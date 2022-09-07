#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50490 "Salary Processing Header"
{
    PageType = Card;
    SourceTable = "Salary Processing Headerr";

    layout
    {
        area(content)
        {
            group(General)
            {
                field(No; No)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Entered By"; "Entered By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Date Entered"; "Date Entered")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Transaction Type"; "Transaction Type")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Description"; "Transaction Description")
                {
                    ApplicationArea = Basic;
                }
                field("Posting date"; "Posting date")
                {
                    ApplicationArea = Basic;
                }
                field("Document No"; "Document No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Exempt Loan Repayment"; "Exempt Loan Repayment")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Remarks; Remarks)
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Total Count"; "Total Count")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                    Style = Strong;
                    StyleExpr = true;
                }
                field("Posted By"; "Posted By")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Account Type"; "Account Type")
                {
                    ApplicationArea = Basic;
                }
                field("Account No"; "Account No")
                {
                    ApplicationArea = Basic;
                }
                field("Balancing Account Balance"; "Balancing Account Balance")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Cheque No."; "Cheque No.")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field(Posted; Posted)
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Amount; Amount)
                {
                    ApplicationArea = Basic;
                }
                field("Scheduled Amount"; "Scheduled Amount")
                {
                    ApplicationArea = Basic;
                    Style = Strong;
                    StyleExpr = true;
                }
                field("Employer Code"; "Employer Code")
                {
                    ApplicationArea = Basic;
                }
                field(Discard; Discard)
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Pre-Post Blocked Status Update"; "Pre-Post Blocked Status Update")
                {
                    ApplicationArea = Basic;
                    Caption = 'Pre-Post Blocked Status Updated';
                    Editable = false;
                    Visible = false;
                }
                field("Post-Post Blocked Statu Update"; "Post-Post Blocked Statu Update")
                {
                    ApplicationArea = Basic;
                    Caption = 'Post-Post Blocked Status Updated';
                    Editable = false;
                    Visible = false;
                }
                field(Status; Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            part("50000"; "Salary Processing Lines")
            {
                Caption = 'Salary Processing Lines';
                Enabled = false;
                SubPageLink = "Salary Header No." = field(No);
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(ActionGroup1102755021)
            {
                action("Clear Lines")
                {
                    ApplicationArea = Basic;
                    Enabled = not ActionEnabled;
                    Image = CheckList;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        if Confirm('This Action will clear all the Lines for the current Salary Document. Do you want to Continue') = false then
                            exit;
                        salarybuffer.Reset;
                        salarybuffer.SetRange(salarybuffer."Salary Header No.", No);
                        salarybuffer.DeleteAll;

                        BATCH_TEMPLATE := 'GENERAL';
                        BATCH_NAME := 'SALARIES';

                        DOCUMENT_NO := Remarks;
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                        GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                        GenJournalLine.DeleteAll;
                    end;
                }
                action("Import Salaries")
                {
                    ApplicationArea = Basic;
                    Enabled = not ActionEnabled;
                    Image = Import;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    RunObject = XMLport "Import Salaries";
                }
                action("Validate Data")
                {
                    ApplicationArea = Basic;
                    Enabled = not ActionEnabled;
                    Image = ViewCheck;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        TestField(No);
                        TestField("Document No");
                        salarybuffer.Reset;
                        salarybuffer.SetRange("Salary Header No.", No);
                        if salarybuffer.Find('-') then begin
                            repeat
                                salarybuffer."Account Name" := '';
                                salarybuffer.Modify;
                            until salarybuffer.Next = 0;
                        end;
                        salarybuffer.Reset;
                        salarybuffer.SetRange("Salary Header No.", No);
                        if salarybuffer.Find('-') then begin
                            repeat
                                ObjVendor.Reset;
                                ObjVendor.SetRange("No.", salarybuffer."Account No.");
                                if ObjVendor.Find('-') then
                                    salarybuffer."Account Name" := ObjVendor.Name;
                                salarybuffer."Mobile Phone Number" := ObjVendor."Phone No.";
                                salarybuffer."Member No" := ObjVendor."BOSA Account No";
                                salarybuffer.Modify;
                            until salarybuffer.Next = 0;
                        end;
                        Message('Validation completed successfully.');
                    end;
                }
                action("Process Salaries")
                {
                    ApplicationArea = Basic;
                    Enabled = EnableProcessing;
                    Image = Apply;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        if Confirm('Are you sure you want to Transfer this Salary to Journals ?') = false then
                            exit;

                        CalcFields("Scheduled Amount");
                        //Message('%1', "Account No");
                        VarAvailableBal := SFactory.FnRunGetAccountAvailableBalance("Account No");

                        // if ("Scheduled Amount" > VarAvailableBal) and ("Account Type" <> "account type"::"G/L Account") then
                        //     Error('Scheduled Salary is more than the available balance');

                        TestField("Document No");
                        TestField(Amount);
                        TestField("Cheque No.");
                        TestField("Transaction Description");
                        Datefilter := '..' + Format("Posting date");
                        if Amount <> "Scheduled Amount" then
                            Error('Scheduled Amount must be equal to the Cheque Amount');

                        BATCH_TEMPLATE := 'GENERAL';
                        BATCH_NAME := 'SALARIES';
                        DOCUMENT_NO := "Document No";
                        EXTERNAL_DOC_NO := "Cheque No.";
                        SMSCODE := '';
                        Counter := 0;

                        FnSalaryProcessing();
                    end;
                }
                action("Mark as Posted")
                {
                    ApplicationArea = Basic;
                    Enabled = ActionEnabled;
                    Image = PostBatch;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        if Confirm('Are you sure you want to mark this process as Complete ?') = false then
                            exit;
                        TestField("Document No");
                        TestField(Amount);
                        salarybuffer.Reset;
                        salarybuffer.SetRange("Salary Header No.", No);
                        if salarybuffer.Find('-') then begin
                            Window.Open('Sending SMS to Members: @1@@@@@@@@@@@@@@@' + 'Record:#2###############');
                            TotalCount := salarybuffer.Count;
                            repeat
                                salarybuffer.CalcFields(salarybuffer."Mobile Phone Number");
                                Percentage := (ROUND(Counter / TotalCount * 10000, 1));
                                Counter := Counter + 1;
                                Window.Update(1, Percentage);
                                Window.Update(2, Counter);
                                if "Transaction Type" = "transaction type"::Salary then
                                    SFactory.FnSendSMS('SALARIES', 'Your Salary has been processed at Vision Sacco.', salarybuffer."Account No.", salarybuffer."Mobile Phone Number")
                                else
                                    SFactory.FnSendSMS('SALARIES', 'Your Instant savings has been processed at Vision Sacco. Dial', salarybuffer."Account No.", salarybuffer."Mobile Phone Number");
                                if ObjVendor.Get(salarybuffer."Account No.") then begin
                                    if ObjVendor."Salary Processing" = false then begin
                                        ObjVendor."Salary Processing" := true;
                                        ObjVendor.Modify;
                                    end
                                end
                            until salarybuffer.Next = 0;
                        end;
                        Posted := true;
                        "Posted By" := UserId;
                        Message('Process Completed Successfully. Account Holders will receive Salary processing notification via SMS');
                        Window.Close;
                    end;
                }
                action(Journals)
                {
                    ApplicationArea = Basic;
                    Caption = 'General Journal';
                    Image = Journals;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedOnly = true;
                    RunObject = Page "General Journal";
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
                        if workflowintegration.CheckSalaryProcessingApprovalsWorkflowEnabled(Rec) then
                            workflowintegration.OnSendSalaryProcessingForApproval(Rec);

                        /*SalHeader.RESET;
                        SalHeader.SETRANGE(SalHeader.No,No);
                        IF SalHeader.FINDSET THEN
                        BEGIN
                          SalHeader.Status:=SalHeader.Status::Approved;
                          SalHeader.MODIFY;
                        END;*/

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
                            workflowintegration.OnCancelSalaryProcessingApprovalRequest(Rec);

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
                        DocumentType := Documenttype::SalaryProcessing;
                        ApprovalEntries.Setfilters(Database::"Salary Processing Headerr", DocumentType, No);
                        ApprovalEntries.Run;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        /*ObjVendorLedger.RESET;
        ObjVendorLedger.SETRANGE(ObjVendorLedger."Document No.","Document No");
        ObjVendorLedger.SETRANGE("External Document No.","Cheque No.");
        IF ObjVendorLedger.FIND('-') THEN
        ActionEnabled:=TRUE;
        */


        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RecordId);
        EnabledApprovalWorkflowsExist := true;

        if Rec.Status = Status::Approved then begin
            OpenApprovalEntriesExist := false;
            CanCancelApprovalForRecord := false;
            EnabledApprovalWorkflowsExist := false;
        end;

        if (Rec.Status = Status::Approved) and (Posted = false) then
            EnableProcessing := true;

    end;

    var
        Gnljnline: Record "Gen. Journal Line";
        PDate: Date;
        DocNo: Code[20];
        RunBal: Decimal;
        ReceiptsProcessingLines: Record "Checkoff Lines-Distributed";
        LineNo: Integer;
        LBatches: Record "Loan Disburesment-Batching";
        Jtemplate: Code[30];
        JBatch: Code[30];
        "Cheque No.": Code[20];
        DActivityBOSA: Code[20];
        DBranchBOSA: Code[20];
        ReptProcHeader: Record "Checkoff Header-Distributed";
        Cust: Record Customer;
        salarybuffer: Record "Salary Processing Lines";
        SalHeader: Record "Salary Processing Headerr";
        Sto: Record "Standing Orders";
        ELoanBuffer: Record "E-Loan Salary Buffer";
        ObjVendor: Record Vendor;
        MembLedg: Record "Cust. Ledger Entry";
        SFactory: Codeunit "SURESTEP Factory";
        BATCH_NAME: Code[50];
        BATCH_TEMPLATE: Code[50];
        DOCUMENT_NO: Code[40];
        GenJournalLine: Record "Gen. Journal Line";
        ActionEnabled: Boolean;
        ObjVendorLedger: Record "Vendor Ledger Entry";
        ObjGenSetup: Record "Sacco General Set-Up";
        Charges: Record Charges;
        SalProcessingFee: Decimal;
        LoanApp: Record "Loans Register";
        Datefilter: Text;
        DedStatus: Option Successfull,"Partial Deduction",Failed;
        ObjSTORegister: Record "Standing Order Register";
        ObjLoanProducts: Record "Loan Products Setup";
        Window: Dialog;
        TotalCount: Integer;
        Counter: Integer;
        Percentage: Integer;
        EXTERNAL_DOC_NO: Code[40];
        SMSCODE: Code[30];
        VarAvailableBal: Decimal;
        VarCreditDescription: Text[250];
        VarMemberName: Text;
        ObjSalaryProcessingLines: Record "Salary Processing Lines";
        OpenApprovalEntriesExist: Boolean;
        EnabledApprovalWorkflowsExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery,ChangeRequest,TreasuryTransactions,FundsTransfer,SaccoTransfers,ChequeDiscounting,ImprestRequisition,ImprestSurrender,LeaveApplication,BulkWithdrawal,PackageLodging,PackageRetrieval,HouseChange,CRMTraining,PettyCash,StaffClaims,MemberAgentNOKChange,HouseRegistration,LoanPayOff,FixedDeposit,RTGS,DemandNotice,OverDraft,LoanRestructure,SweepingInstructions,ChequeBookApplication,LoanTrunchDisbursement,InwardChequeClearing,InValidPaybillTransactions,InternalPV,SalaryProcessing;
        EnableProcessing: Boolean;
        workflowintegration: Codeunit WorkflowIntegration;

    local procedure FnPostSalaryToFosa(ObjSalaryLines: Record "Salary Processing Lines"; RunningBalance: Decimal; VarCreditDescription: Text[250]): Decimal
    var
        AmountToDeduct: Decimal;
    begin
        LineNo := LineNo + 10000;
        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
        GenJournalLine."account type"::Vendor, ObjSalaryLines."Account No.", "Posting date", ObjSalaryLines.Amount * -1, 'FOSA',
        EXTERNAL_DOC_NO, VarCreditDescription, '', GenJournalLine."application source"::" ");
        exit(RunningBalance);
    end;

    local procedure FnRecoverStatutories(ObjSalaryLines: Record "Salary Processing Lines"; RunningBalance: Decimal): Decimal
    var
        AmountToDeduct: Decimal;
    begin
        ObjGenSetup.Get();
        if Charges.Get('SALARYP') then begin
            //---------EARN-------------------------
            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
            GenJournalLine."account type"::"G/L Account", Charges."GL Account", "Posting date", Charges."Charge Amount" * -1, 'FOSA', EXTERNAL_DOC_NO,
            "Transaction Description" + ' Fee', '', GenJournalLine."application source"::" ");
            //-----------RECOVER--------------------
            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
            GenJournalLine."account type"::Vendor, ObjSalaryLines."Account No.", "Posting date", Charges."Charge Amount", 'FOSA', EXTERNAL_DOC_NO,
            'Processing Fee', '', GenJournalLine."application source"::" ");
            SalProcessingFee := Charges."Charge Amount";
            RunningBalance := RunningBalance - SalProcessingFee;
            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
            GenJournalLine."account type"::"G/L Account", ObjGenSetup."Excise Duty Account", "Posting date", SalProcessingFee * -0.1, 'FOSA', EXTERNAL_DOC_NO,
            "Transaction Description", '', GenJournalLine."application source"::" ");
            //--------------RECOVER------------------
            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
            GenJournalLine."account type"::Vendor, ObjSalaryLines."Account No.", "Posting date", SalProcessingFee * 0.1, 'FOSA', EXTERNAL_DOC_NO,
            '10% Excise Duty on ' + "Transaction Description", '', GenJournalLine."application source"::" ");
            RunningBalance := RunningBalance - SalProcessingFee * 0.1;
        end;

        if Charges.Get(SMSCODE) then begin
            //--------------EARN----------------------
            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
            GenJournalLine."account type"::"G/L Account", Charges."GL Account", "Posting date", Charges."Charge Amount" * -1, 'FOSA', EXTERNAL_DOC_NO,
            "Transaction Description", '', GenJournalLine."application source"::" ");
            //--------------RECOVER------------------
            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
            GenJournalLine."account type"::Vendor, ObjSalaryLines."Account No.", "Posting date", Charges."Charge Amount", 'FOSA', EXTERNAL_DOC_NO,
            Charges.Description, '', GenJournalLine."application source"::" ");
            RunningBalance := RunningBalance - Charges."Charge Amount";
        end;
        exit(RunningBalance);
    end;

    local procedure FnRecoverMobileLoanInterest(ObjRcptBuffer: Record "Salary Processing Lines"; RunningBalance: Decimal): Decimal
    var
        AmountToDeduct: Decimal;
    begin
        if RunningBalance > 0 then begin
            LoanApp.Reset;
            LoanApp.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
            LoanApp.SetRange(LoanApp."Client Code", ObjRcptBuffer."Account No.");
            LoanApp.SetFilter(LoanApp."Date filter", Datefilter);
            LoanApp.SetFilter(Source, Format(LoanApp.Source::FOSA));
            LoanApp.SetFilter("Loan Product Type", 'MSADV');
            if LoanApp.Find('-') then begin
                repeat
                    //LoanApp.CALCFIELDS(LoanApp."Outstanding Interest");
                    if (SFactory.FnGetInterestDueFiltered(LoanApp, Datefilter) - Abs(LoanApp."Outstanding Interest")) > 0 then begin
                        if RunningBalance > 0 then begin
                            AmountToDeduct := 0;
                            AmountToDeduct := SFactory.FnGetInterestDueFiltered(LoanApp, Datefilter) - Abs(LoanApp."Outstanding Interest");
                            if RunningBalance <= AmountToDeduct then
                                AmountToDeduct := RunningBalance;
                            //-------------PAY----------------------------
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Interest Paid",
                            GenJournalLine."account type"::Customer, ObjRcptBuffer."Account No.", "Posting date", AmountToDeduct * -1, 'FOSA', EXTERNAL_DOC_NO,
                            Format(GenJournalLine."transaction type"::"Interest Paid"), LoanApp."Loan  No.", GenJournalLine."application source"::" ");
                            //-------------RECOVER------------------------
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                            GenJournalLine."account type"::Vendor, ObjRcptBuffer."Account No.", "Posting date", AmountToDeduct, 'FOSA', LoanApp."Loan  No.",
                            Format(GenJournalLine."transaction type"::"Interest Paid") + '-' + LoanApp."Loan Product Type", LoanApp."Loan  No.", GenJournalLine."application source"::" ");

                            RunningBalance := RunningBalance - AmountToDeduct;
                        end;
                    end;
                until LoanApp.Next = 0;
            end;
            exit(RunningBalance);
        end;
    end;

    local procedure FnRecoverMobileLoanPrincipal(ObjRcptBuffer: Record "Salary Processing Lines"; RunningBalance: Decimal): Decimal
    var
        AmountToDeduct: Decimal;
        varLRepayment: Decimal;
    begin
        if RunningBalance > 0 then begin
            LoanApp.Reset;
            LoanApp.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
            LoanApp.SetRange(LoanApp."Client Code", ObjRcptBuffer."Account No.");
            LoanApp.SetFilter(LoanApp."Date filter", Datefilter);
            LoanApp.SetFilter(Source, Format(LoanApp.Source::FOSA));
            LoanApp.SetFilter("Loan Product Type", 'MSADV');
            LoanApp.SetFilter(Posted, 'Yes');
            if LoanApp.Find('-') then
                if RunningBalance > 0 then begin
                    LoanApp.CalcFields(LoanApp."Outstanding Balance");
                    if LoanApp."Outstanding Balance" > 0 then begin
                        varLRepayment := 0;
                        varLRepayment := LoanApp."Loan Principle Repayment";
                        if LoanApp."Loan Product Type" = 'GUR' then
                            varLRepayment := LoanApp.Repayment;
                        if varLRepayment > 0 then begin
                            if varLRepayment > LoanApp."Outstanding Balance" then
                                varLRepayment := LoanApp."Outstanding Balance";

                            if RunningBalance > 0 then begin
                                if RunningBalance > varLRepayment then begin
                                    AmountToDeduct := varLRepayment;
                                end
                                else
                                    AmountToDeduct := RunningBalance;
                            end;
                            //---------------------PAY-------------------------------
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Repayment",
                            GenJournalLine."account type"::Customer, ObjRcptBuffer."Account No.", "Posting date", AmountToDeduct * -1, 'FOSA', EXTERNAL_DOC_NO,
                            Format(GenJournalLine."transaction type"::"Loan Repayment"), LoanApp."Loan  No.", GenJournalLine."application source"::" ");
                            //--------------------RECOVER-----------------------------
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                            GenJournalLine."account type"::Vendor, ObjRcptBuffer."Account No.", "Posting date", AmountToDeduct, 'FOSA', LoanApp."Loan  No.",
                            Format(GenJournalLine."transaction type"::"Loan Repayment") + '-' + LoanApp."Loan Product Type", LoanApp."Loan  No.", GenJournalLine."application source"::" ");
                            RunningBalance := RunningBalance - AmountToDeduct;
                        end;
                    end;
                end;
            exit(RunningBalance);
        end;
    end;

    local procedure FnRunInterest(ObjRcptBuffer: Record "Salary Processing Lines"; RunningBalance: Decimal): Decimal
    var
        AmountToDeduct: Decimal;
        ObjReceiptTransactions: Record "Receipt Allocation";
    begin
        if RunningBalance > 0 then begin
            LoanApp.Reset;
            LoanApp.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
            LoanApp.SetRange(LoanApp."Client Code", ObjRcptBuffer."Account No.");
            LoanApp.SetFilter(LoanApp."Date filter", Datefilter);
            LoanApp.SetFilter(Source, Format(LoanApp.Source::FOSA));
            LoanApp.SetRange(LoanApp."Recovery Mode", LoanApp."recovery mode"::Salary);
            if LoanApp.Find('-') then begin
                repeat
                    if ObjLoanProducts.Get(LoanApp."Loan Product Type") then begin
                        if ObjLoanProducts."Recovery Method" = ObjLoanProducts."recovery method"::"Salary " then begin
                            //LoanApp.CALCFIELDS(LoanApp."Outstanding Interest");
                            if (SFactory.FnGetOutstandingInterest(LoanApp."Loan  No.")) > 0 then begin
                                if RunningBalance > 0 then begin
                                    AmountToDeduct := 0;
                                    AmountToDeduct := SFactory.FnGetOutstandingInterest(LoanApp."Loan  No.");
                                    if RunningBalance <= AmountToDeduct then
                                        AmountToDeduct := RunningBalance;
                                    LineNo := LineNo + 10000;
                                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Interest Paid",
                                    GenJournalLine."account type"::None, ObjRcptBuffer."Account No.", "Posting date", AmountToDeduct * -1, Format(LoanApp.Source), EXTERNAL_DOC_NO,
                                    Format(GenJournalLine."transaction type"::"Interest Paid"), LoanApp."Loan  No.", GenJournalLine."application source"::" ");

                                    LineNo := LineNo + 10000;
                                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                                    GenJournalLine."account type"::Vendor, ObjRcptBuffer."Account No.", "Posting date", AmountToDeduct, Format(LoanApp.Source), LoanApp."Loan  No.",
                                    Format(GenJournalLine."transaction type"::"Interest Paid") + '-' + LoanApp."Loan Product Type", LoanApp."Loan  No.", GenJournalLine."application source"::" ");
                                    RunningBalance := RunningBalance - AmountToDeduct;
                                end;
                            end;
                        end;
                    end;
                until LoanApp.Next = 0;
            end;
            exit(RunningBalance);
        end;
    end;

    local procedure FnRunPrinciple(ObjRcptBuffer: Record "Salary Processing Lines"; RunningBalance: Decimal): Decimal
    var
        AmountToDeduct: Decimal;
        ObjReceiptTransactions: Record "Receipt Allocation";
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayment: Decimal;
        PRpayment: Decimal;
    begin
        if RunningBalance > 0 then begin
            varTotalRepay := 0;
            varMultipleLoan := 0;
            LoanApp.Reset;
            LoanApp.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
            LoanApp.SetRange(LoanApp."Client Code", ObjRcptBuffer."Account No.");
            LoanApp.SetFilter(LoanApp."Date filter", Datefilter);
            LoanApp.SetFilter(Source, Format(LoanApp.Source::FOSA));
            LoanApp.SetRange(LoanApp."Recovery Mode", LoanApp."recovery mode"::Salary);
            if LoanApp.Find('-') then begin
                repeat
                    if ObjLoanProducts.Get(LoanApp."Loan Product Type") then begin
                        if ObjLoanProducts."Recovery Method" = ObjLoanProducts."recovery method"::"Salary " then begin
                            if RunningBalance > 0 then begin
                                LoanApp.CalcFields(LoanApp."Outstanding Balance");
                                if LoanApp."Outstanding Balance" > 0 then begin
                                    varLRepayment := 0;
                                    PRpayment := 0;
                                    varLRepayment := LoanApp."Loan Principle Repayment";
                                    if LoanApp."Loan Product Type" = 'GUR' then
                                        varLRepayment := LoanApp.Repayment;
                                    if varLRepayment > 0 then begin
                                        if varLRepayment > LoanApp."Outstanding Balance" then
                                            varLRepayment := LoanApp."Outstanding Balance";

                                        if RunningBalance > 0 then begin
                                            if RunningBalance > varLRepayment then begin
                                                AmountToDeduct := varLRepayment;
                                            end
                                            else
                                                AmountToDeduct := RunningBalance;
                                        end;
                                        //-------------PAY------------------
                                        LineNo := LineNo + 10000;
                                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Repayment",
                                        GenJournalLine."account type"::None, ObjRcptBuffer."Member No", "Posting date", AmountToDeduct * -1, Format(LoanApp.Source), EXTERNAL_DOC_NO,
                                        Format(GenJournalLine."transaction type"::"Loan Repayment"), LoanApp."Loan  No.", GenJournalLine."application source"::" ");
                                        //-------------RECOVER---------------
                                        LineNo := LineNo + 10000;
                                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                                        GenJournalLine."account type"::Vendor, ObjRcptBuffer."Account No.", "Posting date", AmountToDeduct, Format(LoanApp.Source), LoanApp."Loan  No.",
                                        Format(GenJournalLine."transaction type"::"Loan Repayment") + '-' + LoanApp."Loan Product Type", LoanApp."Loan  No.", GenJournalLine."application source"::" ");
                                        RunningBalance := RunningBalance - AmountToDeduct;
                                    end;
                                end;
                            end;
                        end;
                    end;
                until LoanApp.Next = 0;
            end;
            exit(RunningBalance);
        end;
    end;

    local procedure FnRunStandingOrders(ObjRcptBuffer: Record "Salary Processing Lines"; RunningBalance: Decimal): Decimal
    var
        AmountToDeduct: Decimal;
        ObjReceiptTransactions: Record "Receipt Allocation";
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayment: Decimal;
        PRpayment: Decimal;
        ObjStandingOrders: Record "Standing Orders";
    begin
        if RunningBalance > 0 then begin
            varTotalRepay := 0;
            varMultipleLoan := 0;
            ObjStandingOrders.Reset;
            ObjStandingOrders.SetCurrentkey("No.", "Source Account No.");
            ObjStandingOrders.SetRange("Source Account No.", ObjRcptBuffer."Account No.");
            ObjStandingOrders.SetRange(Status, ObjStandingOrders.Status::Approved);
            ObjStandingOrders.SetRange("Is Active", true);
            ObjStandingOrders.SetRange("Standing Order Dedution Type", ObjStandingOrders."standing order dedution type"::Salary);
            if ObjStandingOrders.Find('-') then begin
                repeat
                    if RunningBalance > 0 then begin
                        if ObjStandingOrders."Next Run Date" = 0D then
                            ObjStandingOrders."Next Run Date" := ObjStandingOrders."Effective/Start Date";

                        //ObjStandingOrders.CALCFIELDS("Allocated Amount");
                        if RunningBalance >= ObjStandingOrders.Amount then begin
                            AmountToDeduct := ObjStandingOrders.Amount;
                            DedStatus := Dedstatus::Successfull;
                            if AmountToDeduct >= ObjStandingOrders.Balance then begin
                                AmountToDeduct := ObjStandingOrders.Balance;
                                ObjStandingOrders.Balance := 0;
                                ObjStandingOrders."Next Run Date" := CalcDate(ObjStandingOrders.Frequency, ObjStandingOrders."Next Run Date");
                                ObjStandingOrders.Unsuccessfull := false;
                            end
                            else begin
                                ObjStandingOrders.Balance := ObjStandingOrders.Balance - AmountToDeduct;
                                ObjStandingOrders.Unsuccessfull := true;
                            end;
                        end
                        else begin
                            if ObjStandingOrders."Don't Allow Partial Deduction" = true then begin
                                AmountToDeduct := 0;
                                DedStatus := Dedstatus::Failed;
                                ObjStandingOrders.Balance := ObjStandingOrders.Amount;
                                ObjStandingOrders.Unsuccessfull := true;
                            end
                            else begin
                                DedStatus := Dedstatus::"Partial Deduction";
                                ObjStandingOrders.Balance := ObjStandingOrders.Amount - AmountToDeduct;
                                ObjStandingOrders.Unsuccessfull := true;
                            end;
                        end;



                        if ObjStandingOrders."Destination Account Type" <> ObjStandingOrders."destination account type"::"Other Banks Account" then
                            RunningBalance := FnNonBosaStandingOrderTransaction(ObjStandingOrders, RunningBalance)
                        else begin
                            RunningBalance := FnBosaStandingOrderTransaction(ObjStandingOrders, RunningBalance)
                        end;


                        ObjStandingOrders.Effected := true;
                        ObjStandingOrders."Date Reset" := Today;
                        ObjStandingOrders."Next Run Date" := CalcDate('-1D', CalcDate('1M', Dmy2date(1, Date2dmy(CalcDate(ObjStandingOrders.Frequency, Today), 2), Date2dmy(CalcDate(ObjStandingOrders.Frequency, Today), 3))));
                        ObjStandingOrders.Modify;

                        FnRegisterProcessedStandingOrder(ObjStandingOrders, AmountToDeduct);
                    end;
                until ObjStandingOrders.Next = 0;
            end;
            exit(RunningBalance);
        end;
    end;

    local procedure FnCheckIfStandingOrderIsRunnable(ObjStandingOrders: Record "Standing Orders") DontEffect: Boolean
    begin
        DontEffect := false;

        if ObjStandingOrders."Effective/Start Date" <> 0D then begin
            if ObjStandingOrders."Effective/Start Date" > Today then begin
                if Date2dmy(Today, 2) <> Date2dmy(ObjStandingOrders."Effective/Start Date", 2) then
                    DontEffect := true;
            end;
        end;
        exit(DontEffect);
    end;

    local procedure FnNonBosaStandingOrderTransaction(ObjRcptBuffer: Record "Standing Orders"; RunningBalance: Decimal): Decimal
    var
        AmountToDeduct: Decimal;
        ObjReceiptTransactions: Record "Receipt Allocation";
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayment: Decimal;
        PRpayment: Decimal;
        ObjStandingOrders: Record "Standing Orders";
    begin
        if RunningBalance > 0 then begin
            //-------------RECOVER-----------------------
            if ObjVendor.Get(ObjRcptBuffer."Destination Account No.") then begin
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                GenJournalLine."account type"::Vendor, ObjRcptBuffer."Source Account No.", "Posting date", ObjRcptBuffer.Amount, 'FOSA', ObjRcptBuffer."No.",
                'Standing Order to ' + ObjVendor."Account Type", '', GenJournalLine."application source"::" ");
            end;
            //-------------PAY----------------------------
            if ObjVendor.Get(ObjRcptBuffer."Source Account No.") then begin
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                GenJournalLine."account type"::Vendor, ObjRcptBuffer."Destination Account No.", "Posting date", ObjRcptBuffer.Amount * -1, 'FOSA', ObjRcptBuffer."No.",
                'Standing Order From ' + ObjVendor."Account Type", '', GenJournalLine."application source"::" ");
                RunningBalance := RunningBalance - ObjRcptBuffer.Amount;
            end;

            exit(RunningBalance);
        end;
    end;

    local procedure FnBosaStandingOrderTransaction(ObjRcptBuffer: Record "Standing Orders"; RunningBalance: Decimal): Decimal
    var
        AmountToDeduct: Decimal;
        ObjReceiptTransactions: Record "Receipt Allocation";
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayment: Decimal;
        PRpayment: Decimal;
        ObjStandingOrders: Record "Standing Orders";
    begin
        if RunningBalance > 0 then begin
            ObjReceiptTransactions.Reset;
            ObjReceiptTransactions.SetRange("Document No", ObjRcptBuffer."No.");
            if ObjReceiptTransactions.Find('-') then begin
                //ObjReceiptTransactions.CALCFIELDS("Interest Amount");
                repeat
                    if ObjReceiptTransactions."Transaction Type" = ObjReceiptTransactions."transaction type"::"Loan Repayment" then begin
                        //-------------RECOVER principal-----------------------
                        if LoanApp.Get(ObjReceiptTransactions."Loan No.") then begin
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Repayment",
                            GenJournalLine."account type"::Customer, LoanApp."Client Code", "Posting date", (ObjReceiptTransactions.Amount - ObjReceiptTransactions."Interest Amount") * -1,
                            'FOSA', ObjRcptBuffer."No.", Format(GenJournalLine."transaction type"::"Loan Repayment"), ObjReceiptTransactions."Loan No.", GenJournalLine."application source"::" ");

                            //-------------PAY Principal----------------------------
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                            GenJournalLine."account type"::Vendor, ObjRcptBuffer."Source Account No.", "Posting date",
                            ObjReceiptTransactions.Amount - ObjReceiptTransactions."Interest Amount", 'FOSA', ObjRcptBuffer."No.",
                            Format(GenJournalLine."transaction type"::"Loan Repayment") + '-' + ObjReceiptTransactions."Loan Product Name", '', GenJournalLine."application source"::" ");

                            RunningBalance := RunningBalance - (ObjReceiptTransactions.Amount - ObjReceiptTransactions."Interest Amount");

                            //-------------RECOVER Interest-----------------------
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Interest Paid",
                            GenJournalLine."account type"::Customer, LoanApp."Client Code", "Posting date", ObjReceiptTransactions."Interest Amount" * -1,
                            'FOSA', ObjRcptBuffer."No.", Format(GenJournalLine."transaction type"::"Loan Repayment"), ObjReceiptTransactions."Loan No.", GenJournalLine."application source"::" ");

                            //-------------PAY Interest----------------------------
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                            GenJournalLine."account type"::Vendor, ObjRcptBuffer."Source Account No.", "Posting date",
                            ObjReceiptTransactions."Interest Amount", 'FOSA', ObjRcptBuffer."No.",
                            Format(GenJournalLine."transaction type"::"Loan Repayment") + '-' + ObjReceiptTransactions."Loan Product Name", '', GenJournalLine."application source"::" ");

                            RunningBalance := RunningBalance - ObjReceiptTransactions."Interest Amount";
                        end;

                    end
                    else begin
                        //-------------RECOVER BOSA NONLoan Transactions-----------------------
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, ObjReceiptTransactions."Transaction Type",
                        GenJournalLine."account type"::Customer, ObjRcptBuffer."BOSA Account No.", "Posting date", ObjReceiptTransactions.Amount * -1,
                        'FOSA', ObjRcptBuffer."No.", Format(ObjReceiptTransactions."Transaction Type"), '', GenJournalLine."application source"::" ");

                        //-------------PAY BOSA NONLoan Transaction----------------------------
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, ObjReceiptTransactions."transaction type"::" ",
                        GenJournalLine."account type"::Vendor, ObjRcptBuffer."Source Account No.", "Posting date", ObjReceiptTransactions.Amount,
                        'FOSA', ObjRcptBuffer."No.", Format(ObjReceiptTransactions."Transaction Type"), '', GenJournalLine."application source"::" ");

                        RunningBalance := RunningBalance - ObjReceiptTransactions.Amount;

                    end

                until ObjReceiptTransactions.Next = 0;
            end;

            exit(RunningBalance);
        end;
    end;

    local procedure FnRegisterProcessedStandingOrder(ObjStandingOrders: Record "Standing Orders"; AmountToDeduct: Decimal)
    begin
        ObjSTORegister.Reset;
        ObjSTORegister.SetRange("Document No.", No);
        if ObjSTORegister.Find('-') then
            ObjSTORegister.DeleteAll;

        ObjSTORegister.Init;
        ObjSTORegister."Register No." := '';
        ObjSTORegister.Validate(ObjSTORegister."Register No.");
        ObjSTORegister."Standing Order No." := ObjStandingOrders."No.";
        ObjSTORegister."Source Account No." := ObjStandingOrders."Source Account No.";
        ObjSTORegister."Staff/Payroll No." := ObjStandingOrders."Staff/Payroll No.";
        ObjSTORegister.Date := Today;
        ObjSTORegister."Account Name" := ObjStandingOrders."Account Name";
        ObjSTORegister."Destination Account Type" := ObjStandingOrders."Destination Account Type";
        ObjSTORegister."Destination Account No." := ObjStandingOrders."Destination Account No.";
        ObjSTORegister."Destination Account Name" := ObjStandingOrders."Destination Account Name";
        ObjSTORegister."BOSA Account No." := ObjStandingOrders."BOSA Account No.";
        ObjSTORegister."Effective/Start Date" := ObjStandingOrders."Effective/Start Date";
        ObjSTORegister."End Date" := ObjStandingOrders."End Date";
        ObjSTORegister.Duration := ObjStandingOrders.Duration;
        ObjSTORegister.Frequency := ObjStandingOrders.Frequency;
        ObjSTORegister."Don't Allow Partial Deduction" := ObjStandingOrders."Don't Allow Partial Deduction";
        ObjSTORegister."Deduction Status" := DedStatus;
        ObjSTORegister.Remarks := ObjStandingOrders."Standing Order Description";
        ObjSTORegister.Amount := ObjStandingOrders.Amount;
        ObjSTORegister."Amount Deducted" := AmountToDeduct;
        if ObjStandingOrders."Destination Account Type" = ObjStandingOrders."destination account type"::"Member Account" then
            ObjSTORegister.EFT := true;
        ObjSTORegister."Document No." := No;
        ObjSTORegister.Insert(true);
    end;

    local procedure FnSalaryProcessing()
    begin
        BATCH_TEMPLATE := 'GENERAL';
        BATCH_NAME := 'SALARIES';
        DOCUMENT_NO := "Document No";
        EXTERNAL_DOC_NO := "Cheque No.";
        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
        GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
        GenJournalLine.DeleteAll;
        ObjGenSetup.Get();

        VarCreditDescription := '';
        salarybuffer.Reset;
        salarybuffer.SetRange("Salary Header No.", No);
        if salarybuffer.Find('-') then begin
            Window.Open(Format("Transaction Type") + ': @1@@@@@@@@@@@@@@@' + 'Record:#2###############');
            TotalCount := salarybuffer.Count;
            repeat
                Percentage := (ROUND(Counter / TotalCount * 10000, 1));
                Counter := Counter + 1;
                Window.Update(1, Percentage);
                Window.Update(2, Counter);

                RunBal := salarybuffer.Amount;
                RunBal := FnPostSalaryToFosa(salarybuffer, RunBal, salarybuffer."Credit Narration");
                //RunBal:=FnRecoverStatutories(salarybuffer,RunBal);
                FnRunStandingOrders(salarybuffer, RunBal);
            until salarybuffer.Next = 0;
        end;
        //Balancing Journal Entry
        LineNo := LineNo + 10000;
        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ", "Account Type",
        "Account No", "Posting date", Amount, 'FOSA', EXTERNAL_DOC_NO, "Transaction Description", '', GenJournalLine."application source"::" ");


        //CU posting
        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
        GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
        if GenJournalLine.Find('-') then
            Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJournalLine);

        Posted := true;
        "Posted By" := UserId;
        "Posting date" := WorkDate;
        Modify;
        if "Transaction Type" = "transaction type"::Salary then begin
            FnRunLoanRecovery(salarybuffer, No);//=================Recover Loans
            FnRunSalaryProcessingSMS;//============================Salary Processing SMS
        end;
        Message('Salaries Processed Successfuly');
        Window.Close;
    end;

    local procedure FnNISProcessing()
    begin
        BATCH_TEMPLATE := 'GENERAL';
        BATCH_NAME := 'SALARIES';
        DOCUMENT_NO := "Document No";
        EXTERNAL_DOC_NO := "Cheque No.";
        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
        GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
        GenJournalLine.DeleteAll;
        ObjGenSetup.Get();
        salarybuffer.Reset;
        salarybuffer.SetRange("Salary Header No.", No);
        if salarybuffer.Find('-') then begin
            Window.Open(Format("Transaction Type") + ': @1@@@@@@@@@@@@@@@' + 'Record:#2###############');
            TotalCount := salarybuffer.Count;
            repeat
                Percentage := (ROUND(Counter / TotalCount * 10000, 1));
                Counter := Counter + 1;
                Window.Update(1, Percentage);
                Window.Update(2, Counter);

                RunBal := salarybuffer.Amount;
                RunBal := FnPostSalaryToFosa(salarybuffer, RunBal, salarybuffer."Credit Narration");
                RunBal := FnRecoverStatutories(salarybuffer, RunBal);
            until salarybuffer.Next = 0;
        end;
        //Balancing Journal Entry
        LineNo := LineNo + 10000;
        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
        "Account Type", "Account No", "Posting date", Amount, 'FOSA', EXTERNAL_DOC_NO, DOCUMENT_NO, '', GenJournalLine."application source"::" ");
        Message('NIS journals Successfully Generated. BATCH NO=SALARIES.');
        Window.Close;
    end;

    local procedure FnRunSalaryProcessingSMS()
    var
        ObjAccount: Record Vendor;
        VarLoanProductName: Code[30];
        ObjCust: Record Customer;
        VarSMSBody: Text;
    begin
        ObjSalaryProcessingLines.Reset;
        ObjSalaryProcessingLines.SetRange(ObjSalaryProcessingLines."Salary Header No.", No);
        if ObjSalaryProcessingLines.FindSet then begin
            repeat
                SFactory.FnRunAfterCashDepositProcess(ObjSalaryProcessingLines."Account No.");

                ObjSalaryProcessingLines.CalcFields(ObjSalaryProcessingLines."Mobile Phone Number");
                VarMemberName := SFactory.FnRunSplitString(ObjSalaryProcessingLines."Account Name", ' ');
                VarSMSBody := 'Dear ' + VarMemberName + ', your salary of Ksh. ' + Format(ObjSalaryProcessingLines.Amount)
                  + ' has been processed to your Account No. ' + ObjSalaryProcessingLines."Account No.";
                SFactory.FnSendSMS('SALARY', VarSMSBody, ObjSalaryProcessingLines."Account No.", ObjSalaryProcessingLines."Mobile Phone Number");
            until ObjSalaryProcessingLines.Next = 0;
        end;
    end;

    local procedure FnRunLoanRecovery(ObjRcptBuffer: Record "Salary Processing Lines"; VarHeader: Code[50]): Decimal
    var
        AmountToDeduct: Decimal;
        ObjReceiptTransactions: Record "Receipt Allocation";
        VarAvailableBal: Decimal;
    begin
        ObjRcptBuffer.Reset;
        ObjRcptBuffer.SetRange(ObjRcptBuffer."Salary Header No.", VarHeader);
        if ObjRcptBuffer.FindSet then begin
            repeat
                LoanApp.Reset;
                LoanApp.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Employer Code");
                LoanApp.SetRange(LoanApp."Client Code", ObjRcptBuffer."Member No");
                LoanApp.SetRange(LoanApp."Loan Status", LoanApp."loan status"::Disbursed);
                LoanApp.SetRange(LoanApp."Recovery Mode", LoanApp."recovery mode"::Salary);
                if LoanApp.Find('-') then begin
                    BATCH_TEMPLATE := 'GENERAL';
                    BATCH_NAME := 'SALARIES';
                    DOCUMENT_NO := SFactory.FnRunGetNextTransactionDocumentNo;
                    ;
                    EXTERNAL_DOC_NO := "Document No";
                    repeat
                        if ObjVendor.Get(ObjRcptBuffer."Account No.") then begin
                            VarAvailableBal := SFactory.FnRunGetAccountAvailableBalanceWithoutFreeze(ObjVendor."No.", WorkDate);
                            SFactory.FnCreateLoanRecoveryJournalsAdvance(LoanApp."Loan  No.", BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LoanApp."Client Code",
                            "Posting date", EXTERNAL_DOC_NO, ObjRcptBuffer."Account No.", ObjRcptBuffer."Account Name", VarAvailableBal);

                            //CU posting
                            GenJournalLine.Reset;
                            GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                            GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                            if GenJournalLine.Find('-') then
                                Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJournalLine);
                        end;
                    until LoanApp.Next = 0;
                end;
            until ObjRcptBuffer.Next = 0;
        end;
    end;
}

