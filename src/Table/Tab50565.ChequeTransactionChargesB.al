#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50565 "Cheque Transaction Charges(B)"
{

    fields
    {
        field(1; "code"; Code[100])
        {
        }
        field(2; Description; Text[100])
        {
        }
        field(3; Amount; Decimal)
        {
        }
        field(4; "Sacco Income"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "code", Amount)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

