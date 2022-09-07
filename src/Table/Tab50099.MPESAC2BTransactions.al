#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50099 "MPESAC2BTransactions"
{

    fields
    {
        field(1; ColumnID; Integer)
        {
            AutoIncrement = false;
        }
        field(2; ReceiptNumber; Code[50])
        {
        }
        field(3; DateValidated; Code[50])
        {
        }
        field(4; DateCompleted; Code[50])
        {
        }
        field(5; TrxDetails; Text[250])
        {
        }
        field(6; TrxStatus; Text[250])
        {
        }
        field(7; TrxAmount; Decimal)
        {
        }
        field(8; PhoneNumber; Code[15])
        {
        }
        field(9; CustomerName; Text[250])
        {
        }
        field(10; AccountNumber; Text[250])
        {
        }
        field(11; Validated; Boolean)
        {
        }
        field(12; Posted; Boolean)
        {
        }
        field(13; DatePosted; Code[50])
        {
        }
        field(14; Alerted; Boolean)
        {
        }
        field(15; Reversed; Boolean)
        {
        }
        field(16; "Un Identified Payments"; Boolean)
        {
        }
        field(17; "Un Identified Payment Posted"; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; ColumnID)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

