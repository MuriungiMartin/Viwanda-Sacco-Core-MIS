#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50807 "Collateral Movement List"
{
    CardPageID = "Collateral Movement Card";
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Collateral Movement  Register";
    SourceTableView = where("Action Effected" = filter(false));

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
                field("Collateral ID"; "Collateral ID")
                {
                    ApplicationArea = Basic;
                }
                field("Collateral Description"; "Collateral Description")
                {
                    ApplicationArea = Basic;
                }
                field("Registered Owner"; "Registered Owner")
                {
                    ApplicationArea = Basic;
                }
                field("Member No."; "Member No.")
                {
                    ApplicationArea = Basic;
                }
                field("Member Name"; "Member Name")
                {
                    ApplicationArea = Basic;
                }
                field("Collateral Type"; "Collateral Type")
                {
                    ApplicationArea = Basic;
                }
                field("Action Type"; "Action Type")
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

