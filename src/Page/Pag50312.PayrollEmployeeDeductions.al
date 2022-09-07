#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50312 "Payroll Employee Deductions."
{
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Payroll Employee Transactions.";
    SourceTableView = where("Transaction Type" = const(Deduction));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Transaction Code"; "Transaction Code")
                {
                    ApplicationArea = Basic;
                    TableRelation = "Payroll Transaction Code."."Transaction Code" where("Transaction Type" = const(Deduction));
                }
                field("Transaction Name"; "Transaction Name")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Type"; "Transaction Type")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Number"; "Loan Number")
                {
                    ApplicationArea = Basic;
                }
                field("Original Deduction Amount"; "Original Deduction Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Interest Charged"; "Interest Charged")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Amount; Amount)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Amount(LCY)"; "Amount(LCY)")
                {
                    ApplicationArea = Basic;
                }
                field("Amtzd Loan Repay Amt"; "Amtzd Loan Repay Amt")
                {
                    ApplicationArea = Basic;
                }
                field(Balance; Balance)
                {
                    ApplicationArea = Basic;
                }
                field("Balance(LCY)"; "Balance(LCY)")
                {
                    ApplicationArea = Basic;
                }
                field("Period Month"; "Period Month")
                {
                    ApplicationArea = Basic;
                }
                field("Period Year"; "Period Year")
                {
                    ApplicationArea = Basic;
                }
                field("Payroll Period"; "Payroll Period")
                {
                    ApplicationArea = Basic;
                }
                field("Original Amount"; "Original Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Outstanding Interest"; "Outstanding Interest")
                {
                    ApplicationArea = Basic;
                }
                field("Sacco Membership No."; "Sacco Membership No.")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        ObjPayrollCalender.Reset;
        ObjPayrollCalender.SetCurrentkey(ObjPayrollCalender."Date Opened");
        ObjPayrollCalender.SetRange(ObjPayrollCalender.Closed, false);
        if ObjPayrollCalender.FindLast then begin
            VarOpenPeriod := ObjPayrollCalender."Date Opened";
        end;

        SetFilter("Payroll Period", '%1', VarOpenPeriod);
    end;

    var
        ObjPayrollCalender: Record "Payroll Calender.";
        VarOpenPeriod: Date;
}

