#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50957 "Membership Reg Sactions"
{

    fields
    {
        field(1; "Document No"; Code[20])
        {
        }
        field(2; "Code"; Code[20])
        {
        }
        field(3; "Name of Individual/Entity"; Code[250])
        {
        }
        field(4; "Date of Birth"; Text[250])
        {
        }
        field(5; "Palace Of Birth"; Text[250])
        {
        }
        field(6; Citizenship; Text[250])
        {
        }
        field(7; "Listing Information"; Text[250])
        {
        }
        field(8; "Control Date"; Date)
        {
        }
        field(9; "AU Sactions kenya"; Boolean)
        {
        }
        field(10; "County Code"; Code[20])
        {
        }
        field(11; "County Name"; Code[50])
        {
        }
        field(12; "Position Runing For"; Code[50])
        {
        }
        field(13; "Sanction Type"; Option)
        {
            OptionCaption = ' ,PEPs,AU Sanction';
            OptionMembers = " ",PEPs,"AU Sanction";
        }
    }

    keys
    {
        key(Key1; "Document No", "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

