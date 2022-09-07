#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Codeunit 50160 "Cue Management"
{

    trigger OnRun()
    begin
    end;


    procedure GetVisitFrequency(Activity: Option "G/L",BOSA,FOSA; AccountNo: Code[20]; AccountName: Text[70])
    var
        ObjControlCue: Record "Control Cues";
        No_Visits: Integer;
        ObjGenSetUP: Record "Control Cues";
        SMSMessages: Record "SMS Messages";
        iEntryNo: Integer;
    begin
        ObjControlCue.Reset;
        ObjControlCue.SetRange(ObjControlCue.User_Accessed, UserId);
        ObjControlCue.SetRange(ObjControlCue.date, Today);
        ObjControlCue.SetRange(ObjControlCue.Account_no, AccountNo);
        ObjControlCue.SetRange(ObjControlCue.Account_Name, AccountName);
        ObjControlCue.SetRange(ObjControlCue.Activity, Activity);
        if ObjControlCue.Find('-') then begin
            No_Visits := ObjControlCue.Frequency_Today + 1;
            ObjControlCue.Frequency_Today := No_Visits;
            ObjControlCue.Modify;
            /*//Create Sms
              ObjGenSetUP.RESET;
              ObjGenSetUP.SETRANGE(ObjGenSetUP."Activity Source",Activity);
              IF ObjGenSetUP.FIND('-') THEN BEGIN
                IF No_Visits >= ObjGenSetUP."Maxmum Visit(per day)"  THEN BEGIN
              //Insert To SMS MESSAGE
              SMSMessages.RESET;
              IF SMSMessages.FIND('+') THEN BEGIN
              iEntryNo:=SMSMessages."Entry No";
              iEntryNo:=iEntryNo+1;
              END
              ELSE BEGIN
              iEntryNo:=1;
              END;
        
              SMSMessages.RESET;
              SMSMessages.INIT;
              SMSMessages."Entry No":=iEntryNo;
              SMSMessages."Account No":=AccountNo;
              SMSMessages."Date Entered":=TODAY;
              SMSMessages."Time Entered":=TIME;
              SMSMessages.Source:='TrackCue';
              SMSMessages."Entered By":=USERID;
              SMSMessages."Sent To Server":=SMSMessages."Sent To Server"::No;
              SMSMessages."SMS Message":='UserID '+FORMAT(USERID)+
                                        ' has visited ' +FORMAT(ObjControlCue.Activity)+ ' account No.: '+AccountNo+ ' maximum times';
              SMSMessages."Telephone No":=ObjGenSetUP."Phone Number";
              SMSMessages.INSERT;
            END;
            END;*/
        end else begin
            ObjControlCue.Reset;
            ObjControlCue.Init;
            ObjControlCue.Activity := Activity;
            ObjControlCue.Account_no := AccountNo;
            ObjControlCue.Account_Name := AccountName;
            ObjControlCue.time := Time;
            ObjControlCue.date := Today;
            ObjControlCue.User_Accessed := UserId;
            ObjControlCue.Reason := '';
            ObjControlCue.Frequency_Today := 1;
            ObjControlCue.Insert;
        end;

    end;
}

