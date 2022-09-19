#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50966 "Interest Due Ledger Entry"
{
    Caption = 'Interest Due Ledger Entry';
    //nownPage51516791;
    //nownPage51516791;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(3; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            TableRelation = Customer."No.";
        }
        field(4; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(5; "Document Type"; enum "Gen. Journal Document Type")
        {
            Caption = 'Document Type';
            // OptionCaption = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund';
            // OptionMembers = " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund;
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
            Editable = false;

            trigger OnValidate()
            begin
                if Amount > 0 then begin
                    "Debit Amount" := Amount;
                    "Amount (LCY)" := Amount;
                    "Debit Amount (LCY)" := Amount
                end else
                    "Credit Amount" := Amount;
                "Credit Amount (LCY)" := Amount;
                "Amount (LCY)" := Amount;
            end;
        }
        field(14; "Remaining Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Remaining Amount';
            Editable = false;
        }
        field(15; "Original Amt. (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Original Amt. (LCY)';
            Editable = false;
        }
        field(16; "Remaining Amt. (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Remaining Amt. (LCY)';
            Editable = false;
        }
        field(17; "Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Amount (LCY)';
            Editable = false;
        }
        field(18; "Sales (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Sales (LCY)';
        }
        field(19; "Profit (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Profit (LCY)';
        }
        field(20; "Inv. Discount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Inv. Discount (LCY)';
        }
        field(21; "Sell-to Customer No."; Code[20])
        {
            Caption = 'Sell-to Customer No.';
            // TableRelation = Table51516154;
        }
        field(22; "Customer Posting Group"; Code[10])
        {
            Caption = 'Customer Posting Group';
            TableRelation = "Customer Posting Group";
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
                //    LoginMgt.LookupUserID("User ID");
            end;
        }
        field(28; "Source Code"; Code[10])
        {
            Caption = 'Source Code';
            TableRelation = "Source Code";
        }
        field(33; "On Hold"; Code[3])
        {
            Caption = 'On Hold';
        }
        field(34; "Applies-to Doc. Type"; enum "Gen. Journal Document Type")
        {
            Caption = 'Applies-to Doc. Type';
            // OptionCaption = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund';
            // OptionMembers = " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund;
        }
        field(35; "Applies-to Doc. No."; Code[20])
        {
            Caption = 'Applies-to Doc. No.';
        }
        field(36; Open; Boolean)
        {
            Caption = 'Open';
        }
        field(37; "Due Date"; Date)
        {
            Caption = 'Due Date';

            trigger OnValidate()
            var
                ReminderEntry: Record "Reminder/Fin. Charge Entry";
                ReminderIssue: Codeunit "Reminder-Issue";
            begin
                TestField(Open, true);
                if "Due Date" <> xRec."Due Date" then begin
                    ReminderEntry.SetCurrentkey("Customer Entry No.", Type);
                    ReminderEntry.SetRange("Customer Entry No.", "Entry No.");
                    ReminderEntry.SetRange(Type, ReminderEntry.Type::Reminder);
                    ReminderEntry.SetRange("Reminder Level", "Last Issued Reminder Level");
                    if ReminderEntry.FindLast then
                        ReminderIssue.ChangeDueDate(ReminderEntry, "Due Date", xRec."Due Date");
                end;
            end;
        }
        field(38; "Pmt. Discount Date"; Date)
        {
            Caption = 'Pmt. Discount Date';

            trigger OnValidate()
            begin
                TestField(Open, true);
            end;
        }
        field(39; "Original Pmt. Disc. Possible"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Original Pmt. Disc. Possible';
            Editable = false;
        }
        field(40; "Pmt. Disc. Given (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Pmt. Disc. Given (LCY)';
        }
        field(43; Positive; Boolean)
        {
            Caption = 'Positive';
        }
        field(44; "Closed by Entry No."; Integer)
        {
            Caption = 'Closed by Entry No.';
            TableRelation = "Cust. Ledger Entry";
        }
        field(45; "Closed at Date"; Date)
        {
            Caption = 'Closed at Date';
        }
        field(46; "Closed by Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Closed by Amount';
        }
        field(47; "Applies-to ID"; Code[20])
        {
            Caption = 'Applies-to ID';

            trigger OnValidate()
            begin
                TestField(Open, true);
            end;
        }
        field(49; "Journal Batch Name"; Code[10])
        {
            Caption = 'Journal Batch Name';
        }
        field(50; "Reason Code"; Code[10])
        {
            Caption = 'Reason Code';
            TableRelation = "Reason Code";
        }
        field(51; "Bal. Account Type"; enum "Gen. Journal Account Type")
        {
            Caption = 'Bal. Account Type';
            // OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,Member,None,Staff';
            // OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset",Member,"None",Staff;
        }
        field(52; "Bal. Account No."; Code[20])
        {
            Caption = 'Bal. Account No.';
            TableRelation = if ("Bal. Account Type" = const("G/L Account")) "G/L Account"
            else
            if ("Bal. Account Type" = const(Customer)) Customer
            else
            if ("Bal. Account Type" = const(Vendor)) Vendor
            else
            if ("Bal. Account Type" = const("Bank Account")) "Bank Account"
            else
            if ("Bal. Account Type" = const("Fixed Asset")) "Fixed Asset";
        }
        field(53; "Transaction No."; Integer)
        {
            Caption = 'Transaction No.';
        }
        field(54; "Closed by Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Closed by Amount (LCY)';
        }
        field(58; "Debit Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            BlankZero = true;
            Caption = 'Debit Amount';
            Editable = false;
        }
        field(59; "Credit Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            BlankZero = true;
            Caption = 'Credit Amount';
            Editable = false;
        }
        field(60; "Debit Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            Caption = 'Debit Amount (LCY)';
            Editable = false;
        }
        field(61; "Credit Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            Caption = 'Credit Amount (LCY)';
            Editable = false;
        }
        field(62; "Document Date"; Date)
        {
            Caption = 'Document Date';
        }
        field(63; "External Document No."; Code[20])
        {
            Caption = 'External Document No.';
        }
        field(64; "Calculate Interest"; Boolean)
        {
            Caption = 'Calculate Interest';
        }
        field(65; "Closing Interest Calculated"; Boolean)
        {
            Caption = 'Closing Interest Calculated';
        }
        field(66; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
        }
        field(67; "Closed by Currency Code"; Code[10])
        {
            Caption = 'Closed by Currency Code';
            TableRelation = Currency;
        }
        field(68; "Closed by Currency Amount"; Decimal)
        {
            AutoFormatExpression = "Closed by Currency Code";
            AutoFormatType = 1;
            Caption = 'Closed by Currency Amount';
        }
        field(73; "Adjusted Currency Factor"; Decimal)
        {
            Caption = 'Adjusted Currency Factor';
            DecimalPlaces = 0 : 15;
        }
        field(74; "Original Currency Factor"; Decimal)
        {
            Caption = 'Original Currency Factor';
            DecimalPlaces = 0 : 15;
        }
        field(75; "Original Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Original Amount';
            Editable = false;
        }
        field(76; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(77; "Remaining Pmt. Disc. Possible"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Remaining Pmt. Disc. Possible';

            trigger OnValidate()
            begin
                TestField(Open, true);
                //CALCFIELDS(Amount,"Original Amount");

                if "Remaining Pmt. Disc. Possible" * Amount < 0 then
                    FieldError("Remaining Pmt. Disc. Possible", StrSubstNo(Text000, FieldCaption(Amount)));

                if Abs("Remaining Pmt. Disc. Possible") > Abs("Original Amount") then
                    FieldError("Remaining Pmt. Disc. Possible", StrSubstNo(Text001, FieldCaption("Original Amount")));
            end;
        }
        field(78; "Pmt. Disc. Tolerance Date"; Date)
        {
            Caption = 'Pmt. Disc. Tolerance Date';

            trigger OnValidate()
            begin
                TestField(Open, true);
            end;
        }
        field(79; "Max. Payment Tolerance"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Max. Payment Tolerance';

            trigger OnValidate()
            begin
                TestField(Open, true);
                //CALCFIELDS(Amount,"Remaining Amount");

                if "Max. Payment Tolerance" * Amount < 0 then
                    FieldError("Max. Payment Tolerance", StrSubstNo(Text000, FieldCaption(Amount)));

                if Abs("Max. Payment Tolerance") > Abs("Remaining Amount") then
                    FieldError("Max. Payment Tolerance", StrSubstNo(Text001, FieldCaption("Remaining Amount")));
            end;
        }
        field(80; "Last Issued Reminder Level"; Integer)
        {
            Caption = 'Last Issued Reminder Level';
        }
        field(81; "Accepted Payment Tolerance"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Accepted Payment Tolerance';
        }
        field(82; "Accepted Pmt. Disc. Tolerance"; Boolean)
        {
            Caption = 'Accepted Pmt. Disc. Tolerance';
        }
        field(83; "Pmt. Tolerance (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Pmt. Tolerance (LCY)';
        }
        field(84; "Amount to Apply"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Amount to Apply';

            trigger OnValidate()
            begin
                TestField(Open, true);
                //CALCFIELDS("Remaining Amount");

                if "Amount to Apply" * "Remaining Amount" < 0 then
                    FieldError("Amount to Apply", StrSubstNo(Text000, FieldCaption("Remaining Amount")));

                if Abs("Amount to Apply") > Abs("Remaining Amount") then
                    FieldError("Amount to Apply", StrSubstNo(Text001, FieldCaption("Remaining Amount")));
            end;
        }
        field(85; "IC Partner Code"; Code[20])
        {
            Caption = 'IC Partner Code';
            TableRelation = "IC Partner";
        }
        field(86; "Applying Entry"; Boolean)
        {
            Caption = 'Applying Entry';
        }
        field(87; Reversed; Boolean)
        {
            BlankZero = true;
            Caption = 'Reversed';
        }
        field(88; "Reversed by Entry No."; Integer)
        {
            BlankZero = true;
            Caption = 'Reversed by Entry No.';
            TableRelation = "Cust. Ledger Entry";
        }
        field(89; "Reversed Entry No."; Integer)
        {
            BlankZero = true;
            Caption = 'Reversed Entry No.';
            TableRelation = "Cust. Ledger Entry";
        }
        field(90; Prepayment; Boolean)
        {
            Caption = 'Prepayment';
        }
        field(68000; "Transaction Type"; Enum TransactionTypesEnum)
        {
        }
        field(68001; "Loan No"; Code[20])
        {
        }
        field(68002; "Group Code"; Code[20])
        {
        }
        field(68003; Type; Option)
        {
            OptionCaption = ' ,Registration,PassBook,Loan Insurance,Loan Application Fee,Down Payment';
            OptionMembers = " ",Registration,PassBook,"Loan Insurance","Loan Application Fee","Down Payment";
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
        field(68008; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            TableRelation = "Dimension Set Entry";
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
        field(51516063; "Total Interest Accrued"; Decimal)
        {
            CalcFormula = sum("Interest Due Ledger Entry".Amount where("Customer No." = field("Customer No."),
                                                                        "Posting Date" = field("Posting Date")));
            FieldClass = FlowField;
        }
        field(51516064; "Account Type"; Option)
        {
            OptionCaption = ' ,BOSA Account,FOSA Account';
            OptionMembers = " ","BOSA Account","FOSA Account";
        }
        field(51516165; "Transaction Type Interest"; Option)
        {
            OptionCaption = 'Penalty Charged,Interest Accrual';
            OptionMembers = "Penalty Charged","Interest Accrual";
        }
        field(51516166; "Loa Product Type"; Code[30])
        {
            CalcFormula = lookup("Loans Register"."Loan Product Type" where("Loan  No." = field("Loan No")));
            FieldClass = FlowField;
        }
        field(51516167; "Interest Accrual Date"; Date)
        {
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "Customer No.", "Posting Date", "Currency Code")
        {
            SumIndexFields = "Sales (LCY)", "Profit (LCY)", "Inv. Discount (LCY)";
        }
        key(Key3; "Customer No.", "Currency Code", "Posting Date")
        {
        }
        key(Key4; "Document No.")
        {
        }
        key(Key5; "External Document No.")
        {
        }
        key(Key6; "Customer No.", Open, Positive, "Due Date", "Currency Code")
        {
        }
        key(Key7; Open, "Due Date")
        {
        }
        key(Key8; "Document Type", "Customer No.", "Posting Date", "Currency Code")
        {
            MaintainSIFTIndex = false;
            MaintainSQLIndex = false;
            SumIndexFields = "Sales (LCY)", "Profit (LCY)", "Inv. Discount (LCY)";
        }
        key(Key9; "Salesperson Code", "Posting Date")
        {
        }
        key(Key10; "Closed by Entry No.")
        {
        }
        key(Key11; "Transaction No.")
        {
        }
        key(Key12; "Customer No.", Open, Positive, "Calculate Interest", "Due Date")
        {
        }
        key(Key13; "Customer No.", "Global Dimension 1 Code", "Global Dimension 2 Code", "Posting Date", "Currency Code")
        {
            SumIndexFields = "Sales (LCY)", "Profit (LCY)", "Inv. Discount (LCY)";
        }
        key(Key14; "Customer No.", Open, "Global Dimension 1 Code", "Global Dimension 2 Code", Positive, "Due Date", "Currency Code")
        {
            SumIndexFields = "Amount (LCY)", Amount;
        }
        key(Key15; Open, "Global Dimension 1 Code", "Global Dimension 2 Code", "Due Date")
        {
        }
        key(Key16; "Document Type", "Customer No.", "Global Dimension 1 Code", "Global Dimension 2 Code", "Posting Date", "Currency Code")
        {
        }
        key(Key17; "Customer No.", "Applies-to ID", Open, Positive, "Due Date")
        {
        }
        key(Key18; "Customer No.", "Transaction Type", "Loan No")
        {
            SumIndexFields = "Amount (LCY)", Amount;
        }
        key(Key19; "Transaction Type", "Loan No", "Posting Date", "Customer No.")
        {
            SumIndexFields = "Amount (LCY)", Amount;
        }
        key(Key20; Amount, "Customer No.")
        {
            SumIndexFields = "Amount (LCY)", Amount;
        }
        key(Key21; "Customer Posting Group")
        {
        }
        key(Key22; "Posting Date")
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


    procedure DrillDownOnEntries(var CustLedger: Record "Member Ledger Entry")
    var
        CustLedgEntry: Record "Member Ledger Entry";
    begin

        //DtldCustLedgEntry.COPYFILTER("Customer No.",CustLedgEntry."Customer No.");
        //DtldCustLedgEntry.COPYFILTER("Currency Code",CustLedgEntry."Currency Code");
        //DtldCustLedgEntry.COPYFILTER("Initial Entry Global Dim. 1",CustLedgEntry."Global Dimension 1 Code");
        //DtldCustLedgEntry.COPYFILTER("Initial Entry Global Dim. 2",CustLedgEntry."Global Dimension 2 Code");
        CustLedgEntry.Reset;
        CustLedgEntry.SetCurrentkey("Customer No.", "Posting Date");
        CustLedgEntry.SetRange(CustLedgEntry."Customer No.", CustLedger."Customer No.");
        CustLedgEntry.SetRange(Open, true);
        Page.Run(0, CustLedgEntry);
    end;


    procedure DrillDownOnOverdueEntries(var DtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry")
    var
        CustLedgEntry: Record "Cust. Ledger Entry";
    begin
        CustLedgEntry.Reset;
        DtldCustLedgEntry.Copyfilter("Customer No.", CustLedgEntry."Customer No.");
        DtldCustLedgEntry.Copyfilter("Currency Code", CustLedgEntry."Currency Code");
        DtldCustLedgEntry.Copyfilter("Initial Entry Global Dim. 1", CustLedgEntry."Global Dimension 1 Code");
        DtldCustLedgEntry.Copyfilter("Initial Entry Global Dim. 2", CustLedgEntry."Global Dimension 2 Code");
        CustLedgEntry.SetCurrentkey("Customer No.", "Posting Date");
        CustLedgEntry.SetFilter("Date Filter", '..%1', WorkDate);
        CustLedgEntry.SetFilter("Due Date", '..%1', WorkDate);
        CustLedgEntry.SetFilter("Remaining Amount", '<>%1', 0);
        Page.Run(0, CustLedgEntry);
    end;


    procedure GetOriginalCurrencyFactor(): Decimal
    begin
        if "Original Currency Factor" = 0 then
            exit(1);
        exit("Original Currency Factor");
    end;

    local procedure CheckGLAcc(AccNo: Code[20]; CheckProdPostingGroup: Boolean; CheckDirectPosting: Boolean)
    var
        GLAcc: Record "G/L Account";
    begin
        /*
        IF AccNo <> '' THEN BEGIN
          GLAcc.GET(AccNo);
          GLAcc.CheckGLAcc;
          IF CheckProdPostingGroup THEN
            GLAcc.TESTFIELD("Gen. Prod. Posting Group");
          IF CheckDirectPosting THEN
            GLAcc.TESTFIELD("Direct Posting",TRUE);
        END;
        */

    end;


    procedure TestNoEntriesExist(CurrentFieldName: Text[100]; GLNO: Code[20])
    var
        MemberLedgEntry: Record "Member Ledger Entry";
    begin
        //To prevent change of field
        MemberLedgEntry.SetCurrentkey(MemberLedgEntry."Customer No.");
        MemberLedgEntry.SetRange(MemberLedgEntry."Customer No.", "Customer No.");
        if MemberLedgEntry.Find('-') then
            Error(
            Text000,
             CurrentFieldName);
    end;


    procedure RecalculateAmounts(FromCurrencyCode: Code[10]; ToCurrencyCode: Code[10]; PostingDate: Date)
    var
        CurrExchRate: Record "Currency Exchange Rate";
    begin
        if ToCurrencyCode = FromCurrencyCode then
            exit;

        "Remaining Amount" :=
          CurrExchRate.ExchangeAmount("Remaining Amount", FromCurrencyCode, ToCurrencyCode, PostingDate);
        "Remaining Pmt. Disc. Possible" :=
          CurrExchRate.ExchangeAmount("Remaining Pmt. Disc. Possible", FromCurrencyCode, ToCurrencyCode, PostingDate);
        "Accepted Payment Tolerance" :=
          CurrExchRate.ExchangeAmount("Accepted Payment Tolerance", FromCurrencyCode, ToCurrencyCode, PostingDate);
        "Amount to Apply" :=
          CurrExchRate.ExchangeAmount("Amount to Apply", FromCurrencyCode, ToCurrencyCode, PostingDate);
    end;


    procedure CopyFromGenJnlLine(GenJnlLine: Record "Gen. Journal Line")
    begin
        "Customer No." := GenJnlLine."Account No.";
        "Posting Date" := GenJnlLine."Posting Date";
        "Document Date" := GenJnlLine."Document Date";
        "Document Type" := GenJnlLine."Document Type";
        "Document No." := GenJnlLine."Document No.";
        "External Document No." := GenJnlLine."External Document No.";
        Description := GenJnlLine.Description;
        "Currency Code" := GenJnlLine."Currency Code";
        "Sales (LCY)" := GenJnlLine."Sales/Purch. (LCY)";
        "Profit (LCY)" := GenJnlLine."Profit (LCY)";
        "Inv. Discount (LCY)" := GenJnlLine."Inv. Discount (LCY)";
        "Sell-to Customer No." := GenJnlLine."Sell-to/Buy-from No.";
        "Customer Posting Group" := GenJnlLine."Posting Group";
        "Global Dimension 1 Code" := GenJnlLine."Shortcut Dimension 1 Code";
        "Global Dimension 2 Code" := GenJnlLine."Shortcut Dimension 2 Code";
        "Salesperson Code" := GenJnlLine."Salespers./Purch. Code";
        "Source Code" := GenJnlLine."Source Code";
        "On Hold" := GenJnlLine."On Hold";
        //Bett
        "Transaction Type" := GenJnlLine."Transaction Type";
        "Loan No" := GenJnlLine."Loan No";
        "Prepayment Date" := GenJnlLine."Prepayment date";// added to cater for prepayments by david
        "Applies-to Doc. Type" := GenJnlLine."Applies-to Doc. Type";
        "Applies-to Doc. No." := GenJnlLine."Applies-to Doc. No.";
        "Due Date" := GenJnlLine."Due Date";
        "Pmt. Discount Date" := GenJnlLine."Pmt. Discount Date";
        "Applies-to ID" := GenJnlLine."Applies-to ID";
        "Journal Batch Name" := GenJnlLine."Journal Batch Name";
        "Reason Code" := GenJnlLine."Reason Code";
        "User ID" := UserId;
        "Bal. Account Type" := GenJnlLine."Bal. Account Type";
        "Bal. Account No." := GenJnlLine."Bal. Account No.";
        "No. Series" := GenJnlLine."Posting No. Series";
        "IC Partner Code" := GenJnlLine."IC Partner Code";
        Prepayment := GenJnlLine.Prepayment;
        //cyrus
        "Group Code" := GenJnlLine."Group Code";
        //cyrus
        //Bett
        "Debit Amount" := GenJnlLine."Debit Amount";
        "Credit Amount" := GenJnlLine."Credit Amount";
        // CustLedgEntry."Debit Amount (LCY)":="Debit Amount (LCY)";
        // CustLedgEntry."Credit Amount (LCY)":="Credit Amount (LCY)";
        "Loan No" := "Loan No";
        //Bett
    end;


    procedure UpdateDebitCredit(Correction: Boolean)
    begin
        if ((Amount > 0) or ("Amount (LCY)" > 0)) and not Correction or
           ((Amount < 0) or ("Amount (LCY)" < 0)) and Correction
        then begin
            "Debit Amount" := Amount;
            "Credit Amount" := 0;
            "Debit Amount (LCY)" := "Amount (LCY)";
            "Credit Amount (LCY)" := 0;
        end else begin
            "Debit Amount" := 0;
            "Credit Amount" := -Amount;
            "Debit Amount (LCY)" := 0;
            "Credit Amount (LCY)" := -"Amount (LCY)";
        end;
    end;


    procedure EmailRecords(ShowDialog: Boolean)
    var
        DocumentSendingProfile: Record "Document Sending Profile";
        DummyReportSelections: Record "Report Selections";
    begin
        //DocumentSendingProfile.TrySendToEMail(
        //DummyReportSelections.Usage::"S. Arch. Blanket Order", Rec, FieldNo("Entry No."), DocTxt, FieldNo("Entry No."), ShowDialog);
    end;
}

