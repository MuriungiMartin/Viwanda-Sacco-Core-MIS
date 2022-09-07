#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50453 "Banks"
{
    //nownPage51516456;
    //nownPage51516456;

    fields
    {
        field(1; "Bank Code"; Code[20])
        {
            Enabled = false;
            NotBlank = true;

            trigger OnValidate()
            begin
                ObjBanks.Reset;
                ObjBanks.SetRange(ObjBanks."Bank Code", "Bank Code");
                if ObjBanks.FindSet then begin
                    "Bank Name" := ObjBanks."Bank Name";
                end;
            end;
        }
        field(2; "Bank Name"; Text[150])
        {
        }
        field(3; Branch; Text[150])
        {
        }
        field(4; "Branch Code"; Code[20])
        {
            Enabled = false;
        }
        field(5; "Code"; Code[50])
        {

            trigger OnValidate()
            begin
                "Bank Code" := '';
                "Branch Code" := '';

                Evaluate(VarBankCode, CopyStr(Code, 1, 2));
                Evaluate(VarBranchCode, CopyStr(Code, 4, 3));

                "Bank Code" := VarBankCode;
                "Branch Code" := VarBranchCode;
                //VALIDATE("Bank Code");
            end;
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
        fieldgroup(DropDown; "Code", "Bank Name", Branch)
        {
        }
    }

    var
        ObjBanks: Record Banks;
        SFactory: Codeunit "SURESTEP Factory";
        VarBankCode: Code[30];
        VarBranchCode: Code[30];
}

