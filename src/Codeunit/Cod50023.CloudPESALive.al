#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Codeunit 50023 "CloudPESALive"
{

    trigger OnRun()
    begin
        //MESSAGE(AccountBalance('2747-007004-01','102780701'));
        //MESSAGE(WSSAccount('0721906050'));
        //MESSAGE(SurePESARegistration());
        //MESSAGE(UpdateSurePESARegistration('2747-007004-01'));
        //MESSAGE(AccountBalanceNew('2747-006996-01','4800327122'));
        Message(MiniStatement('733942007', 'VS0735'));

        //MESSAGE(FundsTransferBOSA('2747-007004-01','Shares Capital','748502660',800));
        //MESSAGE(LoanRepayment('2747-007004-01','BLN_00044','07963510202',700));
        //MESSAGE(OutstandingLoans('0712345689'));
        //MESSAGE(RegisteredMemberDetails('0721906050'));
        //MESSAGE(FundsTransferFOSA('2747-007004-01','2747-007004-02','907383280',4000));
        //MESSAGE(LoanBalances('0721906050'));
        //MESSAGE(LoansGuaranteed('0721906050'));
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


    procedure AccountBalance(Acc: Code[30]; DocNumber: Code[20]) Bal: Text[500]
    var
        SavingsAcc: Code[10];
    begin
        Vendor.Reset;
        Vendor.SetRange(Vendor."No.", Acc);
        if Vendor.Find('-') then begin
            if Vendor."Account Type" = 'SAVINGS' then begin
                Bal := GenericCharges(Vendor."BOSA Account No", DocNumber, 'CPBAL', 'Balance Enquiry', SurePESATrans."transaction type"::Balance);
            end;
            if (Bal = 'REFEXISTS') or (Bal = 'INSUFFICIENT') or (Bal = 'ACCNOTFOUND') then begin
                Bal := Bal;
            end
            else begin
                Vendor.CalcFields(Vendor."Balance (LCY)");
                Vendor.CalcFields(Vendor."ATM Transactions");
                Vendor.CalcFields(Vendor."Uncleared Cheques");
                Vendor.CalcFields(Vendor."EFT Transactions");
                Vendor.CalcFields(Vendor."Mobile Transactions");
                AccountTypes.Reset;
                AccountTypes.SetRange(AccountTypes.Code, Vendor."Account Type");
                if AccountTypes.Find('-') then begin
                    miniBalance := AccountTypes."Minimum Balance";
                end;
                accBalance := Vendor."Balance (LCY)" - (Vendor."ATM Transactions" + Vendor."Uncleared Cheques" + Vendor."EFT Transactions" + Vendor."Mobile Transactions" + miniBalance);
                Bal := Format(accBalance);
            end
        end;
    end;


    procedure MiniStatement(Phone: Text[20]; DocNumber: Text[20]) MiniStmt: Text[250]
    var
        BosaNUMBER: Code[30];
    begin

        Members.Reset;
        Members.SetRange(Members."Phone No.", Phone);
        if Vendor.Find('-') then begin
            if Vendor."Account Type" = 'SAVINGS' then begin
                MiniStmt := GenericCharges(Vendor."BOSA Account No", DocNumber, 'CPSTMT', 'Mini Statement', SurePESATrans."transaction type"::Ministatement);
            end
            else begin
                BosaNUMBER := BOSAAccountACC(Members."No.");
                MiniStmt := GenericCharges(BosaNUMBER, DocNumber, 'CPSTMT', 'Mini Statement', SurePESATrans."transaction type"::Ministatement);
            end;
            if (MiniStmt = 'REFEXISTS') or (MiniStmt = 'INSUFFICIENT') or (MiniStmt = 'ACCNOTFOUND') then begin
                MiniStmt := MiniStmt;
            end
            else begin
                minimunCount := 0;
                VendorLedgEntry.Reset;
                VendorLedgEntry.SetCurrentkey(VendorLedgEntry."Entry No.");
                VendorLedgEntry.Ascending(false);
                //VendorLedgEntry.SETFILTER(VendorLedgEntry.Description,'<>%1','*Charges*');
                VendorLedgEntry.SetRange(VendorLedgEntry."Vendor No.", Vendor."No.");
                VendorLedgEntry.SetRange(VendorLedgEntry.Reversed, VendorLedgEntry.Reversed);
                if VendorLedgEntry.FindSet then begin
                    MiniStmt := '';
                    repeat
                        VendorLedgEntry.CalcFields(VendorLedgEntry.Amount);
                        amount := VendorLedgEntry.Amount;
                        if amount < 1 then
                            amount := amount * -1;
                        MiniStmt := MiniStmt + Format(VendorLedgEntry."Posting Date") + ':::' + CopyStr(VendorLedgEntry.Description, 1, 25) + ':::' +
                        Format(amount) + '::::';
                        minimunCount := minimunCount + 1;
                        if minimunCount > 5 then
                            exit
                      until VendorLedgEntry.Next = 0;
                end;
            end
        end;
    end;


    procedure LoanProducts() LoanTypes: Text[1000]
    begin
        begin
            LoanProductsSetup.Reset;
            LoanProductsSetup.SetRange(LoanProductsSetup.Source, LoanProductsSetup.Source::FOSA);
            if LoanProductsSetup.Find('-') then begin
                repeat
                    LoanTypes := LoanTypes + ':::' + LoanProductsSetup."Product Description";
                until LoanProductsSetup.Next = 0;
            end
        end
    end;


    procedure BOSAAccount(Phone: Text[20]) bosaAcc: Text[20]
    begin
        Vendor.Reset;
        Vendor.SetRange(Vendor."Phone No.", Phone);
        if Vendor.Find('-') then begin
            Members.Reset;
            Members.SetRange(Members."No.", Vendor."BOSA Account No");
            if Members.Find('-') then begin
                bosaAcc := Members."No.";
            end;
        end;
    end;


    procedure MemberAccountNumbers(phone: Text[20]) accounts: Text[250]
    begin
        begin
            Vendor.Reset;
            Vendor.SetRange(Vendor."Phone No.", phone);
            Vendor.SetRange(Vendor.Status, Vendor.Status::Active);
            if Vendor.Find('-') then begin
                accounts := '';
                repeat
                    accounts := accounts + '::::' + Vendor."No.";
                until Vendor.Next = 0;
            end
            else begin
                accounts := '';
            end
        end;
    end;


    procedure RegisteredMemberDetails(Phone: Text[20]) reginfo: Text[250]
    begin
        begin
            Vendor.Reset;
            Vendor.SetRange(Vendor."Phone No.", Phone);
            if Vendor.Find('-') then begin
                Members.Reset;
                Members.SetRange(Members."No.", Vendor."BOSA Account No");
                if Members.Find('-') then begin
                    reginfo := Members."No." + ':::' + Members.Name + ':::' + Format(Members."ID No.") + ':::' + Members."Payroll No" + ':::' + Members."E-Mail";
                end;
            end
            else begin
                reginfo := '';
            end
        end;
    end;


    procedure DetailedStatement(Phone: Text[20]; lastEntry: Integer) detailedstatement: Text[1023]
    begin
        begin
            dateExpression := '<CD-1M>'; // Current date less 3 months
            dashboardDataFilter := CalcDate(dateExpression, Today);

            Vendor.Reset;
            Vendor.SetRange(Vendor."Phone No.", Phone);
            detailedstatement := '';
            if Vendor.FindSet then
                repeat
                    minimunCount := 1;
                    AccountTypes.Reset;
                    AccountTypes.SetRange(AccountTypes.Code, Vendor."Account Type");

                    if AccountTypes.FindSet then
                        repeat

                            DetailedVendorLedgerEntry.Reset;
                            DetailedVendorLedgerEntry.SetRange(DetailedVendorLedgerEntry."Vendor No.", Vendor."No.");
                            DetailedVendorLedgerEntry.SetFilter(DetailedVendorLedgerEntry."Entry No.", '>%1', lastEntry);
                            DetailedVendorLedgerEntry.SetFilter(DetailedVendorLedgerEntry."Posting Date", '>%1', dashboardDataFilter);

                            if DetailedVendorLedgerEntry.FindSet then
                                repeat

                                    VendorLedgerEntry.Reset;
                                    VendorLedgerEntry.SetRange(VendorLedgerEntry."Entry No.", DetailedVendorLedgerEntry."Vendor Ledger Entry No.");

                                    if VendorLedgerEntry.FindSet then begin
                                        if detailedstatement = ''
                                        then begin
                                            detailedstatement := Format(DetailedVendorLedgerEntry."Entry No.") + ':::' +
                                            Format(AccountTypes.Description) + ':::' +
                                            Format(DetailedVendorLedgerEntry."Posting Date") + ':::' +
                                            Format((DetailedVendorLedgerEntry."Posting Date"), 0, '<Month Text>') + ':::' +
                                            Format(Date2dmy((DetailedVendorLedgerEntry."Posting Date"), 3)) + ':::' +
                                            Format((DetailedVendorLedgerEntry."Credit Amount"), 0, '<Precision,2:2><Integer><Decimals>') + ':::' +
                                            Format((DetailedVendorLedgerEntry."Debit Amount"), 0, '<Precision,2:2><Integer><Decimals>') + ':::' +
                                            Format((DetailedVendorLedgerEntry.Amount), 0, '<Precision,2:2><Integer><Decimals>') + ':::' +
                                            Format(DetailedVendorLedgerEntry."Journal Batch Name") + ':::' +
                                            Format(DetailedVendorLedgerEntry."Initial Entry Global Dim. 1") + ':::' +
                                            Format(VendorLedgerEntry.Description);
                                        end
                                        else
                                            repeat
                                                detailedstatement := detailedstatement + '::::' +
                                                Format(DetailedVendorLedgerEntry."Entry No.") + ':::' +
                                                Format(AccountTypes.Description) + ':::' +
                                                Format(DetailedVendorLedgerEntry."Posting Date") + ':::' +
                                                Format((DetailedVendorLedgerEntry."Posting Date"), 0, '<Month Text>') + ':::' +
                                                Format(Date2dmy((DetailedVendorLedgerEntry."Posting Date"), 3)) + ':::' +
                                                Format((DetailedVendorLedgerEntry."Credit Amount"), 0, '<Precision,2:2><Integer><Decimals>') + ':::' +
                                                Format((DetailedVendorLedgerEntry."Debit Amount"), 0, '<Precision,2:2><Integer><Decimals>') + ':::' +
                                                Format((DetailedVendorLedgerEntry.Amount), 0, '<Precision,2:2><Integer><Decimals>') + ':::' +
                                                Format(DetailedVendorLedgerEntry."Journal Batch Name") + ':::' +
                                                Format(DetailedVendorLedgerEntry."Initial Entry Global Dim. 1") + ':::' +
                                                Format(VendorLedgerEntry.Description);

                                                if minimunCount > 20 then
                                                    exit
                                            until VendorLedgerEntry.Next = 0;
                                    end;
                                until DetailedVendorLedgerEntry.Next = 0;
                        until AccountTypes.Next = 0;
                until Vendor.Next = 0;
        end;
    end;


    procedure MemberAccountNames(phone: Text[20]) accounts: Text[250]
    begin
        begin
            Vendor.Reset;
            Vendor.SetRange(Vendor."Phone No.", phone);
            Vendor.SetRange(Vendor.Status, Vendor.Status::Active);
            if Vendor.Find('-') then begin
                accounts := '';
                repeat
                    accounts := accounts + '::::' + AccountDescription(Vendor."Account Type");
                until Vendor.Next = 0;
            end
            else begin
                accounts := '';
            end
        end;
    end;


    procedure SharesRetained(phone: Text[20]) shares: Text[1000]
    begin
        begin
            Vendor.Reset;
            Vendor.SetRange(Vendor."Phone No.", phone);
            if Vendor.Find('-') then begin
                MemberLedgerEntry.Reset;
                MemberLedgerEntry.SetRange(MemberLedgerEntry."Customer No.", Vendor."BOSA Account No");
                MemberLedgerEntry.SetRange(MemberLedgerEntry."Transaction Type", MemberLedgerEntry."transaction type"::"Share Capital");
                if MemberLedgerEntry.Find('-') then
                    repeat
                        amount := amount + MemberLedgerEntry.Amount;
                        shares := Format(amount, 0, '<Precision,2:2><Integer><Decimals>');
                    until MemberLedgerEntry.Next = 0;
            end;
        end;
    end;


    procedure LoanBalances(phone: Text[20]) loanbalances: Text[250]
    begin
        begin
            Vendor.Reset;
            Vendor.SetRange(Vendor."Phone No.", phone);
            Vendor.SetRange(Vendor.Status, Vendor.Status::Active);
            Vendor.SetRange(Vendor.Blocked, Vendor.Blocked::" ");
            if Vendor.Find('-') then begin
                accountsFOSA := '';
                repeat
                    accountsFOSA := ':::' + Vendor."No.";
                    LoansRegister.Reset;
                    LoansRegister.SetRange(LoansRegister."Client Code", Vendor."BOSA Account No");
                    if LoansRegister.Find('-') then begin
                        repeat
                            LoansRegister.CalcFields(LoansRegister."Outstanding Balance", LoansRegister."Interest Due", LoansRegister."Interest to be paid", LoansRegister."Interest Paid", LoansRegister."Outstanding Interest");
                            if (LoansRegister."Outstanding Balance" > 0) then
                                loanbalances := loanbalances + '::::' + LoansRegister."Loan  No." + ':::' + LoansRegister."Loan Product Type Name" + ':::' +
                                 Format(LoansRegister."Outstanding Balance");
                        until LoansRegister.Next = 0;
                    end;
                until Vendor.Next = 0;
            end
            else begin
                accountsFOSA := '';
            end
        end;
    end;


    procedure MemberAccounts(phone: Text[20]) accounts: Text[700]
    var
        BosaNUMBER: Code[30];
    begin
        begin
            Vendor.Reset;
            Vendor.SetRange(Vendor."Phone No.", phone);
            Vendor.SetRange(Vendor.Status, Vendor.Status::Active);
            Vendor.SetRange(Vendor.Blocked, Vendor.Blocked::" ");
            if Vendor.Find('-') then begin
                BosaNUMBER := BOSAAccountACC(Vendor."No.");
                accounts := '';
                Vendor.Reset;
                Vendor.SetRange(Vendor."BOSA Account No", BosaNUMBER);
                //Vendor.SETRANGE(Vendor.Status, Vendor.Status::Active);
                //Vendor.SETRANGE(Vendor.Blocked, Vendor.Blocked::" ");
                if Vendor.Find('-') then begin
                    repeat
                        accounts := accounts + '::::' + Vendor."No." + ':::' + AccountDescription(Vendor."Account Type");
                    until Vendor.Next = 0;
                end;
            end
            else begin
                accounts := '';
            end
        end;
    end;


    procedure SurePESARegistration() memberdetails: Text[1000]
    begin
        begin
            SurePESAApplications.Reset;
            SurePESAApplications.SetRange(SurePESAApplications.SentToServer, false);
            //SurePESAApplications.SETRANGE(SurePESAApplications.Status, SurePESAApplications.Status::Active);
            if SurePESAApplications.FindFirst() then begin
                memberdetails := SurePESAApplications."Account No" + ':::' + SurePESAApplications.Telephone + ':::' + SurePESAApplications."ID No";
            end
            else begin
                memberdetails := '';
            end
        end;
    end;


    procedure UpdateSurePESARegistration(accountNo: Text[30]) result: Text[10]
    begin
        begin
            SurePESAApplications.Reset;
            SurePESAApplications.SetRange(SurePESAApplications.SentToServer, false);
            SurePESAApplications.SetRange(SurePESAApplications."Account No", accountNo);
            if SurePESAApplications.Find('-') then begin
                SurePESAApplications.SentToServer := true;
                SurePESAApplications.Modify;
                result := 'Modified';
            end
            else begin
                result := 'Failed';
            end
        end;
    end;


    procedure CurrentShares(phone: Text[20]) shares: Text[1000]
    begin
        begin
            Vendor.Reset;
            Vendor.SetRange(Vendor."Phone No.", phone);
            if Vendor.Find('-') then begin
                MemberLedgerEntry.Reset;
                MemberLedgerEntry.SetRange(MemberLedgerEntry."Customer No.", Vendor."BOSA Account No");
                MemberLedgerEntry.SetRange(MemberLedgerEntry."Transaction Type", MemberLedgerEntry."transaction type"::"Deposit Contribution");
                if MemberLedgerEntry.Find('-') then
                    repeat
                        amount := amount + MemberLedgerEntry.Amount;
                        shares := Format(amount, 0, '<Precision,2:2><Integer><Decimals>');
                    until MemberLedgerEntry.Next = 0;
            end;
        end;
    end;


    procedure BenevolentFund(phone: Text[20]) shares: Text[50]
    begin
        begin
            Vendor.Reset;
            Vendor.SetRange(Vendor."Phone No.", phone);
            if Vendor.Find('-') then begin
                MemberLedgerEntry.Reset;
                MemberLedgerEntry.SetRange(MemberLedgerEntry."Customer No.", Vendor."BOSA Account No");
                MemberLedgerEntry.SetRange(MemberLedgerEntry."Transaction Type", MemberLedgerEntry."transaction type"::"Benevolent Fund");
                if MemberLedgerEntry.Find('-') then
                    repeat
                        amount := amount + MemberLedgerEntry.Amount;
                        shares := Format(amount, 0, '<Precision,2:2><Integer><Decimals>');
                    until MemberLedgerEntry.Next = 0;
            end;
        end;
    end;


    procedure FundsTransferFOSA(accFrom: Text[20]; accTo: Text[20]; DocNumber: Text[30]; amount: Decimal) result: Text[30]
    begin
        SurePESATrans.Reset;
        SurePESATrans.SetRange(SurePESATrans."Document No", DocNumber);
        if SurePESATrans.Find('-') then begin
            result := 'REFEXISTS';
        end
        else begin
            GenLedgerSetup.Reset;
            GenLedgerSetup.Get;
            GenLedgerSetup.TestField(GenLedgerSetup."CloudPESA Comm Acc");
            GenLedgerSetup.TestField(GenLedgerSetup."CloudPESA Charge");

            MobileCharges := GetmobileCharges('TRANS');
            MobileChargesACC := GetMobileGLAcc('TRANS');

            SurePESACommACC := GenLedgerSetup."CloudPESA Comm Acc";
            SurePESACharge := GenLedgerSetup."CloudPESA Charge";
            TotalCharges := SurePESACharge + MobileCharges;
            ExcDuty := (10 / 100) * TotalCharges;

            Vendor.Reset;
            Vendor.SetRange(Vendor."No.", accFrom);
            if Vendor.Find('-') then begin
                Vendor.CalcFields(Vendor."Balance (LCY)");
                Vendor.CalcFields(Vendor."ATM Transactions");
                Vendor.CalcFields(Vendor."Uncleared Cheques");
                Vendor.CalcFields(Vendor."EFT Transactions");
                Vendor.CalcFields(Vendor."Mobile Transactions");
                AccountTypes.Reset;
                AccountTypes.SetRange(AccountTypes.Code, Vendor."Account Type");
                if AccountTypes.Find('-') then begin
                    miniBalance := AccountTypes."Minimum Balance";
                end;

                TempBalance := Vendor."Balance (LCY)" - (Vendor."ATM Transactions" + Vendor."Uncleared Cheques" + Vendor."EFT Transactions" + Vendor."Mobile Transactions" + miniBalance);
                accountName1 := Vendor.Name;
                if Vendor.Get(accTo) then begin

                    if (TempBalance > amount + MobileCharges + ExcDuty) then begin
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

                        //DR ACC 1
                        LineNo := LineNo + 10000;
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := 'GENERAL';
                        GenJournalLine."Journal Batch Name" := 'MOBILETRAN';
                        GenJournalLine."Line No." := LineNo;
                        GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                        GenJournalLine."Account No." := accFrom;
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Document No." := DocNumber;
                        GenJournalLine."Shortcut Dimension 1 Code" := DimensionFOSA;
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                        GenJournalLine."Shortcut Dimension 2 Code" := DimensionBRANCH;
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                        GenJournalLine."External Document No." := accFrom;
                        GenJournalLine."Posting Date" := Today;
                        GenJournalLine.Description := 'Mobile Transfer';
                        GenJournalLine.Amount := amount;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;

                        //Dr Transfer Charges
                        LineNo := LineNo + 10000;
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := 'GENERAL';
                        GenJournalLine."Journal Batch Name" := 'MOBILETRAN';
                        GenJournalLine."Line No." := LineNo;
                        GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                        GenJournalLine."Account No." := accFrom;
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Shortcut Dimension 1 Code" := DimensionFOSA;
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                        GenJournalLine."Shortcut Dimension 2 Code" := DimensionBRANCH;
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                        GenJournalLine."Document No." := DocNumber;
                        GenJournalLine."External Document No." := accFrom;
                        GenJournalLine."Posting Date" := Today;
                        GenJournalLine.Description := 'Mobile Charges';
                        GenJournalLine.Amount := TotalCharges;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;


                        //DR Excise Duty
                        LineNo := LineNo + 10000;
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := 'GENERAL';
                        GenJournalLine."Journal Batch Name" := 'MOBILETRAN';
                        GenJournalLine."Line No." := LineNo;
                        GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                        GenJournalLine."Account No." := accFrom;
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Shortcut Dimension 1 Code" := DimensionFOSA;
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                        GenJournalLine."Shortcut Dimension 2 Code" := DimensionBRANCH;
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                        GenJournalLine."Document No." := DocNumber;
                        GenJournalLine."External Document No." := accFrom;
                        GenJournalLine."Posting Date" := Today;
                        GenJournalLine.Description := 'Excise Duty';
                        GenJournalLine.Amount := ExcDuty;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;

                        LineNo := LineNo + 10000;
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := 'GENERAL';
                        GenJournalLine."Journal Batch Name" := 'MOBILETRAN';
                        GenJournalLine."Line No." := LineNo;
                        GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                        GenJournalLine."Account No." := ExxcDuty;
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Shortcut Dimension 1 Code" := DimensionFOSA;
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                        GenJournalLine."Shortcut Dimension 2 Code" := DimensionBRANCH;
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                        GenJournalLine."Document No." := DocNumber;
                        GenJournalLine."External Document No." := MobileChargesACC;
                        GenJournalLine."Posting Date" := Today;
                        GenJournalLine.Description := 'Excise Duty';
                        GenJournalLine.Amount := ExcDuty * -1;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;

                        //CR Mobile Transactions Acc
                        LineNo := LineNo + 10000;
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := 'GENERAL';
                        GenJournalLine."Journal Batch Name" := 'MOBILETRAN';
                        GenJournalLine."Line No." := LineNo;
                        GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                        GenJournalLine."Account No." := MobileChargesACC;
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Shortcut Dimension 1 Code" := DimensionFOSA;
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                        GenJournalLine."Shortcut Dimension 2 Code" := DimensionBRANCH;
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                        GenJournalLine."Document No." := DocNumber;
                        GenJournalLine."External Document No." := MobileChargesACC;
                        GenJournalLine."Source No." := Vendor."No.";
                        GenJournalLine."Posting Date" := Today;
                        GenJournalLine.Description := 'Mobile Charges';
                        GenJournalLine.Amount := MobileCharges * -1;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;

                        //CR Commission
                        LineNo := LineNo + 10000;
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := 'GENERAL';
                        GenJournalLine."Journal Batch Name" := 'MOBILETRAN';
                        GenJournalLine."Line No." := LineNo;
                        GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                        GenJournalLine."Account No." := SurePESACommACC;
                        GenJournalLine."Source No." := Vendor."No.";
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Shortcut Dimension 1 Code" := DimensionFOSA;
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                        GenJournalLine."Shortcut Dimension 2 Code" := DimensionBRANCH;
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                        GenJournalLine."Document No." := DocNumber;
                        GenJournalLine."External Document No." := MobileChargesACC;
                        GenJournalLine."Posting Date" := Today;
                        GenJournalLine.Description := 'Mobile Charges';
                        GenJournalLine.Amount := -SurePESACharge;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;

                        //CR ACC2
                        LineNo := LineNo + 10000;
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := 'GENERAL';
                        GenJournalLine."Journal Batch Name" := 'MOBILETRAN';
                        GenJournalLine."Line No." := LineNo;
                        GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                        GenJournalLine."Account No." := accTo;
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Shortcut Dimension 1 Code" := DimensionFOSA;
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                        GenJournalLine."Shortcut Dimension 2 Code" := DimensionBRANCH;
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                        GenJournalLine."Document No." := DocNumber;
                        GenJournalLine."Source No." := Vendor."No.";
                        GenJournalLine."External Document No." := accTo;
                        GenJournalLine."Posting Date" := Today;
                        GenJournalLine.Description := 'Mobile Transfer from ' + accFrom;
                        GenJournalLine.Amount := -amount;
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

                        SurePESATrans.Init;
                        SurePESATrans."Document No" := DocNumber;
                        SurePESATrans.Description := 'Mobile Transfer';
                        SurePESATrans."Document Date" := Today;
                        SurePESATrans."Account No" := accFrom;
                        SurePESATrans."Account No2" := accTo;
                        SurePESATrans.Amount := amount;
                        SurePESATrans.Posted := true;
                        SurePESATrans."Posting Date" := Today;
                        SurePESATrans.Status := SurePESATrans.Status::Completed;
                        SurePESATrans.Comments := 'Success';
                        SurePESATrans.Client := Vendor."BOSA Account No";
                        SurePESATrans."Transaction Type" := SurePESATrans."transaction type"::"Transfer to Fosa";
                        SurePESATrans."Transaction Time" := Time;
                        SurePESATrans.Insert;
                        result := 'TRUE';

                        Vendor.Reset();
                        Vendor.SetRange(Vendor."No.", accTo);
                        if Vendor.Find('-') then begin
                            accountName2 := Vendor.Name;
                        end;
                        msg := 'You have transfered KES ' + Format(amount) + ' from Account ' + accountName1 + ' to ' + accountName2 +
                         ' .Thank you for using NAFAKA Sacco Mobile.';
                        SMSMessage(DocNumber, accFrom, Vendor."Phone No.", msg);
                    end
                    else begin
                        result := 'INSUFFICIENT';
                        msg := 'You have insufficient funds in your savings Account to use this service.' +
                       ' .Thank you for using NAFAKA Sacco Mobile.';
                        SMSMessage(DocNumber, accFrom, Vendor."Phone No.", msg);
                    end;
                end
                else begin
                    result := 'ACC2INEXISTENT';
                    msg := 'Your request has failed because the recipent account does not exist.' +
                   ' .Thank you for using NAFAKA Sacco Mobile.';
                    SMSMessage(DocNumber, accFrom, Vendor."Phone No.", msg);
                end;
            end
            else begin
                result := 'ACCINEXISTENT';
                result := 'INSUFFICIENT';
                msg := 'Your request has failed because the recipent account does not exist.' +
                ' .Thank you for using NAFAKA Sacco Mobile.';
                SMSMessage(DocNumber, accFrom, Vendor."Phone No.", msg);
            end;
        end;
    end;


    procedure FundsTransferBOSA(accFrom: Text[20]; accTo: Text[20]; DocNumber: Text[30]; amount: Decimal) result: Text[30]
    begin

        SurePESATrans.Reset;
        SurePESATrans.SetRange(SurePESATrans."Document No", DocNumber);
        if SurePESATrans.Find('-') then begin
            result := 'REFEXISTS';
        end
        else begin

            Members.Reset;
            Members.SetRange(Members."FOSA Account No.", accFrom);
            if Members.Find('-') then begin

                GenLedgerSetup.Reset;
                GenLedgerSetup.Get;
                GenLedgerSetup.TestField(GenLedgerSetup."CloudPESA Comm Acc");
                GenLedgerSetup.TestField(GenLedgerSetup."CloudPESA Charge");

                MobileCharges := GetmobileCharges('TRANS');
                MobileChargesACC := GetMobileGLAcc('TRANS');
                SurePESACommACC := GenLedgerSetup."CloudPESA Comm Acc";
                SurePESACharge := GenLedgerSetup."CloudPESA Charge";
                TotalCharges := MobileCharges + SurePESACharge;
                ExcDuty := (10 / 100) * TotalCharges;

                Vendor.Reset;
                Vendor.SetRange(Vendor."No.", accFrom);
                if Vendor.Find('-') then begin
                    Vendor.CalcFields(Vendor."Balance (LCY)");
                    Vendor.CalcFields(Vendor."ATM Transactions");
                    Vendor.CalcFields(Vendor."Uncleared Cheques");
                    Vendor.CalcFields(Vendor."EFT Transactions");
                    Vendor.CalcFields(Vendor."Mobile Transactions");
                    AccountTypes.Reset;
                    AccountTypes.SetRange(AccountTypes.Code, Vendor."Account Type");
                    if AccountTypes.Find('-') then begin
                        miniBalance := AccountTypes."Minimum Balance";
                    end;
                    TempBalance := Vendor."Balance (LCY)" - (Vendor."ATM Transactions" + Vendor."Uncleared Cheques" + Vendor."EFT Transactions" + Vendor."Mobile Transactions");

                    if (accTo = 'Shares Capital') or (accTo = 'Deposit Contribution') or (accTo = 'Benevolent Fund')
                      then begin
                        if (TempBalance > amount + TotalCharges + ExcDuty) then begin
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

                            //DR ACC 1
                            LineNo := LineNo + 10000;
                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name" := 'GENERAL';
                            GenJournalLine."Journal Batch Name" := 'MOBILETRAN';
                            GenJournalLine."Line No." := LineNo;
                            GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                            GenJournalLine."Account No." := accFrom;
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine."Shortcut Dimension 1 Code" := DimensionBOSA;
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                            GenJournalLine."Shortcut Dimension 2 Code" := DimensionBRANCH;
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                            GenJournalLine."Document No." := DocNumber;
                            GenJournalLine."External Document No." := accFrom;
                            GenJournalLine."Posting Date" := Today;
                            GenJournalLine.Description := 'Mobile Transfer';
                            GenJournalLine.Amount := amount;
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            if GenJournalLine.Amount <> 0 then
                                GenJournalLine.Insert;

                            //Dr Transfer Charges
                            LineNo := LineNo + 10000;
                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name" := 'GENERAL';
                            GenJournalLine."Journal Batch Name" := 'MOBILETRAN';
                            GenJournalLine."Line No." := LineNo;
                            GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                            GenJournalLine."Account No." := accFrom;
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine."Shortcut Dimension 1 Code" := DimensionBOSA;
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                            GenJournalLine."Shortcut Dimension 2 Code" := DimensionBRANCH;
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                            GenJournalLine."Document No." := DocNumber;
                            GenJournalLine."External Document No." := accFrom;
                            GenJournalLine."Posting Date" := Today;
                            GenJournalLine.Description := 'Mobile Charges';
                            GenJournalLine.Amount := MobileCharges + SurePESACharge;
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            if GenJournalLine.Amount <> 0 then
                                GenJournalLine.Insert;


                            //DR Excise Duty
                            LineNo := LineNo + 10000;
                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name" := 'GENERAL';
                            GenJournalLine."Journal Batch Name" := 'MOBILETRAN';
                            GenJournalLine."Line No." := LineNo;
                            GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                            GenJournalLine."Account No." := accFrom;
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine."Shortcut Dimension 1 Code" := DimensionBOSA;
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                            GenJournalLine."Shortcut Dimension 2 Code" := DimensionBRANCH;
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                            GenJournalLine."Document No." := DocNumber;
                            GenJournalLine."External Document No." := accFrom;
                            GenJournalLine."Posting Date" := Today;
                            GenJournalLine.Description := 'Excise Duty';
                            GenJournalLine.Amount := ExcDuty;
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            if GenJournalLine.Amount <> 0 then
                                GenJournalLine.Insert;

                            LineNo := LineNo + 10000;
                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name" := 'GENERAL';
                            GenJournalLine."Journal Batch Name" := 'MOBILETRAN';
                            GenJournalLine."Line No." := LineNo;
                            GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                            GenJournalLine."Account No." := ExxcDuty;
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine."Shortcut Dimension 1 Code" := DimensionBOSA;
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                            GenJournalLine."Shortcut Dimension 2 Code" := DimensionBRANCH;
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                            GenJournalLine."Document No." := DocNumber;
                            GenJournalLine."External Document No." := MobileChargesACC;
                            GenJournalLine."Posting Date" := Today;
                            GenJournalLine.Description := 'Excise Duty';
                            GenJournalLine.Amount := ExcDuty * -1;
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            if GenJournalLine.Amount <> 0 then
                                GenJournalLine.Insert;

                            //CR Mobile Transactions Acc
                            LineNo := LineNo + 10000;
                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name" := 'GENERAL';
                            GenJournalLine."Journal Batch Name" := 'MOBILETRAN';
                            GenJournalLine."Line No." := LineNo;
                            GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                            GenJournalLine."Account No." := MobileChargesACC;
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine."Shortcut Dimension 1 Code" := DimensionBOSA;
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                            GenJournalLine."Shortcut Dimension 2 Code" := DimensionBRANCH;
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                            GenJournalLine."Document No." := DocNumber;
                            GenJournalLine."External Document No." := MobileChargesACC;
                            GenJournalLine."Source No." := Vendor."No.";
                            GenJournalLine."Posting Date" := Today;
                            GenJournalLine.Description := 'Mobile Charges';
                            GenJournalLine.Amount := MobileCharges * -1;
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            if GenJournalLine.Amount <> 0 then
                                GenJournalLine.Insert;

                            //CR Commission
                            LineNo := LineNo + 10000;
                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name" := 'GENERAL';
                            GenJournalLine."Journal Batch Name" := 'MOBILETRAN';
                            GenJournalLine."Line No." := LineNo;
                            GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                            GenJournalLine."Account No." := SurePESACommACC;
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine."Shortcut Dimension 1 Code" := DimensionBOSA;
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                            GenJournalLine."Shortcut Dimension 2 Code" := DimensionBRANCH;
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                            GenJournalLine."Document No." := DocNumber;
                            GenJournalLine."External Document No." := MobileChargesACC;
                            GenJournalLine."Source No." := Vendor."No.";
                            GenJournalLine."Posting Date" := Today;
                            GenJournalLine.Description := 'Mobile Charges';
                            GenJournalLine.Amount := -SurePESACharge;
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            if GenJournalLine.Amount <> 0 then
                                GenJournalLine.Insert;

                            //CR ACC2
                            LineNo := LineNo + 10000;
                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name" := 'GENERAL';
                            GenJournalLine."Journal Batch Name" := 'MOBILETRAN';
                            GenJournalLine."Line No." := LineNo;
                            GenJournalLine."Account Type" := GenJournalLine."account type"::Member;
                            GenJournalLine."Account No." := Members."No.";
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine."Document No." := DocNumber;
                            GenJournalLine."External Document No." := 'SUREPESA';
                            GenJournalLine."Posting Date" := Today;

                            if accTo = 'Deposit Contribution' then begin
                                GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Deposit Contribution";
                                GenJournalLine.Description := 'Deposit Contribution';
                            end;
                            if accTo = 'Shares Capital' then begin
                                GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Share Capital";
                                GenJournalLine.Description := 'Deposit Contribution';
                            end;
                            if accTo = 'Benevolent Fund' then begin
                                GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Benevolent Fund";
                                GenJournalLine.Description := 'Benevolent Fund contribution.';
                            end;
                            GenJournalLine."Shortcut Dimension 1 Code" := DimensionBOSA;
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                            GenJournalLine."Shortcut Dimension 2 Code" := DimensionBRANCH;
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            GenJournalLine.Amount := -amount;
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

                            SurePESATrans.Init;
                            SurePESATrans."Document No" := DocNumber;
                            SurePESATrans.Description := 'Mobile Transfer';
                            SurePESATrans."Document Date" := Today;
                            SurePESATrans."Account No" := accFrom;
                            SurePESATrans."Account No2" := accTo;
                            SurePESATrans.Amount := amount;
                            SurePESATrans.Posted := true;
                            SurePESATrans."Posting Date" := Today;
                            SurePESATrans.Comments := 'Success';
                            SurePESATrans.Client := Vendor."BOSA Account No";
                            SurePESATrans."Transaction Type" := SurePESATrans."transaction type"::"Transfer to Fosa";
                            SurePESATrans."Transaction Time" := Time;
                            SurePESATrans.Insert;
                            result := 'TRUE';

                            msg := 'You have transfered KES ' + Format(amount) + ' from Account ' + Vendor.Name + ' to ' + accTo +
                             ' .Thank you for using NAFAKA Sacco Mobile.';
                            SMSMessage(DocNumber, accFrom, Vendor."Phone No.", msg);
                        end
                        else begin
                            result := 'INSUFFICIENT';
                            msg := 'You have insufficient funds in your savings Account to use this service.' +
                           '. Thank you for using NAFAKA Sacco Mobile.';
                            SMSMessage(DocNumber, accFrom, Vendor."Phone No.", msg);
                        end;
                    end
                    else begin
                        result := 'ACC2INEXISTENT';
                        msg := 'Your request has failed because the recipent account does not exist.' +
                       '. Thank you for using NAFAKA Sacco Mobile.';
                        SMSMessage(DocNumber, accFrom, Vendor."Phone No.", msg);
                    end;
                end
                else begin
                    result := 'ACCINEXISTENT';
                    result := 'INSUFFICIENT';
                    msg := 'Your request has failed because the recipent account does not exist.' +
                    '. Thank you for using NAFAKA Sacco Mobile.';
                    SMSMessage(DocNumber, accFrom, Vendor."Phone No.", msg);
                end;
            end
            else begin
                result := 'MEMBERINEXISTENT';
                msg := 'Your request has failed because the recipent account does not exist.' +
                '. Thank you for using NAFAKA Sacco Mobile.';
                SMSMessage(DocNumber, accFrom, Vendor."Phone No.", msg);
            end;
        end;
    end;


    procedure WSSAccount(phone: Text[20]) accounts: Text[250]
    begin
        begin
            Vendor.Reset;
            Vendor.SetRange(Vendor."Phone No.", phone);
            Vendor.SetRange(Vendor.Status, Vendor.Status::Active);
            Vendor.SetRange(Vendor."Account Type", 'SAVINGS');
            Vendor.SetRange(Vendor.Blocked, Vendor.Blocked::" ");
            if Vendor.Find('-') then begin
                accounts := Vendor."No." + ':::' + AccountDescription(Vendor."Account Type");
            end
            else begin
                accounts := '';
            end

        end;
    end;


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


    procedure LoanRepayment(accFrom: Text[20]; loanNo: Text[20]; DocNumber: Text[30]; amount: Decimal) result: Text[30]
    begin

        SurePESATrans.Reset;
        SurePESATrans.SetRange(SurePESATrans."Document No", DocNumber);
        if SurePESATrans.Find('-') then begin
            result := 'REFEXISTS';
        end
        else begin
            LoanAmt := amount;

            Members.Reset;
            Members.SetRange(Members."FOSA Account No.", accFrom);
            if Members.Find('-') then begin

                GenLedgerSetup.Reset;
                GenLedgerSetup.Get;
                GenLedgerSetup.TestField(GenLedgerSetup."CloudPESA Comm Acc");
                GenLedgerSetup.TestField(GenLedgerSetup."CloudPESA Charge");

                MobileCharges := GetmobileCharges('LOANREP');
                MobileChargesACC := GetMobileGLAcc('LOANREP');

                SurePESACommACC := GenLedgerSetup."CloudPESA Comm Acc";
                SurePESACharge := GenLedgerSetup."CloudPESA Charge";
                TotalCharges := SurePESACharge + MobileCharges;
                ExcDuty := (10 / 100) * TotalCharges;

                Vendor.Reset;
                Vendor.SetRange(Vendor."No.", accFrom);
                if Vendor.Find('-') then begin
                    Vendor.CalcFields(Vendor."Balance (LCY)");
                    Vendor.CalcFields(Vendor."ATM Transactions");
                    Vendor.CalcFields(Vendor."Uncleared Cheques");
                    Vendor.CalcFields(Vendor."EFT Transactions");
                    Vendor.CalcFields(Vendor."Mobile Transactions");

                    AccountTypes.Reset;
                    AccountTypes.SetRange(AccountTypes.Code, Vendor."Account Type");
                    if AccountTypes.Find('-') then begin
                        miniBalance := AccountTypes."Minimum Balance";
                    end;

                    TempBalance := Vendor."Balance (LCY)" - (Vendor."ATM Transactions" + Vendor."Uncleared Cheques" + Vendor."EFT Transactions" + Vendor."Mobile Transactions" + miniBalance);

                    LoansRegister.Reset;
                    LoansRegister.SetRange(LoansRegister."Loan  No.", loanNo);
                    LoansRegister.SetRange(LoansRegister."Client Code", Members."No.");

                    if LoansRegister.Find('+') then begin
                        LoansRegister.CalcFields(LoansRegister."Outstanding Balance", LoansRegister."Outstanding Interest", LoansRegister."Interest Paid");
                        if (TempBalance > amount + TotalCharges + ExcDuty) then begin
                            if LoansRegister."Outstanding Balance" > 50 then begin
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
                                    GenBatches.Description := 'Mobile Loan Repayment';
                                    GenBatches.Validate(GenBatches."Journal Template Name");
                                    GenBatches.Validate(GenBatches.Name);
                                    GenBatches.Insert;
                                end;

                                //DR ACC 1
                                LineNo := LineNo + 10000;
                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := 'GENERAL';
                                GenJournalLine."Journal Batch Name" := 'MOBILETRAN';
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                GenJournalLine."Account No." := accFrom;
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Shortcut Dimension 1 Code" := DimensionBOSA;
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                GenJournalLine."Shortcut Dimension 2 Code" := DimensionBRANCH;
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                GenJournalLine."Document No." := DocNumber;
                                GenJournalLine."External Document No." := accFrom;
                                GenJournalLine."Posting Date" := Today;
                                GenJournalLine.Description := 'Mobile Loan Repayment';
                                GenJournalLine.Amount := amount;
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;

                                //Dr Transfer Charges
                                LineNo := LineNo + 10000;
                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := 'GENERAL';
                                GenJournalLine."Journal Batch Name" := 'MOBILETRAN';
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                GenJournalLine."Account No." := accFrom;
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Shortcut Dimension 1 Code" := DimensionBOSA;
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                GenJournalLine."Shortcut Dimension 2 Code" := DimensionBRANCH;
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                GenJournalLine."Document No." := DocNumber;
                                GenJournalLine."External Document No." := accFrom;
                                GenJournalLine."Posting Date" := Today;
                                GenJournalLine.Description := 'Mobile Charges';
                                GenJournalLine.Amount := MobileCharges + SurePESACharge;
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;


                                //DR Excise Duty
                                LineNo := LineNo + 10000;
                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := 'GENERAL';
                                GenJournalLine."Journal Batch Name" := 'MOBILETRAN';
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                GenJournalLine."Account No." := accFrom;
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Shortcut Dimension 1 Code" := DimensionBOSA;
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                GenJournalLine."Shortcut Dimension 2 Code" := DimensionBRANCH;
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                GenJournalLine."Document No." := DocNumber;
                                GenJournalLine."External Document No." := accFrom;
                                GenJournalLine."Posting Date" := Today;
                                GenJournalLine.Description := 'Excise Duty.';
                                GenJournalLine.Amount := ExcDuty;
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;

                                LineNo := LineNo + 10000;
                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := 'GENERAL';
                                GenJournalLine."Journal Batch Name" := 'MOBILETRAN';
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                                GenJournalLine."Account No." := ExxcDuty;
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Shortcut Dimension 1 Code" := DimensionBOSA;
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                GenJournalLine."Shortcut Dimension 2 Code" := DimensionBRANCH;
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                GenJournalLine."Document No." := DocNumber;
                                GenJournalLine."External Document No." := MobileChargesACC;
                                GenJournalLine."Posting Date" := Today;
                                GenJournalLine.Description := 'Excise Duty.';
                                GenJournalLine.Amount := ExcDuty * -1;
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;

                                //CR Mobile Transactions Acc
                                LineNo := LineNo + 10000;
                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := 'GENERAL';
                                GenJournalLine."Journal Batch Name" := 'MOBILETRAN';
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                                GenJournalLine."Account No." := MobileChargesACC;
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Shortcut Dimension 1 Code" := DimensionBOSA;
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                GenJournalLine."Shortcut Dimension 2 Code" := DimensionBRANCH;
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                GenJournalLine."Document No." := DocNumber;
                                GenJournalLine."External Document No." := MobileChargesACC;
                                GenJournalLine."Source No." := Vendor."No.";
                                GenJournalLine."Posting Date" := Today;
                                GenJournalLine.Description := 'Mobile Charges';
                                GenJournalLine.Amount := MobileCharges * -1;
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;

                                //CR Commission
                                LineNo := LineNo + 10000;
                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := 'GENERAL';
                                GenJournalLine."Journal Batch Name" := 'MOBILETRAN';
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                                GenJournalLine."Account No." := SurePESACommACC;
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Shortcut Dimension 1 Code" := DimensionBOSA;
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                GenJournalLine."Shortcut Dimension 2 Code" := DimensionBRANCH;
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                GenJournalLine."Document No." := DocNumber;
                                GenJournalLine."External Document No." := MobileChargesACC;
                                GenJournalLine."Source No." := Vendor."No.";
                                GenJournalLine."Posting Date" := Today;
                                GenJournalLine.Description := 'Mobile Charges';
                                GenJournalLine.Amount := -SurePESACharge;
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;

                                if (LoansRegister."Outstanding Interest" + LoansRegister."Interest Paid") > 0 then begin
                                    LineNo := LineNo + 10000;

                                    GenJournalLine.Init;
                                    GenJournalLine."Journal Template Name" := 'GENERAL';
                                    GenJournalLine."Journal Batch Name" := 'MOBILETRAN';
                                    GenJournalLine."Line No." := LineNo;
                                    GenJournalLine."Account Type" := GenJournalLine."account type"::Member;
                                    GenJournalLine."Account No." := LoansRegister."Client Code";
                                    GenJournalLine.Validate(GenJournalLine."Account No.");
                                    GenJournalLine."Shortcut Dimension 1 Code" := DimensionBOSA;
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                    GenJournalLine."Shortcut Dimension 2 Code" := DimensionBRANCH;
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                    GenJournalLine."Document No." := DocNumber;
                                    GenJournalLine."External Document No." := '';
                                    GenJournalLine."Posting Date" := Today;
                                    GenJournalLine.Description := Format(GenJournalLine."transaction type"::"Interest Paid");
                                end;

                                if amount > (LoansRegister."Outstanding Interest" + LoansRegister."Interest Paid") then
                                    GenJournalLine.Amount := -(LoansRegister."Outstanding Interest" + LoansRegister."Interest Paid")
                                else
                                    GenJournalLine.Amount := -amount;
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Interest Paid";

                                if GenJournalLine."Shortcut Dimension 1 Code" = '' then begin
                                    GenJournalLine."Shortcut Dimension 1 Code" := Members."Global Dimension 1 Code";
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                end;
                                GenJournalLine."Loan No" := LoansRegister."Loan  No.";
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;

                                amount := amount + GenJournalLine.Amount;

                                if amount > 0 then begin
                                    LineNo := LineNo + 10000;

                                    GenJournalLine.Init;
                                    GenJournalLine."Journal Template Name" := 'GENERAL';
                                    GenJournalLine."Journal Batch Name" := 'MOBILETRAN';
                                    GenJournalLine."Line No." := LineNo;
                                    GenJournalLine."Account Type" := GenJournalLine."account type"::Member;
                                    GenJournalLine."Account No." := LoansRegister."Client Code";
                                    GenJournalLine.Validate(GenJournalLine."Account No.");
                                    GenJournalLine."Shortcut Dimension 1 Code" := DimensionBOSA;
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                    GenJournalLine."Shortcut Dimension 2 Code" := DimensionBRANCH;
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                    GenJournalLine."Document No." := DocNumber;
                                    GenJournalLine."External Document No." := '';
                                    GenJournalLine."Posting Date" := Today;
                                    GenJournalLine.Description := Format(GenJournalLine."transaction type"::"Loan Repayment");
                                    GenJournalLine.Amount := -amount;
                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                    GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Loan Repayment";
                                    if GenJournalLine."Shortcut Dimension 1 Code" = '' then begin
                                        GenJournalLine."Shortcut Dimension 1 Code" := Members."Global Dimension 1 Code";
                                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                    end;
                                    GenJournalLine."Loan No" := LoansRegister."Loan  No.";
                                    if GenJournalLine.Amount <> 0 then
                                        GenJournalLine.Insert;
                                end;


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

                                SurePESATrans.Init;
                                SurePESATrans."Document No" := DocNumber;
                                SurePESATrans.Description := 'Mobile repayment';
                                SurePESATrans."Document Date" := Today;
                                SurePESATrans."Account No" := accFrom;
                                SurePESATrans."Account No2" := loanNo;
                                SurePESATrans.Amount := amount;
                                SurePESATrans.Posted := true;
                                SurePESATrans."Posting Date" := Today;
                                SurePESATrans.Comments := 'Success';
                                SurePESATrans.Client := Vendor."BOSA Account No";
                                SurePESATrans."Transaction Type" := SurePESATrans."transaction type"::"Transfer to Fosa";
                                SurePESATrans."Transaction Time" := Time;
                                SurePESATrans.Insert;
                                result := 'TRUE';

                                msg := 'You have transfered KES ' + Format(LoanAmt) + ' from Account ' + Vendor.Name + ' to ' + loanNo +
                                 '. Thank you for using NAFAKA Sacco Mobile.';
                                SMSMessage(DocNumber, accFrom, Vendor."Phone No.", msg);
                            end;
                        end
                        else begin
                            result := 'INSUFFICIENT';
                            msg := 'You have insufficient funds in your savings Account to use this service.' +
                           '. Thank you for using NAFAKA Sacco Mobile.';
                            SMSMessage(DocNumber, accFrom, Vendor."Phone No.", msg);
                        end;
                    end
                    else begin
                        result := 'ACC2INEXISTENT';
                        msg := 'Your request has failed because you do not have any outstanding balance.' +
                       '. Thank you for using NAFAKA Sacco Mobile.';
                        SMSMessage(DocNumber, accFrom, Vendor."Phone No.", msg);
                    end;
                end
                else begin
                    result := 'ACCINEXISTENT';
                    msg := 'Your request has failed.Please make sure you are registered for mobile banking.' +
                    '. Thank you for using NAFAKA Sacco Mobile.';
                    SMSMessage(DocNumber, accFrom, Vendor."Phone No.", msg);
                end;
            end
            else begin
                result := 'MEMBERINEXISTENT';
                msg := 'Your request has failed because the recipent account does not exist.' +
                '. Thank you for using NAFAKA Sacco Mobile.';
                SMSMessage(DocNumber, accFrom, Vendor."Phone No.", msg);
            end;
        end
    end;


    procedure OutstandingLoans(phone: Text[20]) loannos: Text[200]
    begin
        begin
            Vendor.Reset;
            Vendor.SetRange(Vendor."Phone No.", phone);
            if Vendor.Find('-') then begin
                LoansRegister.Reset;
                LoansRegister.SetRange(LoansRegister."Client Code", Vendor."BOSA Account No");
                if LoansRegister.Find('-') then begin
                    repeat
                        LoansRegister.CalcFields(LoansRegister."Outstanding Balance", LoansRegister."Interest Due", LoansRegister."Interest to be paid", LoansRegister."Interest Paid");
                        if (LoansRegister."Outstanding Balance" > 0) or (LoansRegister."Interest Due" > 0) then
                            loannos := loannos + ':::' + LoansRegister."Loan  No.";
                    until LoansRegister.Next = 0;
                end;
            end
        end;
    end;


    procedure LoanGuarantors(loanNo: Text[20]) guarantors: Text[1000]
    begin

        /*LoansRegister.RESET;
        LoansRegister.SETRANGE(LoansRegister."Loan  No.",loanNo);
        LoansRegister.SETRANGE(LoansRegister."Client Code",Members."No.");*/

        LoanGuaranteeDetails.Reset;
        LoanGuaranteeDetails.SetRange(LoanGuaranteeDetails."Loan No", loanNo);
        if LoanGuaranteeDetails.Find('-') then begin
            repeat
                guarantors := guarantors + '::::' + LoanGuaranteeDetails.Name + ':::' + Format(LoanGuaranteeDetails."Amont Guaranteed");
            until LoanGuaranteeDetails.Next = 0;
        end;

    end;


    procedure LoansGuaranteed(phone: Text[20]) guarantors: Text[1000]
    begin
        begin
            Vendor.Reset;
            Vendor.SetRange(Vendor."Phone No.", phone);
            if Vendor.Find('-') then begin
                bosaNo := Vendor."BOSA Account No";

                LoanGuaranteeDetails.Reset;
                LoanGuaranteeDetails.SetRange(LoanGuaranteeDetails."Member No", bosaNo);
                if LoanGuaranteeDetails.Find('-') then begin
                    // IF (LoanGuaranteeDetails."Guarantor Outstanding">0) THEN BEGIN
                    repeat
                        LoanGuaranteeDetails.CalcFields(LoanGuaranteeDetails."Guarantor Outstanding");
                        guarantors := guarantors + ':::' + LoanGuaranteeDetails."Loan No" + ':::' + Format(LoanGuaranteeDetails."Guarantor Outstanding") + '::::';
                    until LoanGuaranteeDetails.Next = 0;
                end;
            end;
        end;
        //END;
    end;


    procedure ClientCodes(loanNo: Text[20]) codes: Text[20]
    begin
        begin
            LoansRegister.Reset;
            LoansRegister.SetRange(LoansRegister."Loan  No.", loanNo);
            if LoansRegister.Find('-') then begin
                codes := LoansRegister."Client Code";
            end;
        end
    end;


    procedure ClientNames(ccode: Text[20]) names: Text[100]
    begin
        begin
            LoansRegister.Reset;
            LoansRegister.SetRange(LoansRegister."Client Code", ccode);
            if LoansRegister.Find('-') then begin
                Vendor.Reset;
                Vendor.SetRange(Vendor."BOSA Account No", ccode);
                if Vendor.Find('-') then begin
                    names := Vendor.Name;
                end;
            end;
        end
    end;


    procedure ChargesGuarantorInfo(Phone: Text[20]; DocNumber: Text[20]) result: Text[250]
    begin
        begin
            SurePESATrans.Reset;
            SurePESATrans.SetRange(SurePESATrans."Document No", DocNumber);
            if SurePESATrans.Find('-') then begin
                result := 'REFEXISTS';
            end
            else begin
                result := '';
                GenLedgerSetup.Reset;
                GenLedgerSetup.Get;
                GenLedgerSetup.TestField(GenLedgerSetup."Mobile Charge");
                GenLedgerSetup.TestField(GenLedgerSetup."CloudPESA Comm Acc");
                GenLedgerSetup.TestField(GenLedgerSetup."CloudPESA Charge");

                Charges.Reset;
                Charges.SetRange(Charges.Code, GenLedgerSetup."Mobile Charge");
                if Charges.Find('-') then begin
                    Charges.TestField(Charges."GL Account");
                    MobileChargesACC := Charges."GL Account";
                end;

                SurePESACommACC := GenLedgerSetup."CloudPESA Comm Acc";
                SurePESACharge := GenLedgerSetup."CloudPESA Charge";

                Vendor.Reset;
                Vendor.SetRange(Vendor."Phone No.", Phone);
                if Vendor.Find('-') then begin
                    Vendor.CalcFields(Vendor."Balance (LCY)");
                    TempBalance := Vendor."Balance (LCY)" - (Vendor."ATM Transactions" + Vendor."Uncleared Cheques" + Vendor."EFT Transactions");
                    fosaAcc := Vendor."No.";

                    if (TempBalance > SurePESACharge) then begin
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
                            GenBatches.Description := 'Loan Guarantors Info';
                            GenBatches.Validate(GenBatches."Journal Template Name");
                            GenBatches.Validate(GenBatches.Name);
                            GenBatches.Insert;
                        end;

                        //Dr Mobile Charges
                        LineNo := LineNo + 10000;
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := 'GENERAL';
                        GenJournalLine."Journal Batch Name" := 'MOBILETRAN';
                        GenJournalLine."Line No." := LineNo;
                        GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                        GenJournalLine."Account No." := fosaAcc;
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Document No." := DocNumber;
                        GenJournalLine."External Document No." := fosaAcc;
                        GenJournalLine."Posting Date" := Today;
                        GenJournalLine.Description := 'Loan Guarantors Info Charges';
                        GenJournalLine.Amount := SurePESACharge;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;

                        //CR Commission
                        LineNo := LineNo + 10000;
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := 'GENERAL';
                        GenJournalLine."Journal Batch Name" := 'MOBILETRAN';
                        GenJournalLine."Line No." := LineNo;
                        GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                        GenJournalLine."Account No." := SurePESACommACC;
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Document No." := DocNumber;
                        GenJournalLine."External Document No." := MobileChargesACC;
                        GenJournalLine."Posting Date" := Today;
                        GenJournalLine.Description := 'Loan Guarantors Info Charges';
                        GenJournalLine.Amount := -SurePESACharge;
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

                        SurePESATrans.Init;
                        SurePESATrans."Document No" := DocNumber;
                        SurePESATrans.Description := 'Loan Guarantors Info';
                        SurePESATrans."Document Date" := Today;
                        SurePESATrans."Account No" := Vendor."No.";
                        SurePESATrans."Account No2" := '';
                        SurePESATrans.Amount := amount;
                        SurePESATrans.Posted := true;
                        SurePESATrans."Posting Date" := Today;
                        SurePESATrans.Status := SurePESATrans.Status::Completed;
                        SurePESATrans.Comments := 'Success';
                        SurePESATrans.Client := Vendor."BOSA Account No";
                        SurePESATrans."Transaction Type" := SurePESATrans."transaction type"::Ministatement;
                        SurePESATrans."Transaction Time" := Time;
                        SurePESATrans.Insert;
                        result := 'TRUE';
                    end
                    else begin
                        result := 'INSUFFICIENT';
                    end;
                end
                else begin
                    result := 'ACCNOTFOUND';
                end;
            end;
        end;
    end;


    procedure AccountBalanceNew(Acc: Code[30]; DocNumber: Code[20]) Bal: Text[50]
    var
        BosaNUMBER: Code[30];
        PhoneNo: Code[30];
    begin
        Vendor.Reset;
        Vendor.SetRange(Vendor."No.", Acc);
        if Vendor.Find('-') then begin
            if Vendor."Account Type" = 'SAVINGS' then begin
                BosaNUMBER := BOSAAccountACC(Vendor."No.");
                Bal := GenericCharges(Vendor."BOSA Account No", DocNumber, 'CPBAL', 'Balance Enquiry', SurePESATrans."transaction type"::Balance);
            end
            else begin
                BosaNUMBER := BOSAAccountACC(Vendor."No.");
                Bal := GenericCharges(BosaNUMBER, DocNumber, 'CPBAL', 'Balance Enquiry', SurePESATrans."transaction type"::Balance);
            end;
            if (Bal = 'REFEXISTS') or (Bal = 'INSUFFICIENT') or (Bal = 'ACCNOTFOUND') then begin
                Bal := Bal;
            end
            else begin

                Vendor.Reset;
                Vendor.SetRange(Vendor."Account Type", 'SAVINGS');
                Vendor.SetRange(Vendor."BOSA Account No", BosaNUMBER);
                if Vendor.Find('-') then begin
                    PhoneNo := Vendor."Phone No."
                end;

                Vendor.Reset;
                Vendor.SetRange(Vendor."No.", Acc);
                if Vendor.Find('-') then begin
                    AccountTypes.Reset;
                    AccountTypes.SetRange(AccountTypes.Code, Vendor."Account Type");
                    if AccountTypes.Find('-') then begin
                        miniBalance := AccountTypes."Minimum Balance";
                    end;
                    Vendor.CalcFields(Vendor."Balance (LCY)");
                    Vendor.CalcFields(Vendor."ATM Transactions");
                    Vendor.CalcFields(Vendor."Uncleared Cheques");
                    Vendor.CalcFields(Vendor."EFT Transactions");
                    Vendor.CalcFields(Vendor."Mobile Transactions");
                    accBalance := Vendor."Balance (LCY)" - (Vendor."ATM Transactions" + Vendor."Uncleared Cheques" + Vendor."EFT Transactions" + Vendor."Mobile Transactions");
                    msg := 'Account Name: ' + Vendor.Name + ', ' + 'BOOK BALANCE: ' + Format(accBalance) + ', ' + 'AVAILABLE BALANCE: ' + Format(accBalance - miniBalance) + '. '
                  + 'Thank you for using NAFAKA Sacco Mobile';
                    SMSMessage(DocNumber, Vendor."No.", PhoneNo, msg);
                    Bal := 'TRUE';
                end;
            end
        end;
    end;


    procedure AccountBalanceDec(Acc: Code[30]; amt: Decimal) Bal: Decimal
    begin
        begin
            Vendor.Reset;
            Vendor.SetRange(Vendor."No.", Acc);
            if Vendor.Find('-') then begin
                AccountTypes.Reset;
                AccountTypes.SetRange(AccountTypes.Code, Vendor."Account Type");
                if AccountTypes.Find('-') then begin
                    miniBalance := AccountTypes."Minimum Balance";
                end;
                Vendor.CalcFields(Vendor."Balance (LCY)");
                Vendor.CalcFields(Vendor."ATM Transactions");
                Vendor.CalcFields(Vendor."Uncleared Cheques");
                Vendor.CalcFields(Vendor."EFT Transactions");
                Bal := Vendor."Balance (LCY)" - (Vendor."ATM Transactions" + Vendor."Uncleared Cheques" + Vendor."EFT Transactions" + miniBalance);

                GenLedgerSetup.Reset;
                GenLedgerSetup.Get;
                GenLedgerSetup.TestField(GenLedgerSetup."CloudPESA Comm Acc");
                GenLedgerSetup.TestField(GenLedgerSetup."CloudPESA Charge");

                Charges.Reset;
                Charges.SetRange(Charges.Code, GenLedgerSetup."Mobile Charge");
                if Charges.Find('-') then begin
                    Charges.TestField(Charges."GL Account");

                    MPESACharge := GetCharge(amt, 'MPESA');
                    SurePESACharge := GetCharge(amt, 'VENDWD');
                    MobileCharges := GetCharge(amt, 'SACCOWD');

                    ExcDuty := (10 / 100) * (MobileCharges + SurePESACharge);
                    TotalCharges := SurePESACharge + MobileCharges + ExcDuty + MPESACharge;
                end;
                Bal := Bal - TotalCharges;
            end
        end;
    end;

    local procedure GetCharge(amount: Decimal; "code": Text[20]) charge: Decimal
    begin
        TariffDetails.Reset;
        TariffDetails.SetRange(TariffDetails.Code, code);
        TariffDetails.SetFilter(TariffDetails."Lower Limit", '<=%1', amount);
        TariffDetails.SetFilter(TariffDetails."Upper Limit", '>=%1', amount);
        if TariffDetails.Find('-') then begin
            charge := TariffDetails."Charge Amount";
        end
    end;


    procedure PostMPESATrans(docNo: Text[20]; telephoneNo: Text[20]; amount: Decimal) result: Text[30]
    var
        ChargeAccount: label '001111';
    begin

        SurePESATrans.Reset;
        SurePESATrans.SetRange(SurePESATrans."Document No", docNo);
        if SurePESATrans.Find('-') then begin
            result := 'REFEXISTS';
        end
        else begin

            GenLedgerSetup.Reset;
            GenLedgerSetup.Get;
            GenLedgerSetup.TestField(GenLedgerSetup."MPESA Settl Acc");
            GenLedgerSetup.TestField(GenLedgerSetup."CloudPESA Comm Acc");
            GenLedgerSetup.TestField(GenLedgerSetup."CloudPESA Charge");

            MPESACharge := GetCharge(amount, 'MPESA');
            SurePESACharge := GenLedgerSetup."CloudPESA Charge";
            MobileCharges := GetCharge(amount, 'SACCOWD');

            SurePESACommACC := GenLedgerSetup."CloudPESA Comm Acc";
            MPESARecon := GenLedgerSetup."MPESA Settl Acc";
            MobileChargesACC := ChargeAccount;

            TotalCharges := SurePESACharge + MobileCharges + MPESACharge;
            ExcDuty := (10 / 100) * (SurePESACharge + MobileCharges);
        end;

        Vendor.Reset;
        Vendor.SetRange(Vendor."Phone No.", telephoneNo);
        if Vendor.Find('-') then begin
            Vendor.CalcFields(Vendor."Balance (LCY)");
            Vendor.CalcFields(Vendor."ATM Transactions");
            Vendor.CalcFields(Vendor."Uncleared Cheques");
            Vendor.CalcFields(Vendor."EFT Transactions");
            Vendor.CalcFields(Vendor."Mobile Transactions");
            TempBalance := Vendor."Balance (LCY)" - (Vendor."ATM Transactions" + Vendor."Uncleared Cheques" + Vendor."EFT Transactions" + Vendor."Mobile Transactions");

            if (TempBalance > amount + TotalCharges + MPESACharge + ExcDuty) then begin
                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                GenJournalLine.SetRange("Journal Batch Name", 'MPESAWITHD');
                GenJournalLine.DeleteAll;
                //end of deletion

                GenBatches.Reset;
                GenBatches.SetRange(GenBatches."Journal Template Name", 'GENERAL');
                GenBatches.SetRange(GenBatches.Name, 'MPESAWITHD');

                if GenBatches.Find('-') = false then begin
                    GenBatches.Init;
                    GenBatches."Journal Template Name" := 'GENERAL';
                    GenBatches.Name := 'MPESAWITHD';
                    GenBatches.Description := 'MPESA Withdrawal';
                    GenBatches.Validate(GenBatches."Journal Template Name");
                    GenBatches.Validate(GenBatches.Name);
                    GenBatches.Insert;
                end;

                //DR Customer Acc
                LineNo := LineNo + 10000;
                GenJournalLine.Init;
                GenJournalLine."Journal Template Name" := 'GENERAL';
                GenJournalLine."Journal Batch Name" := 'MPESAWITHD';
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                GenJournalLine."Account No." := Vendor."No.";
                GenJournalLine.Validate(GenJournalLine."Account No.");
                GenJournalLine."Document No." := docNo;
                GenJournalLine."External Document No." := Vendor."No.";
                GenJournalLine."Posting Date" := Today;
                GenJournalLine.Description := 'MPESA Withdrawal';
                GenJournalLine.Amount := amount;
                GenJournalLine.Validate(GenJournalLine.Amount);
                if GenJournalLine.Amount <> 0 then
                    GenJournalLine.Insert;

                //Dr Withdrawal Charges
                LineNo := LineNo + 10000;
                GenJournalLine.Init;
                GenJournalLine."Journal Template Name" := 'GENERAL';
                GenJournalLine."Journal Batch Name" := 'MPESAWITHD';
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                GenJournalLine."Account No." := Vendor."No.";
                GenJournalLine.Validate(GenJournalLine."Account No.");
                GenJournalLine."Document No." := docNo;
                GenJournalLine."External Document No." := Vendor."No.";
                GenJournalLine."Posting Date" := Today;
                GenJournalLine.Description := 'Mobile Charges';
                GenJournalLine.Amount := TotalCharges;
                GenJournalLine.Validate(GenJournalLine.Amount);
                if GenJournalLine.Amount <> 0 then
                    GenJournalLine.Insert;

                //Cr MPESA ACC
                LineNo := LineNo + 10000;
                GenJournalLine.Init;
                GenJournalLine."Journal Template Name" := 'GENERAL';
                GenJournalLine."Journal Batch Name" := 'MPESAWITHD';
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Account Type" := GenJournalLine."account type"::"Bank Account";
                GenJournalLine."Account No." := MPESARecon;
                GenJournalLine.Validate(GenJournalLine."Account No.");
                GenJournalLine."Document No." := docNo;
                GenJournalLine."External Document No." := Vendor."No.";
                GenJournalLine."Source No." := Vendor."No.";
                GenJournalLine."Posting Date" := Today;
                GenJournalLine.Description := 'Withdrawal to MPESA';
                GenJournalLine.Amount := (amount) * -1;
                GenJournalLine.Validate(GenJournalLine.Amount);
                if GenJournalLine.Amount <> 0 then
                    GenJournalLine.Insert;
                //Cr MPESA ACC
                LineNo := LineNo + 10000;
                GenJournalLine.Init;
                GenJournalLine."Journal Template Name" := 'GENERAL';
                GenJournalLine."Journal Batch Name" := 'MPESAWITHD';
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Account Type" := GenJournalLine."account type"::"Bank Account";
                GenJournalLine."Account No." := MPESARecon;
                GenJournalLine.Validate(GenJournalLine."Account No.");
                GenJournalLine."Document No." := docNo;
                GenJournalLine."External Document No." := Vendor."No.";
                GenJournalLine."Source No." := Vendor."No.";
                GenJournalLine."Posting Date" := Today;
                GenJournalLine.Description := 'MPESA Withdrawal Charges';
                GenJournalLine.Amount := (MPESACharge) * -1;
                GenJournalLine.Validate(GenJournalLine.Amount);
                if GenJournalLine.Amount <> 0 then
                    GenJournalLine.Insert;
                //DR Excise Duty
                LineNo := LineNo + 10000;
                GenJournalLine.Init;
                GenJournalLine."Journal Template Name" := 'GENERAL';
                GenJournalLine."Journal Batch Name" := 'MPESAWITHD';
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                GenJournalLine."Account No." := Vendor."No.";
                GenJournalLine.Validate(GenJournalLine."Account No.");
                GenJournalLine."Document No." := docNo;
                GenJournalLine."External Document No." := Vendor."No.";
                GenJournalLine."Posting Date" := Today;
                GenJournalLine.Description := 'Excise Duty';
                GenJournalLine.Amount := ExcDuty;
                GenJournalLine.Validate(GenJournalLine.Amount);
                if GenJournalLine.Amount <> 0 then
                    GenJournalLine.Insert;

                //CR Excise Duty
                LineNo := LineNo + 10000;
                GenJournalLine.Init;
                GenJournalLine."Journal Template Name" := 'GENERAL';
                GenJournalLine."Journal Batch Name" := 'MPESAWITHD';
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                GenJournalLine."Account No." := Format(ExxcDuty);
                GenJournalLine.Validate(GenJournalLine."Account No.");
                GenJournalLine."Document No." := docNo;
                GenJournalLine."External Document No." := MobileChargesACC;
                GenJournalLine."Source No." := Vendor."No.";
                GenJournalLine."Posting Date" := Today;
                GenJournalLine.Description := 'Excise Duty';
                GenJournalLine.Amount := ExcDuty * -1;
                GenJournalLine.Validate(GenJournalLine.Amount);
                if GenJournalLine.Amount <> 0 then
                    GenJournalLine.Insert;

                //CR Mobile Transactions Acc
                LineNo := LineNo + 10000;
                GenJournalLine.Init;
                GenJournalLine."Journal Template Name" := 'GENERAL';
                GenJournalLine."Journal Batch Name" := 'MPESAWITHD';
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                GenJournalLine."Account No." := MobileChargesACC;
                GenJournalLine.Validate(GenJournalLine."Account No.");
                GenJournalLine."Document No." := docNo;
                GenJournalLine."External Document No." := MobileChargesACC;
                GenJournalLine."Source No." := Vendor."No.";
                GenJournalLine."Posting Date" := Today;
                GenJournalLine.Description := 'Mobile Charges';
                GenJournalLine.Amount := MobileCharges * -1;
                GenJournalLine.Validate(GenJournalLine.Amount);
                if GenJournalLine.Amount <> 0 then
                    GenJournalLine.Insert;

                //CR Surestep Acc
                LineNo := LineNo + 10000;
                GenJournalLine.Init;
                GenJournalLine."Journal Template Name" := 'GENERAL';
                GenJournalLine."Journal Batch Name" := 'MPESAWITHD';
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                GenJournalLine."Account No." := SurePESACommACC;
                GenJournalLine.Validate(GenJournalLine."Account No.");
                GenJournalLine."Document No." := docNo;
                GenJournalLine."External Document No." := MobileChargesACC;
                GenJournalLine."Source No." := Vendor."No.";
                GenJournalLine."Posting Date" := Today;
                GenJournalLine.Description := 'Mobile Charges';
                GenJournalLine.Amount := -SurePESACharge;
                GenJournalLine.Validate(GenJournalLine.Amount);
                if GenJournalLine.Amount <> 0 then
                    GenJournalLine.Insert;

                //Post
                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                GenJournalLine.SetRange("Journal Batch Name", 'MPESAWITHD');
                if GenJournalLine.Find('-') then begin
                    repeat
                    //   GLPosting.RUN(GenJournalLine);
                    until GenJournalLine.Next = 0;
                end;


                SurePESATrans.Init;
                SurePESATrans."Document No" := docNo;
                SurePESATrans.Description := 'MPESA Withdrawal';
                SurePESATrans."Document Date" := Today;
                SurePESATrans."Account No" := Vendor."No.";
                SurePESATrans."Account No2" := MPESARecon;
                SurePESATrans.Amount := amount;
                SurePESATrans.Status := SurePESATrans.Status::Completed;
                SurePESATrans.Posted := true;
                SurePESATrans."Posting Date" := Today;
                SurePESATrans.Comments := 'Success';
                SurePESATrans.Client := Vendor."BOSA Account No";
                SurePESATrans."Transaction Type" := SurePESATrans."transaction type"::Withdrawal;
                SurePESATrans."Transaction Time" := Time;
                SurePESATrans.Insert;
                result := 'TRUE';
                msg := 'You have withdrawn KES ' + Format(amount) + ' from Account ' + Vendor.Name + ' thank you for using NAFAKA Sacco Mobile.';
                SMSMessage(docNo, Vendor."No.", Vendor."Phone No.", msg);
            end
            else begin
                result := 'INSUFFICIENT';
                /* msg:='You have insufficient funds in your savings Account to use this service.'+
                ' .Thank you for using NAFAKA Sacco Mobile.';
                SMSMessage(docNo,Vendor."No.",Vendor."Phone No.",msg);*/
                SurePESATrans.Init;
                SurePESATrans."Document No" := docNo;
                SurePESATrans.Description := 'MPESA Withdrawal';
                SurePESATrans."Document Date" := Today;
                SurePESATrans."Account No" := Vendor."No.";
                SurePESATrans."Account No2" := MPESARecon;
                SurePESATrans.Amount := amount;
                SurePESATrans.Status := SurePESATrans.Status::Failed;
                SurePESATrans.Posted := false;
                SurePESATrans."Posting Date" := Today;
                SurePESATrans.Comments := 'Failed,Insufficient Funds';
                SurePESATrans.Client := Vendor."BOSA Account No";
                SurePESATrans."Transaction Type" := SurePESATrans."transaction type"::Withdrawal;
                SurePESATrans."Transaction Time" := Time;
                SurePESATrans.Insert;
            end;
        end
        else begin
            result := 'ACCINEXISTENT';
            /* msg:='Your request has failed because account does not exist.'+
             ' .Thank you for using NAFAKA Sacco Mobile.';
             SMSMessage(docNo,Vendor."No.",Vendor."Phone No.",msg);*/
            SurePESATrans.Init;
            SurePESATrans."Document No" := docNo;
            SurePESATrans.Description := 'MPESA Withdrawal';
            SurePESATrans."Document Date" := Today;
            SurePESATrans."Account No" := '';
            SurePESATrans."Account No2" := MPESARecon;
            SurePESATrans.Amount := amount;
            SurePESATrans.Posted := false;
            SurePESATrans."Posting Date" := Today;
            SurePESATrans.Comments := 'Failed,Invalid Account';
            SurePESATrans.Client := '';
            SurePESATrans."Transaction Type" := SurePESATrans."transaction type"::Withdrawal;
            SurePESATrans."Transaction Time" := Time;
            SurePESATrans.Insert;
        end;

    end;


    procedure AccountDescription("code": Text[20]) description: Text[100]
    begin
        begin
            AccountTypes.Reset;
            AccountTypes.SetRange(AccountTypes.Code, code);
            if AccountTypes.Find('-') then begin
                description := AccountTypes.Description;
            end
            else begin
                description := '';
            end
        end;
    end;


    procedure InsertTransaction("Document No": Code[30]; Keyword: Code[30]; "Account No": Code[30]; "Account Name": Text[100]; Telephone: Code[20]; Amount: Decimal; "Sacco Bal": Decimal) Result: Code[20]
    begin
        begin
            begin
                PaybillTrans.Init;
                PaybillTrans."Document No" := "Document No";
                PaybillTrans."Key Word" := Keyword;
                PaybillTrans."Account No" := "Account No";
                PaybillTrans."Account Name" := "Account Name";
                PaybillTrans."Transaction Date" := Today;
                PaybillTrans."Paybill Acc Balance" := "Sacco Bal";
                PaybillTrans."Transaction Time" := Today;
                PaybillTrans.Description := 'PayBill Deposit';
                PaybillTrans.Telephone := Telephone;
                PaybillTrans.Amount := Amount;
                PaybillTrans.Posted := false;
                PaybillTrans.Insert;
            end;
            PaybillTrans.Reset;
            PaybillTrans.SetRange(PaybillTrans."Document No", "Document No");
            if PaybillTrans.Find('-') then begin
                Result := 'TRUE';
            end
            else begin
                Result := 'FALSE';
            end;
        end;
    end;


    procedure PaybillSwitch() Result: Code[20]
    begin

        PaybillTrans.Reset;
        PaybillTrans.SetRange(PaybillTrans.Posted, false);
        PaybillTrans.SetRange(PaybillTrans."Needs Manual Posting", false);

        if PaybillTrans.Find('-') then begin
            Result := PayBillToAcc('PAYBILL', PaybillTrans."Document No", PaybillTrans."Account No", PaybillTrans."Account No", PaybillTrans.Amount, 'WSS');

            /*CASE PaybillTrans."Key Word" OF
              '033':
                 Result:=PayBillToAcc('PAYBILL',PaybillTrans."Document No",PaybillTrans."Account No",PaybillTrans."Account No",PaybillTrans.Amount,'BUSINESS');
              '060':
                 Result:=PayBillToAcc('PAYBILL',PaybillTrans."Document No",PaybillTrans."Account No",PaybillTrans."Account No",PaybillTrans.Amount,'CHURCH');
              '041':
                 Result:=PayBillToAcc('PAYBILL',PaybillTrans."Document No",PaybillTrans."Account No",PaybillTrans."Account No",PaybillTrans.Amount,'COFFEE');
              '036':
                 Result:=PayBillToAcc('PAYBILL',PaybillTrans."Document No",PaybillTrans."Account No",PaybillTrans."Account No",PaybillTrans.Amount,'NAFAKA JUNIOR');
              '038':
                 Result:=PayBillToAcc('PAYBILL',PaybillTrans."Document No",PaybillTrans."Account No",PaybillTrans."Account No",PaybillTrans.Amount,'SALIMIA');
              '030':
                 Result:=PayBillToAcc('PAYBILL',PaybillTrans."Document No",PaybillTrans."Account No",PaybillTrans."Account No",PaybillTrans.Amount,'ORDINARY SAVING');
              '030-330':
                 Result:=PayBillToAcc('PAYBILL',PaybillTrans."Document No",PaybillTrans."Account No",PaybillTrans."Account No",PaybillTrans.Amount,'STAFF');
              'HLD':
                 Result:=PayBillToAcc('PAYBILL',PaybillTrans."Document No",PaybillTrans."Account No",PaybillTrans."Account No",PaybillTrans.Amount,'HOLIDAY');
              'SHA':
                 Result:=PayBillToBOSA('PAYBILL',PaybillTrans."Document No",PaybillTrans."Account No",PaybillTrans."Account No",PaybillTrans.Amount,PaybillTrans."Key Word",'PayBill to Share Capital');
              'DEP':
                 Result:=PayBillToBOSA('PAYBILL',PaybillTrans."Document No",PaybillTrans."Account No",PaybillTrans."Account No",PaybillTrans.Amount,PaybillTrans."Key Word",'PayBill to Deposit');
              'BVF':
                 Result:=PayBillToBOSA('PAYBILL',PaybillTrans."Document No",PaybillTrans."Account No",PaybillTrans."Account No",PaybillTrans.Amount,PaybillTrans."Key Word",'PayBill to Benevolent Fund');
              'L01','L02','L02','L03','L04','L05','L06','L07','L08','L09','L10','L11','L12','L13','L14','L15','L16','L17','L18':
                 Result:=PayBillToLoan('PAYBILL',PaybillTrans."Document No",PaybillTrans."Account No",PaybillTrans."Account No",PaybillTrans.Amount,PaybillTrans."Key Word");
                 */

        end;
        if Result = '' then begin
            PaybillTrans."Date Posted" := Today;
            PaybillTrans."Needs Manual Posting" := true;
            PaybillTrans.Description := 'Failed';
            PaybillTrans.Modify;
        end;

    end;

    local procedure PayBillToAcc(batch: Code[20]; docNo: Code[20]; accNo: Code[20]; memberNo: Code[20]; Amount: Decimal; accountType: Code[30]) res: Code[10]
    begin
        GenLedgerSetup.Reset;
        GenLedgerSetup.Get;
        GenLedgerSetup.TestField(GenLedgerSetup."CloudPESA Charge");
        GenLedgerSetup.TestField(GenLedgerSetup."PayBill Settl Acc");
        PaybillRecon := GenLedgerSetup."PayBill Settl Acc";
        SurePESACharge := GetCharge(Amount, 'PAYBILL');
        SurePESACommACC := GenLedgerSetup."CloudPESA Comm Acc";
        ExcDuty := (10 / 100) * (SurePESACharge);

        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
        GenJournalLine.SetRange("Journal Batch Name", batch);
        GenJournalLine.DeleteAll;
        //end of deletion

        GenBatches.Reset;
        GenBatches.SetRange(GenBatches."Journal Template Name", 'GENERAL');
        GenBatches.SetRange(GenBatches.Name, batch);

        if GenBatches.Find('-') = false then begin
            GenBatches.Init;
            GenBatches."Journal Template Name" := 'GENERAL';
            GenBatches.Name := batch;
            GenBatches.Description := 'Paybill Deposit';
            GenBatches.Validate(GenBatches."Journal Template Name");
            GenBatches.Validate(GenBatches.Name);
            GenBatches.Insert;
        end;//General Jnr Batches

        //Members.RESET;
        //Members.SETRANGE(Members."No.", accNo);
        // IF Members.FIND('-') THEN BEGIN
        Vendor.Reset;
        Vendor.SetRange(Vendor."No.", accNo);
        //Vendor.SETRANGE(Vendor."Account Type", accountType);
        if Vendor.Find('-') then begin

            //Dr MPESA PAybill ACC
            LineNo := LineNo + 10000;
            GenJournalLine.Init;
            GenJournalLine."Journal Template Name" := 'GENERAL';
            GenJournalLine."Journal Batch Name" := batch;
            GenJournalLine."Line No." := LineNo;
            GenJournalLine."Account Type" := GenJournalLine."account type"::"Bank Account";
            GenJournalLine."Account No." := PaybillRecon;
            GenJournalLine.Validate(GenJournalLine."Account No.");
            GenJournalLine."Document No." := docNo;
            GenJournalLine."External Document No." := docNo;
            GenJournalLine."Source No." := Vendor."No.";
            GenJournalLine."Posting Date" := Today;
            GenJournalLine.Description := 'Paybill Deposit';
            GenJournalLine.Amount := Amount;
            GenJournalLine.Validate(GenJournalLine.Amount);
            if GenJournalLine.Amount <> 0 then
                GenJournalLine.Insert;

            //Cr Customer
            LineNo := LineNo + 10000;
            GenJournalLine.Init;
            GenJournalLine."Journal Template Name" := 'GENERAL';
            GenJournalLine."Journal Batch Name" := batch;
            GenJournalLine."Line No." := LineNo;
            GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
            GenJournalLine."Account No." := Vendor."No.";
            GenJournalLine.Validate(GenJournalLine."Account No.");
            GenJournalLine."Document No." := docNo;
            GenJournalLine."External Document No." := docNo;
            GenJournalLine."Posting Date" := Today;
            GenJournalLine.Description := 'Paybill Deposit';
            GenJournalLine.Amount := -1 * Amount;
            GenJournalLine.Validate(GenJournalLine.Amount);
            if GenJournalLine.Amount <> 0 then
                GenJournalLine.Insert;

            //Dr Customer charges
            LineNo := LineNo + 10000;
            GenJournalLine.Init;
            GenJournalLine."Journal Template Name" := 'GENERAL';
            GenJournalLine."Journal Batch Name" := batch;
            GenJournalLine."Line No." := LineNo;
            GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
            GenJournalLine."Account No." := Vendor."No.";
            GenJournalLine.Validate(GenJournalLine."Account No.");
            GenJournalLine."Document No." := docNo;
            GenJournalLine."External Document No." := docNo;
            GenJournalLine."Posting Date" := Today;
            GenJournalLine.Description := 'Paybill Deposit Charges';
            GenJournalLine.Amount := SurePESACharge;
            GenJournalLine.Validate(GenJournalLine.Amount);
            if GenJournalLine.Amount <> 0 then
                GenJournalLine.Insert;
            //DR Excise Duty
            LineNo := LineNo + 10000;
            GenJournalLine.Init;
            GenJournalLine."Journal Template Name" := 'GENERAL';
            GenJournalLine."Journal Batch Name" := batch;
            GenJournalLine."Line No." := LineNo;
            GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
            GenJournalLine."Account No." := Vendor."No.";
            GenJournalLine.Validate(GenJournalLine."Account No.");
            GenJournalLine."Document No." := docNo;
            GenJournalLine."External Document No." := docNo;
            GenJournalLine."Posting Date" := Today;
            GenJournalLine.Description := 'Excise duty-Paybill Deposit';
            GenJournalLine.Amount := ExcDuty;
            GenJournalLine.Validate(GenJournalLine.Amount);
            if GenJournalLine.Amount <> 0 then
                GenJournalLine.Insert;


            //CR Excise Duty
            LineNo := LineNo + 10000;
            GenJournalLine.Init;
            GenJournalLine."Journal Template Name" := 'GENERAL';
            GenJournalLine."Journal Batch Name" := batch;
            GenJournalLine."Line No." := LineNo;
            GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
            GenJournalLine."Account No." := Format(ExxcDuty);
            GenJournalLine.Validate(GenJournalLine."Account No.");
            GenJournalLine."Document No." := docNo;
            GenJournalLine."External Document No." := MobileChargesACC;
            GenJournalLine."Posting Date" := Today;
            GenJournalLine.Description := 'Excise duty-Paybill deposit';
            GenJournalLine.Amount := ExcDuty * -1;
            GenJournalLine.Validate(GenJournalLine.Amount);
            if GenJournalLine.Amount <> 0 then
                GenJournalLine.Insert;
            //CR Surestep Acc
            LineNo := LineNo + 10000;
            GenJournalLine.Init;
            GenJournalLine."Journal Template Name" := 'GENERAL';
            GenJournalLine."Journal Batch Name" := batch;
            GenJournalLine."Line No." := LineNo;
            GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
            GenJournalLine."Account No." := SurePESACommACC;
            GenJournalLine.Validate(GenJournalLine."Account No.");
            GenJournalLine."Document No." := docNo;
            GenJournalLine."Source No." := Vendor."No.";
            GenJournalLine."External Document No." := MobileChargesACC;
            GenJournalLine."Posting Date" := Today;
            GenJournalLine.Description := 'Mobile Deposit Charges';
            GenJournalLine.Amount := -SurePESACharge;
            GenJournalLine.Validate(GenJournalLine.Amount);
            if GenJournalLine.Amount <> 0 then
                GenJournalLine.Insert;
        end;
        //Vendor
        //END;//Member

        //Post
        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
        GenJournalLine.SetRange("Journal Batch Name", batch);
        if GenJournalLine.Find('-') then begin
            repeat
                GLPosting.Run(GenJournalLine);
            until GenJournalLine.Next = 0;
            PaybillTrans.Posted := true;
            PaybillTrans."Date Posted" := Today;
            PaybillTrans.Description := 'Posted';
            PaybillTrans.Modify;
            res := 'TRUE';
        end
        else begin
            PaybillTrans."Date Posted" := Today;
            PaybillTrans."Needs Manual Posting" := true;
            PaybillTrans.Description := 'Failed';
            PaybillTrans.Modify;
            res := 'FALSE';
        end;
    end;

    local procedure PayBillToBOSA(batch: Code[20]; docNo: Code[20]; accNo: Code[20]; memberNo: Code[20]; amount: Decimal; type: Code[30]; descr: Text[100]) res: Code[10]
    begin

        /* GenLedgerSetup.RESET;
         GenLedgerSetup.GET;
         GenLedgerSetup.TESTFIELD(GenLedgerSetup."CloudPESA Comm Account");
         GenLedgerSetup.TESTFIELD(GenLedgerSetup.PayBillAcc);
         GenLedgerSetup.TESTFIELD(GenLedgerSetup."CloudPESA Charge");

         SurePESACommACC:=  GenLedgerSetup."CloudPESA Comm Account";
         SurePESACharge:=GenLedgerSetup."CloudPESA Charge";
         PaybillRecon:=GenLedgerSetup.PayBillAcc;

         ExcDuty:=(10/100)*SurePESACharge;

         GenJournalLine.RESET;
         GenJournalLine.SETRANGE("Journal Template Name",'GENERAL');
         GenJournalLine.SETRANGE("Journal Batch Name",batch);
         GenJournalLine.DELETEALL;
         //end of deletion

         GenBatches.RESET;
         GenBatches.SETRANGE(GenBatches."Journal Template Name",'GENERAL');
         GenBatches.SETRANGE(GenBatches.Name,batch);

         IF GenBatches.FIND('-') = FALSE THEN BEGIN
           GenBatches.INIT;
           GenBatches."Journal Template Name":='GENERAL';
           GenBatches.Name:=batch;
           GenBatches.Description:=descr;
           GenBatches.VALIDATE(GenBatches."Journal Template Name");
           GenBatches.VALIDATE(GenBatches.Name);
           GenBatches.INSERT;
         END;//General Jnr Batches

           Members.RESET;
           Members.SETRANGE(Members."No.", accNo);
           IF Members.FIND('-') THEN BEGIN
           Vendor.RESET;
           Vendor.SETRANGE(Vendor."BOSA Account No", accNo);
           Vendor.SETRANGE(Vendor."Account Type", fosaConst);
             IF Vendor.FINDFIRST THEN BEGIN

             //Dr MPESA PAybill ACC
               LineNo:=LineNo+10000;
               GenJournalLine.INIT;
               GenJournalLine."Journal Template Name":='GENERAL';
               GenJournalLine."Journal Batch Name":=batch;
               GenJournalLine."Line No.":=LineNo;
               GenJournalLine."Account Type":=GenJournalLine."Account Type"::"G/L Account";
               GenJournalLine."Account No.":=PaybillRecon;
               GenJournalLine.VALIDATE(GenJournalLine."Account No.");
               GenJournalLine."Document No.":=docNo;
               GenJournalLine."External Document No.":=docNo;
               GenJournalLine."Posting Date":=TODAY;
               GenJournalLine.Description:=descr;
               GenJournalLine.Amount:=amount;
               GenJournalLine.VALIDATE(GenJournalLine.Amount);
               IF GenJournalLine.Amount<>0 THEN
               GenJournalLine.INSERT;

             //Cr Customer
               LineNo:=LineNo+10000;
               GenJournalLine.INIT;
               GenJournalLine."Journal Template Name":='GENERAL';
               GenJournalLine."Journal Batch Name":=batch;
               GenJournalLine."Line No.":=LineNo;
               GenJournalLine."Account Type":=GenJournalLine."Account Type"::Member;
               GenJournalLine."Account No.":=accNo;
               GenJournalLine.VALIDATE(GenJournalLine."Account No.");
               GenJournalLine."Document No.":=docNo;
               GenJournalLine."External Document No.":=docNo;
               GenJournalLine."Posting Date":=TODAY;
               CASE PaybillTrans."Key Word" OF 'DEP':
                   GenJournalLine."Transaction Type" := GenJournalLine."Transaction Type"::"Deposit Contribution";
               END;
               CASE PaybillTrans."Key Word" OF 'SHA':
                 GenJournalLine."Transaction Type" := GenJournalLine."Transaction Type"::"Shares Capital";
               END;
               CASE PaybillTrans."Key Word" OF 'BVF':
                 GenJournalLine."Transaction Type" := GenJournalLine."Transaction Type"::"Benevolent Fund";
               END;
               GenJournalLine."Shortcut Dimension 1 Code":='BOSA';
               GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
               GenJournalLine.Description:=descr;
               GenJournalLine.Amount:=(amount-SurePESACharge-ExcDuty)*-1;
               GenJournalLine.VALIDATE(GenJournalLine.Amount);
               IF GenJournalLine.Amount<>0 THEN
               GenJournalLine.INSERT;

               //CR Excise Duty
               LineNo:=LineNo+10000;
               GenJournalLine.INIT;
               GenJournalLine."Journal Template Name":='GENERAL';
               GenJournalLine."Journal Batch Name":=batch;
               GenJournalLine."Line No.":=LineNo;
               GenJournalLine."Account Type":=GenJournalLine."Account Type"::"G/L Account";
               GenJournalLine."Account No.":=FORMAT(ExxcDuty);
               GenJournalLine.VALIDATE(GenJournalLine."Account No.");
               GenJournalLine."Document No.":=docNo;
               GenJournalLine."External Document No.":=docNo;
               GenJournalLine."Posting Date":=TODAY;
               GenJournalLine.Description:='Excise duty-'+descr;
               GenJournalLine.Amount:=ExcDuty*-1;
               GenJournalLine.VALIDATE(GenJournalLine.Amount);
               IF GenJournalLine.Amount<>0 THEN
               GenJournalLine.INSERT;

               //CR Surestep Acc
               LineNo:=LineNo+10000;
               GenJournalLine.INIT;
               GenJournalLine."Journal Template Name":='GENERAL';
               GenJournalLine."Journal Batch Name":=batch;
               GenJournalLine."Line No.":=LineNo;
               GenJournalLine."Account Type":=GenJournalLine."Account Type"::Vendor;
               GenJournalLine."Account No.":=SurePESACommACC;
               GenJournalLine.VALIDATE(GenJournalLine."Account No.");
               GenJournalLine."Document No.":=docNo;
               GenJournalLine."External Document No.":=docNo;
               GenJournalLine."Posting Date":=TODAY;
               GenJournalLine.Description:=descr+' Charges';
               GenJournalLine.Amount:=-SurePESACharge;
               GenJournalLine.VALIDATE(GenJournalLine.Amount);
               IF GenJournalLine.Amount<>0 THEN
               GenJournalLine.INSERT;
                END;//Vendor
               END;//Member

               //Post
               GenJournalLine.RESET;
               GenJournalLine.SETRANGE("Journal Template Name",'GENERAL');
               GenJournalLine.SETRANGE("Journal Batch Name",batch);
               IF GenJournalLine.FIND('-') THEN BEGIN
               REPEAT
                 GLPosting.RUN(GenJournalLine);
               UNTIL GenJournalLine.NEXT = 0;
                 PaybillTrans.Posted:=TRUE;
                 PaybillTrans."Date Posted":=TODAY;
                 PaybillTrans.Description:='Posted';
                 PaybillTrans.MODIFY;
                 res:='TRUE';
               END
               ELSE BEGIN
                 PaybillTrans."Date Posted":=TODAY;
                 PaybillTrans."Needs Manual Posting":=TRUE;
                 PaybillTrans.Description:='Failed';
                 PaybillTrans.MODIFY;
                 res:='FALSE';
               END;*/

    end;

    local procedure PayBillToLoan(batch: Code[20]; docNo: Code[20]; accNo: Code[20]; memberNo: Code[20]; amount: Decimal; type: Code[30]) res: Code[10]
    begin
        /*GenLedgerSetup.RESET;
        GenLedgerSetup.GET;
        GenLedgerSetup.TESTFIELD(GenLedgerSetup."CloudPESA Comm Account");
        GenLedgerSetup.TESTFIELD(GenLedgerSetup.PayBillAcc);
        GenLedgerSetup.TESTFIELD(GenLedgerSetup."CloudPESA Charge");

        SurePESACommACC:=  GenLedgerSetup."CloudPESA Comm Account";
        SurePESACharge:=GenLedgerSetup."CloudPESA Charge";
        PaybillRecon:=GenLedgerSetup.PayBillAcc;

        ExcDuty:=(10/100)*SurePESACharge;

        GenJournalLine.RESET;
        GenJournalLine.SETRANGE("Journal Template Name",'GENERAL');
        GenJournalLine.SETRANGE("Journal Batch Name",batch);
        GenJournalLine.DELETEALL;
        //end of deletion

        GenBatches.RESET;
        GenBatches.SETRANGE(GenBatches."Journal Template Name",'GENERAL');
        GenBatches.SETRANGE(GenBatches.Name,batch);

        IF GenBatches.FIND('-') = FALSE THEN BEGIN
          GenBatches.INIT;
          GenBatches."Journal Template Name":='GENERAL';
          GenBatches.Name:=batch;
          GenBatches.Description:='Paybill Loan Repayment';
          GenBatches.VALIDATE(GenBatches."Journal Template Name");
          GenBatches.VALIDATE(GenBatches.Name);
          GenBatches.INSERT;
        END;//General Jnr Batches

          Members.RESET;
          Members.SETRANGE(Members."No.", accNo);
          IF Members.FIND('-') THEN BEGIN
          Vendor.RESET;
          Vendor.SETRANGE(Vendor."BOSA Account No", accNo);
          Vendor.SETRANGE(Vendor."Account Type", fosaConst);
            IF Vendor.FINDFIRST THEN BEGIN

              LoansRegister.RESET;
              LoansRegister.SETRANGE(LoansRegister."Loan Product Type",type);
              LoansRegister.SETRANGE(LoansRegister."Client Code",memberNo);

              IF LoansRegister.FIND('+') THEN BEGIN
              LoansRegister.CALCFIELDS(LoansRegister."Outstanding Balance",LoansRegister."Oustanding Interest");
             IF LoansRegister."Outstanding Balance" > 50 THEN BEGIN

            //Dr MPESA PAybill ACC
              LineNo:=LineNo+10000;
              GenJournalLine.INIT;
              GenJournalLine."Journal Template Name":='GENERAL';
              GenJournalLine."Journal Batch Name":=batch;
              GenJournalLine."Line No.":=LineNo;
              GenJournalLine."Account Type":=GenJournalLine."Account Type"::"G/L Account";
              GenJournalLine."Account No.":=PaybillRecon;
              GenJournalLine.VALIDATE(GenJournalLine."Account No.");
              GenJournalLine."Document No.":=docNo;
              GenJournalLine."External Document No.":=docNo;
              GenJournalLine."Posting Date":=TODAY;
              GenJournalLine.Description:='Paybill Loan Repayment';
              GenJournalLine.Amount:=amount;
              GenJournalLine.VALIDATE(GenJournalLine.Amount);
              IF GenJournalLine.Amount<>0 THEN
              GenJournalLine.INSERT;

              IF LoansRegister."Oustanding Interest">0 THEN BEGIN
              LineNo:=LineNo+10000;

              GenJournalLine.INIT;
              GenJournalLine."Journal Template Name":='GENERAL';
              GenJournalLine."Journal Batch Name":=batch;
              GenJournalLine."Line No.":=LineNo;
              GenJournalLine."Account Type":=GenJournalLine."Account Type"::Member;
              GenJournalLine."Account No.":=LoansRegister."Client Code";
              GenJournalLine.VALIDATE(GenJournalLine."Account No.");
              GenJournalLine."Document No.":=docNo;
              GenJournalLine."External Document No.":=docNo;
              GenJournalLine."Posting Date":=TODAY;
              GenJournalLine.Description:='Loan Interest Payment';
              END;

              IF amount > LoansRegister."Oustanding Interest" THEN
              GenJournalLine.Amount:=-LoansRegister."Oustanding Interest"
              ELSE
              GenJournalLine.Amount:=-amount;
              GenJournalLine.VALIDATE(GenJournalLine.Amount);
              GenJournalLine."Transaction Type":=GenJournalLine."Transaction Type"::"Interest Paid";

              IF GenJournalLine."Shortcut Dimension 1 Code" = '' THEN BEGIN
              GenJournalLine."Shortcut Dimension 1 Code":=Members."Global Dimension 1 Code";
              GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
              END;
              GenJournalLine."Loan No":=LoansRegister."Loan  No.";
              IF GenJournalLine.Amount<>0 THEN
              GenJournalLine.INSERT;

              amount:=amount+GenJournalLine.Amount;

              IF amount>0 THEN BEGIN
              LineNo:=LineNo+10000;

              GenJournalLine.INIT;
              GenJournalLine."Journal Template Name":='GENERAL';
              GenJournalLine."Journal Batch Name":=batch;
              GenJournalLine."Line No.":=LineNo;
              GenJournalLine."Account Type":=GenJournalLine."Account Type"::Member;
              GenJournalLine."Account No.":=LoansRegister."Client Code";
              GenJournalLine.VALIDATE(GenJournalLine."Account No.");
              GenJournalLine."Document No.":=docNo;
              GenJournalLine."External Document No.":='';
              GenJournalLine."Posting Date":=TODAY;
              GenJournalLine.Description:='Paybill Loan Repayment';
              GenJournalLine.Amount:=-amount;
              GenJournalLine.VALIDATE(GenJournalLine.Amount);
              GenJournalLine."Transaction Type":=GenJournalLine."Transaction Type"::Repayment;
              IF GenJournalLine."Shortcut Dimension 1 Code" = '' THEN BEGIN
              GenJournalLine."Shortcut Dimension 1 Code":=Members."Global Dimension 1 Code";
              GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
              END;
              GenJournalLine."Loan No":=LoansRegister."Loan  No.";
              IF GenJournalLine.Amount<>0 THEN
              GenJournalLine.INSERT;
              END;

              //DR Cust Acc
              LineNo:=LineNo+10000;
              GenJournalLine.INIT;
              GenJournalLine."Journal Template Name":='GENERAL';
              GenJournalLine."Journal Batch Name":=batch;
              GenJournalLine."Line No.":=LineNo;
              GenJournalLine."Account Type":=GenJournalLine."Account Type"::Vendor;
              GenJournalLine."Account No.":=Vendor."No.";
              GenJournalLine.VALIDATE(GenJournalLine."Account No.");
              GenJournalLine."Document No.":=docNo;
              GenJournalLine."External Document No.":=docNo;
              GenJournalLine."Posting Date":=TODAY;
              GenJournalLine.Description:='Paybill Loan Repayment';
              GenJournalLine.Amount:=SurePESACharge+ExcDuty;
              GenJournalLine.VALIDATE(GenJournalLine.Amount);
              IF GenJournalLine.Amount<>0 THEN
              GenJournalLine.INSERT;

              //CR Excise Duty
              LineNo:=LineNo+10000;
              GenJournalLine.INIT;
              GenJournalLine."Journal Template Name":='GENERAL';
              GenJournalLine."Journal Batch Name":=batch;
              GenJournalLine."Line No.":=LineNo;
              GenJournalLine."Account Type":=GenJournalLine."Account Type"::"G/L Account";
              GenJournalLine."Account No.":=FORMAT(ExxcDuty);
              GenJournalLine.VALIDATE(GenJournalLine."Account No.");
              GenJournalLine."Document No.":=docNo;
              GenJournalLine."External Document No.":=docNo;
              GenJournalLine."Posting Date":=TODAY;
              GenJournalLine.Description:='Excise duty-'+'Paybill Loan Repayment';
              GenJournalLine.Amount:=ExcDuty*-1;
              GenJournalLine.VALIDATE(GenJournalLine.Amount);
              IF GenJournalLine.Amount<>0 THEN
              GenJournalLine.INSERT;

              //CR Surestep Acc
              LineNo:=LineNo+10000;
              GenJournalLine.INIT;
              GenJournalLine."Journal Template Name":='GENERAL';
              GenJournalLine."Journal Batch Name":=batch;
              GenJournalLine."Line No.":=LineNo;
              GenJournalLine."Account Type":=GenJournalLine."Account Type"::Vendor;
              GenJournalLine."Account No.":=SurePESACommACC;
              GenJournalLine.VALIDATE(GenJournalLine."Account No.");
              GenJournalLine."Document No.":=docNo;
              GenJournalLine."External Document No.":=docNo;
              GenJournalLine."Posting Date":=TODAY;
              GenJournalLine.Description:='Paybill Loan Repayment'+' Charges';
              GenJournalLine.Amount:=-SurePESACharge;
              GenJournalLine.VALIDATE(GenJournalLine.Amount);
              IF GenJournalLine.Amount<>0 THEN
              GenJournalLine.INSERT;
                  END//Outstanding Balance
                 END//Loan Register
               END;//Vendor
              END;//Member

              //Post
              GenJournalLine.RESET;
              GenJournalLine.SETRANGE("Journal Template Name",'GENERAL');
              GenJournalLine.SETRANGE("Journal Batch Name",batch);
              IF GenJournalLine.FIND('-') THEN BEGIN
              REPEAT
                GLPosting.RUN(GenJournalLine);
              UNTIL GenJournalLine.NEXT = 0;
                PaybillTrans.Posted:=TRUE;
                PaybillTrans."Date Posted":=TODAY;
                PaybillTrans.Description:='Posted';
                PaybillTrans.MODIFY;
                res:='TRUE';
              END
              ELSE BEGIN
                PaybillTrans."Date Posted":=TODAY;
                PaybillTrans."Needs Manual Posting":=TRUE;
                PaybillTrans.Description:='Failed';
                PaybillTrans.MODIFY;
                res:='FALSE';
              END;
              */

    end;


    procedure Loancalculator() calcdetails: Text[1023]
    var
        varLoan: Text[1023];
        LoanProducttype: Record "Loan Products Setup";
    begin
        begin

            LoanProducttype.Reset;
            //LoanProducttype.GET();
            //LoanProducttype.SETRANGE(LoanProducttype.Code,'HOLIDAY');
            if LoanProducttype.Find('-') then begin
                //  LoanProducttype.CALCFIELDS(LoanProducttype."Interest rate",LoanProducttype."Max. Loan Amount",LoanProducttype."Min. Loan Amount");

                repeat
                    interestRate := LoanProducttype."Interest rate" DIV 1;
                    varLoan := varLoan + '::::' + Format(LoanProducttype."Product Description") + ':::' + Format(interestRate) + ':::' + Format(LoanProducttype."No of Installment") + ':::' + Format(LoanProducttype."Max. Loan Amount");

                until LoanProducttype.Next = 0;
                //MESSAGE('Loan Balance %1',loanbalances);
                calcdetails := varLoan;

            end;
        end;
    end;


    procedure SharesUSSD(phone: Text[20]; DocNo: Text[50]) shares: Text[1000]
    var
        normalshares: Text[50];
        sharecapital: Text[50];
    begin
        begin
            Vendor.Reset;
            Vendor.SetRange(Vendor."Phone No.", phone);
            if Vendor.Find('-') then begin
                MemberLedgerEntry.Reset;
                MemberLedgerEntry.SetRange(MemberLedgerEntry."Customer No.", Vendor."No.");
                MemberLedgerEntry.SetRange(MemberLedgerEntry."Transaction Type", MemberLedgerEntry."transaction type"::"Recovery Account");
                if MemberLedgerEntry.Find('-') then begin
                    repeat
                        amount := amount + MemberLedgerEntry.Amount;
                        sharecapital := Format(amount, 0, '<Precision,2:2><Integer><Decimals>');
                    until MemberLedgerEntry.Next = 0;
                end;

                MemberLedgerEntry.Reset;
                MemberLedgerEntry.SetRange(MemberLedgerEntry."Customer No.", Vendor."BOSA Account No");
                MemberLedgerEntry.SetRange(MemberLedgerEntry."Transaction Type", MemberLedgerEntry."transaction type"::Loan);

                if MemberLedgerEntry.Find('-') then begin
                    amount := 0;
                    repeat
                        amount := amount + MemberLedgerEntry.Amount;
                        normalshares := Format(amount, 0, '<Precision,2:2><Integer><Decimals>');
                    until MemberLedgerEntry.Next = 0;
                end;
                shares := 'Share Capital - KSH ' + sharecapital + ' , Normal Shares - KSH ' + normalshares;
                SMSMessage('MOBILETRAN', Vendor."No.", Vendor."Phone No.", shares);
                GenericCharges(Vendor."BOSA Account No", DocNo, 'CPSHARE', 'Shares Balance Request', SurePESATrans."transaction type"::Balance);
            end;
        end;
    end;


    procedure GenericCharges(BOSAACCNo: Code[30]; DocNo: Code[30]; TransCode: Code[30]; TransDesc: Text[50]; TransType: Option " ",Withdrawal,Deposit,Balance,Ministatement,Airtime,"Loan balance","Loan Status","Share Deposit Balance","Transfer to Fosa","Transfer to Bosa","Utility Payment","Loan Application","Standing orders") result: Text[250]
    var
        savingsAccount: Code[30];
        phoneNo: Code[30];
    begin
        begin
            SurePESATrans.Reset;
            SurePESATrans.SetRange(SurePESATrans."Document No", DocNo);
            if SurePESATrans.Find('-') then begin
                result := 'REFEXISTS';
            end
            else begin
                result := '';
                GenLedgerSetup.Reset;
                GenLedgerSetup.Get;
                GenLedgerSetup.TestField(GenLedgerSetup."CloudPESA Comm Acc");
                GenLedgerSetup.TestField(GenLedgerSetup."CloudPESA Charge");

                MobileCharges := GetmobileCharges(TransCode);
                MobileChargesACC := GetMobileGLAcc(TransCode);

                SurePESACommACC := GenLedgerSetup."CloudPESA Comm Acc";
                SurePESACharge := GenLedgerSetup."CloudPESA Charge";
                TotalCharges := SurePESACharge + MobileCharges;
                ExcDuty := (10 / 100) * (TotalCharges);

                Vendor.Reset;
                Vendor.SetRange(Vendor."BOSA Account No", BOSAACCNo);
                Vendor.SetRange(Vendor."Account Type", 'SAVINGS');
                if Vendor.Find('-') then begin

                    savingsAccount := Vendor."No.";
                    phoneNo := Vendor."Phone No.";

                    AccountTypes.Reset;
                    AccountTypes.SetRange(AccountTypes.Code, Vendor."Account Type");
                    if AccountTypes.Find('-') then begin
                        miniBalance := AccountTypes."Minimum Balance";
                    end;

                    Vendor.CalcFields(Vendor."Balance (LCY)");
                    Vendor.CalcFields(Vendor."ATM Transactions");
                    Vendor.CalcFields(Vendor."Uncleared Cheques");
                    Vendor.CalcFields(Vendor."EFT Transactions");
                    Vendor.CalcFields(Vendor."Mobile Transactions");

                    TempBalance := Vendor."Balance (LCY)" - (Vendor."ATM Transactions" + Vendor."Uncleared Cheques" + Vendor."EFT Transactions" + Vendor."Mobile Transactions");
                    TempBalance := TempBalance - miniBalance;
                    if (Vendor."Account Type" = 'SAVINGS')
                       then begin
                        if (TempBalance > TotalCharges + ExcDuty) then begin
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
                                GenBatches.Description := TransDesc;
                                GenBatches.Validate(GenBatches."Journal Template Name");
                                GenBatches.Validate(GenBatches.Name);
                                GenBatches.Insert;
                            end;

                            //Dr Mobile Charges
                            LineNo := LineNo + 10000;
                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name" := 'GENERAL';
                            GenJournalLine."Journal Batch Name" := 'MOBILETRAN';
                            GenJournalLine."Line No." := LineNo;
                            GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                            GenJournalLine."Account No." := savingsAccount;
                            GenJournalLine."Shortcut Dimension 1 Code" := DimensionFOSA;
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                            GenJournalLine."Shortcut Dimension 2 Code" := DimensionBRANCH;
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine."Document No." := DocNo;
                            GenJournalLine."External Document No." := savingsAccount;
                            GenJournalLine."Posting Date" := Today;
                            GenJournalLine.Description := TransDesc;
                            GenJournalLine.Amount := TotalCharges;
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            if GenJournalLine.Amount <> 0 then
                                GenJournalLine.Insert;

                            //DR Excise Duty
                            LineNo := LineNo + 10000;
                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name" := 'GENERAL';
                            GenJournalLine."Journal Batch Name" := 'MOBILETRAN';
                            GenJournalLine."Line No." := LineNo;
                            GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                            GenJournalLine."Account No." := savingsAccount;
                            GenJournalLine."Shortcut Dimension 1 Code" := DimensionFOSA;
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                            GenJournalLine."Shortcut Dimension 2 Code" := DimensionBRANCH;
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine."Document No." := DocNo;
                            GenJournalLine."External Document No." := savingsAccount;
                            GenJournalLine."Posting Date" := Today;
                            GenJournalLine.Description := 'Excise duty';
                            GenJournalLine.Amount := ExcDuty;
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            if GenJournalLine.Amount <> 0 then
                                GenJournalLine.Insert;

                            LineNo := LineNo + 10000;
                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name" := 'GENERAL';
                            GenJournalLine."Journal Batch Name" := 'MOBILETRAN';
                            GenJournalLine."Line No." := LineNo;
                            GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                            GenJournalLine."Account No." := ExxcDuty;
                            GenJournalLine."Shortcut Dimension 1 Code" := DimensionFOSA;
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                            GenJournalLine."Shortcut Dimension 2 Code" := DimensionBRANCH;
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine."Document No." := DocNo;
                            GenJournalLine."External Document No." := MobileChargesACC;
                            GenJournalLine."Posting Date" := Today;
                            GenJournalLine.Description := 'Excise duty';
                            GenJournalLine.Amount := ExcDuty * -1;
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            if GenJournalLine.Amount <> 0 then
                                GenJournalLine.Insert;

                            //CR Commission
                            LineNo := LineNo + 10000;
                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name" := 'GENERAL';
                            GenJournalLine."Journal Batch Name" := 'MOBILETRAN';
                            GenJournalLine."Line No." := LineNo;
                            GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                            GenJournalLine."Account No." := SurePESACommACC;
                            GenJournalLine."Shortcut Dimension 1 Code" := DimensionFOSA;
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                            GenJournalLine."Shortcut Dimension 2 Code" := DimensionBRANCH;
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine."Document No." := DocNo;
                            GenJournalLine."Source No." := Vendor."No.";
                            GenJournalLine."External Document No." := MobileChargesACC;
                            GenJournalLine."Posting Date" := Today;
                            GenJournalLine.Description := TransDesc + ' Charges';
                            GenJournalLine.Amount := -SurePESACharge;
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            if GenJournalLine.Amount <> 0 then
                                GenJournalLine.Insert;

                            //CR Mobile Transactions Acc
                            LineNo := LineNo + 10000;
                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name" := 'GENERAL';
                            GenJournalLine."Journal Batch Name" := 'MOBILETRAN';
                            GenJournalLine."Line No." := LineNo;
                            GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                            GenJournalLine."Account No." := MobileChargesACC;
                            GenJournalLine."Shortcut Dimension 1 Code" := DimensionFOSA;
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                            GenJournalLine."Shortcut Dimension 2 Code" := DimensionBRANCH;
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine."Document No." := DocNo;
                            GenJournalLine."Source No." := Vendor."No.";
                            GenJournalLine."External Document No." := MobileChargesACC;
                            GenJournalLine."Posting Date" := Today;
                            GenJournalLine.Description := TransDesc + ' Charges';
                            GenJournalLine.Amount := MobileCharges * -1;
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

                            SurePESATrans.Init;
                            SurePESATrans."Document No" := DocNo;
                            SurePESATrans.Description := TransDesc;
                            SurePESATrans."Document Date" := Today;
                            SurePESATrans."Account No" := Vendor."No.";
                            SurePESATrans."Account No2" := '';
                            SurePESATrans.Amount := amount;
                            SurePESATrans.Posted := true;
                            SurePESATrans."Posting Date" := Today;
                            SurePESATrans.Status := SurePESATrans.Status::Completed;
                            SurePESATrans.Comments := 'Success';
                            SurePESATrans.Client := Vendor."BOSA Account No";
                            SurePESATrans."Transaction Type" := TransType;
                            SurePESATrans."Transaction Time" := Time;
                            SurePESATrans.Insert;
                            result := 'TRUE';
                        end
                        else begin
                            result := 'INSUFFICIENT';
                        end;
                    end
                end
                else begin
                    result := 'ACCNOTFOUND';
                end;
            end;
        end;
    end;

    local procedure GetmobileCharges("code": Code[30]) charge: Decimal
    var
        MobileTariffs: Record "CloudPESA Mobile Tariffs";
    begin
        Charges.Reset;
        Charges.SetRange(Charges.Code, code);
        if Charges.Find('-') then begin
            charge := Charges."Charge Amount";
        end;
    end;

    local procedure GetMobileGLAcc("code": Code[30]) account: Code[30]
    begin
        Charges.Reset;
        Charges.SetRange(Charges.Code, code);
        if Charges.Find('-') then begin
            account := Charges."GL Account";
        end;
    end;


    procedure BOSAAccountACC(fosac: Text[20]) bosaAcc: Text[20]
    begin
        Vendor.Reset;
        Vendor.SetRange(Vendor."No.", fosac);
        if Vendor.Find('-') then begin
            Members.Reset;
            Members.SetRange(Members."No.", Vendor."BOSA Account No");
            if Members.Find('-') then begin
                bosaAcc := Members."No.";
            end;
        end;
    end;
}

