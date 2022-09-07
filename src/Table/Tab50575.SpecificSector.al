#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50575 "Specific Sector"
{

    fields
    {
        field(1; "Code"; Code[20])
        {
        }
        field(2; Description; Text[250])
        {
        }
        field(3; No; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; Description, "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

