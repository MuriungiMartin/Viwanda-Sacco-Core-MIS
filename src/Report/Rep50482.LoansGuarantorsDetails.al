#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings

Report 50482 "Loans Guarantors Details"
{
    RDLCLayout = 'Layouts/LoansGuarantorsDetails.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Loans Guarantee Details"; "Loans Guarantee Details")
        {

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

            column(UserId; UserId)
            {
            }
            column(VarCount; VarCount)
            {
            }
            column(LoanNo_LoansGuaranteeDetails; "Loans Guarantee Details"."Loan No")
            {
            }
            column(MemberNo_LoansGuaranteeDetails; "Loans Guarantee Details"."Member No")
            {
            }
            column(Name_LoansGuaranteeDetails; "Loans Guarantee Details".Name)
            {
            }
            column(LoanBalance_LoansGuaranteeDetails; "Loans Guarantee Details"."Loan Balance")
            {
            }
            column(Shares_LoansGuaranteeDetails; "Loans Guarantee Details".Shares)
            {
            }
            column(NoOfLoansGuaranteed_LoansGuaranteeDetails; "Loans Guarantee Details"."No Of Loans Guaranteed")
            {
            }
            column(Substituted_LoansGuaranteeDetails; "Loans Guarantee Details".Substituted)
            {
            }
            column(Date_LoansGuaranteeDetails; "Loans Guarantee Details".Date)
            {
            }
            column(SharesRecovery_LoansGuaranteeDetails; "Loans Guarantee Details"."Shares Recovery")
            {
            }
            column(NewUpload_LoansGuaranteeDetails; "Loans Guarantee Details"."New Upload")
            {
            }
            column(AmontGuaranteed_LoansGuaranteeDetails; "Loans Guarantee Details"."Amont Guaranteed")
            {
            }
            column(StaffPayrollNo_LoansGuaranteeDetails; "Loans Guarantee Details"."Staff/Payroll No.")
            {
            }
            column(AccountNo_LoansGuaranteeDetails; "Loans Guarantee Details"."Account No.")
            {
            }
            column(SelfGuarantee_LoansGuaranteeDetails; "Loans Guarantee Details"."Self Guarantee")
            {
            }
            column(IDNo_LoansGuaranteeDetails; "Loans Guarantee Details"."ID No.")
            {
            }
            column(OutstandingBalance_LoansGuaranteeDetails; "Loans Guarantee Details"."Outstanding Balance")
            {
            }
            column(TotalLoansGuaranteed_LoansGuaranteeDetails; "Loans Guarantee Details"."Total Loans Guaranteed")
            {
            }
            column(LoansOutstanding_LoansGuaranteeDetails; "Loans Guarantee Details"."Loans Outstanding")
            {
            }
            column(GuarantorOutstanding_LoansGuaranteeDetails; "Loans Guarantee Details"."Guarantor Outstanding")
            {
            }
            column(EmployerCode_LoansGuaranteeDetails; "Loans Guarantee Details"."Employer Code")
            {
            }
            column(EmployerName_LoansGuaranteeDetails; "Loans Guarantee Details"."Employer Name")
            {
            }
            column(SubstitutedGuarantor_LoansGuaranteeDetails; "Loans Guarantee Details"."Substituted Guarantor")
            {
            }
            column(LoaneesNo_LoansGuaranteeDetails; "Loans Guarantee Details"."Loanees  No")
            {
            }
            column(LoaneesName_LoansGuaranteeDetails; "Loans Guarantee Details"."Loanees  Name")
            {
            }
            column(LoanProduct_LoansGuaranteeDetails; "Loans Guarantee Details"."Loan Product")
            {
            }
            column(EntryNo_LoansGuaranteeDetails; "Loans Guarantee Details"."Entry No.")
            {
            }
            column(LoanApplicationDate_LoansGuaranteeDetails; "Loans Guarantee Details"."Loan Application Date")
            {
            }
            column(FreeShares_LoansGuaranteeDetails; "Loans Guarantee Details"."Free Shares")
            {
            }
            column(LineNo_LoansGuaranteeDetails; "Loans Guarantee Details"."Line No")
            {
            }
            column(MemberCell_LoansGuaranteeDetails; "Loans Guarantee Details"."Member Cell")
            {
            }
            column(Sharecapital_LoansGuaranteeDetails; "Loans Guarantee Details"."Share capital")
            {
            }
            column(TotalLoanGuaranteed_LoansGuaranteeDetails; "Loans Guarantee Details"."TotalLoan Guaranteed")
            {
            }
            column(Totals_LoansGuaranteeDetails; "Loans Guarantee Details".Totals)
            {
            }
            column(Shares3_LoansGuaranteeDetails; "Loans Guarantee Details"."Shares *3")
            {
            }
            column(Depositsvariance_LoansGuaranteeDetails; "Loans Guarantee Details"."Deposits variance")
            {
            }
            column(DefaulterLoanInstallments_LoansGuaranteeDetails; "Loans Guarantee Details"."Defaulter Loan Installments")
            {
            }
            column(DefaulterLoanRepayment_LoansGuaranteeDetails; "Loans Guarantee Details"."Defaulter Loan Repayment")
            {
            }
            column(ExemptDefaulterLoan_LoansGuaranteeDetails; "Loans Guarantee Details"."Exempt Defaulter Loan")
            {
            }
            column(AdditionalDefaulterAmount_LoansGuaranteeDetails; "Loans Guarantee Details"."Additional Defaulter Amount")
            {
            }
            column(TotalGuaranteed_LoansGuaranteeDetails; "Loans Guarantee Details"."Total Guaranteed")
            {
            }
            column(TotalCommittedShares_LoansGuaranteeDetails; "Loans Guarantee Details"."Total Committed Shares")
            {
            }
            column(OustandingInterest_LoansGuaranteeDetails; "Loans Guarantee Details"."Oustanding Interest")
            {
            }
            column(LoanRiskAmount_LoansGuaranteeDetails; "Loans Guarantee Details"."Loan Risk Amount")
            {
            }
            column(TotalLoanRisk_LoansGuaranteeDetails; "Loans Guarantee Details"."Total Loan Risk")
            {
            }
            column(TotalAmountGuaranteed_LoansGuaranteeDetails; "Loans Guarantee Details"."Total Amount Guaranteed")
            {
            }
            column(ApprovalToken_LoansGuaranteeDetails; "Loans Guarantee Details"."Approval Token")
            {
            }
            column(AcceptanceStatus_LoansGuaranteeDetails; "Loans Guarantee Details"."Acceptance Status")
            {
            }
            column(DateAccepted_LoansGuaranteeDetails; "Loans Guarantee Details"."Date Accepted")
            {
            }
            trigger OnPreDataItem();
            begin
                Company.Get;
                Company.CalcFields(Company.Picture);
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
        ;


    end;

    trigger OnPostReport()
    begin
        ;

    end;

    trigger OnPreReport()
    begin
        ;

    end;

    var
        Company: Record "Company Information";
        VarCount: Integer;

    var
}
