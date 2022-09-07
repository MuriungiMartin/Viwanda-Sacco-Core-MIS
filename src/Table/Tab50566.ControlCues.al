#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50566 "Control Cues"
{

    fields
    {
        field(1; "code"; Integer)
        {
            AutoIncrement = true;
        }
        field(2; Activity; Option)
        {
            Editable = false;
            OptionCaption = 'G/L,BOSA,FOSA';
            OptionMembers = "G/L",BOSA,FOSA;
        }
        field(3; Account_no; Code[20])
        {
        }
        field(4; time; Time)
        {
        }
        field(5; date; Date)
        {
        }
        field(6; User_Accessed; Code[50])
        {
            TableRelation = User."User Name";
        }
        field(7; Reason; Text[100])
        {
        }
        field(8; Frequency_Today; Integer)
        {
        }
        field(9; Account_Name; Text[50])
        {
        }
    }

    keys
    {
        key(Key1; "code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

