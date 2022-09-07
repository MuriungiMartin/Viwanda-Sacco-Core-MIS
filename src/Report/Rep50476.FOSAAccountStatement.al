#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 //  settings

Report 50476 "FOSA Account Statement"
{
    Caption = 'Account Statement';
    RDLCLayout = 'Layouts/FOSAAccountStatement.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem(Vendor; Vendor)
        {
            DataItemTableView = sorting("No.") where("Creditor Type" = const("FOSA Account"));
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Global Dimension 2 Filter", "Date Filter";

            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(CompanyInfo_Address; CompanyInfo.Address)
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
            column(Vendor_Name; Vendor.Name)
            {
            }
            column(Vendor__No__; Vendor."No.")
            {
            }
            column(Vendor_Vendor__Account_Type_; Vendor."Account Type")
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
            column(DataItem1102760019; ((StartBalanceLCY + StartBalAdjLCY + "Vendor Ledger Entry"."Amount (LCY)" + Correction + ApplicationRounding) * -1) - MinBal)
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
            column(CompanyInfoName; CompanyInfo.Name)
            {
            }
            column(CompanyInfoAddress; CompanyInfo.Address)
            {
            }
            column(CompanyInfoCity; CompanyInfo.City)
            {
            }
            column(CompanyInfo_Phone_No; CompanyInfo."Phone No.")
            {
            }
            column(CompanyInfo_EMail; CompanyInfo."E-Mail")
            {
            }
            column(CompanyInfo_Home_Page; CompanyInfo."Home Page")
            {
            }
            dataitem("Vendor Ledger Entry"; "Vendor Ledger Entry")
            {
                DataItemLink = "Vendor No." = field("No."), "Posting Date" = field("Date Filter"), "Global Dimension 1 Code" = field("Global Dimension 1 Filter"), "Global Dimension 2 Code" = field("Global Dimension 2 Filter"), "Date Filter" = field("Date Filter");
                DataItemTableView = sorting("Vendor No.", "Posting Date");

                column(StartBalanceLCY___StartBalAdjLCY____Amount__LCY_____1; (StartBalanceLCY + StartBalAdjLCY + "Amount (LCY)") * -1)
                {
                    AutoFormatType = 1;
                }
                column(Vendor_Ledger_Entry__Posting_Date_; "Vendor Ledger Entry"."Posting Date")
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

            end;

            trigger OnAfterGetRecord();
            begin
                //Totals:=0;
                StartBalanceLCY := 0;
                StartBalAdjLCY := 0;
                if VendDateFilter <> '' then begin
                    if GetRangeMin("Date Filter") <> 0D then begin
                        SetRange("Date Filter", 0D, GetRangeMin("Date Filter") - 1);
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

                VendBalanceLCY := StartBalanceLCY + StartBalAdjLCY;
                MinBal := 0;
                if AccType.Get(Vendor."Account Type") then
                    MinBal := AccType."Minimum Balance";
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
        CompanyInfo.Reset;
        CompanyInfo.CalcFields(CompanyInfo.Picture);
        VendFilter := Vendor.GetFilters;
        VendDateFilter := Vendor.GetFilter("Date Filter");
        with "Vendor Ledger Entry" do
            if PrintAmountsInLCY then begin
                AmountCaption := FieldCaption("Amount (LCY)");
                RemainingAmtCaption := FieldCaption("Remaining Amt. (LCY)");
            end else begin
                AmountCaption := FieldCaption(Amount);
                RemainingAmtCaption := FieldCaption("Remaining Amount");
            end;
        ;

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
        Cust: Record "Members Register";
        Employer: Record "Sacco Employers";


    var

}
