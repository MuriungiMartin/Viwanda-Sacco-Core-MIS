#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50915 "Member House Groups"
{
    //nownPage51516961;
    //nownPage51516961;

    fields
    {
        field(1; "Cell Group Code"; Code[20])
        {

            trigger OnValidate()
            begin
                if "Cell Group Code" <> xRec."Cell Group Code" then begin
                    SalesSetup.Get;
                    NoSeriesMgt.TestManual(SalesSetup."Member Cell Group Nos");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Cell Group Name"; Code[50])
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
            TableRelation = "Members Register"."No." where("Member House Group" = field("Cell Group Code"));

            trigger OnValidate()
            begin
                if ObjCust.Get("Group Leader") then begin
                    "Group Leader Name" := ObjCust.Name;
                    "Group Leader Email" := ObjCust."E-Mail";
                    "Group Leader Phone No" := ObjCust."Mobile Phone No";
                end else begin
                    "Group Leader Name" := '';
                    "Group Leader Email" := '';
                    "Group Leader Phone No" := '';
                end;
            end;
        }
        field(6; "Group Leader Name"; Code[40])
        {
        }
        field(7; "Assistant group Leader"; Code[20])
        {
            TableRelation = "Members Register"."No." where("Member House Group" = field("Cell Group Code"));

            trigger OnValidate()
            begin
                if ObjCust.Get("Assistant group Leader") then begin
                    "Assistant Group Name" := ObjCust.Name;
                    "Assistant Group Leader Email" := ObjCust."E-Mail";
                    "Assistant Group Leader Phone N" := ObjCust."Mobile Phone No";
                end else begin
                    "Assistant Group Name" := '';
                    "Assistant Group Leader Email" := '';
                    "Assistant Group Leader Phone N" := '';
                end;
            end;
        }
        field(8; "Assistant Group Name"; Code[40])
        {

            trigger OnValidate()
            begin
                VarTotalMemberDeposits := 0;
                VarTotalLoans := 0;

                ObjCust.Reset;
                ObjCust.SetRange(ObjCust."Member House Group", "Cell Group Code");
                ObjCust.SetRange(ObjCust.Status, ObjCust.Status::Active);
                if ObjCust.FindSet then begin
                    repeat
                        ObjCust.CalcFields(ObjCust."Current Shares", ObjCust."Total BOSA Loan Balance");
                        VarTotalMemberDeposits := VarTotalMemberDeposits + ObjCust."Current Shares";
                        VarTotalLoans := VarTotalLoans + ObjCust."Total BOSA Loan Balance";
                    until ObjCust.Next = 0;
                    "Member Deposits" := VarTotalMemberDeposits;
                    "Loan Balances" := VarTotalLoans;
                end;
            end;
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
            CalcFormula = count("Members Register" where("Member House Group" = field("Cell Group Code")));
            FieldClass = FlowField;
        }
        field(51516229; "Credit Officer"; Code[30])
        {
            TableRelation = "Credit/Field Officers"."User ID" where("Credit Officer" = filter(true));
        }
        field(51516230; "Field Officer"; Code[30])
        {
            TableRelation = "Credit/Field Officers"."User ID" where("Field Officer" = filter(true));
        }
        field(51516231; "Member Deposits"; Decimal)
        {
            FieldClass = FlowField;
        }
        field(51516232; "Loan Balances"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Cell Group Code")
        {
            Clustered = true;
        }
        key(Key2; "Cell Group Name")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Cell Group Code", "Cell Group Name", "Group Leader Name", "Assistant group Leader", "No of Members")
        {
        }
    }

    trigger OnInsert()
    begin
        if "Cell Group Code" = '' then begin
            SalesSetup.Get;
            SalesSetup.TestField(SalesSetup."Member Cell Group Nos");
            NoSeriesMgt.InitSeries(SalesSetup."Member Cell Group Nos", xRec."No. Series", 0D, "Cell Group Code", "No. Series");
        end;

        "Created By" := UserId;
        "Created On" := Today;
    end;

    var
        SalesSetup: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        ObjCust: Record "Members Register";
        VarTotalMemberDeposits: Decimal;
        VarTotalLoans: Decimal;
}

