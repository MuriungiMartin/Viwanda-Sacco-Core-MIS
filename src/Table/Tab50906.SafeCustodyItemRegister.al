#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50906 "Safe Custody Item Register"
{

    fields
    {
        field(1; "Package ID"; Code[20])
        {
        }
        field(2; "Item ID"; Code[20])
        {

            trigger OnValidate()
            begin
                if "Item ID" <> xRec."Item ID" then begin
                    SalesSetup.Get;
                    NoSeriesMgt.TestManual(SalesSetup."Safe Custody Item Nos");
                    "No. Series" := '';
                end;
            end;
        }
        field(3; "Item Description"; Text[100])
        {
        }
        field(4; "Registered Owner"; Code[100])
        {
        }
        field(5; "Document Reference"; Code[100])
        {
        }
        field(6; "Date Received"; Date)
        {
        }
        field(7; "Received By"; Code[30])
        {
        }
        field(8; "Lodged By(Custodian 1)"; Code[30])
        {
        }
        field(9; "Lodged By(Custodian 2)"; Code[30])
        {
        }
        field(10; "Date Lodged"; Date)
        {
        }
        field(11; "Released On"; Date)
        {
        }
        field(12; "Released By"; Code[30])
        {
        }
        field(13; "Date Collected"; Date)
        {
        }
        field(14; "Collected By"; Code[30])
        {
            TableRelation = "Safe Custody Agents Register"."Agent ID" where("Package ID" = field("Package ID"));

            trigger OnValidate()
            begin
                if ObjAgents.Get("Collected By") then begin
                    "Collected By Name" := ObjAgents."Agent Name";
                end;
            end;
        }
        field(15; "Retrieved By(Custodian 1)"; Code[30])
        {
        }
        field(16; "Retrieved By(Custodian 2)"; Code[30])
        {
        }
        field(17; "Retrieved On"; Date)
        {
        }
        field(18; "No. Series"; Code[30])
        {
        }
        field(51516158; "Released By(Custodian 1)"; Code[30])
        {
        }
        field(51516159; "Released By(Custodian 2)"; Code[30])
        {
        }
        field(51516160; "Date Released"; Date)
        {
        }
        field(51516161; "Time Released"; Time)
        {
        }
        field(51516162; "Collected By Name"; Code[100])
        {
        }
    }

    keys
    {
        key(Key1; "Package ID", "Item ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Package ID", "Item ID", "Item Description", "Registered Owner", "Document Reference")
        {
        }
    }

    trigger OnInsert()
    begin
        if "Item ID" = '' then begin
            SalesSetup.Get;
            SalesSetup.TestField(SalesSetup."Safe Custody Item Nos");
            NoSeriesMgt.InitSeries(SalesSetup."Safe Custody Item Nos", xRec."No. Series", 0D, "Item ID", "No. Series");
        end;

        "Date Received" := Today;
        "Received By" := UserId;
    end;

    var
        SalesSetup: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        ObjAgents: Record "Safe Custody Agents Register";
}

