
Report 50538 "Ded"
{
    RDLCLayout = 'Layouts/Ded.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Payroll Employee Transactions."; "Payroll Employee Transactions.")
        {
            trigger OnAfterGetRecord();
            begin
                C := 11;
                "Payroll Employee Transactions."."Period Month" := C;
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
        C: Integer;

    var
}