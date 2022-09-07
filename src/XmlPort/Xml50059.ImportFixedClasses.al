#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
XmlPort 50059 "Import Fixed Classes"
{
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement("Member Account Freeze Details"; "Member Account Freeze Details")
            {
                XmlName = 'table';
                fieldelement(A; "Member Account Freeze Details"."Document No")
                {
                }
                fieldelement(B; "Member Account Freeze Details"."Account No")
                {
                }
                fieldelement(C; "Member Account Freeze Details"."Amount to Freeze")
                {
                }
                fieldelement(D; "Member Account Freeze Details"."Reason For Freezing")
                {
                }
                fieldelement(E; "Member Account Freeze Details"."Captured By")
                {
                }
                fieldelement(F; "Member Account Freeze Details"."Captured On")
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

