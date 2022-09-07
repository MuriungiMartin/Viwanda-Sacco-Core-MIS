#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50594 "Phone Number Buffer"
{

    fields
    {
        field(1; "Standing Order"; Code[30])
        {
        }
        field(2; "Next Run Date"; Date)
        {
        }
    }

    keys
    {
        key(Key1; "Standing Order")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

