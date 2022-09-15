#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50355 "Closed Loans"
{
    CardPageID = "Loans Application Card(Posted)";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = "Loans Register";
    SourceTableView = where("Loan Status" = filter(Closed));

    layout
    {
        area(content)
        {
            repeater(Control1000000008)
            {
                field("Loan  No."; "Loan  No.")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Product Type"; "Loan Product Type")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loan Product';
                }
                field("Client Code"; "Client Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member No';
                }
                field("Client Name"; "Client Name")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member Name';
                }
                field("ID NO"; "ID NO")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Status"; "Loan Status")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Requested Amount"; "Requested Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Approved Amount"; "Approved Amount")
                {
                    ApplicationArea = Basic;
                }
                field(Installments; Installments)
                {
                    ApplicationArea = Basic;
                }
                field("Loan Disbursement Date"; "Loan Disbursement Date")
                {
                    ApplicationArea = Basic;
                }
                field("Outstanding Balance"; "Outstanding Balance")
                {
                    ApplicationArea = Basic;
                }
                field("Captured By"; "Captured By")
                {
                    ApplicationArea = Basic;
                }
                field("Closed On"; "Closed On")
                {
                    ApplicationArea = Basic;
                }
                field("Closed By"; "Closed By")
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
                    Caption = 'Loan Appraisal';
                    Enabled = true;
                    Image = GanttChart;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        LoanApp.Reset;
                        LoanApp.SetRange(LoanApp."Loan  No.", "Loan  No.");
                        if LoanApp.Find('-') then begin
                            Report.run(50384, true, false, LoanApp);
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
                action("Loan Statement")
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
                            Report.run(50531, true, false, Cust);
                    end;
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
                action("View Schedule")
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
                        LoanApp.Reset;
                        LoanApp.SetRange(LoanApp."Loan  No.", "Loan  No.");
                        if LoanApp.Find('-') then
                            Report.Run(50477, true, false, LoanApp);
                        //51516949
                    end;
                }
                action("View ScheduleNew")
                {
                    ApplicationArea = Basic;
                    Caption = 'Repayments Schedule Updated Payments';
                    Image = "Table";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedOnly = true;
                    ShortCutKey = 'Ctrl+F7';

                    trigger OnAction()
                    begin
                        SFactory.FnRunLoanAmountDue("Loan  No.");
                        Commit;

                        LoanApp.Reset;
                        LoanApp.SetRange(LoanApp."Loan  No.", "Loan  No.");
                        if LoanApp.Find('-') then
                            Report.run(50949, true, false, LoanApp);
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
                action("Reschedule Repayment Date")
                {
                    ApplicationArea = Basic;
                    Caption = 'Repayment:Date Change';
                    Image = Form;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        VarScheduleDay: Integer;
                        VarScheduleMonth: Integer;
                        VarScheduleYear: Integer;
                    begin
                        TestField("New Repayment Start Date");
                        if Confirm('Confirm you Want to Change Repayment Dates for  this Loan?', false) = true then begin

                            VarNewInstalmentDate := "New Repayment Start Date";
                            //=======================================================================Loan Repayment Schedule
                            ObjLoanRepaymentSchedule.Reset;
                            ObjLoanRepaymentSchedule.SetCurrentkey(ObjLoanRepaymentSchedule."Repayment Date");
                            ObjLoanRepaymentSchedule.SetRange(ObjLoanRepaymentSchedule."Loan No.", "Loan  No.");
                            ObjLoanRepaymentSchedule.SetFilter(ObjLoanRepaymentSchedule."Repayment Date", '>=%1', "Reschedule Effective Date");
                            if ObjLoanRepaymentSchedule.FindSet then begin
                                repeat
                                    ObjLoanRepaymentSchedule."Repayment Date" := VarNewInstalmentDate;
                                    ObjLoanRepaymentSchedule.Modify;
                                    VarNewInstalmentDate := CalcDate('1M', VarNewInstalmentDate);
                                until ObjLoanRepaymentSchedule.Next = 0;
                            end;
                            //=======================================================================Loan Repayment Schedule  Temp
                            ObjLoanRepaymentScheduleTemp.Reset;
                            ObjLoanRepaymentScheduleTemp.SetCurrentkey(ObjLoanRepaymentScheduleTemp."Repayment Date");
                            ObjLoanRepaymentScheduleTemp.SetRange(ObjLoanRepaymentScheduleTemp."Loan No.", "Loan  No.");
                            ObjLoanRepaymentScheduleTemp.SetFilter(ObjLoanRepaymentScheduleTemp."Repayment Date", '>=%1', "Reschedule Effective Date");
                            if ObjLoanRepaymentScheduleTemp.FindSet then begin
                                repeat
                                    ObjLoanRepaymentScheduleTemp."Repayment Date" := VarNewInstalmentDate;
                                    ObjLoanRepaymentScheduleTemp.Modify;
                                    VarNewInstalmentDate := CalcDate('1M', VarNewInstalmentDate);
                                until ObjLoanRepaymentScheduleTemp.Next = 0;
                            end;
                            "Repayment Dates Rescheduled" := true;
                            "Repayment Dates Rescheduled By" := UserId;
                            "Repayment Dates Rescheduled On" := Today;
                            Message('Loan Repayment Date Changed Succesfully');
                        end;
                    end;
                }
                action("FOSA Statement")
                {
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        Vend.Reset;
                        Vend.SetRange(Vend."No.", "Account No");
                        if Vend.Find('-') then begin
                            Report.run(50890, true, false, Vend);
                        end;


                        /*Cust.RESET;
                        Cust.SETRANGE(Cust."FOSA Account No.","FOSA Account No.");
                        IF Cust.FIND('-') THEN
                        Report.run(50890,TRUE,FALSE,Cust);
                        */

                    end;
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

                        RunDate := 0D;
                        QCounter := 0;
                        QCounter := 3;
                        ScheduleBal := 0;
                        //EVALUATE(InPeriod,'1D');
                        GrPrinciple := "Grace Period - Principle (M)";
                        GrInterest := "Grace Period - Interest (M)";
                        InitialGraceInt := "Grace Period - Interest (M)";


                        LoansR.Reset;
                        LoansR.SetRange(LoansR."Loan  No.", "Loan  No.");
                        if LoansR.Find('-') then begin
                            LoansR.CalcFields(LoansR."Outstanding Balance");

                            TestField("Loan Disbursement Date");
                            TestField("Repayment Start Date");

                            RSchedule.Reset;
                            RSchedule.SetRange(RSchedule."Loan No.", "Loan  No.");
                            RSchedule.DeleteAll;

                            if LoansR.Get("Loan  No.") then begin
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

                                //RunDate:=0D;
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

                                        ObjProductCharge.Reset;
                                        ObjProductCharge.SetRange(ObjProductCharge."Product Code", "Loan Product Type");
                                        ObjProductCharge.SetRange(ObjProductCharge."Loan Charge Type", ObjProductCharge."loan charge type"::"Loan Insurance");
                                        if ObjProductCharge.FindSet then begin
                                            LInsurance := "Approved Amount" * (ObjProductCharge.Percentage / 100);
                                        end;

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

                                        ObjProductCharge.Reset;
                                        ObjProductCharge.SetRange(ObjProductCharge."Product Code", "Loan Product Type");
                                        ObjProductCharge.SetRange(ObjProductCharge."Loan Charge Type", ObjProductCharge."loan charge type"::"Loan Insurance");
                                        if ObjProductCharge.FindSet then begin
                                            LInsurance := "Approved Amount" * (ObjProductCharge.Percentage / 100);
                                        end;
                                    end;


                                    if "Repayment Method" = "repayment method"::"Reducing Balance" then begin
                                        TestField(Interest);
                                        TestField(Installments);
                                        LPrincipal := ROUND(LoanAmount / RepayPeriod, 1, '>');
                                        LInterest := ROUND((InterestRate / 12 / 100) * LBalance, 1, '>');

                                        ObjProductCharge.Reset;
                                        ObjProductCharge.SetRange(ObjProductCharge."Product Code", "Loan Product Type");
                                        ObjProductCharge.SetRange(ObjProductCharge."Loan Charge Type", ObjProductCharge."loan charge type"::"Loan Insurance");
                                        if ObjProductCharge.FindSet then begin
                                            LInsurance := "Approved Amount" * (ObjProductCharge.Percentage / 100);
                                        end;
                                    end;

                                    if "Repayment Method" = "repayment method"::Constants then begin
                                        TestField(Repayment);
                                        if LBalance < Repayment then
                                            LPrincipal := LBalance
                                        else
                                            LPrincipal := Repayment;
                                        LInterest := Interest;

                                        ObjProductCharge.Reset;
                                        ObjProductCharge.SetRange(ObjProductCharge."Product Code", "Loan Product Type");
                                        ObjProductCharge.SetRange(ObjProductCharge."Loan Charge Type", ObjProductCharge."loan charge type"::"Loan Insurance");
                                        if ObjProductCharge.FindSet then begin
                                            LInsurance := "Approved Amount" * (ObjProductCharge.Percentage / 100);
                                        end;
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

                                    //Grace Period
                                    RSchedule.Init;
                                    RSchedule."Repayment Code" := RepayCode;
                                    RSchedule."Loan No." := "Loan  No.";
                                    RSchedule."Loan Amount" := LoanAmount;
                                    RSchedule."Instalment No" := InstalNo;
                                    RSchedule."Repayment Date" := CalcDate('CM', RunDate);
                                    RSchedule."Member No." := "Client Code";
                                    RSchedule."Loan Category" := "Loan Product Type";
                                    RSchedule."Monthly Repayment" := LInterest + LPrincipal + LInsurance;
                                    RSchedule."Monthly Interest" := LInterest;
                                    RSchedule."Principal Repayment" := LPrincipal;
                                    RSchedule."Monthly Insurance" := LInsurance;
                                    RSchedule."Loan Balance" := ScheduleBal;
                                    RSchedule.Insert;
                                    WhichDay := Date2dwy(RSchedule."Repayment Date", 1);


                                until LBalance < 1
                            end;
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
                action("Payoff Loan")
                {
                    ApplicationArea = Basic;
                    Image = Calculate;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Loan PayOff Card";
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Overdue := Overdue::" ";
        if FormatField(Rec) then
            Overdue := Overdue::Yes;
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
        GenSetUp: Record "Sales & Receivables Setup";
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
        SMSMessage: Record Customer;
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
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None",JV,"Member Closure","Account Opening",Batches,"Payment Voucher","Petty Cash",Requisition,Loan,Imprest,ImprestSurrender,Interbank;
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
        Overdue: Option Yes," ";
        ScheduleBal: Decimal;
        ObjProductCharge: Record "Loan Product Charges";
        LInsurance: Decimal;
        VarNewInstalmentDate: Date;
        ObjLoanRepaymentSchedule: Record "Loan Repayment Schedule";
        ObjLoanRepaymentScheduleTemp: Record "Loan Repayment Schedule Temp";
        SFactory: Codeunit "SURESTEP Factory";


    procedure GetVariables(var LoanNo: Code[20]; var LoanProductType: Code[20])
    begin
        LoanNo := "Loan  No.";
        LoanProductType := "Loan Product Type";
    end;


    procedure FormatField(Rec: Record "Loans Register") OK: Boolean
    begin
        if "Outstanding Balance" > 0 then begin
            if (Rec."Expected Date of Completion" < Today) then
                exit(true)
            else
                exit(false);
        end;
    end;


    procedure CalledFrom()
    begin
        Overdue := Overdue::" ";
    end;
}

