#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50955 "Audit General Setup"
{

    fields
    {
        field(1; "Monthy Credits V TurnOver C%"; Decimal)
        {
        }
        field(2; "Cumm. Daily Credits Limit Amt"; Decimal)
        {
        }
        field(3; "Cumm. Daily Debits Limit Amt"; Decimal)
        {
        }
        field(4; "Primary key"; Integer)
        {
        }
        field(5; "Notification Group Email"; Text[50])
        {
        }
        field(6; "Member TurnOver Period"; DateFormula)
        {
        }
        field(7; "Member TurnOver Per Interger"; Integer)
        {
        }
        field(8; "Expected Monthly TurnOver Peri"; DateFormula)
        {
        }
        field(9; "Expected M.TurnOver Period Int"; Integer)
        {
        }
        field(10; "Over Due Date"; Integer)
        {
        }
        field(11; "Due Date"; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Primary key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

