page 51400 "Mpesa Billing List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = MpesaBillings;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Billing No"; BillingNo)
                {
                    ApplicationArea = All;

                }
                field("Bill Account Type"; "Bill Account Type")
                {
                    ApplicationArea = All;

                }
                field("Bill Account No."; "Bill Account No.")
                {
                    ApplicationArea = All;

                }
                field("Bill Status"; "Bill Status")
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