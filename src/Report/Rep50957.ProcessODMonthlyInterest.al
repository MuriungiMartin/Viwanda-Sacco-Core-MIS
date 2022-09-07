#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Report 50957 "Process OD Monthly Interest"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(Vendor; Vendor)
        {
            DataItemTableView = where("Account Type" = filter(406));
            RequestFilterFields = "No.", Name, "BOSA Account No";
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnAfterGetRecord()
            begin
                if WorkDate = CalcDate('CM', WorkDate) then begin //IF WORKDATE = LAST DAY OF MONTH
                    ObjAccount.CalcFields(ObjAccount.Balance);
                    ObjAccount.Reset;
                    ObjAccount.SetRange(ObjAccount."No.", "No.");
                    ObjAccount.SetRange(ObjAccount."Account Type", '406');
                    if ObjAccount.FindSet then begin
                        if ObjAccountType.Get(ObjAccount."Account Type") then begin
                            ObjAccount.CalcFields(ObjAccount.Balance);


                            VarInterestCharged := 0;

                            VarCurrMonthBeginDay := 1;
                            VarCurrMonthMonth := Date2dmy(WorkDate, 2);
                            VarCurrMonthYear := Date2dmy(WorkDate, 3);
                            VarCurrMonthBeginDate := Dmy2date(VarCurrMonthBeginDay, VarCurrMonthMonth, VarCurrMonthYear);
                            VarDateFilter := Format(VarCurrMonthBeginDate) + '..' + Format(WorkDate);


                            ObjDailyInterestCharge.Reset;
                            ObjDailyInterestCharge.SetRange(ObjDailyInterestCharge."Account No.", ObjAccount."No.");
                            ObjDailyInterestCharge.SetRange(ObjDailyInterestCharge.Posted, false);
                            ObjDailyInterestCharge.SetFilter(ObjDailyInterestCharge."Posting Date", VarDateFilter);
                            if ObjDailyInterestCharge.FindSet then begin
                                ObjDailyInterestCharge.CalcSums(ObjDailyInterestCharge.Amount);
                                VarInterestCharged := ObjDailyInterestCharge.Amount * -1;
                            end;

                            if VarInterestCharged > 0 then begin
                                VarInterestChargedAccount := ObjAccountType."Over Draft Interest Account";



                                BATCH_TEMPLATE := 'GENERAL';
                                BATCH_NAME := 'DEFAULT';
                                DOCUMENT_NO := 'OD' + Format(WorkDate);

                                GenJournalLine.Reset;
                                GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                                GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                                GenJournalLine.DeleteAll;



                                //------------------------------------1. Debit FOSA Account---------------------------------------------------------------------------------------------

                                LineNo := LineNo + 10000;
                                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                                GenJournalLine."account type"::Vendor, "No.", WorkDate, VarInterestCharged, 'FOSA', '',
                                'Interest on Overdraft - ' + Format(WorkDate, 0, '<Month Text,3> <Year4>'), '', GenJournalLine."application source"::CBS);

                                //------------------------------------2. Credit Income Account---------------------------------------------------------------------------------------------
                                LineNo := LineNo + 10000;
                                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                                GenJournalLine."account type"::"G/L Account", VarInterestChargedAccount, WorkDate, VarInterestCharged * -1, 'FOSA', '',
                                'Interest on Overdraft - ' + Format(WorkDate, 0, '<Month Text,3> <Year4>') + ' : ' + "No.", '', GenJournalLine."application source"::CBS);
                                //--------------------------------(Credit Income Account)---------------------------------------------


                                //CU posting
                                GenJournalLine.Reset;
                                GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                                GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                                if GenJournalLine.Find('-') then
                                    Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);


                                ObjDailyInterestCharge.Reset;
                                ObjDailyInterestCharge.SetRange(ObjDailyInterestCharge."Account No.", ObjAccount."No.");
                                ObjDailyInterestCharge.SetFilter(ObjDailyInterestCharge."Posting Date", VarDateFilter);
                                if ObjDailyInterestCharge.FindSet then begin
                                    repeat
                                        ObjDailyInterestCharge.Posted := true;
                                        ObjDailyInterestCharge."Posted On" := WorkDate;
                                        ObjDailyInterestCharge."User ID" := UserId;
                                        ObjDailyInterestCharge.Modify;
                                    until ObjDailyInterestCharge.Next = 0;
                                end;
                            end;
                        end;
                    end
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
        ObjAccountType: Record "Account Types-Saving Products";
        SFactory: Codeunit "SURESTEP Factory";
        GenJournalLine: Record "Gen. Journal Line";
        ObjAccount: Record Vendor;
        VarInterestCharged: Decimal;
        VarInterestChargedAccount: Code[30];
        BATCH_TEMPLATE: Code[30];
        BATCH_NAME: Code[30];
        DOCUMENT_NO: Code[30];
        LineNo: Integer;
        VarCurrMonthBeginDate: Date;
        VarCurrMonthBeginDay: Integer;
        VarCurrMonthMonth: Integer;
        VarCurrMonthYear: Integer;
        ObjDailyInterestCharge: Record "Daily Interest/Penalty Buffer";
        VarDateFilter: Text;
        PostingDate: Date;
}

