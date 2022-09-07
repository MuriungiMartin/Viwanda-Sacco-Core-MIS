#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
XmlPort 50506 "Import Detailed P&L"
{

    //Encoding = UTF8;
    Format = VariableText;
    FormatEvaluate = Legacy;
    PreserveWhiteSpace = true;
    TextEncoding = UTF8;

    schema
    {
        textelement("<paybilltran>")
        {
            XmlName = 'PAYBILLTRAN';
            tableelement(Vendor; Vendor)
            {
                XmlName = 'PAYBILL';
                fieldelement(A; Vendor."No.")
                {
                }
                fieldelement(B; Vendor.Name)
                {
                }
                fieldelement(C; Vendor."Vendor Posting Group")
                {
                }
                fieldelement(D; Vendor."Creditor Type")
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

