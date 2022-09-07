#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // 

Report 50472 "Loan Defaulter Aging"
{
    RDLCLayout = 'Layouts/LoanDefaulterAging.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Loans Register"; "Loans Register")
        {
            DataItemTableView = sorting("Loan  No.") where("Outstanding Balance" = filter(> 0));
            RequestFilterFields = "Loan Product Type", "Outstanding Balance";

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
            column(Loan_Type; "Loans Register"."Loan Product Type")
            {
            }
            column(Client_Code; "Loans Register"."Client Code")
            {
            }
            column(Client_Name; Loans."Client Name")
            {
            }
            column(Interest_Due; Loans."Interest Due")
            {
            }
            column(Approved_Amount; Loans."Approved Amount")
            {
            }
            column(OneMonth; "1Month")
            {
            }
            column(TwoMonths; "2Month")
            {
            }
            column(ThreeMonths; "3Month")
            {
            }
            column(Over3Month; Over3Month)
            {
            }
            column(Outstanding_Balance; Loans."Outstanding Balance")
            {
            }
            column(No; SN)
            {
            }
            trigger OnPreDataItem();
            begin

                GrandTotal := 0;
            end;

            trigger OnAfterGetRecord();
            begin
                if AsAt = 0D then
                    AsAt := Today;
                Evaluate(DFormula, '1Q');
                "1Month" := 0;
                "2Month" := 0;
                "3Month" := 0;
                Over3Month := 0;
                Loans.CalcFields(Loans."Last Pay Date", Loans."Outstanding Balance");
                if Loans."Instalment Period" = DFormula then
                    LastDueDate := CalcDate('1Q', Loans."Last Pay Date")
                else
                    LastDueDate := Loans."Last Pay Date";
                if LastDueDate = 0D then begin
                    LastDueDate := CalcDate('1M', Loans."Issued Date");
                end;
                if LastDueDate > CalcDate('-1M', AsAt) then
                    "1Month" := Loans."Outstanding Balance"
                else
                    if LastDueDate > CalcDate('-2M', AsAt) then
                        "2Month" := Loans."Outstanding Balance"
                    else
                        if LastDueDate > CalcDate('-3M', AsAt) then
                            "3Month" := Loans."Loan Balance at Rescheduling"
                        else
                            if LastDueDate > CalcDate('-4M', AsAt) then
                                Over3Month := Loans."Outstanding Balance"
                            else
                                Over3Month := Loans."Outstanding Balance";
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
                field(AsAt; AsAt)
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
        SN: Integer;
        Company: Record "Company Information";
        "1Month": Decimal;
        "2Month": Decimal;
        "3Month": Decimal;
        Over3Month: Decimal;
        ShowLoan: Boolean;
        AsAt: Date;
        LastDueDate: Date;
        DFormula: DateFormula;
        Loans: Record "Loans Register";
        "0Month": Decimal;
        GrandTotal: Decimal;


    var

}
