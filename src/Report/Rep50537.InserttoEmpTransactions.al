
Report 50537 "Insert to Emp Transactions"
{
    RDLCLayout = 'Layouts/InserttoEmpTransactions.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Loans Register"; "Loans Register")
        {

            column(LoanNo; "Loans Register"."Loan  No.")
            {
            }
            column(ProductType; "Loans Register"."Loan Product Type")
            {
            }
            trigger OnAfterGetRecord();
            begin
                "Loans Register".Reset;
                if "Loans Register".Deductible = true then begin
                    Transaction.Reset;
                    Transaction.SetRange(Transaction."Loan Product", "Loans Register"."Loan Product Type");
                    if Transaction.Find('-') then
                        TCode := Transaction."Transaction Code";
                    Tname := Transaction."Transaction Name";
                    TType := Transaction."Transaction Type";
                    //EmpTrans.SETRANGE(EmpTrans."No.",Employees."No.");
                    Employees.Reset;
                    if not Employees.Get("Loans Register"."Client Code") then CurrReport.Skip;
                    repeat
                        EmpTrans.Init;
                        EmpTrans."Transaction Code" := TCode;
                        EmpTrans."No." := "Loans Register"."Client Code";
                        EmpTrans.Insert;
                    until EmpTrans.Next = 0;
                    EmpTrans.Reset;
                    EmpTrans.SetRange(EmpTrans."No.", "Loans Register"."Client Code");
                    if EmpTrans.Find('-') then begin
                        EmpTrans."Loan Number" := "Loans Register"."Loan  No.";
                        EmpTrans.Modify;
                    end;
                end;
            end;

        }
    }

    requestpage
    {


        SaveValues = false;
        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                }
            }
        }

        actions
        {
        }
        trigger OnOpenPage()
        begin

        end;
    }

    trigger OnInitReport()
    begin
        ;


    end;

    trigger OnPostReport()
    begin
        ;

    end;

    trigger OnPreReport()
    begin
        ;
    end;

    var
        Loans: Record "Loans Register";
        Transaction: Record "Payroll Transaction Code.";
        LoanType: Code[30];
        TCode: Code[30];
        Tname: Text;
        TType: Option Income,Deduction;
        LoanSetup: Record "Loan Products Setup";
        Deductable: Boolean;
        EmpTrans: Record "Payroll Employee Transactions.";
        Employees: Record "Payroll Employee.";

    var
}
