#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Codeunit 50028 "CloudPESA Banks Transaction"
{

    trigger OnRun()
    begin
        Message(PostTransactionsEquity('20151113S6285450-2'));
        //MESSAGE(GnSendIdDetails());
    end;

    var
        Vendor: Record Vendor;
        AccountTypes: Record "Account Types-Saving Products";
        miniBalance: Decimal;
        accBalance: Decimal;
        minimunCount: Integer;
        VendorLedgEntry: Record "Vendor Ledger Entry";
        amount: Decimal;
        Loans: Integer;
        LoansRegister: Record "Loans Register";
        LoanProductsSetup: Record "Loan Products Setup";
        Members: Record Customer;
        dateExpression: Text[20];
        DetailedVendorLedgerEntry: Record "Detailed Vendor Ledg. Entry";
        dashboardDataFilter: Date;
        VendorLedgerEntry: Record "Vendor Ledger Entry";
        MemberLedgerEntry: Record "Member Ledger Entry";
        SurePESAApplications: Record "CloudPESA Applications";
        GenJournalLine: Record "Gen. Journal Line";
        GenBatches: Record "Gen. Journal Batch";
        LineNo: Integer;
        GLPosting: Codeunit "Gen. Jnl.-Post Line";
        SurePESATrans: Record "CloudPESA Transactions";
        GenLedgerSetup: Record "General Ledger Setup";
        Charges: Record "Charges";
        MobileCharges: Decimal;
        MobileChargesACC: Text[20];
        SurePESACommACC: Code[20];
        SurePESACharge: Decimal;
        ExcDuty: Decimal;
        TempBalance: Decimal;
        SMSMessages: Record "SMS Messages";
        iEntryNo: Integer;
        msg: Text[250];
        accountName1: Text[40];
        accountName2: Text[40];
        fosaAcc: Text[30];
        LoanGuaranteeDetails: Record "Loans Guarantee Details";
        bosaNo: Text[20];
        MPESARecon: Text[20];
        TariffDetails: Record "Tariff Details";
        MPESACharge: Decimal;
        TotalCharges: Decimal;
        ExxcDuty: label '01-1-0275';
        PaybillTrans: Record "CloudPESA MPESA Trans";
        PaybillRecon: Code[30];
        fosaConst: label 'SAVINGS';
        accountsFOSA: Text[1023];
        interestRate: Integer;
        LoanAmt: Decimal;
        Dimension: Record "Dimension Value";
        DimensionFOSA: label 'FOSA';
        DimensionBRANCH: label 'NAIROBI';
        DimensionBOSA: label 'BOSA';
        FamilyBankacc: Code[50];
        equityAccount: Code[50];
        coopacc: Code[50];
        AccountLength: Integer;
        fosaAccNo: Code[50];
        MembApp: Record "Membership Applications";
        Idtype: Code[50];
        IDLength: Integer;
        ImportFile: File;
        Desc: Text;
        suspenseacc: Code[50];
        DrNarration: Text;
        SURESTEPFA: Codeunit "SURESTEP Factory";


    procedure SMSMessage(documentNo: Text[30]; accfrom: Text[30]; phone: Text[20]; message: Text[250])
    begin

        SMSMessages.Reset;
        if SMSMessages.Find('+') then begin
            iEntryNo := SMSMessages."Entry No";
            iEntryNo := iEntryNo + 1;
        end
        else begin
            iEntryNo := 1;
        end;
        SMSMessages.Init;
        SMSMessages."Entry No" := iEntryNo;
        SMSMessages."Batch No" := documentNo;
        SMSMessages."Document No" := documentNo;
        SMSMessages."Account No" := accfrom;
        SMSMessages."Date Entered" := Today;
        SMSMessages."Time Entered" := Time;
        SMSMessages.Source := 'MOBILETRAN';
        SMSMessages."Entered By" := UserId;
        SMSMessages."Sent To Server" := SMSMessages."sent to server"::No;
        SMSMessages."SMS Message" := message;
        SMSMessages."Telephone No" := phone;
        if SMSMessages."Telephone No" <> '' then
            SMSMessages.Insert;
    end;


    procedure InsertFBCashDeposit(tranNo: Code[100]; Status: Code[50]; reference: Code[50]; AccountNo: Code[50]; Amount: Decimal; "Date Received": DateTime; "inst Account": Code[50]; Msisdn: Code[20]; narration: Code[100]; "inst name": Code[200]; "flex tran serial no": Text[500]; "fetch date": DateTime; Channel: Code[50]) result: Code[50]
    var
        FbCashDeositTb: Record "FB Cash Deposit";
    begin
        FbCashDeositTb.Reset;
        FbCashDeositTb.SetRange(FbCashDeositTb."Transaction No", tranNo);
        if FbCashDeositTb.Find('-') then begin

            result := 'REFEXIST';

        end
        else begin
            FbCashDeositTb.Init;
            FbCashDeositTb."Transaction No" := tranNo;
            FbCashDeositTb.Status := Status;
            FbCashDeositTb.Reference := reference;
            FbCashDeositTb."Account No" := AccountNo;
            FbCashDeositTb.Amount := Amount;
            FbCashDeositTb."Date Received" := "Date Received";
            FbCashDeositTb."Inst Account" := "inst Account";
            FbCashDeositTb.Msisdn := Msisdn;
            FbCashDeositTb.Narration := narration;
            FbCashDeositTb."Inst Name" := "inst name";
            FbCashDeositTb."Flex Trans Serial No" := "flex tran serial no";
            FbCashDeositTb."Fetch Date" := "fetch date";
            FbCashDeositTb.Channel := Channel;
            FbCashDeositTb."Date posted" := CurrentDatetime;
            FbCashDeositTb.Insert;

            FbCashDeositTb.Reset;
            FbCashDeositTb.SetRange(FbCashDeositTb."Transaction No", tranNo);
            if FbCashDeositTb.Find('-') then begin
                result := PostTransactionsFB(FbCashDeositTb."Transaction No");

            end
            else begin
                result := 'FALSE';
            end;


        end;
    end;


    procedure PostTransactionsFB(TranNo: Code[100]) result: Code[50]
    var
        FbCashDeositTb: Record "FB Cash Deposit";
        BranchCode: Code[50];
        Bankcode: Record Banks;
        BranchName: Text;
        CrDescr: Text;
    begin

        GenLedgerSetup.Reset;
        GenLedgerSetup.Get;
        GenLedgerSetup.TestField(GenLedgerSetup."family account bank");
        GenLedgerSetup.TestField(GenLedgerSetup."equity bank acc");
        GenLedgerSetup.TestField(GenLedgerSetup."coop bank acc");
        GenLedgerSetup.TestField(GenLedgerSetup."Suspense fb");
        FamilyBankacc := GenLedgerSetup."family account bank";
        suspenseacc := GenLedgerSetup."Suspense fb";
        FbCashDeositTb.Reset;
        //FbCashDeositTb.SETRANGE(FbCashDeositTb.Posted,FALSE);
        FbCashDeositTb.SetRange(FbCashDeositTb."Transaction No", TranNo);

        if FbCashDeositTb.Find('-') then begin

            AccountLength := StrLen(FbCashDeositTb."Account No");


            if AccountLength > 13 then begin

                fosaAccNo := CopyStr(FbCashDeositTb."Account No", StrLen(FbCashDeositTb."Account No") - 11, 12);

            end
            else begin
                fosaAccNo := FbCashDeositTb."Account No";

            end;
            BranchCode := CopyStr(FbCashDeositTb.Reference, 1, 3);

            Message(BranchCode);

            Bankcode.Reset;
            Bankcode.SetRange(Bankcode.Code, '70-' + BranchCode);
            if Bankcode.Find('-') then begin
                BranchName := Bankcode.Branch;
            end else begin
                BranchName := '';
            end;

            Vendor.Reset;
            Vendor.SetRange(Vendor."No.", fosaAccNo);
            if Vendor.Find('-') then begin  // find vendor
                if (FbCashDeositTb.Channel = 'EFT') then begin

                    Desc := 'EFT Transaction To Acc . ' + fosaAccNo;
                    CrDescr := 'EFT Transaction To Acc . ' + fosaAccNo + ' ' + Vendor.Name;
                    msg := 'EFT Transaction of Ksh. ' + Format(FbCashDeositTb.Amount) + ' to Acc ' + fosaAccNo + ' ' + Vendor.Name + ' - Received on '
                       + Format(CurrentDatetime, 0, '<Day,2> <Month Text,3> <Year4> <Hours24,2>:<Minutes,2>');
                end else
                    if FbCashDeositTb.Channel = 'AGENT' then begin
                        Desc := 'Cash Deposit at Family Bank Agent to Acc ' + fosaAccNo + ' From ' + FbCashDeositTb.Msisdn;
                        CrDescr := 'Cash Deposit at Family Bank Agent to Acc ' + fosaAccNo + ' ' + Vendor.Name + ' From ' + FbCashDeositTb.Msisdn;

                        msg := 'Deposit at Family Bank Agent of Ksh. ' + Format(FbCashDeositTb.Amount) + ' to Acc ' + fosaAccNo + ' ' + Vendor.Name + ' - Received on '
                          + Format(CurrentDatetime, 0, '<Day,2> <Month Text,3> <Year4> <Hours24,2>:<Minutes,2>');
                    end else begin
                        Desc := 'Cash Deposit at Family Bank ' + BranchName + ' Branch to Acc ' + fosaAccNo + ' From ' + FbCashDeositTb.Msisdn;
                        CrDescr := 'Cash Deposit at Family Bank ' + BranchName + ' Branch to Acc ' + fosaAccNo + ' ' + Vendor.Name + '  From ' + FbCashDeositTb.Msisdn;
                        msg := 'Deposit at Family Bank ' + BranchName + ' Branch of Ksh. ' + Format(FbCashDeositTb.Amount) + ' to Acc ' + fosaAccNo
                        + ' ' + Vendor.Name + ' - Received on ' + Format(CurrentDatetime, 0, '<Day,2> <Month Text,3> <Year4> <Hours24,2>:<Minutes,2>');

                    end;
            end else begin
                if FbCashDeositTb.Channel = 'EFT' then begin
                    Desc := 'EFT Transaction To Acc . ' + fosaAccNo;
                    CrDescr := 'EFT Transaction To Acc . ' + fosaAccNo + ' ' + Vendor.Name;
                    msg := 'EFT Transaction  of Ksh. ' + Format(FbCashDeositTb.Amount) + ' to Acc ' + fosaAccNo + ' - Received on '
                   + Format(CurrentDatetime, 0, '<Day,2> <Month Text,3> <Year4> <Hours24,2>:<Minutes,2>');
                end else
                    if FbCashDeositTb.Channel = 'AGENT' then begin
                        Desc := 'Cash Deposit at Family Bank Agent to Acc ' + fosaAccNo + ' From ' + FbCashDeositTb.Msisdn;
                        CrDescr := 'Cash Deposit at Family Bank Agent to Acc ' + fosaAccNo + ' From ' + FbCashDeositTb.Msisdn;

                        msg := 'Cash Deposit at Family Bank Agent  of Ksh. ' + Format(FbCashDeositTb.Amount) + ' to Acc ' + fosaAccNo + ' - Received on '
                        + Format(CurrentDatetime, 0, '<Day,2> <Month Text,3> <Year4> <Hours24,2>:<Minutes,2>');
                    end else begin
                        Desc := 'Cash Deposit at Family Bank ' + BranchName + ' Branch to Acc ' + fosaAccNo + ' From ' + FbCashDeositTb.Msisdn;
                        CrDescr := 'Cash Deposit at Family Bank ' + BranchName + ' Branch to Acc ' + fosaAccNo + '  From ' + FbCashDeositTb.Msisdn;
                        msg := 'Deposit at Family Bank ' + BranchName + ' Branch of Ksh. ' + Format(FbCashDeositTb.Amount) + ' to Acc ' + fosaAccNo + ' - Received on '
                          + Format(CurrentDatetime, 0, '<Day,2> <Month Text,3> <Year4> <Hours24,2>:<Minutes,2>');

                    end;
            end;
            Vendor.Reset;
            Vendor.SetRange(Vendor."No.", fosaAccNo);
            if Vendor.Find('-') then begin

                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                GenJournalLine.SetRange("Journal Batch Name", 'MOBILETRAN');
                GenJournalLine.DeleteAll;
                //end of deletion

                GenBatches.Reset;
                GenBatches.SetRange(GenBatches."Journal Template Name", 'GENERAL');
                GenBatches.SetRange(GenBatches.Name, 'MOBILETRAN');

                if GenBatches.Find('-') = false then begin
                    GenBatches.Init;
                    GenBatches."Journal Template Name" := 'GENERAL';
                    GenBatches.Name := 'MOBILETRAN';
                    GenBatches.Description := 'FB Cash deposit';
                    GenBatches.Validate(GenBatches."Journal Template Name");
                    GenBatches.Validate(GenBatches.Name);
                    GenBatches.Insert;
                end;

                //===========================================================Recover Debt Collector Fee
                Vendor.CalcFields(Vendor."Balance (LCY)");
                SURESTEPFA.FnRunRecoverODDebtCollectorFee(Vendor."No.", Vendor."Balance (LCY)", FbCashDeositTb.Amount);

                //CR ACC 1
                LineNo := LineNo + 10000;
                GenJournalLine.Init;
                GenJournalLine."Journal Template Name" := 'GENERAL';
                GenJournalLine."Journal Batch Name" := 'MOBILETRAN';
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                GenJournalLine."Account No." := Vendor."No.";
                GenJournalLine.Validate(GenJournalLine."Account No.");
                GenJournalLine."Document No." := FbCashDeositTb.Reference;
                GenJournalLine."Application Source" := GenJournalLine."application source"::Mobile;
                GenJournalLine."Posting Date" := Today;
                GenJournalLine.Description := Desc;
                GenJournalLine."Shortcut Dimension 2 Code" := SURESTEPFA.FnGetUserBranch();
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                GenJournalLine.Amount := -FbCashDeositTb.Amount;
                GenJournalLine.Validate(GenJournalLine.Amount);
                if GenJournalLine.Amount <> 0 then
                    GenJournalLine.Insert;

                //DR BANK
                LineNo := LineNo + 10000;
                GenJournalLine.Init;
                GenJournalLine."Journal Template Name" := 'GENERAL';
                GenJournalLine."Journal Batch Name" := 'MOBILETRAN';
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Account Type" := GenJournalLine."account type"::"Bank Account";
                GenJournalLine."Account No." := FamilyBankacc;
                GenJournalLine.Validate(GenJournalLine."Account No.");
                GenJournalLine."Document No." := FbCashDeositTb.Reference;
                GenJournalLine."Posting Date" := Today;
                GenJournalLine."Application Source" := GenJournalLine."application source"::Mobile;
                GenJournalLine.Description := CrDescr;
                GenJournalLine."Shortcut Dimension 2 Code" := SURESTEPFA.FnGetUserBranch();
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                GenJournalLine.Amount := FbCashDeositTb.Amount;
                GenJournalLine.Validate(GenJournalLine.Amount);
                if GenJournalLine.Amount <> 0 then
                    GenJournalLine.Insert;

                //Post
                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                GenJournalLine.SetRange("Journal Batch Name", 'MOBILETRAN');
                if GenJournalLine.Find('-') then begin
                    Codeunit.Run(Codeunit::"Gen. Jnl.-Post Batch", GenJournalLine);
                end;

                SURESTEPFA.FnRunAfterCashDepositProcess(Vendor."No.");

                SMSMessage(FbCashDeositTb.Reference, Vendor."No.", FbCashDeositTb.Msisdn, msg);


                FbCashDeositTb.Posted := true;
                FbCashDeositTb.Status := '00';
                FbCashDeositTb.Modify;
                result := 'TRUE';

            end else begin//vendor

                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                GenJournalLine.SetRange("Journal Batch Name", 'MOBILETRAN');
                GenJournalLine.DeleteAll;
                //end of deletion

                GenBatches.Reset;
                GenBatches.SetRange(GenBatches."Journal Template Name", 'GENERAL');
                GenBatches.SetRange(GenBatches.Name, 'MOBILETRAN');

                if GenBatches.Find('-') = false then begin
                    GenBatches.Init;
                    GenBatches."Journal Template Name" := 'GENERAL';
                    GenBatches.Name := 'MOBILETRAN';
                    GenBatches.Description := 'FB Cash deposit';
                    GenBatches.Validate(GenBatches."Journal Template Name");
                    GenBatches.Validate(GenBatches.Name);
                    GenBatches.Insert;
                end;

                //CR ACC 1
                LineNo := LineNo + 10000;
                GenJournalLine.Init;
                GenJournalLine."Journal Template Name" := 'GENERAL';
                GenJournalLine."Journal Batch Name" := 'MOBILETRAN';
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                GenJournalLine."Account No." := suspenseacc;
                GenJournalLine.Validate(GenJournalLine."Account No.");
                GenJournalLine."Document No." := FbCashDeositTb.Reference;
                GenJournalLine."Application Source" := GenJournalLine."application source"::Mobile;
                GenJournalLine."Posting Date" := Today;
                GenJournalLine.Description := Desc;
                GenJournalLine."Shortcut Dimension 2 Code" := SURESTEPFA.FnGetUserBranch();
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                GenJournalLine.Amount := -FbCashDeositTb.Amount;
                GenJournalLine.Validate(GenJournalLine.Amount);
                if GenJournalLine.Amount <> 0 then
                    GenJournalLine.Insert;

                //DR BANK
                LineNo := LineNo + 10000;
                GenJournalLine.Init;
                GenJournalLine."Journal Template Name" := 'GENERAL';
                GenJournalLine."Journal Batch Name" := 'MOBILETRAN';
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Account Type" := GenJournalLine."account type"::"Bank Account";
                GenJournalLine."Account No." := FamilyBankacc;
                GenJournalLine.Validate(GenJournalLine."Account No.");
                GenJournalLine."Document No." := FbCashDeositTb.Reference;
                GenJournalLine."Application Source" := GenJournalLine."application source"::Mobile;
                GenJournalLine."Posting Date" := Today;
                GenJournalLine.Description := CrDescr;
                GenJournalLine."Shortcut Dimension 2 Code" := SURESTEPFA.FnGetUserBranch();
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                GenJournalLine.Amount := FbCashDeositTb.Amount;
                GenJournalLine.Validate(GenJournalLine.Amount);
                if GenJournalLine.Amount <> 0 then
                    GenJournalLine.Insert;

                //Post
                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                GenJournalLine.SetRange("Journal Batch Name", 'MOBILETRAN');
                if GenJournalLine.Find('-') then begin
                    Codeunit.Run(Codeunit::"Gen. Jnl.-Post Batch", GenJournalLine);
                end;
                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                GenJournalLine.SetRange("Journal Batch Name", 'MOBILETRAN');
                GenJournalLine.DeleteAll;

                SMSMessage(FbCashDeositTb.Reference, fosaAccNo, FbCashDeositTb.Msisdn, msg);

                FbCashDeositTb.Posted := true;
                FbCashDeositTb.Status := '00';
                FbCashDeositTb.Modify;
                result := 'TRUE';

            end;

        end;
    end;


    procedure PostTransactionsEquity(TranID: Text) result: Code[50]
    var
        EquityTb: Record "Equity Transaction";
        phoneL: Text;
        CrNarration: Text;
    begin

        GenLedgerSetup.Reset;
        GenLedgerSetup.Get;

        GenLedgerSetup.TestField(GenLedgerSetup."equity bank acc");
        GenLedgerSetup.TestField(GenLedgerSetup."suspense equity");

        equityAccount := GenLedgerSetup."equity bank acc";
        suspenseacc := GenLedgerSetup."suspense equity";

        EquityTb.Reset;
        EquityTb.SetRange(EquityTb."Transaction Id", TranID);
        if EquityTb.Find('-') then begin
            phoneL := CopyStr(EquityTb."Phone No", 1, 5);

            if EquityTb."Phone No" = 'NULL' then begin
                DrNarration := 'Equity Bank Deposit Acc. ' + EquityTb."Debit Account" + ' ' + EquityTb."Transaction Particular";
                CrNarration := 'Equity Bank Deposit Acc. ' + EquityTb."Debit Account";
                msg := 'Equity Bank Deposit of Ksh. ' + Format(EquityTb."Transaction Amount") + ' to Acc ' + EquityTb."Debit Account"
                      + ' - Received on ' + Format(CurrentDatetime, 0, '<Day,2> <Month Text,3> <Year4> <Hours24,2>:<Minutes,2>');
            end else begin
                phoneL := CopyStr(EquityTb."Phone No", 1, 5);

                if (phoneL = '25476') then begin
                    CrNarration := 'Equitel Deposit from ' + EquityTb."Phone No" + ' ' + EquityTb."Debit Customer Name";
                    DrNarration := 'Equitel Deposit from ' + EquityTb."Phone No" + ' ' + EquityTb."Debit Customer Name" +
                    ' Acc. ' + EquityTb."Debit Account";

                    msg := 'Equitel Deposit of Ksh. ' + Format(EquityTb."Transaction Amount") + ' to Acc ' + EquityTb."Debit Account"
                                  + ' - Received on ' + Format(CurrentDatetime, 0, '<Day,2> <Month Text,3> <Year4> <Hours24,2>:<Minutes,2>');
                end else begin
                    CrNarration := 'Deposit at Equity Bank Agent Acc. ' + EquityTb."Debit Account";
                    DrNarration := 'Deposit at Equity Bank Agent Acc. ' + EquityTb."Debit Account" + ' -' + EquityTb."Transaction Particular";

                    msg := 'Deposit at Equity Bank Agent Acc of Ksh. ' + Format(EquityTb."Transaction Amount") + ' to Acc ' + EquityTb."Debit Account"
                                + ' - Received on ' + Format(CurrentDatetime, 0, '<Day,2> <Month Text,3> <Year4> <Hours24,2>:<Minutes,2>');
                end;
            end;

            Vendor.Reset;
            Vendor.SetRange("No.", EquityTb."Debit Account");
            if Vendor.Find('-') then begin
                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                GenJournalLine.SetRange("Journal Batch Name", 'MOBILETRAN');
                GenJournalLine.DeleteAll;
                //end of deletion

                GenBatches.Reset;
                GenBatches.SetRange(GenBatches."Journal Template Name", 'GENERAL');
                GenBatches.SetRange(GenBatches.Name, 'MOBILETRAN');

                if GenBatches.Find('-') = false then begin
                    GenBatches.Init;
                    GenBatches."Journal Template Name" := 'GENERAL';
                    GenBatches.Name := 'MOBILETRAN';
                    GenBatches.Description := 'SUREPESA Tranfers';
                    GenBatches.Validate(GenBatches."Journal Template Name");
                    GenBatches.Validate(GenBatches.Name);
                    GenBatches.Insert;
                end;

                //===========================================================Recover Debt Collector Fee
                Vendor.CalcFields(Vendor."Balance (LCY)");
                SURESTEPFA.FnRunRecoverODDebtCollectorFee(Vendor."No.", Vendor."Balance (LCY)", EquityTb."Transaction Amount");

                //CR ACC 1
                LineNo := LineNo + 10000;
                GenJournalLine.Init;
                GenJournalLine."Journal Template Name" := 'GENERAL';
                GenJournalLine."Journal Batch Name" := 'MOBILETRAN';
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                GenJournalLine."Account No." := Vendor."No.";
                GenJournalLine.Validate(GenJournalLine."Account No.");
                GenJournalLine."Document No." := EquityTb."Transaction Id";
                GenJournalLine."Application Source" := GenJournalLine."application source"::Mobile;
                GenJournalLine."Posting Date" := Today;
                GenJournalLine."Shortcut Dimension 2 Code" := SURESTEPFA.FnGetUserBranch();
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                GenJournalLine.Description := CrNarration;
                GenJournalLine.Amount := -EquityTb."Transaction Amount";
                GenJournalLine.Validate(GenJournalLine.Amount);
                if GenJournalLine.Amount <> 0 then
                    GenJournalLine.Insert;

                //DR BANK
                LineNo := LineNo + 10000;
                GenJournalLine.Init;
                GenJournalLine."Journal Template Name" := 'GENERAL';
                GenJournalLine."Journal Batch Name" := 'MOBILETRAN';
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Account Type" := GenJournalLine."account type"::"Bank Account";
                GenJournalLine."Account No." := equityAccount;
                GenJournalLine.Validate(GenJournalLine."Account No.");
                GenJournalLine."Document No." := EquityTb."Transaction Id";
                GenJournalLine."Application Source" := GenJournalLine."application source"::Mobile;
                GenJournalLine."Posting Date" := Today;
                GenJournalLine."Shortcut Dimension 2 Code" := SURESTEPFA.FnGetUserBranch();
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                GenJournalLine.Description := DrNarration;
                GenJournalLine.Amount := EquityTb."Transaction Amount";
                ;
                GenJournalLine.Validate(GenJournalLine.Amount);
                if GenJournalLine.Amount <> 0 then
                    GenJournalLine.Insert;


                //Post
                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                GenJournalLine.SetRange("Journal Batch Name", 'MOBILETRAN');
                if GenJournalLine.Find('-') then begin
                    Codeunit.Run(Codeunit::"Gen. Jnl.-Post Batch", GenJournalLine);
                end;

                SURESTEPFA.FnRunAfterCashDepositProcess(Vendor."No.");


                Members.Reset;
                Members.SetRange(Members."No.", Vendor."BOSA Account No");
                if Members.Find('-') then begin
                    SMSMessage(EquityTb."Transaction Id", Vendor."No.", Members."Mobile Phone No", msg);
                end;

                result := 'TRUE';

                EquityTb.Posted := true;
                EquityTb.Processed := '0';
                EquityTb.Modify;

            end
            else begin
                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                GenJournalLine.SetRange("Journal Batch Name", 'MOBILETRAN');
                GenJournalLine.DeleteAll;
                //end of deletion

                GenBatches.Reset;
                GenBatches.SetRange(GenBatches."Journal Template Name", 'GENERAL');
                GenBatches.SetRange(GenBatches.Name, 'MOBILETRAN');

                if GenBatches.Find('-') = false then begin
                    GenBatches.Init;
                    GenBatches."Journal Template Name" := 'GENERAL';
                    GenBatches.Name := 'MOBILETRAN';
                    GenBatches.Description := 'SUREPESA Tranfers';
                    GenBatches.Validate(GenBatches."Journal Template Name");
                    GenBatches.Validate(GenBatches.Name);
                    GenBatches.Insert;
                end;

                //CR ACC 1
                LineNo := LineNo + 10000;
                GenJournalLine.Init;
                GenJournalLine."Journal Template Name" := 'GENERAL';
                GenJournalLine."Journal Batch Name" := 'MOBILETRAN';
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                GenJournalLine."Account No." := suspenseacc;
                GenJournalLine.Validate(GenJournalLine."Account No.");
                GenJournalLine."Document No." := EquityTb."Transaction Id";
                GenJournalLine."Application Source" := GenJournalLine."application source"::Mobile;
                GenJournalLine."Posting Date" := Today;
                GenJournalLine."Shortcut Dimension 2 Code" := SURESTEPFA.FnGetUserBranch();
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                GenJournalLine.Description := DrNarration;
                GenJournalLine.Amount := -EquityTb."Transaction Amount";
                ;
                GenJournalLine.Validate(GenJournalLine.Amount);
                if GenJournalLine.Amount <> 0 then
                    GenJournalLine.Insert;

                //DR BANK
                LineNo := LineNo + 10000;
                GenJournalLine.Init;
                GenJournalLine."Journal Template Name" := 'GENERAL';
                GenJournalLine."Journal Batch Name" := 'MOBILETRAN';
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Account Type" := GenJournalLine."account type"::"Bank Account";
                GenJournalLine."Account No." := equityAccount;
                GenJournalLine.Validate(GenJournalLine."Account No.");
                GenJournalLine."Document No." := EquityTb."Transaction Id";
                GenJournalLine."Application Source" := GenJournalLine."application source"::Mobile;
                GenJournalLine."Posting Date" := Today;
                GenJournalLine."Shortcut Dimension 2 Code" := SURESTEPFA.FnGetUserBranch();
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                GenJournalLine.Description := DrNarration;
                GenJournalLine.Amount := EquityTb."Transaction Amount";
                ;
                GenJournalLine.Validate(GenJournalLine.Amount);
                if GenJournalLine.Amount <> 0 then
                    GenJournalLine.Insert;

                //Post
                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                GenJournalLine.SetRange("Journal Batch Name", 'MOBILETRAN');
                if GenJournalLine.Find('-') then begin
                    Codeunit.Run(Codeunit::"Gen. Jnl.-Post Batch", GenJournalLine);
                end;

                SMSMessage(EquityTb."Transaction Id", EquityTb."Debit Account", EquityTb."Phone No", msg);

                result := 'TRUE';

                EquityTb.Posted := true;
                EquityTb.Processed := '0';
                EquityTb.Modify;
            end;
        end;
    end;


    procedure InsertCashdepositCOOP("Transaction Id": Code[50]; "account No": Code[50]; "Transtion Date": DateTime; "Transaction Amount": Decimal; "Transaction currency": Code[50]; "Transaction type": Option; "Transaction particular": Code[20]; "Depositor Name": Text[200]; "Depositor Mobile": Code[20]; "Date Posted": Date; "Date Processed": Code[50]; "BrTransaction ID": Code[100]; Processed: Code[50]) result: Code[50]
    var
        CoopCashDeposit: Record "Coop Transfer";
    begin
        CoopCashDeposit.Reset;
        CoopCashDeposit.SetRange(CoopCashDeposit."Transaction Id", "Transaction Id");
        if CoopCashDeposit.Find('-') then begin
            result := 'REFEXIST';
        end
        else begin
            CoopCashDeposit.Reset;
            if CoopCashDeposit.Find('+') then begin
                iEntryNo := CoopCashDeposit.Id;
                iEntryNo := iEntryNo + 1;
            end
            else begin
                iEntryNo := 1;
            end;

            CoopCashDeposit.Init;
            CoopCashDeposit.Id := iEntryNo;
            CoopCashDeposit."Transaction Id" := "Transaction Id";
            CoopCashDeposit."Account No" := "account No";
            CoopCashDeposit."Transaction Date" := "Transtion Date";
            CoopCashDeposit."Transaction Amount" := "Transaction Amount";
            CoopCashDeposit."Transaction Currency" := "Transaction currency";
            CoopCashDeposit."Transaction Type" := CoopCashDeposit."transaction type"::Deposits;
            CoopCashDeposit."Transaction Particular" := "Transaction particular";
            CoopCashDeposit."Depositor Name" := "Depositor Name";
            CoopCashDeposit."BrTransaction ID" := "BrTransaction ID";
            CoopCashDeposit."Date Processed" := CurrentDatetime;
            CoopCashDeposit.Insert;

            CoopCashDeposit.Reset;
            CoopCashDeposit.SetRange(CoopCashDeposit."Transaction Id", "Transaction Id");
            if CoopCashDeposit.Find('-') then begin
                result := PostTransactionsCOOP(CoopCashDeposit."Transaction Id");

            end
            else begin
                result := 'FALSE';
            end;

            result := 'TRUE';
        end;
        //END;
    end;


    procedure PostTransactionsCOOP(TranNo: Code[100]) result: Code[50]
    var
        COOPCashDeositTb: Record "Coop Transfer";
    begin

        GenLedgerSetup.Reset;
        GenLedgerSetup.Get;

        GenLedgerSetup.TestField(GenLedgerSetup."family account bank");
        GenLedgerSetup.TestField(GenLedgerSetup."suspense coop bank");
        GenLedgerSetup.TestField(GenLedgerSetup."coop bank acc");

        coopacc := GenLedgerSetup."coop bank acc";
        suspenseacc := GenLedgerSetup."suspense coop bank";

        COOPCashDeositTb.Reset;
        // COOPCashDeositTb.SETRANGE(COOPCashDeositTb.Processed,'1');
        COOPCashDeositTb.SetRange(COOPCashDeositTb."Transaction Id", TranNo);
        if COOPCashDeositTb.Find('-') then begin

            fosaAccNo := COOPCashDeositTb."Account No";

            Vendor.Reset;
            Vendor.SetRange(Vendor."No.", fosaAccNo);
            if Vendor.Find('-') then begin

                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                GenJournalLine.SetRange("Journal Batch Name", 'MOBILETRAN');
                GenJournalLine.DeleteAll;
                //end of deletion

                GenBatches.Reset;
                GenBatches.SetRange(GenBatches."Journal Template Name", 'GENERAL');
                GenBatches.SetRange(GenBatches.Name, 'MOBILETRAN');

                if GenBatches.Find('-') = false then begin
                    GenBatches.Init;
                    GenBatches."Journal Template Name" := 'GENERAL';
                    GenBatches.Name := 'MOBILETRAN';
                    GenBatches.Description := 'FB Cash deposit';
                    GenBatches.Validate(GenBatches."Journal Template Name");
                    GenBatches.Validate(GenBatches.Name);
                    GenBatches.Insert;
                end;

                //===========================================================Recover Debt Collector Fee
                Vendor.CalcFields(Vendor."Balance (LCY)");
                SURESTEPFA.FnRunRecoverODDebtCollectorFee(Vendor."No.", Vendor."Balance (LCY)", COOPCashDeositTb."Transaction Amount");

                //CR ACC 1
                LineNo := LineNo + 10000;
                GenJournalLine.Init;
                GenJournalLine."Journal Template Name" := 'GENERAL';
                GenJournalLine."Journal Batch Name" := 'MOBILETRAN';
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                GenJournalLine."Account No." := Vendor."No.";
                GenJournalLine.Validate(GenJournalLine."Account No.");
                GenJournalLine."Document No." := COOPCashDeositTb."Transaction Id";
                GenJournalLine."Application Source" := GenJournalLine."application source"::Mobile;
                GenJournalLine."Posting Date" := Today;
                GenJournalLine.Description := 'Coop Bank ' + COOPCashDeositTb."Transaction Particular";
                GenJournalLine.Amount := -COOPCashDeositTb."Transaction Amount";
                GenJournalLine.Validate(GenJournalLine.Amount);
                if GenJournalLine.Amount <> 0 then
                    GenJournalLine.Insert;

                //DR BANK
                LineNo := LineNo + 10000;
                GenJournalLine.Init;
                GenJournalLine."Journal Template Name" := 'GENERAL';
                GenJournalLine."Journal Batch Name" := 'MOBILETRAN';
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Account Type" := GenJournalLine."account type"::"Bank Account";
                GenJournalLine."Account No." := coopacc;
                GenJournalLine.Validate(GenJournalLine."Account No.");
                GenJournalLine."Document No." := COOPCashDeositTb."Transaction Id";
                GenJournalLine."Application Source" := GenJournalLine."application source"::Mobile;
                GenJournalLine."Posting Date" := Today;
                GenJournalLine.Description := 'Coop Bank ' + COOPCashDeositTb."Transaction Particular" + ' to Acc ' + Vendor."No." + ' ' + Vendor.Name;
                GenJournalLine.Amount := COOPCashDeositTb."Transaction Amount";
                GenJournalLine.Validate(GenJournalLine.Amount);
                if GenJournalLine.Amount <> 0 then
                    GenJournalLine.Insert;


                //Post
                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                GenJournalLine.SetRange("Journal Batch Name", 'MOBILETRAN');
                if GenJournalLine.Find('-') then begin
                    repeat
                        GLPosting.Run(GenJournalLine);
                    until GenJournalLine.Next = 0;
                end;
                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                GenJournalLine.SetRange("Journal Batch Name", 'MOBILETRAN');
                GenJournalLine.DeleteAll;



                COOPCashDeositTb.Processed := '1';
                COOPCashDeositTb.Modify;
                result := 'TRUE';

            end else begin//vendor
                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                GenJournalLine.SetRange("Journal Batch Name", 'MOBILETRAN');
                GenJournalLine.DeleteAll;
                //end of deletion

                GenBatches.Reset;
                GenBatches.SetRange(GenBatches."Journal Template Name", 'GENERAL');
                GenBatches.SetRange(GenBatches.Name, 'MOBILETRAN');

                if GenBatches.Find('-') = false then begin
                    GenBatches.Init;
                    GenBatches."Journal Template Name" := 'GENERAL';
                    GenBatches.Name := 'MOBILETRAN';
                    GenBatches.Description := 'FB Cash deposit';
                    GenBatches.Validate(GenBatches."Journal Template Name");
                    GenBatches.Validate(GenBatches.Name);
                    GenBatches.Insert;
                end;

                //CR ACC 1
                LineNo := LineNo + 10000;
                GenJournalLine.Init;
                GenJournalLine."Journal Template Name" := 'GENERAL';
                GenJournalLine."Journal Batch Name" := 'MOBILETRAN';
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                GenJournalLine."Account No." := suspenseacc;
                GenJournalLine.Validate(GenJournalLine."Account No.");
                GenJournalLine."Document No." := COOPCashDeositTb."Transaction Id";
                GenJournalLine."Application Source" := GenJournalLine."application source"::Mobile;
                GenJournalLine."Posting Date" := Today;
                GenJournalLine.Description := 'Coop Bank ' + COOPCashDeositTb."Transaction Particular" + ' to Acc ' + COOPCashDeositTb."Account No";
                ;
                GenJournalLine.Amount := -COOPCashDeositTb."Transaction Amount";
                GenJournalLine.Validate(GenJournalLine.Amount);
                if GenJournalLine.Amount <> 0 then
                    GenJournalLine.Insert;

                //DR BANK
                LineNo := LineNo + 10000;
                GenJournalLine.Init;
                GenJournalLine."Journal Template Name" := 'GENERAL';
                GenJournalLine."Journal Batch Name" := 'MOBILETRAN';
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Account Type" := GenJournalLine."account type"::"Bank Account";
                GenJournalLine."Account No." := coopacc;
                GenJournalLine.Validate(GenJournalLine."Account No.");
                GenJournalLine."Document No." := COOPCashDeositTb."Transaction Id";
                GenJournalLine."Application Source" := GenJournalLine."application source"::Mobile;
                GenJournalLine."Posting Date" := Today;
                GenJournalLine.Description := 'Coop Bank ' + COOPCashDeositTb."Transaction Particular" + ' to Acc ' + COOPCashDeositTb."Account No";
                GenJournalLine.Amount := COOPCashDeositTb."Transaction Amount";
                GenJournalLine.Validate(GenJournalLine.Amount);
                if GenJournalLine.Amount <> 0 then
                    GenJournalLine.Insert;

                //Post
                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                GenJournalLine.SetRange("Journal Batch Name", 'MOBILETRAN');
                if GenJournalLine.Find('-') then begin
                    repeat
                        GLPosting.Run(GenJournalLine);
                    until GenJournalLine.Next = 0;
                end;
                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                GenJournalLine.SetRange("Journal Batch Name", 'MOBILETRAN');
                GenJournalLine.DeleteAll;

                COOPCashDeositTb.Processed := '1';
                COOPCashDeositTb.Modify;
                result := 'TRUE';
            end;

        end;
    end;


    procedure fnSetMemberPhoto()
    var
        MemberApp: Record Customer;
    begin
        MembApp.Get(MembApp."No.");
        MembApp.Picture.ImportFile('E:\IPRS\PHotos\' + MembApp."ID No." + '.jpg', 'Demo image for item ');
        MembApp.Signature.ImportFile('E:\IPRS\PHotos\signature\' + MembApp."ID No." + '.jpg', 'Demo image for item ');
        MembApp.Modify;
        //PicItem.READ('/9j/4AAQSkZJRgABAAEA/gD+AAD//gAcQ3JlYXRlZCBieSBBY2N1U29mdCBDb3JwLgD/wAALCAFIASABAREA/9sAhAAKBwgJCAYKCQgJCwsKDA8ZEA8ODg8eFhcSGSQfJSUjHyIiJyw4MCcqNSoiIjFCMTU6PD8/PyYvRUpEPUk4Pj88AQsLCw8NDx0QEB08KCIoKDw8PDw8PDw8PDw8PDw8PDw8PDw8PDw8PDw8
    end;


    procedure FnGetIprsDetails(dateOfBirth: Date; firstName: Code[250]; otherName: Code[250]; surname: Code[250]; gender: Code[250]; idNumber: Code[250])
    begin

        MembApp.Reset;
        MembApp.SetRange("ID No.", idNumber);
        if MembApp.Find('-') then begin
            if firstName = '' then begin
            end
            else begin
                MembApp."Date of Birth" := dateOfBirth;
                MembApp."First Name" := firstName;
                MembApp."Middle Name" := otherName + ' ' + surname;
                if gender = 'M' then begin
                    MembApp.Gender := MembApp.Gender::Male;
                end
                else begin
                    MembApp.Gender := MembApp.Gender::Female;
                end;
                MembApp."Member House Group" := 'TRUE';
                MembApp."Send E-Statements" := true;
                // ImportFile.

                MembApp.Picture.ImportFile('E:\IPRS\PHotos\' + MembApp."ID No." + '.jpg', 'PHOTO ');
                MembApp.Signature.ImportFile('E:\IPRS\PHotos\signature\' + MembApp."ID No." + '.jpg', 'SIGNATURE ');

                MembApp.Modify;
                // fnSetMemberPhoto();

            end;
        end;
    end;


    procedure GnSendIdDetails() Result: Code[250]
    begin
        MembApp.Reset;
        MembApp.SetRange(MembApp."Send E-Statements", false);
        if MembApp.Find('-') then begin
            if MembApp."Application Category" = MembApp."application category"::"New Application" then begin

                if MembApp."Identification Document" = MembApp."identification document"::"Nation ID Card" then begin
                    Idtype := 'NATIONAL_ID';
                end;
                if MembApp."Identification Document" = MembApp."identification document"::"Passport Card" then begin
                    Idtype := 'NATIONAL_ID';
                end;
                IDLength := StrLen(MembApp."ID No.");


                if IDLength > 6 then begin
                    Result := Idtype + ':::' + 'ID' + ':::' + Format(MembApp."ID No.");
                end;

            end;
        end;
    end;


    procedure GetErrorCodes(errocode: Code[50]; IdNumber: Code[50]; errorDescription: Text[100])
    begin
        MembApp.Reset;
        MembApp.SetRange(MembApp."ID No.", IdNumber);
        if MembApp.Find('-') then begin
            MembApp."Member House Group" := errocode;
            MembApp."Send E-Statements" := true;
            MembApp.Modify;
        end;
    end;


    procedure InsertCashdepositEquity("Transaction Id": Code[50]; "account No": Code[50]; "Transtion Date": DateTime; "Transaction Amount": Decimal; "Transaction currency": Code[50]; "Transaction type": Option; "Transaction particular": Code[500]; "Depositor Name": Text[200]; "Depositor Mobile": Code[20]; "Date Posted": DateTime; "Date Processed": Code[50]; "BrTransaction ID": Code[100]; Processed: Code[50]; Phone: Code[50]) result: Code[50]
    var
        EquityDeposit: Record "Equity Transaction";
    begin
        EquityDeposit.Reset;
        EquityDeposit.SetRange(EquityDeposit."Transaction Id", "Transaction Id");
        if EquityDeposit.Find('-') then begin

            result := 'REFEXIST';

        end
        else begin
            EquityDeposit.Reset;

            if EquityDeposit.Find('+') then begin
                iEntryNo := EquityDeposit.Id;
                iEntryNo := iEntryNo + 1;
            end
            else begin
                iEntryNo := 1;
            end;


            EquityDeposit.Init;
            EquityDeposit.Id := iEntryNo;
            EquityDeposit."Transaction Id" := "Transaction Id";
            EquityDeposit."Debit Account" := "account No";
            EquityDeposit."Transaction Date" := "Transtion Date";
            EquityDeposit."Transaction Amount" := "Transaction Amount";
            EquityDeposit."Transaction Currency" := "Transaction currency";
            EquityDeposit."Transaction Type" := EquityDeposit."transaction type"::"Cash deposit";
            EquityDeposit."Transaction Particular" := "Transaction particular";
            EquityDeposit."Phone No" := Phone;
            EquityDeposit."Debit Customer Name" := "Depositor Name";
            EquityDeposit."BrTransaction Id" := "BrTransaction ID";
            EquityDeposit."Date Processed" := CurrentDatetime;
            EquityDeposit.Insert;

            EquityDeposit.Reset;
            EquityDeposit.SetRange(EquityDeposit."Transaction Id", "Transaction Id");
            if EquityDeposit.Find('-') then begin
                result := PostTransactionsEquity("Transaction Id");

            end
            else begin
                result := 'FALSE';
            end;

            result := 'TRUE';
        end;
    end;
}

