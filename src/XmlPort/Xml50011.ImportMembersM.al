#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
XmlPort 50011 "Import MembersM"
{
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement("Members Register"; "Members Register")
            {
                XmlName = 'Member';
                fieldelement(A; "Members Register"."No.")
                {
                }
                fieldelement(B; "Members Register".Name)
                {
                }
                fieldelement(C; "Members Register".Address)
                {
                }
                fieldelement(D; "Members Register"."Address 2")
                {
                }
                fieldelement(E; "Members Register".City)
                {
                }
                fieldelement(F; "Members Register"."Phone No.")
                {
                }
                fieldelement(G; "Members Register"."Global Dimension 1 Code")
                {
                }
                fieldelement(H; "Members Register"."Global Dimension 2 Code")
                {
                }
                fieldelement(I; "Members Register"."Customer Posting Group")
                {
                }
                fieldelement(J; "Members Register"."Post Code")
                {
                }
                fieldelement(K; "Members Register"."E-Mail")
                {
                }
                fieldelement(L; "Members Register"."Customer Type")
                {
                }
                fieldelement(M; "Members Register"."Registration Date")
                {
                }
                fieldelement(N; "Members Register".Status)
                {
                }
                fieldelement(O; "Members Register"."FOSA Account No.")
                {
                }
                fieldelement(P; "Members Register"."Employer Code")
                {
                }
                fieldelement(Q; "Members Register"."Date of Birth")
                {
                }
                fieldelement(R; "Members Register"."Station/Department")
                {
                }
                fieldelement(S; "Members Register"."Home Address")
                {
                }
                fieldelement(T; "Members Register".Location)
                {
                }
                fieldelement(U; "Members Register"."Sub-Location")
                {
                }
                fieldelement(V; "Members Register".District)
                {
                }
                fieldelement(W; "Members Register"."Payroll No")
                {
                }
                fieldelement(X; "Members Register"."ID No.")
                {
                }
                fieldelement(Y; "Members Register"."Mobile Phone No")
                {
                }
                fieldelement(Z; "Members Register"."Marital Status")
                {
                }
                fieldelement(AA; "Members Register".Gender)
                {
                }
                fieldelement(BB; "Members Register".rejoined)
                {
                }
                fieldelement(CC; "Members Register"."Introduced By")
                {
                }
                fieldelement(DD; "Members Register"."Rejoining Date")
                {
                }
                fieldelement(DE; "Members Register".Staff)
                {
                }
                fieldelement(CC; "Members Register"."Member Category")
                {
                }
                fieldelement(DD; "Members Register"."Terms Of Employment")
                {
                }
                fieldelement(EE; "Members Register"."Nominee Envelope No.")
                {
                }
                fieldelement(FF; "Members Register".Disabled)
                {
                }
                fieldelement(SS; "Members Register"."Death date")
                {
                }
                fieldelement(THT; "Members Register".BoostedDate)
                {
                }
                fieldelement(UJ; "Members Register".BoostedAmount)
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

