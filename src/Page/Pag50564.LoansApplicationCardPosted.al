#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50564 "Loans Application Card(Posted)"
{
    DelayedInsert = false;
    DeleteAllowed = false;
    PageType = Card;
    ShowFilter = false;
    SourceTable = "Loans Register";
    Editable = true;
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                group(Control70)
                {
                    Editable = false;
                    field("Loan  No."; "Loan  No.")
                    {
                        ApplicationArea = Basic;
                        Editable = false;
                    }
                    field("Staff No"; "Staff No")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Staff No';
                        Editable = false;
                    }
                    field("Client Code"; "Client Code")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Member';
                        Editable = MNoEditable;
                    }
                    field("Account No"; "Account No")
                    {
                        ApplicationArea = Basic;
                        Editable = AccountNoEditable;
                    }
                    field("Client Name"; "Client Name")
                    {
                        ApplicationArea = Basic;
                        Editable = false;
                    }
                    field("ID NO"; "ID NO")
                    {
                        ApplicationArea = Basic;
                        Editable = false;
                    }
                    field("Global Dimension 2 Code"; "Global Dimension 2 Code")
                    {
                        ApplicationArea = Basic;
                        Editable = false;
                    }
                    field("Member Deposits"; "Member Deposits")
                    {
                        ApplicationArea = Basic;
                        Editable = false;
                    }
                    field("Application Date"; "Application Date")
                    {
                        ApplicationArea = Basic;
                        Editable = false;

                        trigger OnValidate()
                        begin
                            TestField(Posted, false);
                        end;
                    }
                    field("Loan Product Type"; "Loan Product Type")
                    {
                        ApplicationArea = Basic;
                        Editable = false;
                    }
                    field(Source; Source)
                    {
                        ApplicationArea = Basic;
                    }
                    field(Installments; Installments)
                    {
                        ApplicationArea = Basic;
                        Editable = false;

                        trigger OnValidate()
                        begin
                            TestField(Posted, false);
                        end;
                    }
                    field(Interest; Interest)
                    {
                        ApplicationArea = Basic;
                        Editable = false;
                    }
                    field("Product Currency Code"; "Product Currency Code")
                    {
                        ApplicationArea = Basic;
                        Editable = false;
                        Enabled = true;
                        Visible = false;
                    }
                    field("Requested Amount"; "Requested Amount")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Amount Applied';
                        Editable = false;

                        trigger OnValidate()
                        begin
                            TestField(Posted, false);
                        end;
                    }
                    field("Boost this Loan"; "Boost this Loan")
                    {
                        ApplicationArea = Basic;
                        Editable = false;
                    }
                    field("Boosted Amount"; "Boosted Amount")
                    {
                        ApplicationArea = Basic;
                        Editable = false;
                    }
                    field("Recommended Amount"; "Recommended Amount")
                    {
                        ApplicationArea = Basic;
                        Editable = false;
                    }
                    field("Approved Amount"; "Approved Amount")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Approved Amount';
                        Editable = false;

                        trigger OnValidate()
                        begin
                            TestField(Posted, false);
                        end;
                    }
                    field("Tranch Amount Disbursed"; "Tranch Amount Disbursed")
                    {
                        ApplicationArea = Basic;
                    }
                    field("Loan Purpose"; "Loan Purpose")
                    {
                        ApplicationArea = Basic;
                        Editable = false;
                        Visible = false;
                    }
                    field(Remarks; Remarks)
                    {
                        ApplicationArea = Basic;
                        Editable = false;
                        Visible = true;
                    }
                    field("Repayment Method"; "Repayment Method")
                    {
                        ApplicationArea = Basic;
                        Editable = false;
                    }
                    field(Repayment; Repayment)
                    {
                        ApplicationArea = Basic;
                        Editable = false;
                    }
                    field("Grace Period - Principle (M)"; "Grace Period - Principle (M)")
                    {
                        ApplicationArea = Basic;
                    }
                    field("Grace Period - Interest (M)"; "Grace Period - Interest (M)")
                    {
                        ApplicationArea = Basic;
                    }
                    field("Loan Principle Repayment"; "Loan Principle Repayment")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Principle Repayment';
                        Editable = false;
                        Importance = Promoted;
                        Style = Favorable;
                        StyleExpr = true;
                    }
                    field("Loan Interest Repayment"; "Loan Interest Repayment")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Interest Repayment';
                        Editable = false;
                        Importance = Promoted;
                        Style = Favorable;
                        StyleExpr = true;
                    }
                    field("Approved Repayment"; "Approved Repayment")
                    {
                        ApplicationArea = Basic;
                        Visible = false;
                    }
                    field("Loan Status"; "Loan Status")
                    {
                        ApplicationArea = Basic;
                        Editable = false;

                        trigger OnValidate()
                        begin
                            //UpdateControl();
                        end;
                    }
                    field("Batch No."; "Batch No.")
                    {
                        ApplicationArea = Basic;
                        Editable = false;
                        Visible = false;
                    }
                    field("Member House Group"; "Member House Group")
                    {
                        ApplicationArea = Basic;
                        Editable = false;
                    }
                    field("Member House Group Name"; "Member House Group Name")
                    {
                        ApplicationArea = Basic;
                        Editable = false;
                    }
                }
                group(Control71)
                {
                    Editable = false;
                    field("Credit Officer II"; "Credit Officer II")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Credit Officer';
                    }
                    field("Loan Centre"; "Loan Centre")
                    {
                        ApplicationArea = Basic;
                        Editable = false;
                    }
                    field("Captured By"; "Captured By")
                    {
                        ApplicationArea = Basic;
                        Editable = false;
                    }
                    field("Loan Offset Amount"; "Loan Offset Amount")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Bridged Amount';
                        Editable = false;
                    }
                    field("Repayment Frequency"; "Repayment Frequency")
                    {
                        ApplicationArea = Basic;
                        Editable = false;
                    }
                    field("Mode of Disbursement"; "Mode of Disbursement")
                    {
                        ApplicationArea = Basic;
                    }
                    field("Loan Disbursement Date"; "Loan Disbursement Date")
                    {
                        ApplicationArea = Basic;
                        AssistEdit = true;
                        Editable = false;
                        Enabled = EditableField;
                        Importance = Promoted;
                        NotBlank = true;
                        ShowMandatory = true;
                        Style = Favorable;
                        StyleExpr = true;
                    }
                    field("Cheque No."; "Cheque No.")
                    {
                        ApplicationArea = Basic;
                        Editable = false;
                        Visible = false;

                        trigger OnValidate()
                        begin
                            if StrLen("Cheque No.") > 6 then
                                Error('Document No. cannot contain More than 6 Characters.');
                        end;
                    }
                    field("Repayment Start Date"; "Repayment Start Date")
                    {
                        ApplicationArea = Basic;
                        Editable = false;
                    }
                    field("Expected Date of Completion"; "Expected Date of Completion")
                    {
                        ApplicationArea = Basic;
                        Editable = true;
                    }
                    field("External EFT"; "External EFT")
                    {
                        ApplicationArea = Basic;
                        Editable = false;
                        Visible = false;
                    }
                    field("Approval Status"; "Approval Status")
                    {
                        ApplicationArea = Basic;
                        Editable = false;
                    }
                    field("partially Bridged"; "partially Bridged")
                    {
                        ApplicationArea = Basic;
                        Editable = false;
                        Visible = false;
                    }
                    field(Posted; Posted)
                    {
                        ApplicationArea = Basic;
                        Editable = false;
                        Visible = false;
                    }
                    field("Total Offset Commission"; "Total Offset Commission")
                    {
                        ApplicationArea = Basic;
                        Editable = false;
                    }
                    field("Rejection  Remark"; "Rejection  Remark")
                    {
                        ApplicationArea = Basic;
                        Editable = false;
                    }
                    field("Recovery Mode"; "Recovery Mode")
                    {
                        ApplicationArea = Basic;
                    }
                }
                group(Control69)
                {
                    field("Loan Recovery Account FOSA"; "Loan Recovery Account FOSA")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Repayment Account FOSA';
                    }
                }
                group(Control72)
                {
                    Editable = false;
                    Visible = RescheduledVisible;
                    field(Rescheduled; Rescheduled)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Loan Restructured';
                    }
                    field("Loan Rescheduled Date"; "Loan Rescheduled Date")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Restructured On';
                    }
                    field("Loan Rescheduled By"; "Loan Rescheduled By")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Restructured By';
                    }
                    field("Loan to Reschedule"; "Loan to Reschedule")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Restructured Loan No';
                    }
                    field("Reason For Loan Reschedule"; "Reason For Loan Reschedule")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Reason for Restructure';
                    }
                }
                part(Control42; "Loan Application Stages")
                {
                    Caption = 'Loan Stages';
                    SubPageLink = "Loan No" = field("Loan  No.");
                }
            }
            group("Salary Details")
            {
                Caption = 'Salary Details';
                Editable = false;
                group(Earnings)
                {
                    Caption = 'Earnings';
                    field("Basic Pay H"; "Basic Pay H")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Basic Pay';
                    }
                    field("House AllowanceH"; "House AllowanceH")
                    {
                        ApplicationArea = Basic;
                        Caption = 'House Allowance';
                    }
                    field("Medical AllowanceH"; "Medical AllowanceH")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Medical Allowance';
                    }
                    field("Transport/Bus Fare"; "Transport/Bus Fare")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Commutter  Allowance';
                    }
                    field("Other Income"; "Other Income")
                    {
                        ApplicationArea = Basic;
                    }
                    field(GrossPay; GrossPay)
                    {
                        ApplicationArea = Basic;
                        Visible = false;
                    }
                    field("Gross Pay"; "Gross Pay")
                    {
                        ApplicationArea = Basic;
                        Editable = false;
                    }
                    field(Nettakehome; Nettakehome)
                    {
                        ApplicationArea = Basic;
                        Visible = false;
                    }
                    field("Provident Fund"; "Provident Fund")
                    {
                        ApplicationArea = Basic;
                        Visible = false;
                    }
                }
                group("Non-Taxable Deductions")
                {
                    Caption = 'Non-Taxable Deductions';
                    Visible = false;
                    field("Pension Scheme"; "Pension Scheme")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Total Provident Fund';
                    }
                    field("Other Non-Taxable"; "Other Non-Taxable")
                    {
                        ApplicationArea = Basic;
                    }
                    field("Other Tax Relief"; "Other Tax Relief")
                    {
                        ApplicationArea = Basic;
                    }
                }
                group(Deductions)
                {
                    Caption = 'Deductions';
                    field(PAYE; PAYE)
                    {
                        ApplicationArea = Basic;
                    }
                    field(NSSF; NSSF)
                    {
                        ApplicationArea = Basic;
                    }
                    field(NHIF; NHIF)
                    {
                        ApplicationArea = Basic;
                    }
                    field("Staff Union Contribution"; "Staff Union Contribution")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Union Dues';
                    }
                    field("Monthly Contribution"; "Monthly Contribution")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Deposits';
                    }
                    field("Risk MGT"; "Risk MGT")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Benevolent Fund';
                        Visible = false;
                    }
                    field("Medical Insurance"; "Medical Insurance")
                    {
                        ApplicationArea = Basic;
                    }
                    field("Life Insurance"; "Life Insurance")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Gold Save / NIS';
                        Visible = false;
                    }
                    field("Provident Fund (Self)"; "Provident Fund (Self)")
                    {
                        ApplicationArea = Basic;
                        Visible = false;
                    }
                    field("Other Liabilities"; "Other Liabilities")
                    {
                        ApplicationArea = Basic;
                        Visible = false;
                    }
                    field("Sacco Deductions"; "Sacco Deductions")
                    {
                        ApplicationArea = Basic;
                    }
                    field("Existing Loan Repayments"; "Existing Loan Repayments")
                    {
                        ApplicationArea = Basic;
                        Editable = false;
                    }
                    field("Other Loans Repayments"; "Other Loans Repayments")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Bank Loan Repayments';
                    }
                    field("Excess LSA Recovery"; "Excess LSA Recovery")
                    {
                        ApplicationArea = Basic;
                        Visible = false;
                    }
                    field("Total Deductions"; "Total Deductions")
                    {
                        ApplicationArea = Basic;
                    }
                    field(UtilizableAmount; "Utilizable Amount")
                    {
                        ApplicationArea = Basic;
                        Visible = false;
                    }
                    field("Bridge Amount Release"; "Bridge Amount Release")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Cleared Loan Repayment';
                        Visible = false;
                    }
                    field("Net Utilizable Amount"; "Net Utilizable Amount")
                    {
                        ApplicationArea = Basic;
                    }
                }
            }
            group("Statement Details")
            {
                Caption = 'Statement Details';
                Editable = false;
                field("Bank Statement Avarage Credits"; "Bank Statement Avarage Credits")
                {
                    ApplicationArea = Basic;
                }
                field("Bank Statement Avarage Debits"; "Bank Statement Avarage Debits")
                {
                    ApplicationArea = Basic;
                }
                group("Monthly Expenses Details")
                {
                    Caption = 'Monthly Expenses Details';
                    Editable = false;
                    field("BSExpenses Rent"; "BSExpenses Rent")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Rent';
                    }
                    field("BSExpenses Transport"; "BSExpenses Transport")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Transport';
                    }
                    field("BSExpenses Education"; "BSExpenses Education")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Education';
                    }
                    field("BSExpenses Food"; "BSExpenses Food")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Food';
                    }
                    field("BSExpenses Utilities"; "BSExpenses Utilities")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Utilities';
                    }
                    field("BSExpenses Others"; "BSExpenses Others")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Others';
                    }
                    field("<Exisiting Loans Repayments.>"; "Exisiting Loans Repayments")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Exisiting Loans Repayments.';
                    }
                }
                field("Bank Statement Net Income"; "Bank Statement Net Income")
                {
                    ApplicationArea = Basic;
                }
            }
            part(Control16; "Loans Guarantee Details")
            {
                Caption = 'Guarantors  Detail';
                Editable = false;
                SubPageLink = "Loan No" = field("Loan  No.");
            }
            part(Control15; "Loan Collateral Security")
            {
                Caption = 'Other Securities';
                Editable = true;
                SubPageLink = "Loan No" = field("Loan  No.");
            }
            // part("<Mobile loan Appraisal>";"E Banking loan Appraisal")
            // {
            //     Caption = 'E-Banking Loan Appraisal';
            //     Editable = false;
            //     SubPageLink = "Document No"=field("Doc No Used");
            // }
            group("Repayment Date Change")
            {
                field("Reschedule Effective Date"; "Reschedule Effective Date")
                {
                    ApplicationArea = Basic;
                }
                field("New Repayment Start Date"; "New Repayment Start Date")
                {
                    ApplicationArea = Basic;
                }
                field("Repayment Dates Rescheduled"; "Repayment Dates Rescheduled")
                {
                    ApplicationArea = Basic;
                    Caption = 'Repayment Dates Changed';
                    Editable = false;
                }
                field("Repayment Dates Rescheduled On"; "Repayment Dates Rescheduled On")
                {
                    ApplicationArea = Basic;
                    Caption = 'Repayment Dates Changed On';
                    Editable = false;
                }
                field("Repayment Dates Rescheduled By"; "Repayment Dates Rescheduled By")
                {
                    ApplicationArea = Basic;
                    Caption = 'Repayment Dates Changed By';
                    Editable = false;
                }
            }
            group("Skip Loan Installment")
            {
                field("Installment Date to Skip From"; "Installment Date to Skip From")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Installments to Skip"; "Loan Installments to Skip")
                {
                    ApplicationArea = Basic;
                    Caption = 'No of Loan Installments to Skip';
                }
                field("Skip Installments Effected"; "Skip Installments Effected")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Skip Installments Effected By"; "Skip Installments Effected By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Skip Installments Effected On"; "Skip Installments Effected On")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            group("Debt Collections Details")
            {
                Caption = 'Debt Collections Details';
                field("Loan Debt Collector"; "Loan Debt Collector")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Debt Collector Interest %"; "Loan Debt Collector Interest %")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Debt Collection date Assigned"; "Debt Collection date Assigned")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Debt Collector Name"; "Debt Collector Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Loan Bal As At Debt Collection"; "Loan Bal As At Debt Collection")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loan Bal As At Debt Collection Assignment';
                    Editable = false;
                }
            }
            group("Auctioneer Details")
            {
                field("Loan Auctioneer"; "Loan Auctioneer")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Auctioneer Name"; "Loan Auctioneer Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Date Auctioneer Assigned"; "Date Auctioneer Assigned")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            group(Exemptions)
            {
                Caption = 'Exemptions';
                field("Freeze Interest Accrual"; "Freeze Interest Accrual")
                {
                    ApplicationArea = Basic;
                    Caption = 'Stop Interest Accrual';
                }
                field("Except From Penalty"; "Except From Penalty")
                {
                    ApplicationArea = Basic;
                    Caption = 'Stop Penalty Accrual';
                }
                field("Freeze Until"; "Freeze Until")
                {
                    ApplicationArea = Basic;
                    Caption = 'Interest Acrual Resume Date';
                }
                field("Exempt From Payroll Deduction"; "Exempt From Payroll Deduction")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Loan)
            {
                Caption = 'Loan';
                Image = AnalysisView;
                action("Loan Appraisal")
                {
                    ApplicationArea = Basic;
                    Caption = 'View Loan Appraisal';
                    Enabled = true;
                    Image = GanttChart;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        TestField("Mode of Disbursement");
                        LoanApp.Reset;
                        LoanApp.SetRange(LoanApp."Loan  No.", "Loan  No.");
                        if LoanApp.Find('-') then begin
                            if LoanApp.Source = LoanApp.Source::BOSA then
                                Report.run(50355, true, false, LoanApp)
                            else
                                Report.run(50355, true, false, LoanApp)
                        end;
                    end;
                }
                action("Member Ledger Entries")
                {
                    ApplicationArea = Basic;
                    Caption = 'Ledger Entries';
                    Image = CustomerLedger;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedOnly = true;
                    RunObject = Page "Member Ledger Entries";
                    RunPageLink = "Loan No" = field("Loan  No.");
                    RunPageView = sorting("Customer No.");
                }
                action("Go to FOSA Accounts")
                {
                    ApplicationArea = Basic;
                    Image = List;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Member Accounts List";
                    RunPageLink = "BOSA Account No" = field("Client Code");
                }
                action("Guarantors' Report")
                {
                    ApplicationArea = Basic;
                    Image = SelectReport;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        Cust.Reset;
                        Cust.SetRange(Cust."No.", "Client Code");
                        Cust.SetFilter("Loan No. Filter", "Loan  No.");
                        Cust.SetFilter("Loan Product Filter", "Loan Product Type");
                        if Cust.Find('-') then
                            Report.run(50504, true, false, Cust);
                    end;
                }
                action("Loan Statement")
                {
                    ApplicationArea = Basic;
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        Cust.Reset;
                        Cust.SetRange(Cust."No.", "Client Code");
                        Cust.SetFilter("Loan No. Filter", "Loan  No.");
                        Cust.SetFilter("Loan Product Filter", "Loan Product Type");
                        if Cust.Find('-') then
                            Report.run(50531, true, false, Cust);
                    end;
                }
                action("Member Statement")
                {
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        Cust.Reset;
                        Cust.SetRange(Cust."No.", "Client Code");
                        Report.run(50886, true, false, Cust);
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
                    RunPageLink = "No." = field("Client Code");
                }
                action("Generate Repayment Schedule")
                {
                    ApplicationArea = Basic;
                    Caption = 'Generate Repayment Schedule';
                    Image = "Table";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedOnly = true;
                    ShortCutKey = 'Ctrl+F7';
                    Visible = true;

                    trigger OnAction()
                    begin
                        SFactory.FnGenerateLoanRepaymentSchedule("Loan  No.");
                        //SFactory.FnRunLoanAmountDue("Loan  No.");
                        //COMMIT;

                        LoanApp.Reset;
                        LoanApp.SetRange(LoanApp."Loan  No.", "Loan  No.");
                        if LoanApp.Find('-') then begin
                            Commit;
                            Report.Run(50477, true, false, LoanApp);
                        end;
                    end;
                }
                action("Loan Repayment Schedule")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loan Repayment Schedule';
                    Image = "Table";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedOnly = true;
                    ShortCutKey = 'Ctrl+F7';

                    trigger OnAction()
                    begin
                        /*SFactory.FnRunLoanAmountDue("Loan  No.");
                        COMMIT;*/

                        SFactory.FnGenerateLoanRepaymentSchedule("Loan  No.");
                        Commit;


                        LoanApp.Reset;
                        LoanApp.SetRange(LoanApp."Loan  No.", "Loan  No.");
                        if LoanApp.Find('-') then
                            Report.run(50949, true, false, LoanApp);

                    end;
                }
                action("Reschedule Repayment Date")
                {
                    ApplicationArea = Basic;
                    Caption = 'Reschedule Loan Repayment Date';
                    Image = Form;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        VarScheduleDay: Integer;
                        VarScheduleMonth: Integer;
                        VarScheduleYear: Integer;
                        VarInstallmentNo: Integer;
                        VarPeriodIncreament: Text;
                    begin
                        TestField("New Repayment Start Date");
                        if Confirm('Confirm you Want to Change Repayment Dates for  this Loan?', false) = true then begin
                            VarInstallmentNo := 0;
                            VarNewInstalmentDate := "New Repayment Start Date";
                            //=======================================================================Loan Repayment Schedule
                            ObjLoanRepaymentSchedule.Reset;
                            ObjLoanRepaymentSchedule.SetCurrentkey(ObjLoanRepaymentSchedule."Repayment Date");
                            ObjLoanRepaymentSchedule.SetRange(ObjLoanRepaymentSchedule."Loan No.", "Loan  No.");
                            ObjLoanRepaymentSchedule.SetFilter(ObjLoanRepaymentSchedule."Repayment Date", '>=%1', "Reschedule Effective Date");
                            if ObjLoanRepaymentSchedule.FindSet then begin
                                repeat
                                    ObjLoanRepaymentSchedule.ToDelete := true;
                                    ObjLoanRepaymentSchedule.Modify;
                                until ObjLoanRepaymentSchedule.Next = 0;
                            end;

                            ObjLoanRepaymentSchedule.Reset;
                            ObjLoanRepaymentSchedule.SetCurrentkey(ObjLoanRepaymentSchedule."Repayment Date");
                            ObjLoanRepaymentSchedule.SetRange(ObjLoanRepaymentSchedule."Loan No.", "Loan  No.");
                            ObjLoanRepaymentSchedule.SetFilter(ObjLoanRepaymentSchedule."Repayment Date", '>=%1', "Reschedule Effective Date");
                            ObjLoanRepaymentSchedule.SetRange(ObjLoanRepaymentSchedule.ToDelete, true);
                            if ObjLoanRepaymentSchedule.FindSet then begin
                                ObjLoanRepaymentScheduleII.Reset;
                                ObjLoanRepaymentScheduleII.SetCurrentkey(ObjLoanRepaymentScheduleII."Entry No");
                                if ObjLoanRepaymentScheduleII.FindLast then
                                    ScheduleEntryNo := ObjLoanRepaymentScheduleII."Entry No" + 1;

                                repeat
                                    ObjLoanRepaymentScheduleII.Init;
                                    ObjLoanRepaymentScheduleII."Loan No." := ObjLoanRepaymentSchedule."Loan No.";
                                    ObjLoanRepaymentScheduleII."Entry No" := ScheduleEntryNo;
                                    ObjLoanRepaymentScheduleII."Loan Amount" := ObjLoanRepaymentSchedule."Loan Amount";
                                    ObjLoanRepaymentScheduleII."Instalment No" := ObjLoanRepaymentSchedule."Instalment No";
                                    ObjLoanRepaymentScheduleII."Repayment Date" := VarNewInstalmentDate;
                                    ObjLoanRepaymentScheduleII."Member No." := ObjLoanRepaymentSchedule."Member No.";
                                    ObjLoanRepaymentScheduleII."Loan Category" := ObjLoanRepaymentSchedule."Loan Category";
                                    ObjLoanRepaymentScheduleII."Monthly Repayment" := ObjLoanRepaymentSchedule."Monthly Repayment";
                                    ObjLoanRepaymentScheduleII."Principal Repayment" := ObjLoanRepaymentSchedule."Principal Repayment";
                                    ObjLoanRepaymentScheduleII."Monthly Interest" := ObjLoanRepaymentSchedule."Monthly Interest";
                                    ObjLoanRepaymentScheduleII."Monthly Insurance" := ObjLoanRepaymentSchedule."Monthly Insurance";
                                    ObjLoanRepaymentScheduleII."Loan Balance" := ObjLoanRepaymentSchedule."Loan Balance";
                                    ObjLoanRepaymentScheduleII.Insert;

                                    VarInstallmentNo := VarInstallmentNo + 1;
                                    ScheduleEntryNo := ScheduleEntryNo + 1;
                                    VarPeriodIncreament := Format(VarInstallmentNo) + 'M';
                                    VarNewInstalmentDate := CalcDate(VarPeriodIncreament, "New Repayment Start Date");
                                until ObjLoanRepaymentSchedule.Next = 0;
                            end;

                            ObjLoanRepaymentSchedule.Reset;
                            ObjLoanRepaymentSchedule.SetCurrentkey(ObjLoanRepaymentSchedule."Repayment Date");
                            ObjLoanRepaymentSchedule.SetRange(ObjLoanRepaymentSchedule."Loan No.", "Loan  No.");
                            ObjLoanRepaymentSchedule.SetFilter(ObjLoanRepaymentSchedule."Repayment Date", '>=%1', "Reschedule Effective Date");
                            ObjLoanRepaymentSchedule.SetRange(ObjLoanRepaymentSchedule.ToDelete, true);
                            if ObjLoanRepaymentSchedule.FindSet then
                                ObjLoanRepaymentSchedule.DeleteAll;

                            //=======================================================================Loan Repayment Schedule  Temp

                            ObjLoanRepaymentScheduleTemp.Reset;
                            ObjLoanRepaymentScheduleTemp.SetCurrentkey(ObjLoanRepaymentScheduleTemp."Repayment Date");
                            ObjLoanRepaymentScheduleTemp.SetRange(ObjLoanRepaymentScheduleTemp."Loan No.", "Loan  No.");
                            ObjLoanRepaymentScheduleTemp.SetFilter(ObjLoanRepaymentScheduleTemp."Repayment Date", '>=%1', "Reschedule Effective Date");
                            if ObjLoanRepaymentScheduleTemp.FindSet then begin
                                repeat
                                    ObjLoanRepaymentScheduleTemp.ToDelete := true;
                                    ObjLoanRepaymentScheduleTemp.Modify;
                                until ObjLoanRepaymentScheduleTemp.Next = 0;
                            end;

                            ObjLoanRepaymentScheduleTempII.Reset;
                            ObjLoanRepaymentScheduleTempII.SetCurrentkey(ObjLoanRepaymentScheduleTempII."Entry No");
                            if ObjLoanRepaymentScheduleTempII.FindLast then
                                ScheduleEntryNo := ObjLoanRepaymentScheduleTempII."Entry No" + 1;

                            VarInstallmentNo := 0;
                            VarNewInstalmentDate := "New Repayment Start Date";

                            ObjLoanRepaymentScheduleTemp.Reset;
                            ObjLoanRepaymentScheduleTemp.SetCurrentkey(ObjLoanRepaymentScheduleTemp."Repayment Date");
                            ObjLoanRepaymentScheduleTemp.SetRange(ObjLoanRepaymentScheduleTemp."Loan No.", "Loan  No.");
                            ObjLoanRepaymentScheduleTemp.SetFilter(ObjLoanRepaymentScheduleTemp."Repayment Date", '>=%1', "Reschedule Effective Date");
                            ObjLoanRepaymentScheduleTemp.SetRange(ObjLoanRepaymentScheduleTemp.ToDelete, true);
                            if ObjLoanRepaymentScheduleTemp.FindSet then begin
                                repeat
                                    ObjLoanRepaymentScheduleTempII.Init;
                                    ObjLoanRepaymentScheduleTempII."Loan No." := ObjLoanRepaymentScheduleTemp."Loan No.";
                                    ObjLoanRepaymentScheduleTempII."Entry No" := ScheduleEntryNo;
                                    ObjLoanRepaymentScheduleTempII."Loan Amount" := ObjLoanRepaymentScheduleTemp."Loan Amount";
                                    ObjLoanRepaymentScheduleTempII."Instalment No" := ObjLoanRepaymentScheduleTemp."Instalment No";
                                    ObjLoanRepaymentScheduleTempII."Repayment Date" := VarNewInstalmentDate;
                                    ObjLoanRepaymentScheduleTempII."Member No." := ObjLoanRepaymentScheduleTemp."Member No.";
                                    ObjLoanRepaymentScheduleTempII."Loan Category" := ObjLoanRepaymentScheduleTemp."Loan Category";
                                    ObjLoanRepaymentScheduleTempII."Monthly Repayment" := ObjLoanRepaymentScheduleTemp."Monthly Repayment";
                                    ObjLoanRepaymentScheduleTempII."Principal Repayment" := ObjLoanRepaymentScheduleTemp."Principal Repayment";
                                    ObjLoanRepaymentScheduleTempII."Monthly Interest" := ObjLoanRepaymentScheduleTemp."Monthly Interest";
                                    ObjLoanRepaymentScheduleTempII."Monthly Insurance" := ObjLoanRepaymentScheduleTemp."Monthly Insurance";
                                    ObjLoanRepaymentScheduleTempII."Loan Balance" := ObjLoanRepaymentScheduleTemp."Loan Balance";
                                    ObjLoanRepaymentScheduleTempII.Insert;

                                    VarInstallmentNo := VarInstallmentNo + 1;
                                    ScheduleEntryNo := ScheduleEntryNo + 1;
                                    VarPeriodIncreament := Format(VarInstallmentNo) + 'M';
                                    VarNewInstalmentDate := CalcDate(VarPeriodIncreament, "New Repayment Start Date");
                                until ObjLoanRepaymentScheduleTemp.Next = 0;
                            end;

                            ObjLoanRepaymentScheduleTemp.Reset;
                            ObjLoanRepaymentScheduleTemp.SetCurrentkey(ObjLoanRepaymentScheduleTemp."Repayment Date");
                            ObjLoanRepaymentScheduleTemp.SetRange(ObjLoanRepaymentScheduleTemp."Loan No.", "Loan  No.");
                            ObjLoanRepaymentScheduleTemp.SetFilter(ObjLoanRepaymentScheduleTemp."Repayment Date", '>=%1', "Reschedule Effective Date");
                            ObjLoanRepaymentScheduleTemp.SetRange(ObjLoanRepaymentScheduleTemp.ToDelete, true);
                            if ObjLoanRepaymentScheduleTemp.FindSet then
                                ObjLoanRepaymentScheduleTemp.DeleteAll;

                            "Repayment Dates Rescheduled" := true;
                            "Repayment Dates Rescheduled By" := UserId;
                            "Repayment Dates Rescheduled On" := Today;
                            Message('Loan Repayment Date Changed Succesfully');
                        end;
                    end;
                }
                action("Skip Loan Installments")
                {
                    ApplicationArea = Basic;
                    Caption = 'Skip Loan Installments';
                    Image = Form;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        VarScheduleDay: Integer;
                        VarScheduleMonth: Integer;
                        VarScheduleYear: Integer;
                        VarInstallmentNo: Integer;
                        VarPeriodIncreament: Text;
                    begin
                        TestField("Installment Date to Skip From");
                        if "Loan Installments to Skip" = 0 then
                            Error('You must specify the No. of Loan Installments you want to Skip');

                        if Confirm('Confirm you Want to Skip Installments for  this Loan?', false) = true then begin
                            //=======================================================================Loan Repayment Schedule
                            ObjLoanRepaymentSchedule.Reset;
                            ObjLoanRepaymentSchedule.SetCurrentkey(ObjLoanRepaymentSchedule."Repayment Date");
                            ObjLoanRepaymentSchedule.SetRange(ObjLoanRepaymentSchedule."Loan No.", "Loan  No.");
                            ObjLoanRepaymentSchedule.SetFilter(ObjLoanRepaymentSchedule."Repayment Date", '>=%1', "Installment Date to Skip From");
                            if ObjLoanRepaymentSchedule.FindSet then begin
                                repeat
                                    ObjLoanRepaymentSchedule.ToDelete := true;
                                    ObjLoanRepaymentSchedule.Modify;
                                until ObjLoanRepaymentSchedule.Next = 0;
                            end;

                            ObjLoanRepaymentSchedule.Reset;
                            ObjLoanRepaymentSchedule.SetCurrentkey(ObjLoanRepaymentSchedule."Repayment Date");
                            ObjLoanRepaymentSchedule.SetRange(ObjLoanRepaymentSchedule."Loan No.", "Loan  No.");
                            ObjLoanRepaymentSchedule.SetFilter(ObjLoanRepaymentSchedule."Repayment Date", '>=%1', "Installment Date to Skip From");
                            if ObjLoanRepaymentSchedule.FindSet then begin
                                ObjLoanRepaymentScheduleII.Reset;
                                ObjLoanRepaymentScheduleII.SetCurrentkey(ObjLoanRepaymentScheduleII."Entry No");
                                if ObjLoanRepaymentScheduleII.FindLast then
                                    ScheduleEntryNo := ObjLoanRepaymentScheduleII."Entry No" + 1;

                                InstallmentsToSkip := "Loan Installments to Skip";
                                VarInstallmentNo := ObjLoanRepaymentSchedule."Instalment No";
                                RepaymentDateSkip := ObjLoanRepaymentSchedule."Repayment Date";

                                repeat
                                    ObjLoanRepaymentScheduleII.Init;
                                    ObjLoanRepaymentScheduleII."Loan No." := ObjLoanRepaymentSchedule."Loan No.";
                                    ObjLoanRepaymentScheduleII."Entry No" := ScheduleEntryNo;
                                    ObjLoanRepaymentScheduleII."Loan Amount" := ObjLoanRepaymentSchedule."Loan Amount";
                                    ObjLoanRepaymentScheduleII."Instalment No" := VarInstallmentNo;
                                    ObjLoanRepaymentScheduleII."Repayment Date" := RepaymentDateSkip;
                                    ObjLoanRepaymentScheduleII."Member No." := ObjLoanRepaymentSchedule."Member No.";
                                    ObjLoanRepaymentScheduleII."Loan Category" := ObjLoanRepaymentSchedule."Loan Category";
                                    ObjLoanRepaymentScheduleII."Monthly Repayment" := 0;
                                    ObjLoanRepaymentScheduleII."Principal Repayment" := 0;
                                    ObjLoanRepaymentScheduleII."Monthly Interest" := 0;
                                    ObjLoanRepaymentScheduleII."Monthly Insurance" := 0;
                                    ObjLoanRepaymentScheduleII."Loan Balance" := ObjLoanRepaymentSchedule."Loan Balance";
                                    ObjLoanRepaymentScheduleII.Insert;
                                    InstallmentsToSkip := InstallmentsToSkip - 1;
                                    VarInstallmentNo := VarInstallmentNo + 1;
                                    RepaymentDateSkip := CalcDate('1M', RepaymentDateSkip);
                                    ScheduleEntryNo := ScheduleEntryNo + 1;
                                until InstallmentsToSkip = 0;
                            end;

                            ObjLoanRepaymentSchedule.Reset;
                            ObjLoanRepaymentSchedule.SetCurrentkey(ObjLoanRepaymentSchedule."Instalment No");
                            ObjLoanRepaymentSchedule.SetRange(ObjLoanRepaymentSchedule."Loan No.", "Loan  No.");
                            ObjLoanRepaymentSchedule.SetFilter(ObjLoanRepaymentSchedule."Monthly Repayment", '<>%1', 0);
                            ObjLoanRepaymentSchedule.SetFilter(ObjLoanRepaymentSchedule."Repayment Date", '>=%1', "Installment Date to Skip From");
                            ObjLoanRepaymentSchedule.SetRange(ObjLoanRepaymentSchedule.ToDelete, true);
                            if ObjLoanRepaymentSchedule.FindSet then begin
                                repeat
                                    VarInstallmentNo := ObjLoanRepaymentSchedule."Instalment No" + "Loan Installments to Skip";
                                    VarNewInstalmentDate := CalcDate(Format("Loan Installments to Skip") + 'M', ObjLoanRepaymentSchedule."Repayment Date");

                                    ObjLoanRepaymentScheduleII.Init;
                                    ObjLoanRepaymentScheduleII."Loan No." := ObjLoanRepaymentSchedule."Loan No.";
                                    ObjLoanRepaymentScheduleII."Entry No" := ScheduleEntryNo;
                                    ObjLoanRepaymentScheduleII."Loan Amount" := ObjLoanRepaymentSchedule."Loan Amount";
                                    ObjLoanRepaymentScheduleII."Instalment No" := VarInstallmentNo;
                                    ObjLoanRepaymentScheduleII."Repayment Date" := VarNewInstalmentDate;
                                    ObjLoanRepaymentScheduleII."Member No." := ObjLoanRepaymentSchedule."Member No.";
                                    ObjLoanRepaymentScheduleII."Loan Category" := ObjLoanRepaymentSchedule."Loan Category";
                                    ObjLoanRepaymentScheduleII."Monthly Repayment" := ObjLoanRepaymentSchedule."Monthly Repayment";
                                    ObjLoanRepaymentScheduleII."Principal Repayment" := ObjLoanRepaymentSchedule."Principal Repayment";
                                    ObjLoanRepaymentScheduleII."Monthly Interest" := ObjLoanRepaymentSchedule."Monthly Interest";
                                    ObjLoanRepaymentScheduleII."Monthly Insurance" := ObjLoanRepaymentSchedule."Monthly Insurance";
                                    ObjLoanRepaymentScheduleII."Loan Balance" := ObjLoanRepaymentSchedule."Loan Balance";
                                    ObjLoanRepaymentScheduleII.Insert;

                                    ScheduleEntryNo := ScheduleEntryNo + 1;
                                until ObjLoanRepaymentSchedule.Next = 0;
                            end;

                            ObjLoanRepaymentSchedule.Reset;
                            ObjLoanRepaymentSchedule.SetCurrentkey(ObjLoanRepaymentSchedule."Instalment No");
                            ObjLoanRepaymentSchedule.SetRange(ObjLoanRepaymentSchedule."Loan No.", "Loan  No.");
                            ObjLoanRepaymentSchedule.SetFilter(ObjLoanRepaymentSchedule."Monthly Repayment", '<>%1', 0);
                            ObjLoanRepaymentSchedule.SetFilter(ObjLoanRepaymentSchedule."Repayment Date", '>=%1', "Installment Date to Skip From");
                            ObjLoanRepaymentSchedule.SetRange(ObjLoanRepaymentSchedule.ToDelete, true);
                            if ObjLoanRepaymentSchedule.FindSet then
                                ObjLoanRepaymentSchedule.DeleteAll;

                            //=======================================================================Loan Repayment Schedule  Temp

                            ObjLoanRepaymentScheduleTemp.Reset;
                            ObjLoanRepaymentScheduleTemp.SetCurrentkey(ObjLoanRepaymentScheduleTemp."Repayment Date");
                            ObjLoanRepaymentScheduleTemp.SetRange(ObjLoanRepaymentScheduleTemp."Loan No.", "Loan  No.");
                            ObjLoanRepaymentScheduleTemp.SetFilter(ObjLoanRepaymentScheduleTemp."Repayment Date", '>=%1', "Installment Date to Skip From");
                            if ObjLoanRepaymentScheduleTemp.FindSet then begin
                                repeat
                                    ObjLoanRepaymentScheduleTemp.ToDelete := true;
                                    ObjLoanRepaymentScheduleTemp.Modify;
                                until ObjLoanRepaymentScheduleTemp.Next = 0;
                            end;

                            ObjLoanRepaymentScheduleTemp.Reset;
                            ObjLoanRepaymentScheduleTemp.SetCurrentkey(ObjLoanRepaymentScheduleTemp."Repayment Date");
                            ObjLoanRepaymentScheduleTemp.SetRange(ObjLoanRepaymentScheduleTemp."Loan No.", "Loan  No.");
                            ObjLoanRepaymentScheduleTemp.SetFilter(ObjLoanRepaymentScheduleTemp."Repayment Date", '>=%1', "Installment Date to Skip From");
                            if ObjLoanRepaymentScheduleTemp.FindSet then begin
                                ObjLoanRepaymentScheduleTempII.Reset;
                                ObjLoanRepaymentScheduleTempII.SetCurrentkey(ObjLoanRepaymentScheduleTempII."Entry No");
                                if ObjLoanRepaymentScheduleTempII.FindLast then
                                    ScheduleEntryNo := ObjLoanRepaymentScheduleTempII."Entry No" + 1;

                                InstallmentsToSkip := "Loan Installments to Skip";
                                VarInstallmentNo := ObjLoanRepaymentScheduleTemp."Instalment No";
                                RepaymentDateSkip := ObjLoanRepaymentScheduleTemp."Repayment Date";

                                repeat
                                    ObjLoanRepaymentScheduleTempII.Init;
                                    ObjLoanRepaymentScheduleTempII."Loan No." := ObjLoanRepaymentScheduleTemp."Loan No.";
                                    ObjLoanRepaymentScheduleTempII."Entry No" := ScheduleEntryNo;
                                    ObjLoanRepaymentScheduleTempII."Loan Amount" := ObjLoanRepaymentScheduleTemp."Loan Amount";
                                    ObjLoanRepaymentScheduleTempII."Instalment No" := VarInstallmentNo;
                                    ObjLoanRepaymentScheduleTempII."Repayment Date" := RepaymentDateSkip;
                                    ObjLoanRepaymentScheduleTempII."Member No." := ObjLoanRepaymentScheduleTemp."Member No.";
                                    ObjLoanRepaymentScheduleTempII."Loan Category" := ObjLoanRepaymentScheduleTemp."Loan Category";
                                    ObjLoanRepaymentScheduleTempII."Monthly Repayment" := 0;
                                    ObjLoanRepaymentScheduleTempII."Principal Repayment" := 0;
                                    ObjLoanRepaymentScheduleTempII."Monthly Interest" := 0;
                                    ObjLoanRepaymentScheduleTempII."Monthly Insurance" := 0;
                                    ObjLoanRepaymentScheduleTempII."Loan Balance" := ObjLoanRepaymentScheduleTemp."Loan Balance";
                                    ObjLoanRepaymentScheduleTempII.Insert;
                                    InstallmentsToSkip := InstallmentsToSkip - 1;
                                    VarInstallmentNo := VarInstallmentNo + 1;
                                    RepaymentDateSkip := CalcDate('1M', RepaymentDateSkip);
                                    ScheduleEntryNo := ScheduleEntryNo + 1;
                                until InstallmentsToSkip = 0;
                            end;

                            ObjLoanRepaymentScheduleTemp.Reset;
                            ObjLoanRepaymentScheduleTemp.SetCurrentkey(ObjLoanRepaymentScheduleTemp."Instalment No");
                            ObjLoanRepaymentScheduleTemp.SetRange(ObjLoanRepaymentScheduleTemp."Loan No.", "Loan  No.");
                            ObjLoanRepaymentScheduleTemp.SetFilter(ObjLoanRepaymentScheduleTemp."Monthly Repayment", '<>%1', 0);
                            ObjLoanRepaymentScheduleTemp.SetFilter(ObjLoanRepaymentScheduleTemp."Repayment Date", '>=%1', "Installment Date to Skip From");
                            ObjLoanRepaymentScheduleTemp.SetRange(ObjLoanRepaymentScheduleTemp.ToDelete, true);
                            if ObjLoanRepaymentScheduleTemp.FindSet then begin
                                repeat
                                    VarInstallmentNo := ObjLoanRepaymentScheduleTemp."Instalment No" + "Loan Installments to Skip";
                                    VarNewInstalmentDate := CalcDate(Format("Loan Installments to Skip") + 'M', ObjLoanRepaymentScheduleTemp."Repayment Date");

                                    ObjLoanRepaymentScheduleTempII.Init;
                                    ObjLoanRepaymentScheduleTempII."Loan No." := ObjLoanRepaymentScheduleTemp."Loan No.";
                                    ObjLoanRepaymentScheduleTempII."Entry No" := ScheduleEntryNo;
                                    ObjLoanRepaymentScheduleTempII."Loan Amount" := ObjLoanRepaymentScheduleTemp."Loan Amount";
                                    ObjLoanRepaymentScheduleTempII."Instalment No" := VarInstallmentNo;
                                    ObjLoanRepaymentScheduleTempII."Repayment Date" := VarNewInstalmentDate;
                                    ObjLoanRepaymentScheduleTempII."Member No." := ObjLoanRepaymentScheduleTemp."Member No.";
                                    ObjLoanRepaymentScheduleTempII."Loan Category" := ObjLoanRepaymentScheduleTemp."Loan Category";
                                    ObjLoanRepaymentScheduleTempII."Monthly Repayment" := ObjLoanRepaymentScheduleTemp."Monthly Repayment";
                                    ObjLoanRepaymentScheduleTempII."Principal Repayment" := ObjLoanRepaymentScheduleTemp."Principal Repayment";
                                    ObjLoanRepaymentScheduleTempII."Monthly Interest" := ObjLoanRepaymentScheduleTemp."Monthly Interest";
                                    ObjLoanRepaymentScheduleTempII."Monthly Insurance" := ObjLoanRepaymentScheduleTemp."Monthly Insurance";
                                    ObjLoanRepaymentScheduleTempII."Loan Balance" := ObjLoanRepaymentScheduleTemp."Loan Balance";
                                    ObjLoanRepaymentScheduleTempII.Insert;

                                    ScheduleEntryNo := ScheduleEntryNo + 1;
                                until ObjLoanRepaymentScheduleTemp.Next = 0;
                            end;

                            ObjLoanRepaymentScheduleTemp.Reset;
                            ObjLoanRepaymentScheduleTemp.SetCurrentkey(ObjLoanRepaymentScheduleTemp."Instalment No");
                            ObjLoanRepaymentScheduleTemp.SetRange(ObjLoanRepaymentScheduleTemp."Loan No.", "Loan  No.");
                            ObjLoanRepaymentScheduleTemp.SetFilter(ObjLoanRepaymentScheduleTemp."Monthly Repayment", '<>%1', 0);
                            ObjLoanRepaymentScheduleTemp.SetFilter(ObjLoanRepaymentScheduleTemp."Repayment Date", '>=%1', "Installment Date to Skip From");
                            ObjLoanRepaymentScheduleTemp.SetRange(ObjLoanRepaymentScheduleTemp.ToDelete, true);
                            if ObjLoanRepaymentScheduleTemp.FindSet then
                                ObjLoanRepaymentScheduleTemp.DeleteAll;

                            "Skip Installments Effected" := true;
                            "Skip Installments Effected By" := UserId;
                            "Skip Installments Effected On" := CurrentDatetime;
                            Message('Skip Installments Effected Succesfully. View Repayment Schedule to confirm.');
                        end;
                    end;
                }
                action("Loans to Offset")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loans to Offset';
                    Image = AddAction;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    RunObject = Page "Loan Offset Detail List-P";
                    RunPageLink = "Loan No." = field("Loan  No."),
                                  "Client Code" = field("Client Code");
                }
                action("Cancel Approval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Request';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = false;

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit "Approvals Mgmt.";
                    begin
                        //ApprovalMgt.SendLoanApprRequest(Rec);
                        if Confirm('Are you sure you want to cancel the approval request', false) = true then begin
                            "Loan Status" := "loan status"::Application;
                            "Approval Status" := "approval status"::Open;
                            Modify;
                        end;
                    end;
                }
                action("Loan Recovery Logs")
                {
                    ApplicationArea = Basic;
                    Image = Form;
                    Promoted = true;
                    RunObject = Page "Loan Recovery Logs List";
                    RunPageLink = "Member No" = field("No. Series"),
                                  "Member Name" = field("Name of Chief/ Assistant");
                }
                action("Loan Recovery Log Report")
                {
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        ObjCust.Reset;
                        ObjCust.SetRange(ObjCust."No.", "Client Code");
                        if ObjCust.Find('-') then
                            Report.run(50963, true, false, ObjCust);
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

                        DocumentType := Documenttype::LoanApplication;
                        ApprovalEntries.Setfilters(Database::"Loans Register", DocumentType, "Loan  No.");
                        ApprovalEntries.Run;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        EditableField := true;
    end;

    trigger OnAfterGetRecord()
    begin
        EditableField := true;
        DateChangedEditable := true;
        if "Repayment Dates Rescheduled" = true then begin
            DateChangedEditable := false;
        end;

        RescheduledVisible := Rescheduled;

        "Working Date" := WorkDate;
    end;

    trigger OnOpenPage()
    begin
        EditableField := true;

        EditableField := true;
        DateChangedEditable := true;
        if "Repayment Dates Rescheduled" = true then begin
            DateChangedEditable := false;
        end;

        RescheduledVisible := Rescheduled;
    end;

    var
        i: Integer;
        LoanType: Record "Loan Products Setup";
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
        LineNo: Integer;
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
        GenJournalLine: Record "Gen. Journal Line";
        FOSAComm: Decimal;
        BOSAComm: Decimal;
        GLPosting: Codeunit "Gen. Jnl.-Post Line";
        LoanTopUp: Record "Loan Offset Details";
        Vend: Record Vendor;
        BOSAInt: Decimal;
        TopUpComm: Decimal;
        DActivity: Code[20];
        DBranch: Code[20];
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
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal;
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
        Doc_Type: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
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
        CummulativeGuarantee: Decimal;
        LoansRec: Record "Loans Register";
        RecoveryModeEditable: Boolean;
        RemarksEditable: Boolean;
        CopyofIDEditable: Boolean;
        CopyofPayslipEditable: Boolean;
        ScheduleBal: Decimal;
        SFactory: Codeunit "SURESTEP Factory";
        BATCH_NAME: Code[50];
        BATCH_TEMPLATE: Code[50];
        ReschedulingFees: Decimal;
        ReschedulingFeeAccount: Code[50];
        LoanProcessingFee: Decimal;
        ExciseDuty: Decimal;
        EditableField: Boolean;
        ObjLoanRepaymentSchedule: Record "Loan Repayment Schedule";
        DateChangedEditable: Boolean;
        ObjProductCharge: Record "Loan Product Charges";
        LInsurance: Decimal;
        VarNewInstalmentDate: Date;
        ObjLoanRepaymentScheduleTemp: Record "Loan Repayment Schedule Temp";
        ObjCust: Record Customer;
        ObjLoanRepaymentScheduleII: Record "Loan Repayment Schedule";
        ObjLoanRepaymentScheduleTempII: Record "Loan Repayment Schedule Temp";
        ScheduleEntryNo: Integer;
        InstallmentsToSkip: Integer;
        RepaymentDateSkip: Date;
        RescheduledVisible: Boolean;
        SkipInstallmentEditable: Boolean;


    procedure UpdateControl()
    begin
        if "Approval Status" = "approval status"::Open then begin
            MNoEditable := true;
            ApplcDateEditable := false;
            LoanStatusEditable := false;
            LProdTypeEditable := true;
            InstallmentEditable := true;
            AppliedAmountEditable := true;
            ApprovedAmountEditable := true;
            RepayMethodEditable := true;
            RepaymentEditable := true;
            BatchNoEditable := false;
            RepayFrequencyEditable := true;
            ModeofDisburesmentEdit := true;
            DisbursementDateEditable := false;
            BatchNoEditable := false;
            RemarksEditable := false;
        end;

        if "Approval Status" = "approval status"::Pending then begin
            MNoEditable := false;
            ApplcDateEditable := false;
            LoanStatusEditable := false;
            LProdTypeEditable := false;
            InstallmentEditable := false;
            AppliedAmountEditable := false;
            ApprovedAmountEditable := true;
            RepayMethodEditable := true;
            RepaymentEditable := true;
            BatchNoEditable := false;
            RepayFrequencyEditable := false;
            ModeofDisburesmentEdit := true;
            DisbursementDateEditable := false;
            BatchNoEditable := false;
            RemarksEditable := false;
        end;

        if "Approval Status" = "approval status"::Rejected then begin
            MNoEditable := false;
            AccountNoEditable := false;
            ApplcDateEditable := false;
            LoanStatusEditable := false;
            LProdTypeEditable := false;
            InstallmentEditable := false;
            AppliedAmountEditable := false;
            ApprovedAmountEditable := false;
            RepayMethodEditable := false;
            RepaymentEditable := false;
            BatchNoEditable := false;
            RepayFrequencyEditable := false;
            ModeofDisburesmentEdit := false;
            DisbursementDateEditable := false;
            RejectionRemarkEditable := false;
            BatchNoEditable := false;
            RemarksEditable := false;
        end;

        if "Approval Status" = "approval status"::Approved then begin
            MNoEditable := false;
            AccountNoEditable := false;
            LoanStatusEditable := false;
            ApplcDateEditable := false;
            LProdTypeEditable := false;
            InstallmentEditable := false;
            AppliedAmountEditable := false;
            ApprovedAmountEditable := false;
            RepayMethodEditable := false;
            RepaymentEditable := false;
            BatchNoEditable := true;
            RepayFrequencyEditable := false;
            ModeofDisburesmentEdit := true;
            DisbursementDateEditable := true;
            RejectionRemarkEditable := false;
            BatchNoEditable := true;
            RemarksEditable := false;
        end;
    end;


    procedure LoanAppPermisions()
    begin
    end;

    local procedure FnGenerateSchedule()
    begin
        if "Repayment Frequency" = "repayment frequency"::Daily then
            Evaluate(InPeriod, '1D')
        else
            if "Repayment Frequency" = "repayment frequency"::Weekly then
                Evaluate(InPeriod, '1W')
            else
                if "Repayment Frequency" = "repayment frequency"::Monthly then
                    Evaluate(InPeriod, '1M')
                else
                    if "Repayment Frequency" = "repayment frequency"::Quaterly then
                        Evaluate(InPeriod, '1Q');


        QCounter := 0;
        QCounter := 3;
        ScheduleBal := 0;
        GrPrinciple := "Grace Period - Principle (M)";
        GrInterest := "Grace Period - Interest (M)";
        InitialGraceInt := "Grace Period - Interest (M)";

        LoansR.Reset;
        LoansR.SetRange(LoansR."Loan  No.", "Loan  No.");
        if LoansR.Find('-') then begin

            TestField("Loan Disbursement Date");
            TestField("Repayment Start Date");

            RSchedule.Reset;
            RSchedule.SetRange(RSchedule."Loan No.", "Loan  No.");
            RSchedule.DeleteAll;

            LoanAmount := LoansR."Approved Amount" + LoansR."Capitalized Charges";
            InterestRate := LoansR.Interest;
            RepayPeriod := LoansR.Installments;
            InitialInstal := LoansR.Installments + "Grace Period - Principle (M)";
            LBalance := LoansR."Approved Amount" + LoansR."Capitalized Charges";
            LNBalance := LoansR."Outstanding Balance";
            RunDate := "Repayment Start Date";

            InstalNo := 0;
            Evaluate(RepayInterval, '1W');

            //Repayment Frequency
            if "Repayment Frequency" = "repayment frequency"::Daily then
                RunDate := CalcDate('-1D', RunDate)
            else
                if "Repayment Frequency" = "repayment frequency"::Weekly then
                    RunDate := CalcDate('-1W', RunDate)
                else
                    if "Repayment Frequency" = "repayment frequency"::Monthly then
                        RunDate := CalcDate('-1M', RunDate)
                    else
                        if "Repayment Frequency" = "repayment frequency"::Quaterly then
                            RunDate := CalcDate('-1Q', RunDate);
            //Repayment Frequency


            repeat
                InstalNo := InstalNo + 1;
                ScheduleBal := LBalance;

                //*************Repayment Frequency***********************//
                if "Repayment Frequency" = "repayment frequency"::Daily then
                    RunDate := CalcDate('1D', RunDate)
                else
                    if "Repayment Frequency" = "repayment frequency"::Weekly then
                        RunDate := CalcDate('1W', RunDate)
                    else
                        if "Repayment Frequency" = "repayment frequency"::Monthly then
                            RunDate := CalcDate('1M', RunDate)
                        else
                            if "Repayment Frequency" = "repayment frequency"::Quaterly then
                                RunDate := CalcDate('1Q', RunDate);






                //*******************If Amortised****************************//
                if "Repayment Method" = "repayment method"::Amortised then begin
                    TestField(Installments);
                    TestField(Interest);
                    TestField(Installments);
                    TotalMRepay := ROUND((InterestRate / 12 / 100) / (1 - Power((1 + (InterestRate / 12 / 100)), -RepayPeriod)) * LoanAmount, 1, '>');
                    TotalMRepay := (InterestRate / 12 / 100) / (1 - Power((1 + (InterestRate / 12 / 100)), -RepayPeriod)) * LoanAmount;
                    LInterest := ROUND(LBalance / 100 / 12 * InterestRate);

                    LPrincipal := TotalMRepay - LInterest;
                end;



                if "Repayment Method" = "repayment method"::"Straight Line" then begin
                    TestField(Installments);
                    LPrincipal := ROUND(LoanAmount / RepayPeriod, 1, '>');
                    if ("Loan Product Type" = 'INST') or ("Loan Product Type" = 'MAZAO') then begin
                        LInterest := 0;
                    end else begin
                        LInterest := ROUND((InterestRate / 1200) * LoanAmount, 1, '>');
                    end;

                    Repayment := LPrincipal + LInterest;
                    "Loan Principle Repayment" := LPrincipal;
                    "Loan Interest Repayment" := LInterest;
                end;


                if "Repayment Method" = "repayment method"::"Reducing Balance" then begin
                    TestField(Interest);
                    TestField(Installments);
                    LPrincipal := ROUND(LoanAmount / RepayPeriod, 1, '>');
                    LInterest := ROUND((InterestRate / 12 / 100) * LBalance, 1, '>');
                end;

                if "Repayment Method" = "repayment method"::Constants then begin
                    TestField(Repayment);
                    if LBalance < Repayment then
                        LPrincipal := LBalance
                    else
                        LPrincipal := Repayment;
                    LInterest := Interest;
                end;


                //Grace Period
                if GrPrinciple > 0 then begin
                    LPrincipal := 0
                end else begin
                    if "Instalment Period" <> InPeriod then
                        LBalance := LBalance - LPrincipal;
                    ScheduleBal := ScheduleBal - LPrincipal;
                end;

                if GrInterest > 0 then
                    LInterest := 0;

                GrPrinciple := GrPrinciple - 1;
                GrInterest := GrInterest - 1;
                LInterest := ROUND(LoansR."Approved Amount" * LoansR.Interest / 12 * (RepayPeriod + 1) / (200 * RepayPeriod), 0.05, '>'); //For Nafaka Only
                                                                                                                                          //Grace Period
                RSchedule.Init;
                RSchedule."Repayment Code" := RepayCode;
                RSchedule."Loan No." := "Loan  No.";
                RSchedule."Loan Amount" := LoanAmount;
                RSchedule."Instalment No" := InstalNo;
                RSchedule."Repayment Date" := CalcDate('CM', RunDate);
                RSchedule."Member No." := "Client Code";
                RSchedule."Loan Category" := "Loan Product Type";
                RSchedule."Monthly Repayment" := LInterest + LPrincipal;
                RSchedule."Monthly Interest" := LInterest;
                RSchedule."Principal Repayment" := LPrincipal;
                RSchedule."Loan Balance" := ScheduleBal;
                RSchedule.Insert;
                WhichDay := Date2dwy(RSchedule."Repayment Date", 1);


            until LBalance < 1

        end;

        Commit;

        LoanApp.Reset;
        LoanApp.SetRange(LoanApp."Loan  No.", "Loan  No.");
        if LoanApp.Find('-') then
            if LoanApp."Loan Product Type" <> 'INST' then begin
                Report.Run(50477, true, false, LoanApp);
            end else begin
                Report.Run(50477, true, false, LoanApp);
            end;
    end;
}

