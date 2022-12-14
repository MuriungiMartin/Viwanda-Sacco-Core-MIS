#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
//51516860_v6_3_0_2259) { }
// Autogenerated code - do not delete or modify -->

Report 50860 "Unblock Blocked Accounts"
{
    RDLCLayout = 'Layouts/UnblockBlockedAccounts.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Salary Processing Lines"; "Salary Processing Lines")
        {
            RequestFilterFields = "Salary Header No.", "Account No.";
            column(ReportForNavId_1000000000; 1000000000) { } // Autogenerated by ForNav - Do not delete
            trigger OnAfterGetRecord();
            begin
                Vendor.Reset;
                Vendor.SetRange(Vendor."No.", "Account No."); //"Account No."
                Vendor.SetRange(Vendor.Blocked, Vendor.Blocked::All);
                if Vendor.Find('-') then begin
                    Vendor."Prevous Blocked Status" := Vendor.Blocked;
                    Vendor.Blocked := Vendor.Blocked::" ";

                    Vendor.Modify;
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
        Cust: Record Customer;

    // --> Reports ForNAV Autogenerated code - do not delete or modify
    //51516860_v6_3_0_2259;






    // Reports ForNAV Autogenerated code - do not delete or modify -->
}
