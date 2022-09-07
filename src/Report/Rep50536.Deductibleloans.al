
Report 50536 "Deductible loans"
{
    RDLCLayout = 'Layouts/Deductibleloans.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Loans Register"; "Loans Register")
        {
            trigger OnAfterGetRecord();
            begin
                Setup.Reset;
                Setup.SetRange(Setup.Code, "Loan Product Type");
                if Setup.Find('-') then begin
                    Deductible := Setup.Deductible;
                    Modify;
                end;
                //MESSAGE('Success');
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
        Setup: Record "Loan Products Setup";

    var
}
