#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50159 "Posted Loan Recovery Header"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = "Loan Recovery Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = false;
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
                    Importance = Promoted;
                }
                field("Current Shares"; "Current Shares")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member Deposits';
                    Editable = false;
                    Importance = Promoted;
                    Style = Favorable;
                    StyleExpr = true;
                }
                field("Total Outstanding Loans"; "Total Outstanding Loans")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Style = Unfavorable;
                    StyleExpr = true;
                }
                field("Loan Disbursement Date"; "Loan Disbursement Date")
                {
                    ApplicationArea = Basic;
                    Caption = 'Transaction Date';
                    Editable = true;
                }
                field("Recovery Type"; "Recovery Type")
                {
                    ApplicationArea = Basic;
                    Editable = RecoveryTypeEditable;

                    trigger OnValidate()
                    begin
                        ShareCapitalSellVisible := false;
                        // if "Recovery Type"="recovery type"::"5" then
                        //   begin
                        //     ShareCapitalSellVisible:=true;
                        //     end;

                        ApportionmentVisible := false;
                        if "Recovery Type" = "recovery type"::"Recover From Guarantors Deposits" then begin
                            ApportionmentVisible := true;
                        end;

                        LoanDueVisible := false;
                        if "Recovery Type" = "recovery type"::"Recover From Loanee Deposits" then
                            LoanDueVisible := true;
                    end;
                }
                field("Loan to Attach"; "Loan to Attach")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loan to Recover';
                    Editable = LoantoAttachEditable;
                }
                // field("Loan Settlement Account";"Loan Settlement Account")
                // {
                //     ApplicationArea = Basic;
                //     Editable = LoantoAttachEditable;
                // }
                // field("Loan Settlement Account Bal";"Loan Settlement Account Bal")
                // {
                //     ApplicationArea = Basic;
                //     Editable = false;
                // }
                // field("Total Guarantor Allocation";"Total Guarantor Allocation")
                // {
                //     ApplicationArea = Basic;
                //     Editable = false;
                // }
                group(Apportionment)
                {
                    Editable = false;
                    Visible = ApportionmentVisible;
                    field("Guarantor Allocation Type"; "Guarantor Allocation Type")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Liability Allocation Type';
                        Importance = Promoted;
                        Style = Strong;
                        StyleExpr = true;
                    }
                }
                group(LoanDueAmount)
                {
                    Editable = false;
                    Visible = LoanDueVisible;
                    //     field("Loan Due Amount";"Loan Due Amount")
                    //     {
                    //         ApplicationArea = Basic;
                    //     }
                    //     field("Deposits Recovered Amount";"Deposits Recovered Amount")
                    //     {
                    //         ApplicationArea = Basic;
                    //         Editable = LoantoAttachEditable;
                    //     }
                    //     field("Refund  BOSA Deposit";"Refund  BOSA Deposit")
                    //     {
                    //         ApplicationArea = Basic;
                    //         Editable = LoantoAttachEditable;
                    //     }
                    // }
                    // field("Loan Current PayOff Amount";"Loan Current PayOff Amount")
                    // {
                    //     ApplicationArea = Basic;
                    //     Editable = false;
                    //     Importance = Promoted;
                    //     Style = Attention;
                    //     StyleExpr = true;
                    // }
                    field("Loan Distributed to Guarantors"; "Loan Distributed to Guarantors")
                    {
                        ApplicationArea = Basic;
                        Editable = true;
                        Style = StrongAccent;
                        StyleExpr = true;
                    }
                    field("FOSA Account No"; "FOSA Account No")
                    {
                        ApplicationArea = Basic;
                        Editable = false;
                    }
                    field("Recovery Difference"; "Recovery Difference")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Recovery Difference';
                        Editable = false;
                        Enabled = false;
                        Visible = false;
                    }
                    field("Activity Code"; "Global Dimension 1 Code")
                    {
                        ApplicationArea = Basic;
                        Editable = Global1Editable;
                        //     OptionCaption = 'Activity';
                    }
                    field("Global Dimension 2 Code"; "Global Dimension 2 Code")
                    {
                        ApplicationArea = Basic;
                        Editable = false;
                    }
                    field("Created By"; "Created By")
                    {
                        ApplicationArea = Basic;
                        Editable = false;
                        Importance = Additional;
                    }
                    field("Application Date"; "Application Date")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Date Created';
                        Editable = false;
                    }
                    field(Posted; Posted)
                    {
                        ApplicationArea = Basic;
                        Editable = false;
                        Importance = Additional;
                    }
                    field("Loans Generated"; "Loans Generated")
                    {
                        ApplicationArea = Basic;
                        Editable = false;
                        Importance = Additional;
                    }
                    field("Posting Date"; "Posting Date")
                    {
                        ApplicationArea = Basic;
                        Editable = false;
                    }
                    field("Repayment Start Date"; "Repayment Start Date")
                    {
                        ApplicationArea = Basic;
                        Editable = false;
                        Importance = Additional;
                    }
                    field("Posted By"; "Posted By")
                    {
                        ApplicationArea = Basic;
                        Editable = false;
                        Importance = Additional;
                    }
                    // field("Share Capital Sold";"Share Capital Sold")
                    // {
                    //     ApplicationArea = Basic;
                    //     Editable = false;
                    //     Importance = Additional;
                    // }
                    field(Status; Status)
                    {
                        ApplicationArea = Basic;
                        Editable = false;
                        Importance = Additional;
                    }
                }
                part(Control1000000009; "Loan Recovery Details")
                {
                    Editable = false;
                    Enabled = true;
                    SubPageLink = "Document No" = field("Document No"),
                              "Member No" = field("Member No");
                    Visible = true;
                }
                group("Share Capital Sel")
                {
                    Caption = 'Share Capital Sell';
                    Editable = false;
                    Visible = ShareCapitalSellVisible;
                    // field("Share Capital Balance";"Share Capital Balance")
                    // {
                    //     ApplicationArea = Basic;
                    //     Editable = false;
                    // }
                    field("Settlement Account"; "Settlement Account")
                    {
                        ApplicationArea = Basic;
                        Editable = false;
                        Visible = false;
                    }
                    // field("Share Capital Seller FOSA Acc";"Share Capital Seller FOSA Acc")
                    // {
                    //     ApplicationArea = Basic;
                    //     Caption = 'Seller FOSA Account';
                    // }
                }
                part("Share Capital Sell"; "Share Capital Sell")
                {
                    Editable = false;
                    SubPageLink = "Document No" = field("Document No"),
                              "Selling Member No" = field("Member No"),
                              "Selling Member Name" = field("Member Name");
                    Visible = ShareCapitalSellVisible;
                }
            }
        }
    }
    actions
    {
        area(creation)
        {
            group("Function")
            {
                Caption = 'Function';
                action("Post Transaction")
                {
                    ApplicationArea = Basic;
                    Enabled = EnableCreateMember;
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    Visible = PostVisible;

                    trigger OnAction()
                    var
                        LineNo: Integer;
                        TotalLoanRecovered: Decimal;
                    begin
                        ObjGLEntry.Reset;
                        ObjGLEntry.SetRange(ObjGLEntry."Document No.", "Document No");
                        if ObjGLEntry.FindSet then begin
                            Message('This Transaction has already been posted');
                            Posted := true;
                            "Posted By" := UserId;
                            "Posting Date" := WorkDate;
                        end;

                        if ((Status = Status::Open) or (Status = Status::Pending)) then
                            Error('You cannot post a document which is not approved');

                        BATCH_TEMPLATE := 'GENERAL';
                        BATCH_NAME := 'RECOVERIES';
                        DOCUMENT_NO := "Document No";
                        EXTERNAL_DOC_NO := "Loan to Attach";
                        Datefilter := '..' + Format("Loan Disbursement Date");

                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                        GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                        GenJournalLine.DeleteAll;

                        if "Recovery Type" = "recovery type"::"Attach Defaulted Loans to Guarantors" then begin
                            LineNo := 0;
                            FnRunInterest("Total Interest Due Recovered");
                            FnRunPrincipleThirdparty("Total Thirdparty Loans");
                            FnRecoverMobileLoanPrincipal("Mobile Loan");
                            FnRunPrinciple("Deposits Aportioned");
                            FnGenerateDefaulterLoans();
                        end;

                        // if "Recovery Type"="recovery type"::"Recover From Loanee Deposits" then begin
                        //   LineNo:=0;
                        //   FnRunPostMemberDepositstoLSA("Document No","Loan Disbursement Date","Loan to Attach");
                        //   Validate("Loan Settlement Account");
                        //   SFactory.FnCreateLoanRecoveryJournals("Loan to Attach",BATCH_TEMPLATE,BATCH_NAME,DOCUMENT_NO,"Member No",
                        //   "Loan Disbursement Date","Document No","Loan Settlement Account","Member Name","Loan Settlement Account Bal");
                        //   FnRunCreateBOSAAccountRefundLedgerEntry("Member No","Member Name","Loan Disbursement Date");//===========================Create BOSA Deposit Refund Entries
                        //   end;


                        // if "Recovery Type"="recovery type"::"Recover From Guarantors Deposits" then begin
                        //   FnRunPostAmountAllocatedtoLSA("Document No","Loan Disbursement Date","Loan to Attach");//========================Post Guarantor Recovery to LSA
                        //   FnRunCreateRecoveryLedgerEntry("Member No","Member Name","Loan Disbursement Date");//============================Create Recovery Ledger Entries
                        //   Validate("Loan Settlement Account");
                        //   SFactory.FnCreateLoanRecoveryJournalsAdvance("Loan to Attach",BATCH_TEMPLATE,BATCH_NAME,DOCUMENT_NO,"Member No",
                        //   "Loan Disbursement Date","Document No","Loan Settlement Account","Member Name","Loan Settlement Account Bal");//===Post Recovery From LSA
                        //   end;

                        // if "Recovery Type"="recovery type"::"5" then
                        //   begin
                        //     FnRunShareCapitalSell;
                        //     Validate("Loan Settlement Account");
                        //     SFactory.FnCreateLoanRecoveryJournals("Loan to Attach",BATCH_TEMPLATE,BATCH_NAME,DOCUMENT_NO,"Member No",
                        //     "Loan Disbursement Date","Document No","Loan Settlement Account","Member Name","Loan Settlement Account Bal");
                        //     end;

                        //Post New
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                        GenJournalLine.SetRange("Journal Batch Name", 'RECOVERIES');
                        if GenJournalLine.Find('-') then begin
                            Codeunit.Run(Codeunit::"Gen. Jnl.-Post Batch", GenJournalLine);
                        end;

                        ObjGuarantorRec.Reset;
                        ObjGuarantorRec.SetRange("Loan No", "Loan No");
                        if ObjGuarantorRec.Find('-') then begin
                            "Loans Generated" := Posted;
                            Posted := true;
                            "Loans Generated" := Posted;
                            "Posting Date" := Today;
                            Modify;
                        end;

                        CurrPage.Close;
                    end;
                }
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
                separator(Action19)
                {
                }
                action("Send Approval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send A&pproval Request';
                    Enabled = (not OpenApprovalEntriesExist) and EnabledApprovalWorkflowsExist;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        text001: label 'This batch is already pending approval';
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        // if ("Recovery Type"= "recovery type"::"Recover From Loanee Deposits") and ("Deposits Recovered Amount" = 0) then
                        //   Error('You have to specify Amount to Recover From Deposits');

                        if (Status = Status::Approved) or (Status = Status::Pending) then
                            Error(text001);
                        TestField("Global Dimension 1 Code");
                        TestField("Global Dimension 2 Code");
                        // if ApprovalsMgmt.CheckGuarantorRecoveryApprovalsWorkflowEnabled(Rec) then
                        //   ApprovalsMgmt.OnSendGuarantorRecoveryForApproval(Rec);

                    end;
                }
                action("Cancel Approval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel A&pproval Request';
                    Enabled = CanCancelApprovalForRecord;
                    Image = CancelApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        text001: label 'This batch is already pending approval';
                        ApprovalMgt: Codeunit "Approvals Mgmt.";
                    begin
                        if (Status = Status::Open) or (Status = Status::Approved) then
                            Error(text001);

                        //  if ApprovalsMgmt.CheckGuarantorRecoveryApprovalsWorkflowEnabled(Rec) then
                        //    ApprovalsMgmt.OnCancelGuarantorRecoveryApprovalRequest(Rec);

                    end;
                }
                action(Approvals)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                    begin
                        DocumentType := Documenttype::GuarantorRecovery;

                        ApprovalEntries.Setfilters(Database::"Loan Recovery Header", DocumentType, "Document No");
                        ApprovalEntries.Run;
                    end;
                }
                separator(Action20)
                {
                }
                action("Load Guarantors")
                {
                    ApplicationArea = Basic;
                    Image = CalculateLines;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        LoanDetails: Record "Loan Member Loans";
                        GCount: Integer;
                    begin

                        if ((Status = Status::Pending) or (Posted = true)) then
                            Error('You cannot L a document which is not approved');

                        if ("Recovery Type" = "recovery type"::"Attach Defaulted Loans to Guarantors") or ("Recovery Type" = "recovery type"::"Recover From Guarantors Deposits") then begin
                            LoanDetails.Reset;
                            LoanDetails.SetRange(LoanDetails."Loan No.", "Loan to Attach");
                            if LoanDetails.Find('-') then
                                LoanDetails.DeleteAll;

                            LoanGuarantors.Reset;
                            LoanGuarantors.SetRange(LoanGuarantors."Loan No", "Loan to Attach");
                            if LoanGuarantors.FindSet then begin
                                repeat

                                    if ObjCust.Get(LoanGuarantors."Member No") then begin
                                        ObjCust.CalcFields(ObjCust."Current Shares");
                                        if ObjCust."Current Shares" > 0 then begin
                                            LoanDetails.Init;
                                            LoanDetails."Document No" := "Document No";
                                            LoanDetails."Member No" := "Member No";
                                            LoanDetails."Member Name" := LoanGuarantors.Name;
                                            LoanDetails."Guarantor Number" := LoanGuarantors."Member No";
                                            LoanDetails."Loan No." := LoanGuarantors."Loan No";
                                            LoanDetails."Amont Guaranteed" := LoanGuarantors."Amont Guaranteed";
                                            LoanDetails."Guarantors Current Shares" := ObjCust."Current Shares";
                                            LoanDetails."Current Member Deposits" := ObjCust."Current Shares";
                                            LoanDetails."Guarantors Free Shares" := (LoanGuarantors."Deposits variance" - LoanGuarantors."Total Committed Shares");
                                            LoanDetails.Insert;

                                        end;
                                    end;
                                until LoanGuarantors.Next = 0;
                            end;
                        end;
                        if ("Recovery Type" = "recovery type"::"Attach Defaulted Loans to Guarantors") then begin

                            LoanDetails.Reset;
                            LoanDetails.SetRange(LoanDetails."Loan No.", "Loan to Attach");
                            //LoanDetails.SETRANGE(LoanDetails."Member No","Member No");
                            if LoanDetails.Find('-') then
                                LoanDetails.DeleteAll;

                            LoanGuarantors.Reset;
                            LoanGuarantors.SetRange(LoanGuarantors."Loan No", "Loan to Attach");
                            if LoanGuarantors.FindSet then begin
                                GCount := LoanGuarantors.Count;
                                repeat
                                    //LoanGuarantors.Totals
                                    LoanDetails.Init;
                                    LoanGuarantors.CalcFields(LoanGuarantors."Outstanding Balance", LoanGuarantors."Oustanding Interest", LoanGuarantors."Total Loans Guaranteed");
                                    LoanDetails."Document No" := "Document No";
                                    LoanDetails."Member No" := "Member No";
                                    LoanDetails."Loan Type" := 'GUR';
                                    if LoanType.Get(LoanDetails."Loan Type") then begin
                                        LoanDetails."Loan Instalments" := LoanType."No of Installment";
                                        LoanDetails."Interest Rate" := LoanType."Interest rate";
                                    end;
                                    LoanDetails."Approved Loan Amount" := LoanGuarantors."Amont Guaranteed";
                                    LoanDetails."Guarantor Number" := LoanGuarantors."Member No";
                                    LoanDetails."Loan No." := LoanGuarantors."Loan No";
                                    LoanDetails."Amont Guaranteed" := LoanGuarantors."Amont Guaranteed";
                                    LoanDetails."Outstanding Balance" := LoanGuarantors."Outstanding Balance";
                                    LoanDetails."Outstanding Interest" := FnGetInterestForLoanToAttach();
                                    // IF LoanDetails."Amont Guaranteed" > 0 THEN BEGIN
                                    //  IF (ROUND(FnGetDefaultorLoanAmount("Loan Liabilities",LoanGuarantors."Amont Guaranteed",LoanGuarantors."Total Loans Guaranteed",GCount),0.05, '>')) > LoanDetails."Amont Guaranteed" THEN
                                    //    LoanDetails."Defaulter Loan":=LoanDetails."Amont Guaranteed"
                                    //  ELSE
                                    LoanDetails."Defaulter Loan" := ROUND(FnGetDefaultorLoanAmount("Loan Distributed to Guarantors", LoanGuarantors."Amont Guaranteed", LoanGuarantors."Total Loans Guaranteed", GCount), 0.05, '>');

                                    ObjSaccoNoSeries.Get();
                                    //Create Loan
                                    ObjNoSeries.Reset;
                                    ObjNoSeries.SetRange(ObjNoSeries."Series Code", ObjSaccoNoSeries."Emergency Loans Nos");
                                    if ObjNoSeries.FindSet then begin
                                        LastNoUsed := ObjNoSeries."Last No. Used";
                                        ObjLoansRec.Init;
                                        ObjLoansRec."Loan  No." := (LastNoUsed);
                                        Message(Format(ObjLoansRec."Loan  No."));
                                        ObjLoansRec."Application Date" := Today;
                                        ObjLoansRec."Client Code" := "Member No";
                                        ObjLoansRec."Client Name" := "Member Name";
                                        ObjLoansRec."Requested Amount" := ROUND(FnGetDefaultorLoanAmount("Loan Distributed to Guarantors", LoanGuarantors."Amont Guaranteed", LoanGuarantors."Total Loans Guaranteed", GCount), 0.05, '>');
                                        ObjLoansRec."Approved Amount" := ROUND(FnGetDefaultorLoanAmount("Loan Distributed to Guarantors", LoanGuarantors."Amont Guaranteed", LoanGuarantors."Total Loans Guaranteed", GCount), 0.05, '>');
                                        ObjLoansRec."Loan Product Type" := 'DEFAULTER';
                                        if ObjLoanType.Get('DEFAULTER') then begin
                                            ObjLoansRec.Installments := ObjLoanType."No of Installment";
                                            ObjLoansRec.Interest := ObjLoanType."Interest rate";
                                            ObjLoansRec."Issued Date" := Today;
                                            ObjLoansRec."Loan Disbursement Date" := Today;
                                            ObjLoansRec.Posted := true;
                                            ObjLoansRec.Validate(ObjLoansRec."Loan Disbursement Date");
                                            ObjLoansRec.Insert;

                                        end;
                                    end;
                                    ObjNoSeries."Last No. Used" := IncStr(ObjLoansRec."Loan  No.");
                                    ObjNoSeries.Modify;
                                    ObjLoansRec.Modify;
                                    LoanDetails."Defaulter Loan No" := ObjLoansRec."Loan  No.";
                                    LoanDetails.Insert;
                                //END;
                                until LoanGuarantors.Next = 0;
                            end;
                        end;
                    end;
                }
                action("Apportion Liability")
                {
                    ApplicationArea = Basic;
                    Image = CalculateLines;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        VarTotalLoanLiabilities := "Loan Distributed to Guarantors";//"Loan Liabilities"+"Outstanding Insurance"+"Total Interest Due Recovered"+"Outstanding Penalty";

                        //================================================================================Load Guarantors Check
                        ObjLoanGuarantors.Reset;
                        ObjLoanGuarantors.SetRange(ObjLoanGuarantors."Document No", "Document No");
                        if ObjLoanGuarantors.Find('-') = false then begin
                            Error('Ensure you Load Loan Guarantors');
                        end;
                        //===============================================================================End Load Guarantors Check

                        if "Guarantor Allocation Type" = "guarantor allocation type"::"Equally Liable" then begin
                            //=================================================================================Get Equal Liability Amount
                            VarTotalGuarantorAmount := 0;
                            ObjLoanGuarantors.Reset;
                            ObjLoanGuarantors.SetRange(ObjLoanGuarantors."Document No", "Document No");
                            if ObjLoanGuarantors.FindSet then begin
                                repeat
                                    VarGuarantorCount := ObjLoanGuarantors.Count;
                                    VarTotalGuarantorAmount := VarTotalGuarantorAmount + ObjLoanGuarantors."Amont Guaranteed";
                                    ObjLoanGuarantors."Equal Liability Amount" := VarTotalLoanLiabilities / VarGuarantorCount;
                                    ObjLoanGuarantors.Modify;
                                until ObjLoanGuarantors.Next = 0;
                            end;
                            //==================================================================================End Get Equal Liability Amount
                            VarTotalApprotionLess := 0;
                            VarTotalApprotionLessCount := 0;
                            ObjLoanGuar.Reset;
                            ObjLoanGuar.SetRange(ObjLoanGuar."Document No", "Document No");
                            if ObjLoanGuar.FindSet then begin
                                repeat
                                    if ObjLoanGuar."Current Member Deposits" <= ObjLoanGuar."Equal Liability Amount" then begin
                                        ObjLoanGuar."Guarantor Amount Apportioned" := ObjLoanGuar."Current Member Deposits";
                                        VarTotalApprotionLess := VarTotalApprotionLess + ObjLoanGuar."Current Member Deposits";
                                        VarTotalApprotionLessCount := VarTotalApprotionLessCount + 1;
                                        ObjLoanGuar.Appotioned := true;
                                        ObjLoanGuar.Modify;
                                    end;
                                until ObjLoanGuar.Next = 0;
                            end;

                            ObjLoanGuarantorsII.Reset;
                            ObjLoanGuarantorsII.SetRange(ObjLoanGuarantorsII."Document No", "Document No");
                            ObjLoanGuarantorsII.SetRange(ObjLoanGuarantorsII.Appotioned, false);
                            if ObjLoanGuarantorsII.FindSet then begin
                                ObjLoanGuarantorsII.CalcSums(ObjLoanGuarantorsII."Equal Liability Amount");
                                VarTotalApprotionGreaterI := ObjLoanGuarantorsII."Equal Liability Amount";
                                VarCountRemainingGuarantors := ObjLoanGuarantorsII.Count;
                            end;
                            VarRemainingLiability := VarTotalLoanLiabilities - VarTotalApprotionLess - VarTotalApprotionGreaterI;

                            while (VarRemainingLiability > 0) and (VarCountRemainingGuarantors > 0) do begin
                                ObjLoanGuarantorsIII.Reset;
                                ObjLoanGuarantorsIII.SetRange(ObjLoanGuarantorsIII."Document No", "Document No");
                                ObjLoanGuarantorsIII.SetRange(ObjLoanGuarantorsIII.Appotioned, false);
                                if ObjLoanGuarantorsIII.FindSet then begin
                                    repeat
                                        ObjLoanGuarantorsIII."Equal Liability Amount" := ObjLoanGuarantorsIII."Equal Liability Amount" + (VarRemainingLiability / VarCountRemainingGuarantors);
                                        if ObjLoanGuarantorsIII."Current Member Deposits" <= ObjLoanGuarantorsIII."Equal Liability Amount" then begin
                                            ObjLoanGuarantorsIII."Guarantor Amount Apportioned" := ObjLoanGuarantorsIII."Current Member Deposits";
                                            ObjLoanGuarantorsIII.Appotioned := true;
                                        end;
                                        ObjLoanGuarantorsIII.Modify;
                                    until ObjLoanGuarantorsIII.Next = 0;
                                end;

                                ObjLoanGuarantorsIV.Reset;
                                ObjLoanGuarantorsIV.SetRange(ObjLoanGuarantorsIV."Document No", "Document No");
                                ObjLoanGuarantorsIV.SetRange(ObjLoanGuarantorsIV.Appotioned, false);
                                if ObjLoanGuarantorsIV.FindSet then begin
                                    ObjLoanGuarantorsIV.CalcSums(ObjLoanGuarantorsIV."Equal Liability Amount");
                                    VarTotalApprotionGreaterI := ObjLoanGuarantorsIV."Equal Liability Amount";
                                    VarCountRemainingGuarantors := ObjLoanGuarantorsIV.Count;
                                end;

                                ObjLoanGuarantorsV.Reset;
                                ObjLoanGuarantorsV.SetRange(ObjLoanGuarantorsV."Document No", "Document No");
                                ObjLoanGuarantorsV.SetRange(ObjLoanGuarantorsV.Appotioned, true);
                                if ObjLoanGuarantorsV.FindSet then begin
                                    ObjLoanGuarantorsV.CalcSums(ObjLoanGuarantorsV."Guarantor Amount Apportioned");
                                    VarTotalApprotionLess := ObjLoanGuarantorsV."Guarantor Amount Apportioned";
                                end;
                                VarRemainingLiability := VarTotalLoanLiabilities - VarTotalApprotionLess - VarTotalApprotionGreaterI;
                            end;
                        end;

                        //==========================================================================================Update Final Apportion
                        ObjLoanGuarantorsIII.Reset;
                        ObjLoanGuarantorsIII.SetRange(ObjLoanGuarantorsIII."Document No", "Document No");
                        ObjLoanGuarantorsIII.SetRange(ObjLoanGuarantorsIII.Appotioned, false);
                        if ObjLoanGuarantorsIII.FindSet then begin
                            repeat
                                ObjLoanGuarantorsIII."Guarantor Amount Apportioned" := ObjLoanGuarantorsIII."Equal Liability Amount";
                                ObjLoanGuarantorsIII.Appotioned := true;
                                ObjLoanGuarantorsIII.Modify;
                            until ObjLoanGuarantorsIII.Next = 0;
                        end;


                        //=======================================================================================Propotional Liability
                        if "Guarantor Allocation Type" = "guarantor allocation type"::"Proportionately Liable" then begin
                            ObjLoanGuarantors.Reset;
                            ObjLoanGuarantors.SetRange(ObjLoanGuarantors."Document No", "Document No");
                            if ObjLoanGuarantors.FindSet then begin
                                ObjLoanGuarantors.CalcSums(ObjLoanGuarantors."Amont Guaranteed");
                                VarTotalGuaranteedAmount := ObjLoanGuarantors."Amont Guaranteed";
                            end;

                            ObjLoanGuarantors.Reset;
                            ObjLoanGuarantors.SetRange(ObjLoanGuarantors."Document No", "Document No");
                            if ObjLoanGuarantors.FindSet then begin
                                repeat
                                    ObjLoanGuarantors."Guarantor Amount Apportioned" := (ObjLoanGuarantors."Amont Guaranteed" / VarTotalGuaranteedAmount) * VarTotalLoanLiabilities;
                                    ObjLoanGuarantors.Appotioned := true;
                                    ObjLoanGuarantors.Modify;
                                until ObjLoanGuarantors.Next = 0;
                            end;
                        end;
                        //=======================================================================================Propotional Liability
                    end;
                }
                action("Clear Guarantors")
                {
                    ApplicationArea = Basic;
                    Image = Delete;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        ObjLoanGuarantors.Reset;
                        ObjLoanGuarantors.SetRange("Document No", "Document No");
                        if ObjLoanGuarantors.FindSet then begin
                            ObjLoanGuarantors.DeleteAll;
                        end;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        UpdateControls();
        UpdateControls();
        EnableCreateMember := false;
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RecordId);
        EnabledApprovalWorkflowsExist := true;
        if Rec.Status = Status::Approved then begin
            OpenApprovalEntriesExist := false;
            CanCancelApprovalForRecord := false;
            EnabledApprovalWorkflowsExist := false;
        end;
        if (Rec.Status = Status::Approved) then
            EnableCreateMember := true;

        ShareCapitalSellVisible := false;
        // if "Recovery Type"="recovery type":: then
        //   begin
        //     ShareCapitalSellVisible:=true;
        //     end;


        ApportionmentVisible := false;
        if "Recovery Type" = "recovery type"::"Recover From Guarantors Deposits" then begin
            ApportionmentVisible := true;
        end;

        if "Recovery Type" = "recovery type"::"Recover From Loanee Deposits" then
            LoanDueVisible := true;

        PostVisible := true;
        if Posted = true then
            PostVisible := false;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        "Created By" := UserId;
        "Application Date" := Today;
        "Loan Disbursement Date" := Today;
    end;

    trigger OnOpenPage()
    begin
        //UpdateControls();
        ShareCapitalSellVisible := false;
        // if "Recovery Type" = "recovery type"::"5" then begin
        //     ShareCapitalSellVisible := true;
        // end;

        ApportionmentVisible := false;
        LoanDueVisible := false;
        if "Recovery Type" = "recovery type"::"Recover From Guarantors Deposits" then begin
            ApportionmentVisible := true;
        end;

        if "Recovery Type" = "recovery type"::"Recover From Loanee Deposits" then
            LoanDueVisible := true;

        PostVisible := true;
        if Posted = true then
            PostVisible := false;
    end;

    var
        PayOffDetails: Record "Loans PayOff Details";
        GenJournalLine: Record "Gen. Journal Line";
        LineNo: Integer;
        LoanType: Record "Loan Products Setup";
        LoansRec: Record "Loans Register";
        TotalRecovered: Decimal;
        TotalInsuarance: Decimal;
        DActivity: Code[20];
        DBranch: Code[20];
        GLoanDetails: Record "Loan Member Loans";
        TotalOustanding: Decimal;
        ClosingDepositBalance: Decimal;
        RemainingAmount: Decimal;
        AMOUNTTOBERECOVERED: Decimal;
        PrincipInt: Decimal;
        TotalLoansOut: Decimal;
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        PDate: Date;
        Interest: Decimal;
        TextDateFormula2: Text[30];
        TextDateFormula1: Text[30];
        DateFormula2: DateFormula;
        DateFormula1: DateFormula;
        Lbal: Decimal;
        GenLedgerSetup: Record "General Ledger Setup";
        Hesabu: Integer;
        "Loan&int": Decimal;
        TotDed: Decimal;
        Available: Decimal;
        Distributed: Decimal;
        WINDOW: Dialog;
        PostingCode: Codeunit "Gen. Jnl.-Post Line";
        SHARES: Decimal;
        TOTALLOANS: Decimal;
        LineN: Integer;
        instlnclr: Decimal;
        appotbal: Decimal;
        PRODATA: Decimal;
        LOANAMOUNT2: Decimal;
        TOTALLOANSB: Decimal;
        NETSHARES: Decimal;
        Tinst: Decimal;
        Finst: Decimal;
        Floans: Decimal;
        GrAmount: Decimal;
        TGrAmount: Decimal;
        FGrAmount: Decimal;
        LOANBAL: Decimal;
        Serie: Integer;
        DLN: Code[10];
        "LN Doc": Code[20];
        INTBAL: Decimal;
        COMM: Decimal;
        loanTypes: Record "Loan Products Setup";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery,ChangeRequest,TreasuryTransactions,FundsTransfer,SaccoTransfers,ChequeDiscounting,ImprestRequisition,ImprestSurrender,LeaveApplication;
        MemberNoEditable: Boolean;
        RecoveryTypeEditable: Boolean;
        Global1Editable: Boolean;
        Global2Editable: Boolean;
        LoantoAttachEditable: Boolean;
        GuarantorLoansDetailsEdit: Boolean;
        TotalRecoverable: Decimal;
        LoanGuarantors: Record "Loans Guarantee Details";
        AmounttoRecover: Decimal;
        BaltoRecover: Decimal;
        InstRecoveredAmount: Decimal;
        X: Decimal;
        ObjGuarantorML: Record "Loan Member Loans";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        RunBal: Decimal;
        TotalSharesUsed: Decimal;
        i: Integer;
        PeriodDueDate: Date;
        ScheduleRep: Record "Loan Repayment Schedule";
        LoanGuar: Record "Loans Guarantee Details";
        RunningDate: Date;
        G: Integer;
        IssuedDate: Date;
        SMSMessages: Record "SMS Messages";
        iEntryNo: Integer;
        GracePeiodEndDate: Date;
        InstalmentEnddate: Date;
        GracePerodDays: Integer;
        InstalmentDays: Integer;
        NoOfGracePeriod: Integer;
        NewSchedule: Record "Loan Repayment Schedule";
        RSchedule: Record "Loan Repayment Schedule";
        GP: Text[30];
        ScheduleCode: Code[20];
        PreviewShedule: Record "Loan Repayment Schedule";
        PeriodInterval: Code[10];
        CustomerRecord: Record Customer;
        Gnljnline: Record "Gen. Journal Line";
        Jnlinepost: Codeunit "Gen. Jnl.-Post Line";
        CumInterest: Decimal;
        NewPrincipal: Decimal;
        PeriodPrRepayment: Decimal;
        GenBatch: Record "Gen. Journal Batch";
        GnljnlineCopy: Record "Gen. Journal Line";
        NewLNApplicNo: Code[10];
        Cust: Record Customer;
        LoanApp: Record "Loans Register";
        TestAmt: Decimal;
        CustRec: Record Customer;
        CustPostingGroup: Record "Customer Posting Group";
        GenSetUp: Record "Sacco General Set-Up";
        PCharges: Record "Loan Product Charges";
        TCharges: Decimal;
        LAppCharges: Record "Loan Applicaton Charges";
        LoansR: Record "Loans Register";
        LoanAmount: Decimal;
        InterestRate: Decimal;
        RepayPeriod: Integer;
        LBalance: Decimal;
        RunDate: Date;
        InstalNo: Decimal;
        RepayInterval: DateFormula;
        TotalMRepay: Decimal;
        LInterest: Decimal;
        LPrincipal: Decimal;
        RepayCode: Code[40];
        GrPrinciple: Integer;
        GrInterest: Integer;
        QPrinciple: Decimal;
        QCounter: Integer;
        InPeriod: DateFormula;
        InitialInstal: Integer;
        InitialGraceInt: Integer;
        FOSAComm: Decimal;
        BOSAComm: Decimal;
        GLPosting: Codeunit "Gen. Jnl.-Post Line";
        LoanTopUp: Record "Loan Offset Details";
        Vend: Record Vendor;
        BOSAInt: Decimal;
        TopUpComm: Decimal;
        TotalTopupComm: Decimal;
        CustE: Record Customer;
        DocN: Text[50];
        DocM: Text[100];
        DNar: Text[250];
        DocF: Text[50];
        MailBody: Text[250];
        ccEmail: Text[250];
        LoanG: Record "Loans Guarantee Details";
        SpecialComm: Decimal;
        FOSAName: Text[150];
        IDNo: Code[50];
        MovementTracker: Record "Movement Tracker";
        DiscountingAmount: Decimal;
        StatusPermissions: Record "Status Change Permision";
        BridgedLoans: Record "Loan Special Clearance";
        SMSMessage: Record "SMS Messages";
        InstallNo2: Integer;
        currency: Record "Currency Exchange Rate";
        CURRENCYFACTOR: Decimal;
        LoanApps: Record "Loans Register";
        LoanDisbAmount: Decimal;
        BatchTopUpAmount: Decimal;
        BatchTopUpComm: Decimal;
        Disbursement: Record "Loan Disburesment-Batching";
        SchDate: Date;
        DisbDate: Date;
        WhichDay: Integer;
        LBatches: Record "Loans Register";
        SalDetails: Record "Loan Appraisal Salary Details";
        LGuarantors: Record "Loans Guarantee Details";
        CurrpageEditable: Boolean;
        LoanStatusEditable: Boolean;
        MNoEditable: Boolean;
        ApplcDateEditable: Boolean;
        LProdTypeEditable: Boolean;
        InstallmentEditable: Boolean;
        AppliedAmountEditable: Boolean;
        ApprovedAmountEditable: Boolean;
        RepayMethodEditable: Boolean;
        RepaymentEditable: Boolean;
        BatchNoEditable: Boolean;
        RepayFrequencyEditable: Boolean;
        ModeofDisburesmentEdit: Boolean;
        DisbursementDateEditable: Boolean;
        AccountNoEditable: Boolean;
        LNBalance: Decimal;
        ApprovalEntries: Record "Approval Entry";
        RejectionRemarkEditable: Boolean;
        ApprovalEntry: Record "Approval Entry";
        Table_id: Integer;
        Doc_No: Code[20];
        Doc_Type: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,TransportRequest,Maintenance,Fuel,ImporterExporter,"Import Permit","Export Permit",TR,"Safari Notice","Student Applications","Water Research","Consultancy Requests","Consultancy Proposals","Meals Bookings","General Journal","Student Admissions","Staff Claim",KitchenStoreRequisition,"Leave Application","Account Opening","Member Closure",Loan;
        GrossPay: Decimal;
        Nettakehome: Decimal;
        TotalDeductions: Decimal;
        UtilizableAmount: Decimal;
        NetUtilizable: Decimal;
        Deductions: Decimal;
        Benov: Decimal;
        TAXABLEPAY: Record "PAYE Brackets Credit";
        PAYE: Decimal;
        PAYESUM: Decimal;
        BAND1: Decimal;
        BAND2: Decimal;
        BAND3: Decimal;
        BAND4: Decimal;
        BAND5: Decimal;
        Taxrelief: Decimal;
        OTrelief: Decimal;
        Chargeable: Decimal;
        PartPay: Record "Loan Partial Disburesments";
        PartPayTotal: Decimal;
        AmountPayable: Decimal;
        RepaySched: Record "Loan Repayment Schedule";
        LoanReferee1NameEditable: Boolean;
        LoanReferee2NameEditable: Boolean;
        LoanReferee1MobileEditable: Boolean;
        LoanReferee2MobileEditable: Boolean;
        LoanReferee1AddressEditable: Boolean;
        LoanReferee2AddressEditable: Boolean;
        LoanReferee1PhyAddressEditable: Boolean;
        LoanReferee2PhyAddressEditable: Boolean;
        LoanReferee1RelationEditable: Boolean;
        LoanReferee2RelationEditable: Boolean;
        LoanPurposeEditable: Boolean;
        WitnessEditable: Boolean;
        compinfo: Record "Company Information";
        LoanRepa: Record "Loan Repayment Schedule";
        ObjGuarantorRec: Record "Loan Recovery Header";
        Text0001: label 'Please consider recovering from the Loanee Shares Before Attaching to Guarantors';
        BATCH_TEMPLATE: Code[30];
        BATCH_NAME: Code[30];
        DOCUMENT_NO: Code[30];
        EXTERNAL_DOC_NO: Code[40];
        SFactory: Codeunit "SURESTEP Factory";
        DLoan: Code[20];
        Datefilter: Text;
        LoanDetails: Record "Loan Member Loans";
        OpenApprovalEntriesExist: Boolean;
        EnabledApprovalWorkflowsExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
        EventFilter: Text;
        EnableCreateMember: Boolean;
        RecoveryTransType: Option Normal,"Guarantor Recoverd","Guarantor Paid";
        ObjLoansRec: Record "Loans Register";
        ObjNoSeries: Record "No. Series Line";
        ObjSaccoNoSeries: Record "Sacco No. Series";
        LastNoUsed: Code[20];
        ObjLoanType: Record "Loan Products Setup";
        VarAmounttoDeduct: Decimal;
        ObjCust: Record Customer;
        ObjLoanGuarantors: Record "Loan Member Loans";
        ObjLoanGuarantorsII: Record "Loan Member Loans";
        ObjLoanGuarantorsIII: Record "Loan Member Loans";
        ObjLoanGuarantorsIV: Record "Loan Member Loans";
        ObjLoanGuarantorsV: Record "Loan Member Loans";
        ObjLoanGuar: Record "Loan Member Loans";
        VarTotalGuarantorAmount: Decimal;
        VarGuarantorCount: Integer;
        VarTotalApprotionLess: Decimal;
        VarTotalApprotionGreater: Decimal;
        VarTotalApprotionLessCount: Integer;
        ShareCapitalSellVisible: Boolean;
        ApportionmentVisible: Boolean;
        VarTotalLoanLiabilities: Decimal;
        VarLoanInsuranceBalAccount: Code[20];
        VarTotalApprotionGreaterI: Decimal;
        VarTotalApprotionLessCountI: Integer;
        VarRemainingLiability: Decimal;
        VarCountRemainingGuarantors: Integer;
        VarTotalGuaranteedAmount: Decimal;
        LoanDueVisible: Boolean;
        ObjGLEntry: Record "G/L Entry";
        PostVisible: Boolean;


    procedure UpdateControls()
    begin

        if Status = Status::Open then begin
            MemberNoEditable := true;
            RecoveryTypeEditable := true;
            LoantoAttachEditable := true;
            Global1Editable := true;
            Global2Editable := true;
            GuarantorLoansDetailsEdit := true;
        end;
        if Status = Status::Pending then begin
            MemberNoEditable := false;
            RecoveryTypeEditable := false;
            LoantoAttachEditable := false;
            Global1Editable := false;
            Global2Editable := false;
            GuarantorLoansDetailsEdit := true;
        end;
        if Status = Status::Approved then begin
            MemberNoEditable := false;
            RecoveryTypeEditable := false;
            LoantoAttachEditable := false;
            Global1Editable := false;
            Global2Editable := false;
            GuarantorLoansDetailsEdit := true;
        end
    end;

    local procedure FnGetDefaultorLoanAmount(OutstandingBalance: Decimal; GuaranteedAmount: Decimal; TotalGuaranteedAmount: Decimal; GuarantorCount: Integer): Decimal
    begin
        if "Guarantor Allocation Type" = "guarantor allocation type"::"Equally Liable" then begin
            exit(OutstandingBalance / GuarantorCount)
        end else
            exit(ROUND(GuaranteedAmount / TotalGuaranteedAmount * ("Loan Liabilities"), 0.05, '>'));
    end;


    procedure FnPostRepaymentJournal(TDefaulterLoan: Decimal)
    var
        ObjLoanDetails: Record "Loan Member Loans";
    begin
        if LoansRec.Get("Loan to Attach") then begin
            LineNo := LineNo + 10000;

            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Repayment",
            GenJournalLine."account type"::None, LoansRec."Client Code", "Loan Disbursement Date", TDefaulterLoan * -1, Format(LoanApps.Source), EXTERNAL_DOC_NO,
            'Defaulted Loan Recovered-' + "Loan to Attach", "Loan to Attach", GenJournalLine."application source"::" ");//Maximum No of Parameters(13) Exceeded

        end;
    end;

    local procedure FnGetInterestForLoanToAttach(): Decimal
    var
        ObjLoansRegisterLocal: Record "Loans Register";
    begin
        ObjLoansRegisterLocal.Reset;
        ObjLoansRegisterLocal.SetRange(ObjLoansRegisterLocal."Loan  No.", "Loan to Attach");
        if ObjLoansRegisterLocal.Find('-') then begin
            ObjLoansRegisterLocal.CalcFields(ObjLoansRegisterLocal."Outstanding Interest");
            exit(ObjLoansRegisterLocal."Outstanding Interest");
        end;

    end;

    local procedure FnRunInterest(RunningBalance: Decimal)
    var
        AmountToDeduct: Decimal;
    begin
        if RunningBalance > 0 then begin
            LoanApp.Reset;
            LoanApp.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
            LoanApp.SetRange("BOSA No", "Member No");
            LoanApp.SetFilter(LoanApp."Date filter", Datefilter);
            if LoanApp.Find('-') then begin
                repeat
                    if RunningBalance > 0 then begin
                        AmountToDeduct := 0;
                        AmountToDeduct := FnCalculateTotalInterestDue(LoanApp);
                        if RunningBalance <= AmountToDeduct then
                            AmountToDeduct := RunningBalance;

                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Interest Paid",
                        GenJournalLine."account type"::None, LoanApp."Client Code", "Loan Disbursement Date", AmountToDeduct * -1, Format(LoanApp.Source), EXTERNAL_DOC_NO,
                        Format(GenJournalLine."transaction type"::"Interest Paid"), LoanApp."Loan  No.", GenJournalLine."application source"::" ");
                        RunningBalance := RunningBalance - AmountToDeduct;
                    end;
                until LoanApp.Next = 0;
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Deposit Contribution",
                GenJournalLine."account type"::None, "Member No", "Loan Disbursement Date", "Total Interest Due Recovered", 'BOSA', EXTERNAL_DOC_NO,
                Format(GenJournalLine."transaction type"::"Deposit Contribution") + '-' + LoanApp."Loan Product Type", '', GenJournalLine."application source"::" ");
            end;
        end;
    end;

    local procedure FnRunPrinciple(RunningBalance: Decimal)
    var
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayment: Decimal;
    begin
        begin
            if LoansRec.Get("Loan to Attach") then begin
                //---------------------PAY-------------------------------
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Repayment",
                GenJournalLine."account type"::None, LoansRec."Client Code", "Loan Disbursement Date", "Deposits Aportioned" * -1, Format(LoansRec.Source), EXTERNAL_DOC_NO,
                Format(GenJournalLine."transaction type"::"Loan Repayment"), "Loan to Attach", GenJournalLine."application source"::" ");
                //--------------------RECOVER-----------------------------
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Deposit Contribution",
                GenJournalLine."account type"::None, "Member No", "Loan Disbursement Date", "Deposits Aportioned", Format(LoansRec.Source), EXTERNAL_DOC_NO,
                Format(GenJournalLine."transaction type"::"Deposit Contribution") + '-' + LoansRec."Loan Product Type", '', GenJournalLine."application source"::" ");
            end;
        end;
    end;

    local procedure FnLoansGenerated()
    begin
    end;

    local procedure FnDefaulterLoansDisbursement(ObjLoanDetails: Record "Loan Member Loans"; LineNo: Integer): Code[40]
    var
        GenJournalLine: Record "Gen. Journal Line";
        CUNoSeriesManagement: Codeunit NoSeriesManagement;
        DocNumber: Code[100];
        loanTypes: Record "Loan Products Setup";
        ObjLoanX: Record "Loans Register";
    begin
        loanTypes.Reset;
        loanTypes.SetRange(loanTypes.Code, 'GUR');
        if loanTypes.Find('-') then begin
            DocNumber := CUNoSeriesManagement.GetNextNo('LOANSB', 0D, true);
            LoansRec.Init;
            LoansRec."Loan  No." := DocNumber;
            LoansRec.Insert;

            if LoansRec.Get(LoansRec."Loan  No.") then begin
                LoansRec."Client Code" := ObjLoanDetails."Guarantor Number";
                LoansRec.Validate(LoansRec."Client Code");
                LoansRec."Loan Product Type" := 'GUR';
                LoansRec.Validate(LoansRec."Loan Product Type");
                LoansRec.Interest := ObjLoanDetails."Interest Rate";
                LoansRec."Loan Status" := LoansRec."loan status"::Closed;
                LoansRec."Application Date" := "Loan Disbursement Date";
                LoansRec."Issued Date" := "Loan Disbursement Date";
                LoansRec."Loan Disbursement Date" := "Loan Disbursement Date";
                LoansRec."Expected Date of Completion" := "Expected Date of Completion";
                LoansRec.Validate(LoansRec."Loan Disbursement Date");
                LoansRec."Mode of Disbursement" := LoansRec."mode of disbursement"::"FOSA Account";
                LoansRec."Repayment Start Date" := "Repayment Start Date";
                LoansRec."Global Dimension 1 Code" := Format(LoanApps.Source);
                LoansRec."Global Dimension 2 Code" := SFactory.FnGetUserBranch();
                LoansRec.Source := LoansRec.Source::BOSA;
                LoansRec."Approval Status" := LoansRec."approval status"::Approved;
                LoansRec.Repayment := ObjLoanDetails."Approved Loan Amount";
                LoansRec."Requested Amount" := 0;
                LoansRec."Approved Amount" := ObjLoanDetails."Approved Loan Amount";
                LoansRec."Mode of Disbursement" := LoansRec."mode of disbursement"::"FOSA Account";
                LoansRec.Posted := true;
                LoansRec."Advice Date" := Today;
                LoansRec.Modify;
            end;
        end;
        exit(DocNumber);
    end;

    local procedure FnGenerateRepaymentSchedule(LoanNumber: Code[50])
    begin
        LoansR.Reset;
        LoansR.SetRange(LoansR."Loan  No.", LoansRec."Loan  No.");
        LoansR.SetFilter(LoansR."Approved Amount", '>%1', 0);
        LoansR.SetFilter(LoansR.Posted, '=%1', true);
        if LoansR.Find('-') then begin
            if ((LoansR."Loan Product Type" = 'GUR') and (LoansR."Issued Date" <> 0D) and (LoansR."Repayment Start Date" <> 0D)) then begin
                LoansRec.TestField(LoansRec."Loan Disbursement Date");
                LoansRec.TestField(LoansRec."Repayment Start Date");

                RSchedule.Reset;
                RSchedule.SetRange(RSchedule."Loan No.", LoansR."Loan  No.");
                RSchedule.DeleteAll;

                LoanAmount := LoansR."Approved Amount";
                InterestRate := LoansR.Interest;
                RepayPeriod := LoansR.Installments;
                InitialInstal := LoansR.Installments + LoansRec."Grace Period - Principle (M)";
                LBalance := LoansR."Approved Amount";
                RunDate := "Repayment Start Date";
                InstalNo := 0;

                //Repayment Frequency
                if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Daily then
                    RunDate := CalcDate('-1D', RunDate)
                else
                    if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Weekly then
                        RunDate := CalcDate('-1W', RunDate)
                    else
                        if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Monthly then
                            RunDate := CalcDate('-1M', RunDate)
                        else
                            if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Quaterly then
                                RunDate := CalcDate('-1Q', RunDate);
                //Repayment Frequency


                repeat
                    InstalNo := InstalNo + 1;
                    //Repayment Frequency
                    if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Daily then
                        RunDate := CalcDate('1D', RunDate)
                    else
                        if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Weekly then
                            RunDate := CalcDate('1W', RunDate)
                        else
                            if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Monthly then
                                RunDate := CalcDate('1M', RunDate)
                            else
                                if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Quaterly then
                                    RunDate := CalcDate('1Q', RunDate);

                    if LoansRec."Repayment Method" = LoansRec."repayment method"::Amortised then begin
                        //LoansRec.TESTFIELD(LoansRec.Interest);
                        LoansRec.TestField(LoansRec.Installments);
                        TotalMRepay := ROUND((InterestRate / 12 / 100) / (1 - Power((1 + (InterestRate / 12 / 100)), -(RepayPeriod))) * (LoanAmount), 0.0001, '>');
                        LInterest := ROUND(LBalance / 100 / 12 * InterestRate, 0.0001, '>');
                        LPrincipal := TotalMRepay - LInterest;
                    end;

                    if LoansRec."Repayment Method" = LoansRec."repayment method"::"Straight Line" then begin
                        LoansRec.TestField(LoansRec.Interest);
                        LoansRec.TestField(LoansRec.Installments);
                        LPrincipal := LoanAmount / RepayPeriod;
                        LInterest := (InterestRate / 12 / 100) * LoanAmount / RepayPeriod;
                    end;

                    if LoansRec."Repayment Method" = LoansRec."repayment method"::"Reducing Balance" then begin
                        LoansRec.TestField(LoansRec.Interest);
                        LoansRec.TestField(LoansRec.Installments);
                        LPrincipal := LoanAmount / RepayPeriod;
                        LInterest := (InterestRate / 12 / 100) * LBalance;
                    end;

                    if LoansRec."Repayment Method" = LoansRec."repayment method"::Constants then begin
                        LoansRec.TestField(LoansRec.Repayment);
                        if LBalance < LoansRec.Repayment then
                            LPrincipal := LBalance
                        else
                            LPrincipal := LoansRec.Repayment;
                        LInterest := LoansRec.Interest;
                    end;

                    //Grace Period
                    if GrPrinciple > 0 then begin
                        LPrincipal := 0
                    end else begin
                        LBalance := LBalance - LPrincipal;

                    end;

                    if GrInterest > 0 then
                        LInterest := 0;

                    GrPrinciple := GrPrinciple - 1;
                    GrInterest := GrInterest - 1;
                    Evaluate(RepayCode, Format(InstalNo));


                    RSchedule.Init;
                    RSchedule."Repayment Code" := RepayCode;
                    RSchedule."Interest Rate" := InterestRate;
                    RSchedule."Loan No." := LoansRec."Loan  No.";
                    RSchedule."Loan Amount" := LoanAmount;
                    RSchedule."Instalment No" := InstalNo;
                    RSchedule."Repayment Date" := RunDate;
                    RSchedule."Member No." := LoansRec."Client Code";
                    RSchedule."Loan Category" := LoansRec."Loan Product Type";
                    RSchedule."Monthly Repayment" := LInterest + LPrincipal;
                    RSchedule."Monthly Interest" := LInterest;
                    RSchedule."Principal Repayment" := LPrincipal;
                    RSchedule.Insert;
                    WhichDay := Date2dwy(RSchedule."Repayment Date", 1);
                until LBalance < 1

            end;
        end;

        Commit;
    end;

    local procedure FnRecoverMobileLoanPrincipal(RunningBalance: Decimal)
    var
        AmountToDeduct: Decimal;
        varLRepayment: Decimal;
    begin
        if RunningBalance > 0 then begin
            LoanApp.Reset;
            LoanApp.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
            LoanApp.SetRange(LoanApp."BOSA No", "Member No");
            LoanApp.SetFilter(LoanApp."Date filter", Datefilter);
            LoanApp.SetFilter(Source, Format(LoanApp.Source::FOSA));
            LoanApp.SetFilter("Loan Product Type", 'MSADV');
            LoanApp.SetFilter(Posted, 'Yes');
            if LoanApp.Find('-') then begin
                //---------------------PAY-------------------------------
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Repayment",
                GenJournalLine."account type"::None, LoanApp."Client Code", "Loan Disbursement Date", "Mobile Loan" * -1, 'FOSA', EXTERNAL_DOC_NO,
                Format(GenJournalLine."transaction type"::"Loan Repayment"), LoanApp."Loan  No.", GenJournalLine."application source"::" ");
                //--------------------RECOVER-----------------------------
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Deposit Contribution",
                GenJournalLine."account type"::None, "Member No", "Loan Disbursement Date", "Mobile Loan", 'BOSA', EXTERNAL_DOC_NO,
                Format(GenJournalLine."transaction type"::"Deposit Contribution") + '-' + LoanApp."Loan Product Type", LoanApp."Loan  No.", GenJournalLine."application source"::" ");
            end;
        end;
    end;

    local procedure FnRunPrincipleThirdparty(RunningBalance: Decimal): Decimal
    var
        AmountToDeduct: Decimal;
        ObjReceiptTransactions: Record "Receipt Allocation";
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayment: Decimal;
        PRpayment: Decimal;
        ReceiptLine: Record "Checkoff Lines-Distributed";
    begin
        if RunningBalance > 0 then begin
            varTotalRepay := 0;
            varMultipleLoan := 0;
            LoanApp.Reset;
            LoanApp.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
            LoanApp.SetRange(LoanApp."Client Code", "Member No");
            LoanApp.SetFilter(LoanApp."Date filter", Datefilter);
            LoanApp.SetFilter(LoanApp."Loan Product Type", 'GUR');
            if LoanApp.Find('-') then begin
                repeat
                    if RunningBalance > 0 then begin
                        LoanApp.CalcFields(LoanApp."Outstanding Balance");
                        if LoanApp."Outstanding Balance" > 0 then begin
                            varLRepayment := 0;
                            PRpayment := 0;
                            varLRepayment := LoanApp."Outstanding Balance";
                            if varLRepayment > 0 then begin
                                if RunningBalance > 0 then begin
                                    if RunningBalance > varLRepayment then begin
                                        AmountToDeduct := varLRepayment;
                                    end
                                    else
                                        AmountToDeduct := RunningBalance;
                                end;
                                LineNo := LineNo + 10000;
                                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Repayment",
                                GenJournalLine."account type"::None, LoanApp."Client Code", "Loan Disbursement Date", AmountToDeduct * -1, Format(LoanApp.Source), EXTERNAL_DOC_NO,
                                Format(GenJournalLine."transaction type"::"Loan Repayment"), LoanApp."Loan  No.", GenJournalLine."application source"::" ");
                                RunningBalance := RunningBalance - AmountToDeduct;
                            end;
                        end;
                    end;

                until LoanApp.Next = 0;
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Deposit Contribution",
                GenJournalLine."account type"::None, "Member No", "Loan Disbursement Date", "Total Thirdparty Loans", 'BOSA', EXTERNAL_DOC_NO,
                Format(GenJournalLine."transaction type"::"Deposit Contribution") + '-' + LoanApp."Loan Product Type", '', GenJournalLine."application source"::" ");
            end;
            exit(RunningBalance);
        end;
    end;

    local procedure FnGenerateDefaulterLoans()
    var
        DLoanAmount: Decimal;
    begin
        LoanDetails.Reset;
        LoanDetails.SetRange(LoanDetails."Document No", "Document No");
        LoanDetails.SetRange(LoanDetails."Loan No.", "Loan to Attach");
        LoanDetails.SetRange(LoanDetails."Member No", "Member No");
        if LoanDetails.FindSet then begin
            repeat
                LineNo := LineNo + 1000;
                DLoan := FnDefaulterLoansDisbursement(LoanDetails, LineNo);
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::Loan,
                GenJournalLine."account type"::None, LoanDetails."Guarantor Number", "Loan Disbursement Date", LoanDetails."Defaulter Loan", Format(LoansRec.Source::BOSA), "Loan to Attach",
                'Defaulter Recovery-' + "Loan to Attach", LoanDetails."Defaulter Loan No", GenJournalLine."application source"::" ");//DLoan
                DLoanAmount := DLoanAmount + LoanDetails."Defaulter Loan";
            until LoanDetails.Next = 0;
        end;

        if LoansRec.Get("Loan to Attach") then begin
            LineNo := LineNo + 10000;
            /*SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE,BATCH_NAME,DOCUMENT_NO,LineNo,GenJournalLine."Transaction Type"::"Loan Repayment",
            GenJournalLine."Account Type"::Member,LoansRec."Client Code","Loan Disbursement Date",DLoanAmount*-1,FORMAT(LoanApps.Source),EXTERNAL_DOC_NO,
            'Defaulted Loan Recovered-'+LoansRec."Loan Product Type","Loan to Attach");*///Maximum no of Parameters Exceeded

            GenJournalLine.Init;
            GenJournalLine."Journal Template Name" := BATCH_TEMPLATE;
            GenJournalLine."Journal Batch Name" := BATCH_NAME;
            GenJournalLine."Document No." := DOCUMENT_NO;
            GenJournalLine."Line No." := LineNo;
            GenJournalLine."Account Type" := GenJournalLine."account type"::None;
            GenJournalLine."Account No." := LoansRec."Client Code";
            GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Loan Repayment";
            GenJournalLine."Loan No" := "Loan to Attach";
            GenJournalLine.Validate(GenJournalLine."Account No.");
            GenJournalLine."Posting Date" := "Loan Disbursement Date";
            GenJournalLine.Description := 'Defaulted Loan Recovered-' + "Loan to Attach";
            GenJournalLine.Validate(GenJournalLine."Currency Code");
            GenJournalLine.Amount := DLoanAmount * -1;
            GenJournalLine."External Document No." := "Loan to Attach";
            GenJournalLine.Validate(GenJournalLine.Amount);
            GenJournalLine."Recovery Transaction Type" := GenJournalLine."recovery transaction type"::"Guarantor Recoverd";
            GenJournalLine."Recoverd Loan" := "Loan to Attach";
            GenJournalLine."Shortcut Dimension 1 Code" := "Global Dimension 1 Code";
            GenJournalLine."Shortcut Dimension 2 Code" := "Global Dimension 2 Code";
            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
            if GenJournalLine.Amount <> 0 then
                GenJournalLine.Insert;
        end;

    end;

    local procedure FnCalculateTotalInterestDue(Loans: Record "Loans Register") InterestDue: Decimal
    var
        ObjRepaymentSchedule: Record "Loan Repayment Schedule";
        "Loan Age": Integer;
    begin
        ObjRepaymentSchedule.Reset;
        ObjRepaymentSchedule.SetRange("Loan No.", Loans."Loan  No.");
        ObjRepaymentSchedule.SetFilter("Repayment Date", '<=%1', "Loan Disbursement Date");
        if ObjRepaymentSchedule.Find('-') then
            "Loan Age" := ObjRepaymentSchedule.Count;
        Loans.CalcFields("Outstanding Balance", "Interest Paid");

        InterestDue := ((0.01 * Loans."Approved Amount" + 0.01 * Loans."Outstanding Balance") * Loans.Interest / 12 * ("Loan Age")) / 2 - Abs(Loans."Interest Paid");
        if (Date2dmy("Loan Disbursement Date", 1) > 15) then begin
            InterestDue := ((0.01 * Loans."Approved Amount" + 0.01 * Loans."Outstanding Balance") * Loans.Interest / 12 * ("Loan Age" + 1)) / 2 - Abs(Loans."Interest Paid");
        end;
        if InterestDue <= 0 then
            exit(0);
        //MESSAGE('Approved=%1 Loan Age=%2 OBalance=%3 InterestPaid=%4 InterestDue=%5',Loans."Approved Amount","Loan Age",Loans."Outstanding Balance",Loans."Interest Paid",InterestDue);
        exit(InterestDue);
    end;

    // local procedure FnRunRecoverFromLoaneesDeposits(RunningBalance: Decimal)
    // var
    //     AmountToDeduct: Decimal;
    // begin
    //     if RunningBalance > 0 then begin

    //         if "Charge Insurance" = true then begin
    //             //============================================================Loan Insurance Repayment
    //             LoanApp.Reset;
    //             LoanApp.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
    //             //LoanApp.SETRANGE("BOSA No","Member No");
    //             LoanApp.SetRange(LoanApp."Loan  No.", "Loan to Attach");
    //             LoanApp.SetFilter(LoanApp."Date filter", Datefilter);
    //             if LoanApp.Find('-') then begin
    //                 //REPEAT
    //                 LoanApp.CalcFields(LoanApp."Outstanding Balance", LoanApp."Outstanding Interest");
    //                 if RunningBalance > 0 then begin
    //                     AmountToDeduct := 0;
    //                     if "Outstanding Insurance" > 0 then begin
    //                         if "Outstanding Insurance" < RunningBalance then begin
    //                             AmountToDeduct := "Outstanding Insurance"
    //                         end else
    //                             AmountToDeduct := RunningBalance;

    //                         if ObjLoanType.Get(LoanApp."Loan Product Type") then begin
    //                             VarLoanInsuranceBalAccount := ObjLoanType."Receivable Insurance Accounts";
    //                         end;

    //                         //------------------------------------DEBIT INSURANCE FOR THE CURRENT YEAR  A/C---------------------------------------------------------------------------------------------

    //                         LineNo := LineNo + 10000;
    //                         SFactory.FnCreateGnlJournalLineBalanced(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Insurance Charged",
    //                         GenJournalLine."account type"::None, LoanApp."Client Code", "Loan Disbursement Date", 'Loan Insurance:_' + "Document No", GenJournalLine."bal. account type"::"G/L Account",
    //                         VarLoanInsuranceBalAccount, AmountToDeduct, 'BOSA', LoanApp."Loan  No.");
    //                         //--------------------------------(Credit Loan Penalty Account)-------------------------------------------------------------------------------

    //                         LineNo := LineNo + 10000;
    //                         SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Insurance Paid",
    //                         GenJournalLine."account type"::None, LoanApp."Client Code", "Loan Disbursement Date", AmountToDeduct * -1, Format(LoanApp.Source), EXTERNAL_DOC_NO,
    //                         'Insurance Recovered From Deposits', LoanApp."Loan  No.", GenJournalLine."application source"::" ");
    //                         RunningBalance := RunningBalance - AmountToDeduct;
    //                         VarAmounttoDeduct := VarAmounttoDeduct + AmountToDeduct;
    //                     end;
    //                 end;
    //             end;
    //         end;
    //     end;
    //     //============================================================Loan Penalty Repayment
    //     if RunningBalance > 0 then begin
    //         LoanApp.Reset;
    //         LoanApp.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
    //         //LoanApp.SETRANGE("BOSA No","Member No");
    //         LoanApp.SetRange(LoanApp."Loan  No.", "Loan to Attach");
    //         LoanApp.SetFilter(LoanApp."Date filter", Datefilter);
    //         if LoanApp.Find('-') then begin
    //             //REPEAT
    //             LoanApp.CalcFields(LoanApp."Outstanding Balance", LoanApp."Outstanding Interest");
    //             if RunningBalance > 0 then begin
    //                 AmountToDeduct := 0;
    //                 if "Total Interest Due Recovered" > 0 then begin
    //                     if "Total Interest Due Recovered" < RunningBalance then begin
    //                         AmountToDeduct := "Total Interest Due Recovered"
    //                     end else
    //                         AmountToDeduct := RunningBalance;

    //                     LineNo := LineNo + 10000;
    //                     SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Repayment",
    //                     GenJournalLine."account type"::None, LoanApp."Client Code", "Loan Disbursement Date", AmountToDeduct * -1, Format(LoanApp.Source), EXTERNAL_DOC_NO,
    //                     'Interest Recovered From Deposits', LoanApp."Loan  No.", GenJournalLine."application source"::" ");
    //                     RunningBalance := RunningBalance - AmountToDeduct;
    //                     VarAmounttoDeduct := VarAmounttoDeduct + AmountToDeduct;
    //                 end;
    //             end;
    //         end;
    //     end;

    //     //============================================================Loan Interest Repayment
    //     if RunningBalance > 0 then begin
    //         LoanApp.Reset;
    //         LoanApp.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
    //         //LoanApp.SETRANGE("BOSA No","Member No");
    //         LoanApp.SetRange(LoanApp."Loan  No.", "Loan to Attach");
    //         LoanApp.SetFilter(LoanApp."Date filter", Datefilter);
    //         if LoanApp.Find('-') then begin
    //             //REPEAT
    //             LoanApp.CalcFields(LoanApp."Outstanding Balance", LoanApp."Outstanding Interest");
    //             if RunningBalance > 0 then begin
    //                 AmountToDeduct := 0;
    //                 if "Total Interest Due Recovered" > 0 then begin
    //                     if "Total Interest Due Recovered" < RunningBalance then begin
    //                         AmountToDeduct := "Total Interest Due Recovered"
    //                     end else
    //                         AmountToDeduct := RunningBalance;

    //                     LineNo := LineNo + 10000;
    //                     SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Repayment",
    //                     GenJournalLine."account type"::None, LoanApp."Client Code", "Loan Disbursement Date", AmountToDeduct * -1, Format(LoanApp.Source), EXTERNAL_DOC_NO,
    //                     'Interest Recovered From Deposits', LoanApp."Loan  No.", GenJournalLine."application source"::" ");
    //                     RunningBalance := RunningBalance - AmountToDeduct;
    //                     VarAmounttoDeduct := VarAmounttoDeduct + AmountToDeduct;
    //                 end;
    //             end;
    //         end;
    //     end;






    //     //============================================================Loan Principle Repayment
    //     if RunningBalance > 0 then begin
    //         LoanApp.Reset;
    //         LoanApp.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
    //         //LoanApp.SETRANGE("BOSA No","Member No");
    //         LoanApp.SetRange(LoanApp."Loan  No.", "Loan to Attach");
    //         LoanApp.SetFilter(LoanApp."Date filter", Datefilter);
    //         if LoanApp.Find('-') then begin
    //             LoanApp.CalcFields(LoanApp."Outstanding Balance", LoanApp."Outstanding Interest");
    //             if RunningBalance > 0 then begin
    //                 AmountToDeduct := 0;
    //                 if LoanApp."Outstanding Balance" > 0 then begin
    //                     if LoanApp."Outstanding Balance" < RunningBalance then begin
    //                         AmountToDeduct := LoanApp."Outstanding Balance"
    //                     end else
    //                         AmountToDeduct := RunningBalance;

    //                     LineNo := LineNo + 10000;
    //                     SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Repayment",
    //                     GenJournalLine."account type"::None, LoanApp."Client Code", "Loan Disbursement Date", AmountToDeduct * -1, Format(LoanApp.Source), EXTERNAL_DOC_NO,
    //                     'Repayment Recovered From Deposits', LoanApp."Loan  No.", GenJournalLine."application source"::" ");
    //                     RunningBalance := RunningBalance - AmountToDeduct;
    //                     VarAmounttoDeduct := VarAmounttoDeduct + AmountToDeduct;
    //                 end;
    //             end;
    //         end;
    //     end;


    //     LineNo := LineNo + 10000;
    //     SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Deposit Contribution",
    //     GenJournalLine."account type"::None, "Member No", "Loan Disbursement Date", VarAmounttoDeduct, 'BOSA', EXTERNAL_DOC_NO,
    //     'Repayment Recovered From Deposits' + '-' + LoanApp."Loan Product Type Name", '', GenJournalLine."application source"::" ");
    // end;

    // local procedure FnRunRecoverFromGuarantorsDeposits(VarDocumentNo: Code[20]; VarLoanNo: Code[20]; VarMemberNo: Code[20]; VarPostingDate: Date)
    // var
    //     AmountToDeduct: Decimal;
    //     RunningBalance: Decimal;
    //     VarInsuranceAmounttoDeduct: Decimal;
    // begin


    //     ObjLoanGuarantors.Reset;
    //     ObjLoanGuarantors.SetRange("Document No", VarDocumentNo);
    //     if ObjLoanGuarantors.FindSet then begin
    //         repeat
    //             RunningBalance := ObjLoanGuarantors."Guarantor Amount Apportioned";

    //             if RunningBalance > 0 then begin

    //                 if ("Charge Insurance" = true) and ("Insurance Fully Recovered" = false) then begin

    //                     //============================================================Loan Insurance Repayment
    //                     LoanApp.Reset;
    //                     LoanApp.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
    //                     //LoanApp.SETRANGE("BOSA No","Member No");
    //                     LoanApp.SetRange(LoanApp."Loan  No.", "Loan to Attach");
    //                     LoanApp.SetFilter(LoanApp."Date filter", Datefilter);
    //                     if LoanApp.Find('-') then begin
    //                         //REPEAT
    //                         LoanApp.CalcFields(LoanApp."Outstanding Balance", LoanApp."Outstanding Interest", LoanApp."Outstanding Insurance", LoanApp."Outstanding Penalty");
    //                         if RunningBalance > 0 then begin
    //                             AmountToDeduct := 0;

    //                             VarInsuranceAmounttoDeduct := LoanApp."Outstanding Insurance" + "Insurance:Remaining Period";

    //                             if "Insurance Difference" <> 0 then begin
    //                                 VarInsuranceAmounttoDeduct := "Insurance Difference"
    //                             end;

    //                             if VarInsuranceAmounttoDeduct > 0 then begin
    //                                 if VarInsuranceAmounttoDeduct <= RunningBalance then begin
    //                                     AmountToDeduct := VarInsuranceAmounttoDeduct
    //                                 end else
    //                                     AmountToDeduct := RunningBalance;

    //                                 if ObjLoanType.Get(LoanApp."Loan Product Type") then begin
    //                                     VarLoanInsuranceBalAccount := ObjLoanType."Receivable Insurance Accounts";
    //                                 end;
    //                                 //------------------------------------DEBIT INSURANCE FOR THE CURRENT YEAR  A/C---------------------------------------------------------------------------------------------

    //                                 LineNo := LineNo + 10000;
    //                                 SFactory.FnCreateGnlJournalLineBalanced(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Insurance Charged",
    //                                 GenJournalLine."account type"::None, VarMemberNo, VarPostingDate, 'Loan Insurance:_' + "Document No", GenJournalLine."bal. account type"::"G/L Account",
    //                                 VarLoanInsuranceBalAccount, AmountToDeduct, 'BOSA', VarLoanNo);
    //                                 //--------------------------------(Credit Loan Penalty Account)-------------------------------------------------------------------------------

    //                                 LineNo := LineNo + 10000;
    //                                 SFactory.FnCreateGnlJournalLineGuarantorRecovery(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Insurance Paid",
    //                                 GenJournalLine."account type"::None, VarMemberNo, VarPostingDate, AmountToDeduct * -1, 'BOSA', EXTERNAL_DOC_NO,
    //                                 'Loan Recovered From_' + ObjLoanGuarantors."Member Name" + ObjLoanGuarantors."Guarantor Number", VarLoanNo, GenJournalLine."recovery transaction type"::"Guarantor Recoverd", VarLoanNo);

    //                                 RunningBalance := RunningBalance - AmountToDeduct;
    //                                 VarAmounttoDeduct := VarAmounttoDeduct + AmountToDeduct;
    //                             end;
    //                         end;
    //                     end;
    //                 end;
    //             end;

    //             //============================================================Loan Penalty Repayment
    //             if RunningBalance > 0 then begin
    //                 LoanApp.Reset;
    //                 LoanApp.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
    //                 //LoanApp.SETRANGE("BOSA No","Member No");
    //                 LoanApp.SetRange(LoanApp."Loan  No.", "Loan to Attach");
    //                 LoanApp.SetFilter(LoanApp."Date filter", Datefilter);
    //                 if LoanApp.Find('-') then begin
    //                     //REPEAT
    //                     LoanApp.CalcFields(LoanApp."Outstanding Balance", LoanApp."Outstanding Interest", LoanApp."Outstanding Insurance", LoanApp."Outstanding Penalty");
    //                     if RunningBalance > 0 then begin
    //                         AmountToDeduct := 0;
    //                         if LoanApp."Outstanding Penalty" > 0 then begin
    //                             if LoanApp."Outstanding Penalty" < RunningBalance then begin
    //                                 AmountToDeduct := LoanApp."Outstanding Penalty"
    //                             end else
    //                                 AmountToDeduct := RunningBalance;

    //                             LineNo := LineNo + 10000;
    //                             SFactory.FnCreateGnlJournalLineGuarantorRecovery(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Insurance Paid",
    //                             GenJournalLine."account type"::None, VarMemberNo, VarPostingDate, AmountToDeduct * -1, 'BOSA', EXTERNAL_DOC_NO,
    //                             'Loan Recovered From_' + ObjLoanGuarantors."Member Name" + ObjLoanGuarantors."Guarantor Number", VarLoanNo, GenJournalLine."recovery transaction type"::"Guarantor Recoverd", VarLoanNo);

    //                             RunningBalance := RunningBalance - AmountToDeduct;
    //                             VarAmounttoDeduct := VarAmounttoDeduct + AmountToDeduct;
    //                         end;
    //                     end;
    //                 end;
    //             end;

    //             //============================================================Loan Interest Repayment
    //             if RunningBalance > 0 then begin
    //                 LoanApp.Reset;
    //                 LoanApp.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
    //                 //LoanApp.SETRANGE("BOSA No","Member No");
    //                 LoanApp.SetRange(LoanApp."Loan  No.", "Loan to Attach");
    //                 LoanApp.SetFilter(LoanApp."Date filter", Datefilter);
    //                 if LoanApp.Find('-') then begin
    //                     //REPEAT
    //                     LoanApp.CalcFields(LoanApp."Outstanding Balance", LoanApp."Outstanding Interest", LoanApp."Outstanding Insurance", LoanApp."Outstanding Penalty");
    //                     if RunningBalance > 0 then begin
    //                         AmountToDeduct := 0;
    //                         if LoanApp."Outstanding Interest" > 0 then begin
    //                             if LoanApp."Outstanding Interest" < RunningBalance then begin
    //                                 AmountToDeduct := LoanApp."Outstanding Interest"
    //                             end else
    //                                 AmountToDeduct := RunningBalance;

    //                             LineNo := LineNo + 10000;
    //                             SFactory.FnCreateGnlJournalLineGuarantorRecovery(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Interest Paid",
    //                             GenJournalLine."account type"::None, VarMemberNo, VarPostingDate, AmountToDeduct * -1, 'BOSA', EXTERNAL_DOC_NO,
    //                             'Loan Recovered From_' + ObjLoanGuarantors."Member Name" + ObjLoanGuarantors."Guarantor Number", VarLoanNo, GenJournalLine."recovery transaction type"::"Guarantor Recoverd", VarLoanNo);

    //                             RunningBalance := RunningBalance - AmountToDeduct;
    //                             VarAmounttoDeduct := VarAmounttoDeduct + AmountToDeduct;
    //                         end;
    //                     end;
    //                 end;
    //             end;






    //             //============================================================Loan Principle Repayment
    //             if RunningBalance > 0 then begin
    //                 LoanApp.Reset;
    //                 LoanApp.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
    //                 //LoanApp.SETRANGE("BOSA No","Member No");
    //                 LoanApp.SetRange(LoanApp."Loan  No.", "Loan to Attach");
    //                 LoanApp.SetFilter(LoanApp."Date filter", Datefilter);
    //                 if LoanApp.Find('-') then begin
    //                     LoanApp.CalcFields(LoanApp."Outstanding Balance", LoanApp."Outstanding Interest", LoanApp."Outstanding Insurance", LoanApp."Outstanding Penalty");
    //                     if RunningBalance > 0 then begin
    //                         AmountToDeduct := 0;
    //                         if LoanApp."Outstanding Balance" > 0 then begin
    //                             if LoanApp."Outstanding Balance" < RunningBalance then begin
    //                                 AmountToDeduct := LoanApp."Outstanding Balance"
    //                             end else
    //                                 AmountToDeduct := RunningBalance;

    //                             LineNo := LineNo + 10000;
    //                             SFactory.FnCreateGnlJournalLineGuarantorRecovery(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Repayment",
    //                             GenJournalLine."account type"::None, VarMemberNo, VarPostingDate, AmountToDeduct * -1, 'BOSA', EXTERNAL_DOC_NO,
    //                             'Loan Recovered From_' + ObjLoanGuarantors."Member Name" + ObjLoanGuarantors."Guarantor Number", VarLoanNo, GenJournalLine."recovery transaction type"::"Guarantor Recoverd", VarLoanNo);
    //                             RunningBalance := RunningBalance - AmountToDeduct;
    //                             VarAmounttoDeduct := VarAmounttoDeduct + AmountToDeduct;
    //                         end;
    //                     end;
    //                 end;
    //             end;


    //             LineNo := LineNo + 10000;
    //             SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Deposit Contribution",
    //             GenJournalLine."account type"::None, ObjLoanGuarantors."Guarantor Number", VarPostingDate, ObjLoanGuarantors."Guarantor Amount Apportioned", 'BOSA', EXTERNAL_DOC_NO,
    //             'Loan Recovery' + '-' + VarMemberNo + '-' + "Member Name", '', GenJournalLine."application source"::" ");

    //             //Post New
    //             GenJournalLine.Reset;
    //             GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
    //             GenJournalLine.SetRange("Journal Batch Name", 'RECOVERIES');
    //             if GenJournalLine.Find('-') then begin
    //                 Codeunit.Run(Codeunit::"Gen. Jnl.-Post Batch", GenJournalLine);
    //             end;

    //             if VarInsuranceAmounttoDeduct < ObjLoanGuarantors."Guarantor Amount Apportioned" then begin
    //                 "Insurance Fully Recovered" := true;
    //                 "Insurance Difference" := 0
    //             end else
    //                 "Insurance Difference" := VarInsuranceAmounttoDeduct - ObjLoanGuarantors."Guarantor Amount Apportioned";
    //         until ObjLoanGuarantors.Next = 0;
    //     end;

    //     Validate("Member No");
    // end;

    // local procedure FnRunShareCapitalSell()
    // var
    //     ObjShareCapSell: Record "Share Capital Sell";
    //     TemplateName: Code[30];
    //     BatchName: Code[30];
    //     SurestepFactory: Codeunit "SURESTEP Factory";
    //     Generalsetup: Record "Sacco General Set-Up";
    //     VarBuyerMemberNo: Code[50];
    // begin
    //     BATCH_TEMPLATE := 'GENERAL';
    //     BATCH_NAME := 'RECOVERIES';
    //     DOCUMENT_NO := "Document No";
    //     EXTERNAL_DOC_NO := "Loan to Attach";
    //     Datefilter := '..' + Format("Loan Disbursement Date");

    //     GenJournalLine.Reset;
    //     GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
    //     GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
    //     GenJournalLine.DeleteAll;

    //     //====================================================BOSA Transactions
    //     VarBuyerMemberNo := '';
    //     //Credit Buyer Account
    //     ObjShareCapSell.Reset;
    //     ObjShareCapSell.SetRange(ObjShareCapSell."Document No", "Document No");
    //     if ObjShareCapSell.FindSet then begin
    //         repeat
    //             LineNo := LineNo + 10000;
    //             SurestepFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, "Document No", LineNo, GenJournalLine."transaction type"::"Share Capital",
    //             GenJournalLine."account type"::Vendor, ObjShareCapSell."Buyer Share Capital Account", "Loan Disbursement Date",
    //             (ObjShareCapSell.Amount * -1), 'BOSA', "Document No", 'Share Capital Purchase From ' + "Member No", '', GenJournalLine."application source"::" ");
    //             VarBuyerMemberNo := VarBuyerMemberNo + ObjShareCapSell."Buyer Member No" + ', ';
    //         until ObjShareCapSell.Next = 0;
    //     end;

    //     if ObjCust.Get("Member No") then begin
    //         ObjCust.CalcFields(ObjCust."Shares Retained");
    //         if ObjCust."Shares Retained" < "Share Capital to Sell" then
    //             Error('The Share Capital Amount to Sell specified is more than the Available Member Share Capital Amount');

    //         LineNo := LineNo + 10000;
    //         //Debit Seller Account
    //         CalcFields("Share Capital to Sell");
    //         SurestepFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, "Document No", LineNo, GenJournalLine."transaction type"::"Share Capital",
    //         GenJournalLine."account type"::Vendor, ObjCust."Share Capital No", "Loan Disbursement Date",
    //         "Share Capital to Sell", 'BOSA', "Document No", 'Share Capital Sell to ' + VarBuyerMemberNo, '', GenJournalLine."application source"::" ");
    //     end;
    //     //===============================================End BOSA Transactions


    //     //==================================================FOSA Transaction
    //     //Debit Buyer FOSA Account
    //     ObjShareCapSell.Reset;
    //     ObjShareCapSell.SetRange(ObjShareCapSell."Document No", "Document No");
    //     if ObjShareCapSell.FindSet then begin
    //         repeat
    //             LineNo := LineNo + 10000;
    //             SurestepFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, "Document No", LineNo, GenJournalLine."transaction type"::" ",
    //             GenJournalLine."account type"::Vendor, ObjShareCapSell."Buyer FOSA Account", "Loan Disbursement Date",
    //             (ObjShareCapSell.Amount), 'FOSA', "Document No", 'Share Capital Purchase From ' + "Member No", '', GenJournalLine."application source"::" ");
    //         until ObjShareCapSell.Next = 0;
    //     end;

    //     LineNo := LineNo + 10000;
    //     //Credit Seller FOSA Account
    //     CalcFields("Share Capital to Sell");
    //     SurestepFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, "Document No", LineNo, GenJournalLine."transaction type"::" ",
    //     GenJournalLine."account type"::Vendor, "Share Capital Seller FOSA Acc", "Loan Disbursement Date",
    //         ("Share Capital to Sell" * -1), 'FOSA', "Document No", 'Share Capital Sell to ' + VarBuyerMemberNo, '', GenJournalLine."application source"::" ");
    //     //==================================================FOSA Transaction

    //     /*
    //     LineNo:=LineNo+10000;
    //     //Post Transfer Fee
    //     Generalsetup.GET();

    //     SurestepFactory.FnCreateGnlJournalLineBalanced(BATCH_TEMPLATE,BATCH_NAME,"Document No",LineNo,GenJournalLine."Transaction Type"::" ",GenJournalLine."Account Type"::Vendor,"Loan Settlement Account","Loan Disbursement Date"
    //     ,'Share Cap Sell Fee_'+FORMAT("Document No"),GenJournalLine."Bal. Account Type"::"G/L Account",Generalsetup."Share Capital Transfer Fee Acc",("Share Capital Transfer Fee"),'BOSA','');

    //     LineNo:=LineNo+10000;
    //     //Post Transfer Fee Excise Duty
    //     Generalsetup.GET();

    //     SurestepFactory.FnCreateGnlJournalLineBalanced(BATCH_TEMPLATE,BATCH_NAME,"Document No",LineNo,GenJournalLine."Transaction Type"::" ",GenJournalLine."Account Type"::Vendor,"Loan Settlement Account","Loan Disbursement Date"
    //     ,'Share Cap Sell Excise_'+FORMAT("Document No"),GenJournalLine."Bal. Account Type"::"G/L Account",Generalsetup."Excise Duty Account",("Share Capital Transfer Fee"*(Generalsetup."Excise Duty(%)"/100)),'BOSA','');
    //     //Post Transfer Fee Excise Duty
    //     */

    //     //Post New
    //     GenJournalLine.Reset;
    //     GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
    //     GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
    //     if GenJournalLine.Find('-') then begin
    //         Codeunit.Run(Codeunit::"Gen. Jnl.-Post Batch", GenJournalLine);
    //     end;
    //     Validate("Loan Settlement Account");

    // end;

    // local procedure FnRunPostAmountAllocatedtoLSA(VarDocumentNo: Code[30]; VarPostingDate: Date; VarLoanNo: Code[30])
    // var
    //     GuarantorName: Text[100];
    // begin
    //     ObjLoanGuarantors.Reset;
    //     ObjLoanGuarantors.SetRange("Document No", VarDocumentNo);
    //     if ObjLoanGuarantors.FindSet then begin
    //         repeat
    //             if ObjCust.Get(ObjLoanGuarantors."Guarantor Number") then begin
    //                 GuarantorName := ObjCust.Name;
    //             end;

    //             if ObjCust.Get(ObjLoanGuarantors."Guarantor Number") then begin

    //                 ObjCust.CalcFields(ObjCust."Current Shares");
    //                 if ObjCust."Current Shares" < ObjLoanGuarantors."Guarantor Amount Apportioned" then
    //                     Error('The Guarantor Amount Apportioned for Mno. %1 is more than the Available Member Deposits', ObjLoanGuarantors."Guarantor Number");

    //                 //--------------------------------(Credit LSA Account)-------------------------------------------------------------------------------
    //                 LineNo := LineNo + 10000;
    //                 SFactory.FnCreateGnlJournalLineGuarantorRecovery(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
    //                 GenJournalLine."account type"::Vendor, "Loan Settlement Account", VarPostingDate, ObjLoanGuarantors."Guarantor Amount Apportioned" * -1, 'BOSA', EXTERNAL_DOC_NO,
    //                 'Loan Recovered:' + GuarantorName + ' ' + ObjLoanGuarantors."Guarantor Number", VarLoanNo, GenJournalLine."recovery transaction type"::"Guarantor Recoverd", VarLoanNo);

    //                 //--------------------------------(Debit Guarantor Account)-------------------------------------------------------------------------------
    //                 LineNo := LineNo + 10000;
    //                 SFactory.FnCreateGnlJournalLineGuarantorRecovery(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Deposit Contribution",
    //                 GenJournalLine."account type"::Vendor, ObjCust."Deposits Account No", VarPostingDate, ObjLoanGuarantors."Guarantor Amount Apportioned", 'BOSA', EXTERNAL_DOC_NO,
    //                 'Loan Recovered:' + "Member Name" + ' ' + "Member No", VarLoanNo, GenJournalLine."recovery transaction type"::"Guarantor Recoverd", VarLoanNo);
    //             end;
    //         until ObjLoanGuarantors.Next = 0;
    //     end;

    //     //Post New
    //     GenJournalLine.Reset;
    //     GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
    //     GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
    //     if GenJournalLine.Find('-') then begin
    //         Codeunit.Run(Codeunit::"Gen. Jnl.-Post Batch", GenJournalLine);
    //     end;
    // end;

    // local procedure FnRunCreateRecoveryLedgerEntry(VarMemberNo: Code[30]; VarMemberName: Text[100]; VarPostingDate: Date)
    // var
    //     ObjGuarantorLedger: Record "Guarantor Recovery Ledger";
    //     EntryNo: Integer;
    //     VarGuarantorName: Text[100];
    // begin
    //     ObjLoanGuarantors.Reset;
    //     ObjLoanGuarantors.SetRange(ObjLoanGuarantors."Document No", "Document No");
    //     if ObjLoanGuarantors.FindSet then begin
    //         repeat

    //             if ObjCust.Get(ObjLoanGuarantors."Guarantor Number") then begin
    //                 VarGuarantorName := ObjCust.Name;
    //             end;
    //             ObjGuarantorLedger.Reset;
    //             if ObjGuarantorLedger.FindLast then begin
    //                 EntryNo := ObjGuarantorLedger."Entry No.";
    //             end;

    //             EntryNo := EntryNo + 1;

    //             CalcFields("Total Guarantor Allocation");
    //             ObjGuarantorLedger.Init;
    //             ObjGuarantorLedger."Entry No." := EntryNo;
    //             ObjGuarantorLedger."Defaulter Member No" := "Member No";
    //             ObjGuarantorLedger."Defaulter Name" := "Member Name";
    //             ObjGuarantorLedger."Posting Date" := "Loan Disbursement Date";
    //             ObjGuarantorLedger."Document No." := "Document No";
    //             ObjGuarantorLedger."Guarantor No" := ObjLoanGuarantors."Guarantor Number";
    //             ObjGuarantorLedger."Guarantor Name" := VarGuarantorName;
    //             ObjGuarantorLedger."Amount Allocated" := ObjLoanGuarantors."Guarantor Amount Apportioned";
    //             ObjGuarantorLedger.Insert;
    //         until ObjLoanGuarantors.Next = 0;
    //     end;
    // end;

    // local procedure FnRunPostMemberDepositstoLSA(VarDocumentNo: Code[30]; VarPostingDate: Date; VarLoanNo: Code[30])
    // var
    //     GuarantorName: Text[100];
    //     VarAmounttoRecover: Decimal;
    // begin
    //     if ObjCust.Get("Member No") then begin
    //         ObjCust.CalcFields(ObjCust."Current Shares");
    //         if ObjCust."Current Shares" < "Deposits Recovered Amount" then
    //             Error('The Deposits Recovered Amount specified is more than the Available Member Deposits');

    //         //--------------------------------(Credit LSA Account)-------------------------------------------------------------------------------
    //         LineNo := LineNo + 10000;
    //         SFactory.FnCreateGnlJournalLineGuarantorRecovery(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
    //         GenJournalLine."account type"::Vendor, "Loan Settlement Account", VarPostingDate, "Deposits Recovered Amount" * -1, 'BOSA', EXTERNAL_DOC_NO,
    //         'Loan Recovered: ' + "Member Name" + ' - ' + VarLoanNo, VarLoanNo, GenJournalLine."recovery transaction type"::"Guarantor Recoverd", VarLoanNo);

    //         //--------------------------------(Debit Guarantor Account)-------------------------------------------------------------------------------
    //         LineNo := LineNo + 10000;
    //         SFactory.FnCreateGnlJournalLineGuarantorRecovery(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Deposit Contribution",
    //         GenJournalLine."account type"::Vendor, ObjCust."Deposits Account No", VarPostingDate, "Deposits Recovered Amount", 'BOSA', EXTERNAL_DOC_NO,
    //         'Loan Recovered: ' + "Member Name" + ' - ' + VarLoanNo, VarLoanNo, GenJournalLine."recovery transaction type"::"Guarantor Recoverd", VarLoanNo);


    //         //Post New
    //         GenJournalLine.Reset;
    //         GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
    //         GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
    //         if GenJournalLine.Find('-') then begin
    //             Codeunit.Run(Codeunit::"Gen. Jnl.-Post Batch", GenJournalLine);
    //         end;
    //     end;
    // end;

    // local procedure FnRunCreateBOSAAccountRefundLedgerEntry(VarMemberNo: Code[30]; VarMemberName: Text[100]; VarPostingDate: Date)
    // var
    //     ObjBOSARefundLedger: Record "BOSA Account Refund Ledger";
    //     EntryNo: Integer;
    //     VarGuarantorName: Text[100];
    //     ObjMember: Record Customer;
    // begin
    //     if ObjMember.Get("Member No") then begin
    //         if "Refund  BOSA Deposit" = true then begin
    //             ObjBOSARefundLedger.Reset;
    //             if ObjBOSARefundLedger.FindLast then begin
    //                 EntryNo := ObjBOSARefundLedger."Entry No.";
    //             end;

    //             EntryNo := EntryNo + 1;

    //             ObjBOSARefundLedger.Init;
    //             ObjBOSARefundLedger."Entry No." := EntryNo;
    //             ObjBOSARefundLedger."Account No Recovered" := ObjMember."Deposits Account No";
    //             ObjBOSARefundLedger."Account Name" := "Member Name";
    //             ObjBOSARefundLedger."Posting Date" := "Loan Disbursement Date";
    //             ObjBOSARefundLedger."Document No." := "Document No";
    //             ObjBOSARefundLedger."Member No" := "Member No";
    //             ObjBOSARefundLedger."Member Name" := "Member Name";
    //             ObjBOSARefundLedger."Amount Deducted" := "Deposits Recovered Amount";
    //             ObjBOSARefundLedger.Insert;
    //         end;
    //     end;
    // end;
}

