#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50912 "ATM Card Receipt Lines"
{
    //nownPage51516947;
    //nownPage51516947;

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

            trigger OnValidate()
            begin
                if ("ATM Card No" <> '') and (StrLen("ATM Card No") <> 16) then
                    Error('The ATM Card No. must be 16 digits. Ensure you have input the correct Card No.');

                if "ATM Card No" <> '' then begin
                    Received := true;
                    "Received By" := UserId;
                    "Received On" := Today;
                end;

                if "ATM Card No" = '' then begin
                    Received := false;
                    "Received By" := '';
                    "Received On" := 0D;
                end;

                if ObjReceipHeader.Get("Batch No.") then begin
                    ObjATMApplications.Reset;
                    ObjATMApplications.SetRange(ObjATMApplications."No.", "ATM Application No");
                    if ObjATMApplications.FindSet then begin
                        ObjATMApplications."Card Received" := Received;
                        ObjATMApplications."Card Received By" := "Received By";
                        ObjATMApplications."Card Received On" := "Received On";
                        ObjATMApplications."Card No" := "ATM Card No";
                        ObjATMApplications."ATM Card Bank Batch No" := ObjReceipHeader."Bank Batch No";
                        ObjATMApplications.Modify;
                    end;
                end;
            end;
        }
        field(6; Received; Boolean)
        {
        }
        field(7; "Received By"; Code[20])
        {
        }
        field(8; "Received On"; Date)
        {
        }
        field(9; "ATM Card Application Date"; Date)
        {
        }
        field(10; "Request Type"; Text[30])
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
        ObjReceipHeader: Record "ATM Card Receipt Batch";
}

