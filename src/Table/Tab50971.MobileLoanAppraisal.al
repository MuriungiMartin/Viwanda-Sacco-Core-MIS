#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50971 "Mobile Loan Appraisal"
{

    fields
    {
        field(1; "Document No"; Code[50])
        {
        }
        field(2; "Loan Product"; Code[50])
        {
        }
        field(3; Comment; Text[250])
        {
        }
        field(4; "FOSA Qualify Amt"; Decimal)
        {
        }
        field(5; "FOSA Avg Inflows"; Decimal)
        {
        }
        field(6; Qualify; Decimal)
        {
        }
        field(7; "Require CashFlow Docs"; Boolean)
        {
        }
        field(8; "Share Capital"; Decimal)
        {
        }
        field(9; "BOSA Balance"; Decimal)
        {
        }
        field(10; "Avg Salary"; Decimal)
        {
        }
        field(11; "Group ID"; Code[50])
        {
        }
        field(12; "Group NetWorth"; Decimal)
        {
        }
        field(13; "Group Loans Balance"; Decimal)
        {
        }
        field(14; "Group Loans SecurityValue"; Decimal)
        {
        }
        field(15; "Group Loans Risk"; Decimal)
        {
        }
        field(16; "Non Group Loans Balance"; Decimal)
        {
        }
        field(17; "Non Group Loans Security Value"; Decimal)
        {
        }
        field(18; "Non Group Loans Risk"; Decimal)
        {
        }
        field(19; "BOSA Multiplier"; Decimal)
        {
        }
        field(20; "BOSA Qualif yAmt"; Decimal)
        {
        }
        field(21; "Default History"; Decimal)
        {
        }
        field(22; "Loan No"; Code[50])
        {
        }
        field(23; "Alert Status"; Boolean)
        {
        }
        field(24; "Loan Security"; Option)
        {
            OptionCaption = '  ,Individual Deposits,Group Deposits,Salary,Logbook,Title Deed,Group & Logbook,Group & Title Deed';
            OptionMembers = "  ","Individual Deposits","Group Deposits",Salary,Logbook,"Title Deed","Group & Logbook","Group & Title Deed";
        }
        field(25; "Loan Period"; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Document No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

