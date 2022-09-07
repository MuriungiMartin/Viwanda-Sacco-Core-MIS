#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50349 "Sweeping Instructions Card"
{
    PageType = Card;
    SourceTable = "Member Sweeping Instructions";
    SourceTableView = where(Effected = filter(false));

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Document No"; "Document No")
                {
                    ApplicationArea = Basic;
                }
                field("Member No"; "Member No")
                {
                    ApplicationArea = Basic;
                    Editable = MemberNoEditable;
                }
                field("Member Name"; "Member Name")
                {
                    ApplicationArea = Basic;
                }
                field("Monitor Account"; "Monitor Account")
                {
                    ApplicationArea = Basic;
                    Editable = MonitorAccountEditable;
                }
                field("Monitor Account Type"; "Monitor Account Type")
                {
                    ApplicationArea = Basic;
                }
                field("Monitor Account Type Desc"; "Monitor Account Type Desc")
                {
                    ApplicationArea = Basic;
                    Caption = 'Monitor Account Type Description';
                }
                field("Check Minimum Threshold"; "Check Minimum Threshold")
                {
                    ApplicationArea = Basic;
                    Caption = 'Sweep From Investment Min Threshold';
                    ToolTip = 'Sweep From Investment Account Amount Below Minimum Threshold';

                    trigger OnValidate()
                    begin
                        MinumumThresholdVisible := false;
                        MaximumThresholdVisible := false;
                        if "Check Maximum Threshold" = true then begin
                            MaximumThresholdVisible := true;
                        end;

                        if "Check Minimum Threshold" = true then begin
                            MinumumThresholdVisible := true;
                        end;
                    end;
                }
                field("Check Maximum Threshold"; "Check Maximum Threshold")
                {
                    ApplicationArea = Basic;
                    Caption = 'Swep From Monitor Account Above Max Threshold';

                    trigger OnValidate()
                    begin
                        MinumumThresholdVisible := false;
                        MaximumThresholdVisible := false;
                        if "Check Maximum Threshold" = true then begin
                            MaximumThresholdVisible := true;
                        end;

                        if "Check Minimum Threshold" = true then begin
                            MinumumThresholdVisible := true;
                        end;
                    end;
                }
                group("Minimum Threshold")
                {
                    Visible = MinumumThresholdVisible;
                    field("Minimum Account Threshold"; "Minimum Account Threshold")
                    {
                        ApplicationArea = Basic;
                        Editable = MinThresholdEditable;
                    }
                }
                group("Maximum Threshold")
                {
                    Visible = MaximumThresholdVisible;
                    field("Maximum Account Threshold"; "Maximum Account Threshold")
                    {
                        ApplicationArea = Basic;
                        Editable = MaximumThresholdEditable;
                    }
                }
                field("Investment Account"; "Investment Account")
                {
                    ApplicationArea = Basic;
                    Editable = InvestmentAccountEditable;
                }
                field("Investment Account Type"; "Investment Account Type")
                {
                    ApplicationArea = Basic;
                }
                field("Investment Account Type Desc"; "Investment Account Type Desc")
                {
                    ApplicationArea = Basic;
                    Caption = 'Investment Account Type Description';
                }
                field("Schedule Frequency"; "Schedule Frequency")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        WeeklyVisible := false;
                        MonthlyVisible := false;
                        if "Schedule Frequency" = "schedule frequency"::Weekly then begin
                            WeeklyVisible := true;
                        end;
                        if "Schedule Frequency" = "schedule frequency"::Monthly then begin
                            MonthlyVisible := true;
                        end;
                    end;
                }
                group("Weekly ")
                {
                    Visible = WeeklyVisible;
                    field("Day Of Week"; "Day Of Week")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Day Of Week';
                        Editable = WeeklyEditable;
                    }
                }
                group(Monthly)
                {
                    Visible = MonthlyVisible;
                    field("Day Of Month"; "Day Of Month")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Days Of Month e.g. 05,12,20';
                        Editable = MonthlyEditable;
                    }
                }
                field("Created On"; "Created On")
                {
                    ApplicationArea = Basic;
                }
                field("Created By"; "Created By")
                {
                    ApplicationArea = Basic;
                }
                field(Effected; Effected)
                {
                    ApplicationArea = Basic;
                }
                field("Effected on"; "Effected on")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Effect Change")
            {
                ApplicationArea = Basic;
                Caption = 'Effect Sweeping';
                Enabled = EnableEffectSweeping;
                Image = Customer;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to effect this change?', false) = true then begin
                        Effected := true;
                        "Effected on" := WorkDate;
                        Message('Sweeping Instruction Effected Succesfully');
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

                    if WorkflowIntegration.CheckSweepingInstructionsApprovalsWorkflowEnabled(Rec) then
                        WorkflowIntegration.OnSendSweepingInstructionsForApproval(Rec);
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
                        WorkflowIntegration.OnCancelSweepingInstructionsApprovalRequest(Rec);

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
                    DocumentType := Documenttype::SweepingInstructions;
                    ApprovalEntries.Setfilters(Database::"Member Sweeping Instructions", DocumentType, "Document No");
                    ApprovalEntries.Run;
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin

        EnableEffectSweeping := false;
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RecordId);
        EnabledApprovalWorkflowsExist := true;

        if ((Rec.Status = Status::Approved)) then
            EnableEffectSweeping := true;

        FnRecordRestriction;

        WeeklyVisible := false;
        MonthlyVisible := false;
        if "Schedule Frequency" = "schedule frequency"::Weekly then begin
            WeeklyVisible := true;
        end;
        if "Schedule Frequency" = "schedule frequency"::Monthly then begin
            MonthlyVisible := true;
        end;


        MinumumThresholdVisible := false;
        MaximumThresholdVisible := false;
        if "Check Maximum Threshold" = true then begin
            MaximumThresholdVisible := true;
        end;

        if "Check Minimum Threshold" = true then begin
            MinumumThresholdVisible := true;
        end;
    end;

    trigger OnAfterGetRecord()
    begin
        WeeklyVisible := false;
        MonthlyVisible := false;
        if "Schedule Frequency" = "schedule frequency"::Weekly then begin
            WeeklyVisible := true;
        end;
        if "Schedule Frequency" = "schedule frequency"::Monthly then begin
            MonthlyVisible := true;
        end;


        EnableEffectSweeping := false;
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RecordId);
        EnabledApprovalWorkflowsExist := true;

        if ((Rec.Status = Status::Approved)) then
            EnableEffectSweeping := true;

        FnRecordRestriction;

        MinumumThresholdVisible := false;
        MaximumThresholdVisible := false;
        if "Check Maximum Threshold" = true then begin
            MaximumThresholdVisible := true;
        end;

        if "Check Minimum Threshold" = true then begin
            MinumumThresholdVisible := true;
        end;
    end;

    trigger OnOpenPage()
    begin
        WeeklyVisible := false;
        MonthlyVisible := false;
        if "Schedule Frequency" = "schedule frequency"::Weekly then begin
            WeeklyVisible := true;
        end;
        if "Schedule Frequency" = "schedule frequency"::Monthly then begin
            MonthlyVisible := true;
        end;
    end;

    var
        EnableEffectSweeping: Boolean;
        OpenApprovalEntriesExist: Boolean;
        EnabledApprovalWorkflowsExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery,ChangeRequest,TreasuryTransactions,FundsTransfer,SaccoTransfers,ChequeDiscounting,ImprestRequisition,ImprestSurrender,LeaveApplication,BulkWithdrawal,PackageLodging,PackageRetrieval,HouseChange,CRMTraining,PettyCash,StaffClaims,MemberAgentNOKChange,HouseRegistration,LoanPayOff,FixedDeposit,RTGS,DemandNotice,OverDraft,LoanRestructure,SweepingInstructions;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        MemberNoEditable: Boolean;
        MonitorAccountEditable: Boolean;
        MinThresholdEditable: Boolean;
        MaximumThresholdEditable: Boolean;
        InvestmentAccountEditable: Boolean;
        WeeklyVisible: Boolean;
        MonthlyVisible: Boolean;
        WeeklyEditable: Boolean;
        MonthlyEditable: Boolean;
        MinumumThresholdVisible: Boolean;
        MaximumThresholdVisible: Boolean;
        WorkflowIntegration: Codeunit WorkflowIntegration;

    local procedure FnRecordRestriction()
    begin
        if (Status = Status::Open) then begin
            MemberNoEditable := true;
            MonitorAccountEditable := true;
            MinThresholdEditable := true;
            MaximumThresholdEditable := true;
            InvestmentAccountEditable := true;
            WeeklyEditable := true;
            MonthlyEditable := true;
        end;



        if (Status = Status::"Pending Approval") or (Status = Status::Approved) then begin
            MemberNoEditable := false;
            MonitorAccountEditable := false;
            MinThresholdEditable := false;
            MaximumThresholdEditable := false;
            InvestmentAccountEditable := false;
            WeeklyEditable := false;
            MonthlyEditable := false;
        end;

    end;
}

