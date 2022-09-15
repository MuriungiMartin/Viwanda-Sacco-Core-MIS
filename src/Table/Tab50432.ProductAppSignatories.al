#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50432 "Product App Signatories"
{
    //nownPage51516433;
    //nownPage51516433;

    fields
    {
        field(1; "Document No"; Code[30])
        {
            Editable = false;

            trigger OnValidate()
            begin
                if "Document No" <> xRec."Document No" then begin
                    NoSeries.Get;
                    NoSeriesMgt.TestManual(NoSeries."Signatories Application Doc No");
                    "No. Series" := '';
                end;
                DocNo := "Document No";
            end;
        }
        field(2; "Account No"; Code[20])
        {
            TableRelation = "FOSA Account Applicat. Details"."No.";
        }
        field(3; Names; Text[50])
        {
            NotBlank = true;
        }
        field(4; "Date Of Birth"; Date)
        {
        }
        field(5; "Staff/Payroll"; Code[20])
        {
        }
        field(6; "ID No."; Code[50])
        {
        }
        field(7; Signatory; Boolean)
        {
        }
        field(8; "Must Sign"; Boolean)
        {
        }
        field(9; "Must be Present"; Boolean)
        {
        }
        field(10; Picture; MediaSet)
        {
            Caption = 'Picture';
        }
        field(11; Signature; MediaSet)
        {
            Caption = 'Signature';
        }
        field(12; "Expiry Date"; Date)
        {
        }
        field(13; "BOSA No."; Code[30])
        {
            TableRelation = Customer."No.";

            trigger OnValidate()
            begin
                if ObjCust.Get("BOSA No.") then begin
                    Names := ObjCust.Name;
                    "ID No." := ObjCust."ID No.";
                    "Email Address" := ObjCust."E-Mail";
                    "Date Of Birth" := ObjCust."Date of Birth";
                    "Staff/Payroll" := ObjCust."Payroll No";
                    "Mobile Phone No." := ObjCust."Mobile Phone No";
                end;
            end;
        }
        field(14; "Email Address"; Text[50])
        {
        }
        field(15; Designation; Code[20])
        {
        }
        field(16; "Send SMS"; Boolean)
        {
        }
        field(17; "Mobile Phone No."; Code[50])
        {
        }
        field(18; "No. Series"; Code[30])
        {
        }
        field(19; "Signature II"; MediaSet)
        {
        }
        field(20; DocNo; Code[30])
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
        NoSeries: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        ObjCust: Record Customer;
}

