#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Report 50962 "Post Daily Loan Repayment"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("Loans Register"; "Loans Register")
        {
            DataItemTableView = where("Loan Status" = filter(<> Closed), "Loan Amount Due" = filter(> 0));
            RequestFilterFields = "Loan  No.", "Client Code";
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnAfterGetRecord()
            begin
                if ObjCust.Get("Client Code") then begin
                    if ObjCust.Blocked = ObjCust.Blocked::" " then begin
                        ObjGensetup.Get;
                        VarLoanAmountDue := 0;
                        VarLoanAmountDue := SFactory.FnRunLoanAmountDue("Loan  No.");
                        VarLoanAmountDue := ROUND(VarLoanAmountDue, 1, '>');

                        if VarLoanAmountDue > 0 then begin
                            BATCH_TEMPLATE := 'GENERAL';
                            BATCH_NAME := 'CREDIT';
                            DOCUMENT_NO := SFactory.FnRunGetNextTransactionDocumentNo;

                            ObjAccounts.Reset;
                            ObjAccounts.SetRange(ObjAccounts."BOSA Account No", "Client Code");
                            ObjAccounts.SetFilter(ObjAccounts.Status, '%1|%2', ObjAccounts.Status::Active, ObjAccounts.Status::Dormant);
                            ObjAccounts.SetRange(ObjAccounts.Blocked, ObjAccounts.Blocked::" ");
                            ObjAccounts.SetRange(ObjAccounts."Account Type", '507');
                            if ObjAccounts.FindSet then begin
                                AvailableBal := SFactory.FnRunGetAccountAvailableBalanceWithoutFreeze(ObjAccounts."No.", WorkDate);
                                VarLSAAccount := ObjAccounts."No.";
                                VarRuningBal := VarLoanAmountDue - AvailableBal;
                                if VarRuningBal > 0 then begin
                                    ObjAccounts.Reset;
                                    ObjAccounts.SetRange(ObjAccounts."No.", "Loan Recovery Account FOSA");
                                    ObjAccounts.SetRange(ObjAccounts.Blocked, ObjAccounts.Blocked::" ");
                                    if ObjAccounts.FindSet then begin
                                        VarAvailableBalRecoveryAccount := SFactory.FnRunGetAccountAvailableBalanceWithoutFreeze(ObjAccounts."No.", WorkDate);

                                        if VarAvailableBalRecoveryAccount > 0 then begin
                                            if VarAvailableBalRecoveryAccount > VarRuningBal then begin
                                                VarAmountDeducted := VarRuningBal
                                            end else
                                                VarAmountDeducted := VarAvailableBalRecoveryAccount;

                                            GenJournalLine.Reset;
                                            GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                                            GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                                            GenJournalLine.DeleteAll;

                                            //------------------------------------1. Debit FOSA Account---------------------------------------------------------------------------------------------

                                            LineNo := SFactory.FnRunGetNextJvLineNo(BATCH_TEMPLATE, BATCH_NAME);//LineNo+10000;
                                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                                            GenJournalLine."account type"::Vendor, "Loan Recovery Account FOSA", WorkDate, VarAmountDeducted, 'FOSA', '',
                                            'Loan Repayment Transfer - ' + "Loan  No." + ' ' + "Loan Product Type Name", '', GenJournalLine."application source"::CBS);

                                            //------------------------------------2. Credit LSA Account---------------------------------------------------------------------------------------------
                                            LineNo := SFactory.FnRunGetNextJvLineNo(BATCH_TEMPLATE, BATCH_NAME);//LineNo+10000;
                                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                                            GenJournalLine."account type"::Vendor, VarLSAAccount, WorkDate, VarAmountDeducted * -1, 'FOSA', '',
                                            'Loan Repayment Transfer From - ' + "Loan Recovery Account FOSA" + ' ' + ObjAccTypes.Description, '', GenJournalLine."application source"::CBS);
                                            //--------------------------------(Credit LSA Account)---------------------------------------------

                                            //CU posting
                                            GenJournalLine.Reset;
                                            GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                                            GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                                            if GenJournalLine.Find('-') then
                                                Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);

                                            VarRuningBal := VarRuningBal - VarAmountDeducted;
                                        end;
                                    end;
                                end;

                                if VarRuningBal > 0 then begin
                                    VarAvailableOtherFOSAAccounts := 0;
                                    ObjAccounts.Reset;
                                    ObjAccounts.SetRange(ObjAccounts."BOSA Account No", "Client Code");
                                    ObjAccounts.SetFilter(ObjAccounts."No.", '<>%1', VarLSAAccount);
                                    ObjAccounts.SetFilter(ObjAccounts.Status, '%1|%2', ObjAccounts.Status::Active, ObjAccounts.Status::Dormant);
                                    ObjAccounts.SetRange(ObjAccounts.Blocked, ObjAccounts.Blocked::" ");
                                    ObjAccounts.SetFilter(ObjAccounts."Account Type", '%1|%2|%3|%4|%5|%6|%7|%8|%9', '401', '402', '403', '404', '405', '406', '501', '508', '509', '507');
                                    if ObjAccounts.FindSet then begin
                                        repeat
                                            VarAvailableOtherFOSAAccounts := SFactory.FnRunGetAccountAvailableBalanceWithoutFreeze(ObjAccounts."No.", WorkDate);

                                            if VarAvailableOtherFOSAAccounts > 0 then begin
                                                if VarAvailableOtherFOSAAccounts > VarRuningBal then begin
                                                    VarAmountDeducted := VarRuningBal
                                                end else
                                                    VarAmountDeducted := VarAvailableOtherFOSAAccounts;

                                                GenJournalLine.Reset;
                                                GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                                                GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                                                GenJournalLine.DeleteAll;

                                                //------------------------------------1. Debit FOSA Account---------------------------------------------------------------------------------------------

                                                LineNo := SFactory.FnRunGetNextJvLineNo(BATCH_TEMPLATE, BATCH_NAME);//LineNo+10000;
                                                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                                                GenJournalLine."account type"::Vendor, ObjAccounts."No.", WorkDate, VarAmountDeducted, 'FOSA', '',
                                                'Loan Repayment Transfer - ' + "Loan  No." + ' ' + "Loan Product Type Name", '', GenJournalLine."application source"::CBS);

                                                //------------------------------------2. Credit LSA Account---------------------------------------------------------------------------------------------
                                                LineNo := SFactory.FnRunGetNextJvLineNo(BATCH_TEMPLATE, BATCH_NAME);//LineNo+10000;
                                                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                                                GenJournalLine."account type"::Vendor, VarLSAAccount, WorkDate, VarAmountDeducted * -1, 'FOSA', '',
                                                'Loan Repayment Transfer From - ' + ObjAccounts."No." + ' ' + ObjAccTypes.Description, '', GenJournalLine."application source"::CBS);
                                                //--------------------------------(Credit LSA Account)---------------------------------------------

                                                //CU posting
                                                GenJournalLine.Reset;
                                                GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                                                GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                                                if GenJournalLine.Find('-') then
                                                    Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);

                                                VarRuningBal := VarRuningBal - VarAmountDeducted;
                                            end;
                                        until ObjAccounts.Next = 0;
                                    end;
                                end;


                                ObjAccounts.Reset;
                                ObjAccounts.SetRange(ObjAccounts."BOSA Account No", "Client Code");
                                ObjAccounts.SetFilter(ObjAccounts.Status, '%1|%2', ObjAccounts.Status::Active, ObjAccounts.Status::Dormant);
                                ObjAccounts.SetRange(ObjAccounts.Blocked, ObjAccounts.Blocked::" ");
                                ObjAccounts.SetRange(ObjAccounts."Account Type", '507');
                                if ObjAccounts.FindSet then begin
                                    AvailableBal := SFactory.FnRunGetAccountAvailableBalanceWithoutFreeze(ObjAccounts."No.", WorkDate);
                                    VarLSAAccount := ObjAccounts."No.";
                                end;

                                VarDebtCollectorFee := SFactory.FnRunGetLoanDebtCollectorFee("Loan  No.", AvailableBal);
                                if AvailableBal > (VarLoanAmountDue + VarDebtCollectorFee) then begin
                                    VarAmouttoRecover := (VarLoanAmountDue + VarDebtCollectorFee)
                                end else
                                    VarAmouttoRecover := AvailableBal;

                                GenJournalLine.Reset;
                                GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                                GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                                GenJournalLine.DeleteAll;

                                SFactory.FnCreateLoanRecoveryJournals("Loan  No.", BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, "Client Code", WorkDate,
                                "Loan  No.", ObjAccounts."No.", "Client Name", VarAmouttoRecover);


                                //CU posting
                                GenJournalLine.Reset;
                                GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                                GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                                if GenJournalLine.Find('-') then
                                    Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);

                                if WorkDate = CalcDate('CM', WorkDate) then
                                    SFactory.FnRunLoanAmountDue(ObjLoans."Loan  No.");
                            end;
                        end;
                    end;
                end;
            end;

            trigger OnPostDataItem()
            begin
                SFactory.FnRunPostExcessRepaymentFundsDaily();
                FnRunMarkClearedLoansClosed();
                SFactory.FnRunAutoUnFreezeMemberLoanDueAmount();//====================================================Unfreeze Frozen Amounts
                SFactory.FnRunAutoFreezeMemberLoanDueAmount();//======================================================Freeze Member Loan Due Amounts
                if WorkDate = CalcDate('CM', WorkDate) then
                    FnRecoverSmallArrearsFromBOSADeposits() //======================================================Recover Arrears Less than 1000 from BOSA at EOM
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
        ObjRepamentSchedule: Record "Loan Repayment Schedule";
        ObjAccounts: Record Vendor;
        ObjAccTypes: Record "Account Types-Saving Products";
        AvailableBal: Decimal;
        VarPrincipalRepayment: Decimal;
        VarTotalRepaymentDue: Decimal;
        VarInsuranceAmountDed: Decimal;
        VarInterestAmountDed: Decimal;
        VarPrincipleAmountDed: Decimal;
        ObjLoans: Record "Loans Register";
        ObjExcessRepaymentProducts: Record "Excess Repayment Rules Product";
        VarExcessRuleType: Option " ","Exempt From Excess Rule","Biggest Loan","Smallest Loan","Oldest Loan","Newest Loan";
        ObjExcessRule: Record "Excess Repayment Rules";
        VarNoofLoansCount: Integer;
        VarLoanAmountDue: Decimal;
        VarAvailableBalRecoveryAccount: Decimal;
        VarRuningBal: Decimal;
        VarAmountDeducted: Decimal;
        VarLSAAccount: Code[30];
        VarAvailableOtherFOSAAccounts: Decimal;
        VarAmouttoRecover: Decimal;
        VarDebtCollectorFee: Decimal;
        ObjCust: Record Customer;
        VarAmountInArrears: Decimal;
        ObjSurestep: Codeunit "SURESTEP Factory";
        ObjDemands: Record "Default Notices Register";
        ObjSaccoNoSeries: Record "Sacco No. Series";
        VarDocumentNo: Code[20];
        ObjNoSeriesMgt: Codeunit NoSeriesManagement;
        ObjLSchedule: Record "Loan Repayment Schedule";
        VarScheduleDate: Date;
        SurestpFactory: Codeunit "SURESTEP Factory";
        VarMobileNo: Code[30];
        VarSmsBody: Text[250];
        ObjLoanTypes: Record "Loan Products Setup";
        VarHsLeaderMobile: Code[20];
        VarAssHsLeaderMobile: Code[20];
        ObjHouse: Record "Member House Groups";
        ObjLoansGuarantors: Record "Loans Guarantee Details";
        SMSScheduledOn: DateTime;
        ObjMemberLedger: Record "Member Ledger Entry";

    local procedure FnRunMarkClearedLoansClosed()
    begin
        ObjLoans.CalcFields(ObjLoans."Outstanding Balance");
        ObjLoans.Reset;
        ObjLoans.SetRange(ObjLoans."Loan Status", ObjLoans."loan status"::Disbursed);
        //ObjLoans.SETRANGE(ObjLoans.Closed,FALSE);
        ObjLoans.SetFilter(ObjLoans."Outstanding Balance", '>%1&<%2', -1, 1);
        if ObjLoans.FindSet then begin
            repeat
                ObjMemberLedger.Reset;
                ObjMemberLedger.SetRange(ObjMemberLedger."Loan No", ObjLoans."Loan  No.");
                if ObjMemberLedger.FindSet then begin
                    ObjLoans.Closed := true;
                    ObjLoans."Loan Status" := ObjLoans."loan status"::Closed;
                    ObjLoans."Closed By" := UserId;
                    ObjLoans."Closed On" := WorkDate;
                    ObjLoans.Modify;
                end;
            until ObjLoans.Next = 0;
        end;
    end;

    local procedure FnRecoverSmallArrearsFromBOSADeposits()
    var
        ObjBOSARefundLedger: Record "BOSA Account Refund Ledger";
        EntryNo: Integer;
    begin
        ObjLoans.Reset;
        ObjLoans.SetRange(ObjLoans."Loan Amount Due", 0.01, 1000.0);
        ObjLoans.SetRange(ObjLoans.Closed, false);
        ObjLoans.SetRange(ObjLoans."Loan Status", ObjLoans."loan status"::Disbursed);
        if ObjLoans.FindSet then begin
            repeat
                if ObjCust.Get(ObjLoans."Client Code") then begin
                    if ObjCust.Blocked = ObjCust.Blocked::" " then begin
                        ObjGensetup.Get;
                        VarLoanAmountDue := ObjLoans."Loan Amount Due";

                        if VarLoanAmountDue > 0 then begin
                            BATCH_TEMPLATE := 'GENERAL';
                            BATCH_NAME := 'CREDIT';
                            DOCUMENT_NO := SFactory.FnRunGetNextTransactionDocumentNo;

                            ObjAccounts.Reset;
                            ObjAccounts.SetRange(ObjAccounts."BOSA Account No", ObjLoans."Client Code");
                            ObjAccounts.SetFilter(ObjAccounts.Status, '%1|%2', ObjAccounts.Status::Active, ObjAccounts.Status::Dormant);
                            ObjAccounts.SetRange(ObjAccounts.Blocked, ObjAccounts.Blocked::" ");
                            ObjAccounts.SetFilter(ObjAccounts."Account Type", '%1|%2', '602', '603');
                            if ObjAccounts.FindSet then begin
                                AvailableBal := SFactory.FnRunGetAccountAvailableBalanceWithoutFreeze(ObjAccounts."No.", WorkDate);

                                if AvailableBal > VarLoanAmountDue then begin
                                    VarAmouttoRecover := VarLoanAmountDue
                                end else
                                    VarAmouttoRecover := AvailableBal;

                                VarDebtCollectorFee := SFactory.FnRunGetLoanDebtCollectorFee(ObjLoans."Loan  No.", VarAmouttoRecover);
                                if AvailableBal > (VarAmouttoRecover + VarDebtCollectorFee) then begin
                                    VarAmouttoRecover := (VarLoanAmountDue + VarDebtCollectorFee)
                                end else
                                    VarAmouttoRecover := AvailableBal;

                                GenJournalLine.Reset;
                                GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                                GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                                GenJournalLine.DeleteAll;

                                SFactory.FnCreateLoanRecoveryJournals(ObjLoans."Loan  No.", BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, ObjLoans."Client Code", WorkDate,
                                ObjLoans."Loan  No.", ObjAccounts."No.", ObjLoans."Client Name", VarAmouttoRecover);


                                //CU posting
                                GenJournalLine.Reset;
                                GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                                GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                                if GenJournalLine.Find('-') then
                                    Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);

                                //=========CREATE BOSA RECOVERY REFUND LEDGER============
                                ObjBOSARefundLedger.Reset;
                                if ObjBOSARefundLedger.FindLast then begin
                                    EntryNo := ObjBOSARefundLedger."Entry No.";
                                end;

                                EntryNo := EntryNo + 1;

                                ObjBOSARefundLedger.Init;
                                ObjBOSARefundLedger."Entry No." := EntryNo;
                                ObjBOSARefundLedger."Account No Recovered" := ObjAccounts."No.";
                                ObjBOSARefundLedger."Account Name" := ObjAccounts.Name;
                                ObjBOSARefundLedger."Posting Date" := WorkDate;
                                ObjBOSARefundLedger."Document No." := DOCUMENT_NO;
                                ObjBOSARefundLedger."Member No" := ObjLoans."Client Code";
                                ObjBOSARefundLedger."Member Name" := ObjLoans."Client Name";
                                ObjBOSARefundLedger."Amount Deducted" := VarAmouttoRecover;
                                ObjBOSARefundLedger.Insert;
                            end;
                        end;
                    end;
                end;
            until ObjLoans.Next = 0;
        end;
    end;
}

