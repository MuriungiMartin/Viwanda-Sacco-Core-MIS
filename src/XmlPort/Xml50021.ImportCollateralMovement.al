#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
XmlPort 50021 "Import Collateral Movement"
{
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement("Collateral Movement Buffer"; "Collateral Movement Buffer")
            {
                XmlName = 'Paybill';
                fieldelement(A; "Collateral Movement Buffer"."Document No")
                {
                }
                fieldelement(B; "Collateral Movement Buffer"."Collateral ID")
                {
                }
                fieldelement(C; "Collateral Movement Buffer"."Action Description")
                {
                }
                fieldelement(D; "Collateral Movement Buffer"."Actioned By")
                {
                }
                fieldelement(E; "Collateral Movement Buffer"."Actioned By II")
                {
                }
                fieldelement(F; "Collateral Movement Buffer"."Actioned On")
                {
                }
                fieldelement(G; "Collateral Movement Buffer"."Issued to")
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

