#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50791 "Interest Due Ledger Entries"
{
    Caption = 'Interest Due Ledger Entries';
    DataCaptionFields = "Customer No.";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = "Interest Due Ledger Entry";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Posting Date"; "Posting Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Transaction Type"; "Transaction Type")
                {
                    ApplicationArea = Basic;
                }
                field("Document No."; "Document No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("External Document No."; "External Document No.")
                {
                    ApplicationArea = Basic;
                }
                field("Customer No."; "Customer No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Loan No"; "Loan No")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction No."; "Transaction No.")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Type"; "Loan Type")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Description; Description)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Credit Amount"; "Credit Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Debit Amount"; "Debit Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Global Dimension 1 Code"; "Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Global Dimension 2 Code"; "Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("IC Partner Code"; "IC Partner Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Salesperson Code"; "Salesperson Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field(Amount; Amount)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Amount (LCY)"; "Amount (LCY)")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("User ID"; "User ID")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Date"; "Transaction Date")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the Work Date Transaction Date,for transactions that are Backdated';
                }
                field("Bal. Account Type"; "Bal. Account Type")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Bal. Account No."; "Bal. Account No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Source Code"; "Source Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Reason Code"; "Reason Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field(Reversed; Reversed)
                {
                    ApplicationArea = Basic;
                    Visible = true;
                }
                field("Reversed by Entry No."; "Reversed by Entry No.")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Reversed Entry No."; "Reversed Entry No.")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Reversal Date"; "Reversal Date")
                {
                    ApplicationArea = Basic;
                }
                field("Entry No."; "Entry No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Recoverd Loan"; "Recoverd Loan")
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {
            part("Member Ledger Entry FactBox"; "Member Ledger Entry FactBox")
            {
                SubPageLink = "Entry No." = field("Entry No.");
                Visible = true;
            }
            systempart(Control1102755003; Links)
            {
                Visible = false;
            }
            systempart(Control1102755001; Notes)
            {
                Visible = false;
            }
        }
    }

    actions
    {
    }

    trigger OnModifyRecord(): Boolean
    begin
        Codeunit.Run(Codeunit::"Cust. Entry-Edit", Rec);
        exit(false);
    end;

    var
        Navigate: Page Navigate;
        UserSetup: Record "User Setup";
        ObjMemberLedgerEntries: Record "Member Ledger Entry";
        ObjLoans: Record "Loans Register";
}

