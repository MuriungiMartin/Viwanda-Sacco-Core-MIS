
Report 50491 "Process Salaries BatchX"
{
    RDLCLayout = 'Layouts/ProcessSalariesBatchX.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Salary Processing Lines"; "Salary Processing Lines")
        {
            DataItemTableView = sorting("No.") where(Processed = const(false));
            RequestFilterFields = "Account No.", "Date Filter", "Salary Header No.";

            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(UserId; UserId)
            {
            }
            column(Salary_Processing_Buffer__No__; "Salary Processing Lines"."No.")
            {
            }
            column(Salary_Processing_Buffer__Account_No__; "Salary Processing Lines"."Account No.")
            {
            }
            column(Salary_Processing_Buffer__Staff_No__; "Salary Processing Lines"."Staff No.")
            {
            }
            column(Salary_Processing_Buffer_Name; "Salary Processing Lines".Name)
            {
            }
            column(Salary_Processing_Buffer_Amount; "Salary Processing Lines".Amount)
            {
            }
            column(Salary_Processing_Buffer__Account_Not_Found_; "Salary Processing Lines"."Account Not Found")
            {
            }
            column(Salary_Allowance_Processing_BufferCaption; Salary_Allowance_Processing_BufferCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Salary_Processing_Buffer__No__Caption; FieldCaption("No."))
            {
            }
            column(Salary_Processing_Buffer__Account_No__Caption; FieldCaption("Account No."))
            {
            }
            column(Salary_Processing_Buffer__Staff_No__Caption; FieldCaption("Staff No."))
            {
            }
            column(Salary_Processing_Buffer_NameCaption; FieldCaption(Name))
            {
            }
            column(Salary_Processing_Buffer_AmountCaption; FieldCaption(Amount))
            {
            }
            column(Salary_Processing_Buffer__Account_Not_Found_Caption; FieldCaption("Account Not Found"))
            {
            }
            dataitem("Standing Orders"; "Standing Orders")
            {
                DataItemLink = "Source Account No." = field("Account No.");
                DataItemTableView = where(Status = filter(Approved));
                trigger OnAfterGetRecord();
                begin
                    DontEffect := false;
                    if "Standing Orders"."Effective/Start Date" <> 0D then begin
                        if "Standing Orders"."Effective/Start Date" > Today then begin
                            if Date2dmy(Today, 2) <> Date2dmy("Standing Orders"."Effective/Start Date", 2) then
                                DontEffect := true;
                        end;
                    end;
                    //Check Effective Date
                    if DontEffect = false then begin
                        if SittingAll = false then begin
                            AmountDed := 0;
                            "Standing Orders".Effected := false;
                            "Standing Orders".Unsuccessfull := false;
                            "Standing Orders".Balance := 0;
                            if AccountS.Get("Standing Orders"."Source Account No.") then begin
                                DActivity3 := AccountS."Global Dimension 1 Code";
                                DBranch3 := AccountS."Global Dimension 2 Code";
                                AccountS.CalcFields(AccountS.Balance, AccountS."Uncleared Cheques");
                                //AvailableBal:=(AccountS.Balance-AccountS."Uncleared Cheques")+RunBal;
                                AvailableBal := RunBal;
                                if AccountTypeS.Get(AccountS."Account Type") then begin
                                    //AvailableBal:=AvailableBal-AccountTypeS."Minimum Balance";
                                    Charges.Reset;
                                    if "Destination Account Type" = "destination account type"::"Member Account" then
                                        Charges.SetRange(Charges."Charge Type", Charges."charge type"::"External Standing Order Fee")
                                    else
                                        Charges.SetRange(Charges."Charge Type", Charges."charge type"::"Standing Order Fee");
                                    if Charges.Find('-') then begin
                                        AvailableBal := AvailableBal - Charges."Charge Amount";
                                    end;
                                    if "Standing Orders"."Next Run Date" = 0D then
                                        "Standing Orders"."Next Run Date" := "Standing Orders"."Effective/Start Date";
                                    //IF AvailableBal >= "Standing Orders".Amount THEN BEGIN
                                    "Standing Orders".CalcFields("Standing Orders"."Allocated Amount");
                                    if AvailableBal >= "Standing Orders"."Allocated Amount" then begin
                                        AmountDed := "Standing Orders".Amount;
                                        DedStatus := Dedstatus::Successfull;
                                        if "Standing Orders".Amount >= "Standing Orders".Balance then begin
                                            "Standing Orders".Balance := 0;
                                            "Standing Orders"."Next Run Date" := CalcDate("Standing Orders".Frequency, "Standing Orders"."Next Run Date");
                                            "Standing Orders".Unsuccessfull := false;
                                        end else begin
                                            "Standing Orders".Balance := "Standing Orders".Balance - "Standing Orders".Amount;
                                            "Standing Orders".Unsuccessfull := true;
                                        end;
                                    end else begin
                                        if "Standing Orders"."Don't Allow Partial Deduction" = true then begin
                                            AmountDed := 0;
                                            DedStatus := Dedstatus::Failed;
                                            "Standing Orders".Balance := "Standing Orders".Amount;
                                            "Standing Orders".Unsuccessfull := true;
                                        end else begin
                                            AmountDed := AvailableBal;
                                            DedStatus := Dedstatus::"Partial Deduction";
                                            "Standing Orders".Balance := "Standing Orders".Amount - AmountDed;
                                            "Standing Orders".Unsuccessfull := true;
                                        end;
                                    end;
                                    if AmountDed < 0 then begin
                                        AmountDed := 0;
                                        DedStatus := Dedstatus::Failed;
                                        "Standing Orders".Balance := "Standing Orders".Amount;
                                        "Standing Orders".Unsuccessfull := true;
                                    end;
                                    if AmountDed > 0 then begin
                                        ActualSTO := 0;
                                        if ("Standing Orders"."Destination Account Type" = "Standing Orders"."destination account type"::"Other Banks Account") and ("Standing Orders".Status = "Standing Orders".Status::Approved) then begin
                                            //PostBOSAEntries();
                                            //AmountDed:=ActualSTO;
                                            AmountDed := Amount;
                                            //***********************BOSA  Entries
                                            if AmountDed > 0 then begin
                                                STORunBal := AmountDed;
                                                ReceiptAllocations.Reset;
                                                ReceiptAllocations.SetRange(ReceiptAllocations."Document No", "No.");
                                                ReceiptAllocations.SetRange(ReceiptAllocations."Member No", "BOSA Account No.");
                                                if ReceiptAllocations.Find('-') then begin
                                                    repeat
                                                        ReceiptAllocations."Amount Balance" := 0;
                                                        ReceiptAllocations."Interest Balance" := 0;
                                                        ReceiptAmount := ReceiptAllocations.Amount;//-ReceiptAllocations."Amount Balance";
                                                                                                   //Check Loan Balances
                                                                                                   /*IF ReceiptAllocations."Transaction Type" = ReceiptAllocations."Transaction Type"::Repayment THEN BEGIN
                                                                                                   Loans.RESET;
                                                                                                   Loans.SETRANGE(Loans."Loan  No.",ReceiptAllocations."Loan No.");
                                                                                                   IF Loans.FIND('-') THEN BEGIN
                                                                                                   Loans.CALCFIELDS(Loans."Outstanding Balance");
                                                                                                   IF ReceiptAmount > Loans."Outstanding Balance" THEN
                                                                                                   ReceiptAmount := Loans."Outstanding Balance";
                                                                                                   END ELSE
                                                                                                   ERROR('Loan No. %1 not Found. :- %2',ReceiptAllocations."Loan No.",ReceiptAllocations."Document No");
                                                                                                   END;*/
                                                        if ReceiptAmount < 0 then
                                                            ReceiptAmount := 0;
                                                        if STORunBal < 0 then
                                                            STORunBal := 0;
                                                        LineNo := LineNo + 10000;
                                                        GenJournalLine.Init;
                                                        GenJournalLine."Journal Template Name" := 'GENERAL';
                                                        GenJournalLine."Journal Batch Name" := 'SALARIES';
                                                        GenJournalLine."Line No." := LineNo;
                                                        GenJournalLine."Document No." := SalaryHeader."Document No";
                                                        GenJournalLine."External Document No." := StandingOrders."No.";
                                                        GenJournalLine."Posting Date" := SalaryHeader."Posting date";
                                                        GenJournalLine."Account Type" := GenJournalLine."bal. account type"::Employee;
                                                        GenJournalLine."Account No." := ReceiptAllocations."Member No";
                                                        GenJournalLine.Validate(GenJournalLine."Account No.");
                                                        GenJournalLine.Description := Format(ReceiptAllocations."Transaction Type");
                                                        if STORunBal > ReceiptAmount then
                                                            GenJournalLine.Amount := -ReceiptAmount
                                                        else
                                                            GenJournalLine.Amount := -STORunBal;
                                                        if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"Loan Penalty Paid" then begin
                                                            if Abs(GenJournalLine.Amount) = 100 then
                                                                InsCont := 100;
                                                            GenJournalLine.Amount := -25;
                                                        end;
                                                        GenJournalLine.Validate(GenJournalLine.Amount);
                                                        if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"Benevolent Fund" then
                                                            GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Benevolent Fund"
                                                        else
                                                            if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::Loan then
                                                                GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::Loan
                                                            else
                                                                if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"Loan Insurance Charged" then
                                                                    GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Loan Penalty Paid"
                                                                else
                                                                    if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"Interest Paid" then
                                                                        GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Interest Paid"
                                                                    else
                                                                        if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"Registration Fee" then
                                                                            GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Registration Fee"
                                                                        else
                                                                            if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"Recovery Account" then
                                                                                GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Recovery Account"
                                                                            else
                                                                                if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::" " then
                                                                                    GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::" ";
                                                        GenJournalLine."Loan No" := ReceiptAllocations."Loan No.";
                                                        //IF GenJournalLine.Amount<>0 THEN
                                                        GenJournalLine.Insert;
                                                        ReceiptAllocations."Amount Balance" := ReceiptAllocations."Amount Balance" + (GenJournalLine.Amount * -1);
                                                        STORunBal := STORunBal + GenJournalLine.Amount;
                                                        ActualSTO := ActualSTO + (GenJournalLine.Amount * -1);
                                                        if (ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"Loan Penalty Paid")
                                                           and (InsCont = 100) then begin
                                                            LineNo := LineNo + 10000;
                                                            GenJournalLine.Init;
                                                            GenJournalLine."Journal Template Name" := 'GENERAL';
                                                            GenJournalLine."Journal Batch Name" := 'SALARIES';
                                                            GenJournalLine."Line No." := LineNo;
                                                            GenJournalLine."Document No." := SalaryHeader."Document No";
                                                            GenJournalLine."External Document No." := StandingOrders."No.";
                                                            GenJournalLine."Posting Date" := SalaryHeader."Posting date";
                                                            GenJournalLine."Account Type" := GenJournalLine."bal. account type"::Employee;
                                                            GenJournalLine."Account No." := ReceiptAllocations."Member No";
                                                            GenJournalLine.Validate(GenJournalLine."Account No.");
                                                            GenJournalLine.Description := Format(ReceiptAllocations."Transaction Type");
                                                            GenJournalLine.Amount := -75;
                                                            GenJournalLine.Validate(GenJournalLine.Amount);
                                                            //GenJournalLine."Transaction Type":=GenJournalLine."Transaction Type"::BOSAEXC;
                                                            GenJournalLine."Loan No" := ReceiptAllocations."Loan No.";
                                                            //IF GenJournalLine.Amount<>0 THEN
                                                            GenJournalLine.Insert;
                                                            ReceiptAllocations."Amount Balance" := ReceiptAllocations."Amount Balance" + (GenJournalLine.Amount * -1);
                                                            STORunBal := STORunBal + GenJournalLine.Amount;
                                                            ActualSTO := ActualSTO + (GenJournalLine.Amount * -1);
                                                        end;
                                                        if STORunBal < 0 then
                                                            STORunBal := 0;
                                                        if (ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"Interest Paid") and
                                                           (ReceiptAllocations."Interest Amount" > 0) then begin
                                                            LineNo := LineNo + 10000;
                                                            ReceiptAmount := ReceiptAllocations."Interest Amount";
                                                            //Check Outstanding Interest
                                                            Loans.Reset;
                                                            Loans.SetRange(Loans."Loan  No.", ReceiptAllocations."Loan No.");
                                                            if Loans.Find('-') then begin
                                                                Loans.CalcFields(Loans."Outstanding Interest");
                                                                if ReceiptAmount > Loans."Outstanding Interest" then
                                                                    ReceiptAmount := Loans."Outstanding Interest";
                                                            end else
                                                                Error('Loan No. %1 not Found. :- %2', ReceiptAllocations."Loan No.", ReceiptAllocations."Document No");
                                                            if ReceiptAmount < 0 then
                                                                ReceiptAmount := 0;
                                                            if ReceiptAmount > 0 then begin
                                                                GenJournalLine.Init;
                                                                GenJournalLine."Journal Template Name" := 'GENERAL';
                                                                GenJournalLine."Journal Batch Name" := 'SALARIES';
                                                                GenJournalLine."Line No." := LineNo;
                                                                GenJournalLine."Document No." := SalaryHeader."Document No";
                                                                GenJournalLine."External Document No." := StandingOrders."No.";
                                                                GenJournalLine."Posting Date" := SalaryHeader."Posting date";
                                                                GenJournalLine."Account Type" := GenJournalLine."bal. account type"::Employee;
                                                                GenJournalLine."Account No." := ReceiptAllocations."Member No";
                                                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                                                GenJournalLine.Description := 'Interest Paid';
                                                                if STORunBal > ReceiptAmount then
                                                                    GenJournalLine.Amount := -ReceiptAmount
                                                                else
                                                                    GenJournalLine.Amount := -STORunBal;
                                                                GenJournalLine.Validate(GenJournalLine.Amount);
                                                                GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Insurance Contribution";
                                                                GenJournalLine."Loan No" := ReceiptAllocations."Loan No.";
                                                                //IF GenJournalLine.Amount<>0 THEN
                                                                GenJournalLine.Insert;
                                                                ReceiptAllocations."Interest Balance" := ReceiptAllocations."Interest Balance" + (GenJournalLine.Amount * -1);
                                                                STORunBal := STORunBal + GenJournalLine.Amount;
                                                                ActualSTO := ActualSTO + (GenJournalLine.Amount * -1);
                                                            end;
                                                        end;
                                                        ReceiptAllocations.Modify;
                                                    until ReceiptAllocations.Next = 0;
                                                end;
                                            end;
                                            //**********************End BOSA Entries
                                        end;
                                        LineNo := LineNo + 10000;
                                        GenJournalLine.Init;
                                        GenJournalLine."Journal Template Name" := 'GENERAL';
                                        GenJournalLine."Journal Batch Name" := 'SALARIES';
                                        GenJournalLine."Document No." := SalaryHeader."Document No";
                                        if "Standing Orders"."Destination Account Type" = "Standing Orders"."destination account type"::"Member Account" then
                                            GenJournalLine."External Document No." := "Standing Orders"."Destination Account No."
                                        else
                                            GenJournalLine."External Document No." := "Standing Orders"."No.";
                                        GenJournalLine."Line No." := LineNo;
                                        GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                        GenJournalLine."Account No." := "Standing Orders"."Source Account No.";
                                        GenJournalLine.Validate(GenJournalLine."Account No.");
                                        GenJournalLine."Posting Date" := SalaryHeader."Posting date";
                                        GenJournalLine.Description := 'Standing Order ' + CopyStr("Standing Orders"."Standing Order Description", 1, 14);
                                        GenJournalLine.Validate(GenJournalLine."Currency Code");
                                        GenJournalLine.Amount := AmountDed;
                                        GenJournalLine.Validate(GenJournalLine.Amount);
                                        GenJournalLine."Shortcut Dimension 1 Code" := DActivity3;
                                        GenJournalLine."Shortcut Dimension 2 Code" := DBranch3;
                                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                        if GenJournalLine.Amount <> 0 then
                                            GenJournalLine.Insert;
                                        RunBal := RunBal - AmountDed;
                                        if ("Standing Orders"."Destination Account Type" <> "Standing Orders"."destination account type"::"Other Banks Account") and ("Standing Orders".Status = "Standing Orders".Status::Approved) then begin
                                            LineNo := LineNo + 10000;
                                            GenJournalLine.Init;
                                            GenJournalLine."Journal Template Name" := 'GENERAL';
                                            GenJournalLine."Journal Batch Name" := 'SALARIES';
                                            GenJournalLine."Document No." := SalaryHeader."Document No";
                                            GenJournalLine."Line No." := LineNo;
                                            //GenJournalLine."External Document No.":="Standing Orders"."Source Account No.";
                                            //To pick staff no of the source
                                            GenJournalLine."External Document No." := StandingOrders."Staff/Payroll No.";
                                            if GenJournalLine."External Document No." = '' then
                                                GenJournalLine."External Document No." := "Standing Orders"."Source Account No.";
                                            if "Standing Orders"."Destination Account Type" = "Standing Orders"."destination account type"::"Supplier Account" then begin
                                                GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                                GenJournalLine."Account No." := "Standing Orders"."Destination Account No.";
                                            end else begin
                                                GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                                                GenJournalLine."Account No." := AccountTypeS."Standing Orders Suspense";
                                            end;
                                            GenJournalLine.Validate(GenJournalLine."Account No.");
                                            GenJournalLine."Posting Date" := SalaryHeader."Posting date";
                                            GenJournalLine.Description := 'Standing Order ' + CopyStr("Standing Orders"."Standing Order Description", 1, 14);
                                            GenJournalLine.Validate(GenJournalLine."Currency Code");
                                            GenJournalLine.Amount := -AmountDed;
                                            GenJournalLine.Validate(GenJournalLine.Amount);
                                            GenJournalLine."Shortcut Dimension 1 Code" := DActivity3;
                                            GenJournalLine."Shortcut Dimension 2 Code" := DBranch3;
                                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                            if GenJournalLine.Amount <> 0 then
                                                GenJournalLine.Insert;
                                        end;
                                    end;
                                    //Standing Order Charges
                                    if AmountDed > 0 then begin
                                        Charges.Reset;
                                        //IF "Destination Account Type" = "Destination Account Type"::External THEN
                                        //Charges.SETRANGE(Charges."Charge Type",Charges."Charge Type"::"External Standing Order Fee")
                                        //ELSE
                                        Charges.SetRange(Charges."Charge Type", Charges."charge type"::"Standing Order Fee");
                                        if Charges.Find('-') then begin
                                            LineNo := LineNo + 10000;
                                            GenJournalLine.Init;
                                            GenJournalLine."Journal Template Name" := 'GENERAL';
                                            GenJournalLine."Journal Batch Name" := 'SALARIES';
                                            GenJournalLine."Document No." := SalaryHeader."Document No";
                                            GenJournalLine."Line No." := LineNo;
                                            GenJournalLine."External Document No." := "Standing Orders"."No.";
                                            GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                            GenJournalLine."Account No." := "Standing Orders"."Source Account No.";
                                            GenJournalLine.Validate(GenJournalLine."Account No.");
                                            GenJournalLine."Posting Date" := SalaryHeader."Posting date";
                                            GenJournalLine.Description := Charges.Description;
                                            GenJournalLine.Validate(GenJournalLine."Currency Code");
                                            GenJournalLine.Amount := Charges."Charge Amount";
                                            GenJournalLine.Validate(GenJournalLine.Amount);
                                            GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                            GenJournalLine."Bal. Account No." := Charges."GL Account";
                                            GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                                            GenJournalLine."Shortcut Dimension 1 Code" := DActivity3;
                                            GenJournalLine."Shortcut Dimension 2 Code" := DBranch3;
                                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                            if GenJournalLine.Amount <> 0 then
                                                GenJournalLine.Insert;
                                        end;
                                    end else begin
                                        if AccountTypeS.Code <> 'OMEGA' then begin
                                            Charges.Reset;
                                            Charges.SetRange(Charges."Charge Type", Charges."charge type"::"Failed Standing Order Fee");
                                            if Charges.Find('-') then begin
                                                LineNo := LineNo + 10000;
                                                GenJournalLine.Init;
                                                GenJournalLine."Journal Template Name" := 'GENERAL';
                                                GenJournalLine."Journal Batch Name" := 'SALARIES';
                                                GenJournalLine."Document No." := SalaryHeader."Document No";
                                                GenJournalLine."Line No." := LineNo;
                                                GenJournalLine."External Document No." := "Standing Orders"."No.";
                                                GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                                GenJournalLine."Account No." := "Standing Orders"."Source Account No.";
                                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                                GenJournalLine."Posting Date" := SalaryHeader."Posting date";
                                                GenJournalLine.Description := Charges.Description;
                                                GenJournalLine.Validate(GenJournalLine."Currency Code");
                                                GenJournalLine.Amount := Charges."Charge Amount";
                                                GenJournalLine.Validate(GenJournalLine.Amount);
                                                GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                                GenJournalLine."Bal. Account No." := Charges."GL Account";
                                                GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                                                GenJournalLine."Shortcut Dimension 1 Code" := DActivity3;
                                                GenJournalLine."Shortcut Dimension 2 Code" := DBranch3;
                                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                                if GenJournalLine.Amount <> 0 then
                                                    GenJournalLine.Insert;
                                            end;
                                        end;
                                    end;
                                    //Standing Order Charges
                                    //PostBOSAEntries();
                                    "Standing Orders".Effected := true;
                                    "Standing Orders"."Date Reset" := Today;
                                    "Standing Orders"."Next Run Date" := CalcDate('-1D', CalcDate('1M', Dmy2date(1, Date2dmy(CalcDate("Standing Orders".Frequency, Today), 2),
                                                                               Date2dmy(CalcDate("Standing Orders".Frequency, Today), 3))));
                                    "Standing Orders".Modify;
                                    STORegister.Init;
                                    STORegister."Register No." := '';
                                    STORegister.Validate(STORegister."Register No.");
                                    STORegister."Standing Order No." := "Standing Orders"."No.";
                                    STORegister."Source Account No." := "Standing Orders"."Source Account No.";
                                    STORegister."Staff/Payroll No." := "Standing Orders"."Staff/Payroll No.";
                                    STORegister.Date := Today;
                                    STORegister."Account Name" := "Standing Orders"."Account Name";
                                    STORegister."Destination Account Type" := "Standing Orders"."Destination Account Type";
                                    STORegister."Destination Account No." := "Standing Orders"."Destination Account No.";
                                    STORegister."Destination Account Name" := "Standing Orders"."Destination Account Name";
                                    STORegister."BOSA Account No." := "Standing Orders"."BOSA Account No.";
                                    STORegister."Effective/Start Date" := "Standing Orders"."Effective/Start Date";
                                    STORegister."End Date" := "Standing Orders"."End Date";
                                    STORegister.Duration := "Standing Orders".Duration;
                                    STORegister.Frequency := "Standing Orders".Frequency;
                                    STORegister."Don't Allow Partial Deduction" := "Standing Orders"."Don't Allow Partial Deduction";
                                    STORegister."Deduction Status" := DedStatus;
                                    STORegister.Remarks := "Standing Orders"."Standing Order Description";
                                    STORegister.Amount := "Standing Orders".Amount;
                                    STORegister."Amount Deducted" := AmountDed;
                                    if "Standing Orders"."Destination Account Type" = "Standing Orders"."destination account type"::"Member Account" then
                                        STORegister.EFT := true;
                                    STORegister."Document No." := DocNo;
                                    STORegister.Insert(true);
                                end;
                            end;
                        end;
                    end;
                    //ollin STO cahnge

                end;

            }
            trigger OnPreDataItem();
            begin
                /*
				IF DocNo = '' THEN
				ERROR('You must specify the Document No.');
				IF PDate = 0D THEN
				ERROR('You must specify the posting date.');
				IF IssueDate = 0D THEN
				ERROR('You must specify the last issue date.');
				IF SittingAll = TRUE THEN BEGIN
				IF Remarks = '' THEN
				ERROR('You must specify the remarks for other payments.');
				END;
				*/
                if IssueDate = 0D then
                    Error('You must specify the last Loan issue date.');
                STORegister.Reset;
                STORegister.SetRange(STORegister."Document No.", DocNo);
                STORegister.SetRange(STORegister.Date, PDate);
                STORegister.SetRange(STORegister."Transfered to EFT", false);
                if STORegister.Find('-') then
                    STORegister.DeleteAll;
                GenJournalLine.Reset;
                GenJournalLine.SetRange(GenJournalLine."Journal Template Name", 'GENERAL');
                GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", 'SALARIES');
                if GenJournalLine.Find('-') then
                    GenJournalLine.DeleteAll;
                SalFee := 0;
                ExciseFee := 0;
                //IF SittingAll = FALSE THEN BEGIN
                if Charges.Get('SALARYP') then begin
                    SalGLAccount := Charges."GL Account";
                    SalFee := Charges."Charge Amount";
                end;
                if Charges.Get('EXCEISE') then begin
                    ExciseGLAccount := Charges."GL Account";
                    ExciseFee := SalFee * (Charges."Percentage of Amount" / 100);
                end;
                //END;
                /*
				IF UsersID.GET(USERID) THEN BEGIN
				//UsersID.TESTFIELD(UsersID.Branch);
				DActivity:='FOSA';
				DBranch:=UsersID."Branch Code";
				END;
				*/

            end;

            trigger OnAfterGetRecord();
            begin
                if SalaryHeader.Get("Salary Header No.") then begin
                    //********Update E-Loan Buffer
                    ELoanBuffer.Reset;
                    ELoanBuffer.SetRange(ELoanBuffer."Salary Processing Date", SalaryHeader."Posting date");
                    ELoanBuffer.SetRange(ELoanBuffer."Account No", "Account No.");
                    if ELoanBuffer.Find('-') = false then begin
                        repeat
                            ELoanBuffer.Init;
                            ELoanBuffer."Account No" := "Account No.";
                            ELoanBuffer."Account Name" := "Account Name";
                            ELoanBuffer.Amount := Amount;
                            ELoanBuffer."Salary Processing Date" := SalaryHeader."Posting date";
                            ELoanBuffer.Insert;
                        until ELoanBuffer.Next = 0;
                    end;
                    //*******End Update E-Loan Buffer
                    SMSCharge := 0;
                    LineNo := LineNo + 10000;
                    if "Salary Processing Lines"."Account No." = '350010' then begin
                        LineNo := LineNo + 1000;
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := 'GENERAL';
                        GenJournalLine."Journal Batch Name" := 'SALARIES';
                        GenJournalLine."Line No." := LineNo;
                        GenJournalLine."Document No." := SalaryHeader."Document No";
                        GenJournalLine."External Document No." := "Salary Processing Lines"."Branch Reff.";
                        GenJournalLine."Posting Date" := SalaryHeader."Posting date";
                        GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                        GenJournalLine.Validate(GenJournalLine."Account No.", "Salary Processing Lines"."Account No.");
                        GenJournalLine.Description := "Salary Processing Lines".Name;
                        GenJournalLine.Validate(GenJournalLine.Amount, -"Salary Processing Lines".Amount);
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code", DActivity);
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code", "Salary Processing Lines"."Global Dimension 2 Code");
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;
                    end;
                    if Account.Get("Salary Processing Lines"."Account No.") then begin
                        DActivity2 := Account."Global Dimension 1 Code";
                        DBranch2 := Account."Global Dimension 2 Code";
                        //Check Account Bal
                        AvailableBal := 0;
                        Account.CalcFields(Account.Balance, Account."Uncleared Cheques", Account."ATM Transactions");
                        AvailableBal := (Account.Balance - (Account."Uncleared Cheques" + Account."ATM Transactions"));
                        if AccountTypeS.Get(Account."Account Type") then
                            AvailableBal := AvailableBal - AccountTypeS."Minimum Balance";
                        if AvailableBal < 0 then
                            AvailableBal := 0;
                        LineNo := LineNo + 1000;
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := 'GENERAL';
                        GenJournalLine."Journal Batch Name" := 'SALARIES';
                        GenJournalLine."Line No." := LineNo;
                        GenJournalLine."Document No." := SalaryHeader."Document No";
                        GenJournalLine."External Document No." := "Salary Processing Lines"."Branch Reff.";
                        GenJournalLine."Posting Date" := SalaryHeader."Posting date";
                        if "Salary Processing Lines"."Account No." = '350010' then
                            GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account"
                        else
                            GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                        GenJournalLine.Validate(GenJournalLine."Account No.", "Salary Processing Lines"."Account No.");
                        //GenJournalLine."Salary SMS" := TRUE;-Surestep
                        if (Account."Account Category" = Account."account category"::Branch)
                        or ("Salary Processing Lines"."Account No." = '350010') then
                            GenJournalLine.Description := "Salary Processing Lines".Name
                        else
                            GenJournalLine.Description := 'Salary';
                        if SittingAll = true then
                            GenJournalLine.Description := Remarks;
                        GenJournalLine.Validate(GenJournalLine.Amount, -"Salary Processing Lines".Amount);
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code", DActivity);
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code", "Salary Processing Lines"."Global Dimension 2 Code");
                        if GenJournalLine.Amount <> 0 then begin
                            GenJournalLine.Insert;
                            //Send SMS
                            FnSendSMS("Salary Processing Lines"."Account No.", Account."Mobile Phone No");
                        end;
                        //Salary Processing Fee
                        if (Account."Account Category" <> Account."account category"::Branch) and
                           ("Salary Processing Lines"."Account No." <> '350010') then begin
                            LineNo := LineNo + 1000;
                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name" := 'GENERAL';
                            GenJournalLine."Journal Batch Name" := 'SALARIES';
                            GenJournalLine."Line No." := LineNo;
                            GenJournalLine."Document No." := SalaryHeader."Document No";
                            GenJournalLine."Posting Date" := SalaryHeader."Posting date";
                            GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                            GenJournalLine.Validate(GenJournalLine."Account No.", "Salary Processing Lines"."Account No.");
                            if SittingAll = true then
                                GenJournalLine.Description := 'Processing Fee'
                            else
                                GenJournalLine.Description := 'Salary Processing Fee';
                            GenJournalLine.Amount := (SalFee + ExciseFee);
                            //GenJournalLine.VALIDATE(GenJournalLine.Amount,SalFee);
                            //GenJournalLine."Bal. Account Type":=GenJournalLine."Bal. Account Type"::"G/L Account";
                            //GenJournalLine.VALIDATE(GenJournalLine."Bal. Account No.",SalGLAccount);
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code", DActivity2);
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code", DBranch2);
                            if GenJournalLine.Amount <> 0 then
                                GenJournalLine.Insert;
                        end;
                        //SALARY PROCESSING FEE
                        LineNo := LineNo + 1000;
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := 'GENERAL';
                        GenJournalLine."Journal Batch Name" := 'SALARIES';
                        GenJournalLine."Line No." := LineNo;
                        GenJournalLine."Document No." := SalaryHeader."Document No";
                        GenJournalLine."Posting Date" := SalaryHeader."Posting date";
                        GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                        GenJournalLine."Account No." := SalGLAccount;
                        GenJournalLine.Validate(GenJournalLine."Account No.", SalGLAccount);   //"Salary Processing Lines"."Account No.");
                        GenJournalLine.Description := 'Salary Processing Fee';
                        GenJournalLine.Amount := SalFee * -1;
                        //GenJournalLine."Bal. Account Type":=GenJournalLine."Bal. Account Type"::"G/L Account";
                        //GenJournalLine.VALIDATE(GenJournalLine."Bal. Account No.",ExciseGLAccount);
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code", DActivity2);
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code", DBranch2);
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;
                        //EXCISE DUTY ON SALARY FEE
                        LineNo := LineNo + 1000;
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := 'GENERAL';
                        GenJournalLine."Journal Batch Name" := 'SALARIES';
                        GenJournalLine."Line No." := LineNo;
                        GenJournalLine."Document No." := SalaryHeader."Document No";
                        GenJournalLine."Posting Date" := SalaryHeader."Posting date";
                        GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                        GenJournalLine.Validate(GenJournalLine."Account No.", ExciseGLAccount);   //"Salary Processing Lines"."Account No.");
                        if SittingAll = true then
                            GenJournalLine.Description := ' 10% Excise Duty on Processing Fee'
                        else
                            GenJournalLine.Description := '10% Excise Duty on Salary Processing Fee';
                        //GenJournalLine.VALIDATE(GenJournalLine.Amount,ExciseFee);
                        GenJournalLine.Amount := ExciseFee * -1;
                        //GenJournalLine."Bal. Account Type":=GenJournalLine."Bal. Account Type"::"G/L Account";
                        //GenJournalLine.VALIDATE(GenJournalLine."Bal. Account No.",ExciseGLAccount);
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code", DActivity2);
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code", DBranch2);
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;
                        //EXCISE DUTY ON SALARY FEE
                        /*//SMS CHARGES
                        GenLedgerSetup.RESET;
                        GenLedgerSetup.GET;
                        IF GenLedgerSetup."Salary SMS Charge" <> '' THEN BEGIN
                        Charges1.RESET;
                        Charges1.SETRANGE(Charges1.Code,GenLedgerSetup."Salary SMS Charge");
                        IF Charges1.FIND('-') THEN BEGIN
                        Charges1.TESTFIELD(Charges1."GL Account");
                        SMSCharge := Charges1."Charge Amount";
                        Vend1.RESET;
                        Vend1.SETRANGE(Vend1."No.","Salary Processing Lines"."Account No.");
                        IF Vend1.FIND('-') THEN BEGIN
                        IF Vend1."Phone No." <> '' THEN BEGIN
                        LineNo:=LineNo+1000;
                        GenJournalLine.INIT;
                        GenJournalLine."Journal Template Name":='GENERAL';
                        GenJournalLine."Journal Batch Name":='SALARIES';
                        GenJournalLine."Line No.":=LineNo;
                        GenJournalLine."Document No.":=DocNo;
                        GenJournalLine."External Document No.":="Salary Processing Lines"."Branch Reff.";
                        GenJournalLine."Posting Date":=PDate;
                        GenJournalLine."Account Type":=GenJournalLine."Account Type"::"G/L Account";
                        GenJournalLine."Account No.":=Charges1."GL Account";
                        GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                        GenJournalLine.Description:=Charges1.Description;
                        GenJournalLine.Amount:=-SMSCharge;
                        GenJournalLine."Shortcut Dimension 1 Code":=DActivity;
                        GenJournalLine."Shortcut Dimension 2 Code":=DBranch;
                        GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                        GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                        GenJournalLine.VALIDATE(GenJournalLine.Amount);
                        IF GenJournalLine.Amount<>0 THEN
                        GenJournalLine.INSERT;
                        END;
                        END;
                        END;
                        END;*/
                        //Loans Recovery
                        if SalaryHeader."Exempt Loan Repayment" = false then begin
                            if Account."Account Category" <> Account."account category"::Branch then
                                RunBal := ("Salary Processing Lines".Amount - SalFee - SMSCharge) + AvailableBal;
                            //Interest
                            Loans.Reset;
                            Loans.SetCurrentkey(Source, "Client Code", "Loan Product Type", "Issued Date");
                            //Loans.SETRANGE(Loans."Client Code","Salary Processing Lines"."Account No.");
                            Loans.SetRange(Loans."BOSA No", "Salary Processing Lines"."BOSA No");
                            Loans.SetRange(Loans."Issued Date", 0D, IssueDate);
                            Loans.SetFilter(Loans."Period Date Filter", GetFilter("Date Filter"));
                            //Loans.SETFILTER(Loans."Loan Product Type",'HSFSPECIAL|HSFADVANCE|FOSAKARIBU|HSF OKOA|HSFDEF|DEFAULTED|DEFAULTER1|DEFAULTED2');
                            Loans.SetFilter(Loans.Source, 'FOSA');
                            if Loans.Find('-') then begin
                                repeat
                                    if LoanType.Get(Loans."Loan Product Type") then begin
                                        if LoanType."Recovery Method" = LoanType."recovery method"::"Salary " then begin
                                            if RunBal > 0 then begin
                                                Loans.CalcFields(Loans."Outstanding Balance", Loans."Outstanding Interest");
                                                //IF Loans."Outstanding Balance" > 0 THEN BEGIN
                                                if Loans."Outstanding Interest" > 0 then begin
                                                    Interest := 0;
                                                    Interest := Loans."Outstanding Interest";
                                                    if Interest > 0 then begin
                                                        LineNo := LineNo + 10000;
                                                        GenJournalLine.Init;
                                                        GenJournalLine."Journal Template Name" := 'GENERAL';
                                                        GenJournalLine."Journal Batch Name" := 'SALARIES';
                                                        GenJournalLine."Line No." := LineNo;
                                                        GenJournalLine."Account Type" := GenJournalLine."account type"::Member;
                                                        //GenJournalLine.VALIDATE(GenJournalLine."Account No.","Salary Processing Lines"."Account No.");
                                                        if Loans."Issued Date" < 20160511D then begin
                                                            GenJournalLine."Account No." := "Salary Processing Lines"."BOSA No"
                                                        end else
                                                            GenJournalLine."Account No." := "Salary Processing Lines"."Account No.";
                                                        GenJournalLine."Document No." := SalaryHeader."Document No";
                                                        GenJournalLine."Posting Date" := SalaryHeader."Posting date";
                                                        GenJournalLine.Description := 'Interest Paid';
                                                        if RunBal > Interest then
                                                            GenJournalLine.Validate(GenJournalLine.Amount, Interest * -1)
                                                        else
                                                            GenJournalLine.Validate(GenJournalLine.Amount, RunBal * -1);
                                                        GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Insurance Contribution";
                                                        GenJournalLine.Validate(GenJournalLine."Loan No", Loans."Loan  No.");
                                                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code", DActivity2);
                                                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code", DBranch2);
                                                        if GenJournalLine.Amount <> 0 then
                                                            GenJournalLine.Insert;
                                                        LineNo := LineNo + 10000;
                                                        GenJournalLine.Init;
                                                        GenJournalLine."Journal Template Name" := 'GENERAL';
                                                        GenJournalLine."Journal Batch Name" := 'SALARIES';
                                                        GenJournalLine."Line No." := LineNo;
                                                        GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                                        GenJournalLine.Validate(GenJournalLine."Account No.", "Salary Processing Lines"."Account No.");
                                                        GenJournalLine."Document No." := SalaryHeader."Document No";
                                                        GenJournalLine."Posting Date" := SalaryHeader."Posting date";
                                                        GenJournalLine.Description := 'Interest Paid - ' + Loans."Loan Product Type";
                                                        if RunBal > Interest then
                                                            GenJournalLine.Validate(GenJournalLine.Amount, Interest)
                                                        else
                                                            GenJournalLine.Validate(GenJournalLine.Amount, RunBal);
                                                        GenJournalLine.Validate(GenJournalLine."Loan No", Loans."Loan  No.");
                                                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code", DActivity2);
                                                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code", DBranch2);
                                                        if GenJournalLine.Amount <> 0 then
                                                            GenJournalLine.Insert;
                                                        RunBal := RunBal - Abs(GenJournalLine.Amount);
                                                    end;
                                                end;
                                            end;
                                        end;
                                    end;
                                until Loans.Next = 0;
                            end;
                            MonthlyInt := 0;
                            //Priciple
                            Loans.Reset;
                            Loans.SetCurrentkey(Source, "Client Code", "Loan Product Type", "Issued Date");
                            //Loans.SETRANGE(Loans."Client Code","Salary Processing Lines"."Account No.");
                            Loans.SetRange(Loans."BOSA No", "Salary Processing Lines"."BOSA No");
                            Loans.SetRange(Loans."Issued Date", 0D, IssueDate);
                            Loans.SetFilter(Loans."Period Date Filter", GetFilter("Date Filter"));
                            //Loans.SETFILTER(Loans."Loan Product Type",'HSFSPECIAL|HSFADVANCE|FOSAKARIBU|HSF OKOA|HSFDEF|DEFAULTED|DEFAULTER1|DEFAULTED2');
                            Loans.SetFilter(Loans.Source, 'FOSA');
                            if Loans.Find('-') then begin
                                repeat
                                    if Loans."Issued Date" < 20160511D then begin
                                        CustLedger.Reset;
                                        CustLedger.SetCurrentkey(CustLedger."Posting Date", CustLedger."Customer No.");
                                        CustLedger.SetRange(CustLedger."Customer No.", Loans."BOSA No");
                                        CustLedger.SetRange(CustLedger."Loan No", Loans."Loan  No.");
                                        CustLedger.SetRange(CustLedger."Transaction Type", CustLedger."transaction type"::"Deposit Contribution");
                                        if CustLedger.FindLast then begin
                                            MonthlyInt := CustLedger.Amount;
                                        end;
                                    end else
                                        CustLedger.Reset;
                                    CustLedger.SetCurrentkey(CustLedger."Posting Date", CustLedger."Customer No.");
                                    CustLedger.SetRange(CustLedger."Customer No.", Loans."Account No");
                                    CustLedger.SetRange(CustLedger."Loan No", Loans."Loan  No.");
                                    CustLedger.SetRange(CustLedger."Transaction Type", CustLedger."transaction type"::"Deposit Contribution");
                                    if CustLedger.FindLast then begin
                                        MonthlyInt := CustLedger.Amount;
                                    end;
                                    if LoanType.Get(Loans."Loan Product Type") then begin
                                        if LoanType."Recovery Method" = LoanType."recovery method"::"Salary " then begin
                                            if RunBal > 0 then begin
                                                Loans.CalcFields(Loans."Outstanding Balance", Loans."Interest Due");
                                                if Loans."Outstanding Balance" > 0 then begin
                                                    TotalMRepay := 0;
                                                    LPrincipal := 0;
                                                    LInterest := 0;
                                                    InterestRate := Loans.Interest;
                                                    LoanAmount := Loans."Approved Amount";
                                                    RepayPeriod := Loans.Installments;
                                                    LBalance := Loans."Approved Amount";
                                                    if Loans."Loan Product Type" = 'HSFDEF' then
                                                        LRepayment := ROUND(Loans."Outstanding Balance" / Loans.Installments, 0.05, '>')
                                                    else begin
                                                        if Loans."Adjted Repayment" <> 0 then
                                                            LRepayment := Loans."Adjted Repayment" - MonthlyInt
                                                        else
                                                            LRepayment := Loans.Repayment - MonthlyInt;
                                                    end;
                                                    Loans.CalcFields(Loans."Outstanding Balance");
                                                    if Loans."Loan Product Type" = 'FL353' then begin
                                                        LRepayment := Loans."Outstanding Balance";
                                                    end;
                                                    if LRepayment = 0 then
                                                        LRepayment := Loans.Repayment;
                                                    LineNo := LineNo + 10000;
                                                    GenJournalLine.Init;
                                                    GenJournalLine."Journal Template Name" := 'GENERAL';
                                                    GenJournalLine."Journal Batch Name" := 'SALARIES';
                                                    GenJournalLine."Line No." := LineNo;
                                                    GenJournalLine."Account Type" := GenJournalLine."account type"::Member;
                                                    //GenJournalLine.VALIDATE(GenJournalLine."Account No.","Salary Processing Lines"."Account No.");
                                                    if Loans."Issued Date" < 20160511D then begin
                                                        GenJournalLine."Account No." := "Salary Processing Lines"."BOSA No"
                                                    end else
                                                        GenJournalLine."Account No." := "Salary Processing Lines"."Account No.";
                                                    GenJournalLine."Document No." := SalaryHeader."Document No";
                                                    GenJournalLine."Posting Date" := SalaryHeader."Posting date";
                                                    GenJournalLine.Description := 'Loan Repayment';
                                                    if RunBal > LRepayment then
                                                        GenJournalLine.Validate(GenJournalLine.Amount, LRepayment * -1)
                                                    else
                                                        GenJournalLine.Validate(GenJournalLine.Amount, RunBal * -1);
                                                    GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Interest Paid";
                                                    GenJournalLine.Validate(GenJournalLine."Loan No", Loans."Loan  No.");
                                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code", DActivity2);
                                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code", DBranch2);
                                                    if GenJournalLine.Amount <> 0 then
                                                        GenJournalLine.Insert;
                                                    LineNo := LineNo + 10000;
                                                    GenJournalLine.Init;
                                                    GenJournalLine."Journal Template Name" := 'GENERAL';
                                                    GenJournalLine."Journal Batch Name" := 'SALARIES';
                                                    GenJournalLine."Line No." := LineNo;
                                                    GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                                    GenJournalLine.Validate(GenJournalLine."Account No.", "Salary Processing Lines"."Account No.");
                                                    GenJournalLine."Document No." := SalaryHeader."Document No";
                                                    GenJournalLine."Posting Date" := SalaryHeader."Posting date";
                                                    GenJournalLine.Description := 'Loan Repayment - ' + Loans."Loan Product Type";
                                                    if RunBal > LRepayment then
                                                        GenJournalLine.Validate(GenJournalLine.Amount, LRepayment)
                                                    else
                                                        GenJournalLine.Validate(GenJournalLine.Amount, RunBal);
                                                    GenJournalLine.Validate(GenJournalLine."Loan No", Loans."Loan  No.");
                                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code", DActivity2);
                                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code", DBranch2);
                                                    if GenJournalLine.Amount <> 0 then
                                                        GenJournalLine.Insert;
                                                    RunBal := RunBal - Abs(GenJournalLine.Amount);
                                                end;
                                            end;
                                        end;
                                    end;
                                until Loans.Next = 0;
                            end;
                        end;
                    end else begin
                        "Salary Processing Lines"."Account Not Found" := true;
                    end;
                end;
                "Salary Processing Lines"."Document No." := DocNo;
                "Salary Processing Lines".Date := PDate;
                "Salary Processing Lines".Modify;
                //Mark Salaried Accounts
                if Account.Get("Salary Processing Lines"."Account No.") then begin
                    Account."Salary Processing" := true;
                    Account.Modify;
                end;

            end;

            trigger OnPostDataItem();
            begin
                //Balance With Employer--------------------------------------------------------------
                if SalaryHeader.Get("Salary Header No.") then begin
                    LineNo := LineNo + 10000;
                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := 'GENERAL';
                    GenJournalLine."Journal Batch Name" := 'SALARIES';
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Account Type" := SalaryHeader."Account Type";
                    GenJournalLine."Account No." := SalaryHeader."Account No";
                    GenJournalLine."External Document No." := SalaryHeader."Cheque No.";
                    GenJournalLine."Document No." := SalaryHeader."Document No";
                    GenJournalLine."Posting Date" := SalaryHeader."Posting date";
                    GenJournalLine.Description := SalaryHeader.Remarks;
                    GenJournalLine.Amount := SalaryHeader.Amount;
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code", DActivity2);
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code", DBranch2);
                    //IF GenJournalLine.Amount<>0 THEN
                    GenJournalLine.Insert;
                end;
                //End Balance With Employer--------------------------------------------------------------
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
                field("Last Loan Issue Date"; IssueDate)
                {
                    ApplicationArea = Basic;
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
        GenJournalLine: Record "Gen. Journal Line";
        GLPosting: Codeunit "Gen. Jnl.-Post Line";
        Account: Record Vendor;
        AccountType: Record "Account Types-Saving Products";
        AvailableBal: Decimal;
        STORegister: Record "Standing Order Register";
        AmountDed: Decimal;
        DedStatus: Option Successfull,"Partial Deduction",Failed;
        Charges: Record Charges;
        LineNo: Integer;
        DocNo: Code[20];
        PDate: Date;
        SalFee: Decimal;
        SalGLAccount: Code[20];
        Loans: Record "Loans Register";
        LRepayment: Decimal;
        RunBal: Decimal;
        Interest: Decimal;
        SittingAll: Boolean;
        UsersID: Record User;
        DActivity: Code[20];
        DBranch: Code[20];
        AccountS: Record Vendor;
        AccountTypeS: Record "Account Types-Saving Products";
        IssueDate: Date;
        DActivity2: Code[20];
        DBranch2: Code[20];
        DActivity3: Code[20];
        DBranch3: Code[20];
        BOSABank: Code[20];
        ReceiptAllocations: Record "Receipt Allocation";
        STORunBal: Decimal;
        ReceiptAmount: Decimal;
        StandingOrders: Record "Standing Orders";
        AccountCard: Record Vendor;
        AccountCard2: Record Vendor;
        FlexContribution: Decimal;
        FlexAccountNo: Code[20];
        ActualSTO: Decimal;
        InsCont: Decimal;
        LoanType: Record "Loan Products Setup";
        Remarks: Text[50];
        DontEffect: Boolean;
        TotalMRepay: Decimal;
        InterestRate: Decimal;
        LPrincipal: Decimal;
        LInterest: Decimal;
        LoanAmount: Decimal;
        RepayPeriod: Integer;
        LBalance: Decimal;
        Schedule: Record "Loan Repayment Schedule";
        Salary_Allowance_Processing_BufferCaptionLbl: label 'Salary/Allowance Processing Buffer';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        Vend1: Record Vendor;
        Charges1: Record Charges;
        SMSCharge: Decimal;
        GenLedgerSetup: Record "General Ledger Setup";
        ExciseGLAccount: Code[10];
        ExciseFee: Decimal;
        SalaryHeader: Record "Salary Processing Headerr";
        ELoanBuffer: Record "E-Loan Salary Buffer";
        CustLedger: Record "Member Ledger Entry";
        MonthlyInt: Decimal;

    procedure PostBOSAEntries()
    var
        ReceiptAllocation: Record "Receipt Allocation";
    begin
        if AmountDed > 0 then begin
            STORunBal := AmountDed;
            ReceiptAllocations.Reset;
            ReceiptAllocations.SetRange(ReceiptAllocations."Document No", StandingOrders."No.");
            //ReceiptAllocations.SETRANGE(ReceiptAllocations."Member No",StandingOrders."BOSA Account No.");
            if ReceiptAllocations.Find('-') then begin
                if ReceiptAllocations.Get("Standing Orders"."BOSA Account No.") then begin
                    repeat
                        ReceiptAllocations."Amount Balance" := 0;
                        ReceiptAllocations."Interest Balance" := 0;
                        ReceiptAmount := ReceiptAllocations.Amount;//-ReceiptAllocations."Amount Balance";
                                                                   //Check Loan Balances
                                                                   /*IF ReceiptAllocations."Transaction Type" = ReceiptAllocations."Transaction Type"::Repayment THEN BEGIN
                                                                   Loans.RESET;
                                                                   Loans.SETRANGE(Loans."Loan  No.",ReceiptAllocations."Loan No.");
                                                                   IF Loans.FIND('-') THEN BEGIN
                                                                   Loans.CALCFIELDS(Loans."Outstanding Balance");
                                                                   IF ReceiptAmount > Loans."Outstanding Balance" THEN
                                                                   ReceiptAmount := Loans."Outstanding Balance";
                                                                   END ELSE
                                                                   ERROR('Loan No. %1 not Found. :- %2',ReceiptAllocations."Loan No.",ReceiptAllocations."Document No");
                                                                   END;*/
                        if ReceiptAmount < 0 then
                            ReceiptAmount := 0;
                        if STORunBal < 0 then
                            STORunBal := 0;
                        LineNo := LineNo + 10000;
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := 'GENERAL';
                        GenJournalLine."Journal Batch Name" := 'SALARIES';
                        GenJournalLine."Line No." := LineNo;
                        GenJournalLine."Document No." := SalaryHeader."Document No";
                        GenJournalLine."External Document No." := StandingOrders."No.";
                        GenJournalLine."Posting Date" := SalaryHeader."Posting date";
                        GenJournalLine."Account Type" := GenJournalLine."bal. account type"::Employee;
                        GenJournalLine."Account No." := ReceiptAllocations."Member No";
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine.Description := Format(ReceiptAllocations."Transaction Type");
                        if STORunBal > ReceiptAmount then
                            GenJournalLine.Amount := -ReceiptAmount
                        else
                            GenJournalLine.Amount := -STORunBal;
                        if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"Loan Penalty Paid" then begin
                            if Abs(GenJournalLine.Amount) = 100 then
                                InsCont := 100;
                            GenJournalLine.Amount := -25;
                        end;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"Benevolent Fund" then
                            GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Benevolent Fund"
                        else
                            if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::Loan then
                                GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::Loan
                            else
                                if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::" " then
                                    GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::" "
                                else
                                    if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"Interest Paid" then
                                        GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Interest Paid"
                                    else
                                        if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"Registration Fee" then
                                            GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Registration Fee"
                                        else
                                            if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"Recovery Account" then
                                                GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Recovery Account";
                        GenJournalLine."Loan No" := ReceiptAllocations."Loan No.";
                        //IF GenJournalLine.Amount<>0 THEN
                        GenJournalLine.Insert;
                        ReceiptAllocations."Amount Balance" := ReceiptAllocations."Amount Balance" + (GenJournalLine.Amount * -1);
                        STORunBal := STORunBal + GenJournalLine.Amount;
                        ActualSTO := ActualSTO + (GenJournalLine.Amount * -1);
                        if (ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"Loan Penalty Paid")
                           and (InsCont = 100) then begin
                            LineNo := LineNo + 10000;
                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name" := 'GENERAL';
                            GenJournalLine."Journal Batch Name" := 'SALARIES';
                            GenJournalLine."Line No." := LineNo;
                            GenJournalLine."Document No." := SalaryHeader."Document No";
                            GenJournalLine."External Document No." := StandingOrders."No.";
                            GenJournalLine."Posting Date" := SalaryHeader."Posting date";
                            GenJournalLine."Account Type" := GenJournalLine."bal. account type"::Employee;
                            GenJournalLine."Account No." := ReceiptAllocations."Member No";
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine.Description := Format(ReceiptAllocations."Transaction Type");
                            GenJournalLine.Amount := -75;
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            //GenJournalLine."Transaction Type":=GenJournalLine."Transaction Type"::BOSAEXC;
                            GenJournalLine."Loan No" := ReceiptAllocations."Loan No.";
                            //IF GenJournalLine.Amount<>0 THEN
                            GenJournalLine.Insert;
                            ReceiptAllocations."Amount Balance" := ReceiptAllocations."Amount Balance" + (GenJournalLine.Amount * -1);
                            STORunBal := STORunBal + GenJournalLine.Amount;
                            ActualSTO := ActualSTO + (GenJournalLine.Amount * -1);
                        end;
                        if STORunBal < 0 then
                            STORunBal := 0;
                        if (ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"Interest Paid") and
                           (ReceiptAllocations."Interest Amount" > 0) then begin
                            LineNo := LineNo + 10000;
                            ReceiptAmount := ReceiptAllocations."Interest Amount";
                            //Check Outstanding Interest
                            Loans.Reset;
                            Loans.SetRange(Loans."Loan  No.", ReceiptAllocations."Loan No.");
                            if Loans.Find('-') then begin
                                Loans.CalcFields(Loans."Outstanding Interest");
                                if ReceiptAmount > Loans."Outstanding Interest" then
                                    ReceiptAmount := Loans."Outstanding Interest";
                            end else
                                Error('Loan No. %1 not Found. :- %2', ReceiptAllocations."Loan No.", ReceiptAllocations."Document No");
                            if ReceiptAmount < 0 then
                                ReceiptAmount := 0;
                            if ReceiptAmount > 0 then begin
                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := 'GENERAL';
                                GenJournalLine."Journal Batch Name" := 'SALARIES';
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Document No." := SalaryHeader."Document No";
                                GenJournalLine."External Document No." := StandingOrders."No.";
                                GenJournalLine."Posting Date" := SalaryHeader."Posting date";
                                GenJournalLine."Account Type" := GenJournalLine."bal. account type"::Employee;
                                GenJournalLine."Account No." := ReceiptAllocations."Member No";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine.Description := 'Interest Paid';
                                if STORunBal > ReceiptAmount then
                                    GenJournalLine.Amount := -ReceiptAmount
                                else
                                    GenJournalLine.Amount := -STORunBal;
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Insurance Contribution";
                                GenJournalLine."Loan No" := ReceiptAllocations."Loan No.";
                                //IF GenJournalLine.Amount<>0 THEN
                                GenJournalLine.Insert;
                                ReceiptAllocations."Interest Balance" := ReceiptAllocations."Interest Balance" + (GenJournalLine.Amount * -1);
                                STORunBal := STORunBal + GenJournalLine.Amount;
                                ActualSTO := ActualSTO + (GenJournalLine.Amount * -1);
                            end;
                        end;
                        ReceiptAllocations.Modify;
                    until ReceiptAllocations.Next = 0;
                end;
            end;
        end;

    end;

    local procedure FnSendSMS(AccountNo: Code[100]; PhoneNumber: Code[50])
    var
        SMSMessage: Record "SMS Messages";
        iEntryNo: Integer;
    begin
        //SMS MESSAGE
        SMSMessage.Reset;
        if SMSMessage.Find('+') then begin
            iEntryNo := SMSMessage."Entry No";
            iEntryNo := iEntryNo + 1;
        end
        else begin
            iEntryNo := 1;
        end;
        SMSMessage.LockTable;
        SMSMessage.Reset;
        SMSMessage.Init;
        SMSMessage."Entry No" := iEntryNo;
        SMSMessage."Account No" := AccountNo;
        SMSMessage."Date Entered" := Today;
        SMSMessage."Time Entered" := Time;
        SMSMessage.Source := 'SAL PROCESSING';
        SMSMessage."Entered By" := UserId;
        SMSMessage."Sent To Server" := SMSMessage."sent to server"::No;
        SMSMessage."SMS Message" := 'Dear client, your salary has been credited to your account on ' + Format(Today) + ' ' + Format(Time) + '  From MAFANIKIO SACCO LTD';
        SMSMessage."Telephone No" := PhoneNumber;
        SMSMessage.Insert;
    end;


    var

}
