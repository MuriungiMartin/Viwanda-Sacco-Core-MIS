#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50018 "Cheque Book Request Lines"
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
            TableRelation = "Cheque Book Application"."No.";

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
        field(6; Ordered; Boolean)
        {

            trigger OnValidate()
            begin
                if Ordered <> false then begin
                    "Ordered By" := UserId;
                    "Ordered On" := Today;
                end;

                if Ordered = false then begin
                    "Ordered By" := '';
                    "Ordered On" := 0D;
                end;
                /*
                ObjChequeBookApplications.RESET;
                ObjChequeBookApplications.SETRANGE(ObjChequeBookApplications."No.","Cheque Book Application No");
                IF ObjChequeBookApplications.FINDSET THEN BEGIN
                  ObjChequeBookApplications."Cheque Book Received":=Ordered;
                  ObjChequeBookApplications."Received By":="Ordered By";
                  ObjChequeBookApplications."Received On":="Ordered On";
                  ObjChequeBookApplications."Cheque Book Account No.":="Cheque Book No";
                  ObjChequeBookApplications.MODIFY;
                  END;
                */

            end;
        }
        field(7; "Ordered By"; Code[20])
        {
        }
        field(8; "Ordered On"; Date)
        {
        }
        field(9; "Cheque Book Application Date"; Date)
        {
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

