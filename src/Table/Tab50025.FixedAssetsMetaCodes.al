#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50025 "Fixed Assets Meta Codes"
{

    fields
    {
        field(1; "Code"; Code[4])
        {
        }
        field(2; Description; Text[100])
        {
        }
        field(3; Category; Code[4])
        {
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

