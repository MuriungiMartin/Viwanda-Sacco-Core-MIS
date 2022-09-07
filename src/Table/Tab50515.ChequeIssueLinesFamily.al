#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50515 "Cheque Issue Lines-Family"
{

    fields
    {
        field(1; "Chq Receipt No"; Code[20])
        {
        }
        field(2; "Cheque Serial No"; Code[20])
        {
        }
        field(3; "Account No."; Code[20])
        {
            TableRelation = Vendor."No.";
        }
        field(4; "Date _Refference No."; Code[20])
        {
        }
        field(5; "Transaction Code"; Code[20])
        {
        }
        field(6; "Branch Code"; Code[20])
        {
        }
        field(7; Currency; Code[10])
        {
        }
        field(8; Amount; Decimal)
        {
        }
        field(9; "Date-1"; Date)
        {
        }
        field(10; "Date-2"; Date)
        {
        }
        field(11; "Family Routing No."; Code[10])
        {
        }
        field(12; Fillers; Code[10])
        {
        }
        field(13; "Transaction Refference"; Code[10])
        {
        }
        field(14; "Account Name"; Text[150])
        {
        }
        field(15; "Un pay Code"; Code[10])
        {
            TableRelation = "Cheque Transaction Codes".Code;

            trigger OnValidate()
            begin
                "Un Pay Charge Amount" := 0;
                "Unpay Date" := 0D;
                "Un pay User Id" := '';

                ObjChequeTransactionCode.Reset;
                ObjChequeTransactionCode.SetRange(Code, "Un pay Code");
                if ObjChequeTransactionCode.Find('-') then begin
                    Interpretation := ObjChequeTransactionCode."Transaction Name";
                    ObjChqTransactionCharge.Reset;
                    ObjChqTransactionCharge.SetRange(code, ObjChequeTransactionCode."Transaction Category");
                    if ObjChqTransactionCharge.Find('-') then begin
                        "Un Pay Charge Amount" := ObjChqTransactionCharge.Amount;
                        "Charge Unpay Sacco Income" := ObjChqTransactionCharge."Sacco Income";
                        "Unpay Date" := Today;
                        "Un pay User Id" := UserId;
                    end;
                end else
                    Interpretation := '';
                Modify;
            end;
        }
        field(16; Interpretation; Text[150])
        {
            Editable = false;
        }
        field(17; "Family Account No."; Code[20])
        {
            Editable = false;
        }
        field(18; "Un Pay Charge Amount"; Decimal)
        {
            Editable = false;
        }
        field(19; "Unpay Date"; Date)
        {
        }
        field(20; Status; Option)
        {
            OptionCaption = 'Pending,Approved,Cancelled,stopped';
            OptionMembers = Pending,Approved,Cancelled,stopped;

            trigger OnValidate()
            begin
                if Status = Status::Approved then begin
                    "Transaction Date" := Today;
                    Modify;
                end;
            end;
        }
        field(21; "Cheque No"; Code[50])
        {
        }
        field(22; "Header No"; Code[50])
        {
        }
        field(23; "Account Balance"; Decimal)
        {
            FieldClass = Normal;
        }
        field(24; FrontImage; Blob)
        {
            SubType = Bitmap;
        }
        field(25; FrontGrayImage; Blob)
        {
            SubType = Bitmap;
        }
        field(26; BackImages; Blob)
        {
            SubType = Bitmap;
        }
        field(27; "Verification Status"; Option)
        {
            InitValue = "Not Verified";
            OptionCaption = ' ,Not Verified,Verified';
            OptionMembers = " ","Not Verified",Verified;

            trigger OnValidate()
            begin
                Modify;
            end;
        }
        field(28; Processed; Boolean)
        {
        }
        field(29; "Transaction Date"; Date)
        {
        }
        field(30; "Member Branch"; Code[50])
        {
        }
        field(31; "Un pay User Id"; Code[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(32; "Charge Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(33; "Charge Amount Sacco Income"; Decimal)
        {
        }
        field(34; "Charge Unpay Sacco Income"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Chq Receipt No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        ObjChqTransactionCharge: Record "Cheque Transaction Charges(B)";
        ObjChequeTransactionCode: Record "Cheque Transaction Codes";
}

