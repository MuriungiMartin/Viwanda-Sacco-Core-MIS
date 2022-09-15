#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50977 "Loan Portfolio Provision"
{

    fields
    {
        field(1; "Loan No"; Code[30])
        {
            TableRelation = "Loans Register"."Loan  No.";
        }
        field(2; "Member No"; Code[30])
        {
            TableRelation = Customer."No.";
        }
        field(3; "Member Name"; Code[100])
        {
        }
        field(4; Performing; Decimal)
        {
        }
        field(5; Watch; Decimal)
        {
        }
        field(6; Substandard; Decimal)
        {
        }
        field(7; Doubtful; Decimal)
        {
        }
        field(8; Loss; Decimal)
        {
        }
        field(9; "Outstanding Balance"; Decimal)
        {
        }
        field(10; "Arrears Amount"; Decimal)
        {
        }
        field(11; "Arrears Days"; Integer)
        {
        }
        field(12; Classification; Option)
        {
            OptionCaption = 'Perfoming,Watch,Substandard,Doubtful,Loss';
            OptionMembers = Perfoming,Watch,Substandard,Doubtful,Loss;
        }
        field(13; Rescheduled; Boolean)
        {
        }
        field(14; "Report Date"; Date)
        {
        }
        field(15; "Loan Product Code"; Code[30])
        {
            TableRelation = "Loan Products Setup".Code;
        }
        field(16; "Member Age"; Integer)
        {
        }
        field(17; "Branch Code"; Code[30])
        {
            TableRelation = "Dimension Value".Code where("Dimension Code" = const('BRANCH'));
        }
        field(18; "Group Code"; Code[30])
        {
            TableRelation = "Member House Groups"."Cell Group Code";
        }
        field(19; Alerted; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Loan No", "Report Date")
        {
            Clustered = true;
        }
        key(Key2; "Arrears Days", "Arrears Amount")
        {
        }
        key(Key3; "Loan Product Code", "Outstanding Balance", Classification, "Branch Code")
        {
        }
    }

    fieldgroups
    {
    }
}

