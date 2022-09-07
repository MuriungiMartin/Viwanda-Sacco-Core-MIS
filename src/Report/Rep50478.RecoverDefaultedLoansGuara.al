#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 //  settings

Report 50478 "Recover Defaulted Loans-Guara"
{
    RDLCLayout = 'Layouts/RecoverDefaultedLoans-Guara.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Loans Register"; "Loans Register")
        {

            trigger OnAfterGetRecord();
            begin
                LoanGuar.Reset;
                LoanGuar.SetRange(LoanGuar."Loan No", "Loans Register"."Loan  No.");
                if LoanGuar.Find('-') then begin
                    LoanGuar.Reset;
                    LoanGuar.SetRange(LoanGuar."Loan No", "Loans Register"."Loan  No.");
                    repeat
                        TGrAmount := TGrAmount + GrAmount;
                        GrAmount := LoanGuar."Amont Guaranteed";
                        FGrAmount := TGrAmount + LoanGuar."Amont Guaranteed";
                    until LoanGuar.Next = 0;
                end;
                //Defaulter loan clear
                "Loans Register".CalcFields("Loans Register"."Outstanding Balance", "Loans Register"."Interest Due");
                Lbal := ROUND("Loans Register"."Outstanding Balance", 1, '=');
                if "Loans Register"."Interest Due" > 0 then begin
                    INTBAL := ROUND("Loans Register"."Interest Due", 1, '=');
                    COMM := ROUND(("Loans Register"."Interest Due" * 0.5), 1, '=');
                    "Loans Register"."Attached Amount" := Lbal;
                    "Loans Register".PenaltyAttached := COMM;
                    "Loans Register".InDueAttached := INTBAL;
                    Modify;
                end;
                Attached := true;
                Message('BALANCE %1', Lbal);
                GenJournalLine."Line No." := GenJournalLine."Line No." + 1000;
                GenJournalLine.Init;
                GenJournalLine."Journal Template Name" := 'general';
                GenJournalLine."Journal Batch Name" := 'LNAttach';
                GenJournalLine."Document No." := "Loans Register"."Loan  No.";
                GenJournalLine."External Document No." := Loanapp."Loan  No.";
                GenJournalLine."Line No." := GenJournalLine."Line No." + 900;
                GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Interest Paid";
                GenJournalLine."Account Type" := GenJournalLine."account type"::Member;
                GenJournalLine."Account No." := "Client Code";
                GenJournalLine.Validate(GenJournalLine."Account No.");
                GenJournalLine."Posting Date" := Today;
                GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                GenJournalLine.Description := 'Def Loan' + "Client Code";
                GenJournalLine.Amount := -Lbal;
                GenJournalLine.Validate(GenJournalLine.Amount);
                GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                GenJournalLine."Loan No" := "Loans Register"."Loan  No.";
                if GenJournalLine.Amount <> 0 then
                    GenJournalLine.Insert;
                "LN Doc" := "Loans Register"."Loan  No.";
                // int due
                GenJournalLine."Line No." := GenJournalLine."Line No." + 1000;
                GenJournalLine.Init;
                GenJournalLine."Journal Template Name" := 'general';
                GenJournalLine."Journal Batch Name" := 'LNAttach';
                GenJournalLine."Document No." := "Loans Register"."Loan  No.";
                GenJournalLine."External Document No." := Loanapp."Loan  No.";
                GenJournalLine."Line No." := GenJournalLine."Line No." + 900;
                GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Insurance Contribution";
                GenJournalLine."Account Type" := GenJournalLine."account type"::Member;
                GenJournalLine."Account No." := "Client Code";
                GenJournalLine.Validate(GenJournalLine."Account No.");
                GenJournalLine."Posting Date" := Today;
                GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                //GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                GenJournalLine.Description := 'Defaulted Loan int' + ' ';
                GenJournalLine.Amount := -INTBAL;
                GenJournalLine.Validate(GenJournalLine.Amount);
                GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                GenJournalLine."Loan No" := "Loans Register"."Loan  No.";
                if GenJournalLine.Amount <> 0 then
                    GenJournalLine.Insert;
                //commisision
                GenJournalLine."Line No." := GenJournalLine."Line No." + 1000;
                GenJournalLine.Init;
                GenJournalLine."Journal Template Name" := 'general';
                GenJournalLine."Journal Batch Name" := 'LNAttach';
                GenJournalLine."Document No." := "Loans Register"."Loan  No.";
                GenJournalLine."External Document No." := Loanapp."Loan  No.";
                GenJournalLine."Line No." := GenJournalLine."Line No." + 900;
                GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                GenJournalLine."Account No." := '100002';
                GenJournalLine.Validate(GenJournalLine."Account No.");
                GenJournalLine."Posting Date" := Today;
                GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                GenJournalLine.Description := 'Penalty' + ' ';
                GenJournalLine.Amount := -COMM;
                GenJournalLine.Validate(GenJournalLine.Amount);
                GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                GenJournalLine."Loan No" := "Loans Register"."Loan  No.";
                if GenJournalLine.Amount <> 0 then
                    GenJournalLine.Insert;
                LoanGuar.Reset;
                LoanGuar.SetRange(LoanGuar."Loan No", "Loans Register"."Loan  No.");
                if LoanGuar.Find('-') then begin
                    LoanGuar.Reset;
                    LoanGuar.SetRange(LoanGuar."Loan No", "Loans Register"."Loan  No.");
                    DLN := 'DLN';
                    repeat
                        "Loans Register".Reset;
                        "Loans Register".SetRange("Loans Register"."Client Code", LoanGuar."Member No");
                        "Loans Register".SetRange("Loans Register"."Loan Product Type", 'DEFAULTER');
                        if "Loans Register".Find('-') then begin
                            "Loans Register".CalcFields("Loans Register"."Outstanding Balance");
                            if "Loans Register"."Outstanding Balance" = 0 then
                                "Loans Register".DeleteAll;
                        end;
                        GenSetUp.Get();
                        GenSetUp."Defaulter LN" := GenSetUp."Defaulter LN" + 10;
                        GenSetUp.Modify;
                        DLN := 'DLN' + Format(GenSetUp."Defaulter LN");
                        TGrAmount := TGrAmount + GrAmount;
                        GrAmount := LoanGuar."Amont Guaranteed";
                        Message('guarnteed Amount %1', FGrAmount);
                        ////Insert Journal Lines
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := 'general';
                        GenJournalLine."Journal Batch Name" := 'LNAttach';
                        GenJournalLine."Document No." := "LN Doc";
                        GenJournalLine."External Document No." := "LN Doc";
                        GenJournalLine."Line No." := GenJournalLine."Line No." + 1000;
                        GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Share Capital";
                        GenJournalLine."Account Type" := GenJournalLine."account type"::Member;
                        GenJournalLine."Account No." := LoanGuar."Member No";
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Posting Date" := Today;
                        GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                        GenJournalLine.Description := 'Defaulted Loan' + ' ';
                        GenJournalLine.Amount := ((GrAmount / FGrAmount) * (Lbal + INTBAL + COMM));
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                        GenJournalLine."Loan No" := DLN;
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;
                        if loanTypes.Get("Loan Product Type") then begin
                            "Loans Register".Init;
                            "Loans Register"."Loan  No." := DLN;
                            "Loans Register"."Client Code" := LoanGuar."Member No";
                            "Loans Register"."Loan Product Type" := 'DEFAULTER';
                            "Loans Register"."Loan Status" := "Loans Register"."loan status"::Closed;
                            cust.Reset;
                            cust.SetRange(cust."No.", LoanGuar."Member No");
                            if cust.Find('-') then begin
                                "Loans Register"."Client Name" := cust.Name;
                            end;
                            "Loans Register"."Application Date" := Today;
                            "Loans Register"."Issued Date" := Today;
                            "Loans Register".Installments := loanTypes."No of Installment";
                            "Loans Register".Repayment := ((GrAmount / FGrAmount) * (Lbal + INTBAL + COMM)) / loanTypes."No of Installment";
                            "Loans Register"."Requested Amount" := ((GrAmount / FGrAmount) * (Lbal + INTBAL + COMM));
                            "Loans Register"."Approved Amount" := ((GrAmount / FGrAmount) * (Lbal + INTBAL + COMM));
                            "Loans Register".Posted := true;
                            "Loans Register"."Advice Date" := Today;
                            "Loans Register".Insert;
                        end;
                    until LoanGuar.Next = 0;
                end;
                "Loans Register".Posted := true;
                "Loans Register"."Attachement Date" := Today;
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
                group(Options)
                {
                    Caption = 'Options';

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
        LoanType: Record "Loan Products Setup";
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


    var

}
