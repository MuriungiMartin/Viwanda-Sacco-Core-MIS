#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50516 "Inward file Buffer-Family"
{

    fields
    {
        field(1; Field1; Code[20])
        {
        }
        field(2; Field2; Code[20])
        {
        }
        field(3; Field3; Code[20])
        {
        }
        field(4; Field4; Code[20])
        {
        }
        field(5; Field5; Code[20])
        {
        }
        field(6; Field6; Code[20])
        {
        }
        field(7; Field7; Code[20])
        {
        }
        field(8; Field8; Code[20])
        {
        }
        field(9; Field9; Decimal)
        {
        }
        field(10; Field10; Code[20])
        {
        }
        field(11; Field11; Code[20])
        {
        }
        field(12; Field12; Code[20])
        {
        }
        field(13; Field13; Code[20])
        {
        }
        field(14; Field14; Code[20])
        {
        }
        field(15; Field15; Code[20])
        {
        }
        field(16; Field16; Code[20])
        {
        }
        field(17; Field17; Code[20])
        {
        }
        field(18; Field18; Code[20])
        {
        }
        field(19; Field19; Code[20])
        {
        }
        field(20; Field20; Code[20])
        {
        }
        field(21; Field21; Code[20])
        {
        }
        field(22; CurrentUserID; Code[20])
        {
        }
        field(23; Primary; Integer)
        {
        }
        field(24; "Transaction Code"; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; Field5, Field7)
        {
            Clustered = true;
        }
        key(Key2; Field1)
        {
        }
    }

    fieldgroups
    {
    }
}

