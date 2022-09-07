#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Report 50286 "Payroll JournalTransfer Ver2"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("Payroll Posting Setup Ver1"; "Payroll Posting Setup Ver1")
        {
            column(ReportForNavId_6207; 6207)
            {
            }

            trigger OnAfterGetRecord()
            begin
                FnRunCreateTransactions("Transaction Code", "Debit G/L Account", "Credit G/L Account");
            end;

            trigger OnPostDataItem()
            begin
                Message('Payroll Journal Entries Created in # General Journals # Batch - SALARIES');
            end;

            trigger OnPreDataItem()
            begin
                GenJournalLine.Reset;
                GenJournalLine.SetRange(GenJournalLine."Journal Template Name", 'GENERAL');
                GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", 'SALARY');
                if GenJournalLine.FindSet then begin
                    GenJournalLine.DeleteAll
                end;

                FnRunCreateLoanRepaymentEntries;
                FnRunCreateDepositsContributionEntries;
            end;
        }
        dataitem("Payroll Employee."; "Payroll Employee.")
        {
            column(ReportForNavId_1; 1)
            {
            }
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(VarPayrollPeriod; VarPayrollPeriod)
                {
                    ApplicationArea = Basic;
                    Caption = 'Payroll Period';
                    TableRelation = "Payroll Calender."."Date Opened";
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        VarPayrollPeriod: Date;
        ObjPayrollPeriodTransactions: Record "prPeriod Transactions.";
        BATCH_TEMPLATE: Code[30];
        BATCH_NAME: Code[30];
        DOCUMENT_NO: Code[30];
        LineNo: Integer;
        SFactory: Codeunit "SURESTEP Factory";
        GenJournalLine: Record "Gen. Journal Line";
        ObjPayrollPostingGroup: Record "Payroll Posting Groups.";
        VarTotalGrossPay: Decimal;
        VarTotalDebitTransactions: Decimal;
        VarNSSF: Decimal;
        VarNHIF: Decimal;
        VarPAYE: Decimal;
        VarNETPay: Decimal;
        VarBasicPay: Decimal;
        VarLoanRepayments: Decimal;
        ObjMemberAccount: Record Vendor;
        VarDepositsContribution: Decimal;
        ObjPayrollSetup: Record "Payroll Posting Setup Ver1";

    local procedure FnRunCreateTransactions(VarTransactionCode: Code[30]; VarDebitAccount: Code[30]; VarCreditAccount: Code[30])
    begin
        ObjPayrollPostingGroup.Get('PR');
        BATCH_TEMPLATE := 'GENERAL';
        BATCH_NAME := 'SALARY';
        DOCUMENT_NO := Format(VarPayrollPeriod, 0, '<Month Text,3> <Year4>');

        VarTotalDebitTransactions := 0;
        ObjPayrollPeriodTransactions.Reset;
        ObjPayrollPeriodTransactions.SetRange(ObjPayrollPeriodTransactions."Transaction Code", VarTransactionCode);
        ObjPayrollPeriodTransactions.SetFilter(ObjPayrollPeriodTransactions."Loan Number", '%1', '');
        ObjPayrollPeriodTransactions.SetFilter(ObjPayrollPeriodTransactions."coop parameters", '<>%1',
        ObjPayrollPeriodTransactions."coop parameters"::shares);
        ObjPayrollPeriodTransactions.SetFilter(ObjPayrollPeriodTransactions."Payroll Period", '%1', VarPayrollPeriod);
        if ObjPayrollPeriodTransactions.FindSet then begin
            ObjPayrollPeriodTransactions.CalcSums(ObjPayrollPeriodTransactions.Amount);
            VarTotalDebitTransactions := ObjPayrollPeriodTransactions.Amount;

            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLineBalanced(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
            GenJournalLine."account type"::"G/L Account", VarDebitAccount, WorkDate,
            "Payroll Posting Setup Ver1"."Transaction Description" + ' - ' + Format(VarPayrollPeriod, 0, '<Month Text,3> <Year4>'),
            GenJournalLine."bal. account type"::"G/L Account", VarCreditAccount, VarTotalDebitTransactions, '', '');

        end;
    end;

    local procedure FnRunCreateLoanRepaymentEntries()
    begin
        ObjPayrollPostingGroup.Get('PR');
        BATCH_TEMPLATE := 'GENERAL';
        BATCH_NAME := 'SALARY';
        DOCUMENT_NO := Format(VarPayrollPeriod, 0, '<Month Text,3> <Year4>');

        ObjPayrollPeriodTransactions.Reset;
        ObjPayrollPeriodTransactions.SetFilter(ObjPayrollPeriodTransactions."Loan Number", '<>%1', '');
        ObjPayrollPeriodTransactions.SetFilter(ObjPayrollPeriodTransactions."Payroll Period", '%1', VarPayrollPeriod);
        if ObjPayrollPeriodTransactions.FindSet then begin
            ObjPayrollPeriodTransactions.CalcSums(ObjPayrollPeriodTransactions.Amount);
            VarLoanRepayments := ObjPayrollPeriodTransactions.Amount;


            ObjPayrollSetup.Reset;
            ObjPayrollSetup.SetRange(ObjPayrollSetup."Sacco Deduction Type", ObjPayrollSetup."sacco deduction type"::"Loan Repayments");
            if ObjPayrollSetup.FindSet then begin
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLineBalanced(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                GenJournalLine."account type"::"G/L Account", ObjPayrollSetup."Debit G/L Account", WorkDate,
                'Loan Repayments' + ' - ' + Format(VarPayrollPeriod, 0, '<Month Text,3> <Year4>'),
                GenJournalLine."bal. account type"::"G/L Account", ObjPayrollSetup."Credit G/L Account", VarLoanRepayments, '', '');
            end;

        end;
    end;

    local procedure FnRunCreateDepositsContributionEntries()
    begin
        ObjPayrollPostingGroup.Get('PR');
        BATCH_TEMPLATE := 'GENERAL';
        BATCH_NAME := 'SALARY';
        DOCUMENT_NO := Format(VarPayrollPeriod, 0, '<Month Text,3> <Year4>');

        VarTotalDebitTransactions := 0;
        ObjPayrollPeriodTransactions.Reset;
        ObjPayrollPeriodTransactions.SetRange(ObjPayrollPeriodTransactions."coop parameters", ObjPayrollPeriodTransactions."coop parameters"::shares);
        ObjPayrollPeriodTransactions.SetFilter(ObjPayrollPeriodTransactions."Payroll Period", '%1', VarPayrollPeriod);
        if ObjPayrollPeriodTransactions.FindSet then begin
            ObjPayrollPeriodTransactions.CalcSums(ObjPayrollPeriodTransactions.Amount);
            VarDepositsContribution := ObjPayrollPeriodTransactions.Amount;

            ObjPayrollSetup.Reset;
            ObjPayrollSetup.SetRange(ObjPayrollSetup."Sacco Deduction Type", ObjPayrollSetup."sacco deduction type"::"Deposits Contribution");
            if ObjPayrollSetup.FindSet then begin
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLineBalanced(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                GenJournalLine."account type"::"G/L Account", ObjPayrollSetup."Debit G/L Account", WorkDate,
                'Deposits Contribution' + ' - ' + Format(VarPayrollPeriod, 0, '<Month Text,3> <Year4>'),
                GenJournalLine."bal. account type"::"G/L Account", ObjPayrollSetup."Credit G/L Account", VarDepositsContribution, '', '');
            end;
        end;
    end;
}

