#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
dotnet // --> Reports ForNAV Autogenerated code - do not delete or modify
{
    assembly("ForNav.Reports.6.3.0.2259")
    {
        type(ForNav.Report_6_3_0_2259; ForNavReport51516851_v6_3_0_2259) { }
    }
} // Reports ForNAV Autogenerated code - do not delete or modify -->

Report 50851 "Micro Finance Transactions"
{
    RDLCLayout = 'Layouts/MicroFinanceTransactions.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem(Micro_Fin_Schedule; Micro_Fin_Schedule)
        {
            column(ReportForNavId_1102755000; 1102755000) { } // Autogenerated by ForNav - Do not delete
            column(Account_No; Micro_Fin_Schedule."Account Number")
            {
            }
            column(Account_Name; Micro_Fin_Schedule."Account Name")
            {
            }
            column(Loan_No; Micro_Fin_Schedule."Loan No.")
            {
            }
            column(Expected_Principle; Micro_Fin_Schedule."Expected Principle Amount")
            {
            }
            column(Expected_Interest; Micro_Fin_Schedule."Expected Interest")
            {
            }
            column(Savings; Micro_Fin_Schedule.Savings)
            {
            }
            column(Loan_Balance; ToustLoan)
            {
            }
            column(Group_Name; GrpName)
            {
            }
            column(Group_Code; Micro_Fin_Schedule."Group Code")
            {
            }
            column(Company_Name; CompanyInfo.Name)
            {
            }
            column(Company_Picture; CompanyInfo.Picture)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(CurrReport_PAGENO; Format(ReportForNav.PageNo))
            {
            }
            column(UserId; UserId)
            {
            }
            column(Trans_No; Micro_Fin_Schedule."No.")
            {
            }
            column(Total_Savings; Tsaving)
            {
            }
            column(Amount; Micro_Fin_Schedule.Amount)
            {
            }
            column(Interest_Amount; Micro_Fin_Schedule."Interest Amount")
            {
            }
            column(Principle_Amount; Micro_Fin_Schedule."Principle Amount")
            {
            }
            column(Saving; Saving)
            {
            }
            trigger OnPreDataItem();
            begin
                LastFieldNo := FieldNo("No.");
                CompanyInfo.Get();
                CompanyInfo.CalcFields(CompanyInfo.Picture);
            end;

            trigger OnAfterGetRecord();
            begin
                GroupMembers.Reset;
                GroupMembers.SetRange(GroupMembers."Group Code", "Group Code");
                if GroupMembers.Find('-') then begin
                    GroupMembers.CalcFields(GroupMembers."Balance (LCY)");
                    SAVINGS2 := GroupMembers."Balance (LCY)";
                end;
                "Outstanding Loan" := 0;
                ToustLoan := 0;
                vend.Reset;
                vend.SetRange(vend."No.", Micro_Fin_Schedule."Account Number");
                if vend.Find('-') then begin
                    if vend.Blocked = vend.Blocked::All then begin
                        CurrReport.Skip;
                    end;
                    vend.CalcFields(vend."Balance (LCY)");
                    Saving := vend."Balance (LCY)";
                    Tsavings := Tsavings + Saving;
                end;
                LoanApplic.Reset;
                LoanApplic.SetRange(LoanApplic."Client Code", Micro_Fin_Schedule."Account Number");
                LoanApplic.SetRange(LoanApplic.Source, LoanApplic.Source::FOSA);
                if LoanApplic.Find('-') then begin
                    repeat
                        LoanApplic.CalcFields(LoanApplic."Outstanding Balance", LoanApplic."Outstanding Interest");
                        if LoanApplic."Outstanding Balance" <> 0 then begin
                            "Outstanding Loan" := LoanApplic."Outstanding Balance";//+LoanApplic."Oustanding Interest";
                            ToustLoan := ToustLoan + "Outstanding Loan";
                        end;
                    until LoanApplic.Next = 0;
                end;
                Tsaving := Tsaving + Saving;
                //Get group name
                Grps.Reset;
                if Grps.Get(Micro_Fin_Schedule."Group Code") then
                    GrpName := Grps.Name;
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
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        "Outstanding Loan": Decimal;
        Saving: Decimal;
        LoanApplic: Record "Loans Register";
        vend: Record Vendor;
        Tsaving: Decimal;
        ToustLoan: Decimal;
        Tsavings: Decimal;
        GrpName: Text[100];
        Grps: Record Vendor;
        Loans: Record "Loans Register";
        Outbal: Decimal;
        OutInt: Decimal;
        MicroSubform: Record Micro_Fin_Schedule;
        GroupMembers: Record Vendor;
        SAVINGS2: Decimal;
        CompanyInfo: Record "Company Information";

    // --> Reports ForNAV Autogenerated code - do not delete or modify
    var
        [WithEvents]
        ReportForNav: DotNet ForNavReport51516851_v6_3_0_2259;
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
