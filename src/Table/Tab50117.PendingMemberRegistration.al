#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50117 "Pending Member Registration"
{

    fields
    {
        field(1; Entry; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "ID Number"; Code[50])
        {
        }
        field(3; "Mobile No"; Code[50])
        {
        }
        field(4; "Receipt No"; Code[50])
        {
        }
        field(5; Name; Code[250])
        {
        }
        field(6; Amount; Decimal)
        {
        }
        field(7; "Date Created"; DateTime)
        {
        }
        field(8; Alerted; Boolean)
        {
        }
        field(9; Posted; Boolean)
        {
        }
        field(10; "Posted On"; DateTime)
        {
        }
    }

    keys
    {
        key(Key1; Entry)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

