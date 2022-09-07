page 52200 "CustomGLentryBuffer"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Customglentrybuffer;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Entry No."; "Entry No.")
                {
                    ApplicationArea = All;

                }
                field("Document No."; "Document No.")
                {
                    ApplicationArea = All;

                }
                field("Document Date"; "Document Date")
                {
                    ApplicationArea = All;

                }
                field("Posting Date"; "Posting Date")
                {
                    ApplicationArea = All;

                }
                field("Gen. Posting Type"; "Gen. Posting Type")
                {
                    ApplicationArea = All;

                }
                field(Amount; Amount)
                {
                    ApplicationArea = All;

                }
                field("Bal. Account Type"; "Bal. Account Type")
                {
                    ApplicationArea = All;

                }
                field("Bal. Account No."; "Bal. Account No.")
                {
                    ApplicationArea = All;

                }
                field("Credit Amount"; "Credit Amount")
                {
                    ApplicationArea = All;

                }
                field("Debit Amount"; "Debit Amount")
                {
                    ApplicationArea = All;

                }
                field("Gen. Bus. Posting Group"; "Gen. Bus. Posting Group")
                {
                    ApplicationArea = All;

                }
                field("Gen. Prod. Posting Group"; "Gen. Prod. Posting Group")
                {
                    ApplicationArea = All;

                }
                field("Global Dimension 1 Code"; "Global Dimension 1 Code")
                {
                    ApplicationArea = All;

                }
                field("Global Dimension 2 Code"; "Global Dimension 2 Code")
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