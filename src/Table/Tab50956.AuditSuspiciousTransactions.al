#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50956 "Audit Suspicious Transactions"
{

    fields
    {
        field(1; "Document No"; Code[20])
        {
        }
        field(2; "Account No"; Code[20])
        {
            TableRelation = Vendor."No.";
        }
        field(3; "Account Name"; Code[100])
        {
        }
        field(4; "Transaction Date"; Date)
        {
        }
        field(5; "Transaction Type"; Text[60])
        {
        }
        field(6; "Transaction Amount"; Decimal)
        {
        }
        field(7; "Transacted By"; Code[20])
        {
        }
        field(8; "Max Credits Allowable"; Decimal)
        {
        }
        field(9; "Month TurnOver Amount"; Decimal)
        {
        }
        field(10; "Violation Transaction Type"; Option)
        {
            OptionCaption = ' ,Monthly Turnover Exceed,Daily Transaction Limit Exceeed';
            OptionMembers = " ","Monthly Turnover Exceed","Daily Transaction Limit Exceeed";
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

