page 51000 "TransactionTypePosting Setup"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Transaction Types Table";
    Caption = 'Transaction Types Posting Setup';

    layout
    {
        area(Content)
        {
            repeater(control1)
            {
                field("Transaction Type"; "Transaction Type")
                {
                    ApplicationArea = All;

                }
                field("Posting Group Code"; "Posting Group Code")
                {
                    ApplicationArea = all;
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