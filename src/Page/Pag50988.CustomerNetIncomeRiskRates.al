#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50988 "Customer Net Income Risk Rates"
{
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Customer Net Income Risk Rates";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Min Monthly Income"; "Min Monthly Income")
                {
                    ApplicationArea = Basic;
                }
                field("Max Monthlyl Income"; "Max Monthlyl Income")
                {
                    ApplicationArea = Basic;
                }
                field("Risk Rate"; "Risk Rate")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
}

