pageextension 50114 "CustomerLedgerEntExt" extends "Customer Ledger Entries"
{
    layout
    {
        // Add changes to page layout here
        addlast(Control1)
        {
            field("Transaction Type"; "Transaction Type")
            {
                ApplicationArea = Basic, Suite;
                Editable = false;
            }
            field("Loan No"; "Loan No")
            {
                ApplicationArea = Basic, Suite;
                Editable = false;
            }
            field("Loan Type"; "Loan Type")
            {
                ApplicationArea = Basic, Suite;
                Editable = false;

            }
            field("Final Amount"; "Final Amount")
            {
                ApplicationArea = Basic, Suite;
                Editable = false;

            }
            field("Transaction Amount"; "Transaction Amount")
            {
                ApplicationArea = Basic, Suite;
                Editable = false;

            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}