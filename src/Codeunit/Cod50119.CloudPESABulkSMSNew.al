#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Codeunit 50119 "CloudPESABulkSMS New"
{

    trigger OnRun()
    begin
        Message(GetBulKSMS)
    end;

    var
        SMSMessages: Record "SMS Messages";


    procedure GetBulKSMS() MessageDetails: Text
    var
        countTran: Integer;
        SMSCount: Integer;
    begin
        begin
            countTran := 0;
            SMSMessages.Reset;
            SMSMessages.Ascending(false);
            SMSMessages.SetRange(SMSMessages."Sent To Server", SMSMessages."sent to server"::No);
            SMSMessages.SetRange(SMSMessages."Date Entered", Today);
            if SMSMessages.Find('-') then begin
                SMSCount := 0;
                repeat

                    countTran := countTran + 1;
                    SMSCount := SMSCount + 1;
                    if (SMSMessages."Telephone No" = '') or (SMSMessages."Telephone No" = '+') or (SMSMessages."SMS Message" = '') then begin
                        SMSMessages."Sent To Server" := SMSMessages."sent to server"::Failed;
                        SMSMessages."Entry No." := 'FAILED';
                        SMSMessages.Modify;
                    end
                    else begin

                        MessageDetails += SMSMessages."Telephone No" + ':::' + SMSMessages."SMS Message" + ':::' + Format(SMSMessages."Entry No") + '::::';
                    end;
                    if SMSCount > 20 then begin
                        countTran := 20;
                    end;

                until (SMSMessages.Next = 0) or (countTran = 20);
            end;
        end;
    end;


    procedure UpdateConfirmSent(entryNo: Integer) result: Boolean
    begin
        result := false;
        SMSMessages.Reset;
        SMSMessages.SetRange(SMSMessages."Sent To Server", SMSMessages."sent to server"::No);
        SMSMessages.SetRange(SMSMessages."Entry No", entryNo);
        if SMSMessages.FindFirst then begin
            SMSMessages."Sent To Server" := SMSMessages."sent to server"::Yes;
            SMSMessages."Entry No." := 'SUCCESS';
            SMSMessages."Date Sent to Server" := CreateDatetime(Today, Time);
            SMSMessages."Time Sent To Server" := Time;
            SMSMessages.Modify;
            result := true;
        end
    end;
}

