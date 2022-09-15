#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50945 "Fixed Deposit Placement"
{

    fields
    {
        field(1; "Document No"; Code[20])
        {

            trigger OnValidate()
            begin
                if "Document No" <> xRec."Document No" then begin
                    SalesSetup.Get;
                    NoSeriesMgt.TestManual(SalesSetup."Fixed Deposit Placement");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Member No"; Code[30])
        {
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
        }
        field(4; "Fixed Deposit Account No"; Code[30])
        {
            TableRelation = Vendor."No." where("BOSA Account No" = field("Member No"),
                                                "Account Type" = filter(503 | 506));
        }
        field(5; "Application Date"; Date)
        {
        }
        field(6; "Fixed Deposit Type"; Code[20])
        {
            TableRelation = "Fixed Deposit Type".Code;

            trigger OnValidate()
            begin
                /*
                IF ObjFDType.GET("Fixed Deposit Type") THEN
                  BEGIN
                    "FD Maturity Date":=CALCDATE(ObjFDType.Duration,TODAY);
                     "Fixed Duration":=ObjFDType."No. of Months";
                     "Fixed Deposit Status":="Fixed Deposit Status"::Active;
                     "FD Duration":=ObjFDType.Duration;
                
                 END;
                
                ObjIntCalc.RESET;
                ObjIntCalc.SETRANGE(ObjIntCalc.Code,"Fixed Deposit Type");
                IF ObjIntCalc.FINDSET THEN
                  BEGIN
                   IF ("Amount to Fix">=ObjIntCalc."Minimum Amount") AND ("Amount to Fix"<=ObjIntCalc."Maximum Amount") THEN
                    BEGIN
                     "FD Interest Rate":=ObjIntCalc."Interest Rate";
                     "FD Maturity Date":=CALCDATE("FD Duration","Fixed Deposit Start Date");
                    END;
                 END;
                
                
                 */

            end;
        }
        field(7; "FD Maturity Date"; Date)
        {
        }
        field(8; "Fixed Duration"; Integer)
        {

            trigger OnValidate()
            begin
                ObjGenSetup.Get();

                /*ObjIntCalc.RESET;
                ObjIntCalc.SETRANGE(ObjIntCalc.Code,"Fixed Deposit Type");
                ObjIntCalc.SETRANGE(ObjIntCalc.Duration,"FD Duration");
                IF ObjIntCalc.FIND('-') THEN BEGIN
                  "FD Interest Rate":=ObjIntCalc."Interest Rate";
                  "Fixed Duration":=ObjIntCalc."No of Months";
                  "Expected Interest Earned":=ROUND((("Amount to Fix"*ObjIntCalc."Interest Rate"/100)/12)*ObjIntCalc."No of Months",1,'<');
                  "Expected Tax After Term Period":=ROUND("Expected Interest Earned"*(ObjGenSetup."Withholding Tax (%)"/100),1,'>');
                  "Expected Net After Term Period":="Expected Interest Earned"-"Expected Tax After Term Period";
                  END;*/

                "Expected Interest Earned" := ROUND((("Amount to Fix" * "FD Interest Rate" / 100) / 12) * "Fixed Duration", 1, '<');
                "Expected Tax After Term Period" := ROUND("Expected Interest Earned" * (ObjGenSetup."Withholding Tax (%)" / 100), 1, '>');
                "Expected Net After Term Period" := "Expected Interest Earned" - "Expected Tax After Term Period";

            end;
        }
        field(9; "FDR Deposit Status Type"; Option)
        {
            Editable = false;
            OptionCaption = ' ,New,Renewed,Terminated';
            OptionMembers = " ",New,Renewed,Terminated;
        }
        field(10; "Fixed Deposit Start Date"; Date)
        {

            trigger OnValidate()
            begin
                //"FD Maturity Date":=CALCDATE("FD Duration","Fixed Deposit Start Date");

                "FD Maturity Date" := CalcDate(Format("Fixed Duration") + 'M', "Fixed Deposit Start Date");
            end;
        }
        field(11; "Fixed Deposit Status"; Option)
        {
            OptionCaption = ' ,Active,Matured,Closed,Not Matured';
            OptionMembers = " ",Active,Matured,Closed,"Not Matured";
        }
        field(12; "Amount to Fix"; Decimal)
        {

            trigger OnValidate()
            begin
                ObjGenSetup.Get();

                ObjIntCalc.Reset;
                ObjIntCalc.SetRange(ObjIntCalc.Code, "Fixed Deposit Type");
                ObjIntCalc.SetRange(ObjIntCalc.Duration, "FD Duration");
                if ObjIntCalc.Find('-') then begin
                    "FD Interest Rate" := ObjIntCalc."Interest Rate";
                    "Fixed Duration" := ObjIntCalc."No of Months";
                    "Expected Interest Earned" := ROUND((("Amount to Fix" * ObjIntCalc."Interest Rate" / 100) / 12) * ObjIntCalc."No of Months", 1, '<');
                    "Expected Tax After Term Period" := ROUND("Expected Interest Earned" * (ObjGenSetup."Withholding Tax (%)" / 100), 1, '>');
                    "Expected Net After Term Period" := "Expected Interest Earned" - "Expected Tax After Term Period";
                end;


                ObjIntCalc.Reset;
                ObjIntCalc.SetCurrentkey(ObjIntCalc."Maximum Amount");
                ObjIntCalc.SetRange(ObjIntCalc.Code, "Fixed Deposit Type");
                if ObjIntCalc.Find('-') then begin
                    repeat
                        if ("Amount to Fix" >= ObjIntCalc."Minimum Amount") and ("Amount to Fix" <= ObjIntCalc."Maximum Amount") then begin
                            "FD Interest Rate" := ObjIntCalc."Interest Rate";
                        end;
                    until ObjIntCalc.Next = 0;
                end;
            end;
        }
        field(13; "FD Interest Rate"; Decimal)
        {
        }
        field(14; "FD Duration"; DateFormula)
        {
        }
        field(15; "Expected Interest Earned"; Decimal)
        {
        }
        field(16; "Expected Tax After Term Period"; Decimal)
        {
        }
        field(17; "Expected Net After Term Period"; Decimal)
        {
        }
        field(18; "Created By"; Code[20])
        {
        }
        field(19; "Effected By"; Code[20])
        {
        }
        field(20; "Date Effected"; Date)
        {
        }
        field(21; "No. Series"; Code[20])
        {
        }
        field(22; Status; Option)
        {
            OptionCaption = 'Open,Pending Approval,Approved,Rejected';
            OptionMembers = Open,"Pending Approval",Approved,Rejected;
        }
        field(23; "Account to Tranfers FD Amount"; Code[20])
        {
            TableRelation = Vendor."No." where("BOSA Account No" = field("Member No"));
        }
        field(24; "FD Closed On"; Date)
        {
        }
        field(25; "FD Closed By"; Code[30])
        {
        }
        field(26; Effected; Boolean)
        {
        }
        field(27; Closed; Boolean)
        {
        }
        field(28; "Interest Earned to Date"; Decimal)
        {
            CalcFormula = sum("Interest Buffer"."Interest Amount" where("Account No" = field("Fixed Deposit Account No")));
            FieldClass = FlowField;
        }
        field(29; "Maturity Instructions"; Option)
        {
            OptionCaption = ' ,Pay to FOSA Account_ Deposit+Interest,Roll Back Deposit+Interest,Roll Back Deposit Only ';
            OptionMembers = " ","Pay to FOSA Account_ Deposit+Interest","Roll Back Deposit+Interest","Roll Back Deposit Only ";
        }
        field(30; Remark; Text[100])
        {
        }
        field(31; "Created On"; Date)
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
            SalesSetup.TestField(SalesSetup."Fixed Deposit Placement");
            NoSeriesMgt.InitSeries(SalesSetup."Fixed Deposit Placement", xRec."No. Series", 0D, "Document No", "No. Series");
        end;

        "Created By" := UserId;
        "Application Date" := Today;
    end;

    var
        ObjFDType: Record "Fixed Deposit Type";
        ObjIntCalc: Record "FD Interest Calculation Crite";
        ObjGenSetup: Record "Sacco General Set-Up";
        SalesSetup: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        ObjCust: Record Customer;
}

