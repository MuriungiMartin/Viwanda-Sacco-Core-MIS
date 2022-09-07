#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
XmlPort 50017 "Import Member Next Of Kin"
{
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement("Member Next Of Kin Buffer"; "Member Next Of Kin Buffer")
            {
                XmlName = 'Paybill';
                fieldelement(A; "Member Next Of Kin Buffer"."Member No")
                {
                }
                fieldelement(B; "Member Next Of Kin Buffer"."Next of Kin Name")
                {
                }
                fieldelement(C; "Member Next Of Kin Buffer"."ID No")
                {
                }
                fieldelement(D; "Member Next Of Kin Buffer"."RelationShip Type")
                {
                }
                fieldelement(E; "Member Next Of Kin Buffer"."Allocation Percentage")
                {
                }
                fieldelement(F; "Member Next Of Kin Buffer"."Mobile No")
                {
                }
                fieldelement(G; "Member Next Of Kin Buffer".Email)
                {
                }
                fieldelement(H; "Member Next Of Kin Buffer"."Guardian Details")
                {
                }
                fieldelement(I; "Member Next Of Kin Buffer"."Created On")
                {
                }
                fieldelement(J; "Member Next Of Kin Buffer"."Created By")
                {
                }
                fieldelement(K; "Member Next Of Kin Buffer"."Modified On")
                {
                }
                fieldelement(L; "Member Next Of Kin Buffer"."Modified By")
                {
                }
                fieldelement(M; "Member Next Of Kin Buffer"."Entry No")
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

