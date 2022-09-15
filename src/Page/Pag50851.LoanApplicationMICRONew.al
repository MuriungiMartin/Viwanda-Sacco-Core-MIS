#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50851 "Loan Application MICRO(New)"
{

    DeleteAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = "Loans Register";
    SourceTableView = where(Source = const(MICRO),
                            Posted = const(false),
                            "Loan Status" = const(Application));

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
                field("Group Account"; "Group Account")
                {
                    ApplicationArea = Basic;
                }
                field("Client Code"; "Client Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member';
                    Editable = MNoEditable;

                    trigger OnValidate()
                    begin
                        /*
                        Memb.RESET;
                        Memb.SETRANGE(Memb."No.","Client Code");
                        IF Memb."Customer Posting Group"<>'Micro' THEN
                        ERROR('This Member is NOT Registered under Business Loans');
                        */

                    end;
                }
                field("Client Name"; "Client Name")
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
                field("Global Dimension 2 Code"; "Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("ID NO"; "ID NO")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Member Group"; "Member Group")
                {
                    ApplicationArea = Basic;
                }
                field("Member Group Name"; "Member Group Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
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
                field("Group Shares"; "Group Shares")
                {
                    ApplicationArea = Basic;
                }
                field("Shares Balance"; "Shares Balance")
                {
                    ApplicationArea = Basic;
                }
                field("Pension No"; "Pension No")
                {
                    ApplicationArea = Basic;
                    Visible = false;
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
                    Enabled = false;
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
                field("Loan Purpose"; "Loan Purpose")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                    Visible = false;
                }
                field("Repayment Method"; "Repayment Method")
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
                field(Repayment; Repayment)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Loan Status"; "Loan Status")
                {
                    ApplicationArea = Basic;
                    Editable = true;

                    trigger OnValidate()
                    begin
                        UpdateControl();


                    end;
                }
                field("Batch No."; "Batch No.")
                {
                    ApplicationArea = Basic;
                    Editable = BatchNoEditable;
                    Visible = false;
                }
                field("Captured By"; "Captured By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Loan Offset Amount"; "Loan Offset Amount")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Repayment Frequency"; "Repayment Frequency")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Account No"; "Account No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Mode of Disbursement"; "Mode of Disbursement")
                {
                    ApplicationArea = Basic;
                    Editable = ModeofDisburesmentEdit;
                }
                field("Loan Disbursement Date"; "Loan Disbursement Date")
                {
                    ApplicationArea = Basic;
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
                field("Repayment Start Date"; "Repayment Start Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
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
                field(Posted; Posted)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field(Source; Source)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Remarks; Remarks)
                {
                    ApplicationArea = Basic;
                    Editable = true;
                    Visible = true;
                }
            }
            part(Control1000000014; "Loan Appraisal Salary Details")
            {
                Caption = 'Salary Details';
                SubPageLink = "Loan No" = field("Loan  No."),
                              "Client Code" = field("Client Code");
                Visible = false;
            }
            part(Control1000000013; "Loans Guarantee Details")
            {
                Caption = 'Guarantors  Detail';
                SubPageLink = "Loan No" = field("Loan  No.");
            }
            part(Control1000000012; "Loan Collateral Security")
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
                action("Loan Application Form")
                {
                    ApplicationArea = Basic;
                    Image = Form;
                    Promoted = true;
                    PromotedCategory = "Report";

                    trigger OnAction()
                    begin
                        LoanApp.Reset;
                        LoanApp.SetRange(LoanApp."Loan  No.", "Loan  No.");
                        if LoanApp.Find('-') then begin
                            Report.run(50896, true, false, LoanApp);
                        end;
                    end;
                }
                action("Mark As Posted")
                {
                    ApplicationArea = Basic;
                    Caption = 'Mark As Posted';
                    Visible = false;

                    trigger OnAction()
                    begin
                        Posted := true;
                        Modify;
                    end;
                }
                action("Loan Appraisal")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loan Appraisal';
                    Enabled = true;
                    Image = Aging;
                    Promoted = true;
                    PromotedCategory = "Report";

                    trigger OnAction()
                    begin

                        LoanApp.Reset;
                        LoanApp.SetRange(LoanApp."Loan  No.", "Loan  No.");
                        if LoanApp.Find('-') then begin
                            Report.run(50452, true, false, LoanApp);
                        end;
                    end;
                }
                separator(Action1102760046)
                {
                }
                action("View Schedule")
                {
                    ApplicationArea = Basic;
                    Caption = 'View Schedule';
                    Image = ViewDetails;
                    Promoted = true;
                    PromotedCategory = "Report";
                    ShortCutKey = 'Ctrl+F7';

                    trigger OnAction()
                    begin
                        //IF Posted=TRUE THEN
                        //ERROR('Loan has been posted, Can only preview schedule');

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
                        //EVALUATE(InPeriod,'1D');
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

                            //LoanAmount:=LoansR."Approved Amount";
                            LoanAmount := LoansR."Approved Amount" + LoansR."Capitalized Charges";
                            InterestRate := LoansR.Interest;
                            RepayPeriod := LoansR.Installments;
                            InitialInstal := LoansR.Installments + "Grace Period - Principle (M)";
                            //LBalance:=LoansR."Approved Amount";
                            LBalance := LoansR."Approved Amount" + LoansR."Capitalized Charges";
                            RunDate := "Repayment Start Date";//"Loan Disbursement Date";
                                                              //RunDate:=CALCDATE('-1W',RunDate);
                            InstalNo := 0;
                            //EVALUATE(RepayInterval,'1W');
                            //EVALUATE(RepayInterval,InPeriod);

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
                                //RunDate:=CALCDATE("Instalment Period",RunDate);
                                //RunDate:=CALCDATE('1W',RunDate);


                                //Repayment Frequency
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
                                //Repayment Frequency

                                //kma
                                if "Repayment Method" = "repayment method"::Amortised then begin
                                    TestField(Interest);
                                    TestField(Installments);
                                    TotalMRepay := ROUND((InterestRate / 12 / 100) / (1 - Power((1 + (InterestRate / 12 / 100)), -(RepayPeriod))) * (LoanAmount), 0.05, '>');
                                    LInterest := ROUND(LBalance / 100 / 12 * InterestRate, 0.05, '>');
                                    LPrincipal := TotalMRepay - LInterest;
                                end;

                                if "Repayment Method" = "repayment method"::"Straight Line" then begin
                                    TestField(Interest);
                                    TestField(Installments);
                                    LPrincipal := ROUND(LoanAmount / RepayPeriod, 0.05, '>');
                                    LInterest := ROUND((InterestRate / 1200) * LoanAmount, 0.05, '>');

                                    //Grace Period Interest
                                    LInterest := ROUND((LInterest * InitialInstal) / (InitialInstal - InitialGraceInt), 0.05, '>');

                                end;

                                if "Repayment Method" = "repayment method"::"Reducing Balance" then begin
                                    TestField(Interest);
                                    TestField(Installments);
                                    LPrincipal := ROUND(LoanAmount / RepayPeriod, 0.05, '>');
                                    LInterest := ROUND((InterestRate / 12 / 100) * LBalance, 0.05, '>');
                                end;

                                if "Repayment Method" = "repayment method"::Constants then begin
                                    TestField(Repayment);
                                    LPrincipal := ROUND(LoanAmount / RepayPeriod, 0.05, '>');
                                    //IF LBalance < Repayment THEN
                                    //LPrincipal:=LBalance
                                    //ELSE
                                    //LPrincipal:=Repayment;
                                    LInterest := Interest;
                                end;
                                //kma



                                //Grace Period
                                if GrPrinciple > 0 then begin
                                    LPrincipal := 0
                                end else begin
                                    //IF "Instalment Period" <> InPeriod THEN

                                    //LBalance:=LoanAmount;
                                    LBalance := LBalance - LPrincipal;


                                end;

                                if GrInterest > 0 then
                                    LInterest := 0;

                                GrPrinciple := GrPrinciple - 1;
                                GrInterest := GrInterest - 1;
                                //Grace Period


                                Evaluate(RepayCode, Format(InstalNo));


                                RSchedule.Init;
                                RSchedule."Repayment Code" := RepayCode;
                                RSchedule."Loan No." := "Loan  No.";
                                RSchedule."Loan Amount" := LoanAmount;
                                RSchedule."Instalment No" := InstalNo;
                                RSchedule."Repayment Date" := RunDate;
                                RSchedule."Member No." := "Client Code";
                                RSchedule."Loan Category" := "Loan Product Type";
                                RSchedule."Monthly Repayment" := LInterest + LPrincipal;
                                RSchedule."Monthly Interest" := LInterest;
                                RSchedule."Principal Repayment" := LPrincipal;
                                RSchedule.Insert;
                                //WhichDay:=(DATE2DMY,RSchedule."Repayment Date",1);
                                WhichDay := Date2dwy(RSchedule."Repayment Date", 1);
                            //MESSAGE('which day is %1',WhichDay);
                            //BEEP(2,10000);
                            until LBalance < 1

                        end;

                        Commit;

                        LoanApp.Reset;
                        LoanApp.SetRange(LoanApp."Loan  No.", "Loan  No.");
                        if LoanApp.Find('-') then
                            Report.run(50852, true, false, LoanApp);
                    end;
                }
                separator(Action1102755012)
                {
                }
                action("Loans Top Up")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loans Top Up';
                    Image = AddAction;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Loan Offset Detail List";
                    RunPageLink = "Loan No." = field("Loan  No."),
                                  "Client Code" = field("Client Code");
                    Visible = false;
                }
                separator(Action1102760039)
                {
                }
                separator(Action1102755021)
                {
                }
                action("Post Loan")
                {
                    ApplicationArea = Basic;
                    Caption = 'Post Loan';
                    Visible = false;

                    trigger OnAction()
                    begin

                    end;
                }
                separator(Action1102755023)
                {
                }
                action(Securities)
                {
                    ApplicationArea = Basic;
                    Caption = 'Securities';
                    Image = AllLines;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Loan Collateral Security";
                    RunPageLink = "Loan No" = field("Loan  No.");
                    Visible = true;
                }
                action("Salary Appraisal")
                {
                    ApplicationArea = Basic;
                    Caption = 'Salary Appraisal';
                    Enabled = true;
                    Image = StatisticsGroup;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Loan Appraisal Salary Details";
                    RunPageLink = "Loan No" = field("Loan  No."),
                                  "Client Code" = field("Client Code");
                    Visible = true;
                }
                action("Profitability Analysis")
                {
                    ApplicationArea = Basic;
                    Image = Attach;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "Profitability Analysis";
                    RunPageLink = "Client Code" = field("Client Code"),
                                  "Loan No." = field("Loan  No.");
                }
                action("Appraisal Expenses")
                {
                    ApplicationArea = Basic;
                    Image = ApplicationWorksheet;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "Appraisal Expense";
                    RunPageLink = Loan = field("Loan  No."),
                                  "Client Code" = field("Client Code");
                }
                action(Guarantors)
                {
                    ApplicationArea = Basic;
                    Caption = 'Guarantors';
                    Image = ItemGroup;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Loans Guarantee Details";

                    RunPageLink = "Loan No" = field("Loan  No.");
                    //"Member Cell"=field(Discard);
                }
                separator(Action1102755001)
                {
                }
            }
            group(Approvals)
            {
                Caption = 'Approvals';
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
                action("Send Approval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send A&pproval Request';
                    Enabled = (not OpenApprovalsEntriesExist) and EnabledApprovalWorkflowExist;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        Text001: label 'This transaction is already pending approval';
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin

                        if "Approved Amount" = 0 then Error('Loan Must Be Upraised before sending Approval');

                        TestField("Requested Amount");
                        //TESTFIELD("Recovery Mode");


                        if "Approval Status" <> "approval status"::Open then
                            Error(Text001);

                        //IF ApprovalsMgmt.CheckLoanApplicationApprovalsWorkflowEnabled(Rec) THEN
                        // ApprovalsMgmt.OnSendLoanApplicationForApproval(Rec);

                        GenSetUp.Get();

                        /*IF GenSetUp."Send Loan App SMS"=TRUE THEN BEGIN
                          FnSendReceivedApplicationSMS();
                          END;
                        IF GenSetUp."Send Loan App Email"=TRUE THEN BEGIN
                          FnSendReceivedLoanApplEmail("Loan  No.");
                          END;
                        
                        IF GenSetUp."Send Guarantorship SMS"=TRUE THEN BEGIN
                          FnSendGuarantorAppSMS("Loan  No.");
                          END;
                          */

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
                    PromotedOnly = true;

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
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        UpdateControl();
        OpenApprovalsEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RecordId);
        EnabledApprovalWorkflowExist := true;
        if Rec."Loan Status" = "loan status"::Disbursed then begin
            OpenApprovalsEntriesExist := false;
            CanCancelApprovalForRecord := false;
            EnabledApprovalWorkflowExist := false;
        end;

    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin

        LnLoans.Reset;
        LnLoans.SetRange(LnLoans.Posted, false);
        LnLoans.SetRange(LnLoans."Approval Status", LnLoans."approval status"::Open);
        LnLoans.SetRange(LnLoans."Captured By", UserId);
        if LnLoans."Requested Amount" = 0 then begin
            if LnLoans.Count > 0 then begin
                //ERROR(Text008,LnLoans."Approval Status");
            end;
        end;
    end;

    trigger OnModifyRecord(): Boolean
    begin
        LoanAppPermisions();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Source := Source::MICRO;
    end;

    trigger OnNextRecord(Steps: Integer): Integer
    begin
        if "Loan Status" = "loan status"::Disbursed then
            CurrPage.Editable := false;
    end;

    trigger OnOpenPage()
    begin
        SetRange(Posted, false);
    end;

    var
        i: Integer;
        LoanType: Record "Loan Products Setup";
        PeriodDueDate: Date;
        ScheduleRep: Record "Loan Repayment Schedule";
        RunningDate: Date;
        G: Integer;
        IssuedDate: Date;
        GracePeiodEndDate: Date;
        InstalmentEnddate: Date;
        GracePerodDays: Integer;
        InstalmentDays: Integer;
        NoOfGracePeriod: Integer;
        NewSchedule: Record "Loan Repayment Schedule";
        RSchedule: Record "Loan Repayment Schedule";
        GP: Text[30];
        CheckTiersEditable: Boolean;
        ReasonsEditable: Boolean;
        ScheduleCode: Code[20];
        PreviewShedule: Record "Loan Repayment Schedule";
        PeriodInterval: Code[10];
        LnLoans: Record "Loans Register";
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
        CustRec: Record "Loans Register";
        CustPostingGroup: Record "Customer Posting Group";
        GenSetUp: Record "Sacco General Set-Up";
        PCharges: Record "Loan Charges";
        TCharges: Decimal;
        LAppCharges: Record "Loan Appraisal Salary Details";
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
        BridgedLoans: Record "Loans Register";
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
        Text001: label 'Status Must Be Open';
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery,ChangeRequest,TreasuryTransactions,FundsTransfer;
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
        Memb: Record Customer;
        LoanSecurities: Record "Loans Guarantee Details";
        Text002: label 'Please Insert Securities Details';
        LnSecurities: Record "Loans Guarantee Details";
        TotalSecurities: Decimal;
        Text003: label 'Collateral Value cannot be less than Applied Amount';
        Text004: label 'This Member has a Pending withdrawal application';
        AppSched: Integer;
        Text005: label 'This loan application is not appraised';
        GSetUp: Record "Sacco General Set-Up";
        Text006: label 'Number of guarantors less than minimum of 4';
        Text007: label 'You already have a similar running loan, please topup to proceed.';
        Text008: label 'There are still pending applications whose status is -%1, Please utilize them first';
        Prof: Record "Micro Profitability Analysis";
        AppExp: Record "Appraisal Expenses-Micro";
        compinfo: Record "Company Information";
        iEntryNo: Integer;
        LoanAppMessage: label '<p style="font-family:Verdana,Arial;font-size:10pt">Dear<b> %1,</b></p><p style="font-family:Verdana,Arial;font-size:9pt">Welcome to Mafanikio Sacco</p><p style="font-family:Verdana,Arial;font-size:9pt">This is to confirm that your Loan Application has been received and Undergoing Approval</p><p style="font-family:Verdana,Arial;font-size:9pt"> </b></p><br>Regards<p>%3</p><p><b>MAFANIKIO SACCO LTD</b></p>';
        OpenApprovalsEntriesExist: Boolean;
        EnabledApprovalWorkflowExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";


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
            //WitnessEditable:=TRUE;
            //LoanPurposeEditable:=TRUE;
            //RecoveryModeEditable:=TRUE;
            //RemarksEditable:=TRUE;
            //LoanPurposeEditable:=TRUE;
            //CopyofIDEditable:=TRUE;
            //CopyofPayslipEditable:=TRUE;
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

        end;

        if "Approval Status" = "approval status"::Rejected then begin
            MNoEditable := false;
            //AccountNoEditable:=FALSE;
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

        end;

        if "Approval Status" = "approval status"::Approved then begin
            MNoEditable := false;
            //AccountNoEditable:=FALSE;
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
        Recipient: list of [Text];
    begin
        SMTPSetup.Get();

        LoanRec.Reset;
        LoanRec.SetRange(LoanRec."Loan  No.", LoanNo);
        if LoanRec.Find('-') then begin
            if Cust.Get(LoanRec."Client Code") then begin
                Email := Cust."E-Mail (Personal)";
            end;
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

    local procedure FnSendGuarantorAppSMS(LoanNo: Code[20])
    var
        Cust: Record Customer;
        Sms: Record "SMS Messages";
    begin
        LGuarantors.Reset;
        LGuarantors.SetRange(LGuarantors."Loan No", "Loan  No.");
        if LGuarantors.FindFirst then begin
            repeat
                if Cust.Get(LGuarantors."Member No") then
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
}

