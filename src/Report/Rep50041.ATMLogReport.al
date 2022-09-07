#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
dotnet // --> Reports ForNAV Autogenerated code - do not delete or modify
{
    assembly("ForNav.Reports.6.3.0.2259")
    {
        type(ForNav.Report_6_3_0_2259; ForNavReport51516041_v6_3_0_2259) { }
    }
} // Reports ForNAV Autogenerated code - do not delete or modify -->

Report 50041 "ATM Log Report"
{
    RDLCLayout = 'Layouts/ATMLogReport.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("ATM Log Entries"; "ATM Log Entries")
        {
            column(ReportForNavId_1000000000; 1000000000) { } // Autogenerated by ForNav - Do not delete
            column(CI_Name; CI.Name)
            {
                IncludeCaption = true;
            }
            column(CI_Address; CI.Address)
            {
                IncludeCaption = true;
            }
            column(CI_Address2; CI."Address 2")
            {
                IncludeCaption = true;
            }
            column(CI_PhoneNo; CI."Phone No.")
            {
                IncludeCaption = true;
            }
            column(CI_Picture; CI.Picture)
            {
                IncludeCaption = true;
            }
            column(CI_City; CI.City)
            {
                IncludeCaption = true;
            }
            column(DOCNAME; DOCNAME)
            {
            }
            column(NumberText_1_; NumberText[1])
            {
            }
            column(EntryNo_ATMLogEntries; "ATM Log Entries"."Entry No")
            {
            }
            column(DateTime_ATMLogEntries; "ATM Log Entries"."Date Time")
            {
            }
            column(AccountNo_ATMLogEntries; "ATM Log Entries"."Account No")
            {
            }
            column(Amount_ATMLogEntries; "ATM Log Entries".Amount)
            {
            }
            column(ATMNo_ATMLogEntries; "ATM Log Entries"."ATM No")
            {
            }
            column(ATMLocation_ATMLogEntries; "ATM Log Entries"."ATM Location")
            {
            }
            column(TransactionType_ATMLogEntries; "ATM Log Entries"."Transaction Type")
            {
            }
            column(ReturnCode_ATMLogEntries; "ATM Log Entries"."Return Code")
            {
            }
            column(TraceID_ATMLogEntries; "ATM Log Entries"."Trace ID")
            {
            }
            column(AccountNo_ATMLogEntriessss; "ATM Log Entries"."Account No.")
            {
            }
            column(CardNo_ATMLogEntries; "ATM Log Entries"."Card No.")
            {
            }
            column(ATMAmount_ATMLogEntries; "ATM Log Entries"."ATM Amount")
            {
            }
            column(WithdrawalLocation_ATMLogEntries; "ATM Log Entries"."Withdrawal Location")
            {
            }
            column(ReferenceNo_ATMLogEntries; "ATM Log Entries"."Reference No")
            {
            }
            column(SuppNo; SuppNo)
            {
            }
            column(SuppName; SuppName)
            {
            }
            trigger OnPreDataItem();
            begin
                CI.Get();
                CI.CalcFields(CI.Picture);
            end;

            trigger OnAfterGetRecord();
            begin
                //"Sacco Transfers".CALCFIELDS("Sacco Transfers"."Schedule Total");
                CheckReport.InitTextVariable();
                CheckReport.FormatNoText(NumberText, "ATM Log Entries".Amount, ' ');
                Supps.Reset;
                Supps.SetRange(Supps."ATM No.", "ATM Log Entries"."Card No.");
                if Supps.Find('-') then begin
                    "ATM Log Entries"."Account No." := Supps."No.";
                    "ATM Log Entries".Modify;
                    SuppName := Supps.Name
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
        CI.Get();
        CI.CalcFields(CI.Picture);
        ;
        ReportsForNavPre;
    end;

    var
        StrCopyText: Text[30];
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        DimVal: Record "Dimension Value";
        DimValName: Text[30];
        TTotal: Decimal;
        CheckReport: Report Check;
        NumberText: array[2] of Text[80];
        STotal: Decimal;
        InvoiceCurrCode: Code[10];
        CurrCode: Code[10];
        GLSetup: Record "General Ledger Setup";
        DOCNAME: Text[30];
        VATCaptionLbl: label 'VAT';
        PAYMENT_DETAILSCaptionLbl: label 'PAYMENT DETAILS';
        AMOUNTCaptionLbl: label 'AMOUNT';
        NET_AMOUNTCaptionLbl: label 'AMOUNT';
        W_TAXCaptionLbl: label 'W/TAX';
        Document_No___CaptionLbl: label 'Document No. :';
        Currency_CaptionLbl: label 'Currency:';
        Payment_To_CaptionLbl: label 'Payment To:';
        Document_Date_CaptionLbl: label 'Document Date:';
        Cheque_No__CaptionLbl: label 'Cheque No.:';
        R_CENTERCaptionLbl: label 'R.CENTER CODE';
        PROJECTCaptionLbl: label 'PROJECT CODE';
        TotalCaptionLbl: label 'Total';
        Printed_By_CaptionLbl: label 'Printed By:';
        Amount_in_wordsCaptionLbl: label 'Amount in words';
        EmptyStringCaptionLbl: label '================================================================================================================================================================================================';
        EmptyStringCaption_Control1102755013Lbl: label '================================================================================================================================================================================================';
        Amount_in_wordsCaption_Control1102755021Lbl: label 'Amount in words';
        Printed_By_Caption_Control1102755026Lbl: label 'Printed By:';
        TotalCaption_Control1102755033Lbl: label 'Total';
        Signature_CaptionLbl: label 'Signature:';
        Date_CaptionLbl: label 'Date:';
        Name_CaptionLbl: label 'Name:';
        RecipientCaptionLbl: label 'Recipient';
        CompanyInfo: Record "Company Information";
        BudgetLbl: label 'Budget';
        CreationDoc: Boolean;
        DtldVendEntry: Record "Detailed Vendor Ledg. Entry";
        InvNo: Code[20];
        InvAmt: Decimal;
        ApplyEnt: Record "Vendor Ledger Entry";
        VendEnrty: Record "Vendor Ledger Entry";
        CI: Record "Company Information";
        SuppNo: Code[30];
        SuppName: Text;
        Supps: Record Vendor;

    // --> Reports ForNAV Autogenerated code - do not delete or modify
    var
        [WithEvents]
        ReportForNav: DotNet ForNavReport51516041_v6_3_0_2259;
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