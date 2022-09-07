#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
XmlPort 50057 "Import Insider Details"
{
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement("Members Register"; "Members Register")
            {
                AutoUpdate = true;
                XmlName = 'table';
                fieldelement(A; "Members Register"."No.")
                {
                }
                fieldelement(B; "Members Register"."Insider Status")
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

