#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50133 "Credit Scoring Criteria"
{
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Credit Score Criteria";

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
                field("Credit Score"; "Credit Score")
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
                field("Min Count Range"; "Min Count Range")
                {
                    ApplicationArea = Basic;
                }
                field("Max Count Range"; "Max Count Range")
                {
                    ApplicationArea = Basic;
                }
                field("YES/No"; "YES/No")
                {
                    ApplicationArea = Basic;
                }
                field("Min Amount Range"; "Min Amount Range")
                {
                    ApplicationArea = Basic;
                }
                field("Max Amount Range"; "Max Amount Range")
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

