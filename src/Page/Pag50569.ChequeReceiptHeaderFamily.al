#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50569 "Cheque Receipt Header-Family"
{
    PageType = Card;
    SourceTable = "Cheque Receipts-Family";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; "No.")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Date"; "Transaction Date")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Time"; "Transaction Time")
                {
                    ApplicationArea = Basic;
                }
                field("Created By"; "Created By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Posted By"; "Posted By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Unpaid By"; "Unpaid By")
                {
                    ApplicationArea = Basic;
                }
                field("Refference Document"; "Refference Document")
                {
                    ApplicationArea = Basic;
                }
                field("Document Name"; "Document Name")
                {
                    ApplicationArea = Basic;
                }
                field("Bank Account"; "Bank Account")
                {
                    ApplicationArea = Basic;
                }
                field(Posted; Posted)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Unpaid; Unpaid)
                {
                    ApplicationArea = Basic;
                }
                field(Imported; Imported)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Processed; Processed)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Mark All Verified"; "Mark All Verified")
                {
                    ApplicationArea = Basic;
                    Caption = 'Mark All As Verified';

                    trigger OnValidate()
                    begin
                        ObjChqRecLines.Reset;
                        ObjChqRecLines.SetRange(ObjChqRecLines."Header No", "No.");
                        if ObjChqRecLines.FindSet then begin
                            repeat
                                if "Mark All Verified" = true then
                                    ObjChqRecLines."Verification Status" := ObjChqRecLines."verification status"::Verified
                                else
                                    ObjChqRecLines."Verification Status" := ObjChqRecLines."verification status"::"Not Verified";
                                ObjChqRecLines.Modify;
                            until ObjChqRecLines.Next = 0
                        end
                    end;
                }
                field(Status; Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            part(Control1000000011; "Cheque Receipt Line-Family")
            {
                SubPageLink = "Header No" = field("No.");
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(Import)
            {
                ApplicationArea = Basic;
                Image = Import;
                Visible = false;

                trigger OnAction()
                var
                    DestinationFile: Text[60];
                begin

                    DestinationFile := FileMgt.UploadFile('D:\Cheque Trunc\Raw\J70', UserId);
                    if Confirm('Are you sure you want Import cheques', true) = true then begin
                        if FILE.Copy(DestinationFile, 'D:\Cheque Trunc\Raw\' + '.J70') then begin
                            Message(Format(DestinationFile));
                            ObjChequeFamily.Reset;
                            ObjChequeFamily.SetRange(ObjChequeFamily."No.", "No.");
                            if ObjChequeFamily.Find('-') then begin
                                ObjChequeFamily.Imported := true;
                                ObjChequeFamily."Document Name" := 'D:\Cheque Trunc\Raw\newfile' + '.J70';
                                ObjChequeFamily."Created By" := UserId;
                                ObjChequeFamily.Modify;
                                FILE.Erase(DestinationFile);
                                Message('Successfully Imported');  // continue your program
                            end;
                        end else begin
                            Message('Nothing to Import');  // else handle the error
                        end;
                    end;

                    //XMLPORT.RUN(51516038,TRUE);
                    //Report.run(50517,TRUE);


                    /*
                    RefNoRec.RESET;
                    RefNoRec.SETRANGE(RefNoRec.CurrUserID,USERID);
                    IF RefNoRec.FIND('-') THEN BEGIN
                    RefNoRec."Reference No":="No.";
                    RefNoRec.MODIFY;
                    END
                    ELSE BEGIN
                    RefNoRec.INIT;
                    RefNoRec.CurrUserID:=USERID;
                    RefNoRec."Reference No":="No.";
                    RefNoRec.INSERT;
                    END;*/

                end;
            }
            action(LoadCheques)
            {
                ApplicationArea = Basic;
                Caption = 'Load Cheques';
                Image = GetLines;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Scope = Page;

                trigger OnAction()
                begin
                    objChequeTransactions.Reset;
                    objChequeTransactions.SetRange(objChequeTransactions."Imported to Receipt Lines", false);
                    if objChequeTransactions.FindSet(true, false) then begin
                        repeat
                            ChargeAmount := 0;
                            objChequeCharges.Reset;
                            objChequeCharges.SetFilter(objChequeCharges."Lower Limit", '<=%1', objChequeTransactions.AMOUNT);
                            objChequeCharges.SetFilter(objChequeCharges."Upper Limit", '>=%1', objChequeTransactions.AMOUNT);
                            if objChequeCharges.Find('-') then begin
                                VarChequeCharge := objChequeCharges.Charges;
                                VarSaccoIncome := objChequeCharges."Sacco Income";
                            end;

                            objChequeTransactions.CalcFields(objChequeTransactions.FrontBWImage, objChequeTransactions.FrontGrayScaleImage,
                            objChequeTransactions.RearImage);

                            ObjChequeBookApp.Reset;
                            ObjChequeBookApp.SetRange(ObjChequeBookApp."Cheque Book Account No.", objChequeTransactions.MemberNo);
                            ObjChequeBookApp.SetFilter(ObjChequeBookApp."Begining Cheque No.", '<=%1', objChequeTransactions.SNO);
                            ObjChequeBookApp.SetFilter(ObjChequeBookApp."End Cheque No.", '>=%1', objChequeTransactions.SNO);
                            if ObjChequeBookApp.FindSet then begin
                                AccountNumber := ObjChequeBookApp."Account No.";
                                AccountName := ObjChequeBookApp.Name;
                            end
                            else begin
                                AccountNumber := FnGetAccountNo(objChequeTransactions.MemberNo);
                                AccountName := FnGetAccountName(objChequeTransactions.MemberNo);
                            end;

                            ObjChqRecLines.Init;
                            ObjChqRecLines."Cheque Serial No" := Format(objChequeTransactions.SerialId);
                            ObjChqRecLines."Chq Receipt No" := Format(objChequeTransactions.ChequeDataId);
                            ObjChqRecLines."Account No." := AccountNumber;
                            ObjChqRecLines.TestField(ObjChqRecLines."Account No.");
                            ObjChqRecLines."Member Branch" := CopyStr(ObjChqRecLines."Account No.", 4, 3);
                            ObjChqRecLines."Cheque No" := objChequeTransactions.SNO;
                            ObjChqRecLines."Header No" := "No.";
                            ObjChqRecLines."Account Name" := AccountName;
                            ObjChqRecLines.Amount := objChequeTransactions.AMOUNT;
                            ObjChqRecLines."Charge Amount" := VarChequeCharge;
                            ObjChqRecLines."Charge Amount Sacco Income" := VarSaccoIncome;
                            ObjChqRecLines.Currency := 'KES';
                            ObjChqRecLines."Family Account No." := objChequeTransactions.DESTACC;
                            ObjChqRecLines."Account Balance" := SFactory.FnRunGetAccountAvailableBalance(AccountNumber);
                            ObjChqRecLines.Fillers := objChequeTransactions.FILLER;
                            ObjChqRecLines."Branch Code" := objChequeTransactions.DESTBRANCH;
                            ObjChqRecLines.FrontImage := objChequeTransactions.FrontBWImage;
                            ObjChqRecLines.FrontGrayImage := objChequeTransactions.FrontGrayScaleImage;
                            ObjChqRecLines.BackImages := objChequeTransactions.RearImage;
                            ObjChqRecLines.Insert;

                            objChequeTransactions."Imported to Receipt Lines" := true;
                            objChequeTransactions.Modify;
                        until objChequeTransactions.Next = 0;
                    end;
                end;
            }
            action(Post)
            {
                ApplicationArea = Basic;
                Enabled = EnablePosting;
                Image = Post;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                var
                    MemberBranch: Code[100];
                begin
                    BATCH_NAME := 'DEFAULT';
                    BATCH_TEMPLATE := 'GENERAL';
                    DOCUMENT_NO := "No.";
                    TestField("Bank Account");
                    ObjGenSetup.Get;

                    if Posted then
                        Error('Document already Posted');

                    if Confirm('Confirm Inward Cheque Processing', false) = true then begin

                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                        GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                        GenJournalLine.DeleteAll;


                        ObjChqRecLines.Reset;
                        ObjChqRecLines.SetRange(ObjChqRecLines."Header No", "No.");
                        //ObjChqRecLines.SETRANGE(ObjChqRecLines.Status,ObjChqRecLines.Status::Pending);
                        ObjChqRecLines.SetRange(ObjChqRecLines."Verification Status", ObjChqRecLines."verification status"::Verified);
                        if ObjChqRecLines.Find('-') then begin
                            repeat
                                MemberBranch := FnGetMemberBranch(ObjChqRecLines."Account No.");
                                VarBankAmount := (ObjChqRecLines."Charge Amount" - ObjChqRecLines."Charge Amount Sacco Income");
                                VarBankAmount := VarBankAmount + (VarBankAmount * ObjGenSetup."Excise Duty(%)" / 100);

                                //===================================================================================1.DEBIT TO VENDOR
                                LineNo := LineNo + 10000;
                                SFactory.FnCreateGnlJournalLineBalancedChequeNo(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                                GenJournalLine."account type"::Vendor, ObjChqRecLines."Account No.", "Transaction Date", 'Inward Cheque #' + ObjChqRecLines."Cheque No" + ' to Acc. ' + ObjChqRecLines."Account No.",
                                GenJournalLine."bal. account type"::"Bank Account", "Bank Account", ObjChqRecLines.Amount, 'FOSA', '', ObjChqRecLines."Cheque No", MemberBranch);

                                //=======================================================================================Debit FOSA Account Charges
                                LineNo := LineNo + 10000;
                                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, "No.", LineNo, GenJournalLine."transaction type"::" ", GenJournalLine."account type"::Vendor,
                                        ObjChqRecLines."Account No.", WorkDate, ObjChqRecLines."Charge Amount", 'FOSA', "No.", 'Inward Cheque Clearing Fees #' + ObjChqRecLines."Cheque No"
                                        , '', GenJournalLine."application source"::" ");

                                LineNo := LineNo + 10000;
                                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, "No.", LineNo, GenJournalLine."transaction type"::" ", GenJournalLine."account type"::Vendor,
                                        ObjChqRecLines."Account No.", WorkDate, (ObjChqRecLines."Charge Amount" * ObjGenSetup."Excise Duty(%)" / 100), 'FOSA', "No.", 'Tax: Inward Cheque Clearing Fees #' +
                                        ObjChqRecLines."Cheque No", '',
                                        GenJournalLine."application source"::" ");

                                //=======================================================================================Credit Bank With Charge and Tax
                                LineNo := LineNo + 10000;
                                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, "No.", LineNo, GenJournalLine."transaction type"::" ", GenJournalLine."account type"::"G/L Account",
                                        ObjGenSetup."Cheque Clearing Family Income", WorkDate, VarBankAmount * -1, 'FOSA', "No.", 'Inward Cheque Clearing Fees #' + ObjChqRecLines."Cheque No" + ' to Acc. ' + ObjChqRecLines."Account No.",
                                        '', GenJournalLine."application source"::" ");

                                //=======================================================================================Credit Income Account
                                LineNo := LineNo + 10000;
                                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, "No.", LineNo, GenJournalLine."transaction type"::" ", GenJournalLine."account type"::"G/L Account",
                                        ObjGenSetup."Cheque Processing Fee Account", WorkDate, ObjChqRecLines."Charge Amount Sacco Income" * -1, 'FOSA', "No.",
                                        'Inward Cheque Clearing Fees #' + ObjChqRecLines."Cheque No" + ' to Acc. ' + ObjChqRecLines."Account No.", '', GenJournalLine."application source"::" ");

                                //=======================================================================================Credit Tax:G/L Account
                                LineNo := LineNo + 10000;
                                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, "No.", LineNo, GenJournalLine."transaction type"::" ", GenJournalLine."account type"::"G/L Account",
                                        ObjGenSetup."Excise Duty Account", WorkDate, (ObjChqRecLines."Charge Amount Sacco Income" * ObjGenSetup."Excise Duty(%)" / 100) * -1, 'FOSA', "No.",
                                        'Tax: Inward Cheque Clearing Fees #' + ObjChqRecLines."Cheque No" + ' to Acc. ' + ObjChqRecLines."Account No.", '', GenJournalLine."application source"::" ");


                                VarAccountAvailableBal := SFactory.FnRunGetAccountAvailableBalance(ObjChqRecLines."Account No.");

                                if VarAccountAvailableBal < (ObjChqRecLines.Amount + (ObjChqRecLines."Charge Amount" * (ObjGenSetup."Excise Duty(%)" / 100))) then begin
                                    Message('This Transaction Will result in account %1 being overdrawn', ObjChqRecLines."Account No.");
                                end;

                                ObjChqRecLines.Status := ObjChqRecLines.Status::Approved;
                                ObjChqRecLines.Modify;
                            until ObjChqRecLines.Next = 0;
                        end;

                        //CU Post
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                        GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                        if GenJournalLine.Find('-') then begin
                            Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
                        end;

                        //======================================================================Update cheque book register
                        ObjChqRecLines.Reset;
                        ObjChqRecLines.SetRange(ObjChqRecLines."Header No", "No.");
                        ObjChqRecLines.SetRange(ObjChqRecLines.Status, ObjChqRecLines.Status::Approved);
                        if ObjChqRecLines.Find('-') then begin
                            repeat
                                ObjCheqReg.Reset;
                                ObjCheqReg.SetRange(ObjCheqReg."Cheque No.", ObjChqRecLines."Cheque No");
                                if ObjCheqReg.Find('-') then begin
                                    ObjCheqReg.Status := ObjCheqReg.Status::Paid;
                                    ObjCheqReg."Action Date" := Today;
                                    ObjCheqReg.Modify;
                                end;
                            until ObjChqRecLines.Next = 0;
                        end;
                        Posted := true;
                        "Posted By" := UserId;
                        Modify;
                    end;
                    Message('Transaction Processed Successfully');
                end;
            }
            action("Post UnPaid Accounts")
            {
                ApplicationArea = Basic;
                Enabled = EnableUnpay;
                Image = ReverseLines;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;

                trigger OnAction()
                var
                    MemberBranch: Code[100];
                begin
                    BATCH_NAME := 'DEFAULT';
                    BATCH_TEMPLATE := 'GENERAL';
                    DOCUMENT_NO := "No.";
                    ObjGenSetup.Get();
                    ObjGenSetup.TestField("Excise Duty Account");
                    ObjGenSetup.TestField("Partial Deposit Refund Fee");
                    if Confirm('Confirm Cheque Unpay', false) = true then begin

                        if Posted = false then
                            Error('You have to post the batch before unpaying');

                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                        GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                        GenJournalLine.DeleteAll;

                        ObjChqRecLines.Reset;
                        ObjChqRecLines.SetRange(ObjChqRecLines."Header No", "No.");
                        //ObjChqRecLines.SETRANGE(ObjChqRecLines.Status,ObjChqRecLines.Status::Approved);
                        ObjChqRecLines.SetFilter(ObjChqRecLines."Un pay Code", '<>%1', '');
                        if ObjChqRecLines.Find('-') then begin
                            repeat
                                MemberBranch := '';
                                MemberBranch := FnGetMemberBranch(ObjChqRecLines."Account No.");

                                MemberBranch := FnGetMemberBranch(ObjChqRecLines."Account No.");
                                VarUnpayBankAmount := (ObjChqRecLines."Un Pay Charge Amount" - ObjChqRecLines."Charge Unpay Sacco Income");
                                VarUnpayBankAmount := VarUnpayBankAmount + (VarUnpayBankAmount * ObjGenSetup."Excise Duty(%)" / 100);


                                //===================================================================================1.DEBIT TO VENDOR
                                LineNo := LineNo + 10000;
                                SFactory.FnCreateGnlJournalLineBalancedChequeNo(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                                GenJournalLine."account type"::Vendor, ObjChqRecLines."Account No.", "Transaction Date", 'Unpaid Inward Cheque #' + ObjChqRecLines."Cheque No" + ' for Acc. ' + ObjChqRecLines."Account No.",
                                GenJournalLine."bal. account type"::"Bank Account", "Bank Account", ObjChqRecLines.Amount * -1, 'FOSA', '', ObjChqRecLines."Cheque No", MemberBranch);

                                //=======================================================================================Debit FOSA Account Charges
                                LineNo := LineNo + 10000;
                                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, "No.", LineNo, GenJournalLine."transaction type"::" ", GenJournalLine."account type"::Vendor,
                                        ObjChqRecLines."Account No.", WorkDate, ObjChqRecLines."Un Pay Charge Amount", 'FOSA', "No.", 'Unpaid Inward Cheque Fees #' + ObjChqRecLines."Cheque No"
                                        , '', GenJournalLine."application source"::" ");

                                LineNo := LineNo + 10000;
                                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, "No.", LineNo, GenJournalLine."transaction type"::" ", GenJournalLine."account type"::Vendor,
                                        ObjChqRecLines."Account No.", WorkDate, (ObjChqRecLines."Un Pay Charge Amount" * ObjGenSetup."Excise Duty(%)" / 100), 'FOSA', "No.", 'Tax: Unpaid Inward Cheque Fees #' +
                                        ObjChqRecLines."Cheque No", '',
                                        GenJournalLine."application source"::" ");

                                //=======================================================================================Credit Bank With Charge and Tax
                                LineNo := LineNo + 10000;
                                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, "No.", LineNo, GenJournalLine."transaction type"::" ", GenJournalLine."account type"::"Bank Account",
                                        "Bank Account", WorkDate, VarUnpayBankAmount * -1, 'FOSA', "No.", 'Unpaid Inward Cheque Fees #' + ObjChqRecLines."Cheque No" + ' for Acc. ' + ObjChqRecLines."Account No.",
                                        '', GenJournalLine."application source"::" ");

                                //=======================================================================================Credit Income Account
                                LineNo := LineNo + 10000;
                                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, "No.", LineNo, GenJournalLine."transaction type"::" ", GenJournalLine."account type"::"G/L Account",
                                        ObjGenSetup."Unpaid Cheques Fee Account", WorkDate, ObjChqRecLines."Charge Unpay Sacco Income" * -1, 'FOSA', "No.",
                                        'Unpaid Inward Cheque Fees #' + ObjChqRecLines."Cheque No" + ' for Acc. ' + ObjChqRecLines."Account No.", '', GenJournalLine."application source"::" ");

                                //=======================================================================================Credit Tax:G/L Account
                                LineNo := LineNo + 10000;
                                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, "No.", LineNo, GenJournalLine."transaction type"::" ", GenJournalLine."account type"::"G/L Account",
                                        ObjGenSetup."Excise Duty Account", WorkDate, (ObjChqRecLines."Charge Unpay Sacco Income" * ObjGenSetup."Excise Duty(%)" / 100) * -1, 'FOSA', "No.",
                                        'Unpaid Tax: Inward Cheque Fees #' + ObjChqRecLines."Cheque No" + ' for Acc. ' + ObjChqRecLines."Account No.", '', GenJournalLine."application source"::" ");



                            until ObjChqRecLines.Next = 0;
                        end;

                        //CU Post
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                        GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                        if GenJournalLine.Find('-') then begin
                            Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
                        end;
                        "Unpaid By" := UserId;
                        Unpaid := true;
                        Closed := true;
                    end;
                end;
            }
            action("Export Unpaid Accounts")
            {
                ApplicationArea = Basic;
                Image = Excel;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;

                trigger OnAction()
                begin

                    ObjChqRecLines.Reset;
                    ObjChqRecLines.SetRange(ObjChqRecLines."Chq Receipt No", "No.");
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
                    if WKFLWIntegr.CheckInwardChequeClearingApprovalsWorkflowEnabled(Rec) then
                        WKFLWIntegr.OnSendInwardChequeClearingForApproval(Rec);
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
                        WKFLWIntegr.OnCancelInwardChequeClearingApprovalRequest(Rec);
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
                    DocumentType := Documenttype::InwardChequeClearing;
                    ApprovalEntries.Setfilters(Database::"Loan PayOff", DocumentType, "No.");
                    ApprovalEntries.Run;
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
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

        EnableUnpay := false;
        if ((Rec.Status = Status::Approved) and (Rec.Posted = true)) then
            EnableUnpay := true;
    end;

    trigger OnAfterGetRecord()
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

        EnableUnpay := false;
        if ((Rec.Status = Status::Approved) and (Rec.Posted = true)) then
            EnableUnpay := true;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        "Created By" := UserId;
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

        EnableUnpay := false;
        if ((Rec.Status = Status::Approved) and (Rec.Posted = true)) then
            EnableUnpay := true;
    end;

    var
        GenJournalLine: Record "Gen. Journal Line";
        GLPosting: Codeunit "Gen. Jnl.-Post Line";
        ObjAccountType: Record "Account Types-Saving Products";
        AvailableBal: Decimal;
        LineNo: Integer;
        EFTDetails: Record "prVital Setup Info.";
        STORegister: Record "Standing Order Register";
        ObjAccounts: Record Vendor;
        EFTHeader: Record "HR General Setup.";
        Transactions: Record Transactions;
        ReffNo: Code[20];
        Account: Record Vendor;
        SMSMessage: Record Vendor;
        iEntryNo: Integer;
        ObjVend: Record Vendor;
        ObjChqRecLines: Record "Cheque Issue Lines-Family";
        AccountTypes: Record "Account Types-Saving Products";
        ObjCheqReg: Record "Cheques Register";
        WKFLWIntegr: Codeunit WorkflowIntegration;
        Charges: Record Charges;
        ObjGenSetup: Record "Sacco General Set-Up";
        objChequeTransactions: Record "Cheque Truncation Buffer";
        ObjChequeFamily: Record "Cheque Receipts-Family";
        FileMgt: Codeunit "File Management";
        objChequeCharges: Record "Cheque Processing Charges";
        ChargeAmount: Decimal;
        SFactory: Codeunit "SURESTEP Factory";
        BATCH_TEMPLATE: Code[100];
        BATCH_NAME: Code[100];
        DOCUMENT_NO: Code[100];
        VarChequeCharge: Decimal;
        VarSaccoIncome: Decimal;
        VarBankAmount: Decimal;
        VarAccountAvailableBal: Decimal;
        VarUnPayChequeCharge: Decimal;
        VarUnpaySaccoIncome: Decimal;
        VarUnpayBankAmount: Decimal;
        EnablePosting: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        EnabledApprovalWorkflowsExist: Boolean;
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery,ChangeRequest,TreasuryTransactions,FundsTransfer,SaccoTransfers,ChequeDiscounting,ImprestRequisition,ImprestSurrender,LeaveApplication,BulkWithdrawal,PackageLodging,PackageRetrieval,HouseChange,CRMTraining,PettyCash,StaffClaims,MemberAgentNOKChange,HouseRegistration,LoanPayOff,FixedDeposit,RTGS,DemandNotice,OverDraft,LoanRestructure,SweepingInstructions,ChequeBookApplication,LoanTrunchDisbursement,InwardChequeClearing,InValidPaybillTransactions;
        EnableUnpay: Boolean;
        ObjChequeBookApp: Record "Cheque Book Application";
        AccountNumber: Text;
        AccountName: Text;

    local procedure FnGetAccountNo(MemberNo: Code[100]) AccountNo: Code[100]
    begin
        Account.Reset;
        Account.SetRange(Account."Cheque Clearing No", MemberNo);
        if Account.Find('-') then begin
            AccountNo := Account."No.";
        end
    end;

    local procedure FnGetAccountName(MemberNo: Code[100]) AccountName: Text[250]
    begin
        Account.Reset;
        Account.SetRange(Account."Cheque Clearing No", MemberNo);
        if Account.Find('-') then begin
            AccountName := Account.Name;
        end
    end;


    procedure Balance(Acc: Code[30]; Vendor: Record Vendor) Bal: Decimal
    begin
        if Vendor.Get(Acc) then begin
            Vendor.CalcFields(Vendor."Balance (LCY)", Vendor."ATM Transactions", Vendor."Uncleared Cheques");
            Bal := Vendor."Balance (LCY)" - (Vendor."ATM Transactions" + Vendor."Uncleared Cheques" + Vendor."EFT Transactions");
        end
    end;

    local procedure FnGetAccountBalance(MemberNo: Code[100]) AccountBalance: Decimal
    begin
        Account.Reset;
        Account.SetRange(Account."Cheque Clearing No", MemberNo);
        if Account.Find('-') then begin
            AccountBalance := Balance(Account."No.", Account);
        end
    end;

    local procedure FnGetMemberBranch(FosaAccountNumber: Code[100]): Code[100]
    var
        ObjVendor: Record Vendor;
    begin
        ObjVendor.Reset;
        ObjVendor.SetRange("No.", FosaAccountNumber);
        if ObjVendor.Find('-') then begin
            exit(ObjVendor."Global Dimension 2 Code");
        end;
    end;
}

