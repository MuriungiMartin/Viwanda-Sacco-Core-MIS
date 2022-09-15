#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50980 "Collateral Movement  Register"
{

    fields
    {
        field(1; "Document No"; Code[20])
        {
            Editable = false;

            trigger OnValidate()
            var
                UsersRec: Record User;
            begin
                if "Document No" <> xRec."Document No" then begin
                    SalesSetup.Get;
                    NoSeriesMgt.TestManual(SalesSetup."Package Retrieval Nos");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Collateral ID"; Code[20])
        {
            TableRelation = "Loan Collateral Register"."Document No";

            trigger OnValidate()
            begin

                if ObjCollateralRegister.Get("Collateral ID") then begin
                    ObjCollateralRegister.CalcFields(ObjCollateralRegister.Picture);
                    "Collateral Description" := ObjCollateralRegister."Collateral Description";
                    "Registered Owner" := ObjCollateralRegister."Registered Owner";
                    "Member No." := ObjCollateralRegister."Member No.";
                    "Member Name" := ObjCollateralRegister."Member Name";
                    "ID No." := ObjCollateralRegister."ID No.";
                    "Collateral Type" := ObjCollateralRegister."Collateral Type.";
                    "Collateral Posting Group" := ObjCollateralRegister."Collateral Posting Group";
                    "Collateral Depreciation Method" := ObjCollateralRegister."Collateral Depreciation Method";
                    "Reference No" := ObjCollateralRegister."Registration/Reference No";
                    "Depreciation Percentage" := ObjCollateralRegister."Depreciation Percentage";
                    "Depreciation Completion Date" := ObjCollateralRegister."Depreciation Completion Date";
                    Picture := ObjCollateralRegister.Picture;
                    "Asset Depreciation Amount" := ObjCollateralRegister."Asset Depreciation Amount";
                    "Asset Value @Loan Completion" := ObjCollateralRegister."Asset Value @Loan Completion";
                    "Asset Value" := ObjCollateralRegister."Asset Value";
                    "Last Collateral Action" := ObjCollateralRegister."Last Collateral Action";
                    "Serial No." := ObjCollateralRegister."File No";
                end;
            end;
        }
        field(3; "Collateral Description"; Text[250])
        {
            Editable = false;
        }
        field(4; "Registered Owner"; Code[100])
        {
            Editable = false;
        }
        field(5; "Member No."; Code[20])
        {
            Editable = false;
            TableRelation = Customer."No.";
        }
        field(6; "Member Name"; Code[50])
        {
            Editable = false;
        }
        field(7; "ID No."; Code[20])
        {
            Editable = false;
        }
        field(8; "Collateral Type"; Option)
        {
            Editable = false;
            OptionMembers = Cash;
        }
        field(9; "Date Received"; Date)
        {
            Editable = false;

            trigger OnValidate()
            begin
                "Received By" := UserId;
            end;
        }
        field(10; "Received By"; Code[20])
        {
            Editable = false;
        }
        field(11; "Date Released"; Date)
        {
            Editable = false;
        }
        field(12; "Released By"; Code[20])
        {
            Editable = false;
        }
        field(13; Picture; Blob)
        {
            SubType = Bitmap;
        }
        field(14; "No. Series"; Code[20])
        {
        }
        field(15; "Reference No"; Code[20])
        {
            Editable = false;
        }
        field(16; "Depreciation Completion Date"; Date)
        {
            Editable = false;
        }
        field(17; "Asset Depreciation Amount"; Decimal)
        {
            CalcFormula = sum("Collateral Depr Register"."Depreciation Amount" where("Document No" = field("Document No")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(18; "Asset Value @Loan Completion"; Decimal)
        {
            CalcFormula = min("Collateral Depr Register"."Collateral NBV" where("Document No" = field("Document No")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(19; "Depreciation Percentage"; Decimal)
        {
            Editable = false;
        }
        field(20; "Collateral Posting Group"; Code[20])
        {
            Editable = false;
            TableRelation = "FA Posting Group".Code;

            trigger OnValidate()
            begin
                /*ObjFAPostingGroup.RESET;
                ObjFAPostingGroup.SETRANGE(ObjFAPostingGroup.Code,"Collateral Posting Group");
                IF ObjFAPostingGroup.FINDSET THEN BEGIN
                  "Collateral Depreciation Method":=ObjFAPostingGroup."Depreciation Method";
                  "Depreciation Percentage":=ObjFAPostingGroup."Depreciation %";
                  END;
                  */

            end;
        }
        field(21; "Collateral Depreciation Method"; Option)
        {
            Editable = false;
            OptionCaption = 'Straight-Line,Declining-Balance 1,Declining-Balance 2,DB1/SL,DB2/SL,User-Defined,Manual';
            OptionMembers = "Straight-Line","Declining-Balance 1","Declining-Balance 2","DB1/SL","DB2/SL","User-Defined",Manual;
        }
        field(22; "Action Type"; Code[100])
        {
            TableRelation = if ("Last Collateral Action" = filter('LODGE TO STRONG ROOM')) "Collateral Movement Actions".Action where(Action = filter('RETRIEVE FROM STRONG ROOM' | 'BOOKED TO SAFE CUSTODY'))
            else
            if ("Last Collateral Action" = filter('RECEIVE AT HQ')) "Collateral Movement Actions".Action where(Action = filter('LODGE TO STRONG ROOM' | 'ISSUE TO LAWYER' | 'ISSUE TO INSURANCE AGENT' | 'RELEASE TO MEMBER' | 'DISPATCH TO BRANCH' | 'ISSUE TO AUCTIONEER'))
            else
            if ("Last Collateral Action" = filter('RETRIEVE FROM STRONG ROOM')) "Collateral Movement Actions".Action where(Action = filter('LODGE TO STRONG ROOM' | 'ISSUE TO LAWYER' | 'ISSUE TO INSURANCE AGENT' | 'RELEASE TO MEMBER' | 'DISPATCH TO BRANCH' | 'ISSUE TO AUCTIONEER'))
            else
            if ("Last Collateral Action" = filter('ISSUE TO LAWYER')) "Collateral Movement Actions".Action where(Action = filter('RECEIVE FROM LAWYER'))
            else
            if ("Last Collateral Action" = filter('ISSUE TO INSURANCE AGENT')) "Collateral Movement Actions".Action where(Action = filter('RECEIVE AT HQ' | 'RECEIVE AT BRANCH'))
            else
            if ("Last Collateral Action" = filter('DISPATCH TO BRANCH')) "Collateral Movement Actions".Action where(Action = filter('RECEIVE AT HQ' | 'RECEIVE AT BRANCH'))
            else
            if ("Last Collateral Action" = filter('RECEIVE AT BRANCH')) "Collateral Movement Actions".Action where(Action = filter('ISSUE TO LAWYER' | 'ISSUE TO INSURANCE AGENT' | 'RELEASE TO MEMBER' | 'ISSUE TO AUCTIONEER' | 'DISPATCH TO BRANCH'))
            else
            if ("Last Collateral Action" = filter('RECEIVE FROM LAWYER')) "Collateral Movement Actions".Action where(Action = filter('ISSUE TO LAWYER' | 'ISSUE TO INSURANCE AGENT' | 'RELEASE TO MEMBER' | 'ISSUE TO AUCTIONEER' | 'LODGE TO STRONG ROOM' | 'DISPATCH TO BRANCH'))
            else
            if ("Last Collateral Action" = filter('ISSUE TO AUCTIONEER')) "Collateral Movement Actions".Action where(Action = filter('RECEIVE AT HQ' | 'RECEIVE AT BRANCH'))
            else
            if ("Last Collateral Action" = filter('')) "Collateral Movement Actions".Action where(Action = filter('RECEIVE AT HQ' | 'RECEIVE AT BRANCH' | 'RELEASE TO MEMBER'));

            trigger OnValidate()
            begin

                if ObjActiontypes.Get("Action Type") then begin
                    "No Of Users to Effect Action" := ObjActiontypes."No Of Users to Effect Action";
                end;
            end;
        }
        field(23; "Actioned By(Custodian 1)"; Code[20])
        {
            Editable = false;
        }
        field(24; "Actioned By(Custodian 2)"; Code[20])
        {
            Editable = false;
        }
        field(25; "Actioned On(Custodian 1)"; Date)
        {
            Editable = false;
        }
        field(26; "Actioned On(Custodian 2)"; Date)
        {
            Editable = false;
        }
        field(27; "Lawyer Code"; Code[50])
        {
            TableRelation = Vendor."No." where("Sacco Lawyer" = filter(true));

            trigger OnValidate()
            begin
                if ObjAccount.Get("Lawyer Code") then begin
                    "Lawyer Name" := ObjAccount.Name;
                end;
            end;
        }
        field(28; "Lawyer Name"; Code[100])
        {
            Editable = false;
        }
        field(29; "Insurance Agent Code"; Code[50])
        {
            TableRelation = Vendor."No." where("Insurance Company" = filter(true));

            trigger OnValidate()
            begin
                if ObjAccount.Get("Insurance Agent Code") then begin
                    "Insurance Agent Name" := ObjAccount.Name;
                end;
            end;
        }
        field(30; "Insurance Agent Name"; Code[100])
        {
            Editable = false;
        }
        field(31; "Action Branch"; Code[30])
        {
            TableRelation = "Dimension Value".Code where("Dimension Value ID" = filter(2));
        }
        field(32; "Action Application date"; Date)
        {
            Editable = false;
        }
        field(33; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(34; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(35; "Asset Value"; Decimal)
        {
            Editable = false;
        }
        field(36; "No Of Users to Effect Action"; Option)
        {
            OptionCaption = 'Single,Dual';
            OptionMembers = Single,Dual;
        }
        field(37; "Last Collateral Action"; Code[100])
        {
        }
        field(38; "Action Effected"; Boolean)
        {
            Editable = false;
        }
        field(39; "Action Effected On"; Date)
        {
            Editable = false;
        }
        field(40; "Action Effected By"; Code[30])
        {
            Editable = false;
        }
        field(41; "Auctioneer Code"; Code[50])
        {
            TableRelation = Vendor."No." where(Auctioneer = filter(true));

            trigger OnValidate()
            begin
                if ObjAccount.Get("Auctioneer Code") then begin
                    "Auctioneer Name" := ObjAccount.Name;
                end;
            end;
        }
        field(42; "Auctioneer Name"; Code[100])
        {
            Editable = false;
        }
        field(43; "Released to Member"; Code[100])
        {
        }
        field(44; "Serial No."; Code[30])
        {
        }
        field(45; "Release Reason"; Option)
        {
            OptionCaption = ',Loan Fully Paid, Collateral Replacement, Partial Release of Multiple Collateral';
            OptionMembers = ,"Loan Fully Paid"," Collateral Replacement"," Partial Release of Multiple Collateral";
        }
        field(46; "Collateral Registered"; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Document No", "Collateral ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Document No", "Collateral ID", "Collateral Description", "Registered Owner")
        {
        }
    }

    trigger OnInsert()
    var
        UsersRec: Record User;
    begin
        if "Document No" = '' then begin
            SalesSetup.Get;
            SalesSetup.TestField(SalesSetup."Collateral Movement No");
            NoSeriesMgt.InitSeries(SalesSetup."Collateral Movement No", xRec."No. Series", 0D, "Document No", "No. Series");
        end;

        "Action Application date" := WorkDate;

        UsersRec.Reset;
        UsersRec.SetRange(UsersRec."User Name", UserId);
        if UsersRec.Find('-') then begin
            //"Global Dimension 2 Code" := UsersRec."Branch Code";
        end;

        Validate("Global Dimension 2 Code");
    end;

    var
        SalesSetup: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        ObjAccount: Record Vendor;
        ObjVendors: Record Vendor;
        ObjAccTypes: Record "Account Types-Saving Products";
        AvailableBal: Decimal;
        LodgeFee: Decimal;
        ObjCust: Record Customer;
        ObjGenSetup: Record "Sacco General Set-Up";
        ObjCollateralRegister: Record "Loan Collateral Register";
        ObjActiontypes: Record "Collateral Movement Actions";
}

