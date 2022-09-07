#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50982 "New House Change Request"
{
    CardPageID = "House Change Request Card";
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "House Group Change Request";
    SourceTableView = where("Change Effected" = filter(false));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No"; "Document No")
                {
                    ApplicationArea = Basic;
                }
                field("Member No"; "Member No")
                {
                    ApplicationArea = Basic;
                }
                field("Member Name"; "Member Name")
                {
                    ApplicationArea = Basic;
                }
                field("House Group"; "House Group")
                {
                    ApplicationArea = Basic;
                }
                field("House Group Name"; "House Group Name")
                {
                    ApplicationArea = Basic;
                }
                field("Destination House"; "Destination House")
                {
                    ApplicationArea = Basic;
                }
                field("Destination House Group Name"; "Destination House Group Name")
                {
                    ApplicationArea = Basic;
                }
                field("Reason For Changing Groups"; "Reason For Changing Groups")
                {
                    ApplicationArea = Basic;
                }
                field("Deposits on Date of Change"; "Deposits on Date of Change")
                {
                    ApplicationArea = Basic;
                }
                field("Captured By"; "Captured By")
                {
                    ApplicationArea = Basic;
                }
                field("Captured On"; "Captured On")
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

