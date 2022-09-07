#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50952 "Due Diligence Measures"
{

    fields
    {
        field(1; "Risk Rating Level"; Option)
        {
            OptionCaption = 'Low Risk,Medium Risk,High Risk';
            OptionMembers = "Low Risk","Medium Risk","High Risk";
        }
        field(2; "Risk Rating Scale"; Text[50])
        {
        }
        field(3; "Due Diligence Type"; Code[50])
        {
        }
        field(4; "Due Diligence Measure"; Text[250])
        {
        }
        field(5; "Due Diligence No"; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Risk Rating Level", "Risk Rating Scale", "Due Diligence Type", "Due Diligence Measure")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

