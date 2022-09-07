#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
XmlPort 50019 "Import Loan Repayment Schedule"
{
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement("Loan Repayment Schedule Buffer"; "Loan Repayment Schedule Buffer")
            {
                XmlName = 'Paybill';
                fieldelement(A; "Loan Repayment Schedule Buffer"."Loan No")
                {
                }
                fieldelement(B; "Loan Repayment Schedule Buffer".Instalment)
                {
                }
                fieldelement(C; "Loan Repayment Schedule Buffer"."Repayment Date")
                {
                }
                fieldelement(D; "Loan Repayment Schedule Buffer"."Loan Balance")
                {
                }
                fieldelement(E; "Loan Repayment Schedule Buffer"."Monthly Repayment")
                {
                }
                fieldelement(F; "Loan Repayment Schedule Buffer"."Principle Repayment")
                {
                }
                fieldelement(G; "Loan Repayment Schedule Buffer"."Monthly Interest")
                {
                }
                fieldelement(H; "Loan Repayment Schedule Buffer"."Monthly Insurance")
                {
                }
                fieldelement(I; "Loan Repayment Schedule Buffer"."Entry No")
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

