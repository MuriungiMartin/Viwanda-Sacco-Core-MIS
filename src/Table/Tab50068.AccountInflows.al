#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50068 "Account Inflows"
{

    fields
    {
        field(1; EntryNo; Integer)
        {
        }
        field(2; "Account No"; Code[250])
        {
        }
        field(3; "Account type"; Code[100])
        {
        }
        field(4; AvgInflows; Decimal)
        {
        }
        field(5; "Max Inflows"; Decimal)
        {
        }
        field(6; "Minimum Inflows"; Decimal)
        {
        }
        field(7; "No of counts"; Integer)
        {
        }
        field(8; MemberNo; Code[100])
        {
        }
        field(9; TransactionDate; Date)
        {
        }
    }

    keys
    {
        key(Key1; EntryNo)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

