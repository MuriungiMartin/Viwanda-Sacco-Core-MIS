
Report 50540 "Member Deposit Statement"
{
    RDLCLayout = 'Layouts/MemberDepositStatement.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Members Register"; "Members Register")
        {
            RequestFilterFields = "No.", "Loan Product Filter", "Outstanding Balance", "Date Filter", "Loan No. Filter";
            column(UserId; UserId)
            {
            }
            column(PayrollStaffNo_Members; "Members Register"."Payroll No")
            {
            }
            column(No_Members; "Members Register"."No.")
            {
            }
            column(Name_Members; "Members Register".Name)
            {
            }
            column(EmployerCode_Members; "Members Register"."Employer Code")
            {
            }
            column(EmployerName; EmployerName)
            {
            }

            column(Shares_Retained; "Members Register"."Shares Retained")
            {
            }
            column(ShareCapBF; ShareCapBF)
            {
            }
            column(IDNo_Members; "Members Register"."ID No.")
            {
            }
            column(GlobalDimension2Code_Members; "Members Register"."Global Dimension 2 Code")
            {
            }
            column(Company_Name; Company.Name)
            {
            }
            column(Company_Address; Company.Address)
            {
            }
            column(Company_Picture; Company.Picture)
            {
            }
            dataitem(Shares; "Member Ledger Entry")
            {
                DataItemLink = "Customer No." = field("No."), "Posting Date" = field("Date Filter");
                DataItemTableView = sorting("Transaction Type", "Loan No", "Posting Date") where("Transaction Type" = const("Recovery Account"));
                column(openBalances; OpenBalance)
                {
                }
                column(CLosingBalances; CLosingBalance)
                {
                }
                column(Description_Shares; Shares.Description)
                {
                }
                column(DocumentNo_Shares; Shares."Document No.")
                {
                }
                column(PostingDate_Shares; Shares."Posting Date")
                {
                }
                column(CreditAmount_Shares; Shares."Credit Amount")
                {
                }
                column(DebitAmount_Shares; Shares."Debit Amount")
                {
                }
                column(Amount_Shares; Shares.Amount)
                {
                }
                column(TransactionType_Shares; Shares."Transaction Type")
                {
                }
                column(Shares_Description; Shares.Description)
                {
                }
                column(USER1; Shares."User ID")
                {
                }
                column(ShareCapBF2; ShareCapBF)
                {
                }
                trigger OnPreDataItem();
                begin
                    CLosingBalance := ShareCapBF;
                    OpeningBal := ShareCapBF * -1;
                end;

                trigger OnAfterGetRecord();
                begin
                    CLosingBalance := CLosingBalance - Shares.Amount;
                end;

            }
            dataitem(Deposits; "Member Ledger Entry")
            {
                DataItemLink = "Customer No." = field("No."), "Posting Date" = field("Date Filter");
                DataItemTableView = where("Transaction Type" = filter(Loan));
                PrintOnlyIfDetail = false;
                column(OpeningBal; OpeningBal)
                {
                }
                column(ClosingBal; ClosingBal)
                {
                }
                column(TransactionType_Deposits; Deposits."Transaction Type")
                {
                }
                column(Amount_Deposits; Deposits.Amount)
                {
                }
                column(Description_Deposits; Deposits.Description)
                {
                }
                column(DocumentNo_Deposits; Deposits."Document No.")
                {
                }
                column(PostingDate_Deposits; Deposits."Posting Date")
                {
                }
                column(DebitAmount_Deposits; Deposits."Debit Amount")
                {
                }
                column(CreditAmount_Deposits; Deposits."Credit Amount")
                {
                }
                column(Deposits_Description; Deposits.Description)
                {
                }
                column(USER2; Deposits."User ID")
                {
                }
                trigger OnPreDataItem();
                begin
                    ClosingBal := SharesBF;
                    OpeningBal := SharesBF * -1;
                end;

                trigger OnAfterGetRecord();
                begin
                    ClosingBal := ClosingBal + Deposits.Amount;
                end;

            }
            dataitem(Dividend; "Member Ledger Entry")
            {
                DataItemLink = "Customer No." = field("No."), "Posting Date" = field("Date Filter");
                DataItemTableView = sorting("Transaction Type", "Loan No", "Posting Date") where("Transaction Type" = const("Additional Shares"));

                column(OpenBalancesDividend; OpenBalanceDividend)
                {
                }
                column(CLosingBalancesDividend; ClosingBalanceDividend)
                {
                }
                column(Description_Dividend; Dividend.Description)
                {
                }
                column(DocumentNo_Dividend; Dividend."Document No.")
                {
                }
                column(PostingDate_Dividend; Dividend."Posting Date")
                {
                }
                column(CreditAmount_Dividend; Dividend."Credit Amount")
                {
                }
                column(DebitAmount_Dividend; Dividend."Debit Amount")
                {
                }
                column(Amount_Dividend; Dividend.Amount)
                {
                }
                column(TransactionType_Dividend; Dividend."Transaction Type")
                {
                }
                column(USER3; Dividend."User ID")
                {
                }
                trigger OnPreDataItem();
                begin
                    ClosingBalanceDividend := DividendBF;
                    OpenBalanceDividend := DividendBF * -1;
                end;

                trigger OnAfterGetRecord();
                begin
                    ClosingBalanceDividend := ClosingBalanceDividend - Dividend.Amount;
                end;

            }
            dataitem(Benevolent; "Member Ledger Entry")
            {
                DataItemLink = "Customer No." = field("No."), "Posting Date" = field("Date Filter");
                DataItemTableView = sorting("Transaction Type", "Loan No", "Posting Date") where("Transaction Type" = const("Benevolent Fund"), Reversed = filter(false));
                column(OpenBalancesBenFund; OpenBalanceBenfund)
                {
                }
                column(CLosingBalancesBenFund; CLosingBalanceBenfund)
                {
                }
                column(DescriptionBenevolent; Benevolent.Description)
                {
                }
                column(DocumentNoBenevolent; Benevolent."Document No.")
                {
                }
                column(PostingDateBenevolent; Benevolent."Posting Date")
                {
                }
                column(CreditAmountBenevolent; Benevolent."Credit Amount")
                {
                }
                column(DebitAmountBenevolent; Benevolent."Debit Amount")
                {
                }
                column(AmountBenevolent; Benevolent.Amount)
                {
                }
                column(TransactionTypeBenevolent; Benevolent."Transaction Type")
                {
                }
                column(User4; Benevolent."User ID")
                {
                }
                trigger OnPreDataItem();
                begin
                    CLosingBalanceBenfund := BenFundBF;
                    OpenBalanceBenfund := BenFundBF * -1;
                end;

                trigger OnAfterGetRecord();
                begin
                    CLosingBalanceBenfund := CLosingBalanceBenfund - Benevolent.Amount;
                end;

            }
            dataitem(Risk; "Member Ledger Entry")
            {
                DataItemLink = "Customer No." = field("No."), "Posting Date" = field("Date Filter");
                //DataItemTableView = sorting("Transaction Type","Loan No","Posting Date") where("Transaction Type"=filter("44"|"45));

                column(OpenBalancesRisk; OpenBalanceRisk)
                {
                }
                column(CLosingBalancesRisk; CLosingBalanceRisk)
                {
                }
                column(DescriptionRisk; Risk.Description)
                {
                }
                column(DocumentNoRisk; Risk."Document No.")
                {
                }
                column(PostingDateRisk; Risk."Posting Date")
                {
                }
                column(CreditAmountRisk; Risk."Credit Amount")
                {
                }
                column(DebitAmountRisk; Risk."Debit Amount")
                {
                }
                column(AmountRisk; Risk.Amount)
                {
                }
                column(TransactionTypeRisk; Risk."Transaction Type")
                {
                }
                column(User5; Risk."User ID")
                {
                }
                trigger OnPreDataItem();
                begin
                    CLosingBalanceRisk := RiskBF;
                    OpenBalanceRisk := RiskBF * -1;
                end;

                trigger OnAfterGetRecord();
                begin
                    CLosingBalanceRisk := CLosingBalanceRisk - Risk.Amount;
                end;

            }
            dataitem(Loans; "Loans Register")
            {
                DataItemLink = "Client Code" = field("No."), "Loan Product Type" = field("Loan Product Filter"), "Date filter" = field("Date Filter");
                DataItemTableView = sorting("Loan  No.") where(Posted = const(true), "Loan  No." = filter(<> '"'));
                column(PrincipleBF; PrincipleBF)
                {
                }
                column(LoanNumber; Loans."Loan  No.")
                {
                }
                column(ProductType; LoanName)
                {
                }
                column(RequestedAmount; Loans."Requested Amount")
                {
                }
                column(Interestt; Loans.Interest)
                {
                }
                column(Installments; Loans.Installments)
                {
                }
                column(LoanPrincipleRepayment; Loans."Loan Principle Repayment")
                {
                }
                column(ApprovedAmount_Loans; Loans."Approved Amount")
                {
                }
                column(LoanProductTypeName_Loans; Loans."Loan Product Type Name")
                {
                }
                column(Repayment_Loans; Loans.Repayment)
                {
                }
                column(ModeofDisbursement_Loans; Loans."Mode of Disbursement")
                {
                }
                dataitem(loan; "Member Ledger Entry")
                {
                    DataItemLink = "Customer No." = field("Client Code"), "Loan No" = field("Loan  No."), "Posting Date" = field("Date filter");
                    DataItemTableView = sorting("Posting Date") where("Transaction Type" = filter("Share Capital" | "Interest Paid"), "Loan No" = filter(<> ''), Description = filter(<> 'Interest on salary advance'));
                    column(PostingDate_loan; loan."Posting Date")
                    {
                    }
                    column(DocumentNo_loan; loan."Document No.")
                    {
                    }
                    column(Description_loan; loan.Description)
                    {
                    }
                    column(DebitAmount_Loan; loan."Debit Amount")
                    {
                    }
                    column(CreditAmount_Loan; loan."Credit Amount")
                    {
                    }
                    column(Amount_Loan; loan.Amount)
                    {
                    }
                    column(openBalance_loan; OpenBalance)
                    {
                    }
                    column(CLosingBalance_loan; CLosingBalance)
                    {
                    }
                    column(TransactionType_loan; loan."Transaction Type")
                    {
                    }
                    column(LoanNo; loan."Loan No")
                    {
                    }
                    column(PrincipleBF_loans; PrincipleBF)
                    {
                    }
                    column(Loan_Description; loan.Description)
                    {
                    }
                    column(User7; loan."User ID")
                    {
                    }
                    trigger OnPreDataItem();
                    begin
                        CLosingBalance := PrincipleBF;
                        OpeningBal := PrincipleBF;
                    end;

                    trigger OnAfterGetRecord();
                    begin
                        /*CLosingBalance:=CLosingBalance+loan.Amount;
						ClosingBalInt:=ClosingBalInt+loan.Amount;
						//interest
						ClosingBal:=ClosingBal+LoanInterest.Amount;
						OpeningBal:=ClosingBal-LoanInterest.Amount;
						*/
                        CLosingBalance := CLosingBalance + loan.Amount;
                        if Loans."Loan  No." = '' then begin
                        end;
                        if loan."Transaction Type" = loan."transaction type"::"Insurance Contribution" then begin
                            InterestPaid := loan."Credit Amount";
                            SumInterestPaid := InterestPaid + SumInterestPaid;
                        end;
                        if loan."Transaction Type" = loan."transaction type"::"Interest Paid" then begin
                            loan."Credit Amount" := loan."Credit Amount"//+InterestPaid;
                        end;

                    end;

                }
                dataitem(Interest; "Member Ledger Entry")
                {
                    DataItemLink = "Customer No." = field("Client Code"), "Loan No" = field("Loan  No."), "Posting Date" = field("Date filter");
                    DataItemTableView = sorting("Transaction Type", "Loan No", "Posting Date") where("Transaction Type" = filter("Deposit Contribution" | "Insurance Contribution"), "Loan No" = filter(<> ''), Description = filter(<> 'Interest on salary advance'));

                    column(PostingDate_Interest; Interest."Posting Date")
                    {
                    }
                    column(DocumentNo_Interest; Interest."Document No.")
                    {
                    }
                    column(Description_Interest; Interest.Description)
                    {
                    }
                    column(DebitAmount_Interest; Interest."Debit Amount")
                    {
                    }
                    column(CreditAmount_Interest; Interest."Credit Amount")
                    {
                    }
                    column(Amount_Interest; Interest.Amount)
                    {
                    }
                    column(OpeningBalInt; OpeningBalInt)
                    {
                    }
                    column(ClosingBalInt; ClosingBalInt)
                    {
                    }
                    column(TransactionType_Interest; Interest."Transaction Type")
                    {
                    }
                    column(LoanNo_Interest; Interest."Loan No")
                    {
                    }
                    column(InterestBF; InterestBF)
                    {
                    }
                    column(User8; Interest."User ID")
                    {
                    }
                    trigger OnPreDataItem();
                    begin
                        //Loans.SETFILTER(Loans."Loan  No.","Members Register".GETFILTER("Members Register"."Loan No. Filter"));
                    end;

                }
                trigger OnPreDataItem();
                begin
                    Loans.SetFilter(Loans."Date filter", "Members Register".GetFilter("Members Register"."Date Filter"));
                    //Loans.SETFILTER(Loans."Loan  No.","Members Register".GETFILTER("Members Register"."Loan No. Filter"));
                end;

                trigger OnAfterGetRecord();
                begin
                    if LoanSetup.Get(Loans."Loan Product Type") then
                        LoanName := LoanSetup."Product Description";
                    if DateFilterBF <> '' then begin
                        LoansR.Reset;
                        LoansR.SetRange(LoansR."Loan  No.", "Loan  No.");
                        LoansR.SetFilter(LoansR."Date filter", DateFilterBF);
                        if LoansR.Find('-') then begin
                            LoansR.CalcFields(LoansR."Outstanding Balance");
                            PrincipleBF := LoansR."Outstanding Balance";
                            //InterestBF:=LoansR."Interest Paid";
                        end;
                    end;
                end;

            }
            dataitem("Loans Guarantee Details"; "Loans Guarantee Details")
            {
                DataItemLink = "Member No" = field("No.");
                column(LoanNumb; "Loans Guarantee Details"."Loan No")
                {
                }
                column(MembersNo; "Loans Guarantee Details"."Member No")
                {
                }
                column(Name; "Loans Guarantee Details".Name)
                {
                }
                column(LBalance; "Loans Guarantee Details"."Loan Balance")
                {
                }
                column(Sharess; "Loans Guarantee Details".Shares)
                {
                }
                column(LoansGuaranteed; "Loans Guarantee Details"."No Of Loans Guaranteed")
                {
                }
                column(Substituted; "Loans Guarantee Details".Substituted)
                {
                }
            }
            trigger OnPreDataItem();
            begin
                if "Members Register".GetFilter("Members Register"."Date Filter") <> '' then
                    DateFilterBF := '..' + Format(CalcDate('-1D', "Members Register".GetRangeMin("Members Register"."Date Filter")));
            end;

            trigger OnAfterGetRecord();
            begin
                SaccoEmp.Reset;
                SaccoEmp.SetRange(SaccoEmp.Code, "Members Register"."Employer Code");
                if SaccoEmp.Find('-') then
                    EmployerName := SaccoEmp.Description;
                SharesBF := 0;
                InsuranceBF := 0;
                ShareCapBF := 0;
                RiskBF := 0;
                HseBF := 0;
                BenFundBF := 0;
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
        Cust: Record "Members Register";
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
        OpenBalanceBenfund: Decimal;
        CLosingBalanceBenfund: Decimal;
        OpenBalanceDep1: Decimal;
        CLosingBalanceDep1: Decimal;
        OpenBalanceDep2: Decimal;
        CLosingBalanceDep2: Decimal;
        HseBF: Decimal;
        BenFundBF: Decimal;
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
