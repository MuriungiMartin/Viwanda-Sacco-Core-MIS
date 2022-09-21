#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
//50039_v6_3_0_2259) { }
// Autogenerated code - do not delete or modify -->

Report 50039 "Trial Balance Ver3.0"
{
    Caption = 'Trial Balance';
    RDLCLayout = 'Layouts/TrialBalanceVer3.0.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("G/L Account"; "G/L Account")
        {
            DataItemTableView = sorting("No.") where(Blocked = filter(false));
            RequestFilterFields = "No.", "Account Type", "Date Filter", "Global Dimension 1 Filter", "Global Dimension 2 Filter";
            column(ReportForNavId_6710; 6710) { } // Autogenerated by ForNav - Do not delete
            column(STRSUBSTNO_Text000_PeriodText_; StrSubstNo(Text000, PeriodText))
            {
            }

            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(PeriodText; PeriodText)
            {
            }
            column(G_L_Account__TABLECAPTION__________GLFilter; TableCaption + ': ' + GLFilter)
            {
            }
            column(GLFilter; GLFilter)
            {
            }
            column(G_L_Account_No_; "G/L Account"."No.")
            {
            }
            column(Trial_BalanceCaption; Trial_BalanceCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Net_ChangeCaption; Net_ChangeCaptionLbl)
            {
            }
            column(Totaldebit; TotalDebit)
            {
            }
            column(Totalcredit; -Totalcredit)
            {
            }
            column(BalanceCaption; BalanceCaptionLbl)
            {
            }
            column(G_L_Account___No__Caption; FieldCaption("No."))
            {
            }
            column(PADSTR_____G_L_Account__Indentation___2___G_L_Account__NameCaption; PADSTR_____G_L_Account__Indentation___2___G_L_Account__NameCaptionLbl)
            {
            }
            column(G_L_Account___Net_Change_Caption; G_L_Account___Net_Change_CaptionLbl)
            {
            }
            column(G_L_Account___Net_Change__Control22Caption; G_L_Account___Net_Change__Control22CaptionLbl)
            {
            }
            column(G_L_Account___Balance_at_Date_Caption; G_L_Account___Balance_at_Date_CaptionLbl)
            {
            }
            column(G_L_Account___Balance_at_Date__Control24Caption; G_L_Account___Balance_at_Date__Control24CaptionLbl)
            {
            }
            column(PageGroupNo; PageGroupNo)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
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
            column(StartBalance; StartBalance)
            {
            }
            column(VarGLTotalDebits; VarGLTotalDebits)
            {
            }
            column(VarGLTotalCredits; VarGLTotalCredits)
            {
            }
            column(VarGLClosingBalance; VarGLClosingBalance)
            {
            }
            column(OldNo_GLAccount; "Old No.")
            {
            }
            column(No_GLAccount; "G/L Account"."No.")
            {
            }
            column(Name_GLAccount; "G/L Account".Name)
            {
            }
            column(AccountType_GLAccount; "G/L Account"."Account Type")
            {
            }
            dataitem(Integer; Integer)
            {
                DataItemTableView = sorting(Number) where(Number = const(1));
                column(ReportForNavId_5444; 5444) { } // Autogenerated by ForNav - Do not delete
                column(G_L_Account___No__; "G/L Account"."No.")
                {
                }
                column(PADSTR_____G_L_Account__Indentation___2___G_L_Account__Name; PadStr('', "G/L Account".Indentation * 2) + "G/L Account".Name)
                {
                }
                column(G_L_Account___Net_Change_; "G/L Account"."Net Change")
                {
                }
                column(G_L_Account___Net_Change__Control22; -"G/L Account"."Net Change")
                {
                    AutoFormatType = 1;
                }
                column(G_L_Account___Balance_at_Date_; "G/L Account"."Balance at Date")
                {
                }
                column(G_L_Account___Balance_at_Date__Control24; -"G/L Account"."Balance at Date")
                {
                    AutoFormatType = 1;
                }
                column(G_L_Account___Account_Type_; Format("G/L Account"."Account Type", 0, 2))
                {
                }
                column(No__of_Blank_Lines; "G/L Account"."No. of Blank Lines")
                {
                }
                dataitem(BlankLineRepeater; Integer)
                {
                    column(ReportForNavId_7; 7) { } // Autogenerated by ForNav - Do not delete
                    column(BlankLineNo; BlankLineNo)
                    {
                    }
                    trigger OnAfterGetRecord();
                    begin
                        if BlankLineNo = 0 then
                            CurrReport.Break;
                        BlankLineNo -= 1;
                    end;

                }
                trigger OnAfterGetRecord();
                begin
                    BlankLineNo := "G/L Account"."No. of Blank Lines" + 1;
                end;

            }
            trigger OnPreDataItem();
            begin
                PageGroupNo := 0;
                ChangeGroupNo := false;
            end;

            trigger OnAfterGetRecord();
            begin
                CalcFields("Net Change", "Balance at Date");
                if PrintToExcel then
                    //MakeExcelDataBody;
                    if ChangeGroupNo then begin
                        PageGroupNo += 1;
                        ChangeGroupNo := false;
                    end;
                ChangeGroupNo := "New Page";
                TotalDebit := 0;
                //Totalcreditbal:=0;
                Totalcredit := 0;
                //Totaldebitbal:=0;
                CalcFields("Net Change", "Balance at Date");
                //CREATETOTALS("Net Change","Balance at Date");
                if "G/L Account"."Account Type" = "G/L Account"."account type"::Posting then begin
                    if "Net Change" > 0 then
                        TotalDebit := TotalDebit + "Net Change";
                    if "Net Change" < 0 then
                        Totalcredit := Totalcredit + "Net Change";
                end;
                //=====================================================================Balance B/F
                StartBalance := 0;
                if VarReportFilter <> '' then
                    if (VarReportFilter <> '..*') then begin
                        SetFilter("Date Filter", VarOpeningBalDateFilter);
                        CalcFields(Balance);
                        StartBalance := Balance;
                    end;
                GLAccBalance := StartBalance;
                //=====================================================================End Balance B/F
                //====================================================================GL Closing Balance
                SetFilter("Date Filter", VarClosingBalDateFilter);
                CalcFields(Balance);
                VarGLClosingBalance := Balance;
                //====================================================================GL Closing Balance
                /*IF (GLAccBalance = 0) AND (VarGLClosingBalance = 0) THEN
				   CurrReport.SKIP;*/
                //=======================================================Get Total Debits & Credits
                VarGLTotalDebits := 0;
                VarGLTotalCredits := 0;
                /*ObjGLEntry.RESET;
				ObjGLEntry.SETRANGE(ObjGLEntry."G/L Account No.","No.");
				ObjGLEntry.SETFILTER(ObjGLEntry."Posting Date",VarReportFilter);
				IF ObjGLEntry.FINDSET THEN
				  BEGIN
					ObjGLEntry.CALCSUMS(ObjGLEntry."Debit Amount",ObjGLEntry."Credit Amount");
					VarGLTotalDebits:=ObjGLEntry."Debit Amount";
					VarGLTotalCredits:=ObjGLEntry."Credit Amount";
					END;*/
                ObjGLEntry.Reset;
                ObjGLEntry.SetRange(ObjGLEntry."G/L Account No.", "No.");
                ObjGLEntry.SetFilter(ObjGLEntry."Posting Date", VarReportFilter);
                ObjGLEntry.SetFilter(ObjGLEntry.Amount, '<%1', 0);
                if ObjGLEntry.FindSet then begin
                    ObjGLEntry.CalcSums(ObjGLEntry.Amount);
                    VarGLTotalCredits := ObjGLEntry.Amount * -1;
                end;
                ObjGLEntry.Reset;
                ObjGLEntry.SetRange(ObjGLEntry."G/L Account No.", "No.");
                ObjGLEntry.SetFilter(ObjGLEntry."Posting Date", VarReportFilter);
                ObjGLEntry.SetFilter(ObjGLEntry.Amount, '>%1', 0);
                if ObjGLEntry.FindSet then begin
                    ObjGLEntry.CalcSums(ObjGLEntry.Amount);
                    VarGLTotalDebits := ObjGLEntry.Amount;
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
                group(Options)
                {
                    Caption = 'Options';
                    field(PrintToExcel; PrintToExcel)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Print to Excel';
                    }

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
        if PrintToExcel then
            //CreateExcelbook;
            ;

    end;

    trigger OnPreReport()
    begin
        GLFilter := "G/L Account".GetFilters;
        PeriodText := "G/L Account".GetFilter("Date Filter");
        if PrintToExcel then
            //MakeExcelInfo;
            VarReportFilter := "G/L Account".GetFilter("G/L Account"."Date Filter");
        //VarMinDateDateFilter:=SFactory.FnRunGetStatementDateFilter(VarReportFilter);
        VarMinDateDateFilter := "G/L Account".GetRangeMin("G/L Account"."Date Filter") - 1;
        VarDateFilterMax := "G/L Account".GetRangemax("G/L Account"."Date Filter");
        VarOpeningBalDateFilter := '..' + Format(VarMinDateDateFilter);
        VarClosingBalDateFilter := '..' + Format(VarDateFilterMax);
        ;

    end;

    var
        Text000: label 'Period: %1';
        ExcelBuf: Record "Excel Buffer" temporary;
        GLFilter: Text;
        PeriodText: Text[30];
        PrintToExcel: Boolean;
        Text001: label 'Trial Balance';
        Text002: label 'Data';
        Text003: label 'Debit';
        Text004: label 'Credit';
        Text005: label 'Company Name';
        Text006: label 'Report No.';
        Text007: label 'Report Name';
        Text008: label 'User ID';
        Text009: label 'Date';
        Text010: label 'G/L Filter';
        Text011: label 'Period Filter';
        Trial_BalanceCaptionLbl: label 'Trial Balance';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        Net_ChangeCaptionLbl: label 'Net Change';
        BalanceCaptionLbl: label 'Balance';
        PADSTR_____G_L_Account__Indentation___2___G_L_Account__NameCaptionLbl: label 'Name';
        G_L_Account___Net_Change_CaptionLbl: label 'Debit';
        G_L_Account___Net_Change__Control22CaptionLbl: label 'Credit';
        G_L_Account___Balance_at_Date_CaptionLbl: label 'Debit';
        G_L_Account___Balance_at_Date__Control24CaptionLbl: label 'Credit';
        PageGroupNo: Integer;
        ChangeGroupNo: Boolean;
        BlankLineNo: Integer;
        Totalcredit: Decimal;
        TotalDebit: Decimal;
        Company: Record "Company Information";
        VarReportFilter: Text;
        VarMinDateDateFilter: Date;
        SFactory: Codeunit "SURESTEP Factory";
        StartBalance: Decimal;
        GLAccBalance: Decimal;
        ObjGLEntry: Record "G/L Entry";
        VarGLTotalDebits: Decimal;
        VarGLTotalCredits: Decimal;
        VarDateFilterMax: Date;
        VarClosingBalDateFilter: Text;
        VarGLClosingBalance: Decimal;
        VarOpeningBalDateFilter: Text;

    // --> Reports ForNAV Autogenerated code - do not delete or modify
    //50039_v6_3_0_2259;






    // Reports ForNAV Autogenerated code - do not delete or modify -->
}
