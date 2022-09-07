#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
XmlPort 50203 "Import Checkoff Distributed"
{
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement("Checkoff Lines-Distributed"; "Checkoff Lines-Distributed")
            {
                XmlName = 'Paybill';
                fieldelement(CheckoffNo; "Checkoff Lines-Distributed"."Checkoff No")
                {
                }
                fieldelement(PAYROLL_NO; "Checkoff Lines-Distributed"."Payroll No")
                {
                }
                fieldelement(REGFEE; "Checkoff Lines-Distributed".REGFEE)
                {
                }
                fieldelement(Shares; "Checkoff Lines-Distributed".Deposits)
                {
                }
                fieldelement(Deposits; "Checkoff Lines-Distributed".SHARES)
                {
                }
                fieldelement(DL_P; "Checkoff Lines-Distributed".DL_P)
                {
                }
                fieldelement(DL_I; "Checkoff Lines-Distributed".DL_I)
                {
                }
                fieldelement(EL_P; "Checkoff Lines-Distributed".EL_P)
                {
                }
                fieldelement(EL_I; "Checkoff Lines-Distributed".EL_I)
                {
                }
                fieldelement(SFL_P; "Checkoff Lines-Distributed".SFL_P)
                {
                }
                fieldelement(SFL_I; "Checkoff Lines-Distributed".SFL_I)
                {
                }
                fieldelement(PREMIUM; "Checkoff Lines-Distributed"."SACCO PREMIUM")
                {
                }
                fieldelement("IL-P"; "Checkoff Lines-Distributed".IL_P)
                {
                }
                fieldelement("IL-I"; "Checkoff Lines-Distributed".IL_I)
                {
                }
                fieldelement(SSFL_P; "Checkoff Lines-Distributed".SSFL_P)
                {
                }
                fieldelement(SSFL_I; "Checkoff Lines-Distributed".SSFL_I)
                {
                }
                fieldelement(SILVER; "Checkoff Lines-Distributed"."SILVER SAVINGS")
                {
                }
                fieldelement(SAD; "Checkoff Lines-Distributed".SAD)
                {
                }
                fieldelement(SAI; "Checkoff Lines-Distributed".SAI)
                {
                }
                fieldelement("SPL-P"; "Checkoff Lines-Distributed".SPL_P)
                {
                }
                fieldelement("SPL-I"; "Checkoff Lines-Distributed".SPL_I)
                {
                }
                fieldelement("SHAMBAL-P"; "Checkoff Lines-Distributed"."SHAMBAL-P")
                {
                }
                fieldelement("SHAMBAL-I"; "Checkoff Lines-Distributed"."SHAMBA-I")
                {
                }
                fieldelement(SAFARISAVINGS; "Checkoff Lines-Distributed"."SAFARI SAVINGS")
                {
                }
                fieldelement(JUNIORSAVINGS; "Checkoff Lines-Distributed"."JUNIOR SAVINGS")
                {
                }
                fieldelement(Benevolent; "Checkoff Lines-Distributed".BENEVOLENT)
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

