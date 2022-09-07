#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Report 50407 "Fixed Deposit Daily Processes"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(Vendor; Vendor)
        {
            DataItemTableView = where("Account Type" = filter(503), Balance = filter(<> 0), "Fixed Deposit Start Date" = filter(<> 0D));
            RequestFilterFields = "No.", "Expected Maturity Date";
            column(ReportForNavId_1102755000; 1102755000)
            {
            }

            trigger OnAfterGetRecord()
            begin
                /*VarFixedDepositStartDate:=Vendor."Fixed Deposit Start Date";
                REPEAT*/
                //SFactory.FnRunProcessInterestOnFixedDepositAccount(WORKDATE,"No.");
                SFactory.FnRunPostInterestOnFixedMaturity(WorkDate, "No.");
                //VarFixedDepositStartDate:=CALCDATE('1D',VarFixedDepositStartDate);
                //UNTIL VarFixedDepositStartDate = WORKDATE;

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
        VarFixedDepositStartDate: Date;
        ObjInterestBuffer: Record "Interest Buffer";
        VarProcessingDate: Date;
}

