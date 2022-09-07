#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50284 "HR Training Group"
{
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "HR Training Applications Group";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Training No."; "Training No.")
                {
                    ApplicationArea = Basic;
                }
                field("Training Group Name"; "Training Group Name")
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

