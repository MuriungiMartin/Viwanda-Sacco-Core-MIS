#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
XmlPort 50023 "Import Repayment Schedule"
{
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement("Loan Repayment Schedule"; "Loan Repayment Schedule")
            {
                AutoUpdate = true;
                XmlName = 'Paybill';
                fieldelement(A; "Loan Repayment Schedule"."Loan No.")
                {
                }
                fieldelement(B; "Loan Repayment Schedule"."Member No.")
                {
                }
                fieldelement(C; "Loan Repayment Schedule"."Loan Category")
                {
                }
                fieldelement(D; "Loan Repayment Schedule"."Closed Date")
                {
                }
                fieldelement(E; "Loan Repayment Schedule"."Loan Amount")
                {
                }
                fieldelement(F; "Loan Repayment Schedule"."Interest Rate")
                {
                }
                fieldelement(G; "Loan Repayment Schedule"."Monthly Repayment")
                {
                }
                fieldelement(H; "Loan Repayment Schedule"."Member Name")
                {
                }
                fieldelement(I; "Loan Repayment Schedule"."Monthly Interest")
                {
                }
                fieldelement(J; "Loan Repayment Schedule"."Amount Repayed")
                {
                }
                fieldelement(K; "Loan Repayment Schedule"."Repayment Date")
                {
                }
                fieldelement(L; "Loan Repayment Schedule"."Principal Repayment")
                {
                }
                fieldelement(M; "Loan Repayment Schedule".Paid)
                {
                }
                fieldelement(N; "Loan Repayment Schedule"."Remaining Debt")
                {
                }
                fieldelement(O; "Loan Repayment Schedule"."Instalment No")
                {
                }
                fieldelement(P; "Loan Repayment Schedule"."Actual Loan Repayment Date")
                {
                }
                fieldelement(Q; "Loan Repayment Schedule"."Repayment Code")
                {
                }
                fieldelement(R; "Loan Repayment Schedule"."Group Code")
                {
                }
                fieldelement(S; "Loan Repayment Schedule"."Loan Application No")
                {
                }
                fieldelement(T; "Loan Repayment Schedule"."Actual Principal Paid")
                {
                }
                fieldelement(U; "Loan Repayment Schedule"."Actual Interest Paid")
                {
                }
                fieldelement(V; "Loan Repayment Schedule"."Actual Installment Paid")
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

