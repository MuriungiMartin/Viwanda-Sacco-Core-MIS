page 51388 "Reversal Entries"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Reversal Entry";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Entry No."; "Entry No.")
                {
                    ApplicationArea = All;

                }
                field("Entry Type"; "Entry Type")
                {
                    ApplicationArea = all;
                }
                field("Account No."; "Account No.")
                {
                    ApplicationArea = all;
                }
                field("Document Type"; "Document Type")
                {
                    ApplicationArea = all;
                }
                field("Source Type"; "Source Type")
                {
                    ApplicationArea = all;
                }
                field("Source No."; "Source No.")
                {
                    ApplicationArea = all;
                }
                field("Source Code"; "Source Code")
                {
                    ApplicationArea = all;
                }
                field("Transaction No."; "Transaction No.")
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