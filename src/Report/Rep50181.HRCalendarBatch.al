#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
dotnet // --> Reports ForNAV Autogenerated code - do not delete or modify
{
    assembly("ForNav.Reports.6.3.0.2259")
    {
        type(ForNav.Report_6_3_0_2259; ForNavReport51516181_v6_3_0_2259) { }
    }
} // Reports ForNAV Autogenerated code - do not delete or modify -->

Report 50181 "HR Calendar Batch"
{
    RDLCLayout = 'Layouts/HRCalendarBatch.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("HR Calendar List"; "HR Calendar List")
        {
            RequestFilterFields = "Code", "Non Working";
            column(ReportForNavId_2215; 2215) { } // Autogenerated by ForNav - Do not delete
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(CurrReport_PAGENO; Format(ReportForNav.PageNo))
            {
            }
            column(UserId; UserId)
            {
            }
            column(HR_Calendar_List_Day; "HR Calendar List".Day)
            {
            }
            column(HR_Calendar_List_Date; "HR Calendar List".Date)
            {
            }
            column(HR_Calendar_List__Non_Working_; "HR Calendar List"."Non Working")
            {
            }
            column(HR_Calendar_List_Reason; "HR Calendar List".Reason)
            {
            }
            column(HR_Calendar_ListCaption; HR_Calendar_ListCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(HR_Calendar_List_DayCaption; FieldCaption(Day))
            {
            }
            column(HR_Calendar_List_DateCaption; FieldCaption(Date))
            {
            }
            column(HR_Calendar_List__Non_Working_Caption; FieldCaption("Non Working"))
            {
            }
            column(HR_Calendar_List_ReasonCaption; FieldCaption(Reason))
            {
            }
            column(HR_Calendar_List_Code; "HR Calendar List".Code)
            {
            }
            trigger OnAfterGetRecord();
            begin
                HRCalendar.SetRange(HRCalendar.Current, true);
                if HRCalendar.Find('-') then
                    Code := HRCalendar.Year;
                Modify;
                Holidays.FindFirst;
                repeat
                    if Day = Holidays."Non Working Days" then
                        "Non Working" := true;
                    Modify;
                    if Date = Holidays."Non Working Dates" then
                        "Non Working" := true;
                    Modify;
                until Holidays.Next = 0;
            end;

            trigger OnPostDataItem();
            begin
                Message('Calendar has been updated Successfully');
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
        Holidays: Record "HR Non Working Days & Dates";
        HRCalendar: Record "HR Calendar";
        CurrentDate: Date;
        HR_Calendar_ListCaptionLbl: label 'HR Calendar List';
        CurrReport_PAGENOCaptionLbl: label 'Page';

    // --> Reports ForNAV Autogenerated code - do not delete or modify
    var
        [WithEvents]
        ReportForNav: DotNet ForNavReport51516181_v6_3_0_2259;
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