Report 50528 "Loans Repayment Schedule-Calc"
{
    RDLCLayout = 'Layouts/LoansRepaymentSchedule-Calc.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Loan Calculator"; "Loan Calculator")
        {
            PrintOnlyIfDetail = false;

            column(LoanDisbursementDate_LoanCalculator; "Loan Calculator"."Loan Disbursement Date")
            {
            }
            column(Installments_LoanCalculator; "Loan Calculator".Installments)
            {
            }
            column(Interestrate_LoanCalculator; "Loan Calculator"."Interest rate")
            {
            }
            column(RequestedAmount_LoanCalculator; "Loan Calculator"."Requested Amount")
            {
            }
            column(LoanProductType_LoanCalculator; "Loan Calculator"."Loan Product Type")
            {
            }
            column(MemberNo_LoanCalculator; "Loan Calculator"."Member No")
            {
            }
            column(MemberName_LoanCalculator; "Loan Calculator"."Member Name")
            {
            }
            column(RepaymentMethod_LoanCalculator; "Loan Calculator"."Repayment Method")
            {
            }
            column(INST; INST)
            {
            }
            column(CompanyInfo_Name; CompanyInfo.Name)
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
            dataitem("Loan Repay Schedule-Calc"; "Loan Repay Schedule-Calc")
            {
                DataItemLink = "Loan No." = field("Member No");
                PrintOnlyIfDetail = false;

                column(ROUND__Monthly_Repayment__10_____; ROUND("Loan Repay Schedule-Calc"."Monthly Repayment", 1, '>'))
                {
                }
                column(FORMAT__Repayment_Date__0_4_; Format("Loan Repay Schedule-Calc"."Repayment Date", 0, 4))
                {
                }
                column(ROUND__Principal_Repayment__10_____; ROUND("Loan Repay Schedule-Calc"."Principal Repayment", 1, '>'))
                {
                }
                column(ROUND__Monthly_Interest__10_____; ROUND("Loan Repay Schedule-Calc"."Monthly Interest", 1, '>'))
                {
                }
                column(LoanBalance; ROUND(LoanBalance, 1, '>'))
                {
                }
                column(Loan_Repayment_Schedule__Repayment_Code_; "Loan Repay Schedule-Calc"."Repayment Code")
                {
                }
                column(ROUND__Monthly_Repayment__10______Control1000000043; "Loan Repay Schedule-Calc"."Monthly Repayment")
                {
                }
                column(ROUND__Principal_Repayment__10______Control1000000014; "Loan Repay Schedule-Calc"."Principal Repayment")
                {
                }
                column(ROUND__Monthly_Interest__10______Control1000000015; "Loan Repay Schedule-Calc"."Monthly Interest")
                {
                }
                column(Monthly_RepaymentCaption; Monthly_RepaymentCaptionLbl)
                {
                }
                column(InterestCaption; InterestCaptionLbl)
                {
                }
                column(Principal_RepaymentCaption; Principal_RepaymentCaptionLbl)
                {
                }
                column(Due_DateCaption; Due_DateCaptionLbl)
                {
                }
                column(Loan_BalanceCaption; Loan_BalanceCaptionLbl)
                {
                }
                column(Loan_RepaymentCaption; Loan_RepaymentCaptionLbl)
                {
                }
                column(TotalCaption; TotalCaptionLbl)
                {
                }
                column(Loan_Repayment_Schedule_Loan_No_; "Loan Repay Schedule-Calc"."Loan No.")
                {
                }
                column(Loan_Repayment_Schedule_Member_No_; "Loan Repay Schedule-Calc"."Member No.")
                {
                }
                column(Loan_Repayment_Schedule_Repayment_Date; "Loan Repay Schedule-Calc"."Repayment Date")
                {
                }
                column(RepaymentCode; "Loan Repay Schedule-Calc"."Instalment No")
                {
                }
                trigger OnPreDataItem();
                begin
                    LastFieldNo := FieldNo("Member No.");
                    i := 0;
                    j := 0;
                end;

                trigger OnAfterGetRecord();
                begin
                    /*Cust.RESET;
					Cust.SETRANGE(Cust."No.","Loans Register"."Employer Code");
					IF Cust.FIND('-') THEN BEGIN
					EmployerName:=Cust.Name;
					END;*/
                    i := i + 1;
                    TotalPrincipalRepayment := ROUND(TotalPrincipalRepayment + "Loan Repay Schedule-Calc"."Principal Repayment");
                    if i = 1 then
                        LoanBalance := ("Loan Repay Schedule-Calc"."Loan Amount")
                    else begin
                        LoanBalance := ("Loan Repay Schedule-Calc"."Loan Amount" - TotalPrincipalRepayment +
                        "Loan Repay Schedule-Calc"."Principal Repayment");
                    end;
                    CumInterest := ROUND(CumInterest + "Loan Repay Schedule-Calc"."Monthly Interest");
                    CumMonthlyRepayment := ROUND(CumMonthlyRepayment + "Loan Repay Schedule-Calc"."Monthly Repayment");
                    CumPrincipalRepayment := ROUND(CumPrincipalRepayment + "Loan Repay Schedule-Calc"."Principal Repayment");

                end;

            }
            trigger OnPreDataItem();
            begin
                CompanyInfo.Get();
                CompanyInfo.CalcFields(CompanyInfo.Picture);
            end;

            trigger OnAfterGetRecord();
            begin
                BankDetails := '';
                if LoanCategory.Get("Loan Calculator"."Loan Product Type") then
                    BankDetails := LoanCategory."Bank Account Details";
                INST := "Loan Calculator".Installments;
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
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        TotalFor: label 'Total for ';
        Duration: Integer;
        MemberLoan: Record Customer;
        IssuedDate: Date;
        LoanCategory: Record "Loan Products Setup";
        i: Integer;
        LoanBalance: Decimal;
        CumInterest: Decimal;
        CumMonthlyRepayment: Decimal;
        CumPrincipalRepayment: Decimal;
        j: Integer;
        LoanApp: Record "Loans Register";
        GroupName: Text[70];
        TotalPrincipalRepayment: Decimal;
        Rate: Decimal;
        BankDetails: Text[250];
        Cust: Record Customer;
        Intallments__Months_CaptionLbl: label 'Intallments (Months)';
        Disbursment_DateCaptionLbl: label 'Disbursment Date';
        Current_InterestCaptionLbl: label 'Current Interest';
        Loan_AmountCaptionLbl: label 'Loan Amount';
        Loan_ProductCaptionLbl: label 'Loan Product';
        Loan_No_CaptionLbl: label 'Loan No.';
        Account_No_CaptionLbl: label 'Account No.';
        Monthly_RepaymentCaptionLbl: label 'Monthly Repayment';
        InterestCaptionLbl: label 'Interest';
        Principal_RepaymentCaptionLbl: label 'Principal Repayment';
        Due_DateCaptionLbl: label 'Due Date';
        Loan_BalanceCaptionLbl: label 'Loan Balance';
        Loan_RepaymentCaptionLbl: label 'Loan Repayment';
        TotalCaptionLbl: label 'Total';
        EmployerName: Text;
        INST: Integer;
        CompanyInfo: Record "Company Information";

    var
}