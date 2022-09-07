#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50961 "Member House Groups List"
{
    CardPageID = "Member House Group Card";
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Member House Groups";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Cell Group Code"; "Cell Group Code")
                {
                    ApplicationArea = Basic;
                }
                field("Cell Group Name"; "Cell Group Name")
                {
                    ApplicationArea = Basic;
                }
                field("Date Formed"; "Date Formed")
                {
                    ApplicationArea = Basic;
                }
                field("Meeting Date"; "Meeting Date")
                {
                    ApplicationArea = Basic;
                }
                field("Group Leader"; "Group Leader")
                {
                    ApplicationArea = Basic;
                }
                field("Group Leader Name"; "Group Leader Name")
                {
                    ApplicationArea = Basic;
                }
                field("Assistant group Leader"; "Assistant group Leader")
                {
                    ApplicationArea = Basic;
                }
                field("Assistant Group Name"; "Assistant Group Name")
                {
                    ApplicationArea = Basic;
                }
                field("Meeting Place"; "Meeting Place")
                {
                    ApplicationArea = Basic;
                }
                field("No of Members"; "No of Members")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Credit Officer"; "Credit Officer")
                {
                    ApplicationArea = Basic;
                }
                field("Field Officer"; "Field Officer")
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

