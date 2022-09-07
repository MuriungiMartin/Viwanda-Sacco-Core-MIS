#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50028 "Countries"
{

    fields
    {
        field(1; "Code"; Code[10])
        {
        }
        field(2; Name; Text[100])
        {
        }
    }

    keys
    {
        key(Key1; "Code", Name)
        {
            Clustered = true;
        }
        key(Key2; Name)
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Code", Name)
        {
        }
        fieldgroup(Brick; "Code", Name)
        {
        }
    }
}

