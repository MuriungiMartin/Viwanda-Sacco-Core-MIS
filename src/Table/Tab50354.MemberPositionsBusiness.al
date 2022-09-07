#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50354 "Member Positions & Business"
{
    //nownPage51516352;
    //nownPage51516352;

    fields
    {
        field(1; Occupation; Text[100])
        {
        }
        field(2; Category; Option)
        {
            OptionCaption = ' ,Member Employment Position,Member Business Type';
            OptionMembers = " ","Member Employment Position","Member Business Type";
        }
    }

    keys
    {
        key(Key1; Occupation, Category)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

