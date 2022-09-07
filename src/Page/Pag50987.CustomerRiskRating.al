#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50987 "Customer Risk Rating"
{
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Customer Risk Rating";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Category; Category)
                {
                    ApplicationArea = Basic;
                }
                field("Sub Category"; "Sub Category")
                {
                    ApplicationArea = Basic;
                }
                field("Inherent Risk Rating"; "Inherent Risk Rating")
                {
                    ApplicationArea = Basic;
                }
                field("Risk Score"; "Risk Score")
                {
                    ApplicationArea = Basic;
                }
                field("Min Relationship Length(Years)"; "Min Relationship Length(Years)")
                {
                    ApplicationArea = Basic;
                }
                field("Max Relationship Length(Years)"; "Max Relationship Length(Years)")
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

