#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50574 "Loans Application Card(Approv)"
{
    DelayedInsert = false;
    DeleteAllowed = false;
    ModifyAllowed = true;
    PageType = Card;
    ShowFilter = false;
    SourceTable = "Loans Register";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Loan  No."; "Loan  No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Client Code"; "Client Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member No';
                    Editable = MNoEditable;
                }
                field("Account No"; "Account No")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loan Disburesment Account';
                }
                field("Client Name"; "Client Name")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member Name';
                    Editable = false;
                }
                field("ID NO"; "ID NO")
                {
                    ApplicationArea = Basic;
                    Caption = 'ID No';
                    Editable = false;
                }
                field("Global Dimension 2 Code"; "Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Member Credit Score"; "Member Credit Score")
                {
                    ApplicationArea = Basic;
                    Caption = 'Credit Score';
                    Editable = false;
                }
                field("1 3rd of Basic"; "1 3rd of Basic")
                {
                    ApplicationArea = Basic;
                    Caption = 'Credit Score Description';
                    Editable = false;
                    StyleExpr = CoveragePercentStyle;
                }
                field("Member Deposits"; "Member Deposits")
                {
                    ApplicationArea = Basic;
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
                field("Grace Period - Principle (M)"; "Grace Period - Principle (M)")
                {
                    ApplicationArea = Basic;
                }
                field("Grace Period - Interest (M)"; "Grace Period - Interest (M)")
                {
                    ApplicationArea = Basic;
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
                    Editable = AppliedAmountEditable;

                    trigger OnValidate()
                    begin
                        TestField(Posted, false);
                    end;
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

                    trigger OnValidate()
                    begin
                        TestField(Posted, false);
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
                field("Loan Purpose"; "Loan Purpose")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                    Visible = false;
                }
                field("Loan Purpose Description"; "Loan Purpose Description")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Remarks; Remarks)
                {
                    ApplicationArea = Basic;
                    Editable = RemarksEditable;
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
                    Editable = RepaymentEditable;
                }
                field("Approved Repayment"; "Approved Repayment")
                {
                    ApplicationArea = Basic;
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
                field("Loan Status"; "Loan Status")
                {
                    ApplicationArea = Basic;
                    Editable = LoanStatusEditable;

                    trigger OnValidate()
                    begin
                        //UpdateControl();
                    end;
                }
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
                }
                field("Repayment Frequency"; "Repayment Frequency")
                {
                    ApplicationArea = Basic;
                }
                field("Mode of Disbursement"; "Mode of Disbursement")
                {
                    ApplicationArea = Basic;
                }
                field("Paying Bank Account No"; "Paying Bank Account No")
                {
                    ApplicationArea = Basic;
                }
                field("Cheque No."; "Cheque No.")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        if StrLen("Cheque No.") > 6 then
                            Error('Document No. cannot contain More than 6 Characters.');
                    end;
                }
                field("Batch No."; "Batch No.")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Disbursement Date"; "Loan Disbursement Date")
                {
                    ApplicationArea = Basic;
                    AssistEdit = true;
                    Editable = EditableField;
                    Enabled = EditableField;
                    Importance = Promoted;
                    NotBlank = true;
                    ShowMandatory = true;
                    Style = Attention;
                    StyleExpr = true;
                }
                field("Repayment Start Date"; "Repayment Start Date")
                {
                    ApplicationArea = Basic;
                }
                field("Expected Date of Completion"; "Expected Date of Completion")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("External EFT"; "External EFT")
                {
                    ApplicationArea = Basic;
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
                field("Disburesment Type"; "Disburesment Type")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        TrunchDetailsVisible := false;
                        if "Disburesment Type" = "disburesment type"::"Tranche/Multiple Disbursement" then
                            TrunchDetailsVisible := true;
                    end;
                }
            }
            group("Disburesement Bank Details")
            {
                field("Bank code"; "Bank code")
                {
                    ApplicationArea = Basic;
                }
                field("Bank Name"; "Bank Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Bank Branch"; "Bank Branch")
                {
                    ApplicationArea = Basic;
                }
                field("Bank Branch Name"; "Bank Branch Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Bank Account No"; "Bank Account No")
                {
                    ApplicationArea = Basic;
                }
                part(Control38; "Loan Application Stages")
                {
                    Caption = 'Loan Stages';
                    SubPageLink = "Loan No" = field("Loan  No.");
                    Visible = false;
                }
            }
            group("Salary Details")
            {
                Caption = 'Salary Details';
                Visible = PayslipDetailsVisible;
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
            part(Control1000000001; "Loans Guarantee Details")
            {
                Caption = 'Guarantors  Detail';
                SubPageLink = "Loan No" = field("Loan  No.");
            }
            part(Control1000000000; "Loan Collateral Security")
            {
                Caption = 'Other Securities';
                SubPageLink = "Loan No" = field("Loan  No.");
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
                    Caption = 'Loan Appraisal';
                    Enabled = true;
                    Image = GanttChart;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        TestField("Mode of Disbursement");
                        LoanApp.Reset;
                        LoanApp.SetRange(LoanApp."Loan  No.", "Loan  No.");
                        if LoanApp.Find('-') then begin
                            Report.run(50355, true, false, LoanApp)
                        end;
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
                action("Re-Open Loan")
                {
                    ApplicationArea = Basic;
                    Image = Status;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        if Confirm('Confirm Re-Open Loan?', false) = true then begin
                            "Approval Status" := "approval status"::Open;
                            "Loan Status" := "loan status"::Application;

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
                                    ObjLoanApplicationStages."Stage Status" := ObjLoanApplicationStages."stage status"::Succesful;
                                    ObjLoanApplicationStages."Updated By" := UserId;
                                    ObjLoanApplicationStages."Date Upated" := WorkDate;
                                    ObjLoanApplicationStages.Insert;
                                until ObjLoanStages.Next = 0;
                            end;

                        end;
                        CurrPage.Close;
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
                        Report.run(50920, true, false, ObjMemberCellG);
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

                        SFactory.FnGenerateLoanRepaymentSchedule("Loan  No.");

                        LoanApp.Reset;
                        LoanApp.SetRange(LoanApp."Loan  No.", "Loan  No.");
                        if LoanApp.Find('-') then begin
                            Commit;
                            Report.Run(50477, true, false, LoanApp);
                        end;
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
                action("Disburse Loan")
                {
                    ApplicationArea = Basic;
                    Caption = 'Disburse Loan';
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        VarMailSubject: Text[200];
                        VarMailBody: Text[250];
                    begin
                        ObjMemberLedger.Reset;
                        ObjMemberLedger.SetRange(ObjMemberLedger."Loan No", "Loan  No.");
                        ObjMemberLedger.SetRange(ObjMemberLedger.Reversed, false);
                        if ObjMemberLedger.FindSet then begin
                            Message('Loan already Posted');
                            Posted := true;
                            "Loan Status" := "loan status"::Disbursed;
                            "Loan Disbursement Date" := WorkDate;
                            "Issued Date" := WorkDate;
                            CurrPage.Close;
                            exit;
                        end;


                        FnRunCheckLoanStages;//=======================Check that All loan Stages are Succesful

                        //Check if Collateral Details have been Updated
                        ObjCollateral.Reset;
                        ObjCollateral.SetRange(ObjCollateral."Loan No", "Loan  No.");
                        if ObjCollateral.FindSet = true then begin
                            if ObjCollateral."Collateral Registe Doc" = '' then begin
                                Error('Update the Collateral details on the Collateral register # Go to collateral details>>Collateral register Doc');
                            end;

                            if ObjCollateral.Value = 0 then begin
                                Error('Update the Collateral market value')
                            end;

                            if ObjCollateral."Registered Owner" = '' then begin
                                Error('Update the Collateral Registered Owner')
                            end;

                            if ObjCollateral."Reference No" = '' then begin
                                Error('Update the Collateral Reference No')
                            end;
                        end;



                        if Posted = true then
                            Error('Loan already posted.');

                        if "Approved Amount" <= 0 then
                            Error('You cannot post this Amount Less or Equal to Zero');

                        if "Repayment Start Date" <= WorkDate then
                            Error('The Loan Repayment Start Date must be greater than today.');

                        if Confirm('Are you sure you want to Disburse this Loan? \\The Loan Repayment Start Date specified is ' +
                          Format("Repayment Start Date", 0, '<Day,2> <Month Text,3> <Year4>') + '\\Proceed?', false) = true then begin
                            SFactory.FnGenerateLoanRepaymentSchedule("Loan  No.");

                            /*LoanGuar.RESET;
                            LoanGuar.SETRANGE(LoanGuar."Loan No","Loan  No.");
                            IF LoanGuar.FIND('-') THEN
                              BEGIN
                                REPEAT
                                  Cust.RESET;
                                  Cust.SETRANGE(Cust."No.",LoanGuar."Member No");
                                  IF Cust.FIND('-') THEN
                                    BEGIN
                                       SFactory.FnSendSMS('LOAN GUARANTORS','You have guaranteed an amount of '+FORMAT(LoanGuar."Amont Guaranteed")
                                      +' to '+"Client Name"+' Staff No:-'+"Staff No"+' '+
                                      'Loan Type '+"Loan Product Type"+' of '+FORMAT("Requested Amount") +' at Kingdom Sacco Ltd.',Cust."FOSA Account No.",Cust."Phone No.");
                                    END;
                               UNTIL LoanGuar.NEXT=0;
                            END;*/

                            //SFactory.FnSendSMS('LOAN ISSUE','Your loan application of KSHs.'+FORMAT("Approved Amount")+' has been disbursed.',Cust."FOSA Account No.",Cust."Phone No.");

                            "Loan Disbursement Date" := Today;
                            TestField("Loan Disbursement Date");
                            "Posting Date" := "Loan Disbursement Date";
                            BATCH_TEMPLATE := 'PAYMENTS';
                            BATCH_NAME := 'LOANS';
                            DOCUMENT_NO := "Loan  No.";
                            GenJournalLine.Reset;
                            GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                            GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                            GenJournalLine.DeleteAll;


                            //=========================================================================Disburesment to FOSA Account
                            ObjLoans.Reset;
                            ObjLoans.SetRange(ObjLoans."Loan  No.", "Loan  No.");
                            if ObjLoans.FindSet then begin

                                if "Mode of Disbursement" = "mode of disbursement"::" " then begin
                                    ObjLoans."Mode of Disbursement" := "mode of disbursement"::"FOSA Account";
                                    ObjLoans.Modify;
                                end;

                                if ObjLoans."Mode of Disbursement" = "mode of disbursement"::"FOSA Account" then begin
                                    FnDisburseToCurrentAccount(Rec);


                                    //CU posting
                                    GenJournalLine.Reset;
                                    GenJournalLine.SetRange("Journal Template Name", 'PAYMENTS');
                                    GenJournalLine.SetRange("Journal Batch Name", 'LOANS');
                                    if GenJournalLine.Find('-') then begin
                                        Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJournalLine);
                                    end;

                                    FnRunDisbursementSMS;//=============================================================================Send Disburesment SMS

                                    ObjLoansII.Reset;
                                    ObjLoansII.SetRange(ObjLoansII."Loan  No.", "Loan  No.");
                                    if ObjLoansII.FindSet then begin
                                        ObjMemberLedger.Reset;
                                        ObjMemberLedger.SetRange(ObjMemberLedger."Loan No", "Loan  No.");
                                        if ObjMemberLedger.FindSet then begin
                                            ObjLoansII.Posted := true;
                                            ObjLoansII."Loan Status" := "loan status"::Disbursed;
                                            ObjLoansII."Issued Date" := WorkDate;
                                            ObjLoansII."Offset Eligibility Amount" := "Approved Amount" * 0.5;
                                            ObjLoansII."Posting Date" := WorkDate;
                                            ObjLoansII."Disbursed By" := UserId;
                                            ObjLoansII."Loan Disbursement Date" := Today;


                                            if ("Disburesment Type" = "disburesment type"::" ") or ("Disburesment Type" = "disburesment type"::"Full/Single disbursement") then begin
                                                ObjLoansII."Tranch Amount Disbursed" := "Approved Amount"
                                            end else
                                                ObjLoansII."Tranch Amount Disbursed" := "Amount to Disburse on Tranch 1";

                                            ObjLoansII.Modify;
                                        end;
                                    end;
                                end;
                            end;

                            //=========================================================================Disburesment to Bank Account
                            ObjLoans.Reset;
                            ObjLoans.SetRange(ObjLoans."Loan  No.", "Loan  No.");
                            if ObjLoans.FindSet then begin

                                if "Mode of Disbursement" = "mode of disbursement"::" " then begin
                                    ObjLoans."Mode of Disbursement" := ObjLoans."mode of disbursement"::Cheque;
                                    ObjLoans.Modify;
                                end;

                                if (ObjLoans."Mode of Disbursement" = ObjLoans."mode of disbursement"::Cheque) or
                                (ObjLoans."Mode of Disbursement" = ObjLoans."mode of disbursement"::EFT) then begin
                                    TestField("Paying Bank Account No");
                                    FnDisburseToBankAccount(Rec);


                                    //CU posting
                                    GenJournalLine.Reset;
                                    GenJournalLine.SetRange("Journal Template Name", 'PAYMENTS');
                                    GenJournalLine.SetRange("Journal Batch Name", 'LOANS');
                                    if GenJournalLine.Find('-') then begin
                                        Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJournalLine);
                                    end;

                                    FnRunDisbursementSMS;//=============================================================================Send Disburesment SMS

                                    ObjLoansII.Reset;
                                    ObjLoansII.SetRange(ObjLoansII."Loan  No.", "Loan  No.");
                                    if ObjLoansII.FindSet then begin
                                        ObjMemberLedger.Reset;
                                        ObjMemberLedger.SetRange(ObjMemberLedger."Loan No", "Loan  No.");
                                        if ObjMemberLedger.FindSet then begin
                                            ObjLoansII.Posted := true;
                                            ObjLoansII."Loan Status" := "loan status"::Disbursed;
                                            ObjLoansII."Issued Date" := WorkDate;
                                            ObjLoansII."Offset Eligibility Amount" := "Approved Amount" * 0.5;
                                            ObjLoansII."Posting Date" := WorkDate;
                                            ObjLoansII."Disbursed By" := UserId;
                                            ObjLoansII."Loan Disbursement Date" := Today;


                                            if ("Disburesment Type" = "disburesment type"::" ") or ("Disburesment Type" = "disburesment type"::"Full/Single disbursement") then begin
                                                ObjLoansII."Tranch Amount Disbursed" := "Approved Amount"
                                            end else
                                                ObjLoansII."Tranch Amount Disbursed" := "Amount to Disburse on Tranch 1";

                                            ObjLoansII.Modify;
                                        end;
                                    end;
                                end;
                            end;

                            //Update Share Boosted Deposits
                            FnUpdateShareBoostedTrans();
                            FnRunCreateLSAfor1sttimeLoanees;//=========================================================Create LSA Account For 1st time Loanees
                            FnRunUpdateDisburesmentLoanStage;//========================================================Update Disburesment Loan Stage on the Loan Application Stages
                            FnAccrueInterestOneOffLoans("Loan  No.");//================================================Accrue Interest for Oneoff Loans

                            //============================================================Send Repayment Schedule Via Mail
                            ObjLoans.Reset;
                            ObjLoans.SetRange(ObjLoans."Loan  No.", "Loan  No.");
                            if ObjLoans.FindSet then begin
                                if ObjMember.Get("Client Code") then begin
                                    if (ObjMember."E-Mail" <> '') then begin
                                        VarMemberEmail := Lowercase(ObjMember."E-Mail");

                                        SMTPSetup.Get();
                                        Filename := '';
                                        Filename := SMTPSetup."Path to Save Report" + 'Loan Repayment Schedule.pdf';
                                        Report.SaveAsPdf(Report::"Loans Repayment Schedule", Filename, ObjLoans);

                                        VarMailSubject := 'Loan Repayment Schedule - ' + "Loan  No.";
                                        VarMailBody := 'Your ' + "Loan Product Type Name" + ' Application of Ksh. ' + Format("Approved Amount") + ' has been disbursed to your Account No. ' + ObjMember."Bank Name" + ' Acc no. ' + ObjMember."Bank Account No." +
                                        '. Please find attached the loan repayment schedule for your New Loan Account No. ' + "Loan  No." + '.';

                                        EmailSend := SFactory.FnSendStatementViaMail("Client Name", VarMailSubject, VarMailBody, VarMemberEmail, 'Loan Repayment Schedule.pdf', '');
                                    end;
                                end;
                            end;
                            //============================================================End Send Repayment Schedule Via Mail

                            Message('Loan Disbursed Successfully. The Member has been notified via SMS and Email.');
                            CurrPage.Close;
                        end;

                    end;
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
                            //MODIFY;
                        end;
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
                action("Credit Score Details")
                {
                    ApplicationArea = Basic;
                    Image = Form;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Member Credit Score";
                    RunPageLink = "Member No" = field("Client Code"),
                                  "Report Date" = field("Application Date");
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
                action("Update Offset Details")
                {
                    ApplicationArea = Basic;

                    trigger OnAction()
                    begin
                        /*IF "Loan Offset Amount" > 0 THEN
                        BEGIN
                        LoanTopUp.RESET;
                        LoanTopUp.SETRANGE(LoanTopUp."Loan No.","Loan  No.");
                        IF LoanTopUp.FIND('-') THEN
                        BEGIN
                          LoanTopUp.fn_UpdateLoanOffsetDetails();
                          LoanTopUp.MODIFY;
                        END;
                        END*/
                        Message('Loan Offset Amount %1', LoanApps."Loan Offset Amount");
                        if LoanApps."Loan Offset Amount" > 0 then begin
                            Message('Getting LoanApps."Loan Offset Amount"');
                            LoanTopUp.Reset;
                            LoanTopUp.SetRange(LoanTopUp."Loan No.", LoanApps."Loan  No.");
                            if LoanTopUp.Find('-') then begin
                                LoanTopUp.fn_UpdateLoanOffsetDetails();
                                LoanTopUp.Modify;
                                Message('Modified Loan Offset Amount');
                            end;

                            LoanTopUp.Reset;
                            LoanTopUp.SetRange(LoanTopUp."Loan No.", LoanApps."Loan  No.");
                            if LoanTopUp.Find('-') then
                                Message('Getting Updated Loan Apps');
                        end

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
        UpdateControl();

        TrunchDetailsVisible := false;

        if ("Disburesment Type" = "disburesment type"::"Full/Single disbursement") or ("Disburesment Type" = "disburesment type"::" ") then begin
            TrunchDetailsVisible := false;
        end else
            TrunchDetailsVisible := true;
    end;

    trigger OnOpenPage()
    begin
        EditableField := true;

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
        DOCUMENT_NO: Code[40];
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
        ObjCollateral: Record "Loan Collateral Details";
        ObjCust: Record Customer;
        ObjMemberLedg: Record "Member Ledger Entry";
        ObjMemberCellG: Record "Member House Groups";
        VarAmounttoDisburse: Decimal;
        TrunchDetailsVisible: Boolean;
        LInsurance: Decimal;
        RejectionDetailsVisible: Boolean;
        ObjLoanStages: Record "Loan Stages";
        ObjLoanApplicationStages: Record "Loan Application Stages";
        EmailSend: Boolean;
        ObjMember: Record Customer;
        VarMemberEmail: Text[250];
        Filename: Text[250];
        SMTPSetup: Record "SMTP Mail Setup";
        ObjLoans: Record "Loans Register";
        ObjMemberLedger: Record "Member Ledger Entry";
        VarLineNo: Integer;
        VarMemberName: Text;
        ObjLoansII: Record "Loans Register";
        varShowTranchDisbursement: Boolean;
        CoveragePercentStyle: Text;


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
            InstallmentEditable := true;
            AppliedAmountEditable := false;
            RepayMethodEditable := false;
            RepaymentEditable := false;
            BatchNoEditable := true;
            RepayFrequencyEditable := false;
            ModeofDisburesmentEdit := true;
            DisbursementDateEditable := true;
            RejectionRemarkEditable := false;
            BatchNoEditable := true;
            RemarksEditable := false;
            ApprovedAmountEditable := false;
            ObjCollateral.Reset;
            ObjCollateral.SetRange(ObjCollateral."Loan No", "Loan  No.");
            if ObjCollateral.FindSet = true then begin
                ApprovedAmountEditable := true;
            end;

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
    end;

    local procedure FnDisburseToCurrentAccount(LoanApps: Record "Loans Register")
    var
        ProcessingFees: Decimal;
        ProcessingFeesAcc: Code[50];
        PChargeAmount: Decimal;
        BLoan: Code[30];
        ObjLoans: Record "Loans Register";
        ObjLoanType: Record "Loan Products Setup";
        VarLoanInsuranceBalAccount: Code[30];
    begin

        GenSetUp.Get();
        if LoanApps.Get("Loan  No.") then begin
            LoanApps.CalcFields(LoanApps."Loan Offset Amount", LoanApps."Offset iNTEREST");
            TCharges := 0;
            TopUpComm := 0;
            TotalTopupComm := LoanApps."Loan Offset Amount";

            if ("Disburesment Type" = "disburesment type"::"Full/Single disbursement") or ("Disburesment Type" = "disburesment type"::" ") then begin
                VarAmounttoDisburse := "Approved Amount"
            end else begin
                VarAmounttoDisburse := "Amount to Disburse on Tranch 1";
                if VarAmounttoDisburse <= 0 then
                    Error('You have specified Disbursement Mode as Tranche/Multiple Disbursement, Amount to Disburse on Tranche 1 must be greater than zero.')
            end;

            //------------------------------------1. DEBIT MEMBER LOAN A/C---------------------------------------------------------------------------------------------
            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::Loan,
            GenJournalLine."account type"::None, LoanApps."Client Code", "Posting Date", VarAmounttoDisburse, Format(LoanApps.Source), LoanApps."Loan  No.",
            'Loan Disbursement - ' + LoanApps."Loan Product Type Name", LoanApps."Loan  No.", GenJournalLine."application source"::" ");
            //--------------------------------(Debit Member Loan Account)---------------------------------------------

            //------------------------------------2. CREDIT MEMBER FOSA A/C---------------------------------------------------------------------------------------------
            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
            GenJournalLine."account type"::Vendor, "Account No", "Posting Date", VarAmounttoDisburse * -1, 'BOSA', LoanApps."Loan  No.",
            'Loan Disbursement - ' + LoanApps."Loan Product Type Name" + ' - ' + LoanApps."Loan  No.", LoanApps."Loan  No.", GenJournalLine."application source"::" ");
            //----------------------------------(Credit Member Fosa Account)------------------------------------------------

            //------------------------------------3. EARN/RECOVER PRODUCT CHARGES FROM FOSA A/C--------------------------------------
            PCharges.Reset;
            PCharges.SetRange(PCharges."Product Code", LoanApps."Loan Product Type");
            PCharges.SetFilter(PCharges."Loan Charge Type", '<>%1', PCharges."loan charge type"::"Loan Insurance");
            if PCharges.Find('-') then begin
                repeat
                    PCharges.TestField(PCharges."G/L Account");
                    GenSetUp.TestField(GenSetUp."Excise Duty Account");
                    PChargeAmount := PCharges.Amount;
                    if PCharges."Use Perc" = true then
                        PChargeAmount := (VarAmounttoDisburse * PCharges.Percentage / 100);//LoanDisbAmount
                                                                                           //-------------------EARN CHARGE-------------------------------------------
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::"G/L Account", PCharges."G/L Account", "Posting Date", PChargeAmount * -1, 'BOSA', LoanApps."Loan  No.",
                    PCharges.Description + ' - ' + LoanApps."Client Code" + ' - ' + LoanApps."Loan  No.", LoanApps."Loan  No.", GenJournalLine."application source"::" ");
                    //-------------------RECOVER-----------------------------------------------
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::Vendor, "Account No", "Posting Date", PChargeAmount, 'BOSA', LoanApps."Loan  No.",
                    PCharges.Description + '-' + LoanApps."Loan Product Type Name", LoanApps."Loan  No.", GenJournalLine."application source"::" ");

                    //------------------10% EXCISE DUTY----------------------------------------
                    if SFactory.FnChargeExcise(PCharges.Code) then begin
                        //-------------------Earn---------------------------------
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                        GenJournalLine."account type"::"G/L Account", GenSetUp."Excise Duty Account", "Posting Date", (PChargeAmount * -1) * 0.1, 'BOSA', LoanApps."Loan  No.",
                        PCharges.Description + '-' + LoanApps."Client Code" + '-' + LoanApps."Loan Product Type Name" + '-' + LoanApps."Loan  No." + '- Excise(10%)', LoanApps."Loan  No.", GenJournalLine."application source"::" ");
                        //-----------------Recover---------------------------------
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                        GenJournalLine."account type"::Vendor, "Account No", "Posting Date", PChargeAmount * 0.1, 'BOSA', LoanApps."Loan  No.",
                        PCharges.Description + '-' + LoanApps."Loan Product Type Name" + ' - Excise(10%)', LoanApps."Loan  No.", GenJournalLine."application source"::" ");
                    end
                //----------------END 10% EXCISE--------------------------------------------
                until PCharges.Next = 0;
            end;


            //----------------------------------------4. PAY/RECOVER TOP UPS------------------------------------------------------------------------------------------
            if LoanApps."Loan Offset Amount" > 0 then begin
                LoanTopUp.Reset;
                LoanTopUp.SetRange(LoanTopUp."Loan No.", LoanApps."Loan  No.");
                if LoanTopUp.Find('-') then begin
                    LoanTopUp.fn_UpdateLoanOffsetDetails();
                    LoanTopUp.Modify;
                end;

                LoanTopUp.Reset;
                LoanTopUp.SetRange(LoanTopUp."Loan No.", LoanApps."Loan  No.");
                if LoanTopUp.Find('-') then begin
                    repeat
                        //------------------------------------PAY-----------------------------------------------------------------------------------------------------------
                        //------------------------------------Principal---------------------
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Repayment",
                        GenJournalLine."account type"::None, LoanApps."Client Code", "Posting Date", LoanTopUp."Principle Top Up" * -1, 'BOSA', LoanTopUp."Loan Top Up",
                        'Off Set By - ' + LoanApps."Client Code" + '-' + LoanApps."Loan  No.", LoanTopUp."Loan Top Up", GenJournalLine."application source"::" ");
                        //------------------------------------Outstanding Interest----------
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Interest Paid",
                        GenJournalLine."account type"::None, LoanApps."Client Code", "Posting Date", LoanTopUp."Interest Top Up" * -1, 'BOSA', LoanTopUp."Loan Top Up",
                        'Interest Paid- ' + LoanApps."Client Code" + '-' + LoanApps."Loan  No.", LoanTopUp."Loan Top Up", GenJournalLine."application source"::" ");
                        //-------------------------------------Levy--------------------------
                        LineNo := LineNo + 10000;
                        if LoanType.Get(LoanApps."Loan Product Type") then begin
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                            GenJournalLine."account type"::"G/L Account", LoanType."Top Up Commision Account", "Posting Date", LoanTopUp.Commision * -1, 'BOSA', LoanTopUp."Loan Top Up",
                            'Levy on Bridging -' + LoanApps."Client Code" + '-' + LoanApps."Loan  No.", LoanTopUp."Loan Top Up", GenJournalLine."application source"::" ");
                        end;

                        //-------------------------------------Loan Insurance--------------------------
                        LineNo := LineNo + 10000;
                        if LoanType.Get(LoanApps."Loan Product Type") then begin
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Insurance Paid",
                            GenJournalLine."account type"::None, LoanApps."Client Code", "Posting Date", LoanTopUp."Loan Insurance: Current Year" * -1, 'BOSA', LoanTopUp."Loan Top Up",
                            'Insurance on Loan Clearance -' + LoanApps."Client Code" + '-' + LoanApps."Loan  No.", LoanTopUp."Loan Top Up", GenJournalLine."application source"::" ");
                        end;

                        if ObjLoans.Get(LoanTopUp."Loan Top Up") then begin
                            if ObjLoanType.Get(ObjLoans."Loan Product Type") then begin
                                VarLoanInsuranceBalAccount := ObjLoanType."Loan Insurance Accounts";
                            end;
                        end;


                        //------------------------------------DEBIT INSURANCE FOR THE CURRENT YEAR  A/C---------------------------------------------------------------------------------------------

                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLineBalanced(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Insurance Charged",
                        GenJournalLine."account type"::None, LoanApps."Client Code", WorkDate, 'Loan Insurance:Diff. Calender Year _' + LoanTopUp."Loan Top Up", GenJournalLine."bal. account type"::"G/L Account",
                        VarLoanInsuranceBalAccount, LoanTopUp."Loan Insurance: Current Year", 'FOSA', LoanTopUp."Loan Top Up");
                        //--------------------------------(Credit Loan Penalty Account)-------------------------------------------------------------------------------

                        //-------------------------------------RECOVER-------------------------------------------------------------------------------------------------------
                        //-------------------------------------Principal-----------------------------------------------------------------------------------------------
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                        GenJournalLine."account type"::Vendor, "Account No", "Posting Date", LoanTopUp."Principle Top Up", 'BOSA', LoanTopUp."Loan Top Up",
                        'Loan Offset  - ' + LoanApps."Loan Product Type Name", LoanTopUp."Loan Top Up", GenJournalLine."application source"::" ");
                        //-------------------------------------Outstanding Interest-------------------------------------------------------------------------------------
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                        GenJournalLine."account type"::Vendor, "Account No", "Posting Date", LoanTopUp."Interest Top Up", 'BOSA', LoanTopUp."Loan Top Up",
                        'Interest Paid on topup - ' + LoanApps."Loan Product Type Name", LoanTopUp."Loan Top Up", GenJournalLine."application source"::" ");

                        //-------------------------------------Insurance For the Year-------------------------------------------------------------------------------------
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                        GenJournalLine."account type"::Vendor, "Account No", "Posting Date", LoanTopUp."Loan Insurance: Current Year", 'BOSA', LoanTopUp."Loan Top Up",
                        'Insurance on Loan Clearance - ' + LoanApps."Loan Product Type Name", LoanTopUp."Loan Top Up", GenJournalLine."application source"::" ");
                        //--------------------------------------Levies--------------------------------------------------------------------------------------------------
                        LineNo := LineNo + 10000;
                        if LoanType.Get(LoanApps."Loan Product Type") then begin
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                            GenJournalLine."account type"::Vendor, "Account No", "Posting Date", LoanTopUp.Commision, 'BOSA', LoanTopUp."Loan Top Up",
                            'Levy on Bridging - ' + LoanApps."Loan Product Type Name", LoanTopUp."Loan Top Up", GenJournalLine."application source"::" ");
                        end;

                        //------------------------------Credit Excise Duty Account-----------------------------------------------
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                        GenJournalLine."account type"::"G/L Account", GenSetUp."Excise Duty Account", "Posting Date", (LoanTopUp.Commision * (GenSetUp."Excise Duty(%)" / 100)) * -1, 'BOSA', BLoan,
                        'Excise Duty_Levy on Bridging', BLoan, GenJournalLine."application source"::" ");

                        //----------------------Debit FOSA A/C Excise Duty on Bridging Fee-----------------------------------------------------
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                        GenJournalLine."account type"::Vendor, "Account No", "Posting Date", (LoanTopUp.Commision * (GenSetUp."Excise Duty(%)" / 100)), 'BOSA', BLoan,
                        'Excise Duty_Levy on Bridging', BLoan, GenJournalLine."application source"::" ");
                    until LoanTopUp.Next = 0;
                end;
            end;

            //-----------------------------------------Accrue Interest Disburesment--------------------------------------------------------------------------------------------
            if LoanType.Get(LoanApps."Loan Product Type") then begin
                if LoanType."Accrue Total Insurance&Interes" = true then begin

                    //----------------------Debit interest Receivable Account a/c-----------------------------------------------------
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Interest Due",
                    GenJournalLine."account type"::None, LoanApps."Client Code", "Posting Date", (LoanApps."Approved Amount" * (LoanType."Interest rate" / 1200)) * LoanType."No of Installment", 'BOSA', BLoan,
                    'Interest Due' + '_' + LoanApps."Loan  No.", LoanApps."Loan  No.", GenJournalLine."application source"::" ");

                    //----------------------Credit interest Income Account a/c-----------------------------------------------------
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::"G/L Account", LoanType."Loan Interest Account", "Posting Date", ((LoanApps."Approved Amount" * (LoanType."Interest rate" / 1200)) * LoanType."No of Installment") * -1, 'BOSA', BLoan,
                    'Interest Due' + '_' + LoanApps."Loan  No.", LoanApps."Loan  No.", GenJournalLine."application source"::" ");
                end;
            end;


            //-----------------------------------------Accrue insurance on Disburesment--------------------------------------------------------------------------------------------

            if LoanType.Get(LoanApps."Loan Product Type") then begin
                if LoanType."Accrue Total Insurance&Interes" = true then begin


                    PCharges.Reset;
                    PCharges.SetRange(PCharges."Product Code", LoanApps."Loan Product Type");
                    PCharges.SetRange(PCharges."Loan Charge Type", PCharges."loan charge type"::"Loan Insurance");
                    if PCharges.Find('-') then begin
                        PCharges.TestField(PCharges."G/L Account");
                        GenSetUp.TestField(GenSetUp."Excise Duty Account");
                        PChargeAmount := PCharges.Amount;
                        if PCharges."Use Perc" = true then
                            PChargeAmount := (LoanApps."Approved Amount" * PCharges.Percentage / 100);
                        //----------------------Debit insurance Receivable Account a/c-----------------------------------------------------
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Insurance Charged",
                        GenJournalLine."account type"::None, LoanApps."Client Code", "Posting Date", PChargeAmount * LoanType."No of Installment", 'BOSA', BLoan,
                        'Insurance Charged' + '_' + LoanApps."Loan  No.", LoanApps."Loan  No.", GenJournalLine."application source"::" ");

                        //----------------------Credit Insurance Payable Account a/c-----------------------------------------------------
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                        GenJournalLine."account type"::"G/L Account", LoanType."Loan Insurance Accounts", "Posting Date", (PChargeAmount * LoanType."No of Installment") * -1, 'BOSA', BLoan,
                        'Insurance Charged' + '_' + LoanApps."Loan  No.", LoanApps."Loan  No.", GenJournalLine."application source"::" ");
                    end;
                end;
            end;



            //-----------------------------------------5. BOOST DEPOSITS COMMISSION / RECOVER FROM FOSA A/C--------------------------------------------------------------------------------------------
            if LoanApps."Share Boosting Comission" > 0 then begin

                //----------------------Debit FOSA a/c-----------------------------------------------------
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                GenJournalLine."account type"::Vendor, "Account No", "Posting Date", LoanApps."Share Boosting Comission", 'BOSA', BLoan,
                'Deposits Boosting Fee', BLoan, GenJournalLine."application source"::" ");

                GenSetUp.Get();
                //------------------------------Credit Income G/L-----------------------------------------------
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                GenJournalLine."account type"::"G/L Account", GenSetUp."Boosting Fees Account", "Posting Date", LoanApps."Share Boosting Comission" * -1, 'BOSA', BLoan,
                'Deposits Boosting Fee', BLoan, GenJournalLine."application source"::" ");

                //----------------------Debit FOSA A/C Excise Duty on Boosting Fee-----------------------------------------------------
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                GenJournalLine."account type"::Vendor, "Account No", "Posting Date", (LoanApps."Share Boosting Comission" * (GenSetUp."Excise Duty(%)" / 100)), 'BOSA', BLoan,
                'Excise Duty_Boosting Fee', BLoan, GenJournalLine."application source"::" ");

                GenSetUp.Get();
                //------------------------------Credit Excise Duty Account-----------------------------------------------
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                GenJournalLine."account type"::"G/L Account", GenSetUp."Excise Duty Account", "Posting Date", (LoanApps."Share Boosting Comission" * (GenSetUp."Excise Duty(%)" / 100)) * -1, 'BOSA', BLoan,
                'Excise Duty_Boosting Fee', BLoan, GenJournalLine."application source"::" ");


            end;


            if ObjLoans.Get("Loan  No.") then begin
                ObjLoans."Net Payment to FOSA" := ObjLoans."Approved Amount";
                ObjLoans."Processed Payment" := true;
                ObjLoans.Modify;
            end;
        end;
    end;

    local procedure FnDisburseToBankAccount(LoanApps: Record "Loans Register")
    var
        ProcessingFees: Decimal;
        ProcessingFeesAcc: Code[50];
        PChargeAmount: Decimal;
        BLoan: Code[30];
        ObjLoans: Record "Loans Register";
        ObjLoanType: Record "Loan Products Setup";
        VarLoanInsuranceBalAccount: Code[30];
        TotalPCharges: Decimal;
    begin

        GenSetUp.Get();
        if LoanApps.Get("Loan  No.") then begin
            LoanApps.CalcFields(LoanApps."Loan Offset Amount", LoanApps."Offset iNTEREST");
            TCharges := 0;
            TopUpComm := 0;
            TotalTopupComm := LoanApps."Loan Offset Amount";

            if ("Disburesment Type" = "disburesment type"::"Full/Single disbursement") or ("Disburesment Type" = "disburesment type"::" ") then begin
                VarAmounttoDisburse := "Approved Amount"
            end else begin
                VarAmounttoDisburse := "Amount to Disburse on Tranch 1";
                if VarAmounttoDisburse <= 0 then
                    Error('You have specified Disbursement Mode as Tranche/Multiple Disbursement, Amount to Disburse on Tranche 1 must be greater than zero.')
            end;

            //------------------------------------1. DEBIT MEMBER LOAN A/C---------------------------------------------------------------------------------------------
            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::Loan,
            GenJournalLine."account type"::None, LoanApps."Client Code", "Posting Date", VarAmounttoDisburse, Format(LoanApps.Source), LoanApps."Loan  No.",
            'Loan Disbursement - ' + LoanApps."Loan Product Type Name", LoanApps."Loan  No.", GenJournalLine."application source"::" ");
            //--------------------------------(Debit Member Loan Account)---------------------------------------------



            //------------------------------------3. EARN/RECOVER PRODUCT CHARGES FROM FOSA A/C--------------------------------------
            PCharges.Reset;
            PCharges.SetRange(PCharges."Product Code", LoanApps."Loan Product Type");
            PCharges.SetFilter(PCharges."Loan Charge Type", '<>%1', PCharges."loan charge type"::"Loan Insurance");
            if PCharges.Find('-') then begin
                repeat
                    PCharges.TestField(PCharges."G/L Account");
                    GenSetUp.TestField(GenSetUp."Excise Duty Account");
                    PChargeAmount := PCharges.Amount;
                    if PCharges."Use Perc" = true then
                        PChargeAmount := (VarAmounttoDisburse * PCharges.Percentage / 100);//LoanDisbAmount
                                                                                           //-------------------EARN CHARGE-------------------------------------------
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::"G/L Account", PCharges."G/L Account", "Posting Date", PChargeAmount * -1, 'BOSA', LoanApps."Loan  No.",
                    PCharges.Description + ' - ' + LoanApps."Client Code" + ' - ' + LoanApps."Loan  No.", LoanApps."Loan  No.", GenJournalLine."application source"::" ");


                    //------------------10% EXCISE DUTY----------------------------------------
                    if SFactory.FnChargeExcise(PCharges.Code) then begin
                        //-------------------Earn---------------------------------
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                        GenJournalLine."account type"::"G/L Account", GenSetUp."Excise Duty Account", "Posting Date", (PChargeAmount * -1) * 0.1, 'BOSA', LoanApps."Loan  No.",
                        PCharges.Description + '-' + LoanApps."Client Code" + '-' + LoanApps."Loan Product Type Name" + '-' + LoanApps."Loan  No." + '- Excise(10%)', LoanApps."Loan  No.", GenJournalLine."application source"::" ");
                    end;

                    TotalPCharges := TotalPCharges + PChargeAmount;
                //----------------END 10% EXCISE--------------------------------------------
                until PCharges.Next = 0;
            end;


            //----------------------------------------4. PAY/RECOVER TOP UPS------------------------------------------------------------------------------------------
            if LoanApps."Loan Offset Amount" > 0 then begin
                LoanTopUp.Reset;
                LoanTopUp.SetRange(LoanTopUp."Loan No.", LoanApps."Loan  No.");
                if LoanTopUp.Find('-') then begin
                    LoanTopUp.fn_UpdateLoanOffsetDetails();
                    LoanTopUp.Modify;
                end;

                LoanTopUp.Reset;
                LoanTopUp.SetRange(LoanTopUp."Loan No.", LoanApps."Loan  No.");
                if LoanTopUp.Find('-') then begin
                    repeat
                        //------------------------------------PAY-----------------------------------------------------------------------------------------------------------
                        //------------------------------------Principal---------------------
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Repayment",
                        GenJournalLine."account type"::None, LoanApps."Client Code", "Posting Date", LoanTopUp."Principle Top Up" * -1, 'BOSA', LoanTopUp."Loan Top Up",
                        'Off Set By - ' + LoanApps."Client Code" + '-' + LoanApps."Loan  No.", LoanTopUp."Loan Top Up", GenJournalLine."application source"::" ");
                        //------------------------------------Outstanding Interest----------
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Interest Paid",
                        GenJournalLine."account type"::None, LoanApps."Client Code", "Posting Date", LoanTopUp."Interest Top Up" * -1, 'BOSA', LoanTopUp."Loan Top Up",
                        'Interest Paid- ' + LoanApps."Client Code" + '-' + LoanApps."Loan  No.", LoanTopUp."Loan Top Up", GenJournalLine."application source"::" ");
                        //-------------------------------------Levy--------------------------
                        LineNo := LineNo + 10000;
                        if LoanType.Get(LoanApps."Loan Product Type") then begin
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                            GenJournalLine."account type"::"G/L Account", LoanType."Top Up Commision Account", "Posting Date", LoanTopUp.Commision * -1, 'BOSA', LoanTopUp."Loan Top Up",
                            'Levy on Bridging -' + LoanApps."Client Code" + '-' + LoanApps."Loan  No.", LoanTopUp."Loan Top Up", GenJournalLine."application source"::" ");
                        end;

                        //-------------------------------------Loan Insurance--------------------------
                        LineNo := LineNo + 10000;
                        if LoanType.Get(LoanApps."Loan Product Type") then begin
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Insurance Paid",
                            GenJournalLine."account type"::None, LoanApps."Client Code", "Posting Date", LoanTopUp."Loan Insurance: Current Year" * -1, 'BOSA', LoanTopUp."Loan Top Up",
                            'Insurance on Loan Clearance -' + LoanApps."Client Code" + '-' + LoanApps."Loan  No.", LoanTopUp."Loan Top Up", GenJournalLine."application source"::" ");
                        end;

                        if ObjLoans.Get(LoanTopUp."Loan Top Up") then begin
                            if ObjLoanType.Get(ObjLoans."Loan Product Type") then begin
                                VarLoanInsuranceBalAccount := ObjLoanType."Loan Insurance Accounts";
                            end;
                        end;


                        //------------------------------------DEBIT INSURANCE FOR THE CURRENT YEAR  A/C---------------------------------------------------------------------------------------------
                        /*
                          LineNo:=LineNo+10000;
                          SFactory.FnCreateGnlJournalLineBalanced(BATCH_TEMPLATE,BATCH_NAME,DOCUMENT_NO,LineNo,GenJournalLine."Transaction Type"::"Loan Insurance Charged",
                          GenJournalLine."Account Type"::Member,LoanApps."Client Code",WORKDATE,'Loan Insurance:Diff. Calender Year _'+LoanTopUp."Loan Top Up",GenJournalLine."Bal. Account Type"::"G/L Account",
                          VarLoanInsuranceBalAccount,LoanTopUp."Loan Insurance: Current Year",'FOSA',LoanTopUp."Loan Top Up");
                          */

                        //------------------------------Credit Excise Duty Account-----------------------------------------------
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                        GenJournalLine."account type"::"G/L Account", GenSetUp."Excise Duty Account", "Posting Date", (LoanTopUp.Commision * (GenSetUp."Excise Duty(%)" / 100)) * -1, 'BOSA', BLoan,
                        'Excise Duty_Levy on Bridging', BLoan, GenJournalLine."application source"::" ");


                    until LoanTopUp.Next = 0;
                end;
            end;

            //-----------------------------------------Accrue Interest Disburesment--------------------------------------------------------------------------------------------
            if LoanType.Get(LoanApps."Loan Product Type") then begin
                if LoanType."Accrue Total Insurance&Interes" = true then begin

                    //----------------------Debit interest Receivable Account a/c-----------------------------------------------------
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Interest Due",
                    GenJournalLine."account type"::None, LoanApps."Client Code", "Posting Date", (LoanApps."Approved Amount" * (LoanType."Interest rate" / 1200)) * LoanType."No of Installment", 'BOSA', BLoan,
                    'Interest Due' + '_' + LoanApps."Loan  No.", LoanApps."Loan  No.", GenJournalLine."application source"::" ");

                    //----------------------Credit interest Income Account a/c-----------------------------------------------------
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::"G/L Account", LoanType."Loan Interest Account", "Posting Date", ((LoanApps."Approved Amount" * (LoanType."Interest rate" / 1200)) * LoanType."No of Installment") * -1, 'BOSA', BLoan,
                    'Interest Due' + '_' + LoanApps."Loan  No.", LoanApps."Loan  No.", GenJournalLine."application source"::" ");
                end;
            end;


            //-----------------------------------------Accrue insurance on Disburesment--------------------------------------------------------------------------------------------

            if LoanType.Get(LoanApps."Loan Product Type") then begin
                if LoanType."Accrue Total Insurance&Interes" = true then begin


                    PCharges.Reset;
                    PCharges.SetRange(PCharges."Product Code", LoanApps."Loan Product Type");
                    PCharges.SetRange(PCharges."Loan Charge Type", PCharges."loan charge type"::"Loan Insurance");
                    if PCharges.Find('-') then begin
                        PCharges.TestField(PCharges."G/L Account");
                        GenSetUp.TestField(GenSetUp."Excise Duty Account");
                        PChargeAmount := PCharges.Amount;
                        if PCharges."Use Perc" = true then
                            PChargeAmount := (LoanApps."Approved Amount" * PCharges.Percentage / 100);
                        //----------------------Debit insurance Receivable Account a/c-----------------------------------------------------
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Insurance Charged",
                        GenJournalLine."account type"::None, LoanApps."Client Code", "Posting Date", PChargeAmount * LoanType."No of Installment", 'BOSA', BLoan,
                        'Insurance Charged' + '_' + LoanApps."Loan  No.", LoanApps."Loan  No.", GenJournalLine."application source"::" ");

                        //----------------------Credit Insurance Payable Account a/c-----------------------------------------------------
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                        GenJournalLine."account type"::"G/L Account", LoanType."Loan Insurance Accounts", "Posting Date", (PChargeAmount * LoanType."No of Installment") * -1, 'BOSA', BLoan,
                        'Insurance Charged' + '_' + LoanApps."Loan  No.", LoanApps."Loan  No.", GenJournalLine."application source"::" ");
                    end;
                end;
            end;



            //-----------------------------------------5. BOOST DEPOSITS COMMISSION / RECOVER FROM FOSA A/C--------------------------------------------------------------------------------------------
            if LoanApps."Share Boosting Comission" > 0 then begin


                GenSetUp.Get();
                //------------------------------Credit Income G/L-----------------------------------------------
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                GenJournalLine."account type"::"G/L Account", GenSetUp."Boosting Fees Account", "Posting Date", LoanApps."Share Boosting Comission" * -1, 'BOSA', BLoan,
                'Deposits Boosting Fee', BLoan, GenJournalLine."application source"::" ");


                GenSetUp.Get();
                //------------------------------Credit Excise Duty Account-----------------------------------------------
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                GenJournalLine."account type"::"G/L Account", GenSetUp."Excise Duty Account", "Posting Date", (LoanApps."Share Boosting Comission" * (GenSetUp."Excise Duty(%)" / 100)) * -1, 'BOSA', BLoan,
                'Excise Duty_Boosting Fee', BLoan, GenJournalLine."application source"::" ");


            end;



            //------------------------------------2. CREDIT MEMBER BANK A/C---------------------------------------------------------------------------------------------
            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
            GenJournalLine."account type"::"Bank Account", "Paying Bank Account No", "Posting Date", "Loan Disbursed Amount" * -1, 'BOSA', LoanApps."Cheque No.",
            'Loan Disbursement - ' + LoanApps."Loan Product Type Name" + ' - ' + LoanApps."Loan  No.", LoanApps."Loan  No.", GenJournalLine."application source"::" ");
            //----------------------------------(Credit Member Bank Account)------------------------------------------------

            if ObjLoans.Get("Loan  No.") then begin
                ObjLoans."Net Payment to FOSA" := ObjLoans."Approved Amount";
                ObjLoans."Processed Payment" := true;
                ObjLoans.Modify;
            end;
        end;

    end;

    local procedure FnBoosterLoansDisbursement(ObjLoanDetails: Record "Loans Register"; LineNo: Integer): Code[40]
    var
        GenJournalLine: Record "Gen. Journal Line";
        CUNoSeriesManagement: Codeunit NoSeriesManagement;
        DocNumber: Code[100];
        loanTypes: Record "Loan Products Setup";
        ObjLoanX: Record "Loans Register";
    begin
        loanTypes.Reset;
        loanTypes.SetRange(loanTypes.Code, 'BLOAN');
        if loanTypes.Find('-') then begin
            DocNumber := CUNoSeriesManagement.GetNextNo('LOANSB', 0D, true);
            LoansRec.Init;
            LoansRec."Loan  No." := DocNumber;
            LoansRec.Insert;

            if LoansRec.Get(LoansRec."Loan  No.") then begin
                LoansRec."Client Code" := ObjLoanDetails."Client Code";
                LoansRec.Validate(LoansRec."Client Code");
                LoansRec."Loan Product Type" := 'BLOAN';
                LoansRec.Validate(LoansRec."Loan Product Type");
                LoansRec.Interest := ObjLoanDetails.Interest;
                LoansRec."Loan Status" := LoansRec."loan status"::Closed;
                LoansRec."Application Date" := ObjLoanDetails."Application Date";
                LoansRec."Issued Date" := ObjLoanDetails."Posting Date";
                LoansRec."Loan Disbursement Date" := ObjLoanDetails."Loan Disbursement Date";
                LoansRec.Validate(LoansRec."Loan Disbursement Date");
                LoansRec."Mode of Disbursement" := LoansRec."mode of disbursement"::"FOSA Account";
                LoansRec."Repayment Start Date" := ObjLoanDetails."Repayment Start Date";
                LoansRec."Global Dimension 1 Code" := 'BOSA';
                LoansRec."Global Dimension 2 Code" := SFactory.FnGetUserBranch();
                LoansRec.Source := ObjLoanDetails.Source;
                LoansRec."Approval Status" := ObjLoanDetails."Approval Status";
                LoansRec.Repayment := ObjLoanDetails."Boosted Amount";
                LoansRec."Requested Amount" := ObjLoanDetails."Boosted Amount";
                LoansRec."Approved Amount" := ObjLoanDetails."Boosted Amount";
                LoansRec.Interest := ObjLoanDetails.Interest;
                LoansRec."Mode of Disbursement" := LoansRec."mode of disbursement"::"FOSA Account";
                LoansRec.Posted := true;
                LoansRec."Advice Date" := Today;
                LoansRec.Modify;
            end;
        end;
        exit(DocNumber);
    end;

    local procedure FnUpdateShareBoostedTrans()
    begin

        ObjCust.Reset;
        ObjCust.SetRange(ObjCust."No.", "Client Code");
        if ObjCust.Find('-') then begin
            "Employer Code" := ObjCust."Employer Code";
            //MODIFY;

            GenSetUp.Get();

            ObjMemberLedg.Reset;
            ObjMemberLedg.SetRange(ObjMemberLedg."Customer No.", "Client Code");
            ObjMemberLedg.SetRange(ObjMemberLedg."Journal Batch Name", 'FTRANS');
            ObjMemberLedg.SetRange(ObjMemberLedg."No Boosting", false);
            ObjMemberLedg.SetRange(ObjMemberLedg."Transaction Type", ObjMemberLedg."transaction type"::"Deposit Contribution");
            if ObjMemberLedg.FindSet then begin
                if ObjMemberLedg."No Boosting" = false then begin //>
                    repeat
                        if ObjMemberLedg."Posting Date" > CalcDate(GenSetUp."Boosting Shares Maturity (M)", Today) then begin

                            if ((ObjMemberLedg."Credit Amount") > ObjCust."Monthly Contribution") then begin
                                ObjMemberLedg."Share Boosting Fee Charged" := true;
                                ObjMemberLedg.Modify;
                            end;
                        end;
                    until ObjMemberLedg.Next = 0;
                end;
            end;
        end;
    end;

    local procedure FnRunSendScheduleViaMail(LoanNo: Code[30]; ClientCode: Code[30])
    var
        Filename: Text[100];
        SMTPSetup: Record "SMTP Mail Setup";
        SMTPMail: Codeunit "SMTP Mail";
        VarMemberEmail: Text[50];
        ObjMember: Record Customer;
        Attachment: Text[250];
        ObjLoanType: Record "Loan Products Setup";
        VarProductDescription: Code[50];
        ObjLoans: Record "Loans Register";
        VarNewMemberName: Text[100];
        Recipient: list of [Text];
    begin
        SMTPSetup.Get();

        ObjLoans.Reset;
        ObjLoans.SetRange(ObjLoans."Loan  No.", LoanNo);
        if ObjLoans.FindSet then begin
            if ObjMember.Get(ClientCode) then begin
                VarMemberEmail := Lowercase(ObjMember."E-Mail");
            end;
            Recipient.Add(VarMemberEmail);
            Filename := '';
            Filename := SMTPSetup."Path to Save Report" + 'Loan Repayment Schedule.pdf';
            Report.SaveAsPdf(Report::"Loans Repayment Schedule", Filename, ObjLoans);

            VarProductDescription := ObjLoans."Loan Product Type Name";
            VarNewMemberName := UpperCase(CopyStr("Client Name", 1, 1)) + Lowercase(CopyStr("Client Name", 2));

            SMTPMail.CreateMessage(SMTPSetup."Email Sender Name", SMTPSetup."Email Sender Address", Recipient, 'Loan Repayment Schedule', '', true);
            SMTPMail.AppendBody('Dear ,' + VarNewMemberName);
            SMTPMail.AppendBody('<br><br>');
            SMTPMail.AppendBody('Please find attached your loan repayment schedule.');
            SMTPMail.AppendBody('<br><br>');
            SMTPMail.AppendBody('Thank you for choosing Kingdom SACCO');
            SMTPMail.AppendBody('<br><br>');
            SMTPMail.AppendBody('Kind Regards');
            SMTPMail.AppendBody('<br><br>');
            SMTPMail.AppendBody(UserId);
            SMTPMail.AppendBody('<br><br>');
            SMTPMail.AppendBody(SMTPSetup."Email Sender Name");
            SMTPMail.AppendBody('<br><br>');
            SMTPMail.AppendBody('<HR>');
            SMTPMail.AddAttachment(Filename, Attachment);
            SMTPMail.Send;
        end;
    end;

    local procedure FnRunCreateLSAfor1sttimeLoanees()
    var
        ObjAccount: Record Vendor;
        ObjAccountType: Record "Account Types-Saving Products";
        VarAcctNo: Code[30];
    begin
        ObjAccount.Reset;
        ObjAccount.SetRange(ObjAccount."BOSA Account No", "Client Code");
        ObjAccount.SetFilter(ObjAccount.Status, '<>%1|%2', ObjAccount.Status::Closed, ObjAccount.Status::Deceased);
        ObjAccount.SetRange(ObjAccount."Account Type", '507');
        if ObjAccount.Find('-') = false then begin
            SFactory.FnRunCreatNewAccount('507', "Global Dimension 2 Code", "Client Code");
        end;
    end;

    local procedure FnRunCheckLoanStages()
    var
        ObjLoanApplicationStages: Record "Loan Application Stages";
    begin
        ObjLoanApplicationStages.Reset;
        ObjLoanApplicationStages.SetRange(ObjLoanApplicationStages."Loan No", "Loan  No.");
        ObjLoanApplicationStages.SetFilter(ObjLoanApplicationStages."Stage Status", '<>%1', ObjLoanApplicationStages."stage status"::Succesful);
        ObjLoanApplicationStages.SetFilter(ObjLoanApplicationStages."Loan Stage", '<>%1', '015');
        if ObjLoanApplicationStages.FindSet then begin
            Error('This Loan Application has Loan Stages that are not Succesful. Kindly Review Before Posting the Loan');
        end;
    end;

    local procedure FnRunUpdateDisburesmentLoanStage()
    var
        ObjLoanApplicationStages: Record "Loan Application Stages";
    begin
        ObjLoanApplicationStages.Reset;
        ObjLoanApplicationStages.SetRange(ObjLoanApplicationStages."Loan No", "Loan  No.");
        ObjLoanApplicationStages.SetFilter(ObjLoanApplicationStages."Loan Stage", '%1', '015');
        if ObjLoanApplicationStages.FindSet then begin
            ObjLoanApplicationStages."Stage Status" := ObjLoanApplicationStages."stage status"::Succesful;
            ObjLoanApplicationStages.Modify;
        end;
    end;

    local procedure FnAccrueInterestOneOffLoans(VarLoanNo: Code[30])
    var
        ObjLoans: Record "Loans Register";
        ObjInterestLedger: Record "Interest Due Ledger Entry";
    begin
        ObjLoans.Reset;
        ObjLoans.SetRange("Loan  No.", VarLoanNo);
        ObjLoans.SetRange("OneOff Loan Repayment", true);
        if ObjLoans.FindSet then begin

            ObjLoans.CalcFields(ObjLoans."Outstanding Balance");
            ObjInterestLedger.Reset;
            ObjInterestLedger.SetCurrentkey(ObjInterestLedger."Entry No.");
            if ObjInterestLedger.FindLast then
                VarLineNo := ObjInterestLedger."Entry No." + 1;

            ObjInterestLedger.Init;
            ObjInterestLedger."Journal Batch Name" := 'INTRESTDUE';
            ObjInterestLedger."Entry No." := VarLineNo;
            ObjInterestLedger."Customer No." := ObjLoans."Client Code";
            ObjInterestLedger."Transaction Type" := ObjInterestLedger."transaction type"::"Interest Due";
            ObjInterestLedger."Document No." := SFactory.FnRunGetNextTransactionDocumentNo;
            ObjInterestLedger."Posting Date" := CalcDate(Format(ObjLoans.Installments + ObjLoans."Grace Period - Interest (M)") + 'M', ObjLoans."Loan Disbursement Date");
            ObjInterestLedger.Description := ObjLoans."Loan  No." + ' ' + 'Interest charged';
            ObjInterestLedger.Amount := ROUND(ObjLoans."Outstanding Balance" * (ObjLoans.Interest / 1200), 1, '>') * (ObjLoans.Installments + ObjLoans."Grace Period - Interest (M)");
            if ObjLoans.Source = ObjLoans.Source::" " then begin
                ObjInterestLedger."Global Dimension 2 Code" := ObjLoans."Branch Code";
            end;
            if ObjLoans.Source = ObjLoans.Source::BOSA then begin
                ObjInterestLedger."Global Dimension 2 Code" := ObjLoans."Branch Code";
            end;
            ObjInterestLedger."Global Dimension 1 Code" := FnProductSource(ObjLoans."Loan Product Type");
            ObjInterestLedger.Validate(ObjInterestLedger."Global Dimension 2 Code");
            ObjInterestLedger.Validate(ObjInterestLedger."Global Dimension 1 Code");
            ObjInterestLedger."Loan No" := ObjLoans."Loan  No.";
            ObjInterestLedger."Interest Accrual Date" := ObjLoans."Loan Disbursement Date";
            if ObjInterestLedger.Amount <> 0 then
                ObjInterestLedger.Insert;
        end;
    end;

    local procedure FnProductSource(Product: Code[50]) Source: Code[50]
    var
        ObjProducts: Record "Loan Products Setup";
    begin
        ObjProducts.Reset;
        ObjProducts.SetRange(ObjProducts.Code, Product);
        if ObjProducts.Find('-') then begin
            if ObjProducts.Source = ObjProducts.Source::BOSA then
                Source := 'BOSA'
            else
                Source := 'FOSA';
        end;
        exit(Source);
    end;

    local procedure FnRunDisbursementSMS()
    var
        ObjAccount: Record Vendor;
        VarLoanProductName: Code[30];
        ObjCust: Record Customer;
        VarSMSBody: Text;
    begin
        ObjAccount.Reset;
        ObjAccount.SetRange(ObjAccount."No.", "Account No");
        if ObjAccount.FindSet then
            VarLoanProductName := ObjAccount."Account Type Name";

        VarMemberName := SFactory.FnRunSplitString("Client Name", ' ');

        if ObjCust.Get("Client Code") then begin
            VarSMSBody := 'Dear ' + VarMemberName + ', your ' + "Loan Product Type Name" + ' application of Ksh. ' + Format("Approved Amount")
              + ' has been disbursed to your Account No. ' + "Account No" + ' and loan schedule sent via mail.';
            SFactory.FnSendSMS('LOANDIS', VarSMSBody, "Client Code", ObjCust."Mobile Phone No");
        end;
    end;

    local procedure SetStyles()
    begin
        /*CoveragePercentStyle:='Strong';
        IF ("1 3rd of Basic" = 'Very Poor') OR ("1 3rd of Basic" = 'Poor') THEN
          BEGIN
           CoveragePercentStyle := 'Unfavorable';
          END;
        
        IF ("1 3rd of Basic" ='Good') OR ("1 3rd of Basic" ='Excellent') THEN
          BEGIN
            CoveragePercentStyle := 'Favorable';
          END;*/

    end;
}

