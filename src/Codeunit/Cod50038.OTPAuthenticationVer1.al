#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Codeunit 50038 "OTP Authentication Ver1"
{

    trigger OnRun()
    begin
    end;

    var
        ObjSMSMessages: Record "SMS Messages";
        SFactory: Codeunit "SURESTEP Factory";


    procedure FnRunOTPAuthentication(VarUserID: Code[30])
    var
        "Count": Integer;
        Success: Boolean;
        TwoFactorAuth: Page "OTP Authentication";
    begin
        FnRunGenerateOTP(VarUserID);

        Commit;
        Count := 0;
        Success := false;

        ObjSMSMessages.Reset;
        ObjSMSMessages.SetRange(ObjSMSMessages.OTP_User, VarUserID);
        ObjSMSMessages.SetRange(ObjSMSMessages."OTP Status", ObjSMSMessages."otp status"::Active);
        if ObjSMSMessages.FindSet then begin
            repeat
                Clear(TwoFactorAuth);
                if TwoFactorAuth.RunModal <> Action::Yes then
                    Error('Cancelled');
                if TwoFactorAuth.GetEnteredOTP = ObjSMSMessages."OTP Code" then begin
                    Success := true;
                end
                else begin
                    Count += 1;
                    Message('Wrong OTP');
                end;
            until (Count = 3) or Success;
            if not Success then Error('You have Entered Wrong OTP too many times');
        end;
    end;


    procedure FnRunGenerateOTP(VarUserID: Code[30]): Text
    var
        OTP: Integer;
        VarUserMobileNo: Code[30];
        ObjUsers: Record User;
        RandomParam: Text;
    begin
        //================================================Mark SMS As Authenticated
        ObjSMSMessages.Reset;
        ObjSMSMessages.SetRange(ObjSMSMessages.OTP_User, VarUserID);
        ObjSMSMessages.SetRange(ObjSMSMessages."OTP Status", ObjSMSMessages."otp status"::Active);
        if ObjSMSMessages.FindSet then begin
            repeat
                ObjSMSMessages."OTP Status" := ObjSMSMessages."otp status"::Inactive;
                ObjSMSMessages.Modify;
            until ObjSMSMessages.Next = 0;
        end;


        OTP := Random(99999);
        RandomParam := 'OTP For Login to ' + COMPANYNAME + ' is ' + Format(OTP) + '.' + ' Please Enter this Code into Nav.';
        Message(Format(RandomParam));

        ObjUsers.Reset;
        ObjUsers.SetRange(ObjUsers."User Name", VarUserID);
        if ObjUsers.FindSet then begin
            SFactory.FnSendOTPSMS('OTP', RandomParam, VarUserID, '', VarUserID, OTP);
        end;
        exit;
    end;
}

