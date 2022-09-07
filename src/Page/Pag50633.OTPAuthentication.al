#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50633 "OTP Authentication"
{
    PageType = ConfirmationDialog;

    layout
    {
        area(content)
        {
            group(Control2)
            {
                Caption = 'Enter the OTP Received';
            }
            field(InputOTP;InputOTP)
            {
                ApplicationArea = Basic;
                Caption = 'Input OTP';
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        GetEnteredOTP;
    end;

    var
        InputOTP: Integer;


    procedure GetEnteredOTP() VarInputOTP_II: Integer
    begin
        VarInputOTP_II:=InputOTP;
        exit(VarInputOTP_II);
    end;
}

