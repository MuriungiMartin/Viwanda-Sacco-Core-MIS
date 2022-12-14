#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
//51516058_v6_3_0_2259) { }
// Autogenerated code - do not delete or modify -->

Report 50058 "Portfolio Summary"
{
    RDLCLayout = 'Layouts/PortfolioSummary.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Loan Products Setup"; "Loan Products Setup")
        {
            column(ReportForNavId_4645; 4645) { } // Autogenerated by ForNav - Do not delete
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(Company_Name; Company.Name)
            {
            }
            column(Company_Address; Company.Address)
            {
            }
            column(Company_Address_2; Company."Address 2")
            {
            }
            column(Company_Phone_No; Company."Phone No.")
            {
            }
            column(Company_Fax_No; Company."Fax No.")
            {
            }
            column(Company_Picture; Company.Picture)
            {
            }
            column(Company_Email; Company."E-Mail")
            {
            }

            column(UserId; UserId)
            {
            }
            column(VarEntryNo; VarEntryNo)
            {
            }
            column(Code_LoanProductsSetup; "Loan Products Setup".Code)
            {
            }
            column(ProductDescription_LoanProductsSetup; "Loan Products Setup"."Product Description")
            {
            }
            column(VarReportDate; Format(VarReportDate, 0, '<Day,2> <Month Text,3> <Year4>'))
            {
            }
            column(VarPerformingCount; VarPerformingCount)
            {
            }
            column(VarPerformingBalance; VarPerformingBalance)
            {
            }
            column(VarPerformingArrears; VarPerformingArrears)
            {
            }
            column(PerformingPercPerCount; PerformingPercPerCount)
            {
            }
            column(PerformingPercPerVolume; PerformingPercPerVolume)
            {
            }
            column(PerformingPercPerArrears; PerformingPercPerArrears)
            {
            }
            column(VarWatchCount; VarWatchCount)
            {
            }
            column(VarWatchBalance; VarWatchBalance)
            {
            }
            column(VarWatchArrears; VarWatchArrears)
            {
            }
            column(WatchPercPerCount; WatchPercPerCount)
            {
            }
            column(WatchPercPerVolume; WatchPercPerVolume)
            {
            }
            column(WatchPercPerArrears; WatchPercPerArrears)
            {
            }
            column(VarSubstandardCount; VarSubstandardCount)
            {
            }
            column(VarSubstandardBalance; VarSubstandardBalance)
            {
            }
            column(VarSubstandardArrears; VarSubstandardArrears)
            {
            }
            column(SubstandardPercPerCount; SubstandardPercPerCount)
            {
            }
            column(SubstandardPercPerVolume; SubstandardPercPerVolume)
            {
            }
            column(SubstandardPercPerArrears; SubstandardPercPerArrears)
            {
            }
            column(VarDoubtfulCount; VarDoubtfulCount)
            {
            }
            column(VarDoubtfulBalance; VarDoubtfulBalance)
            {
            }
            column(VarDoubtfulArrears; VarDoubtfulArrears)
            {
            }
            column(DoubtfulPercPerCount; DoubtfulPercPerCount)
            {
            }
            column(DoubtfulPercPerVolume; DoubtfulPercPerVolume)
            {
            }
            column(DoubtfulPercPerArrears; DoubtfulPercPerArrears)
            {
            }
            column(VarLossCount; VarLossCount)
            {
            }
            column(VarLossBalance; VarLossBalance)
            {
            }
            column(VarLossArrears; VarLossArrears)
            {
            }
            column(LossPercPerCount; LossPercPerCount)
            {
            }
            column(LossPercPerVolume; LossPercPerVolume)
            {
            }
            column(LossPercPerArrears; LossPercPerArrears)
            {
            }
            column(GTotalCount; GTotalCount)
            {
            }
            column(GTotalBalance; GTotalBalance)
            {
            }
            column(GTotalArrears; GTotalArrears)
            {
            }
            column(GTotalPercentageCount; GTotalPercentageCount)
            {
            }
            column(GTotalPercentageVolume; GTotalPercentageVolume)
            {
            }
            column(GTotalPercentageArrears; GTotalPercentageArrears)
            {
            }
            trigger OnPreDataItem();
            begin
                Company.Get();
                Company.CalcFields(Company.Picture);
            end;

            trigger OnAfterGetRecord();
            begin
                VarEntryNo := VarEntryNo + 1;
                //====================================================Performing
                ObjLoans.Reset;
                ObjLoans.SetRange(ObjLoans.Classification, ObjLoans.Classification::Perfoming);
                ObjLoans.SetFilter(ObjLoans."Report Date", '%1', VarReportDate);
                ObjLoans.SetFilter(ObjLoans."Outstanding Balance", '>%1', 0);
                if ObjLoans.FindSet then begin
                    ObjLoans.CalcSums(ObjLoans."Outstanding Balance", ObjLoans."Arrears Amount");
                    VarPerformingBalance := ObjLoans."Outstanding Balance";
                    VarPerformingArrears := ObjLoans."Arrears Amount";
                    VarPerformingCount := ObjLoans.Count;
                end;
                //====================================================Watch
                ObjLoans.Reset;
                ObjLoans.SetRange(ObjLoans.Classification, ObjLoans.Classification::Watch);
                ObjLoans.SetFilter(ObjLoans."Report Date", '%1', VarReportDate);
                ObjLoans.SetFilter(ObjLoans."Outstanding Balance", '>%1', 0);
                if ObjLoans.FindSet then begin
                    ObjLoans.CalcSums(ObjLoans."Outstanding Balance", ObjLoans."Arrears Amount");
                    VarWatchBalance := ObjLoans."Outstanding Balance";
                    VarWatchArrears := ObjLoans."Arrears Amount";
                    VarWatchCount := ObjLoans.Count;
                end;
                //====================================================Substandard
                ObjLoans.Reset;
                ObjLoans.SetRange(ObjLoans.Classification, ObjLoans.Classification::Substandard);
                ObjLoans.SetFilter(ObjLoans."Report Date", '%1', VarReportDate);
                ObjLoans.SetFilter(ObjLoans."Outstanding Balance", '>%1', 0);
                if ObjLoans.FindSet then begin
                    ObjLoans.CalcSums(ObjLoans."Outstanding Balance", ObjLoans."Arrears Amount");
                    VarSubstandardBalance := ObjLoans."Outstanding Balance";
                    VarSubstandardArrears := ObjLoans."Arrears Amount";
                    VarSubstandardCount := ObjLoans.Count;
                end;
                //====================================================Doubtful
                ObjLoans.Reset;
                ObjLoans.SetRange(ObjLoans.Classification, ObjLoans.Classification::Doubtful);
                ObjLoans.SetFilter(ObjLoans."Report Date", '%1', VarReportDate);
                ObjLoans.SetFilter(ObjLoans."Outstanding Balance", '>%1', 0);
                if ObjLoans.FindSet then begin
                    ObjLoans.CalcSums(ObjLoans."Outstanding Balance", ObjLoans."Arrears Amount");
                    VarDoubtfulBalance := ObjLoans."Outstanding Balance";
                    VarDoubtfulArrears := ObjLoans."Arrears Amount";
                    VarDoubtfulCount := ObjLoans.Count;
                end;
                //====================================================Loss
                ObjLoans.Reset;
                ObjLoans.SetRange(ObjLoans.Classification, ObjLoans.Classification::Loss);
                ObjLoans.SetFilter(ObjLoans."Report Date", '%1', VarReportDate);
                ObjLoans.SetFilter(ObjLoans."Outstanding Balance", '>%1', 0);
                if ObjLoans.FindSet then begin
                    ObjLoans.CalcSums(ObjLoans."Outstanding Balance", ObjLoans."Arrears Amount");
                    VarLossBalance := ObjLoans."Outstanding Balance";
                    VarLossArrears := ObjLoans."Arrears Amount";
                    VarLossCount := ObjLoans.Count;
                end;
                //====================================================Percentages
                ObjLoans.Reset;
                ObjLoans.SetFilter(ObjLoans."Report Date", '%1', VarReportDate);
                ObjLoans.SetFilter(ObjLoans."Outstanding Balance", '>%1', 0);
                if ObjLoans.FindSet then begin
                    ObjLoans.CalcSums(ObjLoans."Outstanding Balance", ObjLoans."Arrears Amount");
                    VarTotalLoanBalance := ObjLoans."Outstanding Balance";
                    VarTotalArrearsBalance := ObjLoans."Arrears Amount";
                    VarTotalLoansCount := ObjLoans.Count;
                end;
                //=============================================================================By Count
                PerformingPercPerCount := ROUND((VarPerformingCount / VarTotalLoansCount) * 100, 1, '=');
                WatchPercPerCount := ROUND((VarWatchCount / VarTotalLoansCount) * 100, 1, '=');
                SubstandardPercPerCount := ROUND((VarSubstandardCount / VarTotalLoansCount) * 100, 1, '=');
                DoubtfulPercPerCount := ROUND((VarDoubtfulCount / VarTotalLoansCount) * 100, 1, '=');
                LossPercPerCount := ROUND((VarLossCount / VarTotalLoansCount) * 100, 1, '=');
                //=============================================================================By Volume
                PerformingPercPerVolume := ROUND((VarPerformingBalance / VarTotalLoanBalance) * 100, 1, '=');
                WatchPercPerVolume := ROUND((VarWatchBalance / VarTotalLoanBalance) * 100, 1, '=');
                SubstandardPercPerVolume := ROUND((VarSubstandardBalance / VarTotalLoanBalance) * 100, 1, '=');
                DoubtfulPercPerVolume := ROUND((VarDoubtfulBalance / VarTotalLoanBalance) * 100, 1, '=');
                LossPercPerVolume := ROUND((VarLossBalance / VarTotalLoanBalance) * 100, 1, '=');
                //=============================================================================By Arrears
                PerformingPercPerArrears := ROUND((PerformingPercPerArrears / VarTotalArrearsBalance) * 100, 1, '=');
                WatchPercPerArrears := ROUND((VarWatchArrears / VarTotalArrearsBalance) * 100, 1, '=');
                SubstandardPercPerArrears := ROUND((VarSubstandardArrears / VarTotalArrearsBalance) * 100, 1, '=');
                DoubtfulPercPerArrears := ROUND((VarDoubtfulArrears / VarTotalArrearsBalance) * 100, 1, '=');
                LossPercPerArrears := ROUND((VarLossArrears / VarTotalArrearsBalance) * 100, 1, '=');
                GTotalCount := VarPerformingCount + VarWatchCount + VarSubstandardCount + VarDoubtfulCount + VarLossCount;
                GTotalBalance := VarPerformingBalance + VarWatchBalance + VarSubstandardBalance + VarDoubtfulBalance + VarLossBalance;
                GTotalArrears := VarPerformingArrears + VarWatchArrears + VarSubstandardArrears + VarDoubtfulArrears + VarLossArrears;
                GTotalPercentageCount := PerformingPercPerCount + WatchPercPerCount + SubstandardPercPerCount + DoubtfulPercPerCount + LossPercPerCount;
                GTotalPercentageVolume := PerformingPercPerVolume + WatchPercPerVolume + SubstandardPercPerVolume + DoubtfulPercPerVolume + LossPercPerVolume;
                GTotalPercentageArrears := PerformingPercPerArrears + WatchPercPerArrears + SubstandardPercPerArrears + DoubtfulPercPerArrears + LossPercPerArrears;
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
                field(VarReportDate; VarReportDate)
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
        ;

    end;

    var
        AsAt: Date;
        Company: Record "Company Information";
        SFactory: Codeunit "SURESTEP Factory";
        ObjGensetup: Record "Sacco General Set-Up";
        CurrReport_PAGENOCaptionLbl: label 'Page';
        RISK_CLASSIFICATION_OF_ASSETS_AND_PROVISIONINGCaptionLbl: label 'RISK CLASSIFICATION OF ASSETS AND PROVISIONING';
        FORM_4CaptionLbl: label 'FORM 4';
        SASRA_2_004CaptionLbl: label 'SASRA 2/004';
        R__46_CaptionLbl: label 'R.(46)';
        ObjMembers: Record Customer;
        VarEntryNo: Integer;
        ObjDetailedVendLedger: Record "Detailed Vendor Ledg. Entry";
        VarReportDate: Date;
        VarLoansDateFilter: Text;
        VarAccountTypeBalance: Decimal;
        ObjLoans: Record "Loan Portfolio Provision";
        VarPerformingCount: Integer;
        VarPerformingBalance: Decimal;
        VarPerformingArrears: Decimal;
        PerformingPercPerCount: Decimal;
        PerformingPercPerVolume: Decimal;
        PerformingPercPerArrears: Decimal;
        VarWatchCount: Integer;
        VarWatchBalance: Decimal;
        VarWatchArrears: Decimal;
        WatchPercPerCount: Decimal;
        WatchPercPerVolume: Decimal;
        WatchPercPerArrears: Decimal;
        VarSubstandardCount: Integer;
        VarSubstandardBalance: Decimal;
        VarSubstandardArrears: Decimal;
        SubstandardPercPerCount: Decimal;
        SubstandardPercPerVolume: Decimal;
        SubstandardPercPerArrears: Decimal;
        VarDoubtfulCount: Integer;
        VarDoubtfulBalance: Decimal;
        VarDoubtfulArrears: Decimal;
        DoubtfulPercPerCount: Decimal;
        DoubtfulPercPerVolume: Decimal;
        DoubtfulPercPerArrears: Decimal;
        VarLossCount: Integer;
        VarLossBalance: Decimal;
        VarLossArrears: Decimal;
        LossPercPerCount: Decimal;
        LossPercPerVolume: Decimal;
        LossPercPerArrears: Decimal;
        VarTotalLoanBalance: Decimal;
        VarTotalLoansCount: Integer;
        VarTotalArrearsBalance: Decimal;
        GTotalCount: Integer;
        GTotalBalance: Decimal;
        GTotalArrears: Decimal;
        GTotalPercentageCount: Decimal;
        GTotalPercentageVolume: Decimal;
        GTotalPercentageArrears: Decimal;

    // --> Reports ForNAV Autogenerated code - do not delete or modify
    //51516058_v6_3_0_2259;






    // Reports ForNAV Autogenerated code - do not delete or modify -->
}
