#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Report 50076 "Process Debtor Interest"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(Memba; Customer)
        {
            RequestFilterFields = "No.";
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnAfterGetRecord()
            var
                AccountBalance: Decimal;
                InterestEarned: Decimal;
            begin


                Account.Reset;
                Account.SetRange(Account."No.", "No.");
                //Account.SETFILTER(Account."Date Filter",AsAt);
                Account.SetFilter("Date Filter", '..%1', AsAt);
                if Account.Find('-') then begin
                    if Account."Customer Posting Group" = 'DEBTORS' then begin
                        Account.CalcFields(Account."Balance (LCY)");

                        Bal := Account."Balance (LCY)";
                        Message(Format(Bal));
                        PDialog.Update(1, Memba."No." + ' ' + Memba.Name);

                        InterestEarned := Bal * 15 / 100;// * 0.01;

                        //MESSAGE(FORMAT(InterestEarned));

                        if InterestEarned <> 0 then begin

                            LineNo := LineNo + 10000;

                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name" := BATCH_TEMPLATE;
                            GenJournalLine."Journal Batch Name" := BATCH_NAME;
                            GenJournalLine."Line No." := LineNo;
                            GenJournalLine."Account Type" := GenJournalLine."account type"::Customer;
                            GenJournalLine."Account No." := Account."No.";
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine."Document No." := DOCUMENT_NO;
                            GenJournalLine."Posting Date" := PostingDate;
                            GenJournalLine.Description := 'Interest Charged on Debtor' + ' ' + Memba."No.";
                            GenJournalLine.Amount := InterestEarned;
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            //GenJournalLine."Bal. Account Type":=GenJournalLine."Bal. Account Type"::"G/L Account";
                            if GenJournalLine.Amount <> 0 then
                                GenJournalLine.Insert;
                        end;

                    end;
                end;
            end;

            trigger OnPostDataItem()
            var
                done_msg: label 'Processing Done Template %1, Batch %2!';
            begin
                PDialog.Close;
                Message(done_msg, BATCH_TEMPLATE, BATCH_NAME);
            end;

            trigger OnPreDataItem()
            var
                err_asat: label 'Please enter the date as at!';
                err_postforacc: label 'Post for Account must have a value!';
                err_expenseacc: label 'The Expense Acount must have a value!';
                err_intrate: label 'The interest rate must have a value greater than 0!';
                NoSeriesMgmt: Codeunit NoSeriesManagement;
            begin
                FundsUserSetup.Get(UserId);
                FundsUserSetup.TestField("Payment Journal Template");
                FundsUserSetup.TestField("Payment Journal Batch");
                BATCH_NAME := FundsUserSetup."Payment Journal Batch";
                BATCH_TEMPLATE := FundsUserSetup."Payment Journal Template";
                if AsAt = 0D then Error(err_asat);
                //IF InterestRate<=0 THEN ERROR(err_intrate);
                //Memba.SETFILTER("Date Filter",'..%1',AsAt);
                //IF ExpenseAccount='' THEN ERROR(err_expenseacc);



                DOCUMENT_NO := NoSeriesMgmt.GetNextNo('JV', 0D, true);
                SFactory.FnClearGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME);
                PDialog.Open(progress);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Control2)
                {
                    field("As At"; AsAt)
                    {
                        ApplicationArea = Basic;
                    }
                    field("Expense Account"; ExpenseAccount)
                    {
                        ApplicationArea = Basic;
                        TableRelation = "G/L Account"."No." where("Direct Posting" = const(true),
                                                                   "Income/Balance" = const("Income Statement"),
                                                                   Blocked = const(false));
                        Visible = false;
                    }
                    field("Posting Date"; PostingDate)
                    {
                        ApplicationArea = Basic;
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            AsAt := Today;
            PostingDate := Today;
        end;
    }

    labels
    {
    }

    var
        PostForAccount: Option " ",Silver,Safari,Junior;
        InterestRate: Decimal;
        AsAt: Date;
        BATCH_TEMPLATE: Text;
        BATCH_NAME: Text;
        FundsUserSetup: Record "Funds User Setup";
        ExpenseAccount: Code[20];
        LineNo: Integer;
        DOCUMENT_NO: Text;
        GenJournalLine: Record "Gen. Journal Line";
        SFactory: Codeunit "SURESTEP Factory";
        PostingTransactionType: Option " ","Registration Fee","Share Capital","Interest Paid","Loan Repayment","Deposit Contribution","Insurance Contribution","Maono Housing",Loan,"Unallocated Funds",Dividend,"FOSA Account","Loan Insurance Charged","Loan Insurance Paid","Recovery Account","FOSA Shares","Additional Shares","Interest Due","Loan Penalty Charged","Loan Penalty Paid","Junior Savings","Safari Savings","Silver Savings";
        PostingDate: Date;
        PDialog: Dialog;
        progress: label 'Processing : #1##########################';
        SaccoNoSeries: Record "Sacco No. Series";
        Account: Record Customer;
        DFilter: Text;
        Bal: Decimal;
}

