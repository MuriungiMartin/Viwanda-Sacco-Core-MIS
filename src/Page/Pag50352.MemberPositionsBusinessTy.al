#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50352 "Member Positions & Business Ty"
{
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Member Positions & Business";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Occupation; Occupation)
                {
                    ApplicationArea = Basic;
                }
                field(Category; Category)
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

