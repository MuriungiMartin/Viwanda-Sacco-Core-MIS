#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
//51516963_v6_3_0_2259) { }
// Autogenerated code - do not delete or modify -->

Report 50963 "Loan Recovery Log Report(Ver1)"
{
    RDLCLayout = 'Layouts/LoanRecoveryLogReport(Ver1).rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem(Customer; Customer)
        {
            RequestFilterFields = "No.", "Loan Product Filter", "Outstanding Balance", "Date Filter";
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
            column(PageNo_Members; CurrReport.PageNo())
            {
            }
            column(Shares_Retained; Customer."Shares Retained")
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
            dataitem(Loans; "Loans Register")
            {
                DataItemLink = "Client Code" = field("No."), "Date filter" = field("Date Filter"), "Loan Product Type" = field("Loan Product Filter"), "Loan  No." = field("Loan No. Filter");
                DataItemTableView = sorting("Loan  No.") where(Posted = const(true));
                column(ReportForNavId_1102755024; 1102755024) { } // Autogenerated by ForNav - Do not delete
                column(LoanNumber; Loans."Loan  No.")
                {
                }
                column(ProductType; LoanName)
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
                column(AmountinArrears_Loans; Loans."Amount in Arrears")
                {
                }
                column(DaysInArrears_Loans; Loans."Days In Arrears")
                {
                }
                column(IssuedDate_Loans; Format(Loans."Issued Date", 0, '<Day,2> <Month Text,3> <Year4>'))
                {
                }
                column(VarLoanRecoveryLog; VarLoanRecoveryLog)
                {
                }
                dataitem(RecoveryLogs; "Loan Recovery Logs")
                {
                    DataItemLink = "Loan No" = field("Loan  No.");
                    column(ReportForNavId_1000000009; 1000000009) { } // Autogenerated by ForNav - Do not delete
                    column(MemberNo_RecoveryLogs; RecoveryLogs."Member No")
                    {
                    }
                    column(MemberName_RecoveryLogs; RecoveryLogs."Member Name")
                    {
                    }
                    column(LoanNo_RecoveryLogs; RecoveryLogs."Loan No")
                    {
                    }
                    column(LoanProductType_RecoveryLogs; RecoveryLogs."Loan Product Type")
                    {
                    }
                    column(LoanBalance_RecoveryLogs; RecoveryLogs."Loan Balance")
                    {
                    }
                    column(LogDate_RecoveryLogs; Format(RecoveryLogs."Log Date", 0, '<Day,2> <Month Text,3> <Year4>'))
                    {
                    }
                    column(UserID_RecoveryLogs; RecoveryLogs."User ID")
                    {
                    }
                    column(LogDescription_RecoveryLogs; RecoveryLogs."Log Description")
                    {
                    }
                    column(LoanProductName_RecoveryLogs; RecoveryLogs."Loan Product Name")
                    {
                    }
                    column(LoanAmountInArrears_RecoveryLogs; RecoveryLogs."Loan Amount In Arrears")
                    {
                    }
                    column(LoanArrearsDays_RecoveryLogs; RecoveryLogs."Loan Arrears Days")
                    {
                    }
                }
                trigger OnPreDataItem();
                begin
                    Loans.SetFilter(Loans."Date filter", Customer.GetFilter(Customer."Date Filter"));
                end;

                trigger OnAfterGetRecord();
                begin
                    if LoanSetup.Get(Loans."Loan Product Type") then
                        LoanName := LoanSetup."Product Description";
                    VarLoanRecoveryLog := false;
                    ObjLoanRecoveryLogs.Reset;
                    ObjLoanRecoveryLogs.SetRange(ObjLoanRecoveryLogs."Loan No", "Loan  No.");
                    if ObjLoanRecoveryLogs.Find('-') = true then begin
                        VarLoanRecoveryLog := true;
                    end;
                end;

            }
            trigger OnPreDataItem();
            begin
                if Customer.GetFilter(Customer."Date Filter") <> '' then
                    DateFilterBF := '..' + Format(CalcDate('-1D', Customer.GetRangeMin(Customer."Date Filter")));
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
        Company: Record "Company Information";
        DateFilterBF: Text;
        LoanSetup: Record "Loan Products Setup";
        LoanName: Text[50];
        LoansR: Record "Loans Register";
        ObjLoanRecoveryLogs: Record "Loan Recovery Logs";
        VarLoanRecoveryLog: Boolean;

    // --> Reports ForNAV Autogenerated code - do not delete or modify
    //51516963_v6_3_0_2259;






    // Reports ForNAV Autogenerated code - do not delete or modify -->
}
