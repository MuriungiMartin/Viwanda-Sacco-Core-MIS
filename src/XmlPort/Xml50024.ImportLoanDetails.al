#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
XmlPort 50024 "Import Loan Details"
{
    Format = VariableText;

    schema
    {
        textelement(Salaries_Processing)
        {
            tableelement("Loans Details Import Buffer"; "Loans Details Import Buffer")
            {
                XmlName = 'ChequeImport';
                // fieldelement(A;"Loans Details Buffer"."Loan No")
                // {
                // }
                // fieldelement(B;"Loans Details Buffer"."Member No")
                // {
                // }
                // fieldelement(C;"Loans Details Buffer"."Member Name")
                // {
                // }
                // fieldelement(D;"Loans Details Buffer"."Loan Product Type")
                // {
                // }
                // fieldelement(E;"Loans Details Buffer"."Loan Product Name")
                // {
                // }
                // fieldelement(F;"Loans Details Buffer"."Application Date")
                // {
                // }
                // fieldelement(G;"Loans Details Buffer"."Applied By")
                // {
                // }
                // fieldelement(H;"Loans Details Buffer"."Approved On")
                // {
                // }
                // fieldelement(I;"Loans Details Buffer"."Approved By")
                // {
                // }
                // fieldelement(J;"Loans Details Buffer"."Disbursed On")
                // {
                // }
                // fieldelement(K;"Loans Details Buffer"."Disbursed By")
                // {
                // }
                // fieldelement(L;"Loans Details Buffer"."Requested Amount")
                // {
                // }
                // fieldelement(M;"Loans Details Buffer"."Disbursed Amount")
                // {
                // }
                // fieldelement(N;"Loans Details Buffer"."Repayment Amount")
                // {
                // }
                // fieldelement(O;"Loans Details Buffer"."Repayment Method")
                // {
                // }
                // fieldelement(P;"Loans Details Buffer"."Interest Rate")
                // {
                // }
                // fieldelement(Q;"Loans Details Buffer".Instalments)
                // {
                // }
                // fieldelement(R;"Loans Details Buffer"."Repayment Frequency")
                // {
                // }
                // fieldelement(S;"Loans Details Buffer"."Repayment Start Date")
                // {
                // }
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

