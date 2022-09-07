#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
dotnet // --> Reports ForNAV Autogenerated code - do not delete or modify
{
    assembly("ForNav.Reports.6.3.0.2259")
    {
        type(ForNav.Report_6_3_0_2259; ForNavReport51516142_v6_3_0_2259) { }
    }
} // Reports ForNAV Autogenerated code - do not delete or modify -->

Report 50142 "Charge Statement Fee"
{
    RDLCLayout = 'Layouts/ChargeStatementFee.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem(Vendor; Vendor)
        {
            column(ReportForNavId_1; 1) { } // Autogenerated by ForNav - Do not delete
            trigger OnAfterGetRecord();
            begin
                ObjGensetup.Get;
                ObjCharges.Reset;
                ObjCharges.SetRange(ObjCharges."Charge Type", ObjCharges."charge type"::"Statement Charge");
                if ObjCharges.FindSet then begin
                    VarChargeAmount := ObjCharges."Charge Amount";
                    VarChargeAccount := ObjCharges."GL Account";
                    VarChargeAmount := VarChargeAmount * VarStatementNoofPages;
                    VarAvailableBal := SFactory.FnRunGetAccountAvailableBalance("No.");
                    if VarAvailableBal < (VarChargeAmount + (VarChargeAmount * (ObjGensetup."Excise Duty(%)" / 100))) then begin
                        Error('Account has insuffiecient balance for this transactions');
                    end;
                    if Confirm('Confirm Statement Fee Charge', false) = true then begin
                        if ObjNoSeries.Get then begin
                            ObjNoSeries.TestField(ObjNoSeries."Transaction Document No");
                            VarDocumentNo := NoSeriesMgt.GetNextNo(ObjNoSeries."Transaction Document No", 0D, true);
                            if VarDocumentNo <> '' then begin
                                DOCUMENT_NO := VarDocumentNo;
                                GenJournalLine.Reset;
                                GenJournalLine.SetRange("Journal Template Name", 'PURCHASES');
                                GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
                                if GenJournalLine.Find('-') then begin
                                    GenJournalLine.DeleteAll;
                                end;
                                //------------------------------------1. DEBIT MEMBER DEPOSITS A/C---------------------------------------------------------------------------------------------
                                LineNo := LineNo + 10000;
                                SFactory.FnCreateGnlJournalLine('PURCHASES', 'FTRANS', DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Deposit Contribution",
                                GenJournalLine."account type"::Vendor, "No.", WorkDate, VarChargeAmount, 'FOSA', '',
                                'Account Statement Fee', '', GenJournalLine."application source"::" ");
                                //--------------------------------(Debit Member Deposit Account)---------------------------------------------
                                //------------------------------------1.1. CREDIT FEE  GL A/C---------------------------------------------------------------------------------------------
                                LineNo := LineNo + 10000;
                                SFactory.FnCreateGnlJournalLine('PURCHASES', 'FTRANS', DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                                GenJournalLine."account type"::"G/L Account", VarChargeAccount, WorkDate, VarChargeAmount * -1, 'FOSA', '',
                                'Account Statement Fee' + ' - ' + VarChargeAccount, '', GenJournalLine."application source"::" ");
                                //----------------------------------(Credit Fee GL Account)------------------------------------------------
                                VarExciseDuty := VarChargeAmount * (ObjGensetup."Excise Duty(%)" / 100);
                                //------------------------------------2. DEBIT MEMBER DEPOSITS A/C EXCISE ON FEE---------------------------------------------------------------------------------------------
                                LineNo := LineNo + 10000;
                                SFactory.FnCreateGnlJournalLine('PURCHASES', 'FTRANS', DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Deposit Contribution",
                                GenJournalLine."account type"::Vendor, "No.", WorkDate, VarExciseDuty, 'BOSA', '',
                                'Tax: Account Statement Fee', '', GenJournalLine."application source"::" ");
                                //--------------------------------(Debit Member Deposit Account Excise Duty)---------------------------------------------
                                //------------------------------------2.1. CREDIT EXCISE  GL A/C---------------------------------------------------------------------------------------------
                                LineNo := LineNo + 10000;
                                SFactory.FnCreateGnlJournalLine('PURCHASES', 'FTRANS', DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                                GenJournalLine."account type"::"G/L Account", ObjGensetup."Excise Duty Account", WorkDate, VarExciseDuty * -1, 'BOSA', '',
                                'Tax: Account Statement Fee' + ' - ' + Vendor."No.", '', GenJournalLine."application source"::" ");
                                //----------------------------------(Credit Excise GL Account)------------------------------------------------
                            end;
                        end;
                        //============================================================================================================Post New
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", 'PURCHASES');
                        GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
                        if GenJournalLine.Find('-') then begin
                            Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
                            Message('Charge Posted Successfully')
                        end;
                    end;
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
                field(VarStatementNoofPages; VarStatementNoofPages)
                {
                    ApplicationArea = Basic;
                    Caption = 'Statement No of Pages';
                }
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
        ;
        ReportsForNavPre;
    end;

    var
        SFactory: Codeunit "SURESTEP Factory";
        VarStatementNoofPages: Integer;
        ObjCharges: Record Charges;
        VarChargeAmount: Decimal;
        VarChargeAccount: Code[30];
        ObjGensetup: Record "Sacco General Set-Up";
        VarExciseDuty: Decimal;
        VarAvailableBal: Decimal;
        LineNo: Integer;
        DOCUMENT_NO: Code[30];
        GenJournalLine: Record "Gen. Journal Line";
        VarDocumentNo: Code[30];
        ObjNoSeries: Record "General Ledger Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;

    // --> Reports ForNAV Autogenerated code - do not delete or modify
    var
        [WithEvents]
        ReportForNav: DotNet ForNavReport51516142_v6_3_0_2259;
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