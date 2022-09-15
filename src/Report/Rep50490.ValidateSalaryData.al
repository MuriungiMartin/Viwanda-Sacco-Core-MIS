#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 //  settings

Report 50490 "Validate Salary Data"
{
    RDLCLayout = 'Layouts/ValidateSalaryData.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Salary Processing Lines"; "Salary Processing Lines")
        {
            RequestFilterFields = "Salary Header No.", "Account No.";
            trigger OnAfterGetRecord();
            begin
                Vendor.Reset;
                Vendor.SetRange(Vendor."Personal No.", "Staff No."); //"Account No."
                                                                     //Vendor.SETRANGE(Vendor."Global Dimension 2 Code","Global Dimension 2 Code");
                Vendor.SetRange(Vendor."Employer Code", "Employer Code");
                //Vendor.SETRANGE(Vendor."Account Type",'ORDINARY');
                if Vendor.Find('-') then begin
                    "Account No." := Vendor."No.";
                    "Account Name" := Vendor.Name;
                    "Global Dimension 2 Code" := Vendor."Global Dimension 2 Code";
                    "BOSA No" := Vendor."BOSA Account No";
                    Modify;
                end;
                //Get BOSA No
                Cust.Reset;
                Cust.SetRange(Cust."Payroll No", "Staff No."); //"Account No."
                Cust.SetRange(Cust."Employer Code", "Employer Code");
                if Cust.Find('-') then begin
                    "BOSA No" := Cust."No.";
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
        Cust: Record Customer;


    var

}
