#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
XmlPort 50013 "Import Loans"
{
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement("Loans Details Import Buffer"; "Loans Details Import Buffer")
            {
                AutoReplace = true;
                XmlName = 'Paybill';
                fieldelement(A; "Loans Details Import Buffer"."Loan No")
                {
                }
                fieldelement(B; "Loans Details Import Buffer"."Application Date")
                {
                }
                fieldelement(C; "Loans Details Import Buffer"."Loan Product Type")
                {
                }
                fieldelement(D; "Loans Details Import Buffer"."Member No")
                {
                }
                fieldelement(E; "Loans Details Import Buffer"."Requested Amount")
                {
                }
                fieldelement(F; "Loans Details Import Buffer"."Disbursed Amount")
                {
                }
                fieldelement(G; "Loans Details Import Buffer"."Interest Rate")
                {
                }
                fieldelement(H; "Loans Details Import Buffer"."Member Name")
                {
                }
                fieldelement(I; "Loans Details Import Buffer"."Disbursed On")
                {
                }
                fieldelement(J; "Loans Details Import Buffer".Instalments)
                {
                }
                fieldelement(K; "Loans Details Import Buffer"."Approved On")
                {
                }
                fieldelement(L; "Loans Details Import Buffer"."Repayment Amount")
                {
                }
                fieldelement(M; "Loans Details Import Buffer"."Outstanding Balance")
                {
                }
                fieldelement(N; "Loans Details Import Buffer"."Outstanding Interest")
                {
                }
                fieldelement(O; "Loans Details Import Buffer"."Repayment Start Date")
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

