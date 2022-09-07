#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
XmlPort 50030 "Hexa Binary Import"
{
    Format = VariableText;

    schema
    {
        textelement(aa)
        {
            XmlName = 'HexaBinary';
            tableelement("Expected Monthly TurnOver"; "Expected Monthly TurnOver")
            {
                XmlName = 'HexaBinary';
                // fieldelement(Header;"Hexa Binary".Code)
                // {
                // }
                // fieldelement(No;"Hexa Binary"."Minimum Amount")
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

