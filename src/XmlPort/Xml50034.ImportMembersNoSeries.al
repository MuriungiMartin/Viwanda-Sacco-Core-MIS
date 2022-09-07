#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
XmlPort 50034 "Import  Members No. Series"
{
    Format = VariableText;

    schema
    {
        textelement(Salaries_Processing)
        {
            tableelement("Member Accounts No Series"; "Member Accounts No Series")
            {
                AutoReplace = true;
                XmlName = 'ChequeImport';
                fieldelement(A; "Member Accounts No Series"."Account No")
                {
                }
                fieldelement(B; "Member Accounts No Series"."Account Type")
                {
                }
                fieldelement(C; "Member Accounts No Series"."Branch Code")
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

