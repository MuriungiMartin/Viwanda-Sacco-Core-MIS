#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50963 "Loan Application Stages"
{

    fields
    {
        field(1; "Loan No"; Code[20])
        {
        }
        field(2; "Member No"; Code[20])
        {
        }
        field(3; "Member Name"; Code[100])
        {
        }
        field(4; "Loan Stage"; Code[20])
        {
        }
        field(5; "Loan Stage Description"; Text[50])
        {
        }
        field(6; "Stage Status"; Option)
        {
            OptionCaption = 'Pending,Succesful,Failed';
            OptionMembers = Pending,Succesful,Failed;

            trigger OnValidate()
            begin
                if Confirm('Confirm Status?', false) = true then begin
                    "Date Upated" := WorkDate;
                    "Updated By" := UserId;
                end;
            end;
        }
        field(7; "Date Upated"; Date)
        {
        }
        field(8; "Updated By"; Code[30])
        {
        }
        field(9; Comment; Text[250])
        {
        }
    }

    keys
    {
        key(Key1; "Loan No", "Loan Stage")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

