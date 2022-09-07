#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50953 "Member Due Diligence Measures"
{

    fields
    {
        field(1; "Member No"; Code[20])
        {
        }
        field(2; "Member Name"; Code[100])
        {
        }
        field(3; "Risk Rating Level"; Option)
        {
            OptionCaption = 'Low Risk,Medium Risk,High Risk';
            OptionMembers = "Low Risk","Medium Risk","High Risk";
        }
        field(4; "Risk Rating Scale"; Text[50])
        {
        }
        field(5; "Due Diligence Type"; Code[50])
        {
        }
        field(6; "Due Diligence Measure"; Text[250])
        {
        }
        field(7; "Due Diligence No"; Integer)
        {
        }
        field(8; "Due Diligence Done"; Boolean)
        {

            trigger OnValidate()
            begin
                "Due Diligence Done On" := 0D;
                "Due Diligence Done By" := '';

                if Confirm('Due Diligence Done', false) = true then begin
                    "Due Diligence Done On" := WorkDate;
                    "Due Diligence Done By" := UserId;
                end;
            end;
        }
        field(9; "Due Diligence Done By"; Code[30])
        {
        }
        field(10; "Due Diligence Done On"; Date)
        {
        }
    }

    keys
    {
        key(Key1; "Member No", "Member Name", "Risk Rating Level", "Risk Rating Scale", "Due Diligence Measure")
        {
            Clustered = true;
        }
        key(Key2; "Due Diligence No")
        {
        }
    }

    fieldgroups
    {
    }
}

