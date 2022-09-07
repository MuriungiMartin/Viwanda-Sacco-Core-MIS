#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
dotnet // --> Reports ForNAV Autogenerated code - do not delete or modify
{
    assembly("ForNav.Reports.6.3.0.2259")
    {
        type(ForNav.Report_6_3_0_2259; ForNavReport51516046_v6_3_0_2259) { }
    }
} // Reports ForNAV Autogenerated code - do not delete or modify -->

Report 50046 "Update P9Rports"
{
    UseRequestPage = false;
    RDLCLayout = 'Layouts/UpdateP9Rports.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("prPeriod Transactions."; "prPeriod Transactions.")
        {
            column(ReportForNavId_1000000000; 1000000000) { } // Autogenerated by ForNav - Do not delete
            trigger OnAfterGetRecord();
            begin
                ObjP9Periods.Reset;
                ObjP9Periods.SetRange(ObjP9Periods."Employee Code", "Employee Code");
                ObjP9Periods.SetRange(ObjP9Periods."Payroll Period", "Payroll Period");
                //ObjP9Periods.SETRANGE(ObjP9Periods."Period Year","Period Year");
                if ObjP9Periods.Find('-') then begin
                    case "Transaction Code" of
                        'BPAY':
                            ObjP9Periods."Basic Pay" := Amount;
                        'GPAY':
                            ObjP9Periods."Gross Pay" := Amount;
                        'INSRLF':
                            ObjP9Periods."Insurance Relief" := Amount;
                        'TXCHRG':
                            ObjP9Periods."Tax Charged" := Amount;
                        'PAYE':
                            ObjP9Periods.PAYE := Amount;
                        'NPAY':
                            ObjP9Periods."Net Pay" := Amount;
                        'PSNR':
                            ObjP9Periods."Tax Relief" := Amount;
                    //ELSE
                    end;
                    ObjP9Periods.Modify;
                end
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
        ObjPayrollTransactions.Reset;
        if ObjPayrollTransactions.Find('-') then begin
            repeat
                ObjP9Periods.Reset;
                ObjP9Periods.SetRange(ObjP9Periods."Employee Code", ObjPayrollTransactions."Employee Code");
                ObjP9Periods.SetRange(ObjP9Periods."Payroll Period", ObjPayrollTransactions."Payroll Period");
                if not ObjP9Periods.Find('-') then begin
                    ObjP9Periods.Init;
                    ObjP9Periods."Employee Code" := ObjPayrollTransactions."Employee Code";
                    ObjP9Periods."Payroll Period" := ObjPayrollTransactions."Payroll Period";
                    ObjP9Periods."Period Month" := ObjPayrollTransactions."Period Month";
                    ObjP9Periods."Period Year" := ObjPayrollTransactions."Period Year";
                    ObjP9Periods.Insert;
                end;
            until ObjPayrollTransactions.Next = 0;
        end
        ;
        ReportsForNavPre;
    end;

    var
        ObjP9Periods: Record "Payroll Employee P9.";
        ObjPayrollTransactions: Record "prPeriod Transactions.";

    // --> Reports ForNAV Autogenerated code - do not delete or modify
    var
        [WithEvents]
        ReportForNav: DotNet ForNavReport51516046_v6_3_0_2259;
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
