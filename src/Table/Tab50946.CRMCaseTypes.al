#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50946 "CRM Case Types"
{
    DrillDownPageId = "CRM Case Types";
    LookupPageId = "CRM Case Types";

    fields
    {
        field(1; "Code"; Code[30])
        {
        }
        field(2; Description; Code[50])
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
        fieldgroup(DropDown; "Code", Description)
        {
        }
    }
}

