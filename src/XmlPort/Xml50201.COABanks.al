#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
XmlPort 50201 "COA/Banks"
{
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement("Bank Account"; "Bank Account")
            {
                AutoUpdate = true;
                XmlName = 'Paybill';
                fieldelement(Mobile_No; "Bank Account"."No.")
                {
                }
                fieldelement(azxc; "Bank Account".Name)
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

