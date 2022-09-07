#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50069 "Email Logs"
{

    fields
    {
        field(1; No; Integer)
        {
        }
        field(2; Subject; Text[250])
        {
        }
        field(3; Body; Text[250])
        {
        }
        field(4; Name; Text[250])
        {
        }
        field(5; "Sender E Mail"; Text[250])
        {
        }
        field(6; "Recepient EMail"; Text[250])
        {
        }
        field(7; Status; Option)
        {
            OptionCaption = 'Sent,Pending,Failed';
            OptionMembers = Sent,Pending,Failed;
        }
        field(8; "Date Sent"; DateTime)
        {
        }
    }

    keys
    {
        key(Key1; No)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

