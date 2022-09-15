#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50029 "Member Summary By Branch"
{

    fields
    {
        field(1; "Branch Code"; Code[50])
        {
        }
        field(2; "Active Members"; Integer)
        {
            CalcFormula = count(Customer where("Global Dimension 2 Code" = field("Branch Code"),
                                                          Status = filter(Active),
                                                          "Registration Date" = field("Registration Date Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(3; "Awaiting Exit Members"; Integer)
        {
            CalcFormula = count(Customer where("Global Dimension 2 Code" = field("Branch Code"),
                                                          Status = filter("Awaiting Exit"),
                                                          "Registration Date" = field("Registration Date Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(4; "Exited Members"; Integer)
        {
            CalcFormula = count(Customer where("Global Dimension 2 Code" = field("Branch Code"),
                                                          Status = filter(Exited),
                                                          "Registration Date" = field("Registration Date Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(5; "Dormant Members"; Integer)
        {
            CalcFormula = count(Customer where("Global Dimension 2 Code" = field("Branch Code"),
                                                          Status = filter(Dormant),
                                                          "Registration Date" = field("Registration Date Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(6; "Deceased Members"; Integer)
        {
            CalcFormula = count(Customer where("Global Dimension 2 Code" = field("Branch Code"),
                                                          Status = filter(Deceased),
                                                          "Registration Date" = field("Registration Date Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(7; "Total Members"; Integer)
        {
            CalcFormula = count(Customer where("Global Dimension 2 Code" = field("Branch Code"),
                                                          "Registration Date" = field("Registration Date Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(8; "Registration Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
    }

    keys
    {
        key(Key1; "Branch Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

