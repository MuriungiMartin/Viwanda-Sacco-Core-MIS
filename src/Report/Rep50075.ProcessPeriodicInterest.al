#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Report 50075 "Process Periodic Interest"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(Memba; Customer)
        {
            CalcFields = "Silver Savings", "Safari Savings", "Junior Savings";
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnAfterGetRecord()
            var
                AccountBalance: Decimal;
                InterestEarned: Decimal;
            begin
                PDialog.Update(1, Memba."No." + ' ' + Memba.Name);

                case PostForAccount of
                    Postforaccount::Junior:
                        AccountBalance := Memba."Junior Savings";
                    Postforaccount::Safari:
                        AccountBalance := Memba."Safari Savings";
                    Postforaccount::Silver:
                        AccountBalance := Memba."Silver Savings";
                end;

                InterestEarned := AccountBalance * InterestRate * 0.01;

                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, PostingTransactionType,
                GenJournalLine."account type"::Member, Memba."No.", PostingDate, -InterestEarned, Memba."Global Dimension 1 Code", Memba."No.",
                'Interest Earned on - ' + Format(PostingTransactionType), '', GenJournalLine."application source"::" ");
                /*
                LineNo:=LineNo+10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE,BATCH_NAME,DOCUMENT_NO,LineNo,PostingTransactionType,
                GenJournalLine."Account Type"::"G/L Account",ExpenseAccount,PostingDate,InterestEarned,Memba."Global Dimension 1 Code",Memba."No.",
                'Interest Earned on - '+FORMAT(PostingTransactionType),'',GenJournalLine."Application Source"::" ");
                */

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
                if InterestRate <= 0 then Error(err_intrate);
                Memba.SetFilter("Date Filter", '..%1', AsAt);
                if ExpenseAccount = '' then Error(err_expenseacc);

                if PostForAccount = Postforaccount::" " then Error(err_postforacc);
                case PostForAccount of
                    Postforaccount::Junior:
                        begin
                            Memba.SetFilter("Junior Savings", '<>0');
                            PostingTransactionType := GenJournalLine."transaction type"::"Junior Savings";
                        end;

                    Postforaccount::Safari:
                        begin
                            Memba.SetFilter("Safari Savings", '<>0');
                            PostingTransactionType := GenJournalLine."transaction type"::"Safari Savings";
                        end;

                    Postforaccount::Silver:
                        begin
                            Memba.SetFilter("Silver Savings", '<>0');
                            PostingTransactionType := GenJournalLine."transaction type"::"Silver Savings";
                        end;
                end;

                DOCUMENT_NO := NoSeriesMgmt.GetNextNo('JV', 0D, true);
                //COPYSTR(FORMAT(PostForAccount),1,6)+'INTEREST';
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
                    field("Post For Account"; PostForAccount)
                    {
                        ApplicationArea = Basic;
                    }
                    field("Interest Rate"; InterestRate)
                    {
                        ApplicationArea = Basic;
                    }
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
}

