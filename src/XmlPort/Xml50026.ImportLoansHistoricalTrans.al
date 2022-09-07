#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
XmlPort 50026 "Import Loans Historical Trans"
{
    Format = VariableText;

    schema
    {
        textelement(Salaries_Processing)
        {
            tableelement("Member Loans Historical Ledger"; "Member Loans Historical Ledger")
            {
                XmlName = 'ChequeImport';
                fieldelement(A; "Member Loans Historical Ledger"."Entry No.")
                {
                }
                fieldelement(B; "Member Loans Historical Ledger"."Account No.")
                {
                }
                fieldelement(C; "Member Loans Historical Ledger"."Posting Date")
                {
                }
                fieldelement(D; "Member Loans Historical Ledger"."Document No.")
                {
                }
                fieldelement(E; "Member Loans Historical Ledger".Description)
                {
                }
                fieldelement(F; "Member Loans Historical Ledger"."Credit Amount")
                {
                }
                fieldelement(G; "Member Loans Historical Ledger"."Debit Amount")
                {
                }
                fieldelement(H; "Member Loans Historical Ledger"."Product ID")
                {
                }
                fieldelement(I; "Member Loans Historical Ledger"."External Document No")
                {
                }
                fieldelement(J; "Member Loans Historical Ledger"."Created On")
                {
                }
                fieldelement(K; "Member Loans Historical Ledger"."User ID")
                {
                }
                fieldelement(L; "Member Loans Historical Ledger".Amount)
                {
                }
                fieldelement(M; "Member Loans Historical Ledger"."Loan No")
                {
                }
                fieldelement(N; "Member Loans Historical Ledger"."Transaction Type")
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

