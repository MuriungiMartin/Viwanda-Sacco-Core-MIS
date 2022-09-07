#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50459 "Salary Processing Headerr"
{

    fields
    {
        field(1; No; Code[20])
        {

            trigger OnValidate()
            begin

                if No <> xRec.No then begin
                    NoSetup.Get();
                    NoSeriesMgt.TestManual(NoSetup."Salary Processing Nos");
                    "No. Series" := '';

                end;
            end;
        }
        field(2; "No. Series"; Code[20])
        {
        }
        field(3; Posted; Boolean)
        {
        }
        field(6; "Posted By"; Code[60])
        {
            Editable = false;
        }
        field(7; "Date Entered"; Date)
        {
        }
        field(9; "Entered By"; Text[60])
        {
        }
        field(10; Remarks; Text[150])
        {
        }
        field(19; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(20; "Time Entered"; Time)
        {
        }
        field(21; "Posting date"; Date)
        {

            trigger OnValidate()
            begin
                "Document No" := No;//FnGetCheckOffDescription();
            end;
        }
        field(22; "Account Type"; Enum "Gen. Journal Account Type")
        {
            // OptionCaption = 'G/L Account,Customer/Employer,FOSA Account/Vendor,Bank Account,Fixed Asset';
            // OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset";
        }
        field(23; "Account No"; Code[30])
        {
            TableRelation = if ("Account Type" = const("G/L Account")) "G/L Account"
            else
            if ("Account Type" = const(Customer)) Customer
            else
            if ("Account Type" = const(Vendor)) Vendor
            else
            if ("Account Type" = const("Bank Account")) "Bank Account"
            else
            if ("Account Type" = const("Fixed Asset")) "Fixed Asset";

            trigger OnValidate()
            begin
                if "Account Type" = "account type"::Customer then begin
                    cust.Reset;
                    cust.SetRange(cust."No.", "Account No");
                    if cust.Find('-') then begin
                        cust.CalcFields(cust.Balance);
                        "Account Name" := cust.Name;
                        "Balancing Account Balance" := cust.Balance;
                    end;
                end;


                if "Account Type" = "account type"::Vendor then begin
                    ObjAccount.Reset;
                    ObjAccount.SetRange(ObjAccount."No.", "Account No");
                    if ObjAccount.Find('-') then begin
                        ObjAccount.CalcFields(ObjAccount.Balance);
                        "Account Name" := ObjAccount.Name;
                        "Balancing Account Balance" := ObjAccount.Balance;
                    end;
                end;


                if "Account Type" = "account type"::"G/L Account" then begin
                    "GL Account".Reset;
                    "GL Account".SetRange("GL Account"."No.", "Account No");
                    if "GL Account".Find('-') then begin
                        "GL Account".CalcFields("GL Account".Balance);
                        "Account Name" := "GL Account".Name;
                        "Balancing Account Balance" := "GL Account".Balance;
                    end;
                end;

                if "Account Type" = "account type"::"Bank Account" then begin
                    BANKACC.Reset;
                    BANKACC.SetRange(BANKACC."No.", "Account No");
                    if BANKACC.Find('-') then begin
                        BANKACC.CalcFields(BANKACC.Balance);
                        "Account Name" := BANKACC.Name;
                        "Balancing Account Balance" := BANKACC.Balance;
                    end;
                end;
            end;
        }
        field(24; "Document No"; Code[20])
        {
        }
        field(25; Amount; Decimal)
        {

            trigger OnValidate()
            begin
                /*
              IF Amount<>"Scheduled Amount" THEN
              ERROR('The Amount must be equal to the Scheduled Amount');
                  */

            end;
        }
        field(26; "Scheduled Amount"; Decimal)
        {
            CalcFormula = sum("Salary Processing Lines".Amount where("Salary Header No." = field(No)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(27; "Total Count"; Integer)
        {
            CalcFormula = count("Salary Processing Lines" where("Salary Header No." = field(No)));
            FieldClass = FlowField;
        }
        field(28; "Account Name"; Code[50])
        {
        }
        field(29; "Employer Code"; Code[30])
        {
            TableRelation = "Sacco Employers".Code;
        }
        field(30; "Cheque No."; Code[20])
        {
        }
        field(31; Pension; Boolean)
        {
        }
        field(32; Discard; Boolean)
        {
        }
        field(33; "Exempt Loan Repayment"; Boolean)
        {
        }
        field(34; "Pre-Post Blocked Status Update"; Boolean)
        {
        }
        field(35; "Post-Post Blocked Statu Update"; Boolean)
        {
        }
        field(36; "Transaction Type"; Option)
        {
            OptionCaption = 'Salary,Savings,Loan Payments';
            OptionMembers = Salary,Savings,"Loan Payments";

            trigger OnValidate()
            begin
                "Document No" := FnGetCheckOffDescription();
            end;
        }
        field(37; "Transaction Description"; Text[50])
        {
        }
        field(38; "Balancing Account Balance"; Decimal)
        {
        }
        field(39; Status; Option)
        {
            OptionCaption = 'Open,Pending Approval,Approved,Rejected';
            OptionMembers = Open,"Pending Approval",Approved,Rejected;
        }
    }

    keys
    {
        key(Key1; No)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        /*IF Posted = TRUE THEN
        ERROR('You cannot delete a Posted Salary');*/

    end;

    trigger OnInsert()
    begin

        if No = '' then begin
            NoSetup.Get();
            NoSetup.TestField(NoSetup."Salary Processing Nos");
            NoSeriesMgt.InitSeries(NoSetup."Salary Processing Nos", xRec."No. Series", 0D, No, "No. Series");
        end;

        "Date Entered" := Today;
        "Time Entered" := Time;
        "Entered By" := UpperCase(UserId);
        "Document No" := No;
    end;

    trigger OnModify()
    begin
        //IF Posted = TRUE THEN
        //ERROR('You cannot modify a Posted Check Off');
    end;

    trigger OnRename()
    begin
        if Posted = true then
            Error('You cannot rename a Posted Salary');
    end;

    var
        NoSetup: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        cust: Record Customer;
        "GL Account": Record "G/L Account";
        BANKACC: Record "Bank Account";
        ObjAccount: Record Vendor;

    local procedure FnGetCheckOffDescription() rtVal: Text
    var
        SUFFIX: Code[100];
    begin
        SUFFIX := 'SALARIES';
        if "Transaction Type" = "transaction type"::Savings then
            SUFFIX := 'NIS';
        case Date2dmy("Posting date", 2) of
            1:
                rtVal := 'JAN';
            2:
                rtVal := 'FEB';
            3:
                rtVal := 'MAR';
            4:
                rtVal := 'APR';
            5:
                rtVal := 'MAY';
            6:
                rtVal := 'JUN';
            7:
                rtVal := 'JUL';
            8:
                rtVal := 'AUG';
            9:
                rtVal := 'SEP';
            10:
                rtVal := 'OCT';
            11:
                rtVal := 'NOV';
            12:
                rtVal := 'DEC';

        end;
        exit(rtVal + Format(Date2dmy("Posting date", 3)) + SUFFIX);
    end;
}

