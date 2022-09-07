#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50118 "Member Account Status  Logs"
{

    fields
    {
        field(1; "Entry No"; Integer)
        {
            AutoIncrement = true;
        }
        field(2; Date; Date)
        {
        }
        field(3; "Member No"; Code[30])
        {
        }
        field(4; "Member Name"; Code[150])
        {
        }
        field(5; "Account No"; Code[30])
        {
        }
        field(6; "Change Type"; Option)
        {
            OptionCaption = ' ,Account Status Change,Membership Status Change';
            OptionMembers = " ","Account Status Change","Membership Status Change";
        }
        field(7; "Membership Status"; Option)
        {
            OptionCaption = 'Active,Awaiting Exit,Exited,Dormant,Deceased';
            OptionMembers = Active,"Awaiting Exit",Exited,Dormant,Deceased;
        }
        field(8; "Account Status"; Option)
        {
            OptionCaption = 'Active,Closed,Dormant,Frozen,Deceased';
            OptionMembers = Active,Closed,Dormant,Frozen,Deceased;
        }
        field(9; "User ID"; Code[50])
        {
        }
        field(10; "Last Transaction Date"; Date)
        {
        }
    }

    keys
    {
        key(Key1; "Entry No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

