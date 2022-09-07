#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
XmlPort 50055 "Loan Purpose"
{
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement("Regions & Units"; "Regions & Units")
            {
                XmlName = 'table';
                fieldelement(A; "Regions & Units".Region)
                {
                }
                fieldelement(B; "Regions & Units".Unit)
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

