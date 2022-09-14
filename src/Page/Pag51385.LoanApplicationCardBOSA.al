#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51385 "Loan Application Card(BOSA)"
{
    DeleteAllowed = false;
    InsertAllowed = true;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = "Loans Register";
    SourceTableView = where(Source = const(BOSA),
                            Posted = const(false));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("Loan Product Prefix"; "Loan Product Prefix")
                {

                }
                field("Loan  No."; "Loan  No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Client Code"; "Client Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member';
                    Editable = MNoEditable;
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
                    Importance = Additional;
                }
                field("Position In The Sacco"; "Position In The Sacco")
                { }
                field("Member Paying Type"; "Member Paying Type")
                { }
                field("Member Deposits"; "Member Deposits")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member Deposits';
                }
                field("Total Outstanding Loan BAL"; "Total Outstanding Loan BAL")
                {
                    ApplicationArea = Basic;
                    Caption = 'Total Outstanding Loan Balance';
                    Editable = false;
                }
                field("Global Dimension 2 Code"; "Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Additional;
                }
                field("1st Time Loanee"; "1st Time Loanee")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Additional;
                }
                field("Private Member"; "Private Member")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Additional;
                }
                field("Application Date"; "Application Date")
                {
                    ApplicationArea = Basic;
                    Editable = ApplcDateEditable;

                    trigger OnValidate()
                    begin
                        TestField(Posted, false);
                    end;
                }
                field("Loan Product Type"; "Loan Product Type")
                {
                    ApplicationArea = Basic;
                    Editable = LProdTypeEditable;
                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        if "Loan Product Type" = 'DL' then begin
                            DevSubCategoryVisible := true;

                        end;

                    end;
                }
                group("Development Category")
                {
                    Visible = DevSubCategoryVisible;
                    field("Development Loan Category"; "Development Loan Category")
                    {

                    }
                }
                field("Loan Product Type Name"; "Loan Product Type Name")
                {
                    ApplicationArea = Basic;
                    Caption = 'Product Name';
                    Editable = false;
                }
                field(Installments; Installments)
                {
                    ApplicationArea = Basic;
                    Editable = InstallmentEditable;

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
                    Importance = Additional;
                }
                field("Requested Amount"; "Requested Amount")
                {
                    ApplicationArea = Basic;
                    Caption = 'Amount Applied';
                    Editable = AppliedAmountEditable;

                    trigger OnValidate()
                    begin
                        TestField(Posted, false);
                    end;
                }
                field("Recommended Amount"; "Recommended Amount")
                {
                    ApplicationArea = Basic;
                    Caption = 'Qualifying Amount';
                    Editable = false;
                }
                field("Approved Amount"; "Approved Amount")
                {
                    ApplicationArea = Basic;
                    Caption = 'Approved Amount';
                    Editable = ApprovedAmountEditable;

                    trigger OnValidate()
                    begin
                        TestField(Posted, false);
                    end;
                }
                field("Disburesment Type"; "Disburesment Type")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        TrunchDetailsVisible := false;

                        if ("Disburesment Type" = "disburesment type"::"Full/Single disbursement") or ("Disburesment Type" = "disburesment type"::" ") then begin
                            TrunchDetailsVisible := false;
                        end else
                            TrunchDetailsVisible := true;
                    end;
                }
                group("Tranch Details")
                {
                    Caption = 'Tranch Details';
                    Visible = TrunchDetailsVisible;
                    field("Amount to Disburse on Tranch 1"; "Amount to Disburse on Tranch 1")
                    {
                        ApplicationArea = Basic;
                    }
                    field("No of Tranch Disbursment"; "No of Tranch Disbursment")
                    {
                        ApplicationArea = Basic;
                    }
                }
                field(Remarks; Remarks)
                {
                    ApplicationArea = Basic;
                    Editable = Remarkseditable;
                    Visible = true;
                }
                field("Loan Purpose"; "Loan Purpose")
                {
                    ApplicationArea = Basic;
                    Editable = LoanPurposeEditable;
                }
                field("Loan Purpose Description"; "Loan Purpose Description")
                {
                    ApplicationArea = Basic;
                    Editable = false;
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
                field("Income Type"; "Income Type")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        FnVisibility();
                    end;
                }
                field("Statement Account"; "Statement Account")
                {
                    ApplicationArea = Basic;
                }
                field("Received Copy Of ID"; "Received Copy Of ID")
                {
                    ApplicationArea = Basic;
                    Editable = CopyofIDEditable;
                }
                field("Received Payslip/Bank Statemen"; "Received Payslip/Bank Statemen")
                {
                    ApplicationArea = Basic;
                    Editable = CopyofPayslipEditable;
                }
                field("Repayment Method"; "Repayment Method")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Additional;
                }
                field(Repayment; Repayment)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Promoted;
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
                    Importance = Additional;

                    trigger OnValidate()
                    begin
                        UpdateControl();
                    end;
                }
                field("Batch No."; "Batch No.")
                {
                    ApplicationArea = Basic;
                    Editable = BatchNoEditable;
                    Importance = Additional;
                }
                field("Credit Officer"; "Credit Officer")
                {
                    ApplicationArea = Basic;
                    Caption = 'Credit Officer';
                }
                field("Loan Centre"; "Loan Centre")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Additional;
                }
                field("Captured By"; "Captured By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Additional;
                }
                field("Loan Offset Amount"; "Loan Offset Amount")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loan Offset Amount';
                }
                field("Repayment Frequency"; "Repayment Frequency")
                {
                    ApplicationArea = Basic;
                    Editable = RepayFrequencyEditable;
                }
                field("Mode of Disbursement"; "Mode of Disbursement")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Loan Disbursement Date"; "Loan Disbursement Date")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Cheque No."; "Cheque No.")
                {
                    ApplicationArea = Basic;
                    Visible = false;

                    trigger OnValidate()
                    begin
                        if StrLen("Cheque No.") > 6 then
                            Error('Document No. cannot contain More than 6 Characters.');
                    end;
                }
                field("Grace Period - Principle (M)"; "Grace Period - Principle (M)")
                {
                    ApplicationArea = Basic;
                }
                field("Grace Period - Interest (M)"; "Grace Period - Interest (M)")
                {
                    ApplicationArea = Basic;
                }
                field("Repayment Start Date"; "Repayment Start Date")
                {
                    ApplicationArea = Basic;
                }
                field("Expected Date of Completion"; "Expected Date of Completion")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Additional;
                }
                field("External EFT"; "External EFT")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Posted; Posted)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Additional;
                    Visible = false;
                }
                field("Approval Status"; "Approval Status")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Additional;
                }
                field("Recovery Mode"; "Recovery Mode")
                {
                    ApplicationArea = Basic;
                    Editable = RecoveryModeEditable;
                }
                part(Control32; "Loan Application Stages")
                {
                    Caption = 'Loan Stages';
                    SubPageLink = "Loan No" = field("Loan  No.");
                }
            }
            group("Salary Details")
            {
                Caption = 'Salary Details';
                Visible = PayslipDetailsVisible;
                group("Monthly Income Details")
                {
                    field("Basic Pay H"; "Basic Pay H")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Basic Pay';
                    }
                    field("House AllowanceH"; "House AllowanceH")
                    {
                        ApplicationArea = all;
                        Caption = 'House Allowance';

                    }
                    field("Medical AllowanceH"; "Medical AllowanceH")
                    {
                        ApplicationArea = all;

                    }
                    field("Transport Allowance"; "Transport Allowance")
                    {
                        ApplicationArea = all;
                    }
                    field("Other Income"; "Other Income")
                    {
                        ApplicationArea = all;
                    }
                    field(Nettakehome; Nettakehome)
                    {
                        Caption = 'Net Take Home';
                        ApplicationArea = all;
                    }
                    field("Chargeable Pay"; "Chargeable Pay")
                    {
                        ApplicationArea = all;
                    }

                }
                group("None Taxable Deductions")
                {
                    field("Other Non-Taxable"; "Other Non-Taxable")
                    {
                        ApplicationArea = all;
                    }
                    field("Other Tax Relief"; "Other Tax Relief")
                    {
                        ApplicationArea = all;
                    }
                    field("Pension Scheme"; "Pension Scheme")
                    {
                        ApplicationArea = all;
                    }

                }
                group("Monthly Expenses Detailss")
                {
                    field("SExpenses Rent"; "SExpenses Rent")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Rent';
                    }
                    field("SExpenses Transport"; "SExpenses Transport")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Transport';
                    }
                    field("SExpenses Education"; "SExpenses Education")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Education';
                    }
                    field("SExpenses Food"; "SExpenses Food")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Food';
                    }
                    field("SExpenses Utilities"; "SExpenses Utilities")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Utilities';
                    }
                    field("SExpenses Others"; "SExpenses Others")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Others';
                    }
                    field("Exisiting Loans Repayments"; "Exisiting Loans Repayments")
                    {
                        ApplicationArea = Basic;
                    }
                }
                field("Salary Net Utilizable"; "Salary Net Utilizable")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Statement Details")
            {
                Caption = 'Statement Details';
                Visible = BankStatementDetailsVisible;
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
            group("Rejection Details")
            {
                Visible = RejectionDetailsVisible;
                field("Rejection  Remark"; "Rejection  Remark")
                {
                    ApplicationArea = Basic;
                }
                field("Rejected By"; "Rejected By")
                {
                    ApplicationArea = Basic;
                }
                field("Date of Rejection"; "Date of Rejection")
                {
                    ApplicationArea = Basic;
                    Caption = 'Rejection Date';
                }
            }
            part(Control4; "Loans Guarantee Details")
            {
                Caption = 'Guarantors  Detail';
                SubPageLink = "Loan No" = field("Loan  No.");
            }
            part(Control3; "Loan Collateral Security")
            {
                Caption = 'Other Securities';
                SubPageLink = "Loan No" = field("Loan  No.");
            }
        }
        area(factboxes)
        {
            part(Control1; "Member Statistics FactBox")
            {
                SubPageLink = "No." = field("Client Code");
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
                action("Reset Loan Application")
                {
                    ApplicationArea = Basic;
                    Image = RefreshExcise;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        LoanApp.Reset;
                        LoanApp.SetRange(LoanApp."Loan  No.", "Loan  No.");
                        if LoanApp.Find('-') then begin
                            "Client Code" := '';
                            "Client Name" := '';
                            "ID NO" := '';
                            "Staff No" := '';
                            Installments := 0;
                            Interest := 0;
                            "Requested Amount" := 0;
                            "Approved Amount" := 0;
                        end;
                    end;
                }
                action("Loan Application Form")
                {
                    ApplicationArea = Basic;
                    Image = Form;
                    Promoted = true;
                    PromotedCategory = "Report";
                    Visible = false;

                    trigger OnAction()
                    begin
                        LoanApp.Reset;
                        LoanApp.SetRange(LoanApp."Loan  No.", "Loan  No.");
                        if LoanApp.Find('-') then begin
                            Report.Run(50913, true, false, LoanApp);
                        end;
                    end;
                }
                action("Reject Loan Application")
                {
                    ApplicationArea = Basic;
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        if Confirm('Confirm Rejection?', false) = true then begin
                            "Intent to Reject" := true;

                            RejectionDetailsVisible := false;
                            if "Intent to Reject" = true then begin
                                RejectionDetailsVisible := true;
                            end;

                            if "Rejection  Remark" = '' then begin
                                Error('Specify the Rejection Remarks/Reason on the Rejection Details Tab');
                            end else
                                "Rejected By" := UserId;
                            "Date of Rejection" := WorkDate;
                            "Approval Status" := "approval status"::Rejected;
                            "Loan Status" := "loan status"::Rejected;

                            //=========================================================================================Loan Stages Common On All Applications
                            ObjLoanStages.Reset;
                            ObjLoanStages.SetRange(ObjLoanStages."Loan Security Applicable", ObjLoanStages."loan security applicable"::Declined);
                            ObjLoanStages.SetFilter("Min Loan Amount", '=%1', 0);
                            if ObjLoanStages.FindSet then begin
                                repeat
                                    ObjLoanApplicationStages.Init;
                                    ObjLoanApplicationStages."Loan No" := "Loan  No.";
                                    ObjLoanApplicationStages."Member No" := "Client Code";
                                    ObjLoanApplicationStages."Member Name" := "Client Name";
                                    ObjLoanApplicationStages."Loan Stage" := ObjLoanStages."Loan Stage";
                                    ObjLoanApplicationStages."Loan Stage Description" := ObjLoanStages."Loan Stage Description";
                                    ObjLoanApplicationStages.Insert;
                                until ObjLoanStages.Next = 0;
                            end;

                        end;

                        CurrPage.Close;
                    end;
                }
                action("Loan Appraisal")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loan Appraisal';
                    Enabled = true;
                    Image = GanttChart;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        TestField("Mode of Disbursement");
                        ProvidedGuarantors := 0;

                        LoanApp.Reset;
                        LoanApp.SetRange(LoanApp."Loan  No.", "Loan  No.");
                        if LoanApp.Find('-') then begin
                            Report.Run(50384, true, false, LoanApp)
                        end;

                        FnRunCreateLoanStages;//========================Create Loan Stages
                    end;
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
                action("Update PAYE")
                {
                    ApplicationArea = Basic;
                    Image = PayrollStatistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        GenSetUp.Get();
                        Nettakehome := "Gross Pay" * 1 / 3;
                        Modify;


                        GrossPay := "Basic Pay H" + "Medical AllowanceH" + "House Allowance" + "Other Income" + "Transport/Bus Fare";
                        "Gross Pay" := GrossPay;
                        Modify;

                        CalcFields("Bridge Amount Release");

                        "Utilizable Amount" := 0;
                        NetUtilizable := 0;

                        OTrelief := "Other Tax Relief";
                        "Chargeable Pay" := "Gross Pay" + "Other Tax Relief" - "Provident Fund" - "Pension Scheme";
                        if Disabled <> true then begin
                            Rec.PAYE := SFactory.FnCalculatePaye("Chargeable Pay");
                        end;

                        TotalDeductions := "Monthly Contribution" + NSSF + NHIF + PAYE + "Risk MGT" + "Staff Union Contribution" + "Medical Insurance"
                        + "Life Insurance" + "Other Liabilities" + "Other Loans Repayments" + "Sacco Deductions" + "Provident Fund (Self)";


                        "Utilizable Amount" := GrossPay - TotalDeductions;
                        if LoanType.Get("Loan Product Type") then begin
                            "Least Retained Amount" := "Utilizable Amount" * LoanType."Qualification for Saver(%)" / 100;
                            if ((LoanType.Code = 'NSA') or (LoanType.Code = 'SAL ADV')) then
                                "Least Retained Amount" := "Least Retained Amount" + 250;
                        end;

                        "Net take home 2" := GrossPay - (TotalDeductions + "Existing Loan Repayments");

                        NetUtilizable := ROUND(("Utilizable Amount" - "Least Retained Amount" - "Existing Loan Repayments" + "Bridge Amount Release" + "Non Payroll Payments"), 5, '<');
                        "Net Utilizable Amount" := NetUtilizable;
                        "Total DeductionsH" := TotalDeductions;
                        "Net take Home" := Nettakehome;
                        Modify;
                    end;
                }
                action("View Loan Schedule")
                {
                    ApplicationArea = Basic;
                    Caption = 'View Schedule';
                    Image = "Table";
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;
                    ShortCutKey = 'Ctrl+F7';

                    trigger OnAction()
                    begin
                        SFactory.FnGenerateLoanRepaymentSchedule("Loan  No.");
                        LoanApp.reset;
                        LoanApp.SetRange(loanapp."Loan  No.", "Loan  No.");
                        if loanapp.Find('-') then begin
                            Report.Run(50477, true, false, LoanApp);
                        end
                    end;

                }
                action("Account Statement Transactions ")
                {
                    ApplicationArea = Basic;
                    Image = Form;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Loan Appraisal Statement Buffe";
                    RunPageLink = "Loan No" = field("Loan  No.");
                }
                action("Member Deposit Saving History")
                {
                    ApplicationArea = Basic;
                    Image = Form;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Member Deposit Saving History";
                    RunPageLink = "Loan No" = field("Loan  No.");
                }
                action("Load Account Statement Details")
                {
                    ApplicationArea = Basic;
                    Image = InsertAccount;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        //Clear Buffer
                        ObjStatementB.Reset;
                        ObjStatementB.SetRange(ObjStatementB."Loan No", "Loan  No.");
                        if ObjStatementB.FindSet then begin
                            ObjStatementB.DeleteAll;
                        end;



                        //Initialize Variables
                        VerMonth1CreditAmount := 0;
                        VerMonth1DebitAmount := 0;
                        VerMonth2CreditAmount := 0;
                        VerMonth2DebitAmount := 0;
                        VerMonth3CreditAmount := 0;
                        VerMonth3DebitAmount := 0;
                        VerMonth4CreditAmount := 0;
                        VerMonth4DebitAmount := 0;
                        VerMonth5CreditAmount := 0;
                        VerMonth5DebitAmount := 0;
                        VerMonth6CreditAmount := 0;
                        VerMonth6DebitAmount := 0;
                        GenSetUp.Get();

                        //Month 1
                        StatementStartDate := CalcDate(GenSetUp."Bank Statement Period", Today);
                        VerMonth1Date := Date2dmy(StatementStartDate, 1);
                        VerMonth1Month := Date2dmy(StatementStartDate, 2);
                        VerMonth1Year := Date2dmy(StatementStartDate, 3);


                        VerMonth1StartDate := Dmy2date(1, VerMonth1Month, VerMonth1Year);
                        VerMonth1EndDate := CalcDate('CM', VerMonth1StartDate);

                        VarMonth1Datefilter := Format(VerMonth1StartDate) + '..' + Format(VerMonth1EndDate);
                        VerMonth1CreditAmount := 0;
                        VerMonth1DebitAmount := 0;
                        ObjAccountLedger.Reset;
                        ObjAccountLedger.SetRange(ObjAccountLedger."Vendor No.", "Statement Account");
                        ObjAccountLedger.SetFilter(ObjAccountLedger."Posting Date", VarMonth1Datefilter);
                        if ObjAccountLedger.FindSet then begin
                            repeat
                                if ObjAccountLedger.Amount > 0 then begin
                                    VerMonth1DebitAmount := VerMonth1DebitAmount + ObjAccountLedger.Amount
                                end else
                                    VerMonth1CreditAmount := VerMonth1CreditAmount + ObjAccountLedger.Amount;
                            until ObjAccountLedger.Next = 0;

                            ObjStatementB.Init;
                            ObjStatementB."Loan No" := "Loan  No.";
                            ObjStatementB."Transaction Date" := VerMonth1EndDate;
                            ObjStatementB."Transaction Description" := 'Month 1 Transactions';
                            ObjStatementB."Amount Out" := VerMonth1DebitAmount;
                            ObjStatementB."Amount In" := VerMonth1CreditAmount * -1;
                            ObjStatementB.Insert;

                        end;


                        //Month 2
                        StatementStartDate := CalcDate(GenSetUp."Bank Statement Period", Today);
                        VerMonth2Date := Date2dmy(StatementStartDate, 1);
                        VerMonth2Month := (VerMonth1Month + 1);
                        VerMonth2Year := Date2dmy(StatementStartDate, 3);

                        if VerMonth2Month > 12 then begin
                            VerMonth2Month := VerMonth2Month - 12;
                            VerMonth2Year := VerMonth2Year + 1;
                        end;

                        VerMonth2StartDate := Dmy2date(1, VerMonth2Month, VerMonth1Year);
                        VerMonth2EndDate := CalcDate('CM', VerMonth2StartDate);
                        VarMonth2Datefilter := Format(VerMonth2StartDate) + '..' + Format(VerMonth2EndDate);
                        VerMonth2CreditAmount := 0;
                        VerMonth2DebitAmount := 0;
                        ObjAccountLedger.Reset;
                        ObjAccountLedger.SetRange(ObjAccountLedger."Vendor No.", "Statement Account");
                        ObjAccountLedger.SetFilter(ObjAccountLedger."Posting Date", VarMonth2Datefilter);
                        if ObjAccountLedger.FindSet then begin
                            repeat
                                if ObjAccountLedger.Amount > 0 then begin
                                    VerMonth2DebitAmount := VerMonth2DebitAmount + ObjAccountLedger.Amount
                                end else
                                    VerMonth2CreditAmount := VerMonth2CreditAmount + ObjAccountLedger.Amount;
                            until ObjAccountLedger.Next = 0;

                            ObjStatementB.Init;
                            ObjStatementB."Loan No" := "Loan  No.";
                            ObjStatementB."Transaction Date" := VerMonth2EndDate;
                            ObjStatementB."Transaction Description" := 'Month 2 Transactions';
                            ObjStatementB."Amount Out" := VerMonth2DebitAmount;
                            ObjStatementB."Amount In" := VerMonth2CreditAmount * -1;
                            ObjStatementB.Insert;

                        end;

                        VerMonth3CreditAmount := 0;
                        VerMonth3DebitAmount := 0;
                        //Month 3
                        StatementStartDate := CalcDate(GenSetUp."Bank Statement Period", Today);
                        VerMonth3Date := Date2dmy(StatementStartDate, 1);
                        VerMonth3Month := (VerMonth1Month + 2);
                        VerMonth3Year := Date2dmy(StatementStartDate, 3);

                        if VerMonth3Month > 12 then begin
                            VerMonth3Month := VerMonth3Month - 12;
                            VerMonth3Year := VerMonth3Year + 1;
                        end;

                        VerMonth3StartDate := Dmy2date(1, VerMonth3Month, VerMonth3Year);
                        VerMonth3EndDate := CalcDate('CM', VerMonth3StartDate);
                        VarMonth3Datefilter := Format(VerMonth3StartDate) + '..' + Format(VerMonth3EndDate);
                        VerMonth3CreditAmount := 0;
                        VerMonth3DebitAmount := 0;
                        ObjAccountLedger.Reset;
                        ObjAccountLedger.SetRange(ObjAccountLedger."Vendor No.", "Statement Account");
                        ObjAccountLedger.SetFilter(ObjAccountLedger."Posting Date", VarMonth3Datefilter);
                        if ObjAccountLedger.FindSet then begin
                            repeat
                                if ObjAccountLedger.Amount > 0 then begin
                                    VerMonth3DebitAmount := VerMonth3DebitAmount + ObjAccountLedger.Amount
                                end else
                                    VerMonth3CreditAmount := VerMonth3CreditAmount + ObjAccountLedger.Amount;
                            until ObjAccountLedger.Next = 0;

                            ObjStatementB.Init;
                            ObjStatementB."Loan No" := "Loan  No.";
                            ObjStatementB."Transaction Date" := VerMonth3EndDate;
                            ObjStatementB."Transaction Description" := 'Month 3 Transactions';
                            ObjStatementB."Amount Out" := VerMonth3DebitAmount;
                            ObjStatementB."Amount In" := VerMonth3CreditAmount * -1;
                            ObjStatementB.Insert;
                        end;


                        //Month 4
                        StatementStartDate := CalcDate(GenSetUp."Bank Statement Period", Today);
                        VerMonth4Date := Date2dmy(StatementStartDate, 1);
                        VerMonth4Month := (VerMonth1Month + 3);
                        VerMonth4Year := Date2dmy(StatementStartDate, 3);

                        if VerMonth4Month > 12 then begin
                            VerMonth4Month := VerMonth4Month - 12;
                            VerMonth4Year := VerMonth4Year + 1;
                        end;

                        VerMonth4StartDate := Dmy2date(1, VerMonth4Month, VerMonth4Year);
                        VerMonth4EndDate := CalcDate('CM', VerMonth4StartDate);
                        VarMonth4Datefilter := Format(VerMonth4StartDate) + '..' + Format(VerMonth4EndDate);

                        VerMonth4CreditAmount := 0;
                        VerMonth4DebitAmount := 0;
                        ObjAccountLedger.Reset;
                        ObjAccountLedger.SetRange(ObjAccountLedger."Vendor No.", "Statement Account");
                        ObjAccountLedger.SetFilter(ObjAccountLedger."Posting Date", VarMonth4Datefilter);
                        if ObjAccountLedger.FindSet then begin
                            repeat
                                if ObjAccountLedger.Amount > 0 then begin
                                    VerMonth4DebitAmount := VerMonth4DebitAmount + ObjAccountLedger.Amount
                                end else
                                    VerMonth4CreditAmount := VerMonth4CreditAmount + ObjAccountLedger.Amount;
                            until ObjAccountLedger.Next = 0;

                            ObjStatementB.Init;
                            ObjStatementB."Loan No" := "Loan  No.";
                            ObjStatementB."Transaction Date" := VerMonth4EndDate;
                            ObjStatementB."Transaction Description" := 'Month 4 Transactions';
                            ObjStatementB."Amount Out" := VerMonth4DebitAmount;
                            ObjStatementB."Amount In" := VerMonth4CreditAmount * -1;
                            ObjStatementB.Insert;
                        end;


                        //Month 5
                        StatementStartDate := CalcDate(GenSetUp."Bank Statement Period", Today);
                        VerMonth5Date := Date2dmy(StatementStartDate, 1);
                        VerMonth5Month := (VerMonth1Month + 4);
                        VerMonth5Year := Date2dmy(StatementStartDate, 3);

                        if VerMonth5Month > 12 then begin
                            VerMonth5Month := VerMonth5Month - 12;
                            VerMonth5Year := VerMonth5Year + 1;
                        end;

                        VerMonth5StartDate := Dmy2date(1, VerMonth5Month, VerMonth5Year);
                        VerMonth5EndDate := CalcDate('CM', VerMonth5StartDate);
                        VarMonth5Datefilter := Format(VerMonth5StartDate) + '..' + Format(VerMonth5EndDate);

                        VerMonth5CreditAmount := 0;
                        VerMonth5DebitAmount := 0;
                        ObjAccountLedger.Reset;
                        ObjAccountLedger.SetRange(ObjAccountLedger."Vendor No.", "Statement Account");
                        ObjAccountLedger.SetFilter(ObjAccountLedger."Posting Date", VarMonth5Datefilter);
                        if ObjAccountLedger.FindSet then begin
                            repeat
                                if ObjAccountLedger.Amount > 0 then begin
                                    VerMonth5DebitAmount := VerMonth5DebitAmount + ObjAccountLedger.Amount
                                end else
                                    VerMonth5CreditAmount := VerMonth5CreditAmount + ObjAccountLedger.Amount;
                            until ObjAccountLedger.Next = 0;

                            ObjStatementB.Init;
                            ObjStatementB."Loan No" := "Loan  No.";
                            ObjStatementB."Transaction Date" := VerMonth5EndDate;
                            ObjStatementB."Transaction Description" := 'Month 5 Transactions';
                            ObjStatementB."Amount Out" := VerMonth5DebitAmount;
                            ObjStatementB."Amount In" := VerMonth5CreditAmount * -1;
                            ObjStatementB.Insert;
                        end;


                        //Month 6
                        StatementStartDate := CalcDate(GenSetUp."Bank Statement Period", Today);
                        VerMonth6Date := Date2dmy(StatementStartDate, 1);
                        VerMonth6Month := (VerMonth1Month + 5);
                        VerMonth6Year := Date2dmy(StatementStartDate, 3);

                        if VerMonth6Month > 12 then begin
                            VerMonth6Month := VerMonth6Month - 12;
                            VerMonth6Year := VerMonth6Year + 1;
                        end;

                        VerMonth6StartDate := Dmy2date(1, VerMonth6Month, VerMonth6Year);
                        VerMonth6EndDate := CalcDate('CM', VerMonth6StartDate);
                        VarMonth6Datefilter := Format(VerMonth6StartDate) + '..' + Format(VerMonth6EndDate);

                        VerMonth6CreditAmount := 0;
                        VerMonth6DebitAmount := 0;
                        ObjAccountLedger.Reset;
                        ObjAccountLedger.SetRange(ObjAccountLedger."Vendor No.", "Statement Account");
                        ObjAccountLedger.SetFilter(ObjAccountLedger."Posting Date", VarMonth6Datefilter);
                        if ObjAccountLedger.FindSet then begin
                            repeat

                                if ObjAccountLedger.Amount > 0 then begin
                                    VerMonth6DebitAmount := VerMonth6DebitAmount + ObjAccountLedger.Amount
                                end else
                                    VerMonth6CreditAmount := VerMonth6CreditAmount + ObjAccountLedger.Amount;
                            until ObjAccountLedger.Next = 0;

                            ObjStatementB.Init;
                            ObjStatementB."Loan No" := "Loan  No.";
                            ObjStatementB."Transaction Date" := VerMonth6EndDate;
                            ObjStatementB."Transaction Description" := 'Month 6 Transactions';
                            ObjStatementB."Amount Out" := VerMonth6DebitAmount;
                            ObjStatementB."Amount In" := VerMonth6CreditAmount * -1;
                            ObjStatementB.Insert;
                        end;

                        VerStatementAvCredits := 0;
                        //Get Statement Avarage Credits
                        ObjStatementB.Reset;
                        ObjStatementB.SetRange(ObjStatementB."Loan No", "Loan  No.");
                        //ObjStatementB.SETFILTER(ObjStatementB.Amount,'<%1',0);
                        if ObjStatementB.FindSet then begin
                            repeat
                                VerStatementAvCredits := VerStatementAvCredits + ObjStatementB."Amount In";
                                "Bank Statement Avarage Credits" := VerStatementAvCredits / 6;
                                Modify;
                            until ObjStatementB.Next = 0;
                        end;

                        VerStatementsAvDebits := 0;
                        //Get Statement Avarage Debits
                        ObjStatementB.Reset;
                        ObjStatementB.SetRange(ObjStatementB."Loan No", "Loan  No.");
                        //ObjStatementB.SETFILTER(ObjStatementB.Amount,'>%1',0);
                        if ObjStatementB.FindSet then begin
                            repeat
                                VerStatementsAvDebits := VerStatementsAvDebits + ObjStatementB."Amount Out";
                                "Bank Statement Avarage Debits" := VerStatementsAvDebits / 6;
                                Modify;
                            until ObjStatementB.Next = 0;
                        end;

                        "Bank Statement Net Income" := "Bank Statement Avarage Credits" - "Bank Statement Avarage Debits";
                        Modify;
                    end;
                }
                action("House Group Statement")
                {
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        ObjMemberCellG.Reset;
                        ObjMemberCellG.SetRange(ObjMemberCellG."Cell Group Code", "Member House Group");
                        Report.Run(50920, true, false, ObjMemberCellG);
                    end;
                }
                action("Loans Top Up")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loans Top Up';
                    Image = AddAction;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    RunObject = Page "Loan Offset Detail List";
                    RunPageLink = "Loan No." = field("Loan  No."),
                                  "Client Code" = field("Client Code");
                }
                action("Send Approval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send A&pproval Request';
                    Enabled = (not OpenApprovalEntriesExist) and EnabledApprovalWorkflowsExist;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        Text001: label 'This transaction is already pending approval';
                        ApprovalMgt: Codeunit "Approvals Mgmt.";
                        Workflowintegration: Codeunit WorkflowIntegration;
                    begin
                        Codeunit.Run(50004);
                        if "Approved Amount" = 0 then Error('Kindly upraise your loan application before sending approval request');

                        TestField("Loan Product Type");
                        TestField("Recovery Mode");

                        LoanGuar.Reset;
                        LoanGuar.SetRange("Loan No", "Loan  No.");
                        if LoanGuar.Find('-') then begin
                            if LoanType.Get("Loan Product Type") then begin
                                if LoanGuar.Count < LoanType."Min No. Of Guarantors" then
                                    Error('You must capture atleast ' + Format(LoanType."Min No. Of Guarantors") + ' for ' + "Loan Product Type");
                            end;
                        end;


                        if "Approval Status" <> "approval status"::Open then
                            Error(Text001);

                        //End allocate batch number
                        Doc_Type := Doc_type::LoanApplication;
                        Table_id := Database::"Loans Register";

                        if Workflowintegration.CheckLoanApplicationApprovalsWorkflowEnabled(Rec) then
                            Workflowintegration.OnSendLoanApplicationForApproval(Rec);
                        TestField("Requested Amount");
                        //ENSURE THAT REQUESTED AMOUNT IS ENTERED
                        TestField("Requested Amount");
                        CurrPage.Close;
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
                        ApprovalMgt: Codeunit "Approvals Mgmt.";
                    begin
                        // ApprovalMgt.SendLoanApprRequest(Rec);
                        if Confirm('Are you sure you want to cancel the approval request', false) = true then begin
                            "Loan Status" := "loan status"::Application;
                            "Approval Status" := "approval status"::Open;
                            //ApprovalsMgmt.OnCancelLoanApplicationApprovalRequest(Rec);
                            Modify;
                        end;
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
                action("CRB Check Charge")
                {
                    ApplicationArea = Basic;
                    Image = Calculate;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "CRB Check Charge List";
                    RunPageLink = "Member No" = field("Client Code"),
                                  "Loan No" = field("Loan  No.");
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        UpdateControl();
        EnableCreateMember := false;
        EditableAction := true;
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RecordId);
        EnabledApprovalWorkflowsExist := true;
        if Rec."Approval Status" = "approval status"::Approved then begin
            OpenApprovalEntriesExist := false;
            CanCancelApprovalForRecord := false;
            EnabledApprovalWorkflowsExist := false;
        end;
        if (Rec."Approval Status" = "approval status"::Approved) then
            EnableCreateMember := true;

        if Rec."Approval Status" <> "approval status"::Open then
            EditableAction := false;
        if "Approval Status" = "approval status"::Pending then
            CanCancelApprovalForRecord := true; //to correct
    end;

    trigger OnAfterGetRecord()
    begin
        Source := Source::BOSA;
        FnVisibility();

        TrunchDetailsVisible := false;

        if ("Disburesment Type" = "disburesment type"::"Full/Single disbursement") or ("Disburesment Type" = "disburesment type"::" ") then begin
            TrunchDetailsVisible := false;
        end else
            TrunchDetailsVisible := true;
    end;

    trigger OnModifyRecord(): Boolean
    begin
        LoanAppPermisions();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Source := Source::BOSA;
        "Mode of Disbursement" := "mode of disbursement"::" ";
        Discard := true;
    end;

    trigger OnNextRecord(Steps: Integer): Integer
    begin
        if "Loan Status" = "loan status"::Disbursed then
            CurrPage.Editable := false;
    end;

    trigger OnOpenPage()
    begin
        SetRange(Posted, false);
        FnVisibility();
        TrunchDetailsVisible := false;

        if ("Disburesment Type" = "disburesment type"::"Full/Single disbursement") or ("Disburesment Type" = "disburesment type"::" ") then begin
            TrunchDetailsVisible := false;
        end else
            TrunchDetailsVisible := true;
    end;

    var
        i: Integer;
        LoanType: Record "Loan Products Setup";
        PeriodDueDate: Date;
        ScheduleRep: Record "Loan Repayment Schedule";
        RunningDate: Date;
        G: Integer;
        LoanGuar: Record "Loan GuarantorsFOSA";
        IssuedDate: Date;
        GracePeiodEndDate: Date;
        Vend1: Record Vendor;
        InstalmentEnddate: Date;
        SMSMessage: Record "SMS Messages";
        GracePerodDays: Integer;
        InstalmentDays: Integer;
        SMSMessages: Record "SMS Messages";
        NoOfGracePeriod: Integer;
        iEntryNo: Integer;
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
        LoanG: Record "Loans Register";
        SpecialComm: Decimal;
        FOSAName: Text[150];
        IDNo: Code[50];
        MovementTracker: Record "File Movement Tracker";
        DiscountingAmount: Decimal;
        StatusPermissions: Record "Status Change Permision";
        BridgedLoans: Record "Loan Offset Details";
        InstallNo2: Integer;
        currency: Record "Currency Exchange Rate";
        CURRENCYFACTOR: Decimal;
        LoanApps: Record "Loans Register";
        LoanDisbAmount: Decimal;
        BatchTopUpAmount: Decimal;
        BatchTopUpComm: Decimal;
        SchDate: Date;
        DisbDate: Date;
        WhichDay: Integer;
        LBatches: Record "Loan Disburesment-Batching";
        SalDetails: Record "Loan Appraisal Salary Details";
        LGuarantors: Record "Loan GuarantorsFOSA";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery;
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
        Interrest: Boolean;
        InterestSal: Decimal;
        EndMonth: Date;
        RemainingDays: Integer;
        PrincipalRepay: Decimal;
        InterestRepay: Decimal;
        TMonthDays: Integer;
        ReceiptAllocations: Record "HISA Allocation";
        ReceiptAllocation: Record "HISA Allocation";
        ApprovalEntry: Record "Approval Entry";
        Table_id: Integer;
        Doc_No: Code[20];
        Doc_Type: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
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
        GrossPay: Decimal;
        FOSASet: Record "FOSA Guarantors Setup";
        MinGNo: Integer;
        ProvidedGuarantors: Integer;
        LoansRec: Record "Loans Register";
        OpenApprovalEntriesExist: Boolean;
        EnabledApprovalWorkflowsExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
        EventFilter: Text;
        EnableCreateMember: Boolean;
        EditableAction: Boolean;
        SFactory: Codeunit "SURESTEP Factory";
        PayslipDetailsVisible: Boolean;
        BankStatementDetailsVisible: Boolean;
        ObjProductCharge: Record "Loan Product Charges";
        ObjAccountLedger: Record "Detailed Vendor Ledg. Entry";
        ObjStatementB: Record "Loan Appraisal Statement Buffe";
        StatementStartDate: Date;
        StatementDateFilter: Date;
        StatementEndDate: Date;
        VerStatementAvCredits: Decimal;
        VerStatementsAvDebits: Decimal;
        VerMonth1Date: Integer;
        VerMonth1Month: Integer;
        VerMonth1Year: Integer;
        VerMonth1StartDate: Date;
        VerMonth1EndDate: Date;
        VerMonth1DebitAmount: Decimal;
        VerMonth1CreditAmount: Decimal;
        VerMonth2Date: Integer;
        VerMonth2Month: Integer;
        VerMonth2Year: Integer;
        VerMonth2StartDate: Date;
        VerMonth2EndDate: Date;
        VerMonth2DebitAmount: Decimal;
        VerMonth2CreditAmount: Decimal;
        VerMonth3Date: Integer;
        VerMonth3Month: Integer;
        VerMonth3Year: Integer;
        VerMonth3StartDate: Date;
        VerMonth3EndDate: Date;
        VerMonth3DebitAmount: Decimal;
        VerMonth3CreditAmount: Decimal;
        VerMonth4Date: Integer;
        VerMonth4Month: Integer;
        VerMonth4Year: Integer;
        VerMonth4StartDate: Date;
        VerMonth4EndDate: Date;
        VerMonth4DebitAmount: Decimal;
        VerMonth4CreditAmount: Decimal;
        VerMonth5Date: Integer;
        VerMonth5Month: Integer;
        VerMonth5Year: Integer;
        VerMonth5StartDate: Date;
        VerMonth5EndDate: Date;
        VerMonth5DebitAmount: Decimal;
        VerMonth5CreditAmount: Decimal;
        VerMonth6Date: Integer;
        VerMonth6Month: Integer;
        VerMonth6Year: Integer;
        VerMonth6StartDate: Date;
        VerMonth6EndDate: Date;
        VerMonth6DebitAmount: Decimal;
        VerMonth6CreditAmount: Decimal;
        VarMonth1Datefilter: Text;
        VarMonth2Datefilter: Text;
        VarMonth3Datefilter: Text;
        VarMonth4Datefilter: Text;
        VarMonth5Datefilter: Text;
        VarMonth6Datefilter: Text;
        ObjMemberCellG: Record "Member House Groups";
        TrunchDetailsVisible: Boolean;
        AccountNoEditable: Boolean;
        Remarkseditable: Boolean;
        LoanPurposeEditable: Boolean;
        CopyofIDEditable: Boolean;
        CopyofPayslipEditable: Boolean;
        RejectionRemarkEditable: Boolean;
        RecoveryModeEditable: Boolean;
        compinfo: Record "Company Information";
        Text001: label 'Status Must Be Open';
        LoanAppMessage: label '<p style="font-family:Verdana,Arial;font-size:10pt">Dear<b> %1,</b></p><p style="font-family:Verdana,Arial;font-size:9pt">Welcome to Kingdom Sacco</p><p style="font-family:Verdana,Arial;font-size:9pt">This is to confirm that your Loan Application has been received and Undergoing Approval</p><p style="font-family:Verdana,Arial;font-size:9pt"> </b></p><br>Regards<p>%3</p><p><b>KINGDOM SACCO LTD</b></p>';
        SMSMessageText: label 'Your loan application of KSHs.%1 has been received and your qualification is KSHs.%2 The application is being processed.%3.';
        ErrorApproval: label 'Approved Amount of Zero or Less Can not be sent for Approval';
        RejectionDetailsVisible: Boolean;
        ObjLoanStages: Record "Loan Stages";
        ObjLoanApplicationStages: Record "Loan Application Stages";
        ErrorPostingAccount: label 'Specify the Loan Disburesment Account';
        DevSubCategoryVisible: Boolean;


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

            LoanPurposeEditable := true;
            RecoveryModeEditable := true;
            Remarkseditable := true;
            LoanPurposeEditable := true;
            CopyofIDEditable := true;
            CopyofPayslipEditable := true;
            AccountNoEditable := true;
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
            LoanPurposeEditable := false;
            RecoveryModeEditable := false;
            Remarkseditable := false;
            LoanPurposeEditable := false;
            CopyofIDEditable := false;
            CopyofPayslipEditable := false;
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
            LoanPurposeEditable := false;
            RecoveryModeEditable := false;
            Remarkseditable := false;
            LoanPurposeEditable := false;
            CopyofIDEditable := false;
            CopyofPayslipEditable := false;
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
            LoanPurposeEditable := false;
            RecoveryModeEditable := false;
            Remarkseditable := false;
            LoanPurposeEditable := false;
        end;
    end;


    procedure LoanAppPermisions()
    begin
    end;


    procedure FnSendReceivedApplicationSMS()
    begin

        GenSetUp.Get;
        compinfo.Get;



        //SMS MESSAGE
        SMSMessage.Reset;
        if SMSMessage.Find('+') then begin
            iEntryNo := SMSMessage."Entry No";
            iEntryNo := iEntryNo + 1;
        end
        else begin
            iEntryNo := 1;
        end;


        SMSMessage.Init;
        SMSMessage."Entry No" := iEntryNo;
        SMSMessage."Batch No" := "Batch No.";
        SMSMessage."Document No" := "Loan  No.";
        SMSMessage."Account No" := "Account No";
        SMSMessage."Date Entered" := Today;
        SMSMessage."Time Entered" := Time;
        SMSMessage.Source := 'LOANAPP';
        SMSMessage."Entered By" := UserId;
        SMSMessage."Sent To Server" := SMSMessage."sent to server"::No;
        SMSMessage."SMS Message" := 'Dear Member,Your Loan of amount ' + Format("Requested Amount") + ' for ' +
        "Client Code" + ' ' + "Client Name" + ' has been received and is being Processed '
        + compinfo.Name + ' ' + GenSetUp."Customer Care No";
        Cust.Reset;
        Cust.SetRange(Cust."No.", "Client Code");
        if Cust.Find('-') then begin
            SMSMessage."Telephone No" := Cust."Mobile Phone No";
        end;
        if Cust."Mobile Phone No" <> '' then
            SMSMessage.Insert;
    end;

    local procedure FnSendReceivedLoanApplEmail(LoanNo: Code[20])
    var
        LoanRec: Record "Loans Register";
        SMTPMail: Codeunit "SMTP Mail";
        SMTPSetup: Record "SMTP Mail Setup";
        FileName: Text[100];
        Attachment: Text[250];
        CompanyInfo: Record "Company Information";
        Cust: Record Customer;
        Email: Text[50];
        Recipient: List of [Text];
    begin
        SMTPSetup.Get();

        LoanRec.Reset;
        LoanRec.SetRange(LoanRec."Loan  No.", LoanNo);
        if LoanRec.Find('-') then begin
            if Cust.Get(LoanRec."Client Code") then begin
                Email := Cust."E-Mail (Personal)";
                if Cust."E-Mail (Personal)" <> '' then begin

                    if Email = '' then begin
                        Error('Email Address Missing for LoanRecer Application number' + '-' + LoanRec."Loan  No.");
                    end;
                    if Email <> '' then
                        Recipient.Add(Email);
                    SMTPMail.CreateMessage(SMTPSetup."Email Sender Name", SMTPSetup."Email Sender Address", Recipient, 'Loan Application', '', true);
                    SMTPMail.AppendBody(StrSubstNo(LoanAppMessage, LoanRec."Client Name", IDNo, UserId));
                    SMTPMail.AppendBody(SMTPSetup."Email Sender Name");
                    SMTPMail.AppendBody('<br><br>');
                    SMTPMail.AddAttachment(FileName, Attachment);
                    SMTPMail.Send;
                end;
            end;
        end;
    end;

    local procedure FnSendGuarantorAppSMS(LoanNo: Code[20])
    var
        Cust: Record Customer;
        Sms: Record "SMS Messages";

    begin
        LGuarantors.Reset;
        LGuarantors.SetRange(LGuarantors."Loan No", "Loan  No.");
        if LGuarantors.FindFirst then begin
            repeat
                if Cust.Get(LGuarantors."Account No.") then
                    if Cust."Mobile Phone No" <> '' then


                        //SMS MESSAGE
                        SMSMessage.Reset;
                if SMSMessage.Find('+') then begin
                    iEntryNo := SMSMessage."Entry No";
                    iEntryNo := iEntryNo + 1;
                end
                else begin
                    iEntryNo := 1;
                end;


                SMSMessage.Init;
                SMSMessage."Entry No" := iEntryNo;
                SMSMessage."Batch No" := "Batch No.";
                SMSMessage."Document No" := "Loan  No.";
                SMSMessage."Account No" := "Account No";
                SMSMessage."Date Entered" := Today;
                SMSMessage."Time Entered" := Time;
                SMSMessage.Source := 'GUARANTORSHIP';
                SMSMessage."Entered By" := UserId;
                SMSMessage."Sent To Server" := SMSMessage."sent to server"::No;
                SMSMessage."SMS Message" := 'Dear Member,You have guaranteed ' + Format("Client Name")
                + ' ' + "Loan Product Type" + ' of KES. ' + Format("Approved Amount") + ',' + ' ' + 'Call,' + ' ' + compinfo."Phone No." + ',if in dispute .' + ' ' + compinfo.Name + ' ' + GenSetUp."Customer Care No";
                Cust.Reset;
                Cust.SetRange(Cust."No.", "Client Code");
                if Cust.Find('-') then begin
                    SMSMessage."Telephone No" := Cust."Mobile Phone No";
                end;
                if Cust."Mobile Phone No" <> '' then
                    SMSMessage.Insert;

            until LGuarantors.Next = 0;
        end
    end;

    local procedure FnVisibility()
    begin
        PayslipDetailsVisible := false;
        BankStatementDetailsVisible := false;

        if "Income Type" = "income type"::"Bank Statement" then begin
            BankStatementDetailsVisible := true;
            PayslipDetailsVisible := false
        end else
            if "Income Type" = "income type"::Payslip then begin
                PayslipDetailsVisible := true;
                BankStatementDetailsVisible := false;
            end else
                if "Income Type" = "income type"::"Payslip & Bank Statement" then begin
                    PayslipDetailsVisible := true;
                    BankStatementDetailsVisible := true;
                end;
    end;

    local procedure FnRunCreateLoanStages()
    var
        ObjLoanStages: Record "Loan Stages";
        ObjLoanApplicationStages: Record "Loan Application Stages";
        ObjLoanGuarantors: Record "Loans Guarantee Details";
        ObjLoanCollateral: Record "Loan Collateral Details";
    begin
        ObjLoanApplicationStages.Reset;
        ObjLoanApplicationStages.SetRange("Loan No", "Loan  No.");
        if ObjLoanApplicationStages.FindSet then begin
            ObjLoanApplicationStages.DeleteAll;
        end;

        //=========================================================================================Loan Stages Based On Amount
        ObjLoanStages.Reset;
        ObjLoanStages.SetRange("Mobile App Specific", false);
        if ObjLoanStages.Find('-') then begin
            repeat
                if ("Requested Amount" >= ObjLoanStages."Min Loan Amount") and ("Requested Amount" <= ObjLoanStages."Max Loan Amount") then begin

                    ObjLoanApplicationStages.Init;
                    ObjLoanApplicationStages."Loan No" := "Loan  No.";
                    ObjLoanApplicationStages."Member No" := "Client Code";
                    ObjLoanApplicationStages."Member Name" := "Client Name";
                    ObjLoanApplicationStages."Loan Stage" := ObjLoanStages."Loan Stage";
                    ObjLoanApplicationStages."Loan Stage Description" := ObjLoanStages."Loan Stage Description";
                    ObjLoanApplicationStages.Insert;
                end;
            until ObjLoanStages.Next = 0;
        end;

        //=========================================================================================Loan Stages Based On Group Guarantorship
        ObjLoanGuarantors.Reset;
        ObjLoanGuarantors.SetRange(ObjLoanGuarantors."Loan No", "Loan  No.");
        if ObjLoanGuarantors.Find('-') = true then begin
            if "Member House Group" <> '' then begin
                ObjLoanStages.Reset;
                ObjLoanStages.SetRange("Mobile App Specific", false);
                ObjLoanStages.SetRange(ObjLoanStages."Loan Security Applicable", ObjLoanStages."loan security applicable"::"Group Guarantorship");
                if ObjLoanStages.FindSet then begin
                    repeat
                        ObjLoanApplicationStages.Init;
                        ObjLoanApplicationStages."Loan No" := "Loan  No.";
                        ObjLoanApplicationStages."Member No" := "Client Code";
                        ObjLoanApplicationStages."Member Name" := "Client Name";
                        ObjLoanApplicationStages."Loan Stage" := ObjLoanStages."Loan Stage";
                        ObjLoanApplicationStages."Loan Stage Description" := ObjLoanStages."Loan Stage Description";
                        ObjLoanApplicationStages.Insert;
                    until ObjLoanStages.Next = 0;
                end;
            end;
        end;

        //=========================================================================================Loan Stages Based On Collateral Security
        ObjLoanCollateral.Reset;
        ObjLoanCollateral.SetRange(ObjLoanCollateral."Loan No", "Loan  No.");
        if ObjLoanCollateral.Find('-') = true then begin

            ObjLoanStages.Reset;
            ObjLoanStages.SetRange("Mobile App Specific", false);
            ObjLoanStages.SetRange(ObjLoanStages."Loan Security Applicable", ObjLoanStages."loan security applicable"::"Collateral Security");
            if ObjLoanStages.FindSet then begin
                repeat
                    ObjLoanApplicationStages.Init;
                    ObjLoanApplicationStages."Loan No" := "Loan  No.";
                    ObjLoanApplicationStages."Member No" := "Client Code";
                    ObjLoanApplicationStages."Member Name" := "Client Name";
                    ObjLoanApplicationStages."Loan Stage" := ObjLoanStages."Loan Stage";
                    ObjLoanApplicationStages."Loan Stage Description" := ObjLoanStages."Loan Stage Description";
                    ObjLoanApplicationStages.Insert;
                until ObjLoanStages.Next = 0;
            end;
        end;

        //=========================================================================================Loan Stages Common On All Applications
        ObjLoanStages.Reset;
        ObjLoanStages.SetRange("Mobile App Specific", false);
        ObjLoanStages.SetFilter("Loan Purpose", '=%1', '');
        ObjLoanStages.SetRange(ObjLoanStages."Loan Security Applicable", ObjLoanStages."loan security applicable"::All);
        ObjLoanStages.SetFilter("Min Loan Amount", '=%1', 0);
        if ObjLoanStages.FindSet then begin
            repeat
                ObjLoanApplicationStages.Init;
                ObjLoanApplicationStages."Loan No" := "Loan  No.";
                ObjLoanApplicationStages."Member No" := "Client Code";
                ObjLoanApplicationStages."Member Name" := "Client Name";
                ObjLoanApplicationStages."Loan Stage" := ObjLoanStages."Loan Stage";
                ObjLoanApplicationStages."Loan Stage Description" := ObjLoanStages."Loan Stage Description";
                ObjLoanApplicationStages.Insert;
            until ObjLoanStages.Next = 0;
        end;

        //=========================================================================================Loan Stages Based On Education Finance
        if "Loan Purpose" <> '' then begin
            ObjLoanStages.Reset;
            ObjLoanStages.SetRange("Mobile App Specific", false);
            ObjLoanStages.SetFilter("Loan Purpose", '<>%1', '');
            ObjLoanStages.SetRange(ObjLoanStages."Loan Purpose", "Loan Purpose");
            if ObjLoanStages.FindSet then begin
                repeat
                    ObjLoanApplicationStages.Init;
                    ObjLoanApplicationStages."Loan No" := "Loan  No.";
                    ObjLoanApplicationStages."Member No" := "Client Code";
                    ObjLoanApplicationStages."Member Name" := "Client Name";
                    ObjLoanApplicationStages."Loan Stage" := ObjLoanStages."Loan Stage";
                    ObjLoanApplicationStages."Loan Stage Description" := ObjLoanStages."Loan Stage Description";
                    ObjLoanApplicationStages.Insert;
                until ObjLoanStages.Next = 0;
            end;
        end;
    end;
}

