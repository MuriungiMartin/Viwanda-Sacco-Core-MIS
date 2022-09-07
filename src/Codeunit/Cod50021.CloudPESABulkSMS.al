#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Codeunit 50021 "CloudPESABulkSMS"
{

    trigger OnRun()
    begin
        Message(FailOverSetup());
    end;

    var
        SMSMessages: Record "SMS Messages";
        SMSCharges: Record "SMS Charges";
        SMSCharge: Decimal;
        ExDuty: Decimal;
        Vendor: Record Vendor;
        GenJournalLine: Record "Gen. Journal Line";
        GenBatches: Record "Gen. Journal Batch";
        LineNo: Integer;
        GLPosting: Codeunit "Gen. Jnl.-Post Line";
        ExDutyGLAcc: label '01-0-0316';


    procedure PollPendingSMS() MessageDetails: Text[500]
    begin

        SMSMessages.Reset;
        SMSMessages.SetRange(SMSMessages."Sent To Server", SMSMessages."sent to server"::No);
        SMSMessages.SetRange(SMSMessages."Date Entered", Today);
        if SMSMessages.Find('-') then begin

            if (SMSMessages."Telephone No" = '') or (SMSMessages."Telephone No" = '+') or (SMSMessages."SMS Message" = '') then begin
                SMSMessages."Sent To Server" := SMSMessages."sent to server"::Failed;
                SMSMessages."Entry No." := 'FAILED';
                SMSMessages.Modify;
            end
            else begin
                MessageDetails := SMSMessages."Telephone No" + ':::' + SMSMessages."SMS Message" + SMSMessages."Additional Message" + ':::' + Format(SMSMessages."Entry No") + ':::' + SMSMessages."Entered By";
            end;
        end;

    end;


    procedure ConfirmSent(TelephoneNo: Text[20]; Status: Integer)
    begin

        begin
            SMSMessages.Reset;
            SMSMessages.SetRange(SMSMessages."Sent To Server", SMSMessages."sent to server"::No);
            SMSMessages.SetRange(SMSMessages."Entry No", Status);
            if SMSMessages.FindFirst then begin
                SMSMessages."Sent To Server" := SMSMessages."sent to server"::Yes;
                SMSMessages."Entry No." := 'SUCCESS';
                SMSMessages."Delivery Status" := 'Delivery Assumed';
                SMSMessages.Modify;

            end
        end;
    end;


    procedure ChargeSMS()
    begin

        SMSMessages.Reset;
        SMSMessages.SetRange(SMSMessages."Sent To Server", SMSMessages."sent to server"::Yes);
        SMSMessages.SetRange(SMSMessages."Entry No.", 'SUCCESS');
        SMSMessages.SetFilter(SMSMessages."Telephone No", '<>%1', '');
        SMSMessages.SetFilter(SMSMessages."Telephone No", '<>%1', '+254');
        SMSMessages.SetRange(SMSMessages.Charged, false);
        if SMSMessages.Find('-') then
            repeat
            begin

                SMSCharges.Reset;
                SMSCharges.SetFilter(SMSCharges.Source, SMSMessages.Source);
                if SMSCharges.Find('-') then begin
                    SMSCharges.TestField(SMSCharges."Charge Account");
                    SMSCharge := SMSCharges.Amount;
                    ExDuty := (10 / 100) * SMSCharge;
                end;
                Vendor.Reset;
                Vendor.SetRange(Vendor."No.", SMSMessages."Account No");
                if Vendor.Find('-') then begin
                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                    GenJournalLine.SetRange("Journal Batch Name", 'SMSCHARGE');
                    GenJournalLine.DeleteAll;
                    //end of deletion

                    GenBatches.Reset;
                    GenBatches.SetRange(GenBatches."Journal Template Name", 'GENERAL');
                    GenBatches.SetRange(GenBatches.Name, 'SMSCHARGE');

                    if GenBatches.Find('-') = false then begin
                        GenBatches.Init;
                        GenBatches."Journal Template Name" := 'GENERAL';
                        GenBatches.Name := 'SMSCHARGE';
                        GenBatches.Description := 'SMS Charges';
                        GenBatches.Validate(GenBatches."Journal Template Name");
                        GenBatches.Validate(GenBatches.Name);
                        GenBatches.Insert;
                    end;

                    //DR Member Account
                    LineNo := LineNo + 10000;
                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := 'GENERAL';
                    GenJournalLine."Journal Batch Name" := 'SMSCHARGE';
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                    GenJournalLine."Account No." := Vendor."No.";
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Document No." := Format(SMSMessages."Entry No");
                    GenJournalLine."External Document No." := SMSMessages.Source;
                    GenJournalLine."Posting Date" := Today;
                    GenJournalLine.Description := 'SMS Charges';
                    GenJournalLine.Amount := SMSCharges.Amount;
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;

                    //Cr SMS Charges Acc
                    LineNo := LineNo + 10000;
                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := 'GENERAL';
                    GenJournalLine."Journal Batch Name" := 'SMSCHARGE';
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                    GenJournalLine."Account No." := SMSCharges."Charge Account";
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Document No." := Format(SMSMessages."Entry No");
                    GenJournalLine."External Document No." := SMSMessages.Source;
                    GenJournalLine."Posting Date" := Today;
                    GenJournalLine."Source No." := Vendor."No.";
                    GenJournalLine.Description := 'SMS Charge';
                    GenJournalLine.Amount := -SMSCharges.Amount;
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;

                    //DR Excise Duty
                    LineNo := LineNo + 10000;
                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := 'GENERAL';
                    GenJournalLine."Journal Batch Name" := 'SMSCHARGE';
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                    GenJournalLine."Account No." := Vendor."No.";
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                    GenJournalLine."Bal. Account No." := ExDutyGLAcc;
                    GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                    GenJournalLine."Document No." := Format(SMSMessages."Entry No");
                    GenJournalLine."External Document No." := SMSMessages.Source;
                    GenJournalLine."Posting Date" := Today;
                    GenJournalLine.Description := 'Excise duty-SMS Notification';
                    GenJournalLine."Source No." := Vendor."No.";
                    GenJournalLine.Amount := ExDuty;
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;
                    //Post
                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                    GenJournalLine.SetRange("Journal Batch Name", 'SMSCHARGE');
                    if GenJournalLine.Find('-') then begin
                        repeat
                            GLPosting.Run(GenJournalLine);
                        until GenJournalLine.Next = 0;
                    end;

                end;
            end;

            SMSMessages.Charged := true;
            SMSMessages.Modify;
            Commit;
            until SMSMessages.Next = 0;
    end;


    procedure FailOverSetup() result: Code[10]
    var
        SaccoGen: Record "Sacco General Set-Up";
    begin
        SaccoGen.Reset;
        SaccoGen.Get;
        result := Format(SaccoGen."Active SMS Service Provider");
    end;


    procedure UpdateDeliveryStatus(tranID: Decimal; TraceID: Text; Balance: Decimal; status: Decimal) result: Code[50]
    begin
        SMSMessages.Reset;
        SMSMessages.SetRange(SMSMessages."Entry No", tranID);
        if SMSMessages.Find('-') then begin
            SMSMessages."Delivery Status" := TraceID;
            SMSMessages."Bulk SMS Balance" := Balance;
            SMSMessages.Fetched := status;
            SMSMessages."Date Sent to Server" := CurrentDatetime;
            SMSMessages."Time Sent To Server" := Time;
            if SMSMessages.Modify = true then
                result := 'TRUE'
            else
                result := 'FALSE';
        end;
    end;
}

