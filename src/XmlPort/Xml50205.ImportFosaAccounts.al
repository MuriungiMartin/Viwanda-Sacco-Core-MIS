#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
XmlPort 50205 "Import Fosa Accounts"
{
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement("FOSA Accounts Import Buffer"; "FOSA Accounts Import Buffer")
            {
                AutoReplace = true;
                XmlName = 'Paybill';
                fieldelement(A; "FOSA Accounts Import Buffer"."FOSA Account No")
                {
                }
                fieldelement(B; "FOSA Accounts Import Buffer"."Member No")
                {
                }
                fieldelement(c; "FOSA Accounts Import Buffer".Name)
                {
                }
                fieldelement(D; "FOSA Accounts Import Buffer"."Account Type")
                {
                }
                fieldelement(E; "FOSA Accounts Import Buffer".Status)
                {
                }
                fieldelement(F; "FOSA Accounts Import Buffer"."Operating Mode")
                {
                }
                fieldelement(G; "FOSA Accounts Import Buffer"."Account Creation Date")
                {
                }
                fieldelement(H; "FOSA Accounts Import Buffer"."Account Created By")
                {
                }
                fieldelement(I; "FOSA Accounts Import Buffer"."Modified By")
                {
                }
                fieldelement(J; "FOSA Accounts Import Buffer"."Modified On")
                {
                }
                fieldelement(K; "FOSA Accounts Import Buffer"."Supervised On")
                {
                }
                fieldelement(L; "FOSA Accounts Import Buffer"."Supervised By")
                {
                }
                fieldelement(M; "FOSA Accounts Import Buffer"."Account Closed On")
                {
                }
                fieldelement(N; "FOSA Accounts Import Buffer"."Account Closed By")
                {
                }
                fieldelement(O; "FOSA Accounts Import Buffer"."Account Closure Reason")
                {
                }
                fieldelement(P; "FOSA Accounts Import Buffer"."Activity Code")
                {
                }
                fieldelement(Q; "FOSA Accounts Import Buffer"."OD Limit")
                {
                }
                fieldelement(R; "FOSA Accounts Import Buffer"."OD Expiry Date")
                {
                }
                fieldelement(S; "FOSA Accounts Import Buffer".Frozen)
                {
                }
                fieldelement(T; "FOSA Accounts Import Buffer"."Frozen Amount")
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

