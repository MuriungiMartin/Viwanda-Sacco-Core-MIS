#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50080 "Credit Score Rating Scale"
{
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Credit Score Rating Scale.";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Description; Description)
                {
                    ApplicationArea = Basic;
                }
                field("Minimum Credit Score"; "Minimum Credit Score")
                {
                    ApplicationArea = Basic;
                }
                field("Maximum Credit Score"; "Maximum Credit Score")
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

