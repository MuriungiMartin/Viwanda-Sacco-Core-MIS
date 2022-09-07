#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50238 "HR Committee Benefit(Non Cash)"
{

    fields
    {
        field(1; "Code"; Code[20])
        {
        }
        field(2; Description; Text[45])
        {
        }
        field(3; "Applicable?"; Boolean)
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

