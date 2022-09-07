#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50097 "S-Mobile Tarrifs"
{
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "S-Mobile Tarrifs";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Code)
                {
                    ApplicationArea = Basic;
                }
                field(Minimum; Minimum)
                {
                    ApplicationArea = Basic;
                }
                field(Maximum; Maximum)
                {
                    ApplicationArea = Basic;
                }
                field("Charge Amount"; "Charge Amount")
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

