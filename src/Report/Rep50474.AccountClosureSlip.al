#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
// dotnet // --> Reports ForNAV Autogenerated code - do not delete or modify
// {
//     assembly("ForNav.Reports.6.3.0.2259")
//     {
//         type(ForNav.Report_6_3_0_2259; ForNavReport51516474_v6_3_0_2259) { }
//     }
// } // Reports ForNAV Autogenerated code - do not delete or modify -->

Report 50474 "Account Closure Slip"
{
    RDLCLayout = 'Layouts/AccountClosureSlip.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.";
            //column(ReportForNavId_7301; 7301) { } // Autogenerated by ForNav - Do not delete
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            // column(CurrReport_PAGENO; CurrReport.PageNo())
            // {
            // }
            column(UserId; UserId)
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(Companyinfo_Name; Companyinfo.Name)
            {
            }
            column(Companyinfo_Address; Companyinfo.Address)
            {
            }
            column(Members__No__; Customer."No.")
            {
            }
            column(Members_Name; Customer.Name)
            {
            }
            column(Members__ID_No__; Customer."ID No.")
            {
            }
            column(RiskFund; RiskFund)
            {
            }
            column(TotalAdds; TotalAdds)
            {
            }
            column(UnpaidDividendsNew; UnpaidDividendsNew)
            {
            }
            column(TotalLoanBOSA; TotalLoanBOSA)
            {
            }
            column(TotalIntDueBOSA; TotalIntDueBOSA)
            {
            }
            column(TotalLoanFOSA; TotalLoanFOSA)
            {
            }
            column(TotalIntDueFOSA; TotalIntDueFOSA)
            {
            }
            column(Totallesses; Totallesses)
            {
            }
            column(VarTotalDeduction; VarTotalDeduction)
            {
            }
            column(TaxOnWithdrawalFee; TaxOnWithdrawalFee)
            {
            }
            column(TaxOnShareCapSell; TaxOnShareCapSell)
            {
            }
            column(RiskFundBeneficiary; RiskFundBeneficiary)
            {
            }
            column(RiskRefund; RiskRefund)
            {
            }
            column(Members__Payroll_Staff_No_; Customer."Payroll No")
            {
            }
            column(Members__Outstanding_Balance_; Customer."Outstanding Balance")
            {
            }
            column(TranferFee; TranferFee)
            {
            }
            column(CompanyinfoPicture; Companyinfo.Picture)
            {
            }
            column(Current_Shares___1; Customer."Current Shares")
            {
            }
            column(Insurance_Fund___1; Customer."Insurance Fund")
            {
            }
            column(RiskFund_MembersRegister; Customer."Risk Fund")
            {
            }
            column(Members__Accrued_Interest_; Customer."Accrued Interest")
            {
            }
            column(OutstandingInterest_Members; Customer."Outstanding Interest")
            {
            }
            column(Members__Current_Shares_; Customer."Current Shares")
            {
            }
            column(UnpaidDividends; UnpaidDividends)
            {
            }
            column(Members__Insurance_Fund_; Customer."Insurance Fund")
            {
            }
            column(NetPayable; NetPayable)
            {
            }
            column(Members__Current_Investment_Total_; Customer."Current Investment Total")
            {
            }
            column(Members__Dividend_Amount_; Customer."Dividend Amount")
            {
            }
            column(FWithdrawal; FWithdrawal)
            {
            }
            column(Members_Members__Batch_No__; Customer."Batch No.")
            {
            }
            column(Members_Members_Status; Customer.Status)
            {
            }
            column(FOSAInterest; FOSAInterest)
            {
            }
            column(Members__FOSA_Outstanding_Balance_; Customer."FOSA Outstanding Balance")
            {
            }
            column(Members_Members__Shares_Retained_; Customer."Shares Retained")
            {
            }
            column(FExpenses; FExpenses)
            {
            }
            column(InsFund__1; InsFund * -1)
            {
            }
            column(CICLoan; CICLoan)
            {
            }
            column(CICLoan___Current_Shares___1__UnpaidDividends___Insurance_Fund___1__FExpenses; CICLoan + ("Current Shares") + UnpaidDividends + FExpenses)
            {
            }
            column(Outstanding_Balance___Accrued_Interest___FOSA_Outstanding_Balance__FOSAInterest_FWithdrawal__InsFund__1_; "Outstanding Balance" + "Accrued Interest" + "FOSA Outstanding Balance" + FOSAInterest + FWithdrawal + (InsFund * -1))
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(ACCOUNT_CLOSURE_SLIPCaption; ACCOUNT_CLOSURE_SLIPCaptionLbl)
            {
            }
            column(P_O_BOX_75629___00200__NAIROBICaption; P_O_BOX_75629___00200__NAIROBICaptionLbl)
            {
            }
            column(Member_No_Caption; Member_No_CaptionLbl)
            {
            }
            column(Members_NameCaption; FieldCaption(Name))
            {
            }
            column(Members__ID_No__Caption; FieldCaption("ID No."))
            {
            }
            column(Members__Payroll_Staff_No_Caption; FieldCaption("Payroll No"))
            {
            }
            column(Current_Oustanding_LoanCaption; Current_Oustanding_LoanCaptionLbl)
            {
            }
            column(Deposit_ContributionCaption; Deposit_ContributionCaptionLbl)
            {
            }
            column(Other_DeductionsCaption; Other_DeductionsCaptionLbl)
            {
            }
            column(Insurance_Fund_Caption; Insurance_Fund_CaptionLbl)
            {
            }
            column(Members__Accrued_Interest_Caption; FieldCaption("Accrued Interest"))
            {
            }
            column(ADD__Unpaid_DividendsCaption; ADD__Unpaid_DividendsCaptionLbl)
            {
            }
            column(LESS_Caption; LESS_CaptionLbl)
            {
            }
            column(ADD_Caption; ADD_CaptionLbl)
            {
            }
            column(Net_RefundCaption; Net_RefundCaptionLbl)
            {
            }
            column(Withdrawal_FeesCaption; Withdrawal_FeesCaptionLbl)
            {
            }
            column(Batch_No_Caption; Batch_No_CaptionLbl)
            {
            }
            column(DataItem1000000004; Prepared_By___________________________________________________Lbl)
            {
            }
            column(DataItem1000000005; Certified_By__________________________________________________Lbl)
            {
            }
            column(DataItem1000000007; Signature_Date________________________________________________Lbl)
            {
            }
            column(DataItem1000000008; Signature_Date_____________________________________________000Lbl)
            {
            }
            column(Member_StatusCaption; Member_StatusCaptionLbl)
            {
            }
            column(FOSA_Accrued_InterestCaption; FOSA_Accrued_InterestCaptionLbl)
            {
            }
            column(FOSA_Current_Oustanding_LoanCaption; FOSA_Current_Oustanding_LoanCaptionLbl)
            {
            }
            column(Funeral_ExpensesCaption; Funeral_ExpensesCaptionLbl)
            {
            }
            column(Under_Excess_InsuranceCaption; Under_Excess_InsuranceCaptionLbl)
            {
            }
            column(Insurance__CIC_Caption; Insurance__CIC_CaptionLbl)
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }
            column(TotalCaption_Control1102760055; TotalCaption_Control1102760055Lbl)
            {
            }
            column(VarShareCapitalsellAdd; VarShareCapitalsellAdd)
            {
            }
            dataitem("Share Capital Sell"; "Share Capital Sell")
            {
                DataItemLink = "Selling Member No" = field("No.");
                //column(ReportForNavId_4; 4) { } // Autogenerated by ForNav - Do not delete
                column(BuyerMemberNo_ShareCapitalSell; "Share Capital Sell"."Buyer Member No")
                {
                }
                column(BuyerName_ShareCapitalSell; "Share Capital Sell"."Buyer Name")
                {
                }
                column(Amount_ShareCapitalSell; "Share Capital Sell".Amount)
                {
                }
            }
            trigger OnPreDataItem();
            begin
                LastFieldNo := FieldNo("No.");
                Companyinfo.Get();
                Companyinfo.CalcFields(Companyinfo.Picture);
            end;

            trigger OnAfterGetRecord();
            begin
                CalcFields("Current Shares");
                WithdrawalFee := 0;
                NetPayable := 0;
                FWithdrawal := 0;
                FExpenses := 0;
                CICLoan := 0;
                InsFund := 0;
                UnpaidDividends := 0;
                if Cust.Get('RB-' + Cust."Payroll No") then begin
                    Cust.CalcFields(Cust."Balance (LCY)");
                    UnpaidDividends := Cust."Balance (LCY)"
                end;
                Closure.Reset;
                Closure.SetRange(Closure."Member No.", "No.");
                if Closure.FindLast then begin
                    if Closure.Posted = false then begin
                        Closure."Member Deposits" := "Current Shares";
                    end;
                    Closure.CalcFields(Closure."Share Capital to Sell");
                    if Closure."Sell Share Capital" = false then begin
                        Closure."Total Adds" := Closure."Member Deposits" + Closure."Unpaid Dividends"
                    end else
                        Closure."Total Adds" := Closure."Member Deposits" + Closure."Unpaid Dividends" + Closure."Share Capital to Sell";
                    RiskFund := Closure."Risk Fund";
                    RiskFundBeneficiary := Closure."Risk Beneficiary";
                    RiskRefund := Closure."Risk Refundable";
                    TotalAdds := Closure."Total Adds";
                    UnpaidDividendsNew := Closure."Unpaid Dividends";
                    TotalLoanBOSA := Closure."Total Loan";
                    TotalIntDueBOSA := Closure."Total Interest";
                    TotalLoanFOSA := Closure."Total Loans FOSA";
                    TotalIntDueFOSA := Closure."Total Oustanding Int FOSA";
                    Totallesses := Closure."Total Lesses";
                end;
                NetLiability := TotalAdds - Totallesses;
                TranferFee := 0;
                Generalsetup.Get();
                Closure.Reset;
                Closure.SetRange(Closure."Member No.", "No.");
                if Closure.FindLast then begin
                    if (Closure."Sell Share Capital" = true) and (Closure."Closure Type" <> Closure."closure type"::"Member Exit - Deceased") then begin
                        Closure.CalcFields(Closure."Share Capital to Sell");
                        VarShareCapitalsellAdd := Closure."Share Capital to Sell";
                        TranferFee := Generalsetup."Share Capital Transfer Fee";
                        TaxOnShareCapSell := Closure."Tax: Share Capital Transfer Fe";
                    end;
                end;
                if (Closure."Member Deposits" > 1) and (Closure."Closure Type" <> Closure."closure type"::"Member Exit - Deceased") then begin
                    FWithdrawal := Generalsetup."Withdrawal Fee";
                    TaxOnWithdrawalFee := Closure."Tax: Membership Exit Fee";
                end;
                VarTotalDeduction := Totallesses + FWithdrawal + TranferFee + TaxOnShareCapSell + TaxOnWithdrawalFee;
                if Closure."Closure Type" = Closure."closure type"::"Member Exit - Deceased" then begin
                    NetPayable := NetLiability
                end else
                    if (Closure."Closure Type" = Closure."closure type"::"Member Exit - Normal") then begin
                        NetPayable := NetLiability - FWithdrawal - TranferFee - TaxOnShareCapSell - TaxOnWithdrawalFee;
                        Closure."Risk Fund Arrears" := NetPayable;
                    end;
                Closure.Modify;
                /*IF Customer.GET(Withdrawal."Member No.") THEN BEGIN
				Withdrawal."Net Payable to FOSA":=NetPayable;
				  Withdrawal.MODIFY;
				END;*/
                /*
				Closure."Net Pay":=NetPayable;
				Closure."Net Payable to the Member":=NetPayable;
				Closure."Net Payable to FOSA":=NetPayable;
				Closure.MODIFY;
				MESSAGE('NetPayable is %1',Closure."Net Payable to FOSA");
				*/

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
                group(Options)
                {
                    Caption = 'Options';
                    // field(ForNavOpenDesigner; ReportForNavOpenDesigner)
                    // {
                    //     ApplicationArea = Basic;
                    //     Caption = 'Design';
                    //     Visible = ReportForNavAllowDesign;
                    //     trigger OnValidate()
                    //     begin
                    //        // ReportForNav.LaunchDesigner(ReportForNavOpenDesigner);
                    //         CurrReport.RequestOptionsPage.Close();
                    //     end;

                    // }

                }
            }
        }

        actions
        {
        }
        trigger OnOpenPage()
        begin
            ////:= false;
        end;
    }

    trigger OnInitReport()
    begin
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
        WithdrawalFee: Decimal;
        NetRefund: Decimal;
        FWithdrawal: Decimal;
        NetPayable: Decimal;
        FOSAInterest: Decimal;
        FExpenses: Decimal;
        CICLoan: Decimal;
        InsFund: Decimal;
        UnpaidDividends: Decimal;
        Cust: Record Customer;
        CurrReport_PAGENOCaptionLbl: label 'Page';
        ACCOUNT_CLOSURE_SLIPCaptionLbl: label 'ACCOUNT CLOSURE SLIP';
        P_O_BOX_75629___00200__NAIROBICaptionLbl: label 'P.O BOX 75629 - 00200, NAIROBI';
        Member_No_CaptionLbl: label 'Member No.';
        Current_Oustanding_LoanCaptionLbl: label 'Current Oustanding Loan';
        Deposit_ContributionCaptionLbl: label 'Deposit Contribution';
        Other_DeductionsCaptionLbl: label 'Other Deductions';
        Insurance_Fund_CaptionLbl: label 'Insurance Fund ';
        ADD__Unpaid_DividendsCaptionLbl: label 'ADD: Unpaid Dividends';
        LESS_CaptionLbl: label 'LESS:';
        ADD_CaptionLbl: label 'ADD:';
        Net_RefundCaptionLbl: label 'Net Refund';
        Withdrawal_FeesCaptionLbl: label 'Withdrawal Fees';
        Batch_No_CaptionLbl: label 'Batch No.';
        Prepared_By___________________________________________________Lbl: label 'Prepared By: ....................................................................................................................................................................';
        Certified_By__________________________________________________Lbl: label 'Certified By: ....................................................................................................................................................................';
        Signature_Date________________________________________________Lbl: label 'Signature/Date: ....................................................................................................................................................................';
        Signature_Date_____________________________________________000Lbl: label 'Signature/Date: ....................................................................................................................................................................';
        Member_StatusCaptionLbl: label 'Member Status';
        FOSA_Accrued_InterestCaptionLbl: label 'FOSA Accrued Interest';
        FOSA_Current_Oustanding_LoanCaptionLbl: label 'FOSA Current Oustanding Loan';
        Funeral_ExpensesCaptionLbl: label 'Funeral Expenses';
        Under_Excess_InsuranceCaptionLbl: label 'Under/Excess Insurance';
        Insurance__CIC_CaptionLbl: label 'Insurance (CIC)';
        TotalCaptionLbl: label 'Total';
        TotalCaption_Control1102760055Lbl: label 'Total';
        LastFieldNo: Integer;
        Companyinfo: Record "Company Information";
        TranferFee: Decimal;
        Closure: Record "Membership Exist";
        Generalsetup: Record "Sacco General Set-Up";
        RiskFund: Decimal;
        RiskFundBeneficiary: Boolean;
        RiskRefund: Decimal;
        TotalAdds: Decimal;
        UnpaidDividendsNew: Decimal;
        TotalLoanBOSA: Decimal;
        TotalIntDueBOSA: Decimal;
        TotalLoanFOSA: Decimal;
        TotalIntDueFOSA: Decimal;
        NetLiability: Decimal;
        Totallesses: Decimal;
        Withdrawal: Record "Membership Exist";
        TaxOnWithdrawalFee: Decimal;
        TaxOnShareCapSell: Decimal;
        VarShareCapitalsellAdd: Decimal;
        ObjCust: Record Customer;
        VarTotalDeduction: Decimal;

    // --> Reports ForNAV Autogenerated code - do not delete or modify
    // var
    //     [WithEvents]
    //     ReportForNav: DotNet ForNavReport51516474_v6_3_0_2259;
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
