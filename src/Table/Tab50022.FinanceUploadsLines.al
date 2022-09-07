#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50022 "Finance Uploads Lines"
{

    fields
    {
        field(1; "No."; Integer)
        {
            AutoIncrement = true;
            NotBlank = false;
        }
        field(2; "Header No."; Code[20])
        {
            TableRelation = "Finance Uploads Header".No where(No = field("Header No."));
        }
        field(3; "Reference No"; Code[30])
        {
        }
        field(4; "Debit Account Type"; enum "Gen. Journal Account Type")
        {
            Caption = 'Debit Account Type';
            // OptionCaption = 'G/L Account,Trade Customer,Member Account/Supplier,Bank Account,Fixed Asset,IC Partner,Employee,Loan Account,Investor';
            // OptionMembers = "G/L Account",Customer,"Member Account/Supplier","Bank Account","Fixed Asset","IC Partner",Employee,Member,Investor;
        }
        field(5; "Debit Account No"; Code[30])
        {
            TableRelation = if ("Debit Account Type" = filter("Member Account/Supplier")) Vendor."No."
            else
            if ("Debit Account Type" = filter("G/L Account")) "G/L Account"."No."
            else
            if ("Debit Account Type" = filter("Bank Account")) "Bank Account"."No.";
        }
        field(6; "Debit Narration"; Text[100])
        {
        }
        field(7; Amount; Decimal)
        {
        }
        field(8; "Credit Account Type"; enum "Gen. Journal Account Type")
        {
            Caption = 'Credit Account Type';
            // OptionCaption = 'G/L Account,Customer,Member Account/Supplier,Bank Account,Fixed Asset,IC Partner,Employee,Member,Investor';
            // OptionMembers = "G/L Account",Customer,"Member Account/Supplier","Bank Account","Fixed Asset","IC Partner",Employee,Member,Investor;
        }
        field(9; "Credit Account No"; Code[30])
        {
            TableRelation = if ("Credit Account Type" = filter("Member Account/Supplier")) Vendor."No."
            else
            if ("Credit Account Type" = filter("G/L Account")) "G/L Account"."No."
            else
            if ("Credit Account Type" = filter("Bank Account")) "Bank Account"."No.";
        }
        field(10; "Credit Narration"; Text[100])
        {
        }
        field(11; "Debit Account Name"; Text[250])
        {
        }
        field(12; "Credit Account Name"; Text[250])
        {
        }
        field(13; "Debit Account Balance Status"; Option)
        {
            Editable = false;
            OptionCaption = ' ,Sufficient Balance,Insufficient Balance';
            OptionMembers = " ","Sufficient Balance","Insufficient Balance";
        }
        field(14; "Debit Account Status"; Option)
        {
            OptionCaption = 'Active,Closed,Dormant,Frozen,Deceased';
            OptionMembers = Active,Closed,Dormant,Frozen,Deceased;
        }
        field(15; "Credit Account Status"; Option)
        {
            OptionCaption = 'Active,Closed,Dormant,Frozen,Deceased';
            OptionMembers = Active,Closed,Dormant,Frozen,Deceased;
        }
        field(16; Posted; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "No.", "Header No.", "Debit Account No", Amount)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Acc: Record Vendor;
        NoSetup: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        SalBuffer: Record "Salary Processing Lines";
}

