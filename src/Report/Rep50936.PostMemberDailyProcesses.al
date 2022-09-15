#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Report 50936 "Post Member Daily Processes"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = where(Status = filter(<> Exited | Deceased), Blocked = filter(" "));
            RequestFilterFields = "No.";
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnAfterGetRecord()
            begin
                //====================================================================================================Update Member Monthly Contribution
                VarMonthlyContribution := SFactory.FnGetMemberMonthlyContributionDepositstier("No.");

                if VarMonthlyContribution > 0 then begin

                    ObjMemberIV.Reset;
                    ObjMemberIV.SetRange(ObjMemberIV."No.", "No.");
                    if ObjMemberIV.FindSet then begin
                        if VarMonthlyContribution <> ObjMemberIV."Monthly Contribution" then begin
                            ObjMemberIV."Monthly Contribution" := VarMonthlyContribution;
                            ObjMemberIV.Modify;
                        end;
                    end;
                end;
                //========================================Recover Penalty On Deposit Contribution Arrears
                CalcFields("Deposits Penalty Exists", "Current Shares");

                if ("Current Shares" > 0) and ("Deposits Account No" <> '') and ("Deposits Penalty Exists" = true) and (Status = Status::Active) then begin
                    ObjAccounts.Reset;
                    ObjAccounts.SetRange(ObjAccounts."No.", "Deposits Account No");
                    ObjAccounts.SetRange(ObjAccounts.Blocked, ObjAccounts.Blocked::" ");
                    ObjAccounts.SetFilter(ObjAccounts.Status, '<>%1&<>%2', ObjAccounts.Status::Closed, ObjAccounts.Status::Deceased);
                    if ObjAccounts.FindSet then begin
                        BATCH_TEMPLATE := 'GENERAL';
                        BATCH_NAME := 'DEFAULT';
                        SFactory.FnRunCreateDepositArrearsPenaltyJournals("Deposits Account No", BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, WorkDate, DOCUMENT_NO, "Current Shares", LineNo);
                    end
                end;
                //SFactory.FnGetMemberAMLRiskRating("No.");//===========================================================Update Member Risk Rating AML
                //FnRunUpdateMemberAge("No.");//========================================================================Update Member Age
            end;

            trigger OnPreDataItem()
            begin
                FnRunCreateAccounts;//==============================================================================Create Accounts
                FnRunRecoverRegistrationFee;//======================================================================Registration Fee
                FnRunTransferFOSASharestoShareCapital;//============================================================Transfer FOSa Shares to Share Capital
                FnRunTransferShareCapitalVariance;//================================================================Transfer Share Capital Variance
                FnRunTransferBenevolentFund;//======================================================================Transfer benevolent Fund
                FnRunTransferFOSAShares;//==========================================================================Transfer FOSA Shares
                SFactory.FnRunManageAudit_Tracker;//=================================================================Audit Issues Tracker Status
                SFactory.FnRunGetMembershipDormancyStatus(WorkDate);//========================================================Member Dormancy
                SFactory.FnRunGetMemberAccountDormancyStatus(WorkDate);//======================================================Account Dormancy
                SFactory.FnRunPasswordChangeonNextLogin;//=====================================================================Password
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        ObjGensetup: Record "Sacco General Set-Up";
        GenJournalLine: Record "Gen. Journal Line";
        BATCH_TEMPLATE: Code[30];
        BATCH_NAME: Code[30];
        DOCUMENT_NO: Code[30];
        LineNo: Integer;
        SFactory: Codeunit "SURESTEP Factory";
        VarShareCapVariance: Decimal;
        VarAmountPosted: Decimal;
        VarBenfundVariance: Decimal;
        VarDepositBufferEntryNo: Integer;
        VarMonthlyContribution: Decimal;
        ObjDetailedVendorLedger: Record "Detailed Vendor Ledg. Entry";
        VarLedgerDateFilter: Text;
        VarCurrYearBeginDate: Date;
        VarCurrYear: Integer;
        VarBenfundCurrYearCredits: Decimal;
        ObjMemberIV: Record Customer;
        ObjMemberBenfundHistorical: Record "Member Historical Ledger Entry";
        VarBenfundCurrYearCreditsHistorical: Decimal;
        ObjAccounts: Record Vendor;

    local procedure FnRunRecoverRegistrationFee()
    var
        VarRegistrationFeeVariance: Decimal;
        ObjGensetup: Record "Sacco General Set-Up";
        ObjMember: Record Customer;
        VarTaxonFee: Decimal;
        VarRegistrationFeeSeparate: Decimal;
        VarTaxOnFeeSeprate: Decimal;
        VarMemberNo: Code[30];
        VarRegistrationFee: Decimal;
    begin
        BATCH_TEMPLATE := 'GENERAL';
        BATCH_NAME := 'DEFAULT';

        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
        GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
        GenJournalLine.DeleteAll;

        ObjGensetup.Get;

        //INDIVIDUAL MEMBERS REGISTRATION FEE
        ObjMember.CalcFields(ObjMember."Registration Fee Paid", ObjMember."Current Shares");
        ObjMember.Reset;
        ObjMember.SetFilter(ObjMember."Registration Date", '>%1', ObjGensetup."Go Live Date"); //To Ensure deduction is for New Members Only
        ObjMember.SetFilter(ObjMember."Deposits Account No", '<>%1', '');
        ObjMember.SetFilter(ObjMember.Status, '<>%1|%2', ObjMember.Status::Exited, ObjMember.Status::Deceased);
        ObjMember.SetFilter(ObjMember."Registration Fee Paid", '<%1', ObjGensetup."BOSA Registration Fee Amount");
        ObjMember.SetFilter(ObjMember."Current Shares", '>%1', 1);
        ObjMember.SetRange(ObjMember."Account Category", ObjMember."account category"::Individual);
        if ObjMember.Find('-') then begin
            repeat

                DOCUMENT_NO := SFactory.FnRunGetNextTransactionDocumentNo;

                ObjMember.CalcFields(ObjMember."Registration Fee Paid", ObjMember."Current Shares");
                if Abs(ObjMember."Registration Fee Paid") < ObjGensetup."BOSA Registration Fee Amount" then begin
                    VarRegistrationFeeVariance := (ObjGensetup."BOSA Registration Fee Amount" - ObjMember."Registration Fee Paid");
                    VarTaxonFee := VarRegistrationFeeVariance * (ObjGensetup."Excise Duty(%)" / 100);

                    if ObjMember."Current Shares" >= (VarRegistrationFeeVariance + VarTaxonFee) then
                        VarRegistrationFeeSeparate := VarRegistrationFeeVariance
                    else
                        VarRegistrationFeeSeparate := (ObjMember."Current Shares" * 100) / (ObjGensetup."Excise Duty(%)" + 100);

                    VarTaxOnFeeSeprate := VarRegistrationFeeSeparate * (ObjGensetup."Excise Duty(%)" / 100);

                    //=======================================================================================================1. DEBIT MEMBER DEPOSITS A/C
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Deposit Contribution",
                    GenJournalLine."account type"::Vendor, ObjMember."Deposits Account No", WorkDate, VarRegistrationFeeSeparate, 'BOSA', '',
                    'Registration Fee Paid', '', GenJournalLine."application source"::CBS);


                    //=====================================================================================================2. CREDIT MEMBER REGISTRATION FEE A/C
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Registration Fee",
                    GenJournalLine."account type"::None, ObjMember."No.", WorkDate, VarRegistrationFeeSeparate * -1, 'BOSA', '',
                    'Registration Fee Paid - ' + ObjMember."No.", '', GenJournalLine."application source"::CBS);

                    //=======================================================================================================3. DEBIT TAX MEMBER DEPOSITS A/C
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Deposit Contribution",
                    GenJournalLine."account type"::Vendor, ObjMember."Deposits Account No", WorkDate, VarTaxOnFeeSeprate, 'BOSA', '',
                    'Tax: Registration Fee Paid', '', GenJournalLine."application source"::CBS);


                    //=====================================================================================================4. CREDIT TAX ON FEE A/C
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Registration Fee",
                    GenJournalLine."account type"::"G/L Account", ObjGensetup."Excise Duty Account", WorkDate, VarTaxOnFeeSeprate * -1, 'BOSA', '',
                    'Tax: Registration Fee Paid - ' + ObjMember."No.", '', GenJournalLine."application source"::CBS);


                    //CU posting
                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                    GenJournalLine.SetRange("Journal Batch Name", 'DEFAULT');
                    if GenJournalLine.Find('-') then
                        Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);

                end;
            until ObjMember.Next = 0;
        end;

        //CORPORATE MEMBERS REGISTRATION FEE
        ObjMember.CalcFields(ObjMember."Registration Fee Paid", ObjMember."Current Shares");
        ObjMember.Reset;
        ObjMember.SetFilter(ObjMember."Registration Date", '>%1', ObjGensetup."Go Live Date"); //To Ensure deduction is for New Members Only
        ObjMember.SetFilter(ObjMember."Deposits Account No", '<>%1', '');
        ObjMember.SetFilter(ObjMember.Status, '<>%1|%2', ObjMember.Status::Exited, ObjMember.Status::Deceased);
        ObjMember.SetFilter(ObjMember."Registration Fee Paid", '<%1', ObjGensetup."BOSA Reg. Fee Corporate");
        ObjMember.SetFilter(ObjMember."Current Shares", '>%1', 1);
        ObjMember.SetFilter(ObjMember."Account Category", '<>%1', ObjMember."account category"::Individual);
        if ObjMember.Find('-') then begin
            repeat

                DOCUMENT_NO := SFactory.FnRunGetNextTransactionDocumentNo;

                ObjMember.CalcFields(ObjMember."Registration Fee Paid", ObjMember."Current Shares");
                if Abs(ObjMember."Registration Fee Paid") < ObjGensetup."BOSA Reg. Fee Corporate" then begin
                    VarRegistrationFeeVariance := (ObjGensetup."BOSA Reg. Fee Corporate" - ObjMember."Registration Fee Paid");
                    VarTaxonFee := VarRegistrationFeeVariance * (ObjGensetup."Excise Duty(%)" / 100);

                    if ObjMember."Current Shares" >= (VarRegistrationFeeVariance + VarTaxonFee) then
                        VarRegistrationFeeSeparate := VarRegistrationFeeVariance
                    else
                        VarRegistrationFeeSeparate := (ObjMember."Current Shares" * 100) / (ObjGensetup."Excise Duty(%)" + 100);

                    VarTaxOnFeeSeprate := VarRegistrationFeeSeparate * (ObjGensetup."Excise Duty(%)" / 100);

                    //=======================================================================================================1. DEBIT MEMBER DEPOSITS A/C
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Deposit Contribution",
                    GenJournalLine."account type"::Vendor, ObjMember."Deposits Account No", WorkDate, VarRegistrationFeeSeparate, 'BOSA', '',
                    'Registration Fee Paid', '', GenJournalLine."application source"::CBS);


                    //=====================================================================================================2. CREDIT MEMBER REGISTRATION FEE A/C
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Registration Fee",
                    GenJournalLine."account type"::None, ObjMember."No.", WorkDate, VarRegistrationFeeSeparate * -1, 'BOSA', '',
                    'Registration Fee Paid - ' + ObjMember."No.", '', GenJournalLine."application source"::CBS);

                    //=======================================================================================================3. DEBIT TAX MEMBER DEPOSITS A/C
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Deposit Contribution",
                    GenJournalLine."account type"::Vendor, ObjMember."Deposits Account No", WorkDate, VarTaxOnFeeSeprate, 'BOSA', '',
                    'Tax: Registration Fee Paid', '', GenJournalLine."application source"::CBS);


                    //=====================================================================================================4. CREDIT TAX ON FEE A/C
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Registration Fee",
                    GenJournalLine."account type"::"G/L Account", ObjGensetup."Excise Duty Account", WorkDate, VarTaxOnFeeSeprate * -1, 'BOSA', '',
                    'Tax: Registration Fee Paid - ' + ObjMember."No.", '', GenJournalLine."application source"::CBS);


                    //CU posting
                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                    GenJournalLine.SetRange("Journal Batch Name", 'DEFAULT');
                    if GenJournalLine.Find('-') then
                        Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);

                end;
            until ObjMember.Next = 0;
        end;
    end;

    local procedure FnRunCreateAccounts()
    var
        ObjMember: Record Customer;
        ObjAccounts: Record Vendor;
    begin
        //===================================================================Create Share Capital Account
        ObjMember.Reset;
        ObjMember.SetFilter(ObjMember."Deposits Account No", '<>%1', '');
        ObjMember.SetFilter(ObjMember."Share Capital No", '%1', '');
        ObjMember.SetFilter(ObjMember.Status, '%1|%2', ObjMember.Status::Active, ObjMember.Status::Dormant);
        if ObjMember.FindSet then begin
            repeat
                ObjAccounts.Reset;
                ObjAccounts.SetRange(ObjAccounts."BOSA Account No", ObjMember."No.");
                ObjAccounts.SetRange(ObjAccounts."Account Type", '601');
                ObjAccounts.SetFilter(ObjAccounts.Status, '<>%1', ObjAccounts.Status);
                if ObjAccounts.Find('-') = true then begin
                    ObjMember."Share Capital No" := ObjAccounts."No.";
                    ObjMember.Modify
                end else
                    ObjMember."Share Capital No" := SFactory.FnRunCreatNewAccount('601', ObjMember."Global Dimension 2 Code", ObjMember."No.");
                ObjMember.Modify;
            until ObjMember.Next = 0;
        end;

        //===================================================================Create FOSA Shares Account
        ObjMember.Reset;
        ObjMember.SetFilter(ObjMember."Deposits Account No", '%1', '');
        ObjMember.SetRange(ObjMember."Share Capital No", '');
        ObjMember.SetFilter(ObjMember."FOSA Shares Account No", '%1', '');
        ObjMember.SetFilter(ObjMember.Status, '%1|%2', ObjMember.Status::Active, ObjMember.Status::Dormant);
        if ObjMember.FindSet then begin
            repeat
                ObjAccounts.Reset;
                ObjAccounts.SetRange(ObjAccounts."BOSA Account No", ObjMember."No.");
                ObjAccounts.SetRange(ObjAccounts."Account Type", '605');
                if ObjAccounts.Find('-') = true then begin
                    ObjMember."FOSA Shares Account No" := ObjAccounts."No.";
                    ObjMember.Modify;
                end else
                    ObjMember."FOSA Shares Account No" := SFactory.FnRunCreatNewAccount('605', ObjMember."Global Dimension 2 Code", ObjMember."No.");
                ObjMember.Modify;
            until ObjMember.Next = 0;
        end;

        //===================================================================Benevolent Fund
        ObjMember.Reset;
        ObjMember.SetFilter(ObjMember."Benevolent Fund No", '%1', '');
        ObjMember.SetFilter(ObjMember."Deposits Account No", '<>%1', '');
        ObjMember.SetRange(ObjMember."Account Category", ObjMember."account category"::Individual);
        ObjMember.SetFilter(ObjMember.Status, '%1|%2', ObjMember.Status::Active, ObjMember.Status::Dormant);
        if ObjMember.FindSet then begin
            repeat
                ObjAccounts.Reset;
                ObjAccounts.SetRange(ObjAccounts."BOSA Account No", ObjMember."No.");
                ObjAccounts.SetRange(ObjAccounts."Account Type", '606');
                ObjAccounts.SetFilter(ObjAccounts.Status, '<>%1|%2', ObjAccounts.Status::Closed, ObjAccounts.Status::Deceased);
                if ObjAccounts.Find('-') = true then begin
                    ObjMember."Benevolent Fund No" := ObjAccounts."No.";
                    ObjMember.Modify;
                end else
                    ObjMember."Benevolent Fund No" := SFactory.FnRunCreatNewAccount('606', ObjMember."Global Dimension 2 Code", ObjMember."No.");
                ObjMember.Modify;
            until ObjMember.Next = 0;
        end;

        //===================================================================LSA Account No
        ObjMember.Reset;
        ObjMember.CalcFields(ObjMember."LSA Account No", ObjMember."Total Loans Outstanding");
        ObjMember.SetFilter(ObjMember."LSA Account No", '%1', '');
        ObjMember.SetFilter(ObjMember."Total Loans Outstanding", '>%1', 1);
        ObjMember.SetFilter(ObjMember.Status, '<>%1|%2', ObjMember.Status::Exited, ObjMember.Status::Deceased);
        if ObjMember.FindSet then begin
            repeat
                ObjAccounts.Reset;
                ObjAccounts.SetRange(ObjAccounts."BOSA Account No", ObjMember."No.");
                ObjAccounts.SetFilter(ObjAccounts.Status, '<>%1|%2', ObjAccounts.Status::Closed, ObjAccounts.Status::Deceased);
                ObjAccounts.SetRange(ObjAccounts."Account Type", '507');
                if ObjAccounts.Find('-') = false then begin
                    SFactory.FnRunCreatNewAccount('507', ObjMember."Global Dimension 2 Code", ObjMember."No.");
                end;
            until ObjMember.Next = 0;
        end;
    end;

    local procedure FnRunTransferFOSAShares()
    var
        ObjMember: Record Customer;
        VarRunningBal: Decimal;
        ObjAccount: Record Vendor;
        AmountToDeduct: Decimal;
        AvailableBal: Decimal;
        ObjVendors: Record Vendor;
        ObjAccTypes: Record "Account Types-Saving Products";
    begin
        BATCH_TEMPLATE := 'GENERAL';
        BATCH_NAME := 'DEFAULT';

        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
        GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
        GenJournalLine.DeleteAll;


        ObjGensetup.Get;
        ObjMember.CalcFields(ObjMember."FOSA Shares", ObjMember."FOSA Shares Status");
        ObjMember.Reset;
        ObjMember.SetRange(ObjMember."Deposits Account No", '');
        ObjMember.SetRange(ObjMember."Share Capital No", '');
        ObjMember.SetFilter(ObjMember."FOSA Shares Account No", '<>%1', '');
        ObjMember.SetFilter(ObjMember."FOSA Shares Status", '<>%1', ObjMember."fosa shares status"::Closed);
        ObjMember.SetFilter(ObjMember."FOSA Shares", '<%1', ObjGensetup."FOSA Shares Amount");
        ObjMember.SetFilter(ObjMember.Status, '<>%1|%2', ObjMember.Status::Exited, ObjMember.Status::Deceased);
        if ObjMember.FindSet then begin
            repeat
                ObjMember.CalcFields(ObjMember."FOSA Shares", ObjMember."FOSA Shares Status");
                DOCUMENT_NO := SFactory.FnRunGetNextTransactionDocumentNo;
                VarRunningBal := ObjGensetup."FOSA Shares Amount" - ObjMember."FOSA Shares";

                ObjAccount.CalcFields(ObjAccount.Balance);
                ObjAccount.Reset;
                ObjAccount.SetRange(ObjAccount."BOSA Account No", ObjMember."No.");
                ObjAccount.SetFilter(ObjAccount.Status, '<>%1', ObjAccount.Status::Closed);
                ObjAccount.SetRange(ObjAccount.Blocked, ObjAccount.Blocked::" ");
                ObjAccount.SetFilter(ObjAccount.Balance, '>%1', 0);
                ObjAccount.SetFilter(ObjAccount."Account Type", '%1|%2|%3|%4|%5|%6|%7|%8', '401', '402', '403', '404', '405', '406', '501', '502');
                if ObjAccount.FindSet then begin
                    repeat
                        AmountToDeduct := 0;
                        AvailableBal := 0;

                        ObjVendors.Reset;
                        ObjVendors.SetRange(ObjVendors."No.", ObjAccount."No.");
                        if ObjVendors.Find('-') then begin
                            ObjVendors.CalcFields(ObjVendors.Balance, ObjVendors."Uncleared Cheques");
                            AvailableBal := (ObjVendors.Balance - ObjVendors."Uncleared Cheques");

                            ObjAccTypes.Reset;
                            ObjAccTypes.SetRange(ObjAccTypes.Code, ObjVendors."Account Type");
                            if ObjAccTypes.Find('-') then
                                AvailableBal := AvailableBal - ObjAccTypes."Minimum Balance";
                        end;



                        if AvailableBal >= VarRunningBal then begin

                            if AvailableBal > VarRunningBal then begin
                                AmountToDeduct := VarRunningBal
                            end else
                                AmountToDeduct := AvailableBal;

                            //=================================================================================================Recover From FOSA Credit Deposit Contribution
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Deposit Contribution",
                            GenJournalLine."account type"::Vendor, ObjMember."FOSA Shares Account No", WorkDate, AmountToDeduct * -1, 'BOSA', '',
                            'FOSA Shares Transfer from ' + ObjAccount."No.", '', GenJournalLine."application source"::CBS);

                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLineGuarantorRecovery(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                            GenJournalLine."account type"::Vendor, ObjAccount."No.", WorkDate, AmountToDeduct, 'BOSA', '',
                            'FOSA Shares Transfer to ' + ObjMember."FOSA Shares Account No", '', GenJournalLine."recovery transaction type"::Normal, '');

                            VarRunningBal := VarRunningBal - AmountToDeduct;
                        end;

                    until ObjAccount.Next = 0;
                end;

                //CU posting
                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                if GenJournalLine.Find('-') then
                    Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
            until ObjMember.Next = 0;
        end;
    end;

    local procedure FnRunTransferFOSASharestoShareCapital()
    var
        ObjMember: Record Customer;
        VarRunningBal: Decimal;
        ObjAccount: Record Vendor;
        AmountToDeduct: Decimal;
        AvailableBal: Decimal;
        ObjVendors: Record Vendor;
        ObjAccTypes: Record "Account Types-Saving Products";
    begin
        BATCH_TEMPLATE := 'GENERAL';
        BATCH_NAME := 'DEFAULT';


        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
        GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
        GenJournalLine.DeleteAll;


        ObjGensetup.Get;
        ObjMember.CalcFields(ObjMember."FOSA Shares", ObjMember."FOSA Shares Status", ObjMember."Share Capital Status", ObjMember."Deposits Account Status");
        ObjMember.Reset;
        ObjMember.SetFilter(ObjMember."Share Capital No", '<>%1', '');
        ObjMember.SetFilter(ObjMember."Share Capital Status", '<>%1', ObjMember."share capital status"::Closed);
        ObjMember.SetFilter(ObjMember."FOSA Shares Account No", '<>%1', '');
        ObjMember.SetFilter(ObjMember."FOSA Shares Status", '<>%1', ObjMember."fosa shares status"::Closed);
        ObjMember.SetFilter(ObjMember."FOSA Shares", '>%1', 0);
        ObjMember.SetFilter(ObjMember.Status, '<>%1|%2', ObjMember.Status::Exited, ObjMember.Status::Deceased);
        if ObjMember.FindSet then begin
            repeat

                DOCUMENT_NO := SFactory.FnRunGetNextTransactionDocumentNo;

                ObjMember.CalcFields(ObjMember."FOSA Shares");
                //=================================================================================================Transfer FOSA Shares to Share Capital
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Deposit Contribution",
                GenJournalLine."account type"::Vendor, ObjMember."FOSA Shares Account No", WorkDate, ObjMember."FOSA Shares", 'BOSA', '',
                'FOSA Shares Transfer to Share Capital ' + ObjMember."Share Capital No", '', GenJournalLine."application source"::CBS);

                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                GenJournalLine."account type"::Vendor, ObjMember."Share Capital No", WorkDate, ObjMember."FOSA Shares" * -1, 'BOSA', '',
                'Share Capital Transfer from FOSA Shares ' + ObjMember."FOSA Shares Account No", '', GenJournalLine."application source"::CBS);


                //CU posting
                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                if GenJournalLine.Find('-') then
                    Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);

                //=========================================================================================Modify Account Status
                if ObjAccount.Get(ObjMember."FOSA Shares Account No") then begin
                    ObjAccount.Status := ObjAccount.Status::Closed;
                    ObjAccount.Blocked := ObjAccount.Blocked::All;
                    ObjAccount.Modify;
                end;

            until ObjMember.Next = 0;
        end;
    end;

    local procedure FnRunUpdateMemberAge(VarMemberNo: Code[30])
    var
        VarAge: Integer;
        VarAge2: Integer;
        ObjMember: Record Customer;
    begin
        ObjMember.Reset;
        ObjMember.SetRange(ObjMember."No.", VarMemberNo);
        ObjMember.SetFilter(ObjMember."Date Filter", '<>%1', 0D);
        if ObjMember.FindSet then begin
            VarAge := WorkDate - ObjMember."Date of Birth"; //Returns number of days old
            VarAge2 := ROUND((VarAge / 365.2364), 1, '<');  //Returns number of years old as Decimal - Takes into Account Leap Years
            ObjMember.Age := format(VarAge2);
            ObjMember.Modify;
        end;
    end;

    local procedure FnRunTransferShareCapitalVariance()
    var
        ObjMember: Record Customer;
    begin
        ObjGensetup.Get;
        BATCH_TEMPLATE := 'GENERAL';
        BATCH_NAME := 'DEFAULT';

        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
        GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
        GenJournalLine.DeleteAll;


        //================================================================================================================Transfer Share Capital Variance
        ObjMember.CalcFields(ObjMember."Current Shares", ObjMember."Shares Retained");
        ObjMember.Reset;
        ObjMember.SetFilter(ObjMember."Shares Retained", '<%1', ObjGensetup."Retained Shares");
        ObjMember.SetFilter(ObjMember."Current Shares", '>=%1', (ObjGensetup."Retained Shares" - ObjMember."Shares Retained"));
        ObjMember.SetFilter(ObjMember."Share Capital No", '<>%1', '');
        ObjMember.SetFilter(ObjMember.Status, '<>%1|%2', ObjMember.Status::Exited, ObjMember.Status::Deceased);
        if ObjMember.FindSet then begin
            repeat

                DOCUMENT_NO := SFactory.FnRunGetNextTransactionDocumentNo;
                ObjMember.CalcFields(ObjMember."Current Shares", ObjMember."Shares Retained");
                VarShareCapVariance := (ObjGensetup."Retained Shares" - ObjMember."Shares Retained");


                //======================================================================================================1. DEBIT MEMBER DEPOSITS A/C
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Deposit Contribution",
                GenJournalLine."account type"::Vendor, ObjMember."Deposits Account No", WorkDate, VarShareCapVariance, 'BOSA', '',
                'Share Capital Transfer to - ' + ObjMember."Share Capital No", '', GenJournalLine."application source"::CBS);
                //========================================================================================================(Debit Member Deposit Account)

                //=========================================================================================================2. CREDIT MEMBER SHARE CAPITAL A/C
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Share Capital",
                GenJournalLine."account type"::Vendor, ObjMember."Share Capital No", WorkDate, VarShareCapVariance * -1, 'BOSA', '',
                'Share Capital Transfer from - ' + ObjMember."Deposits Account No", '', GenJournalLine."application source"::CBS);
                //===========================================================================================================(Credit Member Share Capital Account)

                //CU posting
                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                GenJournalLine.SetRange("Journal Batch Name", 'DEFAULT');
                if GenJournalLine.Find('-') then
                    Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);

            until ObjMember.Next = 0;
        end;
    end;

    local procedure FnRunTransferBenevolentFund()
    var
        ObjMember: Record Customer;
    begin
        ObjGensetup.Get;
        BATCH_TEMPLATE := 'GENERAL';
        BATCH_NAME := 'DEFAULT';

        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
        GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
        GenJournalLine.DeleteAll;

        VarCurrYear := Date2dmy(WorkDate, 3);
        VarCurrYearBeginDate := Dmy2date(1, 1, VarCurrYear);

        VarLedgerDateFilter := Format(VarCurrYearBeginDate) + '..' + Format(WorkDate);


        ObjMember.CalcFields(ObjMember."Benevolent Fund", ObjMember."Benevolent Fund Historical", ObjMember."Member Deposits", ObjMember."Shares Retained");
        ObjMember.Reset;
        ObjMember.SetFilter(ObjMember."Date Filter", VarLedgerDateFilter);
        ObjMember.SetFilter(ObjMember."Benevolent Fund", '<%1', ObjGensetup."Benevolent Fund Contribution" - ObjMember."Benevolent Fund Historical");
        ObjMember.SetFilter(ObjMember."Member Deposits", '>=%1', ObjGensetup."Benevolent Fund Contribution" - (ObjMember."Benevolent Fund" + ObjMember."Benevolent Fund Historical"));
        ObjMember.SetFilter(ObjMember."Benevolent Fund No", '<>%1', '');
        ObjMember.SetFilter(ObjMember."Shares Retained", '>=%1', ObjGensetup."Retained Shares");
        ObjMember.SetRange(ObjMember."Account Category", ObjMember."account category"::Individual);
        ObjMember.SetRange(ObjMember.Status, ObjMember.Status::Active);
        if ObjMember.FindSet then begin
            repeat
                DOCUMENT_NO := SFactory.FnRunGetNextTransactionDocumentNo;
                ObjMember.CalcFields(ObjMember."Benevolent Fund", ObjMember."Benevolent Fund Historical", ObjMember."Member Deposits");
                VarBenfundVariance := (ObjGensetup."Benevolent Fund Contribution" - (ObjMember."Benevolent Fund Historical" + ObjMember."Benevolent Fund"));
                //======================================================================================================1. DEBIT MEMBER DEPOSITS A/C
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Deposit Contribution",
                GenJournalLine."account type"::Vendor, ObjMember."Deposits Account No", WorkDate, VarBenfundVariance, 'BOSA', '',
                'Benevolent Fund Contribution to - ' + ObjMember."Benevolent Fund No", '', GenJournalLine."application source"::CBS);


                //======================================================================================================2. CREDIT MEMBER BENFUND A/C
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Benevolent Fund",
                GenJournalLine."account type"::Vendor, ObjMember."Benevolent Fund No", WorkDate, VarBenfundVariance * -1, 'BOSA', '',
                'Benevolent Fund Contribution from - ' + ObjMember."Deposits Account No", '', GenJournalLine."application source"::CBS);


                //==========================================================================================================3. DEBIT BENFUND A/C
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Benevolent Fund",
                GenJournalLine."account type"::Vendor, ObjMember."Benevolent Fund No", WorkDate, VarBenfundVariance, 'BOSA', '',
                'Benevolent Fund Transfer - ' + ObjMember."No.", '', GenJournalLine."application source"::CBS);


                //=========================================================================================================4. CREDIT BENFUND G/L A/C
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Benevolent Fund",
                GenJournalLine."account type"::"G/L Account", ObjGensetup."Benevolent Fund Account", WorkDate, VarBenfundVariance * -1, 'BOSA', '',
                'Benevolent Fund Contribution - ' + ObjMember."No.", '', GenJournalLine."application source"::CBS);

                //CU posting
                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                GenJournalLine.SetRange("Journal Batch Name", 'DEFAULT');
                if GenJournalLine.Find('-') then
                    Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);

            until ObjMember.Next = 0;
        end;
    end;
}

