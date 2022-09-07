#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Report 50939 "Fixed Deposit Notifications"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("Fixed Deposit Placement"; "Fixed Deposit Placement")
        {
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnAfterGetRecord()
            var
                varExpectedInterest: Decimal;
            begin
                ObjAccount.Reset;
                ObjAccount.SetRange(ObjAccount."No.", "Fixed Deposit Account No");
                if ObjAccount.FindSet then begin
                    VarMobileNo := ObjAccount."Mobile Phone No";


                    ObjGensetup.Get;

                    ObjFDPlacement.Reset;
                    ObjFDPlacement.SetRange(ObjFDPlacement."Document No", "Document No");
                    if ObjFDPlacement.FindSet then begin
                        if CalcDate('5D', WorkDate) = ObjFDPlacement."FD Maturity Date" then begin

                            //================================================================SMS Notification
                            VarMemberName := SurestpFactory.FnConvertTexttoBeginingWordstostartWithCapital("Member Name");
                            varExpectedInterest := SurestpFactory.FnGetFosaAccountBalance("Fixed Deposit Account No") * "FD Interest Rate" / 100;
                            VarSmsBody := 'Dear ' + VarMemberName + ', your Fixed Deposit of Ksh. ' + Format(ObjFDPlacement."Amount to Fix") + ' will mature on ' + Format(ObjFDPlacement."FD Maturity Date", 0, '<Day,2> <Month Text,3> <Year4>') +
                            ' with an interest of Ksh. ' + Format(varExpectedInterest) + '. Kindly give us instructions for renewal or closure of the same. Kingdom Sacco';
                            SurestpFactory.FnSendSMS('FDMaturity', VarSmsBody, ObjFDPlacement."Fixed Deposit Account No", VarMobileNo);

                            //===========================================================Email Notification

                            VarEmailSubject := 'FIXED DEPOSIT MATURITY NOTIFICATION - ' + "Fixed Deposit Account No";
                            VarEmailBody := 'Kindly note that your Fixed Deposit Investment with us of Ksh. ' + Format("Amount to Fix") + ', account number ' + "Fixed Deposit Account No" +
                            ' matures on ' + Format("FD Maturity Date", 0, '<Day,2> <Month Text,3> <Year4>') + ' with an interest of Ksh. ' + Format(varExpectedInterest) + '. ' +
                                          'Please fill in the attached rollover form and forward it to us entailing the information below:<br>' +
                                          '<br>- The amount to be rolled over - you can opt to roll over the Principal amount with interest or not' +
                                          '<br>- The tenure of the rolled over investment, that is, 1, 3, 6 or 12 months.' +
                                          '<br>- The rate at which the amount is to be rolled over (kindly contact your Financial Advisor on the applicable rates)' +

                                          '<br><br>Should you not opt for rollover, kindly advice on how to treat your funds upon maturity. You may opt to withdraw partially or fully.' +

                                          '<br><br>Thank you for choosing Kingdom Sacco. Our objective is to empower you economically and socially by promoting a Savings and Investments culture and providing affordable credit.';


                            SurestpFactory.FnSendStatementViaMail(VarMemberName, VarEmailSubject, VarEmailBody, ObjAccount."E-Mail", 'FIXED DEPOSIT AGREEMENT.pdf',
                            ObjGensetup."Finance Department E-mail");
                        end;
                    end;
                end;
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
        ObjAccount: Record Vendor;
        SurestpFactory: Codeunit "SURESTEP Factory";
        VarMobileNo: Code[30];
        ObjFDPlacement: Record "Fixed Deposit Placement";
        VarSmsBody: Text;
        VarMemberEmail: Text;
        VarEmailBody: Text;
        ObjGensetup: Record "Sacco General Set-Up";
        VarMemberName: Text;
        VarEmailSubject: Text;
}

