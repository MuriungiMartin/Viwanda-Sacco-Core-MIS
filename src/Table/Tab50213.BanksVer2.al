#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50213 "Banks Ver2"
{
    //nownPage51516456;
    //nownPage51516456;

    fields
    {
        field(1; "Bank Code"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Bank Name"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Branch Code"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Branch Name"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Bank Code", "Branch Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Bank Code", "Bank Name", "Branch Code", "Branch Name")
        {
        }
    }
}

