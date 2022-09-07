#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50954 "Control Risk Rating"
{

    fields
    {
        field(1; "Control Factor"; Text[250])
        {
        }
        field(2; "Control Weighting(%)"; Code[20])
        {
        }
        field(3; "Does  Control Cure Risk(1-3)"; Integer)
        {
        }
        field(4; "Control Been Documented(1-3)"; Integer)
        {
        }
        field(5; "Control Been Communicated(1-3)"; Integer)
        {
        }
        field(6; "Control Weight Aggregate"; Decimal)
        {
        }
        field(7; No; Integer)
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

