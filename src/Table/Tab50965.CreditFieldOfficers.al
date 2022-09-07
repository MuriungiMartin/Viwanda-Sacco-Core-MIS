#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50965 "Credit/Field Officers"
{
    //nownPage51516790;
    //nownPage51516790;

    fields
    {
        field(1; "User ID"; Code[20])
        {
            TableRelation = User."User Name";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnLookup()
            begin
                //    ObjUserMgt.LookupUserID("User ID");
            end;

            trigger OnValidate()
            begin

                // Obj// UserMgt.ValidateUserID("User ID");

                ObjUsers.Reset;
                ObjUsers.SetRange("User Name", "User ID");
                if ObjUsers.Find('-') then begin
                    //"Credit Officer" := ObjUsers."Credit Officer";
                    //Branch := ObjUsers."Branch Code";
                end;
            end;
        }
        field(2; Branch; Code[30])
        {
        }
        field(3; "Credit Officer"; Boolean)
        {
        }
        field(4; "Field Officer"; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "User ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "User ID", Branch, "Credit Officer")
        {
        }
    }

    var
        ObjUsers: Record User;
        ObjUserMgt: Codeunit "User Management";
}

