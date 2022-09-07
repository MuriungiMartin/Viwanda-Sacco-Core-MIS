#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50015 "ATM Card Request Lines"
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
        field(6; Ordered; Boolean)
        {

            trigger OnValidate()
            begin
                if Ordered = true then begin
                    "Ordered By" := UserId;
                    "Ordered On" := WorkDate;
                end;
                if Ordered = false then begin
                    "Ordered By" := '';
                    "Ordered On" := 0D;
                end;
            end;
        }
        field(7; "Ordered On"; Date)
        {
        }
        field(8; "Ordered By"; Code[30])
        {
        }
        field(9; "ATM Card Application Date"; Date)
        {
        }
        field(10; "Phone No"; Code[30])
        {
        }
        field(11; "ID No"; Code[30])
        {
        }
        field(12; "Request Type"; Option)
        {
            OptionCaption = 'New,Replacement,Renewal';
            OptionMembers = New,Replacement,Renewal;
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
}

