#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Report 50053 "Collateral & Statement Process"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("Loan Collateral Register"; "Loan Collateral Register")
        {
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnPreDataItem()
            begin
                FnRunInsuranceExpirynotification;
                SFactory.FnRunExpiredCollateralManagement;
                SFactory.FnRunSendScheduledStatements;
                SFactory.FnRunSendScheduledAccountStatements;
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
        VarMemberName: Text;
        VarEmailSubject: Text;
        VarEmailBody: Text;
        ObjLoanCollateralDetails: Record "Loan Collateral Details";
        ObjCollateralRegister: Record "Loan Collateral Register";
        ObjGensetup: Record "Sacco General Set-Up";

    local procedure FnRunInsuranceExpirynotification()
    begin

        ObjGensetup.Get;
        ObjCollateralRegister.Reset;
        ObjCollateralRegister.SetFilter(ObjCollateralRegister."Collateral Code", '%1', 'LOGBOOK');
        ObjCollateralRegister.SetFilter(ObjCollateralRegister."Released to Member on", '%1', 0D);
        ObjCollateralRegister.SetFilter(ObjCollateralRegister."Insurance Expiration Date", '%1', CalcDate('14D', WorkDate));
        if ObjCollateralRegister.FindSet then begin
            repeat
                ObjLoanCollateralDetails.Reset;
                ObjLoanCollateralDetails.SetRange(ObjLoanCollateralDetails."Collateral Registe Doc", ObjCollateralRegister."Document No");
                if ObjLoanCollateralDetails.FindSet then begin
                    ObjLoanCollateralDetails.CalcFields(ObjLoanCollateralDetails."Outstanding Balance");

                    VarMemberName := 'Credit Team';

                    VarEmailSubject := 'Collateral Insurance Renewal Notification - ' + ObjCollateralRegister."Document No";
                    VarEmailBody := 'The ' + ObjCollateralRegister."Collateral Code" + ' - ' + ObjCollateralRegister."Collateral Description" + ' for ' +
                    ObjCollateralRegister."Member No." + ' - ' + ObjCollateralRegister."Member Name" + ' Securing Loan No. ' + ObjLoanCollateralDetails."Loan No"
                    + ' with an outstanding balance of Ksh. ' + Format(ObjLoanCollateralDetails."Outstanding Balance") + ' is due for insurance renewal on ' +
                    Format(ObjCollateralRegister."Insurance Expiration Date", 0, '<Day,2> <Month Text,3> <Year4>');

                    SFactory.FnSendStatementViaMail(VarMemberName, VarEmailSubject, VarEmailBody, ObjGensetup."Credit Department E-mail", '', '');
                end;
            until ObjCollateralRegister.Next = 0;
        end;
    end;
}

