#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // settings
Report 50377 "Dividend Register"
{
    RDLCLayout = 'Layouts/DividendRegister.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = Status, "Date Filter", "Employer Code", "Dividend Amount", "Mode of Dividend Payment", "Dividends Capitalised %", "Customer Type", "Net Dividend Payable";

            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }

            column(UserId; UserId)
            {
            }
            column(Customer__No__; Customer."No.")
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
            column(Customer__Payroll_Staff_No_; Customer."Payroll No")
            {
            }
            column(Customer_Name; Customer.Name)
            {
            }
            column(Customer_Customer__Qualifying_Shares_; Customer."Qualifying Shares")
            {
            }
            column(Customer__Dividend_Amount_; Customer."Dividend Amount")
            {
            }
            column(WithholdingTax; WithholdingTax)
            {
            }
            column(DividendWithholdingTax; Customer."Dividend Withholding Tax")
            {
            }
            column(DividendCapitalized; DividendCapitalized)
            {
            }
            column(DividendCapitalizedNew; Customer."Dividend Capitalized")
            {
            }
            column(SharesDiv; SharesDiv)
            {
            }
            column(CurrentShares; Customer."Current Shares")
            {
            }
            column(PayableDiv; Customer."Net Dividend Payable")
            {
            }
            column(Customer__Dividend_Amount__Control1000000022; Customer."Dividend Amount")
            {
            }
            column(TWTax; TWTax)
            {
            }
            column(GrossDividend; Customer."Gross Dividend Amount Payable")
            {
            }
            column(TPDiv; TPDiv)
            {
            }
            column(RetainedShares; Customer."Shares Retained")
            {
            }
            column(TSharesDiv; TSharesDiv)
            {
            }
            column(Dividend_Amount____TSharesDiv; "Dividend Amount" - TSharesDiv)
            {
            }
            column(TDividendCapitalized; TDividendCapitalized)
            {
            }
            column(Dividends_RegisterCaption; Dividends_RegisterCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Customer__No__Caption; FieldCaption("No."))
            {
            }
            column(Customer__Payroll_Staff_No_Caption; FieldCaption("Payroll No"))
            {
            }
            column(Customer_NameCaption; FieldCaption(Name))
            {
            }
            column(Qualifying_SharesCaption; Qualifying_SharesCaptionLbl)
            {
            }
            column(Gross_DividendsCaption; Gross_DividendsCaptionLbl)
            {
            }
            column(Withholding_TaxCaption; Withholding_TaxCaptionLbl)
            {
            }
            column(Dividend_CapitalizedCaption; Dividend_CapitalizedCaptionLbl)
            {
            }
            column(Dividends__Shares_Caption; Dividends__Shares_CaptionLbl)
            {
            }
            column(Dividends__Deposits_Caption; Dividends__Deposits_CaptionLbl)
            {
            }
            column(Dividend_PayableCaption; Dividend_PayableCaptionLbl)
            {
            }
            column(TotalsCaption; TotalsCaptionLbl)
            {
            }
            column(CommisionCharged; CommisionCharged)
            {
            }
            column(ExciseDuty; "Excise Duty(10%)")
            {
            }
            trigger OnPreDataItem();
            begin
                GenSetup.Get(0);
                CommisionCharged := GenSetup."Dividend Processing Fee";
                "Excise Duty(10%)" := 0.1 * CommisionCharged;
                CommisionCharged := GenSetup."Dividend Processing Fee" - 0.1 * CommisionCharged;
            end;

            trigger OnAfterGetRecord();
            begin
                WithholdingTax := 0;
                PayableDiv := 0;
                DividendCapitalized := 0;
                SharesDiv := 100;
                if "Net Dividend Payable" <= 0 then begin
                    CommisionCharged := 0;
                    "Excise Duty(10%)" := 0;
                end
                else begin
                    CommisionCharged := GenSetup."Dividend Processing Fee" * (1 - 0.1);
                    "Excise Duty(10%)" := 0.1 * GenSetup."Dividend Processing Fee";
                end;
                if Customer."Dividend Amount" > 0 then begin
                    WithholdingTax := Customer."Dividend Amount" * (GenSetup."Withholding Tax (%)" / 100);
                    PayableDiv := Customer."Dividend Amount" - WithholdingTax;
                    DividendCapitalized := (PayableDiv * Customer."Dividends Capitalised %") * 0.01;
                    PayableDiv := PayableDiv - DividendCapitalized;
                end;
                TWTax := TWTax + WithholdingTax;
                TPDiv := TPDiv + PayableDiv;
                TDividendCapitalized := TDividendCapitalized + DividendCapitalized;
                TSharesDiv := TSharesDiv + SharesDiv;
                //****************************************kk
                WithholdingTax := 0;
                PayableDiv := 0;
                SharesDiv := 100;
                GDiv := 0;
                TWTax := 0;
                TPDiv := 0;
                TSharesDiv := 0;
                CalcFields(Customer."Dividend Amount", Customer."Current Shares", Customer."Shares Retained");
                //>IF Customer."Dividend Amount" <> 0 THEN BEGIN
                //Customer.SETRANGE(Customer."Date Filter",Date1);
                //Share:=("Shares Variance");
                //>END;
                //>IF Customer."Dividend Amount" <> 0 THEN BEGIN
                //Customer.SETRANGE(Customer."Date Filter",Date2);
                GDiv := Customer."Dividend Amount" / 0.95;
                WithholdingTax := GDiv * (GenSetup."Withholding Tax (%)" / 100);
                PayableDiv := Customer."Dividend Amount";
                //>END;
                TWTax := TWTax + WithholdingTax;
                TPDiv := TPDiv + PayableDiv;
                TSharesDiv := TSharesDiv + SharesDiv;
                //****************************************kk
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
        Company.Get();
        Company.CalcFields(Company.Picture)
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
        WithholdingTax: Decimal;
        GenSetup: Record "Sacco General Set-Up";
        PayableDiv: Decimal;
        TWTax: Decimal;
        TPDiv: Decimal;
        SharesDiv: Decimal;
        TSharesDiv: Decimal;
        DividendCapitalized: Decimal;
        TDividendCapitalized: Decimal;
        Dividends_RegisterCaptionLbl: label 'Dividends Register';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        Qualifying_SharesCaptionLbl: label 'Qualifying Shares';
        Gross_DividendsCaptionLbl: label 'Gross Dividends';
        Withholding_TaxCaptionLbl: label 'Withholding Tax';
        Dividend_CapitalizedCaptionLbl: label 'Dividend Capitalized';
        Dividends__Shares_CaptionLbl: label 'Dividends (Shares)';
        Dividends__Deposits_CaptionLbl: label 'Dividends (Deposits)';
        Dividend_PayableCaptionLbl: label 'Dividend Payable';
        TotalsCaptionLbl: label 'Totals';
        Company: Record "Company Information";
        CommisionCharged: Decimal;
        "Excise Duty(10%)": Decimal;
        GDiv: Decimal;


    var

}
