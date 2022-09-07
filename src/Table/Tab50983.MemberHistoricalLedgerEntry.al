#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50983 "Member Historical Ledger Entry"
{
    Caption = 'Member Historical Ledger Entry';
    //nownPage51516369;
    //nownPage51516369;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(2; "Account No."; Code[50])
        {
            Caption = 'Account No.';
        }
        field(3; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(4; "Document No."; Code[50])
        {
            Caption = 'Document No.';
        }
        field(5; Description; Text[250])
        {
            Caption = 'Description';
        }
        field(6; "Credit Amount"; Decimal)
        {
        }
        field(7; "Debit Amount"; Decimal)
        {
        }
        field(8; "Product ID"; Code[50])
        {
        }
        field(9; "External Document No"; Code[50])
        {
        }
        field(10; "Created On"; DateTime)
        {
        }
        field(11; "User ID"; Code[50])
        {
        }
        field(12; Amount; Decimal)
        {
            AutoFormatExpression = "User ID";
            AutoFormatType = 1;
            Caption = 'Amount';
            Editable = false;
        }
        field(13; "Global Dimension 1 Code"; Code[50])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(14; "Global Dimension 2 Code"; Code[50])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "Posting Date")
        {
        }
        key(Key3; "Created On")
        {
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

