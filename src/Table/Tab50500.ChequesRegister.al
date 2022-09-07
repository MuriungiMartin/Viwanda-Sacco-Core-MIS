#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50500 "Cheques Register"
{

    fields
    {
        field(1; "Cheque No."; Code[10])
        {
        }
        field(2; "Cheque Book Account No."; Code[20])
        {
        }
        field(3; Status; Option)
        {
            OptionCaption = 'Pending,Paid,Cancelled,stopped,Dishonoured';
            OptionMembers = Pending,Paid,Cancelled,stopped,Dishonoured;
        }
        field(4; "Action Date"; Date)
        {
        }
        field(5; "Application No."; Code[10])
        {
        }
        field(6; "Actioned By"; Code[50])
        {
        }
        field(7; "Account No."; Code[30])
        {
            TableRelation = Vendor."No.";
        }
    }

    keys
    {
        key(Key1; "Cheque No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

