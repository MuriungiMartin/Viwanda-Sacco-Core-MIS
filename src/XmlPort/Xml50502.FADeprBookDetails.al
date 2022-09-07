#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
XmlPort 50502 "FA Depr Book Details"
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
            tableelement("Fixed Asset"; "Fixed Asset")
            {
                AutoUpdate = true;
                XmlName = 'PAYBILL';
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

