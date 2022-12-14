#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
//50024_v6_3_0_2259) { }
// Autogenerated code - do not delete or modify -->

Report 50635 "Payroll Employees"
{
    RDLCLayout = 'Layouts/PayrollEmployees.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Payroll Employee."; "Payroll Employee.")
        {
            column(ReportForNavId_1; 1) { } // Autogenerated by ForNav - Do not delete
            trigger OnAfterGetRecord();
            begin
                ObjAccount.Reset;
                ObjAccount.SetRange(ObjAccount."BOSA Account No", "Payroll No");
                ObjAccount.SetRange(ObjAccount."Account Type", '507');
                if ObjAccount.FindSet then begin
                    "Loan Settlement Account" := ObjAccount."No.";
                    Modify;
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
            //:= false;
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
        ObjAccount: Record Vendor;

    // --> Reports ForNAV Autogenerated code - do not delete or modify
    //50024_v6_3_0_2259;






    // Reports ForNAV Autogenerated code - do not delete or modify -->
}
