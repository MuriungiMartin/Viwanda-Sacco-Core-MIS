
Report 50541 "Unallocated Funds"
{
    RDLCLayout = 'Layouts/UnallocatedFunds.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = where("Un-allocated Funds" = filter(<> 0));
            RequestFilterFields = "FOSA Account No.", "Loan Product Filter", "Outstanding Balance", "Date Filter";

            column(UserId; UserId)
            {
            }
            column(PayrollStaffNo_Members; Customer."Payroll No")
            {
            }
            column(No_Members; Customer."No.")
            {
            }
            column(Name_Members; Customer.Name)
            {
            }
            column(EmployerCode_Members; Customer."Employer Code")
            {
            }
            column(EmployerName; EmployerName)
            {
            }

            column(Shares_Retained; Customer."Shares Retained")
            {
            }
            column(ShareCapBF; ShareCapBF)
            {
            }
            column(IDNo_Members; Customer."ID No.")
            {
            }
            column(GlobalDimension2Code_Members; Customer."Global Dimension 2 Code")
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
            dataitem(UnallocatedFunds; "Member Ledger Entry")
            {
                DataItemLink = "Customer No." = field("No."), "Posting Date" = field("Date Filter");
                DataItemTableView = sorting("Posting Date") order(ascending) where("Transaction Type" = filter("Loan Insurance Paid"));

                column(PostingDate_UnallocatedFunds; UnallocatedFunds."Posting Date")
                {
                }
                column(DocumentNo_UnallocatedFunds; UnallocatedFunds."Document No.")
                {
                }
                column(Description_UnallocatedFunds; UnallocatedFunds.Description)
                {
                }
                column(DebitAmount_UnallocatedFunds; UnallocatedFunds."Debit Amount")
                {
                }
                column(CreditAmount_UnallocatedFunds; UnallocatedFunds."Credit Amount")
                {
                }
                column(Amount_UnallocatedFunds; UnallocatedFunds.Amount)
                {
                }
                column(openBalance_UnallocatedFunds; OpenBalance)
                {
                }
                column(CLosingBalance_UnallocatedFunds; CLosingBalance)
                {
                }
                column(TransactionType_UnallocatedFunds; UnallocatedFunds."Transaction Type")
                {
                }
                column(LoanNo; UnallocatedFunds."Loan No")
                {
                }
                column(PrincipleBF_UnallocatedFunds; PrincipleBF)
                {
                }
                column(UnallocatedFunds_Description; UnallocatedFunds.Description)
                {
                }
                column(User7; UnallocatedFunds."User ID")
                {
                }
                trigger OnPreDataItem();
                begin
                    CLosingBalance := PrincipleBF;
                    OpeningBal := PrincipleBF;
                end;

                trigger OnAfterGetRecord();
                begin
                    /*{CLosingBalance:=CLosingBalance+loan.Amount;
					ClosingBalInt:=ClosingBalInt+loan.Amount;
					//interest
					ClosingBal:=ClosingBal+LoanInterest.Amount;
					OpeningBal:=ClosingBal-LoanInterest.Amount;
					}
					CLosingBalance:=CLosingBalance+loan.Amount;
					IF Loans."Loan  No."='' THEN BEGIN
					END;
					IF loan."Transaction Type"=loan."Transaction Type"::"Interest Paid" THEN BEGIN
					InterestPaid:=loan."Credit Amount";
					SumInterestPaid:=InterestPaid+SumInterestPaid;
					END;
					IF loan."Transaction Type"=loan."Transaction Type"::Repayment THEN BEGIN
					 loan."Credit Amount":=loan."Credit Amount"//+InterestPaid;
					 END;
					 */

                end;

            }
            trigger OnPreDataItem();
            begin
                if Customer.GetFilter(Customer."Date Filter") <> '' then
                    DateFilterBF := '..' + Format(CalcDate('-1D', Customer.GetRangeMin(Customer."Date Filter")));
            end;

            trigger OnAfterGetRecord();
            begin
                SaccoEmp.Reset;
                SaccoEmp.SetRange(SaccoEmp.Code, Customer."Employer Code");
                if SaccoEmp.Find('-') then
                    EmployerName := SaccoEmp.Description;
                SharesBF := 0;
                InsuranceBF := 0;
                ShareCapBF := 0;
                RiskBF := 0;
                HseBF := 0;
                Dep1BF := 0;
                Dep2BF := 0;
                if DateFilterBF <> '' then begin
                    Cust.Reset;
                    Cust.SetRange(Cust."No.", "No.");
                    Cust.SetFilter(Cust."Date Filter", DateFilterBF);
                    if Cust.Find('-') then begin
                        Cust.CalcFields(Cust."Shares Retained", Cust."Current Shares", Cust."Insurance Fund");
                        SharesBF := Cust."Current Shares";
                        ShareCapBF := Cust."Shares Retained";
                        RiskBF := Cust."Insurance Fund";
                        //*********************gray
                        //XmasBF:=Cust."Holiday Savings";
                        //HseBF:=Cust."Household Item Deposit";
                        //Dep1BF:=Cust."Dependant 1";
                        //Dep2BF:=Cust."Dependant 2";
                    end;
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
        ;


    end;

    trigger OnPostReport()
    begin
        ;

    end;

    trigger OnPreReport()
    begin
        Company.Get();
        Company.CalcFields(Company.Picture);
        ;

    end;

    var
        OpenBalance: Decimal;
        CLosingBalance: Decimal;
        OpenBalanceXmas: Decimal;
        CLosingBalanceXmas: Decimal;
        Cust: Record Customer;
        OpeningBal: Decimal;
        ClosingBal: Decimal;
        FirstRec: Boolean;
        PrevBal: Integer;
        BalBF: Decimal;
        LoansR: Record "Loans Register";
        DateFilterBF: Text[150];
        SharesBF: Decimal;
        InsuranceBF: Decimal;
        LoanBF: Decimal;
        PrincipleBF: Decimal;
        InterestBF: Decimal;
        ShowZeroBal: Boolean;
        ClosingBalSHCAP: Decimal;
        ShareCapBF: Decimal;
        RiskBF: Decimal;
        DividendBF: Decimal;
        Company: Record "Company Information";
        OpenBalanceHse: Decimal;
        CLosingBalanceHse: Decimal;
        OpenBalanceDep1: Decimal;
        CLosingBalanceDep1: Decimal;
        OpenBalanceDep2: Decimal;
        CLosingBalanceDep2: Decimal;
        HseBF: Decimal;
        Dep1BF: Decimal;
        Dep2BF: Decimal;
        OpeningBalInt: Decimal;
        ClosingBalInt: Decimal;
        InterestPaid: Decimal;
        SumInterestPaid: Decimal;
        OpenBalanceRisk: Decimal;
        CLosingBalanceRisk: Decimal;
        OpenBalanceDividend: Decimal;
        ClosingBalanceDividend: Decimal;
        OpenBalanceHoliday: Decimal;
        ClosingBalanceHoliday: Decimal;
        LoanSetup: Record "Loan Products Setup";
        LoanName: Text[50];
        SaccoEmp: Record "Sacco Employers";
        EmployerName: Text[100];

    var

}