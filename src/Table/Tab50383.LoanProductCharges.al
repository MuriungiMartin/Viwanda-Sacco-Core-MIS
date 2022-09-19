#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50383 "Loan Product Charges"
{

    fields
    {
        field(1; "Product Code"; Code[20])
        {
            NotBlank = true;
            TableRelation = "Loan Products Setup".Code;
        }
        field(2; "Code"; Code[20])
        {
            NotBlank = true;
            TableRelation = "Loan Charges".Code;

            trigger OnValidate()
            begin
                if Charges.Get(Code) then begin
                    Description := Charges.Description;
                    Amount := Charges.Amount;
                    Percentage := Charges.Percentage;
                    "G/L Account" := Charges."G/L Account";
                    "Use Perc" := Charges."Use Perc";
                end;
            end;
        }
        field(3; Description; Text[30])
        {
        }
        field(4; Amount; Decimal)
        {
        }
        field(5; Percentage; Decimal)
        {
            DecimalPlaces = 3 : 3;
        }
        field(6; "G/L Account"; Code[20])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(7; "Use Perc"; Boolean)
        {
        }
        field(8; "Minimum Amount"; Decimal)
        {
        }
        field(9; "Deduction Type"; Option)
        {
            OptionCaption = 'Deduct From Loan,Capitalize on Loan';
            OptionMembers = "Deduct From Loan","Capitalize on Loan";
        }
        field(10; "Loan Charge Type"; Option)
        {
            OptionCaption = ' ,Loan Insurance,Loan Application Fee,Loan Appraisal Fee,Loan Form Fees';
            OptionMembers = " ","Loan Insurance","Loan Application Fee","Loan Appraisal Fee","Loan Form Fees";
        }
        field(11; "Development Application Fee"; Decimal)
        {

        }
        field(12; "Emergency Application Fee"; Decimal)
        {

        }
    }

    keys
    {
        key(Key1; "Product Code", "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Charges: Record "Loan Charges";
        loantype: Record "Loan Products Setup";
}

