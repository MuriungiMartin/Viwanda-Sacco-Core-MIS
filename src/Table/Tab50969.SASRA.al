#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50969 "SASRA"
{

    fields
    {
        field(1; "Primary No"; Integer)
        {
        }
        field(2; "Performing Loans Balance"; Decimal)
        {
            CalcFormula = sum("Loans Register"."Outstanding Balance" where("Loans Category-SASRA" = filter(Perfoming)));
            FieldClass = FlowField;
        }
        field(3; "Performing Loans Count"; Integer)
        {
        }
        field(4; "Watch Loans Balance"; Decimal)
        {
        }
        field(5; "Watch Loans Count"; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Primary No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

