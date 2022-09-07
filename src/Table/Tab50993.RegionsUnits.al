#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50993 "Regions & Units"
{

    fields
    {
        field(1; Region; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Unit; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Unit Address"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Postal Code"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; Region, Unit)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

