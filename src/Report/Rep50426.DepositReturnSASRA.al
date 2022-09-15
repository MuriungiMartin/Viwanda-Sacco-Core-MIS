#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
dotnet // --> Reports ForNAV Autogenerated code - do not delete or modify
{
    assembly("ForNav.Reports.6.3.0.2259")
    {
        type(ForNav.Report_6_3_0_2259; ForNavReport51516426_v6_3_0_2259) { }
    }
} // Reports ForNAV Autogenerated code - do not delete or modify -->

Report 50426 "Deposit Return SASRA"
{
    RDLCLayout = 'Layouts/DepositReturnSASRA.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem(MembersAccounts; Vendor)
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "Date Filter", "No.";
            column(ReportForNavId_1102755000; 1102755000) { } // Autogenerated by ForNav - Do not delete
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
            column(Count1; COUNT1)
            {
            }
            column(Count2; COUNT2)
            {
            }
            column(Count3; COUNT3)
            {
            }
            column(Count4; COUNT4)
            {
            }
            column(Count5; COUNT5)
            {
            }
            column(Account1; ACOUNT1)
            {
            }
            column(Account2; ACOUNT2)
            {
            }
            column(Account3; ACOUNT3)
            {
            }
            column(Account4; ACOUNT4)
            {
            }
            column(Account5; ACOUNT5)
            {
            }
            column(Faccount1; FACOUNT1)
            {
            }
            column(Faccount2; FACOUNT2)
            {
            }
            column(Faccount3; FACOUNT3)
            {
            }
            column(Faccount4; FACOUNT4)
            {
            }
            column(Faccount5; FACOUNT5)
            {
            }
            column(Bal1; BAL1)
            {
            }
            column(Bal2; BAL2)
            {
            }
            column(Bal3; BAL3)
            {
            }
            column(Bal4; BAL4)
            {
            }
            column(Bal5; BAL5)
            {
            }
            column(Abal1; ABAL1)
            {
            }
            column(Abal2; ABAL2)
            {
            }
            column(Abal3; ABAL3)
            {
            }
            column(Abal4; ABAL4)
            {
            }
            column(Abal5; ABAL5)
            {
            }
            column(Fbal1; FABAL1)
            {
            }
            column(Fbal2; FABAL2)
            {
            }
            column(Fbal3; FABAL3)
            {
            }
            column(Fbal4; FABAL4)
            {
            }
            column(Fbal5; FABAL5)
            {
            }
            column(GrandCount; GRANDCOUNT)
            {
            }
            column(GrandTotal; GrandTotal)
            {
            }
            column(Sbal1; SBAL1)
            {
            }
            column(Sbal2; SBAL2)
            {
            }
            column(Sbal3; SBAL3)
            {
            }
            column(Sbal4; SBAL4)
            {
            }
            column(Sbal5; SBAL5)
            {
            }
            column(Sccount1; SACOUNT1)
            {
            }
            column(Sacount2; SACOUNT2)
            {
            }
            column(Sacount3; SACOUNT3)
            {
            }
            column(Sacount4; SACOUNT4)
            {
            }
            column(Sacount5; SACOUNT5)
            {
            }
            column(ASAT; Format(ASAT, 0, '<Day,2> <Month Text,3> <Year4>'))
            {
            }
            trigger OnPreDataItem();
            begin
                Company.Get;
                //Company.CALCFIELDS(Company.Picture);
                DFilter := '..' + GetFilter(MembersAccounts."Date Filter");
                FnRunWithdrawableAccounts;
                FnRunNonWithdrawableAccounts;
                FnRunTermDeposits;
                /*GrandTotal:=BAL1+BAL2+BAL3+BAL4+BAL5+ABAL1+ABAL2+ABAL3+ABAL4+ABAL5+FABAL1+FABAL2+FABAL3+FABAL4+FABAL5;
				GRANDCOUNT:=COUNT1+COUNT2+COUNT3+COUNT4+COUNT5+ACOUNT1+ACOUNT2+ACOUNT3+ACOUNT4+ACOUNT5+FACOUNT1+FACOUNT2+FACOUNT3+FACOUNT4+FACOUNT5;*/
                GrandTotal := BAL1 + BAL2 + BAL3 + BAL4 + BAL5 + ABAL1 + ABAL2 + ABAL3 + ABAL4 + ABAL5 + FABAL1 + FABAL2 + FABAL3 + FABAL4 + FABAL5 + SBAL1 + SBAL2 + SBAL3 + SBAL4 + SBAL5;
                GRANDCOUNT := COUNT1 + COUNT2 + COUNT3 + COUNT4 + COUNT5 + ACOUNT1 + ACOUNT2 + ACOUNT3 + ACOUNT4 + ACOUNT5 + FACOUNT1 + FACOUNT2 + FACOUNT3 + FACOUNT4 + FACOUNT5 + SACOUNT1 + SACOUNT2 + SACOUNT3 + SACOUNT4 + SACOUNT5;

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
                field(ASAT; ASAT)
                {
                    ApplicationArea = Basic;
                    Caption = 'As At..............';
                    Visible = false;
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
        Company.Get;
        //Company.CALCFIELDS(Company.Picture);
        ;
        ReportsForNavPre;
    end;

    var
        Less50000: Decimal;
        "50000 to 10000": Decimal;
        "10000 t0 300000": Decimal;
        "300000 to 100000": Decimal;
        "over 1000000": Decimal;
        Account: Record Vendor;
        "Less50000-a/c": Decimal;
        "50000 to 10000-a/c": Decimal;
        "10000 t0 300000-a/c": Decimal;
        "300000 to 100000-a/c": Decimal;
        "over 1000000-a/c": Decimal;
        cust: Record Customer;
        SHARES: Decimal;
        BAL1: Decimal;
        BAL2: Decimal;
        BAL3: Decimal;
        BAL4: Decimal;
        BAL5: Decimal;
        COUNT1: Integer;
        COUNT2: Integer;
        COUNT3: Integer;
        COUNT4: Integer;
        COUNT5: Integer;
        ABAL1: Decimal;
        ABAL2: Decimal;
        ABAL3: Decimal;
        ABAL4: Decimal;
        ABAL5: Decimal;
        ACOUNT1: Integer;
        ACOUNT2: Integer;
        ACOUNT3: Integer;
        ACOUNT4: Integer;
        ACOUNT5: Integer;
        Balance: Decimal;
        FABAL1: Decimal;
        FABAL2: Decimal;
        FABAL3: Decimal;
        FABAL4: Decimal;
        FABAL5: Decimal;
        FACOUNT1: Integer;
        FACOUNT2: Integer;
        FACOUNT3: Integer;
        FACOUNT4: Integer;
        FACOUNT5: Integer;
        Fbalance: Decimal;
        GrandTotal: Decimal;
        GRANDCOUNT: Integer;
        DFilter: Text[50];
        ASAT: Date;
        Company: Record "Company Information";
        vend: Record Vendor;
        Jaza: Decimal;
        SAYE: Decimal;
        SCH: Decimal;
        IDD: Decimal;
        XMAS: Decimal;
        Savings: Decimal;
        cnt: Decimal;
        SayeCount: Decimal;
        XmasCount: Decimal;
        IddCount: Decimal;
        DepositCount: Decimal;
        FosaCount: Decimal;
        SchCount: Decimal;
        SchoolFees: Decimal;
        SBAL1: Decimal;
        SBAL2: Decimal;
        SBAL3: Decimal;
        SBAL4: Decimal;
        SBAL5: Decimal;
        SACOUNT1: Integer;
        SACOUNT2: Integer;
        SACOUNT3: Integer;
        SACOUNT4: Integer;
        SACOUNT5: Integer;
        Group: Decimal;
        ObjMemberAccounts: Record Vendor;
        VarTextFilterWithdrawable: Text;

    local procedure FnRunTermDeposits()
    begin
        //================================================================================Member Term Accounts
        ObjMemberAccounts.CalcFields(ObjMemberAccounts.Balance);
        ObjMemberAccounts.Reset;
        ObjMemberAccounts.SetFilter(ObjMemberAccounts."Account Type", '%1', '503');
        ObjMemberAccounts.SetFilter(ObjMemberAccounts."Date Filter", DFilter);
        ObjMemberAccounts.SetFilter(ObjMemberAccounts.Balance, '<=%1&<>%2', 50000, 0);
        if ObjMemberAccounts.Find('-') then begin
            repeat
                ObjMemberAccounts.CalcFields(ObjMemberAccounts.Balance);
                Fbalance := ObjMemberAccounts.Balance;
                FABAL1 := FABAL1 + Fbalance;
            until ObjMemberAccounts.Next = 0;
            FACOUNT1 := ObjMemberAccounts.Count;
        end;
        ObjMemberAccounts.CalcFields(ObjMemberAccounts.Balance);
        ObjMemberAccounts.Reset;
        ObjMemberAccounts.SetFilter(ObjMemberAccounts."Account Type", '%1', '503');
        ObjMemberAccounts.SetFilter(ObjMemberAccounts."Date Filter", DFilter);
        ObjMemberAccounts.SetFilter(ObjMemberAccounts.Balance, '>%1&<=%2', 50000, 100000);
        if ObjMemberAccounts.Find('-') then begin
            repeat
                ObjMemberAccounts.CalcFields(ObjMemberAccounts.Balance);
                Fbalance := ObjMemberAccounts.Balance;
                FABAL2 := FABAL2 + Fbalance;
            until ObjMemberAccounts.Next = 0;
            FACOUNT2 := ObjMemberAccounts.Count;
        end;
        ObjMemberAccounts.CalcFields(ObjMemberAccounts.Balance);
        ObjMemberAccounts.Reset;
        ObjMemberAccounts.SetFilter(ObjMemberAccounts."Account Type", '%1', '503');
        ObjMemberAccounts.SetFilter(ObjMemberAccounts."Date Filter", DFilter);
        ObjMemberAccounts.SetFilter(ObjMemberAccounts.Balance, '>%1&<=%2', 100000, 300000);
        if ObjMemberAccounts.Find('-') then begin
            repeat
                ObjMemberAccounts.CalcFields(ObjMemberAccounts.Balance);
                Fbalance := ObjMemberAccounts.Balance;
                FABAL3 := FABAL3 + Fbalance;
            until ObjMemberAccounts.Next = 0;
            FACOUNT3 := ObjMemberAccounts.Count;
        end;
        ObjMemberAccounts.CalcFields(ObjMemberAccounts.Balance);
        ObjMemberAccounts.Reset;
        ObjMemberAccounts.SetFilter(ObjMemberAccounts."Account Type", '%1', '503');
        ObjMemberAccounts.SetFilter(ObjMemberAccounts."Date Filter", DFilter);
        ObjMemberAccounts.SetFilter(ObjMemberAccounts.Balance, '>%1&<=%2', 300000, 1000000);
        if ObjMemberAccounts.Find('-') then begin
            repeat
                ObjMemberAccounts.CalcFields(ObjMemberAccounts.Balance);
                Fbalance := ObjMemberAccounts.Balance;
                FABAL4 := FABAL4 + Fbalance;
            until ObjMemberAccounts.Next = 0;
            FACOUNT4 := ObjMemberAccounts.Count;
        end;
        ObjMemberAccounts.CalcFields(ObjMemberAccounts.Balance);
        ObjMemberAccounts.Reset;
        ObjMemberAccounts.SetFilter(ObjMemberAccounts."Account Type", '%1', '503');
        ObjMemberAccounts.SetFilter(ObjMemberAccounts."Date Filter", DFilter);
        ObjMemberAccounts.SetFilter(ObjMemberAccounts.Balance, '>%1', 1000000);
        if ObjMemberAccounts.Find('-') then begin
            repeat
                ObjMemberAccounts.CalcFields(ObjMemberAccounts.Balance);
                Fbalance := ObjMemberAccounts.Balance;
                FABAL5 := FABAL5 + Fbalance;
            until ObjMemberAccounts.Next = 0;
            FACOUNT5 := ObjMemberAccounts.Count;
        end;
        //================================================================================End Member Term Accounts
    end;

    local procedure FnRunWithdrawableAccounts()
    begin
        //================================================================================Member Withdrawable Accounts
        VarTextFilterWithdrawable := '401|402|403|404|405|501|502|504|505|507|508|509|506';
        ObjMemberAccounts.CalcFields(ObjMemberAccounts.Balance);
        ObjMemberAccounts.Reset;
        ObjMemberAccounts.SetFilter(ObjMemberAccounts."Account Type", VarTextFilterWithdrawable);
        ObjMemberAccounts.SetFilter(ObjMemberAccounts."Date Filter", DFilter);
        ObjMemberAccounts.SetFilter(ObjMemberAccounts.Balance, '<=%1&<>%2', 50000, 0);
        if ObjMemberAccounts.Find('-') then begin
            repeat
                ObjMemberAccounts.CalcFields(ObjMemberAccounts.Balance);
                Balance := ObjMemberAccounts.Balance;
                ABAL1 := ABAL1 + Balance;
            until ObjMemberAccounts.Next = 0;
            ACOUNT1 := ObjMemberAccounts.Count;
        end;
        ObjMemberAccounts.CalcFields(ObjMemberAccounts.Balance);
        ObjMemberAccounts.Reset;
        ObjMemberAccounts.SetFilter(ObjMemberAccounts."Account Type", VarTextFilterWithdrawable);
        ObjMemberAccounts.SetFilter(ObjMemberAccounts."Date Filter", DFilter);
        ObjMemberAccounts.SetFilter(ObjMemberAccounts.Balance, '>%1&<=%2', 50000, 100000);
        if ObjMemberAccounts.Find('-') then begin
            repeat
                ObjMemberAccounts.CalcFields(ObjMemberAccounts.Balance);
                Balance := ObjMemberAccounts.Balance;
                ABAL2 := ABAL2 + Balance;
            until ObjMemberAccounts.Next = 0;
            ACOUNT2 := ObjMemberAccounts.Count;
        end;
        ObjMemberAccounts.CalcFields(ObjMemberAccounts.Balance);
        ObjMemberAccounts.Reset;
        ObjMemberAccounts.SetFilter(ObjMemberAccounts."Account Type", VarTextFilterWithdrawable);
        ObjMemberAccounts.SetFilter(ObjMemberAccounts."Date Filter", DFilter);
        ObjMemberAccounts.SetFilter(ObjMemberAccounts.Balance, '>%1&<=%2', 100000, 300000);
        if ObjMemberAccounts.Find('-') then begin
            repeat
                ObjMemberAccounts.CalcFields(ObjMemberAccounts.Balance);
                Balance := ObjMemberAccounts.Balance;
                ABAL3 := ABAL3 + Balance;
            until ObjMemberAccounts.Next = 0;
            ACOUNT3 := ObjMemberAccounts.Count;
        end;
        ObjMemberAccounts.CalcFields(ObjMemberAccounts.Balance);
        ObjMemberAccounts.Reset;
        ObjMemberAccounts.SetFilter(ObjMemberAccounts."Account Type", VarTextFilterWithdrawable);
        ObjMemberAccounts.SetFilter(ObjMemberAccounts."Date Filter", DFilter);
        ObjMemberAccounts.SetFilter(ObjMemberAccounts.Balance, '>%1&<=%2', 300000, 1000000);
        if ObjMemberAccounts.Find('-') then begin
            repeat
                ObjMemberAccounts.CalcFields(ObjMemberAccounts.Balance);
                Balance := ObjMemberAccounts.Balance;
                ABAL4 := ABAL4 + Balance;
            until ObjMemberAccounts.Next = 0;
            ACOUNT4 := ObjMemberAccounts.Count;
        end;
        ObjMemberAccounts.CalcFields(ObjMemberAccounts.Balance);
        ObjMemberAccounts.Reset;
        ObjMemberAccounts.SetFilter(ObjMemberAccounts."Account Type", VarTextFilterWithdrawable);
        ObjMemberAccounts.SetFilter(ObjMemberAccounts."Date Filter", DFilter);
        ObjMemberAccounts.SetFilter(ObjMemberAccounts.Balance, '>%1', 1000000);
        if ObjMemberAccounts.Find('-') then begin
            repeat
                ObjMemberAccounts.CalcFields(ObjMemberAccounts.Balance);
                Balance := ObjMemberAccounts.Balance;
                ABAL5 := ABAL5 + Balance;
            until ObjMemberAccounts.Next = 0;
            ACOUNT5 := ObjMemberAccounts.Count;
        end;
        //================================================================================End Member Withdrawable Accounts
    end;

    local procedure FnRunNonWithdrawableAccounts()
    begin
        //================================================================================Member Non Withdrawable Accounts
        ObjMemberAccounts.CalcFields(ObjMemberAccounts.Balance);
        ObjMemberAccounts.Reset;
        ObjMemberAccounts.SetFilter(ObjMemberAccounts."Account Type", '%1|%2', '602', '603');
        ObjMemberAccounts.SetFilter(ObjMemberAccounts."Date Filter", DFilter);
        ObjMemberAccounts.SetFilter(ObjMemberAccounts.Balance, '<=%1&<>%2', 50000, 0);
        if ObjMemberAccounts.Find('-') then begin
            repeat
                ObjMemberAccounts.CalcFields(ObjMemberAccounts.Balance);
                SHARES := ObjMemberAccounts.Balance;
                BAL1 := BAL1 + SHARES;
            until ObjMemberAccounts.Next = 0;
            COUNT1 := ObjMemberAccounts.Count;
        end;
        ObjMemberAccounts.CalcFields(ObjMemberAccounts.Balance);
        ObjMemberAccounts.Reset;
        ObjMemberAccounts.SetFilter(ObjMemberAccounts."Account Type", '%1|%2', '602', '603');
        ObjMemberAccounts.SetFilter(ObjMemberAccounts."Date Filter", DFilter);
        ObjMemberAccounts.SetFilter(ObjMemberAccounts.Balance, '>%1&<=%2', 50000, 100000);
        if ObjMemberAccounts.Find('-') then begin
            repeat
                ObjMemberAccounts.CalcFields(ObjMemberAccounts.Balance);
                SHARES := ObjMemberAccounts.Balance;
                BAL2 := BAL2 + SHARES;
            until ObjMemberAccounts.Next = 0;
            COUNT2 := ObjMemberAccounts.Count;
        end;
        ObjMemberAccounts.CalcFields(ObjMemberAccounts.Balance);
        ObjMemberAccounts.Reset;
        ObjMemberAccounts.SetFilter(ObjMemberAccounts."Account Type", '%1|%2', '602', '603');
        ObjMemberAccounts.SetFilter(ObjMemberAccounts."Date Filter", DFilter);
        ObjMemberAccounts.SetFilter(ObjMemberAccounts.Balance, '>%1&<=%2', 100000, 300000);
        if ObjMemberAccounts.Find('-') then begin
            repeat
                ObjMemberAccounts.CalcFields(ObjMemberAccounts.Balance);
                SHARES := ObjMemberAccounts.Balance;
                BAL3 := BAL3 + SHARES;
            until ObjMemberAccounts.Next = 0;
            COUNT3 := ObjMemberAccounts.Count;
        end;
        ObjMemberAccounts.CalcFields(ObjMemberAccounts.Balance);
        ObjMemberAccounts.Reset;
        ObjMemberAccounts.SetFilter(ObjMemberAccounts."Account Type", '%1|%2', '602', '603');
        ObjMemberAccounts.SetFilter(ObjMemberAccounts."Date Filter", DFilter);
        ObjMemberAccounts.SetFilter(ObjMemberAccounts.Balance, '>%1&<=%2', 300000, 1000000);
        if ObjMemberAccounts.Find('-') then begin
            repeat
                ObjMemberAccounts.CalcFields(ObjMemberAccounts.Balance);
                SHARES := ObjMemberAccounts.Balance;
                BAL4 := BAL4 + SHARES;
            until ObjMemberAccounts.Next = 0;
            COUNT4 := ObjMemberAccounts.Count;
        end;
        ObjMemberAccounts.CalcFields(ObjMemberAccounts.Balance);
        ObjMemberAccounts.Reset;
        ObjMemberAccounts.SetFilter(ObjMemberAccounts."Account Type", '%1|%2', '602', '603');
        ObjMemberAccounts.SetFilter(ObjMemberAccounts."Date Filter", DFilter);
        ObjMemberAccounts.SetFilter(ObjMemberAccounts.Balance, '>%1', 1000000);
        if ObjMemberAccounts.Find('-') then begin
            repeat
                ObjMemberAccounts.CalcFields(ObjMemberAccounts.Balance);
                SHARES := ObjMemberAccounts.Balance;
                BAL5 := BAL5 + SHARES;
            until ObjMemberAccounts.Next = 0;
            COUNT5 := ObjMemberAccounts.Count;
        end;
        //================================================================================End Non Withdrawable
    end;

    // --> Reports ForNAV Autogenerated code - do not delete or modify
    var
        [WithEvents]
        ReportForNav: DotNet ForNavReport51516426_v6_3_0_2259;
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
