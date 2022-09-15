#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Report 50967 "Member Monthly Processes"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(Customer; Customer)
        {
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnAfterGetRecord()
            begin
                if WorkDate = CalcDate('CM', WorkDate) then //=======IF WORKDATE = LAST DAY OF THE MONTH
                begin
                    if ("Deposits Account No" <> '') and ((Status = Status::Active) or (Status = Status::Dormant)) then begin
                        ObjAccounts.Reset;
                        ObjAccounts.SetRange(ObjAccounts."No.", "Deposits Account No");
                        ObjAccounts.SetRange(ObjAccounts.Blocked, ObjAccounts.Blocked::" ");
                        ObjAccounts.SetFilter(ObjAccounts.Status, '<>%1&<>%2', ObjAccounts.Status::Closed, ObjAccounts.Status::Deceased);
                        if ObjAccounts.FindSet then begin
                            SFactory.FnRunCreateDepositTransferJournalsMonthly("Deposits Account No", "No.");
                        end;
                    end;
                    SFactory.FnRunGetMemberMonthlyTurnover("No.");
                end;
            end;

            trigger OnPostDataItem()
            begin
                if WorkDate = CalcDate('CM', WorkDate) then //=======IF WORKDATE = LAST DAY OF THE MONTH
                begin
                    SFactory.FnRunGetDepositArrearsPenalty;
                    FnRunTransferAdditionalSharestoShareCapital();
                end;
            end;

            trigger OnPreDataItem()
            begin
                VarDateFilter := '..' + Format(WorkDate);
                Customer.CalcFields(Customer."Deposits Contributed", Customer."Deposit Contributed Historical",
                Customer."Deposits Penalty Exists");
                Customer.SetFilter(Customer."Date Filter", VarDateFilter);
                Customer.SetFilter(Customer."Monthly Contribution", '>%1',
                (Customer."Deposits Contributed" + Customer."Deposit Contributed Historical"));
                //Customer.SETFILTER()Customer."FOSA Balances",'>%1',10);

                SFactory.FnRunProcessRefereeComissions;
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
        ObjAccounts: Record Vendor;
        VarDateFilter: Text;

    local procedure FnRunTransferAdditionalSharestoShareCapital()
    var
        ObjMember: Record Customer;
        VarRunningBal: Decimal;
        ObjAccount: Record Vendor;
        AmountToDeduct: Decimal;
        AvailableBal: Decimal;
        ObjVendors: Record Vendor;
        ObjAccTypes: Record "Account Types-Saving Products";
        BATCH_TEMPLATE: Code[30];
        BATCH_NAME: Code[30];
        GenJournalLine: Record "Gen. Journal Line";
        ObjGensetup: Record "Sacco General Set-Up";
        DOCUMENT_NO: Code[30];
        LineNo: Integer;
    begin
        BATCH_TEMPLATE := 'GENERAL';
        BATCH_NAME := 'DEFAULT';


        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
        GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
        GenJournalLine.DeleteAll;


        ObjGensetup.Get;
        ObjMember.CalcFields(ObjMember."Additional Shares", ObjMember."Additional Shares Status", ObjMember."Share Capital Status", ObjMember."Deposits Account Status");
        ObjMember.Reset;
        ObjMember.SetFilter(ObjMember."Share Capital No", '<>%1', '');
        ObjMember.SetFilter(ObjMember."Share Capital Status", '<>%1', ObjMember."share capital status"::Closed);
        ObjMember.SetFilter(ObjMember."Additional Shares Account No", '<>%1', '');
        ObjMember.SetFilter(ObjMember."Additional Shares Status", '<>%1', ObjMember."fosa shares status"::Closed);
        ObjMember.SetFilter(ObjMember."Additional Shares", '>%1', 0);
        ObjMember.SetFilter(ObjMember.Status, '<>%1|%2', ObjMember.Status::Exited, ObjMember.Status::Deceased);
        if ObjMember.FindSet then begin
            repeat

                DOCUMENT_NO := SFactory.FnRunGetNextTransactionDocumentNo;

                ObjMember.CalcFields(ObjMember."Additional Shares");
                //=================================================================================================Transfer Additional Shares to Share Capital
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Deposit Contribution",
                GenJournalLine."account type"::Vendor, ObjMember."Additional Shares Account No", WorkDate, ObjMember."FOSA Shares", 'BOSA', '',
                'Additional Shares Transfer to Share Capital ' + ObjMember."Share Capital No", '', GenJournalLine."application source"::CBS);

                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                GenJournalLine."account type"::Vendor, ObjMember."Share Capital No", WorkDate, ObjMember."FOSA Shares" * -1, 'BOSA', '',
                'Share Capital Transfer from Additional Shares ' + ObjMember."Additional Shares Account No", '', GenJournalLine."application source"::CBS);


                //CU posting
                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                if GenJournalLine.Find('-') then
                    Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);

                //=========================================================================================Modify Account Status
                if ObjAccount.Get(ObjMember."FOSA Shares Account No") then begin
                    ObjAccount.Status := ObjAccount.Status::Closed;
                    ObjAccount.Blocked := ObjAccount.Blocked::All;
                    ObjAccount.Modify;
                end;

            until ObjMember.Next = 0;
        end;
    end;
}

