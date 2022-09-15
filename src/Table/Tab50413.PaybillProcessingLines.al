#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50413 "Paybill Processing Lines"
{

    fields
    {
        field(1; "No."; Integer)
        {
            AutoIncrement = true;
            NotBlank = false;
        }
        field(2; "Account No."; Code[20])
        {
            TableRelation = Vendor."No." where("Creditor Type" = const("FOSA Account"));
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                /*
                Acc.RESET;
                Acc.SETRANGE(Acc."No.","Account No.");
                IF Acc.FIND('-') THEN BEGIN
                IF "Staff No." = '' THEN
                "Staff No.":=Acc."Staff No";
                IF Name = '' THEN
                Name:=Acc.Name;
                "Account Name":=Acc.Name;
                END;
                */

            end;
        }
        field(3; "Staff No."; Code[20])
        {

            trigger OnValidate()
            begin
                /*
              Acc.RESET;
              Acc.SETRANGE(Acc."Account Type",'SAVINGS');
              Acc.SETRANGE(Acc."Staff No","Staff No.");
              IF Acc.FIND('-') THEN BEGIN
              "Account No.":=Acc."No.";
              "Account Name":=Acc.Name;
              VALIDATE("Account No.");
              END
              ELSE
              ERROR('Record not found.')
                */

            end;
        }
        field(4; Name; Text[100])
        {
        }
        field(5; Amount; Decimal)
        {
        }
        field(6; "Account Not Found"; Boolean)
        {
        }
        field(7; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(8; Processed; Boolean)
        {
        }
        field(9; "Document No."; Code[20])
        {
        }
        field(10; Date; Code[30])
        {
        }
        field(11; "No. Series"; Code[20])
        {
        }
        field(12; "Original Account No."; Code[30])
        {
        }
        field(13; "Multiple Salary"; Boolean)
        {
        }
        field(14; Reversed; Boolean)
        {
        }
        field(15; "Branch Reff."; Code[20])
        {
        }
        field(16; "Account Name"; Text[70])
        {
        }
        field(17; "ID No."; Code[30])
        {
        }
        field(18; Closed; Boolean)
        {
        }
        field(33; "Global Dimension 1 Code"; Code[10])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1),
                                                          "Dimension Value Type" = const(Standard));
        }
        field(34; "Global Dimension 2 Code"; Code[10])
        {
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2),
                                                          "Dimension Value Type" = const(Standard));
        }
        field(62000; "BOSA Schedule"; Boolean)
        {
        }
        field(62001; USER; Code[60])
        {
        }
        field(62002; "Balance sl"; Decimal)
        {
            CalcFormula = sum("Gen. Journal Line".Amount where("Account No." = field("Account No.")));
            FieldClass = FlowField;
        }
        field(62003; "Paybill Header No."; Code[20])
        {
            TableRelation = "Paybill Processing Header".No where(No = field("Paybill Header No."));
        }
        field(62004; "Employer Code"; Code[20])
        {
        }
        field(62005; "Pension No"; Code[30])
        {
        }
        field(62006; "BOSA No"; Code[20])
        {
        }
        field(62007; "Mobile Phone Number"; Code[30])
        {
        }
        field(62008; "Credit Narration"; Text[250])
        {
        }
        field(62009; "Correct Account No"; Code[30])
        {
            TableRelation = Vendor."No.";

            trigger OnValidate()
            var
                ObjAccount: Record Vendor;
            begin
                ObjAccount.Reset;
                ObjAccount.SetRange(ObjAccount."No.", "Correct Account No");
                if ObjAccount.FindSet then begin
                    Name := ObjAccount.Name;
                end;
            end;
        }
    }

    keys
    {
        key(Key1; "No.", "Document No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        memb: Record Customer;
        loans: Record "Loans Register";
}

