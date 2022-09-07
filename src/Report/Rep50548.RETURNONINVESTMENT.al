Report 50548 "RETURN ON INVESTMENT."
{
    RDLCLayout = 'Layouts/RETURNONINVESTMENT..rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem(Company; "Company Information")
        {

            column(AsAt; AsAt)
            {
            }
            column(StartDate; StartDate)
            {
            }
            column(FinancialYear; FinancialYear)
            {
            }
            column(name; Company.Name)
            {
            }
            column(CoreCapital; CoreCapital)
            {
            }
            column(TotalAssets; TotalAssets)
            {
            }
            column(TotalDeposits; TotalDeposits)
            {
            }
            column(Nonearningassets; Nonearningassets)
            {
            }
            column(FinancialAssets; FinancialAssets)
            {
            }
            column(SubsidiaryandRelated; SubsidiaryandRelated)
            {
            }
            column(Equityinvestment; Equityinvestment)
            {
            }
            column(Otherinvestments; Otherinvestments)
            {
            }
            column(LandBuilding; LandBuilding)
            {
            }
            column(OtherassetsLandBuilding; OtherassetsLandBuilding)
            {
            }
            column(LandBuildingstoAssetsRatio; LandBuildingstoAssetsRatio)
            {
            }
            column(MaxLandBuildingtoAssetrequirement; MaxLandBuildingtoAssetrequirement)
            {
            }
            column(Excessdeficiency2; Excessdeficiency2)
            {
            }
            column(FinancialinvestmentstoCorecapital; FinancialinvestmentstoCorecapital)
            {
            }
            column(MaximumfinancialinvestmentstoCorecapital; MaximumfinancialinvestmentstoCorecapital)
            {
            }
            column(ExcessCoreCapital; ExcessCoreCapital)
            {
            }
            column(EquityinvestmentstoCoreCapitalRatio; EquityinvestmentstoCoreCapitalRatio)
            {
            }
            column(MaxfinancialinvestmentstoTotalDepositsliablitiesRatio; MaxfinancialinvestmentstoTotalDepositsliablitiesRatio)
            {
            }
            column(ExcessEquity; ExcessEquity)
            {
            }
            column(SubsidiaryrelatedentityinvestmenttoCoreCapitalRatio; SubsidiaryrelatedentityinvestmenttoCoreCapitalRatio)
            {
            }
            column(MaximumSubsidiaryinvestmenttoTotalassetsRatio; MaximumSubsidiaryinvestmenttoTotalassetsRatio)
            {
            }
            column(ExcessSubsidiary; ExcessSubsidiary)
            {
            }
            column(OtherinvestmentstoCoreCapitalRatio; OtherinvestmentstoCoreCapitalRatio)
            {
            }
            column(MaximumOtherinvestmentstoCoreCapital; MaximumOtherinvestmentstoCoreCapital)
            {
            }
            column(ExcessOtherInvestment; ExcessOtherInvestment)
            {
            }
            column(MaxLandBuildingtoAssetrequirementNew; MaxLandBuildingtoAssetrequirementNew)
            {
            }
            column(LandBuildingEquipmentNew; LandBuildingEquipmentNew)
            {
            }
            column(Excessdeficiency3; Excessdeficiency3)
            {
            }
            trigger OnAfterGetRecord();
            begin
                //CoreCapital
                CoreCapital := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."Form2E(investment)", '%1', GLAccount."form2e(investment)"::Core_Capital);
                //GLAccount.SETFILTER(GLAccount."Form2E(investment)",'%1',GLAccount."Form2E(investment)"::);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetFilter(GLEntry."Posting Date", DateFilter);
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            CoreCapital += GLEntry.Amount * -1;
                        end
                    until GLAccount.Next = 0;
                    // MESSAGE('%1',CoreCapital)
                end;
                //non earning assets
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."Form2E(investment)New", '%1', GLAccount."form2e(investment)new"::Nonearningassets);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetFilter(GLEntry."Posting Date", DateFilter);
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            Nonearningassets += GLEntry.Amount;
                        end
                    until GLAccount.Next = 0;
                end;
                //land
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."Form2E(investment)Land", '%1', GLAccount."form2e(investment)land"::LandBuilding);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetFilter(GLEntry."Posting Date", DateFilter);
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            LandBuilding += GLEntry.Amount;
                        end
                    until GLAccount.Next = 0;
                end;
                //total assets
                TotalAssets := 0;
                GLAccount.Reset;
                GLAccount.SetRange(GLAccount."No.", '19999');
                GLAccount.SetFilter(GLAccount."Date Filter", DateFilter);
                GLAccount.SetAutocalcFields(Balance);
                if GLAccount.FindSet then begin
                    repeat
                        TotalAssets += GLAccount.Balance
                      until GLAccount.Next = 0;
                end;
                //deposits
                TotalDeposits := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."Form2E(investment)", '%1', GLAccount."form2e(investment)"::totaldeposits);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetFilter(GLEntry."Posting Date", DateFilter);
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            TotalDeposits += GLEntry.Amount * -1;
                        end
                    until GLAccount.Next = 0;
                end;
                //subsidiaries
                SubsidiaryandRelated := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."Form2E(investment)", '%1', GLAccount."form2e(investment)"::subsidiaryandrelatedentities);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetFilter(GLEntry."Posting Date", DateFilter);
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            SubsidiaryandRelated += GLEntry.Amount;
                        end
                    until GLAccount.Next = 0;
                end;
                //equity
                Equityinvestment := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."Form2E(investment)", '%1', GLAccount."form2e(investment)"::Equityinvestment);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetFilter(GLEntry."Posting Date", DateFilter);
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            Equityinvestment += GLEntry.Amount;
                        end
                    until GLAccount.Next = 0;
                end;
                Otherinvestments := 0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."Form2E(investment)", '%1', GLAccount."form2e(investment)"::Otherinvestments);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetFilter(GLEntry."Posting Date", DateFilter);
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            Otherinvestments += GLEntry.Amount;
                        end
                    until GLAccount.Next = 0;
                end;
                //land and building
                // GLAccount.RESET;
                // GLAccount.SETFILTER(GLAccount."Form2E(investment)",'%1',GLAccount."Form2E(investment)"::totaldeposits);
                // IF GLAccount.FINDSET THEN BEGIN
                //  REPEAT
                //	GLEntry.RESET;
                //	GLEntry.SETFILTER(GLEntry."Posting Date",DateFilter);
                //	GLEntry.SETRANGE(GLEntry."G/L Account No.",GLAccount."No.");
                //	IF GLEntry.FINDSET THEN BEGIN
                //	  GLEntry.CALCSUMS(Amount);
                //	  LandBuilding+=GLEntry.Amount;
                //	  END
                //	  UNTIL GLAccount.NEXT = 0 ;
                //
                // END;
                //other asssets
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."Form2E(investment)", '%1', GLAccount."form2e(investment)"::otherassets);
                if GLAccount.FindSet then begin
                    repeat
                        GLEntry.Reset;
                        GLEntry.SetFilter(GLEntry."Posting Date", DateFilter);
                        GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
                        if GLEntry.FindSet then begin
                            GLEntry.CalcSums(Amount);
                            OtherassetsLandBuilding += GLEntry.Amount;
                        end
                    until GLAccount.Next = 0;
                end;
                //MESSAGE('%1',CoreCapital);
                FinancialAssets := Equityinvestment + SubsidiaryandRelated + Otherinvestments;
                LandBuildingEquipmentNew := OtherassetsLandBuilding / TotalAssets;
                LandBuildingstoAssetsRatio := LandBuilding / TotalAssets;
                //MESSAGE(FORMAT(LandBuildingstoAssetsRatio));
                MaxLandBuildingtoAssetrequirement := 0.1;
                MaxLandBuildingtoAssetrequirementNew := 0.05;
                Excessdeficiency2 := LandBuildingEquipmentNew - MaxLandBuildingtoAssetrequirement;
                Excessdeficiency3 := LandBuildingstoAssetsRatio - MaxLandBuildingtoAssetrequirementNew;
                FinancialinvestmentstoCorecapital := FinancialAssets / CoreCapital;
                MaximumfinancialinvestmentstoCorecapital := 0.4;
                ExcessCoreCapital := FinancialinvestmentstoCorecapital - MaximumfinancialinvestmentstoCorecapital;
                EquityinvestmentstoCoreCapitalRatio := Equityinvestment / CoreCapital;
                MaxfinancialinvestmentstoTotalDepositsliablitiesRatio := 0.2;
                ExcessEquity := EquityinvestmentstoCoreCapitalRatio - MaxfinancialinvestmentstoTotalDepositsliablitiesRatio;
                SubsidiaryrelatedentityinvestmenttoCoreCapitalRatio := SubsidiaryandRelated / CoreCapital;
                MaximumSubsidiaryinvestmenttoTotalassetsRatio := 0.5;
                ExcessSubsidiary := SubsidiaryrelatedentityinvestmenttoCoreCapitalRatio - MaximumSubsidiaryinvestmenttoTotalassetsRatio;
                OtherinvestmentstoCoreCapitalRatio := Otherinvestments / CoreCapital;
                MaximumOtherinvestmentstoCoreCapital := 0.3;
                ExcessOtherInvestment := OtherinvestmentstoCoreCapitalRatio - MaximumOtherinvestmentstoCoreCapital;
                //MESSAGE('%1|%2|%3',Equityinvestment,CoreCapital,EquityinvestmentstoCoreCapitalRatio);
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
        StartDate := CalcDate('-CY', AsAt);
        FinancialYear := Date2dmy(StartDate, 3);
        DateFilter := '..' + Format(AsAt);
        ;

    end;

    var
        AsAt: Date;
        StartDate: Date;
        FinancialYear: Integer;
        CoreCapital: Decimal;
        GLAccount: Record "G/L Account";
        GLEntry: Record "G/L Entry";
        DateFilter: Text;
        TotalAssets: Decimal;
        TotalDeposits: Decimal;
        Nonearningassets: Decimal;
        FinancialAssets: Decimal;
        SubsidiaryandRelated: Decimal;
        Equityinvestment: Decimal;
        Otherinvestments: Decimal;
        LandBuilding: Decimal;
        OtherassetsLandBuilding: Decimal;
        FinancialAssets1: Decimal;
        LandBuildingstoAssetsRatio: Decimal;
        MaxLandBuildingtoAssetrequirement: Decimal;
        Excessdeficiency2: Decimal;
        FinancialinvestmentstoCorecapital: Decimal;
        MaximumfinancialinvestmentstoCorecapital: Decimal;
        ExcessCoreCapital: Decimal;
        EquityinvestmentstoCoreCapitalRatio: Decimal;
        MaxfinancialinvestmentstoTotalDepositsliablitiesRatio: Decimal;
        ExcessEquity: Decimal;
        SubsidiaryrelatedentityinvestmenttoCoreCapitalRatio: Decimal;
        MaximumSubsidiaryinvestmenttoTotalassetsRatio: Decimal;
        ExcessSubsidiary: Decimal;
        OtherinvestmentstoCoreCapitalRatio: Decimal;
        MaximumOtherinvestmentstoCoreCapital: Decimal;
        ExcessOtherInvestment: Decimal;
        MaxLandBuildingtoAssetrequirementNew: Decimal;
        LandBuildingEquipmentNew: Decimal;
        Excessdeficiency3: Decimal;

    var

}