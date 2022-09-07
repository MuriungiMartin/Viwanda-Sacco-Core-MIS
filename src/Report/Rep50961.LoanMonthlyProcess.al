#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Report 50961 "Loan Monthly Process"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(Vendor; Vendor)
        {
            DataItemTableView = where("Account Type" = filter(507 | 508), Status = filter(<> Closed | Deceased), Blocked = filter(" "), Balance = filter(> 1));
            RequestFilterFields = "No.", "BOSA Account No";
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnAfterGetRecord()
            begin
                if WorkDate = CalcDate('CM', WorkDate) then begin
                    FnRunPostExcessLSAFundsMonthly("No.", "BOSA Account No");
                    FnRunPostExcessUfalmeFundsMonthly("No.", "BOSA Account No");
                end;
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
        VarLoantoOverpay: Code[30];
        VarBiggestAmount: Decimal;
        VarSmallestAmount: Decimal;
        ObjLoansII: Record "Loans Register";
        ObjLoansIII: Record "Loans Register";
        ObjLoansIV: Record "Loans Register";
        ObjLoansV: Record "Loans Register";
        VarAmounttoRepay: Decimal;
        RunningBal: Decimal;
        VarOutstandingInsurance: Decimal;
        VarInsuranceForRemainingPeriodII: Decimal;
        VarRecoveryAccountBal: Decimal;
        VarAccountBalBackDated: Decimal;
        VarCurrAccountBal: Decimal;

    local procedure FnRunPostExcessLSAFundsMonthly(VarAccountNo: Code[30]; VarMemberNo: Code[30])
    begin
        BATCH_TEMPLATE := 'PAYMENTS';
        BATCH_NAME := 'LOANS';
        DOCUMENT_NO := SFactory.FnRunGetNextTransactionDocumentNo;

        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
        GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
        GenJournalLine.DeleteAll;



        ObjAccounts.Reset;
        ObjAccounts.SetRange(ObjAccounts."No.", VarAccountNo);
        ObjAccounts.SetRange(ObjAccounts."Account Type", '507');
        if ObjAccounts.FindSet then begin
            ObjAccounts.CalcFields(ObjAccounts.Balance, ObjAccounts."Uncleared Cheques");
            AvailableBal := (ObjAccounts.Balance - ObjAccounts."Uncleared Cheques");

            ObjAccTypes.Reset;
            ObjAccTypes.SetRange(ObjAccTypes.Code, ObjAccounts."Account Type");
            if ObjAccTypes.Find('-') then
                AvailableBal := AvailableBal - ObjAccTypes."Minimum Balance";

            //VarCurrAccountBal:=SFactory.FnRunGetAccountAvailableBalance(ObjAccounts."No.");
            //VarAccountBalBackDated:=SFactory.FnRunGetAccountAvailableBalanceWithoutFreeze(ObjAccounts."No.",20183011D);
            //IF  VarCurrAccountBal>=VarAccountBalBackDated THEN
            if (AvailableBal > 0) and (ObjAccounts."Excess Repayment Rule" <> ObjAccounts."excess repayment rule"::"Exempt From Excess Rule") then begin

                VarExcessRuleType := ObjAccounts."Excess Repayment Rule";
                if VarExcessRuleType = Varexcessruletype::" " then begin
                    ObjExcessRule.Reset;
                    ObjExcessRule.SetRange(ObjExcessRule."Account Type Affected", ObjAccounts."Account Type");
                    if ObjExcessRule.FindSet then begin
                        VarExcessRuleType := ObjExcessRule."Loan Recovery Priority";
                    end;
                end;

                RunningBal := AvailableBal;
                VarRecoveryAccountBal := AvailableBal;
                ObjLoansII.Reset;
                ObjLoansII.SetCurrentkey(ObjLoansII."Issued Date");
                ObjLoansII.SetRange(ObjLoansII."Client Code", VarMemberNo);
                ObjLoansII.SetRange(ObjLoansII."Excess LSA Recovery", true);
                ObjLoansII.SetFilter(ObjLoansII."Outstanding Balance", '>%1', 1);
                if ObjLoansII.FindSet then begin
                    repeat
                        if RunningBal > 0 then begin

                            //=========================================================================Excess to Oldest Loan

                            if VarExcessRuleType = Varexcessruletype::"Oldest Loan" then begin
                                ObjLoans.CalcFields(ObjLoans."Outstanding Balance");

                                ObjLoans.Reset;
                                ObjLoans.SetCurrentkey(ObjLoans."Issued Date");
                                ObjLoans.SetRange(ObjLoans."Client Code", VarMemberNo);
                                ObjLoans.SetRange(ObjLoans."Excess LSA Recovery", true);
                                ObjLoans.SetFilter(ObjLoans."Outstanding Balance", '>%1', 1);
                                if ObjLoans.FindFirst then begin
                                    ObjLoans.CalcFields(ObjLoans."Outstanding Balance");
                                    VarLoantoOverpay := ObjLoans."Loan  No.";

                                    RunningBal := SFactory.FnRunCreateDebtCollectorFeeJournals(VarLoantoOverpay, BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, VarMemberNo, WorkDate,
                                    VarLoantoOverpay, ObjAccounts."No.", RunningBal, LineNo);

                                    if RunningBal > ObjLoans."Outstanding Balance" then begin
                                        FnRunChargeInsuranceForRemainingPeriod(VarLoantoOverpay);//==============================Charge Insurance for the Remaining Period

                                        VarAmounttoRepay := ObjLoans."Outstanding Balance"
                                    end else
                                        VarAmounttoRepay := RunningBal;

                                    //------------------------------------1. Debit LSA Account---------------------------------------------------------------------------------------------
                                    LineNo := LineNo + 10000;
                                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                                    GenJournalLine."account type"::Vendor, ObjAccounts."No.", WorkDate, VarAmounttoRepay, 'FOSA', '',
                                    'Excess Principal Paid from ' + ObjAccounts."No." + ' to ' + ObjLoans."Loan Product Type Name", '', GenJournalLine."application source"::CBS);

                                    //------------------------------------2. Credit Loan Account---------------------------------------------------------------------------------------------
                                    LineNo := LineNo + 10000;
                                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Repayment",
                                    GenJournalLine."account type"::None, VarMemberNo, WorkDate, VarAmounttoRepay * -1, 'FOSA', '',
                                    'Excess Principal Paid from ' + ObjAccounts."No." + ' to ' + ObjLoans."Loan Product Type Name", VarLoantoOverpay, GenJournalLine."application source"::CBS);
                                    //--------------------------------(Credit Loan Account)-----------------------------------------

                                    RunningBal := RunningBal - VarAmounttoRepay;

                                    if (ObjLoans."Outstanding Balance" - VarAmounttoRepay) = 0 then begin
                                        FnRunPostInsuranceRecovery(VarLoantoOverpay, RunningBal, VarMemberNo, ObjAccounts."No.");
                                        VarInsuranceForRemainingPeriodII := FnRunGetInsuranceForRemainingPeriod(VarLoantoOverpay);
                                        RunningBal := RunningBal - VarInsuranceForRemainingPeriodII;
                                    end;

                                end;
                            end;


                            //=========================================================================Excess to Newest Loan
                            if VarExcessRuleType = Varexcessruletype::"Newest Loan" then begin
                                ObjLoans.CalcFields(ObjLoans."Outstanding Balance");

                                ObjLoans.Reset;
                                ObjLoans.SetCurrentkey(ObjLoans."Issued Date");
                                ObjLoans.SetRange(ObjLoans."Client Code", VarMemberNo);
                                ObjLoans.SetRange(ObjLoans."Excess LSA Recovery", true);
                                ObjLoans.SetFilter(ObjLoans."Outstanding Balance", '>%1', 1);
                                if ObjLoans.FindLast then begin
                                    ObjLoans.CalcFields(ObjLoans."Outstanding Balance");
                                    VarLoantoOverpay := ObjLoans."Loan  No.";

                                    RunningBal := SFactory.FnRunCreateDebtCollectorFeeJournals(VarLoantoOverpay, BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, VarMemberNo, WorkDate,
                                    VarLoantoOverpay, ObjAccounts."No.", RunningBal, LineNo);

                                    if RunningBal > ObjLoans."Outstanding Balance" then begin
                                        FnRunChargeInsuranceForRemainingPeriod(VarLoantoOverpay);//==============================Charge Insurance for the Remaining Period
                                        VarAmounttoRepay := ObjLoans."Outstanding Balance"
                                    end else
                                        VarAmounttoRepay := RunningBal;

                                    //------------------------------------1. Debit LSA Account---------------------------------------------------------------------------------------------
                                    LineNo := LineNo + 10000;
                                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                                    GenJournalLine."account type"::Vendor, ObjAccounts."No.", WorkDate, VarAmounttoRepay, 'FOSA', '',
                                    'Excess Principal Paid from ' + ObjAccounts."No." + ' to ' + ObjLoans."Loan Product Type Name", '', GenJournalLine."application source"::CBS);

                                    //------------------------------------2. Credit Loan Account---------------------------------------------------------------------------------------------
                                    LineNo := LineNo + 10000;
                                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Repayment",
                                    GenJournalLine."account type"::None, VarMemberNo, WorkDate, VarAmounttoRepay * -1, 'FOSA', '',
                                    'Excess Principal Paid from ' + ObjAccounts."No." + ' to ' + ObjLoans."Loan Product Type Name", VarLoantoOverpay, GenJournalLine."application source"::CBS);
                                    //--------------------------------(Credit Loan Account)---------------------------------------------

                                    RunningBal := RunningBal - VarAmounttoRepay;

                                    if (ObjLoans."Outstanding Balance" - VarAmounttoRepay) = 0 then begin
                                        FnRunPostInsuranceRecovery(VarLoantoOverpay, RunningBal, VarMemberNo, ObjAccounts."No.");
                                        VarInsuranceForRemainingPeriodII := FnRunGetInsuranceForRemainingPeriod(VarLoantoOverpay);
                                        RunningBal := RunningBal - VarInsuranceForRemainingPeriodII;
                                    end;
                                end;
                            end;
                            //=========================================================================Excess to  Biggest Loan
                            if VarExcessRuleType = Varexcessruletype::"Biggest Loan" then begin
                                ObjLoans.CalcFields(ObjLoans."Outstanding Balance");

                                ObjLoans.Reset;
                                ObjLoans.SetCurrentkey(ObjLoans."Outstanding Balance");
                                ObjLoans.SetRange(ObjLoans."Client Code", VarMemberNo);
                                ObjLoans.SetRange(ObjLoans."Excess LSA Recovery", true);
                                ObjLoans.SetFilter(ObjLoans."Outstanding Balance", '>%1', 1);
                                if ObjLoans.FindLast then begin
                                    ObjLoans.CalcFields(ObjLoans."Outstanding Balance");
                                    VarLoantoOverpay := ObjLoans."Loan  No.";

                                    RunningBal := SFactory.FnRunCreateDebtCollectorFeeJournals(VarLoantoOverpay, BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, VarMemberNo, WorkDate,
                                    VarLoantoOverpay, ObjAccounts."No.", RunningBal, LineNo);

                                    if RunningBal > ObjLoans."Outstanding Balance" then begin
                                        FnRunChargeInsuranceForRemainingPeriod(VarLoantoOverpay);//==============================Charge Insurance for the Remaining Period
                                        VarAmounttoRepay := ObjLoans."Outstanding Balance"
                                    end else
                                        VarAmounttoRepay := RunningBal;

                                    //------------------------------------1. Debit LSA Account---------------------------------------------------------------------------------------------
                                    LineNo := LineNo + 10000;
                                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                                    GenJournalLine."account type"::Vendor, ObjAccounts."No.", WorkDate, VarAmounttoRepay, 'FOSA', '',
                                    'Excess Principal Paid from ' + ObjAccounts."No." + ' to ' + ObjLoans."Loan Product Type Name", '', GenJournalLine."application source"::CBS);

                                    //------------------------------------2. Credit Loan Account---------------------------------------------------------------------------------------------
                                    LineNo := LineNo + 10000;
                                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Repayment",
                                    GenJournalLine."account type"::None, VarMemberNo, WorkDate, VarAmounttoRepay * -1, 'FOSA', '',
                                    'Excess Principal Paid from ' + ObjAccounts."No." + ' to ' + ObjLoans."Loan Product Type Name", VarLoantoOverpay, GenJournalLine."application source"::CBS);
                                    //--------------------------------(Credit Loan Account)---------------------------------------------
                                    RunningBal := RunningBal - VarAmounttoRepay;

                                    if (ObjLoans."Outstanding Balance" - VarAmounttoRepay) = 0 then begin
                                        FnRunPostInsuranceRecovery(VarLoantoOverpay, RunningBal, VarMemberNo, ObjAccounts."No.");
                                        VarInsuranceForRemainingPeriodII := FnRunGetInsuranceForRemainingPeriod(VarLoantoOverpay);
                                        RunningBal := RunningBal - VarInsuranceForRemainingPeriodII;
                                    end;
                                end;
                            end;

                            //=========================================================================Excess to  Smallest Loan
                            if VarExcessRuleType = Varexcessruletype::"Smallest Loan" then begin
                                ObjLoans.CalcFields(ObjLoans."Outstanding Balance");

                                ObjLoans.Reset;
                                ObjLoans.SetCurrentkey(ObjLoans."Outstanding Balance");
                                ObjLoans.SetRange(ObjLoans."Client Code", VarMemberNo);
                                ObjLoans.SetRange(ObjLoans."Excess LSA Recovery", true);
                                ObjLoans.SetFilter(ObjLoans."Outstanding Balance", '>%1', 1);
                                if ObjLoans.FindFirst then begin
                                    ObjLoans.CalcFields(ObjLoans."Outstanding Balance");

                                    VarLoantoOverpay := ObjLoans."Loan  No.";
                                    RunningBal := SFactory.FnRunCreateDebtCollectorFeeJournals(VarLoantoOverpay, BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, VarMemberNo, WorkDate,
                                      VarLoantoOverpay, ObjAccounts."No.", RunningBal, LineNo);

                                    if RunningBal > ObjLoans."Outstanding Balance" then begin
                                        FnRunChargeInsuranceForRemainingPeriod(VarLoantoOverpay);//==============================Charge Insurance for the Remaining Period
                                        VarAmounttoRepay := ObjLoans."Outstanding Balance"
                                    end else
                                        VarAmounttoRepay := RunningBal;


                                    //------------------------------------1. Debit LSA Account---------------------------------------------------------------------------------------------
                                    LineNo := LineNo + 10000;
                                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                                    GenJournalLine."account type"::Vendor, ObjAccounts."No.", WorkDate, VarAmounttoRepay, 'FOSA', '',
                                    'Excess Principal Paid from ' + ObjAccounts."No." + ' to ' + ObjLoans."Loan Product Type Name", '', GenJournalLine."application source"::CBS);
                                    //MESSAGE(FORMAT(RunningBal));
                                    //------------------------------------2. Credit Loan Account---------------------------------------------------------------------------------------------
                                    LineNo := LineNo + 10000;
                                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Repayment",
                                    GenJournalLine."account type"::None, VarMemberNo, WorkDate, VarAmounttoRepay * -1, 'FOSA', '',
                                    'Excess Principal Paid from ' + ObjAccounts."No." + ' to ' + ObjLoans."Loan Product Type Name", VarLoantoOverpay, GenJournalLine."application source"::CBS);
                                    //--------------------------------(Credit Loan Account)---------------------------------------------
                                    RunningBal := RunningBal - VarAmounttoRepay;

                                    if (ObjLoans."Outstanding Balance" - VarAmounttoRepay) = 0 then begin
                                        FnRunPostInsuranceRecovery(VarLoantoOverpay, RunningBal, VarMemberNo, ObjAccounts."No.");
                                        VarInsuranceForRemainingPeriodII := FnRunGetInsuranceForRemainingPeriod(VarLoantoOverpay);
                                        RunningBal := RunningBal - VarInsuranceForRemainingPeriodII;
                                    end;
                                end;
                            end;

                            //CU posting
                            GenJournalLine.Reset;
                            GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                            GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                            if GenJournalLine.Find('-') then
                                Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
                        end;
                    until ObjLoansII.Next = 0;
                end;
            end;
        end;
    end;

    local procedure FnRunPostExcessUfalmeFundsMonthly(VarAccountNo: Code[30]; VarMemberNo: Code[30])
    begin
        BATCH_TEMPLATE := 'PAYMENTS';
        BATCH_NAME := 'LOANS';
        DOCUMENT_NO := SFactory.FnRunGetNextTransactionDocumentNo;

        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
        GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
        GenJournalLine.DeleteAll;



        ObjAccounts.Reset;
        ObjAccounts.SetRange(ObjAccounts."No.", VarAccountNo);
        ObjAccounts.SetRange(ObjAccounts."Account Type", '508');
        if ObjAccounts.FindSet then begin
            ObjAccounts.CalcFields(ObjAccounts.Balance, ObjAccounts."Uncleared Cheques");
            AvailableBal := (ObjAccounts.Balance - ObjAccounts."Uncleared Cheques");

            ObjAccTypes.Reset;
            ObjAccTypes.SetRange(ObjAccTypes.Code, ObjAccounts."Account Type");
            if ObjAccTypes.Find('-') then
                AvailableBal := AvailableBal - ObjAccTypes."Minimum Balance";

            if (AvailableBal > 0) and (ObjAccounts."Excess Repayment Rule" <> ObjAccounts."excess repayment rule"::"Exempt From Excess Rule") then begin
                VarExcessRuleType := ObjAccounts."Excess Repayment Rule";
                if VarExcessRuleType = Varexcessruletype::" " then begin
                    ObjExcessRule.Reset;
                    ObjExcessRule.SetRange(ObjExcessRule."Account Type Affected", ObjAccounts."Account Type");
                    if ObjExcessRule.FindSet then begin
                        VarExcessRuleType := ObjExcessRule."Loan Recovery Priority";
                    end;
                end;

                RunningBal := AvailableBal;
                VarRecoveryAccountBal := AvailableBal;

                ObjLoansII.Reset;
                ObjLoansII.SetCurrentkey(ObjLoansII."Issued Date");
                ObjLoansII.SetRange(ObjLoansII."Client Code", VarMemberNo);
                ObjLoansII.SetRange(ObjLoansII."Excess Ufalme Recovery", true);
                ObjLoansII.SetFilter(ObjLoansII."Outstanding Balance", '>%1', 1);
                if ObjLoansII.FindSet then begin
                    repeat
                        if RunningBal > 0 then begin


                            //=========================================================================Excess to Oldest Loan

                            if VarExcessRuleType = Varexcessruletype::"Oldest Loan" then begin
                                ObjLoans.CalcFields(ObjLoans."Outstanding Balance");

                                ObjLoans.Reset;
                                ObjLoans.SetCurrentkey(ObjLoans."Issued Date");
                                ObjLoans.SetRange(ObjLoans."Client Code", VarMemberNo);
                                ObjLoans.SetRange(ObjLoans."Excess LSA Recovery", true);
                                ObjLoans.SetFilter(ObjLoans."Outstanding Balance", '>%1', 1);
                                if ObjLoans.FindFirst then begin
                                    ObjLoans.CalcFields(ObjLoans."Outstanding Balance");
                                    VarLoantoOverpay := ObjLoans."Loan  No.";

                                    RunningBal := SFactory.FnRunCreateDebtCollectorFeeJournals(VarLoantoOverpay, BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, VarMemberNo, WorkDate,
                                        VarLoantoOverpay, ObjAccounts."No.", RunningBal, LineNo);

                                    if RunningBal >= ObjLoans."Outstanding Balance" then begin
                                        FnRunChargeInsuranceForRemainingPeriod(VarLoantoOverpay);//==============================Charge Insurance for the Remaining Period
                                        VarAmounttoRepay := ObjLoans."Outstanding Balance"
                                    end else
                                        VarAmounttoRepay := RunningBal;

                                    //------------------------------------1. Debit LSA Account---------------------------------------------------------------------------------------------
                                    LineNo := LineNo + 10000;
                                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                                    GenJournalLine."account type"::Vendor, ObjAccounts."No.", WorkDate, VarAmounttoRepay, 'FOSA', '',
                                    'Excess Principal Paid from ' + ObjAccounts."No." + ' to ' + ObjLoans."Loan Product Type Name", '', GenJournalLine."application source"::CBS);

                                    //------------------------------------2. Credit Loan Account---------------------------------------------------------------------------------------------
                                    LineNo := LineNo + 10000;
                                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Repayment",
                                    GenJournalLine."account type"::None, VarMemberNo, WorkDate, VarAmounttoRepay * -1, 'FOSA', '',
                                    'Excess Principal Paid from ' + ObjAccounts."No." + ' to ' + ObjLoans."Loan Product Type Name", VarLoantoOverpay, GenJournalLine."application source"::CBS);
                                    //--------------------------------(Credit Loan Account)---------------------------------------------

                                    RunningBal := RunningBal - VarAmounttoRepay;

                                    if (ObjLoans."Outstanding Balance" - VarAmounttoRepay) = 0 then begin

                                        FnRunPostInsuranceRecovery(VarLoantoOverpay, RunningBal, VarMemberNo, ObjAccounts."No.");
                                        VarInsuranceForRemainingPeriodII := FnRunGetInsuranceForRemainingPeriod(VarLoantoOverpay);
                                        RunningBal := RunningBal - VarInsuranceForRemainingPeriodII;
                                    end;

                                end;
                            end;

                            //=========================================================================Excess to Newest Loan
                            if VarExcessRuleType = Varexcessruletype::"Newest Loan" then begin
                                ObjLoans.CalcFields(ObjLoans."Outstanding Balance");

                                ObjLoans.Reset;
                                ObjLoans.SetCurrentkey(ObjLoans."Issued Date");
                                ObjLoans.SetRange(ObjLoans."Client Code", VarMemberNo);
                                ObjLoans.SetRange(ObjLoans."Excess Ufalme Recovery", true);
                                ObjLoans.SetFilter(ObjLoans."Outstanding Balance", '>%1', 1);
                                if ObjLoans.FindLast then begin
                                    ObjLoans.CalcFields(ObjLoans."Outstanding Balance");
                                    VarLoantoOverpay := ObjLoans."Loan  No.";

                                    RunningBal := SFactory.FnRunCreateDebtCollectorFeeJournals(VarLoantoOverpay, BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, VarMemberNo, WorkDate,
                                        VarLoantoOverpay, ObjAccounts."No.", RunningBal, LineNo);

                                    if RunningBal > ObjLoans."Outstanding Balance" then begin
                                        FnRunChargeInsuranceForRemainingPeriod(VarLoantoOverpay);//==============================Charge Insurance for the Remaining Period
                                        VarAmounttoRepay := ObjLoans."Outstanding Balance"
                                    end else
                                        VarAmounttoRepay := RunningBal;

                                    //------------------------------------1. Debit LSA Account---------------------------------------------------------------------------------------------
                                    LineNo := LineNo + 10000;
                                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                                    GenJournalLine."account type"::Vendor, ObjAccounts."No.", WorkDate, VarAmounttoRepay, 'FOSA', '',
                                    'Excess Principal Paid from ' + ObjAccounts."No." + ' to ' + ObjLoans."Loan Product Type Name", '', GenJournalLine."application source"::CBS);

                                    //------------------------------------2. Credit Loan Account---------------------------------------------------------------------------------------------
                                    LineNo := LineNo + 10000;
                                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Repayment",
                                    GenJournalLine."account type"::None, VarMemberNo, WorkDate, VarAmounttoRepay * -1, 'FOSA', '',
                                    'Excess Principal Paid from ' + ObjAccounts."No." + ' to ' + ObjLoans."Loan Product Type Name", VarLoantoOverpay, GenJournalLine."application source"::CBS);
                                    //--------------------------------(Credit Loan Account)---------------------------------------------

                                    RunningBal := RunningBal - VarAmounttoRepay;

                                    if (ObjLoans."Outstanding Balance" - VarAmounttoRepay) = 0 then begin
                                        FnRunPostInsuranceRecovery(VarLoantoOverpay, RunningBal, VarMemberNo, ObjAccounts."No.");
                                        VarInsuranceForRemainingPeriodII := FnRunGetInsuranceForRemainingPeriod(VarLoantoOverpay);
                                        RunningBal := RunningBal - VarInsuranceForRemainingPeriodII;
                                    end;

                                end;
                            end;
                            //=========================================================================Excess to  Biggest Loan
                            if VarExcessRuleType = Varexcessruletype::"Biggest Loan" then begin
                                ObjLoans.CalcFields(ObjLoans."Outstanding Balance");

                                ObjLoans.Reset;
                                ObjLoans.SetCurrentkey(ObjLoans."Outstanding Balance");
                                ObjLoans.SetRange(ObjLoans."Client Code", VarMemberNo);
                                ObjLoans.SetRange(ObjLoans."Excess Ufalme Recovery", true);
                                ObjLoans.SetFilter(ObjLoans."Outstanding Balance", '>%1', 1);
                                if ObjLoans.FindLast then begin
                                    ObjLoans.CalcFields(ObjLoans."Outstanding Balance");
                                    VarLoantoOverpay := ObjLoans."Loan  No.";

                                    RunningBal := SFactory.FnRunCreateDebtCollectorFeeJournals(VarLoantoOverpay, BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, VarMemberNo, WorkDate,
                                    VarLoantoOverpay, ObjAccounts."No.", RunningBal, LineNo);

                                    if RunningBal > ObjLoans."Outstanding Balance" then begin
                                        FnRunChargeInsuranceForRemainingPeriod(VarLoantoOverpay);//==============================Charge Insurance for the Remaining Period
                                        VarAmounttoRepay := ObjLoans."Outstanding Balance"
                                    end else
                                        VarAmounttoRepay := RunningBal;

                                    //------------------------------------1. Debit LSA Account---------------------------------------------------------------------------------------------
                                    LineNo := LineNo + 10000;
                                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                                    GenJournalLine."account type"::Vendor, ObjAccounts."No.", WorkDate, VarAmounttoRepay, 'FOSA', '',
                                    'Excess Principal Paid from ' + ObjAccounts."No." + ' to ' + ObjLoans."Loan Product Type Name", '', GenJournalLine."application source"::CBS);

                                    //------------------------------------2. Credit Loan Account---------------------------------------------------------------------------------------------
                                    LineNo := LineNo + 10000;
                                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Repayment",
                                    GenJournalLine."account type"::None, VarMemberNo, WorkDate, VarAmounttoRepay * -1, 'FOSA', '',
                                    'Excess Principal Paid from ' + ObjAccounts."No." + ' to ' + ObjLoans."Loan Product Type Name", VarLoantoOverpay, GenJournalLine."application source"::CBS);
                                    //--------------------------------(Credit Loan Account)---------------------------------------------
                                    RunningBal := RunningBal - VarAmounttoRepay;

                                    if (ObjLoans."Outstanding Balance" - VarAmounttoRepay) = 0 then begin
                                        FnRunPostInsuranceRecovery(VarLoantoOverpay, RunningBal, VarMemberNo, ObjAccounts."No.");
                                        VarInsuranceForRemainingPeriodII := FnRunGetInsuranceForRemainingPeriod(VarLoantoOverpay);
                                        RunningBal := RunningBal - VarInsuranceForRemainingPeriodII;
                                    end;

                                end;
                            end;

                            //=========================================================================Excess to  Smallest Loan
                            if VarExcessRuleType = Varexcessruletype::"Smallest Loan" then begin
                                ObjLoans.CalcFields(ObjLoans."Outstanding Balance");

                                ObjLoans.Reset;
                                ObjLoans.SetCurrentkey(ObjLoans."Outstanding Balance");
                                ObjLoans.SetRange(ObjLoans."Client Code", VarMemberNo);
                                ObjLoans.SetRange(ObjLoans."Excess Ufalme Recovery", true);
                                ObjLoans.SetFilter(ObjLoans."Outstanding Balance", '>%1', 1);
                                if ObjLoans.FindFirst then begin
                                    ObjLoans.CalcFields(ObjLoans."Outstanding Balance");

                                    VarLoantoOverpay := ObjLoans."Loan  No.";

                                    RunningBal := SFactory.FnRunCreateDebtCollectorFeeJournals(VarLoantoOverpay, BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, VarMemberNo, WorkDate,
                                      VarLoantoOverpay, ObjAccounts."No.", RunningBal, LineNo);

                                    if RunningBal > ObjLoans."Outstanding Balance" then begin
                                        FnRunChargeInsuranceForRemainingPeriod(VarLoantoOverpay);//==============================Charge Insurance for the Remaining Period
                                        VarAmounttoRepay := ObjLoans."Outstanding Balance"
                                    end else
                                        VarAmounttoRepay := RunningBal;


                                    //------------------------------------1. Debit LSA Account---------------------------------------------------------------------------------------------
                                    LineNo := LineNo + 10000;
                                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                                    GenJournalLine."account type"::Vendor, ObjAccounts."No.", WorkDate, VarAmounttoRepay, 'FOSA', '',
                                    'Excess Principal Paid from ' + ObjAccounts."No." + ' to ' + ObjLoans."Loan Product Type Name", '', GenJournalLine."application source"::CBS);

                                    //------------------------------------2. Credit Loan Account---------------------------------------------------------------------------------------------
                                    LineNo := LineNo + 10000;
                                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Repayment",
                                    GenJournalLine."account type"::None, VarMemberNo, WorkDate, VarAmounttoRepay * -1, 'FOSA', '',
                                    'Excess Principal Paid from ' + ObjAccounts."No." + ' to ' + ObjLoans."Loan Product Type Name", VarLoantoOverpay, GenJournalLine."application source"::CBS);
                                    //--------------------------------(Credit Loan Account)---------------------------------------------
                                    RunningBal := RunningBal - VarAmounttoRepay;

                                    if (ObjLoans."Outstanding Balance" - VarAmounttoRepay) = 0 then begin
                                        FnRunPostInsuranceRecovery(VarLoantoOverpay, RunningBal, VarMemberNo, ObjAccounts."No.");
                                        VarInsuranceForRemainingPeriodII := FnRunGetInsuranceForRemainingPeriod(VarLoantoOverpay);
                                        RunningBal := RunningBal - VarInsuranceForRemainingPeriodII;
                                    end;

                                end;
                            end;

                            //CU posting
                            GenJournalLine.Reset;
                            GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                            GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                            if GenJournalLine.Find('-') then
                                Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
                        end;
                    until ObjLoansII.Next = 0;
                end;
            end;
        end;
    end;

    local procedure FnRunChargeInsuranceForRemainingPeriod(VarLoanNoRecovered: Code[30]) VarInsuranceForRemainingPeriod: Decimal
    var
        VarEndYear: Date;
        VarInsuranceMonths: Integer;
        ObjProductCharge: Record "Loan Product Charges";
        VarInsurancePayoff: Decimal;
        VarLoanInsuranceBalAccount: Code[30];
        ObjLoanType: Record "Loan Products Setup";
    begin
        BATCH_TEMPLATE := 'PAYMENTS';
        BATCH_NAME := 'LOANS';
        DOCUMENT_NO := SFactory.FnRunGetNextTransactionDocumentNo;

        ObjLoans.Reset;
        ObjLoans.SetRange(ObjLoans."Loan  No.", VarLoanNoRecovered);
        if ObjLoans.FindSet then begin
            ObjLoans.CalcFields(ObjLoans."Outstanding Balance", ObjLoans."Loan Insurance Paid", ObjLoans."Penalty Charged", ObjLoans."Penalty Paid", ObjLoans."Interest Due",
            ObjLoans."Interest Paid");

            if ObjLoans."Outstanding Balance" <> 0 then begin

                VarEndYear := CalcDate('CY', Today);
                VarInsuranceMonths := ROUND((VarEndYear - Today) / 30, 1, '=');

                ObjProductCharge.Reset;
                ObjProductCharge.SetRange(ObjProductCharge."Product Code", ObjLoans."Loan Product Type");
                ObjProductCharge.SetRange(ObjProductCharge."Loan Charge Type", ObjProductCharge."loan charge type"::"Loan Insurance");
                if ObjProductCharge.FindSet then begin
                    VarInsurancePayoff := ROUND((ObjLoans."Approved Amount" * (ObjProductCharge.Percentage / 100)) * VarInsuranceMonths, 0.05, '>');
                end;
            end;
        end;
        VarInsuranceForRemainingPeriod := VarInsurancePayoff;


        if ObjLoanType.Get(ObjLoans."Loan Product Type") then begin
            VarLoanInsuranceBalAccount := ObjLoanType."Receivable Insurance Accounts";
        end;


        //------------------------------------Debit Loan Insurance Due---------------------------------------------------------------------------------------------
        LineNo := LineNo + 10000;
        SFactory.FnCreateGnlJournalLineBalanced(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Insurance Charged",
        GenJournalLine."account type"::None, ObjLoans."Client Code", WorkDate, 'Remaining Loan Insurance Charged ' + VarLoanNoRecovered, GenJournalLine."bal. account type"::"G/L Account",
        VarLoanInsuranceBalAccount, VarInsurancePayoff, 'BOSA', VarLoanNoRecovered);
        //--------------------------------Debit Loan Insurance Due-------------------------------------------------------------------------------
    end;

    local procedure FnRunPostInsuranceRecovery(VarInsuranceLoan: Code[30]; VarRemainingLSABal: Decimal; VarMemberNo: Code[30]; VarLSAAccount: Code[30])
    var
        VarAmounttoDeduct: Decimal;
    begin
        BATCH_TEMPLATE := 'PAYMENTS';
        BATCH_NAME := 'LOANS';
        DOCUMENT_NO := SFactory.FnRunGetNextTransactionDocumentNo;

        VarOutstandingInsurance := FnRunGetInsuranceForRemainingPeriod(VarInsuranceLoan);

        if VarRemainingLSABal > 0 then begin
            if VarRemainingLSABal >= VarOutstandingInsurance then begin
                VarAmounttoDeduct := VarOutstandingInsurance
            end else
                VarAmounttoDeduct := VarRemainingLSABal;


            //------------------------------------1. Debit LSA Account---------------------------------------------------------------------------------------------
            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
            GenJournalLine."account type"::Vendor, VarLSAAccount, WorkDate, VarAmounttoDeduct, 'FOSA', '',
            'Remaining Loan Insurance Paid - ' + VarLoantoOverpay, '', GenJournalLine."application source"::CBS);

            //------------------------------------2. Credit Loan Account---------------------------------------------------------------------------------------------
            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Insurance Paid",
            GenJournalLine."account type"::None, VarMemberNo, WorkDate, VarAmounttoDeduct * -1, 'FOSA', '',
            'Loan Insurance Paid ' + VarLoantoOverpay, VarLoantoOverpay, GenJournalLine."application source"::CBS);
            //--------------------------------(Credit Loan Account)---------------------------------------------

        end;
    end;

    local procedure FnRunGetInsuranceForRemainingPeriod(VarLoanNoRecovered: Code[30]) VarInsuranceForRemainingPeriod: Decimal
    var
        VarEndYear: Date;
        VarInsuranceMonths: Integer;
        ObjProductCharge: Record "Loan Product Charges";
        VarInsurancePayoff: Decimal;
        VarLoanInsuranceBalAccount: Code[30];
        ObjLoanType: Record "Loan Products Setup";
    begin

        ObjLoans.Reset;
        ObjLoans.SetRange(ObjLoans."Loan  No.", VarLoanNoRecovered);
        if ObjLoans.FindSet then begin
            ObjLoans.CalcFields(ObjLoans."Outstanding Balance", ObjLoans."Loan Insurance Paid", ObjLoans."Penalty Charged", ObjLoans."Penalty Paid", ObjLoans."Interest Due",
            ObjLoans."Interest Paid");

            if ObjLoans."Outstanding Balance" <> 0 then begin
                VarEndYear := CalcDate('CY', Today);
                VarInsuranceMonths := ROUND((VarEndYear - Today) / 30, 1, '=');

                ObjProductCharge.Reset;
                ObjProductCharge.SetRange(ObjProductCharge."Product Code", ObjLoans."Loan Product Type");
                ObjProductCharge.SetRange(ObjProductCharge."Loan Charge Type", ObjProductCharge."loan charge type"::"Loan Insurance");
                if ObjProductCharge.FindSet then begin
                    VarInsurancePayoff := ROUND((ObjLoans."Approved Amount" * (ObjProductCharge.Percentage / 100)) * VarInsuranceMonths, 0.05, '>');
                end;
            end;
        end;
        VarInsuranceForRemainingPeriod := VarInsurancePayoff;
        exit(VarInsuranceForRemainingPeriod);


    end;
}

