#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
XmlPort 50046 "Import Paid Cheques"
{
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement("Cheques Register"; "Cheques Register")
            {
                AutoUpdate = true;
                XmlName = 'Paybill';
                fieldelement(A; "Cheques Register"."Cheque No.")
                {
                }
                fieldelement(B; "Cheques Register"."Action Date")
                {
                }
                fieldelement(C; "Cheques Register"."Actioned By")
                {
                }
                fieldelement(D; "Cheques Register".Status)
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

