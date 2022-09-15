#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50964 "CRB Notice Register"
{

    fields
    {
        field(1; "Loan No"; Code[20])
        {
            Editable = false;
        }
        field(2; "Member No"; Code[20])
        {
            Editable = false;
            TableRelation = Customer."No.";

            trigger OnValidate()
            begin
                if ObjCust.Get("Member No") then begin
                    "Member Name" := ObjCust.Name;
                end;
            end;
        }
        field(3; "Member Name"; Code[100])
        {
            Editable = false;
        }
        field(4; "Loan Product Type"; Code[30])
        {
            Editable = false;
            TableRelation = "Loan Products Setup".Code;

            trigger OnValidate()
            begin
                if ObjLoanType.Get("Loan Product Type") then begin
                    "Loan Product Name" := ObjLoanType."Product Description";
                end;
            end;
        }
        field(5; "Loan Product Name"; Text[50])
        {
            Editable = false;
        }
        field(6; "Issued Date"; Date)
        {
            Editable = false;
        }
        field(7; "Approved Amount"; Decimal)
        {
            Editable = false;
        }
        field(8; "Principle Outstanding"; Decimal)
        {
            Editable = false;
        }
        field(9; "Amount In Arrears"; Decimal)
        {
            Editable = false;
        }
        field(10; "Days In Arrears"; Integer)
        {
            Editable = false;
        }
        field(11; "Date Of Notice"; Date)
        {
            Editable = false;
        }
        field(12; "CRB Listed"; Boolean)
        {

            trigger OnValidate()
            begin
                if Confirm('Confirm CRB Notification?', false) = true then begin
                    "Date Listed" := WorkDate;
                    "Listed By" := UserId;
                end;
            end;
        }
        field(13; "Date Listed"; Date)
        {
            Editable = false;
        }
        field(14; "Listed By"; Code[50])
        {
            Editable = false;
        }
        field(15; Delist; Boolean)
        {

            trigger OnValidate()
            begin
                if Confirm('Confirm CRB DeListing?', false) = true then begin
                    if Delist = true then begin
                        "CRB Listed" := false;
                        Delist := true;
                        "Delisted By" := UserId;
                        "DeListed On" := WorkDate;
                    end else
                        "CRB Listed" := true;
                    Delist := false;
                    "Delisted By" := '';
                    "DeListed On" := 0D;
                end;
            end;
        }
        field(16; "DeListed On"; Date)
        {
            Editable = false;
        }
        field(17; "Delisted By"; Code[30])
        {
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Loan No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        ObjCust: Record Customer;
        ObjLoanType: Record "Loan Products Setup";
}

