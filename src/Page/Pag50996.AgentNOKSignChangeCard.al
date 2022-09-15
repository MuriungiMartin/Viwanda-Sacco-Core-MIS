#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50996 "Agent/NOK/Sign. Change Card"
{
    PageType = Card;
    SourceTable = "Member Agent/Next Of Kin Chang";

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
                    Editable = MemberNoEditable;
                }
                field("Member Name"; "Member Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Account Type"; "Account Type")
                {
                    ApplicationArea = Basic;
                    Editable = AccountTypeEditable;

                    trigger OnValidate()
                    begin
                        AccountEditable := false;
                        if "Account Type" = "account type"::FOSA then
                            AccountEditable := true;

                        ChangeTypeEditable := true;
                        if "Account Type" = "account type"::" " then
                            ChangeTypeEditable := false;
                    end;
                }
                field("Change Type"; "Change Type")
                {
                    ApplicationArea = Basic;
                    Editable = ChangeTypeEditable;

                    trigger OnValidate()
                    begin
                        FnGetListShow();
                    end;
                }
                field("Captured By"; "Captured By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Captured On"; "Captured On")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Change Effected"; "Change Effected")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Status; Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            part("BOSA Next of Kin"; "Member Next Of Kin Change")
            {
                Caption = 'Member Next Of Kin Details';
                Editable = LinesEditable;
                SubPageLink = "Document No" = field("Document No");
                Visible = VarBOSANOKVisible;
            }
            // part("Account Agent";"Loan Reschedule List")
            // {
            //     Caption = 'Account Agent Details';
            //     Editable = LinesEditable;
            //     SubPageLink = "Document No"=field("Document No");
            //                  // "Document No"=field("Account No");
            //     Visible = VarAccountAgentVisible;
            // }
            part(Control14; "Member Acc. Signatory Change")
            {
                SubPageLink = "Account No" = field("Account No"),
                              "Document No" = field("Document No");
                Visible = VarAccountSignatoriesVisible;
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
                Image = Customer;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    if Confirm('Confirm you want to effect this Change', false) = true then begin
                        if ("Account Type" = "account type"::BOSA) and ("Change Type" = "change type"::"Account Next Of Kin Change") then begin
                            FnRunMemberNextofKinChange_Effect("Document No");
                        end;

                        if ("Account Type" = "account type"::BOSA) and ("Change Type" = "change type"::"Account Agent Change") then begin
                            FnRunMemberAgentDetailsChange_Effect("Document No");
                        end;

                        if ("Account Type" = "account type"::FOSA) and ("Change Type" = "change type"::"Account Next Of Kin Change") then begin
                            FnRunAccountNextofKinChange_Effect("Document No");
                        end;

                        if ("Account Type" = "account type"::FOSA) and ("Change Type" = "change type"::"Account Agent Change") then begin
                            FnRunAccountAgentDetailsChange_Effect("Document No");
                        end;

                        if ("Change Type" = "change type"::"Account Signatory Change") then begin
                            FnRunAccountSignatoriesChange_Effect("Document No");
                        end;

                    end;
                    "Change Effected" := true;
                    "Change Effected By" := UserId;
                    "Change Effected On" := WorkDate;
                    AllowEffect := false;
                    Message('Change Effected Succesfully');
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

                    if WorkflowIntegration.CheckMemberAgentNOKChangeApprovalsWorkflowEnabled(Rec) then
                        WorkflowIntegration.OnSendMemberAgentNOKChangeForApproval(Rec);
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
                        WorkflowIntegration.OnCancelMemberAgentNOKChangeApprovalRequest(Rec);

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
                    DocumentType := Documenttype::MemberAgentNOKChange;
                    ApprovalEntries.Setfilters(Database::"Member Agent/Next Of Kin Chang", DocumentType, "Document No");
                    ApprovalEntries.Run;
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        //FnGetListShow();

        EnableCreateMember := false;
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RecordId);
        EnabledApprovalWorkflowsExist := true;

        if ((Rec.Status = Status::Approved)) then
            EnableCreateMember := true;
    end;

    trigger OnAfterGetRecord()
    begin
        if Status = Status::Open then begin
            MemberNoEditable := true;
            AccountTypeEditable := true;
            AccountNoEditable := true;
            ChangeTypeEditable := true;
            AllowEffect := false;
        end else
            if Status = Status::"Pending Approval" then begin
                MemberNoEditable := false;
                AccountTypeEditable := false;
                AccountNoEditable := false;
                ChangeTypeEditable := false;
                AllowEffect := false;
            end else
                if Status = Status::Approved then begin
                    MemberNoEditable := false;
                    AccountTypeEditable := false;
                    AccountNoEditable := false;
                    ChangeTypeEditable := false;
                    AllowEffect := true;
                end;

        EnableCreateMember := false;
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RecordId);
        EnabledApprovalWorkflowsExist := true;

        if ((Rec.Status = Status::Approved)) then begin
            EnableCreateMember := true;
            AllowEffect := true;
        end;

        FnGetListShow();


        LinesEditable := true;
        if "Change Effected" = true then begin
            LinesEditable := false;
            AllowEffect := false;
        end;
    end;

    trigger OnOpenPage()
    begin
        FnGetListShow();

        if Status = Status::Open then begin
            MemberNoEditable := true;
            AccountTypeEditable := true;
            AccountNoEditable := true;
            ChangeTypeEditable := true;
            AccountEditable := false;
            AllowEffect := false;
            if "Account Type" = "account type"::FOSA then
                AccountEditable := true;

            if "Account Type" = "account type"::" " then
                ChangeTypeEditable := false;
        end else
            if Status = Status::"Pending Approval" then begin
                MemberNoEditable := false;
                AccountTypeEditable := false;
                AccountNoEditable := false;
                ChangeTypeEditable := false;
                AllowEffect := false;
            end else
                if Status = Status::Approved then begin
                    MemberNoEditable := false;
                    AccountTypeEditable := false;
                    AccountNoEditable := false;
                    ChangeTypeEditable := false;
                    AllowEffect := true;
                end;

        LinesEditable := true;
        if "Change Effected" = true then begin
            LinesEditable := false;
            AllowEffect := false;
        end;
    end;

    var
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery,ChangeRequest,TreasuryTransactions,FundsTransfer,SaccoTransfers,ChequeDiscounting,ImprestRequisition,ImprestSurrender,LeaveApplication,BulkWithdrawal,PackageLodging,PackageRetrieval,HouseChange,CRMTraining,PettyCash,StaffClaims,MemberAgentNOKChange;
        EnableCreateMember: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        EnabledApprovalWorkflowsExist: Boolean;
        ObjCust: Record Customer;
        MemberNoEditable: Boolean;
        AccountNoEditable: Boolean;
        ChangeTypeEditable: Boolean;
        AccountTypeEditable: Boolean;
        VarBOSANOKVisible: Boolean;
        VarFOSANOKVisible: Boolean;
        VarAccountAgentVisible: Boolean;
        ObjMemberNextofKinChange: Record "Member NOK Change Request";
        ObjMemberAccountAgent: Record "Account Agents Change Request";
        ObjMemberNOKDetails: Record "Members Next of Kin";
        ObjAccountNOKDetails: Record "FOSA Account NOK Details";
        ObjAccountAgentDetails: Record "Account Agent Details";
        ObjMemberAgentDetails: Record "Member Agent Details";
        ObjNOKAgentChange: Record "Member Agent/Next Of Kin Chang";
        LinesEditable: Boolean;
        VarAccountSignatoriesVisible: Boolean;
        ObjAccountSignatories: Record "FOSA Account Sign. Details";
        ObjNoSeries: Record "Sacco No. Series";
        VarDocumentNo: Code[30];
        NoSeriesMgt: Codeunit NoSeriesManagement;
        AllowEffect: Boolean;
        AccountEditable: Boolean;
        WorkflowIntegration: codeunit WorkflowIntegration;

    local procedure FnGetListShow()
    begin
        VarAccountAgentVisible := false;
        VarBOSANOKVisible := false;
        VarAccountSignatoriesVisible := false;


        if ("Change Type" = "change type"::"Account Next Of Kin Change") then begin
            VarAccountAgentVisible := false;
            VarBOSANOKVisible := true;
            VarAccountSignatoriesVisible := false;
        end else
            if ("Change Type" = "change type"::"Account Agent Change") then begin
                VarAccountAgentVisible := true;
                VarBOSANOKVisible := false;
                VarAccountSignatoriesVisible := false;
            end else
                if ("Change Type" = "change type"::"Account Signatory Change") then begin
                    VarAccountAgentVisible := false;
                    VarBOSANOKVisible := false;
                    VarAccountSignatoriesVisible := true;
                end;
    end;

    local procedure FnRunAccountNextofKinChange_Effect(DocumentNo: Code[30])
    begin
        ObjNOKAgentChange.Reset;
        ObjNOKAgentChange.SetRange(ObjNOKAgentChange."Document No", DocumentNo);
        ObjNOKAgentChange.SetRange(ObjNOKAgentChange."Account Type", ObjNOKAgentChange."account type"::FOSA);
        ObjNOKAgentChange.SetRange(ObjNOKAgentChange."Change Type", ObjNOKAgentChange."change type"::"Account Next Of Kin Change");
        if ObjNOKAgentChange.FindSet then begin
            ObjAccountNOKDetails.Reset;
            ObjAccountNOKDetails.SetRange(ObjAccountNOKDetails."Account No", "Account No");
            if ObjAccountNOKDetails.FindSet then begin
                ObjAccountNOKDetails.DeleteAll;
            end;

            ObjMemberNextofKinChange.Reset;
            ObjMemberNextofKinChange.SetRange(ObjMemberNextofKinChange."Document No", ObjNOKAgentChange."Document No");
            if ObjMemberNextofKinChange.FindSet then begin
                repeat
                    ObjAccountNOKDetails.Init;
                    ObjAccountNOKDetails.Name := ObjMemberNextofKinChange.Name;
                    ObjAccountNOKDetails.Address := ObjMemberNextofKinChange.Address;
                    ObjAccountNOKDetails."ID No." := ObjMemberNextofKinChange."ID No.";
                    ObjAccountNOKDetails."Account No" := "Account No";
                    ObjAccountNOKDetails."%Allocation" := ObjMemberNextofKinChange."%Allocation";
                    ObjAccountNOKDetails."Next Of Kin Type" := ObjMemberNextofKinChange."Next Of Kin Type";
                    ObjAccountNOKDetails.Insert;
                until ObjMemberNextofKinChange.Next = 0;
            end;
        end;
    end;

    local procedure FnRunMemberNextofKinChange_Effect(DocumentNo: Code[30])
    begin

        ObjNOKAgentChange.Reset;
        ObjNOKAgentChange.SetRange(ObjNOKAgentChange."Document No", DocumentNo);
        ObjNOKAgentChange.SetRange(ObjNOKAgentChange."Account Type", ObjNOKAgentChange."account type"::BOSA);
        ObjNOKAgentChange.SetRange(ObjNOKAgentChange."Change Type", ObjNOKAgentChange."change type"::"Account Next Of Kin Change");
        if ObjNOKAgentChange.FindSet then begin
            ObjMemberNOKDetails.Reset;
            ObjMemberNOKDetails.SetRange(ObjMemberNOKDetails."Account No", "Member No");
            if ObjMemberNOKDetails.FindSet then begin
                ObjMemberNOKDetails.DeleteAll;
            end;

            ObjMemberNextofKinChange.Reset;
            ObjMemberNextofKinChange.SetRange(ObjMemberNextofKinChange."Document No", ObjNOKAgentChange."Document No");
            if ObjMemberNextofKinChange.FindSet then begin
                repeat
                    ObjMemberNOKDetails.Init;
                    ObjMemberNOKDetails."Account No" := "Member No";
                    ObjMemberNOKDetails."Member No" := ObjMemberNextofKinChange."Member No";
                    ObjMemberNOKDetails.Name := ObjMemberNextofKinChange.Name;
                    ObjMemberNOKDetails.Address := ObjMemberNextofKinChange.Address;
                    ObjMemberNOKDetails."ID No." := ObjMemberNextofKinChange."ID No.";
                    ObjMemberNOKDetails.Telephone := ObjMemberNextofKinChange.Telephone;
                    ObjMemberNOKDetails.Email := ObjMemberNextofKinChange.Email;
                    ObjMemberNOKDetails."Date of Birth" := ObjMemberNextofKinChange."Date of Birth";
                    ObjMemberNOKDetails."%Allocation" := ObjMemberNextofKinChange."%Allocation";
                    ObjMemberNOKDetails.Description := ObjMemberNextofKinChange.Description;
                    ObjMemberNOKDetails."Next Of Kin Type" := ObjMemberNextofKinChange."Next Of Kin Type";
                    ObjMemberNOKDetails."Created By" := UserId;
                    ObjMemberNOKDetails."Date Created" := WorkDate;
                    ObjMemberNOKDetails.Insert;
                until ObjMemberNextofKinChange.Next = 0;
            end;
        end;
    end;

    local procedure FnRunMemberAgentDetailsChange_Effect(DocumentNo: Code[30])
    begin
        ObjNOKAgentChange.Reset;
        ObjNOKAgentChange.SetRange(ObjNOKAgentChange."Document No", DocumentNo);
        ObjNOKAgentChange.SetRange(ObjNOKAgentChange."Account Type", ObjNOKAgentChange."account type"::BOSA);
        ObjNOKAgentChange.SetRange(ObjNOKAgentChange."Change Type", ObjNOKAgentChange."change type"::"Account Agent Change");
        if ObjNOKAgentChange.FindSet then begin
            ObjMemberAgentDetails.Reset;
            ObjMemberAgentDetails.SetRange(ObjMemberAgentDetails."Account No", "Member No");
            if ObjMemberAgentDetails.FindSet then begin
                ObjMemberAgentDetails.DeleteAll;
            end;

            ObjMemberAccountAgent.Reset;
            ObjMemberAccountAgent.SetRange(ObjMemberAccountAgent."Document No", ObjNOKAgentChange."Document No");
            if ObjMemberAccountAgent.FindSet then begin
                repeat
                    if ObjNoSeries.Get then begin
                        ObjNoSeries.TestField(ObjNoSeries."Agent Serial Nos");
                        VarDocumentNo := NoSeriesMgt.GetNextNo(ObjNoSeries."Agent Serial Nos", 0D, true);
                        if VarDocumentNo <> '' then begin
                            ObjMemberAgentDetails.Init;
                            ObjMemberAgentDetails."Document No" := VarDocumentNo;
                            ObjMemberAgentDetails.Names := ObjMemberAccountAgent.Names;
                            ObjMemberAgentDetails."ID No." := ObjMemberAccountAgent."ID No.";
                            ObjMemberAgentDetails."Account No" := "Member No";
                            ObjMemberAgentDetails."Mobile No." := ObjMemberAccountAgent."Mobile No.";
                            ObjMemberAgentDetails."Expiry Date" := ObjMemberAccountAgent."Expiry Date";
                            ObjMemberAgentDetails."Allowed  Correspondence" := ObjMemberAccountAgent."Allowed  Correspondence";
                            ObjMemberAgentDetails."Allowed Balance Enquiry" := ObjMemberAccountAgent."Allowed Balance Enquiry";
                            ObjMemberAgentDetails."Allowed FOSA Withdrawals" := ObjMemberAccountAgent."Allowed FOSA Withdrawals";
                            ObjMemberAgentDetails."Allowed Loan Processing" := ObjMemberAccountAgent."Allowed Loan Processing";
                            ObjMemberAccountAgent.Insert;
                        end;
                    end;
                until ObjMemberAccountAgent.Next = 0;
            end;
        end;
    end;

    local procedure FnRunAccountAgentDetailsChange_Effect(DocumentNo: Code[30])
    begin
        ObjNOKAgentChange.Reset;
        ObjNOKAgentChange.SetRange(ObjNOKAgentChange."Document No", DocumentNo);
        ObjNOKAgentChange.SetRange(ObjNOKAgentChange."Account Type", ObjNOKAgentChange."account type"::FOSA);
        ObjNOKAgentChange.SetRange(ObjNOKAgentChange."Change Type", ObjNOKAgentChange."change type"::"Account Agent Change");
        if ObjNOKAgentChange.FindSet then begin
            ObjAccountAgentDetails.Reset;
            ObjAccountAgentDetails.SetRange(ObjAccountAgentDetails."Account No", "Account No");
            if ObjAccountAgentDetails.FindSet then begin
                ObjAccountAgentDetails.DeleteAll;
            end;

            ObjMemberAccountAgent.Reset;
            ObjMemberAccountAgent.SetRange(ObjMemberAccountAgent."Document No", ObjNOKAgentChange."Document No");
            if ObjMemberAccountAgent.FindSet then begin
                repeat
                    if ObjNoSeries.Get then begin
                        ObjNoSeries.TestField(ObjNoSeries."Agent Serial Nos");
                        VarDocumentNo := NoSeriesMgt.GetNextNo(ObjNoSeries."Agent Serial Nos", 0D, true);
                        if VarDocumentNo <> '' then begin
                            ObjAccountAgentDetails.Init;
                            ObjAccountAgentDetails."Document No" := VarDocumentNo;
                            ObjAccountAgentDetails.Names := ObjMemberAccountAgent.Names;
                            ObjAccountAgentDetails."ID No." := ObjMemberAccountAgent."ID No.";
                            ObjAccountAgentDetails."Account No" := "Account No";
                            ObjAccountAgentDetails."Mobile No." := ObjMemberAccountAgent."Mobile No.";
                            ObjAccountAgentDetails."Expiry Date" := ObjMemberAccountAgent."Expiry Date";
                            ObjAccountAgentDetails."Allowed  Correspondence" := ObjMemberAccountAgent."Allowed  Correspondence";
                            ObjAccountAgentDetails."Allowed Balance Enquiry" := ObjMemberAccountAgent."Allowed Balance Enquiry";
                            ObjAccountAgentDetails."Allowed FOSA Withdrawals" := ObjMemberAccountAgent."Allowed FOSA Withdrawals";
                            ObjAccountAgentDetails."Allowed Loan Processing" := ObjMemberAccountAgent."Allowed Loan Processing";
                            ObjAccountAgentDetails.Picture := ObjMemberAccountAgent.Picture;
                            ObjAccountAgentDetails.Signature := ObjMemberAccountAgent.Signature;
                            ObjAccountAgentDetails.Insert
                        end;
                    end;
                until ObjMemberAccountAgent.Next = 0;
            end;
        end;
    end;

    local procedure FnRunAccountSignatoriesChange_Effect(DocumentNo: Code[30])
    var
        ObjMemberSignatory: Record "Member Acc. Signatories Change";
    begin
        ObjNOKAgentChange.Reset;
        ObjNOKAgentChange.SetRange(ObjNOKAgentChange."Document No", DocumentNo);
        ObjNOKAgentChange.SetRange(ObjNOKAgentChange."Account Type", ObjNOKAgentChange."account type"::FOSA);
        ObjNOKAgentChange.SetRange(ObjNOKAgentChange."Change Type", ObjNOKAgentChange."change type"::"Account Signatory Change");
        if ObjNOKAgentChange.FindSet then begin
            ObjAccountSignatories.Reset;
            ObjAccountSignatories.SetRange(ObjAccountSignatories."Account No", "Account No");
            if ObjAccountSignatories.FindSet then begin
                ObjAccountSignatories.DeleteAll;
            end;

            ObjMemberSignatory.Reset;
            ObjMemberSignatory.SetRange(ObjMemberSignatory."Document No", ObjNOKAgentChange."Document No");
            if ObjMemberSignatory.FindSet then begin
                repeat
                    ObjNoSeries.Get;
                    ObjNoSeries.TestField(ObjNoSeries."Signatories Document No");
                    VarDocumentNo := NoSeriesMgt.GetNextNo(ObjNoSeries."Signatories Document No", 0D, true);
                    if VarDocumentNo <> '' then begin
                        ObjAccountSignatories.Init;
                        ObjAccountSignatories."Document No" := VarDocumentNo;
                        ObjAccountSignatories.Names := ObjMemberSignatory.Names;
                        ObjAccountSignatories."ID No." := ObjMemberSignatory."ID No.";
                        ObjAccountSignatories."Account No" := "Account No";
                        ObjAccountSignatories."Mobile No" := ObjMemberSignatory."Mobile Phone No";
                        ObjAccountSignatories."Expiry Date" := ObjMemberSignatory."Expiry Date";
                        ObjAccountSignatories."Must be Present" := ObjMemberSignatory."Must be Present";
                        ObjAccountSignatories."Must Sign" := ObjMemberSignatory."Must Sign";
                        ObjAccountSignatories.Picture := ObjMemberSignatory.Picture;
                        ObjAccountSignatories.Signature := ObjMemberSignatory.Signature;
                        ObjAccountSignatories."Must be Present" := ObjMemberSignatory."Must be Present";
                        ObjAccountSignatories."Member No." := ObjMemberSignatory."Member No.";
                        ObjAccountSignatories."Email Address" := ObjMemberSignatory."Email Address";
                        ObjAccountSignatories."Withdrawal Limit" := ObjMemberSignatory."Withdrawal Limit";
                        ObjAccountSignatories."Mobile Banking Limit" := ObjMemberSignatory."Mobile Banking Limit";
                        ObjAccountSignatories."Signed Up For Mobile Banking" := ObjMemberSignatory."Signed Up For Mobile Banking";
                        ObjAccountSignatories."Operating Instructions" := ObjMemberSignatory."Operating Instructions";
                        ObjAccountSignatories.Insert;
                    end;
                until ObjMemberSignatory.Next = 0;
            end;
        end;
    end;
}

