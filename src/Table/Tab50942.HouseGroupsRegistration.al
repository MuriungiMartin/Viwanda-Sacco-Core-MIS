#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50942 "House Groups Registration"
{
    //nownPage51516961;
    //nownPage51516961;

    fields
    {
        field(1; "House Group Code"; Code[20])
        {

            trigger OnValidate()
            begin
                if "House Group Code" <> xRec."House Group Code" then begin
                    SalesSetup.Get;
                    NoSeriesMgt.TestManual(SalesSetup."House Group Application");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "House Group Name"; Code[50])
        {
        }
        field(3; "Date Formed"; Date)
        {
        }
        field(4; "Meeting Date"; Date)
        {
        }
        field(5; "Group Leader"; Code[20])
        {
            TableRelation = Customer."No.";

            trigger OnValidate()
            begin
                if ObjCust.Get("Group Leader") then begin
                    "Group Leader Name" := ObjCust.Name;
                    "Group Leader Email" := ObjCust."E-Mail";
                    "Group Leader Phone No" := ObjCust."Mobile Phone No";
                end;
            end;
        }
        field(6; "Group Leader Name"; Code[40])
        {
        }
        field(7; "Assistant group Leader"; Code[20])
        {
            TableRelation = Customer."No.";

            trigger OnValidate()
            begin
                if ObjCust.Get("Assistant group Leader") then begin
                    "Assistant Group Name" := ObjCust.Name;
                    "Assistant Group Leader Email" := ObjCust."E-Mail";
                    "Assistant Group Leader Phone N" := ObjCust."Mobile Phone No";
                end;
            end;
        }
        field(8; "Assistant Group Name"; Code[40])
        {
        }
        field(9; "Meeting Place"; Code[60])
        {
        }
        field(10; "Created By"; Code[20])
        {
        }
        field(11; "Created On"; Date)
        {
        }
        field(12; "No. Series"; Code[20])
        {
        }
        field(13; "Group Leader Email"; Text[60])
        {
        }
        field(14; "Assistant Group Leader Email"; Text[60])
        {
        }
        field(15; "Group Satatus"; Option)
        {
            OptionCaption = 'Active,Inactive,A';
            OptionMembers = Active,Inactive,A;
        }
        field(16; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));

            trigger OnValidate()
            begin
                /*DimValue.RESET;
                DimValue.SETRANGE(DimValue.Code,"Global Dimension 2 Code");
                  IF DimValue.FIND('-') THEN BEGIN
                    "Member Branch Code":=DimValue."Branch Codes";
                  END;
                  FnCreateDefaultSavingsProducts();
                  */

            end;
        }
        field(17; "Group Leader Phone No"; Code[20])
        {
        }
        field(18; "Assistant Group Leader Phone N"; Code[20])
        {
        }
        field(19; "No of Members"; Integer)
        {
            CalcFormula = count(Customer where("Member House Group" = field("House Group Code")));
            FieldClass = FlowField;
        }
        field(20; "Credit Officer"; Code[20])
        {
            TableRelation = User."User Name";

            trigger OnLookup()
            var
                UserMgt: Codeunit "User Management";
            begin
                // UserMgt.LookupUserID("Credit Officer");
            end;

            trigger OnValidate()
            var
                UserMgt: Codeunit "User Management";
            begin
                // UserMgt.ValidateUserID("Credit Officer");
            end;
        }
        field(21; "Field Officer"; Code[20])
        {
            TableRelation = User."User Name";

            trigger OnLookup()
            var
                UserMgt: Codeunit "User Management";
            begin
                // UserMgt.LookupUserID("Field Officer");
            end;

            trigger OnValidate()
            var
                UserMgt: Codeunit "User Management";
            begin
                // UserMgt.ValidateUserID("Field Officer");
            end;
        }
        field(22; Status; Option)
        {
            Editable = false;
            OptionCaption = 'Open,Pending Approval,Approved,Rejected';
            OptionMembers = Open,"Pending Approval",Approved,Rejected;
        }
        field(23; "Captured By"; Code[30])
        {
            Editable = false;
        }
        field(24; "Captured On"; Date)
        {
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "House Group Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "House Group Code", "House Group Name", "Group Leader Name", "Assistant group Leader", "No of Members")
        {
        }
    }

    trigger OnInsert()
    begin
        if "House Group Code" = '' then begin
            SalesSetup.Get;
            SalesSetup.TestField(SalesSetup."House Group Application");
            NoSeriesMgt.InitSeries(SalesSetup."House Group Application", xRec."No. Series", 0D, "House Group Code", "No. Series");
        end;

        "Captured By" := UserId;
        "Captured On" := WorkDate;
    end;

    var
        SalesSetup: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        ObjCust: Record Customer;
}

