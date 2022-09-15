#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50424 "Member Sweeping Instructions"
{

    fields
    {
        field(1; "Document No"; Code[20])
        {
            Editable = false;

            trigger OnValidate()
            begin
                if "Document No" <> xRec."Document No" then begin
                    SalesSetup.Get;
                    NoSeriesMgt.TestManual(SalesSetup."Sweeping Instructions");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Member No"; Code[30])
        {
            TableRelation = Customer."No.";

            trigger OnValidate()
            begin
                if ObjMember.Get("Member No") then begin
                    "Member Name" := ObjMember.Name;
                end;
            end;
        }
        field(3; "Member Name"; Code[100])
        {
            Editable = false;
        }
        field(4; "Monitor Account"; Code[20])
        {
            TableRelation = Vendor."No." where("BOSA Account No" = field("Member No"));

            trigger OnValidate()
            begin
                if ObjAccounts.Get("Monitor Account") then begin
                    if ObjAccountType.Get(ObjAccounts."Account Type") then begin
                        "Monitor Account Type" := ObjAccounts."Account Type";
                        "Monitor Account Type Desc" := ObjAccountType.Description;
                    end;
                end;
            end;
        }
        field(5; "Monitor Account Type"; Code[30])
        {
            Editable = false;
        }
        field(6; "Monitor Account Type Desc"; Text[100])
        {
            Editable = false;
        }
        field(7; "Minimum Account Threshold"; Decimal)
        {
        }
        field(8; "Maximum Account Threshold"; Decimal)
        {
        }
        field(9; "Investment Account"; Code[20])
        {
            TableRelation = Vendor."No." where("Creditor Type" = filter("FOSA Account"));

            trigger OnValidate()
            begin
                if ObjAccounts.Get("Investment Account") then begin
                    if ObjAccountType.Get(ObjAccounts."Account Type") then begin
                        "Investment Account Type" := ObjAccounts."Account Type";
                        "Investment Account Type Desc" := ObjAccountType.Description;
                    end;
                end;
            end;
        }
        field(10; "Investment Account Type"; Code[20])
        {
            Editable = false;
        }
        field(11; "Investment Account Type Desc"; Text[100])
        {
            Editable = false;
        }
        field(12; "No. Series"; Code[30])
        {
        }
        field(13; "Created By"; Code[30])
        {
            Editable = false;
        }
        field(14; "Created On"; Date)
        {
            Editable = false;
        }
        field(15; Effected; Boolean)
        {
            Editable = false;
        }
        field(16; "Effected on"; Date)
        {
            Editable = false;
        }
        field(17; Status; Option)
        {
            Editable = false;
            OptionCaption = 'Open,Pending Approval,Approved,Rejected,Stopped';
            OptionMembers = Open,"Pending Approval",Approved,Rejected,Stopped;
        }
        field(18; "Schedule Frequency"; Option)
        {
            OptionCaption = 'Daily,Weekly,Monthly';
            OptionMembers = Daily,Weekly,Monthly;
        }
        field(19; "Day Of Week"; Option)
        {
            OptionCaption = 'Sunday,Monday,Tuesday,Wednesday,Thursday,Friday,Saturday';
            OptionMembers = Sunday,Monday,Tuesday,Wednesday,Thursday,Friday,Saturday;
        }
        field(20; "Day Of Month"; Code[50])
        {
        }
        field(21; Stopped; Boolean)
        {
        }
        field(22; "Stopped By"; Code[20])
        {
        }
        field(23; "Stopped On"; Date)
        {
        }
        field(24; "Check Minimum Threshold"; Boolean)
        {
        }
        field(25; "Check Maximum Threshold"; Boolean)
        {
        }
        field(26; "Last Execution"; DateTime)
        {
        }
    }

    keys
    {
        key(Key1; "Document No", "Member No", "Monitor Account")
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
            SalesSetup.TestField(SalesSetup."Sweeping Instructions");
            NoSeriesMgt.InitSeries(SalesSetup."Sweeping Instructions", xRec."No. Series", 0D, "Document No", "No. Series");
        end;

        "Created By" := UserId;
        "Created On" := Today;
    end;

    var
        SalesSetup: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        ObjMember: Record Customer;
        ObjAccounts: Record Vendor;
        ObjAccountType: Record "Account Types-Saving Products";
}

