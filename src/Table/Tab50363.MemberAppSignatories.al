#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50363 "Member App Signatories"
{
    //nownPage51516363;
    //nownPage51516363;

    fields
    {
        field(1; "Account No"; Code[20])
        {
            NotBlank = true;
            TableRelation = "Membership Applications"."No.";
        }
        field(2; Names; Text[50])
        {
        }
        field(3; "Date Of Birth"; Date)
        {
        }
        field(4; "Staff/Payroll"; Code[20])
        {
        }
        field(5; "ID No."; Code[50])
        {

            trigger OnValidate()
            begin
                ObjCust.Reset;
                ObjCust.SetRange(ObjCust."ID No.", "ID No.");
                if ObjCust.FindSet then begin
                    Names := Cust.Name;
                    "Email Address" := Cust."E-Mail";
                    "Date Of Birth" := Cust."Date of Birth";
                    "Staff/Payroll" := Cust."Payroll No";
                    Picture := Cust.Piccture;
                    Signature := Cust.Signature;
                    "Mobile No." := Cust."Mobile Phone No";
                    "BOSA No." := Cust."No.";
                end;
            end;
        }
        field(6; Signatory; Boolean)
        {
        }
        field(7; "Must Sign"; Boolean)
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
            TableRelation = Customer;

            trigger OnValidate()
            begin
                ObjCust.Reset;
                ObjCust.SetRange(ObjCust."No.", "BOSA No.");
                if ObjCust.FindSet then begin
                    Names := ObjCust.Name;
                    "ID No." := ObjCust."ID No.";
                    "Email Address" := ObjCust."E-Mail";
                    "Date Of Birth" := ObjCust."Date of Birth";
                    Picture := ObjCust.Piccture;
                    Signature := ObjCust.Signature;
                    "Mobile No." := ObjCust."Mobile Phone No";
                    Modify;
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
            NotBlank = true;
        }
        field(16; "Maximum Withdrawal"; Decimal)
        {
        }
        field(17; Title; Option)
        {
            OptionCaption = 'Member,Chairperson,Secretary,Treasurer';
            OptionMembers = Member,Chairperson,Secretary,Treasurer;
        }
        field(18; "Document No"; Code[30])
        {

            trigger OnValidate()
            begin
                if "Document No" <> xRec."Document No" then begin
                    NoSeries.Get;
                    NoSeriesMgt.TestManual(NoSeries."Signatories Application Doc No");
                    "No. Series" := '';
                end;
            end;
        }
        field(19; "No. Series"; Code[30])
        {
        }
    }

    keys
    {
        key(Key1; "Document No", "Account No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "Document No" = '' then begin
            NoSeries.Get;
            NoSeries.TestField(NoSeries."Signatories Application Doc No");
            NoSeriesMgt.InitSeries(NoSeries."Signatories Application Doc No", xRec."No. Series", 0D, "Document No", "No. Series");
        end;
    end;

    var
        Cust: Record Customer;
        ObjCust: Record Customer;
        NoSeries: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;
}

