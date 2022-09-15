#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50981 "Loan Demand Notices Card"
{
    PageType = Card;
    SourceTable = "Default Notices Register";

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
                    Editable = true;
                }
                field("Loan In Default"; "Loan In Default")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Loan Product"; "Loan Product")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Loan Instalments"; "Loan Instalments")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Loan Disbursement Date"; "Loan Disbursement Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Expected Completion Date"; "Expected Completion Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Amount In Arrears"; "Amount In Arrears")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Days In Arrears"; "Days In Arrears")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Loan Outstanding Balance"; "Loan Outstanding Balance")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Notice Type"; "Notice Type")
                {
                    ApplicationArea = Basic;
                    Editable = true;

                    trigger OnValidate()
                    begin
                        FnenableVisbility();
                    end;
                }
                group("Auctioneer Details")
                {
                    Visible = VarAuctioneerDetailsVisible;
                    field("Auctioneer No"; "Auctioneer No")
                    {
                        ApplicationArea = Basic;
                    }
                    field("Auctioneer  Name"; "Auctioneer  Name")
                    {
                        ApplicationArea = Basic;
                        Editable = false;
                    }
                    field("Auctioneer Address"; "Auctioneer Address")
                    {
                        ApplicationArea = Basic;
                        Editable = false;
                    }
                    field("Auctioneer Mobile No"; "Auctioneer Mobile No")
                    {
                        ApplicationArea = Basic;
                        Editable = false;
                    }
                    field("Auctioneer Email"; "Auctioneer Email")
                    {
                        ApplicationArea = Basic;
                        Editable = false;
                    }
                }
                field("Demand Notice Date"; "Demand Notice Date")
                {
                    ApplicationArea = Basic;
                    Editable = DemandNoticeDateEditable;
                }
                field("User ID"; "User ID")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Email Sent"; "Email Sent")
                {
                    ApplicationArea = Basic;
                }
                field("SMS Sent"; "SMS Sent")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Status)
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
            group("Demand Letters")
            {
                action("Demand Notice Letter")
                {
                    ApplicationArea = Basic;
                    Image = Document;
                    Promoted = true;
                    PromotedCategory = "Report";
                    Visible = VarDemandNoticeVisible;

                    trigger OnAction()
                    begin

                        /*ObjLoans.RESET;
                        ObjLoans.SETRANGE(ObjLoans."Loan  No.","Loan In Default");
                        IF ObjLoans.FINDSET THEN BEGIN
                          Report.run(50925,TRUE,TRUE,ObjLoans);
                          END;*/

                        ObjDemandNotice.Reset;
                        ObjDemandNotice.SetRange(ObjDemandNotice."Document No", "Document No");
                        if ObjDemandNotice.FindSet then begin
                            Report.run(50925, true, true, ObjDemandNotice);
                        end;


                    end;
                }
                action("CRB Demand Letter")
                {
                    ApplicationArea = Basic;
                    Image = Document;
                    Promoted = true;
                    PromotedCategory = "Report";
                    Visible = VarCRBNoticeVisible;

                    trigger OnAction()
                    begin

                        ObjLoans.Reset;
                        ObjLoans.SetRange(ObjLoans."Loan  No.", "Loan In Default");
                        if ObjLoans.FindSet then begin
                            Report.run(50926, true, true, ObjLoans);
                        end;
                    end;
                }
                action("Debt Collector Demand Letter")
                {
                    ApplicationArea = Basic;
                    Caption = 'Debt Collector Demand Letter';
                    Image = Document;
                    Promoted = true;
                    PromotedCategory = "Report";
                    Visible = VarDebtCollectorVisible;

                    trigger OnAction()
                    begin

                        ObjDemands.Reset;
                        ObjDemands.SetRange(ObjDemands."Document No", "Document No");
                        if ObjDemands.FindSet then begin
                            Report.run(50928, true, true, ObjDemands);
                        end;
                    end;
                }
                action("Send Demand Notice Via Mail")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send Demand Notice Letter Via Mail';
                    Enabled = EnableSendNotice;
                    Image = Email;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = VarDemandNoticeVisible;

                    trigger OnAction()
                    var
                        Filename: Text[100];
                        SMTPSetup: Record "SMTP Mail Setup";
                        SMTPMail: Codeunit "SMTP Mail";
                        VarMemberEmail: Text[50];
                        ObjMember: Record Customer;
                        Attachment: Text[250];
                        ObjLoanType: Record "Loan Products Setup";
                        VarProductDescription: Code[50];
                        VarMemberName: Text[250];
                    begin
                        if Confirm('Confirm Action', false) = true then begin

                            SMTPSetup.Get();

                            ObjLoans.Reset;
                            ObjLoans.SetRange(ObjLoans."Loan  No.", "Loan In Default");
                            if ObjLoans.FindSet then begin
                                if ObjMember.Get("Member No") then begin
                                    VarMemberEmail := Lowercase(ObjMember."E-Mail");
                                end;
                                Filename := '';
                                Filename := SMTPSetup."Path to Save Report" + 'DemandNotice.pdf';
                                Report.SaveAsPdf(Report::"Loan Demand Notice", Filename, ObjLoans);
                                if ObjLoanType.Get("Loan Product") then begin
                                    VarProductDescription := ObjLoanType."Product Description";
                                end;

                                //===========================================Get House Leaders Mails And Department Mail to Cc.
                                ObjGensetup.Get();
                                VarDepartmentMail := ObjGensetup."Credit Department E-mail";
                                if ObjHouseGroup.Get("Member House Group") then begin
                                    VarHouseLeaderMail := ObjHouseGroup."Group Leader Email";
                                    VarAssHouseLeaderMail := ObjHouseGroup."Assistant Group Leader Email";
                                end;
                                //===========================================End Get House Leaders Mails And Department Mail to Cc.

                                if ObjLoanType.Get("Loan Product") then begin
                                    VarLoanProductName := ObjLoanType."Product Description";
                                end;

                                VarMemberName := SurestepFactory.FnConvertTexttoBeginingWordstostartWithCapital("Member Name");

                                VarEmailSubject := 'Loan Demand Notice - ' + "Loan In Default";
                                VarEmailBody := 'Kindly find attached a Loan Demand Notice for your ' + VarProductDescription + ' Account No. ' + "Loan In Default" + ' that is in default.';

                                EnableSend := SurestepFactory.FnSendStatementViaMail(VarMemberName, VarEmailSubject, VarEmailBody, VarMemberEmail, 'DemandNotice.pdf', VarDepartmentMail + ';' + VarHouseLeaderMail + ';' + VarAssHouseLeaderMail);

                                if "Notice Type" = "notice type"::"2nd Demand Notice" then begin
                                    FnRunSendCopyGuarantors("Loan In Default", "Member Name");
                                end;
                            end;
                        end;
                    end;
                }
                action("Send CRB Demand Via Mail")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send CRB Notice Letter Via Mail';
                    Enabled = EnableSendNotice;
                    Image = Email;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = VarCRBNoticeVisible;

                    trigger OnAction()
                    var
                        Filename: Text[100];
                        SMTPSetup: Record "SMTP Mail Setup";
                        SMTPMail: Codeunit "SMTP Mail";
                        VarMemberEmail: Text[50];
                        ObjMember: Record Customer;
                        Attachment: Text[250];
                        ObjLoanType: Record "Loan Products Setup";
                        VarProductDescription: Code[50];
                        VarMemberName: Text[250];
                    begin
                        if Confirm('Confirm Action', false) = true then begin
                            SMTPSetup.Get();

                            ObjLoans.Reset;
                            ObjLoans.SetRange(ObjLoans."Loan  No.", "Loan In Default");
                            if ObjLoans.FindSet then begin
                                if ObjMember.Get("Member No") then begin
                                    VarMemberEmail := Lowercase(ObjMember."E-Mail");
                                end;
                                Filename := '';
                                Filename := SMTPSetup."Path to Save Report" + 'CRBNotice.pdf';
                                Report.SaveAsPdf(Report::"Loan CRB Notice", Filename, ObjLoans);

                                if ObjLoanType.Get("Loan Product") then begin
                                    VarProductDescription := ObjLoanType."Product Description";
                                end;

                                //===========================================Get House Leaders Mails And Department Mail to Cc.
                                ObjGensetup.Get();
                                VarDepartmentMail := ObjGensetup."Credit Department E-mail";
                                if ObjHouseGroup.Get("Member House Group") then begin
                                    VarHouseLeaderMail := ObjHouseGroup."Group Leader Email";
                                    VarAssHouseLeaderMail := ObjHouseGroup."Assistant Group Leader Email";
                                end;
                                VarMemberName := SurestepFactory.FnConvertTexttoBeginingWordstostartWithCapital("Member Name");
                                //===========================================End Get House Leaders Mails And Department Mail to Cc.

                                VarEmailSubject := 'Loan CRB Listing Notice - ' + "Loan In Default";
                                VarEmailBody := 'Kindly find attached a CRB Listing Notice for your ' + VarProductDescription + ' Account No. ' + "Loan In Default" + ' that is in default.';

                                EnableSend := SurestepFactory.FnSendStatementViaMail(VarMemberName, VarEmailSubject, VarEmailBody, VarMemberEmail, 'CRBNotice.pdf', VarDepartmentMail);


                            end;
                        end;
                    end;
                }
                action("Send DebtCollector Demand  Mail")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send Debt Collector Demand Letter Via Mail';
                    Enabled = EnableSendNotice;
                    Image = Email;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = VarDebtCollectorVisible;

                    trigger OnAction()
                    var
                        Filename: Text[100];
                        SMTPSetup: Record "SMTP Mail Setup";
                        SMTPMail: Codeunit "SMTP Mail";
                        VarMemberEmail: Text[50];
                        ObjMember: Record Customer;
                        Attachment: Text[250];
                        ObjLoanType: Record "Loan Products Setup";
                        VarProductDescription: Code[50];
                        ObjDemandNotices: Record "Default Notices Register";
                        VarMemberName: Text[250];
                    begin
                        if Confirm('Confirm Action', false) = true then begin
                            SMTPSetup.Get();

                            ObjDemandNotices.Reset;
                            ObjDemandNotices.SetRange(ObjDemandNotices."Document No", "Document No");
                            if ObjDemandNotices.FindSet then begin
                                if ObjMember.Get("Member No") then begin
                                    VarMemberEmail := Lowercase(ObjMember."E-Mail");
                                end;
                                Filename := '';
                                Filename := SMTPSetup."Path to Save Report" + 'DebtCollectorNotice.pdf';
                                Report.SaveAsPdf(Report::"Loan Debt Collector Notice", Filename, ObjDemandNotices);


                                if ObjLoanType.Get("Loan Product") then begin
                                    VarProductDescription := ObjLoanType."Product Description";
                                end;

                                //===========================================Get House Leaders Mails And Department Mail to Cc.
                                ObjGensetup.Get();
                                VarDepartmentMail := ObjGensetup."Credit Department E-mail";
                                if ObjHouseGroup.Get("Member House Group") then begin
                                    VarHouseLeaderMail := ObjHouseGroup."Group Leader Email";
                                    VarAssHouseLeaderMail := ObjHouseGroup."Assistant Group Leader Email";
                                end;

                                VarMemberName := SurestepFactory.FnConvertTexttoBeginingWordstostartWithCapital("Member Name");
                                //===========================================End Get House Leaders Mails And Department Mail to Cc.

                                VarEmailSubject := 'INSTRUCTIONS TO FULLY RECOVER DEFAULTED LOAN ' + "Loan In Default";
                                VarEmailBody := 'Kindly find attached Instructions to Fully Recover a ' + VarProductDescription + ' Account No. ' + "Loan In Default" + ' that is in default.';
                                VarCCEmails := VarMemberEmail + ';' + VarDepartmentMail;

                                EnableSend := SurestepFactory.FnSendStatementViaMail("Auctioneer  Name", VarEmailSubject, VarEmailBody, "Auctioneer Email", 'DebtCollectorNotice.pdf', VarCCEmails);

                            end;
                        end;
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
                        DocumentType := Documenttype::DemandNotice;
                        ApprovalEntries.Setfilters(Database::"Default Notices Register", DocumentType, "Document No");
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
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        if WorkflowIntegration.CheckDemandNoticeApprovalsWorkflowEnabled(Rec) then
                            WorkflowIntegration.OnSendDemandNoticeForApproval(Rec);
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
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        /* IF ApprovalsMgmt.CheckDemandNoticeApprovalsWorkflowEnabled(Rec) THEN
                           ApprovalsMgmt.OnCancelDemandNoticeApprovalRequest(Rec);*/

                        if Confirm('Are you sure you want to cancel this approval request', false) = true then
                            WorkflowIntegration.OnCancelDemandNoticeApprovalRequest(Rec);


                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        /*
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RECORDID);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RECORDID);
        EnabledApprovalWorkflowsExist :=TRUE;
        IF Rec.Status=Status::Approved THEN BEGIN
          OpenApprovalEntriesExist:=FALSE;
          CanCancelApprovalForRecord:=FALSE;
          EnabledApprovalWorkflowsExist:=FALSE;
          END;
          */

    end;

    trigger OnAfterGetRecord()
    begin
        FnenableVisbility;
        FNenableEditing;
        FnRunShowRelevantButton;

        EnableSendNotice := false;
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RecordId);
        EnabledApprovalWorkflowsExist := true;

        if ((Rec.Status = Status::Approved)) then
            EnableSendNotice := true;
    end;

    trigger OnOpenPage()
    begin
        FnenableVisbility;
        FNenableEditing;
        FnRunShowRelevantButton;
    end;

    var
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery,ChangeRequest,TreasuryTransactions,FundsTransfer,SaccoTransfers,ChequeDiscounting,ImprestRequisition,ImprestSurrender,LeaveApplication,BulkWithdrawal,PackageLodging,PackageRetrieval,HouseChange,CRMTraining,PettyCash,StaffClaims,MemberAgentNOKChange,HouseRegistration,LoanPayOff,FixedDeposit,RTGS,DemandNotice;
        OpenApprovalEntriesExist: Boolean;
        EnabledApprovalWorkflowsExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
        SurestepFactory: Codeunit "SURESTEP Factory";
        JTemplate: Code[20];
        JBatch: Code[20];
        GenSetup: Record "Sacco General Set-Up";
        DocNo: Code[20];
        LineNo: Integer;
        TransType: Option " ","Registration Fee","Share Capital","Interest Paid","Loan Repayment","Deposit Contribution","Insurance Contribution","Benevolent Fund",Loan,"Unallocated Funds",Dividend,"FOSA Account","Loan Insurance Charged","Loan Insurance Paid","Recovery Account","FOSA Shares","Additional Shares";
        AccountType: Enum "Gen. Journal Account Type";
        BalAccountType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Employee;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        ObjVendors: Record Vendor;
        ObjAccTypes: Record "Account Types-Saving Products";
        AvailableBal: Decimal;
        ObjLoans: Record "Loans Register";
        ObjDemands: Record "Default Notices Register";
        VarAuctioneerDetailsVisible: Boolean;
        SMTPSetup: Record "SMTP Mail Setup";
        ObjHouseGroup: Record "Member House Groups";
        EnableSendNotice: Boolean;
        MemberNoEditable: Boolean;
        LoanInDefaultEditable: Boolean;
        NoticeTypeEditable: Boolean;
        DemandNoticeDateEditable: Boolean;
        EnableSend: Boolean;
        VarEmailSubject: Text[200];
        VarEmailBody: Text[250];
        ObjLoanType: Record "Loan Products Setup";
        VarLoanProductName: Text[50];
        ObjGensetup: Record "Sacco General Set-Up";
        VarDepartmentMail: Text[50];
        VarHouseLeaderMail: Text[50];
        VarAssHouseLeaderMail: Text[50];
        VarDemandNoticeVisible: Boolean;
        VarCRBNoticeVisible: Boolean;
        VarDebtCollectorVisible: Boolean;
        VarCCEmails: Text;
        ObjDemandNotice: Record "Default Notices Register";
        WorkflowIntegration: codeunit WorkflowIntegration;

    local procedure FnenableVisbility()
    begin
        VarAuctioneerDetailsVisible := false;

        if "Notice Type" = "notice type"::"Debt Collector Notice" then begin
            VarAuctioneerDetailsVisible := true;
        end
    end;

    local procedure FNenableEditing()
    begin
        if Status = Status::Open then begin
            MemberNoEditable := true;
            LoanInDefaultEditable := true;
            NoticeTypeEditable := true;
            DemandNoticeDateEditable := true
        end else
            MemberNoEditable := false;
        LoanInDefaultEditable := false;
        NoticeTypeEditable := false;
        DemandNoticeDateEditable := false;
    end;

    local procedure FnRunSendCopytoHouseGroupLeader(VarDemandNoticeNo: Code[30]; VarHouseGroup: Code[50]; VarMemberName: Text[100])
    var
        Filename: Text[100];
        SMTPSetup: Record "SMTP Mail Setup";
        SMTPMail: Codeunit "SMTP Mail";
        VarMemberEmail: Text[50];
        ObjMember: Record Customer;
        Attachment: Text[250];
        ObjLoanType: Record "Loan Products Setup";
        VarProductDescription: Code[50];
        ObjDemandNotices: Record "Default Notices Register";
        LeaderName: Text[100];
    begin
        //================================================Send to Group Leader
        SMTPSetup.Get();

        ObjLoans.Reset;
        ObjLoans.SetRange(ObjLoans."Loan  No.", VarDemandNoticeNo);
        if ObjLoans.FindSet then begin
            if ObjHouseGroup.Get(VarHouseGroup) then begin
                VarMemberEmail := Lowercase(ObjHouseGroup."Group Leader Email");
                LeaderName := Lowercase(ObjHouseGroup."Group Leader Name");
            end;
            Filename := '';
            Filename := SMTPSetup."Path to Save Report" + 'DemandNotice.pdf';
            Report.SaveAsPdf(Report::"Loan Demand Notice", Filename, ObjLoans);

            if ObjLoanType.Get("Loan Product") then begin
                VarLoanProductName := ObjLoanType."Product Description";
            end;

            VarEmailSubject := 'Loan Demand Notice';
            VarEmailBody := 'Please find attached a demand notice for a ' + VarLoanProductName + 'Loan Account ' + "Loan In Default" + ' defaulted by ' + "Member Name" + ' a member of your House Group';

            EnableSend := SurestepFactory.FnSendStatementViaMail(LeaderName, VarEmailSubject, VarEmailBody, VarMemberEmail, 'DemandNotice.pdf', '');

        end;


        //==============================================Send to Assistant Group Leader
        ObjLoans.Reset;
        ObjLoans.SetRange(ObjLoans."Loan  No.", VarDemandNoticeNo);
        if ObjLoans.FindSet then begin
            if ObjHouseGroup.Get(VarHouseGroup) then begin
                VarMemberEmail := Lowercase(ObjHouseGroup."Assistant Group Leader Email");
                LeaderName := Lowercase(ObjHouseGroup."Assistant Group Name");
            end;
            Filename := '';
            Filename := SMTPSetup."Path to Save Report" + 'DemandNotice.pdf';
            Report.SaveAsPdf(Report::"Loan Demand Notice", Filename, ObjLoans);

            if ObjLoanType.Get("Loan Product") then begin
                VarProductDescription := ObjLoanType."Product Description";
            end;

            VarEmailSubject := 'Loan Demand Notice';
            VarEmailBody := 'Please find attached a demand notice for a ' + VarLoanProductName + 'Loan Account ' + "Loan In Default" + ' defaulted by ' + "Member Name" + ' a member of your House Group';

            EnableSend := SurestepFactory.FnSendStatementViaMail(LeaderName, VarEmailSubject, VarEmailBody, VarMemberEmail, 'DemandNotice.pdf', '');
        end;
    end;

    local procedure FnRunSendCopyGuarantors(VarLoanNo: Code[30]; VarMemberName: Code[100])
    var
        Filename: Text[100];
        SMTPSetup: Record "SMTP Mail Setup";
        SMTPMail: Codeunit "SMTP Mail";
        VarMemberEmail: Text[50];
        ObjMember: Record Customer;
        Attachment: Text[250];
        ObjLoanType: Record "Loan Products Setup";
        VarProductDescription: Code[50];
        ObjDemandNotices: Record "Default Notices Register";
        MemberName: Text[100];
        ObjLoanGuarantors: Record "Loans Guarantee Details";
    begin
        SMTPSetup.Get();

        ObjLoans.Reset;
        ObjLoans.SetRange(ObjLoans."Loan  No.", VarLoanNo);
        if ObjLoans.FindSet then begin
            ObjLoanGuarantors.Reset;
            ObjLoanGuarantors.SetRange(ObjLoanGuarantors."Loan No", VarLoanNo);
            if ObjLoanGuarantors.FindSet then begin
                repeat
                    if ObjMember.Get(ObjLoanGuarantors."Member No") then begin
                        VarMemberEmail := Lowercase(ObjMember."E-Mail");
                        MemberName := Lowercase(ObjMember.Name);
                    end;

                    Filename := '';
                    Filename := SMTPSetup."Path to Save Report" + 'DemandNotice.pdf';
                    Report.SaveAsPdf(Report::"Loan Demand Notice", Filename, ObjLoans);
                    if ObjLoanType.Get("Loan Product") then begin
                        VarProductDescription := ObjLoanType."Product Description";
                    end;

                    if ObjLoanType.Get("Loan Product") then begin
                        VarProductDescription := ObjLoanType."Product Description";
                    end;

                    VarEmailSubject := 'Loan Demand Notice';
                    VarEmailBody := 'Please find attached a demand notice for a ' + VarLoanProductName + 'Loan Account ' + "Loan In Default" + ' defaulted by ' + "Member Name";

                    EnableSend := SurestepFactory.FnSendStatementViaMail(MemberName, VarEmailSubject, VarEmailBody, VarMemberEmail, 'DemandNotice.pdf', '');

                until ObjLoanGuarantors.Next = 0;
            end;
        end;
    end;

    local procedure FnRunSendDemandNoticeCopyDepartment(VarDemandNoticeNo: Code[30]; VarMemberName: Code[100])
    var
        Filename: Text[100];
        SMTPSetup: Record "SMTP Mail Setup";
        SMTPMail: Codeunit "SMTP Mail";
        VarMemberEmail: Text[50];
        ObjMember: Record Customer;
        Attachment: Text[250];
        ObjLoanType: Record "Loan Products Setup";
        VarProductDescription: Code[50];
        ObjDemandNotices: Record "Default Notices Register";
        LeaderName: Text[100];
        ObjLoanGuarantors: Record "Loans Guarantee Details";
        ObjGensetup: Record "Sacco General Set-Up";
    begin
        SMTPSetup.Get();
        ObjGensetup.Get();

        ObjLoans.Reset;
        ObjLoans.SetRange(ObjLoans."Loan  No.", VarDemandNoticeNo);
        if ObjLoans.FindSet then begin

            if ObjMember.Get(ObjLoanGuarantors."Member No") then begin
                VarMemberEmail := Lowercase(ObjGensetup."Credit Department E-mail");
                LeaderName := 'Credit Team';
            end;
            Filename := '';
            Filename := SMTPSetup."Path to Save Report" + 'DemandNotice.pdf';
            Report.SaveAsPdf(Report::"Loan Demand Notice", Filename, ObjLoans);
            if ObjLoanType.Get("Loan Product") then begin
                VarProductDescription := ObjLoanType."Product Description";
            end;


            if ObjLoanType.Get("Loan Product") then begin
                VarProductDescription := ObjLoanType."Product Description";
            end;

            VarEmailSubject := 'Loan Demand Notice';
            VarEmailBody := 'Please find attached a demand notice for a ' + VarLoanProductName + 'Loan Account ' + "Loan In Default" + ' defaulted by ' + "Member Name";

            EnableSend := SurestepFactory.FnSendStatementViaMail(LeaderName, VarEmailSubject, VarEmailBody, VarMemberEmail, 'DemandNotice.pdf', '');

        end;
    end;

    local procedure FnRunSendCRBNoticeCopyDepartment(VarLoanDefaulted: Code[30]; VarMemberName: Code[100])
    var
        Filename: Text[100];
        SMTPSetup: Record "SMTP Mail Setup";
        SMTPMail: Codeunit "SMTP Mail";
        VarMemberEmail: Text[50];
        ObjMember: Record Customer;
        Attachment: Text[250];
        ObjLoanType: Record "Loan Products Setup";
        VarProductDescription: Code[50];
        ObjDemandNotices: Record "Default Notices Register";
        LeaderName: Text[100];
        ObjLoanGuarantors: Record "Loans Guarantee Details";
        ObjGensetup: Record "Sacco General Set-Up";
    begin
        SMTPSetup.Get();
        ObjGensetup.Get();

        ObjLoans.Reset;
        ObjLoans.SetRange(ObjLoans."Loan  No.", VarLoanDefaulted);
        if ObjLoans.FindSet then begin

            if ObjMember.Get(ObjLoanGuarantors."Member No") then begin
                VarMemberEmail := Lowercase(ObjGensetup."Credit Department E-mail");
                LeaderName := 'Credit Team';
            end;
            Filename := '';
            Filename := SMTPSetup."Path to Save Report" + 'CRBNotice.pdf';
            Report.SaveAsPdf(Report::"Loan CRB Notice", Filename, ObjLoans);

            if ObjLoanType.Get("Loan Product") then begin
                VarProductDescription := ObjLoanType."Product Description";
            end;


            VarEmailSubject := 'Loan CRB Notice';
            VarEmailBody := 'Please find attached a CRB notice for a ' + VarLoanProductName + 'Loan Account ' + "Loan In Default" + ' defaulted by ' + "Member Name";

            EnableSend := SurestepFactory.FnSendStatementViaMail(LeaderName, VarEmailSubject, VarEmailBody, VarMemberEmail, 'CRBNotice.pdf', '');

        end;
    end;

    local procedure FnRunSendAuctioneerNoticeCopyDepartment(VarDemandNoticeNo: Code[30]; VarMemberName: Code[100])
    var
        Filename: Text[100];
        SMTPSetup: Record "SMTP Mail Setup";
        SMTPMail: Codeunit "SMTP Mail";
        VarMemberEmail: Text[50];
        ObjMember: Record Customer;
        Attachment: Text[250];
        ObjLoanType: Record "Loan Products Setup";
        VarProductDescription: Code[50];
        ObjDemandNotices: Record "Default Notices Register";
        LeaderName: Text[100];
        ObjLoanGuarantors: Record "Loans Guarantee Details";
        ObjGensetup: Record "Sacco General Set-Up";
    begin
        SMTPSetup.Get();
        ObjGensetup.Get();

        ObjLoans.Reset;
        ObjLoans.SetRange(ObjLoans."Loan  No.", VarDemandNoticeNo);
        if ObjLoans.FindSet then begin
            ObjLoanGuarantors.Reset;
            ObjLoanGuarantors.SetRange(ObjLoanGuarantors."Loan No", VarDemandNoticeNo);
            if ObjLoanGuarantors.FindSet then begin
                repeat
                    if ObjMember.Get(ObjLoanGuarantors."Member No") then begin
                        VarMemberEmail := Lowercase(ObjGensetup."Credit Department E-mail");
                        LeaderName := Lowercase(ObjMember.Name);
                    end;
                    Filename := '';
                    Filename := SMTPSetup."Path to Save Report" + 'AuctioneerNotice.pdf';
                    Report.SaveAsPdf(Report::"Loan Debt Collector Notice", Filename, ObjLoans);
                    if ObjLoanType.Get("Loan Product") then begin
                        VarProductDescription := ObjLoanType."Product Description";
                    end;

                    VarEmailSubject := 'Loan Auctioneer Notice';
                    VarEmailBody := 'Please find attached Auctioneer notice for a ' + VarLoanProductName + 'Loan Account ' + "Loan In Default" + ' defaulted by ' + "Member Name";

                    EnableSend := SurestepFactory.FnSendStatementViaMail(LeaderName, VarEmailSubject, VarEmailBody, VarMemberEmail, 'AuctioneerNotice.pdf', '');
                until ObjLoanGuarantors.Next = 0;
            end;
        end;
    end;

    local procedure FnRunShowRelevantButton()
    begin
        VarDemandNoticeVisible := false;
        VarCRBNoticeVisible := false;
        VarDebtCollectorVisible := false;

        if ("Notice Type" = "notice type"::"1st Demand Notice") or ("Notice Type" = "notice type"::"2nd Demand Notice") then begin
            VarDemandNoticeVisible := true;
        end;

        if "Notice Type" = "notice type"::"CRB Notice" then begin
            VarCRBNoticeVisible := true;
        end;

        if "Notice Type" = "notice type"::"Debt Collector Notice" then begin
            VarDebtCollectorVisible := true;
        end;
    end;
}

