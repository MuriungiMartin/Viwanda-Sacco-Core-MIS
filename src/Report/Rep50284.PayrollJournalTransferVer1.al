#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Report 50284 "Payroll JournalTransfer Ver1"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("Payroll Transaction Code."; "Payroll Transaction Code.")
        {
            RequestFilterFields = "Current Month Filter", "No. Series";
            column(ReportForNavId_6207; 6207)
            {
            }

            trigger OnAfterGetRecord()
            begin
                FnRunCreateDebitTransactions("Transaction Code", "G/L Account");
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



                FnRunCreateBasicPayEntries;
                FnRunCreateNHIFEntries;
                FnRunCreateNSSFEntries;
                FnRunCreatePAYEEntries;
                FnRunCreateNetPayEntries;
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

    local procedure FnRunCreateGrossPayEntries()
    begin
        ObjPayrollPostingGroup.Get('PR');
        BATCH_TEMPLATE := 'GENERAL';
        BATCH_NAME := 'SALARY';
        DOCUMENT_NO := Format(VarPayrollPeriod, 0, '<Month Text,3> <Year4>');



        ObjPayrollPeriodTransactions.Reset;
        ObjPayrollPeriodTransactions.SetRange(ObjPayrollPeriodTransactions."Transaction Code", 'GPAY');
        ObjPayrollPeriodTransactions.SetFilter(ObjPayrollPeriodTransactions."Payroll Period", '%1', VarPayrollPeriod);
        if ObjPayrollPeriodTransactions.FindSet then begin
            ObjPayrollPeriodTransactions.CalcSums(ObjPayrollPeriodTransactions.Amount);
            VarTotalGrossPay := ObjPayrollPeriodTransactions.Amount;

            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
            GenJournalLine."account type"::"G/L Account", ObjPayrollPostingGroup."Salary Account", WorkDate, VarTotalGrossPay * -1, 'FOSA', '',
            ObjPayrollPeriodTransactions."Transaction Name" + ' - ' + Format(VarPayrollPeriod, 0, '<Month Text,3> <Year4>'), '', GenJournalLine."application source"::CBS);

        end;
    end;

    local procedure FnRunCreateDebitTransactions(VarTransactionCode: Code[30]; VarBalAccountNo: Code[30])
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
            GenJournalLine."account type"::"G/L Account", VarBalAccountNo, WorkDate,
            ObjPayrollPeriodTransactions."Transaction Name" + ' - ' + Format(VarPayrollPeriod, 0, '<Month Text,3> <Year4>'),
            GenJournalLine."bal. account type"::"G/L Account", ObjPayrollPostingGroup."Salary Processing Control", VarTotalDebitTransactions, '', '');

        end;
    end;

    local procedure FnRunCreateBasicPayEntries()
    begin
        ObjPayrollPostingGroup.Get('PR');
        BATCH_TEMPLATE := 'GENERAL';
        BATCH_NAME := 'SALARY';
        DOCUMENT_NO := Format(VarPayrollPeriod, 0, '<Month Text,3> <Year4>');

        VarTotalDebitTransactions := 0;
        ObjPayrollPeriodTransactions.Reset;
        ObjPayrollPeriodTransactions.SetRange(ObjPayrollPeriodTransactions."Transaction Code", 'BPAY');
        ObjPayrollPeriodTransactions.SetFilter(ObjPayrollPeriodTransactions."Payroll Period", '%1', VarPayrollPeriod);
        if ObjPayrollPeriodTransactions.FindSet then begin
            ObjPayrollPeriodTransactions.CalcSums(ObjPayrollPeriodTransactions.Amount);
            VarBasicPay := ObjPayrollPeriodTransactions.Amount;

            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLineBalanced(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
            GenJournalLine."account type"::"G/L Account", ObjPayrollPostingGroup."Salary Account", WorkDate,
            'Basic Pay' + ' - ' + Format(VarPayrollPeriod, 0, '<Month Text,3> <Year4>'),
            GenJournalLine."bal. account type"::"G/L Account", ObjPayrollPostingGroup."Salary Processing Control", VarBasicPay * -1, '', '');

        end;
    end;

    local procedure FnRunCreateNSSFEntries()
    begin
        ObjPayrollPostingGroup.Get('PR');
        BATCH_TEMPLATE := 'GENERAL';
        BATCH_NAME := 'SALARY';
        DOCUMENT_NO := Format(VarPayrollPeriod, 0, '<Month Text,3> <Year4>');

        VarTotalDebitTransactions := 0;
        ObjPayrollPeriodTransactions.Reset;
        ObjPayrollPeriodTransactions.SetRange(ObjPayrollPeriodTransactions."Transaction Code", 'NSSF');
        ObjPayrollPeriodTransactions.SetFilter(ObjPayrollPeriodTransactions."Payroll Period", '%1', VarPayrollPeriod);
        if ObjPayrollPeriodTransactions.FindSet then begin
            ObjPayrollPeriodTransactions.CalcSums(ObjPayrollPeriodTransactions.Amount);
            VarNSSF := ObjPayrollPeriodTransactions.Amount;

            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLineBalanced(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
            GenJournalLine."account type"::"G/L Account", ObjPayrollPostingGroup."SSF Employer Account", WorkDate,
            'NSSF' + ' - ' + Format(VarPayrollPeriod, 0, '<Month Text,3> <Year4>'),
            GenJournalLine."bal. account type"::"G/L Account", ObjPayrollPostingGroup."Salary Processing Control", VarNSSF, '', '');

        end;
    end;

    local procedure FnRunCreateNHIFEntries()
    begin
        ObjPayrollPostingGroup.Get('PR');
        BATCH_TEMPLATE := 'GENERAL';
        BATCH_NAME := 'SALARY';
        DOCUMENT_NO := Format(VarPayrollPeriod, 0, '<Month Text,3> <Year4>');

        VarTotalDebitTransactions := 0;
        ObjPayrollPeriodTransactions.Reset;
        ObjPayrollPeriodTransactions.SetRange(ObjPayrollPeriodTransactions."Transaction Code", 'NHIF');
        ObjPayrollPeriodTransactions.SetFilter(ObjPayrollPeriodTransactions."Payroll Period", '%1', VarPayrollPeriod);
        if ObjPayrollPeriodTransactions.FindSet then begin
            ObjPayrollPeriodTransactions.CalcSums(ObjPayrollPeriodTransactions.Amount);
            VarNHIF := ObjPayrollPeriodTransactions.Amount;

            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLineBalanced(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
            GenJournalLine."account type"::"G/L Account", ObjPayrollPostingGroup."SSF Employer Account", WorkDate,
            'NHIF' + ' - ' + Format(VarPayrollPeriod, 0, '<Month Text,3> <Year4>'),
            GenJournalLine."bal. account type"::"G/L Account", ObjPayrollPostingGroup."Salary Processing Control", VarNHIF, '', '');

        end;
    end;

    local procedure FnRunCreatePAYEEntries()
    begin
        ObjPayrollPostingGroup.Get('PR');
        BATCH_TEMPLATE := 'GENERAL';
        BATCH_NAME := 'SALARY';
        DOCUMENT_NO := Format(VarPayrollPeriod, 0, '<Month Text,3> <Year4>');

        VarTotalDebitTransactions := 0;
        ObjPayrollPeriodTransactions.Reset;
        ObjPayrollPeriodTransactions.SetRange(ObjPayrollPeriodTransactions."Transaction Code", 'PAYE');
        ObjPayrollPeriodTransactions.SetFilter(ObjPayrollPeriodTransactions."Payroll Period", '%1', VarPayrollPeriod);
        if ObjPayrollPeriodTransactions.FindSet then begin
            ObjPayrollPeriodTransactions.CalcSums(ObjPayrollPeriodTransactions.Amount);
            VarPAYE := ObjPayrollPeriodTransactions.Amount;

            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLineBalanced(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
            GenJournalLine."account type"::"G/L Account", ObjPayrollPostingGroup."PAYE Account", WorkDate,
            'PAYE' + ' - ' + Format(VarPayrollPeriod, 0, '<Month Text,3> <Year4>'),
            GenJournalLine."bal. account type"::"G/L Account", ObjPayrollPostingGroup."Salary Processing Control", VarPAYE, '', '');

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

            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLineBalanced(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
            GenJournalLine."account type"::"G/L Account", ObjPayrollPostingGroup."Net Salary Payable", WorkDate,
            'Loan Repayments' + ' - ' + Format(VarPayrollPeriod, 0, '<Month Text,3> <Year4>'),
            GenJournalLine."bal. account type"::"G/L Account", ObjPayrollPostingGroup."Salary Processing Control", VarLoanRepayments * -1, '', '');

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

            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLineBalanced(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
            GenJournalLine."account type"::"G/L Account", ObjPayrollPostingGroup."Net Salary Payable", WorkDate,
            'Deposits Contribution' + ' - ' + Format(VarPayrollPeriod, 0, '<Month Text,3> <Year4>'),
            GenJournalLine."bal. account type"::"G/L Account", ObjPayrollPostingGroup."Salary Processing Control", VarDepositsContribution * -1, '', '');

        end;
    end;

    local procedure FnRunCreateNetPayEntries()
    begin
        ObjPayrollPostingGroup.Get('PR');
        BATCH_TEMPLATE := 'GENERAL';
        BATCH_NAME := 'SALARY';
        DOCUMENT_NO := Format(VarPayrollPeriod, 0, '<Month Text,3> <Year4>');

        VarTotalDebitTransactions := 0;
        ObjPayrollPeriodTransactions.Reset;
        ObjPayrollPeriodTransactions.SetRange(ObjPayrollPeriodTransactions."Transaction Code", 'NPAY');
        ObjPayrollPeriodTransactions.SetFilter(ObjPayrollPeriodTransactions."Payroll Period", '%1', VarPayrollPeriod);
        if ObjPayrollPeriodTransactions.FindSet then begin
            ObjPayrollPeriodTransactions.CalcSums(ObjPayrollPeriodTransactions.Amount);
            ObjPayrollPeriodTransactions.CalcFields(ObjPayrollPeriodTransactions."Fosa Account No.");

            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLineBalanced(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
            GenJournalLine."account type"::"G/L Account", ObjPayrollPostingGroup."Net Salary Payable", WorkDate,
            ObjPayrollPeriodTransactions."Transaction Name" + ' - ' + Format(VarPayrollPeriod, 0, '<Month Text,3> <Year4>'),
            GenJournalLine."bal. account type"::"G/L Account", ObjPayrollPostingGroup."Salary Processing Control", ObjPayrollPeriodTransactions.Amount * -1, '', '');

        end;
    end;
}

