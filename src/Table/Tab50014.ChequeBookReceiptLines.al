#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50014 "Cheque Book Receipt Lines"
{
    // //nownPage51516947;
    // //nownPage51516947;

    fields
    {
        field(1; "Batch No."; Code[20])
        {
            NotBlank = false;
        }
        field(2; "Cheque Book Application No"; Code[20])
        {
            TableRelation = "ATM Card Applications"."No.";

            trigger OnValidate()
            begin
                ObjChequeBookApplications.Reset;
                ObjChequeBookApplications.SetRange(ObjChequeBookApplications."No.", "Cheque Book Application No");
                if ObjChequeBookApplications.FindSet then begin
                    "Cheque Book Account No" := ObjChequeBookApplications."Account No.";
                    "Account Name" := ObjChequeBookApplications.Name;
                end;
            end;
        }
        field(3; "Cheque Book Account No"; Code[20])
        {
        }
        field(4; "Account Name"; Code[50])
        {
        }
        field(5; "Cheque Book No"; Code[20])
        {
        }
        field(6; Received; Boolean)
        {

            trigger OnValidate()
            begin
                if Received <> false then begin
                    "Received By" := UserId;
                    "Received On" := Today;
                end;

                if Received = false then begin
                    "Received By" := '';
                    "Received On" := 0D;
                end;

                ObjChequeBookApplications.Reset;
                ObjChequeBookApplications.SetRange(ObjChequeBookApplications."No.", "Cheque Book Application No");
                if ObjChequeBookApplications.FindSet then begin
                    ObjChequeBookApplications."Cheque Book Received" := Received;
                    ObjChequeBookApplications."Received By" := "Received By";
                    ObjChequeBookApplications."Received On" := "Received On";
                    ObjChequeBookApplications."Cheque Book Account No." := "Cheque Book No";
                    ObjChequeBookApplications.Modify;
                end;
            end;
        }
        field(7; "Received By"; Code[20])
        {
        }
        field(8; "Received On"; Date)
        {
        }
        field(9; "Cheque Book Application Date"; Date)
        {
        }
        field(10; "Member No"; Code[30])
        {
            CalcFormula = lookup(Vendor."BOSA Account No" where("No." = field("Cheque Book Account No")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Batch No.", "Cheque Book Application No")
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
        ObjChequeBookApplications: Record "Cheque Book Application";
}

