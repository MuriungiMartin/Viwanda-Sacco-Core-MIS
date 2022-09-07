#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50032 "Accounts Dormancy Status"
{

    fields
    {
        field(1;"Entry No";Integer)
        {
        }
        field(2;"Effect Date";Date)
        {
        }
        field(3;"Status Pre_Change";Option)
        {
            OptionCaption = 'Active,Closed,Dormant,Frozen,Deceased';
            OptionMembers = Active,Closed,Dormant,Frozen,Deceased;
        }
        field(4;"Status Post_Change";Option)
        {
            OptionCaption = 'Active,Closed,Dormant,Frozen,Deceased';
            OptionMembers = Active,Closed,Dormant,Frozen,Deceased;
        }
        field(5;"Account No";Code[30])
        {
        }
        field(6;"Account Name";Code[100])
        {
        }
    }

    keys
    {
        key(Key1;"Entry No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

