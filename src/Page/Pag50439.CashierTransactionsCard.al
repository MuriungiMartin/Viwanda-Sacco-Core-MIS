#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50439 "Cashier Transactions Card"
{
    DeleteAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = Transactions;
    SourceTableView = where(Posted = const(false));

    layout
    {
        area(content)
        {
            group(Transactions)
            {
                Caption = 'Transactions';
                field(No; No)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Member No"; "Member No")
                {
                    ApplicationArea = Basic;
                }
                field("Member Name"; "Member Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Account No"; "Account No")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        if Posted = true then
                            Error('You cannot modify an already posted record.');

                        CalcAvailableBal;

                        Clear(AccP.Image);
                        Clear(AccP.Signature);
                        if AccP.Get("Account No") then begin
                            /*//Hide Accounts
                            IF AccP.Hide = TRUE THEN BEGIN
                            IF UsersID.GET(USERID) THEN BEGIN
                            IF UsersID."Show Hiden" = FALSE THEN
                            ERROR('You do not have permission to transact on this account.');
                            END;
                            END; */
                            //Hide Accounts
                            //AccP.CALCFIELDS(AccP.Picture,AccP.Signature);
                        end;

                        CalcFields("Uncleared Cheques");
                        if AccP.Get("Account No") then begin
                            // Picture:=AccP.Picture;
                            Signature := AccP.Signature;

                        end;

                        FnShowFields();

                        VarshowSignatories := false;
                        VarShowAgents := false;

                        ObjAccountSignatories.Reset;
                        ObjAccountSignatories.SetRange(ObjAccountSignatories."Account No", "Account No");
                        if ObjAccountSignatories.Find('-') = true then begin
                            VarshowSignatories := true;
                        end;

                        ObjAccountAgent.Reset;
                        ObjAccountAgent.SetRange(ObjAccountAgent."Account No", "Account No");
                        if ObjAccountAgent.FindSet then begin
                            VarShowAgents := true;
                        end;

                    end;
                }
                field("Has Signatories"; "Has Signatories")
                {
                    ApplicationArea = Basic;
                    Importance = Additional;
                }
                field("Signing Instructions"; "Signing Instructions")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Has Special Mandate"; "Has Special Mandate")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Additional;
                    Visible = HasSpecialMandateVisible;
                }
                field("Transacting Agent"; "Transacting Agent")
                {
                    ApplicationArea = Basic;
                    Visible = TransactingAgentVisible;
                }
                field("Agent Name"; "Agent Name")
                {
                    ApplicationArea = Basic;
                    Caption = 'Transacting Agent Name';
                    Editable = false;
                    Visible = TransactingAgentNameVisible;
                }
                field("Transaction Type"; "Transaction Type")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        if Posted = true then
                            Error('You cannot modify an already posted record.');

                        FChequeVisible := false;
                        BChequeVisible := false;
                        BReceiptVisible := false;
                        BOSAReceiptChequeVisible := false;
                        "Branch RefferenceVisible" := false;
                        LRefVisible := false;
                        ChequeTransfVisible := false;
                        ChequeWithdrawalVisible := false;
                        DepositSlipVisible := false;
                        ChequeWithOll := false;



                        if TransactionTypes.Get("Transaction Type") then begin
                            if TransactionTypes.Type = TransactionTypes.Type::"Cheque Deposit" then begin
                                FChequeVisible := true;
                                Type := 'Cheque Deposit';
                                Modify();
                                if ("Account No" = '502-00-000300-00') or ("Account No" = '502-00-000303-00') then
                                    BOSAReceiptChequeVisible := true;
                            end;
                            if TransactionTypes.Type = TransactionTypes.Type::"Bankers Cheque" then begin
                                BChequeVisible := true;
                                Type := 'Bankers Cheque';
                                Modify();
                            end;

                            if ("Transaction Type" = 'RECEIPT') or ("Transaction Type" = 'FOSALOAN') then begin
                                BReceiptVisible := true;
                                Type := 'BOSA Receipt';
                                Modify();
                            end;

                            TellerTill.Reset;
                            TellerTill.SetRange(TellerTill."Account Type", TellerTill."account type"::Cashier);
                            TellerTill.SetRange(TellerTill.CashierID, UserId);
                            if TellerTill.Find('-') then begin
                                "Bank Account" := TellerTill."No.";
                            end;

                            if TransactionTypes.Type = TransactionTypes.Type::Transfer then begin
                                ChequeTransfVisible := true;
                                Type := 'Transfer';
                                Modify();
                            end;

                            if TransactionTypes.Type = TransactionTypes.Type::"Inhouse Cheque Withdrawal" then begin
                                ChequeWithdrawalVisible := true;
                                Type := 'Withdrawal';
                                Modify();
                            end;

                            if TransactionTypes.Type = TransactionTypes.Type::"Cheque Withdrawal" then begin
                                ChequeWithOll := true;
                                Type := 'Cheque Withdrawal';
                                Modify();
                            end;

                            if TransactionTypes.Type = TransactionTypes.Type::"Deposit Slip" then begin
                                DepositSlipVisible := true;
                                Type := 'Deposit Slip';
                                Modify();
                            end;

                            if TransactionTypes.Type = TransactionTypes.Type::Encashment then begin
                                BReceiptVisible := true;
                                Type := 'Encashment';
                            end;



                        end;

                        if "Branch Transaction" = true then begin
                            "Branch RefferenceVisible" := true;
                            LRefVisible := true;
                        end;

                        if Acc.Get("Account No") then begin
                            if Acc."Account Category" = Acc."account category"::Project then begin
                                "Branch RefferenceVisible" := true;
                                LRefVisible := true;
                            end;
                        end;
                        FnShowFields();

                        CalcAvailableBal;

                        ExcessFOSAAccountVisible := false;
                        if ("Excess Transaction Type" = "excess transaction type"::"Fosa Saving") or ("Excess Transaction Type" = "excess transaction type"::"Junior A/c") then begin
                            ExcessFOSAAccountVisible := true;
                        end;
                    end;
                }
                field(Type; Type)
                {
                    Visible = true;
                }
                field(Amount; Amount)
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        if ObjAccountType.Get("Account Type") then begin
                            if (Amount >= ObjAccountType."Bulk Withdrawal Amount") and (Type = 'Withdrawal') then begin
                                BulkWithVisible := true;
                            end;
                        end;
                    end;
                }
                field("Transaction Mode New"; "Transaction Mode New")
                {
                    ApplicationArea = Basic;
                    Caption = 'Transaction Mode';
                }
                field(Description; Description)
                {
                    ApplicationArea = Basic;
                }
                group(ODDetails)
                {
                    Visible = ODDetailsVisible;
                    field("Overdraft Limit"; "Overdraft Limit")
                    {
                        ApplicationArea = Basic;
                    }
                    field("Overdraft Expiry Date"; "Overdraft Expiry Date")
                    {
                        ApplicationArea = Basic;
                    }
                    field("Overdraft Balance"; "Overdraft Balance")
                    {
                        ApplicationArea = Basic;
                    }
                }
                group(DepositSlip)
                {
                    Visible = DepositSlipVisible;
                    field("Receipt Bank."; "Bank Account")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Receipt Bank';
                    }
                    field("Document Date"; "Document Date")
                    {
                        ApplicationArea = Basic;
                    }
                }
                group(BCheque)
                {
                    Caption = '.';
                    Visible = BChequeVisible;
                    field("Bankers Cheque No"; "Bankers Cheque No")
                    {
                        ApplicationArea = Basic;
                    }
                    field(Payee; Payee)
                    {
                        ApplicationArea = Basic;
                    }
                    field("Post Dated"; "Post Dated")
                    {
                        ApplicationArea = Basic;

                        trigger OnValidate()
                        begin
                            "Transaction DateEditable" := false;
                            if "Post Dated" = true then
                                "Transaction DateEditable" := true
                            else
                                "Transaction Date" := Today;
                        end;
                    }
                    field("Cheque Clearing Bank Code"; "Cheque Clearing Bank Code")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Cheque Clearing Bank_ Code';
                    }
                    field("Cheque Clearing Bank"; "Cheque Clearing Bank")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Cheque Clearing_Bank';
                        Editable = false;
                    }
                }
                group(ChequeWith)
                {
                    Caption = '.';
                    Visible = ChequeWithOll;
                    field("Cheque NoChq"; "Bankers Cheque No")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Cheque No';
                    }
                    field("CheqWith Payee"; Payee)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Payee';
                    }
                    field("ChequeWith Post Dated"; "Post Dated")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Post Dated';

                        trigger OnValidate()
                        begin
                            "Transaction DateEditable" := false;
                            if "Post Dated" = true then
                                "Transaction DateEditable" := true
                            else
                                "Transaction Date" := Today;
                        end;
                    }
                    field("Cheque Clearing Bank Code Cheq"; "Cheque Clearing Bank Code")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Cheque Clearing Bank Code';
                    }
                    field("Cheque Clearing Bank Cheq"; "Cheque Clearing Bank")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Cheque Clearing Bank';
                        Editable = false;
                    }
                }
                group(BReceipt)
                {
                    Caption = '.';
                    Visible = BReceiptVisible;
                    field("BOSA Account No"; "BOSA Account No")
                    {
                        ApplicationArea = Basic;
                        Visible = false;
                    }
                    field("Allocated Amount"; "Allocated Amount")
                    {
                        ApplicationArea = Basic;
                    }
                    field("Receipt Bank"; "Bank Account")
                    {
                        ApplicationArea = Basic;
                    }
                    field("<Document Date.>"; "Document Date")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Document Date';
                        Editable = false;
                    }
                    field("Excess Transaction Type"; "Excess Transaction Type")
                    {
                        ApplicationArea = Basic;
                    }
                    group("Excess FOSA Account")
                    {
                        Caption = 'Excess FOSA Account';
                        Visible = ExcessFOSAAccountVisible;
                        field("Excess Funds Account"; "Excess Funds Account")
                        {
                            ApplicationArea = Basic;
                        }
                    }
                }
                group(FCheque)
                {
                    Caption = '.';
                    Visible = FChequeVisible;
                    field("Cheque Type"; "Cheque Type")
                    {
                        ApplicationArea = Basic;
                    }
                    field("Cheque No"; "Cheque No")
                    {
                        ApplicationArea = Basic;

                        trigger OnValidate()
                        begin
                            if StrLen("Cheque No") <> 6 then
                                Error('Cheque No. cannot contain More or less than 6 Characters.');
                        end;
                    }
                    field("Bank Code"; "Bank Code")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Cheque Source Bank';
                    }
                    field("<Cheque Clearing Bank_Code>"; "Cheque Clearing Bank Code")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Cheque Clearing Bank Code>';
                    }
                    field("<Cheque_Clearing Bank>"; "Cheque Clearing Bank")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Cheque Clearing Bank';
                        Editable = false;
                    }
                    field("Expected Maturity Date"; "Expected Maturity Date")
                    {
                        ApplicationArea = Basic;
                        Editable = false;
                    }
                    field(Status; Status)
                    {
                        ApplicationArea = Basic;
                        Editable = false;
                    }
                    field("50048"; "Banking Posted")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Banked';
                        Editable = false;
                    }
                    field("Bank Account"; "Bank Account")
                    {
                        ApplicationArea = Basic;
                        Visible = false;
                    }
                    field("Cheque Date"; "Cheque Date")
                    {
                        ApplicationArea = Basic;
                    }
                    field("Cheque Deposit Remarks"; "Cheque Deposit Remarks")
                    {
                        ApplicationArea = Basic;
                    }
                }
                group(ChequeWithdrawal)
                {
                    Caption = '.';
                    Visible = ChequeWithdrawalVisible;
                    field("Cheque TypeWith"; "Cheque Type")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Cheque Type';
                    }
                    field("Drawer's Account No."; "Drawer's Account No")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Drawer''s Account No.';
                    }
                    field("Drawer's NameWith"; "Drawer's Name")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Drawer''s Name';
                        Editable = false;
                    }
                    field("Drawers Cheque No.With"; "Drawers Cheque No.")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Drawers Cheque No.';
                    }
                    field("Cheque DateWith"; "Cheque Date")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Cheque Date';
                    }
                    field("Cheque Deposit RemarksWith"; "Cheque Deposit Remarks")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Cheque Deposit Remarks';
                    }
                    field("Cheque Clearing Bank Code.With"; "Cheque Clearing Bank Code")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Cheque Clearing Bank Code.';
                    }
                }
                group(ChequeTransf)
                {
                    Caption = '.';
                    Visible = ChequeTransfVisible;
                    field("Cheque TypeTR"; "Cheque Type")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Cheque Type';
                    }
                    field("Drawer's Account No"; "Drawer's Account No")
                    {
                        ApplicationArea = Basic;
                    }
                    field("Drawer's Name"; "Drawer's Name")
                    {
                        ApplicationArea = Basic;
                        Editable = false;
                    }
                    field("Drawers Cheque No."; "Drawers Cheque No.")
                    {
                        ApplicationArea = Basic;
                    }
                    field("Cheque DateTR"; "Cheque Date")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Cheque Date';
                    }
                    field("Cheque Deposit RemarksTR"; "Cheque Deposit Remarks")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Cheque Deposit Remarks';
                    }
                    field("<Cheque Clearing Bank Code.>"; "Cheque Clearing Bank Code")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Cheque Clearing Bank Code.';
                    }
                }
            }
            group("Bulk Withdrawal Details")
            {
                Caption = 'Bulk Withdrawal Details';
                Visible = BulkWithVisible;
                field("Bulk Withdrawal Appl Done"; "Bulk Withdrawal Appl Done")
                {
                    ApplicationArea = Basic;
                    Caption = 'Bulk Withdrawal Application Done';
                    Editable = false;
                }
                field("Bulk Withdrawal Appl Date"; "Bulk Withdrawal Appl Date")
                {
                    ApplicationArea = Basic;
                    Caption = 'Bulk Withdrawal Application Date';
                    Editable = false;
                }
                field("Bulk Withdrawal Appl Amount"; "Bulk Withdrawal Appl Amount")
                {
                    ApplicationArea = Basic;
                    Caption = 'Bulk Withdrawal Application Amount';
                    Editable = false;
                }
                field("Bulk Withdrawal Date"; "Bulk Withdrawal Date")
                {
                    ApplicationArea = Basic;
                    Caption = 'Bulk Withdrawal Date';
                    Editable = false;
                }
                field("Bulk Withdrawal Fee"; "Bulk Withdrawal Fee")
                {
                    ApplicationArea = Basic;
                    Caption = 'Bulk Withdrawal Fee Charged';
                    Editable = false;
                }
                field("Bulk Withdrawal App Done By"; "Bulk Withdrawal App Done By")
                {
                    ApplicationArea = Basic;
                    Caption = 'Bulk Withdrawal Application Done By';
                    Editable = false;
                }
                field("Total Amount Transacted Today"; "Total Amount Transacted Today")
                {
                    ApplicationArea = Basic;
                    Caption = 'Total Amount Withdrawned Today';
                    Editable = false;
                }
                group(BOSAReceiptCheque)
                {
                    Caption = '.';
                    Visible = BOSAReceiptChequeVisible;
                }
                field("Account Name"; "Account Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Additional;
                }
                field("Transaction Description"; "Transaction Description")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                    Importance = Additional;
                }
                field("Book Balance"; "Book Balance")
                {
                    ApplicationArea = Basic;
                }
                field("Uncleared Cheques"; "Uncleared Cheques")
                {
                    ApplicationArea = Basic;
                }
                field(AvailableBalance; AvailableBalance)
                {
                    ApplicationArea = Basic;
                    Caption = 'Available Balance';
                    Editable = false;
                }
                field("N.A.H Balance"; "N.A.H Balance")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Additional;
                    Visible = false;
                }
                field("ID No"; "ID No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Additional;
                }
                field(Cashier; Cashier)
                {
                    ApplicationArea = Basic;
                    Importance = Additional;
                }
                field("Transaction Date"; "Transaction Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Additional;
                }
                field("Transaction Time"; "Transaction Time")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Additional;
                }
                field(Authorised; Authorised)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Posted; Posted)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Additional;
                }
                field(Picture; Picture)
                {
                    ApplicationArea = Basic;
                }
            }
            part("Receipt Allocation"; "Receipt Allocation-BOSA")
            {
                SubPageLink = "Document No" = field(No);
                Visible = ReceiptAllVisible;
            }
            // part(AccountAgents; "Account Agent List")
            // {
            //     Caption = 'Account Agents';
            //     SubPageLink = "Account No" = field("Account No");
            //     Visible = VarShowAgents;
            // }
            // part(AccountSignatories; "Account Signatories Details")
            // {
            //     Caption = 'Account Signatories';
            //     SubPageLink = "Account No" = field("Account No");
            //     Visible = VarshowSignatories;
            // }
        }
        area(factboxes)
        {
            part(Control8; "Vendor Picture-Uploaded")
            {
                Editable = false;
                Enabled = false;
                SubPageLink = "No." = field("Account No");
            }
            part(Control7; "Vendor Signature-Uploaded")
            {
                Editable = false;
                Enabled = false;
                SubPageLink = "No." = field("Account No");
            }
            part(Control1000000000; "FOSA Statistics FactBox")
            {
                SubPageLink = "No." = field("Account No");
            }
            part(Control1000000018; "Member Statistics FactBox")
            {
                SubPageLink = "No." = field("Member No");
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Transaction)
            {
                Caption = 'Transaction';
                action("Account Card")
                {
                    ApplicationArea = Basic;
                    Caption = 'Account Card';
                    Image = Vendor;
                    Promoted = true;
                    RunObject = Page "Member Account Card View";
                    RunPageLink = "No." = field("Account No");
                }
                separator(Action1102760031)
                {
                }
                action("Account Signatories")
                {
                    ApplicationArea = Basic;
                    Caption = 'Signatories Details';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Member Account Signatory list";
                    RunPageLink = "Account No" = field("Member No");
                }
            }
            action("Account Agent Details")
            {
                ApplicationArea = Basic;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Account Agent List";
                RunPageLink = "Account No" = field("Account No");
            }
            action("Members Statistics")
            {
                ApplicationArea = Basic;
                Image = Statistics;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Members Statistics";
                RunPageLink = "No." = field("Member No");
            }
            action("Account Statement")
            {
                ApplicationArea = Basic;
                Promoted = true;
                PromotedCategory = "Report";

                trigger OnAction()
                begin

                    Vend.Reset;
                    Vend.SetRange(Vend."No.", "Account No");
                    if Vend.Find('-') then
                        Report.Run(50890, true, false, Vend)
                end;
            }
            action("Suggest Payments")
            {
                ApplicationArea = Basic;
                Caption = 'Suggest Monthy Repayments';
                Image = Suggest;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    TestField(Posted, false);
                    //TESTFIELD("Account No.");
                    TestField(Amount);
                    // ,Registration Fee,Share Capital,Interest Paid,Loan Repayment,Deposit Contribution,Insurance Contribution,Benevolent Fund,Loan,Unallocated Funds,Dividend,FOSA Account

                    ObjTransactions.Reset;
                    ObjTransactions.SetRange(ObjTransactions."Document No", Rec.No);
                    if ObjTransactions.Find('-') then
                        ObjTransactions.DeleteAll;
                    Datefilter := '..' + Format("Transaction Date");
                    RunBal := 0;
                    RunBal := Amount;
                    RunBal := FnRunEntranceFee(Rec, RunBal);
                    RunBal := FnRunShareCapital(Rec, RunBal);
                    RunBal := FnRunInsurance(Rec, RunBal);
                    RunBal := FnRunInterest(Rec, RunBal);
                    RunBal := FnRunLoanInsurance(Rec, RunBal);
                    RunBal := FnRunPrinciple(Rec, RunBal);
                    RunBal := FnRunDepositContribution(Rec, RunBal);
                    //RunBal:=FnRunInsuranceContribution(Rec,RunBal);
                    //RunBal:=FnRunBenevolentFund(Rec,RunBal);
                    if RunBal > 0 then begin
                        if Confirm('Excess Money will allocated to ' + Format("Excess Transaction Type") + '.Do you want to Continue?', true) = false then
                            exit;
                        case "Excess Transaction Type" of
                            "excess transaction type"::Deposits:
                                FnRunDepositContributionFromExcess(Rec, RunBal);
                            "excess transaction type"::"Fosa Saving":
                                FnRunSavingsProductExcess(Rec, RunBal, 'SAVINGS');
                            "excess transaction type"::"Gold Save":
                                FnRunSavingsProductExcess(Rec, RunBal, 'GOLDSAVE');
                            "excess transaction type"::"Junior A/c":
                                FnRunSavingsProductExcess(Rec, RunBal, 'NFK-JUNIOR');
                        end;
                        //RunBal:=FnRunUnallocatedAmount(Rec,RunBal);
                    end;

                    CalcFields("Allocated Amount");
                    //"Un allocated Amount":=(Amount-"Allocated Amount");
                    Modify;
                end;
            }
        }
        area(processing)
        {
            action(Post)
            {
                ApplicationArea = Basic;
                Caption = 'Post (F11)';
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                ShortCutKey = 'F11';

                trigger OnAction()
                begin
                    //Check if Posted
                    Message('Checking if posted......');
                    BankLedger.Reset;
                    BankLedger.SetRange(BankLedger."Document No.", No);
                    if BankLedger.Find('-') then begin
                        Posted := true;
                        Modify;
                        Message('Transaction is aready posted');
                        CurrPage.Close;
                        exit;
                    end;
                    Message('Checking if posted ended.');

                    //Auto Update the Excess Amount on Receipt--------------------------------------------
                    CalcFields("Allocated Amount");
                    if (Amount > "Allocated Amount") and (Type = 'RECEIPT') then begin
                        if Confirm('Excess Amount will be Allocated to the ' + Format("Excess Transaction Type") + ' Account', false) = true then begin
                            ObjReceiptAllocation.Init;
                            ObjReceiptAllocation."Document No" := No;
                            ObjReceiptAllocation."Member No" := "Member No";
                            ObjReceiptAllocation.Amount := (Amount - "Allocated Amount");
                            if "Excess Transaction Type" = "excess transaction type"::Deposits then begin
                                ObjReceiptAllocation."Transaction Type" := ObjReceiptAllocation."transaction type"::"Deposit Contribution";
                                ObjReceiptAllocation."Account Type" := ObjReceiptAllocation."account type"::Member;
                                ObjReceiptAllocation.Validate(ObjReceiptAllocation."Transaction Type")
                            end else
                                if ("Excess Transaction Type" = "excess transaction type"::"Fosa Saving") or ("Excess Transaction Type" = "excess transaction type"::"Junior A/c") then begin
                                    ObjReceiptAllocation."Transaction Type" := ObjReceiptAllocation."transaction type"::"FOSA Account";
                                    ObjReceiptAllocation."Account No" := "Excess Funds Account";
                                    ObjReceiptAllocation."Account Type" := ObjReceiptAllocation."account type"::Vendor;
                                    ObjReceiptAllocation.Insert;
                                end;
                        end;
                    end;

                    //End Auto Update the Excess Amount on Receipt--------------------------------------------






                    //Ensure Min Share Capital Is Contributed
                    BosaSetUp.Get();
                    TransactionTypes.Reset();
                    TransactionTypes.SetRange(TransactionTypes.Code, "Transaction Type");
                    if TransactionTypes.Find('-') then begin
                        VarTransactionType := TransactionTypes.Type;
                    end;
                    if Type = 'BOSA Receipt' then begin
                        if Cust.Get("Member No") then begin
                            Cust.CalcFields(Cust."Registration Fee Paid", Cust."Shares Retained");
                            if Cust."Shares Retained" < BosaSetUp."Retained Shares" then begin


                                ReceiptAllocations.Reset;
                                ReceiptAllocations.SetRange(ReceiptAllocations."Document No", No);
                                ReceiptAllocations.SetRange(ReceiptAllocations."Transaction Type", ReceiptAllocations."transaction type"::"Deposit Contribution");
                                if not ReceiptAllocations.Find('-') then
                                    Message('The Member Must first Contribute Min. Share Capital Amount');

                                ReceiptAllocations.Reset;
                                ReceiptAllocations.SetRange(ReceiptAllocations."Document No", No);
                                //ReceiptAllocations.SETRANGE(ReceiptAllocations."Transaction Type",ReceiptAllocations."Transaction Type"::"Shares Capital");
                                if ReceiptAllocations.Find('-') then begin
                                    //IF ReceiptAllocations."Transaction Type"=ReceiptAllocations."Transaction Type"::"Shares Capital" THEN BEGIN
                                    if ReceiptAllocations.Count > 1 then
                                        if ReceiptAllocations.Amount < (BosaSetUp."Retained Shares" - Cust."Shares Retained") then
                                            Message('The Member Must first Contribute Min. Share Capital Amount');


                                end;
                            end;
                        end;
                    end;




                    if Cashier <> UpperCase(UserId) then
                        Error('Cannot post a Transaction being processed by %1', Cashier);

                    BankLedger.Reset;
                    BankLedger.SetRange(BankLedger."Posting Date", Today);
                    BankLedger.SetRange(BankLedger."User ID", "Posted By");
                    BankLedger.SetRange(BankLedger.Description, 'END OF DAY RETURN TO TREASURY');
                    if BankLedger.Find('-') = true then begin
                        Error('You cannot post any transactions after perfoming end of day');
                    end;




                    UsersID.Reset;
                    UsersID.SetRange(UsersID."User Name", UpperCase(UserId));
                    if UsersID.Find('-') then begin
                        // DBranch := UsersID."Branch Code";
                        DActivity := 'FOSA';
                        //MESSAGE('%1,%2',Branch,Activity);
                    end;


                    if "Transaction Date" <> Today then begin
                        "Transaction Date" := Today;
                        Modify;
                    end;



                    if Posted = true then
                        Error('The transaction has already been posted.');

                    VarAmtHolder := 0;

                    if Amount <= 0 then
                        Error('Please specify an amount greater than zero.');

                    if "Transaction Type" = '' then
                        Error('Please select the transaction type.');

                    //BOSA Entries
                    if ("Account No" = '502-00-000300-00') or ("Account No" = '502-00-000303-00') then begin
                        TestField("BOSA Account No");
                        if Amount <> "Allocated Amount" then
                            Error('Allocated amount must be equall to the transaction amount.');

                    end;


                    "Post Attempted" := true;
                    Modify;

                    if VarTransactionType = VarTransactionType::"Cheque Deposit" then begin
                        TestField("Cheque Type");
                        TestField("Cheque No");
                        TestField("Cheque Date");
                        TestField("Bank Code");

                        PostChequeDep;

                        exit;
                    end;

                    if VarTransactionType = VarTransactionType::Transfer then begin
                        TestField("Drawers Cheque No.");
                        TestField("Drawer's Account No");

                        PostTransfer;

                        exit;
                    end;

                    if VarTransactionType = VarTransactionType::"Bankers Cheque" then begin

                        PostBankersChequeVer1;

                        exit;
                    end;

                    if (VarTransactionType = VarTransactionType::Encashment) or (VarTransactionType = VarTransactionType::"Inhouse Cheque Withdrawal") then begin
                        PostEncashment;

                        exit;
                    end;
                    if VarTransactionType = VarTransactionType::"Deposit Slip" then begin
                        PostDepSlipDep;
                    end;


                    if Type = 'BOSA Receipt' then begin
                        PostBOSAEntries;
                        exit;
                    end;

                    if VarTransactionType = VarTransactionType::Transfer then begin
                        PostTransfer;
                    end;

                    if (VarTransactionType = VarTransactionType::Withdrawal) or (VarTransactionType = VarTransactionType::"Cash Deposit") then begin
                        //ADDED
                        PostCashDepWith;
                    end;

                    if VarTransactionType = VarTransactionType::"Cheque Withdrawal" then begin
                        PostChequeWith
                    end;

                    exit;
                    //ADDED
                end;
            }
            action("Freeze Account")
            {
                ApplicationArea = Basic;
                Image = "Action";
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                begin
                    if Confirm('Are you Sure you want to Freeze this Account?', false) = true then begin
                        TestField("Reason For Freezing Account");
                        if Account.Get("Account No") then begin
                            Account.Status := Account.Status::Closed;
                            Account.Blocked := Account.Blocked::All;
                            Account."Reason for Freezing Account" := "Reason For Freezing Account";
                            Account."Account Frozen By" := UserId;
                            Account.Modify;
                        end;
                    end;
                    Message('Account Frozen Succesfully');
                end;
            }
            action(SendMail)
            {
                ApplicationArea = Basic;
                Caption = 'SendMail';
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                begin
                    MailContent := 'Bankers cheque transaction' + ' ' + 'of Kshs' + ' ' + Format(Amount) + ' ' + 'for'
                    + ' ' + "Account Name" + ' ' + 'needs your approval';


                    SendEmail;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin

        SetRange(Cashier, UserId);
        FChequeVisible := false;
        BChequeVisible := false;
        BReceiptVisible := false;
        BOSAReceiptChequeVisible := false;
        ChequeTransfVisible := false;
        TransactionTypes.Reset();
        TransactionTypes.SetRange(TransactionTypes.Code, "Transaction Type");
        if TransactionTypes.Find('-') then begin
            VarTransactionType := TransactionTypes.Type;
        end;
        if (VarTransactionType = VarTransactionType::"Cash Deposit") or (VarTransactionType = VarTransactionType::"Cheque Withdrawal") then begin
            FChequeVisible := true;
            if ("Account No" = '502-00-000300-00') or ("Account No" = '502-00-000303-00') then
                BOSAReceiptChequeVisible := true;

        end;

        "Branch RefferenceVisible" := false;
        LRefVisible := false;


        if VarTransactionType = VarTransactionType::"Bankers Cheque" then
            BChequeVisible := true;

        if VarTransactionType = VarTransactionType::Encashment then
            BReceiptVisible := true;


        if ("Transaction Type" = 'RECEIPT') or ("Transaction Type" = 'FOSALN') then
            BReceiptVisible := true;

        if VarTransactionType = VarTransactionType::Transfer then
            ChequeTransfVisible := true;

        if "Branch Transaction" = true then begin
            "Branch RefferenceVisible" := true;
            LRefVisible := true;
        end;

        if Acc.Get("Account No") then begin
            if Acc."Account Category" = Acc."account category"::Project then begin
                "Branch RefferenceVisible" := true;
                LRefVisible := true;
            end;
        end;


        "Transaction DateEditable" := false;
        if "Post Dated" = true then
            "Transaction DateEditable" := true;

        if ObjAccountType.Get("Account Type") then begin
            if (Amount >= ObjAccountType."Bulk Withdrawal Amount") and (VarTransactionType = VarTransactionType::Withdrawal) then begin
                BulkWithVisible := true;
            end;
        end;
        FnShowFields();


        VarshowSignatories := false;
        VarShowAgents := false;

        ObjAccountSignatories.Reset;
        ObjAccountSignatories.SetRange(ObjAccountSignatories."Account No", "Account No");
        if ObjAccountSignatories.Find('-') = true then begin
            VarshowSignatories := true;
        end;

        ObjAccountAgent.Reset;
        ObjAccountAgent.SetRange(ObjAccountAgent."Account No", "Account No");
        if ObjAccountAgent.FindSet then begin
            VarShowAgents := true;
        end;

        ExcessFOSAAccountVisible := false;
        if ("Excess Transaction Type" = "excess transaction type"::"Fosa Saving") or ("Excess Transaction Type" = "excess transaction type"::"Junior A/c") then begin
            ExcessFOSAAccountVisible := true;
        end;
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        if Posted = true then
            Error('You cannot delete an already posted record.');
    end;

    trigger OnInit()
    begin
        "Transaction DateEditable" := true;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Clear(Acc.Image);
        Clear(Acc.Signature);

        "Needs Approval" := "needs approval"::No;
        FChequeVisible := false;


        CashierTrans.Reset;
        CashierTrans.SetRange(CashierTrans.Posted, false);
        CashierTrans.SetRange(CashierTrans.Cashier, UserId);
        if CashierTrans.Count > 0 then begin
            if CashierTrans."Account No" = '' then begin
                if Confirm('There are still some Unused Transaction Nos. Continue?', false) = false then begin
                    Error('There are still some Unused Transaction Nos. Please utilise them first');
                end;
            end;
        end;
    end;

    trigger OnModifyRecord(): Boolean
    begin
        /*IF xRec.Posted = TRUE THEN BEGIN
        IF Posted = TRUE THEN
        ERROR('You cannot modify an already posted record.');
        END;*/

    end;

    trigger OnOpenPage()
    begin
        /*IF UsersID.GET(USERID) THEN BEGIN
        IF UsersID.Branch <> '' THEN
        SETRANGE("Transacting Branch",UsersID.Branch);
        END;*/


        if Posted = true then
            CurrPage.Editable := false;


        FChequeVisible := false;
        BChequeVisible := false;
        BReceiptVisible := false;
        BOSAReceiptChequeVisible := false;
        ChequeTransfVisible := false;
        ChequeWithdrawalVisible := false;
        DepositSlipVisible := false;
        BulkWithVisible := false;
        TransactionTypes.Reset();
        TransactionTypes.SetRange(TransactionTypes.Code, "Transaction Type");
        if TransactionTypes.Find('-') then begin
            VarTransactionType := TransactionTypes.Type;
        end;
        if (VarTransactionType = VarTransactionType::"Cash Deposit") or (VarTransactionType = VarTransactionType::"Cheque Withdrawal") then begin
            FChequeVisible := true;
            if ("Account No" = '502-00-000300-00') or ("Account No" = '502-00-000303-00') then
                BOSAReceiptChequeVisible := true;

        end;

        "Branch RefferenceVisible" := false;
        LRefVisible := false;


        if VarTransactionType = VarTransactionType::"Bankers Cheque" then
            BChequeVisible := true;

        if VarTransactionType = VarTransactionType::Encashment then
            BReceiptVisible := true;


        if ("Transaction Type" = 'RECEIPT') or ("Transaction Type" = 'FOSALN') then
            BReceiptVisible := true;

        if VarTransactionType = VarTransactionType::Transfer then
            ChequeTransfVisible := true;

        if VarTransactionType = VarTransactionType::"Inhouse Cheque Withdrawal" then begin
            ChequeWithdrawalVisible := true;
        end;

        if VarTransactionType = VarTransactionType::"Deposit Slip" then begin
            DepositSlipVisible := true;
        end;

        if "Branch Transaction" = true then begin
            "Branch RefferenceVisible" := true;
            LRefVisible := true;
        end;

        FnShowFields();

        if ObjAccountType.Get("Account Type") then begin
            if (Amount >= ObjAccountType."Bulk Withdrawal Amount") and (Type = 'Withdrawal') then begin
                BulkWithVisible := true;
            end;
        end;


        VarshowSignatories := false;
        VarShowAgents := false;

        ObjAccountSignatories.Reset;
        ObjAccountSignatories.SetRange(ObjAccountSignatories."Account No", "Account No");
        if ObjAccountSignatories.Find('-') = true then begin
            VarshowSignatories := true;
        end;

        ObjAccountAgent.Reset;
        ObjAccountAgent.SetRange(ObjAccountAgent."Account No", "Account No");
        if ObjAccountAgent.FindSet then begin
            VarShowAgents := true;
        end;


        ExcessFOSAAccountVisible := false;
        if ("Excess Transaction Type" = "excess transaction type"::"Fosa Saving") or ("Excess Transaction Type" = "excess transaction type"::"Junior A/c") then begin
            ExcessFOSAAccountVisible := true;
        end;

    end;

    var
        LoanBalance: Decimal;
        VarTransactionType: Enum FOSATransactionTypesEnum;
        AvailableBalance: Decimal;
        UnClearedBalance: Decimal;
        LoanSecurity: Decimal;
        LoanGuaranteed: Decimal;
        GenJournalLine: Record "Gen. Journal Line";
        DefaultBatch: Record "Gen. Journal Batch";
        GLPosting: Codeunit "Gen. Jnl.-Post Line";
        window: Dialog;
        Account: Record Vendor;
        TransactionTypes: Record "Transaction Types";
        TransactionCharges: Record "Transaction Charges";
        TCharges: Decimal;
        LineNo: Integer;
        AccountTypes: Record "Account Types-Saving Products";
        GenLedgerSetup: Record "General Ledger Setup";
        MinAccBal: Decimal;
        FeeBelowMinBal: Decimal;
        AccountNo: Code[30];
        NewAccount: Boolean;
        CurrentTellerAmount: Decimal;
        TellerTill: Record "Bank Account";
        IntervalPenalty: Decimal;
        StandingOrders: Record "Standing Orders";
        AccountAmount: Decimal;
        STODeduction: Decimal;
        Charges: Record Charges;
        "Total Deductions": Decimal;
        STODeductedAmount: Decimal;
        NoticeAmount: Decimal;
        AccountNotices: Record "Account Notices";
        Cust: Record Customer;
        AccountHolders: Record Vendor;
        ChargesOnFD: Decimal;
        TotalGuaranted: Decimal;
        VarAmtHolder: Decimal;
        chqtransactions: Record Transactions;
        Trans: Record Transactions;
        TotalUnprocessed: Decimal;
        CustAcc: Record Customer;
        AmtAfterWithdrawal: Decimal;
        TransactionsRec: Record Transactions;
        LoansTotal: Decimal;
        Interest: Decimal;
        InterestRate: Decimal;
        OBal: Decimal;
        Principal: Decimal;
        ATMTrans: Decimal;
        ATMBalance: Decimal;
        TotalBal: Decimal;
        DenominationsRec: Record Denominations;
        TillNo: Code[20];
        FOSASetup: Record "Purchases & Payables Setup";
        Acc: Record Vendor;
        ChequeTypes: Record "Cheque Types";
        ChargeAmount: Decimal;
        TChargeAmount: Decimal;
        DActivity: Code[20];
        DBranch: Code[20];
        UsersID: Record User;
        ChBank: Code[20];
        DValue: Record "Dimension Value";
        ReceiptAllocations: Record "Receipt Allocation";
        Loans: Record "Loans Register";
        Commision: Decimal;
        Cheque: Boolean;
        LOustanding: Decimal;
        TotalCommision: Decimal;
        TotalOustanding: Decimal;
        BOSABank: Code[20];
        InterestPaid: Decimal;
        PaymentAmount: Decimal;
        RunBal: Decimal;
        Recover: Boolean;
        GenSetup: Record "Sacco General Set-Up";
        MailContent: Text[150];
        supervisor: Record "Supervisors Approval Levels";
        TEXT1: label 'YOU HAVE A TRANSACTION AWAITING APPROVAL';
        AccP: Record Vendor;
        LoansR: Record "Loans Register";
        ClearingCharge: Decimal;
        ClearingRate: Decimal;
        [InDataSet]
        FChequeVisible: Boolean;
        [InDataSet]
        BChequeVisible: Boolean;
        [InDataSet]
        BReceiptVisible: Boolean;
        [InDataSet]
        BOSAReceiptChequeVisible: Boolean;
        [InDataSet]
        "Branch RefferenceVisible": Boolean;
        [InDataSet]
        LRefVisible: Boolean;
        ChequeTransfVisible: Boolean;
        [InDataSet]
        "Transaction DateEditable": Boolean;
        Excise: Decimal;
        Echarge: Decimal;
        BankLedger: Record "Bank Account Ledger Entry";
        Vend: Record Vendor;
        ChequeBook: Record "Cheques Register";
        BosaSetUp: Record "Sacco General Set-Up";
        CashierTrans: Record Transactions;
        ChequeWithdrawalVisible: Boolean;
        DepositSlipVisible: Boolean;
        OverDraftCharge: Decimal;
        OverDraftChargeAcc: Code[20];
        ChequeWithOll: Boolean;
        ChequeRegister: Record "Cheque Book Register";
        LoanType: Record "Loan Products Setup";
        GraduatedCharge: Record "CWithdrawal Graduated Charges";
        ExciseDuty: Decimal;
        ShareCapDefecit: Decimal;
        HasSpecialMandateVisible: Boolean;
        TransactingAgentVisible: Boolean;
        TransactingAgentNameVisible: Boolean;
        ObjAccountAgents: Record "Account Agent Details";
        ReceiptAllVisible: Boolean;
        LoanApp: Record "Loans Register";
        Datefilter: Text;
        SURESTEPFactory: Codeunit "SURESTEP Factory";
        ObjTransactions: Record "Receipt Allocation";
        BulkWithVisible: Boolean;
        ObjAccountType: Record "Account Types-Saving Products";
        VarMonthlyInt: Decimal;
        ObjProductCharge: Record "Loan Product Charges";
        VarshowSignatories: Boolean;
        VarShowAgents: Boolean;
        ObjAccountSignatories: Record "FOSA Account Sign. Details";
        ObjAccountAgent: Record "Account Agent Details";
        ObjReceiptAllocation: Record "Receipt Allocation";
        ExcessFOSAAccountVisible: Boolean;
        VarNoticeType: Option " ","With Notice","Without Notice";
        ODDetailsVisible: Boolean;


    procedure CalcAvailableBal()
    begin
        ATMBalance := 0;

        TCharges := 0;
        AvailableBalance := 0;
        MinAccBal := 0;
        TotalUnprocessed := 0;
        IntervalPenalty := 0;
        //+++++++++++++++++++++++++++++Get the transaction type++++++++++++++++++++++++++++
        TransactionTypes.Reset();
        TransactionTypes.SetRange(TransactionTypes.Code, "Transaction Type");
        if TransactionTypes.Find('-') then begin
            VarTransactionType := TransactionTypes.Type;
        end;

        if Account.Get("Account No") then begin
            Account.CalcFields(Account.Balance, Account."Uncleared Cheques", Account."ATM Transactions");

            AccountTypes.Reset;
            AccountTypes.SetRange(AccountTypes.Code, "Savings Product");
            if AccountTypes.Find('-') then begin
                MinAccBal := AccountTypes."Minimum Balance";
                FeeBelowMinBal := AccountTypes."Fee Below Minimum Balance";


                //Check Withdrawal Interval
                if Account.Status <> Account.Status::Deceased then begin
                    if VarTransactionType = VarTransactionType::Withdrawal then begin
                        AccountTypes.Reset;
                        AccountTypes.SetRange(AccountTypes.Code, "Savings Product");
                        if Account."Last Withdrawal Date" <> 0D then begin
                            if CalcDate(AccountTypes."Withdrawal Interval", Account."Last Withdrawal Date") > Today then
                                IntervalPenalty := AccountTypes."Withdrawal Penalty";
                        end;
                    end;
                    //Check Withdrawal Interval

                    //Fixed Deposit
                    ChargesOnFD := 0;
                    if AccountTypes."Fixed Deposit" = true then begin
                        if Account."Expected Maturity Date" > Today then
                            ChargesOnFD := AccountTypes."Charge Closure Before Maturity";
                    end;
                    //Fixed Deposit

                    /*
                    //Current Charges
                    TransactionCharges.RESET;
                    TransactionCharges.SETRANGE(TransactionCharges."Transaction Type","Transaction Type");
                    IF TransactionCharges.FIND('-') THEN BEGIN
                    REPEAT
                    IF TransactionCharges."Use Percentage"=TRUE THEN BEGIN
                    TransactionCharges.TESTFIELD("Percentage of Amount");
                    TCharges:=TCharges+(TransactionCharges."Percentage of Amount"/100)*Amount;
                    END ELSE BEGIN
                    TCharges:=TCharges+TransactionCharges."Charge Amount";
                    END;
                    UNTIL TransactionCharges.NEXT=0;
                    END;
                    */

                    TotalUnprocessed := Account."Uncleared Cheques";
                    ATMBalance := Account."ATM Transactions";

                    //FD
                    if AccountTypes."Fixed Deposit" = false then begin
                        if Account.Balance < MinAccBal then
                            AvailableBalance := Account.Balance - FeeBelowMinBal - TCharges - MinAccBal - TotalUnprocessed - ATMBalance -
                                              Account."EFT Transactions" + Account."Cheque Discounted"// IntervalPenalty -
                        else
                            AvailableBalance := Account.Balance - TCharges - MinAccBal - TotalUnprocessed - ATMBalance -
                                              Account."EFT Transactions" + Account."Cheque Discounted";//IntervalPenalty -
                    end else begin
                        AvailableBalance := Account.Balance - TCharges - ChargesOnFD - Account."ATM Transactions" + Account."Cheque Discounted";
                    end;
                end;

                /*MESSAGE('FeeBelowMinBal Is %1',FeeBelowMinBal);
                MESSAGE('TCharges Is %1',TCharges);
                MESSAGE('IntervalPenalty Is %1',IntervalPenalty);
                MESSAGE('MinAccBal Is %1',MinAccBal);
                MESSAGE('TotalUnprocessed Is %1',TotalUnprocessed);
                MESSAGE('ATMBalance Is %1',ATMBalance);
                MESSAGE('EFT Transactions Is %1',Account."EFT Transactions");*/


                //FD

            end;
        end;

        if "N.A.H Balance" <> 0 then
            AvailableBalance := "N.A.H Balance";
        //MESSAGE('Available balance is %1',AvailableBalance);

    end;


    procedure PostChequeDep()
    begin
        //Check teller transaction limits
        TillNo := '';
        TellerTill.Reset;
        TellerTill.SetRange(TellerTill."Account Type", TellerTill."account type"::Cashier);
        TellerTill.SetRange(TellerTill.CashierID, UserId);
        if TellerTill.Find('-') then begin
            TillNo := TellerTill."No.";
            TellerTill.CalcFields(TellerTill.Balance);

            //+++++++++++++++++++++++++++++Get the transaction type++++++++++++++++++++++++++++
            TransactionTypes.Reset();
            TransactionTypes.SetRange(TransactionTypes.Code, "Transaction Type");
            if TransactionTypes.Find('-') then begin
                VarTransactionType := TransactionTypes.Type;
            end;

            if VarTransactionType = VarTransactionType::"Cheque Deposit" then begin
                if Amount > TellerTill."Max Cheque Deposit Limit" then begin
                    if Authorised = Authorised::No then begin
                        "Authorisation Requirement" := 'Cheque Receipt Above teller Limit';
                        Modify;

                        MailContent := 'The' + ' ' + 'Cashier' + ' ' + Cashier + ' ' +
                        'cannot Receive a cheque more than allowed ,limit, Maximum limit is' + '' + Format(TellerTill."Max Cheque Deposit Limit") +
                        'you need to authorise';
                        SendEmail;
                        Message('You cannot Receive a cheque more than your allowed limit of %1 unless authorised.', TellerTill."Max Cheque Deposit Limit");

                        exit;
                    end;
                end;
            end;
            DValue.Reset;
            DValue.SetRange(DValue."Global Dimension No.", 2);
            //DValue.SETRANGE(DValue.Code,DBranch);`
            DValue.SetRange(DValue.Code, '01');
            if DValue.Find('-') then begin
                //DValue.TESTFIELD(DValue."Clearing Bank Account");
                ChBank := "Cheque Clearing Bank Code";//DValue."Clearing Bank Account";
            end else
                //ERROR('Branch not set.');
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
                    GenJournalLine.Description := "Transaction Type" + '-' + Description;
                //Project Accounts
                if Acc.Get("Account No") then begin
                    if Acc."Account Category" = Acc."account category"::Project then
                        GenJournalLine.Description := "Transaction Type" + '-' + "Branch Refference"
                end;
                //Project Accounts
                GenJournalLine.Validate(GenJournalLine."Currency Code");
                GenJournalLine.Amount := -Amount;
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
                GenJournalLine.Description := 'Cheque Deposit_' + "Cheque No";
                GenJournalLine.Validate(GenJournalLine."Currency Code");
                GenJournalLine.Amount := Amount;
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
                GenJournalLine.Description := 'Clearing Charges';
                GenJournalLine.Validate(GenJournalLine."Currency Code");
                GenJournalLine.Amount := ClearingCharge;
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
                GenJournalLine.Description := 'Excise Duty';
                GenJournalLine.Validate(GenJournalLine."Currency Code");
                GenJournalLine.Amount := (ClearingCharge * GenSetup."Excise Duty(%)") / 100;
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


                Posted := true;
                Authorised := Authorised::Yes;
                "Supervisor Checked" := true;
                "Needs Approval" := "needs approval"::No;
                "Frequency Needs Approval" := "frequency needs approval"::No;
                "Date Posted" := Today;
                "Time Posted" := Time;
                "Posted By" := UserId;
                if ChequeTypes."Clearing  Days" = 0 then begin
                    Status := Status::Honoured;
                    "Cheque Processed" := true;
                    "Date Cleared" := Today;
                end;
                Modify;
            end;


            Message('Cheque deposited successfully.');

            Trans.Reset;
            Trans.SetRange(Trans.No, No);
            if Trans.Find('-') then begin
                Report.Run(50500, false, true, Trans);
            end;
        end;

        CurrPage.Close;
    end;


    procedure PostDepSlipDep()
    begin
        //+++++++++++++++++++++++++++++Get the transaction type++++++++++++++++++++++++++++
        TransactionTypes.Reset();
        TransactionTypes.SetRange(TransactionTypes.Code, "Transaction Type");
        if TransactionTypes.Find('-') then begin
            VarTransactionType := TransactionTypes.Type;
        end;
        if VarTransactionType = VarTransactionType::"Deposit Slip" then
            DValue.Reset;
        DValue.SetRange(DValue."Global Dimension No.", 2);
        //DValue.SETRANGE(DValue.Code,DBranch);`
        //DValue.SETRANGE(DValue.Code,'NAIROBI');
        if DValue.Find('-') then begin
            //DValue.TESTFIELD(DValue."Clearing Bank Account");
            ChBank := "Cheque Clearing Bank Code";//DValue."Clearing Bank Account";
        end else
            //ERROR('Branch not set.');
            ChBank := "Bank Account";

        //IF ChequeTypes.GET("Cheque Type") THEN BEGIN
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
        GenJournalLine."Posting Date" := "Document Date";
        if "Branch Transaction" = true then
            GenJournalLine.Description := "Transaction Type" + '-' + "Branch Refference"
        else
            GenJournalLine.Description := "Transaction Description" + '-' + Description;
        //Project Accounts
        if Acc.Get("Account No") then begin
            if Acc."Account Category" = Acc."account category"::Project then
                GenJournalLine.Description := "Transaction Type" + '-' + "Branch Refference"
        end;
        //Project Accounts
        GenJournalLine.Validate(GenJournalLine."Currency Code");
        GenJournalLine.Amount := -Amount;
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
        GenJournalLine."Account No." := "Bank Account";
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Posting Date" := "Document Date";
        GenJournalLine.Description := "Account Name";
        GenJournalLine.Validate(GenJournalLine."Currency Code");
        GenJournalLine.Amount := Amount;
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
        GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert;
        /*
        //Post Charges
        ChargeAmount:=0;
        
        LineNo:=LineNo+10000;
        ClearingCharge:=0;
        IF ChequeTypes."Use %" = TRUE THEN BEGIN
        ClearingCharge:=((ChequeTypes."% Of Amount"*0.01)*Amount);
        END ELSE
        ClearingCharge:=ChequeTypes."Clearing Charges";
        //MESSAGE('ClearingCharge%1',ClearingCharge);
        GenJournalLine.INIT;
        GenJournalLine."Journal Template Name":='PURCHASES';
        GenJournalLine."Journal Batch Name":='FTRANS';
        GenJournalLine."Document No.":=No;
        GenJournalLine."Line No.":=LineNo;
        GenJournalLine."Account Type":=GenJournalLine."Account Type"::Vendor;
        GenJournalLine."Account No.":="Account No";
        GenJournalLine."External Document No.":="ID No";
        GenJournalLine.VALIDATE(GenJournalLine."Account No.");
        GenJournalLine."Posting Date":="Transaction Date";
        GenJournalLine.Description:='Clearing Charges';
        GenJournalLine.VALIDATE(GenJournalLine."Currency Code");
        GenJournalLine.Amount:=ClearingCharge;
        GenJournalLine.VALIDATE(GenJournalLine.Amount);
        GenJournalLine."Bal. Account Type":=GenJournalLine."Bal. Account Type"::"G/L Account";
        GenJournalLine."Bal. Account No.":=ChequeTypes."Clearing Charges GL Account";
        GenJournalLine.VALIDATE(GenJournalLine."Bal. Account No.");
        GenJournalLine."Shortcut Dimension 1 Code":=DActivity;
        GenJournalLine."Shortcut Dimension 2 Code":=DBranch;
        GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
        IF GenJournalLine.Amount<>0 THEN
        GenJournalLine.INSERT;
        //Post Charges
        
        
        
        //Excise Duty
        genSetup.GET(0);
        
        LineNo:=LineNo+10000;
        GenJournalLine.INIT;
        GenJournalLine."Journal Template Name":='PURCHASES';
        GenJournalLine."Journal Batch Name":='FTRANS';
        GenJournalLine."Document No.":=No;
        GenJournalLine."Line No.":=LineNo;
        GenJournalLine."Account Type":=GenJournalLine."Account Type"::Vendor;
        GenJournalLine."Account No.":="Account No";
        GenJournalLine."External Document No.":="ID No";
        GenJournalLine.VALIDATE(GenJournalLine."Account No.");
        GenJournalLine."Posting Date":="Transaction Date";
        GenJournalLine.Description:='Excise Duty';
        GenJournalLine.VALIDATE(GenJournalLine."Currency Code");
        GenJournalLine.Amount:=(ClearingCharge*genSetup."Excise Duty(%)")/100;
        GenJournalLine.VALIDATE(GenJournalLine.Amount);
        GenJournalLine."Bal. Account Type":=GenJournalLine."Bal. Account Type"::"G/L Account";
        GenJournalLine."Bal. Account No.":=genSetup."Excise Duty Account";
        GenJournalLine.VALIDATE(GenJournalLine."Bal. Account No.");
        GenJournalLine."Shortcut Dimension 1 Code":=DActivity;
        GenJournalLine."Shortcut Dimension 2 Code":=DBranch;
        GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
        IF GenJournalLine.Amount<>0 THEN
        GenJournalLine.INSERT;
        
        */


        //Post New
        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", 'PURCHASES');
        GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
        if GenJournalLine.Find('-') then begin
            Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
        end;

        //Post New


        Posted := true;
        Authorised := Authorised::Yes;
        "Supervisor Checked" := true;
        "Needs Approval" := "needs approval"::No;
        "Frequency Needs Approval" := "frequency needs approval"::No;
        "Date Posted" := Today;
        "Time Posted" := Time;
        "Posted By" := UserId;


        Modify;



        Message('Deposit Slip deposited successfully.');

        Trans.Reset;
        Trans.SetRange(Trans.No, No);
        if Trans.Find('-') then
            Report.Run(50500, false, true, Trans);


        //END;
        CurrPage.Close;

    end;


    procedure PostTransfer()
    begin
        DValue.Reset;
        DValue.SetRange(DValue."Global Dimension No.", 2);
        //DValue.SETRANGE(DValue.Code,DBranch);`
        //DValue.SETRANGE(DValue.Code,'NAIROBI');
        if DValue.Find('-') then begin
            //DValue.TESTFIELD(DValue."Clearing Bank Account");
            ChBank := "Cheque Clearing Bank Code";//DValue."Clearing Bank Account";
        end else
            //ERROR('Branch not set.');
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
                GenJournalLine.Description := "Transaction Description" + '-' + Description;
            //Project Accounts
            if Acc.Get("Account No") then begin
                if Acc."Account Category" = Acc."account category"::Project then
                    GenJournalLine.Description := "Transaction Type" + '-' + "Branch Refference"
            end;
            //Project Accounts
            GenJournalLine.Validate(GenJournalLine."Currency Code");
            GenJournalLine.Amount := -Amount;
            GenJournalLine.Validate(GenJournalLine.Amount);
            GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
            GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
            if GenJournalLine.Amount <> 0 then
                GenJournalLine.Insert;

            //Debit The drawers Account
            LineNo := LineNo + 10000;
            GenJournalLine.Init;
            GenJournalLine."Journal Template Name" := 'PURCHASES';
            GenJournalLine."Journal Batch Name" := 'FTRANS';
            GenJournalLine."Document No." := No;
            GenJournalLine."External Document No." := "Cheque No";
            GenJournalLine."Line No." := LineNo;
            GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
            GenJournalLine."Account No." := "Drawer's Account No";
            GenJournalLine.Validate(GenJournalLine."Account No.");
            GenJournalLine."Posting Date" := "Transaction Date";
            GenJournalLine.Description := "Account Name";
            GenJournalLine.Validate(GenJournalLine."Currency Code");
            GenJournalLine.Amount := Amount;
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
            GenJournalLine.Description := 'Clearing Charges';
            GenJournalLine.Validate(GenJournalLine."Currency Code");
            GenJournalLine.Amount := ClearingCharge;
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
            GenJournalLine.Description := 'Excise Duty';
            GenJournalLine.Validate(GenJournalLine."Currency Code");
            GenJournalLine.Amount := (ClearingCharge * GenSetup."Excise Duty(%)") / 100;
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


            Posted := true;
            Authorised := Authorised::Yes;
            "Supervisor Checked" := true;
            "Needs Approval" := "needs approval"::No;
            "Frequency Needs Approval" := "frequency needs approval"::No;
            "Date Posted" := Today;
            "Time Posted" := Time;
            "Posted By" := UserId;
            if ChequeTypes."Clearing  Days" = 0 then begin
                Status := Status::Honoured;
                "Cheque Processed" := true;
                "Date Cleared" := Today;
            end;

            Modify;

            //Update Cheque Book
            ChequeBook.Reset;
            ChequeBook.SetRange(ChequeBook."Cheque Book Account No.", "Drawers Member No");
            ChequeBook.SetRange(ChequeBook."Cheque No.", "Drawers Cheque No.");
            if ChequeBook.Find('-') then begin
                ChequeBook.Status := ChequeBook.Status::Paid;
                ChequeBook.Modify;
            end;






            Message('Transfer Posted successfully.');

            Trans.Reset;
            Trans.SetRange(Trans.No, No);
            if Trans.Find('-') then
                Report.Run(50524, false, true, Trans);


        end;

        CurrPage.Close;
    end;


    procedure PostBankersCheq()
    begin
        //Block Payments
        if Acc.Get("Account No") then begin
            if Acc.Blocked = Acc.Blocked::Payment then
                Error('This account has been blocked from receiving payments.');
        end;
        //+++++++++++++++++++++++++++++Get the transaction type++++++++++++++++++++++++++++
        TransactionTypes.Reset();
        TransactionTypes.SetRange(TransactionTypes.Code, "Transaction Type");
        if TransactionTypes.Find('-') then begin
            VarTransactionType := TransactionTypes.Type;
        end;


        DValue.Reset;
        DValue.SetRange(DValue."Global Dimension No.", 2);
        DValue.SetRange(DValue.Code, 'Nairobi');
        //DValue.SETRANGE(DValue.Code,DBranch);
        if DValue.Find('-') then begin
            //DValue.TESTFIELD(//DValue."Banker Cheque Account");
            ChBank := "Cheque Clearing Bank Code";
        end else
            Error('Branch not set.');

        CalcAvailableBal;

        //Check withdrawal limits
        if VarTransactionType = VarTransactionType::"Bankers Cheque" then begin
            if AvailableBalance < Amount then begin
                if Authorised = Authorised::Yes then begin
                    Overdraft := true;
                    Modify;
                end;

                if Authorised = Authorised::No then begin
                    if "Branch Transaction" = false then begin
                        "Authorisation Requirement" := 'Bankers Cheque - Over draft';
                        Modify;
                        Message('You cannot issue a Bankers cheque more than the available balance unless authorised.');
                        SendEmail;
                        exit;
                    end;
                end;
                if Authorised = Authorised::Rejected then
                    Error('Bankers cheque transaction has been rejected and therefore cannot proceed.');
                //SendEmail;
            end;
        end;
        //Check withdrawal limits


        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", 'PURCHASES');
        GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
        GenJournalLine.DeleteAll;

        LineNo := LineNo + 10000;

        GenJournalLine.Init;
        GenJournalLine."Journal Template Name" := 'PURCHASES';
        GenJournalLine."Journal Batch Name" := 'FTRANS';
        GenJournalLine."Document No." := No;
        GenJournalLine."External Document No." := "Bankers Cheque No";
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
        GenJournalLine."Account No." := "Account No";
        GenJournalLine.Validate(GenJournalLine."Account No.");

        GenJournalLine."Posting Date" := "Transaction Date";
        if "Branch Transaction" = true then
            GenJournalLine.Description := "Transaction Type" + '-' + "Branch Refference"
        else
            GenJournalLine.Description := Description; //"Transaction Description"+'-'+Description ;
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
        GenJournalLine."External Document No." := "Bankers Cheque No";
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Account Type" := GenJournalLine."account type"::"Bank Account";
        GenJournalLine."Account No." := ChBank;
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Posting Date" := "Transaction Date";
        GenJournalLine.Description := Payee;//"Account Name";
        GenJournalLine.Validate(GenJournalLine."Currency Code");
        GenJournalLine.Amount := -Amount;
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
        GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert;


        //Charges
        TransactionCharges.Reset;
        TransactionCharges.SetRange(TransactionCharges."Transaction Type", "Transaction Type");
        if TransactionCharges.Find('-') then begin
            repeat
                LineNo := LineNo + 10000;

                GenJournalLine.Init;
                GenJournalLine."Journal Template Name" := 'PURCHASES';
                GenJournalLine."Journal Batch Name" := 'FTRANS';
                GenJournalLine."Document No." := No;
                GenJournalLine."External Document No." := "Bankers Cheque No";
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                GenJournalLine."Account No." := "Account No";
                GenJournalLine.Validate(GenJournalLine."Account No.");
                GenJournalLine."Posting Date" := "Transaction Date";
                GenJournalLine.Description := TransactionCharges.Description;
                GenJournalLine.Validate(GenJournalLine."Currency Code");
                GenJournalLine.Amount := TransactionCharges."Charge Amount";
                GenJournalLine.Validate(GenJournalLine.Amount);
                GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                GenJournalLine."Bal. Account No." := TransactionCharges."G/L Account";
                GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                if GenJournalLine.Amount <> 0 then
                    GenJournalLine.Insert;

                if TransactionCharges."Due Amount" > 0 then begin
                    LineNo := LineNo + 10000;

                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := 'PURCHASES';
                    GenJournalLine."Journal Batch Name" := 'FTRANS';
                    GenJournalLine."Document No." := No;
                    GenJournalLine."External Document No." := "Bankers Cheque No";
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                    GenJournalLine."Account No." := TransactionCharges."G/L Account";
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Posting Date" := "Transaction Date";
                    GenJournalLine.Description := TransactionCharges.Description;
                    GenJournalLine.Validate(GenJournalLine."Currency Code");
                    GenJournalLine.Amount := TransactionCharges."Due Amount";
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"Bank Account";
                    GenJournalLine."Bal. Account No." := ChBank;
                    GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                    GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                    GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;


                end;

            until TransactionCharges.Next = 0;
        end;

        //Charges

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
        GenJournalLine.Description := 'Excise Duty';
        GenJournalLine.Validate(GenJournalLine."Currency Code");
        GenJournalLine.Amount := (TransactionCharges."Charge Amount" * GenSetup."Excise Duty(%)") / 100;
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


        "Transaction Available Balance" := AvailableBalance;
        Posted := true;
        Authorised := Authorised::Yes;
        "Supervisor Checked" := true;
        "Needs Approval" := "needs approval"::No;
        "Frequency Needs Approval" := "frequency needs approval"::No;
        "Date Posted" := Today;
        "Time Posted" := Time;
        "Posted By" := UserId;
        Modify;
        /*IF CONFIRM('Are you sure you want to print this bankers cheque?',TRUE)=TRUE THEN BEGIN
        REPORT.RUN(,TRUE,TRUE,Trans)
        END;*/


        Message('Bankers cheque posted successfully.');

        CurrPage.Close;

    end;


    procedure PostEncashment()
    begin

        //Block Payments
        if Acc.Get("Account No") then begin
            if Acc.Blocked = Acc.Blocked::Payment then
                Error('This account has been blocked from receiving payments.');
        end;
        //+++++++++++++++++++++++++++++Get the transaction type++++++++++++++++++++++++++++
        TransactionTypes.Reset();
        TransactionTypes.SetRange(TransactionTypes.Code, "Transaction Type");
        if TransactionTypes.Find('-') then begin
            VarTransactionType := TransactionTypes.Type;
        end;

        CalcAvailableBal;

        //Check withdrawal limits
        if (VarTransactionType = VarTransactionType::Encashment) or (VarTransactionType = VarTransactionType::"Inhouse Cheque Withdrawal") then begin
            if AvailableBalance < Amount then begin
                if Authorised = Authorised::Yes then begin
                    Overdraft := true;
                    Modify;
                end;

                if Authorised = Authorised::No then begin
                    "Authorisation Requirement" := 'Encashment - Over draft';
                    Modify;
                    Message('You cannot issue an encashment more than the available balance unless authorised.');
                    MailContent := 'Withdrawal transaction' + 'TR. No.' + ' ' + No + ' ' + 'of Kshs' + ' ' + Format(Amount) + ' ' + 'for'
                    + ' ' + "Account Name" + ' ' + 'needs your authorization';
                    SendEmail;

                    //SendEmail;
                    exit;
                end;
                if Authorised = Authorised::Rejected then begin
                    MailContent := 'Bankers cheque transaction' + ' ' + 'of Kshs' + ' ' + Format(Amount) + ' ' + 'for'
                    + ' ' + "Account Name" + ' ' + 'needs your approval';
                    SendEmail;
                    Error('Transaction has been rejected and therefore cannot proceed.');

                end;
            end;
        end;
        //Check withdrawal limits



        //Check Teller Balances
        //ADDED DActivity:='';
        //ADDED DBranch:='';

        TillNo := '';
        TellerTill.Reset;
        TellerTill.SetRange(TellerTill."Account Type", TellerTill."account type"::Cashier);
        TellerTill.SetRange(TellerTill.CashierID, UserId);
        if TellerTill.Find('-') then begin
            //ADDED DActivity:=TellerTill."Global Dimension 1 Code";
            //ADDED DBranch:=TellerTill."Global Dimension 2 Code";
            TillNo := TellerTill."No.";
            TellerTill.CalcFields(TellerTill.Balance);

            CurrentTellerAmount := TellerTill.Balance;

            if CurrentTellerAmount - Amount <= TellerTill."Min. Balance" then
                Message('You need to add more money from the treasury since your balance has gone below the teller replenishing level.');

            if (VarTransactionType = VarTransactionType::Withdrawal) or (VarTransactionType = VarTransactionType::Encashment) or (VarTransactionType = VarTransactionType::"Inhouse Cheque Withdrawal") then begin
                if (CurrentTellerAmount - Amount) < 0 then
                    Error('You do not have enough money to carry out this transaction.');

            end;

            if (VarTransactionType = VarTransactionType::Withdrawal) or (VarTransactionType = VarTransactionType::Encashment) or (VarTransactionType = VarTransactionType::"Inhouse Cheque Withdrawal") then begin
                if CurrentTellerAmount - Amount >= TellerTill."Maximum Teller Withholding" then
                    Message('You need to transfer money back to the treasury since your balance has gone above the teller maximum withholding.');

            end else begin
                if CurrentTellerAmount + Amount >= TellerTill."Maximum Teller Withholding" then
                    Message('You need to transfer money back to the treasury since your balance has gone above the teller maximum withholding.');
            end;


        end;

        if TillNo = '' then
            Error('Teller account not set-up.');

        //Check Teller Balances




        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", 'PURCHASES');
        GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
        GenJournalLine.DeleteAll;

        LineNo := LineNo + 10000;

        GenJournalLine.Init;
        GenJournalLine."Journal Template Name" := 'PURCHASES';
        GenJournalLine."Journal Batch Name" := 'FTRANS';
        GenJournalLine."Document No." := No;
        GenJournalLine."External Document No." := "ID No";
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
        GenJournalLine."Account No." := "Account No";
        if ("Account No" = '00-0000003000') or ("Account No" = '00-0200003000') then
            GenJournalLine."External Document No." := "ID No";

        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Posting Date" := "Transaction Date";
        GenJournalLine.Description := Payee;
        GenJournalLine.Validate(GenJournalLine."Currency Code");
        GenJournalLine.Amount := Amount;
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
        GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert;


        //Charges
        TCharges := 0;
        //ADDED
        TChargeAmount := 0;


        TransactionCharges.Reset;
        TransactionCharges.SetRange(TransactionCharges."Transaction Type", "Transaction Type");

        if TransactionCharges.Find('-') then begin
            repeat
                LineNo := LineNo + 10000;

                ChargeAmount := 0;
                if TransactionCharges."Use Percentage" = true then begin
                    ChargeAmount := (Amount * TransactionCharges."Percentage of Amount") * 0.01
                end else
                    ChargeAmount := TransactionCharges."Charge Amount";


                GenJournalLine.Init;
                GenJournalLine."Journal Template Name" := 'PURCHASES';
                GenJournalLine."Journal Batch Name" := 'FTRANS';
                GenJournalLine."Document No." := No;
                GenJournalLine."External Document No." := "ID No";
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                GenJournalLine."Account No." := "Account No";
                GenJournalLine.Validate(GenJournalLine."Account No.");
                GenJournalLine."Posting Date" := "Transaction Date";
                GenJournalLine.Description := Payee;
                GenJournalLine.Validate(GenJournalLine."Currency Code");
                GenJournalLine.Amount := ChargeAmount;
                GenJournalLine.Validate(GenJournalLine.Amount);
                GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                GenJournalLine."Bal. Account No." := TransactionCharges."G/L Account";
                GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                if GenJournalLine.Amount <> 0 then
                    GenJournalLine.Insert;

                TChargeAmount := TChargeAmount + ChargeAmount;

            until TransactionCharges.Next = 0;
        end;

        /*
        //Excise
        genSetup.GET();
        
        LineNo:=LineNo+10000;
        
        GenJournalLine.INIT;
        GenJournalLine."Journal Template Name":='PURCHASES';
        GenJournalLine."Journal Batch Name":='FTRANS';
        GenJournalLine."Document No.":=No;
        GenJournalLine."External Document No.":="ID No";
        GenJournalLine."Line No.":=LineNo;
        GenJournalLine."Account Type":=GenJournalLine."Account Type"::Vendor;
        GenJournalLine."Account No.":="Account No";
        GenJournalLine.VALIDATE(GenJournalLine."Account No.");
        GenJournalLine."Posting Date":="Transaction Date";
        GenJournalLine.Description:='Excise Duty';
        GenJournalLine.VALIDATE(GenJournalLine."Currency Code");
        GenJournalLine.Amount:=50*genSetup."Excise Duty(%)";
        GenJournalLine.VALIDATE(GenJournalLine.Amount);
        GenJournalLine."Bal. Account Type":=GenJournalLine."Bal. Account Type"::"G/L Account";
        GenJournalLine."Bal. Account No.":=genSetup."Excise Duty Account";
        GenJournalLine."Shortcut Dimension 1 Code":=DActivity;
        GenJournalLine."Shortcut Dimension 2 Code":=DBranch;
        GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
        IF GenJournalLine.Amount<>0 THEN
        GenJournalLine.INSERT;
        
        */
        //Charges


        //Teller Entry
        LineNo := LineNo + 10000;

        GenJournalLine.Init;
        GenJournalLine."Journal Template Name" := 'PURCHASES';
        GenJournalLine."Journal Batch Name" := 'FTRANS';
        GenJournalLine."Document No." := No;
        GenJournalLine."External Document No." := "ID No";
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Account Type" := GenJournalLine."account type"::"Bank Account";
        GenJournalLine."Account No." := TillNo;
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Posting Date" := "Transaction Date";
        GenJournalLine.Description := Payee;
        GenJournalLine.Validate(GenJournalLine."Currency Code");
        GenJournalLine.Amount := -(Amount);
        GenJournalLine.Validate(GenJournalLine.Amount);
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


        "Transaction Available Balance" := AvailableBalance;
        Posted := true;
        Authorised := Authorised::Yes;
        "Supervisor Checked" := true;
        "Needs Approval" := "needs approval"::No;
        "Frequency Needs Approval" := "frequency needs approval"::No;
        "Date Posted" := Today;
        "Time Posted" := Time;
        "Posted By" := UserId;
        Modify;

        //Update Cheque Book
        ChequeBook.Reset;
        ChequeBook.SetRange(ChequeBook."Cheque Book Account No.", "Drawers Member No");
        ChequeBook.SetRange(ChequeBook."Cheque No.", "Drawers Cheque No.");
        if ChequeBook.Find('-') then begin
            ChequeBook.Status := ChequeBook.Status::Paid;
            ChequeBook.Modify;
        end;

        Message('Transaction Successful.');

        Trans.Reset;
        Trans.SetRange(Trans.No, No);
        if Trans.Find('-') then
            if Type = 'Inhouse Cheque Withdrawal ' then
                Report.Run(50527, false, true, Trans);

        CurrPage.Close;

    end;


    procedure PostCashDepWith()
    begin
        CalcAvailableBal;
        //+++++++++++++++++++++++++++++Get the transaction type++++++++++++++++++++++++++++
        TransactionTypes.Reset();
        TransactionTypes.SetRange(TransactionTypes.Code, "Transaction Type");
        if TransactionTypes.Find('-') then begin
            VarTransactionType := TransactionTypes.Type;
        end;
        //Check withdrawal limits - Available Bal
        if VarTransactionType = VarTransactionType::Withdrawal then begin
            //Block Payments
            if Acc.Get("Account No") then begin
                if Acc.Blocked = Acc.Blocked::Payment then
                    Error('This account has been blocked from receiving payments.');
            end;

            if AvailableBalance < Amount then begin
                if Authorised = Authorised::Yes then begin
                    Overdraft := true;
                    Modify;
                end;

                if Authorised = Authorised::No then begin
                    if "Branch Transaction" = false then begin
                        "Authorisation Requirement" := 'Over draft';
                        Modify;
                        MailContent := 'Withdrawal transaction' + 'TR. No.' + ' ' + No + ' ' + 'of Kshs' + ' ' + Format(Amount) + ' ' + 'for'
                        + ' ' + "Account Name" + ' ' + 'needs your approval';
                        SendEmail;
                        Message('You cannot withdraw more than the available balance unless authorised.');

                        exit;
                    end;
                    if Authorised = Authorised::Rejected then
                        Error('Transaction has been rejected and therefore cannot proceed.');

                end;
            end;
        end;
        //Check withdrawal limits - Available Bal



        //Check Teller Balances
        //ADDED DActivity:='';
        //ADDED DBranch:='';

        TillNo := '';
        TellerTill.Reset;
        TellerTill.SetRange(TellerTill."Account Type", TellerTill."account type"::Cashier);
        TellerTill.SetRange(TellerTill.CashierID, UserId);
        if TellerTill.Find('-') then begin
            TillNo := TellerTill."No.";
            TellerTill.CalcFields(TellerTill.Balance);

            CurrentTellerAmount := TellerTill.Balance;

            if CurrentTellerAmount - Amount <= TellerTill."Min. Balance" then
                Message('You need to add more money from the treasury since your balance has gone below the teller replenishing level.');

            if ("Transaction Type" = 'Withdrawal') or ("Transaction Type" = 'Encashment') then begin
                if (CurrentTellerAmount - Amount) < 0 then
                    Error('You do not have enough money to carry out this transaction.');
                exit;
            end;
            //MESSAGE('CurrentTellerAmount %1',CurrentTellerAmount);
            if (VarTransactionType = VarTransactionType::Withdrawal) or (VarTransactionType = VarTransactionType::Encashment) then begin
                if CurrentTellerAmount - Amount >= TellerTill."Maximum Teller Withholding" then
                    Message('You need to transfer money back to the treasury since your balance has gone above the teller maximum withholding.');

            end else begin
                if CurrentTellerAmount + Amount >= TellerTill."Maximum Teller Withholding" then
                    Message('You need to transfer money back to the treasury since your balance has gone above the teller maximum withholding.');
            end;

            //Check teller transaction limits
            if VarTransactionType = VarTransactionType::Withdrawal then begin
                if Amount > TellerTill."Max Withdrawal Limit" then begin
                    if Authorised = Authorised::No then begin
                        "Authorisation Requirement" := 'Withdrawal Above teller Limit';
                        Modify;

                        MailContent := 'The' + ' ' + 'Cashier' + ' ' + Cashier + ' ' +
                        'cannot withdraw more than allowed ,limit, Maximum limit is' + '' + Format(TellerTill."Max Withdrawal Limit") +
                        'you need to authorise';
                        SendEmail;
                        Message('You cannot withdraw more than your allowed limit of %1 unless authorised.', TellerTill."Max Withdrawal Limit");

                        exit;
                    end;
                    if Authorised = Authorised::Rejected then
                        Error('Transaction has been rejected and therefore cannot proceed.');

                end;
            end;


            //Prevent teller from Overdrawing Till

            if VarTransactionType = VarTransactionType::Withdrawal then begin
                TellerTill.CalcFields(TellerTill.Balance);
                if Amount > TellerTill.Balance then begin
                    Error('you cannot transact below your Till balance.');
                end;
            end;

            //Prevent teller from Overdrawing Till



            if VarTransactionType = VarTransactionType::"Cash Deposit" then begin
                if Amount > TellerTill."Max Deposit Limit" then begin
                    if Authorised = Authorised::No then begin
                        "Authorisation Requirement" := 'Deposit above teller Limit';
                        Modify;
                        MailContent := 'The' + ' ' + 'Cashier' + ' ' + Cashier + ' ' +
                        'cannot deposit more than allowed limit, Maximum limit is' + '' + Format(TellerTill."Max Deposit Limit") + 'you need to authorise';
                        SendEmail;
                        Message('You cannot deposit more than your allowed limit of %1 unless authorised.', TellerTill."Max Deposit Limit");
                        exit;
                    end;
                    if Authorised = Authorised::Rejected then
                        //SendEmail;
                        Error('Transaction has been rejected therefore you cannot proceed.');

                end;
            end;

            //Check teller transaction limits
        end;



        if TillNo = '' then
            Error('Teller account not set-up.');

        //Check Teller Balances


        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", 'PURCHASES');
        GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
        GenJournalLine.DeleteAll;

        LineNo := LineNo + 10000;

        GenJournalLine.Init;
        GenJournalLine."Journal Template Name" := 'PURCHASES';
        GenJournalLine."Journal Batch Name" := 'FTRANS';
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Document No." := No;
        if ("Transaction Type" = 'CASHWITH') or ("Transaction Type" = 'Encashment') then
            GenJournalLine."External Document No." := Account."ID No."; // "ID No"; //"BOSA Account No";
        GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
        GenJournalLine."Account No." := "Account No";
        if "Account No" = '00-0000000000' then
            GenJournalLine."External Document No." := Account."ID No."; //"ID No";
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Posting Date" := "Transaction Date";
        if ("Transaction Type" = 'BOSA') or ("Transaction Type" = 'Encashment') then
            GenJournalLine.Description := "Transaction Type" + Payee
        else begin
            if "Branch Transaction" = true then
                GenJournalLine.Description := "Transaction Type" + '-' + "Branch Refference"
            else
                GenJournalLine.Description := "Transaction Type" + '-' + Description;
        end;
        //Project Accounts
        if Acc.Get("Account No") then begin
            if Acc."Account Category" = Acc."account category"::Project then
                GenJournalLine.Description := "Transaction Type" + '-' + "Branch Refference"
        end;
        //Project Accounts

        GenJournalLine.Validate(GenJournalLine."Currency Code");
        if (VarTransactionType = VarTransactionType::"Cash Deposit") or (Type = 'BOSA Receipt') then
            GenJournalLine.Amount := -Amount
        else
            GenJournalLine.Amount := Amount;
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"Bank Account";
        GenJournalLine."Bal. Account No." := TillNo;
        GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
        GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
        GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert;

        if (Acc."Mobile Phone No" <> '') then begin
            //Sms.SendSms('Withrawal',Acc."Mobile Phone No",'You have made a cash withdrawal of '+FORMAT(Amount) +'. Waumini SACCO',Acc."No.");

        end;

        //Charges
        TCharges := 0;



        //Charges
        TCharges := 0;
        if Account.Get("Account No") then begin
            if Account."Staff Account" <> true then begin

                if "Use Graduated Charges" = false then begin
                    TransactionCharges.Reset;
                    TransactionCharges.SetRange(TransactionCharges."Transaction Type", "Transaction Type");
                    if TransactionCharges.Find('-') then begin
                        repeat

                            LineNo := LineNo + 10000;

                            ChargeAmount := 0;
                            if Account.Get("Account No") then begin
                                if Account."Staff Account" = false then begin
                                    Echarge := ChargeAmount;
                                    GenJournalLine.Init;
                                    GenJournalLine."Journal Template Name" := 'PURCHASES';
                                    GenJournalLine."Journal Batch Name" := 'FTRANS';
                                    GenJournalLine."Document No." := No;
                                    GenJournalLine."Line No." := LineNo;
                                    GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                    GenJournalLine."Account No." := "Account No";
                                    if "Account No" = '00-0000000000' then
                                        GenJournalLine."External Document No." := "ID No";
                                    GenJournalLine.Validate(GenJournalLine."Account No.");
                                    GenJournalLine."Posting Date" := "Transaction Date";
                                    GenJournalLine.Description := TransactionCharges.Description;
                                    GenJournalLine.Validate(GenJournalLine."Currency Code");
                                    //IF (TransactionCharges."Charge Code",'<>SD') AND (Amount > 20000)  THEN
                                    //ChargeAmount:=200 ELSE
                                    GenJournalLine.Amount := TransactionCharges."Charge Amount";
                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                    GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                    GenJournalLine."Bal. Account No." := TransactionCharges."G/L Account";
                                    GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                                    GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                                    GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                    if GenJournalLine.Amount <> 0 then
                                        GenJournalLine.Insert;

                                    TChargeAmount := TChargeAmount + ChargeAmount;
                                end;
                            end;
                        until TransactionCharges.Next = 0;
                    end;
                end;
            end;
        end;

        if ObjAccountType.Get("Account Type") then begin
            if Amount <= ObjAccountType."Bulk Withdrawal Amount" then begin
                if Account.Get("Account No") then begin
                    if Account."Staff Account" <> true then begin

                        //***Graduated Charge
                        ChargeAmount := 0;
                        if (VarTransactionType = VarTransactionType::Withdrawal) and "Use Graduated Charges" = true then begin
                            GraduatedCharge.Reset;
                            if GraduatedCharge.Find('-') then begin
                                repeat
                                    if (Amount >= GraduatedCharge."Minimum Amount") and (Amount <= GraduatedCharge."Maximum Amount") then begin
                                        if GraduatedCharge."Use Percentage" = true then begin
                                            ChargeAmount := Amount * (GraduatedCharge."Percentage of Amount" / 100)
                                        end else
                                            ChargeAmount := GraduatedCharge.Amount;
                                    end;
                                until GraduatedCharge.Next = 0;
                            end;
                        end;
                        Message('Normal Withdrawal Charge %1', ChargeAmount);
                        //ChargeAmount:=TransactionCharges."Charge Amount";
                        if (VarTransactionType = VarTransactionType::Withdrawal) and "Use Graduated Charges" = true then begin
                            if Account.Get("Account No") then begin
                                if Account."Staff Account" = false then begin
                                    Echarge := ChargeAmount;

                                    LineNo := LineNo + 10000;
                                    GenJournalLine.Init;
                                    GenJournalLine."Journal Template Name" := 'PURCHASES';
                                    GenJournalLine."Journal Batch Name" := 'FTRANS';
                                    GenJournalLine."Document No." := No;
                                    GenJournalLine."Line No." := LineNo;
                                    GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                    GenJournalLine."Account No." := "Account No";
                                    if "Account No" = '00-0000000000' then
                                        GenJournalLine."External Document No." := "ID No";
                                    GenJournalLine.Validate(GenJournalLine."Account No.");
                                    GenJournalLine."Posting Date" := "Transaction Date";
                                    GenJournalLine.Description := 'Cash Withdrawal Comission';
                                    GenJournalLine.Validate(GenJournalLine."Currency Code");
                                    //IF (TransactionCharges."Charge Code",'<>SD') AND (Amount > 20000)  THEN
                                    //ChargeAmount:=200 ELSE
                                    GenJournalLine.Amount := ChargeAmount;
                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                    GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                    GenJournalLine."Bal. Account No." := GraduatedCharge."Charge Account";
                                    GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                                    GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                                    GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                    if GenJournalLine.Amount <> 0 then
                                        GenJournalLine.Insert;

                                    TChargeAmount := TChargeAmount + ChargeAmount;



                                    ExciseDuty := (GenSetup."Excise Duty(%)" / 100) * ChargeAmount;

                                    //***Graduated Charge End

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
                                    GenJournalLine.Description := 'Excise Duty';
                                    GenJournalLine.Validate(GenJournalLine."Currency Code");
                                    GenJournalLine.Amount := (ChargeAmount * (GenSetup."Excise Duty(%)" / 100));
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

                                    //***Graduated Charge End

                                end;
                            end;
                        end;
                    end;
                end;
            end;
        end;



        GenSetup.Get();



        //***Graduated Charge With Notices
        ChargeAmount := 0;
        if ObjAccountType.Get("Account Type") then begin
            if Amount > ObjAccountType."Bulk Withdrawal Amount" then begin

                Message('Bulk Withdrawal Charge %1', ChargeAmount);
                //----------Get Notice Type--------------
                CalcFields("Total Amount Transacted Today");
                if ("Bulk Withdrawal Appl Done" = false) or ((Amount + "Total Amount Transacted Today") > "Bulk Withdrawal Appl Amount") then begin
                    VarNoticeType := Varnoticetype::"Without Notice"
                end else
                    if ("Bulk Withdrawal Appl Done" = true) or ((Amount + "Total Amount Transacted Today") <= "Bulk Withdrawal Appl Amount") then begin
                        VarNoticeType := Varnoticetype::"With Notice"
                    end;
                //---------End Get Notice Type------------

                if (VarTransactionType = VarTransactionType::Withdrawal) and "Use Graduated Charges" = true then begin
                    if ("Bulk Withdrawal Appl Done" = true) then begin
                        GraduatedCharge.Reset;
                        GraduatedCharge.SetRange(GraduatedCharge."Notice Status", VarNoticeType);
                        if GraduatedCharge.Find('-') then begin
                            repeat
                                if ((Amount) >= GraduatedCharge."Minimum Amount") and ((Amount) <= GraduatedCharge."Maximum Amount") then begin
                                    if GraduatedCharge."Use Percentage" = true then begin
                                        ChargeAmount := Amount * (GraduatedCharge."Percentage of Amount" / 100)
                                    end else
                                        ChargeAmount := GraduatedCharge.Amount;
                                end;
                            until GraduatedCharge.Next = 0;
                        end;
                    end;
                end;






                //ChargeAmount:=TransactionCharges."Charge Amount";
                if (VarTransactionType = VarTransactionType::Withdrawal) and "Use Graduated Charges" = true then begin
                    if Account.Get("Account No") then begin
                        if Account."Staff Account" = false then begin
                            Echarge := ChargeAmount;

                            LineNo := LineNo + 10000;
                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name" := 'PURCHASES';
                            GenJournalLine."Journal Batch Name" := 'FTRANS';
                            GenJournalLine."Document No." := No;
                            GenJournalLine."Line No." := LineNo;
                            GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                            GenJournalLine."Account No." := "Account No";
                            if "Account No" = '00-0000000000' then
                                GenJournalLine."External Document No." := "ID No";
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine."Posting Date" := "Transaction Date";
                            GenJournalLine.Description := 'Cash Withdrawal Comission';
                            GenJournalLine.Validate(GenJournalLine."Currency Code");
                            //IF (TransactionCharges."Charge Code",'<>SD') AND (Amount > 20000)  THEN
                            //ChargeAmount:=200 ELSE
                            GenJournalLine.Amount := ChargeAmount;
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                            GenJournalLine."Bal. Account No." := GraduatedCharge."Charge Account";
                            GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                            GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                            GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                            if GenJournalLine.Amount <> 0 then
                                GenJournalLine.Insert;

                            TChargeAmount := TChargeAmount + ChargeAmount;





                            ExciseDuty := (GenSetup."Excise Duty(%)" / 100) * ChargeAmount;

                            //***Graduated Charge End

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
                            GenJournalLine.Description := 'Excise Duty';
                            GenJournalLine.Validate(GenJournalLine."Currency Code");
                            GenJournalLine.Amount := (ChargeAmount * (GenSetup."Excise Duty(%)" / 100));
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

                        end;
                    end;
                end;
            end;
        end;







        //ABOVE 20K
        //Charges
        TCharges := 0;
        //IF Amount > 20000 THEN BEGIN

        TransactionCharges.Reset;
        TransactionCharges.SetRange(TransactionCharges."Transaction Type", "Transaction Type");
        TransactionCharges.SetRange(TransactionCharges."Charge Code", '0003');
        if TransactionCharges.Find('-') then begin
            //REPEAT
            LineNo := LineNo + 10000;

            LineNo := LineNo + 10000;

            ChargeAmount := 2;

            if Account.Get("Account No") then begin
                if Account."Staff Account" = false then begin
                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := 'PURCHASES';
                    GenJournalLine."Journal Batch Name" := 'FTRANS';
                    GenJournalLine."Document No." := No;
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                    GenJournalLine."Account No." := "Account No";
                    if "Account No" = '00-0000000000' then
                        GenJournalLine."External Document No." := "ID No";
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Posting Date" := "Transaction Date";
                    GenJournalLine.Description := 'Stamp Duty';
                    GenJournalLine.Validate(GenJournalLine."Currency Code");
                    GenJournalLine.Amount := ChargeAmount;
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                    GenJournalLine."Bal. Account No." := TransactionCharges."G/L Account";
                    GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                    GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                    GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;

                    TChargeAmount := TChargeAmount + ChargeAmount;

                    //UNTIL TransactionCharges.NEXT = 0;
                end;
            end;
            //Charges
        end;
        //END;
        //END;



        //ABOVE 20K
        //Charge withdrawal Freq
        if VarTransactionType = VarTransactionType::Withdrawal then begin
            if Account.Get("Account No") then begin
                if AccountTypes.Get(Account."Account Type") then begin
                    if Account."Last Withdrawal Date" = 0D then begin
                        Account."Last Withdrawal Date" := Today;
                        Account.Modify;
                    end else begin
                        if CalcDate(AccountTypes."Withdrawal Interval", Account."Last Withdrawal Date") > Today then begin
                            //IF CALCDATE(AccountTypes."Withdrawal Interval",Account."Last Withdrawal Date") <= CALCDATE('1D',TODAY) THEN BEGIN
                            LineNo := LineNo + 10000;

                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name" := 'PURCHASES';
                            GenJournalLine."Journal Batch Name" := 'FTRANS';
                            GenJournalLine."Document No." := No;
                            GenJournalLine."Line No." := LineNo;
                            GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                            GenJournalLine."Account No." := "Account No";
                            if "Account No" = '00-0000000000' then
                                GenJournalLine."External Document No." := "ID No";

                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine."Posting Date" := "Transaction Date";
                            GenJournalLine.Description := 'Commision on Withdrawal Freq.';
                            GenJournalLine.Validate(GenJournalLine."Currency Code");
                            GenJournalLine.Amount := AccountTypes."Withdrawal Penalty";
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                            GenJournalLine."Bal. Account No." := AccountTypes."Withdrawal Interval Account";
                            GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                            GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                            GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                            if GenJournalLine.Amount <> 0 then
                                GenJournalLine.Insert;

                        end;
                        Account."Last Withdrawal Date" := Today;
                        Account.Modify;

                    end;
                end;
            end;

            //NON-CUSTOMER CHARGE
            if "Account No" = '507-10000-00' then;
            //NON-CUSTOMER CHARGE

        end;
        //Charge withdrawal Freq


        //Charge Overdraft Comission
        if "Authorisation Requirement" = 'Over draft' then begin
            if ("Over Draft Type" = "over draft type"::AWD) and ("Excempt Charge" <> true) then begin
                Charges.Reset;
                Charges.SetRange(Charges.Code, 'AWD');
                if Charges.Find('-') then begin
                    if Charges."Use Percentage" = true then begin
                        OverDraftCharge := Amount * (Charges."Percentage of Amount" / 100);
                        OverDraftChargeAcc := Charges."GL Account"
                    end else
                        OverDraftCharge := Charges."Charge Amount";
                    OverDraftChargeAcc := Charges."GL Account"
                end;

                LineNo := LineNo + 10000;

                GenJournalLine.Init;
                GenJournalLine."Journal Template Name" := 'PURCHASES';
                GenJournalLine."Journal Batch Name" := 'FTRANS';
                GenJournalLine."Document No." := No;
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                GenJournalLine."Account No." := "Account No";
                GenJournalLine.Validate(GenJournalLine."Account No.");
                GenJournalLine."Posting Date" := "Transaction Date";
                GenJournalLine.Description := 'Commision on Overdraft';
                GenJournalLine.Validate(GenJournalLine."Currency Code");
                if AccountTypes.Get("Account Type") then begin
                    GenJournalLine.Amount := OverDraftCharge;
                end;
                GenJournalLine.Validate(GenJournalLine.Amount);
                GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                GenJournalLine."Bal. Account No." := OverDraftChargeAcc;
                GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                if GenJournalLine.Amount <> 0 then
                    GenJournalLine.Insert;


            end;
        end;

        //Charge Overdraft Comission
        if "Authorisation Requirement" = 'Over draft' then begin
            if ("Over Draft Type" = "over draft type"::LWD) and ("Excempt Charge" <> true) then begin
                Charges.Reset;
                Charges.SetRange(Charges.Code, 'LWD');
                if Charges.Find('-') then begin
                    if Charges."Use Percentage" = true then begin
                        OverDraftCharge := Amount * (Charges."Percentage of Amount" / 100);
                        if LoanType.Get("LWD Loan Product") then
                            //OverDraftChargeAcc:=Charges."GL Account"
                            OverDraftChargeAcc := LoanType."Loan Interest Account"
                    end else
                        OverDraftCharge := Charges."Charge Amount";
                    if LoanType.Get("LWD Loan Product") then
                        //OverDraftChargeAcc:=Charges."GL Account"
                        OverDraftChargeAcc := LoanType."Loan Interest Account"
                end;

                LineNo := LineNo + 10000;

                GenJournalLine.Init;
                GenJournalLine."Journal Template Name" := 'PURCHASES';
                GenJournalLine."Journal Batch Name" := 'FTRANS';
                GenJournalLine."Document No." := No;
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                GenJournalLine."Account No." := "Account No";
                GenJournalLine.Validate(GenJournalLine."Account No.");
                GenJournalLine."Posting Date" := "Transaction Date";
                GenJournalLine.Description := 'Commision on Overdraft';
                GenJournalLine.Validate(GenJournalLine."Currency Code");
                if AccountTypes.Get("Account Type") then begin
                    GenJournalLine.Amount := OverDraftCharge;
                end;
                GenJournalLine.Validate(GenJournalLine.Amount);
                GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                GenJournalLine."Bal. Account No." := OverDraftChargeAcc;
                GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                if GenJournalLine.Amount <> 0 then
                    GenJournalLine.Insert;


            end;
        end;










        //BOSA Entries
        //IF Type = 'Cash Deposit' THEN BEGIN
        if ("Account No" = '502-00-000300-00') or ("Account No" = '502-00-000303-00') then
            PostBOSAEntries();
        //END;


        //Post New
        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", 'PURCHASES');
        GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
        if GenJournalLine.Find('-') then begin
            Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
        end;
        //Post New


        "Transaction Available Balance" := AvailableBalance;
        Posted := true;
        Authorised := Authorised::Yes;
        "Supervisor Checked" := true;
        "Needs Approval" := "needs approval"::No;
        "Frequency Needs Approval" := "frequency needs approval"::No;
        "Date Posted" := Today;
        "Time Posted" := Time;
        "Posted By" := UserId;
        Modify;

        //Clear Bulk Withdrawal Details
        if Account.Get("Account No") and ("Transaction Date" = Today) then begin
            Account."Bulk Withdrawal App Done By" := '';
            Account."Bulk Withdrawal Appl Amount" := 0;
            Account."Bulk Withdrawal Appl Date" := 0D;
            Account."Bulk Withdrawal Appl Done" := false;
            Account."Bulk Withdrawal Fee" := 0;
            Account.Modify;
        end;
        //End Clear Bulk Withdrawal Details

        Trans.Reset;
        Trans.SetRange(Trans.No, No);
        if Trans.Find('-') then begin
            if VarTransactionType = VarTransactionType::"Cash Deposit" then
                Report.Run(50498, false, true, Trans)
            else
                if Type = 'BOSA Receipt' then
                    Report.Run(50516, false, true, Trans)
                else
                    if VarTransactionType = VarTransactionType::Withdrawal then
                        Report.Run(50499, false, true, Trans)
        end;


        CurrPage.Close;
    end;


    procedure PostBOSAEntries()
    var
        ReceiptAllocation: Record "Receipt Allocation";
    begin
        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", 'PURCHASES');
        GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
        GenJournalLine.DeleteAll;




        //BOSA Cash Book Entry
        if "Transaction Type" = 'RECEIPT' then begin


            LineNo := LineNo + 10000;

            GenJournalLine.Init;
            GenJournalLine."Journal Template Name" := 'PURCHASES';
            GenJournalLine."Journal Batch Name" := 'FTRANS';
            GenJournalLine."Document No." := No;
            GenJournalLine."External Document No." := "Cheque No";
            GenJournalLine."Line No." := LineNo;
            GenJournalLine."Account Type" := GenJournalLine."account type"::"Bank Account";
            GenJournalLine."Account No." := "Bank Account";
            GenJournalLine.Validate(GenJournalLine."Account No.");
            GenJournalLine."Posting Date" := "Document Date";
            GenJournalLine.Description := "Member Name";
            GenJournalLine.Validate(GenJournalLine."Currency Code");
            GenJournalLine.Amount := Amount;
            GenJournalLine.Validate(GenJournalLine.Amount);
            if GenJournalLine.Amount <> 0 then
                GenJournalLine.Insert;

            ReceiptAllocations.Reset;
            ReceiptAllocations.SetRange(ReceiptAllocations."Document No", No);
            if ReceiptAllocations.Find('-') then begin
                repeat
                    LineNo := LineNo + 10000;

                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := 'PURCHASES';
                    GenJournalLine."Journal Batch Name" := 'FTRANS';
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Document No." := No;
                    GenJournalLine."External Document No." := "Cheque No";
                    GenJournalLine."Posting Date" := "Document Date";
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Account Type" := ReceiptAllocations."Account Type";
                    if ReceiptAllocations."Account Type" <> ReceiptAllocations."account type"::Member then begin
                        GenJournalLine."Account No." := ReceiptAllocations."Account No"
                    end else
                        GenJournalLine."Account No." := ReceiptAllocations."Member No";
                    GenJournalLine."Transaction Type" := ReceiptAllocations."Transaction Type";
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine.Description := Format(ReceiptAllocations."Transaction Type");
                    GenJournalLine.Amount := -ReceiptAllocations.Amount;
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    GenJournalLine."Loan No" := ReceiptAllocations."Loan No.";
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;





                    //Generate Advice
                    if (ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"Registration Fee") then begin
                        if LoansR.Get(ReceiptAllocations."Loan No.") then begin
                            LoansR.CalcFields(LoansR."Outstanding Balance");
                            LoansR.Advice := true;
                            if ((LoansR."Outstanding Balance" - ReceiptAllocations.Amount) < LoansR."Loan Principle Repayment") then
                                LoansR."Advice Type" := LoansR."advice type"::Stoppage
                            else
                                LoansR."Advice Type" := LoansR."advice type"::Adjustment;
                            LoansR.Modify;
                        end;
                    end;
                //Generate Advice

                until ReceiptAllocations.Next = 0;
            end;
        end;


        //Post New
        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", 'PURCHASES');
        GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
        if GenJournalLine.Find('-') then begin
            Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
        end;
        Message('Transaction Posted Successfully!');
        //Post New


        Posted := true;
        Authorised := Authorised::Yes;
        "Supervisor Checked" := true;
        "Needs Approval" := "needs approval"::No;
        "Frequency Needs Approval" := "frequency needs approval"::No;
        "Date Posted" := Today;
        "Time Posted" := Time;
        "Posted By" := UserId;
        if ChequeTypes."Clearing  Days" = 0 then begin
            Status := Status::Honoured;
            "Cheque Processed" := true;
            "Date Cleared" := Today;
        end;

        Trans.Reset;
        Trans.SetRange(Trans.No, No);
        if Trans.Find('-') then begin
            Report.Run(50516, false, true, Trans);
            // REPORT.RUN(50486,FALSE,TRUE,Trans);
        end;
        Modify;

        CurrPage.Close;
    end;


    procedure PostChequeWith()
    begin
        //Block Payments
        if Acc.Get("Account No") then begin
            if Acc.Blocked = Acc.Blocked::Payment then
                Error('This account has been blocked from receiving payments.');
        end;
        //+++++++++++++++++++++++++++++Get the transaction type++++++++++++++++++++++++++++
        TransactionTypes.Reset();
        TransactionTypes.SetRange(TransactionTypes.Code, "Transaction Type");
        if TransactionTypes.Find('-') then begin
            VarTransactionType := TransactionTypes.Type;
        end;

        /*DValue.RESET;
        DValue.SETRANGE(DValue."Global Dimension No.",2);
        DValue.SETRANGE(DValue.Code,'Nairobi');
        //DValue.SETRANGE(DValue.Code,DBranch);
        IF DValue.FIND('-') THEN BEGIN
        DValue.TESTFIELD(DValue."Banker Cheque Account");
        ChBank:=DValue."Banker Cheque Account";
        END ELSE
        ERROR('Branch not set.');*/

        CalcAvailableBal;

        //Check withdrawal limits
        if VarTransactionType = VarTransactionType::"Cheque Deposit" then begin
            if AvailableBalance < Amount then begin
                if Authorised = Authorised::Yes then begin
                    Overdraft := true;
                    Modify;
                end;

                if Authorised = Authorised::No then begin
                    if "Branch Transaction" = false then begin
                        "Authorisation Requirement" := 'Cheque Withdrawal - Over draft';
                        Modify;
                        Message('You cannot issue a Cheque more than the available balance unless authorised.');
                        SendEmail;
                        exit;
                    end;
                end;
                if Authorised = Authorised::Rejected then
                    Error('Cheque Withdrawal transaction has been rejected and therefore cannot proceed.');
                //SendEmail;
            end;
        end;
        //Check withdrawal limits


        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", 'PURCHASES');
        GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
        GenJournalLine.DeleteAll;

        LineNo := LineNo + 10000;

        GenJournalLine.Init;
        GenJournalLine."Journal Template Name" := 'PURCHASES';
        GenJournalLine."Journal Batch Name" := 'FTRANS';
        GenJournalLine."Document No." := No;
        GenJournalLine."External Document No." := "Bankers Cheque No";
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
        GenJournalLine."Account No." := "Account No";
        GenJournalLine.Validate(GenJournalLine."Account No.");

        GenJournalLine."Posting Date" := "Transaction Date";
        if "Branch Transaction" = true then
            GenJournalLine.Description := "Transaction Type" + '-' + "Branch Refference"
        else
            GenJournalLine.Description := Payee; //"Transaction Description"+'-'+Description ;
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
        GenJournalLine."External Document No." := "Bankers Cheque No";
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Account Type" := GenJournalLine."account type"::"Bank Account";
        GenJournalLine."Account No." := "Cheque Clearing Bank Code";
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Posting Date" := "Transaction Date";
        GenJournalLine.Description := Payee;//"Account Name";
        GenJournalLine.Validate(GenJournalLine."Currency Code");
        GenJournalLine.Amount := -Amount;
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
        GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert;

        if Account.Get("Account No") then begin
            if Account."Staff Account" <> true then begin

                //Charges
                TransactionCharges.Reset;
                TransactionCharges.SetRange(TransactionCharges."Transaction Type", "Transaction Type");
                if TransactionCharges.Find('-') then begin
                    repeat
                        LineNo := LineNo + 10000;

                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := 'PURCHASES';
                        GenJournalLine."Journal Batch Name" := 'FTRANS';
                        GenJournalLine."Document No." := No;
                        GenJournalLine."External Document No." := "Bankers Cheque No";
                        GenJournalLine."Line No." := LineNo;
                        GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                        GenJournalLine."Account No." := TransactionCharges."G/L Account";
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Posting Date" := "Transaction Date";
                        GenJournalLine.Description := TransactionCharges.Description;
                        GenJournalLine.Validate(GenJournalLine."Currency Code");
                        GenJournalLine.Amount := TransactionCharges."Charge Amount" * -1;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                        GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                        GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;

                        if TransactionCharges."Due Amount" > 0 then begin
                            LineNo := LineNo + 10000;

                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name" := 'PURCHASES';
                            GenJournalLine."Journal Batch Name" := 'FTRANS';
                            GenJournalLine."Document No." := No;
                            GenJournalLine."External Document No." := "Bankers Cheque No";
                            GenJournalLine."Line No." := LineNo;
                            GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                            GenJournalLine."Account No." := TransactionCharges."G/L Account";
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine."Posting Date" := "Transaction Date";
                            GenJournalLine.Description := TransactionCharges.Description;
                            GenJournalLine.Validate(GenJournalLine."Currency Code");
                            GenJournalLine.Amount := TransactionCharges."Due Amount";
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"Bank Account";
                            GenJournalLine."Bal. Account No." := ChBank;
                            GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                            GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                            GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                            if GenJournalLine.Amount <> 0 then
                                GenJournalLine.Insert;


                        end;

                    until TransactionCharges.Next = 0;
                end;


                //Balancing Account
                //Charges
                TransactionCharges.Reset;
                TransactionCharges.SetRange(TransactionCharges."Transaction Type", "Transaction Type");
                if TransactionCharges.Find('-') then begin
                    TransactionCharges.CalcFields(TransactionCharges."Total Charges");
                    LineNo := LineNo + 10000;

                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := 'PURCHASES';
                    GenJournalLine."Journal Batch Name" := 'FTRANS';
                    GenJournalLine."Document No." := No;
                    GenJournalLine."External Document No." := "Bankers Cheque No";
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                    GenJournalLine."Account No." := "Account No";
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Posting Date" := "Transaction Date";
                    GenJournalLine.Description := TransactionCharges.Description;
                    GenJournalLine.Validate(GenJournalLine."Currency Code");
                    GenJournalLine.Amount := TransactionCharges."Total Charges";
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    //GenJournalLine."Bal. Account Type":=GenJournalLine."Bal. Account Type"::"Bank Account";
                    //GenJournalLine."Bal. Account No.":=ChBank;
                    //GenJournalLine.VALIDATE(GenJournalLine."Bal. Account No.");
                    GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                    GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;
                end;
            end;
        end;

        //Charge Overdraft Comission
        if "Authorisation Requirement" = 'Over draft' then begin
            if ("Over Draft Type" = "over draft type"::AWD) and ("Excempt Charge" <> true) then begin
                Charges.Reset;
                Charges.SetRange(Charges.Code, 'AWD');
                if Charges.Find('-') then begin
                    if Charges."Use Percentage" = true then begin
                        OverDraftCharge := Amount * (Charges."Percentage of Amount" / 100);
                        OverDraftChargeAcc := Charges."GL Account"
                    end else
                        OverDraftCharge := Charges."Charge Amount";
                    OverDraftChargeAcc := Charges."GL Account"
                end;

                LineNo := LineNo + 10000;

                GenJournalLine.Init;
                GenJournalLine."Journal Template Name" := 'PURCHASES';
                GenJournalLine."Journal Batch Name" := 'FTRANS';
                GenJournalLine."Document No." := No;
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                GenJournalLine."Account No." := "Account No";
                GenJournalLine.Validate(GenJournalLine."Account No.");
                GenJournalLine."Posting Date" := "Transaction Date";
                GenJournalLine.Description := 'Commision on Overdraft';
                GenJournalLine.Validate(GenJournalLine."Currency Code");
                if AccountTypes.Get("Account Type") then begin
                    GenJournalLine.Amount := OverDraftCharge;
                end;
                GenJournalLine.Validate(GenJournalLine.Amount);
                GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                GenJournalLine."Bal. Account No." := OverDraftChargeAcc;
                GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                if GenJournalLine.Amount <> 0 then
                    GenJournalLine.Insert;
            end;
        end;


        //Charge Overdraft Comission
        if "Authorisation Requirement" = 'Over draft' then begin
            if ("Over Draft Type" = "over draft type"::LWD) and ("Excempt Charge" <> true) then begin
                Charges.Reset;
                Charges.SetRange(Charges.Code, 'OVERDRAFT');
                if Charges.Find('-') then begin
                    if Charges."Use Percentage" = true then begin
                        OverDraftCharge := Amount * (Charges."Percentage of Amount" / 100);
                        if LoanType.Get("LWD Loan Product") then
                            //OverDraftChargeAcc:=Charges."GL Account"
                            OverDraftChargeAcc := LoanType."Loan Interest Account"
                    end else
                        OverDraftCharge := Charges."Charge Amount";
                    if LoanType.Get("LWD Loan Product") then
                        //OverDraftChargeAcc:=Charges."GL Account"
                        OverDraftChargeAcc := LoanType."Loan Interest Account"
                end;

                LineNo := LineNo + 10000;

                GenJournalLine.Init;
                GenJournalLine."Journal Template Name" := 'PURCHASES';
                GenJournalLine."Journal Batch Name" := 'FTRANS';
                GenJournalLine."Document No." := No;
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                GenJournalLine."Account No." := "Account No";
                GenJournalLine.Validate(GenJournalLine."Account No.");
                GenJournalLine."Posting Date" := "Transaction Date";
                GenJournalLine.Description := 'Commision on Overdraft';
                GenJournalLine.Validate(GenJournalLine."Currency Code");
                if AccountTypes.Get("Account Type") then begin
                    GenJournalLine.Amount := OverDraftCharge;
                end;
                GenJournalLine.Validate(GenJournalLine.Amount);
                GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                GenJournalLine."Bal. Account No." := OverDraftChargeAcc;
                GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                if GenJournalLine.Amount <> 0 then
                    GenJournalLine.Insert;
            end;
        end;

        //Post New
        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", 'PURCHASES');
        GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
        if GenJournalLine.Find('-') then begin
            Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
        end;

        //Post New


        "Transaction Available Balance" := AvailableBalance;
        Posted := true;
        Authorised := Authorised::Yes;
        "Supervisor Checked" := true;
        "Needs Approval" := "needs approval"::No;
        "Frequency Needs Approval" := "frequency needs approval"::No;
        "Date Posted" := Today;
        "Time Posted" := Time;
        "Posted By" := UserId;
        Modify;
        /*IF CONFIRM('Are you sure you want to print this bankers cheque?',TRUE)=TRUE THEN BEGIN
        REPORT.RUN(,TRUE,TRUE,Trans)
        END;*/


        //Mark Cheque Book
        ChequeRegister.Reset;
        ChequeRegister.SetRange(ChequeRegister."Cheque No.", "Bankers Cheque No");
        if ChequeRegister.Find('-') then begin
            ChequeRegister.Issued := true;
            ChequeRegister.Modify;
        end;

        Message('Cheque Withdrawal posted successfully.');
        CurrPage.Close;

    end;


    procedure SuggestBOSAEntries()
    begin
        TestField(Posted, false);
        TestField("BOSA Account No");

        ReceiptAllocations.Reset;
        ReceiptAllocations.SetRange(ReceiptAllocations."Document No", No);
        ReceiptAllocations.DeleteAll;

        PaymentAmount := Amount;
        RunBal := PaymentAmount;

        Loans.Reset;
        Loans.SetCurrentkey(Loans.Source, Loans."Client Code");
        Loans.SetRange(Loans."Client Code", "BOSA Account No");
        Loans.SetRange(Loans.Source, Loans.Source::" ");
        if Loans.Find('-') then begin
            repeat
                Loans.CalcFields(Loans."Outstanding Balance", Loans."Interest Due");
                Recover := true;

                if (Loans."Outstanding Balance") > 0 then begin
                    if ((Loans."Outstanding Balance" - Loans."Loan Principle Repayment") <= 0) and (Cheque = false) then
                        Recover := false;

                    if Recover = true then begin

                        Commision := 0;
                        if Cheque = true then begin
                            Commision := (Loans."Outstanding Balance") * 0.1;
                            LOustanding := Loans."Outstanding Balance";
                            if Loans."Interest Due" > 0 then
                                InterestPaid := Loans."Interest Due";
                        end else begin
                            LOustanding := (Loans."Outstanding Balance" - Loans."Loan Principle Repayment");
                            if LOustanding < 0 then
                                LOustanding := 0;
                            if Loans."Interest Due" > 0 then
                                InterestPaid := Loans."Interest Due";
                            if (Loans."Outstanding Balance" - Loans."Loan Principle Repayment") > 0 then begin
                                if (Loans."Outstanding Balance" - Loans."Loan Principle Repayment") > (Loans."Approved Amount" * 1 / 3) then
                                    Commision := LOustanding * 0.1;
                            end;
                        end;

                        if PaymentAmount > 0 then begin
                            if RunBal < (LOustanding + Commision + InterestPaid) then begin
                                if RunBal < InterestPaid then
                                    InterestPaid := RunBal;
                                //Commision:=(RunBal-InterestPaid)*0.1;
                                Commision := (RunBal - InterestPaid) - ((RunBal - InterestPaid) / 1.1);
                                LOustanding := (RunBal - InterestPaid) - Commision;

                            end;
                        end;


                        TotalCommision := TotalCommision + Commision;
                        TotalOustanding := TotalOustanding + LOustanding + InterestPaid + Commision;

                        RunBal := RunBal - (LOustanding + InterestPaid + Commision);

                        if (LOustanding + InterestPaid) > 0 then begin
                            ReceiptAllocations.Init;
                            ReceiptAllocations."Document No" := No;
                            ReceiptAllocations."Member No" := "BOSA Account No";
                            ReceiptAllocations."Transaction Type" := ReceiptAllocations."transaction type"::"Registration Fee";
                            ReceiptAllocations."Loan No." := Loans."Loan  No.";
                            ReceiptAllocations.Amount := ROUND(LOustanding, 0.01);
                            ReceiptAllocations."Interest Amount" := ROUND(InterestPaid, 0.01);
                            ReceiptAllocations."Total Amount" := ReceiptAllocations.Amount + ReceiptAllocations."Interest Amount";
                            ReceiptAllocations.Insert;
                        end;

                        if Commision > 0 then begin
                            ReceiptAllocations.Init;
                            ReceiptAllocations."Document No" := No;
                            ReceiptAllocations."Member No" := "BOSA Account No";
                            ReceiptAllocations."Transaction Type" := ReceiptAllocations."transaction type"::"Interest Paid";
                            ReceiptAllocations."Loan No." := Loans."Loan  No.";
                            ReceiptAllocations.Amount := ROUND(Commision, 0.01);
                            ReceiptAllocations."Interest Amount" := 0;
                            ReceiptAllocations."Total Amount" := ReceiptAllocations.Amount + ReceiptAllocations."Interest Amount";
                            ReceiptAllocations.Insert;
                        end;

                    end;
                end;

            until Loans.Next = 0;
        end;

        if RunBal > 0 then begin
            ReceiptAllocations.Init;
            ReceiptAllocations."Document No" := No;
            ReceiptAllocations."Member No" := "BOSA Account No";
            ReceiptAllocations."Transaction Type" := ReceiptAllocations."transaction type"::"Benevolent Fund";
            ReceiptAllocations."Loan No." := '';
            ReceiptAllocations.Amount := RunBal;
            ReceiptAllocations."Interest Amount" := 0;
            ReceiptAllocations."Total Amount" := ReceiptAllocations.Amount + ReceiptAllocations."Interest Amount";
            ReceiptAllocations.Insert;

        end;
    end;


    procedure SendEmail()
    begin
        /*
        //send e-mail to supervisor
        supervisor.RESET;
        supervisor.SETFILTER(supervisor."Transaction Type",'withdrawal');
        IF supervisor.FIND('-') THEN BEGIN
         // MailContent:=TEXT1;
        REPEAT
        
         genSetup.GET(0);
         SMTPMAIL.NewMessage(genSetup."Sender Address",'Transactions' +''+'');
         SMTPMAIL.SetWorkMode();
         SMTPMAIL.ClearAttachments();
         SMTPMAIL.ClearAllRecipients();
         SMTPMAIL.SetDebugMode();
         SMTPMAIL.SetFromAdress(genSetup."Sender Address");
         SMTPMAIL.SetHost(genSetup."Outgoing Mail Server");
         SMTPMAIL.SetUserID(genSetup."Sender User ID");
         SMTPMAIL.AddLine(MailContent);
         SMTPMAIL.SetToAdress(supervisor."E-mail Address");
         SMTPMAIL.Send;
         UNTIL supervisor.NEXT=0;
        END;
        */

    end;


    procedure PostBankersChequeVer1()
    var
        ObjCharges: Record Charges;
        VarChargeAmount: Decimal;
        VarChargeAccount: Code[20];
        VarChargeAmountTax: Decimal;
        VarChargeTaxAccount: Code[20];
    begin
        //Block Payments
        if Acc.Get("Account No") then begin
            if Acc.Blocked = Acc.Blocked::Payment then
                Error('This account has been blocked from receiving payments.');
        end;

        //+++++++++++++++++++++++++++++Get the transaction type++++++++++++++++++++++++++++
        TransactionTypes.Reset();
        TransactionTypes.SetRange(TransactionTypes.Code, "Transaction Type");
        if TransactionTypes.Find('-') then begin
            VarTransactionType := TransactionTypes.Type;
        end;
        /*DValue.RESET;
        DValue.SETRANGE(DValue."Global Dimension No.",2);
        DValue.SETRANGE(DValue.Code,'Nairobi');
        //DValue.SETRANGE(DValue.Code,DBranch);
        IF DValue.FIND('-') THEN BEGIN
        DValue.TESTFIELD(DValue."Banker Cheque Account");
        ChBank:=DValue."Banker Cheque Account";
        END ELSE
        ERROR('Branch not set.');*/

        CalcAvailableBal;

        //Check withdrawal limits
        if VarTransactionType = VarTransactionType::"Bankers Cheque" then begin
            if AvailableBalance < Amount then begin
                if Authorised = Authorised::Yes then begin
                    Overdraft := true;
                    Modify;
                end;

                if Authorised = Authorised::No then begin
                    if "Branch Transaction" = false then begin
                        "Authorisation Requirement" := 'Cheque Withdrawal - Over draft';
                        Modify;
                        Message('You cannot issue a Cheque more than the available balance unless authorised.');
                        SendEmail;
                        exit;
                    end;
                end;
                if Authorised = Authorised::Rejected then
                    Error('Cheque Withdrawal transaction has been rejected and therefore cannot proceed.');
                //SendEmail;
            end;
        end;
        //Check withdrawal limits


        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", 'PURCHASES');
        GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
        GenJournalLine.DeleteAll;

        LineNo := LineNo + 10000;

        GenJournalLine.Init;
        GenJournalLine."Journal Template Name" := 'PURCHASES';
        GenJournalLine."Journal Batch Name" := 'FTRANS';
        GenJournalLine."Document No." := No;
        GenJournalLine."External Document No." := "Bankers Cheque No";
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
        GenJournalLine."Account No." := "Account No";
        GenJournalLine.Validate(GenJournalLine."Account No.");

        GenJournalLine."Posting Date" := "Transaction Date";
        if "Branch Transaction" = true then
            GenJournalLine.Description := "Transaction Type" + '-' + "Branch Refference"
        else
            GenJournalLine.Description := "Transaction Type" + '-' + Payee; //"Transaction Description"+'-'+Description ;
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
        GenJournalLine."External Document No." := "Bankers Cheque No";
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Account Type" := GenJournalLine."account type"::"Bank Account";
        GenJournalLine."Account No." := "Cheque Clearing Bank Code";
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Posting Date" := "Transaction Date";
        GenJournalLine.Description := Payee;//"Account Name";
        GenJournalLine.Validate(GenJournalLine."Currency Code");
        GenJournalLine.Amount := -Amount;
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
        GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert;

        if Account.Get("Account No") then begin
            if Account."Staff Account" <> true then begin

                //Charges
                ObjCharges.Reset;
                ObjCharges.SetRange(ObjCharges."Charge Type", ObjCharges."charge type"::"Bankers Cheque Fee");
                if ObjCharges.Find('-') then begin
                    if ObjCharges."Use Percentage" = false then begin
                        VarChargeAmount := ObjCharges."Charge Amount";
                        VarChargeAccount := ObjCharges."GL Account"
                    end else
                        if ObjCharges."Use Percentage" = true then begin
                            VarChargeAmount := (ObjCharges."Percentage of Amount" / 100) * Amount;
                            VarChargeAccount := ObjCharges."GL Account"
                        end;

                    LineNo := LineNo + 10000;

                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := 'PURCHASES';
                    GenJournalLine."Journal Batch Name" := 'FTRANS';
                    GenJournalLine."Document No." := No;
                    GenJournalLine."External Document No." := "Bankers Cheque No";
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                    GenJournalLine."Account No." := VarChargeAccount;
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Posting Date" := "Transaction Date";
                    GenJournalLine.Description := "Transaction Type" + ' Charge';
                    GenJournalLine.Validate(GenJournalLine."Currency Code");
                    GenJournalLine.Amount := VarChargeAmount * -1;
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                    GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                    GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;

                end;




                //Balancing Account
                //Charges
                ObjCharges.Reset;
                ObjCharges.SetRange(ObjCharges."Charge Type", ObjCharges."charge type"::"Bankers Cheque Fee");
                if ObjCharges.Find('-') then begin
                    if ObjCharges."Use Percentage" = false then begin
                        VarChargeAmount := ObjCharges."Charge Amount";
                        VarChargeAccount := ObjCharges."GL Account"
                    end else
                        if ObjCharges."Use Percentage" = true then begin
                            VarChargeAmount := (ObjCharges."Percentage of Amount" / 100) * Amount;
                            VarChargeAccount := ObjCharges."GL Account"
                        end;

                    LineNo := LineNo + 10000;

                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := 'PURCHASES';
                    GenJournalLine."Journal Batch Name" := 'FTRANS';
                    GenJournalLine."Document No." := No;
                    GenJournalLine."External Document No." := "Bankers Cheque No";
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                    GenJournalLine."Account No." := "Account No";
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Posting Date" := "Transaction Date";
                    GenJournalLine.Description := "Transaction Type" + ' Charge';
                    GenJournalLine.Validate(GenJournalLine."Currency Code");
                    GenJournalLine.Amount := VarChargeAmount;
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    //GenJournalLine."Bal. Account Type":=GenJournalLine."Bal. Account Type"::"Bank Account";
                    //GenJournalLine."Bal. Account No.":=ChBank;
                    //GenJournalLine.VALIDATE(GenJournalLine."Bal. Account No.");
                    GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                    GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;
                end;
            end;
        end;

        //Charge Overdraft Comission
        if "Authorisation Requirement" = 'Over draft' then begin
            if ("Over Draft Type" = "over draft type"::AWD) and ("Excempt Charge" <> true) then begin
                Charges.Reset;
                Charges.SetRange(Charges.Code, 'AWD');
                if Charges.Find('-') then begin
                    if Charges."Use Percentage" = true then begin
                        OverDraftCharge := Amount * (Charges."Percentage of Amount" / 100);
                        OverDraftChargeAcc := Charges."GL Account"
                    end else
                        OverDraftCharge := Charges."Charge Amount";
                    OverDraftChargeAcc := Charges."GL Account"
                end;

                LineNo := LineNo + 10000;

                GenJournalLine.Init;
                GenJournalLine."Journal Template Name" := 'PURCHASES';
                GenJournalLine."Journal Batch Name" := 'FTRANS';
                GenJournalLine."Document No." := No;
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                GenJournalLine."Account No." := "Account No";
                GenJournalLine.Validate(GenJournalLine."Account No.");
                GenJournalLine."Posting Date" := "Transaction Date";
                GenJournalLine.Description := 'Commision on Overdraft';
                GenJournalLine.Validate(GenJournalLine."Currency Code");
                if AccountTypes.Get("Account Type") then begin
                    GenJournalLine.Amount := OverDraftCharge;
                end;
                GenJournalLine.Validate(GenJournalLine.Amount);
                GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                GenJournalLine."Bal. Account No." := OverDraftChargeAcc;
                GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                if GenJournalLine.Amount <> 0 then
                    GenJournalLine.Insert;
            end;
        end;


        //Charge Overdraft Comission
        if "Authorisation Requirement" = 'Over draft' then begin
            if ("Over Draft Type" = "over draft type"::LWD) and ("Excempt Charge" <> true) then begin
                Charges.Reset;
                Charges.SetRange(Charges.Code, 'OVERDRAFT');
                if Charges.Find('-') then begin
                    if Charges."Use Percentage" = true then begin
                        OverDraftCharge := Amount * (Charges."Percentage of Amount" / 100);
                        if LoanType.Get("LWD Loan Product") then
                            //OverDraftChargeAcc:=Charges."GL Account"
                            OverDraftChargeAcc := LoanType."Loan Interest Account"
                    end else
                        OverDraftCharge := Charges."Charge Amount";
                    if LoanType.Get("LWD Loan Product") then
                        //OverDraftChargeAcc:=Charges."GL Account"
                        OverDraftChargeAcc := LoanType."Loan Interest Account"
                end;

                LineNo := LineNo + 10000;

                GenJournalLine.Init;
                GenJournalLine."Journal Template Name" := 'PURCHASES';
                GenJournalLine."Journal Batch Name" := 'FTRANS';
                GenJournalLine."Document No." := No;
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                GenJournalLine."Account No." := "Account No";
                GenJournalLine.Validate(GenJournalLine."Account No.");
                GenJournalLine."Posting Date" := "Transaction Date";
                GenJournalLine.Description := 'Commision on Overdraft';
                GenJournalLine.Validate(GenJournalLine."Currency Code");
                if AccountTypes.Get("Account Type") then begin
                    GenJournalLine.Amount := OverDraftCharge;
                end;
                GenJournalLine.Validate(GenJournalLine.Amount);
                GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                GenJournalLine."Bal. Account No." := OverDraftChargeAcc;
                GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                if GenJournalLine.Amount <> 0 then
                    GenJournalLine.Insert;
            end;
        end;

        GenSetup.Get();
        //Excise Duty
        ObjCharges.Reset;
        ObjCharges.SetRange(ObjCharges."Charge Type", ObjCharges."charge type"::"Bankers Cheque Fee");
        if ObjCharges.Find('-') then begin
            if ObjCharges."Use Percentage" = false then begin
                VarChargeAmountTax := ObjCharges."Charge Amount" * (GenSetup."Excise Duty(%)" / 100);
                VarChargeTaxAccount := GenSetup."Excise Duty Account";
            end else
                if ObjCharges."Use Percentage" = true then begin
                    VarChargeAmount := (ObjCharges."Percentage of Amount" / 100) * Amount;
                    VarChargeAmountTax := VarChargeAmount * (GenSetup."Excise Duty(%)" / 100);
                    VarChargeTaxAccount := GenSetup."Excise Duty Account";
                end;
            LineNo := LineNo + 10000;

            GenJournalLine.Init;
            GenJournalLine."Journal Template Name" := 'PURCHASES';
            GenJournalLine."Journal Batch Name" := 'FTRANS';
            GenJournalLine."Document No." := No;
            GenJournalLine."External Document No." := "Bankers Cheque No";
            GenJournalLine."Line No." := LineNo;
            GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
            GenJournalLine."Account No." := "Account No";
            GenJournalLine.Validate(GenJournalLine."Account No.");
            GenJournalLine."Posting Date" := "Transaction Date";
            GenJournalLine.Description := 'Excise Duty';
            GenJournalLine.Validate(GenJournalLine."Currency Code");
            GenJournalLine.Amount := VarChargeAmountTax;
            GenJournalLine.Validate(GenJournalLine.Amount);
            GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
            GenJournalLine."Bal. Account No." := VarChargeTaxAccount;
            GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
            GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
            GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
            if GenJournalLine.Amount <> 0 then
                GenJournalLine.Insert;
        end;


        //Post New
        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", 'PURCHASES');
        GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
        if GenJournalLine.Find('-') then begin
            Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
        end;

        //Post New


        "Transaction Available Balance" := AvailableBalance;
        Posted := true;
        Authorised := Authorised::Yes;
        "Supervisor Checked" := true;
        "Needs Approval" := "needs approval"::No;
        "Frequency Needs Approval" := "frequency needs approval"::No;
        "Date Posted" := Today;
        "Time Posted" := Time;
        "Posted By" := UserId;
        Modify;
        /*IF CONFIRM('Are you sure you want to print this bankers cheque?',TRUE)=TRUE THEN BEGIN
        REPORT.RUN(,TRUE,TRUE,Trans)
        END;*/


        //Mark Cheque Book
        ChequeRegister.Reset;
        ChequeRegister.SetRange(ChequeRegister."Cheque No.", "Bankers Cheque No");
        if ChequeRegister.Find('-') then begin
            ChequeRegister.Issued := true;
            ChequeRegister.Modify;
        end;

        Message('Cheque Withdrawal posted successfully.');

    end;

    local procedure FnShowFields()
    begin
        HasSpecialMandateVisible := false;
        TransactingAgentVisible := false;
        TransactingAgentNameVisible := false;
        ReceiptAllVisible := false;

        ObjAccountAgents.Reset;
        ObjAccountAgents.SetRange(ObjAccountAgents."Account No", "Account No");
        if ObjAccountAgents.FindSet = true then begin
            HasSpecialMandateVisible := true;
            TransactingAgentVisible := true;
            TransactingAgentNameVisible := true;
        end;


        if "Transaction Type" = 'RECEIPT' then begin
            ReceiptAllVisible := true;
        end;
    end;

    local procedure AllocatedAmountOnDeactivate()
    begin
        CurrPage.Update := true;
    end;

    local procedure FnRunInsurance(ObjRcptBuffer: Record Transactions; RunningBalance: Decimal): Decimal
    var
        AmountToDeduct: Decimal;
        ObjReceiptTransactions: Record "Receipt Allocation";
    begin
        if RunningBalance > 0 then begin
            LoanApp.Reset;
            LoanApp.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
            LoanApp.SetRange(LoanApp."Client Code", ObjRcptBuffer."Member No");
            LoanApp.SetFilter(LoanApp."Date filter", Datefilter);
            if LoanApp.Find('-') then begin
                repeat
                    LoanApp.CalcFields(LoanApp."Outstanding Insurance");
                    if LoanApp."Outstanding Insurance" > 0 then begin
                        if RunningBalance > 0 then begin
                            AmountToDeduct := 0;
                            AmountToDeduct := ROUND(LoanApp."Outstanding Insurance", 0.05, '>');
                            if RunningBalance <= AmountToDeduct then
                                AmountToDeduct := RunningBalance;
                            ObjReceiptTransactions.Init;
                            ObjReceiptTransactions."Document No" := ObjRcptBuffer.No;
                            ObjReceiptTransactions."Member No" := ObjRcptBuffer."Member No";
                            ObjReceiptTransactions."Account Type" := ObjReceiptTransactions."account type"::Member;
                            ObjReceiptTransactions."Account No" := ObjRcptBuffer."Member No";
                            ObjReceiptTransactions."Loan No." := LoanApp."Loan  No.";
                            ObjReceiptTransactions."Transaction Type" := ObjReceiptTransactions."transaction type"::"Loan Insurance Paid";
                            ObjReceiptTransactions."Global Dimension 1 Code" := 'BOSA';
                            ObjReceiptTransactions."Global Dimension 2 Code" := SURESTEPFactory.FnGetMemberBranch(ObjRcptBuffer."Member No");
                            ObjReceiptTransactions.Amount := AmountToDeduct;
                            if ObjReceiptTransactions.Amount > 0 then
                                ObjReceiptTransactions.Insert(true);
                            RunningBalance := RunningBalance - Abs(ObjReceiptTransactions.Amount);
                        end;
                    end;
                until LoanApp.Next = 0;
            end;
            exit(RunningBalance);
        end;
    end;

    local procedure FnRunInterest(ObjRcptBuffer: Record Transactions; RunningBalance: Decimal): Decimal
    var
        AmountToDeduct: Decimal;
        ObjReceiptTransactions: Record "Receipt Allocation";
    begin
        if RunningBalance > 0 then begin
            LoanApp.Reset;
            LoanApp.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
            LoanApp.SetRange(LoanApp."Client Code", ObjRcptBuffer."Member No");
            LoanApp.SetFilter(LoanApp."Date filter", Datefilter);
            if LoanApp.Find('-') then begin
                repeat
                    LoanApp.CalcFields(LoanApp."Outstanding Interest", LoanApp."Outstanding Balance");
                    if (LoanApp."Outstanding Balance" * LoanApp.Interest / 1200) > 0 then begin
                        if RunningBalance > 0 then begin
                            AmountToDeduct := 0;
                            AmountToDeduct := ROUND((LoanApp."Outstanding Balance" * LoanApp.Interest / 1200), 0.05, '>');
                            if RunningBalance <= AmountToDeduct then
                                AmountToDeduct := RunningBalance;
                            ObjReceiptTransactions.Init;
                            ObjReceiptTransactions."Document No" := ObjRcptBuffer.No;
                            ObjReceiptTransactions."Member No" := ObjRcptBuffer."Member No";
                            ObjReceiptTransactions."Account No" := ObjRcptBuffer."Member No";
                            ObjReceiptTransactions."Account Type" := ObjReceiptTransactions."account type"::Member;
                            ObjReceiptTransactions."Loan No." := LoanApp."Loan  No.";
                            ObjReceiptTransactions."Transaction Type" := ObjReceiptTransactions."transaction type"::"Interest Paid";
                            ObjReceiptTransactions."Global Dimension 1 Code" := 'BOSA';
                            ObjReceiptTransactions."Global Dimension 2 Code" := SURESTEPFactory.FnGetMemberBranch(ObjRcptBuffer."Member No");
                            ObjReceiptTransactions.Amount := AmountToDeduct;
                            if ObjReceiptTransactions.Amount > 0 then
                                ObjReceiptTransactions.Insert(true);
                            RunningBalance := RunningBalance - Abs(ObjReceiptTransactions.Amount);
                        end;
                    end;
                until LoanApp.Next = 0;
            end;
            exit(RunningBalance);
        end;
    end;

    local procedure FnRunLoanInsurance(ObjRcptBuffer: Record Transactions; RunningBalance: Decimal): Decimal
    var
        INSAmountToDeduct: Decimal;
        ObjReceiptTransactions: Record "Receipt Allocation";
    begin
        if RunningBalance > 0 then begin
            LoanApp.Reset;
            LoanApp.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
            LoanApp.SetRange(LoanApp."Client Code", ObjRcptBuffer."Member No");
            LoanApp.SetFilter(LoanApp."Date filter", Datefilter);
            if LoanApp.Find('-') then begin
                repeat
                    LoanApp.CalcFields(LoanApp."Outstanding Interest", LoanApp."Outstanding Balance");
                    if (LoanApp."Outstanding Balance") > 0 then begin
                        if RunningBalance > 0 then begin
                            ObjProductCharge.Reset;
                            ObjProductCharge.SetRange(ObjProductCharge."Product Code", LoanApp."Loan Product Type");
                            ObjProductCharge.SetRange(ObjProductCharge."Loan Charge Type", ObjProductCharge."loan charge type"::"Loan Insurance");
                            if ObjProductCharge.FindSet then begin
                                //MESSAGE('Insurance Perc. is %1',ObjProductCharge.Percentage);
                                INSAmountToDeduct := ROUND(((LoanApp."Approved Amount" * ObjProductCharge.Percentage / 100)), 0.05, '>');
                            end;
                            //INSAmountToDeduct:=0;

                            if RunningBalance <= INSAmountToDeduct then
                                INSAmountToDeduct := RunningBalance;
                            ObjReceiptTransactions.Init;
                            ObjReceiptTransactions."Document No" := ObjRcptBuffer.No;
                            ObjReceiptTransactions."Member No" := ObjRcptBuffer."Member No";
                            ObjReceiptTransactions."Account No" := ObjRcptBuffer."Member No";
                            ObjReceiptTransactions."Account Type" := ObjReceiptTransactions."account type"::Member;
                            ObjReceiptTransactions."Loan No." := LoanApp."Loan  No.";
                            ObjReceiptTransactions."Transaction Type" := ObjReceiptTransactions."transaction type"::"Loan Insurance Paid";
                            ObjReceiptTransactions."Global Dimension 1 Code" := 'BOSA';
                            ObjReceiptTransactions."Global Dimension 2 Code" := SURESTEPFactory.FnGetMemberBranch(ObjRcptBuffer."Member No");
                            ObjReceiptTransactions.Amount := INSAmountToDeduct;
                            if ObjReceiptTransactions.Amount > 0 then
                                ObjReceiptTransactions.Insert(true);
                            RunningBalance := RunningBalance - Abs(ObjReceiptTransactions.Amount);
                        end;
                    end;
                until LoanApp.Next = 0;
            end;
            exit(RunningBalance);
        end;
    end;

    local procedure FnRunPrinciple(ObjRcptBuffer: Record Transactions; RunningBalance: Decimal): Decimal
    var
        AmountToDeduct: Decimal;
        ObjReceiptTransactions: Record "Receipt Allocation";
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayment: Decimal;
        PRpayment: Decimal;
        INSAmountToDeduct: Decimal;
    begin
        if RunningBalance > 0 then begin
            varTotalRepay := 0;
            varMultipleLoan := 0;

            LoanApp.Reset;
            LoanApp.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
            LoanApp.SetRange(LoanApp."Client Code", ObjRcptBuffer."Member No");
            LoanApp.SetFilter(LoanApp."Date filter", Datefilter);

            if LoanApp.Find('-') then begin
                repeat

                    if RunningBalance > 0 then begin
                        LoanApp.CalcFields(LoanApp."Outstanding Balance", "Oustanding Interest to Date");
                        if LoanApp."Outstanding Balance" > 0 then begin
                            varLRepayment := 0;
                            PRpayment := 0;
                            PRpayment := LoanApp."Oustanding Interest to Date";
                            VarMonthlyInt := (LoanApp."Outstanding Balance" * LoanApp.Interest / 1200);

                            ObjProductCharge.Reset;
                            ObjProductCharge.SetRange(ObjProductCharge."Product Code", LoanApp."Loan Product Type");
                            ObjProductCharge.SetRange(ObjProductCharge."Loan Charge Type", ObjProductCharge."loan charge type"::"Loan Insurance");
                            if ObjProductCharge.FindSet then begin
                                INSAmountToDeduct := ROUND(((LoanApp."Approved Amount" * ObjProductCharge.Percentage / 100)), 0.05, '>');
                            end;

                            varLRepayment := LoanApp.Repayment - (VarMonthlyInt + INSAmountToDeduct);
                            if LoanApp."Loan Product Type" = 'GUR' then
                                varLRepayment := LoanApp.Repayment;
                            if varLRepayment > 0 then begin
                                if varLRepayment > LoanApp."Outstanding Balance" then
                                    varLRepayment := LoanApp."Outstanding Balance";

                                if RunningBalance > 0 then begin
                                    if RunningBalance > varLRepayment then begin
                                        ObjReceiptTransactions.Amount := varLRepayment;
                                    end
                                    else
                                        ObjReceiptTransactions.Amount := RunningBalance;
                                end;
                                ObjReceiptTransactions.Init;
                                ObjReceiptTransactions."Document No" := ObjRcptBuffer.No;
                                ObjReceiptTransactions."Loan No." := LoanApp."Loan  No.";
                                ObjReceiptTransactions."Member No" := LoanApp."Client Code";
                                ObjReceiptTransactions."Account No" := ObjRcptBuffer."Member No";
                                ObjReceiptTransactions."Account Type" := ObjReceiptTransactions."account type"::Member;
                                ObjReceiptTransactions."Transaction Type" := ObjReceiptTransactions."transaction type"::"Loan Repayment";
                                ObjReceiptTransactions."Global Dimension 1 Code" := Format(LoanApp.Source);
                                ObjReceiptTransactions."Global Dimension 2 Code" := SURESTEPFactory.FnGetMemberBranch(ObjRcptBuffer."Member No");
                                if ObjReceiptTransactions.Amount > 0 then
                                    ObjReceiptTransactions.Insert(true);
                                RunningBalance := RunningBalance - Abs(ObjReceiptTransactions.Amount);
                            end;
                        end;
                    end;
                until LoanApp.Next = 0;
            end;
            exit(RunningBalance);
        end;
    end;

    local procedure FnRunEntranceFee(ObjRcptBuffer: Record Transactions; RunningBalance: Decimal): Decimal
    var
        AmountToDeduct: Decimal;
        ObjReceiptTransactions: Record "Receipt Allocation";
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayment: Decimal;
        PRpayment: Decimal;
        ObjMember: Record Customer;
    begin
        if RunningBalance > 0 then begin
            GenSetup.Get();
            ObjMember.Reset;
            ObjMember.SetRange(ObjMember."No.", ObjRcptBuffer."Member No");
            ObjMember.SetFilter(ObjMember."Registration Date", '>%1', 20171017D); //To Ensure deduction is for New Members Only
            if ObjMember.Find('-') then begin
                ObjMember.CalcFields(ObjMember."Registration Fee Paid");
                if Abs(ObjMember."Registration Fee Paid") < 500 then begin
                    if ObjMember."Registration Date" <> 0D then begin

                        AmountToDeduct := 0;
                        AmountToDeduct := GenSetup."BOSA Registration Fee Amount" - Abs(ObjMember."Registration Fee Paid");
                        if RunningBalance <= AmountToDeduct then
                            AmountToDeduct := RunningBalance;
                        ObjReceiptTransactions.Init;
                        ObjReceiptTransactions."Document No" := ObjRcptBuffer.No;
                        ObjReceiptTransactions."Member No" := ObjRcptBuffer."Member No";
                        ObjReceiptTransactions."Account Type" := ObjReceiptTransactions."account type"::Member;
                        ObjReceiptTransactions."Account No" := ObjRcptBuffer."Member No";
                        ObjReceiptTransactions."Transaction Type" := ObjReceiptTransactions."transaction type"::"Registration Fee";
                        ObjReceiptTransactions."Global Dimension 1 Code" := 'BOSA';
                        ObjReceiptTransactions."Global Dimension 2 Code" := SURESTEPFactory.FnGetMemberBranch(ObjRcptBuffer."Member No");
                        ObjReceiptTransactions.Amount := AmountToDeduct;
                        if ObjReceiptTransactions.Amount <> 0 then
                            ObjReceiptTransactions.Insert(true);
                        RunningBalance := RunningBalance - Abs(ObjReceiptTransactions.Amount);
                    end;
                end;
            end;
            exit(RunningBalance);
        end;
    end;

    local procedure FnRunShareCapital(ObjRcptBuffer: Record Transactions; RunningBalance: Decimal): Decimal
    var
        AmountToDeduct: Decimal;
        ObjReceiptTransactions: Record "Receipt Allocation";
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayment: Decimal;
        PRpayment: Decimal;
        ObjMember: Record Customer;
        SharesCap: Decimal;
        DIFF: Decimal;
    begin
        if RunningBalance > 0 then begin
            GenSetup.Get();
            ObjMember.Reset;
            ObjMember.SetRange(ObjMember."No.", ObjRcptBuffer."Member No");
            ObjMember.SetRange(ObjMember."Customer Type", ObjMember."customer type"::Member);
            if ObjMember.Find('-') then begin
                //REPEAT Deducted once unless otherwise advised
                ObjMember.CalcFields(ObjMember."Shares Retained");
                if ObjMember."Shares Retained" < GenSetup."Retained Shares" then begin
                    SharesCap := GenSetup."Retained Shares";
                    DIFF := SharesCap - ObjMember."Shares Retained";

                    if DIFF > 1 then begin
                        if RunningBalance > 0 then begin
                            AmountToDeduct := 0;
                            AmountToDeduct := DIFF;
                            if DIFF > 10000 then
                                AmountToDeduct := 10000;
                            if RunningBalance <= AmountToDeduct then
                                AmountToDeduct := RunningBalance;

                            ObjReceiptTransactions.Init;
                            ObjReceiptTransactions."Document No" := ObjRcptBuffer.No;
                            ObjReceiptTransactions."Account Type" := ObjReceiptTransactions."account type"::Member;
                            ObjReceiptTransactions."Member No" := ObjRcptBuffer."Member No";
                            ObjReceiptTransactions."Account No" := ObjRcptBuffer."Member No";
                            ObjReceiptTransactions."Transaction Type" := ObjReceiptTransactions."transaction type"::"Share Capital";
                            ObjReceiptTransactions."Global Dimension 1 Code" := 'BOSA';
                            ObjReceiptTransactions."Global Dimension 2 Code" := SURESTEPFactory.FnGetMemberBranch(ObjRcptBuffer."Member No");
                            ObjReceiptTransactions.Amount := AmountToDeduct;
                            if ObjReceiptTransactions.Amount <> 0 then
                                ObjReceiptTransactions.Insert(true);
                            RunningBalance := RunningBalance - Abs(ObjReceiptTransactions.Amount);
                        end;
                    end;
                end;
                //UNTIL RcptBufLines.NEXT=0;
            end;

            exit(RunningBalance);
        end;
    end;

    local procedure FnRunDepositContribution(ObjRcptBuffer: Record Transactions; RunningBalance: Decimal): Decimal
    var
        AmountToDeduct: Decimal;
        ObjReceiptTransactions: Record "Receipt Allocation";
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayment: Decimal;
        PRpayment: Decimal;
        ObjMember: Record Customer;
        SharesCap: Decimal;
        DIFF: Decimal;
    begin
        if RunningBalance > 0 then begin
            ObjMember.Reset;
            ObjMember.SetRange(ObjMember."No.", ObjRcptBuffer."Member No");
            ObjMember.SetRange(ObjMember."Customer Type", ObjMember."customer type"::Member);
            if ObjMember.Find('-') then begin
                ObjMember."Monthly Contribution" := SURESTEPFactory.FnGetMemberMonthlyContributionDepositstier(ObjRcptBuffer."Member No");
                ObjMember.Modify;

                AmountToDeduct := 0;
                AmountToDeduct := ROUND(ObjMember."Monthly Contribution", 0.05, '>');
                if RunningBalance <= AmountToDeduct then
                    AmountToDeduct := RunningBalance;

                ObjReceiptTransactions.Init;
                ObjReceiptTransactions."Document No" := ObjRcptBuffer.No;
                ObjReceiptTransactions."Member No" := ObjRcptBuffer."Member No";
                ObjReceiptTransactions."Account No" := ObjRcptBuffer."Member No";
                ObjReceiptTransactions."Account Type" := ObjReceiptTransactions."account type"::Member;
                ObjReceiptTransactions."Transaction Type" := ObjReceiptTransactions."transaction type"::"Deposit Contribution";
                ObjReceiptTransactions."Global Dimension 1 Code" := 'BOSA';
                ObjReceiptTransactions."Global Dimension 2 Code" := SURESTEPFactory.FnGetMemberBranch(ObjRcptBuffer."Member No");
                ObjReceiptTransactions.Amount := AmountToDeduct;
                if ObjReceiptTransactions.Amount <> 0 then
                    ObjReceiptTransactions.Insert(true);
                RunningBalance := RunningBalance - Abs(ObjReceiptTransactions.Amount);
            end;

            exit(RunningBalance);
        end;
    end;

    local procedure FnRunInsuranceContribution(ObjRcptBuffer: Record Transactions; RunningBalance: Decimal): Decimal
    var
        AmountToDeduct: Decimal;
        ObjReceiptTransactions: Record "Receipt Allocation";
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayment: Decimal;
        PRpayment: Decimal;
        ObjMember: Record Customer;
    begin
        GenSetup.Get();
        if RunningBalance > 0 then begin
            ObjMember.Reset;
            ObjMember.SetRange(ObjMember."No.", ObjRcptBuffer."Member No");
            if ObjMember.Find('-') then begin
                if ObjMember."Registration Date" <> 0D then begin
                    AmountToDeduct := 0;
                    AmountToDeduct := GenSetup."Benevolent Fund Contribution";
                    if RunningBalance <= AmountToDeduct then
                        AmountToDeduct := RunningBalance;
                    ObjReceiptTransactions.Init;
                    ObjReceiptTransactions."Document No" := ObjRcptBuffer.No;
                    ObjReceiptTransactions."Account Type" := ObjReceiptTransactions."account type"::Member;
                    ObjReceiptTransactions."Member No" := ObjRcptBuffer."Member No";
                    ObjReceiptTransactions."Account No" := ObjRcptBuffer."Member No";
                    ObjReceiptTransactions."Transaction Type" := ObjReceiptTransactions."transaction type"::"Insurance Contribution";
                    ObjReceiptTransactions."Global Dimension 1 Code" := 'BOSA';
                    ObjReceiptTransactions."Global Dimension 2 Code" := SURESTEPFactory.FnGetMemberBranch(ObjRcptBuffer."Member No");
                    ObjReceiptTransactions.Amount := AmountToDeduct;
                    if ObjReceiptTransactions.Amount <> 0 then
                        ObjReceiptTransactions.Insert(true);
                    RunningBalance := RunningBalance - Abs(ObjReceiptTransactions.Amount);
                end;
            end;
            exit(RunningBalance);
        end;
    end;

    local procedure FnRunBenevolentFund(ObjRcptBuffer: Record Transactions; RunningBalance: Decimal): Decimal
    var
        AmountToDeduct: Decimal;
        ObjReceiptTransactions: Record "Receipt Allocation";
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayment: Decimal;
        PRpayment: Decimal;
        ObjMember: Record Customer;
    begin
        if RunningBalance > 0 then begin
            GenSetup.Get();
            ObjMember.Reset;
            ObjMember.SetRange(ObjMember."No.", ObjRcptBuffer."Member No");
            if ObjMember.Find('-') then begin
                if ObjMember."Registration Date" <> 0D then begin

                    AmountToDeduct := 0;
                    AmountToDeduct := GenSetup."Risk Fund Amount";
                    if RunningBalance <= AmountToDeduct then
                        AmountToDeduct := RunningBalance;
                    ObjReceiptTransactions.Init;
                    ObjReceiptTransactions."Document No" := ObjRcptBuffer.No;
                    ObjReceiptTransactions."Member No" := ObjRcptBuffer."Member No";
                    ObjReceiptTransactions."Account No" := ObjRcptBuffer."Member No";
                    ObjReceiptTransactions."Account Type" := ObjReceiptTransactions."account type"::Member;
                    ObjReceiptTransactions."Transaction Type" := ObjReceiptTransactions."transaction type"::"Benevolent Fund";
                    ObjReceiptTransactions."Global Dimension 1 Code" := 'BOSA';
                    ObjReceiptTransactions."Global Dimension 2 Code" := SURESTEPFactory.FnGetMemberBranch(ObjRcptBuffer."Member No");
                    ObjReceiptTransactions.Amount := AmountToDeduct;
                    if ObjReceiptTransactions.Amount <> 0 then
                        ObjReceiptTransactions.Insert(true);
                    RunningBalance := RunningBalance - Abs(ObjReceiptTransactions.Amount);
                end;
            end;
            exit(RunningBalance);
        end;
    end;

    local procedure FnRunUnallocatedAmount(ObjRcptBuffer: Record Transactions; RunningBalance: Decimal): Decimal
    var
        AmountToDeduct: Decimal;
        ObjReceiptTransactions: Record "Receipt Allocation";
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayment: Decimal;
        PRpayment: Decimal;
        ObjMember: Record Customer;
    begin
        ObjMember.Reset;
        ObjMember.SetRange(ObjMember."No.", ObjRcptBuffer."Member No");
        if ObjMember.Find('-') then begin
            begin
                AmountToDeduct := 0;
                AmountToDeduct := RunningBalance;
                ObjReceiptTransactions.Init;
                ObjReceiptTransactions."Document No" := ObjRcptBuffer.No;
                ObjReceiptTransactions."Member No" := ObjRcptBuffer."Member No";
                ObjReceiptTransactions."Account No" := ObjRcptBuffer."Member No";
                ObjReceiptTransactions."Account Type" := ObjReceiptTransactions."account type"::Member;
                ObjReceiptTransactions."Transaction Type" := ObjReceiptTransactions."transaction type"::"Unallocated Funds";
                ObjReceiptTransactions."Global Dimension 1 Code" := 'BOSA';
                ObjReceiptTransactions."Global Dimension 2 Code" := SURESTEPFactory.FnGetMemberBranch(ObjRcptBuffer."Member No");
                ObjReceiptTransactions.Amount := AmountToDeduct;
                if ObjReceiptTransactions.Amount <> 0 then
                    ObjReceiptTransactions.Insert(true);
            end;
        end;
    end;

    local procedure FnRunDepositContributionFromExcess(ObjRcptBuffer: Record Transactions; RunningBalance: Decimal): Decimal
    var
        AmountToDeduct: Decimal;
        ObjReceiptTransactions: Record "Receipt Allocation";
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayment: Decimal;
        PRpayment: Decimal;
        ObjMember: Record Customer;
        SharesCap: Decimal;
        DIFF: Decimal;
        TransType: Option " ","Registration Fee","Share Capital","Interest Paid","Loan Repayment","Deposit Contribution","Insurance Contribution","Benevolent Fund",Loan,"Unallocated Funds",Dividend,"FOSA Account";
    begin

        ObjMember.Reset;
        ObjMember.SetRange(ObjMember."No.", ObjRcptBuffer."Member No");
        ObjMember.SetRange(ObjMember."Customer Type", ObjMember."customer type"::Member);
        if ObjMember.Find('-') then begin
            AmountToDeduct := 0;
            AmountToDeduct := RunningBalance + FnReturnAmountToClear(Transtype::"Deposit Contribution");
            ObjReceiptTransactions.Init;
            ObjReceiptTransactions."Document No" := ObjRcptBuffer.No;
            ObjReceiptTransactions."Member No" := ObjRcptBuffer."Member No";
            ObjReceiptTransactions."Account No" := ObjRcptBuffer."Member No";
            ObjReceiptTransactions."Account Type" := ObjReceiptTransactions."account type"::Member;
            ObjReceiptTransactions."Transaction Type" := ObjReceiptTransactions."transaction type"::"Deposit Contribution";
            ObjReceiptTransactions."Global Dimension 1 Code" := 'BOSA';
            ObjReceiptTransactions."Global Dimension 2 Code" := SURESTEPFactory.FnGetMemberBranch(ObjRcptBuffer."Member No");
            ObjReceiptTransactions.Amount := AmountToDeduct;
            if ObjReceiptTransactions.Amount <> 0 then
                ObjReceiptTransactions.Insert(true);
        end;
    end;

    local procedure FnReturnAmountToClear(TransType: Option " ","Registration Fee","Share Capital","Interest Paid","Loan Repayment","Deposit Contribution","Insurance Contribution","Benevolent Fund",Loan,"Unallocated Funds",Dividend,"FOSA Account") AmountReturned: Decimal
    var
        ObjReceiptAllocation: Record "Receipt Allocation";
    begin
        ObjReceiptAllocation.Reset;
        ObjReceiptAllocation.SetRange("Document No", Rec.No);
        ObjReceiptAllocation.SetRange("Transaction Type", TransType);
        if ObjReceiptAllocation.Find('-') then begin
            AmountReturned := ObjReceiptAllocation.Amount;
            ObjReceiptAllocation.Delete;
        end;
        exit;
    end;

    local procedure FnRunSavingsProductExcess(ObjRcptBuffer: Record Transactions; RunningBalance: Decimal; SavingsProduct: Code[100]): Decimal
    var
        AmountToDeduct: Decimal;
        ObjReceiptTransactions: Record "Receipt Allocation";
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayment: Decimal;
        PRpayment: Decimal;
        ObjMember: Record Customer;
        SharesCap: Decimal;
        DIFF: Decimal;
        TransType: Option " ","Registration Fee","Share Capital","Interest Paid","Loan Repayment","Deposit Contribution","Insurance Contribution","Benevolent Fund",Loan,"Unallocated Funds",Dividend,"FOSA Account";
    begin

        ObjMember.Reset;
        ObjMember.SetRange(ObjMember."No.", ObjRcptBuffer."Account No.");
        ObjMember.SetRange(ObjMember."Customer Type", ObjMember."customer type"::Member);
        if ObjMember.Find('-') then begin
            AmountToDeduct := 0;
            AmountToDeduct := RunningBalance + FnReturnAmountToClear(Transtype::"FOSA Account");
            ObjReceiptTransactions.Init;
            ObjReceiptTransactions."Document No" := ObjRcptBuffer.No;
            ObjReceiptTransactions."Member No" := ObjRcptBuffer."Account No.";
            ObjReceiptTransactions."Account No" := SavingsProduct;
            ObjReceiptTransactions.Validate(ObjReceiptTransactions."Account No");
            ObjReceiptTransactions."Transaction Type" := ObjReceiptTransactions."transaction type"::"FOSA Account";
            ObjReceiptTransactions."Global Dimension 1 Code" := 'FOSA';
            ObjReceiptTransactions."Global Dimension 2 Code" := SURESTEPFactory.FnGetMemberBranch(ObjRcptBuffer."Account No.");
            ObjReceiptTransactions.Amount := AmountToDeduct;
            if ObjReceiptTransactions.Amount <> 0 then
                ObjReceiptTransactions.Insert(true);
        end;
    end;
}

