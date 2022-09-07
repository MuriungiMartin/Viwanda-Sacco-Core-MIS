#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
XmlPort 50058 "Import Fixed Asset"
{
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement("Fixed Asset"; "Fixed Asset")
            {
                AutoReplace = true;
                XmlName = 'table';
                fieldelement(A; "Fixed Asset"."No.")
                {
                }
                fieldelement(B; "Fixed Asset"."FA Class Code")
                {
                }
                fieldelement(C; "Fixed Asset"."FA Subclass Code")
                {
                }
                fieldelement(D; "Fixed Asset".Description)
                {
                }
                // fieldelement(E;"Fixed Asset"."Asset Label")
                // {
                // }
                fieldelement(F; "Fixed Asset"."Serial No.")
                {
                }
                // fieldelement(G;"Fixed Asset"."Payment Details")
                // {
                // }
                // fieldelement(I;"Fixed Asset"."Supplier Name")
                // {
                // }
                // fieldelement(J;"Fixed Asset".Location)
                // {
                // }
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

