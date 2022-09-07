#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50482 "Audit Volume Trans. Entries"
{

    fields
    {
        field(1; "Entry No"; Integer)
        {
        }
        field(2; "Posting Date"; Date)
        {
        }
        field(3; "Account No"; Code[30])
        {
        }
        field(4; "Document No"; Code[50])
        {
        }
        field(5; Description; Text[250])
        {
        }
        field(6; "Debit Amount"; Decimal)
        {
        }
        field(7; "Credit Amount"; Decimal)
        {
        }
        field(8; Amount; Decimal)
        {
        }
        field(9; "User ID"; Code[50])
        {
        }
        field(10; "Account Name"; Text[150])
        {
        }
        field(11; "Account Type"; Code[50])
        {
        }
        field(12; "Account Type Description"; Text[150])
        {
        }
        field(13; "Account Balance"; Decimal)
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

