#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50017 "ATM Pin Receipt Lines"
{
    // //nownPage51516947;
    // //nownPage51516947;

    fields
    {
        field(1; "Batch No."; Code[20])
        {
            NotBlank = false;
        }
        field(2; "ATM Application No"; Code[20])
        {
            TableRelation = "ATM Card Applications"."No.";

            trigger OnValidate()
            begin
                ObjATMApplications.Reset;
                ObjATMApplications.SetRange(ObjATMApplications."No.", "ATM Application No");
                if ObjATMApplications.FindSet then begin
                    "ATM Card Account No" := ObjATMApplications."Account No";
                    "Account Name" := ObjATMApplications."Account Name";
                end;
            end;
        }
        field(3; "ATM Card Account No"; Code[20])
        {
        }
        field(4; "Account Name"; Code[50])
        {
        }
        field(5; "ATM Card No"; Code[20])
        {
        }
        field(6; "Pin Received"; Boolean)
        {

            trigger OnValidate()
            begin
                if "Pin Received" = true then begin
                    "Pin Received" := true;
                    "Pin Received By" := UserId;
                    "Pin Received On" := Today;
                end;

                if "Pin Received" = false then begin
                    "Pin Received" := false;
                    "Pin Received By" := '';
                    "Pin Received On" := 0D;
                end;

                if ObjReceipHeader.Get("Batch No.") then begin

                    ObjATMApplications.Reset;
                    ObjATMApplications.SetRange(ObjATMApplications."No.", "ATM Application No");
                    if ObjATMApplications.FindSet then begin
                        ObjATMApplications."Pin Received" := "Pin Received";
                        ObjATMApplications."Pin Received By" := "Pin Received By";
                        ObjATMApplications."Pin Received On" := "Pin Received On";
                        ObjATMApplications."ATM Pin Bank Batch No" := ObjReceipHeader."Bank Batch No";
                        ObjATMApplications.Modify;
                    end;
                end;
            end;
        }
        field(7; "Pin Received By"; Code[20])
        {
        }
        field(8; "Pin Received On"; Date)
        {
        }
        field(9; "ATM Card Application Date"; Date)
        {
        }
    }

    keys
    {
        key(Key1; "Batch No.", "ATM Application No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        SalesSetup: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        EntryNo: Integer;
        ObjATMApplications: Record "ATM Card Applications";
        ObjReceipHeader: Record "ATM Pin Receipt Batch";
}

