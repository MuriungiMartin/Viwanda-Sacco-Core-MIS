pageextension 50118 "DetCustLedgerpExt" extends "Detailed Cust. Ledg. Entries"
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
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}