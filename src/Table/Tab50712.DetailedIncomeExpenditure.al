#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50712 "Detailed Income & Expenditure"
{

    fields
    {
        field(1; "Row No"; Code[30])
        {
        }
        field(2; Description; Text[100])
        {
        }
        field(3; "G/L Account"; Code[30])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(4; "Account Type"; Option)
        {
            OptionCaption = ' ,Income,Expense';
            OptionMembers = " ",Income,Expense;
        }
    }

    keys
    {
        key(Key1; "Row No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

