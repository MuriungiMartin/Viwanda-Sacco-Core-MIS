#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50947 "Member NOK Change Request"
{
    //nownPage51516364;
    //nownPage51516364;

    fields
    {
        field(1; "Account No"; Code[30])
        {
            TableRelation = "Membership Applications"."No.";
        }
        field(2; Name; Text[150])
        {
            NotBlank = true;
        }
        field(3; Relationship; Text[30])
        {
            NotBlank = true;
            TableRelation = "Relationship Types";
        }
        field(4; Beneficiary; Boolean)
        {
        }
        field(5; "Date of Birth"; Date)
        {

            trigger OnValidate()
            begin
                Age := Dates.DetermineAge("Date of Birth", Today);
            end;
        }
        field(6; Address; Text[80])
        {
        }
        field(7; Telephone; Code[50])
        {
        }
        field(8; Fax; Code[10])
        {
        }
        field(9; Email; Text[30])
        {
        }
        field(11; "ID No."; Code[50])
        {
        }
        field(12; "%Allocation"; Decimal)
        {

            trigger OnValidate()
            begin
                "Maximun Allocation %" := 100;
                Modify;
                CalcFields("Total Allocation");
                if ("Total Allocation" > 100) then
                    Error('% Allocation cannot be more than 100');
            end;
        }
        field(13; "Total Allocation"; Decimal)
        {
            CalcFormula = sum("Member App Nominee"."%Allocation" where("Account No" = field("Account No")));
            FieldClass = FlowField;
        }
        field(14; "Maximun Allocation %"; Decimal)
        {
        }
        field(15; Age; Text[50])
        {
        }
        field(16; Description; Text[50])
        {
        }
        field(17; "Next Of Kin Type"; Option)
        {
            OptionCaption = ' ,Beneficiary,Guardian';
            OptionMembers = " ",Beneficiary,Guardian;
        }
        field(18; "Member No"; Code[20])
        {
            TableRelation = Customer."No.";

            trigger OnValidate()
            begin
                /*IF ObjCust.GET("Member No") THEN
                  BEGIN
                    Name:=ObjCust.Name;
                    "ID No.":=ObjCust."ID No.";
                    "Date of Birth":=ObjCust."Date of Birth";
                    Email:=ObjCust."E-Mail (Personal)";
                    Address:=ObjCust.Address;
                    END;
                    */

            end;
        }
        field(19; "Document No"; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "Document No", "Account No", Name)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        NomineeApp: Record "Member App Nominee";
        TotalAllocation: Decimal;
        Dates: Codeunit "Dates Calculation";
        DAge: DateFormula;
        ObjCust: Record Customer;
}

