#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Report 50879 "Post Monthly Interest FOSA V1"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(Vendor; Vendor)
        {
            DataItemTableView = where("Document No. Filter" = filter('OD30/11/18'));
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnPreDataItem()
            begin
                if WorkDate = CalcDate('CM', WorkDate) then begin
                    VarCurrMonth := Date2dmy(WorkDate, 2);
                    VarCurrYear := Date2dmy(WorkDate, 3);
                    VarMonthBeginDate := Dmy2date(1, VarCurrMonth, VarCurrYear);

                    VarReportDate := VarMonthBeginDate;
                    repeat
                        Sfactory.FnRunProcessDailyInterestonFOSAAccounts(VarReportDate);
                        VarReportDate := CalcDate('1D', VarReportDate);
                    until VarReportDate > WorkDate;
                end;

                Sfactory.FnRunPostInterestEarnedonFOSAAccountsMonthly;//============================================Post Interest Earned
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
        ObjPayrollPosting: Record "Payroll Posting Setup Ver1";
        ObjTransactionCodes: Record "Payroll Transaction Code.";
        VarName: Text;
        Sfactory: Codeunit "SURESTEP Factory";
        VarReportDate: Date;
        VarCurrMonth: Integer;
        VarCurrYear: Integer;
        VarMonthBeginDate: Date;
}

