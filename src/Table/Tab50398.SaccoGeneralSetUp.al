#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50398 "Sacco General Set-Up"
{

    fields
    {
        field(1; "Share Interest (%)"; Decimal)
        {
        }
        field(2; "Max. Non Contribution Periods"; Code[10])
        {
        }
        field(3; "Min. Contribution"; Decimal)
        {
        }
        field(4; "Min. Dividend Proc. Period"; Code[10])
        {
        }
        field(5; "Loan to Share Ratio"; Decimal)
        {
        }
        field(6; "Min. Loan Application Period"; Code[10])
        {
        }
        field(7; "Min. Guarantors"; Integer)
        {
        }
        field(8; "Max. Guarantors"; Integer)
        {
        }
        field(9; "Member Can Guarantee Own Loan"; Boolean)
        {
        }
        field(10; "Insurance Premium (%)"; Decimal)
        {
        }
        field(11; Rec; Integer)
        {
            NotBlank = false;
        }
        field(12; "Commision (%)"; Decimal)
        {
        }
        field(13; "Contactual Shares (%)"; Decimal)
        {
        }
        field(14; "Registration Fee"; Decimal)
        {
        }
        field(15; "Welfare Contribution"; Decimal)
        {
        }
        field(16; "Administration Fee"; Decimal)
        {
        }
        field(17; "Dividend (%)"; Decimal)
        {
        }
        field(18; "Statement Message #1"; Text[250])
        {
            Enabled = false;
        }
        field(19; "Statement Message #2"; Text[250])
        {
            Enabled = false;
        }
        field(20; "Statement Message #3"; Text[250])
        {
            Enabled = false;
        }
        field(21; "Statement Message #4"; Text[100])
        {
            Enabled = false;
        }
        field(22; "Statement Message #5"; Text[100])
        {
            Enabled = false;
        }
        field(23; "Statement Message #6"; Text[100])
        {
            Enabled = false;
        }
        field(24; "Defaut Batch"; Code[20])
        {
            TableRelation = "Collateral Movement Buffer"."Collateral ID";
        }
        field(25; "Min. Member Age"; DateFormula)
        {
        }
        field(26; "Approved Loans Letter"; Code[10])
        {
            TableRelation = "Interaction Template".Code;
        }
        field(27; "Rejected Loans Letter"; Code[10])
        {
            TableRelation = "Interaction Template".Code;
        }
        field(28; "Max. Contactual Shares"; Decimal)
        {
        }
        field(29; "Shares Contribution"; Decimal)
        {
        }
        field(30; "Boosting Shares %"; Decimal)
        {
        }
        field(31; "Boosting Shares Maturity (M)"; DateFormula)
        {
        }
        field(32; "Min Loan Reaplication Period"; DateFormula)
        {
        }
        field(33; "Welfare Breakdown #1 (%)"; Decimal)
        {
        }
        field(34; "Loan to Share Ratio (4M)"; Decimal)
        {
        }
        field(35; "FOSA Loans Transfer Acct"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(36; "FOSA Bank Account"; Code[20])
        {
            TableRelation = "Bank Account"."No.";
        }
        field(37; "Guarantor Loan No Series"; Code[20])
        {
        }
        field(38; "Interest Due Document No."; Code[20])
        {
        }
        field(39; "Interest Due Posting Date"; Date)
        {
        }
        field(40; "Withholding Tax (%)"; Decimal)
        {
        }
        field(41; "Withdrawal Fee"; Decimal)
        {
        }
        field(42; "Retained Shares"; Decimal)
        {
        }
        field(43; "Multiple Disb. Acc."; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(44; "Receipt Document No."; Code[20])
        {
        }
        field(45; "Minimum Balance"; Decimal)
        {
        }
        field(46; "Use Bands"; Boolean)
        {
        }
        field(47; "Retirement Age"; DateFormula)
        {
        }
        field(48; "Insurance Retension Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(49; "Shares Retension Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(50; "Batch File Path"; Text[20])
        {
        }
        field(51; "Incoming Mail Server"; Text[30])
        {
        }
        field(52; "Outgoing Mail Server"; Text[30])
        {
        }
        field(53; "Email Text"; Text[30])
        {
        }
        field(54; "Sender User ID"; Text[30])
        {
        }
        field(55; "Sender Address"; Text[50])
        {
        }
        field(56; "Email Subject"; Text[50])
        {
        }
        field(57; "Template Location"; Text[50])
        {
        }
        field(58; "Copy To"; Text[50])
        {
        }
        field(59; "Delay Time"; Integer)
        {
        }
        field(60; "Alert time"; Time)
        {
        }
        field(61; Shares; Decimal)
        {
        }
        field(62; "Qualifing Shares"; Decimal)
        {
        }
        field(63; "Gross Dividends"; Decimal)
        {
        }
        field(64; "Withholding Tax"; Decimal)
        {
        }
        field(65; "Net Dividends"; Decimal)
        {
        }
        field(66; "Actual Net Surplus"; Decimal)
        {
            CalcFormula = sum("G/L Entry".Amount where("G/L Account No." = filter('1-11-00000' .. '2-99-29999'),
                                                        "Posting Date" = field("Date Filter")));
            FieldClass = FlowField;
        }
        field(67; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(68; "Loan Transfer Fees Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(69; "Rejoining Fees Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(70; "Boosting Fees Account"; Code[20])
        {
            TableRelation = "G/L Account";

            trigger OnValidate()
            begin
                TestNoEntriesExist(FieldCaption("Boosting Fees Account"), "Boosting Fees Account");
            end;
        }
        field(71; "Bridging Commision Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(72; "Risk Fund Amount"; Decimal)
        {
        }
        field(73; "Funeral Expenses Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(74; "Interest on Deposits (%)"; Decimal)
        {
        }
        field(75; "Days for Checkoff"; DateFormula)
        {
        }
        field(76; "Guarantors Multiplier"; Decimal)
        {
        }
        field(77; "Excise Duty(%)"; Decimal)
        {
        }
        field(78; "Excise Duty Account"; Code[20])
        {
            TableRelation = "G/L Account";

            trigger OnValidate()
            begin
                TestNoEntriesExist(FieldCaption("Excise Duty Account"), "Excise Duty Account");
            end;
        }
        field(79; "ATM Expiry Duration"; DateFormula)
        {
        }
        field(80; "Defaulter LN"; Integer)
        {
        }
        field(81; "Loan Trasfer Fee-EFT"; Decimal)
        {
        }
        field(82; "Loan Trasfer Fee-Cheque"; Decimal)
        {

            trigger OnLookup()
            begin
                TestNoEntriesExist(FieldCaption("Loan Trasfer Fee A/C-Cheque"), "Loan Trasfer Fee A/C-Cheque");
            end;
        }
        field(83; "Loan Trasfer Fee-FOSA"; Decimal)
        {
        }
        field(84; "Loan Trasfer Fee A/C-FOSA"; Code[15])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(85; "Loan Trasfer Fee A/C-EFT"; Code[15])
        {
            TableRelation = "G/L Account"."No.";

            trigger OnValidate()
            begin
                TestNoEntriesExist(FieldCaption("Loan Trasfer Fee A/C-EFT"), "Loan Trasfer Fee A/C-EFT");
            end;
        }
        field(86; "Loan Trasfer Fee A/C-Cheque"; Code[15])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(87; "Monthly Share Contributions"; Decimal)
        {
        }
        field(88; "Maximum No of Guarantees"; Integer)
        {
        }
        field(89; "Loan Trasfer Fee-RTGS"; Decimal)
        {

            trigger OnValidate()
            begin
                TestNoEntriesExist(FieldCaption("Loan Trasfer Fee A/C-RTGS"), "Loan Trasfer Fee A/C-RTGS");
            end;
        }
        field(90; "Loan Trasfer Fee A/C-RTGS"; Code[15])
        {
            TableRelation = "G/L Account";
        }
        field(91; "Top up Commission"; Decimal)
        {
        }
        field(92; "ATM Card Fee-New Coop"; Decimal)
        {
        }
        field(93; "ATM Card Fee-Replacement Coop"; Decimal)
        {
        }
        field(95; "ATM Card Income Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(96; "ATM Card Co-op Bank Account"; Code[20])
        {
            TableRelation = "Bank Account";
        }
        field(97; "ATM Card Fee-New Sacco"; Decimal)
        {
        }
        field(98; "ATM Card Fee-Replacement SACCO"; Decimal)
        {
        }
        field(99; "Deposits Multiplier"; Decimal)
        {
        }
        field(100; "FOSA MPESA COmm A/C"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(101; "Funeral Expense Amount"; Decimal)
        {
        }
        field(102; "Rejoining Fee"; Decimal)
        {
        }
        field(103; "Maximum No of Loans Guaranteed"; Integer)
        {
        }
        field(104; "Withdrawal Fee Account"; Code[20])
        {
            TableRelation = "G/L Account";

            trigger OnValidate()
            begin
                TestNoEntriesExist(FieldCaption("Withdrawal Fee Account"), "Withdrawal Fee Account");
            end;
        }
        field(105; "Dividend Payable Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(106; "WithHolding Tax Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(107; "Dividend Processing Fee"; Decimal)
        {
        }
        field(108; "Dividend Process Fee Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(109; "Comission On Cash Clearance(%)"; Decimal)
        {
        }
        field(110; "SMS Fee Amount"; Decimal)
        {
        }
        field(111; "SMS Fee Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(112; "Minimum Take home"; Decimal)
        {
        }
        field(113; "Min Deposit Cont.(% of Basic)"; Decimal)
        {
        }
        field(114; "Begin Of Month"; Date)
        {
        }
        field(115; "End Of Month"; Date)
        {
        }
        field(116; "Minimum take home FOSA"; Decimal)
        {
        }
        field(117; "Checkoff Interest Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(118; "Risk Beneficiary (%)"; Decimal)
        {
        }
        field(119; "Loan Cash Clearing Fee(%)"; Decimal)
        {
        }
        field(120; "Loan Cash Clearing Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(121; "Risk Fund Control Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(122; "S_Mobile Settlement Account"; Code[20])
        {
            TableRelation = "Bank Account";
        }
        field(123; "S_Mobile Income Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(124; "S_Mobile Income Bulk"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(125; "Paybill Tarrifs"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(126; "Share Transfer Fee %"; Decimal)
        {
            DecimalPlaces = 3 : 3;
        }
        field(127; "Cheque Discounting Fee Account"; Code[20])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(128; "Mpesa Withdrawal Fee"; Decimal)
        {
        }
        field(129; "Mpesa Withdrawal Fee Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(130; "Cheque Discounting Comission"; Decimal)
        {
        }
        field(131; "Comission Received Mpesa"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(132; "Mpesa Cash Withdrawal fee ac"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(133; "Deceased Cust Dep Multiplier"; Integer)
        {
        }
        field(134; "Deposit Refund On DeathAccount"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(135; "E-Loan Qualification (%)"; Decimal)
        {
        }
        field(136; "Charge FOSA Registration Fee"; Boolean)
        {
        }
        field(137; "Charge BOSA Registration Fee"; Boolean)
        {
        }
        field(138; "FOSA Registration Fee Amount"; Decimal)
        {
        }
        field(139; "BOSA Registration Fee Amount"; Decimal)
        {
        }
        field(140; "FOSA Registration Fee Account"; Code[20])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(141; "BOSA Registration Fee Account"; Code[20])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(142; "Loan Attachment Comm. Account"; Code[15])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(143; "Last Transaction Duration"; DateFormula)
        {
        }
        field(144; "Customer Care No"; Code[15])
        {
        }
        field(145; "Send Membership App SMS"; Boolean)
        {
        }
        field(146; "Send Membership Reg SMS"; Boolean)
        {
        }
        field(147; "Send Loan App SMS"; Boolean)
        {
        }
        field(148; "Send Loan Disbursement SMS"; Boolean)
        {
        }
        field(149; "Send Guarantorship SMS"; Boolean)
        {
        }
        field(150; "Send Membership Withdrawal SMS"; Boolean)
        {
        }
        field(151; "Send ATM Withdrawal SMS"; Boolean)
        {
        }
        field(152; "Send Cash Withdrawal SMS"; Boolean)
        {
        }
        field(153; "Send Membership App Email"; Boolean)
        {
        }
        field(154; "Send Membership Reg Email"; Boolean)
        {
        }
        field(155; "Send Loan App Email"; Boolean)
        {
        }
        field(156; "Send Loan Disbursement Email"; Boolean)
        {
        }
        field(157; "Send Guarantorship Email"; Boolean)
        {
        }
        field(158; "Send Membship Withdrawal Email"; Boolean)
        {
        }
        field(159; "Send ATM Withdrawal Email"; Boolean)
        {
        }
        field(160; "Send Cash Withdrawal Email"; Boolean)
        {
        }
        field(161; "Auto Open FOSA Savings Acc."; Boolean)
        {
        }
        field(162; "Business Loans A/c Format"; Code[15])
        {
        }
        field(163; "Sacco Fosa No"; Code[15])
        {
        }
        field(164; "Min. Contribution Bus Loan"; Decimal)
        {
        }
        field(165; "Send Email Notifications"; Boolean)
        {
        }
        field(166; "Part Charge GL"; Code[15])
        {
            TableRelation = "G/L Account";
        }
        field(167; "Part Charge Amount"; Decimal)
        {
        }
        field(168; "External Loan GL"; Code[15])
        {
            TableRelation = "G/L Account";
        }
        field(169; "External Charge (%)"; Decimal)
        {
        }
        field(170; "Welfare Loan GL"; Code[15])
        {
            TableRelation = "G/L Account";
        }
        field(171; "Variance Deposit Gl"; Code[15])
        {
            TableRelation = "G/L Account";
        }
        field(172; "Variance Risk Gl"; Code[15])
        {
            TableRelation = "G/L Account";
        }
        field(173; "Branch Code No"; Code[15])
        {
        }
        field(174; "Default Customer Posting Group"; Code[15])
        {
            TableRelation = "Customer Posting Group".Code;
        }
        field(175; "Default Micro Credit Posting G"; Code[15])
        {
            TableRelation = "Customer Posting Group".Code;
        }
        field(176; "Benevolent Fund Contribution"; Decimal)
        {
            
        }
        field(177; "ATM Card Renewal Fee Coop"; Decimal)
        {
        }
        field(178; "ATM Card Renewal Fee Sacco"; Decimal)
        {
        }
        field(180; "Share Capital Transfer Fee"; Decimal)
        {
        }
        field(181; "Share Capital Transfer Fee Acc"; Code[15])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(182; "Package Retrieval Charge"; Decimal)
        {
        }
        field(183; "Package Retrieval Charge Acc"; Code[20])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(184; "Bank Statement Period"; DateFormula)
        {
        }
        field(185; "Div Capitalization Min_Indiv"; Decimal)
        {
        }
        field(186; "Div Capitalization Min_Corp"; Decimal)
        {
        }
        field(187; "Div Capitalization %"; Decimal)
        {
        }
        field(188; "Partial Deposit Refund Fee"; Decimal)
        {
        }
        field(189; "Partial Deposit Refund Fee A/C"; Code[15])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(190; "Allowable Cheque Discounting %"; Decimal)
        {
        }
        field(191; "Sto max tolerance Days"; DateFormula)
        {
        }
        field(192; "Dont Allow Sto Partial Ded."; Boolean)
        {
        }
        field(193; "Standing Order Bank"; Code[15])
        {
        }
        field(194; "Penalty On Deposit Arrears"; Decimal)
        {
        }
        field(195; "Penalty On Deposit Arrears A/C"; Code[20])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(196; "Corporate Minimum Monthly Cont"; Decimal)
        {
        }
        field(197; "CRB Check Charge"; Decimal)
        {
        }
        field(198; "CRB Vendor Account"; Code[20])
        {
            TableRelation = Vendor."No." where("Creditor Type" = filter(Supplier));
        }
        field(199; "CRB Check Vendor Charge"; Decimal)
        {
        }
        field(200; "CRB Check SACCO income A/C"; Code[10])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(201; "Self Guarantee Multiplier"; Decimal)
        {
        }
        field(202; "Credit Department E-mail"; Text[30])
        {
        }
        field(203; "Operations Department E-mail"; Text[30])
        {
        }
        field(204; "Finance Department E-mail"; Text[30])
        {
        }
        field(205; "BD Department E-mail"; Text[30])
        {
        }
        field(206; "IT Department E-mail"; Text[30])
        {
        }
        field(207; "1st Demand Notice Days"; Integer)
        {
        }
        field(208; "2nd Demand Notice Days"; Integer)
        {
        }
        field(209; "CRB Notice Days"; Integer)
        {
        }
        field(210; "Auctioneer Notice Days"; Integer)
        {
        }
        field(211; "Group Leaders Notice Days"; Integer)
        {
        }
        field(212; "Member Notice Days"; Integer)
        {
        }
        field(213; "Repetitive SMS Frequency Days"; Integer)
        {
        }
        field(214; "Group Members Notice Days"; Integer)
        {
        }
        field(215; "Mobile Loan CRB Notice Days"; Integer)
        {
        }
        field(216; "Performing Required Provision%"; Decimal)
        {
        }
        field(217; "Watch Required Provision%"; Decimal)
        {
        }
        field(218; "Substandar Required Provision%"; Decimal)
        {
        }
        field(219; "Doubtful Required Provision%"; Decimal)
        {
        }
        field(220; "Loss Required Provision%"; Decimal)
        {
        }
        field(221; "Benevolent Fund Account"; Code[30])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(222; "FOSA Shares Amount"; Decimal)
        {
        }
        field(223; "Go Live Date"; Date)
        {
        }
        field(224; "SMS Alert Fees"; Decimal)
        {
        }
        field(225; "SMS Alert Fee Account"; Code[20])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(226; "Total Membership"; Integer)
        {
            CalcFormula = count(Customer where("Customer Type" = filter(Member)));
            FieldClass = FlowField;
        }
        field(227; "ATM Destruction Period"; DateFormula)
        {
        }
        field(228; "Cheque Book Request Path"; Text[100])
        {
        }
        field(229; "ATM Card Request Path"; Text[100])
        {
        }
        field(230; "Active SMS Service Provider"; Option)
        {
            OptionCaption = ' ,CloudPESA,SMSLeo';
            OptionMembers = " ",CloudPESA,SMSLeo;
        }
        field(231; "Collateral Collection Period"; DateFormula)
        {
        }
        field(232; "Loan Amount Due Freeze Period"; DateFormula)
        {
        }
        field(233; "Cheque Processing Fee Account"; Code[16])
        {
            TableRelation = "G/L Account";
        }
        field(234; "Unpaid Cheques Fee Account"; Code[10])
        {
            TableRelation = "G/L Account";
        }
        field(235; "Internal Transfer Fee"; Decimal)
        {
        }
        field(236; "Internal Transfer Fee Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(237; "Paybill Suspense Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(238; "Internal PV Control Account"; Code[20])
        {
            TableRelation = "Bank Account";
        }
        field(239; "FB ATM Withdrawal Limit"; Decimal)
        {
        }
        field(240; "Cheque Clearing Family Income"; Code[30])
        {
            TableRelation = "G/L Account";
        }
        field(241; "Withholding Tax Acc Dividend"; Code[10])
        {
            TableRelation = "G/L Account";
        }
        field(242; "BOSA Reg. Fee Corporate"; Decimal)
        {
        }
        field(243; OnlineMemberMonthlyTransLimit; Decimal)
        {
        }
        field(244; "Referee Comm. Period"; DateFormula)
        {
        }
        field(245; "Recruitment Commission"; Decimal)
        {
        }
        field(246; "Recruitment Comm. Expense GL"; Code[30])
        {
            TableRelation = "G/L Account";
        }
        field(247; "Dormancy Period"; DateFormula)
        {
        }
        field(248; "New Piggy Bank Debit G/L"; Code[20])
        {
        }
        field(249; "New Piggy Bank Credit G/L"; Code[20])
        {
        }
        field(250; "Last Date of Checkoff Advice"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(251; "Penlaty On Recovery"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(252; "Reschedule Charge(%)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(253; "Eq Account"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account"."No.";
        }
        field(254; "The Key"; Code[10])
        {
            DataClassification = ToBeClassified;
            // TableRelation = "G/L Account"."No.";
        }
        field(255; "No. Of Months BeforeLoan"; Integer)
        {
            DataClassification = ToBeClassified;
            // TableRelation = "G/L Account"."No.";
        }
        field(256; "Withdrwal Notice Period"; DateFormula)
        {

        }
        field(257; "Withdrawal Interest Penalty"; Decimal)
        {

        }



    }

    keys
    {
        key(Key1; "The Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        TestNoEntriesExist(FieldCaption("Loan Trasfer Fee A/C-Cheque"), "Loan Trasfer Fee A/C-Cheque");
        TestNoEntriesExist(FieldCaption("Loan Trasfer Fee A/C-EFT"), "Loan Trasfer Fee A/C-EFT");
        TestNoEntriesExist(FieldCaption("Loan Trasfer Fee A/C-RTGS"), "Loan Trasfer Fee A/C-RTGS");
        TestNoEntriesExist(FieldCaption("Withdrawal Fee Account"), "Withdrawal Fee Account");
        TestNoEntriesExist(FieldCaption("Excise Duty Account"), "Excise Duty Account");
        TestNoEntriesExist(FieldCaption("Boosting Fees Account"), "Boosting Fees Account");
    end;

    trigger OnModify()
    begin
        TestNoEntriesExist(FieldCaption("Loan Trasfer Fee A/C-Cheque"), "Loan Trasfer Fee A/C-Cheque");
        TestNoEntriesExist(FieldCaption("Loan Trasfer Fee A/C-EFT"), "Loan Trasfer Fee A/C-EFT");
        TestNoEntriesExist(FieldCaption("Loan Trasfer Fee A/C-RTGS"), "Loan Trasfer Fee A/C-RTGS");
        TestNoEntriesExist(FieldCaption("Withdrawal Fee Account"), "Withdrawal Fee Account");
        TestNoEntriesExist(FieldCaption("Excise Duty Account"), "Excise Duty Account");
        TestNoEntriesExist(FieldCaption("Boosting Fees Account"), "Boosting Fees Account");
    end;

    trigger OnRename()
    begin
        TestNoEntriesExist(FieldCaption("Loan Trasfer Fee A/C-Cheque"), "Loan Trasfer Fee A/C-Cheque");
        TestNoEntriesExist(FieldCaption("Loan Trasfer Fee A/C-EFT"), "Loan Trasfer Fee A/C-EFT");
        TestNoEntriesExist(FieldCaption("Loan Trasfer Fee A/C-RTGS"), "Loan Trasfer Fee A/C-RTGS");
        TestNoEntriesExist(FieldCaption("Withdrawal Fee Account"), "Withdrawal Fee Account");
        TestNoEntriesExist(FieldCaption("Excise Duty Account"), "Excise Duty Account");
        TestNoEntriesExist(FieldCaption("Boosting Fees Account"), "Boosting Fees Account");
    end;

    var
        Text000: label 'You cannot change %1 because there are one or more ledger entries associated with this account.';


    procedure TestNoEntriesExist(CurrentFieldName: Text[100]; GLNO: Code[20])
    var
        GLLedgEntry: Record "G/L Entry";
    begin
        /*
          //To prevent change of field
         GLLedgEntry.SETCURRENTKEY(GLLedgEntry."G/L Account No.");
         GLLedgEntry.SETRANGE("G/L Account No.",GLNO);
        IF GLLedgEntry.FIND('-') THEN
          ERROR(
          Text000,   CurrentFieldName)
          */

    end;
}

