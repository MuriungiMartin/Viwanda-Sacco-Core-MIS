
Report 50501 "Interest Due Period."
{
    RDLCLayout = 'Layouts/InterestDuePeriod..rdlc';
    DefaultLayout = RDLC;

    requestpage
    {


        SaveValues = false;
        layout
        {
            area(content)
            {
                field("Int Due Year Start Date"; FiscalYearStartDate)
                {
                    ApplicationArea = Basic;
                }
                field("No Of Periods"; NoOfPeriods)
                {
                    ApplicationArea = Basic;
                }
                field("Period Length"; PeriodLength)
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
        AccountingPeriod."Interest Due Date" := FiscalYearStartDate;
        AccountingPeriod.TestField("Interest Due Date");
        if AccountingPeriod.Find('-') then begin
            FirstPeriodStartDate := AccountingPeriod."Interest Due Date";
            FirstPeriodLocked := AccountingPeriod."Date Locked";
            if (FiscalYearStartDate < FirstPeriodStartDate) and FirstPeriodLocked then
                if not
                   Confirm(
                     Text000 +
                     Text001)
                then
                    exit;
            if AccountingPeriod.Find('+') then
                LastPeriodStartDate := AccountingPeriod."Interest Due Date";
        end else
            if not
               Confirm(
                 Text002 +
                 Text003)
            then
                exit;
        FiscalYearStartDate2 := FiscalYearStartDate;
        for i := 1 to NoOfPeriods + 1 do begin
            if (FiscalYearStartDate <= FirstPeriodStartDate) and (i = NoOfPeriods + 1) then
                exit;
            if (FirstPeriodStartDate <> 0D) then
                if (FiscalYearStartDate >= FirstPeriodStartDate) and (FiscalYearStartDate < LastPeriodStartDate) then
                    Error(Text004);
            AccountingPeriod.Init;
            AccountingPeriod."Interest Due Date" := FiscalYearStartDate;
            //AccountingPeriod."Interest Calcuation Date":=CALCDATE('1M-1D',FiscalYearStartDate);
            AccountingPeriod."Interest Calcuation Date" := FiscalYearStartDate;
            AccountingPeriod.Validate("Interest Due Date");
            if (i = 1) or (i = NoOfPeriods + 1) then begin
                AccountingPeriod."New Fiscal Year" := true;
                InvtSetup.Get;
                AccountingPeriod."Average Cost Calc. Type" := InvtSetup."Average Cost Calc. Type";
                AccountingPeriod."Average Cost Period" := InvtSetup."Average Cost Period";
            end;
            if (FirstPeriodStartDate = 0D) and (i = 1) then
                AccountingPeriod."Date Locked" := true;
            if (AccountingPeriod."Interest Due Date" < FirstPeriodStartDate) and FirstPeriodLocked then begin
                AccountingPeriod.Closed := true;
                //AccountingPeriod."Date Locked" := TRUE;
            end;
            if not AccountingPeriod.Find('=') then
                AccountingPeriod.Insert;
            FiscalYearStartDate := CalcDate(PeriodLength, FiscalYearStartDate);
            //MESSAGE('FiscalYearStartDate %1',FiscalYearStartDate);
        end;
        AccountingPeriod.Get(FiscalYearStartDate2);
        AccountingPeriod.UpdateAvgItems(0);
        ;

    end;

    var
        AccountingPeriod: Record "Interest Due Period";
        InvtSetup: Record "Inventory Setup";
        NoOfPeriods: Integer;
        PeriodLength: DateFormula;
        FiscalYearStartDate: Date;
        FiscalYearStartDate2: Date;
        FirstPeriodStartDate: Date;
        LastPeriodStartDate: Date;
        FirstPeriodLocked: Boolean;
        i: Integer;
        Text000: label 'The new Interest period begins before an existing interest period, so the new year will be closed automatically.\\';
        Text001: label 'Do you want to create and close the interest period?';
        Text002: label 'Once you create the new interest period you cannot change its starting date.\\';
        Text003: label 'Do you want to create the interest period?';
        Text004: label 'It is only possible to create new interest period before or after the existing ones.';

    var

}
