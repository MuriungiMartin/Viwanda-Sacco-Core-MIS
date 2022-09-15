#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50404 "Bosa Receipts H Card-Checkoff"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "ReceiptsProcessing_H-Checkoff";

    layout
    {
        area(content)
        {
            group(General)
            {
                field(No; No)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Entered By"; "Entered By")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                }
                field("Date Entered"; "Date Entered")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Posting date"; "Posting date")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Loan CutOff Date"; "Loan CutOff Date")
                {
                    ApplicationArea = Basic;
                }
                field(Remarks; Remarks)
                {
                    ApplicationArea = Basic;
                }
                field("Total Count"; "Total Count")
                {
                    ApplicationArea = Basic;
                }
                field("Posted By"; "Posted By")
                {
                    ApplicationArea = Basic;
                }
                field("Account Type"; "Account Type")
                {
                    ApplicationArea = Basic;
                }
                field("Account No"; "Account No")
                {
                    ApplicationArea = Basic;
                }
                field("Employer Code"; "Employer Code")
                {
                    ApplicationArea = Basic;
                }
                field("Document No"; "Document No")
                {
                    ApplicationArea = Basic;
                }
                field(Posted; Posted)
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field(Amount; Amount)
                {
                    ApplicationArea = Basic;
                }
                field("Scheduled Amount"; "Scheduled Amount")
                {
                    ApplicationArea = Basic;
                }
            }
            part("Bosa receipt lines"; "Bosa Receipt line-Checkoff")
            {
                SubPageLink = "Receipt Header No" = field(No);
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("<XMLport Import receipts>")
            {
                ApplicationArea = Basic;
                Caption = 'Import Receipts';
                RunObject = XMLport "Import Checkoff Block";
            }
            group(ActionGroup1102755021)
            {
            }
            action("Validate Receipts")
            {
                ApplicationArea = Basic;
                Caption = 'Validate Receipts';
                //   RunObject = Report UnknownReport50074;

                trigger OnAction()
                begin
                    Cust.Reset;
                    Cust.SetRange(Cust."No.", ReceiptsProcessingLines."Member No");
                    if Cust.Find('-') then begin
                        //REPEAT
                        ReceiptsProcessingLines."Member Found" := true;
                        ReceiptsProcessingLines.Modify;
                        //UNTIL Cust.NEXT=0;
                    end;
                    RcptBufLines.Reset;
                    RcptBufLines.SetRange(RcptBufLines."Receipt Header No", No);
                    if RcptBufLines.Find('-') then begin
                        repeat
                            "Scheduled Amount" := RcptBufLines."Saccco Benevolent" +
                            RcptBufLines."Sacco Appl Fee" +
                            RcptBufLines."Sacco Shares" +
                            RcptBufLines."Sacco Total Interest" +
                            RcptBufLines."Sacco Total Loan";
                        until
                        RcptBufLines.Next() = 0;
                        Modify();
                        Message('Validation complete');
                    end;

                end;
            }
            group(ActionGroup1102755019)
            {
            }
            action("Post check off")
            {
                ApplicationArea = Basic;
                Caption = 'Post check off';

                trigger OnAction()
                begin

                    genstup.Get();
                    if Posted = true then
                        Error('This Check Off has already been posted');
                    if "Account No" = '' then
                        Error('You must specify the Account No.');
                    if "Document No" = '' then
                        Error('You must specify the Document No.');
                    if "Posting date" = 0D then
                        Error('You must specify the Posting date.');
                    Datefilter := '..' + Format("Loan CutOff Date");



                    PDate := "Posting date";
                    DocNo := "Document No";
                    // GenBatches.Reset;
                    // GenBatches.SetRange(GenBatches."Journal Template Name", 'GENERAL');
                    // GenBatches.SetRange(GenBatches.Name, No);
                    // if GenBatches.Find('-') = false then begin
                    //     GenBatches.Init;
                    //     GenBatches."Journal Template Name" := 'GENERAL';
                    //     GenBatches.Name := No;
                    //     GenBatches.Description := 'cHECK OFF PROCESS';
                    //     GenBatches.Validate(GenBatches."Journal Template Name");
                    //     GenBatches.Validate(GenBatches.Name);
                    //     GenBatches.Insert;
                    // end;



                    //Delete journal
                    Gnljnline.Reset;
                    Gnljnline.SetRange("Journal Template Name", 'GENERAL');
                    Gnljnline.SetRange("Journal Batch Name", 'CHECKOFF');
                    Gnljnline.DeleteAll;
                    //End of deletion





                    RunBal := 0;
                    CalcFields("Scheduled Amount");
                    /*
                   IF "Scheduled Amount" <>   Amount THEN BEGIN
                   ERROR('Scheduled Amount Is Not Equal To Cheque Amount');
                   END;
                   */

                    //Post Control Account------------------------------------------

                    LineN := LineN + 10000;

                    Gnljnline.Init;
                    Gnljnline."Journal Template Name" := 'GENERAL';
                    Gnljnline."Journal Batch Name" := 'CHECKOFF';
                    Gnljnline."Line No." := LineN;
                    Gnljnline."Account Type" := "Account Type";
                    Gnljnline."Account No." := "Account No";
                    Gnljnline.Validate(Gnljnline."Account No.");
                    Gnljnline."Document No." := "Document No";
                    Gnljnline."Posting Date" := "Posting date";
                    Gnljnline.Description := 'checkoff  ' + Format("Posting date") + No;
                    Gnljnline.Amount := Amount;
                    Gnljnline.Validate(Gnljnline.Amount);
                    if Gnljnline.Amount <> 0 then
                        Gnljnline.Insert;


                    //End Post Control Account---------------------------------------

                    //------------------------------------Recover,Registration Fee, Insurance and Interest-------------------------------Viwanda
                    //Insurance

                    //Registration Fee
                    genstup.Get();
                    RcptBufLines.Reset;
                    RcptBufLines.SetRange(RcptBufLines."Receipt Header No", No);
                    RcptBufLines.SetRange(RcptBufLines.Posted, false);
                    if RcptBufLines.Find('-') then begin
                        repeat
                            RunBal := RcptBufLines."Sacco Total Interest";

                            CUst.Reset();
                            Cust.SetRange(Cust."No.", RcptBufLines."Member No");
                            Cust.SetAutoCalcFields(Cust."Registration Fee Paid");
                            if CUst.FindSet() then begin
                                repeat
                                    if RunBal > 0 then begin
                                        if Cust."Registration Fee Paid" < genstup."Registration Fee" then begin
                                            LineN := LineN + 10000;

                                            Gnljnline.Init;
                                            Gnljnline."Journal Template Name" := 'GENERAL';
                                            Gnljnline."Journal Batch Name" := 'CHECKOFF';
                                            Gnljnline."Line No." := LineN;
                                            Gnljnline."Account Type" := Gnljnline."bal. account type"::Customer;
                                            Gnljnline."Account No." := LoanApp."Client Code";
                                            Gnljnline.Validate(Gnljnline."Account No.");
                                            Gnljnline."Document No." := "Document No";
                                            Gnljnline."Posting Date" := "Posting date";
                                            Gnljnline.Description := 'Registration fee  ' + Remarks;
                                            if RunBal > (genstup."Registration Fee" - Cust."Registration Fee Paid") then
                                                Gnljnline.Amount := -ROUND((genstup."Registration Fee" - Cust."Registration Fee Paid"), 1, '>')
                                            else
                                                Gnljnline.Amount := -Round(runbal, 1, '>');
                                            Gnljnline.Validate(Gnljnline.Amount);
                                            Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Registration Fee";
                                            Gnljnline."Loan No" := LoanApp."Loan  No.";
                                            if Gnljnline.Amount <> 0 then
                                                Gnljnline.Insert;
                                            RunBal := RunBal + (Gnljnline.Amount);
                                        end;
                                    end;
                                until Cust.Next() = 0;
                            end;
                        until RcptBufLines.Next = 0;
                    end;

                    genstup.Get();
                    RcptBufLines.Reset;
                    RcptBufLines.SetRange(RcptBufLines."Receipt Header No", No);
                    RcptBufLines.SetRange(RcptBufLines.Posted, false);
                    if RcptBufLines.Find('-') then begin
                        repeat

                            LoanApp.Reset();
                            LoanApp.SetRange(LoanApp."Client Code", RcptBufLines."Member No");
                            LoanApp.SetAutoCalcFields(LoanApp."Outstanding Balance", LoanApp."Outstanding Interest", LoanApp."Outstanding Insurance");
                            LoanApp.SetFilter(LoanApp."Outstanding Insurance", '>%1', 0);
                            if LoanApp.FindSet() then begin
                                repeat
                                    if RunBal > 0 then begin
                                        LineN := LineN + 10000;

                                        Gnljnline.Init;
                                        Gnljnline."Journal Template Name" := 'GENERAL';
                                        Gnljnline."Journal Batch Name" := 'CHECKOFF';
                                        Gnljnline."Line No." := LineN;
                                        Gnljnline."Account Type" := Gnljnline."bal. account type"::Customer;
                                        Gnljnline."Account No." := LoanApp."Client Code";
                                        Gnljnline.Validate(Gnljnline."Account No.");
                                        Gnljnline."Document No." := "Document No";
                                        Gnljnline."Posting Date" := "Posting date";
                                        Gnljnline.Description := 'Insurance ' + Remarks;
                                        if RunBal > LoanApp."Outstanding Insurance" then
                                            Gnljnline.Amount := -ROUND(LoanApp."Outstanding Insurance", 1, '>')
                                        else
                                            Gnljnline.Amount := -Round(RunBal, 1, '>');
                                        Gnljnline.Validate(Gnljnline.Amount);
                                        Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Loan Insurance Paid";
                                        Gnljnline."Loan No" := LoanApp."Loan  No.";
                                        if Gnljnline.Amount <> 0 then
                                            Gnljnline.Insert;
                                        RunBal := RunBal + (Gnljnline.Amount);
                                    end;
                                until LoanApp.Next() = 0;
                            end;
                        until RcptBufLines.Next = 0;
                    end;
                    //Interest

                    RcptBufLines.Reset;
                    RcptBufLines.SetRange(RcptBufLines."Receipt Header No", No);
                    RcptBufLines.SetRange(RcptBufLines.Posted, false);
                    if RcptBufLines.Find('-') then begin
                        repeat

                            LoanApp.Reset();
                            LoanApp.SetRange(LoanApp."Client Code", RcptBufLines."Member No");
                            LoanApp.SetAutoCalcFields(LoanApp."Outstanding Balance", LoanApp."Outstanding Interest", LoanApp."Outstanding Insurance");
                            LoanApp.SetFilter(LoanApp."Outstanding Interest", '>%1', 0);
                            if LoanApp.FindSet() then begin
                                repeat
                                    if RunBal > 0 then begin
                                        LineN := LineN + 10000;

                                        Gnljnline.Init;
                                        Gnljnline."Journal Template Name" := 'GENERAL';
                                        Gnljnline."Journal Batch Name" := 'CHECKOFF';
                                        Gnljnline."Line No." := LineN;
                                        Gnljnline."Account Type" := Gnljnline."bal. account type"::Customer;
                                        Gnljnline."Account No." := LoanApp."Client Code";
                                        Gnljnline.Validate(Gnljnline."Account No.");
                                        Gnljnline."Document No." := "Document No";
                                        Gnljnline."Posting Date" := "Posting date";
                                        Gnljnline.Description := 'Interest Paid ' + Remarks;
                                        if RunBal > LoanApp."Outstanding Interest" then
                                            Gnljnline.Amount := -ROUND(LoanApp."Outstanding Interest", 1, '>')
                                        else
                                            Gnljnline.Amount := -Round(RunBal, 1, '>');
                                        Gnljnline.Validate(Gnljnline.Amount);
                                        Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Interest Paid";
                                        Gnljnline."Loan No" := LoanApp."Loan  No.";
                                        if Gnljnline.Amount <> 0 then
                                            Gnljnline.Insert;
                                        RunBal := RunBal + (Gnljnline.Amount);
                                    end;
                                until LoanApp.Next() = 0;
                            end;
                        until RcptBufLines.Next = 0;
                    end;
                    //--------------------------------------End Registration Fee, Insurance and Interest---------------------------------Viwanda

                    //---------------------------------------------Loan Repayments-----------------------------------Viwanda
                    RunBal := 0;
                    RcptBufLines.Reset;
                    RcptBufLines.SetRange(RcptBufLines."Receipt Header No", No);
                    RcptBufLines.SetRange(RcptBufLines.Posted, false);
                    if RcptBufLines.Find('-') then begin
                        repeat
                            RunBal := RcptBufLines."Sacco Total Loan";
                            if RunBal > 0 then begin
                                LoanApp.Reset();
                                LoanApp.SetRange(LoanApp."Client Code", RcptBufLines."Member No");
                                LoanApp.SetAutoCalcFields(LoanApp."Outstanding Balance", LoanApp."Outstanding Interest", LoanApp."Outstanding Insurance");
                                LoanApp.SetFilter(LoanApp."Outstanding Balance", '>%1', 0);
                                if LoanApp.FindSet() then begin
                                    repeat

                                        ObjLSchedule.reset;
                                        ObjLSchedule.SetRange(ObjLSchedule."Loan No.", LoanApp."Loan  No.");
                                        ObjLSchedule.SetFilter(ObjLSchedule."Repayment Date", '<=%1', "Loan CutOff Date");
                                        if ObjLSchedule.FindLast() then begin
                                            LRepayment := ObjLSchedule."Principal Repayment";
                                        end;
                                        LineN := LineN + 10000;
                                        Gnljnline.Init;
                                        Gnljnline."Journal Template Name" := 'GENERAL';
                                        Gnljnline."Journal Batch Name" := 'CHECKOFF';
                                        Gnljnline."Line No." := LineN;
                                        Gnljnline."Account Type" := Gnljnline."bal. account type"::Customer;
                                        Gnljnline."Account No." := LoanApp."Client Code";
                                        Gnljnline.Validate(Gnljnline."Account No.");
                                        Gnljnline."Document No." := "Document No";
                                        Gnljnline."Posting Date" := "Posting date";
                                        Gnljnline.Description := 'Repayment ' + Remarks;

                                        if RunBal > 0 then begin

                                            if RunBal > LRepayment then
                                                Gnljnline.Amount := LRepayment * -1
                                            else
                                                Gnljnline.Amount := RunBal * -1;
                                        end;

                                        Gnljnline.Validate(Gnljnline.Amount);
                                        Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Loan Repayment";
                                        Gnljnline."Loan No" := LoanApp."Loan  No.";
                                        if Gnljnline.Amount <> 0 then
                                            Gnljnline.Insert;

                                        RunBal := RunBal + (Gnljnline.Amount);
                                    until LoanApp.Next() = 0;
                                end;

                            end;

                        until RcptBufLines.Next() = 0;
                    end;
                    //-----------------------------------------End Loan Repayments-----------------------------------Viwanda
                    RunBal := 0;
                    //--------------------------------------------Benevolent fund------------------------------------Viwanda
                    genstup.Get();
                    RcptBufLines.Reset;
                    RcptBufLines.SetRange(RcptBufLines."Receipt Header No", No);
                    RcptBufLines.SetRange(RcptBufLines.Posted, false);
                    if RcptBufLines.Find('-') then begin
                        repeat


                            RunBal := RcptBufLines."Saccco Benevolent";

                            if RunBal > 0 then begin

                                Cust.Reset;
                                Cust.SetRange(Cust."No.", RcptBufLines."Member No");
                                if Cust.Find('-') then begin
                                    repeat
                                        Cust.CalcFields(Cust."Registration Fee Paid");



                                        LineN := LineN + 10000;
                                        Gnljnline.Init;
                                        Gnljnline."Journal Template Name" := 'GENERAL';
                                        Gnljnline."Journal Batch Name" := 'CHECKOFF';
                                        Gnljnline."Line No." := LineN;
                                        Gnljnline."Account Type" := Gnljnline."account type"::Customer;
                                        Gnljnline."Account No." := RcptBufLines."Member No";
                                        Gnljnline.Validate(Gnljnline."Account No.");
                                        Gnljnline."Document No." := "Document No";
                                        Gnljnline."Posting Date" := "Posting date";
                                        Gnljnline.Description := 'Benevolent Fee ' + Remarks;
                                        Gnljnline.Amount := RcptBufLines."Saccco Benevolent" * -1;
                                        Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Benevolent Fund";
                                        Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                                        Gnljnline."Shortcut Dimension 2 Code" := 'Nairobi';
                                        Gnljnline.Validate(Gnljnline.Amount);
                                        if Gnljnline.Amount <> 0 then
                                            Gnljnline.Insert;
                                        RunBal := RunBal + (Gnljnline.Amount);


                                    until Cust.Next = 0;
                                end;
                            end;
                        until RcptBufLines.Next() = 0;
                    end;


                    //----------------------------------------End Benevolent fund------------------------------------Viwanda
                    RunBal := 0;

                    //------------------------------------------Sacco Deposits---------------------------------------Viwanda
                    //Share Capital contribution
                    genstup.Get();
                    RcptBufLines.Reset;
                    RcptBufLines.SetRange(RcptBufLines."Receipt Header No", No);
                    RcptBufLines.SetRange(RcptBufLines.Posted, false);
                    if RcptBufLines.Find('-') then begin
                        repeat
                            RunBal := RcptBufLines."Sacco Shares";
                            Cust.Reset;
                            Cust.SetRange(Cust."No.", RcptBufLines."Member No");
                            Cust.SetAutoCalcFields(Cust."Shares Retained");
                            if Cust.Find('-') then begin
                                if Cust."Shares Retained" < genstup."Retained Shares" then begin
                                    if RunBal > 0 then begin
                                        LineN := LineN + 10000;

                                        Gnljnline.Init;
                                        Gnljnline."Journal Template Name" := 'GENERAL';
                                        Gnljnline."Journal Batch Name" := 'CHECKOFF';
                                        Gnljnline."Line No." := LineN;
                                        Gnljnline."Account Type" := Gnljnline."account type"::Customer;
                                        Gnljnline."Account No." := RcptBufLines."Member No";
                                        Gnljnline.Validate(Gnljnline."Account No.");
                                        Gnljnline."Document No." := "Document No";
                                        Gnljnline."Posting Date" := "Posting date";
                                        Gnljnline.Description := Remarks;
                                        if RunBal > Cust."Monthly Contribution" then
                                            Gnljnline.Amount := Cust."Monthly Contribution" * -1
                                        else
                                            Gnljnline.Amount := RunBal * -1;
                                        Gnljnline.Validate(Gnljnline.Amount);
                                        Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Deposit Contribution";
                                        if Gnljnline.Amount <> 0 then
                                            Gnljnline.Insert;
                                        RunBal := RunBal - (Gnljnline.Amount * -1);
                                    end;

                                end;
                            end;

                        until RcptBufLines.next = 0;
                    end;

                    //Deposits Contribution
                    RcptBufLines.Reset;
                    RcptBufLines.SetRange(RcptBufLines."Receipt Header No", No);
                    RcptBufLines.SetRange(RcptBufLines.Posted, false);
                    if RcptBufLines.Find('-') then begin
                        repeat
                            if RunBal > 0 then begin
                                LineN := LineN + 10000;

                                Gnljnline.Init;
                                Gnljnline."Journal Template Name" := 'GENERAL';
                                Gnljnline."Journal Batch Name" := 'CHECKOFF';
                                Gnljnline."Line No." := LineN;
                                Gnljnline."Account Type" := Gnljnline."account type"::Customer;
                                Gnljnline."Account No." := RcptBufLines."Member No";
                                Gnljnline.Validate(Gnljnline."Account No.");
                                Gnljnline."Document No." := "Document No";
                                Gnljnline."Posting Date" := "Posting date";
                                Gnljnline.Description := Remarks;
                                Gnljnline.Amount := RunBal * -1;
                                Gnljnline.Validate(Gnljnline.Amount);
                                Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Deposit Contribution";
                                if Gnljnline.Amount <> 0 then
                                    Gnljnline.Insert;
                                RunBal := RunBal - (Gnljnline.Amount * -1);
                            end;
                        until RcptBufLines.next = 0;
                    end;

                    //-------------------------------------End  Sacco Deposits---------------------------------------Viwanda

                    //----------------------------------------Loan Processing fee------------------------------------Viwanda
                    RunBal := 0;
                    RcptBufLines.Reset;
                    RcptBufLines.SetRange(RcptBufLines."Receipt Header No", No);
                    RcptBufLines.SetRange(RcptBufLines.Posted, false);
                    if RcptBufLines.Find('-') then begin
                        repeat
                            LoanApp.Reset();
                            LoanApp.SetRange(LoanApp."Client Code", RcptBufLines."Member No");
                            LoanApp.SetAutoCalcFields(loanapp."Outstanding Processing Fee");
                            LoanApp.SetFilter(LoanApp."Outstanding Processing Fee", '>%1', 0);
                            if LoanApp.FindSet then begin
                                repeat
                                    RunBal := RcptBufLines."Sacco Appl Fee";
                                    if RunBal > 0 then begin
                                        LineN := LineN + 10000;

                                        Gnljnline.Init;
                                        Gnljnline."Journal Template Name" := 'GENERAL';
                                        Gnljnline."Journal Batch Name" := 'CHECKOFF';
                                        Gnljnline."Line No." := LineN;
                                        Gnljnline."Account Type" := Gnljnline."account type"::Customer;
                                        Gnljnline."Account No." := LoanApp."Client Code";
                                        Gnljnline.Validate(Gnljnline."Account No.");
                                        Gnljnline."Document No." := "Document No";
                                        Gnljnline."Posting Date" := "Posting date";
                                        Gnljnline.Description := Remarks;
                                        Gnljnline.Amount := RcptBufLines."Sacco Appl Fee" * -1;
                                        Gnljnline.Validate(Gnljnline.Amount);
                                        Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Loan Processing Fee Paid";
                                        if Gnljnline.Amount <> 0 then
                                            Gnljnline.Insert;
                                        RunBal := RunBal - (Gnljnline.Amount * -1);
                                    end;

                                until LoanApp.Next() = 0;
                            end;

                        until RcptBufLines.Next() = 0;
                    end;

                    //-------------------------------------End Ln processing fee ------------------------------------Viwanda

                    "Posted By" := No;
                    Modify;

                    Message('CheckOff Successfully Generated');
                    /*
                    Posted:=True;
                    MODIFY;
                     */

                end;
            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        "Posting date" := Today;
        "Date Entered" := Today;
    end;

    var
        Gnljnline: Record "Gen. Journal Line";
        PDate: Date;
        DocNo: Code[20];
        RunBal: Decimal;
        ReceiptsProcessingLines: Record "ReceiptsProcessing_L-Checkoff";
        LineNo: Integer;
        LBatches: Record "Loan Disburesment-Batching";
        Jtemplate: Code[30];
        JBatch: Code[30];
        "Cheque No.": Code[20];
        DActivityBOSA: Code[20];
        DBranchBOSA: Code[20];
        ReptProcHeader: Record "ReceiptsProcessing_H-Checkoff";
        Cust: Record Customer;
        MembPostGroup: Record "Customer Posting Group";
        Loantable: Record "Loans Register";
        LRepayment: Decimal;
        RcptBufLines: Record "ReceiptsProcessing_L-Checkoff";
        LoanType: Record "Loan Products Setup";
        LoanApp: Record "Loans Register";
        Interest: Decimal;
        LineN: Integer;
        TotalRepay: Decimal;
        MultipleLoan: Integer;
        LType: Text;
        MonthlyAmount: Decimal;
        ShRec: Decimal;
        SHARESCAP: Decimal;
        DIFF: Decimal;
        DIFFPAID: Decimal;
        genstup: Record "Sacco General Set-Up";
        Memb: Record Customer;
        INSURANCE: Decimal;
        GenBatches: Record "Gen. Journal Batch";
        Datefilter: Text[50];
        ReceiptLine: Record "ReceiptsProcessing_L-Checkoff";
        ObjLSchedule: Record "Loan Repayment Schedule";
}

