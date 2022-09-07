#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50603 "Top Depositers"
{

    fields
    {
        field(1; "Customer No"; Code[30])
        {
        }
        field(2; Amount; Decimal)
        {
        }
        field(3; "Amount LCY"; Decimal)
        {
        }
        field(4; Rank; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Customer No")
        {
            Clustered = true;
        }
        key(Key2; Amount)
        {
            SumIndexFields = Amount;
        }
    }

    fieldgroups
    {
    }
}

