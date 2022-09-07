
Report 50492 "Process Loan Monthly Interest"

{
    RDLCLayout = 'Layouts/ProcessLoanMonthlyInterest.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Loans Register"; "Loans Register")
        {
            CalcFields = "Outstanding Balance";
            DataItemTableView = where("Loan Product Type" = filter(<> 'FL354'), "Loan Product Type" = filter(<> 'FL358'), "Loan Product Type" = filter(<> 'FL353'), "Loan Product Type" = filter(<> 'FL364'));
            RequestFilterFields = "Issued Date", "Date filter", Source, "Loan  No.", "Client Code", "Account No", "Loan Product Type", "Outstanding Interest", "Interest Due", "Interest Paid", "Repayment Start Date", "Staff No";

            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(UserId; UserId)
            {
            }
            column(Loans__Loan__No__; "Loans Register"."Loan  No.")
            {
            }
            column(Loans__Application_Date_; "Loans Register"."Application Date")
            {
            }
            column(Loans__Loan_Product_Type_; "Loans Register"."Loan Product Type")
            {
            }
            column(Loans__Client_Code_; "Loans Register"."Client Code")
            {
            }
            column(Loans__Client_Name_; "Loans Register"."Client Name")
            {
            }
            column(Loans__Outstanding_Balance_; "Loans Register"."Outstanding Balance")
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
            trigger OnPreDataItem();
            begin
                if PostDate = 0D then
                    PostDate := Today;
                MonthName := Format(PostDate, 0, '<Month Text>');
                if DocNo = '' then
                    DocNo := 'INT' + MonthName;
                //delete journal line
                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name", 'General');
                GenJournalLine.SetRange("Journal Batch Name", 'INTDUE');
                GenJournalLine.DeleteAll;
                //end of deletion
                GenBatches.Reset;
                GenBatches.SetRange(GenBatches."Journal Template Name", 'General');
                GenBatches.SetRange(GenBatches.Name, 'INTDUE');
                if GenBatches.Find('-') = false then begin
                    GenBatches.Init;
                    GenBatches."Journal Template Name" := 'General';
                    GenBatches.Name := 'INTDUE';
                    GenBatches.Description := 'Interest Due';
                    GenBatches.Insert;
                end;
            end;

            trigger OnAfterGetRecord();
            begin
                PDate := Today;
                // PDate:="Loans Register".GETRANGEMAX("Loans Register"."Date filter");
                SDATE := '..' + Format(PDate);
                loanapp.Reset;
                loanapp.SetRange(loanapp."Loan  No.", "Loan  No.");
                loanapp.SetFilter(loanapp."Outstanding Balance", '>%1', 0);
                loanapp.SetFilter(loanapp."Date filter", SDATE);
                if loanapp.Find('-') then begin
                    loanapp.CalcFields(loanapp."Outstanding Balance");
                    if loanapp."Issued Date" <> 0D then begin
                        if (Date2dmy(loanapp."Issued Date", 1)) = (Date2dmy(Today, 1)) then begin
                            if loanapp."Outstanding Balance" > 0 then begin
                                if (loanapp."Loan Product Type" <> 'FL353') and (loanapp."Loan Product Type" <> 'FL354') and (loanapp."Loan Product Type" <> 'FL358') and (loanapp."Loan Product Type" <> 'FL364') then begin
                                    LineNo := LineNo + 10000;
                                    GenJournalLine.Init;
                                    GenJournalLine."Journal Template Name" := 'General';
                                    GenJournalLine."Journal Batch Name" := 'INTDUE';
                                    GenJournalLine."Line No." := LineNo;
                                    GenJournalLine."Account Type" := GenJournalLine."account type"::None;
                                    GenJournalLine."Account No." := loanapp."Client Code";
                                    GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Interest Due";
                                    GenJournalLine.Validate(GenJournalLine."Account No.");
                                    GenJournalLine."Document No." := DocNo;
                                    GenJournalLine."Posting Date" := PostDate;
                                    GenJournalLine.Description := DocNo + ' ' + 'Interest Due';
                                    GenJournalLine.Amount := ROUND(loanapp."Outstanding Balance" * (loanapp.Interest / 1200), 1, '>');
                                    if loanapp."Repayment Method" = loanapp."repayment method"::"Straight Line" then
                                        GenJournalLine.Amount := ROUND(loanapp."Approved Amount" * (loanapp.Interest / 1200), 1, '>');
                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                    if LoanType.Get(loanapp."Loan Product Type") then begin
                                        GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                        LoanType.TestField("Receivable Interest Account");
                                        GenJournalLine."Bal. Account No." := LoanType."Receivable Interest Account";
                                        GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                                    end;
                                    if loanapp.Source = loanapp.Source::" " then begin
                                        GenJournalLine."Shortcut Dimension 2 Code" := loanapp."Branch Code";
                                    end;
                                    if loanapp.Source = loanapp.Source::BOSA then begin
                                        GenJournalLine."Shortcut Dimension 2 Code" := loanapp."Branch Code";
                                    end;
                                    GenJournalLine."Shortcut Dimension 1 Code" := FnProductSource(loanapp."Loan Product Type");
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                    GenJournalLine."Loan No" := loanapp."Loan  No.";
                                    if GenJournalLine.Amount <> 0 then
                                        GenJournalLine.Insert;
                                end;
                            end;
                        end;
                    end;
                end;
                /*
				//Post New
				GenJournalLine.RESET;
				GenJournalLine.SETRANGE("Journal Template Name",'General');
				GenJournalLine.SETRANGE("Journal Batch Name",'INT DUE');
				IF GenJournalLine.FIND('-') THEN BEGIN
				CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post B",GenJournalLine);
				END; */
                //Post New

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
                field(PostDate; PostDate)
                {
                    ApplicationArea = Basic;
                    Caption = 'Posting Date';
                }
                field(DocNo; DocNo)
                {
                    ApplicationArea = Basic;
                    Caption = 'Document No.';
                }

            }
        }

        actions
        {
        }
        trigger OnOpenPage()
        begin

        end;
    }

    trigger OnInitReport()
    begin
        //Accounting periods
        AccountingPeriod.SetRange(AccountingPeriod.Closed, false);
        if AccountingPeriod.Find('-') then begin
            FiscalYearStartDate := AccountingPeriod."Interest Calcuation Date";
            PostDate := (FiscalYearStartDate);
            DocNo := AccountingPeriod.Name + '-' + Format(PostDate);
        end;
        //Accounting periods
        ;


    end;

    trigger OnPostReport()
    begin
        ;

    end;

    trigger OnPreReport()
    begin
        ;

    end;

    var
        GenBatches: Record "Gen. Journal Batch";
        PDate: Date;
        LoanType: Record "Loan Products Setup";
        PostDate: Date;
        Cust: Record "Members Register";
        LineNo: Integer;
        DocNo: Code[20];
        GenJournalLine: Record "Gen. Journal Line";
        GLPosting: Codeunit "Gen. Jnl.-Post Line";
        EndDate: Date;
        DontCharge: Boolean;
        Temp: Record "Funds General Setup";
        JBatch: Code[10];
        Jtemplate: Code[10];
        CustLedger: Record "Member Ledger Entry";
        AccountingPeriod: Record "Interest Due Period";
        FiscalYearStartDate: Date;
        "ExtDocNo.": Text[30];
        Loan_Application_FormCaptionLbl: label 'Loan Application Form';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        loanapp: Record "Loans Register";
        SDATE: Text[30];
        MonthName: Text;

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


    var

}
