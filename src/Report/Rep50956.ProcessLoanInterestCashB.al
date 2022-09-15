#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Report 50956 "Process Loan Interest:Cash B."
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("Loans Register"; "Loans Register")
        {
            CalcFields = "Outstanding Balance";
            DataItemTableView = where("Loan Product Type" = filter(<> '322' & <> '304'), "Loan Status" = filter(<> Closed));
            RequestFilterFields = "Loan  No.", "Client Code", "Loan Product Type";
            column(ReportForNavId_4645; 4645)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            // column(CurrReport_PAGENO;CurrReport.PageNo)
            // {
            // }
            column(UserId; UserId)
            {
            }
            column(Loans__Loan__No__; "Loan  No.")
            {
            }
            column(Loans__Application_Date_; "Application Date")
            {
            }
            column(Loans__Loan_Product_Type_; "Loan Product Type")
            {
            }
            column(Loans__Client_Code_; "Client Code")
            {
            }
            column(Loans__Client_Name_; "Client Name")
            {
            }
            column(Loans__Outstanding_Balance_; "Outstanding Balance")
            {
            }
            column(Loan_Application_FormCaption; Loan_Application_FormCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Loans__Loan__No__Caption; FieldCaption("Loan  No."))
            {
            }
            column(Loans__Application_Date_Caption; FieldCaption("Application Date"))
            {
            }
            column(Loans__Loan_Product_Type_Caption; FieldCaption("Loan Product Type"))
            {
            }
            column(Loans__Client_Code_Caption; FieldCaption("Client Code"))
            {
            }
            column(Loans__Client_Name_Caption; FieldCaption("Client Name"))
            {
            }
            column(Loans__Outstanding_Balance_Caption; FieldCaption("Outstanding Balance"))
            {
            }

            trigger OnAfterGetRecord()
            begin
                //=====================================================Interest periods
                if CalcDate('-CM', WorkDate) = WorkDate then begin
                    PostDate := WorkDate;
                    MonthEndDate := CalcDate('CM', WorkDate);
                    DocNo := Format(PostDate, 0, '<Month Text,3> <Year4>');
                    LoansDateFilter := '..' + Format(WorkDate);

                    ObjLoans.CalcFields(ObjLoans."Outstanding Balance");
                    ObjLoans.Reset;
                    ObjLoans.SetRange(ObjLoans."Loan  No.", "Loan  No.");
                    ObjLoans.SetFilter(ObjLoans."Outstanding Balance", '>%1', 0);
                    ObjLoans.SetFilter(ObjLoans."Loan Product Type", '<>%1&<>%2', '322', '304');
                    ObjLoans.SetFilter(ObjLoans."Date filter", LoansDateFilter);
                    ObjLoans.SetRange(ObjLoans."Freeze Interest Accrual", false);
                    ObjLoans.SetFilter(ObjLoans."Freeze Until", '%1|>%2', 0D, WorkDate);
                    ObjLoans.SetFilter(ObjLoans."Repayment Start Date", '<=%1', MonthEndDate);
                    if ObjLoans.Find('-') then begin
                        ObjLoans.CalcFields(ObjLoans."Outstanding Balance");
                        if ObjLoans."Outstanding Balance" > 0 then begin
                            ObjInterestLedger.Reset;
                            ObjInterestLedger.SetCurrentkey("Entry No.");
                            if ObjInterestLedger.FindLast then begin
                                LineNo := ObjInterestLedger."Entry No." + 1;
                            end;

                            ObjInterestLedger.Init;
                            ObjInterestLedger."Journal Batch Name" := 'INTRESTDUE';
                            ObjInterestLedger."Entry No." := LineNo;
                            ObjInterestLedger."Customer No." := ObjLoans."Client Code";
                            ObjInterestLedger."Transaction Type" := ObjInterestLedger."transaction type"::"Interest Due";
                            ObjInterestLedger."Document No." := DocNo;
                            ObjInterestLedger."Posting Date" := PostDate;
                            ObjInterestLedger.Description := DocNo + ' - Interest Accrued';
                            ObjInterestLedger.Amount := ROUND(ObjLoans."Outstanding Balance" * (ObjLoans.Interest / 1200), 1, '>');
                            if ObjLoans."Repayment Method" = ObjLoans."repayment method"::"Straight Line" then
                                ObjInterestLedger.Amount := ROUND(ObjLoans."Approved Amount" * (ObjLoans.Interest / 1200), 1, '>');
                            ObjInterestLedger.Validate(ObjInterestLedger.Amount);
                            ObjInterestLedger."Global Dimension 2 Code" := ObjLoans."Branch Code";
                            ObjInterestLedger."Global Dimension 1 Code" := FnProductSource(ObjLoans."Loan Product Type");
                            ObjInterestLedger.Validate(ObjInterestLedger."Global Dimension 2 Code");
                            ObjInterestLedger.Validate(ObjInterestLedger."Global Dimension 1 Code");
                            ObjInterestLedger."Loan No" := ObjLoans."Loan  No.";
                            if ObjInterestLedger.Amount <> 0 then
                                ObjInterestLedger.Insert;

                        end;
                    end;
                end;
                //=======================================================Interest periods
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        PDate: Date;
        LoanType: Record "Loan Products Setup";
        PostDate: Date;
        Cust: Record Customer;
        LineNo: Integer;
        DocNo: Code[20];
        EndDate: Date;
        DontCharge: Boolean;
        Temp: Record "Funds General Setup";
        JBatch: Code[10];
        Jtemplate: Code[10];
        CustLedger: Record "Member Ledger Entry";
        ObjInterestDuePeriod: Record "Interest Due Period";
        FiscalYearStartDate: Date;
        "ExtDocNo.": Text[30];
        Loan_Application_FormCaptionLbl: label 'Loan Application Form';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        loanapp: Record "Loans Register";
        SDATE: Text[30];
        ObjLoans: Record "Loans Register";
        ObjInterestLedger: Record "Interest Due Ledger Entry";
        VarCurrDate: Integer;
        LoansDateFilter: Text;
        MonthEndDate: Date;

    local procedure FnProductSource(Product: Code[50]) Source: Code[50]
    var
        ObjProducts: Record "Loan Products Setup";
    begin
        ObjProducts.Reset;
        ObjProducts.SetRange(ObjProducts.Code, Product);
        if ObjProducts.Find('-') then begin
            if ObjProducts.Source = ObjProducts.Source::BOSA then
                Source := 'BOSA'
            else
                Source := 'FOSA';
        end;
        exit(Source);
    end;
}

