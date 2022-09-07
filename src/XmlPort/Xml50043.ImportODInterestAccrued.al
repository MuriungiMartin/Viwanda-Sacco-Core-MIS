#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
XmlPort 50043 "Import OD Interest Accrued"
{
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement("Daily Interest/Penalty Buffer"; "Daily Interest/Penalty Buffer")
            {
                XmlName = 'Paybill';
                fieldelement(A; "Daily Interest/Penalty Buffer"."Entry No.")
                {
                }
                fieldelement(B; "Daily Interest/Penalty Buffer"."Account Type")
                {
                }
                fieldelement(C; "Daily Interest/Penalty Buffer"."Account No.")
                {
                }
                fieldelement(D; "Daily Interest/Penalty Buffer"."Posting Date")
                {
                }
                fieldelement(E; "Daily Interest/Penalty Buffer"."Document No.")
                {
                }
                fieldelement(F; "Daily Interest/Penalty Buffer".Description)
                {
                }
                fieldelement(G; "Daily Interest/Penalty Buffer".Amount)
                {
                }
                fieldelement(H; "Daily Interest/Penalty Buffer"."Transaction Type")
                {
                }
                fieldelement(I; "Daily Interest/Penalty Buffer"."Loan No")
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

