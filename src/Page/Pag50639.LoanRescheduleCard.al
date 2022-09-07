#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50639 "Loan Reschedule Card"
{
    PageType = Card;
    SourceTable = "Loan Rescheduling";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'Loan Reschedule';
                field("Document No"; "Document No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Member No"; "Member No")
                {
                    ApplicationArea = Basic;
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
                field(Status; Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Issue Date"; "Issue Date")
                {
                    ApplicationArea = Basic;
                }
                field("Approved Amount"; "Approved Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Rescheduled By"; "Rescheduled By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Rescheduled Date"; "Rescheduled Date")
                {
                    ApplicationArea = Basic;
                }
                field("Original Installments"; "Original Installments")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("New Installments"; "New Installments")
                {
                    ApplicationArea = Basic;
                }
                field("Outstanding Loan Amount"; "Outstanding Loan Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Repayment Start Date"; "Repayment Start Date")
                {
                    ApplicationArea = Basic;
                }
                field("Repayment Amount"; "Repayment Amount")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Loan Principle Repayment"; "Loan Principle Repayment")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Loan Interest Repayment"; "Loan Interest Repayment")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Rescheduled; Rescheduled)
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
            group(ActionGroup1000000020)
            {
                action("Reschedule Loan")
                {
                    ApplicationArea = Basic;
                    Image = Holiday;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        LoanRegister: Record "Loans Register";
                        LoanSchedule: Record "Loan Repayment Schedule";
                        Installments: Integer;
                        DisbAmount: Decimal;
                        LoanTranche: Record "Loan trunch Disburesment";
                        LoanAmount: Decimal;
                        LoanBal: Decimal;
                        InterestRate: Decimal;
                        RepayDate: Date;
                        LoanInterest: Decimal;
                        SharesTxt: label 'Include monthly shares in the schedule?';
                        SharesBand: Record "Deposit Tier Setup";
                        InsuranceBand: Record "Cheque Truncation Buffer";
                        SharesContribution: Decimal;
                        InsuranceContribution: Decimal;
                        LoanDisbursed: Decimal;
                        Cust: Record Customer;
                    begin
                        if Confirm('Are you sure you want to reshedule the loan') then begin
                            TestField(Status, Status::Approved);

                            LoanRegister.Reset;
                            LoanRegister.SetRange(LoanRegister."Loan  No.", "Loan No");
                            LoanRegister.SetFilter(LoanRegister.Posted, '%1', true);
                            if LoanRegister.FindFirst then begin
                                LoanRegister."Loan Principle Repayment" := LoanPrinciple;
                                LoanRegister.Installments := "New Installments";
                                LoanRegister."Repayment Start Date" := "Repayment Start Date";
                                LoanRegister.Modify;
                            end;

                            Rescheduled := true;
                            Modify;

                            TestField("New Installments");
                            TestField("Repayment Start Date");

                            LoanRegister.Reset;
                            LoanRegister.SetRange(LoanRegister."Loan  No.", "Loan No");
                            LoanRegister.SetFilter(LoanRegister.Posted, '%1', true);
                            if LoanRegister.FindFirst then begin
                                LoanRegister.TestField(LoanRegister.Installments);
                                LoanRegister.TestField(LoanRegister.Interest);
                                LoanRegister.TestField(LoanRegister."Repayment Frequency");

                                //Delete Schedule:
                                LoanSchedule.Reset;
                                LoanSchedule.SetRange(LoanSchedule."Loan No.", LoanRegister."Loan  No.");
                                LoanSchedule.DeleteAll;

                                //End of Delete Schedule

                                LoanAmount := "Outstanding Loan Amount";
                                LoanBal := LoanAmount;
                                InterestRate := LoanRegister.Interest;
                                Installments := "New Installments";
                                RepayDate := "Repayment Start Date";

                                InstalNo := 0;


                                repeat
                                    InstalNo := InstalNo + 1;

                                    //Repayment Frequency
                                    if LoanRegister."Repayment Frequency" = LoanRegister."repayment frequency"::Daily then
                                        RepayDate := CalcDate('1D', RepayDate)
                                    else
                                        if LoanRegister."Repayment Frequency" = LoanRegister."repayment frequency"::Weekly then
                                            RepayDate := CalcDate('1W', RepayDate)
                                        else
                                            if LoanRegister."Repayment Frequency" = LoanRegister."repayment frequency"::Monthly then
                                                RepayDate := CalcDate('1M', RepayDate)
                                            else
                                                if LoanRegister."Repayment Frequency" = LoanRegister."repayment frequency"::Quaterly then
                                                    RepayDate := CalcDate('1Q', RepayDate);
                                    //Repayment Frequency

                                    //MESSAGE('method is %1',LoanRegister."Repayment Method");
                                    if LoanRegister."Repayment Method" = LoanRegister."repayment method"::"Reducing Balance" then begin
                                        LoanPrinciple := ROUND(LoanAmount / Installments, 0.05, '>');
                                        LoanInterest := (InterestRate / 12 / 100) * LoanBal;
                                        LoanRegister."Loan Principle Repayment" := LoanPrinciple;
                                        LoanRegister."Loan Interest Repayment" := LoanInterest;
                                        LoanRegister."Loan Disbursement Date" := "Repayment Start Date";
                                        LoanRegister.Modify;
                                    end;
                                    if LoanRegister."Repayment Method" = LoanRegister."repayment method"::"Straight Line" then begin
                                        LoanPrinciple := LoanAmount / Installments;
                                        LoanInterest := (InterestRate / 12 / 100) * LoanAmount;
                                        LoanRegister."Loan Principle Repayment" := LoanPrinciple;
                                        LoanRegister."Loan Interest Repayment" := LoanInterest;
                                        LoanRegister."Loan Disbursement Date" := "Repayment Start Date";
                                        LoanRegister.Modify;
                                    end;

                                    //*******************If Amortised****************************//

                                    if LoanRegister."Repayment Method" = LoanRegister."repayment method"::Amortised then begin
                                        TotalMRepay := ROUND((InterestRate / 12 / 100) / (1 - Power((1 + (InterestRate / 12 / 100)), -("New Installments"))) * (LoanAmount), 0.05, '>');
                                        LoanInterest := ROUND(LoanBal / 100 / 12 * InterestRate, 0.05, '>');
                                        LoanPrinciple := TotalMRepay - LoanInterest;
                                        LoanRegister."Loan Principle Repayment" := LoanPrinciple;
                                        LoanRegister."Loan Interest Repayment" := LoanInterest;
                                        LoanRegister."Loan Disbursement Date" := "Repayment Start Date";
                                        LoanRegister.Repayment := TotalMRepay;
                                        LoanRegister.Modify;
                                    end;



                                    //******************* end If Amortised****************************//
                                    LoanBal := LoanBal - LoanPrinciple;
                                    LoanSchedule.Init;
                                    LoanSchedule."Repayment Code" := '';
                                    LoanSchedule."No Of Months" := "New Installments";
                                    LoanSchedule."Loan No." := LoanRegister."Loan  No.";
                                    LoanSchedule."Loan Amount" := LoanAmount;
                                    LoanSchedule."Instalment No" := InstalNo;
                                    LoanSchedule."Repayment Date" := RepayDate;
                                    LoanSchedule."Member No." := LoanRegister."Client Code";
                                    LoanSchedule."Loan Category" := LoanRegister."Loan Product Type";
                                    LoanSchedule."Monthly Repayment" := LoanInterest + LoanPrinciple;
                                    ;//+SharesContribution+InsuranceContribution;
                                    LoanSchedule."Monthly Interest" := LoanInterest;
                                    LoanSchedule."Principle Amount Paid" := SharesContribution;
                                    //LoanSchedule."Insurance Contribution":=InsuranceContribution;
                                    LoanSchedule."Principal Repayment" := LoanPrinciple;
                                    LoanSchedule."Interest Paid" := Date2dmy(RepayDate, 1);
                                    LoanSchedule."Insurance Paid" := Date2dmy(RepayDate, 2);
                                    LoanSchedule."Cummulative Principle Paid" := Date2dmy(RepayDate, 3);
                                    LoanSchedule."Loan Balance" := LoanBal;
                                    LoanSchedule."Instalment Fully Settled" := true;


                                    LoanSchedule.Insert(true);
                                until LoanBal < 1;

                            end;
                            Cust.Reset;
                            Cust.SetRange(Cust."No.", LoanSchedule."Member No.");
                            if Cust.Find('-') then begin
                                if SharesContribution <> 0 then begin
                                    Cust."Monthly Contribution" := SharesContribution;
                                    //Cust.MODIFY;
                                end;
                            end;

                            Commit;

                            LoanRegister.Reset;
                            LoanRegister.SetRange(LoanRegister."Loan  No.", "Loan No");
                            if LoanRegister.Find('-') then begin
                                Report.Run(50477, true, false, LoanRegister);
                            end;


                        end;



                        BATCH_TEMPLATE := 'PAYMENTS';
                        BATCH_NAME := 'LOANS';
                        DOCUMENT_NO := "Document No";

                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", 'PAYMENTS');
                        GenJournalLine.SetRange("Journal Batch Name", 'LOANS');
                        if GenJournalLine.Find('-') then begin
                            GenJournalLine.DeleteAll
                        end;

                        //------------------------------------1. DEBIT MEMBER Deposit A/C---------------------------------------------------------------------------------------------
                        SaccoGeneralSetUp.Get();

                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Deposit Contribution",
                        GenJournalLine."account type"::Member, "Member No", "Rescheduled Date", ("Outstanding Loan Amount" * SaccoGeneralSetUp."Reschedule Charge(%)" / 100), 'BOSA', LoanApps."Loan  No.",
                       'Loan Rescheduling Fee -' + "Loan No", LoanApps."Loan  No.", GenJournalLine."application source"::" ");


                        //------------------------------------Interest on Reschesdule----------
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                        GenJournalLine."account type"::"G/L Account", SaccoGeneralSetUp."Boosting Fees Account", "Rescheduled Date", ("Outstanding Loan Amount" * SaccoGeneralSetUp."Reschedule Charge(%)" / 100) * -1, 'BOSA', LoanApps."Loan  No.",
                        'Loan Rescheduling Fee' + "Loan No", LoanApps."Loan  No.", GenJournalLine."application source"::" ");


                        //Posting
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", 'PAYMENTS');
                        GenJournalLine.SetRange("Journal Batch Name", 'LOANS');
                        if GenJournalLine.Find('-') then begin
                            Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJournalLine);
                        end;


                        Message('Reschedule Successfully done and Respective Charges Effected');
                    end;
                }
                action("New Schedule")
                {
                    ApplicationArea = Basic;
                    Caption = 'View Schedule';
                    Image = "report";
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        LoanRegister: Record "Loans Register";
                    begin

                        LoanRegister.Reset;
                        LoanRegister.SetRange(LoanRegister."Loan  No.", "Loan No");
                        if LoanRegister.Find('-') then begin
                            Report.Run(50477, true, false, LoanRegister);
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
                        /*DocumentType:=DocumentType::"Loan Tranche";
                        ApprovalEntries.Setfilters(DATABASE::"Loan trunch Disburesment",DocumentType,"Document No");
                        ApprovalEntries.RUN;*/

                    end;
                }
                action("Send Approval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        Text001: label 'This transaction is already pending approval';
                        ApprovalMgt: Codeunit "Approvals Mgmt.";
                    begin
                        /*
                        IF ApprovalMgt.CheckLoanRestructureApprovalsWorkflowEnabled(Rec) THEN
                        ApprovalMgt.OnSendLoanRestructureForApproval(Rec);
                        */
                        Status := Status::Approved;
                        Modify;
                        Message('Approved Successfully');

                    end;
                }
                action("Cancel Approval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Request';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit "Approvals Mgmt.";
                    begin
                        /*IF CONFIRM(CancelApproval,FALSE)=TRUE THEN
                          BEGIN
                            ApprovalMgt.OnCancelLoanTrancheApprovalRequest(Rec);
                          END;*/

                        Status := Status::Open;
                        Modify;
                        Message('Cancelled Successfully');

                    end;
                }
                action(Approval1)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approvals';
                    Image = Approval;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = false;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                    begin
                        /*
                        IF Status<>Status::Pending THEN
                        ERROR('Status must be pending');
                        ApprovalPermissions.RESET;
                        ApprovalPermissions.SETRANGE(ApprovalPermissions."User ID",USERID);
                        ApprovalPermissions.SETRANGE(ApprovalPermissions."Function",ApprovalPermissions."Function"::"ATM Approval");
                        IF ApprovalPermissions.FIND('-') = FALSE THEN
                        ERROR('You do not have permissions to Approve partial.');
                        Status:=Status::Approved;
                        MODIFY;
                        MESSAGE('Application'+"Document No"+'Successful approved');
                        */

                    end;
                }
            }
        }
    }

    var
        LineNo: Integer;
        LoanPrinciple: Decimal;
        InstalNo: Integer;
        TotalMRepay: Decimal;
        BATCH_TEMPLATE: Code[30];
        BATCH_NAME: Code[30];
        DOCUMENT_NO: Code[30];
        SFactory: Codeunit "SURESTEP Factory";
        GenJournalLine: Record "Gen. Journal Line";
        LoanApps: Record "Loans Register";
        LoansReschedule: Record "Loan Rescheduling";
        SaccoGeneralSetUp: Record "Sacco General Set-Up";
}

