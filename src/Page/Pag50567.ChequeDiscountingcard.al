#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50567 "Cheque Discounting card"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Cheque Discounting";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Transaction No"; "Transaction No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Member No"; "Member No")
                {
                    ApplicationArea = Basic;
                    Editable = MemberNoEditable;
                }
                field("Member Name"; "Member Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Savings Product"; "Savings Product")
                {
                    ApplicationArea = Basic;
                    Editable = SavingsProductEditable;
                }
                field("Account No"; "Account No")
                {
                    ApplicationArea = Basic;
                    Editable = AccountNoEditable;
                }
                field("Cheque to Discount"; "Cheque to Discount")
                {
                    ApplicationArea = Basic;
                    Editable = ChequetoDiscountEditable;
                }
                field("Cheque Amount"; "Cheque Amount")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Cheque No"; "Cheque No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Expected Maturity Date"; "Expected Maturity Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Percentage Discount"; "Percentage Discount")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Discount Amount Allowable"; "Discount Amount Allowable")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Amount Discounted"; "Amount Discounted")
                {
                    ApplicationArea = Basic;
                    Editable = AmounttoDiscountEditable;
                }
                field("Discounted Amount+Fee"; "Discounted Amount+Fee")
                {
                    ApplicationArea = Basic;
                    Caption = 'Discounted Amount+Commission';
                    Editable = false;
                }
                field(Status; Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Created By"; "Created By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Date Created"; "Date Created")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Posted; Posted)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Posted By"; "Posted By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Date Posted"; "Date Posted")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
        }
        area(factboxes)
        {
            part(Control1000000029; "FOSA Statistics FactBox")
            {
                SubPageLink = "No." = field("Account No");
            }
            part(Control1000000028; "Member Statistics FactBox")
            {
                SubPageLink = "No." = field("Member No");
            }
            part(Control1000000027; "Vendor Picture-Uploaded")
            {
                SubPageLink = "No." = field("Account No");
            }
            part(Control1000000026; "Vendor Signature-Uploaded")
            {
                SubPageLink = "No." = field("Account No");
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Post Cheque Discount")
            {
                ApplicationArea = Basic;
                Enabled = EnablePosting;
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to discount this Cheque ?', false) = true then begin
                        if Status <> Status::Approved then begin
                            Error('Status Must be Approved')
                        end else
                            if Accounts.Get("Account No") then
                                Accounts."Cheque Discounted" := Accounts."Cheque Discounted" + "Amount Discounted";
                        Accounts."Comission On Cheque Discount" := "Discounted Amount+Fee" - "Amount Discounted";
                        Accounts.Modify;


                        BATCH_TEMPLATE := 'GENERAL';
                        BATCH_NAME := 'DEFAULT';
                        DOCUMENT_NO := "Transaction No";

                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                        GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                        GenJournalLine.DeleteAll;
                        ObjGensetup.Get;

                        //------------------------------------1. Debit FOSA Account Discounting Fee---------------------------------------------------------------------------------------------
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                        GenJournalLine."account type"::Vendor, "Account No", WorkDate, "Cheque Discounting Commission", 'FOSA', '',
                        'Cheque Discounting (ENC) Fee #' + "Cheque No", '', GenJournalLine."application source"::" ");

                        //------------------------------------2. Debit FOSA Account Tax: Discounting Fee---------------------------------------------------------------------------------------------
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                        GenJournalLine."account type"::Vendor, "Account No", WorkDate, "Cheque Discounting Commission" * (ObjGensetup."Excise Duty(%)" / 100), 'FOSA', '',
                        'Tax: Cheque Discounting (ENC) Fee #' + "Cheque No", '', GenJournalLine."application source"::" ");

                        //------------------------------------3. Credit Income G/L---------------------------------------------------------------------------------------------
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                        GenJournalLine."account type"::"G/L Account", ObjGensetup."Cheque Discounting Fee Account", WorkDate, "Cheque Discounting Commission" * -1, 'FOSA', '',
                        'Cheque Discounting (ENC) Fee #' + "Cheque No" + ' Acc. ' + "Account No", '', GenJournalLine."application source"::" ");
                        //-----------------------------------(Credit Income G/L)---------------------------------------------

                        //------------------------------------4. Credit Tax G/L---------------------------------------------------------------------------------------------
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                        GenJournalLine."account type"::"G/L Account", ObjGensetup."Excise Duty Account", WorkDate, "Cheque Discounting Commission" * (ObjGensetup."Excise Duty(%)" / 100) * -1, 'FOSA', '',
                        'Tax: Cheque Discounting (ENC) Fee #' + "Cheque No" + ' Acc. ' + "Account No", '', GenJournalLine."application source"::" ");
                        //-----------------------------------(Credit Tax G/L)---------------------------------------------

                        //CU posting
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                        GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                        if GenJournalLine.Find('-') then
                            Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);

                    end;
                    Message('Cheque has been discounted Successfuly');
                    Posted := true;
                    "Posted By" := UserId;
                    "Date Posted" := Today;

                    ObjTransactions.Reset;
                    ObjTransactions.SetRange(ObjTransactions.No, "Cheque to Discount");
                    if ObjTransactions.FindSet then begin
                        ObjTransactions."Cheque Discounted Amount" := ObjTransactions."Cheque Discounted Amount" + "Amount Discounted";
                        ObjTransactions.Modify;
                    end;
                end;
            }
            group(Approvals)
            {
                Caption = 'Approvals';
                action(Approval)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approvals';
                    Image = Approval;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                    begin

                        DocumentType := Documenttype::ChequeDiscounting;
                        ApprovalEntries.Setfilters(Database::"Cheque Discounting", DocumentType, "Transaction No");
                        ApprovalEntries.Run;
                    end;
                }
                action("Send Approval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send A&pproval Request';
                    Enabled = (not OpenApprovalEntriesExist) and EnabledApprovalWorkflowsExist;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        Text001: label 'This transaction is already pending approval';
                        ApprovalMgt: Codeunit "Approvals Mgmt.";
                    begin

                        if WKFLWIntegr.CheckChequeDiscountingApprovalsWorkflowEnabled(Rec) then
                            WKFLWIntegr.OnSendChequeDiscountingForApproval(Rec)
                    end;
                }
                action("Cancel Approval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Request';
                    Enabled = CanCancelApprovalForRecord;
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit "Approvals Mgmt.";
                    begin
                        if WKFLWIntegr.CheckChequeDiscountingApprovalsWorkflowEnabled(Rec) then
                            WKFLWIntegr.OnCancelChequeDiscountingApprovalRequest(Rec);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        FnAddRecordRestriction();

        EnablePosting := false;
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RecordId);
        EnabledApprovalWorkflowsExist := true;
        if Rec.Status = Status::Approved then begin
            OpenApprovalEntriesExist := false;
            CanCancelApprovalForRecord := false;
            EnabledApprovalWorkflowsExist := false;
        end;
        if (Rec.Status = Status::Approved) then
            EnablePosting := true;
    end;

    trigger OnAfterGetRecord()
    begin
        FnAddRecordRestriction();
    end;

    trigger OnOpenPage()
    begin
        FnAddRecordRestriction();
    end;

    var
        Accounts: Record Vendor;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery,ChangeRequest,TreasuryTransactions,FundsTransfer,SaccoTransfers,ChequeDiscounting;
        MemberNoEditable: Boolean;
        SavingsProductEditable: Boolean;
        AccountNoEditable: Boolean;
        ChequetoDiscountEditable: Boolean;
        AmounttoDiscountEditable: Boolean;
        OpenApprovalEntriesExist: Boolean;
        EnabledApprovalWorkflowsExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
        EventFilter: Text;
        EnablePosting: Boolean;
        ObjTransactions: Record Transactions;
        GenJournalLine: Record "Gen. Journal Line";
        BATCH_TEMPLATE: Code[30];
        BATCH_NAME: Code[30];
        DOCUMENT_NO: Code[30];
        LineNo: Integer;
        SFactory: Codeunit "SURESTEP Factory";
        ObjGensetup: Record "Sacco General Set-Up";
        WKFLWIntegr: codeunit WorkflowIntegration;

    local procedure FnAddRecordRestriction()
    begin
        if Status = Status::Open then begin
            MemberNoEditable := true;
            SavingsProductEditable := true;
            AccountNoEditable := true;
            ChequetoDiscountEditable := true;
            AmounttoDiscountEditable := true
        end else
            if Status = Status::"Pending Approval" then begin
                MemberNoEditable := false;
                SavingsProductEditable := false;
                AccountNoEditable := false;
                ChequetoDiscountEditable := false;
                AmounttoDiscountEditable := false
            end else
                if Status = Status::Approved then begin
                    MemberNoEditable := false;
                    SavingsProductEditable := false;
                    AccountNoEditable := false;
                    ChequetoDiscountEditable := false;
                    AmounttoDiscountEditable := false
                end;
    end;
}

