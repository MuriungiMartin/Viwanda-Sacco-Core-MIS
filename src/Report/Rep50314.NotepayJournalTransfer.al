#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Report 50314 "Notepay JournalTransfer."
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("Payroll Employee."; "Payroll Employee.")
        {
            RequestFilterFields = "Current Month Filter", "No.";
            column(ReportForNavId_6207; 6207)
            {
            }

            trigger OnAfterGetRecord()
            begin
                PostingGroup.Get('PR');
                PostingGroup.TestField("SSF Employer Account");
                PostingGroup.TestField("SSF Employee Account");
                PostingGroup.TestField("Pension Employer Acc");
                PostingGroup.TestField("Pension Employee Acc");
                PostingGroup.TestField("Net Salary Payable");
                objEmp.SetRange(objEmp."No.", "No.");
                if objEmp.Find('-') then begin
                    strEmpName := '[' + "No." + '] ' + objEmp.Lastname + ' ' + objEmp.Firstname + ' ' + objEmp.Surname;
                end;

                LineNumber := LineNumber + 10;
                GlobalDim1 := "Payroll Employee."."Global Dimension 1";
                GlobalDim2 := "Payroll Employee."."Global Dimension 2";
                PeriodTrans.Reset;
                PeriodTrans.SetRange(PeriodTrans."Employee Code", "No.");
                PeriodTrans.SetRange(PeriodTrans."Payroll Period", SelectedPeriod);
                PeriodTrans.SetFilter(PeriodTrans."Transaction Code", '%1', 'NPAY');
                if PeriodTrans.Find('-') then begin
                    repeat
                        AmountToDebit := 0;
                        AmountToCredit := 0;
                        if PeriodTrans."Post As" = PeriodTrans."post as"::Debit then
                            AmountToDebit := AmountToDebit;

                        if PeriodTrans."Post As" = PeriodTrans."post as"::Credit then
                            AmountToCredit := PeriodTrans.Amount;
                        AccountType := Accounttype::Vendor;

                        //PeriodTrans.CALCFIELDS(PeriodTrans."Fosa Account No.");
                        FosaAccountNo := "Bank Account No";//PeriodTrans."Fosa Account No.";
                        SaccoTransactionType := Saccotransactiontype::" ";

                        CreateJnlEntry(IntegerPostAs, PostingDate, FosaAccountNo,
                        GlobalDim1, '', CopyStr(PeriodTrans."Transaction Name" + '-' + PeriodTrans."Employee Code", 1, 30), AmountToDebit, AmountToCredit,
                        PeriodTrans."Post As", PeriodTrans."Loan Number", SaccoTransactionType, GlobalDim1, GlobalDim2);


                    until PeriodTrans.Next = 0;
                end;
            end;

            trigger OnPostDataItem()
            begin
                Message('Journals Created Successfully');
            end;

            trigger OnPreDataItem()
            begin
                LineNumber := 10000;
                //Create batch*****************************************************************************
                GenJnlBatch.Reset;
                GenJnlBatch.SetRange(GenJnlBatch."Journal Template Name", 'GENERAL');
                GenJnlBatch.SetRange(GenJnlBatch.Name, 'NETPAY');
                if GenJnlBatch.Find('-') = false then begin
                    GenJnlBatch.Init;
                    GenJnlBatch."Journal Template Name" := 'GENERAL';
                    GenJnlBatch.Name := 'NETPAY';
                    GenJnlBatch.Insert;
                end;
                // End Create Batch

                // Clear the journal Lines
                GeneraljnlLine.SetRange(GeneraljnlLine."Journal Batch Name", 'NETPAY');
                if GeneraljnlLine.Find('-') then
                    GeneraljnlLine.DeleteAll;

                //"Slip/Receipt No":=UPPERCASE(objPeriod."Period Name");
                "Slip/Receipt No" := kk."Period Name";
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(Period; SelectedPeriod)
                {
                    ApplicationArea = Basic;
                    Caption = 'Period';
                    TableRelation = "Payroll Calender."."Date Opened";
                }
                field("Posting Date"; PostingDate)
                {
                    ApplicationArea = Basic;
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

    trigger OnPreReport()
    begin
        if SelectedPeriod = 0D then
            Error('Period Must Have a value:!');
        if PostingDate = 0D then
            Error('Posting Date Must Have a value:!');
        objPeriod.Reset;
        if objPeriod.Get(SelectedPeriod) then PeriodName := objPeriod."Period Name";
        //PostingDate:=CALCDATE('1M-1D',SelectedPeriod);

        if UserSetup.Get(UserId) then begin
            if UserSetup."View Payroll" = false then Error('You dont have permissions for payroll, Contact your system administrator! ')
        end;
    end;

    var
        PeriodTrans: Record "prPeriod Transactions.";
        objEmp: Record "Payroll Employee.";
        PeriodName: Text[30];
        PeriodFilter: Text[30];
        SelectedPeriod: Date;
        objPeriod: Record "Payroll Calender.";
        ControlInfo: Record "Control-Information.";
        strEmpName: Text[150];
        GeneraljnlLine: Record "Gen. Journal Line";
        GenJnlBatch: Record "Gen. Journal Batch";
        "Slip/Receipt No": Code[50];
        LineNumber: Integer;
        "Salary Card": Record "Payroll Employee.";
        TaxableAmount: Decimal;
        PostingGroup: Record "Payroll Posting Groups.";
        GlobalDim1: Code[10];
        GlobalDim2: Code[10];
        TransCode: Record "Payroll Transaction Code.";
        PostingDate: Date;
        AmountToDebit: Decimal;
        AmountToCredit: Decimal;
        IntegerPostAs: Integer;
        SaccoTransactionType: Option " ","Registration Fee","Loan Issue","Loan Repayment",Withdrawal,"Interest Due","Interest Paid","Normal Shares","Penalty Charged","Unallocated Funds","Share Capital",Dividend,"Penalty Paid","Partial Disbursement","Loan Due","PassBook Fee",Jipage,"Processing fees",Britam,"Rescheduling fees","Loan Insurance","Insurance Paid";
        EmployerDed: Record "Payroll Employer Deductions.";
        GlobalDim3: Code[10];
        kk: Record "Payroll Calender.";
        UserSetup: Record "User Setup";
        DocumentNo: Code[10];
        AccountType: Option Vendor;
        BalAccount: Code[10];
        FosaAccountNo: Code[100];


    procedure CreateJnlEntry(AccountType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Member,"None",Staff; TransPostingDate: Date; AccountNo: Code[20]; GlobalDime1: Code[20]; GlobalDime2: Code[20]; Description: Text[50]; DebitAmount: Decimal; CreditAmount: Decimal; PostAs: Option " ",Debit,Credit; LoanNo: Code[20]; TransType: Option " ","Registration Fee","Loan Issue","Loan Repayment",Withdrawal,"Interest Due","Interest Paid","Normal Shares","Penalty Charged","Unallocated Funds","Share Capital",Dividend,"Penalty Paid","Partial Disbursement","Loan Due","PassBook Fee",Jipage,"Processing fees",Britam,"Rescheduling fees","Loan Insurance","Insurance Paid"; Dim1: Code[100]; Dim2: Code[100])
    var
        BalAccountNo: Code[20];
    begin
        AccountType := Accounttype::Vendor;
        GlobalDime1 := 'BOSA';
        BalAccountNo := PostingGroup."Net Salary Payable";

        LineNumber := LineNumber + 100;
        GeneraljnlLine.Init;
        GeneraljnlLine."Journal Template Name" := 'GENERAL';
        GeneraljnlLine."Journal Batch Name" := 'NETPAY';
        GeneraljnlLine."Line No." := LineNumber;
        GeneraljnlLine."Document No." := 'NETPAY';
        GeneraljnlLine."Loan No" := LoanNo;
        GeneraljnlLine."Posting Date" := TransPostingDate;
        GeneraljnlLine."Account Type" := GeneraljnlLine."account type"::Vendor;
        GeneraljnlLine."Account No." := AccountNo;
        GeneraljnlLine.Validate(GeneraljnlLine."Account No.");
        GeneraljnlLine.Description := Description;
        if PostAs = Postas::Debit then begin
            GeneraljnlLine."Debit Amount" := DebitAmount;
            GeneraljnlLine.Validate("Debit Amount");
        end else begin
            GeneraljnlLine."Credit Amount" := CreditAmount;
            GeneraljnlLine.Validate("Credit Amount");
        end;
        GeneraljnlLine."Bal. Account Type" := GeneraljnlLine."bal. account type"::"G/L Account";
        GeneraljnlLine."Bal. Account No." := BalAccountNo;
        GeneraljnlLine.Validate(GeneraljnlLine."Account No.");
        GeneraljnlLine."Shortcut Dimension 1 Code" := Dim1;
        GeneraljnlLine.Validate(GeneraljnlLine."Shortcut Dimension 1 Code");
        GeneraljnlLine."Shortcut Dimension 2 Code" := Dim2;
        GeneraljnlLine.Validate(GeneraljnlLine."Shortcut Dimension 2 Code");
        if GeneraljnlLine.Amount <> 0 then
            GeneraljnlLine.Insert;
    end;
}

