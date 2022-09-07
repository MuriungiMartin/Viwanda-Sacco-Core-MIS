#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50948 "Account Agents Change Request"
{
    //nownPage51516363;
    //nownPage51516363;

    fields
    {
        field(1; "Account No"; Code[20])
        {
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
                if ObjCust.Get("BOSA No.") then begin
                    Picture := ObjCust.Picture;
                    Signature := ObjCust.Signature;
                    Names := ObjCust.Name;
                    "ID No." := ObjCust."ID No.";
                    "Mobile No." := ObjCust."Mobile Phone No";
                    "Email Address" := ObjCust."E-Mail";
                end
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
        field(16; "Allowed Balance Enquiry"; Boolean)
        {
        }
        field(17; "Allowed  Correspondence"; Boolean)
        {
        }
        field(18; "Allowed FOSA Withdrawals"; Boolean)
        {
        }
        field(19; "Allowed Loan Processing"; Boolean)
        {
        }
        field(20; "Document No"; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "Document No", "Account No", Names)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Account No", Names, "ID No.", "Mobile No.", "Allowed Balance Enquiry", "Allowed  Correspondence", "Allowed FOSA Withdrawals", "Allowed Loan Processing")
        {
        }
    }

    var
        ObjCust: Record "Members Register";
}

