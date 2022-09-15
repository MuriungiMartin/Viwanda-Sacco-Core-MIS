#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
dotnet // --> Reports ForNAV Autogenerated code - do not delete or modify
{
    assembly("ForNav.Reports.6.3.0.2259")
    {
        type(ForNav.Report_6_3_0_2259; ForNavReport51516423_v6_3_0_2259) { }
    }
} // Reports ForNAV Autogenerated code - do not delete or modify -->

Report 50423 "Recover Defaulted Loan -Guaran"
{
    RDLCLayout = 'Layouts/RecoverDefaultedLoan-Guaran.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem(Loans; "Loans Register")
        {
            PrintOnlyIfDetail = false;
            RequestFilterFields = "Loan  No.", "Client Code", "Loan Product Type";
            column(ReportForNavId_4645; 4645) { } // Autogenerated by ForNav - Do not delete
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(Company_Address; Company.Address)
            {
            }
            column(Company_Address2; Company."Address 2")
            {
            }
            column(Company_PhoneNo; Company."Phone No.")
            {
            }
            column(Company_Email; Company."E-Mail")
            {
            }
            column(Company_Picture; Company.Picture)
            {
            }
            column(CurrReport_PAGENO; Format(ReportForNav.PageNo))
            {
            }
            column(UserId; UserId)
            {
            }
            trigger OnPreDataItem();
            begin
                LastFieldNo := FieldNo("Loan  No.");
            end;

            trigger OnAfterGetRecord();
            begin
                LoanGuar.Reset;
                LoanGuar.SetRange(LoanGuar."Loan No", Loans."Loan  No.");
                if LoanGuar.Find('-') then begin
                    LoanGuar.Reset;
                    LoanGuar.SetRange(LoanGuar."Loan No", Loans."Loan  No.");
                    repeat
                        TGrAmount := TGrAmount + GrAmount;
                        GrAmount := LoanGuar."Amont Guaranteed";
                        //LoanGuar."Amount Guarnted";
                        FGrAmount := TGrAmount + LoanGuar."Amont Guaranteed";
                    until LoanGuar.Next = 0;
                end;
                //Defaulter loan clear
                Loans.CalcFields(Loans."Outstanding Balance", Loans."Interest Due");
                Lbal := ROUND(Loans."Outstanding Balance", 1, '=');
                if Loans."Interest Due" > 0 then begin
                    INTBAL := ROUND(Loans."Interest Due", 1, '=');
                    COMM := ROUND((Loans."Interest Due" * 0.5), 1, '=');
                    Loans."Attached Amount" := Lbal;
                    Loans.PenaltyAttached := COMM;
                    Loans.InDueAttached := INTBAL;
                    Modify;
                end;
                Attached := true;
                Message('BALANCE %1', Lbal);
                GenJournalLine."Line No." := GenJournalLine."Line No." + 1000;
                GenJournalLine.Init;
                GenJournalLine."Journal Template Name" := 'general';
                GenJournalLine."Journal Batch Name" := 'LNAttach';
                GenJournalLine."Document No." := Loans."Loan  No.";
                GenJournalLine."External Document No." := Loanapp."Loan  No.";
                GenJournalLine."Line No." := GenJournalLine."Line No." + 900;
                GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Interest Paid";
                GenJournalLine."Account Type" := GenJournalLine."account type"::Member;
                GenJournalLine."Account No." := "Client Code";
                //GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                GenJournalLine."Posting Date" := Today;
                GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                //GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                GenJournalLine.Description := 'Def Loan' + "Client Code";
                GenJournalLine.Amount := -Lbal;
                GenJournalLine.Validate(GenJournalLine.Amount);
                GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                GenJournalLine."Loan No" := Loans."Loan  No.";
                if GenJournalLine.Amount <> 0 then
                    GenJournalLine.Insert;
                "LN Doc" := Loans."Loan  No.";
                // int due
                GenJournalLine."Line No." := GenJournalLine."Line No." + 1000;
                GenJournalLine.Init;
                GenJournalLine."Journal Template Name" := 'general';
                GenJournalLine."Journal Batch Name" := 'LNAttach';
                GenJournalLine."Document No." := Loans."Loan  No.";
                GenJournalLine."External Document No." := Loanapp."Loan  No.";
                GenJournalLine."Line No." := GenJournalLine."Line No." + 900;
                GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Insurance Contribution";
                GenJournalLine."Account Type" := GenJournalLine."account type"::Member;
                GenJournalLine."Account No." := "Client Code";
                //GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                GenJournalLine."Posting Date" := Today;
                GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                //GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                GenJournalLine.Description := 'Defaulted Loan int' + ' ';
                GenJournalLine.Amount := -INTBAL;
                GenJournalLine.Validate(GenJournalLine.Amount);
                GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                GenJournalLine."Loan No" := Loans."Loan  No.";
                if GenJournalLine.Amount <> 0 then
                    GenJournalLine.Insert;
                //commisision
                GenJournalLine."Line No." := GenJournalLine."Line No." + 1000;
                GenJournalLine.Init;
                GenJournalLine."Journal Template Name" := 'general';
                GenJournalLine."Journal Batch Name" := 'LNAttach';
                GenJournalLine."Document No." := Loans."Loan  No.";
                GenJournalLine."External Document No." := Loanapp."Loan  No.";
                GenJournalLine."Line No." := GenJournalLine."Line No." + 900;
                //GenJournalLine."Transaction Type":=GenJournalLine."Transaction Type"::"Interest Paid";
                GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                GenJournalLine."Account No." := '100004';
                //GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                GenJournalLine."Posting Date" := Today;
                GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                //GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                GenJournalLine.Description := 'Penalty' + ' ';
                GenJournalLine.Amount := -COMM;
                GenJournalLine.Validate(GenJournalLine.Amount);
                GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                //GenJournalLine."Bal. Account No.":=" ";
                GenJournalLine."Loan No" := Loans."Loan  No.";
                if GenJournalLine.Amount <> 0 then
                    GenJournalLine.Insert;
                LoanGuar.Reset;
                LoanGuar.SetRange(LoanGuar."Loan No", Loans."Loan  No.");
                if LoanGuar.Find('-') then begin
                    LoanGuar.Reset;
                    LoanGuar.SetRange(LoanGuar."Loan No", Loans."Loan  No.");
                    DLN := 'DLN';
                    repeat
                        Loans.Reset;
                        Loans.SetRange(Loans."Client Code", LoanGuar."Member No");
                        Loans.SetRange(Loans."Loan Product Type", 'DEFAULTER');
                        Loans.SetRange(Loans.Posted, false);
                        if Loans.Find('-') then begin
                            Loans.CalcFields(Loans."Outstanding Balance");
                            if Loans."Outstanding Balance" = 0 then
                                Loans.DeleteAll;
                        end;
                        GenSetUp.Get();
                        GenSetUp."Defaulter LN" := GenSetUp."Defaulter LN" + 10;
                        GenSetUp.Modify;
                        DLN := 'DLN' + Format(GenSetUp."Defaulter LN");
                        TGrAmount := TGrAmount + GrAmount;
                        GrAmount := LoanGuar."Amont Guaranteed";
                        //LoanGuar."Amount Guarnted";
                        Message('guarnteed Amount %1', FGrAmount);
                        //REPEAT
                        ////Insert jnl lines
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := 'general';
                        GenJournalLine."Journal Batch Name" := 'LNAttach';
                        GenJournalLine."Document No." := "LN Doc";
                        GenJournalLine."External Document No." := "LN Doc";
                        GenJournalLine."Line No." := GenJournalLine."Line No." + 1000;
                        GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Share Capital";
                        GenJournalLine."Account Type" := GenJournalLine."account type"::Member;
                        GenJournalLine."Account No." := LoanGuar."Member No";
                        //GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                        GenJournalLine."Posting Date" := Today;
                        GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                        //GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                        GenJournalLine.Description := 'Defaulted Loan' + ' ';
                        GenJournalLine.Amount := ((GrAmount / FGrAmount) * (Lbal + INTBAL + COMM));
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                        GenJournalLine."Loan No" := DLN;
                        /*Loans.RESET;
                        Loans.SETRANGE(Loans."Loan Product Type",'DEFAULTER');
                        Loans.SETRANGE(Loans."Client Code",LoanGuar."Member No");
                        IF FIND('-') THEN BEGIN
                        GenJournalLine."Loan No":=DLN;
                        //Loans."Loan  No.";
                        END;*/
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;
                        if loanTypes.Get("Loan Product Type") then begin
                            Loans.Init;
                            Loans."Loan  No." := DLN;
                            Loans."Client Code" := LoanGuar."Member No";
                            Loans."Loan Product Type" := 'DEFAULTER';
                            Loans."Loan Status" := Loans."loan status"::Closed;
                            cust.Reset;
                            cust.SetRange(cust."No.", LoanGuar."Member No");
                            if cust.Find('-') then begin
                                Loans."Client Name" := cust.Name;
                            end;
                            Loans."Application Date" := Today;
                            Loans."Issued Date" := Today;
                            Loans.Installments := loanTypes."No of Installment";
                            Loans.Repayment := ((GrAmount / FGrAmount) * (Lbal + INTBAL + COMM)) / loanTypes."No of Installment";
                            Loans."Requested Amount" := ((GrAmount / FGrAmount) * (Lbal + INTBAL + COMM));
                            Loans."Approved Amount" := ((GrAmount / FGrAmount) * (Lbal + INTBAL + COMM));
                            Loans.Posted := true;
                            Loans."Advice Date" := Today;
                            Loans.Insert;
                        end;
                    until LoanGuar.Next = 0;
                end;
                /*
				//Post New
				GenJournalLine.RESET;
				GenJournalLine.SETRANGE("Journal Template Name",'GENERAL');
				GenJournalLine.SETRANGE("Journal Batch Name",'LNAttach');
				IF GenJournalLine.FIND('-') THEN BEGIN
				CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post B",GenJournalLine);
				END;
				MESSAGE('Loan recovery from guarantors posted successfully.');
				*/
                Loans.Posted := true;
                Loans."Attachement Date" := Today;
                Modify;

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
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        PDate: Date;
        Interest: Decimal;
        GenSetUp: Record "Sacco General Set-Up";
        TextDateFormula2: Text[30];
        TextDateFormula1: Text[30];
        DateFormula2: DateFormula;
        DateFormula1: DateFormula;
        Vend: Record Vendor;
        LoanGuar: Record "Loans Guarantee Details";
        Lbal: Decimal;
        cust: Record Customer;
        GenJournalLine: Record "Gen. Journal Line";
        GenLedgerSetup: Record "General Ledger Setup";
        Hesabu: Integer;
        Loanapp: Record "Loans Register";
        "Loan&int": Decimal;
        TotDed: Decimal;
        LoanType: Record "Loan Repayment Schedule";
        Available: Decimal;
        Distributed: Decimal;
        WINDOW: Dialog;
        PostingCode: Codeunit "Gen. Jnl.-Post Line";
        SHARES: Decimal;
        TOTALLOANS: Decimal;
        Gnljnline: Record "Gen. Journal Line";
        LineN: Integer;
        instlnclr: Decimal;
        appotbal: Decimal;
        LOANAMOUNT: Decimal;
        PRODATA: Decimal;
        LOANAMOUNT2: Decimal;
        TOTALLOANSB: Decimal;
        NETSHARES: Decimal;
        Tinst: Decimal;
        Finst: Decimal;
        Floans: Decimal;
        GrAmount: Decimal;
        TGrAmount: Decimal;
        FGrAmount: Decimal;
        LOANBAL: Decimal;
        Serie: Integer;
        DLN: Code[10];
        "LN Doc": Code[20];
        INTBAL: Decimal;
        COMM: Decimal;
        loanTypes: Record "Loan Products Setup";

    // --> Reports ForNAV Autogenerated code - do not delete or modify
    var
        [WithEvents]
        ReportForNav: DotNet ForNavReport51516423_v6_3_0_2259;
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
