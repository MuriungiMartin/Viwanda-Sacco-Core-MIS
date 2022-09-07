#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50506 "Member's Parishes"
{
    //nownPage51516534;
    //nownPage51516534;

    fields
    {
        field(1; "Code"; Code[20])
        {
        }
        field(2; Description; Text[50])
        {
        }
        field(3; "Share Class"; Option)
        {
            OptionCaption = ' ,Class A,Class B';
            OptionMembers = " ","Class A","Class B";
        }
        field(4; "No of Members"; Integer)
        {
            CalcFormula = count("Members Register" where("Members Parish" = field(Code)));
            FieldClass = FlowField;
        }
        field(5; "Male Members"; Integer)
        {
            CalcFormula = count("Members Register" where("Members Parish" = field(Code),
                                                          Gender = filter(" ")));
            FieldClass = FlowField;
        }
        field(6; "Female Members"; Integer)
        {
            CalcFormula = count("Members Register" where("Members Parish" = field(Code),
                                                          Gender = filter(Male)));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

