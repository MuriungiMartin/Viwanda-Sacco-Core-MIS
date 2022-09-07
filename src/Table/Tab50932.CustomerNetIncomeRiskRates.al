#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50932 "Customer Net Income Risk Rates"
{

    fields
    {
        field(1; "Min Monthly Income"; Decimal)
        {
        }
        field(2; "Max Monthlyl Income"; Decimal)
        {
        }
        field(3; "Risk Rate"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Min Monthly Income")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

