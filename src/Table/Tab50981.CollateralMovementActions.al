#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50981 "Collateral Movement Actions"
{

    fields
    {
        field(1; "Action"; Code[30])
        {
        }
        field(2; "Action Description"; Text[50])
        {
        }
        field(3; "No Of Users to Effect Action"; Option)
        {
            OptionCaption = 'Single,Dual';
            OptionMembers = Single,Dual;
        }
        field(4; "Action Scope"; Option)
        {
            OptionCaption = ' ,Lawyer,Insurance,Branch,Auctioneer';
            OptionMembers = " ",Lawyer,Insurance,Branch,Auctioneer;
        }
    }

    keys
    {
        key(Key1; "Action")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Action", "Action Description", "No Of Users to Effect Action")
        {
        }
    }
}

