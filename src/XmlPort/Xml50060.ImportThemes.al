#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
XmlPort 50060 "Import Themes"
{
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement("Audit Themes"; "Audit Themes")
            {
                XmlName = 'table';
                fieldelement(A; "Audit Themes".Code)
                {
                }
                fieldelement(B; "Audit Themes".Description)
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

