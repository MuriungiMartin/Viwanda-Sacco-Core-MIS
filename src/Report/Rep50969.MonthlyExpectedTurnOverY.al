#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Report 50969 "Monthly Expected TurnOver(Y)"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(Customer; Customer)
        {
            RequestFilterFields = "No.", "Insider Status";
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnAfterGetRecord()
            begin
                SFactory.FnRunGetMemberExpectedMonthlyTurnover("No.");
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        SFactory: Codeunit "SURESTEP Factory";
        ObjAccounts: Record Vendor;
        VarDateFilter: Text;
}

