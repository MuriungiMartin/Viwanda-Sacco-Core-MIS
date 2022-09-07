#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50950 "Member Deposit Tier"
{

    fields
    {
        field(1; "Code"; Code[30])
        {
        }
        field(2; "Minimum Amount"; Decimal)
        {
        }
        field(3; "Maximum Amount"; Decimal)
        {
        }
        field(4; Amount; Decimal)
        {
        }
        field(5; "Use Percentage"; Boolean)
        {
        }
        field(6; "Percentage of Amount"; Decimal)
        {
            DecimalPlaces = 4 : 4;
        }
        field(7; "Charge Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(8; "Notice Status"; Option)
        {
            OptionCaption = ' ,With Notice,Without Notice';
            OptionMembers = " ","With Notice","Without Notice";
        }
    }

    keys
    {
        key(Key1; "Notice Status", "Code", "Minimum Amount")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

