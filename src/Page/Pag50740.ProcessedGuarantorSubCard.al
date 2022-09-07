#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50740 "Processed Guarantor Sub Card"
{
    Editable = false;
    PageType = Card;
    SourceTable = "Guarantorship Substitution H";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Substituting Member"; "Substituting Member")
                {
                    ApplicationArea = Basic;
                    Editable = SubMemberEditable;
                }
                field("Substituting Member Name"; "Substituting Member Name")
                {
                    ApplicationArea = Basic;
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
                field(Substituted; Substituted)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Date Substituted"; "Date Substituted")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Substituted By"; "Substituted By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            part(Control1000000014; "Guarantor Sub Subform")
            {
                SubPageLink = "Document No" = field("Document No");
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(Approvals)
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
                    DocumentType := Documenttype::GuarantorSubstitution;

                    ApprovalEntries.Setfilters(Database::"Cheque Processing Charges", DocumentType, "Document No");
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
                    text001: label 'This batch is already pending approval';
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    if Status <> Status::Open then
                        Error(text001);
                    /*
                    IF ApprovalsMgmt.CheckFundsTransferWorkflowEnabled(Rec) THEN
                      ApprovalsMgmt.OnSendVendChangeForApproval(Rec);
                    */

                end;
            }
            action("Cancel Approval Request")
            {
                ApplicationArea = Basic;
                Caption = 'Cancel A&pproval Request';
                Image = Cancel;
                Promoted = true;
                PromotedCategory = Category4;

                trigger OnAction()
                var
                    text001: label 'This batch is already pending approval';
                    ApprovalMgt: Codeunit "Approvals Mgmt.";
                begin
                    if Status <> Status::Open then
                        Error(text001);

                    //ApprovalMgt.Cancelg;
                end;
            }
            action("Process Substitution")
            {
                ApplicationArea = Basic;
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    //IF Status<>Status::Approved THEN
                    //ERROR('This Application has to be Approved');
                    /*
                  LGuarantor.RESET;
                  LGuarantor.SETRANGE(LGuarantor."Loan No","Loan Guaranteed");
                  LGuarantor.SETRANGE(LGuarantor."Member No","Substituting Member");
                  IF LGuarantor.FINDSET THEN BEGIN

                    GSubLine.RESET;
                    GSubLine.SETRANGE(GSubLine."Document No","Document No");
                    GSubLine.SETRANGE(GSubLine."Member No","Substituting Member");
                    IF GSubLine.FINDSET THEN BEGIN
                      LGuarantor.Substituted:=TRUE;
                      LGuarantor."Substituted Guarantor":=GSubLine."Substitute Member";
                      LGuarantor."Substituted Guarantor Name":=GSubLine."Substitute Member Name";
                      LGuarantor.MODIFY;


                        LGuarantor.INIT;
                        LGuarantor."Loan No":="Loan Guaranteed";
                        LGuarantor."Member No":=GSubLine."Substitute Member";
                        LGuarantor.Name:=GSubLine."Substitute Member Name";
                        LGuarantor."Amont Guaranteed":=GSubLine."Sub Amount Guaranteed";
                        LGuarantor.INSERT;
                      END;
                    END;

                  Substituted:=TRUE;
                  "Date Substituted":=TODAY;
                  "Substituted By":=USERID;
                  MODIFY;

                  MESSAGE('Guarantor Substituted Succesfully');
                  */

                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        FNAddRecordRestriction();
    end;

    trigger OnAfterGetRecord()
    begin
        FNAddRecordRestriction();
    end;

    var
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery,ChangeRequest,TreasuryTransactions,FundsTransfer,SaccoTransfers,ChequeDiscounting,ImprestRequisition,ImprestSurrender,LeaveApplication,GuarantorSubstitution;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        LGuarantor: Record "Loans Guarantee Details";
        GSubLine: Record "Guarantorship Substitution L";
        LoaneeNoEditable: Boolean;
        LoanGuaranteedEditable: Boolean;
        SubMemberEditable: Boolean;

    local procedure FNAddRecordRestriction()
    begin
        if Status = Status::Open then begin
            LoaneeNoEditable := true;
            LoanGuaranteedEditable := true;
            SubMemberEditable := true
        end else
            if Status = Status::Pending then begin
                LoaneeNoEditable := false;
                LoanGuaranteedEditable := false;
                SubMemberEditable := false
            end else
                if Status = Status::Approved then begin
                    LoaneeNoEditable := false;
                    LoanGuaranteedEditable := false;
                    SubMemberEditable := false;
                end;
    end;
}

