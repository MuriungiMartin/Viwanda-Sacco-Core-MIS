#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50248 "HR Reward Lines"
{

    fields
    {
        field(1; "No."; Code[20])
        {
        }
        field(2; "Line No."; Integer)
        {
        }
        field(3; "Expense Account"; Code[20])
        {
            //TableRelation = Table0;
        }
        field(4; "Reason for Compensation"; Text[30])
        {
        }
        field(5; Amount; Decimal)
        {

            trigger OnValidate()
            begin
                "Total Amount" := Quantity * Amount;
            end;
        }
        field(6; Quantity; Decimal)
        {

            trigger OnValidate()
            begin
                Validate(Amount);
            end;
        }
        field(7; "Total Amount"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "No.", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

