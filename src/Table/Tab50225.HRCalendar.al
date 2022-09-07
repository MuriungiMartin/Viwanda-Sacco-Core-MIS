#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50225 "HR Calendar"
{

    fields
    {
        field(2; Year; Code[10])
        {
        }
        field(3; Starts; Date)
        {
        }
        field(4; Ends; Date)
        {
        }
        field(5; Current; Boolean)
        {
            Editable = false;
        }
    }

    keys
    {
        key(Key1; Year)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

