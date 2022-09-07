pageextension 50177 "GenJournalPageExtension" extends "General Journal"
{
    layout
    {
        // Add changes to page layout here
        addlast(Control1)
        {
            field("Transaction Type"; "Transaction Type")
            {

            }
            field("Loan No"; "Loan No")
            {

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