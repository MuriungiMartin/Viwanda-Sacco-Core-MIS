
Report 50542 "Unallocated Funds Checkoff"
{
    RDLCLayout = 'Layouts/UnallocatedFundsCheckoff.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Checkoff Header-Distributed"; "Checkoff Header-Distributed")
        {
            column(UserId; UserId)
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
            column(Amount_CheckoffHeaderDistributed; "Checkoff Header-Distributed".Amount)
            {
            }
            column(No_CheckoffHeaderDistributed; "Checkoff Header-Distributed".No)
            {
            }
            column(Remarks_CheckoffHeaderDistributed; "Checkoff Header-Distributed".Remarks)
            {
            }
            column(Postingdate_CheckoffHeaderDistributed; "Checkoff Header-Distributed"."Posting date")
            {
            }
            column(DocumentNo_CheckoffHeaderDistributed; "Checkoff Header-Distributed"."Document No")
            {
            }
            dataitem(ChecKoffLines; "Checkoff Lines-Distributed")
            {
                DataItemLink = "VS-MEMBER" = field(No);
                //DataItemTableView = sorting("VS-MEMBER",DL_I) where(SPL_P=filter(SLOAN|SINTEREST),MSL_I=filter(''));
                column(MemberNo_ChecKoffLines; ChecKoffLines.INSURANCE)
                {
                }
                column(Reference_ChecKoffLines; ChecKoffLines.SPL_P)
                {
                }
                column(LoanType_ChecKoffLines; ChecKoffLines.THIRDPARTY)
                {
                }
                column(LoanNo_ChecKoffLines; ChecKoffLines.MSL_I)
                {
                }
                column(StaffPayrollNo_ChecKoffLines; ChecKoffLines."Payroll No")
                {
                }
                column(Name_ChecKoffLines; ChecKoffLines.IL_P)
                {
                }
                column(Amount_ChecKoffLines; ChecKoffLines."Employee Name")
                {
                }
            }
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

