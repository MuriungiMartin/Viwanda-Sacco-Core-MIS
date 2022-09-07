#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50060 "Travel Destination"
{
    // //nownPage55981;
    // //nownPage55981;

    fields
    {
        field(1; "Destination Code"; Code[10])
        {
            NotBlank = true;
        }
        field(2; "Destination Name"; Text[50])
        {
        }
        field(3; "Destination Type"; Option)
        {
            OptionMembers = "Local",Foreign;
        }
        field(4; Currency; Code[10])
        {
            CalcFormula = lookup("Destination Rate Entry".Currency where("Destination Code" = field("Destination Code")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Destination Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

