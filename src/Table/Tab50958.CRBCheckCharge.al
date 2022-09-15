#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50958 "CRB Check Charge"
{
    //nownPage51516982;
    //nownPage51516982;

    fields
    {
        field(1; "Document No"; Code[20])
        {

            trigger OnValidate()
            begin
                if "Document No" <> xRec."Document No" then begin
                    SalesSetup.Get;
                    NoSeriesMgt.TestManual(SalesSetup."CRB Charge");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Member No"; Code[20])
        {
            Editable = false;
            TableRelation = Customer."No.";

            trigger OnValidate()
            begin
                if ObjCust.Get("Member No") then begin
                    ObjCust.CalcFields(ObjCust."Current Shares", ObjCust."Total Loans Outstanding");
                    "Member Name" := ObjCust.Name;
                end;
            end;
        }
        field(3; "Member Name"; Code[50])
        {
            Editable = false;
        }
        field(4; "FOSA Account to Charge"; Code[20])
        {
            TableRelation = Vendor."No." where("BOSA Account No" = field("Member No"),
                                                "Global Dimension 1 Code" = filter('FOSA'));

            trigger OnValidate()
            begin
                ObjVendors.Reset;
                ObjVendors.SetRange(ObjVendors."No.", "FOSA Account to Charge");
                if ObjVendors.Find('-') then begin
                    ObjVendors.CalcFields(ObjVendors.Balance, ObjVendors."Uncleared Cheques");
                    AvailableBal := (ObjVendors.Balance - ObjVendors."Uncleared Cheques");

                    ObjAccTypes.Reset;
                    ObjAccTypes.SetRange(ObjAccTypes.Code, ObjVendors."Account Type");
                    if ObjAccTypes.Find('-') then
                        AvailableBal := AvailableBal - ObjAccTypes."Minimum Balance";
                end;

                if "Charge Amount" > AvailableBal then
                    Error('This Account has less than the Charge Amount,Available Bal is %1', AvailableBal);
            end;
        }
        field(5; "No. Series"; Code[20])
        {
        }
        field(6; "Charge Effected"; Boolean)
        {
        }
        field(7; "Charged By"; Code[20])
        {
        }
        field(8; "Captured By"; Code[20])
        {
        }
        field(9; "Captured On"; Date)
        {
        }
        field(10; "Charged On"; Date)
        {
        }
        field(11; "Charge Amount"; Decimal)
        {
        }
        field(12; "Loan No"; Code[30])
        {
            Editable = false;
            TableRelation = "Loans Register"."Loan  No.";
        }
    }

    keys
    {
        key(Key1; "Document No", "Member No", "Loan No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Document No", "Member No", "Member Name", "FOSA Account to Charge")
        {
        }
    }

    trigger OnInsert()
    begin
        if "Document No" = '' then begin
            SalesSetup.Get;
            SalesSetup.TestField(SalesSetup."CRB Charge");
            NoSeriesMgt.InitSeries(SalesSetup."CRB Charge", xRec."No. Series", 0D, "Document No", "No. Series");
        end;

        ObjGenSetup.Get();

        "Captured By" := UserId;
        "Captured On" := WorkDate;
        "Charge Amount" := ObjGenSetup."CRB Check Charge";
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
        ObjGenSetup: Record "Sacco General Set-Up";
        ObjVendors: Record Vendor;
        ObjAccTypes: Record "Account Types-Saving Products";
        AvailableBal: Decimal;
}

