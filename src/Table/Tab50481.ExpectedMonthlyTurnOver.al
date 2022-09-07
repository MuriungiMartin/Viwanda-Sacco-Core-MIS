#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50481 "Expected Monthly TurnOver"
{

    fields
    {
        field(1; "Code"; Code[50])
        {
        }
        field(2; "Minimum Amount"; Decimal)
        {
        }
        field(3; "Maximum Amount"; Decimal)
        {
        }
        field(4; Amount; Decimal)
        {
        }
        field(5; "Entry No"; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Entry No", "Code")
        {
            Clustered = true;
        }
        key(Key2; "Minimum Amount")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Code", "Minimum Amount", "Maximum Amount")
        {
        }
    }
}

