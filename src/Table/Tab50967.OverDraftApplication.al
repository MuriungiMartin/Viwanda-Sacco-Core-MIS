#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50967 "OverDraft Application"
{
    //nownPage51516792;
    //nownPage51516792;

    fields
    {
        field(1; "Document No"; Code[30])
        {
            Editable = false;

            trigger OnValidate()
            begin
                if "Document No" <> xRec."Document No" then begin
                    SalesSetup.Get;
                    NoSeriesMgt.TestManual(SalesSetup."Over Draft Application No");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Over Draft Account"; Text[30])
        {
            NotBlank = true;
            TableRelation = Vendor."No." where("BOSA Account No" = field("Member No"),
                                                "Account Type" = filter(406));

            trigger OnValidate()
            begin
                if ObjAccount.Get("Over Draft Account") then begin
                    "Over Draft Account Name" := ObjAccount.Name;
                    "ID No." := ObjAccount."ID No.";
                    Email := ObjAccount."E-Mail";
                    "Prev_OverDraft Expiry Date" := ObjAccount."Over Draft Limit Expiry Date";
                    "Prev_Qualifying Overdraft Amnt" := ObjAccount."Over Draft Limit Amount";
                    "Qualifying Overdraft Amount" := ObjAccount."Over Draft Limit Amount";
                    if ObjAccountTypes.Get(ObjAccount."Account Type") then
                        "Interest Rate" := ObjAccountTypes."Over Draft Interest Rate";
                end;
            end;
        }
        field(3; "Over Draft Account Name"; Text[100])
        {
            Editable = false;
            NotBlank = true;
            TableRelation = "Relationship Types";
        }
        field(4; "Application Date"; Date)
        {
            Editable = false;
        }
        field(5; "Created By"; Code[30])
        {
        }
        field(6; "Security Type"; Option)
        {
            OptionCaption = ' ,Member Deposits,Collateral';
            OptionMembers = " ","Member Deposits",Collateral;
        }
        field(7; "Member No"; Code[50])
        {
            TableRelation = Customer."No.";

            trigger OnValidate()
            begin
                if ObjCust.Get("Member No") then begin
                    ObjCust.CalcFields("Current Shares");
                    "Member Deposits" := ObjCust."Current Shares";
                end;

                ObjAccount.Reset;
                ObjAccount.SetRange("BOSA Account No", "Member No");
                ObjAccount.SetRange("Account Type", '406');
                if ObjAccount.FindSet then begin
                    "Over Draft Account" := ObjAccount."No.";
                    Validate("Over Draft Account");
                end;
                "Member Guarantee Liability" := SFactory.FnGetMemberLiability("Member No");
                "Total Members Unsecured Loans" := SFactory.FnGetMemberUnsecuredLoanAmount("Member No");
                "OD Qualifying Amount:Deposits" := "Member Deposits" - ("Member Guarantee Liability" + "Total Members Unsecured Loans");
                if "OD Qualifying Amount:Deposits" < 0 then
                    "OD Qualifying Amount:Deposits" := 0;
            end;
        }
        field(8; "Member Guarantee Liability"; Decimal)
        {
            Editable = false;
        }
        field(9; Email; Text[30])
        {
        }
        field(11; "ID No."; Code[50])
        {
        }
        field(12; "Qualifying Overdraft Amount"; Decimal)
        {
        }
        field(13; "Overdraft Duration"; DateFormula)
        {

            trigger OnValidate()
            var
                SetupMaxPeriod: Integer;
                ODPeriod: Integer;
            begin
                if ObjAccount.Get("Over Draft Account") then begin
                    if ObjAccountTypes.Get(ObjAccount."Account Type") then begin
                        VarSetupODMaturityDate := CalcDate(ObjAccountTypes."Maximum Overdraft Period", "Application Date");
                        VarActualODMaturityDate := CalcDate("Overdraft Duration", "Application Date");

                        if VarActualODMaturityDate > VarSetupODMaturityDate then begin
                            Error('Maximum Overdraft Limit Period is %1', ObjAccountTypes."Maximum Overdraft Period");
                        end;

                        if "OverDraft Application Type" = "overdraft application type"::New then begin
                            "OverDraft Expiry Date" := CalcDate("Overdraft Duration", "Application Date")
                        end else
                            "OverDraft Expiry Date" := CalcDate("Overdraft Duration", "Prev_OverDraft Expiry Date");
                    end;
                end;
            end;
        }
        field(14; "OverDraft Expiry Date"; Date)
        {
            Editable = false;
        }
        field(15; "No. Series"; Code[20])
        {
        }
        field(16; Status; Option)
        {
            Editable = false;
            OptionCaption = 'Open,Pending Approval,Approved,Rejected';
            OptionMembers = Open,"Pending Approval",Approved,Rejected;
        }
        field(17; "Member Deposits"; Decimal)
        {
            Editable = false;
        }
        field(18; "Total Members Unsecured Loans"; Decimal)
        {
            Editable = false;
        }
        field(19; "OD Qualifying Amount:Deposits"; Decimal)
        {
            Editable = false;
        }
        field(20; "OD Qualifying Amount:Collatera"; Decimal)
        {
            CalcFormula = sum("OD Collateral Details"."Guarantee Value" where("OD No" = field("Document No")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(21; "OD Application Effected"; Boolean)
        {
        }
        field(22; "OD Application Effected Date"; Date)
        {
        }
        field(23; "OD Application Effected By"; Code[30])
        {
        }
        field(24; "Prev_Qualifying Overdraft Amnt"; Decimal)
        {
        }
        field(25; "Prev_OverDraft Expiry Date"; Date)
        {
            Editable = false;
        }
        field(26; "OverDraft Application Type"; Option)
        {
            OptionCaption = 'New,Amend';
            OptionMembers = New,Amend;
        }
        field(27; "OverDraft Application Status"; Option)
        {
            OptionCaption = 'Active,Terminated';
            OptionMembers = Active,Terminated;
        }
        field(28; "Date Terminated"; Date)
        {
        }
        field(29; "Terminated By"; Code[30])
        {
        }
        field(30; "Reason For Termination"; Text[150])
        {
        }
        field(31; "Interest Rate"; Decimal)
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
            SalesSetup.TestField(SalesSetup."Over Draft Application No");
            NoSeriesMgt.InitSeries(SalesSetup."Over Draft Application No", xRec."No. Series", 0D, "Document No", "No. Series");
        end;

        "Created By" := UserId;
        "Application Date" := WorkDate;
    end;

    var
        SalesSetup: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        ObjAccount: Record Vendor;
        SFactory: Codeunit "SURESTEP Factory";
        ObjCust: Record Customer;
        ObjAccountTypes: Record "Account Types-Saving Products";
        VarSetupODMaturityDate: Date;
        VarActualODMaturityDate: Date;
}

