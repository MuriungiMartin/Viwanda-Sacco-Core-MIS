#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50951 "EFT/RTGS Charges Setup"
{

    fields
    {
        field(1; "Code"; Code[30])
        {
        }
        field(2; "EFT/RTGS Type"; Option)
        {
            OptionCaption = 'Internal,External';
            OptionMembers = Internal,External;
        }
        field(3; "Bank No"; Code[30])
        {
            TableRelation = "Bank Account"."No.";

            trigger OnValidate()
            begin
                if ObjBankAccount.Get("Bank No") then begin
                    "Bank Name" := ObjBankAccount.Name;
                end;
            end;
        }
        field(4; "Bank Name"; Code[100])
        {
        }
        field(5; Description; Text[150])
        {
        }
        field(6; "Charge Amount"; Decimal)
        {
        }
        field(7; "Percentage of Amount"; Decimal)
        {

            trigger OnValidate()
            begin
                if "Percentage of Amount" > 100 then
                    Error('You cannot exceed 100. Please enter a valid number.');
            end;
        }
        field(8; "Use Percentage"; Boolean)
        {
        }
        field(9; "GL Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(10; "Bank Commission"; Decimal)
        {
        }
        field(11; "SACCO Commission"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        ObjBankAccount: Record "Bank Account";
}

