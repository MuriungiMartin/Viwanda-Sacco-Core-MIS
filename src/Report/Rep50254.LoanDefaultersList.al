#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
//51516254_v6_3_0_2259) { }
// Autogenerated code - do not delete or modify -->

Report 50254 "Loan Defaulters List"
{
    RDLCLayout = 'Layouts/LoanDefaultersList.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem(Loans; "Loans Register")
        {
            DataItemTableView = sorting("Client Code", "Loan Product Type", Posted, "Issued Date") order(ascending) where("Outstanding Balance" = filter(> 0), Installments = filter(> 0));
            RequestFilterFields = "Issued Date", "Date filter", "Loan Product Type", "Client Code";
            column(ReportForNavId_1102755000; 1102755000) { } // Autogenerated by ForNav - Do not delete
            column(LoanNo; "Loan  No.")
            {
            }
            column(LoanType; "Loan Product Type")
            {
            }
            column(ClientCode; "Client Code")
            {
            }
            column(ClientName; "Client Name")
            {
            }
            column(ApprovedAmnt; "Approved Amount")
            {
            }
            column(AmountPaid; Amountpaid)
            {
            }
            column(Outstandingbal; totalbal)
            {
            }
            column(TotalActual; TotalActual)
            {
            }
            column(AmountDefaulted; "Amount defaulted")
            {
            }
            column(LaSTpaydate; "Last Pay Date")
            {
            }
            // column(InstallmentDefaulted; "Installment Defaulted")
            // {
            // }
            column(IssuedDate; Loans."Issued Date")
            {
            }
            column(Period; Period)
            {
            }
            trigger OnPreDataItem();
            begin
                CurrDate := Loans.GetRangemax(Loans."Date filter");
                Loans.SetRange(Loans."Date filter", 0D, CurrDate);
            end;

            trigger OnAfterGetRecord();
            begin
                "Amount defaulted" := 0;
                Amountpaid := 0;
                TotalActual := 0;
                ExpIntallment := 0;
                if Loans."Issued Date" = 0D then
                    CurrReport.Skip;
                Period := Loans.Installments;
                HesabuWeeks := ROUND((CurrDate - Loans."Issued Date") / 31, 1.0, '<');
                //MESSAGE('%1Curr Date',HesabuWeeks);
                if (CurrDate - Loans."Issued Date") > 1 then
                    Loans.CalcFields(Loans."Outstanding Balance");
                Loans.CalcFields(Loans."Interest Due");
                Amountpaid := Loans."Approved Amount" - Loans."Outstanding Balance";
                totalbal := Loans."Outstanding Balance";//+Loans."Interest Due";
                                                        //ExpIntallment:=ROUND(Amountpaid/Loans.Repayment,1);
                if (Amountpaid > 0) and (Loans.Repayment > 0) then begin  //for loans that approved amount is greater than outstanding balance
                    ExpIntallment := ROUND((Loans."Approved Amount" - Loans."Outstanding Balance") /
                    Loans.Repayment, 1);
                    if HesabuWeeks >= Loans.Installments then begin
                        TotalActual := Loans."Loan Principle Repayment" * Loans.Installments;
                    end else
                        if HesabuWeeks < Loans.Installments then begin
                            TotalActual := Loans."Loan Principle Repayment" * HesabuWeeks;
                        end;
                    //
                    if HesabuWeeks > Loans.Installments then begin
                        "Defaulted install" := Loans.Installments - ExpIntallment;
                        if Amountpaid > 0 then begin
                            "Amount defaulted" := (TotalActual - Amountpaid);
                        end else
                            if Amountpaid < 0 then
                                "Amount defaulted" := ("Defaulted install" * Loans.Installments) + TotalActual;
                        //   Loans."Total Loans Default":= "Amount defaulted";
                        //    Loans."Installment Defaulted":=HesabuWeeks-ExpIntallment
                    end else
                        if HesabuWeeks > ExpIntallment then begin
                            "Defaulted install" := HesabuWeeks - ExpIntallment;
                            "Amount defaulted" := TotalActual - Amountpaid;
                            //IF  "Amount defaulted" >0 THEN BEGIN
                            // Cust.GET(Loans."Client Code");
                            //Cust.Status:= Cust.Status::Defaulter;
                            //Cust.MODIFY;
                            //END;
                            //   Loans."Total Loans Default":= "Amount defaulted";
                            //   Loans."Installment Defaulted":=HesabuWeeks-ExpIntallment
                        end;
                    Loans.Modify;
                    TotalAmountDefaulted := TotalAmountDefaulted + "Amount defaulted";
                    if ("Amount defaulted" = 0) or ("Amount defaulted" < 0) then
                        CurrReport.Skip;
                end;
                no := no + 1;
                Cust.Reset;
                Cust.SetRange(Cust."No.", "Client Code");
                //cust.SETRANGE("Transaction Type",membledg."Transaction Type"::"Deposit Contribution");
                if Cust.Find('-') then begin
                    Cust.CalcFields(Cust."Current Shares");
                    Savings := Cust."Current Shares";
                end
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
        ;

    end;

    var
        "1Month": Decimal;
        "2Month": Decimal;
        "3Month": Decimal;
        Over3Month: Decimal;
        ShowLoan: Boolean;
        TShare: Decimal;
        TLApp: Decimal;
        TCheque: Decimal;
        DateFilterBF: Text[150];
        TLBalance: Decimal;
        GenSetUp: Record "HR Appraisal Evaluation Descri";
        LoanApp: Record "HR Transport Requisition Pass";
        PendingApp: Decimal;
        ApprovedApp: Decimal;
        Cust: Record Customer;
        ShowSec: Boolean;
        TLAppB: Decimal;
        TChequeB: Decimal;
        TReq: Decimal;
        Variance: Integer;
        CurrDate: Date;
        Savings: Decimal;
        Tsavings: Decimal;
        vend: Record Vendor;
        TapprovedAmount: Decimal;
        "Amount defaulted": Decimal;
        "Defaulted install": Decimal;
        TotalActual: Decimal;
        ExpIntallment: Decimal;
        membledg: Record "HR Calendar List";
        HesabuWeeks: Decimal;
        ExpectedPrinc: Decimal;
        TotExpPr: Decimal;
        TotExpAmount: Decimal;
        Amountpaid: Decimal;
        TotalAmountDefaulted: Decimal;
        no: Integer;
        totalbal: Decimal;
        Period: Decimal;

    // --> Reports ForNAV Autogenerated code - do not delete or modify
    //51516254_v6_3_0_2259;






    // Reports ForNAV Autogenerated code - do not delete or modify -->
}
