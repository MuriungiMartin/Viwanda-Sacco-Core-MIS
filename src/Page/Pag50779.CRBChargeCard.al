#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50779 "CRB Charge Card"
{
    PageType = Card;
    SourceTable = "CRB Check Charge";

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
                field("Loan No"; "Loan No")
                {
                    ApplicationArea = Basic;
                }
                field("FOSA Account to Charge"; "FOSA Account to Charge")
                {
                    ApplicationArea = Basic;
                    Editable = FOSAAccountEditable;
                }
                field("Charge Amount"; "Charge Amount")
                {
                    ApplicationArea = Basic;
                    Editable = false;
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
                field("Charge Effected"; "Charge Effected")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Charged By"; "Charged By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Charged On"; "Charged On")
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
            action("Post Charge")
            {
                ApplicationArea = Basic;
                Enabled = EnablePosting;
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    if "Charge Effected" = true then begin
                        Error('This Transaction has been effected');
                    end;

                    BATCH_TEMPLATE := 'PURCHASES';
                    BATCH_NAME := 'FTRANS';
                    DOCUMENT_NO := "Document No";

                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                    GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                    GenJournalLine.DeleteAll;



                    if Confirm('Confirm CRB Check Charge?', false) = true then begin
                        ObjGensetup.Get();

                        VarCRBAmount := ObjGensetup."CRB Check Charge" - (ObjGensetup."CRB Check Vendor Charge" + VarTaxOnCharge);
                        VarSaccoIncome := (ObjGensetup."CRB Check Charge" - ObjGensetup."CRB Check Vendor Charge") / ((ObjGensetup."Excise Duty(%)" / 100) + 1);
                        VarTaxOnCharge := ROUND(VarSaccoIncome * (ObjGensetup."Excise Duty(%)" / 100), 0.01, '>');

                        //------------------------------------1. DEBIT MEMBER FOSA  A/C---------------------------------------------------------------------------------------------
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                        GenJournalLine."account type"::Vendor, "FOSA Account to Charge", WorkDate, "Charge Amount", 'FOSA', '',
                        'Credit Reference Charge', '', GenJournalLine."application source"::" ");
                        //--------------------------------(Debit Member Source Account)-------------------------------------------------------------------------------

                        //------------------------------------2. CREDIT CRB CHARGE VENDOR  A/C---------------------------------------------------------------------------------------------
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                        GenJournalLine."account type"::Vendor, ObjGensetup."CRB Vendor Account", WorkDate, ObjGensetup."CRB Check Vendor Charge" * -1, 'FOSA', '',
                        'Credit Reference Charge - ' + "Loan No" + ' ' + "Member Name", '', GenJournalLine."application source"::" ");
                        //--------------------------------(Credit CRB Charge Vendor Account)-------------------------------------------------------------------------------

                        //------------------------------------3. CREDIT CRB CHARGE SACCO INCOME GL  A/C---------------------------------------------------------------------------------------------
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                        GenJournalLine."account type"::"G/L Account", ObjGensetup."CRB Check SACCO income A/C", WorkDate, VarSaccoIncome * -1, 'FOSA', '',
                        'Credit Reference Income - ' + "Loan No", '', GenJournalLine."application source"::" ");
                        //--------------------------------(Credit CRB Charge Sacco Income GL Account)-------------------------------------------------------------------------------

                        //------------------------------------4. CREDIT TAX GL  A/C---------------------------------------------------------------------------------------------
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                        GenJournalLine."account type"::"G/L Account", ObjGensetup."Excise Duty Account", WorkDate, VarTaxOnCharge * -1, 'FOSA', '',
                        'Tax: Credit Reference Charge - ' + "Loan No", '', GenJournalLine."application source"::" ");
                        //--------------------------------(Credit Tax GL Account)-------------------------------------------------------------------------------
                    end;

                    //CU posting
                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                    GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                    if GenJournalLine.Find('-') then
                        Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJournalLine);

                    "Charge Effected" := true;
                    "Charged By" := UserId;
                    "Charged On" := WorkDate;
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
                Visible = false;

                trigger OnAction()
                var
                    Text001: label 'This request is already pending approval';
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    /*ObjHouseGroups.RESET;
                    ObjHouseGroups.SETRANGE(ObjHouseGroups."Group Leader","Member No");
                    IF ObjHouseGroups.FIND('-')=TRUE THEN
                      BEGIN
                        FnGroupLeaderExitNotification();
                        END;
                    
                    ObjHouseGroups.RESET;
                    ObjHouseGroups.SETRANGE(ObjHouseGroups."Assistant group Leader","Member No");
                    IF ObjHouseGroups.FIND('-')=TRUE THEN
                      BEGIN
                        FnGroupLeaderExitNotification();
                        END;
                    
                    
                    IF ApprovalsMgmt.CheckHouseChangeApprovalsWorkflowEnabled(Rec) THEN
                            ApprovalsMgmt.OnSendHouseChangeForApproval(Rec);
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
                Visible = false;

                trigger OnAction()
                var
                    Approvalmgt: Codeunit "Approvals Mgmt.";
                begin
                    /*IF CONFIRM('Are you sure you want to cancel this approval request',FALSE)=TRUE THEN
                     ApprovalsMgmt.OnCancelHouseChangeApprovalRequest(Rec);
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
                Visible = false;

                trigger OnAction()
                var
                    ApprovalEntries: Page "Approval Entries";
                begin
                    /*DocumentType:=DocumentType::HouseChange;
                    ApprovalEntries.Setfilters(DATABASE::"House Group Change Request",DocumentType,"Document No");
                    ApprovalEntries.RUN;
                    */

                end;
            }
            action("BOSA Statement")
            {
                ApplicationArea = Basic;
                Caption = 'BOSA Statement';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    ObjCust.Reset;
                    ObjCust.SetRange(ObjCust."No.", "Member No");
                    if ObjCust.Find('-') then
                        Report.run(50886, true, false, ObjCust);
                end;
            }
            action("FOSA Statement")
            {
                ApplicationArea = Basic;
                Caption = 'FOSA Statement';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    ObjAccount.Reset;
                    ObjAccount.SetRange(ObjAccount."No.", "FOSA Account to Charge");
                    if ObjAccount.Find('-') then
                        Report.run(50890, true, false, ObjAccount);
                end;
            }
            action("General Ledger Entries")
            {
                ApplicationArea = Basic;
                Image = LedgerEntries;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "General Ledger Entries";
                RunPageLink = "Document No." = field("Document No");
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        /*MemberNoEditable:=FALSE;
        DestinationHouseEditable:=FALSE;
        ReasonforChangeEditable:=FALSE;
        
        IF Status=Status::Open THEN
          BEGIN
          MemberNoEditable:=TRUE;
          DestinationHouseEditable:=TRUE;
          ReasonforChangeEditable:=TRUE
          END ELSE
            IF Status=Status::"Pending Approval" THEN
              BEGIN
              MemberNoEditable:=FALSE;
              DestinationHouseEditable:=FALSE;
              ReasonforChangeEditable:=FALSE
              END ELSE
              IF Status=Status::Approved THEN
                BEGIN
                  MemberNoEditable:=FALSE;
                  DestinationHouseEditable:=FALSE;
                  ReasonforChangeEditable:=FALSE;
                  END;
        
        EnableCreateMember:=FALSE;
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RECORDID);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RECORDID);
        EnabledApprovalWorkflowsExist :=TRUE;
        
        IF ((Rec.Status=Status::Approved) ) THEN
            EnableCreateMember:=TRUE;
        */

    end;

    trigger OnAfterGetRecord()
    begin
        MemberNoEditable := true;
        FOSAAccountEditable := true;
        if "Charge Effected" = true then begin
            MemberNoEditable := false;
            FOSAAccountEditable := false;
        end;


        EnablePosting := true;
        if "Charge Effected" = true then
            EnablePosting := false;
    end;

    trigger OnOpenPage()
    begin
        MemberNoEditable := true;
        FOSAAccountEditable := true;
        if "Charge Effected" = true then begin
            MemberNoEditable := false;
            FOSAAccountEditable := false;
        end;

        EnablePosting := true;
        if "Charge Effected" = true then
            EnablePosting := false;
    end;

    var
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery,ChangeRequest,TreasuryTransactions,FundsTransfer,SaccoTransfers,ChequeDiscounting,ImprestRequisition,ImprestSurrender,LeaveApplication,BulkWithdrawal,PackageLodging,PackageRetrieval,HouseChange;
        EnableCreateMember: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        EnabledApprovalWorkflowsExist: Boolean;
        ObjCust: Record Customer;
        MemberNoEditable: Boolean;
        FOSAAccountEditable: Boolean;
        ReasonforChangeEditable: Boolean;
        ExitMessage: label '<p style="font-family:Verdana,Arial;font-size:10pt">Dear<b> %1,</b></p><p style="font-family:Verdana,Arial;font-size:9pt">Group Leader Group Exit </p><p style="font-family:Verdana,Arial;font-size:9pt">This is to inform you that %2  a group Leader of  %3  has applied to exit the Group,house group change application no %4,</p><p style="font-family:Verdana,Arial;font-size:9pt"> </b></p><br>Regards<p>%5</p><p><b>KINGDOM SACCO LTD</b></p>';
        ObjHouseGroups: Record "Member House Groups";
        SFactory: Codeunit "SURESTEP Factory";
        ObjAccount: Record Vendor;
        GenJournalLine: Record "Gen. Journal Line";
        ObjGensetup: Record "Sacco General Set-Up";
        LineNo: Integer;
        BATCH_TEMPLATE: Code[30];
        BATCH_NAME: Code[30];
        DOCUMENT_NO: Code[30];
        VarCRBAmount: Decimal;
        VarTaxOnCharge: Decimal;
        VarSaccoIncome: Decimal;
        EnablePosting: Boolean;

    local procedure FnGroupLeaderExitNotification()
    var
        SMTPMail: Codeunit "SMTP Mail";
        SMTPSetup: Record "SMTP Mail Setup";
        FileName: Text[100];
        Attachment: Text[250];
        CompanyInfo: Record "Company Information";
        ObjUser: Record User;
        ObjHouseGroups: Record "Member House Groups";
        VarGroupOfficer: Code[50];
    begin
        /*SMTPSetup.GET();
        
        IF ObjHouseGroups.GET("House Group") THEN
          BEGIN
            VarGroupOfficer:=ObjHouseGroups."Credit Officer";
            END;
        
          ObjUser.RESET;
          ObjUser.SETRANGE(ObjUser."User Name",VarGroupOfficer);
            IF ObjUser.FINDSET THEN
              BEGIN
                IF ObjUser."Contact Email"='' THEN
                  BEGIN
                    ERROR ('Email Address Missing for User' +'-'+ VarGroupOfficer);
                  END;
                IF ObjUser."Contact Email"<>'' THEN
                  SMTPMail.CreateMessage(SMTPSetup."Email Sender Name",SMTPSetup."Email Sender Address",ObjUser."Contact Email",'Group Leader Group Exit Notification','',TRUE);
                  SMTPMail.AppendBody(STRSUBSTNO(ExitMessage,VarGroupOfficer,"Member Name","House Group Name","Document No",USERID));
                  SMTPMail.AppendBody(SMTPSetup."Email Sender Name");
                  SMTPMail.AppendBody('<br><br>');
                  SMTPMail.AddAttachment(FileName,Attachment);
                  SMTPMail.Send;
                  MESSAGE('Email Sent');
              END;*/

    end;
}

