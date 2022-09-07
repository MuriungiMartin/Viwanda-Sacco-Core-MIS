#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50072 "Finance KPI Buffer"
{

    fields
    {
        field(1; "Entry No"; Integer)
        {
        }
        field(2; Description; Text[150])
        {
        }
        field(3; "Base G/L Account"; Code[30])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(4; "Denominator G/L Account"; Code[30])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(5; "KSACCO Targets"; Code[50])
        {
        }
        field(6; BenchMarks; Code[50])
        {
        }
        field(7; Caption; Code[10])
        {
        }
        field(8; "Base G/L Account to Sum"; Code[100])
        {
        }
        field(9; "Base G/L Account to Less"; Code[100])
        {
        }
        field(10; "Denominator G/L Account to Sum"; Code[100])
        {
        }
        field(11; "Denominator G/L Account to Les"; Code[100])
        {
        }
        field(12; "Insider Lending/T.Asset Staff"; Boolean)
        {
        }
        field(13; "Insider Lending/T.Asset Board"; Boolean)
        {
        }
        field(14; "Total Insider/Total assets"; Boolean)
        {
        }
        field(15; "Total Insider/Total Loans"; Boolean)
        {
        }
        field(16; "Insider Loans/Deposit Staff"; Boolean)
        {
        }
        field(17; "Insider Loans/Deposit Board"; Boolean)
        {
        }
        field(18; "Use Deliquent Loans Over 1Y D"; Boolean)
        {
        }
        field(19; "Show Amount"; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Entry No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

