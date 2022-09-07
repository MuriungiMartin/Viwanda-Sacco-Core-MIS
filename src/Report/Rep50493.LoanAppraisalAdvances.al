
Report 50493 "Loan Appraisal-Advances"
{
    RDLCLayout = 'Layouts/LoanAppraisal-Advances.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Loans Register"; "Loans Register")
        {
            DataItemTableView = sorting("Loan  No.");
            RequestFilterFields = "Loan  No.";
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
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
            column(Loans__Application_Date_; "Loans Register"."Application Date")
            {
            }
            column(Psalary; Psalary)
            {
            }
            column(JazaDeposits; "Loans Register"."Jaza Deposits")
            {
            }
            column(DepositReinstatement; "Loans Register"."Deposit Reinstatement")
            {
            }
            column(LoanProcessingFee; LPFcharge)
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
            column(SaccoInt; SaccoInt)
            {
            }
            column(LApplicationFee; LApplicationFee)
            {
            }
            column(IntCapitalized; IntCapitalized)
            {
            }
            column(TotalLoanBal; TotalLoanBal)
            {
            }
            column(Upfronts; "Loans Register".Upfronts)
            {
            }
            column(LoaProcessingFee; LoanProcessing)
            {
            }
            column(PrincipalAmountGlobal; PrincipalAmountGlobal)
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
            column(BoostedAmountInterest_LoansRegister; "Loans Register"."Boosted Amount Interest")
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
            column(Cust_Name; Cust.Name)
            {
            }
            column(ClientName_LoansRegister; "Loans Register"."Client Name")
            {
            }
            column(AccountNo_LoansRegister; "Loans Register"."Account No")
            {
            }
            column(Loans__Requested_Amount_; "Loans Register"."Requested Amount")
            {
            }
            column(Loans__Staff_No_; "Loans Register"."Staff No")
            {
            }
            column(NetSalary; NetSalary)
            {
            }
            column(Approved_Amounts; "Loans Register"."Approved Amount")
            {
            }
            column(Reccom_Amount; Recomm)
            {
            }
            column(LOANBALANCE; LOANBALANCE)
            {
            }
            column(Loans_Installments; "Loans Register".Installments)
            {
            }
            column(Loans__No__Of_Guarantors_; "Loans Register"."No. Of Guarantors")
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
            column(Cust_Name_Control1102760142; Cust.Name)
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
            column(MinDepositAsPerTier_Loans; "Loans Register"."Min Deposit As Per Tier")
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
            column(NHIF; "Loans Register".NHIF)
            {
            }
            column(PAYE; "Loans Register".PAYE)
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
            column(ShareBoostComm; ShareBoostComm)
            {
            }
            column(LoanInsurance; LoanInsurance)
            {
            }
            column(SMSFEE; SMSFEE)
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
            column(LoanTransferFee; LoanTransferFee)
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
            column(GGGG; "Loans Register"."No. Of Guarantors")
            {
            }
            column(BoostedAmount_LoansRegister; "Loans Register"."Boosted Amount")
            {
            }
            column(BoostingCommision_LoansRegister; "Loans Register"."Boosting Commision")
            {
            }
            dataitem("Loan GuarantorsFOSA"; "Loan GuarantorsFOSA")
            {
                DataItemLink = "Loan No" = field("Loan  No.");

                column(Amont_Guarant; "Loan GuarantorsFOSA"."Loan No")
                {
                }
                column(AccountNo_LoanGuarantorsFOSA; "Loan GuarantorsFOSA"."Account No.")
                {
                }
                column(Names_LoanGuarantorsFOSA; "Loan GuarantorsFOSA".Names)
                {
                }
                column(EmployerCode_LoanGuarantorsFOSA; "Loan GuarantorsFOSA"."Employer Code")
                {
                }
                column(EmployerName_LoanGuarantorsFOSA; "Loan GuarantorsFOSA"."Employer Name")
                {
                }
                column(Signed_LoanGuarantorsFOSA; "Loan GuarantorsFOSA".Signed)
                {
                }
                column(GuarantorOutstanding_LoanGuarantorsFOSA; "Loan GuarantorsFOSA"."Guarantor Outstanding")
                {
                }
                column(AmountGuaranted_LoanGuarantorsFOSA; "Loan GuarantorsFOSA"."Amount Guaranted")
                {
                }
                column(Distribution_LoanGuarantorsFOSA; "Loan GuarantorsFOSA"."Distribution (%)")
                {
                }
                column(DistributionAmount_LoanGuarantorsFOSA; "Loan GuarantorsFOSA"."Distribution (Amount)")
                {
                }
                column(PnUmber; "Loan GuarantorsFOSA"."Staff/Payroll No.")
                {
                }
                column(Substituted_LoanGuarantorsFOSA; "Loan GuarantorsFOSA".Substituted)
                {
                }
                column(LineNo_LoanGuarantorsFOSA; "Loan GuarantorsFOSA"."Line No")
                {
                }
                column(Date_LoanGuarantorsFOSA; "Loan GuarantorsFOSA".Date)
                {
                }
                column(SelfGuarantee_LoanGuarantorsFOSA; "Loan GuarantorsFOSA"."Self Guarantee")
                {
                }
                column(GShares_TGuaranteedAmount2; GShares - TGuaranteedAmount)
                {
                }
                trigger OnAfterGetRecord();
                begin
                    if CustRecord.Get("Loan GuarantorsFOSA"."Account No.") then begin
                        //CustRecord.CALCFIELDS(CustRecord."Current Savings",CustRecord."Principal Balance");
                        TShares := TShares + CustRecord."Current Savings";
                        TLoans := TLoans + CustRecord."Principal Balance";
                    end;
                    //GuaranteedAmount:=0;
                    LoanG.Reset;
                    LoanG.SetRange(LoanG."Account No.", "Account No.");
                    if LoanG.Find('-') then begin
                        repeat
                            LoanG.CalcFields(LoanG."Outstanding Balance", LoanG."Guarantor Outstanding");
                            if LoanG."Outstanding Balance" > 0 then begin
                                GuaranteedAmount := GuaranteedAmount + LoanG."Amount Guaranted";
                                GuarOutstanding := LoanG."Guarantor Outstanding";
                            end;
                        until LoanG.Next = 0;
                    end;
                    TGuaranteedAmount := TGuaranteedAmount + GuaranteedAmount;
                end;

            }
            dataitem("Loan Offset Details"; "Loan Offset Details")
            {
                DataItemLink = "Loan No." = field("Loan  No.");

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
                column(Loans_Top_up__Principle_Top_Up__Control1102760116; "Loan Offset Details"."Principle Top Up")
                {
                }
                column(BrTopUpCom; BrTopUpCom)
                {
                }
                column(TOTALBRIDGED; TOTALBRIDGED)
                {
                }
                column(Loans_Top_up__Total_Top_Up__Control1102755050; "Loan Offset Details"."Total Top Up")
                {
                }
                column(Loans_Top_up_Commision_Control1102755053; "Loan Offset Details".Commision)
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
                column(Recomm_TOTALBRIDGED2; Recomm - TOTALBRIDGED)
                {
                }
                trigger OnPreDataItem();
                begin
                    BrTopUpCom := 0;
                    TOTALBRIDGED := 0;
                end;

                trigger OnAfterGetRecord();
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

            }
            trigger OnPreDataItem();
            begin
                CompanyInfo.Get();
                CompanyInfo.CalcFields(CompanyInfo.Picture);
            end;

            trigger OnAfterGetRecord();
            begin
                Cshares := 0;
                MAXAvailable := 0;
                LOANBALANCE := 0;
                TotalTopUp := 0;
                TotalIntPayable := 0;
                GTotals := 0;
                AmountGuaranteed := 0;
                TotLoans := 0;
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
                //NtTakeHome:=0;
                //NetDisburment:=0;
                TotalRepay := 0;
                //  Deposits analysis
                if Cust.Get("Loans Register"."Client Code") then begin
                    Cust.CalcFields(Cust."Current Shares");
                    Cshares := Cust."Current Shares";
                    if LoanType.Get("Loans Register"."Loan Product Type") then begin
                        //QUALIFICATION AS PER DEPOSITS
                        DEpMultiplier := LoanType."Shares Multiplier" * (Cshares + "Deposit Reinstatement");
                        DEpMultiplier := LoanType."FOSA Loan Shares Ratio" * Cshares;
                        BridgedRepayment := 0;
                        TotalRepayments := 0;
                        LoanApp.Reset;
                        LoanApp.SetRange(LoanApp."Client Code", "Client Code");
                        LoanApp.SetRange(LoanApp.Source, LoanApp.Source::" ");
                        LoanApp.SetRange(LoanApp.Posted, true);
                        if LoanApp.Find('-') then begin
                            repeat
                                LoanApp.CalcFields(LoanApp."Outstanding Balance", LoanApp."Total Repayments", LoanApp."Total Interest", "Offset Commission");
                                if LoanApp."Outstanding Balance" > 0 then begin
                                    LOANBALANCE := LOANBALANCE + LoanApp."Outstanding Balance";
                                    TotalRepayments := TotalRepayments + LoanApp.Repayment;
                                end;
                            until LoanApp.Next = 0;
                        end;
                    end;
                    LoanTopUp.Reset;
                    LoanTopUp.SetRange(LoanTopUp."Loan No.", "Loans Register"."Loan  No.");
                    LoanTopUp.SetRange(LoanTopUp."Client Code", "Loans Register"."Client Code");
                    if LoanTopUp.Find('-') then begin
                        repeat
                            //BRIGEDAMOUNT:=BRIGEDAMOUNT+LoanTopUp."Principle Top Up";
                            BRIGEDAMOUNT := BRIGEDAMOUNT + LoanTopUp."Total Top Up";
                        until LoanTopUp.Next = 0;
                    end;
                    LoanTopUp.Reset;
                    LoanTopUp.SetRange(LoanTopUp."Loan No.", "Loans Register"."Loan  No.");
                    LoanTopUp.SetRange(LoanTopUp."Client Code", "Loans Register"."Client Code");
                    if LoanTopUp.Find('-') then begin
                        repeat
                            if LoanTopUp."Partial Bridged" = false then begin
                                BridgedRepayment := BridgedRepayment + LoanTopUp."Monthly Repayment";
                                FinalInst := FinalInst + LoanTopUp."Finale Instalment";
                            end;
                        until LoanTopUp.Next = 0;
                    end;
                    TotalRepayments := TotalRepayments - BridgedRepayment;
                    TotalLoanBal := (LOANBALANCE + "Loans Register"."Approved Amount") - BRIGEDAMOUNT;
                    LBalance := LOANBALANCE - BRIGEDAMOUNT;
                    //**Guarantors Loan Balances
                    "Loan GuarantorsFOSA".Reset;
                    "Loan GuarantorsFOSA".SetRange("Loan GuarantorsFOSA"."Account No.", "Account No");
                    if "Loan GuarantorsFOSA".Find('-') then begin
                        CalcFields("Outstanding Balance");
                        GuarOutstanding := "Outstanding Balance";
                    end;
                    //Qualification as per salary
                    //compute Earnings
                    SalDetails.Reset;
                    SalDetails.SetRange(SalDetails."Client Code", "Client Code");
                    SalDetails.SetRange(SalDetails.Type, SalDetails.Type::Earnings);
                    SalDetails.SetRange(SalDetails."Loan No", "Loan  No.");
                    if SalDetails.Find('-') then begin
                        repeat
                            Earnings := Earnings + SalDetails.Amount;
                        until SalDetails.Next = 0;
                    end;
                    //End compute Earnings
                    //compute Deduction
                    SalDetails.Reset;
                    SalDetails.SetRange(SalDetails."Client Code", "Client Code");
                    SalDetails.SetRange(SalDetails.Type, SalDetails.Type::Deductions);
                    SalDetails.SetRange(SalDetails."Loan No", "Loan  No.");
                    if SalDetails.Find('-') then begin
                        repeat
                            Deductions := Deductions + SalDetails.Amount;
                        until SalDetails.Next = 0;
                    end;
                    //****Computes 1/3 Rule Based on Basic Salary Only*****
                    SalDetails.Reset;
                    SalDetails.SetRange(SalDetails."Client Code", Loans."Client Code");
                    SalDetails.Code := 'Basic';
                    if SalDetails.Find('-') then begin
                        BasicEarnings := (BasicEarnings + SalDetails.Amount);
                    end;
                    //2Thirds
                    TwoThirds := ROUND((Earnings - StatDeductions) * 2 / 3, 0.05, '>');
                    ATHIRD := ROUND((Earnings - StatDeductions) * 1 / 3, 0.05, '>');
                    //NtTakeHome:=TwoThirds-(TotalRepayments+Totalinterest+Loans.Repayment+Band);
                    //Psalary:=TwoThirds-(TotalRepayments+Band+Deductions);
                    //Ollin
                    salary := "Gross Pay";  //+("Non Payroll Payments"+"Bridge Amount Release");  //("Gross Pay"-"Total DeductionsH"-"Net take Home")+("Non Payroll Payments"+"Bridge Amount Release");
                    Psalary := (salary * 100 * Loans.Installments) / (100 + Loans.Installments);
                    LoanG.Reset;
                    LoanG.SetRange(LoanG."Loan No", "Loan  No.");
                    if LoanG.Find('-') then begin
                        LoanG.CalcSums(LoanG."Amount Guaranted");
                        GShares := LoanG."Amount Guaranted";
                    end;
                    TotalGuaranteed := GShares;
                    MaximumEligible := "Loans Register"."Net Utilizable Amount";
                    if MaximumEligible > "Loans Register"."Least Retained Amount" then
                        MaximumEligible := "Loans Register"."Least Retained Amount";//
                                                                                    //P=200XT/(200+R(T+1)) For Nafaka
                    PrincipalAmountGlobal := ROUND(200 * MaximumEligible * Installments / (200 + ("Loans Register".Interest / 12) * (Installments + 1)), 100, '<');
                    if "Loans Register"."Repayment Method" = "Loans Register"."repayment method"::Amortised then
                        PrincipalAmountGlobal := MaximumEligible * ((Power((1 + "Loans Register".Interest / 1200), Installments) - 1) / (("Loans Register".Interest / 1200) * (Power((1 + "Loans Register".Interest / 1200), Installments))));
                    DepX := (DEpMultiplier);//-(LBalance-FinalInst);
                    Riskamount := "Loans Register"."Requested Amount" - MAXAvailable;
                    Message('#Requested Amount=%1, #Total Deposits=%2 #Guarantorsip Amount=%3 #Qualification by Salary=%4  #Total Boosted Deposits=%5..***Recommended Amount=%6***',
                    "Loans Register"."Requested Amount", DepX, TotalGuaranteed, ROUND(PrincipalAmountGlobal, 0.05, '<'), "Loans Register"."Boosted Amount",
                    ROUND(FnReccommendAmount("Loans Register"."Requested Amount", DepX, TotalGuaranteed, PrincipalAmountGlobal), 100, '<'));
                    Recomm := ROUND(FnReccommendAmount("Loans Register"."Requested Amount", DepX, TotalGuaranteed, PrincipalAmountGlobal), 100, '<'); //Introduced on 28th sep 2017 To Hadnle Amortized Loans;
                    "Recommended Amount" := ROUND(Recomm, 100, '<');
                    "Approved Amount" := ROUND(Recomm, 100, '<');
                    if "Loans Register".Posted = false then
                        "Loans Register".Modify;
                    if (("Loans Register"."Recommended Amount" / 8) > "Loans Register"."Shares Balance") then begin
                        "Loans Register"."Boosted Amount" := ("Loans Register"."Recommended Amount" / 8) - "Loans Register"."Shares Balance";
                        "Loans Register"."Boost this Loan" := true;
                        Validate("Loans Register"."Boost this Loan");
                    end else begin
                        "Boosted Amount" := 0;
                        "Boosting Commision" := 0;
                        "Boost this Loan" := false;
                        "Boosted Amount Interest" := 0;
                        Validate("Loans Register"."Boost this Loan");
                    end;
                    if "Loans Register".Posted = false then
                        Modify;
                    //Compute monthly Repayments based on repay method
                    TotalMRepay := 0;
                    LPrincipal := 0;
                    LInterest := 0;
                    LoanAmount := 0;
                    InterestRate := Interest;
                    LoanAmount := "Approved Amount";
                    RepayPeriod := Installments;
                    LBalance := "Approved Amount";
                    //Repayments for amortised method
                    if "Repayment Method" = "repayment method"::Amortised then begin
                        //TESTFIELD(Interest);
                        //TESTFIELD(Installments);
                        //TotalMRepay:=ROUND((InterestRate/12/100) / (1 - POWER((1 + (InterestRate/12/100)),- RepayPeriod)) * LoanAmount,1,'>');
                        //LInterest:=ROUND(LBalance / 100 / 12 * InterestRate,0.05,'>');
                        LPrincipal := TotalMRepay - LInterest;
                        "Loan Principle Repayment" := LPrincipal;
                        "Loan Interest Repayment" := LInterest;
                        Repayment := LPrincipal + LInterest;
                    end;
                    "Loan GuarantorsFOSA".Reset;
                    "Loan GuarantorsFOSA".SetRange("Loan GuarantorsFOSA"."Loan No", "Loans Register"."Loan  No.");
                    if "Loan GuarantorsFOSA".Find('-') then begin
                        "Loan GuarantorsFOSA".CalcSums("Loan GuarantorsFOSA"."Amount Guaranted");
                        TGAmount := "Loan GuarantorsFOSA"."Amount Guaranted";
                    end;
                    LoanApp.Reset;
                    LoanApp.SetRange(LoanApp."Loan  No.", "Loan  No.");
                    if LoanApp.Find('-') then begin
                        LoanApp.CalcFields(LoanApp."Offset Commission");
                    end;
                    if LoanApp."Member Category" = LoanApp."member category"::Private then begin
                        Cust.Reset;
                        Cust.SetRange(Cust."No.", "Client Code");
                        if Cust.Find('-') then begin
                            "Employer Code" := Cust."Employer Code";
                            Modify;
                        end;
                    end;
                    Upfronts := 0;
                    GenSetUp.Get();
                    ProcessingFee := SFactory.FnGetChargeFee("Loan Product Type", "Approved Amount", 'LPF');
                    BRIGEDAMOUNT := BRIGEDAMOUNT;
                    BRIDGEBAL := BRIGEDAMOUNT;
                    Upfronts := SFactory.FnGetUpfrontsTotal(LoanApp."Loan Product Type", LoanApp."Requested Amount") + LoanApp."Boosted Amount" + "Boosting Commision" + BRIGEDAMOUNT + LoanApp."Boosted Amount Interest";
                    Netdisbursed := "Approved Amount" - Upfronts;
                    if "Loans Register".Posted = false then
                        Modify;
                    if ("Loans Register"."Expected Date of Completion" > FnReturnRetirementDate("Loans Register"."BOSA No")) then
                        Message('The Member retirement date will come earlier than the Expected Date of Completion (%1).The Member is due to retire on %2: Risk', "Loans Register"."Expected Date of Completion", FnReturnRetirementDate("Loans Register"."Client Code"));
                    TotalMRepay := 0;
                    LPrincipal := 0;
                    LInterest := 0;
                    InterestRate := Interest;
                    LoanAmount := "Approved Amount";
                    RepayPeriod := Installments;
                    LBalance := "Approved Amount";
                    if "Repayment Method" = "repayment method"::"Straight Line" then begin
                        TestField(Installments);
                        LPrincipal := ROUND(LoanAmount / RepayPeriod, 1, '>');
                        LInterest := ROUND((InterestRate / 12 / 100) * LoanAmount, 1, '>');
                        Repayment := LPrincipal + LInterest;
                        Modify;
                    end;
                    //Monthly Interest Formula PR(T+1)/200T
                    if "Repayment Method" = "repayment method"::"Reducing Balance" then begin
                        TestField(Interest);
                        TestField(Installments);
                        LPrincipal := ROUND(LoanAmount / RepayPeriod, 1, '>');
                        LInterest := ROUND(Recomm * "Loans Register".Interest / 12 * (RepayPeriod + 1) / (200 * RepayPeriod), 1, '>');//ROUND((InterestRate/12/100)*LBalance,0.05,'>');
                        Message('Monthly Interest Repayment=%1, Monthly Principal Repayment=%2, ****Total Monthly Repayment=%3***', LInterest, LPrincipal, LPrincipal + LInterest);
                        Repayment := LPrincipal + LInterest;
                        "Loan Principle Repayment" := LPrincipal;
                        "Loan Interest Repayment" := LInterest;
                        Modify;
                    end;
                    if "Repayment Method" = "repayment method"::Amortised then begin
                        TotalMRepay := ROUND((InterestRate / 12 / 100) / (1 - Power((1 + (InterestRate / 12 / 100)), -RepayPeriod)) * LoanAmount, 1, '>');
                        LInterest := ROUND(LBalance / 100 / 12 * InterestRate, 0.05, '>');
                        LPrincipal := TotalMRepay - LInterest;
                        "Loan Principle Repayment" := LPrincipal;
                        "Loan Interest Repayment" := LInterest;
                        "Approved Repayment" := TotalMRepay;
                        Repayment := LPrincipal + LInterest;
                        Modify;
                    end;
                    //"Recommended Amount":=Recomm;
                    "Approved Amount" := Recomm;
                    "Loans Register".Modify;
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
                end;
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

        end;
    }

    trigger OnInitReport()
    begin
        //IF LoanType."Min No. Of Guarantors" < 10 THEN ERROR('Kindly add More guarantors');
        ;


    end;

    trigger OnPostReport()
    begin
        ;

    end;

    trigger OnPreReport()
    begin
        if GenSetUp.Get(0) then
            CompanyInfo.Get;
        ;

    end;

    var
        CustRec: Record "Members Register";
        GenSetUp: Record "Sacco General Set-Up";
        Cust: Record "Members Register";
        CustRecord: Record "Members Register";
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
        LoanG: Record "Loan GuarantorsFOSA";
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
        Comment______________________________________Caption_Control1102755070Lbl: label 'Comment :____________________________________________________________________________________';
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
        CustDiv: Record "Members Register";
        DivProg: Record "Dividends Progression";
        CDiv: Decimal;
        BDate: Date;
        CustR: Record "Members Register";
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
        CustLeg: Record "Member Ledger Entry";
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
        LoanProcessing: Decimal;
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
        LApplicationFee: Decimal;
        IntCapitalized: Decimal;
        IntCapitalizationFactor: Integer;
        TotalGuaranteed: Decimal;
        PrincipalAmountGlobal: Decimal;
        MaximumEligible: Decimal;
        SFactory: Codeunit "SURESTEP Factory";

    procedure ComputeTax()
    begin
    end;

    local procedure FnReccommendAmount(RequestedAmount: Decimal; QShares: Decimal; QGuarantors: Decimal; QSalary: Decimal) RecommendedAmount: Decimal
    begin
        RecommendedAmount := RequestedAmount;
        if RecommendedAmount > QSalary then
            RecommendedAmount := QSalary;
        //IF RecommendedAmount > QShares THEN
        //  RecommendedAmount:=QShares;//Uncomment this for BOSA Loans
        //IF RecommendedAmount > QGuarantors THEN
        //  RecommendedAmount:=QGuarantors;//Uncomment this for BOSA Loans
        exit(RecommendedAmount);
    end;

    local procedure FnReturnRetirementDate(MemberNo: Code[50]): Date
    var
        ObjMembers: Record "Members Register";
    begin
        GenSetUp.Get();
        ObjMembers.Reset;
        ObjMembers.SetRange(ObjMembers."No.", MemberNo);
        if ObjMembers.Find('-') then
            exit(CalcDate(GenSetUp."Retirement Age", ObjMembers."Date of Birth"));
    end;

    var

}
