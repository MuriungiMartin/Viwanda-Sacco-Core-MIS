#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50974 "Core Capital G/L"
{

    fields
    {
        field(1; " Name"; Text[50])
        {
        }
        field(2; Account; Code[50])
        {
            TableRelation = "G/L Account";
        }
        field(3; Amount; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; " Name")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

