#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50355 "Employers Register"
{
    //nownPage51516422;
    //nownPage51516422;

    fields
    {
        field(1; "Employer Code"; Code[20])
        {

            trigger OnValidate()
            begin
                if "Employer Code" <> xRec."Employer Code" then begin
                    SalesSetup.Get;
                    NoSeriesMgt.TestManual(SalesSetup."Employers Nos");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Employer Name"; Text[150])
        {
        }
        field(3; "Employer Address"; Code[50])
        {
        }
        field(4; "Employer Physical Location"; Text[250])
        {
        }
        field(5; "Employer Email"; Text[50])
        {
        }
        field(6; "Employer Phone No"; Code[30])
        {
        }
        field(7; "Contact Person"; Text[100])
        {
        }
        field(8; "Contact Person Mobile No"; Code[30])
        {
        }
        field(9; "Created On"; Date)
        {
            Editable = false;
        }
        field(10; "Created By"; Code[50])
        {
            Editable = false;
        }
        field(12; "No. Series"; Code[20])
        {
        }
        field(69219; "Payment Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Checkoff,Standing Order';
            OptionMembers = " ",Checkoff,"Standing Order";
        }
    }

    keys
    {
        key(Key1; "Employer Code")
        {
            Clustered = true;
        }
        key(Key2; "Employer Name")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Employer Code", "Employer Name", "Employer Address", "Employer Physical Location")
        {
        }
    }

    trigger OnInsert()
    begin
        if "Employer Code" = '' then begin
            SalesSetup.Get;
            SalesSetup.TestField(SalesSetup."Employers Nos");
            NoSeriesMgt.InitSeries(SalesSetup."Employers Nos", xRec."No. Series", 0D, "Employer Code", "No. Series");
        end;
    end;

    var
        SalesSetup: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        ObjAccount: Record Vendor;
        ObjCust: Record Customer;
        ObjLoans: Record "Loans Register";
        ObjSurestep: Codeunit "SURESTEP Factory";
        VarAmountInArrears: Decimal;
        ObjHouses: Record "Member House Groups";
        SFactory: Codeunit "SURESTEP Factory";
}

