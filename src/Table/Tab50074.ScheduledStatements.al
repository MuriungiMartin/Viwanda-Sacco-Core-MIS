#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50074 "Scheduled Statements"
{

    fields
    {
        field(1; "Document No"; Code[30])
        {

            trigger OnValidate()
            begin
                if "Document No" <> xRec."Document No" then begin
                    SalesSetup.Get;
                    NoSeriesMgt.TestManual(SalesSetup."Scheduled Statements");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Member No"; Code[30])
        {
            TableRelation = Customer."No.";

            trigger OnValidate()
            begin
                if ObjCust.Get("Member No") then
                    "Member Name" := ObjCust.Name;
            end;
        }
        field(3; "Member Name"; Code[200])
        {
        }
        field(4; "Account No"; Code[30])
        {
            TableRelation = Vendor."No." where("BOSA Account No" = field("Member No"));

            trigger OnValidate()
            begin
                ObjAccount.Reset;
                ObjAccount.SetRange("No.", "Account No");
                if ObjAccount.FindSet then
                    "Account Email" := ObjAccount."E-Mail";
            end;
        }
        field(5; "Statement Period"; DateFormula)
        {
        }
        field(6; Frequency; Option)
        {
            OptionCaption = 'Daily,Weekly,Mothly';
            OptionMembers = Daily,Weekly,Mothly;
        }
        field(7; "Days of Week"; Text[250])
        {
        }
        field(8; "No. Series"; Code[50])
        {
        }
        field(9; "Statement Type"; Option)
        {
            OptionCaption = 'Member Statement,Account Statement';
            OptionMembers = "Member Statement","Account Statement";
        }
        field(10; "Schedule Status"; Option)
        {
            OptionCaption = ' ,Active,Stopped';
            OptionMembers = " ",Active,Stopped;
        }
        field(11; "Created By"; Code[30])
        {
            Editable = false;
        }
        field(12; "Created On"; Date)
        {
            Editable = false;
        }
        field(13; "Activated By"; Code[30])
        {
            Editable = false;
        }
        field(14; "Activated On"; Date)
        {
            Editable = false;
        }
        field(15; "Stopped By"; Code[30])
        {
            Editable = false;
        }
        field(16; "Stopped On"; Date)
        {
            Editable = false;
        }
        field(17; "Account Email"; Text[50])
        {

            trigger OnValidate()
            begin
                ObjAccount.Reset;
                ObjAccount.SetRange("No.", "Account No");
                if ObjAccount.FindSet then begin
                    ObjAccount."E-Mail" := "Account Email";
                    ObjAccount.Modify;
                end
            end;
        }
        field(18; "Days Of Month"; Text[30])
        {
        }
        field(19; "Output Format"; Option)
        {
            OptionCaption = 'PDF,EXCEL';
            OptionMembers = PDF,EXCEL;
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
            SalesSetup.TestField(SalesSetup."Scheduled Statements");
            NoSeriesMgt.InitSeries(SalesSetup."Scheduled Statements", xRec."No. Series", 0D, "Document No", "No. Series");
        end;

        "Created On" := WorkDate;
        "Created By" := UserId;
    end;

    var
        SalesSetup: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        ObjCust: Record Customer;
        ObjAccount: Record Vendor;
}

