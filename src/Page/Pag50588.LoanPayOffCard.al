#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50588 "Loan PayOff Card"
{
    PageType = Card;
    SourceTable = "Loan PayOff";

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
                field("FOSA Account No"; "FOSA Account No")
                {
                    ApplicationArea = Basic;
                    Editable = FOSANoEditable;
                }
                field("FOSA Account Available Balance"; "FOSA Account Available Balance")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Promoted;
                    Style = Favorable;
                    StyleExpr = true;
                }
                field("Application Date"; "Application Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Requested PayOff Amount"; "Requested PayOff Amount")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Approved PayOff Amount"; "Approved PayOff Amount")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Created By"; "Created By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Global Dimension 2 Code"; "Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Total PayOut Amount"; "Total PayOut Amount")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Posted; Posted)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Posting Date"; "Posting Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Posted By"; "Posted By")
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
            part(Control1000000009; "Loan PayOff Details")
            {
                SubPageLink = "Document No" = field("Document No"),
                              "Member No" = field("Member No");
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
                Caption = 'Member Statistics';
                Image = Statistics;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                RunObject = Page "Members Statistics";
                RunPageLink = "No." = field("Member No");
            }
            action("Post PayOff")
            {
                ApplicationArea = Basic;
                Caption = 'Post PayOff';
                Enabled = EnablePosting;
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    CalcFields("Total PayOut Amount");
                    if "Total PayOut Amount" <> "Approved PayOff Amount" then begin
                        Error('Cummulative PayOffs on the lines must be equal to Total PayOffs')
                    end else
                        BATCH_TEMPLATE := 'PURCHASES';
                    BATCH_NAME := 'FTRANS';
                    DOCUMENT_NO := "Document No";

                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                    GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                    GenJournalLine.DeleteAll;



                    if Confirm('Confirm Payoff Posting?', false) = true then begin
                        ObjPayOffDetails.Reset;
                        ObjPayOffDetails.SetRange(ObjPayOffDetails."Document No", "Document No");
                        if ObjPayOffDetails.FindSet then begin
                            repeat
                                if ObjLoans.Get(ObjPayOffDetails."Loan to PayOff") then begin
                                    if ObjLoanType.Get(ObjLoans."Loan Product Type") then begin
                                        VarLoanInsuranceBalAccount := ObjLoanType."Loan Insurance Accounts";
                                    end;
                                end;

                                SFactory.FnCreateLoanPayOffJournals(ObjPayOffDetails."Loan to PayOff", BATCH_TEMPLATE, BATCH_NAME, "Document No", "Member No", WorkDate,
                                ObjPayOffDetails."Loan to PayOff", "FOSA Account No", "Member Name", "FOSA Account Available Balance");

                            until ObjPayOffDetails.Next = 0;
                        end;
                    end;


                    //CU posting
                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                    GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                    if GenJournalLine.Find('-') then
                        Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJournalLine);

                    SFactory.FnRunFreezeMemberLoanDueAmountAfterPayoff("Member No");

                    Posted := true;
                    "Posting Date" := Today;
                    "Posted By" := UserId;
                    Modify;

                    Message('PayOff Posted Succesfuly');
                    PayOffDetails.Reset;
                    PayOffDetails.SetRange(PayOffDetails."Document No", "Document No");
                    if PayOffDetails.Find('-') then begin
                        repeat
                            PayOffDetails.Posted := true;
                            PayOffDetails."Posting Date" := Today;
                            PayOffDetails.Modify;
                        until PayOffDetails.Next = 0;
                    end;

                    CurrPage.Close;

                    if ObjLoans.Get(ObjPayOffDetails."Loan to PayOff") then begin
                        ObjLoans.CalcFields(ObjLoans."Outstanding Balance");
                        if (ObjLoans."Outstanding Balance" > -1) and (ObjLoans."Outstanding Balance" < 1) then begin
                            ObjLoans.Closed := true;
                            ObjLoans."Loan Status" := ObjLoans."loan status"::Closed;
                            ObjLoans."Closed By" := UserId;
                            ObjLoans."Closed On" := WorkDate;
                            ObjLoans.Modify;
                        end;
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
                    ObjVendors.Reset;
                    ObjVendors.SetRange(ObjVendors."No.", "FOSA Account No");
                    if ObjVendors.Find('-') then begin
                        ObjVendors.CalcFields(ObjVendors.Balance, ObjVendors."Uncleared Cheques");
                        AvailableBal := (ObjVendors.Balance - ObjVendors."Uncleared Cheques");

                        ObjAccTypes.Reset;
                        ObjAccTypes.SetRange(ObjAccTypes.Code, ObjVendors."Account Type");
                        if ObjAccTypes.Find('-') then
                            AvailableBal := AvailableBal - ObjAccTypes."Minimum Balance";
                    end;

                    CalcFields("Total PayOut Amount");

                    if "Total PayOut Amount" > AvailableBal then
                        Error('This Account has less than the PayOff Amount,Available Bal is %1', AvailableBal);


                    //===================================================================Ensure Payoff Loan is Inserted
                    ObjPayOffDetails.Reset;
                    ObjPayOffDetails.SetRange(ObjPayOffDetails."Document No", "Document No");
                    if ObjPayOffDetails.FindSet = false then begin
                        Error('Specify loan to offset on the Loan Offset Details');
                    end;


                    if WKFLWIntegr.CheckLoanPayOffApprovalsWorkflowEnabled(Rec) then
                        WKFLWIntegr.OnSendLoanPayOffForApproval(Rec);
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
                        WKFLWIntegr.OnCancelLoanPayOffApprovalRequest(Rec);
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
                    DocumentType := Documenttype::LoanPayOff;
                    ApprovalEntries.Setfilters(Database::"Loan PayOff", DocumentType, "Document No");
                    ApprovalEntries.Run;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        CalcFields("Total PayOut Amount");
        "Requested PayOff Amount" := "Total PayOut Amount";
        "Approved PayOff Amount" := "Total PayOut Amount";

        EnablePosting := false;
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RecordId);
        EnabledApprovalWorkflowsExist := true;
        if Rec.Status = Rec.Status::Approved then begin
            OpenApprovalEntriesExist := false;
            CanCancelApprovalForRecord := false;
            EnabledApprovalWorkflowsExist := false;
        end;


        if ((Rec.Status = Status::Approved) and (Rec.Posted = false)) then
            EnablePosting := true;
        UpdateControls;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        "Created By" := UserId;
        "Application Date" := Today;
    end;

    trigger OnOpenPage()
    begin
        EnablePosting := false;
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RecordId);
        EnabledApprovalWorkflowsExist := true;
        if Rec.Status = Rec.Status::Approved then begin
            OpenApprovalEntriesExist := false;
            CanCancelApprovalForRecord := false;
            EnabledApprovalWorkflowsExist := false;
        end;


        if ((Rec.Status = Status::Approved) and (Rec.Posted = false)) then
            EnablePosting := true;
        UpdateControls;
    end;

    var
        PayOffDetails: Record "Loans PayOff Details";
        GenJournalLine: Record "Gen. Journal Line";
        LineNo: Integer;
        LoanType: Record "Loan Products Setup";
        LoansRec: Record "Loans Register";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery,ChangeRequest,TreasuryTransactions,FundsTransfer,SaccoTransfers,ChequeDiscounting,ImprestRequisition,ImprestSurrender,LeaveApplication,BulkWithdrawal,PackageLodging,PackageRetrieval,HouseChange,CRMTraining,PettyCash,StaffClaims,MemberAgentNOKChange,HouseRegistration,LoanPayOff;
        EnablePosting: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        EnabledApprovalWorkflowsExist: Boolean;
        ObjPayOffDetails: Record "Loans PayOff Details";
        BATCH_TEMPLATE: Code[30];
        BATCH_NAME: Code[30];
        DOCUMENT_NO: Code[30];
        SFactory: Codeunit "SURESTEP Factory";
        ObjVendors: Record Vendor;
        ObjAccTypes: Record "Account Types-Saving Products";
        AvailableBal: Decimal;
        ObjLoans: Record "Loans Register";
        ObjLoanType: Record "Loan Products Setup";
        VarLoanInsuranceBalAccount: Code[20];
        MemberNoEditable: Boolean;
        FOSANoEditable: Boolean;
        WKFLWIntegr: Codeunit WorkflowIntegration;


    procedure UpdateControls()
    begin

        if Status = Status::Open then begin
            MemberNoEditable := true;
            FOSANoEditable := true;
        end;
        if Status = Status::"Pending Approval" then begin
            MemberNoEditable := false;
            FOSANoEditable := false;
        end;
        if Status = Status::Approved then begin
            MemberNoEditable := false;
            FOSANoEditable := false;
        end
    end;
}

