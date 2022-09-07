#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50600 "Account Agent Details Buffer"
{

    fields
    {
        field(1; "Account No"; Code[30])
        {
        }
        field(2; "Member No"; Code[50])
        {
        }
        field(3; "Member Name"; Code[200])
        {
        }
        field(4; "Date of Birth"; Date)
        {
        }
        field(5; "ID No"; Code[40])
        {
        }
        field(6; "Mobile No"; Code[50])
        {
        }
        field(7; Email; Text[200])
        {
        }
        field(8; Instructions; Text[250])
        {
        }
        field(9; "Withdrawal Limit"; Decimal)
        {
        }
        field(10; "Allow Balance Enquiry"; Boolean)
        {
        }
        field(11; "Allow Correspondence"; Boolean)
        {
        }
        field(12; "Allow FOSA Withdrawal"; Boolean)
        {
        }
        field(13; "Can Process Loan"; Boolean)
        {
        }
        field(14; "Created On"; Date)
        {
        }
        field(15; "Created By"; Code[40])
        {
        }
        field(16; "Modified By"; Code[40])
        {
        }
        field(17; "Modified On"; Date)
        {
        }
        field(18; "Can Draw Cheque"; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Account No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

