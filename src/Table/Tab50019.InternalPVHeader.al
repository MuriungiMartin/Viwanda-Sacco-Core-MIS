#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50019 "Internal PV Header"
{

    fields
    {
        field(1; No; Code[20])
        {

            trigger OnValidate()
            begin
                if No <> xRec.No then begin
                    NoSetup.Get();
                    NoSeriesMgt.TestManual(NoSetup."Internal PV Document");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(3; Posted; Boolean)
        {
            Editable = true;
        }
        field(4; "Date Posted"; Date)
        {
            Editable = false;
        }
        field(5; "Time Posted"; Time)
        {
            Editable = false;
        }
        field(6; "Posted By"; Text[60])
        {
            Editable = false;
        }
        field(7; "Date Entered"; Date)
        {
        }
        field(8; "Time Entered"; Time)
        {
        }
        field(9; "Entered By"; Text[60])
        {
        }
        field(10; "Transaction Description"; Text[150])
        {
        }
        field(15; "Total Debits"; Decimal)
        {
            CalcFormula = sum("Internal PV Lines"."Debit Amount" where("Header No" = field(No)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(16; "Total Count"; Integer)
        {
            CalcFormula = count("Internal PV Lines" where("Header No" = field(No)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(17; "Total Credits"; Decimal)
        {
            CalcFormula = sum("Internal PV Lines"."Credit Amount" where("Header No" = field(No)));
            FieldClass = FlowField;
        }
        field(22; Status; Option)
        {
            OptionCaption = 'Open,Pending Approval,Approved,Rejected';
            OptionMembers = Open,"Pending Approval",Approved,Rejected;
        }
        field(24; "Cheque No"; Code[20])
        {
        }
        field(30; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));

            trigger OnValidate()
            begin

                /*DimVal.RESET;
                DimVal.SETRANGE(DimVal."Global Dimension No.",1);
                DimVal.SETRANGE(DimVal.Code,"Global Dimension 1 Code");
                 IF DimVal.FIND('-') THEN
                    "Function Name":=DimVal.Name;
                
                ValidateShortcutDimCode(1,"Global Dimension 1 Code");*/

            end;
        }
        field(31; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));

            trigger OnValidate()
            begin

                /*DimVal.RESET;
                DimVal.SETRANGE(DimVal."Global Dimension No.",2);
                DimVal.SETRANGE(DimVal.Code,"Global Dimension 2 Code");
                 IF DimVal.FIND('-') THEN
                    "Budget Center Name":=DimVal.Name;
                
                ValidateShortcutDimCode(2,"Global Dimension 2 Code");*/

            end;
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

    trigger OnInsert()
    begin
        if No = '' then begin
            NoSetup.Get();
            NoSetup.TestField(NoSetup."Internal PV Document");
            NoSeriesMgt.InitSeries(NoSetup."Internal PV Document", xRec."No. Series", 0D, No, "No. Series");
        end;


        "Date Entered" := Today;
        "Time Entered" := Time;
        "Entered By" := UserId;
    end;

    var
        NoSetup: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Accounts: Record Vendor;
        Members: Record Vendor;
        AccountHolders: Record Vendor;
        Banks: Record "Bank Account";
        BanksList: Record Banks;
        EFTDetails: Record "EFT/RTGS Details";
        AccountTypes: Record "Account Types-Saving Products";
}

