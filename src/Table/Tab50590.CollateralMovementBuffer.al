#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50590 "Collateral Movement Buffer"
{

    fields
    {
        field(1; "Collateral ID"; Code[20])
        {
        }
        field(2; "Action Description"; Code[100])
        {
        }
        field(3; "Actioned By"; Code[100])
        {
        }
        field(4; "Actioned By II"; Code[100])
        {
        }
        field(5; "Actioned On"; Date)
        {
        }
        field(6; "Issued to"; Text[250])
        {
        }
        field(7; "Document No"; Code[50])
        {
        }
    }

    keys
    {
        key(Key1; "Collateral ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

