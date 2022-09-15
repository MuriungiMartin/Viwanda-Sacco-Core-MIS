#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50649 "Piggy Bank Issuance"
{

    fields
    {
        field(1; "Document No"; Code[30])
        {
            Editable = false;

            trigger OnValidate()
            begin
                if "Document No" <> xRec."Document No" then begin
                    NoSetup.Get();
                    NoSeriesMgt.TestManual(NoSetup."Piggy Bank No");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Member Account No"; Code[30])
        {
            TableRelation = Customer."No.";

            trigger OnValidate()
            begin
                if ObjCust.Get("Member Account No") then begin
                    "Member Name" := ObjCust.Name;
                end;
            end;
        }
        field(3; "Member Name"; Code[100])
        {
            Editable = false;
        }
        field(4; "Piggy Bank Account"; Code[20])
        {
            TableRelation = Vendor."No." where("BOSA Account No" = field("Member Account No"),
                                                "Global Dimension 1 Code" = filter('FOSA'));

            trigger OnValidate()
            begin
                if ObjAccount.Get("Piggy Bank Account") then begin
                    "Piggy Bank Account Name" := ObjAccount.Name;
                end;

                ObjPiggyBank.Reset;
                ObjPiggyBank.SetRange(ObjPiggyBank."Piggy Bank Account", "Piggy Bank Account");
                ObjPiggyBank.SetRange(ObjPiggyBank.Issued, true);
                if ObjPiggyBank.FindSet then begin
                    "Exisiting piggy Bank" := true;
                end;
            end;
        }
        field(5; "Piggy Bank Account Name"; Code[100])
        {
            Editable = false;
        }
        field(6; "Exisiting piggy Bank"; Boolean)
        {
            Editable = false;
        }
        field(7; "Issued By"; Code[30])
        {
        }
        field(8; "Issued On"; Date)
        {
        }
        field(9; "Issued To"; Code[30])
        {
        }
        field(10; "Collected By"; Code[60])
        {
        }
        field(11; "Captured By"; Code[30])
        {
        }
        field(12; "No. Series"; Code[30])
        {
        }
        field(13; "Captured On"; Date)
        {
        }
        field(14; Issued; Boolean)
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
            NoSetup.Get();
            NoSetup.TestField(NoSetup."Piggy Bank No");
            NoSeriesMgt.InitSeries(NoSetup."Piggy Bank No", xRec."No. Series", 0D, "Document No", "No. Series");
        end;
        "Captured By" := UserId;
        "Captured On" := WorkDate;
    end;

    var
        NoSetup: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        ObjCust: Record Customer;
        ObjAccount: Record Vendor;
        ObjPiggyBank: Record "Piggy Bank Issuance";
}

