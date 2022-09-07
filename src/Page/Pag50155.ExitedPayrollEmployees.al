#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50155 "Exited Payroll Employees"
{
    CardPageID = "Payroll Employee Card.";
    DeleteAllowed = true;
    Editable = false;
    InsertAllowed = true;
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    RefreshOnActivate = true;
    SourceTable = "Payroll Employee.";
    SourceTableView = where("Date Exited" = filter(<> ''));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; "No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Staff  No.';
                }
                field("Payroll No"; "Payroll No")
                {
                    ApplicationArea = Basic;
                    Caption = 'Sacco Membership No.';
                }
                field(Surname; Surname)
                {
                    ApplicationArea = Basic;
                }
                field(Firstname; Firstname)
                {
                    ApplicationArea = Basic;
                }
                field(Lastname; Lastname)
                {
                    ApplicationArea = Basic;
                }
                field("Exit Staff"; "Exit Staff")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        ExitReasonVisible := false;
                        if "Exit Staff" = true then begin
                            ExitReasonVisible := true;
                        end;
                    end;
                }
                field("Joining Date"; "Joining Date")
                {
                    ApplicationArea = Basic;
                }
                field("Job Group"; "Job Group")
                {
                    ApplicationArea = Basic;
                }
                field(Category; Category)
                {
                    ApplicationArea = Basic;
                }
                field("Posting Group"; "Posting Group")
                {
                    ApplicationArea = Basic;
                }
                field("Pays PAYE"; "Pays PAYE")
                {
                    ApplicationArea = Basic;
                }
                field("Bank Account No"; "Bank Account No")
                {
                    ApplicationArea = Basic;
                }
                field("Employee Email"; "Employee Email")
                {
                    ApplicationArea = Basic;
                }
                field("Managerial Position"; "Managerial Position")
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control9; Outlook)
            {
            }
            systempart(Control10; Notes)
            {
            }
            systempart(Control11; MyNotes)
            {
            }
            systempart(Control12; Links)
            {
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(InsertSaccoDeductions)
            {
                ApplicationArea = Basic;
                Caption = 'Effect Sacco Deductions';
                Image = UpdateUnitCost;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    ObjPayrollCalender.Reset;
                    ObjPayrollCalender.SetCurrentkey(ObjPayrollCalender."Date Opened");
                    ObjPayrollCalender.SetRange(ObjPayrollCalender.Closed, false);
                    if ObjPayrollCalender.FindLast then begin
                        VarOpenPeriod := ObjPayrollCalender."Date Opened";
                    end;


                    //============================================Delete Entries For the Same Period
                    ObjEmployeeTransactions.Reset;
                    ObjEmployeeTransactions.SetRange(ObjEmployeeTransactions."Payroll Period", VarOpenPeriod);
                    if ObjEmployeeTransactions.FindSet then begin
                        ObjEmployeeTransactions.DeleteAll;
                    end;
                    //============================================Delete Entries For the Same Period



                    ObjPayrollEmployees.Reset;
                    ObjPayrollEmployees.SetRange(ObjPayrollEmployees.Status, ObjPayrollEmployees.Status::Active);
                    if ObjPayrollEmployees.Find('-') then begin
                        repeat
                            if not ObjPayrollEmployees."Suspend Pay" then begin


                                ObjPayrollCalender.Reset;
                                ObjPayrollCalender.SetCurrentkey(ObjPayrollCalender."Date Opened");
                                ObjPayrollCalender.SetRange(ObjPayrollCalender.Closed, false);
                                if ObjPayrollCalender.FindLast then begin
                                    VarOpenPeriod := ObjPayrollCalender."Date Opened";
                                end;


                                ObjPayrollEmployeeTransIII.Reset;
                                ObjPayrollEmployeeTransIII.SetRange(ObjPayrollEmployeeTransIII."No.", ObjPayrollEmployees."No.");
                                ObjPayrollEmployeeTransIII.SetRange(ObjPayrollEmployeeTransIII."Sacco Membership No.", '');
                                if ObjPayrollEmployeeTransIII.FindSet then begin
                                    repeat
                                        ObjPayrollEmployeeTransIII."Sacco Membership No." := ObjPayrollEmployees."Payroll No";
                                        ObjPayrollEmployeeTransIII.Modify;
                                    until ObjPayrollEmployeeTransIII.Next = 0;
                                end;

                                FnRunUpdateNewMemberLoans(ObjPayrollEmployees."Sacco Membership No.", ObjPayrollEmployees."No.");//==================================================================Insert Staff New Loans

                                ObjPayrollEmployeeTrans.Reset;
                                ObjPayrollEmployeeTrans.SetRange(ObjPayrollEmployeeTrans."Sacco Membership No.", ObjPayrollEmployees."Payroll No");
                                ObjPayrollEmployeeTrans.SetFilter(ObjPayrollEmployeeTrans."Payroll Period", '%1', VarOpenPeriod);
                                ObjPayrollEmployeeTrans.SetFilter(ObjPayrollEmployeeTrans."Loan Number", '<>%1', '');
                                if ObjPayrollEmployeeTrans.FindSet then begin
                                    repeat
                                        ObjPayrollEmployeeTrans.Amount := SFactory.FnRunLoanAmountDuePayroll(ObjPayrollEmployeeTrans."Loan Number");

                                        ObjPayrollEmployeeTrans.Modify;
                                    until ObjPayrollEmployeeTrans.Next = 0;
                                end;

                                FnRunInsertMonthlyDepositContribution(ObjPayrollEmployees."Sacco Membership No.", ObjPayrollEmployees."No.");

                            end;
                        until ObjPayrollEmployees.Next = 0;
                    end;

                    Message('Entries Updated Succesfully');
                end;
            }
            action("Process Payroll")
            {
                ApplicationArea = Basic;
                Image = Allocations;
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin

                    ContrInfo.Get;

                    objPeriod.Reset;
                    objPeriod.SetRange(objPeriod.Closed, false);
                    if objPeriod.Find('-') then begin
                        SelectedPeriod := objPeriod."Date Opened";
                        varPeriodMonth := objPeriod."Period Month";
                        SalCard.Get("No.");
                    end;

                    //For Multiple Payroll
                    if ContrInfo."Multiple Payroll" then begin
                        PayrollDefined := '';
                        PayrollType.Reset;
                        PayrollType.SetCurrentkey(EntryNo);
                        if PayrollType.FindFirst then begin
                            NoofRecords := PayrollType.Count;
                            i := 0;
                            repeat
                                i += 1;
                                PayrollDefined := PayrollDefined + '&' + PayrollType."Payroll Code";
                                if i < NoofRecords then
                                    PayrollDefined := PayrollDefined + ','
                            until PayrollType.Next = 0;
                        end;
                        //Selection := STRMENU(PayrollDefined,NoofRecords);

                        PayrollType.Reset;
                        PayrollType.SetRange(PayrollType.EntryNo, Selection);
                        if PayrollType.Find('-') then begin
                            PayrollCode := PayrollType."Payroll Code";
                        end;
                    end;

                    //Delete all Records from the prPeriod Transactions for Reprocessing
                    objPeriod.Reset;
                    objPeriod.SetRange(objPeriod.Closed, false);
                    if objPeriod.FindFirst then begin

                        //IF ContrInfo."Multiple Payroll" THEN BEGIN
                        ObjPayrollTransactions.Reset;
                        ObjPayrollTransactions.SetRange(ObjPayrollTransactions."Payroll Period", objPeriod."Date Opened");
                        if ObjPayrollTransactions.Find('-') then begin
                            ObjPayrollTransactions.DeleteAll;
                        end;
                    end;

                    PayrollEmployerDed.Reset;
                    PayrollEmployerDed.SetRange(PayrollEmployerDed."Payroll Period", SelectedPeriod);
                    if PayrollEmployerDed.Find('-') then
                        PayrollEmployerDed.DeleteAll;




                    if ContrInfo."Multiple Payroll" then
                        HrEmployee.Reset;
                    HrEmployee.SetRange(HrEmployee.Status, HrEmployee.Status::Active);
                    if HrEmployee.Find('-') then begin
                        ProgressWindow.Open('Processing Salary for Employee No. #1#######');
                        repeat
                            Sleep(100);
                            if not SalCard."Suspend Pay" then begin
                                ProgressWindow.Update(1, HrEmployee."No." + ':' + HrEmployee.Firstname + ' ' + HrEmployee.Lastname + ' ' + HrEmployee.Surname);
                                if SalCard.Get(HrEmployee."No.") then
                                    ProcessPayroll.fnProcesspayroll(HrEmployee."No.", HrEmployee."Joining Date", SalCard."Basic Pay", SalCard."Pays PAYE"
                                    , SalCard."Pays NSSF", SalCard."Pays NHIF", SelectedPeriod, SelectedPeriod, HrEmployee."No.", '',
                                    HrEmployee."Date of Leaving", true, HrEmployee."Branch Code", PayrollCode);
                                HrEmployee."Last Payroll Period" := SelectedPeriod;
                                HrEmployee.Modify;
                            end;
                        until HrEmployee.Next = 0;
                        ProgressWindow.Close;
                    end;
                    Message('Payroll processing completed successfully.');
                end;
            }
            action("View PaySlip")
            {
                ApplicationArea = Basic;
                Image = PaymentHistory;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    PayrollEmp.Reset;
                    PayrollEmp.SetRange(PayrollEmp."No.", "No.");
                    if PayrollEmp.FindFirst then begin
                        Report.Run(50009, true, false, PayrollEmp);
                    end;
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        ExitReasonVisible := false;
        BonusAmountVisible := false;
        if "Exit Staff" = true then begin
            ExitReasonVisible := true;
        end;

        if "Pay Bonus" = true then
            BonusAmountVisible := true;
    end;

    trigger OnAfterGetRecord()
    begin
        ExitReasonVisible := false;
        BonusAmountVisible := false;
        if "Exit Staff" = true then begin
            ExitReasonVisible := true;
        end;

        if "Pay Bonus" = true then
            BonusAmountVisible := true;
    end;

    trigger OnInit()
    begin
        //TODO
        if Usersetup.Get(UserId) then begin
            if Usersetup."View Payroll" = false then Error('You dont have permissions for payroll, Contact your system administrator! ')
        end;
    end;

    trigger OnOpenPage()
    begin
        ExitReasonVisible := false;
        BonusAmountVisible := false;
        if "Exit Staff" = true then begin
            ExitReasonVisible := true;
        end;

        if "Pay Bonus" = true then
            BonusAmountVisible := true;
    end;

    var
        Usersetup: Record "User Setup";
        ObjPayrollEmployeeTrans: Record "Payroll Employee Transactions.";
        SFactory: Codeunit "SURESTEP Factory";
        ObjPayrollCalender: Record "Payroll Calender.";
        VarOpenPeriod: Date;
        ObjLoans: Record "Loans Register";
        ObjPayrollEmployeeTransII: Record "Payroll Employee Transactions.";
        ObjTransactionCodes: Record "Payroll Transaction Code.";
        ObjPayrollEmployeeTransIII: Record "Payroll Employee Transactions.";
        ObjTransactionCodesII: Record "Payroll Transaction Code.";
        ObjLoanRepaymentSchedule: Record "Loan Repayment Schedule Buffer";
        VarAmortizationAmount: Decimal;
        ObjPayrollEmployees: Record "Payroll Employee.";
        ProgressWindow: Dialog;
        ObjEmployeeTransactions: Record "Payroll Employee Transactions.";
        ExitReasonVisible: Boolean;
        PayrollEmp: Record "Payroll Employee.";
        PayrollManager: Codeunit "Payroll Management";
        "Payroll Period": Date;
        PayrollCalender: Record "Payroll Calender.";
        PayrollMonthlyTrans: Record "Payroll Monthly Transactions.";
        PayrollEmployeeDed: Record "Payroll Employee Deductions.";
        PayrollEmployerDed: Record "Payroll Employer Deductions.";
        objEmp: Record "Salary Processing Header";
        SalCard: Record "Payroll Employee.";
        objPeriod: Record "Payroll Calender.";
        SelectedPeriod: Date;
        PeriodName: Text[30];
        PeriodMonth: Integer;
        PeriodYear: Integer;
        ProcessPayroll: Codeunit "Payroll Processing";
        HrEmployee: Record "Payroll Employee.";
        prPeriodTransactions: Record "prPeriod Transactions..";
        prEmployerDeductions: Record "Payroll Employer Deductions.";
        PayrollType: Record "Payroll Type.";
        Selection: Integer;
        PayrollDefined: Text[30];
        PayrollCode: Code[10];
        NoofRecords: Integer;
        i: Integer;
        ContrInfo: Record "Control-Information.";
        ObjPayrollTransactions: Record "prPeriod Transactions.";
        varPeriodMonth: Integer;
        BonusAmountVisible: Boolean;

    local procedure FnRunUpdateNewMemberLoans(VarMemberNo: Code[30]; VarPayollNo: Code[30])
    var
        VarOpenPeriod: Date;
        VarPeriodMonth: Integer;
        VarPeriodYear: Integer;
    begin
        ObjPayrollCalender.Reset;
        ObjPayrollCalender.SetCurrentkey(ObjPayrollCalender."Date Opened");
        ObjPayrollCalender.SetRange(ObjPayrollCalender.Closed, false);
        if ObjPayrollCalender.FindLast then begin
            VarOpenPeriod := ObjPayrollCalender."Date Opened";
            VarPeriodMonth := Date2dmy(VarOpenPeriod, 2);
            VarPeriodYear := Date2dmy(VarOpenPeriod, 3);
        end;


        ObjLoans.CalcFields(ObjLoans."Outstanding Balance");
        ObjLoans.Reset;
        ObjLoans.SetRange(ObjLoans."Client Code", VarMemberNo);
        ObjLoans.SetFilter(ObjLoans."Outstanding Balance", '>%1', 0);
        if ObjLoans.FindSet then begin
            repeat
                ObjLoans.CalcFields(ObjLoans."Outstanding Balance");
                ObjTransactionCodesII.Reset;
                ObjTransactionCodesII.SetRange(ObjTransactionCodesII."Loan Product", ObjLoans."Loan Product Type");
                if ObjTransactionCodesII.Find('-') = false then begin
                    FnRunCreateLoanProductinTransactionCodes(ObjLoans."Loan Product Type", ObjLoans.Interest, ObjLoans."Loan Product Type Name");//=================Create New Transaction Code
                end;

                ObjPayrollEmployeeTrans.Reset;
                ObjPayrollEmployeeTrans.SetRange(ObjPayrollEmployeeTrans."Sacco Membership No.", VarMemberNo);
                ObjPayrollEmployeeTrans.SetRange(ObjPayrollEmployeeTrans."Loan Number", ObjLoans."Loan  No.");
                ObjPayrollEmployeeTrans.SetFilter(ObjPayrollEmployeeTrans."Payroll Period", '%1', VarOpenPeriod);
                if ObjPayrollEmployeeTrans.Find('-') = false then begin
                    ObjTransactionCodes.Reset;
                    ObjTransactionCodes.SetRange(ObjTransactionCodes."Loan Product", ObjLoans."Loan Product Type");
                    if ObjTransactionCodes.FindSet then begin


                        ObjPayrollEmployeeTransII.Init;
                        ObjPayrollEmployeeTransII."Sacco Membership No." := ObjLoans."Client Code";
                        ObjPayrollEmployeeTransII."No." := VarPayollNo;
                        ObjPayrollEmployeeTransII."Loan Number" := ObjLoans."Loan  No.";
                        ObjPayrollEmployeeTransII."Transaction Code" := ObjTransactionCodes."Transaction Code";
                        ObjPayrollEmployeeTransII."Transaction Name" := ObjTransactionCodes."Transaction Name";
                        ObjPayrollEmployeeTransII."Transaction Type" := ObjTransactionCodes."Transaction Type";
                        ObjPayrollEmployeeTransII."Payroll Period" := VarOpenPeriod;
                        ObjPayrollEmployeeTransII."Period Month" := VarPeriodMonth;
                        ObjPayrollEmployeeTransII."Period Year" := VarPeriodYear;
                        ObjPayrollEmployeeTransII.Balance := ObjLoans."Outstanding Balance";
                        ObjPayrollEmployeeTransII."Balance(LCY)" := ObjLoans."Outstanding Balance";
                        ObjPayrollEmployeeTransII."Amtzd Loan Repay Amt" := VarAmortizationAmount;
                        ObjPayrollEmployeeTransII.Insert;

                    end;
                end;
            until ObjLoans.Next = 0;
        end;
    end;

    local procedure FnRunCreateLoanProductinTransactionCodes(VarLoanType: Text[100]; VarInterestRate: Decimal; VarLoanProductName: Text[100])
    var
        VarTransactionCode: Code[30];
    begin
        ObjTransactionCodes.Reset;
        ObjTransactionCodes.SetCurrentkey(ObjTransactionCodes."Transaction Code");
        ObjTransactionCodes.SetRange(ObjTransactionCodes."Transaction Type", ObjTransactionCodes."transaction type"::Deduction);
        if ObjTransactionCodes.FindLast then begin
            VarTransactionCode := IncStr(ObjTransactionCodes."Transaction Code");
        end;

        ObjTransactionCodes.Init;
        ObjTransactionCodes."Transaction Code" := VarTransactionCode;
        ObjTransactionCodes."Transaction Name" := VarLoanProductName;
        ObjTransactionCodes."Transaction Type" := ObjTransactionCodes."transaction type"::Deduction;
        ObjTransactionCodes."Balance Type" := ObjTransactionCodes."balance type"::Reducing;
        ObjTransactionCodes.Frequency := ObjTransactionCodes.Frequency::Fixed;
        ObjTransactionCodes."Special Transaction" := ObjTransactionCodes."special transaction"::"Staff Loan";
        ObjTransactionCodes."Interest Rate" := VarInterestRate;
        ObjTransactionCodes."Repayment Method" := ObjTransactionCodes."repayment method"::Amortized;
        ObjTransactionCodes."Customer Posting Group" := 'MEMBER';
        ObjTransactionCodes.SubLedger := ObjTransactionCodes.SubLedger;
        ObjTransactionCodes."Loan Product" := VarLoanType;
        ObjTransactionCodes."Loan Product Name" := VarLoanProductName;
        ObjTransactionCodes.Insert;
    end;

    local procedure FnRunInsertMonthlyDepositContribution(VarMemberNo: Code[30]; VarPayrollNo: Code[30])
    var
        ObjCust: Record "Members Register";
        VarOpenPeriod: Date;
        VarPeriodMonth: Integer;
        VarPeriodYear: Integer;
        VarDepositBal: Decimal;
    begin
        ObjPayrollCalender.Reset;
        ObjPayrollCalender.SetCurrentkey(ObjPayrollCalender."Date Opened");
        ObjPayrollCalender.SetRange(ObjPayrollCalender.Closed, false);
        if ObjPayrollCalender.FindLast then begin
            VarOpenPeriod := ObjPayrollCalender."Date Opened";
            VarPeriodMonth := Date2dmy(VarOpenPeriod, 2);
            VarPeriodYear := Date2dmy(VarOpenPeriod, 3);
        end;

        ObjTransactionCodes.Reset;
        ObjTransactionCodes.SetRange(ObjTransactionCodes."Co-Op Parameters", ObjTransactionCodes."co-op parameters"::Shares);
        if ObjTransactionCodes.FindSet then begin

            if ObjCust.Get(VarMemberNo) then begin
                ObjCust.CalcFields(ObjCust."Current Shares");

                ObjPayrollEmployeeTransII.Init;
                ObjPayrollEmployeeTransII."Sacco Membership No." := VarMemberNo;
                ObjPayrollEmployeeTransII."No." := VarPayrollNo;
                ObjPayrollEmployeeTransII."Loan Number" := '';
                ObjPayrollEmployeeTransII."Transaction Code" := ObjTransactionCodes."Transaction Code";
                ObjPayrollEmployeeTransII."Transaction Name" := ObjTransactionCodes."Transaction Name";
                ObjPayrollEmployeeTransII."Transaction Type" := ObjTransactionCodes."Transaction Type";
                ObjPayrollEmployeeTransII."Payroll Period" := VarOpenPeriod;
                ObjPayrollEmployeeTransII."Period Month" := VarPeriodMonth;
                ObjPayrollEmployeeTransII."Period Year" := VarPeriodYear;
                ObjPayrollEmployeeTransII.Amount := SFactory.FnGetMemberMonthlyContributionDepositstier(ObjCust."No.");
                ObjPayrollEmployeeTransII."Amount(LCY)" := SFactory.FnGetMemberMonthlyContributionDepositstier(ObjCust."No.");
                ObjPayrollEmployeeTransII.Balance := ObjCust."Current Shares";
                ObjPayrollEmployeeTransII."Balance(LCY)" := ObjCust."Current Shares";
                ObjPayrollEmployeeTransII."Amtzd Loan Repay Amt" := 0;
                ObjPayrollEmployeeTransII.Insert;
            end;
        end;
    end;
}

