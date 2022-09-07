#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
XmlPort 50500 "Import Jnl"
{
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement("Gen. Journal Line"; "Gen. Journal Line")
            {
                XmlName = 'Paybill';
                fieldelement(A; "Gen. Journal Line"."Journal Template Name")
                {
                }
                fieldelement(B; "Gen. Journal Line"."Journal Batch Name")
                {
                }
                fieldelement(C; "Gen. Journal Line"."Line No.")
                {
                }
                fieldelement(D; "Gen. Journal Line"."Posting Date")
                {
                }
                fieldelement(E; "Gen. Journal Line"."Document No.")
                {
                }
                fieldelement(F; "Gen. Journal Line"."FA Posting Type")
                {
                }
                fieldelement(G; "Gen. Journal Line"."Account Type")
                {
                }
                fieldelement(H; "Gen. Journal Line"."Account No.")
                {
                }
                fieldelement(I; "Gen. Journal Line".Description)
                {
                }
                fieldelement(J; "Gen. Journal Line".Amount)
                {
                }
                fieldelement(K; "Gen. Journal Line"."Amount (LCY)")
                {
                }
                fieldelement(L; "Gen. Journal Line"."Shortcut Dimension 2 Code")
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

