#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
// dotnet // --> Reports ForNAV Autogenerated code - do not delete or modify
// {
//     assembly("ForNav.Reports.6.3.0.2259")
//     {
//         type(ForNav.Report_6_3_0_2259; ForNavReport51516450_v6_3_0_2259) { }
//     }
// } // Reports ForNAV Autogenerated code - do not delete or modify -->

Report 50450 "Loan Monthly Expectation"
{
    RDLCLayout = 'Layouts/LoanMonthlyExpectation.rdlc';
    DefaultLayout = RDLC;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Loans Register"; "Loans Register")
        {
            DataItemTableView = where("Outstanding Balance" = filter(<> 0));
            RequestFilterFields = Source, Posted, "Last Pay Date", "Issued Date";
            // column(ReportForNavId_4645; 4645) { } // Autogenerated by ForNav - Do not delete
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(Company_Name; Company.Name)
            {
            }
            column(Company_Address; Company.Address)
            {
            }
            column(Company_Address_2; Company."Address 2")
            {
            }
            column(Company_Phone_No; Company."Phone No.")
            {
            }
            column(Company_Fax_No; Company."Fax No.")
            {
            }
            column(Company_Picture; Company.Picture)
            {
            }
            column(Company_Email; Company."E-Mail")
            {
            }
            // column(CurrReport_PAGENO; CurrReport.PageNo())
            // {
            // }
            column(UserId; UserId)
            {
            }
            column(S_No; SN)
            {
            }
            column(Loan_No; "Loans Register"."Loan  No.")
            {
            }
            column(Loan_Type; "Loans Register"."Loan Product Type")
            {
            }
            column(Staff_No; "Loans Register"."Staff No")
            {
            }
            column(Member_Name; "Loans Register"."Client Name")
            {
            }
            column(Issued_Date; Format("Loans Register"."Issued Date"))
            {
            }
            column(Installments; "Loans Register".Installments)
            {
            }
            column(Repayment; "Loans Register".Repayment)
            {
            }
            column(Approved_Amount; "Loans Register"."Approved Amount")
            {
            }
            column(Outstanding_Bal; "Loans Register"."Outstanding Balance")
            {
            }
            column(exrepay; exrepay)
            {
            }
            column(expectedInterest; expectedInterest)
            {
            }
            column(ScheduledRepayment; ScheduledRepayment)
            {
            }
            column(ScheduledInterest; ScheduledInterest)
            {
            }
            column(Arrears; Arrears)
            {
            }
            column(LBal; LBal)
            {
            }
            column(ScheduledLoanBal; ScheduledLoanBal)
            {
            }
            trigger OnPreDataItem();
            begin

            end;

            trigger OnAfterGetRecord();
            begin
                "1Month" := 0;
                "2Month" := 0;
                "3Month" := 0;
                Over3Month := 0;
                currInstal := 0;
                //exrepay:=0;
                expectedRepay := 0;
                expectedInterest := 0;
                Variance := 0;
                //Filter:=Loans."Issued Date";
                //IF Loans.Installments>0 THEN
                if BEGINDATE = 0D then
                    Error('You Must Specify the Begin date for the report');
                if ENDATE = 0D then
                    Error('You Must Specify the End date for the report');
                INST := Loans.Installments;
                Oustanding := Loans."Outstanding Balance";
                Interest := Loans.Interest;
                Loans.CalcFields(Loans."Last Pay Date", Loans."Outstanding Balance", Loans."Loan Repayment");
                if Loans."Issued Date" <> 0D then begin
                    if Loans.Posted = true then
                        currInstal := Today - Loans."Issued Date";
                    currInstal2 := ROUND(currInstal / 30, 1);
                    expectedInterest := ROUND(((Interest / 1200) * Oustanding), 0.05, '>');
                    //expectedInterest:=Oustanding * (Interest/100);
                    //MESSAGE('THE OUTSTANDING BAL IS %1',Oustanding);
                    //MESSAGE('THE INTEREST RATE IS %1',Interest);
                    exrepay := Loans."Loan Repayment";
                    //MESSAGE('The expectedInterest is %1',expectedInterest);
                    //exrepay:= Loans."Loan Principle "Loan Repayment"";
                    //expectedRepay:=exrepay*currInstal2;
                    Variance := expectedRepay - (Loans."Loan Repayment" * -1);
                end;
                TexpectedInterest := TexpectedInterest + expectedInterest;
                FnGetMonthlyRepayment("Loan  No.");
            end;

        }
    }

    requestpage
    {


        SaveValues = false;
        layout
        {
            area(content)
            {
                field(Begin_Date; BEGINDATE)
                {
                    ApplicationArea = Basic;
                    Caption = 'Begin Date';
                }
                field(End_Date; ENDATE)
                {
                    ApplicationArea = Basic;
                    Caption = 'End Date';
                }
                // field(ForNavOpenDesigner; ReportForNavOpenDesigner)
                // {
                //     ApplicationArea = Basic;
                //     Caption = 'Design';
                //     Visible = ReportForNavAllowDesign;
                //     trigger OnValidate()
                //     begin
                //         ReportForNav.LaunchDesigner(ReportForNavOpenDesigner);
                //         CurrReport.RequestOptionsPage.Close();
                //     end;

                // }
            }
        }

        actions
        {
        }
        trigger OnOpenPage()
        begin
            //ReportForNavOpenDesigner := false;
        end;
    }

    trigger OnInitReport()
    begin
        Company.Get();
        Company.CalcFields(Company.Picture);
        ;
        //

    end;

    trigger OnPostReport()
    begin
        ;
        //
    end;

    trigger OnPreReport()
    begin
        ;
        // 
    end;

    var
        Loans_RegisterCaptionLbl: label 'Approved Loans Report';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        Loan_TypeCaptionLbl: label 'Loan Type';
        Client_No_CaptionLbl: label 'Client No.';
        Outstanding_LoanCaptionLbl: label 'Outstanding Loan';
        PeriodCaptionLbl: label 'Period';
        Approved_DateCaptionLbl: label 'Approved Date';
        Loan_TypeCaption_Control1102760043Lbl: label 'Loan Type';
        Verified_By__________________________________________________CaptionLbl: label 'Verified By..................................................';
        Confirmed_By__________________________________________________CaptionLbl: label 'Confirmed By..................................................';
        Sign________________________CaptionLbl: label 'Sign........................';
        Sign________________________Caption_Control1102755003Lbl: label 'Sign........................';
        Date________________________CaptionLbl: label 'Date........................';
        Date________________________Caption_Control1102755005Lbl: label 'Date........................';
        NameCreditOff: label 'Name......................................';
        NameCreditDate: label 'Date........................................';
        NameCreditSign: label 'Signature..................................';
        NameCreditMNG: label 'Name......................................';
        NameCreditMNGDate: label 'Date.....................................';
        NameCreditMNGSign: label 'Signature..................................';
        NameCEO: label 'Name........................................';
        NameCEOSign: label 'Signature...................................';
        NameCEODate: label 'Date.....................................';
        CreditCom1: label 'Name........................................';
        CreditCom1Sign: label 'Signature...................................';
        CreditCom1Date: label 'Date.........................................';
        CreditCom2: label 'Name........................................';
        CreditCom2Sign: label 'Signature....................................';
        CreditCom2Date: label 'Date..........................................';
        CreditCom3: label 'Name.........................................';
        CreditComDate3: label 'Date..........................................';
        CreditComSign3: label 'Signature..................................';
        Comment: label '....................';
        SN: Integer;
        Company: Record "Company Information";
        "1Month": Decimal;
        "2Month": Decimal;
        "3Month": Decimal;
        Over3Month: Decimal;
        ShowLoan: Boolean;
        Defaultedamount: Decimal;
        INST: Decimal;
        currInstal: Integer;
        currInstal2: Decimal;
        exrepay: Decimal;
        expectedRepay: Decimal;
        Variance: Decimal;
        expectedInterest: Decimal;
        Oustanding: Decimal;
        Interest: Decimal;
        TexpectedInterest: Decimal;
        BEGINDATE: Date;
        ENDATE: Date;
        Loans: Record "Loans Register";
        ScheduledLoanBal: Decimal;
        LBal: Decimal;
        Arrears: Decimal;
        ScheduledRepayment: Decimal;
        ScheduledInterest: Decimal;
        RepaymentPeriod: Date;
        LastMonth: Date;
        LSchedule: Record "Loan Repayment Schedule";
        DateFilter: Text[100];

    local procedure FnGetMonthlyRepayment(LoanNo: Code[20])
    begin
        RepaymentPeriod := ENDATE;
        Loans.Reset;
        Loans.SetRange(Loans."Loan  No.", LoanNo);
        if Loans.Find('-') then begin
            Loans.CalcFields(Loans."Outstanding Balance", Loans."Penalty Charged");
            LoanNo := Loans."Loan  No.";
            //Get Last Day of the previous month
            if Loans."Repayment Frequency" = Loans."repayment frequency"::Monthly then begin
                if RepaymentPeriod = CalcDate('CM', RepaymentPeriod) then begin
                    LastMonth := RepaymentPeriod;
                end else begin
                    LastMonth := CalcDate('0M', RepaymentPeriod);
                end;
                LastMonth := CalcDate('CM', LastMonth);
            end;
            //End Get Last Day of the previous month
            //Get Scheduled Balance
            LSchedule.Reset;
            LSchedule.SetRange(LSchedule."Loan No.", LoanNo);
            LSchedule.SetRange(LSchedule."Repayment Date", LastMonth);
            if LSchedule.FindFirst then begin
                ScheduledLoanBal := LSchedule."Loan Amount";
                ScheduledRepayment := LSchedule."Principal Repayment";
                ScheduledInterest := LSchedule."Monthly Interest";
            end;
            //End Get Scheduled Balance
            //Get Loan Bal as per the date filter
            DateFilter := '..' + Format(LastMonth);
            Loans.SetFilter(Loans."Date filter", DateFilter);
            Loans.CalcFields(Loans."Outstanding Balance");
            LBal := Loans."Outstanding Balance";
            //End Get Loan Bal as per the date filter
            LBal := Loans."Outstanding Balance";
            //Amount in Arrears
            Arrears := ScheduledLoanBal - LBal;
            if (Arrears > 0) or (Arrears = 0) then begin
                Arrears := 0
            end else
                Arrears := Arrears;
        end;
    end;

    // --> Reports ForNAV Autogenerated code - do not delete or modify
    var
    //     [WithEvents]
    //     ReportForNav: DotNet ForNavReport51516450_v6_3_0_2259;
    //     ReportForNavOpenDesigner: Boolean;
    //     [InDataSet]
    //     ReportForNavAllowDesign: Boolean;

    // local procedure ReportsForNavInit();
    // var
    //     ApplicationSystemConstants: Codeunit "Application System Constants";
    //     addInFileName: Text;
    //     tempAddInFileName: Text;
    //     path: DotNet Path;
    //     ReportForNavObject: Variant;
    // begin
    //     addInFileName := ApplicationPath() + 'Add-ins\ReportsForNAV_6_3_0_2259\ForNav.Reports.6.3.0.2259.dll';
    //     if not File.Exists(addInFileName) then begin
    //         tempAddInFileName := path.GetTempPath() + '\Microsoft Dynamics NAV\Add-Ins\' + ApplicationSystemConstants.PlatformFileVersion() + '\ForNav.Reports.6.3.0.2259.dll';
    //         if not File.Exists(tempAddInFileName) then
    //             Error('Please install the ForNAV DLL version 6.3.0.2259 in your service tier Add-ins folder under the file name "%1"\\If you already have the ForNAV DLL on the server, you should move it to this folder and rename it to match this file name.', addInFileName);
    //     end;
    //     ReportForNavObject := ReportForNav.GetLatest(CurrReport.OBJECTID, CurrReport.Language, SerialNumber, UserId, CompanyName);
    //     ReportForNav := ReportForNavObject;
    //     ReportForNav.Init();
    // end;

    // local procedure ReportsForNavPre();
    // begin
    //     ReportForNav.OpenDesigner := ReportForNavOpenDesigner;
    //     if not ReportForNav.Pre() then CurrReport.Quit();
    // end;

    // Reports ForNAV Autogenerated code - do not delete or modify -->
}
