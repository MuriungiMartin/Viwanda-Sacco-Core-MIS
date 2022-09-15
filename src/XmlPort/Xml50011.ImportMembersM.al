#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
XmlPort 50011 "Import MembersM"
{
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement(Customer; Customer)
            {
                XmlName = 'Member';
                fieldelement(A; Customer."No.")
                {
                }
                fieldelement(B; Customer.Name)
                {
                }
                fieldelement(C; Customer.Address)
                {
                }
                fieldelement(D; Customer."Address 2")
                {
                }
                fieldelement(E; Customer.City)
                {
                }
                fieldelement(F; Customer."Phone No.")
                {
                }
                fieldelement(G; Customer."Global Dimension 1 Code")
                {
                }
                fieldelement(H; Customer."Global Dimension 2 Code")
                {
                }
                fieldelement(I; Customer."Customer Posting Group")
                {
                }
                fieldelement(J; Customer."Post Code")
                {
                }
                fieldelement(K; Customer."E-Mail")
                {
                }
                fieldelement(L; Customer."Customer Type")
                {
                }
                fieldelement(M; Customer."Registration Date")
                {
                }
                fieldelement(N; Customer.Status)
                {
                }
                fieldelement(O; Customer."FOSA Account No.")
                {
                }
                fieldelement(P; Customer."Employer Code")
                {
                }
                fieldelement(Q; Customer."Date of Birth")
                {
                }
                fieldelement(R; Customer."Station/Department")
                {
                }
                fieldelement(S; Customer."Home Address")
                {
                }
                fieldelement(T; Customer.Location)
                {
                }
                fieldelement(U; Customer."Sub-Location")
                {
                }
                fieldelement(V; Customer.District)
                {
                }
                fieldelement(W; Customer."Payroll No")
                {
                }
                fieldelement(X; Customer."ID No.")
                {
                }
                fieldelement(Y; Customer."Mobile Phone No")
                {
                }
                fieldelement(Z; Customer."Marital Status")
                {
                }
                fieldelement(AA; Customer.Gender)
                {
                }
                fieldelement(BB; Customer.rejoined)
                {
                }
                fieldelement(CC; Customer."Introduced By")
                {
                }
                fieldelement(DD; Customer."Rejoining Date")
                {
                }
                fieldelement(DE; Customer.Staff)
                {
                }
                fieldelement(CC; Customer."Member Category")
                {
                }
                fieldelement(DD; Customer."Terms Of Employment")
                {
                }
                fieldelement(EE; Customer."Nominee Envelope No.")
                {
                }
                fieldelement(FF; Customer.Disabled)
                {
                }
                fieldelement(SS; Customer."Death date")
                {
                }
                fieldelement(THT; Customer.BoostedDate)
                {
                }
                fieldelement(UJ; Customer.BoostedAmount)
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

