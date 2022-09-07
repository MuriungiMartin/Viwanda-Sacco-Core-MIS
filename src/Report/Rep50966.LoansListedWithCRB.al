#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
dotnet // --> Reports ForNAV Autogenerated code - do not delete or modify
{
    assembly("ForNav.Reports.6.3.0.2259")
    {
        type(ForNav.Report_6_3_0_2259; ForNavReport51516966_v6_3_0_2259) { }
    }
} // Reports ForNAV Autogenerated code - do not delete or modify -->

Report 50966 "Loans Listed With CRB"
{
    RDLCLayout = 'Layouts/LoansListedWithCRB.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("CRB Notice Register"; "CRB Notice Register")
        {
            DataItemTableView = where("CRB Listed" = filter(true));
            PrintOnlyIfDetail = false;
            RequestFilterFields = "Loan No", "Member No", "Loan Product Type", "CRB Listed", "Date Listed", "Listed By";
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
            column(CurrReport_PAGENO; Format(ReportForNav.PageNo))
            {
            }
            column(UserId; UserId)
            {
            }
            column(VarCount; VarCount)
            {
            }
            column(LoanNo_CRBNoticeRegister; "CRB Notice Register"."Loan No")
            {
            }
            column(MemberNo_CRBNoticeRegister; "CRB Notice Register"."Member No")
            {
            }
            column(MemberName_CRBNoticeRegister; "CRB Notice Register"."Member Name")
            {
            }
            column(LoanProductType_CRBNoticeRegister; "CRB Notice Register"."Loan Product Type")
            {
            }
            column(LoanProductName_CRBNoticeRegister; "CRB Notice Register"."Loan Product Name")
            {
            }
            column(IssuedDate_CRBNoticeRegister; Format("CRB Notice Register"."Issued Date", 0, '<Day,2> <Month Text,3> <Year4>'))
            {
            }
            column(ApprovedAmount_CRBNoticeRegister; "CRB Notice Register"."Approved Amount")
            {
            }
            column(PrincipleOutstanding_CRBNoticeRegister; "CRB Notice Register"."Principle Outstanding")
            {
            }
            column(AmountInArrears_CRBNoticeRegister; "CRB Notice Register"."Amount In Arrears")
            {
            }
            column(DaysInArrears_CRBNoticeRegister; "CRB Notice Register"."Days In Arrears")
            {
            }
            column(DateOfNotice_CRBNoticeRegister; Format("CRB Notice Register"."Date Of Notice", 0, '<Day,2> <Month Text,3> <Year4>'))
            {
            }
            column(NotifyCRB_CRBNoticeRegister; "CRB Notice Register"."CRB Listed")
            {
            }
            column(DateNotified_CRBNoticeRegister; Format("CRB Notice Register"."Date Listed", 0, '<Day,2> <Month Text,3> <Year4>'))
            {
            }
            column(NotifiedBy_CRBNoticeRegister; "CRB Notice Register"."Listed By")
            {
            }
            column(Delist_CRBNoticeRegister; "CRB Notice Register".Delist)
            {
            }
            column(DeListedOn_CRBNoticeRegister; "CRB Notice Register"."DeListed On")
            {
            }
            column(DelistedBy_CRBNoticeRegister; "CRB Notice Register"."Delisted By")
            {
            }
            trigger OnAfterGetRecord();
            begin
                VarAmountinArrears := 0;
                VarCount := VarCount + 1;
                //SFactory.FnGetLoanArrearsAmountII("Loans Register"."Loan  No.");
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
        Company.Get();
        Company.CalcFields(Company.Picture);
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
        Company: Record "Company Information";
        SFactory: Codeunit "SURESTEP Factory";
        VarAmountinArrears: Decimal;
        ObjRepaymentSchedule: Record "Loan Repayment Schedule";
        VarCount: Integer;

    // --> Reports ForNAV Autogenerated code - do not delete or modify
    var
        [WithEvents]
        ReportForNav: DotNet ForNavReport51516966_v6_3_0_2259;
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
