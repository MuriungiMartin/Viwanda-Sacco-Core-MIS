#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50521 "Loan Trunch Disburesment"
{
    PageType = Card;
    SourceTable = "Loan trunch Disburesment";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Document No"; "Document No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Member No"; "Member No")
                {
                    ApplicationArea = Basic;
                    Editable = EnableFields;
                }
                field("Member Name"; "Member Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Loan No"; "Loan No")
                {
                    ApplicationArea = Basic;
                    Editable = EnableFields;
                }
                field("Issue Date"; "Issue Date")
                {
                    ApplicationArea = Basic;
                }
                field("Approved Amount"; "Approved Amount")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Disbursed Amount"; "Disbursed Amount")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Balance Outstanding"; "Balance Outstanding")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Requested Amount"; "Requested Amount")
                {
                    ApplicationArea = Basic;
                    Editable = EnableFields;
                }
                field("Amount to Disburse"; "Amount to Disburse")
                {
                    ApplicationArea = Basic;
                    Editable = EnableFields;
                }
                field("Mode of Disbursement"; "Mode of Disbursement")
                {
                    ApplicationArea = Basic;
                    Editable = EnableFields;
                }
                field(Status; Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("FOSA Account"; "FOSA Account")
                {
                    ApplicationArea = Basic;
                    Editable = EnableFields;
                }
                field("Cheque No/Reference No"; "Cheque No/Reference No")
                {
                    ApplicationArea = Basic;
                    Editable = EnableFields;
                }
                field("User ID"; "User ID")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            group(ActionGroup1000000022)
            {
                action("Post Trunch")
                {
                    ApplicationArea = Basic;
                    Enabled = EnablePost;
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin

                        if Confirm('Are You Sure you Want to Post this trunch?', false) = true then begin

                            BATCH_TEMPLATE := 'PAYMENTS';
                            BATCH_NAME := 'LOANS';
                            DOCUMENT_NO := "Document No";
                            GenJournalLine.Reset;
                            GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                            GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                            GenJournalLine.DeleteAll;

                            //------------------------------------1. DEBIT MEMBER LOAN A/C---------------------------------------------------------------------------------------------
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::Loan,
                            GenJournalLine."account type"::None, "Member No", WorkDate, "Amount to Disburse", '', "Loan No",
                            'Trunch Loan Disbursment - ' + "Loan No", "Loan No", GenJournalLine."application source"::" ");
                            //--------------------------------(Debit Member Loan Account)---------------------------------------------

                            //------------------------------------2. CREDIT MEMBER FOSA A/C---------------------------------------------------------------------------------------------
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                            GenJournalLine."account type"::Vendor, "FOSA Account", WorkDate, "Amount to Disburse" * -1, 'BOSA', "Loan No",
                            'Trunch Loan Disbursment - ' + "Loan No", "Loan No", GenJournalLine."application source"::" ");
                            //----------------------------------(Credit Member Fosa Account)------------------------------------------------
                            GenSetUp.Get;
                            ObjLoans.Reset;
                            ObjLoans.SetRange(ObjLoans."Loan  No.", "Loan No");
                            if ObjLoans.FindSet then begin

                                //------------------------------------3. EARN/RECOVER PRODUCT CHARGES FROM FOSA A/C--------------------------------------
                                PCharges.Reset;
                                PCharges.SetRange(PCharges."Product Code", ObjLoans."Loan Product Type");
                                PCharges.SetFilter(PCharges."Loan Charge Type", '<>%1', PCharges."loan charge type"::"Loan Insurance");
                                if PCharges.FindSet then begin
                                    repeat
                                        PCharges.TestField(PCharges."G/L Account");
                                        GenSetUp.TestField(GenSetUp."Excise Duty Account");
                                        PChargeAmount := PCharges.Amount;
                                        if PCharges."Use Perc" = true then
                                            PChargeAmount := ("Amount to Disburse" * PCharges.Percentage / 100);//LoanDisbAmount
                                                                                                                //-------------------EARN CHARGE-------------------------------------------
                                        LineNo := LineNo + 10000;
                                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                                        GenJournalLine."account type"::"G/L Account", PCharges."G/L Account", WorkDate, PChargeAmount * -1, 'BOSA', ObjLoans."Loan  No.",
                                        PCharges.Description + ' - ' + ObjLoans."Client Code" + ' - ' + ObjLoans."Loan  No.", ObjLoans."Loan  No.", GenJournalLine."application source"::" ");
                                        //-------------------RECOVER-----------------------------------------------
                                        LineNo := LineNo + 10000;
                                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                                        GenJournalLine."account type"::Vendor, "FOSA Account", WorkDate, PChargeAmount, 'BOSA', ObjLoans."Loan  No.",
                                        PCharges.Description + '-' + ObjLoans."Loan Product Type Name", ObjLoans."Loan  No.", GenJournalLine."application source"::" ");

                                        //------------------10% EXCISE DUTY----------------------------------------
                                        if SFactory.FnChargeExcise(PCharges.Code) then begin
                                            //-------------------Earn---------------------------------
                                            LineNo := LineNo + 10000;
                                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                                            GenJournalLine."account type"::"G/L Account", GenSetUp."Excise Duty Account", WorkDate, (PChargeAmount * -1) * 0.1, 'BOSA', ObjLoans."Loan  No.",
                                            'Tax: ' + PCharges.Description + '-' + ObjLoans."Client Code" + '-' + ObjLoans."Loan Product Type Name" + '-' + ObjLoans."Loan  No.", ObjLoans."Loan  No.", GenJournalLine."application source"::" ");
                                            //-----------------Recover---------------------------------
                                            LineNo := LineNo + 10000;
                                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                                            GenJournalLine."account type"::Vendor, "FOSA Account", WorkDate, PChargeAmount * 0.1, 'BOSA', ObjLoans."Loan  No.",
                                            'Tax: ' + PCharges.Description + '-' + ObjLoans."Loan Product Type Name", ObjLoans."Loan  No.", GenJournalLine."application source"::" ");
                                        end
                                    //----------------END 10% EXCISE--------------------------------------------
                                    until PCharges.Next = 0;
                                end;

                                //Post
                                GenJournalLine.Reset;
                                GenJournalLine.SetRange("Journal Template Name", 'PAYMENTS');
                                GenJournalLine.SetRange("Journal Batch Name", 'LOANS');
                                if GenJournalLine.Find('-') then begin
                                    Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJournalLine);
                                end;
                                Posted := true;
                                "Posting Date" := Today;
                                Modify;
                                //Post New

                                ObjLoans."Tranch Amount Disbursed" := ObjLoans."Tranch Amount Disbursed" + "Amount to Disburse";
                                ObjLoans.Modify;
                                SFactory.FnGenerateLoanRepaymentSchedule("Loan No");

                                if ObjMember.Get(ObjLoans."Client Code") then begin
                                    if (ObjMember."Email Indemnified" = true) and (ObjMember."E-Mail" <> '') then begin
                                        VarMemberEmail := Lowercase(ObjMember."E-Mail");

                                        SMTPSetup.Get();
                                        Filename := '';
                                        Filename := SMTPSetup."Path to Save Report" + 'Loan Repayment Schedule.pdf';
                                        Report.SaveAsPdf(Report::"Loans Repayment Schedule", Filename, ObjLoans);

                                        VarMailSubject := 'Trunch Loan Disbursment - ' + ObjLoans."Loan  No.";
                                        VarMailBody := 'Please note that we have disbursed a Loan Trunch of Ksh. ' + Format("Amount to Disburse") + ' for your ' +
                                        ObjLoans."Loan Product Type Name" + ' Account ' + ObjLoans."Loan  No." + ' which now totals to Ksh. ' + Format(ObjLoans."Tranch Amount Disbursed") +
                                        '. Find attached your new loan repayment schedule.';

                                        EmailSend := SFactory.FnSendStatementViaMail(ObjLoans."Client Name", VarMailSubject, VarMailBody, VarMemberEmail,
                                        'Loan Repayment Schedule.pdf', GenSetUp."Credit Department E-mail");
                                    end;
                                end;
                            end;
                        end;

                        Message('Loan Trunch Posted Successfully.');
                    end;
                }
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

                        DocumentType := Documenttype::LoanTrunchDisbursement;
                        ApprovalEntries.Setfilters(Database::"Loan trunch Disburesment", DocumentType, "Document No");
                        ApprovalEntries.Run;
                    end;
                }
                action("Send Approval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        Text001: label 'This transaction is already pending approval';
                        ApprovalMgt: Codeunit "Approvals Mgmt.";
                    begin

                        if WorkflowIntegration.CheckLoanTrunchDisbursementApprovalsWorkflowEnabled(Rec) then
                            WorkflowIntegration.OnSendLoanTrunchDisbursementForApproval(Rec);

                    end;
                }
                action("Cancel Approval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Request';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit "Approvals Mgmt.";
                    begin
                        WorkflowIntegration.OnCancelLoanTrunchDisbursementApprovalRequest(Rec);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        EnableFields := false;
        EnablePost := false;

        if Status = Status::Open then
            EnableFields := true;

        if Status = Status::Approved then
            EnablePost := true;

        if Posted = true then
            EnablePost := false;
    end;

    trigger OnAfterGetRecord()
    begin
        EnableFields := false;
        EnablePost := false;

        if Status = Status::Open then
            EnableFields := true;

        if Status = Status::Approved then
            EnablePost := true;

        if Posted = true then
            EnablePost := false;
    end;

    trigger OnOpenPage()
    begin
        EnableFields := false;
        EnablePost := false;

        if Status = Status::Open then
            EnableFields := true;

        if Status = Status::Approved then
            EnablePost := true;

        if Posted = true then
            EnablePost := false;
    end;

    var
        GenJournalLine: Record "Gen. Journal Line";
        LineNo: Integer;
        SFactory: Codeunit "SURESTEP Factory";
        BATCH_TEMPLATE: Code[50];
        BATCH_NAME: Code[50];
        DOCUMENT_NO: Code[50];
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery,ChangeRequest,TreasuryTransactions,FundsTransfer,SaccoTransfers,ChequeDiscounting,ImprestRequisition,ImprestSurrender,LeaveApplication,BulkWithdrawal,PackageLodging,PackageRetrieval,HouseChange,CRMTraining,PettyCash,StaffClaims,MemberAgentNOKChange,HouseRegistration,LoanPayOff,FixedDeposit,RTGS,DemandNotice,OverDraft,LoanRestructure,SweepingInstructions,ChequeBookApplication,LoanTrunchDisbursement;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        EnableFields: Boolean;
        EnablePost: Boolean;
        ObjLoans: Record "Loans Register";
        ObjMember: Record Customer;
        PCharges: Record "Loan Product Charges";
        GenSetUp: Record "Sacco General Set-Up";
        PChargeAmount: Decimal;
        VarMemberEmail: Text;
        SMTPSetup: Record "SMTP Mail Setup";
        Filename: Text;
        VarMailSubject: Text;
        VarMailBody: Text;
        EmailSend: Boolean;
        AllowPost: Boolean;
        WorkflowIntegration: Codeunit WorkflowIntegration;
}

