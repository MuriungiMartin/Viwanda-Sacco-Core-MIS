#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50526 "Loan PayOff"
{

    fields
    {
        field(1; "Document No"; Code[20])
        {

            trigger OnValidate()
            begin
                if "Document No" <> xRec."Document No" then begin
                    SalesSetup.Get;
                    NoSeriesMgt.TestManual(SalesSetup."Loan PayOff Nos");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Member No"; Code[20])
        {
            TableRelation = "Members Register"."No.";

            trigger OnValidate()
            begin
                if Cust.Get("Member No") then begin
                    "Member Name" := Cust.Name;
                    "FOSA Account No" := Cust."FOSA Account No.";
                    "Personal No" := Cust."Payroll No";
                    "Global Dimension 2 Code" := Cust."Global Dimension 2 Code";
                    Validate("FOSA Account No");
                end;
            end;
        }
        field(3; "Member Name"; Code[50])
        {
        }
        field(4; "Application Date"; Date)
        {
        }
        field(5; "Requested PayOff Amount"; Decimal)
        {
        }
        field(6; "Approved PayOff Amount"; Decimal)
        {
        }
        field(7; "Created By"; Code[20])
        {
        }
        field(8; "No. Series"; Code[20])
        {
        }
        field(9; "FOSA Account No"; Code[20])
        {
            TableRelation = Vendor."No." where("BOSA Account No" = field("Member No"),
                                                Status = filter(<> Closed | Deceased),
                                                Blocked = filter(<> Payment | All));

            trigger OnValidate()
            begin
                ObjVendors.Reset;
                ObjVendors.SetRange(ObjVendors."No.", "FOSA Account No");
                if ObjVendors.Find('-') then begin
                    ObjVendors.CalcFields(ObjVendors.Balance, ObjVendors."Uncleared Cheques");
                    AvailableBal := (ObjVendors.Balance - ObjVendors."Uncleared Cheques");

                    ObjAccTypes.Reset;
                    ObjAccTypes.SetRange(ObjAccTypes.Code, ObjVendors."Account Type");
                    if ObjAccTypes.Find('-') then
                        AvailableBal := AvailableBal - ObjAccTypes."Minimum Balance";
                end;
                "FOSA Account Available Balance" := AvailableBal;
            end;
        }
        field(10; "Total PayOut Amount"; Decimal)
        {
            CalcFormula = sum("Loans PayOff Details"."Total PayOff" where("Document No" = field("Document No")));
            FieldClass = FlowField;
        }
        field(11; "Global Dimension 2 Code"; Code[10])
        {
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2),
                                                          "Dimension Value Type" = const(Standard));
        }
        field(12; Posted; Boolean)
        {
        }
        field(13; "Posting Date"; Date)
        {
        }
        field(14; "Posted By"; Code[20])
        {
        }
        field(15; "Personal No"; Code[30])
        {
        }
        field(22; Status; Option)
        {
            OptionCaption = 'Open,Pending Approval,Approved,Rejected';
            OptionMembers = Open,"Pending Approval",Approved,Rejected;
        }
        field(23; "FOSA Account Available Balance"; Decimal)
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
    }

    trigger OnInsert()
    begin

        if "Document No" = '' then begin
            SalesSetup.Get;
            SalesSetup.TestField(SalesSetup."Loan PayOff Nos");
            NoSeriesMgt.InitSeries(SalesSetup."Loan PayOff Nos", xRec."No. Series", 0D, "Document No", "No. Series");
        end;
    end;

    var
        SalesSetup: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Cust: Record "Members Register";
        ObjVendors: Record Vendor;
        AvailableBal: Decimal;
        ObjAccTypes: Record "Account Types-Saving Products";
}

