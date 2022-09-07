#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
dotnet // --> Reports ForNAV Autogenerated code - do not delete or modify
{
    assembly("ForNav.Reports.6.3.0.2259")
    {
        type(ForNav.Report_6_3_0_2259; ForNavReport51516174_v6_3_0_2259) { }
    }
} // Reports ForNAV Autogenerated code - do not delete or modify -->

Report 50174 "HR Job Requirements"
{
    RDLCLayout = 'Layouts/HRJobRequirements.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("HR Jobss"; "HR Jobss")
        {
            RequestFilterFields = "Job ID";
            column(ReportForNavId_9002; 9002) { } // Autogenerated by ForNav - Do not delete
            column(PageConst_________FORMAT_CurrReport_PAGENO_; PageConst + ' ' + Format(ReportForNav.PageNo))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(CI_City; CI.City)
            {
            }
            column(CI__Address_2______CI__Post_Code_; CI."Address 2" + ' ' + CI."Post Code")
            {
            }
            column(CI_Address; CI.Address)
            {
            }
            column(CI_PhoneNo; CI."Phone No.")
            {
            }
            column(HR_Jobs__Job_ID_; "HR Jobss"."Job ID")
            {
            }
            column(HR_Jobs__Job_Description_; "HR Jobss"."Job Description")
            {
            }
            column(HR_Jobs__Main_Objective_; "HR Jobss"."Main Objective")
            {
            }
            column(HR_JobsCaption; HR_JobsCaptionLbl)
            {
            }
            column(Job_RequirementsCaption; Job_RequirementsCaptionLbl)
            {
            }
            column(P_O__BoxCaption; P_O__BoxCaptionLbl)
            {
            }
            column(HR_Jobs__Job_ID_Caption; FieldCaption("Job ID"))
            {
            }
            column(HR_Jobs__Job_Description_Caption; FieldCaption("Job Description"))
            {
            }
            column(HR_Jobs__Main_Objective_Caption; FieldCaption("Main Objective"))
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            dataitem("HR Job Requirements"; "HR Job Requirements")
            {
                DataItemLink = "Job Id" = field("Job ID");
                DataItemTableView = sorting("Job Id", "Qualification Type", "Qualification Code");
                column(ReportForNavId_5968; 5968) { } // Autogenerated by ForNav - Do not delete
                column(JobId_HRJobRequirements; "HR Job Requirements"."Job Id")
                {
                    IncludeCaption = true;
                }
                column(QualificationType_HRJobRequirements; "HR Job Requirements"."Qualification Type")
                {
                    IncludeCaption = true;
                }
                column(QualificationCode_HRJobRequirements; "HR Job Requirements"."Qualification Code")
                {
                    IncludeCaption = true;
                }
                column(Priority_HRJobRequirements; "HR Job Requirements".Priority)
                {
                    IncludeCaption = true;
                }
                column(ScoreID_HRJobRequirements; "HR Job Requirements"."Score ID")
                {
                    IncludeCaption = true;
                }
                column(Needcode_HRJobRequirements; "HR Job Requirements"."Need code")
                {
                    IncludeCaption = true;
                }
                column(StageCode_HRJobRequirements; "HR Job Requirements"."Stage Code")
                {
                    IncludeCaption = true;
                }
                column(Mandatory_HRJobRequirements; "HR Job Requirements".Mandatory)
                {
                    IncludeCaption = true;
                }
                column(DesiredScore_HRJobRequirements; "HR Job Requirements"."Desired Score")
                {
                    IncludeCaption = true;
                }
                column(TotalStageDesiredScore_HRJobRequirements; "HR Job Requirements"."Total (Stage)Desired Score")
                {
                    IncludeCaption = true;
                }
                column(QualificationDescription_HRJobRequirements; "HR Job Requirements"."Qualification Description")
                {
                    IncludeCaption = true;
                }
            }
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
        CI: Record "Company Information";
        HR_JobsCaptionLbl: label 'HR Jobs';
        Job_RequirementsCaptionLbl: label 'Job Requirements';
        P_O__BoxCaptionLbl: label 'P.O. Box';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        PageConst: label 'Page';
        NameCaptionLbl: label 'Name';

    // --> Reports ForNAV Autogenerated code - do not delete or modify
    var
        [WithEvents]
        ReportForNav: DotNet ForNavReport51516174_v6_3_0_2259;
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