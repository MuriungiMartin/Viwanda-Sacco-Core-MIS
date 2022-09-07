#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
XmlPort 50507 "Import Mobi Loans"
{
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement("Payroll PAYE Setup."; "Payroll PAYE Setup.")
            {
                AutoUpdate = true;
                XmlName = 'Member';
                fieldelement(A; "Payroll PAYE Setup."."Tier Code")
                {
                }
                fieldelement(B; "Payroll PAYE Setup."."PAYE Tier")
                {
                }
                fieldelement(C; "Payroll PAYE Setup.".Rate)
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

