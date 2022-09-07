#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50804 "Loan Restructure Card"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = "Loan Rescheduling";

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
                }
                field("Member Name"; "Member Name")
                {
                    ApplicationArea = Basic;
                }
                field("Loan No"; "Loan No")
                {
                    ApplicationArea = Basic;
                }
                field("Issue Date"; "Issue Date")
                {
                    ApplicationArea = Basic;
                }
                field("Approved Amount"; "Approved Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Requested Amount"; "Requested Amount")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Status)
                {
                    ApplicationArea = Basic;
                }
                field(Rescheduled; Rescheduled)
                {
                    ApplicationArea = Basic;
                }
                field("Rescheduled By"; "Rescheduled By")
                {
                    ApplicationArea = Basic;
                }
                field("Rescheduled Date"; "Rescheduled Date")
                {
                    ApplicationArea = Basic;
                }
                field("No. Series"; "No. Series")
                {
                    ApplicationArea = Basic;
                }
                field("Repayment Start Date"; "Repayment Start Date")
                {
                    ApplicationArea = Basic;
                }
                field("Outstanding Loan Amount"; "Outstanding Loan Amount")
                {
                    ApplicationArea = Basic;
                }
                field("New Installments"; "New Installments")
                {
                    ApplicationArea = Basic;
                }
                field("Original Installments"; "Original Installments")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Insurance"; "Loan Insurance")
                {
                    ApplicationArea = Basic;
                }
                field("Active Schedule"; "Active Schedule")
                {
                    ApplicationArea = Basic;
                }
                field("Repayment Amount"; "Repayment Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Principle Repayment"; "Loan Principle Repayment")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Interest Repayment"; "Loan Interest Repayment")
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
            action("Members Statistics")
            {
                ApplicationArea = Basic;
                Caption = 'New Repayment Schedule';
                Image = Statistics;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    LoanRegister.Reset;
                    LoanRegister.SetRange(LoanRegister."Loan  No.", "Loan No");
                    if LoanRegister.Find('-') then begin
                        Report.Run(50477, true, false, LoanRegister);
                    end;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        EnableEffectRetructure := false;
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RecordId);
        EnabledApprovalWorkflowsExist := true;
        if Rec.Status = Rec.Status::Approved then begin
            OpenApprovalEntriesExist := false;
            CanCancelApprovalForRecord := false;
            EnabledApprovalWorkflowsExist := false;
        end;


        if ((Rec.Status = Status::Approved) and (Rec."Rescheduled Date" = 0D)) then
            EnableEffectRetructure := true;
        //FnRecordRestriction;
    end;

    trigger OnOpenPage()
    begin
        EnableEffectRetructure := false;
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RecordId);
        EnabledApprovalWorkflowsExist := true;
        if Rec.Status = Rec.Status::Approved then begin
            OpenApprovalEntriesExist := false;
            CanCancelApprovalForRecord := false;
            EnabledApprovalWorkflowsExist := false;
        end;


        if ((Rec.Status = Status::Approved) and (Rec."Rescheduled Date" = 0D)) then
            EnableEffectRetructure := true;
        //FnRecordRestriction;
    end;

    var
        EnableEffectRetructure: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        EnabledApprovalWorkflowsExist: Boolean;
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery,ChangeRequest,TreasuryTransactions,FundsTransfer,SaccoTransfers,ChequeDiscounting,ImprestRequisition,ImprestSurrender,LeaveApplication,BulkWithdrawal,PackageLodging,PackageRetrieval,HouseChange,CRMTraining,PettyCash,StaffClaims,MemberAgentNOKChange,HouseRegistration,LoanPayOff,FixedDeposit,RTGS,DemandNotice,OverDraft,LoanRestructure;
        MemberNoEditable: Boolean;
        LoantoRestructureEditable: Boolean;
        NewPeriodEditable: Boolean;
        SFactory: Codeunit "SURESTEP Factory";
        BATCH_NAME: Code[50];
        BATCH_TEMPLATE: Code[50];
        DOCUMENT_NO: Code[40];
        ObjAccount: Record Vendor;
        VarLSAAccount: Code[30];
        ObjLoanType: Record "Loan Products Setup";
        ObjLoans: Record "Loans Register";
        ObjLoansII: Record "Loans Register";
        LineNo: Integer;
        GenJournalLine: Record "Gen. Journal Line";
        VarNewLoanNo: Code[30];
        ObjAccounts: Record Vendor;
        AvailableBal: Decimal;
        ObjAccTypes: Record "Account Types-Saving Products";
        VarInterestRateMin: Decimal;
        VarInterestRateMax: Decimal;
        ObjNoSeries: Record "Sacco No. Series";
        VarDocumentNo: Code[30];
        NoSeriesMgt: Codeunit NoSeriesManagement;
        LoanRegister: Record "Loans Register";
}

