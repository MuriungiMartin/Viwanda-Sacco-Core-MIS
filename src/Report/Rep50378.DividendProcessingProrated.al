#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 //  settings

Report 50378 "Dividend Processing-Prorated"
{
    RDLCLayout = 'Layouts/DividendProcessing-Prorated.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem(Customer; "Members Register")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.", Status;

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
            column(Customer_Name; Customer.Name)
            {
            }
            column(Customer__Current_Shares_; Customer."Current Shares")
            {
            }
            column(CustomerCaption; CustomerCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Customer__No__Caption; FieldCaption("No."))
            {
            }
            column(Customer_NameCaption; FieldCaption(Name))
            {
            }
            column(Customer__Current_Shares_Caption; FieldCaption("Current Shares"))
            {
            }
            trigger OnPreDataItem();
            begin
                LastFieldNo := FieldNo("No.");
                Cust.Reset;
                Cust.ModifyAll(Cust."Dividend Amount", 0);
            end;

            trigger OnAfterGetRecord();
            begin
                Customer."Dividend Amount" := 0;
                DivProg.Reset;
                DivProg.SetCurrentkey("Member No");
                DivProg.SetRange(DivProg."Member No", Customer."No.");
                if DivProg.Find('-') then
                    DivProg.DeleteAll;
                if StartDate = 0D then
                    Error('You must specify start Date.');
                DivTotal := 0;
                "W/Tax" := 0;
                CommDiv := 0;
                GenSetUp.Get(0);
                //1st Month
                Evaluate(BDate, '01/01/05');
                FromDate := BDate;
                ToDate := CalcDate('-1D', StartDate);
                Evaluate(FromDateS, Format(FromDate));
                Evaluate(ToDateS, Format(ToDate));
                DateFilter := FromDateS + '..' + ToDateS;
                Cust.Reset;
                Cust.SetCurrentkey("No.");
                Cust.SetRange(Cust."No.", Customer."No.");
                Cust.SetFilter(Cust."Date Filter", DateFilter);
                if Cust.Find('-') then begin
                    Cust.CalcFields(Cust."Current Shares", Cust."Shares Retained");
                    if (Cust."Current Shares" <> 0) then begin
                        CDiv := (((GenSetUp."Dividend (%)" / 100) * ((Cust."Shares Retained"))) * (12 / 12));
                        CInterest := (((GenSetUp."Interest on Deposits (%)" / 100) * ((Cust."Current Shares"))) * (12 / 12));
                        DivTotal := (CDiv + CInterest);
                        DivProg.Init;
                        DivProg."Member No" := Customer."No.";
                        DivProg.Date := ToDate;
                        DivProg."Gross Dividends" := CDiv;
                        DivProg."Gross Interest On Deposit" := CInterest;
                        DivProg."Qualifying Share Capital" := ((Cust."Shares Retained")) * (12 / 12);
                        DivProg."Witholding Tax" := (CDiv + CInterest) * (GenSetUp."Withholding Tax (%)" / 100);
                        DivProg."Net Dividends" := (DivProg."Gross Dividends" + DivProg."Gross Interest On Deposit") - DivProg."Witholding Tax";
                        DivProg."Qualifying Shares" := ((Cust."Current Shares")) * (12 / 12);
                        DivProg.Shares := Cust."Current Shares";
                        DivProg."Share Capital" := Cust."Shares Retained";
                        DivProg.Insert;
                    end;
                end;
                //2nd Month(Jan)
                FromDate := StartDate;
                ToDate := CalcDate('-1D', CalcDate('1M', StartDate));
                Evaluate(FromDateS, Format(FromDate));
                Evaluate(ToDateS, Format(ToDate));
                DateFilter := FromDateS + '..' + ToDateS;
                Cust.Reset;
                Cust.SetCurrentkey("No.");
                Cust.SetRange(Cust."No.", Customer."No.");
                Cust.SetFilter(Cust."Date Filter", DateFilter);
                if Cust.Find('-') then begin
                    Cust.CalcFields(Cust."Current Shares", Cust."Shares Retained");
                    if (Cust."Current Shares" <> 0) then begin
                        CDiv := (((GenSetUp."Dividend (%)" / 100) * ((Cust."Shares Retained"))) * (11 / 12));
                        CInterest := (((GenSetUp."Interest on Deposits (%)" / 100) * ((Cust."Current Shares"))) * (11 / 12));
                        DivTotal := DivTotal + (CDiv + CInterest);
                        DivProg.Init;
                        DivProg."Member No" := Customer."No.";
                        DivProg.Date := ToDate;
                        DivProg."Gross Dividends" := CDiv;
                        DivProg."Gross Interest On Deposit" := CInterest;
                        DivProg."Qualifying Share Capital" := ((Cust."Shares Retained")) * (11 / 12);
                        DivProg."Witholding Tax" := (CDiv + CInterest) * (GenSetUp."Withholding Tax (%)" / 100);
                        DivProg."Net Dividends" := (DivProg."Gross Dividends" + DivProg."Gross Interest On Deposit") - DivProg."Witholding Tax";
                        DivProg."Qualifying Shares" := ((Cust."Current Shares")) * (11 / 12);
                        DivProg.Shares := Cust."Current Shares";
                        DivProg."Share Capital" := Cust."Shares Retained";
                        DivProg.Insert;
                    end;
                end;
                //3rd Month
                FromDate := CalcDate('1M', StartDate);
                ToDate := CalcDate('-1D', CalcDate('2M', StartDate));
                Evaluate(FromDateS, Format(FromDate));
                Evaluate(ToDateS, Format(ToDate));
                DateFilter := FromDateS + '..' + ToDateS;
                Cust.Reset;
                Cust.SetCurrentkey("No.");
                Cust.SetRange(Cust."No.", Customer."No.");
                Cust.SetFilter(Cust."Date Filter", DateFilter);
                if Cust.Find('-') then begin
                    Cust.CalcFields(Cust."Current Shares", Cust."Shares Retained");
                    if (Cust."Current Shares" <> 0) then begin
                        CDiv := (((GenSetUp."Dividend (%)" / 100) * ((Cust."Shares Retained"))) * (10 / 12));
                        CInterest := (((GenSetUp."Interest on Deposits (%)" / 100) * ((Cust."Current Shares"))) * (10 / 12));
                        DivTotal := DivTotal + (CDiv + CInterest);
                        DivProg.Init;
                        DivProg."Member No" := Customer."No.";
                        DivProg.Date := ToDate;
                        DivProg."Gross Dividends" := CDiv;
                        DivProg."Gross Interest On Deposit" := CInterest;
                        DivProg."Qualifying Share Capital" := ((Cust."Shares Retained")) * (10 / 12);
                        DivProg."Witholding Tax" := (CDiv + CInterest) * (GenSetUp."Withholding Tax (%)" / 100);
                        DivProg."Net Dividends" := (DivProg."Gross Dividends" + DivProg."Gross Interest On Deposit") - DivProg."Witholding Tax";
                        DivProg."Qualifying Shares" := ((Cust."Current Shares")) * (10 / 12);
                        DivProg.Shares := Cust."Current Shares";
                        DivProg."Share Capital" := Cust."Shares Retained";
                        DivProg.Insert;
                    end;
                end;
                //4th Month
                FromDate := CalcDate('2M', StartDate);
                ToDate := CalcDate('-1D', CalcDate('3M', StartDate));
                Evaluate(FromDateS, Format(FromDate));
                Evaluate(ToDateS, Format(ToDate));
                DateFilter := FromDateS + '..' + ToDateS;
                Cust.Reset;
                Cust.SetCurrentkey("No.");
                Cust.SetRange(Cust."No.", Customer."No.");
                Cust.SetFilter(Cust."Date Filter", DateFilter);
                if Cust.Find('-') then begin
                    Cust.CalcFields(Cust."Current Shares", Cust."Shares Retained");
                    if (Cust."Current Shares" <> 0) then begin
                        CDiv := (((GenSetUp."Dividend (%)" / 100) * ((Cust."Shares Retained"))) * (9 / 12));
                        CInterest := (((GenSetUp."Interest on Deposits (%)" / 100) * ((Cust."Current Shares"))) * (9 / 12));
                        DivTotal := DivTotal + (CDiv + CInterest);
                        DivProg.Init;
                        DivProg."Member No" := Customer."No.";
                        DivProg.Date := ToDate;
                        DivProg."Gross Dividends" := CDiv;
                        DivProg."Gross Interest On Deposit" := CInterest;
                        DivProg."Qualifying Share Capital" := ((Cust."Shares Retained")) * (9 / 12);
                        DivProg."Witholding Tax" := (CDiv + CInterest) * (GenSetUp."Withholding Tax (%)" / 100);
                        DivProg."Net Dividends" := (DivProg."Gross Dividends" + DivProg."Gross Interest On Deposit") - DivProg."Witholding Tax";
                        DivProg."Qualifying Shares" := ((Cust."Current Shares")) * (9 / 12);
                        DivProg.Shares := Cust."Current Shares";
                        DivProg."Share Capital" := Cust."Shares Retained";
                        DivProg.Insert;
                    end;
                end;
                //5th Month
                FromDate := CalcDate('3M', StartDate);
                ToDate := CalcDate('-1D', CalcDate('4M', StartDate));
                Evaluate(FromDateS, Format(FromDate));
                Evaluate(ToDateS, Format(ToDate));
                DateFilter := FromDateS + '..' + ToDateS;
                Cust.Reset;
                Cust.SetCurrentkey("No.");
                Cust.SetRange(Cust."No.", Customer."No.");
                Cust.SetFilter(Cust."Date Filter", DateFilter);
                if Cust.Find('-') then begin
                    Cust.CalcFields(Cust."Current Shares", Cust."Shares Retained");
                    if (Cust."Current Shares" <> 0) then begin
                        CDiv := (((GenSetUp."Dividend (%)" / 100) * ((Cust."Shares Retained"))) * (8 / 12));
                        CInterest := (((GenSetUp."Interest on Deposits (%)" / 100) * ((Cust."Current Shares"))) * (8 / 12));
                        DivTotal := DivTotal + (CDiv + CInterest);
                        DivProg.Init;
                        DivProg."Member No" := Customer."No.";
                        DivProg.Date := ToDate;
                        DivProg."Gross Dividends" := CDiv;
                        DivProg."Gross Interest On Deposit" := CInterest;
                        DivProg."Qualifying Share Capital" := ((Cust."Shares Retained")) * (8 / 12);
                        DivProg."Witholding Tax" := (CDiv + CInterest) * (GenSetUp."Withholding Tax (%)" / 100);
                        DivProg."Net Dividends" := (DivProg."Gross Dividends" + DivProg."Gross Interest On Deposit") - DivProg."Witholding Tax";
                        DivProg."Qualifying Shares" := ((Cust."Current Shares")) * (8 / 12);
                        DivProg.Shares := Cust."Current Shares";
                        DivProg."Share Capital" := Cust."Shares Retained";
                        DivProg.Insert;
                    end;
                end;
                //6th Month
                FromDate := CalcDate('4M', StartDate);
                ToDate := CalcDate('-1D', CalcDate('5M', StartDate));
                Evaluate(FromDateS, Format(FromDate));
                Evaluate(ToDateS, Format(ToDate));
                DateFilter := FromDateS + '..' + ToDateS;
                Cust.Reset;
                Cust.SetCurrentkey("No.");
                Cust.SetRange(Cust."No.", Customer."No.");
                Cust.SetFilter(Cust."Date Filter", DateFilter);
                if Cust.Find('-') then begin
                    Cust.CalcFields(Cust."Current Shares", Cust."Shares Retained");
                    if (Cust."Current Shares" <> 0) then begin
                        CDiv := (((GenSetUp."Dividend (%)" / 100) * ((Cust."Shares Retained"))) * (7 / 12));
                        CInterest := (((GenSetUp."Interest on Deposits (%)" / 100) * ((Cust."Current Shares"))) * (7 / 12));
                        DivTotal := DivTotal + (CDiv + CInterest);
                        DivProg.Init;
                        DivProg."Member No" := Customer."No.";
                        DivProg.Date := ToDate;
                        DivProg."Gross Dividends" := CDiv;
                        DivProg."Gross Interest On Deposit" := CInterest;
                        DivProg."Qualifying Share Capital" := ((Cust."Shares Retained")) * (7 / 12);
                        DivProg."Witholding Tax" := (CDiv + CInterest) * (GenSetUp."Withholding Tax (%)" / 100);
                        DivProg."Net Dividends" := (DivProg."Gross Dividends" + DivProg."Gross Interest On Deposit") - DivProg."Witholding Tax";
                        DivProg."Qualifying Shares" := ((Cust."Current Shares")) * (7 / 12);
                        DivProg.Shares := Cust."Current Shares";
                        DivProg."Share Capital" := Cust."Shares Retained";
                        DivProg.Insert;
                    end;
                end;
                //7th Month
                FromDate := CalcDate('5M', StartDate);
                ToDate := CalcDate('-1D', CalcDate('6M', StartDate));
                Evaluate(FromDateS, Format(FromDate));
                Evaluate(ToDateS, Format(ToDate));
                DateFilter := FromDateS + '..' + ToDateS;
                Cust.Reset;
                Cust.SetCurrentkey("No.");
                Cust.SetRange(Cust."No.", Customer."No.");
                Cust.SetFilter(Cust."Date Filter", DateFilter);
                if Cust.Find('-') then begin
                    Cust.CalcFields(Cust."Current Shares", Cust."Shares Retained");
                    if (Cust."Current Shares" <> 0) then begin
                        CDiv := (((GenSetUp."Dividend (%)" / 100) * ((Cust."Shares Retained"))) * (6 / 12));
                        CInterest := (((GenSetUp."Interest on Deposits (%)" / 100) * ((Cust."Current Shares"))) * (6 / 12));
                        DivTotal := DivTotal + (CDiv + CInterest);
                        DivProg.Init;
                        DivProg."Member No" := Customer."No.";
                        DivProg.Date := ToDate;
                        DivProg."Gross Dividends" := CDiv;
                        DivProg."Gross Interest On Deposit" := CInterest;
                        DivProg."Qualifying Share Capital" := ((Cust."Shares Retained")) * (6 / 12);
                        DivProg."Witholding Tax" := (CDiv + CInterest) * (GenSetUp."Withholding Tax (%)" / 100);
                        DivProg."Net Dividends" := (DivProg."Gross Dividends" + DivProg."Gross Interest On Deposit") - DivProg."Witholding Tax";
                        DivProg."Qualifying Shares" := ((Cust."Current Shares")) * (6 / 12);
                        DivProg.Shares := Cust."Current Shares";
                        DivProg."Share Capital" := Cust."Shares Retained";
                        DivProg.Insert;
                    end;
                end;
                //8th Month
                FromDate := CalcDate('6M', StartDate);
                ToDate := CalcDate('-1D', CalcDate('7M', StartDate));
                Evaluate(FromDateS, Format(FromDate));
                Evaluate(ToDateS, Format(ToDate));
                DateFilter := FromDateS + '..' + ToDateS;
                Cust.Reset;
                Cust.SetCurrentkey("No.");
                Cust.SetRange(Cust."No.", Customer."No.");
                Cust.SetFilter(Cust."Date Filter", DateFilter);
                if Cust.Find('-') then begin
                    Cust.CalcFields(Cust."Current Shares", Cust."Shares Retained");
                    if (Cust."Current Shares" <> 0) then begin
                        CDiv := (((GenSetUp."Dividend (%)" / 100) * ((Cust."Shares Retained"))) * (5 / 12));
                        CInterest := (((GenSetUp."Interest on Deposits (%)" / 100) * ((Cust."Current Shares"))) * (5 / 12));
                        DivTotal := DivTotal + (CDiv + CInterest);
                        DivProg.Init;
                        DivProg."Member No" := Customer."No.";
                        DivProg.Date := ToDate;
                        DivProg."Gross Dividends" := CDiv;
                        DivProg."Gross Interest On Deposit" := CInterest;
                        DivProg."Qualifying Share Capital" := ((Cust."Shares Retained")) * (5 / 12);
                        DivProg."Witholding Tax" := (CDiv + CInterest) * (GenSetUp."Withholding Tax (%)" / 100);
                        DivProg."Net Dividends" := (DivProg."Gross Dividends" + DivProg."Gross Interest On Deposit") - DivProg."Witholding Tax";
                        DivProg."Qualifying Shares" := ((Cust."Current Shares")) * (5 / 12);
                        DivProg.Shares := Cust."Current Shares";
                        DivProg."Share Capital" := Cust."Shares Retained";
                        DivProg.Insert;
                    end;
                end;
                //9th Month
                FromDate := CalcDate('7M', StartDate);
                ToDate := CalcDate('-1D', CalcDate('8M', StartDate));
                Evaluate(FromDateS, Format(FromDate));
                Evaluate(ToDateS, Format(ToDate));
                DateFilter := FromDateS + '..' + ToDateS;
                Cust.Reset;
                Cust.SetCurrentkey("No.");
                Cust.SetRange(Cust."No.", Customer."No.");
                Cust.SetFilter(Cust."Date Filter", DateFilter);
                if Cust.Find('-') then begin
                    Cust.CalcFields(Cust."Current Shares", Cust."Shares Retained");
                    if (Cust."Current Shares" <> 0) then begin
                        CDiv := (((GenSetUp."Dividend (%)" / 100) * ((Cust."Shares Retained"))) * (4 / 12));
                        CInterest := (((GenSetUp."Interest on Deposits (%)" / 100) * ((Cust."Current Shares"))) * (4 / 12));
                        DivTotal := DivTotal + (CDiv + CInterest);
                        DivProg.Init;
                        DivProg."Member No" := Customer."No.";
                        DivProg.Date := ToDate;
                        DivProg."Gross Dividends" := CDiv;
                        DivProg."Gross Interest On Deposit" := CInterest;
                        DivProg."Qualifying Share Capital" := ((Cust."Shares Retained")) * (4 / 12);
                        DivProg."Witholding Tax" := (CDiv + CInterest) * (GenSetUp."Withholding Tax (%)" / 100);
                        DivProg."Net Dividends" := (DivProg."Gross Dividends" + DivProg."Gross Interest On Deposit") - DivProg."Witholding Tax";
                        DivProg."Qualifying Shares" := ((Cust."Current Shares")) * (4 / 12);
                        DivProg.Shares := Cust."Current Shares";
                        DivProg."Share Capital" := Cust."Shares Retained";
                        DivProg.Insert;
                    end;
                end;
                //10th Month
                FromDate := CalcDate('8M', StartDate);
                ToDate := CalcDate('-1D', CalcDate('9M', StartDate));
                Evaluate(FromDateS, Format(FromDate));
                Evaluate(ToDateS, Format(ToDate));
                DateFilter := FromDateS + '..' + ToDateS;
                Cust.Reset;
                Cust.SetCurrentkey("No.");
                Cust.SetRange(Cust."No.", Customer."No.");
                Cust.SetFilter(Cust."Date Filter", DateFilter);
                if Cust.Find('-') then begin
                    Cust.CalcFields(Cust."Current Shares", Cust."Shares Retained");
                    if (Cust."Current Shares" <> 0) then begin
                        CDiv := (((GenSetUp."Dividend (%)" / 100) * ((Cust."Shares Retained"))) * (3 / 12));
                        CInterest := (((GenSetUp."Interest on Deposits (%)" / 100) * ((Cust."Current Shares"))) * (3 / 12));
                        DivTotal := DivTotal + (CDiv + CInterest);
                        DivProg.Init;
                        DivProg."Member No" := Customer."No.";
                        DivProg.Date := ToDate;
                        DivProg."Gross Dividends" := CDiv;
                        DivProg."Gross Interest On Deposit" := CInterest;
                        DivProg."Qualifying Share Capital" := ((Cust."Shares Retained")) * (3 / 12);
                        DivProg."Witholding Tax" := (CDiv + CInterest) * (GenSetUp."Withholding Tax (%)" / 100);
                        DivProg."Net Dividends" := (DivProg."Gross Dividends" + DivProg."Gross Interest On Deposit") - DivProg."Witholding Tax";
                        DivProg."Qualifying Shares" := ((Cust."Current Shares")) * (3 / 12);
                        DivProg.Shares := Cust."Current Shares";
                        DivProg."Share Capital" := Cust."Shares Retained";
                        DivProg.Insert;
                    end;
                end;
                //11th Month
                FromDate := CalcDate('9M', StartDate);
                ToDate := CalcDate('-1D', CalcDate('10M', StartDate));
                Evaluate(FromDateS, Format(FromDate));
                Evaluate(ToDateS, Format(ToDate));
                DateFilter := FromDateS + '..' + ToDateS;
                Cust.Reset;
                Cust.SetCurrentkey("No.");
                Cust.SetRange(Cust."No.", Customer."No.");
                Cust.SetFilter(Cust."Date Filter", DateFilter);
                if Cust.Find('-') then begin
                    Cust.CalcFields(Cust."Current Shares", Cust."Shares Retained");
                    if (Cust."Current Shares" <> 0) then begin
                        CDiv := (((GenSetUp."Dividend (%)" / 100) * ((Cust."Shares Retained"))) * (2 / 12));
                        CInterest := (((GenSetUp."Interest on Deposits (%)" / 100) * ((Cust."Current Shares"))) * (2 / 12));
                        DivTotal := DivTotal + (CDiv + CInterest);
                        DivProg.Init;
                        DivProg."Member No" := Customer."No.";
                        DivProg.Date := ToDate;
                        DivProg."Gross Dividends" := CDiv;
                        DivProg."Gross Interest On Deposit" := CInterest;
                        DivProg."Qualifying Share Capital" := ((Cust."Shares Retained")) * (2 / 12);
                        DivProg."Witholding Tax" := (CDiv + CInterest) * (GenSetUp."Withholding Tax (%)" / 100);
                        DivProg."Net Dividends" := (DivProg."Gross Dividends" + DivProg."Gross Interest On Deposit") - DivProg."Witholding Tax";
                        DivProg."Qualifying Shares" := ((Cust."Current Shares")) * (2 / 12);
                        DivProg.Shares := Cust."Current Shares";
                        DivProg."Share Capital" := Cust."Shares Retained";
                        DivProg.Insert;
                    end;
                end;
                //12th Month
                FromDate := CalcDate('10M', StartDate);
                ToDate := CalcDate('-1D', CalcDate('11M', StartDate));
                Evaluate(FromDateS, Format(FromDate));
                Evaluate(ToDateS, Format(ToDate));
                DateFilter := FromDateS + '..' + ToDateS;
                Cust.Reset;
                Cust.SetCurrentkey("No.");
                Cust.SetRange(Cust."No.", Customer."No.");
                Cust.SetFilter(Cust."Date Filter", DateFilter);
                if Cust.Find('-') then begin
                    Cust.CalcFields(Cust."Current Shares", Cust."Shares Retained");
                    if (Cust."Current Shares" <> 0) then begin
                        CDiv := (((GenSetUp."Dividend (%)" / 100) * ((Cust."Shares Retained"))) * (1 / 12));
                        CInterest := (((GenSetUp."Interest on Deposits (%)" / 100) * ((Cust."Current Shares"))) * (1 / 12));
                        DivTotal := DivTotal + (CDiv + CInterest);
                        DivProg.Init;
                        DivProg."Member No" := Customer."No.";
                        DivProg.Date := ToDate;
                        DivProg."Gross Dividends" := CDiv;
                        DivProg."Gross Interest On Deposit" := CInterest;
                        DivProg."Qualifying Share Capital" := ((Cust."Shares Retained")) * (1 / 12);
                        DivProg."Witholding Tax" := (CDiv + CInterest) * (GenSetUp."Withholding Tax (%)" / 100);
                        DivProg."Net Dividends" := (DivProg."Gross Dividends" + DivProg."Gross Interest On Deposit") - DivProg."Witholding Tax";
                        DivProg."Qualifying Shares" := ((Cust."Current Shares")) * (1 / 12);
                        DivProg.Shares := Cust."Current Shares";
                        DivProg."Share Capital" := Cust."Shares Retained";
                        DivProg.Insert;
                    end;
                end;
                Customer."Dividend Amount" := DivTotal;
                Customer.Modify;
                DivProg.Reset;
                DivProg.SetRange(DivProg."Member No", "No.");
                if DivProg.Find('-') then begin
                    repeat
                        "W/Tax" += DivProg."Witholding Tax";
                        CommDiv += DivProg.Shares;
                    until DivProg.Next = 0;
                end;
                //Initialize Poosting==============================================================================
                BATCH_TEMPLATE := 'PAYMENTS';
                BATCH_NAME := 'DIVIDEND';
                DOCUMENT_NO := 'DIV_' + Format(PostingDate);
                ObjGensetup.Get();
                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                GenJournalLine.DeleteAll;
                //------------------------------------1. CREDIT MEMBER DIVIDEND A/C_Gross Dividend+Interest on Deposits---------------------------------------
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::Dividend,
                GenJournalLine."account type"::Member, "No.", PostingDate, DivTotal * -1, 'BOSA', '',
                'Gross Dividend+Interest on Deposits- ' + Format(PostingDate), '', AppSource::" ");
                //--------------------------------(CREDIT MEMBER DIVIDEND A/C_Gross Dividend+Interest on Deposits)---------------------------------------------
                //------------------------------------1.1 DEBIT DIVIVIDEND PAYABLE GL A/C-----------------------------------------------------------------------
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                GenJournalLine."account type"::"G/L Account", ObjGensetup."Dividend Payable Account", PostingDate, DivTotal, 'BOSA', '',
                'Gross Dividend+Interest on Deposits- ' + Format(PostingDate), '', AppSource::" ");
                //----------------------------------(Debit Dividend Payable GL A/C)----------------------------------------------------------------------------
                //------------------------------------2. DEBIT MEMBER DIVIDEND A/C_GROSS WITHHOLDING TAX-------------------------------------------------------
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::Dividend,
                GenJournalLine."account type"::Member, "No.", PostingDate, (DivTotal * (ObjGensetup."Withholding Tax (%)" / 100)), 'BOSA', '',
                'Witholding Tax on Dividend- ' + Format(PostingDate), '', AppSource::" ");
                //--------------------------------(Debit Member Dividend A/C_Gross Witholding Tax)-------------------------------------------------------------
                //------------------------------------2.1. CREDIT WITHHOLDING TAX GL A/C-----------------------------------------------------------------------
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                GenJournalLine."account type"::"G/L Account", ObjGensetup."WithHolding Tax Account", PostingDate, (DivTotal * (ObjGensetup."Withholding Tax (%)" / 100)) * -1, 'BOSA', '',
                'Witholding Tax on Dividend- ' + Format(PostingDate), '', AppSource::" ");
                //----------------------------------(Credit Witholding tax gl a/c)-----------------------------------------------------------------------------
                //------------------------------------3. DEBIT MEMBER DIVIDEND A/C_PROCESSING FEE--------------------------------------------------------------
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::Dividend,
                GenJournalLine."account type"::Member, "No.", PostingDate, ObjGensetup."Dividend Processing Fee", 'BOSA', '',
                'Processing Fee- ' + Format(PostingDate), '', AppSource::" ");
                //--------------------------------(Debit Member Dividend A/C_Processing Fee)-------------------------------------------------------------------
                //------------------------------------3.1. CREDIT PROCESSING FEE INCOME GL A/C-----------------------------------------------------------------
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                GenJournalLine."account type"::"G/L Account", ObjGensetup."Dividend Process Fee Account", PostingDate, ObjGensetup."Dividend Processing Fee" * -1, 'BOSA', '',
                'Processing Fee- ' + Format(PostingDate), '', AppSource::" ");
                //----------------------------------(Credit Processing Fee income gl a/c)----------------------------------------------------------------------
                //------------------------------------4. DEBIT MEMBER DIVIDEND A/C_EXCISE ON PROCESSING FEE----------------------------------------------------
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::Dividend,
                GenJournalLine."account type"::Member, "No.", PostingDate, (ObjGensetup."Dividend Processing Fee" * (ObjGensetup."Excise Duty(%)" / 100)), 'BOSA', '',
                'Excise Duty- ' + Format(PostingDate), '', AppSource::" ");
                //--------------------------------(Debit Member Dividend A/C_Excise On Processing Fee)---------------------------------------------------------
                //------------------------------------4.1. CREDIT EXCISE DUTY GL A/C-----------------------------------------------------------------
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                GenJournalLine."account type"::"G/L Account", ObjGensetup."Excise Duty Account", PostingDate, (ObjGensetup."Dividend Processing Fee" * (ObjGensetup."Excise Duty(%)" / 100)) * -1, 'BOSA', '',
                'Excise Duty- ' + Format(PostingDate), '', AppSource::" ");
                //----------------------------------(Credit Excise Duty gl a/c)----------------------------------------------------------------------
                //CU posting
                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name", 'PAYMENTS');
                GenJournalLine.SetRange("Journal Batch Name", 'DIVIDEND');
                if GenJournalLine.Find('-') then
                    Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJournalLine);
                FnRecoverLoansinArrears("No.");//=========================Recover Loan In Arrears From Dividend Account
                FnRecoverCapitalizedAmount("No.");//======================Recover Capitalized Amount to Deposits
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
                field(StartDate; StartDate)
                {
                    ApplicationArea = Basic;
                }
                field(PostingDate; PostingDate)
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
        CustomerCaptionLbl: label 'Customer';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        Cust: Record "Members Register";
        StartDate: Date;
        DateFilter: Text[100];
        FromDate: Date;
        ToDate: Date;
        FromDateS: Text[100];
        ToDateS: Text[100];
        DivTotal: Decimal;
        GenSetUp: Record "Sacco General Set-Up";
        CDeposits: Decimal;
        CustDiv: Record "Members Register";
        DivProg: Record "Dividends Progression";
        CDiv: Decimal;
        CInterest: Decimal;
        BDate: Date;
        CustR: Record "Members Register";
        IntRebTotal: Decimal;
        CIntReb: Decimal;
        LineNo: Integer;
        Gnjlline: Record "Gen. Journal Line";
        PostingDate: Date;
        "W/Tax": Decimal;
        CommDiv: Decimal;
        GenJournalLine: Record "Gen. Journal Line";
        SFactory: Codeunit "SURESTEP Factory";
        BATCH_NAME: Code[50];
        BATCH_TEMPLATE: Code[50];
        DOCUMENT_NO: Code[50];
        ObjGensetup: Record "Sacco General Set-Up";
        AppSource: Option " ",CBS,ATM,Mobile,Internet,MPESA,Equity,"Co-op",Family,"SMS Banking";

    local procedure FnRecoverLoansinArrears(MemberNo: Code[30])
    var
        ObjLoans: Record "Loans Register";
        VarAmountinArrears: Decimal;
        ObjMember: Record "Members Register";
        VarRuningBal: Decimal;
        VarAmountRecovered: Decimal;
    begin
        ObjLoans.CalcFields(ObjLoans."Outstanding Balance");
        ObjLoans.Reset;
        ObjLoans.SetRange(ObjLoans."Client Code", MemberNo);
        ObjLoans.SetFilter(ObjLoans."Outstanding Balance", '>%1', 0);
        if ObjLoans.FindSet then begin
            repeat
                VarAmountinArrears := SFactory.FnGetLoanAmountinArrears(ObjLoans."Loan  No.");
                ObjMember.Reset;
                ObjMember.SetRange(ObjMember."No.", MemberNo);
                if ObjMember.FindSet then begin
                    ObjMember.CalcFields(ObjMember."Dividend Amount");
                    VarRuningBal := ObjMember."Dividend Amount";
                end;
                if VarAmountinArrears > 0 then begin
                    if VarRuningBal >= VarAmountinArrears then begin
                        VarAmountRecovered := VarAmountinArrears
                    end else
                        VarAmountRecovered := VarRuningBal;
                    //------------------------------------2. DEBIT MEMBER DIVIDEND A/C_LOAN IN ARREARS-------------------------------------------------------
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::Dividend,
                    GenJournalLine."account type"::None, MemberNo, PostingDate, VarAmountRecovered, 'BOSA', ObjLoans."Loan  No.",
                    'Loan in Arrears Recovered- ' + Format(ObjLoans."Loan  No."), ObjLoans."Loan  No.", AppSource::" ");
                    //--------------------------------(Debit Member Dividend A/C_Loan In Arrears)-------------------------------------------------------------
                    //------------------------------------2.1. CREDIT MEMBER LOAN IN AREARS-----------------------------------------------------------------------
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Repayment",
                    GenJournalLine."account type"::None, MemberNo, PostingDate, VarAmountRecovered * -1, 'BOSA', ObjLoans."Loan  No.",
                    'Loan In Arrears Recovered From Dividend- ' + Format(PostingDate), ObjLoans."Loan  No.", AppSource::" ");
                    //----------------------------------(Credit Member Loan In Arrears)-----------------------------------------------------------------------------
                    //CU posting
                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", 'PAYMENTS');
                    GenJournalLine.SetRange("Journal Batch Name", 'DIVIDEND');
                    if GenJournalLine.Find('-') then
                        Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJournalLine);
                end;
            until ObjLoans.Next = 0;
        end;
    end;

    local procedure FnRecoverCapitalizedAmount(MemberNo: Code[30])
    var
        ObjMember: Record "Members Register";
        VarExpectedCapitalizedAmount: Decimal;
        VarActualCapitalizedAmount: Decimal;
        VarDepositDifference: Decimal;
    begin
        ObjGensetup.Get();
        //Individual Account==================================================================================================================
        ObjMember.Reset;
        ObjMember.SetRange(ObjMember."No.", MemberNo);
        ObjMember.SetRange(ObjMember."Account Category", ObjMember."account category"::Individual);
        if ObjMember.FindSet then begin
            ObjMember.CalcFields(ObjMember."Dividend Amount");
            if ObjMember."Current Shares" < ObjGensetup."Div Capitalization Min_Indiv" then begin
                VarDepositDifference := ObjGensetup."Div Capitalization Min_Indiv" - ObjMember."Current Shares";
                VarExpectedCapitalizedAmount := ((ObjGensetup."Div Capitalization %" / 100) * ObjMember."Dividend Amount");
                if VarExpectedCapitalizedAmount > VarDepositDifference then begin
                    VarActualCapitalizedAmount := VarDepositDifference
                end else
                    VarActualCapitalizedAmount := VarExpectedCapitalizedAmount;
                //------------------------------------2. DEBIT MEMBER DIVIDEND A/C-------------------------------------------------------
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::Dividend,
                GenJournalLine."account type"::None, MemberNo, PostingDate, VarActualCapitalizedAmount, 'BOSA', '',
                'Dividend Capitalized- ' + Format(PostingDate), '', AppSource::" ");
                //--------------------------------(Debit Member Dividend A/C)-------------------------------------------------------------
                //------------------------------------2.1. CREDIT MEMBER DEPOSIT CONTRIBUTION-----------------------------------------------------------------------
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Deposit Contribution",
                GenJournalLine."account type"::None, MemberNo, PostingDate, VarActualCapitalizedAmount * -1, 'BOSA', '',
                'Dividend Capitalized- ' + Format(PostingDate), '', AppSource::" ");
                //----------------------------------(Credit Member Deposit Contribution)-----------------------------------------------------------------------------
                //CU posting
                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name", 'PAYMENTS');
                GenJournalLine.SetRange("Journal Batch Name", 'DIVIDEND');
                if GenJournalLine.Find('-') then
                    Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJournalLine);
            end;
        end;
        ObjGensetup.Get();
        //Corporate Accounts========================================================================================================================
        ObjMember.Reset;
        ObjMember.SetRange(ObjMember."No.", MemberNo);
        ObjMember.SetRange(ObjMember."Account Category", ObjMember."account category"::Joint);
        if ObjMember.FindSet then begin
            ObjMember.CalcFields(ObjMember."Dividend Amount");
            if ObjMember."Current Shares" < ObjGensetup."Div Capitalization Min_Corp" then begin
                VarDepositDifference := ObjGensetup."Div Capitalization Min_Corp" - ObjMember."Current Shares";
                VarExpectedCapitalizedAmount := ((ObjGensetup."Div Capitalization %" / 100) * ObjMember."Dividend Amount");
                if VarExpectedCapitalizedAmount > VarDepositDifference then begin
                    VarActualCapitalizedAmount := VarDepositDifference
                end else
                    VarActualCapitalizedAmount := VarExpectedCapitalizedAmount;
                //------------------------------------2. DEBIT MEMBER DIVIDEND A/C-------------------------------------------------------
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::Dividend,
                GenJournalLine."account type"::None, MemberNo, PostingDate, VarActualCapitalizedAmount, 'BOSA', '',
                'Dividend Capitalized- ' + Format(PostingDate), '', AppSource::" ");
                //--------------------------------(Debit Member Dividend A/C)-------------------------------------------------------------
                //------------------------------------2.1. CREDIT MEMBER DEPOSIT CONTRIBUTION-----------------------------------------------------------------------
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Deposit Contribution",
                GenJournalLine."account type"::None, MemberNo, PostingDate, VarActualCapitalizedAmount * -1, 'BOSA', '',
                'Dividend Capitalized- ' + Format(PostingDate), '', AppSource::" ");
                //----------------------------------(Credit Member Deposit Contribution)-----------------------------------------------------------------------------
                //CU posting
                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name", 'PAYMENTS');
                GenJournalLine.SetRange("Journal Batch Name", 'DIVIDEND');
                if GenJournalLine.Find('-') then
                    Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJournalLine);
            end;
        end;
    end;


    var
}
