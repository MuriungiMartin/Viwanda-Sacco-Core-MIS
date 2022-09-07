#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50768 "Due Diligence Measures"
{
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Due Diligence Measures";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Risk Rating Level"; "Risk Rating Level")
                {
                    ApplicationArea = Basic;
                }
                field("Risk Rating Scale"; "Risk Rating Scale")
                {
                    ApplicationArea = Basic;
                }
                field("Due Diligence Type"; "Due Diligence Type")
                {
                    ApplicationArea = Basic;
                }
                field("Due Diligence No"; "Due Diligence No")
                {
                    ApplicationArea = Basic;
                }
                field("Due Diligence Measure"; "Due Diligence Measure")
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

