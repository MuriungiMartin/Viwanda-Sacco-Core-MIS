tableextension 50048 "CustLedgerExt" extends "Cust. Ledger Entry"
{


    fields
    {
        // Add changes to table fields here
        field(68000; Type; enum TransactionTypesEnum)
        {
        }
        field(68001; "Loan No"; Code[20])
        {
        }
        field(68002; "Group Code"; Code[20])
        {
        }
        field(68003; "Transaction Type"; enum TransactionTypesEnum)
        {
        }
        field(68004; "Member Name"; Text[30])
        {
        }
        field(68005; "Loan Type"; Code[25])
        {
            CalcFormula = lookup("Loans Register"."Loan Product Type" where("Loan  No." = field("Loan No")));
            FieldClass = FlowField;
        }
        field(68006; "Prepayment Date"; Date)
        {
        }
        field(68007; Totals; Decimal)
        {
            CalcFormula = sum("Member Ledger Entry".Amount where("Document No." = filter('JUNE  15/06/14')));
            FieldClass = FlowField;
        }

        field(68009; "No Boosting"; Boolean)
        {
        }
        field(68010; "Posting Count"; Integer)
        {
        }
        field(68011; "Total Debits"; Decimal)
        {
            CalcFormula = sum("Member Ledger Entry".Amount where("Transaction Type" = filter("Share Capital"),
                                                                  "Loan Type" = field("Loan Type"),
                                                                  "Posting Date" = field("Posting Date")));
            FieldClass = FlowField;
        }
        field(68012; "Total Credits"; Decimal)
        {
            CalcFormula = sum("Member Ledger Entry".Amount where("Transaction Type" = filter("Interest Paid"),
                                                                  "Loan Type" = field("Loan Type"),
                                                                  "Posting Date" = field("Posting Date")));
            FieldClass = FlowField;
        }
        field(68013; "Group Account No"; Code[20])
        {
        }
        field(68014; "FOSA Account No."; Code[60])
        {
        }
        field(68015; "Recovery Transaction Type"; Option)
        {
            OptionCaption = 'Normal,Guarantor Recoverd,Guarantor Paid';
            OptionMembers = Normal,"Guarantor Recoverd","Guarantor Paid";
        }
        field(68016; "Recoverd Loan"; Code[20])
        {
        }
        field(68017; "Share Boosting Fee Charged"; Boolean)
        {
        }
        field(68018; Unapplied; Boolean)
        {
            Caption = 'Unapplied';
        }
        field(68019; "Unapplied by Entry No."; Integer)
        {
            Caption = 'Unapplied by Entry No.';
            TableRelation = "Detailed Cust. Ledg. Entry";
        }
        field(68020; "Entry Type"; Option)
        {
            Caption = 'Entry Type';
            OptionCaption = ',Initial Entry,Application,Unrealized Loss,Unrealized Gain,Realized Loss,Realized Gain,Payment Discount,Payment Discount (VAT Excl.),Payment Discount (VAT Adjustment),Appln. Rounding,Correction of Remaining Amount,Payment Tolerance,Payment Discount Tolerance,Payment Tolerance (VAT Excl.),Payment Tolerance (VAT Adjustment),Payment Discount Tolerance (VAT Excl.),Payment Discount Tolerance (VAT Adjustment)';
            OptionMembers = ,"Initial Entry",Application,"Unrealized Loss","Unrealized Gain","Realized Loss","Realized Gain","Payment Discount","Payment Discount (VAT Excl.)","Payment Discount (VAT Adjustment)","Appln. Rounding","Correction of Remaining Amount","Payment Tolerance","Payment Discount Tolerance","Payment Tolerance (VAT Excl.)","Payment Tolerance (VAT Adjustment)","Payment Discount Tolerance (VAT Excl.)","Payment Discount Tolerance (VAT Adjustment)";
        }
        field(51516061; "Reversal Date"; Date)
        {
        }
        field(51516062; "Transaction Date"; Date)
        {
            Description = 'Actual Transaction Date(Workdate)';
            Editable = false;
        }
        field(51516063; "Application Source"; Option)
        {
            OptionCaption = ' ,CBS,ATM,Mobile,Internet,MPESA,Equity,Co-op,Family,SMS Banking';
            OptionMembers = " ",CBS,ATM,Mobile,Internet,MPESA,Equity,"Co-op",Family,"SMS Banking";
        }
        field(51516064; "Created On"; DateTime)
        {
        }
        field(51516065; "Computer Name"; Text[30])
        {
        }
        field(51516066; "Member House Group"; Code[30])
        {
        }
        field(51516067; "Final Amount"; Decimal)
        {
        }
        field(51516068; "Transaction Amount"; Decimal)
        {
        }
    }

    keys
    {
        key(Key5; "Transaction Type")
        {

        }
    }
    trigger OnInsert()
    begin
        CalcFields(Amount);
        "Final Amount" := Amount;
    end;

    var
        myInt: Integer;
        MEmbeLedger: Record "Member Ledger Entry";
}