#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Report 50955 "Post Excess LSA Funds Daily"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("Loans Register"; "Loans Register")
        {
            DataItemTableView = where("Outstanding Balance" = filter(> 0));
            RequestFilterFields = "Loan  No.", "Client Code";
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnAfterGetRecord()
            begin
                FnRunPostExcessRepaymentFundsDaily("Loan  No.", "Client Code", BATCH_TEMPLATE, BATCH_NAME, LineNo, DOCUMENT_NO);
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
        VarRunningBal: Decimal;

    local procedure FnRunPostExcessRepaymentFundsDaily(VarLoanNo: Code[30]; VarMemberNo: Code[30]; VarTemplateName: Code[30]; VarBatchName: Code[30]; VarLineNo: Integer; VarDocumentNo: Code[30])
    var
        VarLoansCount: Integer;
        VarLoantoOverpay: Code[30];
        VarBiggestAmount: Decimal;
        VarSmallestAmount: Decimal;
        VarAmounttoDeduct: Decimal;
    begin
        ObjGensetup.Get();
        BATCH_TEMPLATE := 'GENERAL';
        BATCH_NAME := 'DEFAULT';
        DOCUMENT_NO := 'Rec:' + Format(VarLoanNo);

        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
        GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
        if GenJournalLine.Find('-') then begin
            GenJournalLine.DeleteAll;
        end;


        ObjRepamentSchedule.Reset;
        ObjRepamentSchedule.SetRange(ObjRepamentSchedule."Loan No.", VarLoanNo);
        ObjRepamentSchedule.SetRange(ObjRepamentSchedule."Repayment Date", WorkDate);
        if ObjRepamentSchedule.FindSet then begin
            ObjAccounts.Reset;
            ObjAccounts.SetRange(ObjAccounts."BOSA Account No", VarMemberNo);
            ObjAccounts.SetRange(ObjAccounts."Account Type", '507');
            if ObjAccounts.FindSet then begin
                ObjAccounts.CalcFields(ObjAccounts.Balance, ObjAccounts."Uncleared Cheques");
                AvailableBal := (ObjAccounts.Balance - ObjAccounts."Uncleared Cheques");

                ObjAccTypes.Reset;
                ObjAccTypes.SetRange(ObjAccTypes.Code, ObjAccounts."Account Type");
                if ObjAccTypes.Find('-') then
                    AvailableBal := AvailableBal - ObjAccTypes."Minimum Balance";
            end;

            if (AvailableBal > 0) and (ObjAccounts."Excess Repayment Rule" <> ObjAccounts."excess repayment rule"::"Exempt From Excess Rule") then begin



                ObjLoans.CalcFields(ObjLoans."Outstanding Balance");
                ObjLoans.Reset;
                ObjLoans.SetCurrentkey(ObjLoans."Issued Date");
                ObjLoans.SetRange(ObjLoans."Client Code", VarMemberNo);
                ObjLoans.SetFilter(ObjLoans."Outstanding Balance", '>%1', 0);
                if ObjLoans.FindSet then begin
                    VarLoansCount := ObjLoans.Count;
                    if VarLoansCount = 1 then begin
                        VarLoantoOverpay := ObjLoans."Loan  No.";
                        VarRunningBal := FnRunRecoverDebtCollectorFee(VarLoantoOverpay, AvailableBal, ObjAccounts."No.");

                        if VarRunningBal > ObjLoans."Outstanding Balance" then
                            VarAmounttoDeduct := ObjLoans."Outstanding Balance"
                        else
                            VarAmounttoDeduct := VarRunningBal;

                        //------------------------------------1. Debit FOSA Account---------------------------------------------------------------------------------------------
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                        GenJournalLine."account type"::Vendor, ObjAccounts."No.", WorkDate, VarAmounttoDeduct, 'FOSA', '',
                        'Excess Principal Paid from ' + ObjAccounts."No." + ' to ' + ObjLoans."Loan Product Type Name", '', GenJournalLine."application source"::CBS);

                        //------------------------------------2. Credit Loan Account---------------------------------------------------------------------------------------------
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Repayment",
                        GenJournalLine."account type"::None, VarMemberNo, WorkDate, VarAmounttoDeduct * -1, 'BOSA', '',
                        'Excess Principal Paid from ' + ObjAccounts."No." + ' to ' + ObjLoans."Loan Product Type Name", VarLoantoOverpay, GenJournalLine."application source"::CBS);
                        //--------------------------------(Credit Loan Account)---------------------------------------------

                    end;
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

    local procedure FnRunRecoverDebtCollectorFee(VarLoanNo: Code[30]; RunningBalance: Decimal; VarFOSAAccount: Code[30]) VarRunBal: Decimal
    var
        AmountToDeduct: Decimal;
        VarDebtCollectorBaseAmount: Decimal;
        VarDebtCollectorFee: Decimal;
    begin
        //============================================================Debt Collector Fee
        if RunningBalance > 0 then begin
            ObjLoans.Reset;
            ObjLoans.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
            ObjLoans.SetRange(ObjLoans."Loan  No.", VarLoanNo);
            ObjLoans.SetRange(ObjLoans."Loan Under Debt Collection", true);
            if ObjLoans.Find('-') then begin

                ObjLoans.CalcFields(ObjLoans."Outstanding Balance", ObjLoans."Penalty Charged", ObjLoans."Penalty Paid");
                if RunningBalance > 0 then begin
                    AmountToDeduct := 0;

                    if RunningBalance > ObjLoans."Outstanding Balance" then
                        VarDebtCollectorBaseAmount := ObjLoans."Outstanding Balance"
                    else
                        VarDebtCollectorBaseAmount := RunningBalance;

                    VarDebtCollectorFee := VarDebtCollectorBaseAmount * (ObjLoans."Loan Debt Collector Interest %" / 100);
                    VarDebtCollectorFee := VarDebtCollectorFee + (VarDebtCollectorFee * 0.16);

                    if RunningBalance > VarDebtCollectorFee then begin
                        AmountToDeduct := VarDebtCollectorFee
                    end else
                        AmountToDeduct := RunningBalance;

                    //------------------------------------1. Debit FOSA Account---------------------------------------------------------------------------------------------
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::Vendor, VarFOSAAccount, WorkDate, AmountToDeduct, 'FOSA', '',
                    'Debt Collection Charge + VAT from ' + VarLoanNo + ObjLoans."Client Name", '', GenJournalLine."application source"::CBS);

                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::Vendor, ObjLoans."Loan Debt Collector", WorkDate, AmountToDeduct * -1, 'BOSA', VarLoanNo,
                    'Debt Collection Charge + VAT from ' + VarLoanNo + ObjLoans."Client Name", VarLoanNo, GenJournalLine."application source"::CBS);
                    VarRunBal := RunningBalance - AmountToDeduct;
                    exit(VarRunBal);
                end;
            end;
        end;
    end;
}

