#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
XmlPort 50501 "CloudPESA Paybill"
{
    // Encoding = UTF8;
    Format = VariableText;
    FormatEvaluate = Legacy;
    PreserveWhiteSpace = true;
    TextEncoding = UTF8;

    schema
    {
        textelement("<paybilltran>")
        {
            XmlName = 'PAYBILLTRAN';
            tableelement("CloudPESA MPESA Trans"; "CloudPESA MPESA Trans")
            {
                AutoUpdate = true;
                XmlName = 'PAYBILL';
                fieldelement(A; "CloudPESA MPESA Trans"."Document No")
                {
                }
                fieldelement(F; "CloudPESA MPESA Trans".Amount)
                {
                }
                fieldelement(H; "CloudPESA MPESA Trans"."Paybill Acc Balance")
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

