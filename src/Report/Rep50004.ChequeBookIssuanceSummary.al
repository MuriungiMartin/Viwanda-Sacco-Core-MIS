#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
//51516004_v6_3_0_2259) { }
// Autogenerated code - do not delete or modify -->

Report 50004 "Cheque Book Issuance Summary"
{
    RDLCLayout = 'Layouts/ChequeBookIssuanceSummary.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Cheque Book Application"; "Cheque Book Application")
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
            column(VarMonth1MonthYear; VarMonth1MonthYear)
            {
            }
            column(VarMonth2MonthYear; VarMonth2MonthYear)
            {
            }
            column(VarMonth3MonthYear; VarMonth3MonthYear)
            {
            }
            column(VarNairobiMonth1Count; VarNairobiMonth1Count)
            {
            }
            column(VarNairobiMonth2Count; VarNairobiMonth2Count)
            {
            }
            column(VarNairobiMonth3Count; VarNairobiMonth3Count)
            {
            }
            column(VarNaivashaMonth1Count; VarNaivashaMonth1Count)
            {
            }
            column(VarNaivashaMonth2Count; VarNaivashaMonth2Count)
            {
            }
            column(VarNaivashaMonth3Count; VarNaivashaMonth3Count)
            {
            }
            column(VarNakuruMonth1Count; VarNakuruMonth1Count)
            {
            }
            column(VarNakuruMonth2Count; VarNakuruMonth2Count)
            {
            }
            column(VarNakuruMonth3Count; VarNakuruMonth3Count)
            {
            }
            column(VarEldoretMonth1Count; VarEldoretMonth1Count)
            {
            }
            column(VarEldoretMonth2Count; VarEldoretMonth2Count)
            {
            }
            column(VarEldoretMonth3Count; VarEldoretMonth3Count)
            {
            }
            column(VarMombasaMonth1Count; VarMombasaMonth1Count)
            {
            }
            column(VarMombasaMonth2Count; VarMombasaMonth2Count)
            {
            }
            column(VarMombasaMonth3Count; VarMombasaMonth3Count)
            {
            }
            trigger OnPreDataItem();
            begin
                Company.Get();
                Company.CalcFields(Company.Picture);
            end;

            trigger OnAfterGetRecord();
            begin
                VarMonth1DateFilter := Format(VarReportStartDate) + '..' + Format(CalcDate('1M', VarReportStartDate));
                VarMonth2DateFilter := Format(CalcDate('1M', VarReportStartDate)) + '..' + Format(CalcDate('2M', VarReportStartDate));
                VarMonth3DateFilter := Format(CalcDate('2M', VarReportStartDate)) + '..' + Format(CalcDate('3M', VarReportStartDate));
                VarMonth1MonthYear := Format(VarReportStartDate, 0, '<Month Text,3> <Year4>');
                VarMonth2MonthYear := Format(CalcDate('1M', VarReportStartDate), 0, '<Month Text,3> <Year4>');
                VarMonth3MonthYear := Format(CalcDate('2M', VarReportStartDate), 0, '<Month Text,3> <Year4>');
                //====================================================================================================================NAIROBI
                //===============================================Month 1
                ObjChequeBookApplications.Reset;
                ObjChequeBookApplications.SetFilter(ObjChequeBookApplications."Branch Code", '%1', 'NAIROBI');
                ObjChequeBookApplications.SetFilter(ObjChequeBookApplications."Date Issued", VarMonth1DateFilter);
                if ObjChequeBookApplications.FindSet then begin
                    VarNairobiMonth1Count := ObjChequeBookApplications.Count;
                end;
                //===============================================Month 2
                ObjChequeBookApplications.Reset;
                ObjChequeBookApplications.SetFilter(ObjChequeBookApplications."Branch Code", '%1', 'NAIROBI');
                ObjChequeBookApplications.SetFilter(ObjChequeBookApplications."Date Issued", VarMonth2DateFilter);
                if ObjChequeBookApplications.FindSet then begin
                    VarNairobiMonth2Count := ObjChequeBookApplications.Count;
                end;
                //===============================================Month 3
                ObjChequeBookApplications.Reset;
                ObjChequeBookApplications.SetFilter(ObjChequeBookApplications."Branch Code", '%1', 'NAIROBI');
                ObjChequeBookApplications.SetFilter(ObjChequeBookApplications."Date Issued", VarMonth3DateFilter);
                if ObjChequeBookApplications.FindSet then begin
                    VarNairobiMonth3Count := ObjChequeBookApplications.Count;
                end;
                //====================================================================================================================NAIVASHA
                //===============================================Month 1
                ObjChequeBookApplications.Reset;
                ObjChequeBookApplications.SetFilter(ObjChequeBookApplications."Branch Code", '%1', 'NAIVASHA');
                ObjChequeBookApplications.SetFilter(ObjChequeBookApplications."Date Issued", VarMonth1DateFilter);
                if ObjChequeBookApplications.FindSet then begin
                    VarNaivashaMonth1Count := ObjChequeBookApplications.Count;
                end;
                //===============================================Month 2
                ObjChequeBookApplications.Reset;
                ObjChequeBookApplications.SetFilter(ObjChequeBookApplications."Branch Code", '%1', 'NAIVASHA');
                ObjChequeBookApplications.SetFilter(ObjChequeBookApplications."Date Issued", VarMonth2DateFilter);
                if ObjChequeBookApplications.FindSet then begin
                    VarNaivashaMonth2Count := ObjChequeBookApplications.Count;
                end;
                //===============================================Month 3
                ObjChequeBookApplications.Reset;
                ObjChequeBookApplications.SetFilter(ObjChequeBookApplications."Branch Code", '%1', 'NAIVASHA');
                ObjChequeBookApplications.SetFilter(ObjChequeBookApplications."Date Issued", VarMonth3DateFilter);
                if ObjChequeBookApplications.FindSet then begin
                    VarNaivashaMonth3Count := ObjChequeBookApplications.Count;
                end;
                //====================================================================================================================NAKURU
                //===============================================Month 1
                ObjChequeBookApplications.Reset;
                ObjChequeBookApplications.SetFilter(ObjChequeBookApplications."Branch Code", '%1', 'NAKURU');
                ObjChequeBookApplications.SetFilter(ObjChequeBookApplications."Date Issued", VarMonth1DateFilter);
                if ObjChequeBookApplications.FindSet then begin
                    VarNakuruMonth1Count := ObjChequeBookApplications.Count;
                end;
                //===============================================Month 2
                ObjChequeBookApplications.Reset;
                ObjChequeBookApplications.SetFilter(ObjChequeBookApplications."Branch Code", '%1', 'NAKURU');
                ObjChequeBookApplications.SetFilter(ObjChequeBookApplications."Date Issued", VarMonth2DateFilter);
                if ObjChequeBookApplications.FindSet then begin
                    VarNakuruMonth2Count := ObjChequeBookApplications.Count;
                end;
                //===============================================Month 3
                ObjChequeBookApplications.Reset;
                ObjChequeBookApplications.SetFilter(ObjChequeBookApplications."Branch Code", '%1', 'NAKURU');
                ObjChequeBookApplications.SetFilter(ObjChequeBookApplications."Date Issued", VarMonth3DateFilter);
                if ObjChequeBookApplications.FindSet then begin
                    VarNakuruMonth3Count := ObjChequeBookApplications.Count;
                end;
                //====================================================================================================================ELDORET
                //===============================================Month 1
                ObjChequeBookApplications.Reset;
                ObjChequeBookApplications.SetFilter(ObjChequeBookApplications."Branch Code", '%1', 'ELDORET');
                ObjChequeBookApplications.SetFilter(ObjChequeBookApplications."Date Issued", VarMonth1DateFilter);
                if ObjChequeBookApplications.FindSet then begin
                    VarEldoretMonth1Count := ObjChequeBookApplications.Count;
                end;
                //===============================================Month 2
                ObjChequeBookApplications.Reset;
                ObjChequeBookApplications.SetFilter(ObjChequeBookApplications."Branch Code", '%1', 'ELDORET');
                ObjChequeBookApplications.SetFilter(ObjChequeBookApplications."Date Issued", VarMonth2DateFilter);
                if ObjChequeBookApplications.FindSet then begin
                    VarEldoretMonth2Count := ObjChequeBookApplications.Count;
                end;
                //===============================================Month 3
                ObjChequeBookApplications.Reset;
                ObjChequeBookApplications.SetFilter(ObjChequeBookApplications."Branch Code", '%1', 'ELDORET');
                ObjChequeBookApplications.SetFilter(ObjChequeBookApplications."Date Issued", VarMonth3DateFilter);
                if ObjChequeBookApplications.FindSet then begin
                    VarEldoretMonth3Count := ObjChequeBookApplications.Count;
                end;
                //====================================================================================================================MOMBASA
                //===============================================Month 1
                ObjChequeBookApplications.Reset;
                ObjChequeBookApplications.SetFilter(ObjChequeBookApplications."Branch Code", '%1', 'MOMBASA');
                ObjChequeBookApplications.SetFilter(ObjChequeBookApplications."Date Issued", VarMonth1DateFilter);
                if ObjChequeBookApplications.FindSet then begin
                    VarMombasaMonth1Count := ObjChequeBookApplications.Count;
                end;
                //===============================================Month 2
                ObjChequeBookApplications.Reset;
                ObjChequeBookApplications.SetFilter(ObjChequeBookApplications."Branch Code", '%1', 'MOMBASA');
                ObjChequeBookApplications.SetFilter(ObjChequeBookApplications."Date Issued", VarMonth2DateFilter);
                if ObjChequeBookApplications.FindSet then begin
                    VarMombasaMonth2Count := ObjChequeBookApplications.Count;
                end;
                //===============================================Month 3
                ObjChequeBookApplications.Reset;
                ObjChequeBookApplications.SetFilter(ObjChequeBookApplications."Branch Code", '%1', 'MOMBASA');
                ObjChequeBookApplications.SetFilter(ObjChequeBookApplications."Date Issued", VarMonth3DateFilter);
                if ObjChequeBookApplications.FindSet then begin
                    VarMombasaMonth3Count := ObjChequeBookApplications.Count;
                end;
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
                field(VarReportStartDate; VarReportStartDate)
                {
                    ApplicationArea = Basic;
                    Caption = 'Report Start Date';
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
        VarMonth1DateFilter: Text;
        VarMonth2DateFilter: Text;
        VarMonth3DateFilter: Text;
        VarReportStartDate: Date;
        ObjChequeBookApplications: Record "Cheque Book Application";
        VarMonth1MonthYear: Text;
        VarMonth2MonthYear: Text;
        VarMonth3MonthYear: Text;
        VarNairobiMonth1Count: Integer;
        VarNairobiMonth2Count: Integer;
        VarNairobiMonth3Count: Integer;
        VarNaivashaMonth1Count: Integer;
        VarNaivashaMonth2Count: Integer;
        VarNaivashaMonth3Count: Integer;
        VarNakuruMonth1Count: Integer;
        VarNakuruMonth2Count: Integer;
        VarNakuruMonth3Count: Integer;
        VarEldoretMonth1Count: Integer;
        VarEldoretMonth2Count: Integer;
        VarEldoretMonth3Count: Integer;
        VarMombasaMonth1Count: Integer;
        VarMombasaMonth2Count: Integer;
        VarMombasaMonth3Count: Integer;

    // --> Reports ForNAV Autogenerated code - do not delete or modify
    //51516004_v6_3_0_2259;






    // Reports ForNAV Autogenerated code - do not delete or modify -->
}
