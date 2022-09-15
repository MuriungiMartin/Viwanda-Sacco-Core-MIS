#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50970 "Daily Interest/Penalty Buffer"
{
    Caption = 'Daily Interest/Penalty Buffer';
    //nownPage51516799;
    //nownPage51516799;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(2; "Account Type"; Option)
        {
            OptionCaption = ' ,BOSA Account,FOSA Account';
            OptionMembers = " ","BOSA Account","FOSA Account";
        }
        field(3; "Account No."; Code[20])
        {
            Caption = 'Customer No.';
            TableRelation = if ("Account Type" = filter("BOSA Account")) Customer."No."
            else
            if ("Account Type" = filter("FOSA Account")) Vendor."No.";
        }
        field(4; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(5; "Document Type"; Option)
        {
            Caption = 'Document Type';
            OptionCaption = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund';
            OptionMembers = " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund;
        }
        field(6; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(7; Description; Text[90])
        {
            Caption = 'Description';
        }
        field(11; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;
        }
        field(13; Amount; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Amount';
        }
        field(23; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(24; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(25; "Salesperson Code"; Code[10])
        {
            Caption = 'Salesperson Code';
            TableRelation = "Salesperson/Purchaser";
        }
        field(27; "User ID"; Code[50])
        {
            Caption = 'User ID';
            TableRelation = User;
            //This property is currently not supported
            //TestTableRelation = false;

            trigger OnLookup()
            var
                LoginMgt: Codeunit "User Management";
            begin
                //LoginMgt.LookupUserID("User ID");
            end;
        }
        field(51516160; "Transaction Type"; Option)
        {
            OptionCaption = 'Penalty Charged,Interest Accrual';
            OptionMembers = "Penalty Charged","Interest Accrual";
        }
        field(51516161; "Loan No"; Code[50])
        {
            TableRelation = "Loans Register"."Loan  No.";
        }
        field(51516162; Posted; Boolean)
        {
        }
        field(51516163; "Posted On"; Date)
        {
        }
        field(51516164; "Member Name"; Code[100])
        {
        }
        field(51516165; "Base Amount"; Decimal)
        {
        }
        field(51516166; "Loan Product Code"; Code[30])
        {
            CalcFormula = lookup("Loans Register"."Loan Product Type" where("Loan  No." = field("Loan No")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Text000: label 'must have the same sign as %1';
        Text001: label 'must not be larger than %1';
        DocTxt: label 'Member Ledger Entries';
}

