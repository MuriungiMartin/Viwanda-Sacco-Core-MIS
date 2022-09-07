#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
XmlPort 50004 "Import Members"
{
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement("Member Accounts Import Buffer"; "Member Accounts Import Buffer")
            {
                AutoReplace = true;
                XmlName = 'Member';
                fieldelement(A; "Member Accounts Import Buffer"."Member No")
                {
                }
                fieldelement(B; "Member Accounts Import Buffer"."Member Name")
                {
                }
                fieldelement(C; "Member Accounts Import Buffer"."Branch Code")
                {
                }
                fieldelement(D; "Member Accounts Import Buffer"."Account Status")
                {
                }
                fieldelement(E; "Member Accounts Import Buffer"."Payroll No")
                {
                }
                fieldelement(F; "Member Accounts Import Buffer"."ID No")
                {
                }
                fieldelement(G; "Member Accounts Import Buffer"."Mobile No")
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

