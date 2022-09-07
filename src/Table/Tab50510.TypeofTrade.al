#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50510 "Type of Trade"
{
    //nownPage51516553;
    //nownPage51516553;

    fields
    {
        field(1; "Type of Trade"; Code[20])
        {
        }
        field(2; "Trade Description"; Text[50])
        {
        }
    }

    keys
    {
        key(Key1; "Type of Trade")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Type of Trade", "Trade Description")
        {
        }
    }
}

