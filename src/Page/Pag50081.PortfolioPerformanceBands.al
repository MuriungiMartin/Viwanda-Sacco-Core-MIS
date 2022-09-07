#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50081 "Portfolio Performance Bands"
{
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Portfolio Summary Bands";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No"; "Entry No")
                {
                    ApplicationArea = Basic;
                }
                field(Band; Band)
                {
                    ApplicationArea = Basic;
                }
                field("Band Description"; "Band Description")
                {
                    ApplicationArea = Basic;
                }
                field(Classification; Classification)
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

