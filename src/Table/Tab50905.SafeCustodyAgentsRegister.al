#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50905 "Safe Custody Agents Register"
{

    fields
    {
        field(1; "Package ID"; Code[50])
        {
        }
        field(2; "Agent ID"; Code[50])
        {

            trigger OnValidate()
            begin
                if "Agent ID" <> xRec."Agent ID" then begin
                    SalesSetup.Get;
                    NoSeriesMgt.TestManual(SalesSetup."Safe Custody Agent Nos");
                    "No. Series" := '';
                end;
            end;
        }
        field(3; "Agent Member No"; Code[50])
        {
            TableRelation = "Members Register"."No.";

            trigger OnValidate()
            begin
                if ObjCust.Get("Agent Member No") then begin
                    "Agent Name" := ObjCust.Name;
                    "Agent ID/Passport No" := ObjCust."ID No.";
                    "Agent Mobile No" := ObjCust."Mobile Phone No";
                    "Agent Postal Address" := ObjCust.Address;
                    "Agent Postal Code" := ObjCust."Post Code";
                    "Agent Physical Address" := ObjCust."Member's Residence";
                    Picture := ObjCust.Picture;
                    Signature := ObjCust.Signature;
                end;
            end;
        }
        field(4; "Agent Name"; Code[50])
        {
        }
        field(5; "Access Instructions"; Text[150])
        {
        }
        field(6; "Is Owner"; Boolean)
        {
        }
        field(7; "Created By"; Code[50])
        {
        }
        field(8; "Date Appointed"; Date)
        {
        }
        field(9; "Modified By"; Code[50])
        {
        }
        field(10; "Modified On"; Date)
        {
        }
        field(11; "Withdrawned By"; Code[50])
        {
        }
        field(12; "Withdrawned On"; Date)
        {
        }
        field(13; "No. Series"; Code[50])
        {
        }
        field(14; Picture; MediaSet)
        {
        }
        field(15; Signature; MediaSet)
        {
        }
        field(16; "Agent ID/Passport No"; Code[50])
        {
        }
        field(17; "Agent Mobile No"; Code[50])
        {
        }
        field(18; "Agent Postal Address"; Code[50])
        {
        }
        field(19; "Agent Postal Code"; Code[50])
        {
            TableRelation = "Post Code".Code;
        }
        field(20; "Agent Physical Address"; Code[50])
        {
        }
        field(21; "Collect Package/Item"; Boolean)
        {
        }
        field(22; "Add Package/Item"; Boolean)
        {
        }
        field(23; "Make Copy of Package/Item"; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Package ID", "Agent ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Package ID", "Agent ID", "Agent Name", "Access Instructions", "Is Owner")
        {
        }
    }

    trigger OnInsert()
    begin
        if "Agent ID" = '' then begin
            SalesSetup.Get;
            SalesSetup.TestField(SalesSetup."Safe Custody Agent Nos");
            NoSeriesMgt.InitSeries(SalesSetup."Safe Custody Agent Nos", xRec."No. Series", 0D, "Agent ID", "No. Series");
        end;

        "Created By" := UserId;
        "Date Appointed" := Today;
    end;

    trigger OnModify()
    begin
        "Modified By" := UserId;
        "Modified On" := Today;
    end;

    var
        SalesSetup: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        ObjCust: Record "Members Register";
}

