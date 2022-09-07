#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50599 "Collateral Details Buffer"
{

    fields
    {
        field(1; "Collateral ID"; Code[30])
        {
        }
        field(2; "Loan No"; Code[30])
        {
        }
        field(3; "Member No"; Code[50])
        {
        }
        field(4; "Member Name"; Code[100])
        {
        }
        field(5; "Collateral Type"; Code[50])
        {
        }
        field(6; "Market Value"; Decimal)
        {
        }
        field(7; "Forced Sale Value"; Decimal)
        {
        }
        field(8; "Last Valued On"; Date)
        {
        }
        field(9; "Collateral Description"; Text[250])
        {
        }
        field(10; "Registered Owner"; Code[100])
        {
        }
        field(11; "File No"; Code[50])
        {
        }
        field(12; "Released By"; Code[50])
        {
        }
        field(13; "Released On"; Date)
        {
        }
        field(14; "Last Actions"; Text[150])
        {
        }
    }

    keys
    {
        key(Key1; "Collateral ID", "Loan No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

