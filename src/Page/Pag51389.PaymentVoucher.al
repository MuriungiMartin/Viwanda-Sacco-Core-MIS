page 51389 "Payment Voucher"
{
    // version Sacco ManagementV1.0(Surestep Systems)

    // //Use if Cheque is to be Validated
    // Payments.RESET;
    // Payments.SETRANGE(Payments."No.","No.");
    // IF Payments.FINDFIRST THEN
    //   BEGIN
    //     IF Payments."Pay Mode"=Payments."Pay Mode"::Cheque THEN
    //       BEGIN
    //          IF STRLEN(Payments."Cheque No.")<>6 THEN
    //           BEGIN
    //             ERROR ('Invalid Cheque Number Inserted');
    //           END;
    //       END;
    //   END;
    // **************************************************************************************
    // //Use if Paying Bank Account should not be overdrawn
    // 
    // //get the source account balance from the database table
    // BankAcc.RESET;
    // BankAcc.SETRANGE(BankAcc."No.",Payment."Paying Bank Account");
    // BankAcc.SETRANGE(BankAcc."Bank Type",BankAcc."Bank Type"::Cash);
    // IF BankAcc.FINDFIRST THEN
    //   BEGIN
    //     Payments.TESTFIELD(Payments.Date,TODAY);
    //     BankAcc.CALCFIELDS(BankAcc."Balance (LCY)");
    //     "Current Source A/C Bal.":=BankAcc."Balance (LCY)";
    //     IF ("Current Source A/C Bal."-Payment."Total Net Amount")<0 THEN
    //       BEGIN
    //         ERROR('The transaction will result in a negative balance in the BANK ACCOUNT.');
    //       END;
    //   END;

    DeleteAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    RefreshOnActivate = true;
    SourceTable = "Payments Header";

    layout
    {
        area(content)
        {
            group(General)

            {
                field("No."; "No.")
                {
                    Editable = false;
                }
                field(Date; Date)
                {
                    Editable = DateEditable;
                }
                field("Global Dimension 1 Code"; "Global Dimension 1 Code")
                {
                    Editable = GlobalDimension1CodeEditable;
                }
                field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
                {
                    Editable = ShortcutDimension2CodeEditable;
                    Visible = true;
                }
                field("Budget Center Name"; "Budget Center Name")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Responsibility Center"; "Responsibility Center")
                {
                    Visible = false;
                }
                field("Shortcut Dimension 3 Code"; "Shortcut Dimension 3 Code")
                {
                    Editable = false;
                    Visible = false;
                }
                field(Dim3; Dim3)
                {
                    Editable = false;
                    Visible = false;
                }
                field("Shortcut Dimension 4 Code"; "Shortcut Dimension 4 Code")
                {
                    Editable = false;
                    Visible = false;
                }
                field(Dim4; Dim4)
                {
                    Editable = false;
                    Visible = false;
                }
                field("Pay Mode"; "Pay Mode")
                {
                    Editable = PaymentModeEditable;
                }
                field("Cheque Type"; "Cheque Type")
                {
                    Caption = 'Cheque Type';
                    Editable = "Cheque TypeEditable";
                }
                field("Invoice Number"; "Invoice Number")
                {
                    Visible = false;
                }
                field("Paying Type"; "Paying Type")
                {
                    Editable = false;
                    OptionCaption = ' Bank';
                }
                field("Expense Type"; "Expense Type")
                {
                    Visible = false;
                }
                field("Currency Code"; "Currency Code")
                {
                    Editable = CurrencyCodeEditable;
                    Visible = false;
                }
                field("Invoice Currency Code"; "Invoice Currency Code")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Paying Bank Account"; "Paying Bank Account")
                {

                    trigger OnValidate()
                    begin
                        // TESTFIELD("Responsibility Center");
                    end;
                }
                field("Paying Vendor Account"; "Paying Vendor Account")
                {
                    Visible = false;
                }
                field("Bank Name"; "Bank Name")
                {
                    Editable = false;
                }
                field(Payee; Payee)
                {
                    Caption = 'Payment to';
                    Editable = PayeeEditable;
                }
                field("On Behalf Of"; "On Behalf Of")
                {
                    Editable = OnBehalfEditable;
                }
                field("Payment Narration"; "Payment Narration")
                {
                    Editable = "Payment NarrationEditable";
                }
                field(Cashier; Cashier)
                {
                    Editable = false;
                }
                field(Status; Status)
                {
                    Editable = true;
                }
                field("Total Payment Amount"; "Total Payment Amount")
                {
                }
                field("Total VAT Amount"; "Total VAT Amount")
                {
                }
                field("Total Witholding Tax Amount"; "Total Witholding Tax Amount")
                {
                }
                field("Total Retention Amount"; "Total Retention Amount")
                {
                    Visible = false;
                }

                field("Total Payment Amount LCY"; "Total Payment Amount LCY")
                {
                    Caption = 'Total Net Amount LCY';
                    Editable = false;
                }
                field("Cheque No."; "Cheque No.")
                {
                    Caption = 'Cheque/EFT No.';

                    trigger OnValidate()
                    begin
                        /*//check if the cheque has been inserted
                        TESTFIELD("Paying Bank Account");
                        PVHead.RESET;
                        PVHead.SETRANGE(PVHead."Paying Bank Account","Paying Bank Account");
                        PVHead.SETRANGE(PVHead."Pay Mode",PVHead."Pay Mode"::Cheque);
                        IF PVHead.FINDFIRST THEN
                          BEGIN
                            REPEAT
                              IF PVHead."Cheque No."="Cheque No." THEN
                                BEGIN
                                  IF PVHead."No."<>"No." THEN
                                    BEGIN
                                     ERROR('The Cheque Number has already been utilised');
                                    END;
                                END;
                            UNTIL PVHead.NEXT=0;
                          END;
                        
                        {IF "Pay Mode"="Pay Mode"::Cheque THEN BEGIN
                         IF STRLEN("Cheque No.") <> 6 THEN
                          ERROR('Document No. cannot contain More than 6 Characters.');
                        END;
                        }*/

                        GLEntry.RESET;
                        GLEntry.SETRANGE(GLEntry."External Document No.", "Cheque No.");
                        GLEntry.SETRANGE(GLEntry.Reversed, FALSE);
                        IF GLEntry.FINDSET THEN BEGIN
                            ERROR('The Cheque Number has already been utilised');
                        END;

                    end;
                }
                field("Payment Release Date"; "Payment Release Date")
                {
                    Caption = 'Posting Date';
                }
            }
            part(PVLines; 50134)
            {
                Editable = PVLinesEditable;
                SubPageLink = No = FIELD("No.");
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("&Functions")
            {
                Caption = '&Functions';
                action(Post)
                {
                    Caption = 'Post Payment and Print';
                    Enabled = EnableCreateMember;
                    Image = PostPrint;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        TESTFIELD(Payee);
                        TESTFIELD("Payment Narration");
                        TESTFIELD("Payment Release Date");
                        //TESTFIELD("Cheque No.");
                        IF UserSetup.GET(USERID) THEN BEGIN
                            IF NOT UserSetup."Post Pv" THEN
                                ERROR(Text004)
                            ELSE
                                ;
                            //Post Pv Entries
                            CurrPage.SAVERECORD;
                            CheckPVRequiredItems;
                            //post pv
                            GenJournalLine.RESET;
                            GenJnlLine.SETRANGE(GenJnlLine."Journal Template Name", JTemplate);
                            GenJnlLine.SETRANGE(GenJnlLine."Journal Batch Name", JBatch);
                            IF GenJnlLine.FIND('+') THEN BEGIN
                                LineNo := GenJnlLine."Line No." + 1000;
                            END
                            ELSE BEGIN
                                LineNo := 1000;
                            END;
                            GenJnlLine.DELETEALL;
                            GenJnlLine.RESET;

                            Payments.RESET;
                            Payments.SETRANGE(Payments."No.", "No.");
                            IF Payments.FIND('-') THEN BEGIN
                                PayLine.RESET;
                                PayLine.SETRANGE(PayLine.No, Payments."No.");
                                IF PayLine.FIND('-') THEN BEGIN
                                    REPEAT
                                        PostHeader(Payments);

                                    UNTIL PayLine.NEXT = 0;
                                END;
                            END;

                            Post := FALSE;
                            Post := JournlPosted.PostedSuccessfully();
                            //IF Post THEN  BEGIN
                            Posted := TRUE;
                            Status := Payments.Status::Posted;
                            "Posted By" := USERID;
                            "Date Posted" := TODAY;
                            "Time Posted" := TIME;
                            MODIFY;

                        END;

                        COMMIT;
                    end;
                }

                action("Send Approval Request")
                {
                    Caption = 'Send A&pproval Request';
                    Enabled = (NOT OpenApprovalEntriesExist) AND EnabledApprovalWorkflowsExist;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        Text001: Label 'This transaction is already pending approval';
                    // ApprovalsMgmt: Codeunit "1535";
                    // ApprovalMgt: Codeunit "1535";
                    begin

                        TESTFIELD("Paying Bank Account");

                        // IF "Paying Type" = "Paying Type"::Bank THEN
                        //     ERROR('Kindly spceify the paying type')

                        // ELSE
                        //     IF ("Paying Vendor Account" <> '') AND ("Paying Bank Account" <> '') THEN
                        //         ERROR('You cannot have both paying bank and paying vendor, choose one')

                        //     ELSE
                        //         IF ("Paying Type" = "Paying Type"::Bank) AND ("Paying Vendor Account" = '') THEN
                        //             ERROR('Kindly spceify the paying vendor account');

                        // // ELSE
                        //     IF ("Paying Type" = "Paying Type"::) AND ("Paying Bank Account" = '') THEN
                        //         ERROR('Kindly spceify the paying bank account');


                        IF NOT LinesExists THEN
                            ERROR('There are no Lines created for this Document');
                        //Ensure No Items That should be committed that are not
                        IF LinesCommitmentStatus THEN
                            ERROR('There are some lines that have not been committed');
                        /*
                        PayLine.RESET;
                        PayLine.SETRANGE(PayLine.Type,"RFQ No.");
                        PayLine.SETRANGE(PayLine."Vendor No.",'MEMBER');
                        IF PayLine.FIND('-') THEN BEGIN
                        IF PayLine."Transaction Type"=PayLine."Transaction Type"::"0" THEN
                        ERROR('Transaction Type cannot be blank in payment lines');
                        END;
                        */
                        //TESTFIELD("Total Net Amount");
                        //Release the PV for Approval
                        IF "Pay Mode" = "Pay Mode"::Cheque THEN
                            //TESTFIELD("Cheque No.");
                            TESTFIELD(Payee);
                        TESTFIELD("Total Payment Amount");
                        TESTFIELD("Payment Narration");
                        Workflowmanagement.OnSendPaymentDocForApproval(Rec);
                        //ApprovalMgt.OnSendVendorForApproval(Rec) ;


                        Doc_Type := Doc_Type::"Payment Voucher";
                        Table_id := DATABASE::"Payments Header";
                        //IF Approvalmgt.SendApproval(Table_id,"No.",Doc_Type,Status)THEN;

                        // TESTFIELD("Cheque No.");
                        // TESTFIELD(Payee);
                        TESTFIELD("Total Payment Amount");
                        IF Workflowmanagement.CheckPaymentApprovalsWorkflowEnabled(Rec) THEN
                            Workflowmanagement.IsPaymentApprovalsWorkflowEnabled(Rec);

                        //Print PV
                        PHeader2.RESET;
                        PHeader2.SETRANGE(PHeader2."No.", "No.");
                        IF PHeader2.FINDFIRST THEN
                            Message('done');
                        //Report.run(50125, FALSE, TRUE, PHeader2);

                    end;
                }
                action("Cancel Approval REquest")
                {
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = CanCancelApprovalForRecord;
                    Image = CancelApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin

                        IF Workflowmanagement.CheckPaymentApprovalsWorkflowEnabled(Rec) THEN
                            Workflowmanagement.OnCancelPaymentApprovalRequest(Rec);
                    end;
                }
                action(Approval)
                {
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                    begin
                        DocumentType := DocumentType::"Payment Voucher";
                        ApprovalEntries.Setfilters(51516112, DocumentType, "No.");
                        ApprovalEntries.RUN;
                    end;
                }

                action(Print)
                {
                    Caption = 'Print/Preview';
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        //TESTFIELD(Posted,TRUE);
                        PHeader2.RESET;
                        PHeader2.SETRANGE(PHeader2."No.", "No.");
                        IF PHeader2.FINDFIRST THEN
                            Report.run(50125, TRUE, TRUE, PHeader2);
                    end;
                }

                action("Cancel Document")
                {
                    Caption = 'Cancel Document';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = false;

                    trigger OnAction()
                    var
                        Text000: Label 'Are you sure you want to cancel this Document?';
                        Text001: Label 'You have selected not to Cancel the Document';
                    begin


                    end;
                }

                action("Check Budgetary Availability")
                {
                    Image = Balance;
                    Promoted = true;
                    Visible = false;

                    trigger OnAction()
                    begin

                        BCSetup.GET;
                        IF NOT BCSetup.Mandatory THEN
                            EXIT;

                        IF NOT AllFieldsEntered THEN
                            ERROR('Some of the Key Fields on the Lines:[ACCOUNT NO.,AMOUNT] Have not been Entered please RECHECK your entries');
                        //First Check whether other lines are already committed.
                        Commitments.RESET;
                        Commitments.SETRANGE(Commitments."Document Type", Commitments."Document Type"::"Payment Voucher");
                        Commitments.SETRANGE(Commitments."Document No.", "No.");
                        IF Commitments.FIND('-') THEN BEGIN
                            IF CONFIRM('Lines in this Document appear to be committed do you want to re-commit?', FALSE) = FALSE THEN BEGIN EXIT END;
                            Commitments.RESET;
                            Commitments.SETRANGE(Commitments."Document Type", Commitments."Document Type"::"Payment Voucher");
                            Commitments.SETRANGE(Commitments."Document No.", "No.");
                            Commitments.DELETEALL;
                        END;

                        //CheckBudgetAvail.CheckPayments(Rec);
                    end;
                }
                action("Cancel Budget Commitment")
                {
                    Image = CancelAllLines;
                    Promoted = true;
                    Visible = false;

                    trigger OnAction()
                    begin

                        TESTFIELD(Status, Status::Pending);
                        IF CONFIRM('Do you Wish to Cancel the Commitment entries for this document', FALSE) = FALSE THEN BEGIN EXIT END;

                        Commitments.RESET;
                        Commitments.SETRANGE(Commitments."Document Type", Commitments."Document Type"::"Payment Voucher");
                        Commitments.SETRANGE(Commitments."Document No.", "No.");
                        Commitments.DELETEALL;

                        PayLine.RESET;
                        PayLine.SETRANGE(PayLine.No, "No.");
                        IF PayLine.FIND('-') THEN BEGIN
                            REPEAT
                                PayLine.Committed := FALSE;
                                PayLine.MODIFY;
                            UNTIL PayLine.NEXT = 0;
                        END;
                    end;
                }
                action(PrintCheque)
                {
                    Caption = 'Print Cheque';
                    Image = PrintCheck;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        //TESTFIELD(Status,Status::Approved);
                        /*IF (Status=Status::Pending) OR  (Status=Status::"Pending Approval") THEN
                           ERROR('You cannot Print until the document is Approved'); */

                        PHeader2.RESET;
                        PHeader2.SETRANGE(PHeader2."No.", "No.");
                        IF PHeader2.FINDFIRST THEN
                            Report.run(50030, TRUE, TRUE, PHeader2);

                        /*RESET;
                        SETRANGE("No.","No.");
                        IF "No." = '' THEN
                          REPORT.RUNMODAL(51516000,TRUE,TRUE,Rec)
                        ELSE
                          REPORT.RUNMODAL(51516344,TRUE,TRUE,Rec);
                        RESET;
                        */

                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        UpdateControls();
        UpdateControls();
        EnableCreateMember := FALSE;
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RECORDID);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RECORDID);
        EnabledApprovalWorkflowsExist := TRUE;
        IF Rec.Status = Status::Approved THEN BEGIN
            OpenApprovalEntriesExist := FALSE;
            CanCancelApprovalForRecord := FALSE;
            EnabledApprovalWorkflowsExist := FALSE;
        END;
        IF (Rec.Status = Status::Approved) THEN
            EnableCreateMember := TRUE;
    end;

    trigger OnInit()
    begin

        PVLinesEditable := TRUE;
        DateEditable := TRUE;
        PayeeEditable := TRUE;
        "Payment NarrationEditable" := TRUE;
        GlobalDimension1CodeEditable := TRUE;
        CurrencyCodeEditable := TRUE;
        "Invoice Currency CodeEditable" := TRUE;
        "Cheque TypeEditable" := TRUE;
        PaymentReleasDateEditable := TRUE;
        "Cheque No.Editable" := TRUE;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin

        "Payment Type" := "Payment Type"::Normal;
        "Responsibility Center" := UserMgt.GetPurchasesFilter;
        "Pay Mode" := "Pay Mode"::Cheque;
        "Paying Type" := "Paying Type"::Bank;
        "Cheque Type" := "Cheque Type"::"Manual Check";
        Date := TODAY;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin

        "Responsibility Center" := UserMgt.GetSalesFilter();
        //Add dimensions if set by default here
        // "Global Dimension 1 Code":=UserMgt.GetSetDimensions(USERID,1);
        "Shortcut Dimension 2 Code" := UserMgt.GetSetDimensions(USERID, 2);
        "Shortcut Dimension 3 Code" := UserMgt.GetSetDimensions(USERID, 3);
        VALIDATE("Shortcut Dimension 3 Code");
        "Shortcut Dimension 4 Code" := UserMgt.GetSetDimensions(USERID, 4);
        VALIDATE("Shortcut Dimension 4 Code");
        "Responsibility Center" := 'FINANCE';
        "Shortcut Dimension 2 Code" := 'NAIROBI';
        "Global Dimension 1 Code" := 'BOSA';

    end;

    trigger OnOpenPage()
    begin

        IF UserMgt.GetPurchasesFilter() <> '' THEN BEGIN
            FILTERGROUP(2);
            SETRANGE("Responsibility Center", UserMgt.GetPurchasesFilter());
            FILTERGROUP(0);
        END;
    end;

    var
        PayLine: Record "Payment Line";
        PVUsers: Record "CshMgt PV Steps Users";
        strFilter: Text[250];
        IntC: Integer;
        IntCount: Integer;
        Payments: Record "Payments Header";
        RecPayTypes: Record "Receipts and Payment Types";
        TarriffCodes: Record "Tariff Codes";
        GenJnlLine: Record "Gen. Journal Line";
        DefaultBatch: Record "Gen. Journal Batch";
        CashierLinks: Record "Cashier Link";
        LineNo: Integer;
        Temp: Record "Funds User Setup";
        JTemplate: Code[10];
        JBatch: Code[10];
        PCheck: Codeunit "Posting Check FP";
        Post: Boolean;
        strText: Text[100];
        PVHead: Record "Payments Header";
        BankAcc: Record "Bank Account";
        CheckBudgetAvail: Codeunit "Budgetary Control";
        Commitments: Record Committment;
        UserMgt: Codeunit "User Setup Management BR";
        JournlPosted: Codeunit "Journal Post Successful";
        Doc_Type: Option LPO,Requisition,Imprest,"Payment Voucher";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery,ChangeRequest,TreasuryTransactions,FundsTransfer,SaccoTransfers,ChequeDiscounting,ImprestRequisition,ImprestSurrender,LeaveApplication;
        DocPrint: Codeunit "Document-Print";
        CheckLedger: Record "Check Ledger Entry";
        Text001: Label 'This Document no %1 has printed Cheque No %2 which will have to be voided first before reposting.';
        CheckManagement: Codeunit CheckManagement;
        Text000: Label 'Do you want to Void Check No %1';
        Text002: Label 'You have selected post and generate a computer cheque ensure that your cheque printer is ready do you want to continue?';
        HasLines: Boolean;
        AllKeyFieldsEntered: Boolean;
        AdjustGenJnl: Codeunit "Adjust Gen. Journal Balance";
        OnBehalfEditable: Boolean;
        [InDataSet]
        "Cheque No.Editable": Boolean;
        [InDataSet]
        PaymentReleasDateEditable: Boolean;
        [InDataSet]
        "Cheque TypeEditable": Boolean;
        [InDataSet]
        "Invoice Currency CodeEditable": Boolean;
        [InDataSet]
        CurrencyCodeEditable: Boolean;
        [InDataSet]
        GlobalDimension1CodeEditable: Boolean;
        [InDataSet]
        "Payment NarrationEditable": Boolean;
        [InDataSet]
        PayeeEditable: Boolean;
        [InDataSet]
        DateEditable: Boolean;
        [InDataSet]
        PVLinesEditable: Boolean;
        [InDataSet]
        ShortcutDimension2CodeEditable: Boolean;
        [InDataSet]
        ShortcutDimension3CodeEditable: Boolean;
        [InDataSet]
        ShortcutDimension4CodeEditable: Boolean;
        PaymentModeEditable: Boolean;
        BCSetup: Record "Budgetary Control Setup";
        Text003: Label 'Are you sure you want to print a cheque for this Payment.';
        GeneralSet: Record "Sacco General Set-Up";
        PHeader2: Record "Payments Header";
        Table_id: Integer;
        GLEntry: Record "Bank Account Ledger Entry";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";

        Workflowmanagement: Codeunit WorkflowIntegration;
        OpenApprovalEntriesExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
        EnabledApprovalWorkflowsExist: Boolean;
        EnableCreateMember: Boolean;
        UserSetup: Record "User Setup";
        Text004: Label 'You do not have the permission to post Payment Vouchers. Contact the System Administrator';
        GenJournalLine: Record "Gen. Journal Line";

    procedure PostPaymentVoucher()
    begin

        //Post PV Entries
        CurrPage.SAVERECORD;
        CheckPVRequiredItems;
        //post pv
        // DELETE ANY LINE ITEM THAT MAY BE PRESENT
        GenJnlLine.RESET;
        GenJnlLine.SETRANGE(GenJnlLine."Journal Template Name", JTemplate);
        GenJnlLine.SETRANGE(GenJnlLine."Journal Batch Name", JBatch);
        IF GenJnlLine.FIND('+') THEN BEGIN
            LineNo := GenJnlLine."Line No." + 1000;
        END
        ELSE BEGIN
            LineNo := 1000;
        END;
        GenJnlLine.DELETEALL;
        GenJnlLine.RESET;

        Payments.RESET;
        Payments.SETRANGE(Payments."No.", "No.");
        IF Payments.FIND('-') THEN BEGIN
            PayLine.RESET;
            PayLine.SETRANGE(PayLine.No, Payments."No.");
            IF PayLine.FIND('-') THEN BEGIN
                REPEAT
                    PostHeader(Payments);

                UNTIL PayLine.NEXT = 0;
            END;

            Post := FALSE;
            Post := JournlPosted.PostedSuccessfully();
            //IF Post THEN  BEGIN
            Posted := TRUE;
            Status := Payments.Status::Posted;
            "Posted By" := USERID;
            "Date Posted" := TODAY;
            "Time Posted" := TIME;
            MODIFY;

            //Post Reversal Entries for Commitments
            // Doc_Type:=Doc_Type::"Payment Voucher";
            //CheckBudgetAvail.ReverseEntries(Doc_Type,"No.");
            // END;
        END;

        COMMIT;
        //end of post pv
        //{
        //Print Here
        RESET;
        SETFILTER("No.", "No.");
        Report.run(50004, TRUE, TRUE, Rec);
        RESET;
        //End Print Here
        //}
    end;

    procedure PostHeader(var Payment: Record "Payments Header")
    begin


        IF (Payments."Pay Mode" = Payments."Pay Mode"::Cheque) AND ("Cheque Type" = "Cheque Type"::" ") THEN
            ERROR('Cheque type has to be specified');

        IF Payments."Pay Mode" = Payments."Pay Mode"::Cheque THEN BEGIN
            IF (Payments."Cheque No." = '') AND ("Cheque Type" = "Cheque Type"::"Manual Check") THEN BEGIN
                //  ERROR('Please ensure that the cheque number is inserted');
            END;
        END;


        IF Payments."Pay Mode" = Payments."Pay Mode"::EFT THEN BEGIN
            IF Payments."Cheque No." = '' THEN BEGIN
                ERROR('Please ensure that the EFT number is inserted');
            END;
        END;

        IF Payments."Pay Mode" = Payments."Pay Mode"::EFT THEN BEGIN
            IF Payments."Cheque No." = '' THEN BEGIN
                ERROR('Please ensure that the EFT number is inserted');
            END;
        END;

        IF Payments."Pay Mode" = Payments."Pay Mode"::RTGS THEN BEGIN
            IF Payments."Cheque No." = '' THEN BEGIN
                ERROR('Please ensure that the Letter of Credit ref no. is entered.');
            END;
        END;
        GenJnlLine.RESET;
        GenJnlLine.SETRANGE(GenJnlLine."Journal Template Name", JTemplate);
        GenJnlLine.SETRANGE(GenJnlLine."Journal Batch Name", JBatch);

        IF GenJnlLine.FIND('+') THEN BEGIN
            LineNo := GenJnlLine."Line No." + 1000;
        END
        ELSE BEGIN
            LineNo := 1000;
        END;


        LineNo := LineNo + 1000;
        GenJnlLine.INIT;
        GenJnlLine."Journal Template Name" := JTemplate;
        GenJnlLine.VALIDATE(GenJnlLine."Journal Template Name");
        GenJnlLine."Journal Batch Name" := JBatch;
        GenJnlLine.VALIDATE(GenJnlLine."Journal Batch Name");
        GenJnlLine."Line No." := LineNo;
        GenJnlLine."Source Code" := 'PAYMENTJNL';
        GenJnlLine."Posting Date" := Payment."Payment Release Date";
        IF CustomerPayLinesExist THEN
            GenJnlLine."Document Type" := GenJnlLine."Document Type"::" "
        ELSE
            GenJnlLine."Document Type" := GenJnlLine."Document Type"::" ";
        GenJnlLine."Document No." := Payments."No.";
        GenJnlLine."External Document No." := Payments."Cheque No.";

        IF "Paying Type" = "Paying Type"::Bank THEN BEGIN
            GenJnlLine."Account Type" := GenJnlLine."Account Type"::"Bank Account";
            GenJnlLine."Account No." := Payments."Paying Bank Account";
        END;
        GenJnlLine.VALIDATE(GenJnlLine."Account No.");

        GenJnlLine."Currency Code" := Payments."Currency Code";
        GenJnlLine.VALIDATE(GenJnlLine."Currency Code");
        //CurrFactor
        GenJnlLine."Currency Factor" := Payments."Currency Factor";
        GenJnlLine.VALIDATE("Currency Factor");

        Payments.CALCFIELDS(Payments."Total Net Amount", Payments."Total VAT Amount");
        GenJnlLine.Amount := -(Payments."Total Net Amount" + Payments."Total VAT Amount");
        GenJnlLine.VALIDATE(GenJnlLine.Amount);
        GenJnlLine.VALIDATE(GenJnlLine."Bal. Account No.");
        GenJnlLine."Shortcut Dimension 1 Code" := PayLine."Global Dimension 1 Code";
        GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 1 Code");
        GenJnlLine."Shortcut Dimension 2 Code" := PayLine."Shortcut Dimension 2 Code";
        GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 2 Code");
        GenJnlLine.Description := COPYSTR('Pay To:' + Payments.Payee, 1, 50);
        GenJnlLine.VALIDATE(GenJnlLine.Description);

        IF "Pay Mode" <> "Pay Mode"::Cheque THEN BEGIN
            GenJnlLine."Bank Payment Type" := GenJnlLine."Bank Payment Type"::" "
        END ELSE BEGIN
            IF "Cheque Type" = "Cheque Type"::"Computer Check" THEN
                GenJnlLine."Bank Payment Type" := GenJnlLine."Bank Payment Type"::"Computer Check"
            ELSE
                GenJnlLine."Bank Payment Type" := GenJnlLine."Bank Payment Type"::" "

        END;
        IF GenJnlLine.Amount <> 0 THEN
            GenJnlLine.INSERT;

        //Post Other Payment Journal Entries
        PostPV(Payments);
    end;

    procedure GetAppliedEntries(var LineNo: Integer) InvText: Text[100]
    var
        Appl: Record "CshMgt Application";
    begin


        InvText := '';
        Appl.RESET;
        Appl.SETRANGE(Appl."Document Type", Appl."Document Type"::PV);
        Appl.SETRANGE(Appl."Document No.", "No.");
        Appl.SETRANGE(Appl."Line No.", LineNo);
        IF Appl.FINDFIRST THEN BEGIN
            REPEAT
                InvText := COPYSTR(InvText + ',' + Appl."Appl. Doc. No", 1, 50);
            UNTIL Appl.NEXT = 0;
        END;
    end;

    procedure InsertApproval()
    var
        Appl: Record "CshMgt Approvals";
        LineNo: Integer;
    begin

        LineNo := 0;
        Appl.RESET;
        IF Appl.FINDLAST THEN BEGIN
            LineNo := Appl."Line No.";
        END;

        LineNo := LineNo + 1;

        Appl.RESET;
        Appl.INIT;
        Appl."Line No." := LineNo;
        Appl."Document Type" := Appl."Document Type"::PV;
        Appl."Document No." := "No.";
        Appl."Document Date" := Date;
        Appl."Process Date" := TODAY;
        Appl."Process Time" := TIME;
        Appl."Process User ID" := USERID;
        Appl."Process Name" := "Current Status";
        // Appl."Process Machine":=ENVIRON('COMPUTERNAME');
        Appl.INSERT;
    end;

    procedure LinesCommitmentStatus() Exists: Boolean
    var
        BCSetup: Record "Budgetary Control Setup";
    begin

        IF BCSetup.GET() THEN BEGIN
            IF NOT BCSetup.Mandatory THEN BEGIN
                Exists := FALSE;
                EXIT;
            END;
        END ELSE BEGIN
            Exists := FALSE;
            EXIT;
        END;
        Exists := FALSE;
        PayLine.RESET;
        PayLine.SETRANGE(PayLine.No, "No.");
        PayLine.SETRANGE(PayLine.Committed, FALSE);
        PayLine.SETRANGE(PayLine."Budgetary Control A/C", TRUE);
        IF PayLine.FIND('-') THEN
            Exists := TRUE;
    end;

    procedure CheckPVRequiredItems()
    begin

        IF Posted THEN BEGIN
            ERROR('The Document has already been posted');
        END;
        TESTFIELD("Payment Narration");
        //TESTFIELD(Status,Status::Approved);
        // IF "Paying Type" = "Paying Type"::"2" THEN
        //     TESTFIELD("Paying Bank Account")
        // ELSE
        //     IF "Paying Type" = "Paying Type"::"1" THEN
        //         TESTFIELD("Paying Vendor Account");

        TESTFIELD("Pay Mode");
        TESTFIELD("Payment Release Date");
        //Confirm whether Bank Has the Cash
        IF "Pay Mode" = "Pay Mode"::Cash THEN
            // CheckBudgetAvail.CheckFundsAvailability(Rec);

            //Confirm Payment Release Date is today);
            IF "Pay Mode" = "Pay Mode"::Cash THEN
                TESTFIELD("Payment Release Date");

        /*Check if the user has selected all the relevant fields*/
        Temp.GET(USERID);

        JTemplate := Temp."Payment Journal Template";
        JBatch := Temp."Payment Journal Batch";

        IF JTemplate = '' THEN BEGIN
            ERROR('Ensure the PV Template is set up in Cash Office Setup');
        END;
        IF JBatch = '' THEN BEGIN
            ERROR('Ensure the PV Batch is set up in the Cash Office Setup')
        END;

        IF ("Pay Mode" = "Pay Mode"::Cheque) AND ("Cheque Type" = "Cheque Type"::"Computer Check") THEN BEGIN
            IF NOT CONFIRM(Text002, FALSE) THEN
                ERROR('You have selected to Abort PV Posting');
        END;
        //Check whether there is any printed cheques and lines not posted
        /*CheckLedger.RESET;
        CheckLedger.SETRANGE(CheckLedger."Document No.","No.");
        CheckLedger.SETRANGE(CheckLedger."Entry Status",CheckLedger."Entry Status"::Printed);
        IF CheckLedger.FIND('-') THEN BEGIN
        //Ask whether to void the printed cheque
        GenJnlLine.RESET;
        GenJnlLine.SETRANGE(GenJnlLine."Journal Template Name",JTemplate);
        GenJnlLine.SETRANGE(GenJnlLine."Journal Batch Name",JBatch);
        GenJnlLine.FINDFIRST;
        IF CONFIRM(Text000,FALSE,CheckLedger."Check No.") THEN
          CheckManagement.VoidCheck(GenJnlLine)
          ELSE
           ERROR(Text001,"No.",CheckLedger."Check No.");
        END;
        */

    end;

    procedure PostPV(var Payment: Record "Payments Header")
    begin


        PayLine.RESET;
        PayLine.SETRANGE(PayLine.No, Payments."No.");
        IF PayLine.FIND('-') THEN BEGIN

            REPEAT
                strText := GetAppliedEntries(PayLine."Line No.");
                Payment.TESTFIELD(Payment.Payee);
                PayLine.TESTFIELD(PayLine.Amount);
                PayLine.TESTFIELD(PayLine."Global Dimension 1 Code");
                //BANK
                IF PayLine."Pay Mode" = PayLine."Pay Mode"::Cash THEN BEGIN
                    CashierLinks.RESET;
                    CashierLinks.SETRANGE(CashierLinks.UserID, USERID);
                END;

                //CHEQUE
                LineNo := LineNo + 1000;
                GenJnlLine.INIT;
                GenJnlLine."Journal Template Name" := JTemplate;
                GenJnlLine.VALIDATE(GenJnlLine."Journal Template Name");
                GenJnlLine."Journal Batch Name" := JBatch;
                GenJnlLine.VALIDATE(GenJnlLine."Journal Batch Name");
                GenJnlLine."Source Code" := 'PAYMENTJNL';
                GenJnlLine."Line No." := LineNo;
                GenJnlLine."Posting Date" := Payment."Payment Release Date";
                GenJnlLine."Document No." := PayLine.No;

                //Bett
                IF PayLine."Account Type" = PayLine."Account Type"::Customer THEN BEGIN
                    GenJnlLine."Document Type" := GenJnlLine."Document Type"::" ";
                    GenJnlLine."Transaction Type" := PayLine."Transaction Type";
                    GenJnlLine."Loan No" := PayLine."Loan No.";
                END ELSE
                    GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;

                GenJnlLine."Account Type" := PayLine."Account Type";
                GenJnlLine."Account No." := PayLine."Account No.";
                GenJnlLine.VALIDATE(GenJnlLine."Account No.");
                GenJnlLine."External Document No." := Payments."Cheque No.";
                GenJnlLine.Description := COPYSTR(PayLine."Transaction Name" + ':' + Payment.Payee, 1, 50);
                GenJnlLine."Currency Code" := Payments."Currency Code";
                GenJnlLine.VALIDATE("Currency Code");
                GenJnlLine."Currency Factor" := Payments."Currency Factor";
                GenJnlLine.VALIDATE("Currency Factor");
                IF PayLine."VAT Code" = '' THEN BEGIN
                    GenJnlLine.Amount := PayLine."Net Amount" + PayLine."VAT Amount";
                END
                ELSE BEGIN
                    GenJnlLine.Amount := PayLine."Net Amount" + PayLine."VAT Amount";
                END;
                GenJnlLine.VALIDATE(GenJnlLine.Amount);
                GenJnlLine."VAT Prod. Posting Group" := PayLine."VAT Prod. Posting Group";
                GenJnlLine.VALIDATE(GenJnlLine."VAT Prod. Posting Group");
                //GenJnlLine.VALIDATE(GenJnlLine."Bal. Account No.");
                GenJnlLine."Shortcut Dimension 1 Code" := PayLine."Global Dimension 1 Code";
                GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 1 Code");
                GenJnlLine."Shortcut Dimension 2 Code" := PayLine."Shortcut Dimension 2 Code";
                GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 2 Code");
                //GenJnlLine.ValidateShortcutDimCode(3,PayLine."Shortcut Dimension 3 Code");
                //GenJnlLine.ValidateShortcutDimCode(4,PayLine."Shortcut Dimension 4 Code");
                GenJnlLine."Applies-to Doc. Type" := GenJnlLine."Applies-to Doc. Type"::Invoice;
                GenJnlLine."Applies-to Doc. No." := PayLine."Applies-to Doc. No.";
                //GenJnlLine.VALIDATE(GenJnlLine."Applies-to Doc. No.");
                GenJnlLine."Applies-to ID" := PayLine."Applies-to ID";

                IF GenJnlLine.Amount <> 0 THEN GenJnlLine.INSERT;

                //POST W/TAX to Respective W/TAX GL Account
                TarriffCodes.RESET;
                TarriffCodes.SETRANGE(TarriffCodes.Code, PayLine."Withholding Tax Code");
                IF TarriffCodes.FIND('-') THEN BEGIN
                    TarriffCodes.TESTFIELD(TarriffCodes."Account No.");
                    LineNo := LineNo + 1000;
                    GenJnlLine.INIT;
                    GenJnlLine."Journal Template Name" := JTemplate;
                    GenJnlLine.VALIDATE(GenJnlLine."Journal Template Name");
                    GenJnlLine."Journal Batch Name" := JBatch;
                    GenJnlLine.VALIDATE(GenJnlLine."Journal Batch Name");
                    GenJnlLine."Source Code" := 'PAYMENTJNL';
                    GenJnlLine."Line No." := LineNo;
                    GenJnlLine."Posting Date" := Payment."Payment Release Date";
                    GenJnlLine."Document Type" := GenJnlLine."Document Type"::" ";
                    GenJnlLine."Document No." := PayLine.No;
                    GenJnlLine."External Document No." := Payments."Cheque No.";
                    GenJnlLine."Account Type" := TarriffCodes."Account Type";
                    GenJnlLine."Account No." := TarriffCodes."Account No.";
                    GenJnlLine.VALIDATE(GenJnlLine."Account No.");
                    GenJnlLine."Currency Code" := Payments."Currency Code";
                    GenJnlLine.VALIDATE(GenJnlLine."Currency Code");
                    GenJnlLine."Gen. Posting Type" := GenJnlLine."Gen. Posting Type"::" ";
                    GenJnlLine.VALIDATE(GenJnlLine."Gen. Posting Type");
                    GenJnlLine."Gen. Bus. Posting Group" := '';
                    GenJnlLine.VALIDATE(GenJnlLine."Gen. Bus. Posting Group");
                    GenJnlLine."Gen. Prod. Posting Group" := '';
                    GenJnlLine.VALIDATE(GenJnlLine."Gen. Prod. Posting Group");
                    GenJnlLine."VAT Bus. Posting Group" := '';
                    GenJnlLine.VALIDATE(GenJnlLine."VAT Bus. Posting Group");
                    GenJnlLine."VAT Prod. Posting Group" := '';
                    GenJnlLine.VALIDATE(GenJnlLine."VAT Prod. Posting Group");
                    GenJnlLine.Amount := -PayLine."Withholding Tax Amount";
                    GenJnlLine.VALIDATE(GenJnlLine.Amount);
                    //GenJnlLine."Bal. Account Type":=GenJnlLine."Bal. Account Type"::"G/L Account";
                    GenJnlLine."Bal. Account Type" := TarriffCodes."Account Type";
                    //GenJnlLine."Bal. Account No.":=TarriffCodes."PAYE expense";
                    GenJnlLine.VALIDATE(GenJnlLine."Bal. Account No.");
                    GenJnlLine.Description := COPYSTR('W/Tax:' + FORMAT(PayLine."Account Name") + '::' + strText, 1, 50);
                    GenJnlLine."Shortcut Dimension 1 Code" := PayLine."Global Dimension 1 Code";
                    GenJnlLine."Shortcut Dimension 2 Code" := PayLine."Shortcut Dimension 2 Code";
                    GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 2 Code");
                    GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 1 Code");
                    //GenJnlLine.ValidateShortcutDimCode(3,PayLine."Shortcut Dimension 3 Code");
                    //GenJnlLine.ValidateShortcutDimCode(4,PayLine."Shortcut Dimension 4 Code");
                    IF GenJnlLine.Amount <> 0 THEN
                        GenJnlLine.INSERT;
                END;


            UNTIL PayLine.NEXT = 0;

            COMMIT;
            //Post the Journal Lines
            GenJnlLine.RESET;
            GenJnlLine.SETRANGE(GenJnlLine."Journal Template Name", JTemplate);
            GenJnlLine.SETRANGE(GenJnlLine."Journal Batch Name", JBatch);
            //Adjust Gen Jnl Exchange Rate Rounding Balances
            AdjustGenJnl.RUN(GenJnlLine);
            //End Adjust Gen Jnl Exchange Rate Rounding Balances

            //Before posting if paymode is cheque print the cheque
            IF ("Pay Mode" = "Pay Mode"::Cheque) AND ("Cheque Type" = "Cheque Type"::"Computer Check") THEN BEGIN
                DocPrint.PrintCheck(GenJnlLine);
                CODEUNIT.RUN(CODEUNIT::"Adjust Gen. Journal Balance", GenJnlLine);
                //Confirm Cheque printed //Not necessary.
            END;
            //EXIT;

            CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post", GenJnlLine);
            Post := FALSE;
            Post := JournlPosted.PostedSuccessfully();
            IF Post THEN BEGIN
                IF PayLine.FINDFIRST THEN BEGIN
                    REPEAT
                    //PayLine."Date Posted":=TODAY;
                    //PayLine."Time Posted":=TIME;
                    //PayLine."Posted By":=USERID;
                    //PayLine.Status:=PayLine.Status::Posted;
                    //PayLine.MODIFY;
                    UNTIL PayLine.NEXT = 0;
                END;
            END;

        END;

    end;

    procedure UpdateControls()
    begin

        IF Status <> Status::Approved THEN BEGIN
            PaymentReleasDateEditable := FALSE;
            //CurrForm."Paying Bank Account".EDITABLE:=FALSE;
            //CurrForm."Pay Mode".EDITABLE:=FALSE;
            //CurrForm."Currency Code".EDITABLE:=TRUE;
            "Cheque No.Editable" := FALSE;
            "Cheque TypeEditable" := FALSE;
            "Invoice Currency CodeEditable" := TRUE;
            OnBehalfEditable := TRUE;
            PaymentModeEditable := TRUE;
            GlobalDimension1CodeEditable := TRUE;
        END ELSE BEGIN
            PaymentReleasDateEditable := TRUE;
            //CurrForm."Paying Bank Account".EDITABLE:=TRUE;
            //CurrForm."Pay Mode".EDITABLE:=TRUE;
            IF "Pay Mode" = "Pay Mode"::Cheque THEN
                "Cheque TypeEditable" := TRUE;
            //CurrForm."Currency Code".EDITABLE:=FALSE;
            IF "Cheque Type" <> "Cheque Type"::"Computer Check" THEN
                "Cheque No.Editable" := TRUE;
            "Invoice Currency CodeEditable" := FALSE;
        END;

        IF Status = Status::Pending THEN BEGIN
            CurrencyCodeEditable := TRUE;
            GlobalDimension1CodeEditable := TRUE;
            "Payment NarrationEditable" := TRUE;
            ShortcutDimension2CodeEditable := TRUE;
            PayeeEditable := TRUE;
            OnBehalfEditable := TRUE;
            PaymentModeEditable := TRUE;
            ShortcutDimension3CodeEditable := TRUE;
            ShortcutDimension4CodeEditable := TRUE;
            "Cheque TypeEditable" := TRUE;
            DateEditable := TRUE;
            PVLinesEditable := TRUE;

        END ELSE BEGIN
            CurrencyCodeEditable := FALSE;
            GlobalDimension1CodeEditable := FALSE;
            "Payment NarrationEditable" := FALSE;
            ShortcutDimension2CodeEditable := FALSE;
            PayeeEditable := FALSE;
            OnBehalfEditable := FALSE;
            PaymentModeEditable := TRUE;
            ShortcutDimension3CodeEditable := FALSE;
            ShortcutDimension4CodeEditable := FALSE;
            DateEditable := FALSE;
            PVLinesEditable := FALSE;
            "Cheque TypeEditable" := TRUE;
        END
    end;

    procedure LinesExists(): Boolean
    var
        PayLines: Record "Payment Line";
    begin

        HasLines := FALSE;
        PayLines.RESET;
        PayLines.SETRANGE(PayLines.No, "No.");
        IF PayLines.FIND('-') THEN BEGIN
            HasLines := TRUE;
            EXIT(HasLines);
        END;
    end;

    procedure AllFieldsEntered(): Boolean
    var
        PayLines: Record "Payment Line";
    begin

        AllKeyFieldsEntered := TRUE;
        PayLines.RESET;
        PayLines.SETRANGE(PayLines.No, "No.");
        IF PayLines.FIND('-') THEN BEGIN
            REPEAT
                IF (PayLines."Account No." = '') OR (PayLines.Amount <= 0) THEN
                    AllKeyFieldsEntered := FALSE;
            UNTIL PayLines.NEXT = 0;
            EXIT(AllKeyFieldsEntered);
        END;
    end;

    procedure CustomerPayLinesExist(): Boolean
    var
        PayLine: Record "Payment Line";
    begin

        PayLine.RESET;
        PayLine.SETRANGE(PayLine.No, "No.");
        PayLine.SETRANGE(PayLine."Account Type", PayLine."Account Type"::Customer);
        EXIT(PayLine.FINDFIRST);
    end;
}

