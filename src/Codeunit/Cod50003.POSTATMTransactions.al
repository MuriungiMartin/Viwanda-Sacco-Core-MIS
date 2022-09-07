#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Codeunit 50003 "POST ATM Transactions"
{
    Permissions = TableData "ATM Transactions" = rimd;
    TableNo = "ATM Transactions";

    trigger OnRun()
    begin
        //MESSAGE(FORMAT(DT2TIME(CURRENTDATETIME)));
    end;

    var
        GenJournalLine: Record "Gen. Journal Line";
        ATMTrans: Record "ATM Transactions";
        LineNo: Integer;
        Acct: Record Vendor;
        ATMCharges: Decimal;
        BankCharges: Decimal;
        ExciseGLAcc: Code[20];
        ExciseFee: Decimal;
        GenBatches: Record "Gen. Journal Batch";
        GLPosting: Codeunit "Gen. Jnl.-Post Line";
        ATM_CHARGES: Record "ATM Charges";
        DocNo: Code[20];
        BankAccount: Code[20];
        GLAccount: Code[20];
        Reversals2: Record "ATM Transactions";
        iEntryNo: Integer;
        SMSMessage: Record "SMS Messages";
        Vend1: Record Vendor;
        VendL: Record "Vendor Ledger Entry";
        Pos: Record "POS Commissions";
        AccountCharges: Decimal;


    procedure PostTrans(): Boolean
    var
        processed: Boolean;
        time_processed: Time;
    begin
        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
        GenJournalLine.SetRange("Journal Batch Name", 'ATMTRANS');
        GenJournalLine.DeleteAll;
        //end of deletion

        GenBatches.Reset;
        GenBatches.SetRange(GenBatches."Journal Template Name", 'GENERAL');
        GenBatches.SetRange(GenBatches.Name, 'ATMTRANS');
        if GenBatches.Find('-') = false then begin
            GenBatches.Init;
            GenBatches."Journal Template Name" := 'GENERAL';
            GenBatches.Name := 'ATMTRANS';
            GenBatches.Description := 'ATM Transactions';
            GenBatches.Validate(GenBatches."Journal Template Name");
            GenBatches.Validate(GenBatches.Name);
            GenBatches.Insert;
        end;

        ATMTrans.LockTable;
        ATMTrans.Reset;
        ATMTrans.SetRange(ATMTrans.Posted, false);
        //ATMTrans.SETRANGE(ATMTrans.Source,ATMTrans.Source::"ATM Bridge");
        if ATMTrans.Find('-') then begin
            repeat

                //INITIALIZE COMMON POSTING VALUES
                if (ATMTrans."Transaction Type Charges" = ATMTrans."transaction type charges"::"Cash Withdrawal - Coop ATM") then begin
                    BankAccount := 'BANK_0007';
                    GLAccount := '8-06-1-0018-00';
                    ExciseGLAcc := '8-01-1-0007-00';
                end else
                    if (ATMTrans."Transaction Type Charges" = ATMTrans."transaction type charges"::"Cash Withdrawal - VISA ATM") then begin
                        BankAccount := 'BANK_0007';
                        GLAccount := '8-06-1-0018-00';
                        ExciseGLAcc := '8-01-1-0007-00';
                    end else

                        if (ATMTrans."Transaction Type Charges" = ATMTrans."transaction type charges"::"M-PESA Withdrawal") then begin
                            BankAccount := 'BANK_0007';
                            GLAccount := '8-06-1-0018-00';
                            ExciseGLAcc := '8-01-1-0007-00';
                        end else
                            BankAccount := 'BANK_0004';
                GLAccount := '8-06-1-0019-00';
                ExciseGLAcc := '8-01-1-0007-00';

                //DocNo:='TRM'+ATMTrans."Trace ID";
                DocNo := ATMTrans."Reference No";
                ATMCharges := 0;
                BankCharges := 0;
                ExciseFee := 0;

                ATM_CHARGES.Reset;
                ATM_CHARGES.SetRange(ATM_CHARGES."Transaction Type", ATMTrans."Transaction Type Charges");
                if (ATM_CHARGES.Find('-')) then begin
                    ATMCharges := ATM_CHARGES."Total Amount";
                    BankCharges := ATMCharges - ATM_CHARGES."Sacco Amount";

                    /*IF (ATMTrans."Transaction Type Charges"=ATMTrans."Transaction Type Charges"::"Cash Withdrawal - Coop ATM") THEN BEGIN
                    ExciseFee:=((ATMCharges-BankCharges)*0.1);
                    BankAccount:='BANK_0007';
                    END;*/

                    if (ATMTrans."Transaction Type Charges" = ATMTrans."transaction type charges"::"Cash Withdrawal - Coop ATM") then begin
                        ExciseFee := ATMCharges * 0.1;

                        BankAccount := 'BANK_0007';
                    end;

                    if (ATMTrans."Transaction Type Charges" = ATMTrans."transaction type charges"::"Cash Withdrawal - VISA ATM") then begin
                        ExciseFee := ATMCharges * 0.1;
                        BankAccount := 'BANK_0007';
                    end;
                    if (ATMTrans."Transaction Type Charges" = ATMTrans."transaction type charges"::"POS - Balance Enquiry") then begin
                        ExciseFee := ATMCharges * 0.1;
                        BankAccount := 'BANK_0004';
                    end;
                    if (ATMTrans."Transaction Type Charges" = ATMTrans."transaction type charges"::"POS - Cash Withdrawal") then begin
                        ExciseFee := ATMCharges * 0.1;
                        BankAccount := 'BANK_0004';
                    end;
                    if (ATMTrans."Transaction Type Charges" = ATMTrans."transaction type charges"::"POS - Mini Statement") then begin
                        ExciseFee := ATMCharges * 0.1;
                        BankAccount := 'BANK_0004';
                    end;

                end;
                Message(Format(BankAccount));
                //**************************IF REVERSAL, THEN REVERSE THE SIGN*******************************
                if ATMTrans."Transaction Type Charges" = ATMTrans."transaction type charges"::Reversal then begin
                    Reversals2.Reset;
                    Reversals2.SetRange(Reversals2."Trace ID", ATMTrans."Reversal Trace ID");
                    //Reversals2.SETRANGE(Reversals2."Reference No",ATMTrans."Reversal Trace ID");
                    //Reversals2.SETRANGE(Reversals2."Reference No",ATMTrans."Reference No");
                    Reversals2.SetRange(Reversals2."Account No", ATMTrans."Account No");
                    Reversals2.SetRange(Reversals2.Reversed, false);
                    //Reversals2.SETRANGE(Reversals2.Amount,ATMTrans.Amount);

                    if (Reversals2.Find('-')) then begin
                        ATM_CHARGES.Reset;
                        ATM_CHARGES.SetRange(ATM_CHARGES."Transaction Type", Reversals2."Transaction Type Charges");

                        if (ATM_CHARGES.Find('-')) then begin
                            ATMCharges := ATM_CHARGES."Total Amount";
                            BankCharges := ATMCharges - ATM_CHARGES."Sacco Amount";


                            ATMCharges := ATMCharges * (-1);
                            BankCharges := BankCharges * (-1);

                            if (Reversals2."Transaction Type Charges" = Reversals2."transaction type charges"::"Cash Withdrawal - Coop ATM") then
                                ExciseFee := -(((ATM_CHARGES."Total Amount") - (ATM_CHARGES."Total Amount" - ATM_CHARGES."Sacco Amount")) * 0.1);

                            if (Reversals2."Transaction Type Charges" = Reversals2."transaction type charges"::"Cash Withdrawal - VISA ATM") then
                                ExciseFee := -(((ATM_CHARGES."Total Amount") - (ATM_CHARGES."Total Amount" - ATM_CHARGES."Sacco Amount")) * 0.1);


                        end;
                    end;
                end;


                if (ATMTrans."Transaction Type Charges" >= ATMTrans."transaction type charges"::"POS - School Payment") then begin
                    if (ATMTrans."Transaction Type Charges" = ATMTrans."transaction type charges"::"POS - Cash Withdrawal") then
                        if (ATMTrans."POS Vendor" = ATMTrans."pos vendor"::"Coop Branch POS") then ATMCharges := 100;//refer to e-mail from coop bank

                    BankCharges := ATMCharges - ATM_CHARGES."Sacco Amount";
                end;

                if ATMTrans."Transaction Type Charges" = ATMTrans."transaction type charges"::"POS - Cash Withdrawal" then begin
                    Pos.Reset;
                    Pos.SetFilter(Pos."Lower Limit", '<=%1', ATMTrans.Amount);
                    Pos.SetFilter(Pos."Upper Limit", '>=%1', ATMTrans.Amount);
                    if Pos.FindFirst then begin
                        ATMCharges := Pos."Charge Amount";
                        BankCharges := Pos."Bank charge";
                    end;
                end;

                if Acct.Get(ATMTrans."Account No") then begin

                    //ATM Transaction
                    LineNo := LineNo + 10000;

                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := 'GENERAL';
                    GenJournalLine."Journal Batch Name" := 'ATMTRANS';
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                    GenJournalLine."Account No." := ATMTrans."Account No";
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Document No." := DocNo;
                    GenJournalLine."Posting Date" := ATMTrans."Posting Date";
                    //GenJournalLine.Description:=ATMTrans.Description;
                    GenJournalLine.Description := Format(ATMTrans."Transaction Type Charges");
                    GenJournalLine.Amount := ATMTrans.Amount;
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    GenJournalLine."ATM SMS" := true;
                    GenJournalLine."Trace ID" := ATMTrans."Trace ID";
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;


                    LineNo := LineNo + 10000;

                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := 'GENERAL';
                    GenJournalLine."Journal Batch Name" := 'ATMTRANS';
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Account Type" := GenJournalLine."account type"::"Bank Account";
                    GenJournalLine."Account No." := BankAccount;
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Document No." := DocNo;
                    GenJournalLine."External Document No." := ATMTrans."Account No";
                    GenJournalLine."Posting Date" := ATMTrans."Posting Date";
                    GenJournalLine.Description := Acct.Name;
                    GenJournalLine.Amount := ATMTrans.Amount * -1;
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    GenJournalLine."Shortcut Dimension 1 Code" := Acct."Global Dimension 1 Code";
                    GenJournalLine."Shortcut Dimension 2 Code" := Acct."Global Dimension 2 Code";
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                    if GenJournalLine.Amount <> 0 then GenJournalLine.Insert;

                    LineNo := LineNo + 10000;

                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := 'GENERAL';
                    GenJournalLine."Journal Batch Name" := 'ATMTRANS';
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                    GenJournalLine."Account No." := ATMTrans."Account No";
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Document No." := DocNo;
                    GenJournalLine."Posting Date" := ATMTrans."Posting Date";
                    GenJournalLine.Description := ATMTrans.Description + ' Charges';
                    GenJournalLine.Amount := ATMCharges;
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;

                    //EXCISE PASSED TO VENDOR
                    LineNo := LineNo + 10000;

                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := 'GENERAL';
                    GenJournalLine."Journal Batch Name" := 'ATMTRANS';
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                    GenJournalLine."Account No." := ATMTrans."Account No";
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Document No." := DocNo;//ATMTrans."Reference No";
                    if ATMTrans."Transaction Type Charges" = ATMTrans."transaction type charges"::Reversal then begin
                        GenJournalLine."Document No." := DocNo;//ATMTrans."Reference No";
                    end;
                    GenJournalLine."Posting Date" := ATMTrans."Posting Date";
                    GenJournalLine.Description := ATMTrans."Transaction Description" + ' ' + ' Excise Duty Charges';
                    GenJournalLine.Amount := ExciseFee;
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;
                    //EXCISE PASSED TO VENDOR


                    /* //EXCISE DUTY TO G/L ACCOUNT
                     LineNo:=LineNo+10000;

                     GenJournalLine.INIT;
                     GenJournalLine."Journal Template Name":='GENERAL';
                     GenJournalLine."Journal Batch Name":='ATMTRANS';
                     GenJournalLine."Line No.":=LineNo;
                     GenJournalLine."Account Type":=GenJournalLine."Account Type"::"G/L Account";
                     GenJournalLine."Account No.":=ExciseGLAcc;
                     GenJournalLine."Document No.":=DocNo;//ATMTrans."Reference No";
                     GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                     GenJournalLine."Posting Date":=ATMTrans."Posting Date";
                     GenJournalLine.Description:='10% Excise Duty Charges on ATM Transactions.';//maf
                     GenJournalLine.Amount:=(ExciseFee-BankCharges)*-1;
                     GenJournalLine.VALIDATE(GenJournalLine.Amount);
                     GenJournalLine."Shortcut Dimension 1 Code":=Acct."Global Dimension 1 Code";
                     GenJournalLine."Shortcut Dimension 2 Code":=Acct."Global Dimension 2 Code";
                     GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                     GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                     IF GenJournalLine.Amount<>0 THEN
                     GenJournalLine.INSERT;

                     //EXCISE DUTY TO bank

                     LineNo:=LineNo+10000;

                     GenJournalLine.INIT;
                     GenJournalLine."Journal Template Name":='GENERAL';
                     GenJournalLine."Journal Batch Name":='ATMTRANS';
                     GenJournalLine."Line No.":=LineNo;
                     GenJournalLine."Account Type":=GenJournalLine."Account Type"::"Bank Account";
                     GenJournalLine."Account No.":=BankAccount;
                     GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                     GenJournalLine."Document No.":=DocNo;
                     GenJournalLine."External Document No.":=ATMTrans."Account No";
                     GenJournalLine."Posting Date":=ATMTrans."Posting Date";
                     GenJournalLine.Description:='10% Excise Duty Charges on Transactions.'; //maf2
                     GenJournalLine.Amount:=BankCharges*-1;
                     GenJournalLine.VALIDATE(GenJournalLine.Amount);
                     GenJournalLine."Shortcut Dimension 1 Code":=Acct."Global Dimension 1 Code";
                     GenJournalLine."Shortcut Dimension 2 Code":=Acct."Global Dimension 2 Code";
                     GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                     GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                     IF GenJournalLine.Amount<>0 THEN
                     GenJournalLine.INSERT;
                 //Bank Work
                 */

                    //Excise New Mafanikio
                    LineNo := LineNo + 10000;

                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := 'GENERAL';
                    GenJournalLine."Journal Batch Name" := 'ATMTRANS';
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Account Type" := GenJournalLine."account type"::"Bank Account";
                    GenJournalLine."Account No." := BankAccount;
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Document No." := DocNo;
                    GenJournalLine."External Document No." := ATMTrans."Account No";
                    GenJournalLine."Posting Date" := ATMTrans."Posting Date";
                    GenJournalLine.Description := '10% Excise Duty ' + ' Charges to settlement account';
                    GenJournalLine.Amount := (BankCharges * -1) * 0.1;
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    GenJournalLine."Shortcut Dimension 1 Code" := Acct."Global Dimension 1 Code";
                    GenJournalLine."Shortcut Dimension 2 Code" := Acct."Global Dimension 2 Code";
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;

                    LineNo := LineNo + 10000;

                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := 'GENERAL';
                    GenJournalLine."Journal Batch Name" := 'ATMTRANS';
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                    GenJournalLine."Account No." := ExciseGLAcc;
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Document No." := DocNo;
                    GenJournalLine."External Document No." := ATMTrans."Account No";
                    GenJournalLine."Posting Date" := ATMTrans."Posting Date";
                    GenJournalLine.Description := Acct.Name + '-Excise';
                    GenJournalLine.Amount := ((ATMCharges - BankCharges) * -1) * 0.1;
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    GenJournalLine."Shortcut Dimension 1 Code" := Acct."Global Dimension 1 Code";
                    GenJournalLine."Shortcut Dimension 2 Code" := Acct."Global Dimension 2 Code";
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;

                    //End Excise New Mafanikio


                    LineNo := LineNo + 10000;

                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := 'GENERAL';
                    GenJournalLine."Journal Batch Name" := 'ATMTRANS';
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Account Type" := GenJournalLine."account type"::"Bank Account";
                    GenJournalLine."Account No." := BankAccount;
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Document No." := DocNo;
                    GenJournalLine."External Document No." := ATMTrans."Account No";
                    GenJournalLine."Posting Date" := ATMTrans."Posting Date";
                    GenJournalLine.Description := ATMTrans.Description + ' Charges';
                    GenJournalLine.Amount := BankCharges * -1;
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    GenJournalLine."Shortcut Dimension 1 Code" := Acct."Global Dimension 1 Code";
                    GenJournalLine."Shortcut Dimension 2 Code" := Acct."Global Dimension 2 Code";
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;

                    LineNo := LineNo + 10000;

                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := 'GENERAL';
                    GenJournalLine."Journal Batch Name" := 'ATMTRANS';
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                    GenJournalLine."Account No." := GLAccount;
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Document No." := DocNo;
                    GenJournalLine."External Document No." := ATMTrans."Account No";
                    GenJournalLine."Posting Date" := ATMTrans."Posting Date";
                    GenJournalLine.Description := Acct.Name;
                    GenJournalLine.Amount := (ATMCharges - BankCharges) * -1;
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    GenJournalLine."Shortcut Dimension 1 Code" := Acct."Global Dimension 1 Code";
                    GenJournalLine."Shortcut Dimension 2 Code" := Acct."Global Dimension 2 Code";
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;









                    //Reverse Excise Duty
                    if ATMTrans."Transaction Type Charges" = ATMTrans."transaction type charges"::Reversal then begin
                        //CO-OP TRANS
                        VendL.Reset();
                        VendL.SetRange(VendL."Vendor No.", ATMTrans."Account No");
                        VendL.SetRange(VendL."Document No.", ATMTrans."Reference No");
                        VendL.CalcFields(VendL.Amount);
                        VendL.SetRange(VendL.Amount, 0.9);
                        if VendL.Find('+') then begin

                            //EXCISE PASSED TO VENDOR
                            LineNo := LineNo + 10000;

                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name" := 'GENERAL';
                            GenJournalLine."Journal Batch Name" := 'ATMTRANS';
                            GenJournalLine."Line No." := LineNo;
                            GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                            GenJournalLine."Account No." := ATMTrans."Account No";
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine."Document No." := DocNo;//ATMTrans."Reference No";
                            GenJournalLine."Posting Date" := ATMTrans."Posting Date";
                            GenJournalLine.Description := ATMTrans."Transaction Description" + ' ' + ' Reverse ExciseDuty';
                            GenJournalLine.Amount := 0.9 * -1;
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            if GenJournalLine.Amount <> 0 then
                                GenJournalLine.Insert;
                            //EXCISE PASSED TO VENDOR

                            //EXCISE DUTY TO G/L ACCOUNT
                            LineNo := LineNo + 10000;

                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name" := 'GENERAL';
                            GenJournalLine."Journal Batch Name" := 'ATMTRANS';
                            GenJournalLine."Line No." := LineNo;
                            GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                            GenJournalLine."Account No." := ExciseGLAcc;
                            GenJournalLine."Document No." := DocNo;//ATMTrans."Reference No";
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine."Posting Date" := ATMTrans."Posting Date";
                            GenJournalLine.Description := 'Reversed 10% Excise Duty on ATM Transaction';
                            GenJournalLine.Amount := 0.9;
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            GenJournalLine."Shortcut Dimension 1 Code" := Acct."Global Dimension 1 Code";
                            GenJournalLine."Shortcut Dimension 2 Code" := Acct."Global Dimension 2 Code";
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                            if GenJournalLine.Amount <> 0 then
                                GenJournalLine.Insert;
                            //EXCISE DUTY TO G/L ACCOUNT
                        end;
                        //CO-OP TRANS

                        //VISA TRANS
                        VendL.Reset();
                        VendL.SetRange(VendL."Vendor No.", ATMTrans."Account No");
                        VendL.SetRange(VendL."Document No.", ATMTrans."Reference No");
                        VendL.CalcFields(VendL.Amount);
                        VendL.SetRange(VendL.Amount, 4);
                        if VendL.Find('+') then begin

                            //EXCISE PASSED TO VENDOR
                            LineNo := LineNo + 10000;

                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name" := 'GENERAL';
                            GenJournalLine."Journal Batch Name" := 'ATMTRANS';
                            GenJournalLine."Line No." := LineNo;
                            GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                            GenJournalLine."Account No." := ATMTrans."Account No";
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine."Document No." := DocNo;//ATMTrans."Reference No";
                            GenJournalLine."Posting Date" := ATMTrans."Posting Date";
                            GenJournalLine.Description := ATMTrans."Transaction Description" + ' ' + ' Reverse ExciseDuty';
                            GenJournalLine.Amount := 4 * -1;
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            if GenJournalLine.Amount <> 0 then
                                GenJournalLine.Insert;
                            //EXCISE PASSED TO VENDOR




                            //EXCISE DUTY TO G/L ACCOUNT
                            LineNo := LineNo + 10000;

                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name" := 'GENERAL';
                            GenJournalLine."Journal Batch Name" := 'ATMTRANS';
                            GenJournalLine."Line No." := LineNo;
                            GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                            GenJournalLine."Account No." := ExciseGLAcc;
                            GenJournalLine."Document No." := DocNo;//ATMTrans."Reference No";
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine."Posting Date" := ATMTrans."Posting Date";
                            GenJournalLine.Description := 'Reversed 10% Excise Duty on ATM Transaction';
                            GenJournalLine.Amount := 4;
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            GenJournalLine."Shortcut Dimension 1 Code" := Acct."Global Dimension 1 Code";
                            GenJournalLine."Shortcut Dimension 2 Code" := Acct."Global Dimension 2 Code";
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                            if GenJournalLine.Amount <> 0 then
                                GenJournalLine.Insert;

                            //EXCISE DUTY TO G/L ACCOUNT
                        end;
                        //VISA TRANS
                    end;
                    //Reverse Excise Duty

                    //ATM Charges




                end else begin
                    Error('%1', 'Account No. %1 not found.', ATMTrans."Account No");
                end;


            /*
            ATMTrans.Posted:=TRUE;
            //ATMTrans.LOCKTABLE:=false;
            ATMTrans.MODIFY;
            processed:=TRUE;
            time_processed:=DT2TIME(CURRENTDATETIME);


            ///sms

            //SMS MESSAGE
                  SMSMessage.RESET;
                  IF SMSMessage.FIND('+') THEN BEGIN
                  iEntryNo:=SMSMessage."Entry No";
                  iEntryNo:=iEntryNo+1;
                  END
                  ELSE BEGIN
                  iEntryNo:=1;
                  END;
                  SMSMessage.LOCKTABLE;
                  SMSMessage.RESET;
                  SMSMessage.INIT;
                  SMSMessage."Entry No":=iEntryNo;
                  SMSMessage."Account No":=ATMTrans."Account No";
                  SMSMessage."Date Entered":=TODAY;
                  SMSMessage."Time Entered":=ATMTrans."Transaction Time";
                  SMSMessage.Source:='ATM TRANS';
                  SMSMessage."Entered By":=USERID;
                  SMSMessage."Sent To Server":=SMSMessage."Sent To Server"::No;
                  IF ATMTrans.Amount>0 THEN BEGIN
                  SMSMessage."SMS Message":='You have withdrawn KSHs.'+FORMAT(ATMTrans.Amount)+
                                            ' from ATM Location '+ATMTrans."Withdrawal Location"+
                                            ' on '+FORMAT(TODAY) + ' ' +FORMAT(ATMTrans."Transaction Time")+'  From MAFANIKIO SACCO LTD';


                  SMSMessage."Telephone No":=Acct."Phone No.";
                  SMSMessage.INSERT;
                  END;

                  IF ATMTrans.Amount<0 THEN BEGIN
                  SMSMessage."SMS Message":='Your withdrawal of KSHs.'+FORMAT(ATMTrans.Amount)+
                                            ' from ATM Location '+ATMTrans."Withdrawal Location"+
                                            ' has been reversed on '+FORMAT(TODAY) + ' ' +FORMAT(ATMTrans."Transaction Time")+' From MAFANIKIO SACCO LTD' ;


                  SMSMessage."Telephone No":=Acct."Phone No.";
                  processed:=SMSMessage.INSERT;
                  IF processed=FALSE THEN
                  ERROR('INSERTING SMS FAILED %1',Acct."Phone No.");

                  END;

                 */
            ////////////////////////////
            ///end sms
            until ATMTrans.Next = 0;

            //Post
            /*
            GenJournalLine.RESET;
            GenJournalLine.SETRANGE("Journal Template Name",'GENERAL');
            GenJournalLine.SETRANGE("Journal Batch Name",'ATMTRANS');
            IF GenJournalLine.FIND('-') THEN BEGIN
            REPEAT
            GLPosting.RUN(GenJournalLine);
            UNTIL GenJournalLine.NEXT = 0;
            END;


            GenJournalLine.RESET;
            GenJournalLine.SETRANGE("Journal Template Name",'GENERAL');
            GenJournalLine.SETRANGE("Journal Batch Name",'ATMTRANS');
            GenJournalLine.DELETEALL;*/
        end;
        //processed:=TRUE;
        //EXIT(processed);

    end;


    procedure fnTotalUnposted() unposted: Integer
    begin
        ATMTrans.LockTable;
        ATMTrans.Reset;
        ATMTrans.SetFilter(ATMTrans.Posted, '%1', false);
        if ATMTrans.Find('-') then begin
            unposted := ATMTrans.Count;
        end;
        exit(unposted);
    end;
}

