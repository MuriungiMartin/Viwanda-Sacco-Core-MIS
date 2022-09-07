#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50451 "EFT/RTGS Card"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "EFT/RTGS Header";

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
                field(Total; Total)
                {
                    ApplicationArea = Basic;
                }
                field("Total Count"; "Total Count")
                {
                    ApplicationArea = Basic;
                    Caption = 'Record Count';
                }
                field(Transferred; Transferred)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Date Transferred"; "Date Transferred")
                {
                    ApplicationArea = Basic;
                }
                field("Time Transferred"; "Time Transferred")
                {
                    ApplicationArea = Basic;
                }
                field("Transferred By"; "Transferred By")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Additional;
                }
            }
            part(Control1; "EFT/RTGS Details")
            {
                Editable = BankCodeEditable;
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
                    if Transferred = true then begin
                        Error(ErrorAlreadyPosted);
                    end;

                    BATCH_TEMPLATE := 'PURCHASES';
                    BATCH_NAME := 'FTRANS';
                    DOCUMENT_NO := No;

                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", 'PURCHASES');
                    GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
                    if GenJournalLine.Find('-') then begin
                        GenJournalLine.DeleteAll;
                    end;

                    if "Cheque No" = '' then begin
                        "Cheque No" := FnRunAssignChequeNo;
                    end;

                    CalcFields(Total);
                    FnPostDebitSourceAccounts();//-------------Post Transaction


                    //CU posting
                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", 'PURCHASES');
                    GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
                    if GenJournalLine.Find('-') then
                        Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJournalLine);

                    Transferred := true;
                    "Date Transferred" := Today;
                    "Time Transferred" := Time;
                    "Transferred By" := UserId;
                    Modify;

                    //========================================Update Issued Cheque Nos
                    ObjEFTRTGSDetailsII.Reset;
                    ObjEFTRTGSDetailsII.SetRange(ObjEFTRTGSDetailsII."Header No", No);
                    if ObjEFTRTGSDetailsII.Find('-') then begin
                        repeat

                            ObjChequeNosII.Reset;
                            ObjChequeNosII.SetRange(ObjChequeNosII."Cheque No.", ObjEFTRTGSDetailsII."Cheque No");
                            if ObjChequeNosII.FindSet then begin
                                ObjChequeNosII.Issued := true;
                                ObjChequeNosII.Modify;
                            end;
                        until ObjEFTRTGSDetailsII.Next = 0;
                    end;
                    Message('Transaction Posted successfully.');
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
                    EFTHeader.Reset;
                    EFTHeader.SetRange(EFTHeader.No, No);
                    if EFTHeader.Find('-') then
                        Report.run(50943, true, true, EFTHeader)
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
                    ObjEFTRTGSDetailsII.Reset;
                    ObjEFTRTGSDetailsII.SetRange(ObjEFTRTGSDetailsII."Header No", No);
                    if ObjEFTRTGSDetailsII.Find('-') then begin
                        repeat
                            ObjEFTRTGSDetailsII.TestField(ObjEFTRTGSDetailsII."Destination Account No");
                            ObjEFTRTGSDetailsII.TestField(ObjEFTRTGSDetailsII."Destination Account Name");
                        until ObjEFTRTGSDetailsII.Next = 0;
                    end;

                    if workflowintegration.CheckEFTRTGSApprovalsWorkflowEnabled(Rec) then
                        workflowintegration.OnSendEFTRTGSForApproval(Rec);
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
                        workflowintegration.OnCancelEFTRTGSApprovalRequest(Rec);

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
                    DocumentType := Documenttype::RTGS;
                    ApprovalEntries.Setfilters(Database::"EFT/RTGS Header", DocumentType, No);
                    ApprovalEntries.Run;
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
        EFTDetails: Record "EFT/RTGS Details";
        STORegister: Record "Standing Order Register";
        Accounts: Record Vendor;
        EFTHeader: Record "EFT/RTGS Header";
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
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery,ChangeRequest,TreasuryTransactions,FundsTransfer,SaccoTransfers,ChequeDiscounting,ImprestRequisition,ImprestSurrender,LeaveApplication,BulkWithdrawal,PackageLodging,PackageRetrieval,HouseChange,CRMTraining,PettyCash,StaffClaims,MemberAgentNOKChange,HouseRegistration,LoanPayOff,FixedDeposit,RTGS;
        BankCodeEditable: Boolean;
        TransactionDescriptionEditable: Boolean;
        ErrorAlreadyPosted: label 'Transaction Already Posted';
        ObjChequeNosII: Record "Cheque Book Register";
        ObjEFTRTGSDetailsII: Record "EFT/RTGS Details";
        workflowintegration: Codeunit WorkflowIntegration;

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

        ObjEFTRTGSDetails.Reset;
        ObjEFTRTGSDetails.SetRange(ObjEFTRTGSDetails."Header No", No);
        if ObjEFTRTGSDetails.Find('-') then begin
            repeat
                ObjEFTRTGSDetails.TestField(ObjEFTRTGSDetails."Destination Account No");
                ObjEFTRTGSDetails.TestField(ObjEFTRTGSDetails."Destination Account Name");

                ObjRTGSCharges.Reset;
                ObjRTGSCharges.SetRange(ObjRTGSCharges.Code, ObjEFTRTGSDetails."EFT/RTGS Type");
                if ObjRTGSCharges.FindSet then begin
                    VarBankCharge := ObjRTGSCharges."Bank Commission" + ((GenSetup."Excise Duty(%)" / 100) * ObjRTGSCharges."Bank Commission");
                    VarSaccoCharge := ObjRTGSCharges."SACCO Commission";
                    VarSaccoCommissionAccount := ObjRTGSCharges."GL Account";
                    VarTotalRtgsCommission := ObjRTGSCharges."Bank Commission" + VarSaccoCharge;
                end;


                //------------------------------------1. CREDIT CASH BOOK  A/C---------------------------------------------------------------------------------------------
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                GenJournalLine."account type"::"Bank Account", ObjEFTRTGSDetails."Destination Cash Book", Today, ObjEFTRTGSDetails.Amount * -1, 'FOSA', '',
                'Chq. No' + ' ' + ObjEFTRTGSDetails."Cheque No" + ' ' + "Transaction Description", ObjEFTRTGSDetails."Cheque No", GenJournalLine."application source"::" ");
                //--------------------------------(Credit Cash Book Account)-------------------------------------------------------------------------------

                //------------------------------------1.1. Debit Member Source EFT/RTGs Amount A/C---------------------------------------------------------------------------------------------
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                GenJournalLine."account type"::Vendor, ObjEFTRTGSDetails."Account No", Today, ObjEFTRTGSDetails.Amount, 'FOSA', '',
                'RTGS:' + 'Chq. No' + ' ' + ObjEFTRTGSDetails."Cheque No" + ' ' + ObjEFTRTGSDetails."Transaction Description", ObjEFTRTGSDetails."Cheque No", GenJournalLine."application source"::" ");
                //--------------------------------(Debit Member Source Account EFT/RTGs Amount)-------------------------------------------------------------------------------

                //------------------------------------1.2. Debit Member Source EFT Charge A/C---------------------------------------------------------------------------------------------
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                GenJournalLine."account type"::Vendor, ObjEFTRTGSDetails."Account No", Today, VarTotalRtgsCommission, 'FOSA', '',
                'RTGS Charge ' + Format(No), '', GenJournalLine."application source"::" ");
                //--------------------------------(Debit Member Source Bank Charge)-------------------------------------------------------------------------------

                //------------------------------------1.3. Credit Charge to Cash Book A/C---------------------------------------------------------------------------------------------
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                GenJournalLine."account type"::"Bank Account", ObjEFTRTGSDetails."Destination Cash Book", Today, VarBankCharge * -1, 'FOSA', '',
                'RTGS Charge ' + Format(No), '', GenJournalLine."application source"::" ");
                //--------------------------------(Credit Charge to Cash Book A/C)-------------------------------------------------------------------------------

                //------------------------------------1.4. Credit Charge to G/L A/C---------------------------------------------------------------------------------------------
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                GenJournalLine."account type"::"G/L Account", VarSaccoCommissionAccount, Today, VarSaccoCharge * -1, 'FOSA', '',
                'RTGS Charge ' + Format(No), '', GenJournalLine."application source"::" ");
                //--------------------------------(Credit Charge to G/L A/C)-------------------------------------------------------------------------------

                GenSetup.Get();
                //------------------------------------1.5. Debit Tax Charge From Member A/C---------------------------------------------------------------------------------------------
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                GenJournalLine."account type"::Vendor, ObjEFTRTGSDetails."Account No", Today, (VarTotalRtgsCommission) * (GenSetup."Excise Duty(%)" / 100), 'FOSA', '',
                'RTGS Charge Tax' + Format(No), '', GenJournalLine."application source"::" ");
                //--------------------------------(Credit Charge to G/L A/C)-------------------------------------------------------------------------------

                //------------------------------------1.6. Credit Charge to G/L A/C---------------------------------------------------------------------------------------------
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                GenJournalLine."account type"::"G/L Account", GenSetup."Excise Duty Account", Today, (VarSaccoCharge * (GenSetup."Excise Duty(%)" / 100)) * -1, 'FOSA', '',
                'RTGS Charge Tax' + Format(No), '', GenJournalLine."application source"::" ");
            //--------------------------------(Credit Charge to G/L A/C)-------------------------------------------------------------------------------
            until ObjEFTRTGSDetails.Next = 0;
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

