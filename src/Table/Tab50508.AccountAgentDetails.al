#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50508 "Account Agent Details"
{
    //nownPage51516547;
    //nownPage51516547;

    fields
    {
        field(1; "Account No"; Code[20])
        {
            NotBlank = true;
            TableRelation = Vendor."No.";
        }
        field(2; Names; Text[50])
        {
            NotBlank = true;
        }
        field(3; "Date Of Birth"; Date)
        {
        }
        field(4; "Staff/Payroll"; Code[20])
        {
        }
        field(5; "ID No."; Code[50])
        {
        }
        field(6; "Must Sign"; Boolean)
        {
        }
        field(8; "Must be Present"; Boolean)
        {
        }
        field(9; Picture; MediaSet)
        {
            Caption = 'Picture';
        }
        field(10; Signature; MediaSet)
        {
            Caption = 'Signature';
        }
        field(11; "Expiry Date"; Date)
        {
        }
        field(12; "BOSA No."; Code[30])
        {
            TableRelation = "Members Register";

            trigger OnValidate()
            begin
                CUST.Reset;
                CUST.SetRange(CUST."No.", "BOSA No.");
                if CUST.Find('-') then begin
                    //CUST.CALCFIELDS(CUST.Picture,CUST.Signature);
                    Names := CUST.Name;
                    "Mobile No." := CUST."Mobile Phone No";
                    "Date Of Birth" := CUST."Date of Birth";
                    "Staff/Payroll" := CUST."Payroll No";
                    "ID No." := CUST."ID No.";
                    //Picture:=CUST.Picture;
                    //Signature:=CUST.Signature;
                end;
            end;
        }
        field(13; "Email Address"; Text[50])
        {
        }
        field(14; Designation; Code[20])
        {
        }
        field(15; "Mobile No."; Code[20])
        {
        }
        field(16; "Any to sign"; Boolean)
        {
        }
        field(17; "Both to Sign"; Boolean)
        {
        }
        field(18; "All to sign"; Boolean)
        {
        }
        field(19; "Withdrawal Limit"; Decimal)
        {
        }
        field(20; "Operation Instruction"; Code[100])
        {
        }
        field(21; "Entry No"; Integer)
        {
        }
        field(22; "Source No."; Code[20])
        {
        }
        field(23; "Agent Serial No"; Code[20])
        {

            trigger OnValidate()
            begin
                if "Agent Serial No" <> xRec."Agent Serial No" then begin
                    SalesSetup.Get;
                    NoSeriesmgt.TestManual(SalesSetup."Agent Serial Nos");
                    "No. Series" := '';
                end;
            end;
        }
        field(24; "No. Series"; Code[20])
        {
        }
        field(25; "Allowed Balance Enquiry"; Boolean)
        {
        }
        field(26; "Allowed  Correspondence"; Boolean)
        {
        }
        field(27; "Allowed FOSA Withdrawals"; Boolean)
        {
        }
        field(28; "Allowed Loan Processing"; Boolean)
        {
        }
        field(29; "Allow Cheque Processing"; Boolean)
        {
        }
        field(30; "Document No"; Code[30])
        {
        }
    }

    keys
    {
        key(Key1; "Document No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Account No", Names, "ID No.", "Mobile No.", "Allowed Balance Enquiry", "Allowed  Correspondence", "Allowed FOSA Withdrawals", "Allowed Loan Processing", "Withdrawal Limit")
        {
        }
    }

    trigger OnInsert()
    begin
        /*IF "Agent Serial No" = '' THEN BEGIN
          SalesSetup.GET;
          SalesSetup.TESTFIELD(SalesSetup."Agent Serial Nos");
          NoSeriesmgt.InitSeries(SalesSetup."Agent Serial Nos",xRec."No. Series",0D,"Agent Serial No","No. Series");
        END;*/

    end;

    var
        CUST: Record "Members Register";
        NoSeriesmgt: Codeunit NoSeriesManagement;
        SalesSetup: Record "Sacco No. Series";
}

