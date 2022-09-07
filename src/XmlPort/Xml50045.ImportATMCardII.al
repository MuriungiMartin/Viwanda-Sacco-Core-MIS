#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
XmlPort 50045 "Import ATM Card II"
{
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement("ATM Card Applications"; "ATM Card Applications")
            {
                XmlName = 'Paybill';
                fieldelement(A; "ATM Card Applications"."No.")
                {
                }
                fieldelement(B; "ATM Card Applications"."Account No")
                {
                }
                fieldelement(C; "ATM Card Applications"."Account Name")
                {
                }
                fieldelement(D; "ATM Card Applications"."Phone No.")
                {
                }
                fieldelement(E; "ATM Card Applications"."ID No")
                {
                }
                fieldelement(F; "ATM Card Applications"."Request Type")
                {
                }
                fieldelement(G; "ATM Card Applications"."Application Date")
                {
                }
                fieldelement(H; "ATM Card Applications"."Applied By")
                {
                }
                fieldelement(I; "ATM Card Applications"."Order ATM Card")
                {
                }
                fieldelement(J; "ATM Card Applications"."Ordered On")
                {
                }
                fieldelement(K; "ATM Card Applications"."Ordered By")
                {
                }
                fieldelement(L; "ATM Card Applications"."Card Received")
                {
                }
                fieldelement(M; "ATM Card Applications"."Card Received On")
                {
                }
                fieldelement(N; "ATM Card Applications"."Card Received By")
                {
                }
                fieldelement(O; "ATM Card Applications"."ATM Card Bank Batch No")
                {
                }
                fieldelement(P; "ATM Card Applications"."Card No")
                {
                }
                fieldelement(Q; "ATM Card Applications"."Pin Received")
                {
                }
                fieldelement(R; "ATM Card Applications"."Pin Received On")
                {
                }
                fieldelement(S; "ATM Card Applications"."Pin Received By")
                {
                }
                fieldelement(T; "ATM Card Applications"."ATM Pin Bank Batch No")
                {
                }
                fieldelement(U; "ATM Card Applications".Collected)
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

