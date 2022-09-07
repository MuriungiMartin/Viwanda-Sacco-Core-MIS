#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
dotnet // --> Reports ForNAV Autogenerated code - do not delete or modify
{
    assembly("ForNav.Reports.6.3.0.2259")
    {
        type(ForNav.Report_6_3_0_2259; ForNavReport51516862_v6_3_0_2259) { }
    }
} // Reports ForNAV Autogenerated code - do not delete or modify -->

Report 50862 "Send Members & Groups Report"
{
    RDLCLayout = 'Layouts/SendMembers&GroupsReport.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Sacco General Set-Up"; "Sacco General Set-Up")
        {
            column(ReportForNavId_1; 1) { } // Autogenerated by ForNav - Do not delete
            trigger OnAfterGetRecord();
            begin
                SMTPSetup.Get;
                Filename := '';
                FilePath := '';
                Filename := 'Members & House Groups Report - ' + Format(WorkDate, 0, '<Day,2> <Month Text,3> <Year4>') + '.xlsx';
                FilePath := SMTPSetup."Path to Save Report" + Filename;
                Report.SaveAsExcel(Report::"Member & Group Balances Report", FilePath);
                VarMailSubject := 'Members & House Groups Report - ' + Format(WorkDate, 0, '<Day,2> <Month Text,3> <Year4>');
                VarMailBody := 'Kindly find attached the Members & House Groups Report as at ' + Format(WorkDate, 0, '<Day,2> <Month Text,3> <Year4>') + ' for your review.';
                SFactory.FnSendStatementViaMail('Team', VarMailSubject, VarMailBody, 'info@visionsacco.com', Filename, '');
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
        ;
        ReportsForNavPre;
    end;

    var
        SFactory: Codeunit "SURESTEP Factory";
        SMTPSetup: Record "SMTP Mail Setup";
        Filename: Text;
        FilePath: Text;
        VarMailSubject: Text;
        VarMailBody: Text;

    // --> Reports ForNAV Autogenerated code - do not delete or modify
    var
        [WithEvents]
        ReportForNav: DotNet ForNavReport51516862_v6_3_0_2259;
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
