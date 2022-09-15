#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings

Report 50368 "Loan Defaulters Attached"
{
    RDLCLayout = 'Layouts/LoanDefaultersAttached.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Loans Register"; "Loans Register")
        {
            DataItemTableView = sorting("Loan  No.") where(Source = const(" "), Attached = const(true));
            RequestFilterFields = "Loan  No.", "Loan Product Type", "Application Date", "Appraisal Status", "Loan Status", "Issued Date", "Attachement Date";

            column(Loan_No; "Loans Register"."Loan  No.")
            {
            }
            column(Member_No; "Loans Register"."Client Code")
            {
            }
            column(ClientName_Loans; "Loans Register"."Client Name")
            {
            }
            column(Personal_No; "Loans Register"."Staff No")
            {
            }
            column(Employer_Name; "Loans Register"."Employer Name")
            {
            }
            column(Loan_Type; "Loans Register"."Loan Product Type Name")
            {
            }
            column(Approved_Amount; "Loans Register"."Approved Amount")
            {
            }
            column(Outstanding_Bal; "Loans Register"."Outstanding Balance")
            {
            }
            column(Issued_Date; "Loans Register"."Issued Date")
            {
            }
            column(Interest_Due; "Loans Register"."Interest Due")
            {
            }
            column(Penalty_Charged; "Loans Register"."Penalty Charged")
            {
            }
            column(Total_Liability; "Loans Register"."Penalty Charged" + "Loans Register"."Interest Due" + "Loans Register"."Outstanding Balance")
            {
            }
            column(Remarks; "Loans Register".Remarks)
            {
            }
            trigger OnAfterGetRecord();
            begin
                RPeriod := "Loans Register".Installments;
                if ("Loans Register"."Outstanding Balance" > 0) and ("Loans Register".Repayment > 0) then
                    RPeriod := "Loans Register"."Outstanding Balance" / "Loans Register".Repayment;
                Cust.Reset;
                Cust.SetRange(Cust."No.", "Client Code");
                if Cust.Find('-') then begin
                    EmpCode := Cust."Employer Code";
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
                field(Month; Month)
                {
                    ApplicationArea = Basic;
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


    var
}
