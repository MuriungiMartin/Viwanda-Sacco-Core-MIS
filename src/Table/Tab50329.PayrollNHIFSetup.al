#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50329 "Payroll NHIF Setup."
{

    fields
    {
        field(10; "Tier Code"; Code[10])
        {
        }
        field(11; "NHIF Tier"; Decimal)
        {
        }
        field(12; Amount; Decimal)
        {
        }
        field(13; "Lower Limit"; Decimal)
        {
        }
        field(14; "Upper Limit"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Tier Code")
        {
            Clustered = true;
        }
        key(Key2; "Lower Limit")
        {
        }
    }

    fieldgroups
    {
    }
}

