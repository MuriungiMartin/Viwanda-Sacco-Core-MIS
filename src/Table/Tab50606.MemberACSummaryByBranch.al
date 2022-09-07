#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50606 "Member A/C  Summary By Branch"
{

    fields
    {
        field(1; "Branch Code"; Code[50])
        {
        }
        field(2; "Active Accounts"; Integer)
        {
            CalcFormula = count(Vendor where("Global Dimension 2 Code" = field("Branch Code"),
                                              Status = filter(Active),
                                              "Registration Date" = field("Registration Date Filter"),
                                              "Account Type" = field("Product Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(3; "Closed Accounts"; Integer)
        {
            CalcFormula = count(Vendor where("Global Dimension 2 Code" = field("Branch Code"),
                                              Status = filter(Closed),
                                              "Registration Date" = field("Registration Date Filter"),
                                              "Account Type" = field("Product Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(4; "Dormant Accounts"; Integer)
        {
            CalcFormula = count(Vendor where("Global Dimension 2 Code" = field("Branch Code"),
                                              Status = filter(Dormant),
                                              "Registration Date" = field("Registration Date Filter"),
                                              "Account Type" = field("Product Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(5; "Frozen Accounts"; Integer)
        {
            CalcFormula = count(Vendor where("Global Dimension 2 Code" = field("Branch Code"),
                                              Status = filter(Frozen),
                                              "Registration Date" = field("Registration Date Filter"),
                                              "Account Type" = field("Product Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(6; "Deceased Accounts"; Integer)
        {
            CalcFormula = count(Vendor where("Global Dimension 2 Code" = field("Branch Code"),
                                              Status = filter(Deceased),
                                              "Registration Date" = field("Registration Date Filter"),
                                              "Account Type" = field("Product Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(7; "Total Accounts"; Integer)
        {
            CalcFormula = count(Vendor where("Global Dimension 2 Code" = field("Branch Code"),
                                              "Registration Date" = field("Registration Date Filter"),
                                              "Account Type" = field("Product Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(8; "Registration Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(9; "Product Filter"; Code[30])
        {
            FieldClass = FlowFilter;
            TableRelation = "Account Types-Saving Products".Code;
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

