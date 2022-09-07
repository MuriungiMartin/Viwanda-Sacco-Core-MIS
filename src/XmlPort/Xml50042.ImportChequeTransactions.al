#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
XmlPort 50042 "Import Cheque Transactions"
{
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement(Transactions; Transactions)
            {
                XmlName = 'Paybill';
                fieldelement(A; Transactions.No)
                {
                }
                fieldelement(B; Transactions."Transaction Date")
                {
                }
                fieldelement(C; Transactions."Account Type")
                {
                }
                fieldelement(D; Transactions."Account No")
                {
                }
                fieldelement(E; Transactions."Transaction Description")
                {
                }
                fieldelement(F; Transactions.Amount)
                {
                }
                fieldelement(G; Transactions."Expected Maturity Date")
                {
                }
                fieldelement(H; Transactions."Cheque No")
                {
                }
                fieldelement(I; Transactions."Cheque Date")
                {
                }
                fieldelement(J; Transactions."Member No")
                {
                }
                fieldelement(K; Transactions."Account Name")
                {
                }
                fieldelement(L; Transactions.Payee)
                {
                }
                fieldelement(M; Transactions."Cheque Clearing Bank")
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
        //MESSAGE('Bank Statement Import completed!');
    end;
}

