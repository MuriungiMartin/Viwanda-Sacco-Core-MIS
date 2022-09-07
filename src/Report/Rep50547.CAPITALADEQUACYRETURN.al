
Report 50547 "CAPITAL ADEQUACY RETURN"
{
    RDLCLayout = 'Layouts/CAPITALADEQUACYRETURN.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem(Company; "Company Information")
        {

            column(Name; Company.Name)
            {
            }
            column(FinancialYear; FinancialYear)
            {
            }
            column(AsAt; AsAt)
            {
            }
            column(StartDate; StartDate)
            {
            }
            column(ShareCapital; ShareCapital)
            {
            }
            column(StatutoryReserve; StatutoryReserve)
            {
            }
            column(Otherreserves; Otherreserves)
            {
            }
            column(retainedEarnins; retainedEarnins)
            {
            }
            column(NetSurplusaftertax; NetSurplusaftertax)
            {
            }
            column(LoansandAdvances; LoansandAdvances)
            {
            }
            column(totalassetsPBSheet; totalassetsPBSheet)
            {
            }
            column(Cash; Cash)
            {
            }
            column(PropertyandEquipment; PropertyandEquipment)
            {
            }
            column(GovernmentSecurities; GovernmentSecurities)
            {
            }
            column(DepositsandBalancesatOtherInstitutions; DepositsandBalancesatOtherInstitutions)
            {
            }
            column(Otherassets; Otherassets)
            {
            }
            column(CapitalGrants; CapitalGrants)
            {
            }
            column(InvestmentsinSubsidiary; InvestmentsinSubsidiary)
            {
            }
            column(OFFBALANCESHEETASSETS; OFFBALANCESHEETASSETS)
            {
            }
            column(TOTALOnBalanceSheet; TOTALOnBalanceSheet)
            {
            }
            column(OtherDeductions; OtherDeductions)
            {
            }
            column(Sub_Total; Sub_Total)
            {
            }
            column(TotalDeductions; TotalDeductions)
            {
            }
            column(CORECAPITAL; CORECAPITAL)
            {
            }
            column(RetainedearningsandDisclosedreserves; RetainedearningsandDisclosedreserves)
            {
            }
            column(TotalAssets; TotalAssets)
            {
            }
            column(TotalDepositsLiabilities; TotalDepositsLiabilities)
            {
            }
            column(CorecapitaltoAssetsRatio; CorecapitaltoAssetsRatio)
            {
            }
            column(MinimumCoreCapitaltoAssetsRatioRequirement; MinimumCoreCapitaltoAssetsRatioRequirement)
            {
            }
            column(Excess1; Excess1)
            {
            }
            column(RetainedearningsanddisclosedreservestoCorecapital; RetainedearningsanddisclosedreservestoCorecapital)
            {
            }
            column(MinimumRetainedearningsanddisclosed; MinimumRetainedearningsanddisclosed)
            {
            }
            column(Excess2; Excess2)
            {
            }
            column(CorecapitatoDepositsRatio; CorecapitatoDepositsRatio)
            {
            }
            column(MinimumCoreCapitaltoDeposits; MinimumCoreCapitaltoDeposits)
            {
            }
            column(Excess; Excess)
            {
            }
            trigger OnAfterGetRecord();
            begin
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."Capital adequecy", '%1', GLAccount."capital adequecy"::ShareCapital);
                if GLAccount.FindSet then begin
                    repeat
                        ShareCapitalValue := 0;
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', AsAt);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            ShareCapitalValue := GLEntry.Amount * -1;
                        end;
                        ShareCapital := ShareCapital + ShareCapitalValue;
                    until GLAccount.Next = 0;
                end;
                //statutory reserve
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."Capital adequecy", '%1', GLAccount."capital adequecy"::StatutoryReserve);
                if GLAccount.FindSet then begin
                    repeat
                        ShareCapitalValue := 0;
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', AsAt);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            StatutoryReserve += GLEntry.Amount * -1;
                        end;
                    until GLAccount.Next = 0;
                end;
                //retained earnings
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."Capital adequecy", '%1', GLAccount."capital adequecy"::RetainedEarnings);
                if GLAccount.FindSet then begin
                    repeat
                        ShareCapitalValue := 0;
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', AsAt);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            retainedEarnins += GLEntry.Amount * -1;
                        end;
                    until GLAccount.Next = 0;
                end;
                /*
				//curent year surplus
				// GLAccount.RESET;
				// GLAccount.SETFILTER(GLAccount."Capital adequecy",'%1',GLAccount."Capital adequecy"::NetSurplusaftertax);
				// IF GLAccount.FINDSET THEN BEGIN
				//  REPEAT
				//	ShareCapitalValue:=0;
				//	GLEntry.RESET;
				//	GLEntry.SETRANGE(GLEntry."G/L Account No.",GLAccount."No.");
				//	GLEntry.SETFILTER(GLEntry."Posting Date",CurrentYearFilter);
				//	IF GLEntry.FINDSET THEN BEGIN
				//	  GLEntry.CALCSUMS(Amount);
				//	  NetSurplusaftertax+=GLEntry.Amount*-1;
				//	  END;
				//
				//   UNTIL GLAccount.NEXT = 0;
				//
				// END;
				*/
                GLAccount.Reset;
                GLAccount.SetRange(GLAccount."No.", '59999');
                GLAccount.SetFilter(GLAccount."Date Filter", Datefilter);
                GLAccount.SetAutocalcFields(Balance);
                if GLAccount.FindSet then begin
                    repeat
                        NetSurplusaftertax += (GLAccount.Balance * 50 / 100) * -1;
                    until GLAccount.Next = 0;
                end;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."Capital adequecy", '%1', GLAccount."capital adequecy"::LoansandAdvances);
                if GLAccount.FindSet then begin
                    repeat
                        ShareCapitalValue := 0;
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", Datefilter);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            LoansandAdvances += GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;
                end;
                //total assets as per the balance sheet
                GLAccount.Reset;
                GLAccount.SetRange(GLAccount."No.", '19999');
                GLAccount.SetFilter(GLAccount."Date Filter", Datefilter);
                GLAccount.SetAutocalcFields(Balance);
                if GLAccount.FindSet then begin
                    repeat
                        totalassetsPBSheet += GLAccount.Balance;
                    until GLAccount.Next = 0;
                end;
                //Cash (Local + Foreign Currency)
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."Capital adequecy", '%1', GLAccount."capital adequecy"::Cash);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", Datefilter);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            Cash += GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;
                end;
                //INVESTMENT IN SUBSIDIARY
                InvestmentsinSubsidiary := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."Capital adequecy", '%1', GLAccount."capital adequecy"::InvestmentsinSubsidiary);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', AsAt);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            InvestmentsinSubsidiary += GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;
                end;
                //Other reserves
                Otherreserves := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."Capital adequecy", '%1', GLAccount."capital adequecy"::Otherreserves);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', AsAt);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            Otherreserves += GLEntry.Amount * -1;
                        end;
                    until GLAccount.Next = 0;
                end;
                //gov securities
                GovernmentSecurities := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."Capital adequecy", '%1', GLAccount."capital adequecy"::GovernmentSecurities);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', AsAt);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            GovernmentSecurities += GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;
                end;
                //balances at other institutions
                DepositsandBalancesatOtherInstitutions := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."Capital adequecy", '%1', GLAccount."capital adequecy"::DepositsandBalancesatOtherInstitutions);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', AsAt);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            DepositsandBalancesatOtherInstitutions += GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;
                end;
                //other assets
                Otherassets := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."Capital adequecy", '%1', GLAccount."capital adequecy"::Otherassets);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', AsAt);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            Otherassets += GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;
                end;
                //property and equipment
                PropertyandEquipment := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."Capital adequecy", '%1', GLAccount."capital adequecy"::PropertyandEquipment);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', AsAt);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            PropertyandEquipment += GLEntry.Amount;
                        end;
                    until GLAccount.Next = 0;
                end;
                //deposit & liabilities
                TotalDepositsLiabilities := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."Capital adequecy", '%1', GLAccount."capital adequecy"::TotalDepositsLiabilities);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        GLEntry.SetFilter(GLEntry."Posting Date", '<=%1', AsAt);
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            TotalDepositsLiabilities += GLEntry.Amount * -1;
                        end;
                    until GLAccount.Next = 0;
                end;
                TOTALOnBalanceSheet := Cash + GovernmentSecurities + DepositsandBalancesatOtherInstitutions + LoansandAdvances + InvestmentsinSubsidiary + Otherassets + PropertyandEquipment;
                Sub_Total := ShareCapital + CapitalGrants + retainedEarnins + NetSurplusaftertax + StatutoryReserve + Otherreserves;
                TotalDeductions := InvestmentsinSubsidiary + OtherDeductions;
                CORECAPITAL := Sub_Total - TotalDeductions;
                RetainedearningsandDisclosedreserves := retainedEarnins;
                TotalAssets := totalassetsPBSheet + OFFBALANCESHEETASSETS;
                CorecapitaltoAssetsRatio := CORECAPITAL / TotalAssets;
                MinimumCoreCapitaltoAssetsRatioRequirement := 0.08;
                Excess1 := CorecapitaltoAssetsRatio - MinimumCoreCapitaltoAssetsRatioRequirement;
                RetainedearningsanddisclosedreservestoCorecapital := RetainedearningsandDisclosedreserves / CORECAPITAL;
                MinimumRetainedearningsanddisclosed := 0.5;
                Excess2 := RetainedearningsanddisclosedreservestoCorecapital - MinimumRetainedearningsanddisclosed;
                CorecapitatoDepositsRatio := CORECAPITAL / TotalDepositsLiabilities;
                MinimumCoreCapitaltoDeposits := 0.05;
                Excess := CorecapitatoDepositsRatio - MinimumCoreCapitaltoDeposits;

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
                    Caption = 'As At';
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
        FinancialYear := Date2dmy(AsAt, 3);
        StartDate := CalcDate('-CY', AsAt);
        Datefilter := '..' + Format(AsAt);
        CurrentYearFilter := Format(StartDate) + '..' + Format(AsAt);
        ;

    end;

    var
        FinancialYear: Integer;
        AsAt: Date;
        Datefilter: Text;
        StartDate: Date;
        ShareCapital: Decimal;
        GLEntry: Record "G/L Entry";
        GLAccount: Record "G/L Account";
        ShareCapitalValue: Decimal;
        StatutoryReserve: Decimal;
        Otherreserves: Decimal;
        retainedEarnins: Decimal;
        NetSurplusaftertax: Decimal;
        CurrentYearFilter: Text;
        LoansandAdvances: Decimal;
        LoansRegister: Record "Loans Register";
        totalassetsPBSheet: Decimal;
        Cash: Decimal;
        PropertyandEquipment: Decimal;
        GovernmentSecurities: Decimal;
        DepositsandBalancesatOtherInstitutions: Decimal;
        Otherassets: Decimal;
        CapitalGrants: Decimal;
        InvestmentsinSubsidiary: Decimal;
        OFFBALANCESHEETASSETS: Decimal;
        TOTALOnBalanceSheet: Decimal;
        OtherDeductions: Decimal;
        Sub_Total: Decimal;
        TotalDeductions: Decimal;
        CORECAPITAL: Decimal;
        RetainedearningsandDisclosedreserves: Decimal;
        TotalAssets: Decimal;
        TotalDepositsLiabilities: Decimal;
        CorecapitaltoAssetsRatio: Decimal;
        MinimumCoreCapitaltoAssetsRatioRequirement: Decimal;
        Excess1: Decimal;
        RetainedearningsanddisclosedreservestoCorecapital: Decimal;
        MinimumRetainedearningsanddisclosed: Decimal;
        Excess2: Decimal;
        CorecapitatoDepositsRatio: Decimal;
        MinimumCoreCapitaltoDeposits: Decimal;
        Excess: Decimal;

    var
}

