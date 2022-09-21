#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
//50010_v6_3_0_2259) { }
// Autogenerated code - do not delete or modify -->

Report 50620 "Payroll Payslip Email"
{
    RDLCLayout = 'Layouts/PayrollPayslipEmail.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Payroll Employee."; "Payroll Employee.")
        {
            RequestFilterFields = "No.";
            column(ReportForNavId_1; 1) { } // Autogenerated by ForNav - Do not delete
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(Company_Name; CompanyInfo.Name)
            {
            }
            column(Company_Address; CompanyInfo.Address)
            {
            }
            column(Company_Address_2; CompanyInfo."Address 2")
            {
            }
            column(Company_Phone_No; CompanyInfo."Phone No.")
            {
            }
            column(Company_Fax_No; CompanyInfo."Fax No.")
            {
            }
            column(Company_Picture; CompanyInfo.Picture)
            {
            }
            column(Company_Email; CompanyInfo."E-Mail")
            {
            }

            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(No; "Payroll Employee."."No.")
            {
            }
            column(Surname; "Payroll Employee.".Surname)
            {
            }
            column(FirstName; "Payroll Employee.".Firstname)
            {
            }
            column(Lastname; "Payroll Employee.".Lastname)
            {
            }
            column(FullName; "Payroll Employee."."Full Name")
            {
            }
            column(CName; CompanyInfo.Name)
            {
            }
            column(CAddress; CompanyInfo.Address)
            {
            }
            column(CPic; CompanyInfo.Picture)
            {
            }
            column(PeriodName; PeriodName)
            {
            }
            column(PINNo; "Payroll Employee."."PIN No")
            {
            }
            column(NSSFNo; "Payroll Employee."."NSSF No")
            {
            }
            column(NHIFNo; "Payroll Employee."."NHIF No")
            {
            }
            column(BankName; "Payroll Employee."."Bank Name")
            {
            }
            column(BranchName; "Payroll Employee."."Branch Name")
            {
            }
            column(Department; "Payroll Employee.".Department)
            {
            }
            column(UserId; UserId)
            {
            }
            column(BankAccNo; "Payroll Employee."."Bank Account No")
            {
            }
            dataitem("prPeriod Transactions."; "prPeriod Transactions.")
            {
                DataItemLink = "Employee Code" = field("No."), "Payroll Period" = field("Last Payroll Period");
                RequestFilterFields = "Payroll Period";
                column(ReportForNavId_6; 6) { } // Autogenerated by ForNav - Do not delete
                column(TCode; "prPeriod Transactions."."Transaction Code")
                {
                }
                column(TName; "prPeriod Transactions."."Transaction Name")
                {
                }
                column(Grouping; "prPeriod Transactions."."Group Order")
                {
                }
                column(TBalances; "prPeriod Transactions.".Balance)
                {
                }
                column(SubGroupOrder; "prPeriod Transactions."."Sub Group Order")
                {
                }
                column(Amount; "prPeriod Transactions.".Amount)
                {
                }
                column(PeriodMonth_prPeriodTransactions; "prPeriod Transactions."."Period Month")
                {
                }
                column(PeriodYear_prPeriodTransactions; "prPeriod Transactions."."Period Year")
                {
                }
                trigger OnPreDataItem();
                begin
                    /*"prPeriod Transactions.".SETFILTER("prPeriod Transactions."."Employee Code",VarEmployeeNo);
					"prPeriod Transactions.".SETRANGE("prPeriod Transactions."."Payroll Period",VarCurrPayrollPeriod);*/

                end;

                trigger OnAfterGetRecord();
                begin
                    PayrollCalender.Reset;
                    PayrollCalender.SetRange(PayrollCalender."Date Opened", "Payroll Period");
                    if PayrollCalender.FindLast then begin
                        PeriodName := Format(PayrollCalender."Date Opened", 0, '<Month Text,3> <Year4>')//PayrollCalender."Period Name"+'-'+ FORMAT(PayrollCalender."Period Year");
                    end;
                end;

            }
            trigger OnPreDataItem();
            begin
                CompanyInfo.Get;
                CompanyInfo.CalcFields(CompanyInfo.Picture);
            end;

            trigger OnAfterGetRecord();
            begin
                /*PayrollCalender.RESET;
                PayrollCalender.SETRANGE(PayrollCalender."Date Opened","Date Filter");
                IF PayrollCalender.FINDLAST THEN BEGIN
                  PeriodName:=PayrollCalender."Period Name";
                END;*/
                VarEmployeeNo := '';
                VarCurrPayrollPeriod := 0D;
                VarEmployeeNo := "No.";
                VarCurrPayrollPeriod := "Last Payroll Period";

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
        if UserSetup.Get(UserId) then begin
            if not UserSetup."View Payroll" then
                Error(PemissionDenied);
        end else begin
            Error(UserNotFound, UserId);
        end;
        ;


    end;

    trigger OnPostReport()
    begin
        ;

    end;

    trigger OnPreReport()
    begin
        CompanyInfo.Get;
        CompanyInfo.CalcFields(CompanyInfo.Picture);
        /*PayrollEmp.RESET;
        PayrollEmp.SETRANGE(PayrollEmp.Status,PayrollEmp.Status::Active);
        IF PayrollEmp.FINDFIRST THEN BEGIN
          PayrollCalender.RESET;
          PayrollCalender.SETRANGE(PayrollCalender."Date Opened",PayrollEmp."Date Filter");
          IF PayrollCalender.FINDLAST THEN BEGIN
               PeriodName:=PayrollCalender."Period Name";
          END;
        END;*/
        ;


    end;

    var
        CompanyInfo: Record "Company Information";
        PayrollCalender: Record "Payroll Calender.";
        "Payroll Period": Date;
        PeriodName: Text;
        PayrollEmp: Record "Payroll Employee.";
        UserNotFound: label 'User Setup %1 not found.';
        PemissionDenied: label 'User Account is not Setup for Payroll Use. Contact System Administrator.';
        UserSetup: Record "User Setup";
        VarCurrPayrollPeriod: Date;
        VarEmployeeNo: Code[30];

    // --> Reports ForNAV Autogenerated code - do not delete or modify
    //50010_v6_3_0_2259;






    // Reports ForNAV Autogenerated code - do not delete or modify -->
}
