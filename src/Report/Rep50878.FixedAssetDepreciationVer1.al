#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Report 50878 "Fixed Asset Depreciation Ver1"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("FA Depreciation Book"; "FA Depreciation Book")
        {
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnPreDataItem()
            begin
                SFactory.FnRunProcessAssetDepreciationCustom;
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
        ObjCust: Record Customer;
        SFactory: Codeunit "SURESTEP Factory";
}

