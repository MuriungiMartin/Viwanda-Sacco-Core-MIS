page 51516000 "permissionranges"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Permission Range";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Object Type"; "Object Type")
                {
                    ApplicationArea = All;

                }
                field(Index; Index)
                {
                    ApplicationArea = All;

                }
                field(From; From)
                {
                    ApplicationArea = All;

                }
                field(To; "To")
                {
                    ApplicationArea = All;

                }
                field("Insert Permission"; "Insert Permission")
                {
                    ApplicationArea = All;

                }
                field("Execute Permission"; "Execute Permission")
                {
                    ApplicationArea = All;

                }
                field("Delete Permission"; "Delete Permission")
                {
                    ApplicationArea = All;

                }
                field("Modify Permission"; "Modify Permission")
                {
                    ApplicationArea = All;

                }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }
        }
    }
}