#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50370 "Members-Group"
{

    fields
    {
        field(1; "Account No."; Code[20])
        {
            NotBlank = true;
            TableRelation = Customer;
        }
        field(2; "Member No."; Code[20])
        {
            NotBlank = true;
            TableRelation = Customer."No.";//where (testing=const(1),
                                           //      Field68012=filter(0|4|11|10));

            trigger OnValidate()
            begin
                /*IF Cust.GET("Member No.") THEN BEGIN
                "Staff No.":=Cust."Payroll/Staff No";
                Names:=Cust.Name;
                
                END;
                */

            end;
        }
        field(3; "Staff No."; Code[20])
        {

            trigger OnValidate()
            begin
                /*Cust.RESET;
                Cust.SETRANGE(Cust."Customer Type",Cust."Customer Type"::Member);
                Cust.SETRANGE(Cust."Payroll/Staff No","Staff No.");
                IF Cust.FIND('-') THEN BEGIN
                "Member No.":=Cust."No.";
                VALIDATE("Member No.");
                END;
                */

            end;
        }
        field(4; Names; Text[150])
        {
        }
    }

    keys
    {
        key(Key1; "Account No.", "Staff No.", "Member No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Cust: Record Customer;
}

