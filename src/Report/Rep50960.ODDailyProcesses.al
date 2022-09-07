#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Report 50960 "OD Daily Processes"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(Vendor; Vendor)
        {
            DataItemTableView = where("Account Type" = filter(406));
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnAfterGetRecord()
            begin
                if Vendor."Over Draft Limit Expiry Date" = WorkDate then begin
                    Vendor."Over Draft Limit Amount" := 0;
                    Vendor.Modify;
                end;


                ObjGensetup.Get();

                if Vendor."Over Draft Limit Expiry Date" = CalcDate('14D', WorkDate) then begin

                    VarEmailBody := 'Your Overdraft account limit of Ksh. ' + Format(Vendor."Over Draft Limit Amount") + ' will expire on ' + Format(Vendor."Over Draft Limit Expiry Date") +
                  '. If you wish to renew your overdraft, kindly do so in good time.';

                    SFactory.FnSendStatementViaMail(Vendor.Name, 'OVERDRAFT FACILITY EXPIRY', VarEmailBody, Vendor."E-Mail", '', ObjGensetup."Credit Department E-mail");

                    VarSMS := 'Dear ' + Vendor.Name + ', ' + VarEmailBody;
                    Clouspesa.SMSMessage('Overdraft', Vendor."No.", Vendor."Mobile Phone No", VarSMS, '');
                end;

                SFactory.FnGetDailyInterestAccrualOD("No.");

            end;

            trigger OnPreDataItem()
            begin

                SFactory.FnRunOverdraftSweeping;
                SFactory.FnRunTransferOverdrawAmounttoOD;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        SFactory: Codeunit "SURESTEP Factory";
        VarEmailBody: Text;
        ObjGensetup: Record "Sacco General Set-Up";
        Clouspesa: Codeunit CloudPESALivetest;
        VarSMS: Text[250];
}

