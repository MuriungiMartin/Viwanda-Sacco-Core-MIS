#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
//51516876_v6_3_0_2259) { }
// Autogenerated code - do not delete or modify -->

Report 50876 "Member Account Statement(App)"
{
    RDLCLayout = 'Layouts/MemberAccountStatement(App).rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem(Customer; Customer)
        {
            RequestFilterFields = "No.", "Date Filter";
            column(ReportForNavId_1102755000; 1102755000) { } // Autogenerated by ForNav - Do not delete
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
            column(Address_MembersRegister; Customer.Address)
            {
            }
            column(City_MembersRegister; Customer.City)
            {
            }
            column(DateFilter_MembersRegister; Customer."Date Filter")
            {
            }
            // column(PageNo_Members; CurrReport.PageNo())
            // {
            // }
            column(Shares_Retained; Customer."Shares Retained")
            {
            }
            column(IDNo_Members; Customer."ID No.")
            {
            }
            column(GlobalDimension2Code_Members; Customer."Global Dimension 2 Code")
            {
            }
            column(FromDate; Format(FromDate, 0, '<Day,2> <Month Text,3> <Year4>'))
            {
            }
            column(ToDate; Format(ToDate, 0, '<Day,2> <Month Text,3> <Year4>'))
            {
            }
            column(GeneratedOn; GeneratedOn)
            {
            }
            column(MemberAddress; MemberAddress)
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
            dataitem("Member Accounts"; Vendor)
            {
                DataItemLink = "BOSA Account No" = field("No.");
                DataItemTableView = sorting("No.") order(ascending);
                RequestFilterFields = "No.", "Account Type";
                column(ReportForNavId_38; 38) { } // Autogenerated by ForNav - Do not delete
                column(AccountType_MemberAccounts; "Member Accounts"."Account Type")
                {
                }
                column(No_MemberAccounts; "Member Accounts"."No.")
                {
                }
                column(AccountTypeName_MemberAccounts; "Member Accounts"."Account Type Name")
                {
                }
                column(BalanceBF; StartBalance * -1)
                {
                }
                column(Name_MemberAccounts; "Member Accounts".Name)
                {
                }
                dataitem("Member Historical Ledger Entry"; "Member Historical Ledger Entry")
                {
                    DataItemLink = "Account No." = field("No.");
                    DataItemTableView = sorting("Created On") order(ascending);
                    column(ReportForNavId_19; 19) { } // Autogenerated by ForNav - Do not delete
                    column(AccountNo_MemberHistoricalLedgerEntry; "Member Historical Ledger Entry"."Account No.")
                    {
                    }
                    column(PostingDate_MemberHistoricalLedgerEntry; Format("Member Historical Ledger Entry"."Posting Date", 0, '<Day,2> <Month Text,3> <Year4>'))
                    {
                    }
                    column(DocumentNo_MemberHistoricalLedgerEntry; "Member Historical Ledger Entry"."Document No.")
                    {
                    }
                    column(Description_MemberHistoricalLedgerEntry; "Member Historical Ledger Entry".Description)
                    {
                    }
                    column(Amount_MemberHistoricalLedgerEntry; "Member Historical Ledger Entry".Amount)
                    {
                    }
                    column(DebitAmount_MemberHistoricalLedgerEntry; "Member Historical Ledger Entry"."Debit Amount")
                    {
                    }
                    column(CreditAmount_MemberHistoricalLedgerEntry; "Member Historical Ledger Entry"."Credit Amount")
                    {
                    }
                    column(ExternalDocumentNo_MemberHistoricalLedgerEntry; "Member Historical Ledger Entry"."External Document No")
                    {
                    }
                    column(RunningBalanceHistorical; MemberAccBalance * -1)
                    {
                    }
                    column(CreatedOn_MemberHistoricalLedgerEntry; "Member Historical Ledger Entry"."Created On")
                    {
                    }
                    trigger OnPreDataItem();
                    begin
                        "Member Historical Ledger Entry".SetFilter("Member Historical Ledger Entry"."Posting Date", VarReportFilter);
                    end;

                    trigger OnAfterGetRecord();
                    begin
                        MemberAccBalance := MemberAccBalance + Amount;
                    end;

                }
                dataitem("Ledger Entries"; "Vendor Ledger Entry")
                {
                    CalcFields = "Cheque Maturity Date";
                    DataItemLink = "Vendor No." = field("No.");
                    DataItemTableView = sorting("Posting Date") where("Document No." = filter(<> 'BALB/F9THNOV2018'));
                    column(ReportForNavId_1000000009; 1000000009) { } // Autogenerated by ForNav - Do not delete
                    column(VendorNo_LedgerEntries; "Ledger Entries"."Vendor No.")
                    {
                    }
                    column(PostingDate_LedgerEntries; Format("Ledger Entries"."Posting Date", 0, '<Day,2> <Month Text,3> <Year4>'))
                    {
                    }
                    column(DocumentNo_LedgerEntries; "Ledger Entries"."Document No.")
                    {
                    }
                    column(Description_LedgerEntries; "Ledger Entries".Description)
                    {
                    }
                    column(Amount_LedgerEntries; "Ledger Entries".Amount)
                    {
                    }
                    column(DebitAmount_LedgerEntries; "Ledger Entries"."Debit Amount")
                    {
                    }
                    column(CreditAmount_LedgerEntries; "Ledger Entries"."Credit Amount")
                    {
                    }
                    column(ExternalDocumentNo_LedgerEntries; "Ledger Entries"."External Document No.")
                    {
                    }
                    column(RunningBalance; MemberAccBalance * -1)
                    {
                    }
                    column(ChequeMaturityDate_LedgerEntries; Format("Ledger Entries"."Cheque Maturity Date", 0, '<Day,2> <Month Text,3> <Year4>'))
                    {
                    }
                    trigger OnPreDataItem();
                    begin
                        SetFilter("Posting Date", VarReportFilter);
                    end;

                    trigger OnAfterGetRecord();
                    begin
                        MemberAccBalance := MemberAccBalance + Amount;
                        MemberAccBalanceLCY := MemberAccBalanceLCY + "Amount (LCY)"
                    end;

                }
                trigger OnPreDataItem();
                begin
                    "Member Accounts".SetFilter("Member Accounts"."Account Closed On", '%1|>%2', 0D, VarMinDateDateFilter);
                    "Member Accounts".SetFilter("Member Accounts"."Account Type", '<>%1', '606');
                end;

                trigger OnAfterGetRecord();
                begin
                    StartBalance := 0;
                    if VarReportFilter <> '' then
                        if (VarReportFilter <> '..*') then begin
                            ObjSaccoGeneralSetup.Get;
                            SetRange("Date Filter", 0D, VarMinDateDateFilter);
                            CalcFields("Balance For Reporting", "Balance (LCY)", "Balance Historical");
                            StartBalance := "Balance Historical";
                            if VarMinDateDateFilter > ObjSaccoGeneralSetup."Go Live Date" then
                                StartBalance := "Balance For Reporting";
                            StartBalanceLCY := "Balance (LCY)";
                            SetFilter("Date Filter", DateFilter_MemberAccount);
                        end;
                    MemberAccBalance := StartBalance;
                    MemberAccBalanceLCY := StartBalanceLCY;
                end;

            }
            dataitem(Loans; "Loans Register")
            {
                DataItemLink = "Client Code" = field("No.");
                DataItemTableView = sorting("Loan  No.") where(Posted = const(true));
                column(ReportForNavId_1102755024; 1102755024) { } // Autogenerated by ForNav - Do not delete
                column(PrincipleBF; PrincipleBF)
                {
                }
                column(LoanNumber; Loans."Loan  No.")
                {
                }
                column(RequestedAmount; Loans."Requested Amount")
                {
                }
                column(Interest; Loans.Interest)
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
                column(OutstandingBalance_Loans; Loans."Outstanding Balance")
                {
                }
                column(OustandingInterest_Loans; Loans."Outstanding Interest")
                {
                }
                column(LoansBalanceBF; LoansStartBalance)
                {
                }
                column(ClientName_Loans; Loans."Client Name")
                {
                }
                dataitem("Member Loans Historical Ledger"; "Member Loans Historical Ledger")
                {
                    DataItemLink = "Loan No" = field("Loan  No.");
                    DataItemTableView = sorting("Created On") order(ascending) where(Description = filter(<> 'Loan Repayment B/F 2012'));
                    column(ReportForNavId_30; 30) { } // Autogenerated by ForNav - Do not delete
                    column(PostingDate_MemberLoansHistoricalLedger; Format("Member Loans Historical Ledger"."Posting Date", 0, '<Day,2> <Month Text,3> <Year4>'))
                    {
                    }
                    column(DocumentNo_MemberLoansHistoricalLedger; "Member Loans Historical Ledger"."Document No.")
                    {
                    }
                    column(Description_MemberLoansHistoricalLedger; "Member Loans Historical Ledger".Description)
                    {
                    }
                    column(DebitAmount_MemberLoansHistoricalLedger; "Member Loans Historical Ledger"."Debit Amount")
                    {
                    }
                    column(CreditAmount_MemberLoansHistoricalLedger; "Member Loans Historical Ledger"."Credit Amount")
                    {
                    }
                    column(Amount_MemberLoansHistoricalLedger; "Member Loans Historical Ledger".Amount)
                    {
                    }
                    column(TransactionType_MemberLoansHistoricalLedger; "Member Loans Historical Ledger"."Transaction Type")
                    {
                    }
                    column(ExternalDocumentNo_MemberLoansHistoricalLedger; "Member Loans Historical Ledger"."External Document No")
                    {
                    }
                    column(CreatedOn_MemberLoansHistoricalLedger; "Member Loans Historical Ledger"."Created On")
                    {
                    }
                    column(LoansRunningBalanceHistorical; LoansAccBalance)
                    {
                    }
                    trigger OnPreDataItem();
                    begin
                        SetFilter("Posting Date", VarReportFilter);
                    end;

                    trigger OnAfterGetRecord();
                    begin
                        LoansAccBalance := LoansAccBalance + Amount;
                    end;

                }
                dataitem(loan; "Member Ledger Entry")
                {
                    DataItemLink = "Loan No" = field("Loan  No.");
                    DataItemTableView = sorting("Created On") where("Transaction Type" = filter(Loan | "Loan Repayment" | "Loan Insurance Charged" | "Loan Insurance Paid" | "Loan Penalty Charged" | "Loan Penalty Paid" | "Interest Paid" | "Interest Due"), "Document No." = filter(<> 'BALB/F9THNOV2018'));
                    column(ReportForNavId_1102755031; 1102755031) { } // Autogenerated by ForNav - Do not delete
                    column(PostingDate_loan; Format(loan."Posting Date", 0, '<Day,2> <Month Text,3> <Year4>'))
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
                    column(LoansRunningBalance; LoansAccBalance)
                    {
                    }
                    column(CreatedOn_loan; loan."Created On")
                    {
                    }
                    column(PostingDateSortingLoan; loan."Posting Date")
                    {
                    }
                    trigger OnPreDataItem();
                    begin
                        SetFilter("Posting Date", VarReportFilter);
                    end;

                    trigger OnAfterGetRecord();
                    begin
                        LoansAccBalance := LoansAccBalance + Amount;
                        LoansAccBalanceLCY := LoansAccBalanceLCY + "Amount (LCY)"
                    end;

                }
                trigger OnPreDataItem();
                begin
                    Loans.SetFilter(Loans."Closed On", '%1|>%2', 0D, VarMinDateDateFilter);
                end;

                trigger OnAfterGetRecord();
                begin
                    LoansStartBalance := 0;
                    if VarReportFilter <> '' then
                        if (VarReportFilter <> '..*') then begin
                            ObjSaccoGeneralSetup.Get;
                            SetRange("Date filter", 0D, VarMinDateDateFilter);
                            CalcFields("Actual Loan Balance", "Actual Loan Balance Historical");
                            LoansStartBalance := "Actual Loan Balance Historical";
                            if VarMinDateDateFilter > ObjSaccoGeneralSetup."Go Live Date" then
                                LoansStartBalance := "Actual Loan Balance";
                            //SETFILTER("Date filter",DateFilter_MemberAccount);
                        end;
                    LoansAccBalance := LoansStartBalance;
                end;

            }
            trigger OnPreDataItem();
            begin
                VarReportFilter := Customer.GetFilter(Customer."Date Filter");
                if VarReportFilter = '' then
                    VarReportFilter := Format(WorkDate);
                VarMinDateDateFilter := SFactory.FnRunGetStatementDateFilterAPP(VarReportFilter);
                FromDate := SFactory.FnRunGetStatementFromDateApp(VarReportFilter);
                ToDate := SFactory.FnRunGetStatementToDateApp(VarReportFilter);
                GeneratedOn := Format(CurrentDatetime, 0, '<Day,2> <Month Text,3> <Year4> <Hours24,2>:<Minutes,2>');
            end;

            trigger OnAfterGetRecord();
            begin
                MemberAddress := Customer.Address + ' - ' + Customer.City;
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
            //:= false;
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
        BenfundBF: Decimal;
        FOSASharesBF: Decimal;
        AdditionalSharesBF: Decimal;
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
        OpenBalanceHoliday: Decimal;
        ClosingBalanceHoliday: Decimal;
        LoanSetup: Record "Loan Products Setup";
        LoanName: Text[50];
        SaccoEmp: Record "Sacco Employers";
        EmployerName: Text[100];
        OpenBalanceShareCap: Decimal;
        ClosingBalanceShareCap: Decimal;
        OpenBalanceDeposits: Decimal;
        ClosingBalanceDeposits: Decimal;
        OpenBalanceDividend: Decimal;
        ClosingBalanceDividend: Decimal;
        OpenBalanceBenfund: Decimal;
        ClosingBalanceBenfund: Decimal;
        OpenBalanceFOSAShares: Decimal;
        ClosingBalanceFOSAShares: Decimal;
        OpenBalanceAdditionalShares: Decimal;
        ClosingBalanceAdditionalShares: Decimal;
        MemberAccFilter: Text;
        DateFilter_MemberAccount: Text;
        StartBalance: Decimal;
        StartBalanceLCY: Decimal;
        MemberAccBalance: Decimal;
        MemberAccBalanceLCY: Decimal;
        LoansAccFilter: Text;
        DateFilter_LoansAccount: Text;
        LoansStartBalance: Decimal;
        LoansStartBalanceLCY: Decimal;
        LoansAccBalance: Decimal;
        LoansAccBalanceLCY: Decimal;
        ObjLoans: Record "Loans Register";
        VarReportFilter: Text;
        VarBalanceFilterBeginDate: Text;
        VarNewDate: Date;
        myDate: Integer;
        myMonth: Integer;
        myYear: Integer;
        ObjSaccoGeneralSetup: Record "Sacco General Set-Up";
        VarMinDateDateFilter: Date;
        SFactory: Codeunit "SURESTEP Factory";
        FromDate: Date;
        ToDate: Date;
        GeneratedOn: Text;
        MemberAddress: Text;

    // --> Reports ForNAV Autogenerated code - do not delete or modify
    //51516876_v6_3_0_2259;






    // Reports ForNAV Autogenerated code - do not delete or modify -->
}
