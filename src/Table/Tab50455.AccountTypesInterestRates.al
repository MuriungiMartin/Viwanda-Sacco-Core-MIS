#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50455 "Account Types Interest Rates"
{

    fields
    {
        field(1; "Account Type"; Code[30])
        {
        }
        field(2; "Minimum Balance"; Decimal)
        {
        }
        field(3; "Maximum Balance"; Decimal)
        {
        }
        field(4; "Interest Rate"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Account Type", "Minimum Balance")
        {
            Clustered = true;
        }
        key(Key2; "Minimum Balance")
        {
        }
        key(Key3; "Maximum Balance")
        {
        }
    }

    fieldgroups
    {
    }
}

