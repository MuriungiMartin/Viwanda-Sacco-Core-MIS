#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50441 "Transactions"
{

    fields
    {
        field(1; No; Code[20])
        {
            Editable = true;

            trigger OnValidate()
            begin
                if No <> xRec.No then begin
                    NoSetup.Get();
                    NoSeriesMgt.TestManual(NoSetup."Transaction Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Account No"; Code[20])
        {
            TableRelation = if ("Member No" = filter(<> '')) Vendor."No." where("BOSA Account No" = field("Member No"),
                                                                              Status = filter(<> Closed | Deceased),
                                                                              Blocked = filter(<> Payment | All))
            else
            if ("Member No" = filter('')) Vendor."No." where(Status = filter(<> Closed | Deceased),
                                                                                                                                   Blocked = filter(<> All | Payment));

            trigger OnValidate()
            begin


                AgentDetails.Reset;
                AgentDetails.SetRange(AgentDetails."Account No", "Account No");
                if AgentDetails.Find('-') then begin
                    "Has Special Mandate" := true;
                end;


                Account.Reset;
                Account.SetRange(Account."No.", "Account No");
                if Account.FindSet then begin
                    "Savings Product" := Account."Account Type";
                end;



                //INSERT IMAGE & SIGNATURE
                CustM.Reset;
                CustM.SetRange(CustM."No.", "Account No");
                if CustM.Find('-') then begin
                    //CustM.CALCFIELDS(CustM.Picture,CustM.Signature);
                    //Picture:=CustM.Picture;
                    //Signature:=CustM.Signature;
                end;

                //CHECK ACCOUNT ACTIVITY
                Account.Reset;
                if Account.Get("Account No") then begin
                    /*IF Account.Status=Account.Status::Dormant THEN BEGIN
                    Account.Status:=Account.Status::Active;
                    Account.MODIFY;
                    END;*/
                    /*IF Account.Status=Account.Status::Deceased THEN BEGIN
                    END
                    ELSE BEGIN
                    IF Account.Status<>Account.Status::Active THEN
                    ERROR('The account is not active and therefore cannot be transacted upon.');
                    END;*/


                    if Account.Get("Account No") then begin
                        Account.CalcFields(Account.Balance);
                        "Account Name" := Account.Name;
                        if "Member No" = '' then begin
                            "Member Name" := Account.Name;
                            "Member No" := Account."BOSA Account No";
                        end;
                        if ObjAccount."Account Category" = ObjAccount."account category"::Joint then
                            "Account Name" := ObjAccount."Joint Account Name";
                        //"Member Name":=ObjAccount."Joint Account Name";
                    end;
                    //Payee:=Account.Name;
                    "Account Type" := Account."Account Type";
                    "Currency Code" := Account."Currency Code";
                    "Staff/Payroll No" := Account."Personal No.";
                    "ID No" := Account."ID No.";
                    "Signing Instructions" := Account."Signing Instructions";
                    //Picture:=Account.Picture;
                    "Staff Account" := Account."Staff Account";
                    "Overdraft Limit" := Account."Over Draft Limit Amount";
                    "Overdraft Expiry Date" := Account."Over Draft Limit Expiry Date";
                    "Overdraft Balance" := Account."Over Draft Limit Amount" - (Account.Balance * -1);
                    if Account."Bulk Withdrawal App Date For W" = "Transaction Date" then begin
                        //Bulk Transaction***********************
                        "Bulk Withdrawal App Done By" := Account."Bulk Withdrawal App Done By";
                        "Bulk Withdrawal Appl Amount" := Account."Bulk Withdrawal Appl Amount";
                        "Bulk Withdrawal Appl Date" := Account."Bulk Withdrawal Appl Date";
                        "Bulk Withdrawal Appl Done" := Account."Bulk Withdrawal Appl Done";
                        "Bulk Withdrawal Fee" := Account."Bulk Withdrawal Fee";
                        "Bulk Withdrawal Date" := Account."Bulk Withdrawal App Date For W";
                        //End Bulk Transaction*******************
                    end;
                end;


                Signature := Account.Signature;
                if (Account.Balance <> 0) and (Account.Status = Account.Status::Deceased) then begin
                    Account.Status := Account.Status::Active;
                    Account.Modify;
                end;

                "Book Balance" := Account.Balance;

                if Account."Account Category" = Account."account category"::Branch then
                    "Branch Transaction" := true;




                if ObjAccount.Get("Account No") then begin

                    if ObjAccount.Status <> ObjAccount.Status::Active then
                        Error('Account status has to be active, Current status is %1', ObjAccount.Status);

                    if AccountTypes.Get(ObjAccount."Account Type") then begin
                        Account.CalcFields(Account.Balance);

                        "Account Description" := AccountTypes.Description;
                        "Minimum Account Balance" := AccountTypes."Minimum Balance";
                        "Fee Below Minimum Balance" := AccountTypes."Fee Below Minimum Balance";
                        "Fee on Withdrawal Interval" := AccountTypes."Withdrawal Penalty";
                        "Use Graduated Charges" := AccountTypes."Use Graduated Charges";
                        //Picture:=Account.Picture;
                        //Signature:=Account.Signature;


                        ObjCust.Reset;
                        ObjCust.SetRange(ObjCust."No.", ObjAccount."BOSA Account No");
                        if ObjCust.FindSet then begin
                            VarMonthlyTurnOver := ObjCust."Expected Monthly Income Amount";
                            "Monthly TurnOver Amount" := VarMonthlyTurnOver;
                        end;
                    end;

                end;

                ObjSignatories.Reset;
                ObjSignatories.SetRange(ObjSignatories."Account No", "Account No");
                if ObjSignatories.FindSet = true then begin
                    "Has Signatories" := true;
                end;

                ObjAuditGeneralSetup.Get();

                "Month Credits to Date" := SFactory.FnGetAccountMonthlyCredit("Account No", "Transaction Date", "Member No");

                "Monthly Max Credits+Tolerance" := VarMonthlyTurnOver + (VarMonthlyTurnOver * (ObjAuditGeneralSetup."Monthy Credits V TurnOver C%" / 100));

            end;
        }
        field(3; "Account Name"; Text[200])
        {
        }
        field(4; "Transaction Type"; Code[20])
        {
            NotBlank = true;
            TableRelation = if ("Account No" = filter(<> '')) "Transaction Types" where("Account Type" = field("Savings Product"))
            else
            if ("Account No" = filter('')) "Transaction Types" where("Account Type" = filter('MEMBERSHIP'));

            trigger OnValidate()
            begin
                VarAmtHolder := 0;

                TransactionTypes.Reset;
                TransactionTypes.SetRange(TransactionTypes.Code, "Transaction Type");
                TransactionTypes.SetRange(TransactionTypes."Account Type", "Savings Product");
                if TransactionTypes.FindSet then begin
                    "Transaction Description" := TransactionTypes.Description;
                    "Transaction Mode" := TransactionTypes."Default Mode";
                    "Transaction Span" := TransactionTypes."Transaction Span";
                    "Use Graduated Charges" := TransactionTypes."Use Graduated Charge";
                    "Type _Transactions" := TransactionTypes.Type;

                    //EVALUATE(Type,FORMAT(TransactionTypes.Type));



                    if "Transaction Category" = 'BANKERS CHEQUE' then begin
                        if "Bankers Cheque Type" = "bankers cheque type"::Company then begin
                            TransactionCharges.Reset;
                            TransactionCharges.SetRange(TransactionCharges."Transaction Type", "Transaction Type");
                            if TransactionCharges.Find('-') then begin
                                ////////
                                repeat
                                    if TransactionCharges."Use Percentage" = true then begin
                                        if TransactionCharges."Percentage of Amount" = 0 then
                                            Error('Percentage of amount cannot be zero.');
                                        VarAmtHolder := VarAmtHolder + (TransactionCharges."Percentage of Amount" / 100) * "Suspended Amount";
                                    end
                                    else begin
                                        VarAmtHolder := VarAmtHolder + TransactionCharges."Charge Amount";
                                    end;
                                /////////
                                until TransactionCharges.Next = 0;
                            end;

                            if "Suspended Amount" <> 0 then begin
                                Amount := "Suspended Amount" - VarAmtHolder;
                            end
                            else begin
                                Amount := 0;
                            end;

                        end;
                    end;


                    Banks.Reset;
                    Banks.SetRange(Banks.CashierID, UserId);
                    Banks.SetRange(Banks."Account Type", Banks."account type"::Cashier);
                    if Banks.Find('-') then begin
                        "Bank Account" := Banks."No.";
                    end;
                    //END;



                    if AccountTypes.Get("Savings Product") then begin
                        "Use Graduated Charges" := AccountTypes."Use Graduated Charges";
                    end;

                    "Transaction Mode" := TransactionTypes."Default Mode";
                    "Transaction Mode New" := TransactionTypes."Default Mode";
                    "Type _Transactions" := TransactionTypes.Type;

                end;
            end;
        }
        field(5; Amount; Decimal)
        {
            NotBlank = true;

            trigger OnValidate()
            begin
                Suspicious := false;
                "Transaction to Be Declared" := false;

                if "Transaction Category" = 'BANKERS CHEQUE' then begin
                    if "Bankers Cheque Type" = "bankers cheque type"::Company then begin

                    end;
                end;

                if ObjAccount.Get("Account No") then begin
                    if ObjAccount."Account Type" = '406' then begin
                        ObjAccount.CalcFields(ObjAccount.Balance, ObjAccount."Uncleared Cheques");
                        AvailableBal := (ObjAccount.Balance - ObjAccount."Uncleared Cheques");


                        ObjAccTypes.Reset;
                        ObjAccTypes.SetRange(ObjAccTypes.Code, ObjAccount."Account Type");
                        if ObjAccTypes.Find('-') then
                            AvailableBal := AvailableBal - ObjAccTypes."Minimum Balance";
                        if Type = 'Withdrawal' then begin

                            if (AvailableBal - Amount) < (ObjAccount."Over Draft Limit Amount" * -1) then
                                Error('Transaction will exceed the Account Over draft limit of %1', ObjAccount."Over Draft Limit Amount");
                            if ObjAccount."Over Draft Limit Expiry Date" < WorkDate then
                                Error('Account Over draft limit expired on %1', ObjAccount."Over Draft Limit Expiry Date");
                        end;
                    end;
                end;

                ObjAuditGeneralSetup.Get;

                if "Type _Transactions" = "type _transactions"::"Cash Deposit" then begin
                    if (("Month Credits to Date" + Amount) > "Monthly Max Credits+Tolerance") and ("Monthly Max Credits+Tolerance" > 0) then begin
                        Suspicious := true;
                        if Suspicious = true then
                            Message('Suspicious Transaction!,Look at the Suspicious Transaction Tab Below for Details.');
                    end;
                end;

                CalcFields("Total Credits Transacted Today", "Total Debits Transacted Today");
                if "Type _Transactions" = "type _transactions"::Withdrawal then begin
                    if (Amount + "Total Debits Transacted Today") > ObjAuditGeneralSetup."Cumm. Daily Debits Limit Amt" then begin
                        "Transaction to Be Declared" := true;
                        if "Transaction to Be Declared" = true then
                            Message('Transaction Requires Declaretion!,Look at the Declaration Tab Below for Details.');
                    end;
                end;




                if "Type _Transactions" = "type _transactions"::"Cash Deposit" then begin
                    if (Amount + "Total Credits Transacted Today") > ObjAuditGeneralSetup."Cumm. Daily Credits Limit Amt" then begin
                        "Transaction to Be Declared" := true;
                        if "Transaction to Be Declared" = true then
                            Message('Transaction Requires Declaretion!,Look at the Declaration Tab Below for Details.');
                    end;
                end;



                ObjGraduatedCharge.Reset;
                if ObjGraduatedCharge.Find('-') then begin
                    if (Amount >= ObjGraduatedCharge."Minimum Amount") and (Amount <= ObjGraduatedCharge."Maximum Amount")
                    and (ObjGraduatedCharge."Notice Status" = ObjGraduatedCharge."notice status"::" ") then begin
                        repeat
                            "Normal Transaction Charge" := true;
                        until ObjGraduatedCharge.Next = 0;
                    end;
                end;
            end;
        }
        field(6; Cashier; Code[60])
        {
            Editable = false;
        }
        field(7; "Transaction Date"; Date)
        {
            Editable = true;

            trigger OnValidate()
            begin
                if "Transaction Mode" = "transaction mode"::"Deposit Slip" then begin
                    if ChequeTypes.Get("Cheque Type") then begin
                        CDays := ChequeTypes."Clearing  Days" + 1;

                        EMaturity := "Transaction Date";
                        if i < CDays then begin
                            repeat
                                EMaturity := CalcDate('1D', EMaturity);
                                if (Date2dwy(EMaturity, 1) <> 6) and (Date2dwy(EMaturity, 1) <> 7) then
                                    i := i + 1;

                            until i = CDays;
                        end;

                        "Expected Maturity Date" := EMaturity;

                    end;
                end;
            end;
        }
        field(8; "Transaction Time"; Time)
        {
            Editable = false;
        }
        field(9; Posted; Boolean)
        {
            Editable = true;
        }
        field(10; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(11; "Account Type"; Code[20])
        {
            TableRelation = "Account Types-Saving Products".Code;
        }
        field(12; "Account Description"; Text[90])
        {
        }
        field(13; "Denomination Total"; Decimal)
        {
        }
        field(14; "Cheque Type"; Code[20])
        {
            TableRelation = "Cheque Types";

            trigger OnValidate()
            begin
                if ChequeTypes.Get("Cheque Type") then begin
                    Description := ChequeTypes.Description;
                    "Clearing Charges" := ChequeTypes."Clearing Charges";
                    "Clearing Days" := ChequeTypes."Clearing Days";

                    CDays := ChequeTypes."Clearing  Days"; //+1;

                    EMaturity := "Transaction Date";
                    if i < CDays then begin
                        repeat
                            EMaturity := CalcDate('1D', EMaturity);
                            if (Date2dwy(EMaturity, 1) <> 6) and (Date2dwy(EMaturity, 1) <> 7) then
                                i := i + 1;

                        until i = CDays;
                    end;

                    "Expected Maturity Date" := EMaturity;

                end;
            end;
        }
        field(15; "Cheque No"; Code[20])
        {

            trigger OnValidate()
            begin
                if "Cheque No" <> '' then begin
                    Trans.Reset;
                    Trans.SetCurrentkey(Trans."Cheque No");
                    Trans.SetRange(Trans."Cheque No", "Cheque No");
                    Trans.SetRange(Trans.Posted, true);
                    //IF Trans.FIND('-') THEN
                    //ERROR('There is an existing posted cheque No. %1',Trans.No);

                end;
            end;
        }
        field(16; "Cheque Date"; Date)
        {

            trigger OnValidate()
            begin
                if "Cheque Date" > Today then
                    Error('Post dated cheques not allowed.');

                if CalcDate('6M', "Cheque Date") < Today then
                    Error('Cheque stale therefore cannot be accepted.');
            end;
        }
        field(17; Payee; Text[100])
        {
        }
        field(19; "Bank No"; Code[20])
        {
            TableRelation = "Bank Account"."No.";

            trigger OnLookup()
            begin
                "Bank No" := BanksList."Bank Code";

                BanksList.Reset;

                if BanksList.Get("Bank No") then begin
                    "Bank Name" := BanksList."Bank Name";
                end;

                BanksList.Reset;
            end;
        }
        field(20; "Branch No"; Code[20])
        {

            trigger OnValidate()
            begin
                BanksList.Reset;
                if BanksList.Get("Branch No") then begin
                    "Branch Name" := BanksList."Bank Name";
                end;
            end;
        }
        field(21; "Clearing Charges"; Decimal)
        {
        }
        field(22; "Clearing Days"; DateFormula)
        {
        }
        field(23; Description; Text[150])
        {
        }
        field(24; "Bank Name"; Text[150])
        {
        }
        field(25; "Branch Name"; Text[150])
        {
        }
        field(26; "Transaction Mode"; Option)
        {
            Caption = 'Payment Mode';
            OptionCaption = 'Cash,Deposit Slip,Cheque';
            OptionMembers = Cash,"Deposit Slip",Cheque;
            TableRelation = "Transaction Type";
        }
        field(27; Type; Text[50])
        {
        }
        field(31; "Transaction Description"; Text[100])
        {
        }
        field(32; "Minimum Account Balance"; Decimal)
        {
            FieldClass = Normal;
        }
        field(33; "Fee Below Minimum Balance"; Decimal)
        {
        }
        field(34; "Normal Withdrawal Charge"; Decimal)
        {
        }
        field(36; Authorised; Option)
        {
            Editable = true;
            OptionMembers = No,Yes,Rejected,"No Charges";

            trigger OnValidate()
            begin
                "Withdrawal FrequencyAuthorised" := Authorised;
            end;
        }
        field(39; "Checked By"; Text[50])
        {
        }
        field(40; "Fee on Withdrawal Interval"; Decimal)
        {
        }
        field(41; Remarks; Text[250])
        {
        }
        field(42; Status; Option)
        {
            OptionMembers = Pending,Honoured,Stopped,Bounced;
        }
        field(43; "Date Posted"; Date)
        {
        }
        field(44; "Time Posted"; Time)
        {
        }
        field(45; "Posted By"; Text[50])
        {
        }
        field(46; "Expected Maturity Date"; Date)
        {
        }
        field(47; Picture; Media)
        {
            Caption = 'Picture';
        }
        field(48; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;
        }
        field(49; "Transaction Category"; Code[20])
        {
        }
        field(50; Deposited; Boolean)
        {
        }
        field(51; "Date Deposited"; Date)
        {
        }
        field(52; "Time Deposited"; Time)
        {
        }
        field(53; "Deposited By"; Text[20])
        {
        }
        field(54; "Post Dated"; Boolean)
        {
        }
        field(55; Select; Boolean)
        {
        }
        field(56; "Status Date"; Date)
        {
        }
        field(57; "Status Time"; Time)
        {
        }
        field(58; "Supervisor Checked"; Boolean)
        {
        }
        field(59; "Book Balance"; Decimal)
        {
            Editable = false;
            FieldClass = Normal;
        }
        field(60; "Notice No"; Code[20])
        {
        }
        field(61; "Notice Cleared"; Option)
        {
            OptionMembers = Pending,No,Yes,"No Charges";
        }
        field(62; "Schedule Amount"; Decimal)
        {
            DecimalPlaces = 2 : 2;
        }
        field(63; "Has Schedule"; Boolean)
        {
        }
        field(64; Requested; Boolean)
        {
        }
        field(65; "Date Requested"; Date)
        {
        }
        field(66; "Time Requested"; Time)
        {
        }
        field(67; "Requested By"; Text[20])
        {
        }
        field(68; Overdraft; Boolean)
        {
        }
        field(69; "Cheque Processed"; Boolean)
        {
        }
        field(70; "Staff/Payroll No"; Text[20])
        {

            trigger OnValidate()
            begin
                /*Account.RESET;
                Account.SETRANGE(Account."Staff/Payroll No","Staff/Payroll No");
                
                IF Account.FIND('-')THEN BEGIN
                MESSAGE('its there');
                IF Account.Status=Account.Status::Dormant THEN BEGIN
                Account.Status:=Account.Status::Active;
                Account.MODIFY;
                END;
                IF Account.Status=Account.Status::New THEN BEGIN
                END
                ELSE BEGIN
                IF Account.Status<>Account.Status::Active THEN
                ERROR('The account is not active and therefore cannot be transacted upon.');
                END;
                END;
                
                
                IF Account.GET("Staff/Payroll No") THEN BEGIN
                "Account No":=Account."No.";
                "Account Name":=Account.Name;
                "Account Type":=Account."Account Type";
                "Currency Code":=Account."Currency Code";
                
                END;
                
                IF AccountTypes.GET("Account Type") THEN BEGIN
                "Account Description":=AccountTypes.Description;
                "Minimum Account Balance":=AccountTypes."Minimum Balance";
                "Fee Below Minimum Balance":=AccountTypes."Fee Below Minimum Balance";
                //"Normal Withdrawal Charge":=AccountTypes."Withdrawal Charge";
                "Fee on Withdrawal > Interval":=AccountTypes."Withdrawal Penalty";
                END;
                
                 */

            end;
        }
        field(71; "Cheque Transferred"; Option)
        {
            OptionMembers = No,Yes;
        }
        field(72; "Expected Amount"; Decimal)
        {
        }
        field(73; "Line Totals"; Decimal)
        {
        }
        field(74; "Transfer Date"; Date)
        {
        }
        field(75; "BIH No"; Code[20])
        {
        }
        field(76; "Transfer No"; Code[20])
        {
        }
        field(77; Attached; Boolean)
        {
        }
        field(78; "BOSA Account No"; Code[20])
        {
            TableRelation = Customer."No." where(ISNormalMember = filter(true),
                                                            Status = const(Active));
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                /*Cust.RESET;
                Cust.SETRANGE(Cust."No.","BOSA Account No");
                IF Cust.FIND('-') THEN BEGIN
                Payee:=Cust.Name;
                "Reference No":=Cust."Payroll/Staff No";
                "Staff/Payroll No":=Cust."Payroll/Staff No";
                "ID No":=Cust."ID No.";
                
                END;
                  */

            end;
        }
        field(79; "Salary Processing"; Option)
        {
            OptionMembers = " ",No,Yes;
        }
        field(80; "Expense Account"; Code[30])
        {
        }
        field(81; "Expense Description"; Text[50])
        {
        }
        field(82; "Company Code"; Code[30])
        {
            TableRelation = "Sacco Employers".Code;
        }
        field(83; "Schedule Type"; Option)
        {
            OptionMembers = ,"Salary Processing",Contributions,"ATM EFT Transactions","Savings Loan Recoveries";
        }
        field(84; "Banked By"; Code[20])
        {
        }
        field(85; "Date Banked"; Date)
        {
        }
        field(86; "Time Banked"; Time)
        {
        }
        field(87; "Banking Posted"; Boolean)
        {
        }
        field(88; "Cleared By"; Code[20])
        {
        }
        field(89; "Date Cleared"; Date)
        {
        }
        field(90; "Time Cleared"; Time)
        {
        }
        field(91; "Clearing Posted"; Boolean)
        {
        }
        field(92; "Needs Approval"; Option)
        {
            OptionMembers = Yes,No;
        }
        field(93; "ID Type"; Code[20])
        {
        }
        field(94; "ID No"; Code[50])
        {

            trigger OnValidate()
            begin


                /*IF ("Account No"<>'00-0000003000') OR ("Account No"<>'00-0000000000')  THEN
                ERROR('THIS ID. NO CANNOT BE MODIFIED');*/
                "N.A.H Balance" := 0;
                VendLedg.Reset;
                VendLedg.SetCurrentkey(VendLedg."External Document No.");
                VendLedg.SetRange(VendLedg."External Document No.", "ID No");
                if VendLedg.Find('-') then begin
                    VendLedg.CalcFields(VendLedg.Amount);
                    repeat
                        "N.A.H Balance" := ("N.A.H Balance" + VendLedg.Amount) * -1;
                        Modify;
                    until VendLedg.Next = 0;
                end;

            end;
        }
        field(95; "Reference No"; Code[20])
        {
        }
        field(96; "Refund Cheque"; Boolean)
        {
        }
        field(97; Imported; Boolean)
        {
        }
        field(98; "External Account No"; Code[30])
        {
        }
        field(99; "BOSA Transactions"; Decimal)
        {
            Editable = false;
            FieldClass = Normal;
        }
        field(100; "Bank Account"; Code[20])
        {
            TableRelation = "Bank Account"."No.";
        }
        field(101; "Savers Total"; Decimal)
        {
            FieldClass = Normal;
        }
        field(102; "Mustaafu Total"; Decimal)
        {
            FieldClass = Normal;
        }
        field(103; "Junior Star Total"; Decimal)
        {
            FieldClass = Normal;
        }
        field(104; Printed; Boolean)
        {
        }
        field(105; "Account Type."; enum "Gen. Journal Account Type")
        {
            Caption = 'Account Type';

        }
        field(106; "Account No."; Code[20])
        {
            Caption = 'Account No.';
            TableRelation = if ("Account Type." = const("G/L Account")) "G/L Account"
            else
            if ("Account Type." = const(Customer)) Customer
            else
            if ("Account Type." = const(Vendor)) Vendor
            else
            if ("Account Type." = const("Bank Account")) "Bank Account"
            else
            if ("Account Type." = const("Fixed Asset")) "Fixed Asset"
            else
            if ("Account Type." = const("IC Partner")) "IC Partner";

            trigger OnValidate()
            begin

                if "Account Type." in ["account type."::Customer, "account type."::Vendor, "account type."::
                "IC Partner"] then
                    case "Account Type." of
                        "account type."::"G/L Account":
                            begin
                                GLAcc.Get("Account No.");


                            end;


                        "account type."::Customer:
                            begin
                                Cust.Get("Account No.");

                            end;
                        "account type."::Vendor:
                            begin
                                Vend.Get("Account No.");
                            end;
                        "account type."::"Bank Account":
                            begin
                                BankAcc.Get("Account No.");
                            end;
                        "account type."::"Fixed Asset":
                            begin
                                FA.Get("Account No.");
                            end;
                    end;
            end;
        }
        field(107; "Withdrawal FrequencyAuthorised"; Option)
        {
            OptionMembers = No,Yes,Rejected;
        }
        field(108; "Frequency Needs Approval"; Option)
        {
            OptionMembers = " ",No,Yes;
        }
        field(109; "Special Advance No"; Code[20])
        {
        }
        field(110; "Bankers Cheque Type"; Option)
        {
            OptionMembers = Normal,Company;

            trigger OnValidate()
            begin
                if "Bankers Cheque Type" = "bankers cheque type"::Company then begin
                    GenLedgerSetup.Get;
                    // GenLedgerSetup.TESTFIELD(GenLedgerSetup."Company Bankers Cheque Account");
                    "Account Type." := "account type."::"G/L Account";
                    //"Account No.":=GenLedgerSetup."Company Bankers Cheque Account";

                end else begin
                    "Account No." := '';
                end;
            end;
        }
        field(111; "Suspended Amount"; Decimal)
        {
        }
        field(112; "Transferred By EFT"; Boolean)
        {
        }
        field(113; "Banking User"; Code[20])
        {
        }
        field(114; "Company Text Name"; Code[20])
        {
        }
        field(115; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(116; "Total Salaries"; Integer)
        {
            FieldClass = Normal;
        }
        field(117; "EFT Transferred"; Boolean)
        {
        }
        field(118; "ATM Transactions Total"; Decimal)
        {
            FieldClass = Normal;
        }
        field(119; "Bank Code"; Code[20])
        {
            TableRelation = Banks.Code;

            trigger OnValidate()
            begin
                if BanksList.Get("Bank Code") then begin
                    "Bank Name" := BanksList."Bank Name";
                    "Branch Name" := BanksList.Branch;
                end;
            end;
        }
        field(120; "External Account Name"; Text[50])
        {
        }
        field(121; "Overdraft Limit"; Decimal)
        {
            Editable = false;
        }
        field(122; "Overdraft Allowed"; Boolean)
        {
        }
        field(123; "Available Balance"; Decimal)
        {
        }
        field(124; "Authorisation Requirement"; Text[50])
        {
        }
        field(125; "Bankers Cheque No"; Code[20])
        {
            TableRelation = if ("Type _Transactions" = filter("Bankers Cheque")) "Banker Cheque Register"."Banker Cheque No." where(Issued = const(false),
                                                                                                                                   Cancelled = const(false))
            else
            if ("Type _Transactions" = filter("Cheque Withdrawal")) "Cheque Book Register"."Cheque No." where(Issued = const(false),
                                                                                                                                                                                                                                         Cancelled = const(false));
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                if BRegister.Get("Bankers Cheque No") then begin
                    BRegister.Issued := true;
                    BRegister.Modify;
                end;
            end;
        }
        field(126; "Transaction Span"; Option)
        {
            OptionCaption = 'FOSA,BOSA';
            OptionMembers = FOSA,BOSA;
        }
        field(127; "Uncleared Cheques"; Decimal)
        {
            CalcFormula = sum(Transactions.Amount where("Account No" = field("Account No"),
                                                         Posted = const(true),
                                                         "Cheque Processed" = const(false),
                                                         Type = const('Cheque Deposit')));
            Editable = false;
            FieldClass = FlowField;
        }
        field(128; "Transaction Available Balance"; Decimal)
        {
        }
        field(129; "Branch Account"; Code[20])
        {
            TableRelation = Vendor."No." where("Creditor Type" = const("FOSA Account"),
                                                "Account Category" = const(Branch));

            trigger OnValidate()
            begin
                if Acc.Get("Branch Account") then
                    "FOSA Branch Name" := Acc.Name;
            end;
        }
        field(130; "Branch Transaction"; Boolean)
        {
        }
        field(131; "FOSA Branch Name"; Text[30])
        {
        }
        field(133; "Branch Refference"; Text[30])
        {
        }
        field(134; "Branch Account No"; Code[20])
        {
        }
        field(135; "Branch Transaction Date"; Date)
        {
        }
        field(136; "Post Attempted"; Boolean)
        {
        }
        field(137; "Transacting Branch"; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(138; Signature; MediaSet)
        {
        }
        field(139; "Allocated Amount"; Decimal)
        {
            CalcFormula = sum("Receipt Allocation".Amount where("Document No" = field(No)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(140; "Amount Discounted"; Decimal)
        {
        }
        field(141; "Dont Clear"; Boolean)
        {
        }
        field(142; "Other Bankers No."; Code[100])
        {
        }
        field(50000; Discard; Boolean)
        {
        }
        field(62000; "N.A.H Balance"; Decimal)
        {
        }
        field(62001; "Cheque Deposit Remarks"; Text[50])
        {
        }
        field(62002; "Balancing Account"; Code[20])
        {
            TableRelation = Vendor."No.";
        }
        field(62003; "Balancing Account Name"; Text[50])
        {

            trigger OnValidate()
            begin
                Vend.Reset;

                if Vend.Get(No) then begin
                    "Balancing Account Name" := Vend.Name;
                end;
            end;
        }
        field(62004; "Bankers Cheque Payee"; Code[10])
        {
        }
        field(62005; "Member No"; Code[20])
        {
            TableRelation = Customer."No.";

            trigger OnValidate()
            begin
                Cust.Reset;
                Cust.SetRange(Cust."No.", "Member No");
                if Cust.Find('-') then begin
                    "Member Name" := Cust.Name;
                    "BOSA Account No" := "Member No";
                    "ID No" := Cust."ID No.";
                    "Account Type" := 'MEMBERSHIP';
                end;
                /*
            //*********ABC TRANSACTIONS****
              Cust.RESET;
              Cust.SETRANGE(Cust."No.",'ABC');
              IF Cust.FIND('-') THEN BEGIN
                "Member Name":=Cust.Name;
                "BOSA Account No":="Member No";
                "Savings Product":='Z_ABC';
                "Account No.":=Cust."FOSA Account No.";
                //VALIDATE("Account No.");
                VALIDATE("Savings Product");

                END;

            //*********ABC TRANSACTIONS END****
            */

            end;
        }
        field(62006; "Member Name"; Text[60])
        {
        }
        field(62007; "Savings Product"; Code[20])
        {
            TableRelation = "Account Types-Saving Products".Code;

            trigger OnValidate()
            begin
                /*IF "Member No"<>'' THEN BEGIN
                Account.RESET;
                Account.SETRANGE(Account."BOSA Account No","Member No");
                Account.SETRANGE(Account."Account Type","Savings Product");
                IF Account.FIND('-') THEN BEGIN
                  IF "Savings Product"<>'MEMBERSHIP' THEN BEGIN
                "Account No":=Account."No.";
                "Account Name":=Account.Name;
                VALIDATE("Account No");
                END ELSE
                "Account No":='';
                "Account Name":='';
                END;
                END;
                
                IF "Member No"<>'' THEN BEGIN
                Account.RESET;
                Account.SETRANGE(Account."BOSA Account No","Member No");
                Account.SETRANGE(Account."Account Type","Account Type");
                IF Account.FINDSET THEN BEGIN
                  "Account No":=Account."No.";
                  "Account Name":=Account.Name;
                  VALIDATE("Account No")
                  END ELSE
                  "Account No":='';
                  "Account Name":='';
                  //VALIDATE("Account No");
                END;
                */

            end;
        }
        field(62008; "Transaction Chrages"; Decimal)
        {
        }
        field(62009; "Cashier Bank"; Code[20])
        {
            CalcFormula = lookup("Bank Account"."No." where(CashierID = field(Cashier)));
            FieldClass = FlowField;
        }
        field(62010; "Drawer's Account No"; Code[20])
        {
            TableRelation = Vendor;

            trigger OnValidate()
            begin
                if Vend.Get("Drawer's Account No") then
                    "Drawer's Name" := Vend.Name;
                "Drawers Member No" := Vend."BOSA Account No";

            end;
        }
        field(62011; "Drawer's Name"; Text[50])
        {
        }
        field(62012; "Drawers Cheque No."; Code[20])
        {
            TableRelation = "Cheques Register"."Cheque No." where("Cheque Book Account No." = field("Drawers Member No"));
        }
        field(62013; "Transaction Mode New"; Option)
        {
            OptionCaption = 'Cash,Deposit Slip,Cheque';
            OptionMembers = Cash,"Deposit Slip",Cheque;

            trigger OnValidate()
            begin
                if "Transaction Mode New" = "transaction mode new"::Cash then begin
                    ObjBank.Reset;
                    ObjBank.SetRange("Cashier ID", UserId);
                    ObjBank.SetRange(ObjBank."Account Type", ObjBank."account type"::Cashier);
                    if ObjBank.FindSet then begin
                        "Bank Account" := ObjBank."No.";
                    end;
                end else
                    "Bank Account" := '';
            end;
        }
        field(62014; "Cheque Clearing Bank Code"; Code[50])
        {
            TableRelation = if ("Type _Transactions" = filter("Cheque Deposit")) "Bank Account"."No." where("Cheque Clearing Bank" = filter(true))
            else
            if ("Type _Transactions" = filter("Bankers Cheque")) "Bank Account"."No." where("Bankers Cheque Clearing Bank" = filter(true));

            trigger OnValidate()
            begin
                BankAcc.Reset;
                BankAcc.SetRange(BankAcc."No.", "Cheque Clearing Bank Code");
                if BankAcc.Find('-') then begin
                    "Cheque Clearing Bank" := BankAcc.Name;
                end;
            end;
        }
        field(62015; "Cheque Clearing Bank"; Text[80])
        {
        }
        field(62016; "Drawers Member No"; Code[20])
        {
        }
        field(62017; "Staff Account"; Boolean)
        {
        }
        field(62018; "Document Date"; Date)
        {

            trigger OnValidate()
            begin
                if "Document Date" > Today then Error('Transaction cannot be in the future');
            end;
        }
        field(62019; "Overdraft Transaction"; Boolean)
        {
        }
        field(62020; "Reason For Freezing Account"; Code[30])
        {
        }
        field(62021; "Over Draft Type"; Option)
        {
            OptionCaption = ' ,AWD,LWD';
            OptionMembers = " ",AWD,LWD;
        }
        field(62022; "LWD Loan No"; Code[20])
        {
            TableRelation = "Loans Register"."Loan  No." where("BOSA No" = field("Member No"),
                                                                Posted = filter(false));

            trigger OnValidate()
            begin
                if LoansRec.Get("LWD Loan No") then begin
                    "LWD Loan Product" := LoansRec."Loan Product Type";
                end;
            end;
        }
        field(62023; "LWD Loan Product"; Code[20])
        {
            TableRelation = "Loan Products Setup";
        }
        field(62024; "Excempt Charge"; Boolean)
        {
        }
        field(62025; "ABC Transaction Type"; Option)
        {
            OptionCaption = ' ,Property rates,Single Business Permit,Parking Fees,Tender Fees,Ground Rent,Plan Approvals,Slaughter House Fee,Market Fee,Cess and Quary Cess,House and Stall Rent';
            OptionMembers = " ","Property rates","Single Business Permit","Parking Fees","Tender Fees","Ground Rent","Plan Approvals","Slaughter House Fee","Market Fee","Cess and Quary Cess","House and Stall Rent";
        }
        field(62026; "ABC Depositer"; Text[30])
        {
        }
        field(62027; "ABC Depositer ID"; Code[15])
        {
        }
        field(62028; "Has Special Mandate"; Boolean)
        {
        }
        field(62029; "Transacting Agent"; Code[20])
        {
            TableRelation = "Account Agent Details"."Document No" where("Account No" = field("Account No"));

            trigger OnValidate()
            begin
                AgentDetails.Reset;
                AgentDetails.SetRange(AgentDetails."Document No", "Transacting Agent");
                //AgentDetails.SETRANGE(AgentDetails.Names,"Transacting Agent");
                if AgentDetails.Find('-') then begin
                    //AgentDetails.CALCFIELDS(AgentDetails.Picture,AgentDetails.Signature);
                    //Picture:=AgentDetails.Picture;
                    //Signature:=AgentDetails.Signature;
                    "Agent Name" := AgentDetails.Names;

                end;
            end;
        }
        field(62030; Reversed; Boolean)
        {
            CalcFormula = lookup("Bank Account Ledger Entry".Reversed where("Document No." = field(No)));
            FieldClass = FlowField;
        }
        field(62031; "Use Graduated Charges"; Boolean)
        {
        }
        field(62032; "Agent Name"; Code[50])
        {
        }
        field(62033; "Cheque Discounted Amount"; Decimal)
        {
        }
        field(62034; "Excess Transaction Type"; Option)
        {
            OptionCaption = 'Deposits,Fosa Saving,Gold Save,Junior A/c';
            OptionMembers = Deposits,"Fosa Saving","Gold Save","Junior A/c";
        }
        field(69211; "Bulk Withdrawal Appl Done"; Boolean)
        {
        }
        field(69212; "Bulk Withdrawal Appl Date"; Date)
        {
        }
        field(69213; "Bulk Withdrawal Appl Amount"; Decimal)
        {
        }
        field(69214; "Bulk Withdrawal Fee"; Decimal)
        {
        }
        field(69215; "Bulk Withdrawal App Done By"; Code[20])
        {
        }
        field(69216; "Signing Instructions"; Option)
        {
            OptionCaption = ' ,Any to Sign,Two to Sign,Three to Sign,All to Sign,Four to Sign,Sole Signatory';
            OptionMembers = " ","Any to Sign","Two to Sign","Three to Sign","All to Sign","Four to Sign","Sole Signatory";
        }
        field(69217; "Has Signatories"; Boolean)
        {
        }
        field(69218; "Clear Cheque"; Boolean)
        {

            trigger OnValidate()
            begin
                if Confirm('Are you sure you want to clear this cheque', false) = true then begin
                    ChargeAmount := 0;

                    Trans.Reset;
                    Trans.SetRange(Trans."Cheque No", "Cheque No");
                    if Trans.FindSet then begin

                        if (Trans.Status = Trans.Status::Pending) or (Trans.Status = Trans.Status::Honoured) then begin
                            GenJournalLine.Reset;
                            GenJournalLine.SetRange("Journal Template Name", 'PURCHASES');
                            GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
                            GenJournalLine.DeleteAll;

                            //Charges
                            ChequeType.Reset;
                            ChequeType.SetRange(ChequeType.Code, Trans."Cheque Type");
                            if ChequeType.Find('-') then begin
                                if ChequeType."Use %" = true then
                                    ChargeAmount := ((ChequeType."% Of Amount" * 0.01) * Trans.Amount)
                                else
                                    ChargeAmount := ChequeType."Clearing Charges";
                                LineNo := LineNo + 10000;
                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := 'PURCHASES';
                                GenJournalLine."Journal Batch Name" := 'FTRANS';
                                GenJournalLine."Document No." := No;
                                GenJournalLine."External Document No." := "Cheque No";
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                GenJournalLine."Account No." := "Account No";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Posting Date" := Today;
                                GenJournalLine.Description := 'Cheque Clearing Charges';
                                GenJournalLine.Validate(GenJournalLine."Currency Code");
                                GenJournalLine.Amount := ChargeAmount;
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                GenJournalLine."Bal. Account No." := ChequeType."Clearing Charges GL Account";
                                GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                                GenJournalLine."Shortcut Dimension 1 Code" := 'FOSA';
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                GenJournalLine."Shortcut Dimension 2 Code" := Trans."Transacting Branch";
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;
                            end;
                            //Charges
                            GenSetup.Get();
                            ChequeDiscounting.Reset;
                            ChequeDiscounting.SetRange(ChequeDiscounting."Cheque to Discount", No);
                            ChequeDiscounting.SetRange(ChequeDiscounting."Cheque No", "Cheque No");
                            if ChequeDiscounting.FindSet then begin
                                LineNo := LineNo + 10000;
                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := 'PURCHASES';
                                GenJournalLine."Journal Batch Name" := 'FTRANS';
                                GenJournalLine."Document No." := No;
                                GenJournalLine."External Document No." := "Cheque No";
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                GenJournalLine."Account No." := "Account No";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Posting Date" := Today;
                                GenJournalLine.Description := 'Cheque Discounting Commission';
                                GenJournalLine.Validate(GenJournalLine."Currency Code");
                                GenJournalLine.Amount := ChequeDiscounting."Cheque Discounting Commission";
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                GenJournalLine."Bal. Account No." := GenSetup."Cheque Discounting Fee Account";
                                GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                                GenJournalLine."Shortcut Dimension 1 Code" := 'FOSA';
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                GenJournalLine."Shortcut Dimension 2 Code" := Trans."Transacting Branch";
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;

                                //Excise Duty
                                LineNo := LineNo + 10000;
                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := 'PURCHASES';
                                GenJournalLine."Journal Batch Name" := 'FTRANS';
                                GenJournalLine."Document No." := No;
                                GenJournalLine."External Document No." := "Cheque No";
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                GenJournalLine."Account No." := "Account No";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Posting Date" := Today;
                                GenJournalLine.Description := 'Excise Duty';
                                GenJournalLine.Validate(GenJournalLine."Currency Code");
                                GenJournalLine.Amount := ChequeDiscounting."Cheque Discounting Commission" * (GenSetup."Excise Duty(%)" / 100);
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                GenJournalLine."Bal. Account No." := GenSetup."Excise Duty Account";
                                GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                                GenJournalLine."Shortcut Dimension 1 Code" := 'FOSA';
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                GenJournalLine."Shortcut Dimension 2 Code" := Trans."Transacting Branch";
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;

                                if Account.Get(ChequeDiscounting."Account No") then begin
                                    Account."Cheque Discounted" := 0;
                                    Account."Comission On Cheque Discount" := 0;
                                end;
                            end;



                            GenJournalLine.Reset;
                            GenJournalLine.SetRange("Journal Template Name", 'PURCHASES');
                            GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
                            if GenJournalLine.Find('-') then begin
                                repeat
                                    //GLPosting.RUN(GenJournalLine);
                                    Codeunit.Run(Codeunit::"Gen. Jnl.-Post Line", GenJournalLine);
                                until GenJournalLine.Next = 0;
                            end;


                            GenJournalLine.Reset;
                            GenJournalLine.SetRange("Journal Template Name", 'PURCHASES');
                            GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
                            GenJournalLine.DeleteAll;



                            Trans."Cheque Processed" := true;
                            Trans."Date Cleared" := Today;
                            Trans.Modify;
                        end;
                    end;
                end;
            end;
        }
        field(69219; "Bounce Cheque"; Boolean)
        {

            trigger OnValidate()
            begin
                if Confirm('Are you sure you want to bounce this cheque', false) = true then begin
                    DValue.Reset;
                    DValue.SetRange(DValue."Global Dimension No.", 2);
                    DValue.SetRange(DValue.Code, '01');
                    if DValue.Find('-') then begin
                        ChBank := "Cheque Clearing Bank Code";
                    end else
                        ChBank := "Bank Account";

                    if ChequeTypes.Get("Cheque Type") then begin
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", 'PURCHASES');
                        GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
                        GenJournalLine.DeleteAll;

                        LineNo := LineNo + 10000;

                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := 'PURCHASES';
                        GenJournalLine."Journal Batch Name" := 'FTRANS';
                        GenJournalLine."Document No." := No;
                        GenJournalLine."External Document No." := "Cheque No";
                        GenJournalLine."Line No." := LineNo;
                        GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                        GenJournalLine."Account No." := "Account No";

                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Posting Date" := "Transaction Date";
                        if "Branch Transaction" = true then
                            GenJournalLine.Description := "Transaction Type" + '-' + "Branch Refference"
                        else
                            //GenJournalLine.Description:="Transaction Description" +'-'+ Description ;
                            GenJournalLine.Description := "Transaction Type" + '-' + 'Bounced';
                        //Project Accounts
                        if Acc.Get("Account No") then begin
                            if Acc."Account Category" = Acc."account category"::Project then
                                GenJournalLine.Description := "Transaction Type" + '-' + "Branch Refference"
                        end;
                        //Project Accounts
                        GenJournalLine.Validate(GenJournalLine."Currency Code");
                        GenJournalLine.Amount := Amount;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                        GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;

                        LineNo := LineNo + 10000;

                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := 'PURCHASES';
                        GenJournalLine."Journal Batch Name" := 'FTRANS';
                        GenJournalLine."Document No." := No;
                        GenJournalLine."External Document No." := "Cheque No";
                        GenJournalLine."Line No." := LineNo;
                        GenJournalLine."Account Type" := GenJournalLine."account type"::"Bank Account";
                        GenJournalLine."Account No." := "Cheque Clearing Bank Code";
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Posting Date" := "Transaction Date";
                        GenJournalLine.Description := 'Bounced_' + "Cheque No";
                        GenJournalLine.Validate(GenJournalLine."Currency Code");
                        GenJournalLine.Amount := Amount * -1;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                        GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;

                        //Post Charges
                        ChargeAmount := 0;

                        LineNo := LineNo + 10000;
                        ClearingCharge := 0;
                        if ChequeTypes."Use %" = true then begin
                            ClearingCharge := ((ChequeTypes."% Of Amount" * 0.01) * Amount);
                        end else
                            ClearingCharge := ChequeTypes."Clearing Charges";
                        //MESSAGE('ClearingCharge%1',ClearingCharge);
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := 'PURCHASES';
                        GenJournalLine."Journal Batch Name" := 'FTRANS';
                        GenJournalLine."Document No." := No;
                        GenJournalLine."Line No." := LineNo;
                        GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                        GenJournalLine."Account No." := "Account No";
                        GenJournalLine."External Document No." := "ID No";
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Posting Date" := "Transaction Date";
                        GenJournalLine.Description := 'Clearing Charges Bounced Chq';
                        GenJournalLine.Validate(GenJournalLine."Currency Code");
                        GenJournalLine.Amount := ClearingCharge * -1;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                        GenJournalLine."Bal. Account No." := ChequeTypes."Clearing Charges GL Account";
                        GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                        GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                        GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;
                        //Post Charges



                        //Excise Duty
                        GenSetup.Get(0);

                        LineNo := LineNo + 10000;
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := 'PURCHASES';
                        GenJournalLine."Journal Batch Name" := 'FTRANS';
                        GenJournalLine."Document No." := No;
                        GenJournalLine."Line No." := LineNo;
                        GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                        GenJournalLine."Account No." := "Account No";
                        GenJournalLine."External Document No." := "ID No";
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Posting Date" := "Transaction Date";
                        GenJournalLine.Description := 'Excise Duty Bounced Chq';
                        GenJournalLine.Validate(GenJournalLine."Currency Code");
                        GenJournalLine.Amount := -(ClearingCharge * GenSetup."Excise Duty(%)") / 100;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                        GenJournalLine."Bal. Account No." := GenSetup."Excise Duty Account";
                        GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                        GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                        GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;


                        //Bounced Cheque Fee
                        GenSetup.Get(0);

                        ChequeType.Reset;
                        ChequeType.SetRange(ChequeType.Code, "Cheque Type");
                        if ChequeType.Find('-') then begin
                            BChargeAmount := ChequeType."Bounced Charges";
                            BChargeAccount := ChequeType."Bounced Charges GL Account";
                        end;

                        LineNo := LineNo + 10000;
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := 'PURCHASES';
                        GenJournalLine."Journal Batch Name" := 'FTRANS';
                        GenJournalLine."Document No." := No;
                        GenJournalLine."Line No." := LineNo;
                        GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                        GenJournalLine."Account No." := "Account No";
                        GenJournalLine."External Document No." := "ID No";
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Posting Date" := "Transaction Date";
                        GenJournalLine.Description := 'Bounced Cheque Fee';
                        GenJournalLine.Validate(GenJournalLine."Currency Code");
                        GenJournalLine.Amount := BChargeAmount;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                        GenJournalLine."Bal. Account No." := BChargeAccount;
                        GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                        GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                        GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;

                        //Excise Duty on Bounced Cheque Fee
                        GenSetup.Get(0);

                        ChequeType.Reset;
                        ChequeType.SetRange(ChequeType.Code, Trans."Cheque Type");
                        if ChequeType.Find('-') then begin
                            BChargeAmount := ChequeType."Bounced Charges";
                            BChargeAccount := ChequeType."Bounced Charges GL Account";
                        end;

                        LineNo := LineNo + 10000;
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := 'PURCHASES';
                        GenJournalLine."Journal Batch Name" := 'FTRANS';
                        GenJournalLine."Document No." := No;
                        GenJournalLine."Line No." := LineNo;
                        GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                        GenJournalLine."Account No." := "Account No";
                        GenJournalLine."External Document No." := "ID No";
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Posting Date" := "Transaction Date";
                        GenJournalLine.Description := 'Excise Duty Bounced Cheque';
                        GenJournalLine.Validate(GenJournalLine."Currency Code");
                        GenJournalLine.Amount := BChargeAmount * (GenSetup."Excise Duty(%)" / 100);
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                        GenJournalLine."Bal. Account No." := GenSetup."Excise Duty Account";
                        GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                        GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                        GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;

                        //Post New
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", 'PURCHASES');
                        GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
                        if GenJournalLine.Find('-') then begin
                            Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
                        end;

                        //Post New

                    end;
                    Message('Cheque bounced successfully.');
                end;
            end;
        }
        field(69220; "Bulk Withdrawal Date"; Date)
        {
        }
        field(69221; "Excess Funds Account"; Code[20])
        {
            TableRelation = Vendor."No." where("BOSA Account No" = field("Member No"));
        }
        field(69222; "Total Amount Transacted Today"; Decimal)
        {
            CalcFormula = sum(Transactions.Amount where("Account No" = field("Account No"),
                                                         Posted = filter(true),
                                                         Type = filter('Withdrawal'),
                                                         "Transaction Date" = field("Transaction Date")));
            FieldClass = FlowField;
        }
        field(69223; "Normal Transaction Charge"; Boolean)
        {
        }
        field(69224; "Month Credits to Date"; Decimal)
        {
        }
        field(69225; "Monthly Max Credits+Tolerance"; Decimal)
        {
        }
        field(69226; Suspicious; Boolean)
        {
        }
        field(69227; "Monthly TurnOver Amount"; Decimal)
        {
        }
        field(69228; "Total Credits Transacted Today"; Decimal)
        {
            CalcFormula = sum(Transactions.Amount where("Account No" = field("Account No"),
                                                         Posted = filter(true),
                                                         "Type _Transactions" = filter("Cash Deposit"),
                                                         "Transaction Date" = field("Transaction Date")));
            FieldClass = FlowField;
        }
        field(69229; "Total Debits Transacted Today"; Decimal)
        {
            CalcFormula = sum(Transactions.Amount where("Account No" = field("Account No"),
                                                         Posted = filter(true),
                                                         "Type _Transactions" = filter(Withdrawal),
                                                         "Transaction Date" = field("Transaction Date")));
            FieldClass = FlowField;
        }
        field(69230; "Transaction to Be Declared"; Boolean)
        {
        }
        field(69231; "Transaction Declaration"; Text[60])
        {
        }
        field(69232; "Type _Transactions"; Option)
        {
            OptionCaption = 'Cash Deposit,Withdrawal,Cheque Deposit,ATM Cash Deposit,ATM Cheque Deposit,ATM Withdrawal,Batch Deposit,BOSA Withdrawal,Bankers Cheque,Encashment,Transfer,Inhouse Cheque Withdrawal,Deposit Slip,Cheque Withdrawal,ABC Deposit';
            OptionMembers = "Cash Deposit",Withdrawal,"Cheque Deposit","ATM Cash Deposit","ATM Cheque Deposit","ATM Withdrawal","Batch Deposit","BOSA Withdrawal","Bankers Cheque",Encashment,Transfer,"Inhouse Cheque Withdrawal","Deposit Slip","Cheque Withdrawal","ABC Deposit";
        }
        field(69233; "Overdraft Expiry Date"; Date)
        {
            Editable = false;
        }
        field(69234; "Overdraft Balance"; Decimal)
        {
            Editable = false;
        }
        field(69235; "Evidence Obtained"; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; No, "Member No")
        {
            Clustered = true;
        }
        key(Key2; "Transfer No")
        {
            SumIndexFields = Amount;
        }
        key(Key3; Type, "Transaction Date", Posted, "Transaction Category")
        {
            SumIndexFields = Amount;
        }
        key(Key4; "Account No", "Cheque Processed", Deposited, "Transaction Category")
        {
            SumIndexFields = Amount;
        }
        key(Key5; Deposited, Posted, "Transaction Category", "Transaction Date", "Has Schedule")
        {
            SumIndexFields = Amount;
        }
        key(Key6; Requested, "Transaction Category", "Transaction Date")
        {
            SumIndexFields = Amount;
        }
        key(Key7; "Account No", "Cheque Processed", Posted, Type)
        {
            SumIndexFields = Amount;
        }
        key(Key8; "Cheque No")
        {
        }
        key(Key9; "Transaction Type", "Transaction Date", Posted)
        {
            SumIndexFields = Amount;
        }
        key(Key10; "Bankers Cheque No")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; No, "Account No", "Account Name", Type, "Cheque No", "Expected Maturity Date")
        {
        }
    }

    trigger OnDelete()
    begin
        /*IF Posted = TRUE THEN
        ERROR('The transaction has been posted and therefore cannot be deleted.');
        */

    end;

    trigger OnInsert()
    begin

        if No = '' then begin
            NoSetup.Get();
            NoSetup.TestField(NoSetup."Transaction Nos.");
            NoSeriesMgt.InitSeries(NoSetup."Transaction Nos.", xRec."No. Series", 0D, No, "No. Series");
        end;

        Cashier := UserId;
        "Transaction Date" := Today;
        "Document Date" := Today;
        "Transaction Time" := Time;
        Status := Status::Pending;
        "Needs Approval" := "needs approval"::Yes;
        "Frequency Needs Approval" := "frequency needs approval"::Yes;

        Validate("Transaction Mode New");
    end;

    trigger OnRename()
    begin
        if Type <> 'Cheque Deposit' then begin
            if Posted then begin
                Error('The transaction has been posted and therefore cannot be modified.');
            end;
        end;

        if Deposited then begin
            Error('The cheque has already been deposited and therefore cannot be modified.');
        end;
    end;

    var
        NoSetup: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Account: Record Vendor;
        AccountTypes: Record "Account Types-Saving Products";
        ChequeTypes: Record "Cheque Types";
        Banks: Record "Bank Account";
        BankBranches: Record "Bank Branch";
        PaymentMethod: Record "Payment Method";
        TransactionTypes: Record "Transaction Types";
        Denominations: Record Denominations;
        Cust: Record Customer;
        i: Integer;
        PublicHoliday: Integer;
        weekday: Integer;
        CDays: Integer;
        BanksList: Record Banks;
        GLAcc: Record "G/L Account";
        Vend: Record Vendor;
        BankAcc: Record "Bank Account";
        FA: Record "Fixed Asset";
        GenLedgerSetup: Record "General Ledger Setup";
        TransactionCharges: Record "Transaction Charges";
        VarAmtHolder: Decimal;
        DimValue: Record "Dimension Value";
        EMaturity: Date;
        BRegister: Record "Banker Cheque Register";
        Acc: Record Vendor;
        UsersID: Record User;
        Trans: Record Transactions;
        VendLedg: Record "Vendor Ledger Entry";
        ATMApp: Record "ATM Card Applications";
        CustM: Record Vendor;
        LoansRec: Record "Loans Register";
        AgentDetails: Record "Account Agent Details";
        TransType: Record "Transaction Types";
        ObjSignatories: Record "FOSA Account Sign. Details";
        ChargeAmount: Decimal;
        GenJournalLine: Record "Gen. Journal Line";
        ChequeType: Record "Cheque Types";
        LineNo: Integer;
        GenSetup: Record "Sacco General Set-Up";
        ChequeDiscounting: Record "Cheque Discounting";
        DValue: Record "Dimension Value";
        ChBank: Code[20];
        DActivity: Code[20];
        DBranch: Code[20];
        ClearingCharge: Decimal;
        BChargeAmount: Decimal;
        BChargeAccount: Code[20];
        ObjAccount: Record Vendor;
        ObjCust: Record Customer;
        VarMonthlyTurnOver: Decimal;
        SFactory: Codeunit "SURESTEP Factory";
        ObjAuditGeneralSetup: Record "Audit General Setup";
        ObjAuditSuspiciousTrans: Record "Audit Suspicious Transactions";
        ObjAccounts: Record Vendor;
        AvailableBal: Decimal;
        ObjAccTypes: Record "Account Types-Saving Products";
        ObjBank: Record "Bank Account";
        ObjGraduatedCharge: Record "CWithdrawal Graduated Charges";
        EmailRecepient: Text;
        EmailRecepientName: Text;
        SMTPSetup: Record "SMTP Mail Setup";
        SurestepFactory: Codeunit "SURESTEP Factory";
        VarEmailSubject: Text;
        VarEmailBody: Text;

    local procedure FnRunGetSuspiciousCredits()
    begin
    end;


    procedure FnRunEmailSuspiciousTransaction()
    begin
        SMTPSetup.Get;
        ObjAuditGeneralSetup.Get;

        EmailRecepient := ObjAuditGeneralSetup."Notification Group Email";
        EmailRecepientName := SurestepFactory.FnConvertTexttoBeginingWordstostartWithCapital('Team');

        VarEmailSubject := 'Suspicious Transaction Notification - ' + "Account No";
        VarEmailBody := 'Member ' + "Member No" + ' - ' + "Member Name" + ' has performed Cash Deposit of Ksh. ' + Format(Amount) +
        ' on Account No. ' + "Account No" + ' that would bring their current month cumulative credits to Ksh. ' + Format("Month Credits to Date" + Amount) +
        ' which would exceed their current Monthly Turnover of Ksh. ' + Format("Monthly Max Credits+Tolerance");

        SurestepFactory.FnSendStatementViaMail(EmailRecepientName, VarEmailSubject, VarEmailBody, EmailRecepient, '', '');


    end;
}

