#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
dotnet // --> Reports ForNAV Autogenerated code - do not delete or modify
{
    assembly("ForNav.Reports.6.3.0.2259")
    {
        type(ForNav.Report_6_3_0_2259; ForNavReport51516891_v6_3_0_2259) { }
    }
} // Reports ForNAV Autogenerated code - do not delete or modify -->

Report 50891 "FOSA Account Statement (App)"
{
    Caption = 'Account Statement';
    RDLCLayout = 'Layouts/FOSAAccountStatement(App).rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem(Vendor; Vendor)
        {
            DataItemTableView = sorting("No.") where("Creditor Type" = const("FOSA Account"));
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Date Filter";
            column(ReportForNavId_3182; 3182) { } // Autogenerated by ForNav - Do not delete
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(CompanyInfo_Address; CompanyInfo.Address)
            {
            }
            column(CurrReport_PAGENO; Format(ReportForNav.PageNo))
            {
            }
            column(CompanyInfo_Pic; CompanyInfo.Picture)
            {
            }
            column(CompanyInfo_Name; CompanyInfo.Name)
            {
            }
            column(CompanyInfo__Address_2_; CompanyInfo."Address 2")
            {
            }
            column(STRSUBSTNO_Text000_VendDateFilter_; StrSubstNo(Text000, VendDateFilter))
            {
            }
            column(VendFilter; VendFilter)
            {
            }
            column(FromDate; Format(FromDate, 0, '<Day,2> <Month Text,3> <Year4>'))
            {
            }
            column(ToDate; Format(ToDate, 0, '<Day,2> <Month Text,3> <Year4>'))
            {
            }
            column(GeneratedOn; GeneratedOn)
            {
            }
            column(Vendor_Name; Vendor.Name)
            {
            }
            column(Vendor__No__; Vendor."No.")
            {
            }
            column(Vendor_Vendor__Account_Type_; Vendor."Account Type")
            {
            }
            column(AccountTypeName; AccountTypeName)
            {
            }
            column(BOSA_Account_No; "BOSA Account No")
            {
            }
            column(Company_Code; "Employer Code")
            {
            }
            column(CompanyNamee; CompanyNamee)
            {
            }
            column(Vendor_Vendor__Staff_No_; Vendor."Personal No.")
            {
            }
            column(StartBalanceLCY__1; StartBalanceLCY * -1)
            {
                AutoFormatType = 1;
            }
            column(StartBalAdjLCY; StartBalAdjLCY)
            {
                AutoFormatType = 1;
            }
            column(VendBalanceLCY__1; VendBalanceLCY * -1)
            {
                AutoFormatType = 1;
            }
            column(StartBalanceLCY__1_Control29; StartBalanceLCY * -1)
            {
                AutoFormatType = 1;
            }
            column(Vendor_Ledger_Entry___Amount__LCY_____Correction___ApplicationRounding___1; ("Vendor Ledger Entry"."Amount (LCY)" + Correction + ApplicationRounding) * -1)
            {
                AutoFormatType = 1;
            }
            column(StartBalanceLCY___StartBalAdjLCY____Vendor_Ledger_Entry___Amount__LCY_____Correction___ApplicationRounding___1; (StartBalanceLCY + StartBalAdjLCY + "Vendor Ledger Entry"."Amount (LCY)" + Correction + ApplicationRounding) * -1)
            {
                AutoFormatType = 1;
            }
            column(Vendor__Uncleared_Cheques_; "Uncleared Cheques")
            {
            }
            column(DataItem1102760019; ((StartBalanceLCY + StartBalAdjLCY + "Vendor Ledger Entry"."Amount (LCY)" + Correction + ApplicationRounding) * -1) - "Uncleared Cheques" - MinBal)
            {
            }
            column(Account_StatementCaption; Account_StatementCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(All_amounts_are_in_LCYCaption; All_amounts_are_in_LCYCaptionLbl)
            {
            }
            column(VendBalanceLCY__1_Control40Caption; VendBalanceLCY__1_Control40CaptionLbl)
            {
            }
            column(Vendor_Ledger_Entry_DescriptionCaption; "Vendor Ledger Entry".FieldCaption(Description))
            {
            }
            column(Vendor_Ledger_Entry__Document_No__Caption; "Vendor Ledger Entry".FieldCaption("Document No."))
            {
            }
            column(Vendor_Ledger_Entry__Posting_Date_Caption; "Vendor Ledger Entry".FieldCaption("Posting Date"))
            {
            }
            column(Account_No_Caption; Account_No_CaptionLbl)
            {
            }
            column(NamesCaption; NamesCaptionLbl)
            {
            }
            column(Account_TypeCaption; Account_TypeCaptionLbl)
            {
            }
            column(Vendor_Ledger_Entry__Debit_Amount_Caption; "Vendor Ledger Entry".FieldCaption("Debit Amount"))
            {
            }
            column(Vendor_Ledger_Entry__Credit_Amount_Caption; "Vendor Ledger Entry".FieldCaption("Credit Amount"))
            {
            }
            column(Vendor_Ledger_Entry__External_Document_No__Caption; "Vendor Ledger Entry".FieldCaption("External Document No."))
            {
            }
            column(Staff_No_Caption; Staff_No_CaptionLbl)
            {
            }
            column(Adj__of_Opening_BalanceCaption; Adj__of_Opening_BalanceCaptionLbl)
            {
            }
            column(Total_BalanceCaption; Total_BalanceCaptionLbl)
            {
            }
            column(Total_Balance_Before_PeriodCaption; Total_Balance_Before_PeriodCaptionLbl)
            {
            }
            column(Vendor__Uncleared_Cheques_Caption; FieldCaption("Uncleared Cheques"))
            {
            }
            column(Available_BalanceCaption; Available_BalanceCaptionLbl)
            {
            }
            column(Vendor_Date_Filter; Vendor."Date Filter")
            {
            }
            column(Vendor_Global_Dimension_1_Filter; Vendor."Global Dimension 1 Filter")
            {
            }
            column(Vendor_Global_Dimension_2_Filter; Vendor."Global Dimension 2 Filter")
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
            dataitem("Vendor Ledger Entry"; "Vendor Ledger Entry")
            {
                DataItemLink = "Vendor No." = field("No."), "Posting Date" = field("Date Filter"), "Global Dimension 1 Code" = field("Global Dimension 1 Filter"), "Global Dimension 2 Code" = field("Global Dimension 2 Filter"), "Date Filter" = field("Date Filter");
                DataItemTableView = sorting("Vendor No.", "Posting Date");
                column(ReportForNavId_4114; 4114) { } // Autogenerated by ForNav - Do not delete
                column(StartBalanceLCY___StartBalAdjLCY____Amount__LCY_____1; (StartBalanceLCY + StartBalAdjLCY + "Amount (LCY)") * -1)
                {
                    AutoFormatType = 1;
                }
                column(Vendor_Ledger_Entry__Posting_Date_; Format("Posting Date", 0, '<Day,2> <Month Text,3> <Year4>'))
                {
                }
                column(Vendor_Ledger_Entry__Document_No__; "Vendor Ledger Entry"."Document No.")
                {
                }
                column(Vendor_Ledger_Entry_Description; "Vendor Ledger Entry".Description)
                {
                }
                column(VendAmount__1; VendAmount * -1)
                {
                    AutoFormatExpression = VendCurrencyCode;
                    AutoFormatType = 1;
                }
                column(VendBalanceLCY__1_Control40; VendBalanceLCY * -1)
                {
                    AutoFormatType = 1;
                }
                column(VendCurrencyCode; VendCurrencyCode)
                {
                }
                column(Vendor_Ledger_Entry__Debit_Amount_; "Vendor Ledger Entry"."Debit Amount")
                {
                }
                column(Vendor_Ledger_Entry__Credit_Amount_; "Vendor Ledger Entry"."Credit Amount")
                {
                }
                column(Vendor_Ledger_Entry__External_Document_No__; "Vendor Ledger Entry"."External Document No.")
                {
                }
                column(StartBalanceLCY___StartBalAdjLCY____Amount__LCY_____1_Control53; (StartBalanceLCY + StartBalAdjLCY + "Amount (LCY)") * -1)
                {
                    AutoFormatType = 1;
                }
                column(ContinuedCaption; ContinuedCaptionLbl)
                {
                }
                column(ContinuedCaption_Control46; ContinuedCaption_Control46Lbl)
                {
                }
                column(Vendor_Ledger_Entry_Entry_No_; "Vendor Ledger Entry"."Entry No.")
                {
                }
                column(Vendor_Ledger_Entry_Vendor_No_; "Vendor Ledger Entry"."Vendor No.")
                {
                }
                column(Vendor_Ledger_Entry_Global_Dimension_1_Code; "Vendor Ledger Entry"."Global Dimension 1 Code")
                {
                }
                column(Vendor_Ledger_Entry_Global_Dimension_2_Code; "Vendor Ledger Entry"."Global Dimension 2 Code")
                {
                }
                column(Vendor_Ledger_Entry_Date_Filter; "Vendor Ledger Entry"."Date Filter")
                {
                }
                column(TotalDebits; TotalDebits)
                {
                }
                column(TotalCredits; TotalCredits)
                {
                }
                column(Totals; Totals)
                {
                }
                column(PostedBy; "Vendor Ledger Entry"."User ID")
                {
                }
                dataitem("Detailed Vendor Ledg. Entry"; "Detailed Vendor Ledg. Entry")
                {
                    DataItemLink = "Vendor Ledger Entry No." = field("Entry No.");
                    DataItemTableView = sorting("Vendor Ledger Entry No.", "Entry Type", "Posting Date") where("Entry Type" = const("Correction of Remaining Amount"));
                    column(ReportForNavId_2149; 2149) { } // Autogenerated by ForNav - Do not delete
                    column(Vendor_Ledger_Entry___Amount__LCY_____Correction___ApplicationRounding___12; ("Vendor Ledger Entry"."Amount (LCY)" + Correction + ApplicationRounding) * -1)
                    {
                    }
                    column(StartBalanceLCY___StartBalAdjLCY____Vendor_Ledger_Entry___Amount__LCY_____Correction___ApplicationRounding___13; (StartBalanceLCY + StartBalAdjLCY + "Vendor Ledger Entry"."Amount (LCY)" + Correction + ApplicationRounding) * -1)
                    {
                    }
                    column(DataItem11027600193; ((StartBalanceLCY + StartBalAdjLCY + "Vendor Ledger Entry"."Amount (LCY)" + Correction + ApplicationRounding) * -1) - MinBal)
                    {
                    }
                    column(VendBalanceLCY__1_Control402; VendBalanceLCY * -1)
                    {
                    }
                    trigger OnPreDataItem();
                    begin
                        SetFilter("Posting Date", VendDateFilter);
                    end;

                    trigger OnAfterGetRecord();
                    begin
                        Correction := Correction + "Amount (LCY)";
                        VendBalanceLCY := VendBalanceLCY + "Amount (LCY)";
                    end;

                }
                dataitem("Detailed Vendor Ledg. Entry2"; "Detailed Vendor Ledg. Entry")
                {
                    DataItemLink = "Vendor Ledger Entry No." = field("Entry No.");
                    DataItemTableView = sorting("Vendor Ledger Entry No.", "Entry Type", "Posting Date") where("Entry Type" = const("Appln. Rounding"));
                    column(ReportForNavId_4103; 4103) { } // Autogenerated by ForNav - Do not delete
                    column(Vendor_Ledger_Entry___Amount__LCY_____Correction___ApplicationRounding___13; ("Vendor Ledger Entry"."Amount (LCY)" + Correction + ApplicationRounding) * -1)
                    {
                    }
                    column(StartBalanceLCY___StartBalAdjLCY____Vendor_Ledger_Entry___Amount__LCY_____Correction___ApplicationRounding___14; (StartBalanceLCY + StartBalAdjLCY + "Vendor Ledger Entry"."Amount (LCY)" + Correction + ApplicationRounding) * -1)
                    {
                    }
                    column(DataItem11027600194; ((StartBalanceLCY + StartBalAdjLCY + "Vendor Ledger Entry"."Amount (LCY)" + Correction + ApplicationRounding) * -1) - MinBal)
                    {
                    }
                    trigger OnPreDataItem();
                    begin
                        SetFilter("Posting Date", VendDateFilter);
                    end;

                    trigger OnAfterGetRecord();
                    begin
                        ApplicationRounding := ApplicationRounding + "Amount (LCY)";
                        VendBalanceLCY := VendBalanceLCY + "Amount (LCY)";
                    end;

                }
                trigger OnPreDataItem();
                begin
                    VendLedgEntryExists := false;

                end;

                trigger OnAfterGetRecord();
                begin
                    TotalDebits := 0;
                    TotalCredits := 0;
                    CalcFields(Amount, "Remaining Amount", "Amount (LCY)", "Remaining Amt. (LCY)");
                    VendLedgEntryExists := true;
                    if PrintAmountsInLCY then begin
                        VendAmount := "Amount (LCY)";
                        VendRemainAmount := "Remaining Amt. (LCY)";
                        VendCurrencyCode := '';
                    end else begin
                        VendAmount := Amount;
                        VendRemainAmount := "Remaining Amount";
                        VendCurrencyCode := "Currency Code";
                    end;
                    VendBalanceLCY := VendBalanceLCY + "Amount (LCY)";
                    if ("Document Type" = "document type"::Payment) or ("Document Type" = "document type"::Refund) then
                        VendEntryDueDate := 0D
                    else
                        VendEntryDueDate := "Due Date";
                    TotalDebits := "Vendor Ledger Entry"."Debit Amount";
                    //FinaleDebits:=FinaleDebits+TotalDebits;
                    Vendor.Get("Vendor Ledger Entry"."Vendor No.");
                    Totals := Vendor."Balance (LCY)";
                    //MESSAGE('Balance is %1',Totals);
                end;

            }
            dataitem(Integer; Integer)
            {
                DataItemTableView = sorting(Number) where(Number = const(1));
                column(ReportForNavId_5444; 5444) { } // Autogenerated by ForNav - Do not delete
                column(StartBalanceLCY__12; StartBalanceLCY * -1)
                {
                }
                column(StartBalanceLCY___StartBalAdjLCY____Vendor_Ledger_Entry___Amount__LCY_____Correction___ApplicationRounding___12; (StartBalanceLCY + StartBalAdjLCY + "Vendor Ledger Entry"."Amount (LCY)" + Correction + ApplicationRounding) * -1)
                {
                }
                column(DataItem11027600192; ((StartBalanceLCY + StartBalAdjLCY + "Vendor Ledger Entry"."Amount (LCY)" + Correction + ApplicationRounding) * -1) - MinBal)
                {
                }
                trigger OnAfterGetRecord();
                begin
                    if not VendLedgEntryExists and ((StartBalanceLCY = 0) or ExcludeBalanceOnly) then begin
                        StartBalanceLCY := 0;
                        CurrReport.Skip;
                    end;
                end;

            }
            trigger OnPreDataItem();
            begin
                ReportForNav.GetDataItem('Vendor').NewPagePerRecord := PrintOnlyOnePerPage;

                if CompanyInfo.Get() then
                    CompanyInfo.CalcFields(CompanyInfo.Picture);
                /*
               //Hide Balances
               IF UsersID.GET(USERID) THEN BEGIN
               IF UsersID."Show Hiden" = FALSE THEN
               Vendor.SETRANGE(Vendor.Hide,FALSE);
               END;
               //Hide Balances
               */
                Company.Get();
                Company.CalcFields(Company.Picture);

            end;

            trigger OnAfterGetRecord();
            begin
                //Totals:=0;
                StartBalanceLCY := 0;
                StartBalAdjLCY := 0;
                if VendDateFilter <> '' then begin
                    if GetRangeMin("Date Filter") <> 0D then begin
                        SetRange("Date Filter", 0D, VarMinDateDateFilter);
                        CalcFields("Net Change (LCY)");
                        StartBalanceLCY := -"Net Change (LCY)";
                    end;
                    SetFilter("Date Filter", VendDateFilter);
                    CalcFields("Net Change (LCY)");
                    StartBalAdjLCY := -"Net Change (LCY)";
                    VendorLedgerEntry.SetCurrentkey("Vendor No.", "Posting Date");
                    VendorLedgerEntry.SetRange("Vendor No.", Vendor."No.");
                    VendorLedgerEntry.SetFilter("Posting Date", VendDateFilter);
                    if VendorLedgerEntry.Find('-') then
                        repeat
                            VendorLedgerEntry.SetFilter("Date Filter", VendDateFilter);
                            VendorLedgerEntry.CalcFields("Amount (LCY)");
                            StartBalAdjLCY := StartBalAdjLCY - VendorLedgerEntry."Amount (LCY)";
                            "Detailed Vendor Ledg. Entry".SetCurrentkey("Vendor Ledger Entry No.", "Entry Type", "Posting Date");
                            "Detailed Vendor Ledg. Entry".SetRange("Vendor Ledger Entry No.", VendorLedgerEntry."Entry No.");
                            "Detailed Vendor Ledg. Entry".SetFilter("Entry Type", '%1|%2',
                              "Detailed Vendor Ledg. Entry"."entry type"::"Correction of Remaining Amount",
                              "Detailed Vendor Ledg. Entry"."entry type"::"Appln. Rounding");
                            "Detailed Vendor Ledg. Entry".SetFilter("Posting Date", VendDateFilter);
                            if "Detailed Vendor Ledg. Entry".Find('-') then
                                repeat
                                    StartBalAdjLCY := StartBalAdjLCY - "Detailed Vendor Ledg. Entry"."Amount (LCY)";
                                until "Detailed Vendor Ledg. Entry".Next = 0;
                            "Detailed Vendor Ledg. Entry".Reset;
                        until VendorLedgerEntry.Next = 0;
                end;
                ReportForNav.GetDataItem('Vendor').PrintOnlyIfDetail := ExcludeBalanceOnly or (StartBalanceLCY = 0);
                VendBalanceLCY := StartBalanceLCY + StartBalAdjLCY;
                MinBal := 0;
                if AccType.Get(Vendor."Account Type") then begin
                    MinBal := AccType."Minimum Balance";
                    AccountTypeName := AccType.Description;
                end;
                Employer.Reset;
                Employer.SetRange(Employer.Code, "Employer Code");
                if Employer.Find('-') then begin
                    CompanyNamee := Employer.Description;
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
                    field(ForNavOpenDesigner; ReportForNavOpenDesigner)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Design';
                        Visible = ReportForNavAllowDesign;
                        trigger OnValidate()
                        begin
                            ReportForNav.LaunchDesigner(ReportForNavOpenDesigner);
                            CurrReport.RequestOptionsPage.Close();
                        end;

                    }
                }
            }
        }

        actions
        {
        }
        trigger OnOpenPage()
        begin
            ReportForNavOpenDesigner := false;
        end;
    }

    trigger OnInitReport()
    begin
        ;
        ReportsForNavInit;

    end;

    trigger OnPostReport()
    begin
        ;
        ReportForNav.Post;
    end;

    trigger OnPreReport()
    begin
        CompanyInfo.Reset;
        CompanyInfo.CalcFields(CompanyInfo.Picture);
        VendFilter := Vendor.GetFilters;
        VendDateFilter := Vendor.GetFilter("Date Filter");
        if VendDateFilter = '' then
            VendDateFilter := Format(WorkDate);
        VarMinDateDateFilter := SFactory.FnRunGetStatementDateFilterAPP(VendDateFilter);
        FromDate := SFactory.FnRunGetStatementFromDateApp(VendDateFilter);
        ToDate := SFactory.FnRunGetStatementToDateApp(VendDateFilter);
        GeneratedOn := Format(CurrentDatetime, 0, '<Day,2> <Month Text,3> <Year4> <Hours24,2>:<Minutes,2>');
        with "Vendor Ledger Entry" do
            if PrintAmountsInLCY then begin
                AmountCaption := FieldCaption("Amount (LCY)");
                RemainingAmtCaption := FieldCaption("Remaining Amt. (LCY)");
            end else begin
                AmountCaption := FieldCaption(Amount);
                RemainingAmtCaption := FieldCaption("Remaining Amount");
            end;
        ;
        ReportsForNavPre;
    end;

    var
        Text000: label 'Period: %1';
        VendorLedgerEntry: Record "Vendor Ledger Entry";
        VendFilter: Text[250];
        VendDateFilter: Text[30];
        VendAmount: Decimal;
        VendRemainAmount: Decimal;
        VendBalanceLCY: Decimal;
        VendEntryDueDate: Date;
        StartBalanceLCY: Decimal;
        StartBalAdjLCY: Decimal;
        Correction: Decimal;
        ApplicationRounding: Decimal;
        ExcludeBalanceOnly: Boolean;
        PrintAmountsInLCY: Boolean;
        PrintOnlyOnePerPage: Boolean;
        VendLedgEntryExists: Boolean;
        AmountCaption: Text[30];
        RemainingAmtCaption: Text[30];
        VendCurrencyCode: Code[10];
        CompanyInfo: Record "Company Information";
        AccType: Record "Account Types-Saving Products";
        MinBal: Decimal;
        Account_StatementCaptionLbl: label 'Account Statement';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        All_amounts_are_in_LCYCaptionLbl: label 'All amounts are in LCY';
        VendBalanceLCY__1_Control40CaptionLbl: label 'Balance (LCY)';
        Account_No_CaptionLbl: label 'Account No.';
        NamesCaptionLbl: label 'Names';
        Account_TypeCaptionLbl: label 'Account Type';
        Staff_No_CaptionLbl: label 'Staff No.';
        Adj__of_Opening_BalanceCaptionLbl: label 'Adj. of Opening Balance';
        Total_BalanceCaptionLbl: label 'Total Balance';
        Total_Balance_Before_PeriodCaptionLbl: label 'Total Balance Before Period';
        Available_BalanceCaptionLbl: label 'Available Balance';
        ContinuedCaptionLbl: label 'Continued';
        ContinuedCaption_Control46Lbl: label 'Continued';
        UsersID: Record User;
        TotalDebits: Decimal;
        TotalCredits: Decimal;
        Totals: Decimal;
        CompanyNamee: Code[50];
        Cust: Record Customer;
        Employer: Record "Sacco Employers";
        Company: Record "Company Information";
        FromDate: Date;
        ToDate: Date;
        GeneratedOn: Text;
        SFactory: Codeunit "SURESTEP Factory";
        AccountTypeName: Text;
        VarMinDateDateFilter: Date;

    // --> Reports ForNAV Autogenerated code - do not delete or modify
    var
        [WithEvents]
        ReportForNav: DotNet ForNavReport51516891_v6_3_0_2259;
        ReportForNavOpenDesigner: Boolean;
        [InDataSet]
        ReportForNavAllowDesign: Boolean;

    local procedure ReportsForNavInit();
    var
        ApplicationSystemConstants: Codeunit "Application System Constants";
        addInFileName: Text;
        tempAddInFileName: Text;
        path: DotNet Path;
        ReportForNavObject: Variant;
    begin
        addInFileName := ApplicationPath() + 'Add-ins\ReportsForNAV_6_3_0_2259\ForNav.Reports.6.3.0.2259.dll';
        if not File.Exists(addInFileName) then begin
            tempAddInFileName := path.GetTempPath() + '\Microsoft Dynamics NAV\Add-Ins\' + ApplicationSystemConstants.PlatformFileVersion() + '\ForNav.Reports.6.3.0.2259.dll';
            if not File.Exists(tempAddInFileName) then
                Error('Please install the ForNAV DLL version 6.3.0.2259 in your service tier Add-ins folder under the file name "%1"\\If you already have the ForNAV DLL on the server, you should move it to this folder and rename it to match this file name.', addInFileName);
        end;
        ReportForNavObject := ReportForNav.GetLatest(CurrReport.OBJECTID, CurrReport.Language, SerialNumber, UserId, CompanyName);
        ReportForNav := ReportForNavObject;
        ReportForNav.Init();
    end;

    local procedure ReportsForNavPre();
    begin
        ReportForNav.OpenDesigner := ReportForNavOpenDesigner;
        if not ReportForNav.Pre() then CurrReport.Quit();
    end;

    // Reports ForNAV Autogenerated code - do not delete or modify -->
}
