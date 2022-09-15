#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings

Report 50367 "Loan Defaulter Notified"
{
    RDLCLayout = 'Layouts/LoanDefaulterNotified.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem(Loans; "Loans Register")
        {
            DataItemTableView = sorting("Loan  No.") where(Source = const(" "));
            RequestFilterFields = "Loan Product Type", "Application Date", "Appraisal Status", "Loan Status", "Issued Date";

            column(Loan_No; Loans."Loan  No.")
            {
            }
            column(Member_No; Loans."Client Code")
            {
            }
            column(ClientName_Loans; Loans."Client Name")
            {
            }
            column(Personal_No; Loans."Staff No")
            {
            }
            column(Employer_Name; Loans."Employer Name")
            {
            }
            column(Loan_Type; Loans."Loan Product Type")
            {
            }
            column(Approved_Amount; Loans."Approved Amount")
            {
            }
            column(Outstanding_Bal; Loans."Outstanding Balance")
            {
            }
            column(Issued_Date; Loans."Issued Date")
            {
            }
            column(Interest_Due; Loans."Interest Due")
            {
            }
            column(Penalty_Charged; Loans."Penalty Charged")
            {
            }
            column(LastPay_date; Loans."Last Pay Date")
            {
            }
            column(Remarks; Loans.Remarks)
            {
            }
            trigger OnAfterGetRecord();
            begin
                RPeriod := Loans.Installments;
                if (Loans."Outstanding Balance" > 0) and (Loans.Repayment > 0) then
                    RPeriod := Loans."Outstanding Balance" / Loans.Repayment;
                Cust.Reset;
                Cust.SetRange(Cust."No.", "Client Code");
                if Cust.Find('-') then begin
                    EmpCode := Cust."Employer Code";
                    PersonalNo := Cust."Payroll No";
                end;
                Intcount += 1;
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
        RPeriod: Decimal;
        Cust: Record Customer;
        EmpCode: Code[30];
        Intcount: Integer;
        Month: Code[10];
        PersonalNo: Code[30];
        StartDate: Date;
        EndDate: Date;

    var

}
