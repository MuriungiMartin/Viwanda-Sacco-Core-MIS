#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
XmlPort 50208 "Import Sacco Loan No"
{
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement("Phone Number Buffer"; "Phone Number Buffer")
            {
                AutoUpdate = true;
                XmlName = 'Paybill';
                fieldelement(A; "Phone Number Buffer"."Standing Order")
                {
                }
                fieldelement(B; "Phone Number Buffer"."Next Run Date")
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

