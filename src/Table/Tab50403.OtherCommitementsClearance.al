#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50403 "Other Commitements Clearance"
{

    fields
    {
        field(1; "Loan No."; Code[20])
        {
            NotBlank = true;
            TableRelation = "Loans Register"."Loan  No.";
        }
        field(2; Description; Text[50])
        {
        }
        field(3; Payee; Text[50])
        {
            NotBlank = true;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;
        }
        field(4; Amount; Decimal)
        {

            trigger OnValidate()
            begin
                if Amount < 0 then
                    Error('Amount cannot be less than 0');
            end;
        }
        field(5; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(6; "Bankers Cheque No"; Code[20])
        {
        }
        field(7; "Bankers Cheque No 2"; Code[20])
        {
        }
        field(8; "Bankers Cheque No 3"; Code[20])
        {
        }
        field(9; "Batch No."; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "Loan No.", Payee)
        {
            Clustered = true;
            SumIndexFields = Amount;
        }
        key(Key2; Payee)
        {
        }
        key(Key3; "Batch No.")
        {
        }
    }

    fieldgroups
    {
    }
}

