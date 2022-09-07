#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // settings
Report 50471 "Loans Balances -FOSA"
{
    RDLCLayout = 'Layouts/LoansBalances-FOSA.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Loans Register"; "Loans Register")
        {
            DataItemTableView = sorting("Loan  No.") where(Source = const(BOSA));
            PrintOnlyIfDetail = false;
            RequestFilterFields = "Loan Product Type", "Application Date", "Appraisal Status", "Loan Status", "Issued Date", "Outstanding Balance", "Current Shares", "Date filter";

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
            column(Loan_No; "Loans Register"."Loan  No.")
            {
            }
            column(Client_No; "Loans Register"."Client Code")
            {
            }
            column(Client_Name; "Loans Register"."Client Name")
            {
            }
            column(Agency_Name; "Loans Register"."Employer Name")
            {
            }
            column(Loan_Type; "Loans Register"."Loan Product Type")
            {
            }
            column(Approved_Amount; "Loans Register"."Approved Amount")
            {
            }
            column(Installments; "Loans Register".Installments)
            {
            }
            column(Remaining_Installments; RInst)
            {
            }
            column(Principle_Repayment; "Loans Register".Repayment)
            {
            }
            column(Interest_Due; "Loans Register"."Interest Due")
            {
            }
            column(Outstanding_Bal; "Loans Register"."Outstanding Balance")
            {
            }
            column(Net_Repayment; "Net Repayment")
            {
            }
            column(IntAmount; IntAmount)
            {
            }
            trigger OnPreDataItem();
            begin

            end;

            trigger OnAfterGetRecord();
            begin
                IntAmount := 0;
                RInst := 0;
                if ("Loans Register"."Outstanding Balance" > 0) and ("Loans Register".Interest > 0) then
                    IntAmount := ROUND(("Loans Register"."Outstanding Balance") * ("Loans Register".Interest / 1200), 0.05, '>');
                if ("Loans Register"."Outstanding Balance" > 0) and ("Loans Register".Repayment > 0) then
                    //RInst:=ROUND(Loans."Outstanding Balance"/(Loans.Repayment-IntAmount),1,'>');
                    "Net Repayment" := Repayment - IntAmount;
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

        end;
    }

    trigger OnInitReport()
    begin
        Company.Get();
        Company.CalcFields(Company.Picture);
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
        Company: Record "Company Information";
        IntAmount: Decimal;
        RInst: Integer;
        "Net Repayment": Decimal;


    var
}
