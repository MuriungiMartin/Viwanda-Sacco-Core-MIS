#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
//51516353_v6_3_0_2259) { }
// Autogenerated code - do not delete or modify -->

Report 50353 "Validate Salary Data-Pension"
{
    RDLCLayout = 'Layouts/ValidateSalaryData-Pension.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Pension Processing Lines"; "Pension Processing Lines")
        {
            RequestFilterFields = "Salary Header No.", "Account No.";
            column(ReportForNavId_1000000000; 1000000000) { } // Autogenerated by ForNav - Do not delete
            trigger OnAfterGetRecord();
            begin
                Vendor.Reset;
                Vendor.SetRange(Vendor."Pension No", "Pension No"); //"Account No."
                                                                    //Vendor.SETRANGE(Vendor."Global Dimension 2 Code","Global Dimension 2 Code");
                                                                    //Vendor.SETRANGE(Vendor."Employer Code","Employer Code");
                if Vendor.Find('-') then begin
                    "Account No." := Vendor."No.";
                    "Account Name" := Vendor.Name;
                    "Global Dimension 2 Code" := Vendor."Global Dimension 2 Code";
                    "Bosa No" := Vendor."BOSA Account No";
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
        Vendor: Record Vendor;

    // --> Reports ForNAV Autogenerated code - do not delete or modify
    //51516353_v6_3_0_2259;






    // Reports ForNAV Autogenerated code - do not delete or modify -->
}
