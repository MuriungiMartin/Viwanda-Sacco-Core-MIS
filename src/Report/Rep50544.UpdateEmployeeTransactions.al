
Report 50544 "Update Employee Transactions"
{
    RDLCLayout = 'Layouts/UpdateEmployeeTransactions.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Payroll Employee Transactions."; "Payroll Employee Transactions.")
        {

            trigger OnAfterGetRecord();
            begin
                Transction.Reset;
                if Transction.Get("Payroll Employee Transactions."."Transaction Code") then
                    "Payroll Employee Transactions."."Transaction Type" := Transction."Transaction Type";
                "Payroll Employee Transactions.".Modify;
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
        Transction: Record "Payroll Transaction Code.";

    var
}

