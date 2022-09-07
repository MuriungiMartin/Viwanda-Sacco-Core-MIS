#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50888 "Closed CRM Training Card"
{
    DeleteAllowed = false;
    Editable = false;
    PageType = Card;
    SourceTable = "CRM Trainings";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Code"; Code)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Description; Description)
                {
                    ApplicationArea = Basic;
                }
                field("Start Date"; "Start Date")
                {
                    ApplicationArea = Basic;
                }
                field("End Date"; "End Date")
                {
                    ApplicationArea = Basic;
                }
                field("Duration Units"; "Duration Units")
                {
                    ApplicationArea = Basic;
                }
                field(Duration; Duration)
                {
                    ApplicationArea = Basic;
                }
                field("Cost Of Training"; "Cost Of Training")
                {
                    ApplicationArea = Basic;
                }
                field(Location; Location)
                {
                    ApplicationArea = Basic;
                }
                field("Re-Assessment Date"; "Re-Assessment Date")
                {
                    ApplicationArea = Basic;
                }
                field("Need Source"; "Need Source")
                {
                    ApplicationArea = Basic;
                }
                field(Provider; Provider)
                {
                    ApplicationArea = Basic;
                }
                field("Provider Name"; "Provider Name")
                {
                    ApplicationArea = Basic;
                }
                field(Closed; Closed)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Training Scope"; "Training Scope")
                {
                    ApplicationArea = Basic;
                    MultiLine = true;
                }
                field("Global Dimension 1 Code"; "Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Global Dimension 2 Code"; "Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Status)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approval Status';
                    Editable = false;
                    Importance = Additional;
                }
                field("Training Status"; "Training Status")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Additional;
                }
                field("Created By"; "Created By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Additional;
                }
                field("Created On"; "Created On")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Additional;
                }
                field("Total Attendees"; "Total Attendees")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            part(Control19; "CRM Trainees")
            {
                SubPageLink = "Training Code" = field(Code);
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(ImportTrainees)
            {
                ApplicationArea = Basic;
                Image = Import;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = XMLport "Import BD Trainees";
            }
            action("Close Training")
            {
                ApplicationArea = Basic;
                Enabled = EnableActivateTraining;
                Image = Customer;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to close this training?', false) = true then begin
                        "Training Status" := "training status"::Closed;
                        Closed := true;
                        Modify;
                    end;
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

                    if WorkflowIntegration.CheckCRMTrainingApprovalsWorkflowEnabled(Rec) then
                        WorkflowIntegration.OnSendCRMTrainingForApproval(Rec);
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
                        WorkflowIntegration.OnCancelCRMTrainingApprovalRequest(Rec);
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
                    DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery,ChangeRequest,TreasuryTransactions,FundsTransfer,SaccoTransfers,ChequeDiscounting,ImprestRequisition,ImprestSurrender,LeaveApplication,BulkWithdrawal,PackageLodging,PackageRetrieval,HouseChange,CRMTraining;
                begin
                    DocumentType := Documenttype::CRMTraining;
                    ApprovalEntries.Setfilters(Database::"CRM Trainings", DocumentType, Code);
                    ApprovalEntries.Run;
                end;
            }
            action("Training Cost/Suppliers")
            {
                ApplicationArea = Basic;
                Image = Form;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "CRM Training Suppliers";
                RunPageLink = "CRM Training No" = field(Code);
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        EnableActivateTraining := false;
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RecordId);
        EnabledApprovalWorkflowsExist := true;

        if ((Rec.Status = Status::Approved)) then
            EnableActivateTraining := true;
    end;

    trigger OnOpenPage()
    begin
        EnableActivateTraining := false;
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RecordId);
        EnabledApprovalWorkflowsExist := true;

        if ((Rec.Status = Status::Approved)) then
            EnableActivateTraining := true;
    end;

    var
        EnableActivateTraining: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        EnabledApprovalWorkflowsExist: Boolean;
        WorkflowIntegration: Codeunit WorkflowIntegration;
}

