#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50310 "Payroll Employee Card."
{
    DeleteAllowed = false;
    InsertAllowed = true;
    PageType = Card;
    SourceTable = "Payroll Employee.";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; "No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Staff No';
                }
                field("Payroll No"; "Payroll No")
                {
                    ApplicationArea = Basic;
                    Caption = 'Sacco Member No.';
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
                field("Employee Email"; "Employee Email")
                {
                    ApplicationArea = Basic;
                }
                field("Joining Date"; "Joining Date")
                {
                    ApplicationArea = Basic;
                }
                field("Currency Code"; "Currency Code")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Global Dimension 1"; "Global Dimension 1")
                {
                    ApplicationArea = Basic;
                }
                field("Global Dimension 2"; "Global Dimension 2")
                {
                    ApplicationArea = Basic;
                }
                field("Posting Group"; "Posting Group")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Status)
                {
                    ApplicationArea = Basic;
                }
                field("National ID No"; "National ID No")
                {
                    ApplicationArea = Basic;
                }
                field("NSSF No"; "NSSF No")
                {
                    ApplicationArea = Basic;
                }
                field("NHIF No"; "NHIF No")
                {
                    ApplicationArea = Basic;
                }
                field("PIN No"; "PIN No")
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
                field(Department; Department)
                {
                    ApplicationArea = Basic;
                }
                field("Managerial Position"; "Managerial Position")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Pay Details")
            {
                field("Basic Pay"; "Basic Pay")
                {
                    ApplicationArea = Basic;
                }
                field("Paid per Hour"; "Paid per Hour")
                {
                    ApplicationArea = Basic;
                }
                field("Pays PAYE"; "Pays PAYE")
                {
                    ApplicationArea = Basic;
                }
                field("Pays NSSF"; "Pays NSSF")
                {
                    ApplicationArea = Basic;
                }
                field("Pays NHIF"; "Pays NHIF")
                {
                    ApplicationArea = Basic;
                }
                field("Payment Mode"; "Payment Mode")
                {
                    ApplicationArea = Basic;
                }
                field("Insurance Premium"; "Insurance Premium")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Bank Details")
            {
                field("Bank Code"; "Bank Code")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Bank Name"; "Bank Name")
                {
                    ApplicationArea = Basic;
                }
                field("Branch Code"; "Branch Code")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Branch Name"; "Branch Name")
                {
                    ApplicationArea = Basic;
                }
                field("Bank Account No"; "Bank Account No")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Settlement Account"; "Loan Settlement Account")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Other Details")
            {
                field("Payslip Message"; "Payslip Message")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Cummulative Figures")
            {
                Editable = false;
                field("Cummulative Basic Pay"; "Cummulative Basic Pay")
                {
                    ApplicationArea = Basic;
                }
                field("Cummulative Gross Pay"; "Cummulative Gross Pay")
                {
                    ApplicationArea = Basic;
                }
                field("Cummulative Allowances"; "Cummulative Allowances")
                {
                    ApplicationArea = Basic;
                }
                field("Cummulative Deductions"; "Cummulative Deductions")
                {
                    ApplicationArea = Basic;
                }
                field("Cummulative Net Pay"; "Cummulative Net Pay")
                {
                    ApplicationArea = Basic;
                }
                field("Cummulative PAYE"; "Cummulative PAYE")
                {
                    ApplicationArea = Basic;
                }
                field("Cummulative NSSF"; "Cummulative NSSF")
                {
                    ApplicationArea = Basic;
                }
                field("Cummulative Pension"; "Cummulative Pension")
                {
                    ApplicationArea = Basic;
                }
                field("Cummulative HELB"; "Cummulative HELB")
                {
                    ApplicationArea = Basic;
                }
                field("Cummulative NHIF"; "Cummulative NHIF")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Suspension of Payment")
            {
                field("Suspend Pay"; "Suspend Pay")
                {
                    ApplicationArea = Basic;
                }
                field("Suspend Date"; "Suspend Date")
                {
                    ApplicationArea = Basic;
                }
                field("Suspend Reason"; "Suspend Reason")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Staff Existing Details")
            {
                field("Exit Staff"; "Exit Staff")
                {
                    ApplicationArea = Basic;
                }
                field("Date Exited"; "Date Exited")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Exited By"; "Exited By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Reason For Exiting Staff"; "Reason For Exiting Staff")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Employee Earnings")
            {
                ApplicationArea = Basic;
                Image = AllLines;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = Page "Payroll Employee Earnings.";
                RunPageLink = "No." = field("No.");
                RunPageView = where("Transaction Type" = filter(Income));
            }
            action("Employee Deductions")
            {
                ApplicationArea = Basic;
                Image = EntriesList;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = Page "Payroll Employee Deductions.";
                RunPageLink = "No." = field("No."),
                              "Sacco Membership No." = field("Payroll No");
                RunPageView = where("Transaction Type" = filter(Deduction));
            }
            action("Employee Assignments")
            {
                ApplicationArea = Basic;
                Image = Apply;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = Page "Payroll Employee Assignments.";
                RunPageLink = "No." = field("No.");
            }
            action("Employee Cummulatives")
            {
                ApplicationArea = Basic;
                Image = History;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = Page "Payroll Employee Cummulatives.";
                RunPageLink = "No." = field("No.");
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
            action("Process Payroll")
            {
                ApplicationArea = Basic;
                Image = Allocations;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin

                    //ContrInfo.GET;

                    objPeriod.Reset;
                    objPeriod.SetRange(objPeriod.Closed, false);
                    if objPeriod.Find('-') then;
                    SelectedPeriod := objPeriod."Date Opened";
                    //MESSAGE('SelectedPeriod IS%1',SelectedPeriod);
                    SalCard.Get("No.");


                    //For Multiple Payroll
                    /*IF ContrInfo."Multiple Payroll" THEN BEGIN
                    PayrollDefined:='';
                    PayrollType.RESET;
                    PayrollType.SETCURRENTKEY(EntryNo);
                    IF PayrollType.FINDFIRST THEN BEGIN
                        NoofRecords:=PayrollType.COUNT;
                        i:=0;
                        REPEAT
                          i+= 1;
                          PayrollDefined:=PayrollDefined+'&'+PayrollType."Payroll Code";
                          IF i<NoofRecords THEN
                             PayrollDefined:=PayrollDefined+','
                        UNTIL PayrollType.NEXT=0;
                    END;
                    
                    
                            Selection := STRMENU(PayrollDefined,NoofRecords);
                            PayrollType.RESET;
                            PayrollType.SETRANGE(PayrollType.EntryNo,Selection);
                            IF PayrollType.FIND('-') THEN BEGIN
                                PayrollCode:=PayrollType."Payroll Code";
                            END;
                    END;
                    //End Multiple Payroll*/

                    //Delete all Records from the prPeriod Transactions for Reprocessing
                    prPeriodTransactions.Reset;
                    //prPeriodTransactions.SETRANGE(prPeriodTransactions."Employee Code",strEmpCode);
                    //IF ContrInfo."Multiple Payroll" THEN
                    prPeriodTransactions.SetRange(prPeriodTransactions."Payroll Code", PayrollCode);
                    prPeriodTransactions.SetRange(prPeriodTransactions."Payroll Period", SelectedPeriod);
                    if prPeriodTransactions.Find('-') then
                        prPeriodTransactions.DeleteAll;

                    PayrollEmp.Reset;
                    PayrollEmp.SetRange(PayrollEmp.Status, PayrollEmp.Status::Active);
                    PayrollEmp.SetRange(PayrollEmp."Suspend Pay", false);
                    if PayrollEmp.FindSet then begin
                        // ProgressWindow.OPEN('Processing Salary for Employee No. #1#######');
                        repeat
                            PayrollEmp.TestField(PayrollEmp."Posting Group");
                            PayrollEmp.TestField(PayrollEmp."Joining Date");
                            PayrollEmp.TestField(PayrollEmp."Basic Pay");
                            PayrollEmp.TestField(PayrollEmp."PIN No");
                            PayrollEmp.TestField(PayrollEmp."NHIF No");
                            PayrollEmp.TestField(PayrollEmp."NSSF No");

                            //First Remove Any transactions for this Month
                            RemoveTrans(PayrollEmp."No.", "Payroll Period");
                        until PayrollEmp.Next = 0;
                    end;



                    //Delete all Records from prEmployer Deductions
                    prEmployerDeductions.Reset;
                    //prEmployerDeductions.SETRANGE(prEmployerDeductions."Employee Code",strEmpCode);
                    //IF ContrInfo."Multiple Payroll" THEN
                    prEmployerDeductions.SetRange(prEmployerDeductions."Payroll Code", PayrollCode);
                    prEmployerDeductions.SetRange(prEmployerDeductions."Payroll Period", SelectedPeriod);
                    if prEmployerDeductions.Find('-') then
                        prEmployerDeductions.DeleteAll;

                    //Use CODEUNIT
                    HrEmployee.Reset;
                    HrEmployee.SetRange(HrEmployee.Status, HrEmployee.Status::Active);
                    if ContrInfo."Multiple Payroll" then
                        HrEmployee.SetRange(HrEmployee."No.", PayrollCode);

                    if HrEmployee.Find('-') then begin

                        ProgressWindow.Open('Processing Salary for Employee No. #1#######');
                        repeat

                            Sleep(100);

                            //Suspended
                            //IF NOT SalCard."Suspend Pay" THEN BEGIN
                            ProgressWindow.Update(1, HrEmployee."No." + ':' + HrEmployee.Firstname + ' ' + HrEmployee.Lastname + ' ' + HrEmployee.Surname);
                            if SalCard.Get(HrEmployee."No.") then
                                ProcessPayroll.fnProcesspayroll(HrEmployee."No.", HrEmployee."Joining Date", SalCard."Basic Pay", SalCard."Pays PAYE"
                                    , SalCard."Pays NSSF", SalCard."Pays NHIF", SelectedPeriod, SelectedPeriod, '', '',
                                   HrEmployee."Date of Leaving", true, HrEmployee."Global Dimension 1", PayrollCode)//,HrEmployee."Global Dimension 1",HrEmployee."Global Dimension 2 Code");

                       until HrEmployee.Next = 0;
                        ////Progress Window
                        ProgressWindow.Close;
                    end;







                    Message('Payroll processing completed successfully.');

                end;
            }
        }
    }

    trigger OnInit()
    begin
        //TODO
        /*IF UserSetup.GET(USERID) THEN
        BEGIN
        IF UserSetup."View Payroll"=FALSE THEN ERROR ('You dont have permissions for payroll, Contact your system administrator! ')
        END;*/

    end;

    var
        PayrollEmp: Record "Payroll Employee.";
        // PayrollManager: Codeunit "Payroll Management";
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
        ProgressWindow: Dialog;
        prPeriodTransactions: Record "prPeriod Transactions.";
        prEmployerDeductions: Record "Payroll Employer Deductions.";
        PayrollType: Record "Payroll Type.";
        Selection: Integer;
        PayrollDefined: Text[30];
        PayrollCode: Code[10];
        NoofRecords: Integer;
        i: Integer;
        ContrInfo: Record "Control-Information.";
        UserSetup: Record "User Setup";
        ObjPayrollTransactions: Record "prPeriod Transactions.";
        varPeriodMonth: Integer;
        ObjPayrollEmployees: Record "Payroll Employee.";

    local procedure RemoveTrans(EmpNo: Code[20]; PayrollPeriod: Date)
    begin
    end;

    local procedure FnRunCreatePayrollSummary()
    var
        ObjPayrollTranS: Record "prPeriod Transactions Summary";
        ObjPeriodTrans: Record "prPeriod Transactions.";
        ObjPeriodTransII: Record "prPeriod Transactions.";
        VarPeriodAmount: Decimal;
    begin
        objPeriod.Reset;
        objPeriod.SetRange(objPeriod.Closed, false);
        if objPeriod.Find('-') then begin
            SelectedPeriod := objPeriod."Date Opened";
            varPeriodMonth := objPeriod."Period Month";
            SalCard.Get("No.");
        end;


        ObjPayrollTranS.Reset;
        ObjPayrollTranS.SetRange(ObjPayrollTranS."Payroll Period", objPeriod."Date Opened");
        if ObjPayrollTranS.Find('-') then begin
            ObjPayrollTranS.DeleteAll;
        end;

        VarPeriodAmount := 0;
        ObjPeriodTrans.Reset;
        ObjPeriodTrans.SetRange(ObjPeriodTrans."Employee Code", "No.");
        ObjPeriodTrans.SetRange(ObjPeriodTrans."Payroll Period", SelectedPeriod);
        ObjPeriodTrans.SetFilter(ObjPeriodTrans."Transaction Code", ObjPeriodTransII."Transaction Code");
        if ObjPeriodTrans.Find('-') then begin
            repeat
                ObjPeriodTrans.CalcSums(ObjPeriodTrans.Amount);
                VarPeriodAmount := ObjPeriodTrans.Amount;

                ObjPayrollTranS.Init;
                ObjPayrollTranS."Document Code" := '';
                ObjPayrollTranS."Transaction Code" := ObjPeriodTrans."Transaction Code";
                ObjPayrollTranS."Period Month" := ObjPeriodTrans."Period Month";
                ObjPayrollTranS."Period Year" := ObjPeriodTrans."Period Year";
                ObjPayrollTranS."Reference No" := ObjPeriodTrans."Reference No";
                ObjPayrollTranS."Group Order" := ObjPeriodTrans."Group Order";
                ObjPayrollTranS."Group Text" := ObjPeriodTrans."Group Text";
                ObjPayrollTranS."Transaction Name" := ObjPeriodTrans."Transaction Name";
                ObjPayrollTranS.Amount := VarPeriodAmount;
                ObjPayrollTranS."Sub Group Order" := ObjPeriodTrans."Sub Group Order";
                ObjPayrollTranS."Payroll Period" := ObjPeriodTrans."Payroll Period";
                ObjPayrollTranS."GL Account" := ObjPeriodTrans."GL Account";
                ObjPayrollTranS."Journal Account Code" := ObjPeriodTrans."Journal Account Code";
                ObjPayrollTranS."Journal Account Type" := ObjPeriodTrans."Journal Account Type";
                ObjPayrollTranS."Post As" := ObjPeriodTrans."Post As";
                ObjPayrollTranS."coop parameters" := ObjPeriodTrans."coop parameters";
                ObjPayrollTranS."Payroll Code" := ObjPeriodTrans."Payroll Code";
                ObjPayrollTranS."Fosa Account No." := ObjPeriodTrans."Fosa Account No.";
                ObjPayrollTranS."Sacco Member No" := ObjPeriodTrans."Sacco Member No";
                ObjPayrollTranS.Insert;
            until ObjPeriodTrans.Next = 0;
        end;
    end;
}

