#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
dotnet // --> Reports ForNAV Autogenerated code - do not delete or modify
{
    assembly("ForNav.Reports.6.3.0.2259")
    {
        type(ForNav.Report_6_3_0_2259; ForNavReport51516206_v6_3_0_2259) { }
    }
} // Reports ForNAV Autogenerated code - do not delete or modify -->

Report 50206 "Accounts Listed CRB Report"
{
    RDLCLayout = 'Layouts/AccountsListedCRBReport.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("CRB Notice Register"; "CRB Notice Register")
        {
            DataItemTableView = where("CRB Listed" = const(true));
            column(ReportForNavId_1; 1) { } // Autogenerated by ForNav - Do not delete
            column(Company_Name; Company.Name)
            {
            }
            column(Company_Address; Company.Address)
            {
            }
            column(Company_City; Company.City)
            {
            }
            column(Company_Picture; Company.Picture)
            {
            }
            column(Company_Email; Company."E-Mail")
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
            column(SN; SN)
            {
            }
            column(PrincipleOutstanding_CRBNoticeRegister; "CRB Notice Register"."Principle Outstanding")
            {
            }
            column(ListedBy_CRBNoticeRegister; "CRB Notice Register"."Listed By")
            {
            }
            column(DateListed_CRBNoticeRegister; "CRB Notice Register"."Date Listed")
            {
            }
            column(DateOfNotice_CRBNoticeRegister; "CRB Notice Register"."Date Of Notice")
            {
            }
            column(LoanNo_CRBNoticeRegister; "CRB Notice Register"."Loan No")
            {
            }
            column(DaysInArrears_CRBNoticeRegister; "CRB Notice Register"."Days In Arrears")
            {
            }
            column(AmountInArrears_CRBNoticeRegister; "CRB Notice Register"."Amount In Arrears")
            {
            }
            column(ApprovedAmount_CRBNoticeRegister; "CRB Notice Register"."Approved Amount")
            {
            }
            column(LoanProductName_CRBNoticeRegister; "CRB Notice Register"."Loan Product Name")
            {
            }
            column(LoanProductType_CRBNoticeRegister; "CRB Notice Register"."Loan Product Type")
            {
            }
            column(MemberName_CRBNoticeRegister; "CRB Notice Register"."Member Name")
            {
            }
            column(MemberNo_CRBNoticeRegister; "CRB Notice Register"."Member No")
            {
            }
            dataitem("Loan Collateral Details"; "Loan Collateral Details")
            {
                DataItemLink = "Loan No" = field("Loan No");
                column(ReportForNavId_13; 13) { } // Autogenerated by ForNav - Do not delete
                column(CollateralRegisteDoc_LoanCollateralDetails; "Loan Collateral Details"."Collateral Registe Doc")
                {
                }
                column(GuaranteeValue_LoanCollateralDetails; "Loan Collateral Details"."Guarantee Value")
                {
                }
                column(SecurityDetails_LoanCollateralDetails; "Loan Collateral Details"."Security Details")
                {
                }
                column(Code_LoanCollateralDetails; "Loan Collateral Details".Code)
                {
                }
                dataitem("Loans Register"; "Loans Register")
                {
                    DataItemLink = "Loan  No." = field("Loan No");
                    column(ReportForNavId_20; 20) { } // Autogenerated by ForNav - Do not delete
                    column(Rescheduled_LoansRegister; "Loans Register".Rescheduled)
                    {
                    }
                    column(LastRepaymentDate_LoansRegister; "Loans Register"."Last Repayment Date")
                    {
                    }
                }
            }
            trigger OnPreDataItem();
            begin
                Company.Get();
                Company.CalcFields(Picture);
            end;

            trigger OnAfterGetRecord();
            begin
                SN := SN + 1;
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
        Company: Record "Company Information";
        SN: Integer;

    // --> Reports ForNAV Autogenerated code - do not delete or modify
    var
        [WithEvents]
        ReportForNav: DotNet ForNavReport51516206_v6_3_0_2259;
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
