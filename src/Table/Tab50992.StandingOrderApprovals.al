#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50992 "Standing Order Approvals"
{

    fields
    {
        field(1; "Entry No."; Integer)
        {
        }
        field(2; "Signatory Name"; Text[250])
        {
        }
        field(3; "Mobile No"; Code[50])
        {
        }
        field(4; Status; Option)
        {
            OptionCaption = 'Pending,Approved,Declined';
            OptionMembers = Pending,Approved,Declined;
        }
        field(5; "Transaction No"; Code[50])
        {
        }
        field(6; Token; Text[250])
        {
        }
        field(7; "ID Number"; Code[50])
        {
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

