#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
XmlPort 50025 "Import Historical Transactions"
{
    Format = VariableText;

    schema
    {
        textelement(Salaries_Processing)
        {
            tableelement("Member Historical Ledger Entry"; "Member Historical Ledger Entry")
            {
                XmlName = 'ChequeImport';
                fieldelement(A; "Member Historical Ledger Entry"."Entry No.")
                {
                }
                fieldelement(B; "Member Historical Ledger Entry"."Account No.")
                {
                }
                fieldelement(C; "Member Historical Ledger Entry"."Posting Date")
                {
                }
                fieldelement(D; "Member Historical Ledger Entry"."Document No.")
                {
                }
                fieldelement(E; "Member Historical Ledger Entry".Description)
                {
                }
                fieldelement(F; "Member Historical Ledger Entry"."Credit Amount")
                {
                }
                fieldelement(G; "Member Historical Ledger Entry"."Debit Amount")
                {
                }
                fieldelement(H; "Member Historical Ledger Entry"."Product ID")
                {
                }
                fieldelement(I; "Member Historical Ledger Entry"."External Document No")
                {
                }
                fieldelement(J; "Member Historical Ledger Entry"."Created On")
                {
                }
                fieldelement(K; "Member Historical Ledger Entry"."User ID")
                {
                }
                fieldelement(L; "Member Historical Ledger Entry".Amount)
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

