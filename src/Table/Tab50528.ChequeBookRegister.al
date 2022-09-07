#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50528 "Cheque Book Register"
{
    //nownPage51516592;
    //nownPage51516592;

    fields
    {
        field(1; "Cheque No."; Code[30])
        {
        }
        field(2; Issued; Boolean)
        {
        }
        field(3; Cancelled; Boolean)
        {
        }
        field(4; "Bank Account"; Code[30])
        {
            TableRelation = "Bank Account"."No.";
        }
    }

    keys
    {
        key(Key1; "Cheque No.", "Bank Account")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

