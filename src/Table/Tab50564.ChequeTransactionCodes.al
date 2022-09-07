#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50564 "Cheque Transaction Codes"
{

    fields
    {
        field(1; "Code"; Code[100])
        {
        }
        field(2; "Transaction Name"; Text[100])
        {
        }
        field(3; "Is Common"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Transaction Category"; Code[100])
        {
            TableRelation = "Cheque Transaction Charges(B)".code;
        }
    }

    keys
    {
        key(Key1; "Code", "Transaction Name")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

