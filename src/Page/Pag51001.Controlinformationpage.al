page 51001 "Controlinformationpage"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Control-Information.";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Primary Key"; "Primary Key")
                {
                    ApplicationArea = All;

                }
                field("Payslip Message"; "Payslip Message")
                {

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