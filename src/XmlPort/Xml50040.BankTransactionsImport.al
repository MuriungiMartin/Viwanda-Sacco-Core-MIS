#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
XmlPort 50040 "Bank Transactions Import"
{
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement("Bank Acc. Statement Linevb"; "Bank Acc. Statement Linevb")
            {
                XmlName = 'Paybill';
                fieldelement(A; "Bank Acc. Statement Linevb"."Bank Account No.")
                {
                }
                fieldelement(B; "Bank Acc. Statement Linevb"."Statement No.")
                {
                }
                fieldelement(C; "Bank Acc. Statement Linevb"."Transaction Date")
                {
                }
                fieldelement(D; "Bank Acc. Statement Linevb"."Document No.")
                {
                }
                fieldelement(E; "Bank Acc. Statement Linevb"."Transaction Text")
                {
                }
                fieldelement(F; "Bank Acc. Statement Linevb"."Statement Amount")
                {
                }
                fieldelement(G; "Bank Acc. Statement Linevb"."Credit Amount")
                {
                }
                fieldelement(H; "Bank Acc. Statement Linevb"."Debit Amount")
                {
                }
                fieldelement(I; "Bank Acc. Statement Linevb".Balance)
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

    trigger OnPostXmlPort()
    begin
        Message('Bank Statement Import completed!');
    end;
}

