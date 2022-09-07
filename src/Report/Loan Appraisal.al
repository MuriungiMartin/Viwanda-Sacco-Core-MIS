#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Report 50384 "Loan Appraisal Draft"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Loan Appraisal Draft.rdlc';

    dataset
    {
        dataitem("Loans Register"; "Loans Register")
        {
            DataItemTableView = sorting("Loan  No.");
            RequestFilterFields = "Loan  No.", "Loan Product Type";
            column(ReportForNavId_4645; 4645)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            // column(CurrReport_PAGENO; CurrReport.PageNo)
            // {
            // }
            column(UserId; UserId)
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(CompanyInfo_Address; CompanyInfo.Address)
            {
            }
            column(CompanyInfo__Phone_No__; CompanyInfo."Phone No.")
            {
            }
            column(CompanyInfo__E_Mail_; CompanyInfo."E-Mail")
            {
            }
            column(CompanyInfo_City; CompanyInfo.City)
            {
            }
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(Loans__Application_Date_; "Application Date")
            {
            }
            column(Psalary; Psalary)
            {
            }
            column(JazaDeposits; "Jaza Deposits")
            {
            }
            column(DepositReinstatement; "Deposit Reinstatement")
            {
            }
            column(LoanDepositMultiplier; "Loans Register"."Loan Deposit Multiplier")
            {
            }
            column(interestUpfront; interestUpfront)
            {
            }
            column(LoanProcessingFee; LPFcharge)
            {
            }
            column(LoanTransferFee; LoanTransferFee)
            {
            }
            column(TscInt; TscInt)
            {
            }
            column(AccruedInt; AccruedInt)
            {
            }
            column(ProcessingFee; ProcessingFee)
            {
            }
            column(LoanFormFee; LoanFormFee)
            {
            }
            column(LAppraisalFee; LAppraisalFee)
            {
            }
            column(DepositMultiplier; (DEpMultiplier - LBalance))
            {
            }
            column(SaccoInt; SaccoInt)
            {
            }
            column(TotalLoanBal; TotalLoanBal)
            {
            }
            column(Upfronts; Upfronts)
            {
            }
            column(ShareBoostComm; ShareBoostComm)
            {
            }
            column(ExciseDutyShareBoostComm; ExciseDutyShareBoostComm)
            {
            }
            column(Netdisbursed; Netdisbursed)
            {
            }
            column(StatDeductions; StatDeductions)
            {
            }
            column(TotLoans; TotLoans)
            {
            }
            column(LoanInsurance; LoanInsurance)
            {
            }
            column(Multiplier; Multiplier)
            {
            }
            column(BoostedAmount_LoansRegister; "Loans Register"."Boosted Amount")
            {
            }
            column(BoostingCommision_LoansRegister; "Loans Register"."Boosting Commision")
            {
            }
            column(IncomeType_LoansRegister; "Loans Register"."Income Type")
            {
            }
            column(BankStatementAvarageCredits_LoansRegister; "Loans Register"."Bank Statement Avarage Credits")
            {
            }
            column(BankStatementAvarageDebits_LoansRegister; "Loans Register"."Bank Statement Avarage Debits")
            {
            }
            column(BankStatementNetIncome_LoansRegister; "Loans Register"."Bank Statement Net Income")
            {
            }
            column(BSExpensesTransport_LoansRegister; "Loans Register"."BSExpenses Transport")
            {
            }
            column(BSExpensesEducation_LoansRegister; "Loans Register"."BSExpenses Education")
            {
            }
            column(BSExpensesFood_LoansRegister; "Loans Register"."BSExpenses Food")
            {
            }
            column(BSExpensesUtilities_LoansRegister; "Loans Register"."BSExpenses Utilities")
            {
            }
            column(BSExpensesOthers_LoansRegister; "Loans Register"."BSExpenses Others")
            {
            }
            column(BSExpensesRent_LoansRegister; "Loans Register"."BSExpenses Rent")
            {
            }
            column(SalaryTotalIncome_LoansRegister; "Loans Register"."Salary Total Income")
            {
            }
            column(SExpensesRent_LoansRegister; "Loans Register"."SExpenses Rent")
            {
            }
            column(SExpensesTransport_LoansRegister; "Loans Register"."SExpenses Transport")
            {
            }
            column(SExpensesEducation_LoansRegister; "Loans Register"."SExpenses Education")
            {
            }
            column(SExpensesFood_LoansRegister; "Loans Register"."SExpenses Food")
            {
            }
            column(SExpensesUtilities_LoansRegister; "Loans Register"."SExpenses Utilities")
            {
            }
            column(SExpensesOthers_LoansRegister; "Loans Register"."SExpenses Others")
            {
            }
            column(SalaryNetUtilizable_LoansRegister; "Loans Register"."Salary Net Utilizable")
            {
            }
            column(LoanCashCleared_LoansRegister; "Loans Register"."Loan  Cash Cleared")
            {
            }
            column(LoanCashClearancefee_LoansRegister; "Loans Register"."Loan Cash Clearance fee")
            {
            }
            column(PrincipleRepayment; "Loans Register"."Loan Principle Repayment")
            {
            }
            column(InterestRepayment; "Loans Register"."Loan Interest Repayment")
            {
            }
            column(repayAmount; repayAmount)
            {
            }
            column(Repayment; "Loans Register".Repayment)
            {
            }
            column(Loans__Loan__No__; "Loan  No.")
            {
            }
            column(Loans__Loan_Product_Type_; "Loan Product Type")
            {
            }
            column(Loans_Loans__Client_Code_; "Loans Register"."Client Code")
            {
            }
            column(LoansApprovedAmount; "Loans Register"."Approved Amount")
            {
            }
            column(ShareCapitalDue_LoansRegister; "Loans Register"."Share Capital Due")
            {
            }
            column(Cust_Name; Cust.Name)
            {
            }
            column(Loans__Requested_Amount_; "Requested Amount")
            {
            }
            column(Loans__Staff_No_; "Staff No")
            {
            }
            column(NetSalary; NetSalary)
            {
            }
            column(CollateralAmount; CollateralAmount)
            {
            }
            column(Approved_Amounts; "Approved Amount")
            {
            }
            column(Reccom_Amount; Recomm)
            {
            }
            column(LOANBALANCE; LOANBALANCE)
            {
            }
            column(Loans_Installments; Installments)
            {
            }
            column(Loans__No__Of_Guarantors_; "No. Of Guarantors")
            {
            }
            column(TotalBridgeAmount; TotalBridgeAmount)
            {
            }
            column(Cshares_3; Cshares * 3)
            {
            }
            column(Cshares_3__LOANBALANCE_BRIDGEBAL_LOANBALANCEFOSASEC; (Cshares * 3) - LOANBALANCE + BRIDGEBAL - LOANBALANCEFOSASEC)
            {
            }
            column(Cshares; Cshares)
            {
            }
            column(LOANBALANCE_BRIDGEBAL; TotalLoanBal - BRIDGEBAL)
            {
            }
            column(Loans__Transport_Allowance_; "Transport Allowance")
            {
            }
            column(Loans__Employer_Code_; "Employer Code")
            {
            }
            column(Loans__Loan_Product_Type_Name_; "Loan Product Type Name")
            {
            }
            column(Loans__Loan__No___Control1102760138; "Loan  No.")
            {
            }
            column(Loans__Application_Date__Control1102760139; "Application Date")
            {
            }
            column(Loans__Loan_Product_Type__Control1102760140; "Loan Product Type")
            {
            }
            column(Loans_Loans__Client_Code__Control1102760141; "Loans Register"."Client Code")
            {
            }
            column(Cust_Name_Control1102760142; Cust.Name)
            {
            }
            column(Loans__Staff_No__Control1102760144; "Staff No")
            {
            }
            column(Loans_Installments_Control1102760145; Installments)
            {
            }
            column(Loans__No__Of_Guarantors__Control1102760146; "No. Of Guarantors")
            {
            }
            column(Loans__Requested_Amount__Control1102760143; "Requested Amount")
            {
            }
            column(Loans_Repayment; Repayment)
            {
            }
            column(Loans__Employer_Code__Control1102755075; "Employer Code")
            {
            }
            column(MAXAvailable; MAXAvailable)
            {
            }
            column(Cshares_Control1102760156; Cshares)
            {
            }
            column(BRIDGEBAL; BRIDGEBAL)
            {
            }
            column(LOANBALANCE_BRIDGEBAL_Control1102755006; LOANBALANCE - BRIDGEBAL)
            {
            }
            column(DEpMultiplier; DEpMultiplier)
            {
            }
            column(DefaultInfo; DefaultInfo)
            {
            }
            column(RecomRemark; RecomRemark)
            {
            }
            column(Recomm; Recomm)
            {
            }
            column(BLA_Balance; bLaBalance)
            {
            }
            column(BasicEarnings; BasicEarnings)
            {
            }
            column(GShares; GShares)
            {
            }
            column(GShares_TGuaranteedAmount; GShares - TGuaranteedAmount)
            {
            }
            column(Msalary; Msalary)
            {
            }
            column(MAXAvailable_Control1102755031; MAXAvailable)
            {
            }
            column(Recomm_TOTALBRIDGED; Recomm - TOTALBRIDGED)
            {
            }
            column(GuarantorQualification; GuarantorQualification)
            {
            }
            column(Requested_Amount__MAXAvailable; "Requested Amount" - MAXAvailable)
            {
            }
            column(Requested_Amount__Msalary; "Requested Amount" - Msalary)
            {
            }
            column(Requested_Amount__GShares; "Requested Amount" - GShares)
            {
            }
            column(Loan_Appraisal_AnalysisCaption; Loan_Appraisal_AnalysisCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Loan_Application_DetailsCaption; Loan_Application_DetailsCaptionLbl)
            {
            }
            column(Loans__Application_Date_Caption; FieldCaption("Application Date"))
            {
            }
            column(Loans__Loan__No__Caption; FieldCaption("Loan  No."))
            {
            }
            column(Loan_TypeCaption; Loan_TypeCaptionLbl)
            {
            }
            column(MemberCaption; MemberCaptionLbl)
            {
            }
            column(Amount_AppliedCaption; Amount_AppliedCaptionLbl)
            {
            }
            column(Loans__Staff_No_Caption; FieldCaption("Staff No"))
            {
            }
            column(Loans_InstallmentsCaption; FieldCaption(Installments))
            {
            }
            column(Deposits__3Caption; Deposits__3CaptionLbl)
            {
            }
            column(Eligibility_DetailsCaption; Eligibility_DetailsCaptionLbl)
            {
            }
            column(Maxim__Amount_Avail__for_the_LoanCaption; Maxim__Amount_Avail__for_the_LoanCaptionLbl)
            {
            }
            column(Outstanding_LoanCaption; Outstanding_LoanCaptionLbl)
            {
            }
            column(Member_DepositsCaption; Member_DepositsCaptionLbl)
            {
            }
            column(Loans__No__Of_Guarantors_Caption; FieldCaption("No. Of Guarantors"))
            {
            }
            column(Loans__Transport_Allowance_Caption; FieldCaption("Transport Allowance"))
            {
            }
            column(Loans__Employer_Code_Caption; FieldCaption("Employer Code"))
            {
            }
            column(Loans__No__Of_Guarantors__Control1102760146Caption; FieldCaption("No. Of Guarantors"))
            {
            }
            column(Loans_Installments_Control1102760145Caption; FieldCaption(Installments))
            {
            }
            column(Loans__Staff_No__Control1102760144Caption; FieldCaption("Staff No"))
            {
            }
            column(Amount_AppliedCaption_Control1102760132; Amount_AppliedCaption_Control1102760132Lbl)
            {
            }
            column(MemberCaption_Control1102760133; MemberCaption_Control1102760133Lbl)
            {
            }
            column(Loan_TypeCaption_Control1102760134; Loan_TypeCaption_Control1102760134Lbl)
            {
            }
            column(Loans__Application_Date__Control1102760139Caption; FieldCaption("Application Date"))
            {
            }
            column(Loans__Loan__No___Control1102760138Caption; FieldCaption("Loan  No."))
            {
            }
            column(Loan_Application_DetailsCaption_Control1102760151; Loan_Application_DetailsCaption_Control1102760151Lbl)
            {
            }
            column(RepaymentCaption; RepaymentCaptionLbl)
            {
            }
            column(Loans__Employer_Code__Control1102755075Caption; FieldCaption("Employer Code"))
            {
            }
            column(Maxim__Amount_Avail__for_the_LoanCaption_Control1102760150; Maxim__Amount_Avail__for_the_LoanCaption_Control1102760150Lbl)
            {
            }
            column(Total_Outstand__Loan_BalanceCaption; Total_Outstand__Loan_BalanceCaptionLbl)
            {
            }
            column(Deposits___MulitiplierCaption; Deposits___MulitiplierCaptionLbl)
            {
            }
            column(Member_DepositsCaption_Control1102760148; Member_DepositsCaption_Control1102760148Lbl)
            {
            }
            column(Deposits_AnalysisCaption; Deposits_AnalysisCaptionLbl)
            {
            }
            column(Bridged_AmountCaption; Bridged_AmountCaptionLbl)
            {
            }
            column(Out__Balance_After_Top_upCaption; Out__Balance_After_Top_upCaptionLbl)
            {
            }
            column(Recommended_AmountCaption; Recommended_AmountCaptionLbl)
            {
            }
            column(Net_Loan_Disbursement_Caption; Net_Loan_Disbursement_CaptionLbl)
            {
            }
            column(V3__Qualification_as_per_GuarantorsCaption; V3__Qualification_as_per_GuarantorsCaptionLbl)
            {
            }
            column(Defaulter_Info_Caption; Defaulter_Info_CaptionLbl)
            {
            }
            column(V2__Qualification_as_per_SalaryCaption; V2__Qualification_as_per_SalaryCaptionLbl)
            {
            }
            column(V1__Qualification_as_per_SharesCaption; V1__Qualification_as_per_SharesCaptionLbl)
            {
            }
            column(QUALIFICATIONCaption; QUALIFICATIONCaptionLbl)
            {
            }
            column(Insufficient_Deposits_to_cover_the_loan_applied__RiskCaption; Insufficient_Deposits_to_cover_the_loan_applied__RiskCaptionLbl)
            {
            }
            column(WARNING_Caption; WARNING_CaptionLbl)
            {
            }
            column(Salary_is_Insufficient_to_cover_the_loan_applied__RiskCaption; Salary_is_Insufficient_to_cover_the_loan_applied__RiskCaptionLbl)
            {
            }
            column(WARNING_Caption_Control1000000140; WARNING_Caption_Control1000000140Lbl)
            {
            }
            column(WARNING_Caption_Control1000000141; WARNING_Caption_Control1000000141Lbl)
            {
            }
            column(Guarantors_do_not_sufficiently_cover_the_loan__RiskCaption; Guarantors_do_not_sufficiently_cover_the_loan__RiskCaptionLbl)
            {
            }
            column(WARNING_Caption_Control1000000020; WARNING_Caption_Control1000000020Lbl)
            {
            }
            column(Shares_Deposits_BoostedCaption; Shares_Deposits_BoostedCaptionLbl)
            {
            }
            column(DepX; DepX)
            {
            }
            column(TwoThird; TwoThirds)
            {
            }
            column(LPrincipal; LPrincipal)
            {
            }
            column(LInterest; LInterest)
            {
            }
            column(LNumber; LNumber)
            {
            }
            column(TotalLoanDeductions; TotalLoanDeductions)
            {
            }
            column(MinDepositAsPerTier_Loans; "Min Deposit As Per Tier")
            {
            }
            column(TotalRepayments; TotalRepayments)
            {
            }
            column(Totalinterest; Totalinterest)
            {
            }
            column(Band; Band)
            {
            }
            column(NtTakeHome; NtTakeHome)
            {
            }
            column(ATHIRD; ATHIRD)
            {
            }
            column(BridgedRepayment; BridgedRepayment)
            {
            }
            column(BRIGEDAMOUNT; BRIGEDAMOUNT)
            {
            }
            column(BasicPay; BasicPay)
            {
            }
            column(HouseAllowance; HouseAllowance)
            {
            }
            column(TransportAll; TransportAll)
            {
            }
            column(MedicalAll; MedicalAll)
            {
            }
            column(OtherIncomes; OtherIncomes)
            {
            }
            column(GrossP; GrossP)
            {
            }
            column(NETTAKEHOME; NETTAKEHOME)
            {
            }
            column(MonthlyCont; MonthlyCont)
            {
            }
            column(NHIF; NHIF)
            {
            }
            column(PAYE; PAYE)
            {
            }
            column(Risk; Risk)
            {
            }
            column(LifeInsurance; LifeInsurance)
            {
            }
            column(OtherLiabilities; OtherLiabilities)
            {
            }
            column(SaccoDed; SaccoDed)
            {
            }
            column(SMSFEE; SMSFEE)
            {
            }
            column(LPFcharge; LPFcharge)
            {
            }
            column(HisaARREAR; HisaARREAR)
            {
            }
            column(ShareBoostCommHISA; ShareBoostCommHISA)
            {
            }
            column(BoostedAmountHISA; BoostedAmountHISA)
            {
            }
            column(ShareBoostCommHISAFOSA; ShareBoostCommHISAFOSA)
            {
            }
            column(LoanDisbursedAmount_LoansRegister; "Loans Register"."Loan Disbursed Amount")
            {
            }
            column(BasicPayH_LoansRegister; "Loans Register"."Basic Pay H")
            {
            }
            column(MedicalAllowanceH_LoansRegister; "Loans Register"."Medical AllowanceH")
            {
            }
            column(HouseAllowanceH_LoansRegister; "Loans Register"."House AllowanceH")
            {
            }
            column(StaffAssement_LoansRegister; "Loans Register"."Staff Assement")
            {
            }
            column(Pension_LoansRegister; "Loans Register".Pension)
            {
            }
            column(MedicalInsurance_LoansRegister; "Loans Register"."Medical Insurance")
            {
            }
            column(LifeInsurance_LoansRegister; "Loans Register"."Life Insurance")
            {
            }
            column(OtherLiabilities_LoansRegister; "Loans Register"."Other Liabilities")
            {
            }
            column(TransportBusFare_LoansRegister; "Loans Register"."Transport/Bus Fare")
            {
            }
            column(OtherIncome_LoansRegister; "Loans Register"."Other Income")
            {
            }
            column(PensionScheme_LoansRegister; "Loans Register"."Pension Scheme")
            {
            }
            column(OtherNonTaxable_LoansRegister; "Loans Register"."Other Non-Taxable")
            {
            }
            column(MonthlyContribution_LoansRegister; "Loans Register"."Monthly Contribution")
            {
            }
            column(SaccoDeductions_LoansRegister; "Loans Register"."Sacco Deductions")
            {
            }
            column(OtherTaxRelief_LoansRegister; "Loans Register"."Other Tax Relief")
            {
            }
            column(NHIF_LoansRegister; "Loans Register".NHIF)
            {
            }
            column(NSSF_LoansRegister; "Loans Register".NSSF)
            {
            }
            column(PAYE_LoansRegister; "Loans Register".PAYE)
            {
            }
            column(RiskMGT_LoansRegister; "Loans Register"."Risk MGT")
            {
            }
            column(OtherLoansRepayments_LoansRegister; "Loans Register"."Other Loans Repayments")
            {
            }
            column(BridgeAmountRelease_LoansRegister; "Loans Register"."Bridge Amount Release")
            {
            }
            column(Staff_LoansRegister; "Loans Register".Staff)
            {
            }
            column(Disabled_LoansRegister; "Loans Register".Disabled)
            {
            }
            column(StaffUnionContribution_LoansRegister; "Loans Register"."Staff Union Contribution")
            {
            }
            column(NonPayrollPayments_LoansRegister; "Loans Register"."Non Payroll Payments")
            {
            }
            column(GrossPay_LoansRegister; "Loans Register"."Gross Pay")
            {
            }
            column(TotalDeductionsH_LoansRegister; "Loans Register"."Total DeductionsH")
            {
            }
            column(UtilizableAmount_LoansRegister; "Loans Register"."Utilizable Amount")
            {
            }
            column(NetUtilizableAmount_LoansRegister; "Loans Register"."Net Utilizable Amount")
            {
            }
            column(NettakeHome_LoansRegister; "Loans Register"."Net take Home")
            {
            }
            column(InterestInArrears_LoansRegister; "Loans Register"."Interest In Arrears")
            {
            }
            column(PrincipalAmountGlobal; PrincipalAmountGlobal)
            {
            }
            column(Remarks_LoansRegister; "Loans Register".Remarks)
            {
            }
            column(CICInsurance; CICInsurance)
            {
            }
            dataitem("Loans Guarantee Details"; "Loans Guarantee Details")
            {
                DataItemLink = "Loan No" = field("Loan  No.");
                column(ReportForNavId_5140; 5140)
                {
                }
                column(Amont_Guarant; "Loan No")
                {
                }
                column(Name; Name)
                {
                }
                column(AmontGuaranteed_LoansGuaranteeDetails; "Loans Guarantee Details"."Amont Guaranteed")
                {
                }
                column(Guarantor_Memb_No; "Loans Guarantee Details"."Member No")
                {
                }
                column(G_Shares; "Loans Guarantee Details".Shares)
                {
                }
                column(Loan_Guarant; "Loan No")
                {
                }
                column(Guarantor_Outstanding; "Guarantor Outstanding")
                {
                }
                column(Employer_code; "Employer Code")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    if CustRecord.Get("Loans Guarantee Details"."Member No") then begin
                        TShares := TShares + CustRecord."Current Savings";
                        TLoans := TLoans + CustRecord."Principal Balance";
                    end;
                    LoanG.Reset;
                    LoanG.SetRange(LoanG."Member No", "Member No");
                    if LoanG.Find('-') then begin
                        repeat
                            LoanG.CalcFields(LoanG."Outstanding Balance", LoanG."Guarantor Outstanding");
                            if LoanG."Outstanding Balance" > 0 then begin
                                GuaranteedAmount := GuaranteedAmount + LoanG."Amont Guaranteed";
                                GuarOutstanding := LoanG."Guarantor Outstanding";
                            end;
                        until LoanG.Next = 0;
                    end;
                    TGuaranteedAmount := TGuaranteedAmount + GuaranteedAmount;
                end;
            }
            dataitem("Loan Collateral Details"; "Loan Collateral Details")
            {
                DataItemLink = "Loan No" = field("Loan  No.");
                column(ReportForNavId_1000000099; 1000000099)
                {
                }
                column(LoanNo_LoanCollateralDetails; "Loan Collateral Details"."Loan No")
                {
                }
                column(Type_LoanCollateralDetails; "Loan Collateral Details".Type)
                {
                }
                column(SecurityDetails_LoanCollateralDetails; "Loan Collateral Details"."Security Details")
                {
                }
                column(Remarks_LoanCollateralDetails; "Loan Collateral Details".Remarks)
                {
                }
                column(LoanType_LoanCollateralDetails; "Loan Collateral Details"."Loan Type")
                {
                }
                column(Value_LoanCollateralDetails; "Loan Collateral Details".Value)
                {
                }
                column(GuaranteeValue_LoanCollateralDetails; "Loan Collateral Details"."Guarantee Value")
                {
                }
                column(Code_LoanCollateralDetails; "Loan Collateral Details".Code)
                {
                }
                column(Category_LoanCollateralDetails; "Loan Collateral Details".Category)
                {
                }
                column(CollateralMultiplier_LoanCollateralDetails; "Loan Collateral Details"."Collateral Multiplier")
                {
                }
                column(ViewDocument_LoanCollateralDetails; "Loan Collateral Details"."View Document")
                {
                }
                column(AssesmentDone_LoanCollateralDetails; "Loan Collateral Details"."Assesment Done")
                {
                }
                column(AccountNo_LoanCollateralDetails; "Loan Collateral Details"."Account No")
                {
                }
            }
            dataitem("Loan Offset Details"; "Loan Offset Details")
            {
                DataItemLink = "Loan No." = field("Loan  No.");
                DataItemTableView = where("Principle Top Up" = filter(> 0));
                column(ReportForNavId_4717; 4717)
                {
                }
                column(Loans_Top_up__Principle_Top_Up_; "Principle Top Up")
                {
                }
                column(Loans_Top_up__Loan_Type_; "Loan Type")
                {
                }
                column(Loans_Top_up__Client_Code_; "Client Code")
                {
                }
                column(Loans_Top_up__Loan_No__; "Loan No.")
                {
                }
                column(Loans_Top_up__Total_Top_Up_; "Total Top Up")
                {
                }
                column(Loans_Top_up__Interest_Top_Up_; "Interest Top Up")
                {
                }
                column(Loan_Type; "Loan Offset Details"."Loan Type")
                {
                }
                column(Loans_Top_up_Commision; Commision)
                {
                }
                column(Loans_Top_up__Principle_Top_Up__Control1102760116; "Principle Top Up")
                {
                }
                column(BrTopUpCom; BrTopUpCom)
                {
                }
                column(TOTALBRIDGED; TOTALBRIDGED)
                {
                }
                column(Loans_Top_up__Total_Top_Up__Control1102755050; "Total Top Up")
                {
                }
                column(Loans_Top_up_Commision_Control1102755053; Commision)
                {
                }
                column(Loans_Top_up__Interest_Top_Up__Control1102755055; "Interest Top Up")
                {
                }
                column(Total_TopupsCaption; Total_TopupsCaptionLbl)
                {
                }
                column(Bridged_LoansCaption; Bridged_LoansCaptionLbl)
                {
                }
                column(Loan_No_Caption; Loan_No_CaptionLbl)
                {
                }
                column(Loans_Top_up_CommisionCaption; FieldCaption(Commision))
                {
                }
                column(Principal_Top_UpCaption; Principal_Top_UpCaptionLbl)
                {
                }
                column(Loans_Top_up__Interest_Top_Up_Caption; FieldCaption("Interest Top Up"))
                {
                }
                column(Client_CodeCaption; Client_CodeCaptionLbl)
                {
                }
                column(Loan_TypeCaption_Control1102755059; Loan_TypeCaption_Control1102755059Lbl)
                {
                }
                column(TotalsCaption; TotalsCaptionLbl)
                {
                }
                column(Total_Amount_BridgedCaption; Total_Amount_BridgedCaptionLbl)
                {
                }
                column(Bridging_total_higher_than_the_qualifing_amountCaption; Bridging_total_higher_than_the_qualifing_amountCaptionLbl)
                {
                }
                column(WARNING_Caption_Control1102755044; WARNING_Caption_Control1102755044Lbl)
                {
                }
                column(Loans_Top_up_Loan_Top_Up; "Loan Top Up")
                {
                }
                column(WarnBridged; WarnBridged)
                {
                }
                column(WarnSalary; WarnSalary)
                {
                }
                column(WarnDeposits; WarnDeposits)
                {
                }
                column(WarnGuarantor; WarnGuarantor)
                {
                }
                column(WarnShare; WarnShare)
                {
                }
                column(LoanDefaultInfo; DefaultInfo)
                {
                }
                column(Riskamount; Riskamount)
                {
                }
                column(RiskDeposits; RiskDeposits)
                {
                }
                column(RiskGshares; RiskGshares)
                {
                }

                trigger OnAfterGetRecord()
                begin

                    TotalTopUp := ROUND((TotalTopUp + "Principle Top Up"), 0.05, '>');
                    TotalIntPayable := TotalIntPayable + "Monthly Repayment";
                    GTotals := GTotals + ("Principle Top Up" + "Monthly Repayment");
                    if "Loans Register".Get("Loan Offset Details"."Loan No.") then begin
                        if LoanType.Get("Loans Register"."Loan Product Type") then begin
                        end;
                    end;

                    TOTALBRIDGED := TOTALBRIDGED + "Loan Offset Details"."Total Top Up";

                    if TOTALBRIDGED > Recomm then
                        WarnBridged := UpperCase('WARNING: Bridging Total is Higher than the Qualifing Amount.')
                    else
                        WarnBridged := '';
                end;

                trigger OnPreDataItem()
                begin
                    BrTopUpCom := 0;
                    TOTALBRIDGED := 0;
                end;
            }

            trigger OnAfterGetRecord()
            var
                MaximumEligible: Decimal;
                PrincipalAmount: Decimal;
            begin
                Cshares := 0;
                MAXAvailable := 0;
                LOANBALANCE := 0;
                TotalTopUp := 0;
                TotalIntPayable := 0;
                GTotals := 0;
                AmountGuaranteed := 0;
                TotLoans := 0;
                DepX := 0;
                TotalSec := 0;
                TShares := 0;
                TLoans := 0;
                Earnings := 0;
                Deductions := 0;
                NetSalary := 0;
                LoanPrincipal := 0;
                loanInterest := 0;
                Psalary := 0;
                TotalLoanBal := 0;
                TotalBand := 0;
                TotalRepay := 0;
                BridgedRepayment := 0;
                TotalRepayments := 0;
                interestUpfront := 0;
                repayAmount := 0;
                bLaBalance := 0;
                repayAmount := "Loans Register".Repayment;
                if LoanType.Get("Loans Register"."Loan Product Type") then begin
                    if "Loans Register"."Loan Product Type" = 'EMERGENCY 6' then
                        interestUpfront := 0.1 * "Loans Register"."Approved Amount";
                    repayAmount := "Loans Register"."Loan Principle Repayment";

                end;

                "Loans Register"."Gross Pay" := "Loans Register"."Basic Pay H" + "Loans Register"."House AllowanceH" + "Loans Register"."Medical AllowanceH" + "Loans Register"."Transport/Bus Fare"
                + "Loans Register"."Other Income";

                /*
                "Loans Register"."Total Deductions":=("Loans Register".PAYE+"Loans Register".NHIF+"Loans Register".NSSF+"Loans Register"."Staff Union Contribution"
                +"Loans Register"."Monthly Contribution"+"Loans Register"."Risk MGT"+"Loans Register"."Medical Insurance"+"Loans Register"."Life Insurance"
                +"Loans Register"."Provident Fund (Self)"+"Loans Register"."Other Liabilities"+"Loans Register"."Sacco Deductions"+"Loans Register"."Existing Loan Repayments"
                +"Loans Register"."Other Loans Repayments")-"Loans Register"."Offset Loan Monthly repayment";
                
                "Loans Register".MODIFY;
                COMMIT;*/
                FnDepositsAnalysis();
                FnCheckQualificationAsPerDeposits();
                FnCheckQualificationAsPerSalary();
                FnCheckQualificationAsPerGuarantors();
                //FnCheckQualificationAsPerSecurities();
                FnCheckQualificationAsPerDividends();
                FnGetShareBoosting();
                Recomm := ROUND(FnReccommendAmount("Loans Register"."Requested Amount", DepX, TotalGuaranteed, ROUND(Psalary, 0.05, '<')), 100, '<');

                Riskamount := "Loans Register"."Requested Amount" - MAXAvailable;
                //MESSAGE('#Requested Amount=%1, #Total Deposits=%2 #Security Offered Amount=%3 #Qualification by Income=%4..***Recommended Amount=%5***',
                // "Loans Register"."Requested Amount",DepX,TotalGuaranteed,ROUND(Psalary,0.05,'<'),Recomm);

                "Recommended Amount" := ROUND(Recomm, 100, '<');
                bLaBalance := 0.1 * "Loans Register"."Requested Amount";

                // if "Loans Register"."Sacco Decision" then begin
                //"Approved Amount":=ROUND(,100,'<')
                "Approved Amount" := ROUND("Loans Register"."Approved Amount", 100, '<');
                Recomm := ROUND("Loans Register"."Approved Amount", 100, '<');
                //end else
                "Approved Amount" := ROUND(Recomm, 100, '<');

                "Loans Register".Validate("Approved Amount", ROUND(Recomm, 100, '<'));
                if ("Loans Register".Posted = false) then
                    "Loans Register".Modify;

                FnGetLoanApplicationCharges();
                FnEditRepaymentPrincipleAndInterestAmounts();
                FnWarningMessages();

            end;

            trigger OnPreDataItem()
            begin

                CompanyInfo.Get();
                CompanyInfo.CalcFields(CompanyInfo.Picture);
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        if GenSetUp.Get(0) then
            CompanyInfo.Get;
    end;

    var
        CustRec: Record Customer;
        GenSetUp: Record "Sacco General Set-Up";
        Cust: Record Customer;
        CustRecord: Record customer;
        TShares: Decimal;
        TLoans: Decimal;
        LoanApp: Record "Loans Register";
        LoanShareRatio: Decimal;
        Eligibility: Decimal;
        TotalSec: Decimal;
        saccded: Decimal;
        saccded2: Decimal;
        grosspay: Decimal;
        Tdeduct: Decimal;
        Cshares: Decimal;
        "Cshares*3": Decimal;
        "Cshares*4": Decimal;
        QUALIFY_SHARES: Decimal;
        salary: Decimal;
        LoanG: Record "Loans Guarantee Details";
        GShares: Decimal;
        Recomm: Decimal;
        GShares1: Decimal;
        NETTAKEHOME: Decimal;
        Msalary: Decimal;
        RecPeriod: Integer;
        FOSARecomm: Decimal;
        FOSARecoPRD: Integer;
        "Asset Value": Decimal;
        InterestRate: Decimal;
        RepayPeriod: Decimal;
        LBalance: Decimal;
        TotalMRepay: Decimal;
        LInterest: Decimal;
        LPrincipal: Decimal;
        SecuredSal: Decimal;
        Linterest1: Integer;
        LOANBALANCE: Decimal;
        BRIDGEDLOANS: Record "Loan Offset Details";
        BRIDGEBAL: Decimal;
        LOANBALANCEFOSASEC: Decimal;
        TotalTopUp: Decimal;
        TotalIntPayable: Decimal;
        GTotals: Decimal;
        TempVal: Decimal;
        TempVal2: Decimal;
        "TempCshares*4": Decimal;
        "TempCshares*3": Decimal;
        InstallP: Decimal;
        RecomRemark: Text[150];
        InstallRecom: Decimal;
        TopUpComm: Decimal;
        TotalTopupComm: Decimal;
        LoanTopUp: Record "Loan Offset Details";
        "Interest Payable": Decimal;
        LoanType: Record "Loan Products Setup";
        "general set-up": Record "Sacco General Set-Up";
        Days: Integer;
        EndMonthInt: Decimal;
        BRIDGEBAL2: Decimal;
        DefaultInfo: Text[80];
        TOTALBRIDGED: Decimal;
        DEpMultiplier: Decimal;
        MAXAvailable: Decimal;
        SalDetails: Record "Loan Appraisal Salary Details";
        Earnings: Decimal;
        Deductions: Decimal;
        BrTopUpCom: Decimal;
        LoanAmount: Decimal;
        CompanyInfo: Record "Company Information";
        CompanyAddress: Code[20];
        CompanyEmail: Text[30];
        CompanyTel: Code[20];
        CurrentAsset: Decimal;
        CurrentLiability: Decimal;
        FixedAsset: Decimal;
        Equity: Decimal;
        Sales: Decimal;
        SalesOnCredit: Decimal;
        AppraiseDeposits: Boolean;
        AppraiseShares: Boolean;
        AppraiseSalary: Boolean;
        AppraiseGuarantors: Boolean;
        AppraiseBusiness: Boolean;
        TLoan: Decimal;
        LoanBal: Decimal;
        GuaranteedAmount: Decimal;
        RunBal: Decimal;
        TGuaranteedAmount: Decimal;
        GuarantorQualification: Boolean;
        Loan_Appraisal_AnalysisCaptionLbl: label 'Loan Appraisal Analysis';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        Loan_Application_DetailsCaptionLbl: label 'Loan Application Details';
        Loan_TypeCaptionLbl: label 'Loan Type';
        MemberCaptionLbl: label 'Member';
        Amount_AppliedCaptionLbl: label 'Amount Applied';
        Deposits__3CaptionLbl: label 'Deposits* 3';
        Eligibility_DetailsCaptionLbl: label 'Eligibility Details';
        Maxim__Amount_Avail__for_the_LoanCaptionLbl: label 'Maxim. Amount Avail. for the Loan';
        Outstanding_LoanCaptionLbl: label 'Outstanding Loan';
        Member_DepositsCaptionLbl: label 'Member Deposits';
        Amount_AppliedCaption_Control1102760132Lbl: label 'Amount Applied';
        MemberCaption_Control1102760133Lbl: label 'Member';
        Loan_TypeCaption_Control1102760134Lbl: label 'Loan Type';
        Loan_Application_DetailsCaption_Control1102760151Lbl: label 'Loan Application Details';
        RepaymentCaptionLbl: label 'Repayment';
        Maxim__Amount_Avail__for_the_LoanCaption_Control1102760150Lbl: label 'Maxim. Amount Avail. for the Loan';
        Total_Outstand__Loan_BalanceCaptionLbl: label 'Total Outstand. Loan Balance';
        Deposits___MulitiplierCaptionLbl: label 'Deposits * Mulitiplier';
        Member_DepositsCaption_Control1102760148Lbl: label 'Member Deposits';
        Deposits_AnalysisCaptionLbl: label 'Deposits Analysis';
        Bridged_AmountCaptionLbl: label 'Bridged Amount';
        Out__Balance_After_Top_upCaptionLbl: label 'Out. Balance After Top-up';
        Recommended_AmountCaptionLbl: label 'Recommended Amount';
        Net_Loan_Disbursement_CaptionLbl: label 'Net Loan Disbursement:';
        V3__Qualification_as_per_GuarantorsCaptionLbl: label '3. Qualification as per Guarantors';
        Defaulter_Info_CaptionLbl: label 'Defaulter Info:';
        V2__Qualification_as_per_SalaryCaptionLbl: label '2. Qualification as per Salary';
        V1__Qualification_as_per_SharesCaptionLbl: label '1. Qualification as per Shares';
        QUALIFICATIONCaptionLbl: label 'QUALIFICATION';
        Insufficient_Deposits_to_cover_the_loan_applied__RiskCaptionLbl: label 'Insufficient Deposits to cover the loan applied: Risk';
        WARNING_CaptionLbl: label 'WARNING:';
        Salary_is_Insufficient_to_cover_the_loan_applied__RiskCaptionLbl: label 'Salary is Insufficient to cover the loan applied: Risk';
        WARNING_Caption_Control1000000140Lbl: label 'WARNING:';
        WARNING_Caption_Control1000000141Lbl: label 'WARNING:';
        Guarantors_do_not_sufficiently_cover_the_loan__RiskCaptionLbl: label 'Guarantors do not sufficiently cover the loan: Risk';
        WARNING_Caption_Control1000000020Lbl: label 'WARNING:';
        Shares_Deposits_BoostedCaptionLbl: label 'Shares/Deposits Boosted';
        I_Certify_that_the_foregoing_details_and_member_information_is_true_statement_of_the_account_maintained_CaptionLbl: label 'I Certify that the foregoing details and member information is true statement of the account maintained.';
        Loans_Asst__Officer______________________CaptionLbl: label 'Loans Asst. Officer:_____________________';
        Signature__________________CaptionLbl: label 'Signature:_________________';
        Date___________________CaptionLbl: label 'Date:__________________';
        General_Manger______________________CaptionLbl: label 'General Manger:_____________________';
        Signature__________________Caption_Control1102760039Lbl: label 'Signature:_________________';
        Date___________________Caption_Control1102760040Lbl: label 'Date:__________________';
        Signature__________________Caption_Control1102755017Lbl: label 'Signature:_________________';
        Date___________________Caption_Control1102755018Lbl: label 'Date:__________________';
        Loans_Officer______________________CaptionLbl: label 'Loans Officer:_____________________';
        Chairman_Signature______________________CaptionLbl: label 'Chairman Signature:_____________________';
        Secretary_s_Signature__________________CaptionLbl: label 'Secretary''s Signature:_________________';
        Members_Signature______________________CaptionLbl: label 'Members Signature:_____________________';
        Credit_Committe_Minute_No______________________CaptionLbl: label 'Credit Committe Minute No._____________________';
        Date___________________Caption_Control1102755074Lbl: label 'Date:__________________';
        Comment______________________________________________________________________________________CaptionLbl: label 'Comment :____________________________________________________________________________________';
        Amount_Approved______________________CaptionLbl: label 'Amount Approved:_____________________';
        Signatory_1__________________CaptionLbl: label 'Signatory 1:_________________';
        Signatory_2__________________CaptionLbl: label 'Signatory 2:_________________';
        Signatory_3__________________CaptionLbl: label 'Signatory 3:_________________';
        FOSA_SIGNATORIES_CaptionLbl: label 'FOSA SIGNATORIES:';
        Comment___________________________Caption_Control1102755070Lbl: label 'Comment :____________________________________________________________________________________';
        FINANCE_CaptionLbl: label 'FINANCE:';
        Disbursed_By__________________CaptionLbl: label 'Disbursed By:_________________';
        Signature__________________Caption_Control1102755081Lbl: label 'Signature:_________________';
        Date___________________Caption_Control1102755082Lbl: label 'Date:__________________';
        Salary_Details_AnalysisCaptionLbl: label 'Salary Details Analysis';
        Total_EarningsCaptionLbl: label 'Total Earnings';
        Total_DeductionsCaptionLbl: label 'Total Deductions';
        Net_SalaryCaptionLbl: label 'Net Salary';
        Qualification_as_per_SalaryCaptionLbl: label 'Qualification as per Salary';
        V1_3_of_Gross_PayCaptionLbl: label '1/3 of Gross Pay';
        Amount_GuaranteedCaptionLbl: label 'Amount Guaranteed';
        Loan_GuarantorsCaptionLbl: label 'Loan Guarantors';
        RatioCaptionLbl: label 'Ratio';
        Total_Amount_GuaranteedCaptionLbl: label 'Total Amount Guaranteed';
        Total_TopupsCaptionLbl: label 'Total Topups';
        Bridged_LoansCaptionLbl: label 'Bridged Loans';
        Loan_No_CaptionLbl: label 'Loan No.';
        Principal_Top_UpCaptionLbl: label 'Principal Top Up';
        Client_CodeCaptionLbl: label 'Client Code';
        Loan_TypeCaption_Control1102755059Lbl: label 'Loan Type';
        TotalsCaptionLbl: label 'Totals';
        Total_Amount_BridgedCaptionLbl: label 'Total Amount Bridged';
        Bridging_total_higher_than_the_qualifing_amountCaptionLbl: label 'Bridging total higher than the qualifing amount';
        WARNING_Caption_Control1102755044Lbl: label 'WARNING:';
        TotalLoanBalance: Decimal;
        TGAmount: Decimal;
        NetSalary: Decimal;
        Riskamount: Decimal;
        WarnBridged: Text;
        WarnSalary: Text;
        WarnDeposits: Text;
        WarnGuarantor: Text;
        WarnShare: Text;
        RiskGshares: Decimal;
        RiskDeposits: Decimal;
        BasicEarnings: Decimal;
        DepX: Decimal;
        LoanPrincipal: Decimal;
        loanInterest: Decimal;
        AmountGuaranteed: Decimal;
        StatDeductions: Decimal;
        GuarOutstanding: Decimal;
        TwoThirds: Decimal;
        Bridged_AmountCaption: Integer;
        LNumber: Code[20];
        TotalLoanDeductions: Decimal;
        TotalRepayments: Decimal;
        Totalinterest: Decimal;
        Band: Decimal;
        TotalOutstanding: Decimal;
        BANDING: Record "Deposit Tier Setup";
        NtTakeHome: Decimal;
        ATHIRD: Decimal;
        Psalary: Decimal;
        LoanApss: Record "Loans Register";
        TotalLoanBal: Decimal;
        TotalBand: Decimal;
        LoanAp: Record "Loans Register";
        TotalRepay: Decimal;
        TotalInt: Decimal;
        LastFieldNo: Integer;
        TotLoans: Decimal;
        JazaLevy: Decimal;
        BridgeLevy: Decimal;
        Upfronts: Decimal;
        Netdisbursed: Decimal;
        TotalLRepayments: Decimal;
        BridgedRepayment: Decimal;
        OutstandingLrepay: Decimal;
        Loantop: Record "Loan Offset Details";
        BRIGEDAMOUNT: Decimal;
        TOTALBRIGEDAMOUNT: Decimal;
        FinalInst: Decimal;
        NonRec: Decimal;
        OTHERDEDUCTIONS: Decimal;
        StartDate: Date;
        DateFilter: Text[100];
        FromDate: Date;
        ToDate: Date;
        FromDateS: Text[100];
        ToDateS: Text[100];
        DivTotal: Decimal;
        CDeposits: Decimal;
        CustDiv: Record Customer;
        DivProg: Record "Dividends Progression";
        CDiv: Decimal;
        BDate: Date;
        CustR: Record Customer;
        BasicPay: Decimal;
        HouseAllowance: Decimal;
        TransportAll: Decimal;
        MedicalAll: Decimal;
        OtherIncomes: Decimal;
        GrossP: Decimal;
        MonthlyCont: Decimal;
        NHIF: Decimal;
        PAYE: Decimal;
        Risk: Decimal;
        LifeInsurance: Decimal;
        OtherLiabilities: Decimal;
        SaccoDed: Decimal;
        ProductCharges: Record "Loan Product Charges";
        LoanInsurance: Decimal;
        CustLeg: Record "Cust. Ledger Entry";
        BoostedAmount2: Decimal;
        ShareBoostComm: Decimal;
        currentshare: Decimal;
        SMSFEE: Decimal;
        HisaARREAR: Decimal;
        ShareBoostCommHISA: Decimal;
        BoostedAmountHISA: Decimal;
        Loans: Record "Loans Register";
        ShareBoostCommHISAFOSA: Decimal;
        LoanTransferFee: Decimal;
        RemainingDays: Integer;
        IARR: Decimal;
        TotalBridgeAmount: Decimal;
        LoanCashClearedFee: Decimal;
        Collateral: Record "Loan Collateral Details";
        CollateralAmount: Decimal;
        ShareCap: Decimal;
        LPFcharge: Decimal;
        LAppraisalFee: Decimal;
        LAppraisalFeeAccount: Code[20];
        TscInt: Decimal;
        AccruedInt: Decimal;
        ProcessingFee: Decimal;
        LoanFormFee: Decimal;
        SaccoInt: Decimal;
        ArmotizationFactor: Decimal;
        ArmotizationFInstalment: Decimal;
        SaccoIntRelief: Decimal;
        SuperLoanBal: Decimal;
        QualifyingDep: Decimal;
        RemainigDep: Decimal;
        PrincipalAmountGlobal: Decimal;
        TotalGuaranteed: Decimal;
        SFactory: Codeunit "SURESTEP Factory";
        ExciseDutyShareBoostComm: Decimal;
        ObjSecurities: Record "Loan Collateral Details";
        ObjProductCharge: Record "Loan Product Charges";

        LInsurance: Decimal;
        DepositsMultiplier: Decimal;
        ObjLoans: Record "Loans Register";
        VarTotalCollateralValue: Decimal;
        VarTotalLoansnotSecuredbyCollateral: Decimal;
        EmergencyUpfront: Decimal;
        interestUpfront: Decimal;
        repayAmount: Decimal;
        Multiplier: Decimal;
        bLaBalance: Decimal;
        CICInsurance: Decimal;
        LoanProductCharges: Record "Loan Product Charges";
        Formula: Decimal;
        ObjCust: Record Customer;

    local procedure FnDepositsAnalysis()
    begin
        if Cust.Get("Loans Register"."Client Code") then begin
            Cust.CalcFields("Current Shares", "Shares Retained");
            Cshares := Cust."Current Shares";
            ShareCap := Cust."Shares Retained";
        end;
    end;

    local procedure FnCheckQualificationAsPerDeposits()
    begin
        LOANBALANCE := 0;
        TotalRepayments := 0;
        BRIGEDAMOUNT := 0;
        TotalBridgeAmount := 0;
        GenSetUp.Get();
        Multiplier := 0;
        if LoanType.Get("Loans Register"."Loan Product Type") then
            //MESSAGE('%1|%2',LoanType."Deposits Multiplier",LoanType.Code);
            if ("Loans Register"."Loan Product Type" <> 'L18B') or ("Loans Register"."Loan Product Type" <> 'L08B') then begin
                if ObjCust.Get("Loans Register"."Client Code") then begin
                    ObjCust.CalcFields(ObjCust."Current Shares");
                    if (ObjCust."Current Shares" < 0) then begin
                        DEpMultiplier := LoanType."Deposits Multiplier" * (ObjCust."Current Shares");//"Loans Register"."Boosted Amount"+
                        Multiplier := LoanType."Deposits Multiplier";
                    end else begin
                        DEpMultiplier := LoanType."Deposits Multiplier" * (ObjCust."Current Shares") + "Loans Register"."Boosted Amount" * GenSetUp."Deposits Multiplier";//"Loans Register"."Boosted Amount"+
                        Multiplier := LoanType."Deposits Multiplier";
                    end;
                end;
            end else
                if ("Loans Register".Savings + "Loans Register"."Boosted Amount") < 0 then
                    DEpMultiplier := 0;
        if LoanType.Get("Loans Register"."Loan Product Type") then begin

            //************Find Loan Balances BOSA********************//
            LoanApp.Reset;
            LoanApp.SetRange(LoanApp."Client Code", "Loans Register"."Client Code");
            //LoanApp.SETRANGE(LoanApp.Source,LoanApp.Source::BOSA);
            LoanApp.SetRange(LoanApp.Posted, true);
            if LoanApp.Find('-') then begin
                LoanApp.CalcFields(LoanApp."Outstanding Balance", LoanApp."Outstanding Balance");
                /*REPEAT
                   LoanApp.CALCFIELDS(LoanApp."Outstanding Balance",LoanApp."Outstanding Balance Bosa");
                   IF LoanApp."Outstanding Balance">0 THEN
                     BEGIN
                       //LOANBALANCE:=LOANBALANCE+LoanApp."Outstanding Balance Bosa";
                       TotalRepayments:=TotalRepayments+LoanApp.Repayment;
                   END;

               UNTIL LoanApp.NEXT=0;*/
                if LoanApp.Source = LoanApp.Source::BOSA then begin
                    LOANBALANCE := LoanApp."Outstanding Balance";
                end else
                    if LoanApp.Source = LoanApp.Source::FOSA then begin
                        LOANBALANCE := LoanApp."Outstanding Balance";
                    end;
            end;

            LoanTopUp.Reset;
            LoanTopUp.SetRange(LoanTopUp."Loan No.", "Loans Register"."Loan  No.");
            LoanTopUp.SetRange(LoanTopUp."Client Code", "Loans Register"."Client Code");
            if LoanTopUp.Find('-') then begin
                repeat
                    BRIGEDAMOUNT := BRIGEDAMOUNT + LoanTopUp."Principle Top Up";
                    //BridgedRepayment:=BridgedRepayment+LoanTopUp."Monthly Repayment";
                    //TotalBridgeAmount:=TotalBridgeAmount+LoanTopUp."Total Top Up";
                    FinalInst := FinalInst + LoanTopUp."Finale Instalment";
                until LoanTopUp.Next = 0;
            end;
            LOANBALANCE := LOANBALANCE - BRIGEDAMOUNT;
            //MESSAGE('LOANBALANCE %1 ',LOANBALANCE);
        end;
        TotalLoanBal := LBalance;
        DepX := (DEpMultiplier + "Loans Register"."Boosted Amount") - LOANBALANCE;
        Message('Deps %1 Loan Balance %2 Net Loans %3 Diff %4 current shares%5', DEpMultiplier, LOANBALANCE, TotalLoanBal, DepX, "Loans Register".Savings);

    end;

    local procedure FnCheckQualificationAsPerSalary()
    begin
        salary := ("Loans Register"."Gross Pay" - "Loans Register"."Total Deductions") - ("Loans Register"."Basic Pay H" / 3);

        //("Loans Register"."Gross Pay"-"Loans Register"."Basic Pay H")-"Loans Register"."Total Deductions";
        /*("Loans Register"."Gross Pay"-("Loans Register"."Total DeductionsH"+"Loans Register"."Gross Pay"/3))+
                  ("Loans Register"."Non Payroll Payments"+"Loans Register"."Bridge Amount Release");*/
        //Psalary:=("Loans Register"."Net Utilizable Amount"*100*"Loans Register".Installments)/(100+"Loans Register".Installments);
        //MESSAGE('Utilizable=%1 , Installments=%2, Interest=%3',"Loans Register"."Net Utilizable Amount","Loans Register".Installments,"Loans Register".Interest);
        "Loans Register"."Net Utilizable Amount" := salary;
        "Loans Register".Modify;
        //Psalary:="Loans Register"."Net Utilizable Amount"/((1/"Loans Register".Installments)+("Loans Register".Interest/1200));


        Psalary := salary / ((1 / "Loans Register".Installments) + ("Loans Register".Interest / 1200));

        if "Loans Register"."Repayment Method" = "Loans Register"."repayment method"::Amortised then begin
            Formula := Power(1 + ("Loans Register".Interest / 1200), -1 * "Loans Register".Installments);
            Formula := 1 - Formula;
            Formula := Formula / ("Loans Register".Interest / 1200);
            Psalary := salary * Formula;
        end;

    end;

    local procedure FnCheckQualificationAsPerGuarantors()
    begin
        LoanG.Reset;
        LoanG.SetRange(LoanG."Loan No", "Loans Register"."Loan  No.");
        if LoanG.Find('-') then begin
            repeat
                GShares := GShares + LoanG."Amont Guaranteed";
            until LoanG.Next = 0
        end;
        TotalGuaranteed := GShares;
    end;

    local procedure FnCheckQualificationAsPerSecurities()
    begin
        VarTotalCollateralValue := 0;
        ObjLoans.CalcFields(ObjLoans."Outstanding Balance");

        //Get Member Collateral Value===========================================
        ObjLoans.Reset;
        ObjLoans.SetRange(ObjLoans."Client Code", "Loans Register"."Client Code");
        ObjLoans.SetFilter(ObjLoans."Outstanding Balance", '>%1', 0);
        if ObjLoans.FindSet then begin
            repeat
                ObjLoans.CalcFields(ObjLoans."Outstanding Balance");
                ObjSecurities.Reset;
                ObjSecurities.SetRange(ObjSecurities."Loan No", ObjLoans."Loan  No.");
                ObjSecurities.SetFilter(ObjSecurities."Guarantee Value", '<%1', ObjLoans."Outstanding Balance");
                if ObjSecurities.FindSet then begin
                    VarTotalCollateralValue := VarTotalCollateralValue + (ObjLoans."Outstanding Balance" - ObjSecurities."Guarantee Value");
                end;
            until ObjLoans.Next = 0;
        end;
        //End Get Member Collateral Value=======================================

        VarTotalLoansnotSecuredbyCollateral := 0;
        ObjLoans.CalcFields(ObjLoans."Outstanding Balance");
        //Get Loans not Secured by Collateral===========================================
        ObjLoans.Reset;
        ObjLoans.SetRange(ObjLoans."Client Code", "Loans Register"."Client Code");
        ObjLoans.SetFilter(ObjLoans."Outstanding Balance", '>%1', 0);
        if ObjLoans.FindSet then begin
            repeat
                ObjSecurities.Reset;
                ObjSecurities.SetRange(ObjSecurities."Loan No", ObjLoans."Loan  No.");
                if ObjSecurities.Find('-') = false then begin
                    VarTotalLoansnotSecuredbyCollateral := VarTotalLoansnotSecuredbyCollateral + ObjLoans."Outstanding Balance";
                end;
            until ObjLoans.Next = 0;
        end;
        DepX := (DepX - ((VarTotalLoansnotSecuredbyCollateral + VarTotalCollateralValue)));//-BRIDGEBAL);
    end;

    local procedure FnCheckQualificationAsPerDividends()
    begin
    end;

    local procedure FnGetShareBoosting()
    begin
        /*
           Cust.RESET;
           Cust.SETRANGE(Cust."No.","Loans Register"."Client Code");
           IF Cust.FIND('-') THEN BEGIN
              "Loans Register"."Employer Code":=Cust."Employer Code";
              "Loans Register".MODIFY;

              //Cust.TESTFIELD(Cust."Monthly Contribution");
              GenSetUp.GET();

              CustLeg.RESET;
              CustLeg.SETRANGE(CustLeg."Customer No.","Loans Register"."Client Code");
              CustLeg.SETRANGE(CustLeg."Journal Batch Name",'FTRANS');
              CustLeg.SETRANGE(CustLeg."No Boosting",FALSE);
              CustLeg.SETRANGE(CustLeg."Transaction Type",CustLeg."Transaction Type"::"Deposit Contribution");
              IF CustLeg.FINDSET THEN BEGIN
                     IF CustLeg."No Boosting"=FALSE THEN BEGIN //>
                         REPEAT
                         IF CustLeg."Posting Date" > CALCDATE(GenSetUp."Boosting Shares Maturity (M)",TODAY) THEN BEGIN

                             IF ((CustLeg."Credit Amount")>Cust."Monthly Contribution") THEN BEGIN
                                 BoostedAmount2:=BoostedAmount2+(ABS(CustLeg."Credit Amount"))
                             END;
                         END;
                         UNTIL CustLeg.NEXT=0;
               IF BoostedAmount2>("Loans Register"."Member Deposits"/2) THEN BEGIN
                 BoostedAmount2:=BoostedAmount2
                 END ELSE
                 BoostedAmount2:=0;
             END;
       END;
       END;
       */

        ShareBoostComm := (GenSetUp."Boosting Shares %" / 100) * BoostedAmount2;
        if "Loans Register"."Boosting Commision" > 0 then begin
            ExciseDutyShareBoostComm := "Loans Register"."Boosting Commision" * (GenSetUp."Excise Duty(%)" / 100);
        end;
        //MESSAGE('#Chargable Share Boosted Amount=%1, #Share Boosting Comission=%2, #Excise on Boosting Comission=%3',BoostedAmount2,ShareBoostComm,ExciseDutyShareBoostComm);

        "Loans Register"."Share Boosting Comission" := ShareBoostComm;
        //

    end;

    local procedure FnGetLoanApplicationCharges()
    begin
        GenSetUp.Get();
        if LoanType.Get("Loans Register"."Loan Product Type") then begin
            BridgeLevy := ROUND(LoanApp."Offset Commission", 1, '>');
            //Confirm if there is condition for Levy on Top up
            //POPULATE ALL CHARGES & GLs FROM PRODUCT SETUPS---------------------------------------------------------------------------------//
            LoanInsurance := 0;
            LAppraisalFee := 0;
            LoanTransferFee := 0;
            LoanInsurance := SFactory.FnGetChargeFee("Loans Register"."Loan Product Type", "Loans Register"."Approved Amount", 'CRB');
            ProcessingFee := SFactory.FnGetChargeFee("Loans Register"."Loan Product Type", "Loans Register"."Approved Amount", 'LPF');
            LoanFormFee := SFactory.FnGetChargeFee("Loans Register"."Loan Product Type", "Loans Register"."Approved Amount", 'FACI');
            LAppraisalFee := SFactory.FnGetChargeFee("Loans Register"."Loan Product Type", "Loans Register"."Approved Amount", 'LAF');
            EmergencyUpfront := SFactory.FnGetChargeFee("Loans Register"."Loan Product Type", "Loans Register"."Approved Amount", 'INT');

            LoanProductCharges.Reset;
            LoanProductCharges.SetRange("Product Code", "Loans Register"."Loan Product Type");
            LoanProductCharges.SetRange("Loan Charge Type", LoanProductCharges."loan charge type"::"Loan Insurance");
            if LoanProductCharges.FindFirst then begin
                CICInsurance := 0.001 * "Loans Register".Installments * "Loans Register"."Approved Amount";
            end;

            ///SFactory.FnGetChargeFee("Loans Register"."Loan Product Type","Loans Register"."Approved Amount",'LIS');
            // FACI
            LoanTransferFee := SFactory.FnGetTransferFee("Loans Register"."Mode of Disbursement");
            BridgeLevy := ROUND("Loans Register"."Offset Commission", 1, '>');
            SMSFEE := GenSetUp."SMS Fee Amount";
            Upfronts := LoanInsurance + CICInsurance + EmergencyUpfront + ProcessingFee + LoanFormFee + LAppraisalFee + LoanTransferFee + BridgeLevy + ShareBoostComm + ExciseDutyShareBoostComm + "Loans Register"."Boosted Amount" +
            "Loans Register"."Boosted Amount Interest" + "Loans Register"."Boosting Commision" + TotalBridgeAmount;

            //END------------------------------------------------------------------------------------------------------------//
            //"Loans Register".CalcFields("Loans Register"."Top Up Amount");
            "Loans Register"."Loan SMS Fee" := SMSFEE;
            "Loans Register".Modify;
            Netdisbursed := "Loans Register"."Approved Amount" - Upfronts - "Loans Register"."Total Offset Amount" - "Loans Register"."Offset Commission" - "Loans Register"."Offset iNTEREST";
        end;
        "Loans Register"."Capitalized Charges" := TscInt + LAppraisalFee + AccruedInt + SaccoInt;
        "Loans Register"."Loan Disbursed Amount" := Netdisbursed - "Loans Register"."Total Offset Amount";

        "Loans Register".Upfronts := Upfronts;
        "Loans Register"."Total Offset Amount" := TotalBridgeAmount;
        "Loans Register".Modify;
        //MESSAGE(FORMAT(LoanTransferFee));
    end;

    local procedure FnReccommendAmount(RequestedAmount: Decimal; QShares: Decimal; QGuarantors: Decimal; QSalary: Decimal) RecommendedAmount: Decimal
    begin
        RecommendedAmount := RequestedAmount;
        if LoanType.Get("Loans Register"."Loan Product Type") then begin
            if LoanType."Appraise Deposits" then begin
                if RecommendedAmount > QShares then
                    RecommendedAmount := QShares;
            end;

            if LoanType."Appraise Guarantors" then begin
                if RecommendedAmount > QGuarantors then
                    RecommendedAmount := QGuarantors;
            end;

            if LoanType."Appraise Salary" then begin
                if RecommendedAmount > QSalary then
                    RecommendedAmount := QSalary;
            end;

            if ((LoanType."Appraise Deposits") and (LoanType."Appraise Guarantors")) then begin
                if RecommendedAmount > QShares then
                    RecommendedAmount := QShares;
                if RecommendedAmount > QGuarantors then
                    RecommendedAmount := QGuarantors;
            end;

            if ((LoanType."Appraise Deposits") and (LoanType."Appraise Salary")) then begin
                if RecommendedAmount > QSalary then
                    RecommendedAmount := QSalary;
                if RecommendedAmount > QShares then
                    RecommendedAmount := QShares;
            end;

            if ((LoanType."Appraise Guarantors") and (LoanType."Appraise Salary")) then begin
                if RecommendedAmount > QSalary then
                    RecommendedAmount := QSalary;
                if RecommendedAmount > QGuarantors then
                    RecommendedAmount := QGuarantors;
                Message('RecommendedAmount%1', RecommendedAmount);
            end;

            if ((LoanType."Appraise Guarantors") and (LoanType."Appraise Salary") and (LoanType."Appraise Deposits")) then begin
                if RecommendedAmount > QSalary then
                    RecommendedAmount := QSalary;
                if RecommendedAmount > QShares then
                    RecommendedAmount := QShares;
                if RecommendedAmount > QGuarantors then
                    RecommendedAmount := QGuarantors;
            end;
        end;
        if RecommendedAmount > RequestedAmount then
            RecommendedAmount := RequestedAmount;

        if RecommendedAmount < 0 then
            RecommendedAmount := 0;
        exit(RecommendedAmount);
    end;

    local procedure FnRecommendShareBooster(TotalDeposits: Decimal; RequestedAmount: Decimal): Decimal
    begin
        exit(RequestedAmount - TotalDeposits);
    end;

    local procedure FnReturnRetirementDate(MemberNo: Code[50]): Date
    var
        ObjMembers: Record Customer;
    begin
        GenSetUp.Get();
        ObjMembers.Reset;
        ObjMembers.SetRange(ObjMembers."No.", MemberNo);
        if ObjMembers.Find('-') then
            exit(CalcDate(GenSetUp."Retirement Age", ObjMembers."Date of Birth"));
    end;

    local procedure FnWarningMessages()
    begin
        if Netdisbursed < 0 then
            Message('Net Disbursed cannot be 0 or Negative');

        if MAXAvailable < 0 then
            WarnDeposits := UpperCase('WARNING: Insufficient Deposits to cover the loan applied: Risk %1')
        else
            WarnDeposits := '';

        if MAXAvailable < 0 then
            RiskDeposits := "Loans Register"."Requested Amount" - MAXAvailable;

        if Msalary < "Loans Register"."Requested Amount" then
            WarnSalary := UpperCase('WARNING: Salary is Insufficient to cover the loan applied: Risk')
        else
            WarnSalary := '';

        if Msalary < "Loans Register"."Requested Amount" then
            Riskamount := "Loans Register"."Requested Amount" - Msalary;

        if GShares < "Loans Register"."Requested Amount" then
            WarnGuarantor := UpperCase('WARNING: Guarantors do not sufficiently cover the loan: Risk')
        else
            WarnGuarantor := '';

        if GShares < "Loans Register"."Requested Amount" then
            RiskGshares := "Loans Register"."Requested Amount" - GShares;
        //MESSAGE('WARNING: Insufficient Deposits to cover the loan applied: Risk %1',Riskamount)
        //
        /*IF ("Loans Register"."Expected Date of Completion" > FnReturnRetirementDate("Loans Register"."Client Code")) THEN
          MESSAGE('The Member retirement date will come earlier than the Expected Date of Completion (%1).The Member is due to retire on %2: Risk',"Loans Register"."Expected Date of Completion",FnReturnRetirementDate("Loans Register"."Client Code"));
        */

    end;

    local procedure FnEditRepaymentPrincipleAndInterestAmounts()
    begin
        TotalMRepay := 0;
        LPrincipal := 0;
        LInterest := 0;
        InterestRate := "Loans Register".Interest;
        LoanAmount := "Loans Register"."Approved Amount";
        RepayPeriod := "Loans Register".Installments;
        LBalance := "Loans Register"."Approved Amount";


        if "Loans Register"."Repayment Method" = "Loans Register"."repayment method"::"Straight Line" then begin
            "Loans Register".TestField(Installments);
            LPrincipal := ROUND(LoanAmount / RepayPeriod, 1, '>');
            LInterest := ROUND(((InterestRate / 100) * LoanAmount) / "Loans Register".Installments, 1, '>');
            "Loans Register"."Loan Principle Repayment" := LPrincipal;
            "Loans Register"."Loan Interest Repayment" := LInterest;
            "Loans Register".Repayment := LPrincipal + LInterest;
            if LoanType.Get("Loans Register"."Loan Product Type") then begin
                if "Loans Register"."Loan Product Type" = 'EMERGENCY 6' then
                    "Loans Register".Repayment := LPrincipal;

                "Loans Register".Modify;
            end;
        end;
        //Monthly Interest Formula PR(T+1)/200T
        if "Loans Register"."Repayment Method" = "Loans Register"."repayment method"::"Reducing Balance" then begin
            "Loans Register".TestField(Interest);
            "Loans Register".TestField(Installments);
            LPrincipal := ROUND(LoanAmount / RepayPeriod, 1, '>');
            LInterest := ROUND(Recomm * "Loans Register".Interest / 1200, 1, '>');
            //LInterest:=ROUND(Recomm*"Loans Register".Interest/12*(RepayPeriod+1)/(200*RepayPeriod),1,'>');//ROUND((InterestRate/12/100)*LBalance,0.05,'>');
            //MESSAGE('Monthly Interest Repayment=%1, Monthly Principal Repayment=%2, ****Total Monthly Repayment=%3***',LInterest,LPrincipal,LPrincipal+LInterest);
            "Loans Register".Repayment := LPrincipal + LInterest;
            "Loans Register"."Loan Principle Repayment" := LPrincipal;
            "Loans Register"."Loan Interest Repayment" := LInterest;
            "Loans Register".Modify;
        end;


        if "Loans Register"."Repayment Method" = "Loans Register"."repayment method"::Amortised then begin
            /*TotalMRepay:=ROUND((InterestRate/12/100) / (1 - POWER((1 + (InterestRate/12/100)),- RepayPeriod)) * LoanAmount,1,'>');
            LInterest:=ROUND(LBalance / 100 / 12 * InterestRate,0.05,'>');
            LPrincipal:=TotalMRepay-LInterest;
            "Loans Register"."Loan Principle Repayment":=LPrincipal;
            "Loans Register"."Loan Interest Repayment":=LInterest;
            "Loans Register"."Approved Repayment":=TotalMRepay;*/

            LInterest := ROUND(((((ROUND((InterestRate / 12), 0.01, '>') * RepayPeriod) + ROUND((InterestRate / 12), 0.01, '>')) * LoanAmount) / 200) / RepayPeriod, 0.01, '=');
            LPrincipal := ROUND(LoanAmount / RepayPeriod, 0.01, '=');
            TotalMRepay := LPrincipal + LInterest;
            "Loans Register"."Loan Principle Repayment" := LPrincipal;
            "Loans Register"."Loan Interest Repayment" := LInterest;
            "Loans Register"."Approved Repayment" := TotalMRepay;
            "Loans Register".Repayment := TotalMRepay;


            ObjProductCharge.Reset;
            ObjProductCharge.SetRange(ObjProductCharge."Product Code", "Loans Register"."Loan Product Type");
            ObjProductCharge.SetRange(ObjProductCharge."Loan Charge Type", ObjProductCharge."loan charge type"::"Loan Insurance");
            if ObjProductCharge.FindSet then begin
                LInsurance := "Loans Register"."Approved Amount" * (ObjProductCharge.Percentage / 100);
            end;


            "Loans Register".Repayment := LPrincipal + LInterest + LInsurance;
            "Loans Register".Modify;
        end;

    end;
}

