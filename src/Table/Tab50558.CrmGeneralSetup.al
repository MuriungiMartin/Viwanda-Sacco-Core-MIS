#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50558 "Crm General Setup."
{

    fields
    {
        field(1; "Primary key"; Integer)
        {
        }
        field(2; "Lead Nos"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(3; "General Enquiries Nos"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(4; "Cases nos"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(5; "Crm logs Nos"; Code[10])
        {
            TableRelation = "No. Series";
        }
    }

    keys
    {
        key(Key1; "Primary key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

