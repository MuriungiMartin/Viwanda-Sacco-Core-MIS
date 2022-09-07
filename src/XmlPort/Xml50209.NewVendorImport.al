#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
XmlPort 50209 "New Vendor Import"
{
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement(Vendor; Vendor)
            {
                AutoReplace = false;
                AutoUpdate = true;
                XmlName = 'Paybill';
                fieldelement(Mobile_No; Vendor."No.")
                {
                }
                fieldelement(a; Vendor.Name)
                {
                }
                fieldelement(b; Vendor."Creditor Type")
                {
                }
                fieldelement(c; Vendor."Gen. Bus. Posting Group")
                {
                }
                fieldelement(d; Vendor."VAT Bus. Posting Group")
                {
                }
                fieldelement(E; Vendor."Vendor Posting Group")
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

