#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
//50041_v6_3_0_2259) { }
// Autogenerated code - do not delete or modify -->

Report 50647 "update loans"
{
    RDLCLayout = 'Layouts/updateloans.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem(User; User)
        {
            column(ReportForNavId_1; 1) { } // Autogenerated by ForNav - Do not delete
            trigger OnAfterGetRecord();
            begin
                //	User."Authentication Type":=WorkDate;
                User.Modify;
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

    // --> Reports ForNAV Autogenerated code - do not delete or modify
    //50041_v6_3_0_2259;






    // Reports ForNAV Autogenerated code - do not delete or modify -->
}
