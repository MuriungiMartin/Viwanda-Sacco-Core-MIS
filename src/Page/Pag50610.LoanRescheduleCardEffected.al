#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50610 "Loan Reschedule Card-Effected"
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
                field("Loan Insurance"; "Loan Insurance")
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
                action("Rescedule Loan")
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
                                //LoanSchedule.SETRANGE(LoanSchedule."Reschedule Code","Document No"); //Commented
                                LoanSchedule.DeleteAll;
                                //End of Delete Schedule

                                LoanAmount := "Outstanding Loan Amount";
                                LoanBal := LoanAmount;
                                InterestRate := LoanRegister.Interest;
                                Installments := "New Installments";
                                RepayDate := "Repayment Start Date";//LoanRegister."Repayment Start Date";
                                                                    //MESSAGE('start date is %1',RepayDate);
                                InstalNo := 0;

                                //United Women Sacco Shares Contribution:
                                if Confirm(SharesTxt) = true then begin
                                    SharesBand.Reset;
                                    SharesBand.SetFilter(SharesBand."Minimum Amount", '<=%1', LoanAmount);
                                    SharesBand.SetFilter(SharesBand."Maximum Amount", '>=%1', LoanAmount);
                                    if SharesBand.Find('-') then begin
                                        SharesContribution := SharesBand."Minimum Dep Contributions";
                                    end;
                                end else begin
                                    SharesContribution := 0;
                                end;



                                InsuranceContribution := "Loan Insurance";


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
                                        LoanRegister.Modify;
                                    end;
                                    if LoanRegister."Repayment Method" = LoanRegister."repayment method"::"Straight Line" then begin
                                        LoanPrinciple := LoanAmount / Installments;
                                        LoanInterest := (InterestRate / 12 / 100) * LoanAmount;
                                        LoanRegister."Loan Principle Repayment" := LoanPrinciple;
                                        LoanRegister."Loan Interest Repayment" := LoanInterest;
                                        LoanRegister.Modify;
                                    end;

                                    //*******************If Amortised****************************//

                                    if LoanRegister."Repayment Method" = LoanRegister."repayment method"::Amortised then begin
                                        TotalMRepay := ROUND((InterestRate / 12 / 100) / (1 - Power((1 + (InterestRate / 12 / 100)), -("New Installments"))) * (LoanAmount), 0.05, '>');
                                        LoanInterest := ROUND(LoanBal / 100 / 12 * InterestRate, 0.05, '>');
                                        LoanPrinciple := TotalMRepay - LoanInterest;
                                        LoanRegister."Loan Principle Repayment" := LoanPrinciple;
                                        LoanRegister."Loan Interest Repayment" := LoanInterest;
                                        LoanRegister.Repayment := TotalMRepay;
                                        LoanRegister.Modify;
                                    end;


                                    //MESSAGE('method is %1',LoanRegister."Repayment Method");

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

                                    /*IF "Active Schedule"=TRUE THEN
                                    BEGIN
                                      LoanSchedule."Active Schedule":=TRUE;
                                    END;*/
                                    LoanSchedule.Insert;
                                until LoanBal < 1;

                                /* LoanSchedule.RESET;
                                 LoanSchedule.SETRANGE(LoanSchedule."Loan No.","Loan No");
                                 LoanSchedule.SETFILTER(LoanSchedule."Reschedule Code",'<>%1',"Document No");
                                 IF  LoanSchedule.FIND('-') THEN
                                   BEGIN
                                     REPEAT
                                     IF "Active Schedule"=TRUE THEN
                                       BEGIN
                                         LoanSchedule."Active Schedule":=FALSE;
                                         LoanSchedule.MODIFY;
                                       END;
                                       UNTIL LoanSchedule.NEXT=0;
                                   END;*/
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


                        Status := Status::Approved;
                        Modify;
                        Message('Approved Automatically');
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
        LoanPrinciple: Decimal;
        InstalNo: Integer;
        TotalMRepay: Decimal;
}

