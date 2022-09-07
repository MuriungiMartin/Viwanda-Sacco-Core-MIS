#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
dotnet // --> Reports ForNAV Autogenerated code - do not delete or modify
{
    assembly("ForNav.Reports.6.3.0.2259")
    {
        type(ForNav.Report_6_3_0_2259; ForNavReport51516006_v6_3_0_2259) { }
    }
} // Reports ForNAV Autogenerated code - do not delete or modify -->

Report 50006 "Cheque Book Applications"
{
    RDLCLayout = 'Layouts/ChequeBookApplications.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Cheque Book Application"; "Cheque Book Application")
        {
            RequestFilterFields = "Account No.", "Cheque Book Ordered", "Ordered On", "Cheque Book Received", "Received On";
            column(ReportForNavId_1; 1) { } // Autogenerated by ForNav - Do not delete
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
            column(EntryNo; EntryNo)
            {
            }
            column(No_ChequeBookApplication; "Cheque Book Application"."No.")
            {
            }
            column(AccountNo_ChequeBookApplication; "Cheque Book Application"."Account No.")
            {
            }
            column(Name_ChequeBookApplication; "Cheque Book Application".Name)
            {
            }
            column(IDNo_ChequeBookApplication; "Cheque Book Application"."ID No.")
            {
            }
            column(ApplicationDate_ChequeBookApplication; Format("Cheque Book Application"."Application Date", 0, '<Day,2> <Month Text,3> <Year4>'))
            {
            }
            column(ChequeAccountNo_ChequeBookApplication; "Cheque Book Application"."Cheque Book Account No.")
            {
            }
            column(MemberNo_ChequeBookApplication; "Cheque Book Application"."Member No.")
            {
            }
            column(ResponsibilityCentre_ChequeBookApplication; "Cheque Book Application"."Responsibility Centre")
            {
            }
            column(BeginingChequeNo_ChequeBookApplication; "Cheque Book Application"."Begining Cheque No.")
            {
            }
            column(EndChequeNo_ChequeBookApplication; "Cheque Book Application"."End Cheque No.")
            {
            }
            column(ChequeRegisterGenerated_ChequeBookApplication; "Cheque Book Application"."Cheque Register Generated")
            {
            }
            column(Select_ChequeBookApplication; "Cheque Book Application".Select)
            {
            }
            column(ChequeBookchargesPosted_ChequeBookApplication; "Cheque Book Application"."Cheque Book charges Posted")
            {
            }
            column(ChequeBookType_ChequeBookApplication; "Cheque Book Application"."Cheque Book Type")
            {
            }
            column(Status_ChequeBookApplication; "Cheque Book Application".Status)
            {
            }
            column(Lastcheck_ChequeBookApplication; "Cheque Book Application"."Last check")
            {
            }
            column(RequestedBy_ChequeBookApplication; "Cheque Book Application"."Requested By")
            {
            }
            column(ChequeBookFeeCharged_ChequeBookApplication; "Cheque Book Application"."Cheque Book Fee Charged")
            {
            }
            column(ChequeBookFeeChargedOn_ChequeBookApplication; Format("Cheque Book Application"."Cheque Book Fee Charged On", 0, '<Day,2> <Month Text,3> <Year4>'))
            {
            }
            column(ChequeBookFeeChargedBy_ChequeBookApplication; "Cheque Book Application"."Cheque Book Fee Charged By")
            {
            }
            column(ChequeBookOrdered_ChequeBookApplication; "Cheque Book Application"."Cheque Book Ordered")
            {
            }
            column(OrderedBy_ChequeBookApplication; "Cheque Book Application"."Ordered By")
            {
            }
            column(OrderedOn_ChequeBookApplication; Format("Cheque Book Application"."Ordered On", 0, '<Day,2> <Month Text,3> <Year4>'))
            {
            }
            column(ChequeBookReceived_ChequeBookApplication; "Cheque Book Application"."Cheque Book Received")
            {
            }
            column(ReceivedBy_ChequeBookApplication; "Cheque Book Application"."Received By")
            {
            }
            column(ReceivedOn_ChequeBookApplication; Format("Cheque Book Application"."Received On", 0, '<Day,2> <Month Text,3> <Year4>'))
            {
            }
            column(ListedForDestruction_ChequeBookApplication; "Cheque Book Application"."Listed For Destruction")
            {
            }
            column(Destroyed_ChequeBookApplication; "Cheque Book Application".Destroyed)
            {
            }
            column(DestroyedOn_ChequeBookApplication; Format("Cheque Book Application"."Destroyed On", 0, '<Day,2> <Month Text,3> <Year4>'))
            {
            }
            column(DestroyedBy_ChequeBookApplication; "Cheque Book Application"."Destroyed By")
            {
            }
            column(Collected_ChequeBookApplication; "Cheque Book Application".Collected)
            {
            }
            column(DateCollected_ChequeBookApplication; Format("Cheque Book Application"."Date Collected", 0, '<Day,2> <Month Text,3> <Year4>'))
            {
            }
            column(CardIssuedBy_ChequeBookApplication; "Cheque Book Application"."Card Issued By")
            {
            }
            column(Issuedto_ChequeBookApplication; "Cheque Book Application"."Issued to")
            {
            }
            column(BranchCode_ChequeBookApplication; "Cheque Book Application"."Branch Code")
            {
            }
            column(DateIssued_ChequeBookApplication; Format("Cheque Book Application"."Date Issued", 0, '<Day,2> <Month Text,3> <Year4>'))
            {
            }
            column(AccountType; AccountType)
            {
            }
            column(IssuedBy_ChequeBookApplication; "Cheque Book Application"."Issued By")
            {
            }
            trigger OnAfterGetRecord();
            begin
                EntryNo := EntryNo + 1;
                if ObjAccounts.Get("Account No.") then begin
                    if ObjAccountTypes.Get(ObjAccounts."Account Type") then begin
                        AccountType := ObjAccountTypes.Description;
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
        Company.Get();
        Company.CalcFields(Company.Picture);
        ;
        ReportsForNavPre;
    end;

    var
        Company: Record "Company Information";
        EntryNo: Integer;
        ObjAccounts: Record Vendor;
        AccountType: Code[30];
        ObjAccountTypes: Record "Account Types-Saving Products";

    // --> Reports ForNAV Autogenerated code - do not delete or modify
    var
        [WithEvents]
        ReportForNav: DotNet ForNavReport51516006_v6_3_0_2259;
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
