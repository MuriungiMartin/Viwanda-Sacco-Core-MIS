#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50356 "BOSA Account Refund Ledger"
{
    Caption = 'BOSA Account Refund Ledger';

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(2; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(3; Closed; Boolean)
        {
            Caption = 'Closed';
        }
        field(4; "Account No Recovered"; Code[20])
        {
            Caption = 'Defaulter Member No';
        }
        field(5; "Account Name"; Text[70])
        {
            Caption = 'Defaulter Name';
        }
        field(6; "Transaction Type"; Option)
        {
            Caption = 'Transaction Type';
            OptionCaption = 'Recovery,Reimbursement';
            OptionMembers = Recovery,Reimbursement;
        }
        field(7; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(8; "Member No"; Code[20])
        {
        }
        field(9; "Member Name"; Text[70])
        {
            Caption = 'Guarantor Name';
            TableRelation = User;
            //This property is currently not supported
            //TestTableRelation = false;

            trigger OnLookup()
            var
                LoginMgt: Codeunit "User Management";
            begin
                //LoginMgt.LookupUserID("Guarantor Name");
            end;
        }
        field(10; "Source Code"; Code[10])
        {
            Caption = 'Source Code';
            TableRelation = "Source Code";
        }
        field(11; "Journal Batch Name"; Code[10])
        {
            Caption = 'Journal Batch Name';
        }
        field(12; "Reason Code"; Code[10])
        {
            Caption = 'Reason Code';
            TableRelation = "Reason Code";
        }
        field(13; "Index Entry"; Boolean)
        {
            Caption = 'Index Entry';
        }
        field(14; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
        }
        field(15; "Amount Paid Back"; Decimal)
        {
        }
        field(16; "Amount Deducted"; Decimal)
        {
        }
        field(17; "Fully Settled"; Boolean)
        {
        }
        field(18; "Total Amount Apportioned"; Decimal)
        {
            CalcFormula = sum("Guarantor Recovery Ledger"."Amount Allocated" where("Document No." = field("Document No."),
                                                                                    "Fully Settled" = filter(false)));
            FieldClass = FlowField;
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
        key(Key3; "Posting Date", Closed)
        {
        }
        key(Key4; "Account No Recovered", "Posting Date", Closed)
        {
        }
        key(Key5; "Account No Recovered", Closed)
        {
        }
        key(Key6; "Document No.", "Account No Recovered")
        {
        }
        key(Key7; "Account No Recovered")
        {
        }
        key(Key8; "Document No.", "Account No Recovered", Closed)
        {
        }
        // key(Key9;"Document No.","Account No Recovered",Closed)
        // {
        //     Enabled = false;
        // }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Entry No.", "Posting Date", "Account No Recovered", "Account Name", "Transaction Type")
        {
        }
    }
}

