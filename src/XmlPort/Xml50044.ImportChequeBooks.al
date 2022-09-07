#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
XmlPort 50044 "Import Cheque Books"
{
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement("Cheque Book Application"; "Cheque Book Application")
            {
                XmlName = 'Paybill';
                fieldelement(A; "Cheque Book Application"."No.")
                {
                }
                fieldelement(B; "Cheque Book Application"."Account No.")
                {
                }
                fieldelement(C; "Cheque Book Application"."Cheque Book Account No.")
                {
                }
                fieldelement(D; "Cheque Book Application"."Begining Cheque No.")
                {
                }
                fieldelement(E; "Cheque Book Application"."End Cheque No.")
                {
                }
                fieldelement(F; "Cheque Book Application"."Cheque Book Type")
                {
                }
                fieldelement(G; "Cheque Book Application"."Application Date")
                {
                }
                fieldelement(H; "Cheque Book Application"."Date Issued")
                {
                }
                fieldelement(I; "Cheque Book Application"."Issued By")
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

