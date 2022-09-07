#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
XmlPort 50022 "Import Interest  Accrued"
{
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement("Interest Due Ledger Entry"; "Interest Due Ledger Entry")
            {
                XmlName = 'Paybill';
                fieldelement(A; "Interest Due Ledger Entry"."Entry No.")
                {
                }
                fieldelement(B; "Interest Due Ledger Entry"."Account Type")
                {
                }
                fieldelement(C; "Interest Due Ledger Entry"."Customer No.")
                {
                }
                fieldelement(D; "Interest Due Ledger Entry"."Posting Date")
                {
                }
                fieldelement(E; "Interest Due Ledger Entry"."Document No.")
                {
                }
                fieldelement(F; "Interest Due Ledger Entry".Description)
                {
                }
                fieldelement(G; "Interest Due Ledger Entry".Amount)
                {
                }
                fieldelement(H; "Interest Due Ledger Entry"."Transaction Type Interest")
                {
                }
                fieldelement(I; "Interest Due Ledger Entry"."Loan No")
                {
                }
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }
}

