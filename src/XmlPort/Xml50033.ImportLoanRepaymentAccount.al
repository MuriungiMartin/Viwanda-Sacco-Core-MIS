#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
XmlPort 50033 "Import Loan Repayment Account"
{
    Format = VariableText;

    schema
    {
        textelement(Salaries_Processing)
        {
            tableelement("Loans Register"; "Loans Register")
            {
                AutoUpdate = true;
                XmlName = 'ChequeImport';
                fieldelement(A; "Loans Register"."Loan  No.")
                {
                }
                fieldelement(B; "Loans Register"."Loan Recovery Account FOSA")
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

