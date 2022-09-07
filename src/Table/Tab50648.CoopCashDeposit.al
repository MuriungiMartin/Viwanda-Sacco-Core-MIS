#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50648 "Coop Cash Deposit"
{

    fields
    {
        field(1; TranID; Integer)
        {
        }
        field(2; "Transaction Date"; Date)
        {
        }
        field(3; "Account No"; Code[200])
        {
        }
        field(4; "Account Name"; Text[250])
        {
        }
        field(5; "Institution Code"; Code[200])
        {
        }
        field(6; "Institution Name"; Code[150])
        {
        }
        field(7; "Total Amount"; Decimal)
        {
        }
        field(8; Currency; Option)
        {
            OptionCaption = 'KES';
            OptionMembers = KES;
        }
        field(9; "Additional info"; Code[250])
        {
        }
        field(10; "Reference Code"; Code[250])
        {
        }
        field(11; posted; Boolean)
        {
        }
        field(12; "Member No"; Code[250])
        {
        }
        field(13; MessageID; Code[250])
        {
        }
        field(14; "Bank Reference code"; Code[250])
        {
        }
        field(15; "Transaction Time"; DateTime)
        {
        }
        field(16; "Date Posted"; DateTime)
        {
        }
        field(17; "Needs Manual Posting"; Boolean)
        {
        }
        field(18; Comments; Text[250])
        {
        }
    }

    keys
    {
        key(Key1; TranID)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

