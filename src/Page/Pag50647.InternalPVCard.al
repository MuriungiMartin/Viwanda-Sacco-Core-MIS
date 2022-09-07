#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50647 "Internal PV Card"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Internal PV Header";

    layout
    {
        area(content)
        {
            group("EFT Batch")
            {
                Caption = 'EFT Batch';
                field(No; No)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Transaction Description"; "Transaction Description")
                {
                    ApplicationArea = Basic;
                    Editable = TransactionDescriptionEditable;
                }
                field("Global Dimension 1 Code"; "Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                    Editable = TransactionDescriptionEditable;
                }
                field("Global Dimension 2 Code"; "Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                    Editable = TransactionDescriptionEditable;
                }
                field("Cheque No"; "Cheque No")
                {
                    ApplicationArea = Basic;
                    Editable = TransactionDescriptionEditable;
                }
                field("Date Entered"; "Date Entered")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Time Entered"; "Time Entered")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Entered By"; "Entered By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Posted; Posted)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Date Posted"; "Date Posted")
                {
                    ApplicationArea = Basic;
                }
                field("Time Posted"; "Time Posted")
                {
                    ApplicationArea = Basic;
                }
                field("Posted By"; "Posted By")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Total Debits"; "Total Debits")
                {
                    ApplicationArea = Basic;
                }
                field("Total Credits"; "Total Credits")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Total Count"; "Total Count")
                {
                    ApplicationArea = Basic;
                    Caption = 'Record Count';
                }
            }
            part(Control1; "Internal PV Details")
            {
                Editable = TransactionDescriptionEditable;
                SubPageLink = "Header No" = field(No);
            }
        }
    }

    actions
    {
        area(navigation)
        {
        }
        area(processing)
        {
            action("Post Transfer")
            {
                ApplicationArea = Basic;
                Enabled = EnablePost;
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    if Posted = true then begin
                        Error(ErrorAlreadyPosted);
                    end;

                    BATCH_TEMPLATE := 'GENERAL';
                    BATCH_NAME := 'DEFAULT';
                    DOCUMENT_NO := No;

                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                    GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                    if GenJournalLine.Find('-') then begin
                        GenJournalLine.DeleteAll;
                    end;

                    if "Cheque No" = '' then begin
                        "Cheque No" := FnRunAssignChequeNo;
                    end;

                    CalcFields("Total Debits");
                    FnPostDebitSourceAccounts();//-------------Post Transaction


                    //CU posting
                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                    GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                    if GenJournalLine.Find('-') then
                        Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJournalLine);

                    Posted := true;
                    "Date Posted" := Today;
                    "Time Posted" := Time;
                    "Posted By" := UserId;
                    Modify;

                    /*
                    //========================================Update Issued Cheque Nos
                    ObjEFTRTGSDetailsII.RESET;
                    ObjEFTRTGSDetailsII.SETRANGE(ObjEFTRTGSDetailsII."Header No",No);
                    IF ObjEFTRTGSDetailsII.FIND('-') THEN BEGIN
                      REPEAT
                    
                    ObjChequeNosII.RESET;
                    ObjChequeNosII.SETRANGE(ObjChequeNosII."Cheque No.",ObjEFTRTGSDetailsII."Cheque No");
                    IF ObjChequeNosII.FINDSET THEN
                      BEGIN
                        ObjChequeNosII.Issued:=TRUE;
                        ObjChequeNosII.MODIFY;
                        END;
                        UNTIL ObjEFTRTGSDetailsII.NEXT=0;
                    END;
                    MESSAGE('Transaction Posted successfully.');
                    */

                end;
            }
            action("View Schedule")
            {
                ApplicationArea = Basic;
                Caption = 'View Schedule';
                Image = Form;
                Promoted = true;
                PromotedCategory = "Report";

                trigger OnAction()
                begin
                    /*EFTHeader.RESET;
                    EFTHeader.SETRANGE(EFTHeader.No,No);
                    IF EFTHeader.FIND('-') THEN
                    Report.run(50943,TRUE,TRUE,EFTHeader)*/

                end;
            }
            action("Send Approval Request")
            {
                ApplicationArea = Basic;
                Caption = 'Send Approval Request';
                Enabled = (not OpenApprovalEntriesExist) and EnabledApprovalWorkflowsExist;
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedOnly = true;

                trigger OnAction()
                var
                    Text001: label 'This request is already pending approval';
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    CalcFields("Total Credits", "Total Debits");

                    if "Total Credits" <> "Total Debits" then
                        Error('Debit and Credit totals are not Equal');

                    if WKFLWIntegr.CheckInternalPVApprovalsWorkflowEnabled(Rec) then
                        WKFLWIntegr.OnSendInternalPVForApproval(Rec);
                end;
            }
            action("Cancel Approval Request")
            {
                ApplicationArea = Basic;
                Caption = 'Cancel Approval Request';
                Enabled = CanCancelApprovalForRecord;
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedOnly = true;

                trigger OnAction()
                var
                    Approvalmgt: Codeunit "Approvals Mgmt.";
                begin
                    if Confirm('Are you sure you want to cancel this approval request', false) = true then
                        WKFLWIntegr.OnCancelInternalPVApprovalRequest(Rec);
                    Status := Status::Open;
                    Modify;
                end;
            }
            action(Approval)
            {
                ApplicationArea = Basic;
                Caption = 'Approvals';
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedOnly = true;

                trigger OnAction()
                var
                    ApprovalEntries: Page "Approval Entries";
                begin
                    DocumentType := Documenttype::InternalPV;
                    ApprovalEntries.Setfilters(Database::"Internal PV Header", DocumentType, No);
                    ApprovalEntries.Run;
                end;
            }
            action("Post Transfer And Print")
            {
                ApplicationArea = Basic;
                Caption = 'Post Transfer And Print';
                Enabled = EnablePost;
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    if Posted = true then begin
                        Error(ErrorAlreadyPosted);
                    end;

                    BATCH_TEMPLATE := 'GENERAL';
                    BATCH_NAME := 'DEFAULT';
                    DOCUMENT_NO := No;

                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                    GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                    if GenJournalLine.Find('-') then begin
                        GenJournalLine.DeleteAll;
                    end;

                    if "Cheque No" = '' then begin
                        "Cheque No" := FnRunAssignChequeNo;
                    end;

                    CalcFields("Total Debits");
                    FnPostDebitSourceAccounts();//-------------Post Transaction


                    //CU posting
                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                    GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                    if GenJournalLine.Find('-') then
                        Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJournalLine);

                    Posted := true;
                    "Date Posted" := Today;
                    "Time Posted" := Time;
                    "Posted By" := UserId;
                    Modify;

                    PVHeader.Reset;
                    PVHeader.SetRange(PVHeader.No, No);
                    if PVHeader.Find('-') then
                        Report.run(50875, false, true, PVHeader)

                    /*
                    //========================================Update Issued Cheque Nos
                    ObjEFTRTGSDetailsII.RESET;
                    ObjEFTRTGSDetailsII.SETRANGE(ObjEFTRTGSDetailsII."Header No",No);
                    IF ObjEFTRTGSDetailsII.FIND('-') THEN BEGIN
                      REPEAT
                      S
                    ObjChequeNosII.RESET;
                    ObjChequeNosII.SETRANGE(ObjChequeNosII."Cheque No.",ObjEFTRTGSDetailsII."Cheque No");
                    IF ObjChequeNosII.FINDSET THEN
                      BEGIN
                        ObjChequeNosII.Issued:=TRUE;
                        ObjChequeNosII.MODIFY;
                        END;
                        UNTIL ObjEFTRTGSDetailsII.NEXT=0;
                    END;
                    MESSAGE('Transaction Posted successfully.');
                    */

                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        EnablePost := false;
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RecordId);
        EnabledApprovalWorkflowsExist := true;

        if ((Rec.Status = Status::Approved)) then
            EnablePost := true;

        TransactionDescriptionEditable := true;
        BankCodeEditable := true;
        if Status <> Status::Open then begin
            TransactionDescriptionEditable := false;
            BankCodeEditable := false;
        end;
    end;

    trigger OnOpenPage()
    begin
        EnablePost := false;
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RecordId);
        EnabledApprovalWorkflowsExist := true;

        if ((Rec.Status = Status::Approved)) then
            EnablePost := true;

        TransactionDescriptionEditable := true;
        BankCodeEditable := true;
        if Status <> Status::Open then begin
            TransactionDescriptionEditable := false;
            BankCodeEditable := false;
        end;
    end;

    var
        GenJournalLine: Record "Gen. Journal Line";
        GLPosting: Codeunit "Gen. Jnl.-Post Line";
        Account: Record Vendor;
        AccountType: Record "Account Types-Saving Products";
        AvailableBal: Decimal;
        LineNo: Integer;
        PVLinesDetails: Record "Internal PV Lines";
        STORegister: Record "Standing Order Register";
        Accounts: Record Vendor;
        PVHeader: Record "Internal PV Header";
        Transactions: Record Transactions;
        TextGen: Text[250];
        STO: Record "Standing Orders";
        ReffNo: Code[20];
        GenSetup: Record "Sacco General Set-Up";
        SFactory: Codeunit "SURESTEP Factory";
        ObjRTGSCharges: Record "EFT/RTGS Charges Setup";
        BATCH_TEMPLATE: Code[30];
        BATCH_NAME: Code[30];
        DOCUMENT_NO: Code[30];
        EnablePost: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        EnabledApprovalWorkflowsExist: Boolean;
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery,ChangeRequest,TreasuryTransactions,FundsTransfer,SaccoTransfers,ChequeDiscounting,ImprestRequisition,ImprestSurrender,LeaveApplication,BulkWithdrawal,PackageLodging,PackageRetrieval,HouseChange,CRMTraining,PettyCash,StaffClaims,MemberAgentNOKChange,HouseRegistration,LoanPayOff,FixedDeposit,RTGS,DemandNotice,OverDraft,LoanRestructure,SweepingInstructions,ChequeBookApplication,LoanTrunchDisbursement,InwardChequeClearing,InValidPaybillTransactions,InternalPV;
        BankCodeEditable: Boolean;
        TransactionDescriptionEditable: Boolean;
        ErrorAlreadyPosted: label 'Transaction Already Posted';
        ObjChequeNosII: Record "Cheque Book Register";
        ObjEFTRTGSDetailsII: Record "EFT/RTGS Details";
        WKFLWIntegr: Codeunit WorkflowIntegration;

    local procedure FnPostDebitSourceAccounts()
    var
        ObjAccounts: Record Vendor;
        ObjEFTRTGSDetails: Record "EFT/RTGS Details";
        VarBankCharge: Decimal;
        VarSaccoCharge: Decimal;
        VarSaccoCommissionAccount: Code[20];
        VarTotalRtgsCommission: Decimal;
    begin
        GenSetup.Get;

        PVLinesDetails.Reset;
        PVLinesDetails.SetRange(PVLinesDetails."Header No", No);
        PVLinesDetails.SetRange(PVLinesDetails.Type, PVLinesDetails.Type::Debit);
        if PVLinesDetails.FindSet then begin
            repeat
                Message('Debit %1 - %2, %3', PVLinesDetails."Account No.", PVLinesDetails.Description, PVLinesDetails.Amount);
                //------------------------------------1.1. Debit Source A/C---------------------------------------------------------------------------------------------
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLineBranch(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                PVLinesDetails."Account Type", PVLinesDetails."Account No.", Today, PVLinesDetails."Debit Amount", PVLinesDetails."Global Dimension 1 Code", '',
                "Cheque No" + ' ' + PVLinesDetails.Description, "Cheque No", GenJournalLine."application source"::" ", PVLinesDetails."Global Dimension 2 Code");
                //------------------------------------1.2. Credit Control A/C---------------------------------------------------------------------------------------------
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLineBranch(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                GenJournalLine."account type"::"Bank Account", GenSetup."Internal PV Control Account", Today, PVLinesDetails."Debit Amount" * -1, PVLinesDetails."Global Dimension 1 Code", '',
                "Cheque No" + ' ' + PVLinesDetails.Description, '', GenJournalLine."application source"::" ", PVLinesDetails."Global Dimension 2 Code");

            //--------------------------------(Credit Charge to Cash Book A/C)-------------------------------------------------------------------------------


            until PVLinesDetails.Next = 0;
        end;


        PVLinesDetails.Reset;
        PVLinesDetails.SetRange(PVLinesDetails."Header No", No);
        PVLinesDetails.SetRange(PVLinesDetails.Type, PVLinesDetails.Type::Credit);
        if PVLinesDetails.FindSet then begin
            repeat

                //------------------------------------1.1. Debit Control A/C---------------------------------------------------------------------------------------------
                Message('Credit %1 - %2, %3', PVLinesDetails."Account No.", PVLinesDetails.Description, PVLinesDetails.Amount);
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLineBranch(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                GenJournalLine."account type"::"Bank Account", GenSetup."Internal PV Control Account", Today, PVLinesDetails."Credit Amount", 'FOSA', '',
                "Cheque No" + ' ' + PVLinesDetails.Description, "Cheque No", GenJournalLine."application source"::" ", "Global Dimension 2 Code");

                //------------------------------------1.2. Credit Destination A/C---------------------------------------------------------------------------------------------

                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLineBranch(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                PVLinesDetails."Account Type", PVLinesDetails."Account No.", Today, PVLinesDetails."Credit Amount" * -1, 'FOSA', '',
                "Cheque No" + ' ' + PVLinesDetails.Description, '', GenJournalLine."application source"::" ", "Global Dimension 2 Code");

            until PVLinesDetails.Next = 0;
        end;
    end;

    local procedure FnRunAssignChequeNo() VarChequeNo: Code[20]
    var
        ObjChequeRegsiter: Record "Cheque Book Register";
        ObjEFTLines: Record "EFT/RTGS Details";
        VarDestinationBank: Code[30];
    begin
        /*ObjEFTLines.RESET;
        ObjEFTLines.SETRANGE(ObjEFTLines."Header No",No);
        ObjEFTLines.SETFILTER(ObjEFTLines.Amount,'<>%1',0);
        IF ObjEFTLines.FINDFIRST THEN
          BEGIN
            VarDestinationBank:=ObjEFTLines."Destination Cash Book";
            END;
        ObjChequeRegsiter.RESET;
        ObjChequeRegsiter.SETRANGE(ObjChequeRegsiter."Bank Account",VarDestinationBank);
        ObjChequeRegsiter.SETRANGE(ObjChequeRegsiter.Issued,FALSE);
        ObjChequeRegsiter.SETRANGE(ObjChequeRegsiter.Cancelled,FALSE);
        IF ObjChequeRegsiter.FINDFIRST THEN
          BEGIN
            VarChequeNo:=ObjChequeRegsiter."Cheque No.";
            EXIT(VarChequeNo);
            END;*/

    end;
}

