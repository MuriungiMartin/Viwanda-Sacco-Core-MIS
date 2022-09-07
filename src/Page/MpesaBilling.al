page 51401 MpesaBilling
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = MpesaBillings;

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field(BillingNo; BillingNo)
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }


}