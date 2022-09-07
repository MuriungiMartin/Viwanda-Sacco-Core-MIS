#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50982 "Member Accounts No Series"
{

    fields
    {
        field(1; "Account Type"; Code[30])
        {
            TableRelation = "Account Types-Saving Products".Code;

            trigger OnValidate()
            begin
                ObjAccounType.Reset;
                ObjAccounType.SetRange(ObjAccounType.Code, "Account Type");
                if ObjAccounType.FindSet then begin
                    Description := ObjAccounType.Description;
                end;
            end;
        }
        field(2; Description; Text[50])
        {
            Editable = false;
        }
        field(3; "Branch Code"; Code[30])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = filter(2));
        }
        field(4; "Account No"; Code[30])
        {
        }
    }

    keys
    {
        key(Key1; "Account Type", "Branch Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        ObjAccounType: Record "Account Types-Saving Products";
}

