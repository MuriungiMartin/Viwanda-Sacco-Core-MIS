#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50073 "Failed Standing Order Buffer"
{

    fields
    {
        field(1; "Entry No"; Integer)
        {
        }
        field(2; "Document No"; Code[30])
        {
        }
        field(3; "Account No"; Code[30])
        {
        }
        field(4; "Account Name"; Code[150])
        {
        }
        field(5; "Date Posted"; Date)
        {
        }
        field(6; "Amount Charged"; Decimal)
        {
        }
        field(7; "Amount Paid Back"; Decimal)
        {
        }
        field(8; "Fully Settled"; Boolean)
        {
        }
        field(9; "Standing Order Narration"; Text[250])
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

