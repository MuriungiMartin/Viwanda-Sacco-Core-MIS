#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50795 "Posted OverDraft Applic Card"
{
    PageType = Card;
    SourceTable = "OverDraft Application";

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
                    Editable = false;
                }
                field("Over Draft Account"; "Over Draft Account")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Over Draft Account Name"; "Over Draft Account Name")
                {
                    ApplicationArea = Basic;
                }
                field("Application Date"; "Application Date")
                {
                    ApplicationArea = Basic;
                }
                field("Security Type"; "Security Type")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Member Deposits"; "Member Deposits")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                    Style = Strong;
                    StyleExpr = true;
                }
                field("Member Guarantee Liability"; "Member Guarantee Liability")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                    Style = Strong;
                    StyleExpr = true;
                }
                field("Total Members Unsecured Loans"; "Total Members Unsecured Loans")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                    Style = Strong;
                    StyleExpr = true;
                }
                field("OD Qualifying Amount:Deposits"; "OD Qualifying Amount:Deposits")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                    Style = Favorable;
                    StyleExpr = true;
                }
                field("OD Qualifying Amount:Collatera"; "OD Qualifying Amount:Collatera")
                {
                    ApplicationArea = Basic;
                    Caption = 'OD Qualifying Amount:Collateral';
                }
                field("Qualifying Overdraft Amount"; "Qualifying Overdraft Amount")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Overdraft Duration"; "Overdraft Duration")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("OverDraft Expiry Date"; "OverDraft Expiry Date")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Status)
                {
                    ApplicationArea = Basic;
                }
                field("OverDraft Application Type"; "OverDraft Application Type")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("OverDraft Application Status"; "OverDraft Application Status")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Date Terminated"; "Date Terminated")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Terminated By"; "Terminated By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Reason For Termination"; "Reason For Termination")
                {
                    ApplicationArea = Basic;
                    MultiLine = true;
                }
            }
            part("Collateral Security"; "OverDraft Collateral Register")
            {
                Caption = 'Collateral Security';
                Editable = false;
                SubPageLink = "OD No" = field("Document No");
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(EnableCreateHouse)
            {
                ApplicationArea = Basic;
                Caption = 'Create Group';
                Enabled = EnableCreateHouse;
                Image = Customer;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;
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
                    /*
                    IF ApprovalsMgmt.CheckHouseRegistrationApprovalsWorkflowEnabled(Rec) THEN
                            ApprovalsMgmt.OnSendHouseRegistrationForApproval(Rec);
                    */

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
                    /*IF CONFIRM('Are you sure you want to cancel this approval request',FALSE)=TRUE THEN
                     ApprovalsMgmt.OnCancelHouseRegistrationApprovalRequest(Rec);
                      Status:=Status::Open;
                      MODIFY;
                    */

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
                    /*DocumentType:=DocumentType::HouseRegistration;
                    ApprovalEntries.Setfilters(DATABASE::"House Groups Registration",DocumentType,"Cell Group Code");
                    ApprovalEntries.RUN;*/

                end;
            }
            action(EndOverDraft)
            {
                ApplicationArea = Basic;
                Caption = 'Terminate OverDraft';
                Image = Stop;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    if "OverDraft Application Status" = "overdraft application status"::Terminated then
                        Error('Application Terminated');

                    if "Reason For Termination" = '' then
                        Error('Specify termination Reasons');

                    if Confirm('Confirm Overdraft Termination?', false) = true then begin
                        "Terminated By" := UserId;
                        "OverDraft Application Status" := "overdraft application status"::Terminated;
                        "Date Terminated" := WorkDate;

                        if ObjAccount.Get("Over Draft Account") then begin
                            ObjAccount."Over Draft Limit Expiry Date" := 0D;
                            ObjAccount."Over Draft Limit Amount" := 0;
                        end;
                    end;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        EnableCreateHouse := false;
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RecordId);
        EnabledApprovalWorkflowsExist := true;

        if ((Rec.Status = Status::Approved)) then
            EnableCreateHouse := true;
    end;

    trigger OnOpenPage()
    begin
        EnableCreateHouse := false;
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RecordId);
        EnabledApprovalWorkflowsExist := true;

        if ((Rec.Status = Status::Approved)) then
            EnableCreateHouse := true;
    end;

    var
        ObjCellGroups: Record "Member House Groups";
        ObjCust: Record Customer;
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery,ChangeRequest,TreasuryTransactions,FundsTransfer,SaccoTransfers,ChequeDiscounting,ImprestRequisition,ImprestSurrender,LeaveApplication,BulkWithdrawal,PackageLodging,PackageRetrieval,HouseChange,CRMTraining,PettyCash,StaffClaims,MemberAgentNOKChange,HouseRegistration,LoanPayOff;
        EnableCreateHouse: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        EnabledApprovalWorkflowsExist: Boolean;
        MemberNoEditable: Boolean;
        AccountNoEditable: Boolean;
        ChangeTypeEditable: Boolean;
        AccountTypeEditable: Boolean;
        VarBOSANOKVisible: Boolean;
        VarFOSANOKVisible: Boolean;
        VarAccountAgentVisible: Boolean;
        ObjSaccoNos: Record "Sacco No. Series";
        VarHouseNo: Code[30];
        ObjHouseG: Record "Member House Groups";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        ObjAccount: Record Vendor;
}

