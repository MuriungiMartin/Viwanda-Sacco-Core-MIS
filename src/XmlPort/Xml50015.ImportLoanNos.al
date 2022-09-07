#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
XmlPort 50015 "Import Loan Nos"
{
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement("Loan Products Setup"; "Loan Products Setup")
            {
                XmlName = 'Paybill';
                fieldelement(A; "Loan Products Setup".Code)
                {
                }
                fieldelement(B; "Loan Products Setup"."Product Description")
                {
                }
                fieldelement(C; "Loan Products Setup"."Interest rate")
                {
                }
                fieldelement(D; "Loan Products Setup"."Insurance %")
                {
                }
                fieldelement(E; "Loan Products Setup"."No of Installment")
                {
                }
                fieldelement(F; "Loan Products Setup"."Instalment Period")
                {
                }
                fieldelement(G; "Loan Products Setup"."Max. Loan Amount")
                {
                }
                fieldelement(H; "Loan Products Setup"."Top Up Commision")
                {
                }
                fieldelement(I; "Loan Products Setup".Source)
                {
                }
                fieldelement(J; "Loan Products Setup"."Min No. Of Guarantors")
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

