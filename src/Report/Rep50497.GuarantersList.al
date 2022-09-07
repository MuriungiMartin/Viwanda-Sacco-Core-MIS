Report 50497 "Guaranters List"
{
    RDLCLayout = 'Layouts/GuarantersList.rdlc';
    DefaultLayout = RDLC;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem(loansG; "Loans Guarantee Details")
        {
            RequestFilterFields = "Loan No", "Loan Balance", "Self Guarantee", "Loanees  No", "Guarantor Outstanding", "Employer Code";
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(Company_Address; Company.Address)
            {
            }
            column(Company_Address2; Company."Address 2")
            {
            }
            column(Company_PhoneNo; Company."Phone No.")
            {
            }
            column(Company_Email; Company."E-Mail")
            {
            }
            column(Company_Picture; Company.Picture)
            {
            }

            column(UserId; UserId)
            {
            }
            column(Loan_No; loansG."Loan No")
            {
            }
            column(Staff_No; loansG."Staff/Payroll No.")
            {
            }
            column(Member_No; loansG."Member No")
            {
            }
            column(Name; loansG.Name)
            {
                AutoCalcField = true;
            }
            column(Shares; loansG.Shares)
            {
            }
            column(Amount_Guaranteed; loansG."Amont Guaranteed")
            {
            }
            column(Account_No; loansG."Account No.")
            {
            }
            column(Self_Guaranteed; loansG."Self Guarantee")
            {
            }
            column(Total_LoanGuaranteed; loansG."Total Loans Guaranteed")
            {
            }
            column(No_Of_Loan_Guaranteed; loansG."No Of Loans Guaranteed")
            {
            }
            column(Loans_Outstanding; loansG."Loans Outstanding")
            {
            }
            column(Guarantor_Outstanding; loansG."Guarantor Outstanding")
            {
            }
            trigger OnPreDataItem();
            begin
                Company.Get();
                Company.CalcFields(Company.Picture);
                //Error('<Month Text>');
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

    end;

    trigger OnPostReport()
    begin

    end;

    trigger OnPreReport()
    begin

    end;

    var
        Company: Record "Company Information";


    var

}
