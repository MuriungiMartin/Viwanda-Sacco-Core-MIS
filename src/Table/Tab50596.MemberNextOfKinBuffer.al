#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50596 "Member Next Of Kin Buffer"
{

    fields
    {
        field(1; "Member No"; Code[50])
        {
        }
        field(2; "Next of Kin Name"; Code[100])
        {
        }
        field(3; "ID No"; Code[50])
        {
        }
        field(4; "RelationShip Type"; Code[50])
        {
        }
        field(5; "Allocation Percentage"; Decimal)
        {
        }
        field(6; "Mobile No"; Code[50])
        {
        }
        field(7; Email; Text[250])
        {
        }
        field(8; "Guardian Details"; Text[250])
        {
        }
        field(9; "Created On"; Date)
        {
        }
        field(10; "Created By"; Code[50])
        {
        }
        field(11; "Modified On"; Date)
        {
        }
        field(12; "Modified By"; Code[50])
        {
        }
        field(13; "Entry No"; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Member No", "Next of Kin Name", "Allocation Percentage", "RelationShip Type", "Entry No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

