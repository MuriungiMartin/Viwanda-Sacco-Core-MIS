#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Report 50285 "Payroll Net Pay Transfer Ver1"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("Payroll Employee."; "Payroll Employee.")
        {
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnAfterGetRecord()
            begin
                FnRunCreateLoansandNetPayCreditEntries("No.", "Loan Settlement Account", "Payroll No", "Bank Account No");
            end;

            trigger OnPostDataItem()
            begin
                Message('Net Pay Journal Entries Created in # General Journals # Batch - NETPAY');
            end;

            trigger OnPreDataItem()
            begin
                GenJournalLine.Reset;
                GenJournalLine.SetRange(GenJournalLine."Journal Template Name", 'GENERAL');
                GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", 'NETPAY');
                if GenJournalLine.FindSet then begin
                    GenJournalLine.DeleteAll
                end;
            end;
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
        VarDepositsAccountNo: Code[30];
        VarAmounttoDebitNetPay: Decimal;
        ObjPayrollEmployee: Record "Payroll Employee.";
        ObjPayrollGeneralSetup: Record "Payroll General Setup.";

    local procedure FnRunCreateLoansandNetPayCreditEntries(VarEmployeeCode: Code[30]; VarLoanSettlement: Code[30]; VarMemberNo: Code[30]; VarFOSAAccount: Code[30])
    begin
        ObjPayrollPostingGroup.Get('PR');
        BATCH_TEMPLATE := 'GENERAL';
        BATCH_NAME := 'NETPAY';
        DOCUMENT_NO := SFactory.FnRunGetNextTransactionDocumentNo;

        VarLoanRepayments := 0;
        VarDepositsContribution := 0;
        VarNETPay := 0;
        VarAmounttoDebitNetPay := 0;

        //==============================================================================Loan Repayments
        ObjPayrollPeriodTransactions.Reset;
        ObjPayrollPeriodTransactions.SetRange(ObjPayrollPeriodTransactions."Employee Code", VarEmployeeCode);
        ObjPayrollPeriodTransactions.SetFilter(ObjPayrollPeriodTransactions."Loan Number", '<>%1', '');
        ObjPayrollPeriodTransactions.SetFilter(ObjPayrollPeriodTransactions."Payroll Period", '%1', VarPayrollPeriod);
        if ObjPayrollPeriodTransactions.FindSet then begin
            ObjPayrollPeriodTransactions.CalcSums(ObjPayrollPeriodTransactions.Amount);
            VarLoanRepayments := ObjPayrollPeriodTransactions.Amount;

            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
            GenJournalLine."account type"::Vendor, VarLoanSettlement, WorkDate, VarLoanRepayments * -1, 'FOSA', '',
            'Loan Repayment Deduction - ' + Format(VarPayrollPeriod, 0, '<Month Text,3> <Year4>'), '', GenJournalLine."application source"::CBS);

        end;

        //==============================================================================Deposits Contribution
        ObjPayrollPeriodTransactions.Reset;
        ObjPayrollPeriodTransactions.SetRange(ObjPayrollPeriodTransactions."Employee Code", VarEmployeeCode);
        ObjPayrollPeriodTransactions.SetRange(ObjPayrollPeriodTransactions."coop parameters", ObjPayrollPeriodTransactions."coop parameters"::shares);
        ObjPayrollPeriodTransactions.SetFilter(ObjPayrollPeriodTransactions."Payroll Period", '%1', VarPayrollPeriod);
        if ObjPayrollPeriodTransactions.FindSet then begin
            ObjPayrollPeriodTransactions.CalcSums(ObjPayrollPeriodTransactions.Amount);
            VarDepositsContribution := ObjPayrollPeriodTransactions.Amount;

            ObjMemberAccount.Reset;
            ObjMemberAccount.SetRange(ObjMemberAccount."BOSA Account No", VarMemberNo);
            ObjMemberAccount.SetRange(ObjMemberAccount."Account Type", '602');
            ObjMemberAccount.SetFilter(ObjMemberAccount.Status, '<>%1&<>%2', ObjMemberAccount.Status::Closed, ObjMemberAccount.Status::Deceased);
            if ObjMemberAccount.FindSet then begin
                VarDepositsAccountNo := ObjMemberAccount."No.";
            end;

            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
            GenJournalLine."account type"::Vendor, VarDepositsAccountNo, WorkDate, VarDepositsContribution * -1, 'FOSA', '',
            'Deposit Contribution - ' + Format(VarPayrollPeriod, 0, '<Month Text,3> <Year4>'), '', GenJournalLine."application source"::CBS);

        end;

        //==============================================================================Net Pay
        ObjPayrollPeriodTransactions.Reset;
        ObjPayrollPeriodTransactions.SetRange(ObjPayrollPeriodTransactions."Employee Code", VarEmployeeCode);
        ObjPayrollPeriodTransactions.SetRange(ObjPayrollPeriodTransactions."Transaction Code", 'NPAY');
        ObjPayrollPeriodTransactions.SetFilter(ObjPayrollPeriodTransactions."Payroll Period", '%1', VarPayrollPeriod);
        if ObjPayrollPeriodTransactions.FindSet then begin
            VarNETPay := ObjPayrollPeriodTransactions.Amount;
            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
            GenJournalLine."account type"::Vendor, VarFOSAAccount, WorkDate, VarNETPay * -1, 'FOSA', '',
            'Net Pay For' + ' - ' + Format(VarPayrollPeriod, 0, '<Month Text,3> <Year4>'), '', GenJournalLine."application source"::CBS);

        end;


        //==============================================================================Debit Total Net Pay Account
        ObjPayrollGeneralSetup.Get;
        ObjPayrollEmployee.Reset;
        ObjPayrollEmployee.SetRange(ObjPayrollEmployee."No.", VarEmployeeCode);
        if ObjPayrollEmployee.FindSet then begin
            VarAmounttoDebitNetPay := VarLoanRepayments + VarDepositsContribution + VarNETPay;
            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
            GenJournalLine."account type"::"G/L Account", ObjPayrollGeneralSetup."Staff Net Pay G/L Account", WorkDate, VarAmounttoDebitNetPay, 'FOSA', '',
            DOCUMENT_NO + ' - ' + Format(VarPayrollPeriod, 0, '<Month Text,3> <Year4>'), '', GenJournalLine."application source"::CBS);
        end;

    end;
}

