#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
//51516399_v6_3_0_2259) { }
// Autogenerated code - do not delete or modify -->

Report 50399 "Process Cheque Clearing(Ver.1)"
{
    RDLCLayout = 'Layouts/ProcessChequeClearing(Ver.1).rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem(Transactions; Transactions)
        {
            RequestFilterFields = No;
            column(ReportForNavId_5806; 5806) { } // Autogenerated by ForNav - Do not delete
            trigger OnPreDataItem();
            begin
                Trans.SetRange(Trans."Expected Maturity Date", 0D, Today);
            end;

            trigger OnAfterGetRecord();
            begin
                ChargeAmount := 0;
                Trans.Reset;
                Trans.SetRange(Trans."Cheque No", "Cheque No");
                if Trans.FindSet then begin
                    if (Trans.Status = Trans.Status::Pending) or (Trans.Status = Trans.Status::Honoured) then begin
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", 'PURCHASES');
                        GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
                        GenJournalLine.DeleteAll;
                        //Charges
                        ChequeType.Reset;
                        ChequeType.SetRange(ChequeType.Code, Trans."Cheque Type");
                        if ChequeType.Find('-') then begin
                            if ChequeType."Use %" = true then
                                ChargeAmount := ((ChequeType."% Of Amount" * 0.01) * Trans.Amount)
                            else
                                ChargeAmount := ChequeType."Clearing Charges";
                            LineNo := LineNo + 10000;
                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name" := 'PURCHASES';
                            GenJournalLine."Journal Batch Name" := 'FTRANS';
                            GenJournalLine."Document No." := No;
                            GenJournalLine."External Document No." := "Cheque No";
                            GenJournalLine."Line No." := LineNo;
                            GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                            GenJournalLine."Account No." := "Account No";
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine."Posting Date" := Today;
                            GenJournalLine.Description := 'Cheque Clearing Charges';
                            GenJournalLine.Validate(GenJournalLine."Currency Code");
                            GenJournalLine.Amount := ChargeAmount;
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                            GenJournalLine."Bal. Account No." := ChequeType."Clearing Charges GL Account";
                            GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                            GenJournalLine."Shortcut Dimension 1 Code" := 'FOSA';
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                            GenJournalLine."Shortcut Dimension 2 Code" := Trans."Transacting Branch";
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                            if GenJournalLine.Amount <> 0 then
                                GenJournalLine.Insert;
                        end;
                        //Charges
                        GenSetup.Get();
                        ChequeDiscounting.Reset;
                        ChequeDiscounting.SetRange(ChequeDiscounting."Cheque to Discount", No);
                        ChequeDiscounting.SetRange(ChequeDiscounting."Cheque No", "Cheque No");
                        if ChequeDiscounting.FindSet then begin
                            LineNo := LineNo + 10000;
                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name" := 'PURCHASES';
                            GenJournalLine."Journal Batch Name" := 'FTRANS';
                            GenJournalLine."Document No." := No;
                            GenJournalLine."External Document No." := "Cheque No";
                            GenJournalLine."Line No." := LineNo;
                            GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                            GenJournalLine."Account No." := "Account No";
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine."Posting Date" := Today;
                            GenJournalLine.Description := 'Cheque Discounting Commission';
                            GenJournalLine.Validate(GenJournalLine."Currency Code");
                            GenJournalLine.Amount := ChequeDiscounting."Cheque Discounting Commission";
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                            GenJournalLine."Bal. Account No." := GenSetup."Cheque Discounting Fee Account";
                            GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                            GenJournalLine."Shortcut Dimension 1 Code" := 'FOSA';
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                            GenJournalLine."Shortcut Dimension 2 Code" := Trans."Transacting Branch";
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                            if GenJournalLine.Amount <> 0 then
                                GenJournalLine.Insert;
                            //Excise Duty
                            LineNo := LineNo + 10000;
                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name" := 'PURCHASES';
                            GenJournalLine."Journal Batch Name" := 'FTRANS';
                            GenJournalLine."Document No." := No;
                            GenJournalLine."External Document No." := "Cheque No";
                            GenJournalLine."Line No." := LineNo;
                            GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                            GenJournalLine."Account No." := "Account No";
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine."Posting Date" := Today;
                            GenJournalLine.Description := 'Excise Duty';
                            GenJournalLine.Validate(GenJournalLine."Currency Code");
                            GenJournalLine.Amount := ChequeDiscounting."Cheque Discounting Commission" * (GenSetup."Excise Duty(%)" / 100);
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                            GenJournalLine."Bal. Account No." := GenSetup."Excise Duty Account";
                            GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                            GenJournalLine."Shortcut Dimension 1 Code" := 'FOSA';
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                            GenJournalLine."Shortcut Dimension 2 Code" := Trans."Transacting Branch";
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                            if GenJournalLine.Amount <> 0 then
                                GenJournalLine.Insert;
                            if Account.Get(ChequeDiscounting."Account No") then begin
                                Account."Cheque Discounted" := 0;
                                Account."Comission On Cheque Discount" := 0;
                            end;
                        end;
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", 'PURCHASES');
                        GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
                        if GenJournalLine.Find('-') then begin
                            repeat
                                //GLPosting.RUN(GenJournalLine);
                                Codeunit.Run(Codeunit::"Gen. Jnl.-Post Line", GenJournalLine);
                            until GenJournalLine.Next = 0;
                        end;
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", 'PURCHASES');
                        GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
                        GenJournalLine.DeleteAll;
                        Trans."Cheque Processed" := true;
                        Trans."Date Cleared" := Today;
                        Trans.Modify;
                    end;
                end;
            end;

        }
    }

    requestpage
    {


        SaveValues = false;
        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';

                }
            }
        }

        actions
        {
        }
        trigger OnOpenPage()
        begin
            //:= false;
        end;
    }

    trigger OnInitReport()
    begin
        ;


    end;

    trigger OnPostReport()
    begin
        ;

    end;

    trigger OnPreReport()
    begin
        ;

    end;

    var
        GenJournalLine: Record "Gen. Journal Line";
        GLPosting: Codeunit "Gen. Jnl.-Post Line";
        Account: Record Vendor;
        AccountType: Record "Account Types-Saving Products";
        LineNo: Integer;
        ChequeType: Record "Cheque Types";
        DimensionV: Record "Dimension Value";
        ChargeAmount: Decimal;
        Loans: Record "Loans Register";
        DiscountingComm: Decimal;
        Trans: Record Transactions;
        ChequeDiscounting: Record "Cheque Discounting";
        GenSetup: Record "Sacco General Set-Up";

    // --> Reports ForNAV Autogenerated code - do not delete or modify
    //51516399_v6_3_0_2259;






    // Reports ForNAV Autogenerated code - do not delete or modify -->
}
