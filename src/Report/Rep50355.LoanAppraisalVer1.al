#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Report 50355 "Loan Appraisal Ver1"
{
    RDLCLayout = 'Layouts/LoanAppraisalVer1.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Loans Register"; "Loans Register")
        {
            DataItemTableView = sorting("Loan  No.");
            RequestFilterFields = "Loan  No.";
            column(UserId; UserId)
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(CompanyInfo_Address; ObjCompanyInfo.Address)
            {
            }
            column(CompanyInfo__Phone_No__; ObjCompanyInfo."Phone No.")
            {
            }
            column(CompanyInfo__E_Mail_; ObjCompanyInfo."E-Mail")
            {
            }
            column(CompanyInfo_City; ObjCompanyInfo.City)
            {
            }
            column(CurrentShares_LoansRegister; "Loans Register"."Current Shares")
            {
            }
            column(CompanyInfo_Picture; ObjCompanyInfo.Picture)
            {
            }
            column(Loans__Application_Date_; "Loans Register"."Application Date")
            {
            }
            column(Psalary; VarPsalary)
            {
            }
            column(JazaDeposits; "Loans Register"."Jaza Deposits")
            {
            }
            column(DepositReinstatement; "Loans Register"."Deposit Reinstatement")
            {
            }
            column(LoanDepositMultiplier; "Loans Register"."Loan Deposit Multiplier")
            {
            }
            column(LoanProcessingFee; VarLPFcharge)
            {
            }
            column(TscInt; VarTscInt)
            {
            }
            column(AccruedInt; VarAccruedInt)
            {
            }
            column(ProcessingFee; VarAplicationFee)
            {
            }
            column(LoanFormFee; VarLoanFormFee)
            {
            }
            column(LAppraisalFee; VarLAppraisalFee)
            {
            }
            column(SharesBalance_LoansRegister; "Loans Register"."Shares Balance")
            {
            }
            column(VarLoanInsurance; VarLoanInsurance)
            {
            }
            column(DepositMultiplier; (VarDepMultiplier - VarLBalance))
            {
            }
            column(SaccoInt; VarSaccoInt)
            {
            }
            column(TotalLoanBal; VarTotalLoanBal)
            {
            }
            column(Upfronts; VarUpfronts)
            {
            }
            column(ShareBoostComm; VarShareBoostComm)
            {
            }
            column(ExciseDutyShareBoostComm; VarExciseDutyShareBoostComm)
            {
            }
            column(Netdisbursed; VarNetdisbursed)
            {
            }
            column(StatDeductions; VarStatDeductions)
            {
            }
            column(TotLoans; VarTotLoans)
            {
            }
            column(ClientName_LoansRegister; "Loans Register"."Client Name")
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
            column(Loans__Loan__No__; "Loans Register"."Loan  No.")
            {
            }
            column(Loans__Loan_Product_Type_; "Loans Register"."Loan Product Type")
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
            column(Cust_Name; ObjCust.Name)
            {
            }
            column(Loans__Requested_Amount_; "Loans Register"."Requested Amount")
            {
            }
            column(Loans__Staff_No_; "Loans Register"."Staff No")
            {
            }
            column(NetSalary; VarNetSalary)
            {
            }
            column(CollateralAmount; VarCollateralAmount)
            {
            }
            column(Approved_Amounts; "Loans Register"."Approved Amount")
            {
            }
            column(Reccom_Amount; VarRecomm)
            {
            }
            column(LOANBALANCE; VarLoanBalance)
            {
            }
            column(Loans_Installments; "Loans Register".Installments)
            {
            }
            column(Loans__No__Of_Guarantors_; "Loans Register"."No. Of Guarantors")
            {
            }
            column(TotalBridgeAmount; VarTotalBridgeAmount)
            {
            }
            column(Cshares_3; VarCshares * 3)
            {
            }
            column(Cshares_3__LOANBALANCE_BRIDGEBAL_LOANBALANCEFOSASEC; (VarCshares * 3) - VarLoanBalance + VarBridgeBal - VarLoanBalanceFosaSec)
            {
            }
            column(Cshares; VarCshares)
            {
            }
            column(LOANBALANCE_BRIDGEBAL; VarTotalLoanBal - VarBridgeBal)
            {
            }
            column(Loans__Transport_Allowance_; "Loans Register"."Transport Allowance")
            {
            }
            column(Loans__Employer_Code_; "Loans Register"."Employer Code")
            {
            }
            column(Loans__Loan_Product_Type_Name_; "Loans Register"."Loan Product Type Name")
            {
            }
            column(Loans__Loan__No___Control1102760138; "Loans Register"."Loan  No.")
            {
            }
            column(Loans__Application_Date__Control1102760139; "Loans Register"."Application Date")
            {
            }
            column(Loans__Loan_Product_Type__Control1102760140; "Loans Register"."Loan Product Type")
            {
            }
            column(Loans_Loans__Client_Code__Control1102760141; "Loans Register"."Client Code")
            {
            }
            column(Cust_Name_Control1102760142; ObjCust.Name)
            {
            }
            column(Loans__Staff_No__Control1102760144; "Loans Register"."Staff No")
            {
            }
            column(Loans_Installments_Control1102760145; "Loans Register".Installments)
            {
            }
            column(Loans__No__Of_Guarantors__Control1102760146; "Loans Register"."No. Of Guarantors")
            {
            }
            column(Loans__Requested_Amount__Control1102760143; "Loans Register"."Requested Amount")
            {
            }
            column(Loans_Repayment; "Loans Register".Repayment)
            {
            }
            column(Loans__Employer_Code__Control1102755075; "Loans Register"."Employer Code")
            {
            }
            column(MAXAvailable; VarMAXAvailable)
            {
            }
            column(Cshares_Control1102760156; VarCshares)
            {
            }
            column(BRIDGEBAL; VarBridgeBal)
            {
            }
            column(LOANBALANCE_BRIDGEBAL_Control1102755006; VarLoanBalance - VarBridgeBal)
            {
            }
            column(DEpMultiplier; VarDepMultiplier)
            {
            }
            column(DefaultInfo; VarDefaultInfo)
            {
            }
            column(RecomRemark; VarRecomRemark)
            {
            }
            column(Recomm; VarRecomm)
            {
            }
            column(BasicEarnings; VarBasicEarnings)
            {
            }
            column(GShares; VarGShares)
            {
            }
            column(GShares_TGuaranteedAmount; VarGShares - VarTGuaranteedAmount)
            {
            }
            column(Msalary; VarMsalary)
            {
            }
            column(MAXAvailable_Control1102755031; VarMAXAvailable)
            {
            }
            column(Recomm_TOTALBRIDGED; VarRecomm - VarTotalBridged)
            {
            }
            column(GuarantorQualification; VarGuarantorQualification)
            {
            }
            column(Requested_Amount__MAXAvailable; "Requested Amount" - VarMAXAvailable)
            {
            }
            column(Requested_Amount__Msalary; "Requested Amount" - VarMsalary)
            {
            }
            column(Requested_Amount__GShares; "Requested Amount" - VarGShares)
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
            column(DepX; VarDepX)
            {
            }
            column(TwoThird; VarTwoThirds)
            {
            }
            column(LPrincipal; VarLPrincipal)
            {
            }
            column(LInterest; VarLInterest)
            {
            }
            column(LNumber; VarLNumber)
            {
            }
            column(TotalLoanDeductions; VarTotalLoanDeductions)
            {
            }
            column(MinDepositAsPerTier_Loans; "Loans Register"."Min Deposit As Per Tier")
            {
            }
            column(TotalRepayments; VarTotalRepayments)
            {
            }
            column(Totalinterest; VarTotalinterest)
            {
            }
            column(Band; VarBand)
            {
            }
            column(NtTakeHome; VarNtTakeHome)
            {
            }
            column(ATHIRD; VarAthird)
            {
            }
            column(BridgedRepayment; VarBridgedRepayment)
            {
            }
            column(BRIGEDAMOUNT; VarBridgedAmount)
            {
            }
            column(BasicPay; VarBasicPay)
            {
            }
            column(HouseAllowance; VarHouseAllowance)
            {
            }
            column(TransportAll; VarTransportAll)
            {
            }
            column(MedicalAll; VarMedicalAll)
            {
            }
            column(OtherIncomes; VarOtherIncomes)
            {
            }
            column(GrossP; VarGrossP)
            {
            }
            column(NETTAKEHOME; VarNettakehome)
            {
            }
            column(MonthlyCont; VarMonthlyCont)
            {
            }
            column(NHIF; "Loans Register".NHIF)
            {
            }
            column(PAYE; "Loans Register".PAYE)
            {
            }
            column(Risk; VarRisk)
            {
            }
            column(LifeInsurance; VarLifeInsurance)
            {
            }
            column(OtherLiabilities; VarOtherLiabilities)
            {
            }
            column(SaccoDed; VarSaccoDed)
            {
            }
            column(LoanInsurance; VarLoanInsurance)
            {
            }
            column(SMSFEE; VarSMSFee)
            {
            }
            column(LPFcharge; VarLPFcharge)
            {
            }
            column(HisaARREAR; VarHisaARREAR)
            {
            }
            column(ShareBoostCommHISA; VarShareBoostCommHISA)
            {
            }
            column(BoostedAmountHISA; VarBoostedAmountHISA)
            {
            }
            column(ShareBoostCommHISAFOSA; VarShareBoostCommHISAFOSA)
            {
            }
            column(LoanTransferFee; VarLoanTransferFee)
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
            column(PrincipalAmountGlobal; VarPrincipalAmountGlobal)
            {
            }
            column(BoostedAmount_LoansRegister; "Loans Register"."Boosted Amount")
            {
            }
            column(BoostedAmountInterest_LoansRegister; "Loans Register"."Boosted Amount Interest")
            {
            }
            column(Remarks_LoansRegister; "Loans Register".Remarks)
            {
            }
            column(StaffNo; Memba."Payroll No")
            {
            }
            dataitem("Loans Guarantee Details"; "Loans Guarantee Details")
            {
                DataItemLink = "Loan No" = field("Loan  No.");
                // //orNavId_5140; 5140) { } // Autogenerated by ForNav - Do not delete
                column(Amont_Guarant; "Loans Guarantee Details"."Loan No")
                {
                }
                column(Name; "Loans Guarantee Details".Name)
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
                column(Loan_Guarant; "Loans Guarantee Details"."Loan No")
                {
                }
                column(Shares_LoansGuaranteeDetails; "Loans Guarantee Details".Shares)
                {
                }
                column(LoanBalance_LoansGuaranteeDetails; "Loans Guarantee Details"."Loan Balance")
                {
                }
                column(Guarantor_Outstanding; "Loans Guarantee Details"."Guarantor Outstanding")
                {
                }
                column(Employer_code; "Loans Guarantee Details"."Employer Code")
                {
                }
                column(VarGuaranteedAmount; VarGuaranteedAmount)
                {
                }
                column(VarCollateralSecurity; VarCollateralSecurity)
                {
                }
                column(VarLoanRisk; VarLoanRisk)
                {
                }
                column(VarTotalArrears; VarTotalArrears)
                {
                }
                column(GShares_TGuaranteedAmount2; VarGShares - VarTGuaranteedAmount)
                {
                }
                trigger OnAfterGetRecord();
                begin
                    if ObjCustRecord.Get("Loans Guarantee Details"."Member No") then begin
                        VarTShares := VarTShares + ObjCustRecord."Current Savings";
                        VarTLoans := VarTLoans + ObjCustRecord."Principal Balance";
                    end;
                    ObjLoanG.CalcFields(ObjLoanG."Outstanding Balance");
                    ObjLoanG.Reset;
                    ObjLoanG.SetRange(ObjLoanG."Member No", "Member No");
                    ObjLoanG.SetFilter(ObjLoanG."Outstanding Balance", '>%1', 0);
                    if ObjLoanG.Find('-') then begin
                        repeat
                            // ObjLoanG.CALCFIELDS(ObjLoanG."Outstanding Balance",ObjLoanG."Total Loan Risk");
                            ObjLoanG.CalcFields(ObjLoanG."Total Amount Guaranteed");
                            VarGuaranteedAmount := ObjLoanG."Total Amount Guaranteed";
                            VarGuarOutstanding := ObjLoanG."Guarantor Outstanding";
                        until ObjLoanG.Next = 0;
                    end;
                    VarTGuaranteedAmount := VarTGuaranteedAmount + VarGuaranteedAmount;
                    //-----------------------------------------------------Get Group Networth
                    VarCollateralSecurity := 0;
                    VarRepaymentPeriod := WorkDate;
                    VarArrears := 0;
                    VarTotalArrears := 0;
                    ObjLoanCollateral.Reset;
                    ObjLoanCollateral.SetRange(ObjLoanCollateral."Member No", "Loans Guarantee Details"."Member No");
                    if ObjLoanCollateral.FindSet then begin
                        repeat
                            ObjLoans.Reset;
                            ObjLoans.SetRange(ObjLoans."Loan  No.", ObjLoanCollateral."Loan No");
                            ObjLoans.SetFilter(ObjLoans."Loan Product Type", '%1|%2|%3|%4', '301', '302', '303', '306', '322');
                            if ObjLoans.FindSet then begin
                                ObjLoans.CalcFields(ObjLoans."Outstanding Balance");
                                if ObjLoans."Outstanding Balance" > 0 then begin
                                    VarCollateralSecurity := VarCollateralSecurity + ObjLoanCollateral."Guarantee Value";
                                end;
                            end;
                        until ObjLoanCollateral.Next = 0;
                    end;
                    ObjCust.Reset;
                    ObjCust.SetRange(ObjCust."No.", "Loans Guarantee Details"."Member No");
                    if ObjCust.FindSet then begin
                        ObjCust.CalcFields(ObjCust."Total BOSA Loan Balance");
                        if ObjCust."Total BOSA Loan Balance" > VarCollateralSecurity then begin
                            VarLoanRisk := ObjCust."Total BOSA Loan Balance";//-VarCollateralSecurity
                        end else
                            VarLoanRisk := 0;
                    end;
                    VarTotalArrears := 0;
                    ObjLoans.CalcFields("Outstanding Balance");
                    ObjLoans.Reset;
                    ObjLoans.SetRange("Client Code", "Loans Guarantee Details"."Member No");
                    ObjLoans.SetFilter("Outstanding Balance", '>%1', 0);
                    if ObjLoans.FindSet then begin
                        repeat
                            SFactory.FnGetLoanArrearsAmountII(ObjLoans."Loan  No.");
                            VarTotalArrears := VarTotalArrears + ObjLoans."Amount in Arrears";
                        until ObjLoans.Next = 0;
                    end;
                end;

            }
            dataitem("Loan Collateral Details"; "Loan Collateral Details")
            {
                DataItemLink = "Loan No" = field("Loan  No.");
                //orNavId_1000000099; 1000000099) { } // Autogenerated by ForNav - Do not delete
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
                column(CollateralRegisteDoc_LoanCollateralDetails; "Loan Collateral Details"."Collateral Registe Doc")
                {
                }
            }
            dataitem("Loan Offset Details"; "Loan Offset Details")
            {
                DataItemLink = "Loan No." = field("Loan  No.");
                DataItemTableView = where("Principle Top Up" = filter(> 0));
                //orNavId_4717; 4717) { } // Autogenerated by ForNav - Do not delete
                column(Loans_Top_up__Principle_Top_Up_; "Loan Offset Details"."Principle Top Up")
                {
                }
                column(Loans_Top_up__Loan_Type_; "Loan Offset Details"."Loan Type")
                {
                }
                column(Loans_Top_up__Client_Code_; "Loan Offset Details"."Client Code")
                {
                }
                column(Loans_Top_up__Loan_No__; "Loan Offset Details"."Loan No.")
                {
                }
                column(Loans_Top_up__Total_Top_Up_; "Loan Offset Details"."Total Top Up")
                {
                }
                column(Loans_Top_up__Interest_Top_Up_; "Loan Offset Details"."Interest Top Up")
                {
                }
                column(Loan_Type; "Loan Offset Details"."Loan Type")
                {
                }
                column(Loans_Top_up_Commision; "Loan Offset Details".Commision)
                {
                }
                column(TaxOnComission_LoanOffsetDetails; "Loan Offset Details"."Tax On Comission")
                {
                }
                column(Loans_Top_up__Principle_Top_Up__Control1102760116; "Loan Offset Details"."Principle Top Up")
                {
                }
                column(BrTopUpCom; VarBrTopUpCom)
                {
                }
                column(TOTALBRIDGED; VarTotalBridged)
                {
                }
                column(Loans_Top_up__Total_Top_Up__Control1102755050; "Loan Offset Details"."Total Top Up")
                {
                }
                column(Loans_Top_up_Commision_Control1102755053; "Loan Offset Details".Commision)
                {
                }
                column(LoanInsuranceCurrentYear_LoanOffsetDetails; "Loan Offset Details"."Loan Insurance: Current Year")
                {
                }
                column(ProductDescription; VarProductDescription)
                {
                }
                column(Loans_Top_up__Interest_Top_Up__Control1102755055; "Loan Offset Details"."Interest Top Up")
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
                column(Loans_Top_up_Loan_Top_Up; "Loan Offset Details"."Loan Top Up")
                {
                }
                column(WarnBridged; VarWarnBridged)
                {
                }
                column(WarnSalary; VarWarnSalary)
                {
                }
                column(WarnDeposits; VarWarnDeposits)
                {
                }
                column(WarnGuarantor; VarWarnGuarantor)
                {
                }
                column(WarnShare; VarWarnShare)
                {
                }
                column(LoanDefaultInfo; VarDefaultInfo)
                {
                }
                column(Riskamount; VarRiskamount)
                {
                }
                column(RiskDeposits; VarRiskDeposits)
                {
                }
                column(RiskGshares; VarRiskGshares)
                {
                }
                column(Recomm_TOTALBRIDGED2; VarRecomm - VarTotalBridged)
                {
                }
                trigger OnPreDataItem();
                begin
                    VarBrTopUpCom := 0;
                    VarTotalBridged := 0;
                end;

                trigger OnAfterGetRecord();
                begin
                    VarTotalTopUp := ROUND((VarTotalTopUp + "Principle Top Up"), 0.05, '>');
                    VarTotalIntPayable := VarTotalIntPayable + "Monthly Repayment";
                    VarGTotals := VarGTotals + ("Principle Top Up" + "Monthly Repayment");
                    if "Loans Register".Get("Loan Offset Details"."Loan No.") then begin
                        if ObjLoanType.Get("Loans Register"."Loan Product Type") then begin
                        end;
                    end;
                    VarTotalBridged := VarTotalBridged + "Loan Offset Details"."Total Top Up";
                    if VarTotalBridged > VarRecomm then
                        VarWarnBridged := UpperCase('WARNING: Bridging Total is Higher than the Qualifing Amount.')
                    else
                        VarWarnBridged := '';
                    if ObjLoanType.Get("Loan Offset Details"."Loan Type") then begin
                        VarProductDescription := ObjLoanType."Product Description";
                    end;
                end;

            }
            trigger OnPreDataItem();
            begin
                ObjCompanyInfo.Get;
                ObjCompanyInfo.CalcFields(ObjCompanyInfo.Picture);
            end;

            trigger OnAfterGetRecord();
            var
                MaximumEligible: Decimal;
                PrincipalAmount: Decimal;
            begin
                VarTotalRepaymentReinstated := FnRunGetLoanOffsetRepayments("Loan  No.");
                if Memba.Get("Loans Register"."Client Code") then;
                "Existing Loan Repayments" := "Loans Register".FnRungetexistingLoansRepayment("Loans Register"."Client Code") - VarTotalRepaymentReinstated;
                "Loans Register".Validate("Total DeductionsH");
                Modify;
                FnGetPayslipNetUtilizable;
                FnRunInitializeVariables;//=================================================================================Initialize Variables
                VarDepositQualificationII := FnRunGetQualificationPerDeposits("Loan  No.", "Client Code");//==========================================================================Qualification Deposits
                FnRunGetOffsetDetails("Client Code", "Loan  No.");//=====================================================================================Loan Ofset Details
                VarPsalary := FnRunGetQualificatioPerIncome("Loan  No.");//=============================================================================Income Qualification
                FnRunGetSecurityQualification("Client Code", "Loan  No.", "Loan Product Type");//=============================================================================Security Qualification
                VarDepX := VarDepositQualificationII;
                VarRiskamount := "Loans Register"."Requested Amount" - VarMAXAvailable;
                VarRecomm := ROUND(FnReccommendAmount("Loans Register"."Requested Amount", VarDepX, VarTotalGuaranteed, ROUND(VarPsalary, 0.05, '<')), 100, '<'); //Introduced on 28th sep 2017 To Hadnle Amortized Loans;
                // Message('#Requested Amount=%1, #Total Qualification per Deposits=%2 #Security Offered Amount=%3 #Qualification by Income=%4..***Recommended Amount=%5***',
                // "Loans Register"."Requested Amount", VarDepX, VarTotalGuaranteed, ROUND(VarPsalary, 0.05, '<'),
                // VarRecomm);
                //ROUND(FnReccommendAmount("Loans Register"."Requested Amount",(VarDepX-"Loans Register"."Total Outstanding Loan BAL"),VarTotalGuaranteed,ROUND(VarPsalary,0.05,'<')),100,'<'));
                "Recommended Amount" := ROUND(VarRecomm, 100, '<');
                "Approved Amount" := ROUND(VarRecomm, 100, '<');
                VarTotalMRepay := 0;
                VarLPrincipal := 0;
                VarLInterest := 0;
                VarLoanAmount := 0;
                VarInterestRate := Interest;
                VarLoanAmount := "Approved Amount";
                VarRepayPeriod := Installments;
                VarLBalance := "Approved Amount";
                "Loans Guarantee Details".Reset;
                "Loans Guarantee Details".SetRange("Loans Guarantee Details"."Loan No", "Loans Register"."Loan  No.");
                if "Loans Guarantee Details".Find('-') then begin
                    "Loans Guarantee Details".CalcSums("Loans Guarantee Details"."Amont Guaranteed");
                    VarTGAmount := "Loans Guarantee Details"."Amont Guaranteed";
                end;
                FnRunGetShareBoostingDetails;//===========================================================================Share Boosting Details
                                             //Charge Cash Clearance fee
                ObjLoanApp.Reset;
                ObjLoanApp.SetRange(ObjLoanApp."Client Code", "Client Code");
                ObjLoanApp.SetRange(ObjLoanApp.Source, ObjLoanApp.Source::BOSA);
                ObjLoanApp.SetRange(ObjLoanApp.Posted, true);
                if ObjLoanApp.Find('-') then begin
                    repeat
                        ObjLoanApp.CalcFields(ObjLoanApp."Outstanding Balance", ObjLoanApp."Total Repayments", ObjLoanApp."Total Interest", "Offset Commission");
                        if ObjLoanApp."Loan  Cash Cleared" > 0 then begin
                            VarLoanCashClearedFee := VarLoanCashClearedFee + (ObjLoanApp."Loan  Cash Cleared" * (ObjGenSetUp."Loan Cash Clearing Fee(%)" / 100));
                            "Loan Cash Clearance fee" := VarLoanCashClearedFee;
                            Modify;
                        end;
                    until ObjLoanApp.Next = 0;
                end;
                ObjGenSetUp.Get;
                if ObjLoanType.Get("Loan Product Type") then begin
                    //POPULATE ALL CHARGES & GLs FROM PRODUCT SETUPS---------------------------------------------------------------------------------//
                    VarLoanInsurance := 0;
                    VarLoanInsurance := SFactory.FnGetChargeFee("Loan Product Type", "Approved Amount", 'LINSURANCE');
                    VarAplicationFee := SFactory.FnGetChargeFee("Loan Product Type", "Approved Amount", 'LPF');
                    VarLoanFormFee := SFactory.FnGetChargeFee("Loan Product Type", "Approved Amount", 'BOSA TRANSFER');
                    VarLAppraisalFee := SFactory.FnGetChargeFee("Loan Product Type", "Approved Amount", 'LAPPRAISAL');
                    VarLoanTransferFee := SFactory.FnGetTransferFee("Mode of Disbursement");
                    // VarBridgeLevy:=ROUND(ObjLoanApp."Offset Commission",1,'>');
                    VarSMSFee := ObjGenSetUp."SMS Fee Amount";
                    // Upfronts := VarLoanInsurance + VarAplicationFee + VarLoanFormFee + VarLAppraisalFee + VarLoanTransferFee + VarShareBoostComm + VarExciseDutyShareBoostComm + "Loans Register"."Boosted Amount" +
                    // "Loans Register"."Boosted Amount Interest" + "Loans Register"."Boosting Commision" + VarTotalBridgeAmount + "Loans Register"."Interest Upfront";
                    //END------------------------------------------------------------------------------------------------------------//
                    "Loan SMS Fee" := VarSMSFee;
                    Modify;
                    VarNetdisbursed := "Approved Amount";//- Upfronts;
                end;
                "Capitalized Charges" := VarTscInt + VarLAppraisalFee + VarAccruedInt + VarSaccoInt;
                "Loan Disbursed Amount" := VarNetdisbursed;
                //VarUpfronts := Upfronts;
                "Total Offset Amount" := VarTotalBridgeAmount;
                "Loan Insurance Charged" := VarLoanInsurance;
                "Loan Insurance" := VarLoanInsurance;
                Modify;
                if VarNetdisbursed < 0 then
                    Message('Net Disbursed cannot be 0 or Negative');
                if VarMAXAvailable < 0 then
                    VarWarnDeposits := UpperCase('WARNING: Insufficient Deposits to cover the loan applied: Risk %1')
                else
                    VarWarnDeposits := '';
                if VarMAXAvailable < 0 then
                    VarRiskDeposits := "Loans Register"."Requested Amount" - VarMAXAvailable;
                if VarMsalary < "Loans Register"."Requested Amount" then
                    VarWarnSalary := UpperCase('WARNING: Salary is Insufficient to cover the loan applied: Risk')
                else
                    VarWarnSalary := '';
                if VarMsalary < "Loans Register"."Requested Amount" then
                    VarRiskamount := "Loans Register"."Requested Amount" - VarMsalary;
                if VarGShares < "Loans Register"."Requested Amount" then
                    VarWarnGuarantor := UpperCase('WARNING: Guarantors do not sufficiently cover the loan: Risk')
                else
                    VarWarnGuarantor := '';
                if VarGShares < "Loans Register"."Requested Amount" then
                    VarRiskVarGShares := "Loans Register"."Requested Amount" - VarGShares;
                if ("Loans Register"."Expected Date of Completion" > FnReturnRetirementDate("Loans Register"."Client Code")) then
                    Message('The Member retirement date will come earlier than the Expected Date of Completion (%1).The Member is due to retire on %2: Risk', "Loans Register"."Expected Date of Completion", FnReturnRetirementDate("Loans Register"."Client Code"));
                VarTotalMRepay := 0;
                VarLPrincipal := 0;
                VarLInterest := 0;
                VarInterestRate := Interest;
                VarLoanAmount := "Approved Amount";
                VarRepayPeriod := Installments;
                VarLBalance := "Approved Amount";
                if "Loans Register"."Loan Product Type" = 'VS-MEMBER' then begin
                    VarLInterest := ROUND((VarInterestRate / 100) * VarLoanAmount, 1, '>');
                    "Loans Register"."Interest Upfront" := VarLInterest;
                    //MESSAGE('int %1|rate %2 | %3 period',VarLInterest,VarInterestRate,VarRepayPeriod);
                    Modify;
                end;
                if "Repayment Method" = "repayment method"::"Straight Line" then begin
                    TestField(Installments);
                    VarLPrincipal := ROUND(VarLoanAmount / VarRepayPeriod, 1, '>');
                    "Loans Register".Repayment := VarLPrincipal + VarLInterest;
                    //"Loans Register"."Interest Upfront":=VarLInterest;
                    Modify;
                end;
                //Monthly Interest Formula PR(T+1)/200T
                if "Repayment Method" = "repayment method"::"Reducing Balance" then begin
                    TestField(Interest);
                    TestField(Installments);
                    VarLPrincipal := ROUND(VarLoanAmount / VarRepayPeriod, 1, '>');
                    VarLInterest := ROUND(VarRecomm * "Loans Register".Interest / 12 * 0.01, 1, '>');
                    if ObjLoanType."Charge Interest Upfront" then VarLInterest := 0;
                    //VarLInterest:=ROUND(VarRecomm*"Loans Register".Interest/12*(VarRepayPeriod+1)/(200*VarRepayPeriod),1,'>');//ROUND((InterestRate/12/100)*LBalance,0.05,'>');
                    Repayment := VarLPrincipal + VarLInterest;
                    "Loan Principle Repayment" := VarLPrincipal;
                    "Loan Interest Repayment" := VarLInterest;
                    Modify;
                end;
                if "Repayment Method" = "repayment method"::Amortised then begin
                    VarTotalMRepay := ROUND((VarInterestRate / 12 / 100) / (1 - Power((1 + (VarInterestRate / 12 / 100)), -VarRepayPeriod)) * VarLoanAmount, 1, '>');
                    VarLInterest := ROUND(VarLBalance / 100 / 12 * VarInterestRate, 0.05, '>');
                    if ObjLoanType."Charge Interest Upfront" then VarLInterest := 0;
                    VarLPrincipal := VarTotalMRepay - VarLInterest;
                    "Loan Principle Repayment" := VarLPrincipal;
                    "Loan Interest Repayment" := VarLInterest;
                    "Approved Repayment" := VarTotalMRepay;
                    ObjProductCharge.Reset;
                    ObjProductCharge.SetRange(ObjProductCharge."Product Code", "Loan Product Type");
                    ObjProductCharge.SetRange(ObjProductCharge."Loan Charge Type", ObjProductCharge."loan charge type"::"Loan Insurance");
                    if ObjProductCharge.FindSet then begin
                        VarLInsurance := "Approved Amount" * (ObjProductCharge.Percentage / 100);
                    end;
                    Repayment := VarLPrincipal + VarLInterest + VarLInsurance;
                    Modify;
                end;
                Message('Monthly Interest Repayment=%1, Monthly Principal Repayment=%2, ****Total Monthly Repayment=%3***', VarLInterest, VarLPrincipal, VarLPrincipal + VarLInterest);
                //"Approved Amount":=VarRecomm;
                "Loans Register".Modify;

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
                }
            }
        }

        actions
        {
        }
        trigger OnOpenPage()
        begin
            //  ReportForNavOpenDesigner := false;
        end;
    }

    trigger OnInitReport()
    begin
        ;
        //  ReportsForNavInit;

    end;

    trigger OnPostReport()
    begin
        ;
        //  ReportForNav.Post;
    end;

    trigger OnPreReport()
    begin
        ObjGenSetUp.Get;
        ObjCompanyInfo.Get;
        ;
        // ReportsForNavPre;
    end;

    var
        ObjCustRec: Record Customer;
        ObjGenSetUp: Record "Sacco General Set-Up";
        ObjCustRecord: Record Customer;
        VarTShares: Decimal;
        VarTLoans: Decimal;
        ObjLoanApp: Record "Loans Register";
        VarLoanShareRatio: Decimal;
        VarEligibility: Decimal;
        VarTotalSec: Decimal;
        Varsaccded: Decimal;
        Varsaccded2: Decimal;
        Vargrosspay: Decimal;
        VarTdeduct: Decimal;
        VarCshares: Decimal;
        "VarCshares*3": Decimal;
        "VarCshares*4": Decimal;
        VarQUALIFY_SHARES: Decimal;
        Varsalary: Decimal;
        ObjLoanG: Record "Loans Guarantee Details";
        VarGShares: Decimal;
        VarRecomm: Decimal;
        VarGShares1: Decimal;
        VarNettakehome: Decimal;
        VarMsalary: Decimal;
        VarRecPeriod: Integer;
        VarFOSARecomm: Decimal;
        VarFOSARecoPRD: Integer;
        VarAssetValue: Decimal;
        VarInterestRate: Decimal;
        VarRepayPeriod: Decimal;
        VarLBalance: Decimal;
        VarTotalMRepay: Decimal;
        VarLInterest: Decimal;
        VarLPrincipal: Decimal;
        VarSecuredSal: Decimal;
        VarLinterest1: Integer;
        VarLoanBalance: Decimal;
        ObjBridgedLoans: Record "Loan Offset Details";
        VarBridgeBal: Decimal;
        VarLoanBalanceFosaSec: Decimal;
        VarTotalTopUp: Decimal;
        VarTotalIntPayable: Decimal;
        VarGTotals: Decimal;
        VarTempVal: Decimal;
        VarTempVal2: Decimal;
        "VarTempCshares*4": Decimal;
        "VarTempCshares*3": Decimal;
        VarInstallP: Decimal;
        VarRecomRemark: Text[150];
        VarInstallRecom: Decimal;
        VarTopUpComm: Decimal;
        VarTotalTopupComm: Decimal;
        ObjLoanTopUp: Record "Loan Offset Details";
        "VarInterest Payable": Decimal;
        ObjGeneralsetup: Record "Sacco General Set-Up";
        VarDays: Integer;
        VarEndMonthInt: Decimal;
        VarBridgeBal2: Decimal;
        VarDefaultInfo: Text[80];
        VarTotalBridged: Decimal;
        VarDepMultiplier: Decimal;
        VarMAXAvailable: Decimal;
        ObjSalDetails: Record "Loan Appraisal Salary Details";
        VarEarnings: Decimal;
        VarDeductions: Decimal;
        VarBrTopUpCom: Decimal;
        VarLoanAmount: Decimal;
        ObjCompanyInfo: Record "Company Information";
        VarCompanyAddress: Code[20];
        VarCompanyEmail: Text[30];
        VarCompanyTel: Code[20];
        VarCurrentAsset: Decimal;
        VarCurrentLiability: Decimal;
        VarFixedAsset: Decimal;
        VarEquity: Decimal;
        VarSales: Decimal;
        VarSalesOnCredit: Decimal;
        VarAppraiseDeposits: Boolean;
        VarAppraiseShares: Boolean;
        VarAppraiseSalary: Boolean;
        VarAppraiseGuarantors: Boolean;
        VarAppraiseBusiness: Boolean;
        VarTLoan: Decimal;
        VarLoanBal: Decimal;
        VarGuaranteedAmount: Decimal;
        VarRunBal: Decimal;
        VarTGuaranteedAmount: Decimal;
        VarGuarantorQualification: Boolean;
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
        Comment__________Caption_Control1102755070Lbl: label 'Comment :____________________________________________________________________________________';
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
        VarTotalLoanBalance: Decimal;
        VarTGAmount: Decimal;
        VarNetSalary: Decimal;
        VarRiskamount: Decimal;
        VarWarnBridged: Text;
        VarWarnSalary: Text;
        VarWarnDeposits: Text;
        VarWarnGuarantor: Text;
        VarWarnShare: Text;
        VarRiskGshares: Decimal;
        VarRiskDeposits: Decimal;
        VarBasicEarnings: Decimal;
        VarDepX: Decimal;
        VarLoanPrincipal: Decimal;
        VarloanInterest: Decimal;
        VarAmountGuaranteed: Decimal;
        VarStatDeductions: Decimal;
        VarGuarOutstanding: Decimal;
        VarTwoThirds: Decimal;
        VarBridged_AmountCaption: Integer;
        VarLNumber: Code[20];
        VarTotalLoanDeductions: Decimal;
        VarTotalRepayments: Decimal;
        VarTotalinterest: Decimal;
        VarBand: Decimal;
        VarTotalOutstanding: Decimal;
        ObjBanding: Record "Deposit Tier Setup";
        VarNtTakeHome: Decimal;
        VarAthird: Decimal;
        VarPsalary: Decimal;
        ObjLoanApss: Record "Loans Register";
        VarTotalLoanBal: Decimal;
        VarTotalBand: Decimal;
        ObjLoanAp: Record "Loans Register";
        VarTotalRepay: Decimal;
        VarTotalInt: Decimal;
        VarLastFieldNo: Integer;
        VarTotLoans: Decimal;
        JazaLevy: Decimal;
        VarBridgeLevy: Decimal;
        VarUpfronts: Decimal;
        VarNetdisbursed: Decimal;
        VarTotalLRepayments: Decimal;
        VarBridgedRepayment: Decimal;
        VarOutstandingLrepay: Decimal;
        ObjLoantop: Record "Loan Offset Details";
        VarBridgedAmount: Decimal;
        VarTotalBridgedAmount: Decimal;
        VarFinalInst: Decimal;
        VarNonRec: Decimal;
        VarOtherDeductions: Decimal;
        VarStartDate: Date;
        VarFromDate: Date;
        VarToDate: Date;
        VarFromDateS: Text[100];
        VarToDateS: Text[100];
        VarDivTotal: Decimal;
        VarCDeposits: Decimal;
        ObjCustDiv: Record Customer;
        ObjDivProg: Record "Dividends Progression";
        VarCDiv: Decimal;
        VarBDate: Date;
        ObjCustR: Record Customer;
        VarBasicPay: Decimal;
        VarHouseAllowance: Decimal;
        VarTransportAll: Decimal;
        VarMedicalAll: Decimal;
        VarOtherIncomes: Decimal;
        VarGrossP: Decimal;
        VarMonthlyCont: Decimal;
        VarNHIF: Decimal;
        VarPAYE: Decimal;
        VarRisk: Decimal;
        VarLifeInsurance: Decimal;
        VarOtherLiabilities: Decimal;
        VarSaccoDed: Decimal;
        ObjProductCharges: Record "Loan Product Charges";
        VarLoanInsurance: Decimal;
        ObjCustLeg: Record "Detailed Vendor Ledg. Entry";
        VarBoostedAmount2: Decimal;
        VarShareBoostComm: Decimal;
        Varcurrentshare: Decimal;
        VarSMSFee: Decimal;
        VarHisaARREAR: Decimal;
        VarShareBoostCommHISA: Decimal;
        VarBoostedAmountHISA: Decimal;
        VarShareBoostCommHISAFOSA: Decimal;
        VarLoanTransferFee: Decimal;
        VarRemainingDays: Integer;
        VarIARR: Decimal;
        VarTotalBridgeAmount: Decimal;
        VarLoanCashClearedFee: Decimal;
        ObjCollateral: Record "Loan Collateral Details";
        VarCollateralAmount: Decimal;
        VarShareCap: Decimal;
        VarLPFcharge: Decimal;
        VarLAppraisalFee: Decimal;
        VarLAppraisalFeeAccount: Code[20];
        VarTscInt: Decimal;
        VarAccruedInt: Decimal;
        VarAplicationFee: Decimal;
        VarLoanFormFee: Decimal;
        VarSaccoInt: Decimal;
        VarArmotizationFactor: Decimal;
        VarArmotizationFInstalment: Decimal;
        VarSaccoIntRelief: Decimal;
        VarSuperLoanBal: Decimal;
        VarQualifyingDep: Decimal;
        VarRemainigDep: Decimal;
        VarPrincipalAmountGlobal: Decimal;
        VarTotalGuaranteed: Decimal;
        SFactory: Codeunit "SURESTEP Factory";
        VarExciseDutyShareBoostComm: Decimal;
        ObjSecurities: Record "Loan Collateral Details";
        ObjProductCharge: Record "Loan Product Charges";
        VarLInsurance: Decimal;
        VarDepositsMultiplier: Decimal;
        ObjLoans: Record "Loans Register";
        VarTotalCollateralValue: Decimal;
        VarTotalLoansnotSecuredbyCollateral: Decimal;
        VarPayslipNet: Decimal;
        VarBankStatementNet: Decimal;
        VarProductDescription: Code[50];
        ObjLoanType: Record "Loan Products Setup";
        ObjLoanCollateral: Record "Loan Collateral Details";
        VarCollateralSecurity: Decimal;
        VarArreasAmount: Decimal;
        VarLoanRisk: Decimal;
        VarNoGroupMembers: Integer;
        VarGroupNetWorth: Decimal;
        ObjCust: Record Customer;
        VarLastMonth: Date;
        ObjRepaymentSch: Record "Loan Repayment Schedule";
        VarArrears: Decimal;
        VarDateFilter: Text;
        VarRepaymentPeriod: Date;
        VarScheduledLoanBal: Decimal;
        VarLBal: Decimal;
        VarLastMonthDate: Integer;
        VarLastMonthMonth: Integer;
        VarLastMonthYear: Integer;
        VarRepaymentDate: Date;
        VarRepayDate: Integer;
        VarTotalArrears: Decimal;
        VarExitDeposits: Decimal;
        VarExitLoans: Decimal;
        VarMemberGuarantorshipLiability: Decimal;
        "NoofMonthsArrears:Deposit": Decimal;
        "AmountArrears:Deposit": Decimal;
        VarLastDayofPreviousMonth: Date;
        VarTotalLoansIssued: Decimal;
        ObjLoanGuaranteeDetails: Record "Loans Guarantee Details";
        ObjAccount: Record Vendor;
        VarBoostingDateFilter: Text;
        VarDepositHalfBeforeBoosting: Decimal;
        VarShareBoostingCheckDate: Date;
        ObjDetailedLedg: Record "Detailed Vendor Ledg. Entry";
        ObjHistoricalLedg: Record "Member Historical Ledger Entry";
        VarHistoricalBoostedAmount: Decimal;
        VarRiskVarGShares: Decimal;
        VarCollateralSecurityOffered: Boolean;
        VarSelfGuarantee: Boolean;
        VarDepositQualificationII: Decimal;
        VarTotalRepaymentReinstated: Decimal;
        Memba: Record Customer;

    local procedure FnReccommendAmount(RequestedAmount: Decimal; QShares: Decimal; QGuarantors: Decimal; QSalary: Decimal) RecommendedAmount: Decimal
    begin
        RecommendedAmount := RequestedAmount;
        if RecommendedAmount > QSalary then
            RecommendedAmount := QSalary;
        if ("Loans Register"."Loan Product Type" <> 'EL') and ("Loans Register"."Loan Product Type" <> 'IL') then begin
            if RecommendedAmount > QShares then
                RecommendedAmount := QShares;
        end;
        if RecommendedAmount > QGuarantors then
            RecommendedAmount := QGuarantors;
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
        ObjGenSetUp.Get();
        ObjMembers.Reset;
        ObjMembers.SetRange(ObjMembers."No.", MemberNo);
        if ObjMembers.Find('-') then
            if ObjMembers."Date of Birth" = 0D then
                exit("Loans Register"."Expected Date of Completion")
            else
                exit(CalcDate(ObjGenSetUp."Retirement Age", ObjMembers."Date of Birth"));
    end;

    local procedure FnRunInitializeVariables()
    begin
        VarCshares := 0;
        VarMAXAvailable := 0;
        VarLoanBalance := 0;
        VarTotalTopUp := 0;
        VarTotalIntPayable := 0;
        VarGTotals := 0;
        VarAmountGuaranteed := 0;
        VarTotLoans := 0;
        VarDepX := 0;
        VarTotalSec := 0;
        VarTShares := 0;
        VarTLoans := 0;
        VarEarnings := 0;
        VarDeductions := 0;
        VarNetSalary := 0;
        VarLoanPrincipal := 0;
        VarloanInterest := 0;
        VarPsalary := 0;
        VarTotalLoanBal := 0;
        VarTotalBand := 0;
        VarTotalRepay := 0;
        VarBridgedRepayment := 0;
        VarTotalRepayments := 0;
    end;

    local procedure FnRunGetQualificationPerDeposits(VarLoanNo: Code[30]; VarMemberNo: Code[30]) VarDepMultiplierII: Decimal
    begin
        //===================================================================================================Deposits analysis
        ObjLoans.Reset;
        ObjLoans.SetRange(ObjLoans."Loan  No.", VarLoanNo);
        if ObjLoans.FindSet then begin
            if ObjCust.Get(VarMemberNo) then begin
                ObjCust.CalcFields(ObjCust."Current Shares", ObjCust."Shares Retained");
                VarCshares := ObjCust."Current Shares";
                VarShareCap := ObjCust."Shares Retained";
                //===================================================================================================Get Qualification Amount
                message('source %1', ObjLoans.Source);
                if ObjLoans.Source = ObjLoans.Source::BOSA then begin
                    if ObjLoanType.Get(ObjLoans."Loan Product Type") then begin
                        // Message('multiplier %1 1st time loanee %1  objloans mult %3', ObjLoanType."Deposits Multiplier", ObjLoans."1st Time Loanee", ObjLoanType."Deposits Multiplier");
                        if "Loans Register"."1st Time Loanee" <> true then begin
                            VarDepMultiplier := ObjLoans."Loan Deposit Multiplier" * (VarCshares)
                        end else
                            VarDepMultiplier := ObjLoans."Loan Deposit Multiplier" * (VarCshares);
                        VarDepMultiplierII := VarDepMultiplier;
                    end;
                end;
            end;
            if ObjLoans.Source = ObjLoans.Source::FOSA then begin
                if ObjLoanType.Get(ObjLoans."Loan Product Type") then begin
                    VarDepMultiplier := ObjLoanType."FOSA Loan Shares Ratio" * VarCshares;
                    VarDepMultiplierII := VarDepMultiplier;
                end;
            end;
        end;
        // Message('mult %1', VarDepMultiplierII);
        exit(VarDepMultiplierII);
    end;

    local procedure FnRunGetOffsetDetails(VarMemberNo: Code[30]; VarLoanNo: Code[30])
    begin
        ObjLoanApp.Reset;
        ObjLoanApp.SetRange(ObjLoanApp."Client Code", VarMemberNo);
        //ObjLoanApp.SETRANGE(ObjLoanApp.Source,ObjLoanApp.Source::BOSA);
        ObjLoanApp.SetRange(ObjLoanApp.Posted, true);
        if ObjLoanApp.Find('-') then begin
            repeat
                ObjLoanApp.CalcFields(ObjLoanApp."Outstanding Balance", ObjLoanApp."Total Repayments", ObjLoanApp."Total Interest", "Offset Commission");
                if ObjLoanApp."Outstanding Balance" > 0 then begin
                    VarLoanBalance := VarLoanBalance + ObjLoanApp."Outstanding Balance";
                    VarTotalRepayments := VarTotalRepayments + ObjLoanApp.Repayment;
                end;
            until ObjLoanApp.Next = 0;
        end;
        ObjLoanTopUp.Reset;
        ObjLoanTopUp.SetRange(ObjLoanTopUp."Loan No.", VarLoanNo);
        ObjLoanTopUp.SetRange(ObjLoanTopUp."Client Code", VarMemberNo);
        if ObjLoanTopUp.FindSet then begin
            repeat
                VarBridgedAmount := VarBridgedAmount + ObjLoanTopUp."Principle Top Up";
                VarTotalBridgeAmount := VarTotalBridgeAmount + ObjLoanTopUp."Total Top Up";
            until ObjLoanTopUp.Next = 0;
        end;
        ObjLoanTopUp.Reset;
        ObjLoanTopUp.SetRange(ObjLoanTopUp."Loan No.", VarLoanNo);
        ObjLoanTopUp.SetRange(ObjLoanTopUp."Client Code", VarMemberNo);
        if ObjLoanTopUp.Find('-') then begin
            repeat
                if ObjLoanTopUp."Partial Bridged" = false then begin
                    VarBridgedRepayment := VarBridgedRepayment + ObjLoanTopUp."Monthly Repayment";
                    VarFinalInst := VarFinalInst + ObjLoanTopUp."Finale Instalment";
                end;
            until ObjLoanTopUp.Next = 0;
        end;
        VarTotalRepayments := VarTotalRepayments - VarBridgedRepayment;
        VarTotalLoanBal := (VarLoanBalance + "Loans Register"."Approved Amount") - VarBridgedAmount;
        VarLBalance := VarLoanBalance - VarBridgedAmount;
        //====================================================================================Member Total Loans Guaranteed
        "Loans Guarantee Details".Reset;
        "Loans Guarantee Details".SetRange("Loans Guarantee Details"."Member No", VarMemberNo);
        if "Loans Guarantee Details".Find('-') then begin
            "Loans Guarantee Details".CalcFields("Outstanding Balance");
            VarGuarOutstanding := "Loans Guarantee Details"."Outstanding Balance";
        end;
    end;

    local procedure FnRunGetQualificatioPerIncome(VarLoanNo: Code[30]): decimal
    begin
        ObjLoans.Reset;
        ObjLoans.SetRange(ObjLoans."Loan  No.", VarLoanNo);
        if ObjLoans.FindSet then begin
            if (ObjLoans."Income Type" = ObjLoans."income type"::Payslip) or (ObjLoans."Income Type" = ObjLoans."income type"::"Payslip & Bank Statement") then begin
                Varsalary := ObjLoans."Net Utilizable Amount";//(ObjLoans."Salary Total Income"-(ObjLoans."SExpenses Rent"+ObjLoans."SExpenses Transport"+ObjLoans."SExpenses Food"+ObjLoans."SExpenses Utilities"+ObjLoans."SExpenses Others"));
                VarPayslipNet := ObjLoans."Net Utilizable Amount";
                //  Message(' varsalary %1 varpaslipnet %2', Varsalary, VarPayslipNet);
            end;
            if (ObjLoans."Income Type" = ObjLoans."income type"::"Bank Statement") or (ObjLoans."Income Type" = ObjLoans."income type"::"Payslip & Bank Statement") then begin
                Varsalary := ObjLoans."Bank Statement Net Income";
                VarBankStatementNet := Varsalary;

            end;
            if (VarPayslipNet + VarBankStatementNet) > 0 then begin
                VarPsalary := ((VarPayslipNet + VarBankStatementNet) * 100 * ObjLoans.Installments) / (100 + ObjLoans.Installments)
            end else
                VarPsalary := 0;
        end;
        exit(VarPsalary)
    end;

    local procedure FnRunGetSecurityQualification(VarMemberNo: Code[30]; VarLoanNo: Code[30]; VarLoanType: Code[30])
    var
        ObjLoanGuarantors: Record "Loans Guarantee Details";
    begin
        VarGShares1 := 0;
        ObjLoanG.Reset;
        ObjLoanG.SetRange(ObjLoanG."Loan No", VarLoanNo);
        if ObjLoanG.FindSet then begin
            //    Message('guaranteed %1', ObjLoanG."Amont Guaranteed");
            repeat
                VarGShares := VarGShares + ObjLoanG."Amont Guaranteed";
            until ObjLoanG.Next = 0;
        end;
        VarTotalGuaranteed := VarGShares;

    end;

    local procedure FnRunGetShareBoostingDetails()
    begin
        //==================================================================================================CHECK SHARES BOOSTING
        ObjGenSetUp.Get();
        VarShareBoostingCheckDate := CalcDate(ObjGenSetUp."Boosting Shares Maturity (M)", WorkDate);
        ObjDetailedLedg.Reset;
        ObjDetailedLedg.SetRange(ObjDetailedLedg."Vendor No.", "Loans Register"."Member Deposit Account No");
        ObjDetailedLedg.SetFilter(ObjDetailedLedg."Posting Date", '>%1&<>%2', VarShareBoostingCheckDate, ObjGenSetUp."Go Live Date");
        if ObjDetailedLedg.FindSet then begin
            ObjDetailedLedg.CalcSums(ObjDetailedLedg.Amount);
            VarBoostedAmount2 := ObjDetailedLedg.Amount * -1;
        end;
        ObjHistoricalLedg.Reset;
        ObjHistoricalLedg.SetRange(ObjHistoricalLedg."Account No.", "Loans Register"."Member Deposit Account No");
        ObjHistoricalLedg.SetFilter(ObjHistoricalLedg."Posting Date", '>%1', VarShareBoostingCheckDate);
        if ObjHistoricalLedg.FindSet then begin
            ObjHistoricalLedg.CalcSums(ObjHistoricalLedg.Amount);
            VarHistoricalBoostedAmount := ObjHistoricalLedg.Amount * -1;
        end;
        if VarShareBoostingCheckDate > ObjGenSetUp."Go Live Date" then begin
            VarBoostingDateFilter := '..' + Format(VarShareBoostingCheckDate);
            ObjAccount.Reset;
            ObjAccount.SetRange(ObjAccount."No.", "Loans Register"."Member Deposit Account No");
            ObjAccount.SetFilter(ObjAccount."Date Filter", VarBoostingDateFilter);
            if ObjAccount.FindSet then begin
                ObjAccount.CalcFields(ObjAccount.Balance);
                VarDepositHalfBeforeBoosting := ObjAccount.Balance / 2;
            end;
        end else begin
            ObjHistoricalLedg.Reset;
            ObjHistoricalLedg.SetRange(ObjHistoricalLedg."Account No.", "Loans Register"."Member Deposit Account No");
            ObjHistoricalLedg.SetFilter(ObjHistoricalLedg."Posting Date", '<=%1', VarShareBoostingCheckDate);
            if ObjHistoricalLedg.FindSet then begin
                ObjHistoricalLedg.CalcSums(ObjHistoricalLedg.Amount);
                VarDepositHalfBeforeBoosting := (ObjHistoricalLedg.Amount * -1) / 2;
            end;
        end;
        VarBoostedAmount2 := VarBoostedAmount2 + VarHistoricalBoostedAmount;
        if VarBoostedAmount2 > VarDepositHalfBeforeBoosting then begin
            VarBoostedAmount2 := VarBoostedAmount2
        end else
            VarBoostedAmount2 := 0;
        VarShareBoostComm := (ObjGenSetUp."Boosting Shares %" / 100) * VarBoostedAmount2;
        VarExciseDutyShareBoostComm := VarShareBoostComm * (ObjGenSetUp."Excise Duty(%)" / 100);
        //   Message('#Chargable Share Boosted Amount=%1, #Share Boosting Comission=%2, #Excise on Boosting Comission=%3', VarBoostedAmount2, VarShareBoostComm, VarExciseDutyShareBoostComm);
        "Loans Register"."Share Boosting Comission" := VarShareBoostComm;
        "Loans Register".Modify;
        ObjGenSetUp.Get;
    end;

    local procedure FnRunGetLoanOffsetRepayments(VarLoanNo: Code[30]) VarTotalRepayments: Decimal
    var
        LoanOffsetDetails: Record "Loan Offset Details";
        LoansRegisterVer1: Record "Loans Register";
    begin
        LoanOffsetDetails.Reset;
        LoanOffsetDetails.SetRange(LoanOffsetDetails."Loan No.", VarLoanNo);
        if LoanOffsetDetails.FindSet then
            repeat
                VarTotalRepayments += LoansRegisterVer1.FnRungetexistingLoansRepaymentPerLoan(LoanOffsetDetails."Client Code", LoanOffsetDetails."Loan Top Up");
            until LoanOffsetDetails.Next = 0;
        exit(VarTotalRepayments);
    end;

    local procedure FnGetPayslipNetUtilizable()
    var
        GenSetUp: Record "Sacco General Set-Up";
        Nettakehome: Decimal;
        GrossPay: Decimal;
        NetUtilizable: Decimal;
        Var13rdofBasic: Decimal;
        TotalDeductions: Decimal;
        OTrelief: Decimal;
    begin
        "Loans Register".FnGetNetPayUtilizable(false);
    end;
}
