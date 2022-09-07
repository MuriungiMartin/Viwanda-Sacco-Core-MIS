#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
XmlPort 50035 "Import Phone No"
{
    Format = VariableText;

    schema
    {
        textelement(Salaries_Processing)
        {
            tableelement("Banks Ver2"; "Banks Ver2")
            {
                AutoReplace = true;
                XmlName = 'ChequeImport';
                fieldelement(A; "Banks Ver2"."Bank Code")
                {
                }
                fieldelement(B; "Banks Ver2"."Bank Name")
                {
                }
                fieldelement(C; "Banks Ver2"."Branch Code")
                {
                }
                fieldelement(D; "Banks Ver2"."Branch Name")
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

