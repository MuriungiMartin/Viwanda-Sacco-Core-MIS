codeunit 50163 "PostCustomerExtension"
{
    trigger OnRun()
    begin

    end;

    [EventSubscriber(ObjectType::codeunit, 12, 'OnAfterInsertDtldCustLedgEntry', '', false, false)]
    procedure InsertCustomfieldstodetailedcustledgerentry(GenJournalLine: Record "Gen. Journal Line"; var DtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry")
    begin

        DtldCustLedgEntry."Transaction Type" := GenJournalLine."Transaction Type";
        DtldCustLedgEntry."Loan No" := GenJournalLine."Loan No";
        DtldCustLedgEntry."Loan Type" := GenJournalLine."Loan Product Type";
        DtldCustLedgEntry."Recoverd Loan" := GenJournalLine."Recoverd Loan";
        DtldCustLedgEntry."Recovery Transaction Type" := GenJournalLine."Recovery Transaction Type";
        DtldCustLedgEntry."Transaction Date" := WorkDate();
        DtldCustLedgEntry."Application Source" := GenJournalLine."Application Source";
        DtldCustLedgEntry."Created On" := CurrentDateTime;


    end;

    [EventSubscriber(ObjectType::Codeunit, 12, 'OnBeforePostGenJnlLine', '', false, false)]
    procedure ModifyReceivablesAccount(var GenJournalLine: Record "Gen. Journal Line")
    var
        Cust: Record Customer;
        TransactionTypestable: record "Transaction Types Table";
        LoanApp: Record "Loans Register";
        LoanTypes: record "Loan Products Setup";
        CustPostingGroupBuffer: record "Customer Posting Group";
    begin
        if cust.Get(GenJournalLine."Account No.") then begin
            if cust.ISNormalMember then begin
                if GenJournalLine."Transaction Type" = GenJournalLine."Transaction Type"::" " then
                    Error('Cannot post with missing transaction type.');
                TransactionTypestable.reset;
                TransactionTypestable.SetRange(TransactionTypestable."Transaction Type", GenJournalLine."Transaction Type");
                if TransactionTypestable.Find('-') then begin
                    GenJournalLine."Posting Group" := TransactionTypestable."Posting Group Code";
                    GenJournalLine.Modify();
                end else
                    Error('The transaction setup for transaction %1 is missing', GenJournalLine."Transaction Type");
            end;
        end;

        if (GenJournalLine."Transaction Type" = GenJournalLine."transaction type"::"Loan Repayment") then begin
            if GenJournalLine."Loan No" = '' then
                Error('Loan No must be specified for Loan, Repayment or Interest transactions');

            LoanApp.Reset;
            LoanApp.SetCurrentkey(LoanApp."Loan  No.");
            LoanApp.SetRange(LoanApp."Loan  No.", GenJournalLine."Loan No");
            if LoanApp.Find('-') then begin
                if LoanTypes.Get(LoanApp."Loan Product Type") then begin
                    LoanTypes.TestField(LoanTypes."Loan Account");
                    if cust.get(GenJournalLine."Account No.") then
                        if Cust.ISNormalMember = true then
                            if GenJournalLine."Transaction Type" = GenJournalLine."Transaction Type"::" " then
                                Error('Cannot post with missing transaction type.');
                    TransactionTypestable.reset;
                    TransactionTypestable.SetRange(TransactionTypestable."Transaction Type", GenJournalLine."Transaction Type");
                    if TransactionTypestable.Find('-') then begin
                        CustPostingGroupBuffer.Reset();
                        CustPostingGroupBuffer.SetRange(Code, TransactionTypestable."Posting Group Code");
                        if CustPostingGroupBuffer.FindFirst() then begin
                            CustPostingGroupBuffer."Receivables Account" := LoanTypes."Loan Account";
                            CustPostingGroupBuffer.Modify();
                            GenJournalLine."Posting Group" := CustPostingGroupBuffer.code;
                            GenJournalLine.Modify();

                        end;

                    end else
                        Error('The transaction setup for transaction %1 is missing', GenJournalLine."Transaction Type");
                end;
            end;
        end;

        //-----------------------------------Loan Processing Fee-----------------------------------------------------------
        if (GenJournalLine."Transaction Type" = GenJournalLine."transaction type"::"Loan Application Fee charged") then begin
            if GenJournalLine."Loan No" = '' then
                Error('Loan No must be specified for Loan, Repayment,Loan Insurance or processing fee transactions :- %1', GenJournalLine."Account No.");

            LoanApp.Reset;
            LoanApp.SetCurrentkey(LoanApp."Loan  No.");
            LoanApp.SetRange(LoanApp."Loan  No.", GenJournalLine."Loan No");
            if LoanApp.Find('-') then begin
                if LoanTypes.Get(LoanApp."Loan Product Type") then begin
                    LoanTypes.TestField(LoanTypes."Loan ApplFee Accounts");
                    if cust.get(GenJournalLine."Account No.") then
                        if Cust.ISNormalMember = true then
                            if GenJournalLine."Transaction Type" = GenJournalLine."Transaction Type"::" " then
                                Error('Cannot post with missing transaction type.');
                    TransactionTypestable.reset;
                    TransactionTypestable.SetRange(TransactionTypestable."Transaction Type", GenJournalLine."Transaction Type");
                    if TransactionTypestable.Find('-') then begin
                        CustPostingGroupBuffer.Reset();
                        CustPostingGroupBuffer.SetRange(Code, TransactionTypestable."Posting Group Code");
                        if CustPostingGroupBuffer.FindFirst() then begin
                            CustPostingGroupBuffer."Receivables Account" := LoanTypes."Loan ApplFee Accounts";
                            CustPostingGroupBuffer.Modify();
                            GenJournalLine."Posting Group" := CustPostingGroupBuffer.code;
                            GenJournalLine.Modify();
                        end;
                    end else
                        Error('The transaction setup for transaction %1 is missing', GenJournalLine."Transaction Type");

                end;
            end;
        end;

        if (GenJournalLine."Transaction Type" = GenJournalLine."transaction type"::"Loan Application Fee Paid") then begin
            if GenJournalLine."Loan No" = '' then
                Error('Loan No must be specified for Loan, Repayment or processingn fee transactions :- %1', GenJournalLine."Account No.");

            LoanApp.Reset;
            LoanApp.SetCurrentkey(LoanApp."Loan  No.");
            LoanApp.SetRange(LoanApp."Loan  No.", GenJournalLine."Loan No");
            if LoanApp.Find('-') then begin
                if LoanTypes.Get(LoanApp."Loan Product Type") then begin
                    LoanTypes.TestField(LoanTypes."Receivable ApplFee Accounts");
                    if cust.get(GenJournalLine."Account No.") then
                        if Cust.ISNormalMember = true then
                            if GenJournalLine."Transaction Type" = GenJournalLine."Transaction Type"::" " then
                                Error('Cannot post with missing transaction type.');
                    TransactionTypestable.reset;
                    TransactionTypestable.SetRange(TransactionTypestable."Transaction Type", GenJournalLine."Transaction Type");
                    if TransactionTypestable.Find('-') then begin
                        CustPostingGroupBuffer.Reset();
                        CustPostingGroupBuffer.SetRange(Code, TransactionTypestable."Posting Group Code");
                        if CustPostingGroupBuffer.FindFirst() then begin
                            CustPostingGroupBuffer."Receivables Account" := LoanTypes."Receivable ApplFee Accounts";
                            CustPostingGroupBuffer.Modify();
                            GenJournalLine."Posting Group" := CustPostingGroupBuffer.code;
                            GenJournalLine.Modify();
                        end;
                    end else
                        Error('The transaction setup for transaction %1 is missing', GenJournalLine."Transaction Type");

                end;
            end;
        end;
        //-----------------------------------end Loan Processing fee-------------------------------------------------------


        if (GenJournalLine."Transaction Type" = GenJournalLine."transaction type"::"Interest Due") then begin
            if GenJournalLine."Loan No" = '' then
                Error('Loan No must be specified for Loan, Repayment,Loan Insurance or Interest transactions :- %1', GenJournalLine."Account No.");

            LoanApp.Reset;
            LoanApp.SetCurrentkey(LoanApp."Loan  No.");
            LoanApp.SetRange(LoanApp."Loan  No.", GenJournalLine."Loan No");
            if LoanApp.Find('-') then begin
                if LoanTypes.Get(LoanApp."Loan Product Type") then begin
                    LoanTypes.TestField(LoanTypes."Loan Interest Account");
                    if cust.get(GenJournalLine."Account No.") then
                        if Cust.ISNormalMember = true then
                            if GenJournalLine."Transaction Type" = GenJournalLine."Transaction Type"::" " then
                                Error('Cannot post with missing transaction type.');
                    TransactionTypestable.reset;
                    TransactionTypestable.SetRange(TransactionTypestable."Transaction Type", GenJournalLine."Transaction Type");
                    if TransactionTypestable.Find('-') then begin
                        CustPostingGroupBuffer.Reset();
                        CustPostingGroupBuffer.SetRange(Code, TransactionTypestable."Posting Group Code");
                        if CustPostingGroupBuffer.FindFirst() then begin
                            CustPostingGroupBuffer."Receivables Account" := LoanTypes."Receivable Interest Account";
                            CustPostingGroupBuffer.Modify();
                            GenJournalLine."Posting Group" := CustPostingGroupBuffer.code;
                            GenJournalLine.Modify();
                        end;
                    end else
                        Error('The transaction setup for transaction %1 is missing', GenJournalLine."Transaction Type");

                end;
            end;
        end;

        if (GenJournalLine."Transaction Type" = GenJournalLine."transaction type"::"Interest Paid") then begin
            if GenJournalLine."Loan No" = '' then
                Error('Loan No must be specified for Loan, Repayment or Interest transactions :- %1', GenJournalLine."Account No.");

            LoanApp.Reset;
            LoanApp.SetCurrentkey(LoanApp."Loan  No.");
            LoanApp.SetRange(LoanApp."Loan  No.", GenJournalLine."Loan No");
            if LoanApp.Find('-') then begin
                if LoanTypes.Get(LoanApp."Loan Product Type") then begin
                    LoanTypes.TestField(LoanTypes."Receivable Interest Account");
                    if cust.get(GenJournalLine."Account No.") then
                        if Cust.ISNormalMember = true then
                            if GenJournalLine."Transaction Type" = GenJournalLine."Transaction Type"::" " then
                                Error('Cannot post with missing transaction type.');
                    TransactionTypestable.reset;
                    TransactionTypestable.SetRange(TransactionTypestable."Transaction Type", GenJournalLine."Transaction Type");
                    if TransactionTypestable.Find('-') then begin
                        CustPostingGroupBuffer.Reset();
                        CustPostingGroupBuffer.SetRange(Code, TransactionTypestable."Posting Group Code");
                        if CustPostingGroupBuffer.FindFirst() then begin
                            CustPostingGroupBuffer."Receivables Account" := LoanTypes."Loan Interest Account";
                            CustPostingGroupBuffer.Modify();
                            GenJournalLine."Posting Group" := CustPostingGroupBuffer.code;
                            GenJournalLine.Modify();
                        end;
                    end else
                        Error('The transaction setup for transaction %1 is missing', GenJournalLine."Transaction Type");

                end;
            end;
        end;

        if (GenJournalLine."Transaction Type" = GenJournalLine."transaction type"::Loan) then begin
            if GenJournalLine."Loan No" = '' then
                Error('Loan No must be specified for Loan, Repayment or Interest transactions :- %1', GenJournalLine."Account No.");

            LoanApp.Reset;
            LoanApp.SetCurrentkey(LoanApp."Loan  No.");
            LoanApp.SetRange(LoanApp."Loan  No.", GenJournalLine."Loan No");
            if LoanApp.Find('-') then begin
                if LoanTypes.Get(LoanApp."Loan Product Type") then begin
                    LoanTypes.TestField(LoanTypes."Loan Account");
                    if cust.get(GenJournalLine."Account No.") then
                        if Cust.ISNormalMember = true then
                            if GenJournalLine."Transaction Type" = GenJournalLine."Transaction Type"::" " then
                                Error('Cannot post with missing transaction type.');
                    TransactionTypestable.reset;
                    TransactionTypestable.SetRange(TransactionTypestable."Transaction Type", GenJournalLine."Transaction Type");
                    if TransactionTypestable.Find('-') then begin
                        CustPostingGroupBuffer.Reset();
                        CustPostingGroupBuffer.SetRange(Code, TransactionTypestable."Posting Group Code");
                        if CustPostingGroupBuffer.FindFirst() then begin
                            CustPostingGroupBuffer."Receivables Account" := LoanTypes."Loan Account";
                            CustPostingGroupBuffer.Modify();
                            GenJournalLine."Posting Group" := CustPostingGroupBuffer.code;
                            GenJournalLine.Modify();
                        end;
                    end else
                        Error('The transaction setup for transaction %1 is missing', GenJournalLine."Transaction Type");
                end;
            end;

        end;

        if (GenJournalLine."Transaction Type" = GenJournalLine."transaction type"::"Loan Insurance Charged") then begin
            if GenJournalLine."Loan No" = '' then
                Error('Loan No must be specified for Loan, Repayment,Loan Insurance or Interest transactions :- %1', GenJournalLine."Account No.");

            LoanApp.Reset;
            LoanApp.SetCurrentkey(LoanApp."Loan  No.");
            LoanApp.SetRange(LoanApp."Loan  No.", GenJournalLine."Loan No");
            if LoanApp.Find('-') then begin
                if LoanTypes.Get(LoanApp."Loan Product Type") then begin
                    LoanTypes.TestField(LoanTypes."Loan Insurance Accounts");
                    if cust.get(GenJournalLine."Account No.") then
                        if Cust.ISNormalMember = true then
                            if GenJournalLine."Transaction Type" = GenJournalLine."Transaction Type"::" " then
                                Error('Cannot post with missing transaction type.');
                    TransactionTypestable.reset;
                    TransactionTypestable.SetRange(TransactionTypestable."Transaction Type", GenJournalLine."Transaction Type");
                    if TransactionTypestable.Find('-') then begin
                        CustPostingGroupBuffer.Reset();
                        CustPostingGroupBuffer.SetRange(Code, TransactionTypestable."Posting Group Code");
                        if CustPostingGroupBuffer.FindFirst() then begin
                            CustPostingGroupBuffer."Receivables Account" := LoanTypes."Receivable Insurance Accounts";
                            CustPostingGroupBuffer.Modify();
                            GenJournalLine."Posting Group" := CustPostingGroupBuffer.code;
                            GenJournalLine.Modify();
                        end;
                    end else
                        Error('The transaction setup for transaction %1 is missing', GenJournalLine."Transaction Type");

                end;
            end;

        end;

        if (GenJournalLine."Transaction Type" = GenJournalLine."transaction type"::"Loan Insurance Paid") then begin
            if GenJournalLine."Loan No" = '' then
                Error('Loan No must be specified for Loan, Repayment,Loan Insurance or Interest transactions :- %1', GenJournalLine."Account No.");

            LoanApp.Reset;
            LoanApp.SetCurrentkey(LoanApp."Loan  No.");
            LoanApp.SetRange(LoanApp."Loan  No.", GenJournalLine."Loan No");
            if LoanApp.Find('-') then begin
                if LoanTypes.Get(LoanApp."Loan Product Type") then begin
                    LoanTypes.TestField(LoanTypes."Loan Insurance Accounts");
                    if cust.get(GenJournalLine."Account No.") then
                        if Cust.ISNormalMember = true then
                            if GenJournalLine."Transaction Type" = GenJournalLine."Transaction Type"::" " then
                                Error('Cannot post with missing transaction type.');
                    TransactionTypestable.reset;
                    TransactionTypestable.SetRange(TransactionTypestable."Transaction Type", GenJournalLine."Transaction Type");
                    if TransactionTypestable.Find('-') then begin
                        CustPostingGroupBuffer.Reset();
                        CustPostingGroupBuffer.SetRange(Code, TransactionTypestable."Posting Group Code");
                        if CustPostingGroupBuffer.FindFirst() then begin
                            CustPostingGroupBuffer."Receivables Account" := LoanTypes."Receivable Insurance Accounts";
                            CustPostingGroupBuffer.Modify();
                            GenJournalLine."Posting Group" := CustPostingGroupBuffer.code;
                            GenJournalLine.Modify();
                        end;
                    end else
                        Error('The transaction setup for transaction %1 is missing', GenJournalLine."Transaction Type");

                end;
            end;

        end;



        if (GenJournalLine."Transaction Type" = GenJournalLine."transaction type"::"Loan Penalty Charged") then begin
            if GenJournalLine."Loan No" = '' then
                Error('Loan No must be specified for Loan, Repayment,Loan Insurance or Interest transactions :- %1', GenJournalLine."Account No.");

            LoanApp.Reset;
            LoanApp.SetCurrentkey(LoanApp."Loan  No.");
            LoanApp.SetRange(LoanApp."Loan  No.", GenJournalLine."Loan No");
            if LoanApp.Find('-') then begin
                if LoanTypes.Get(LoanApp."Loan Product Type") then begin
                    LoanTypes.TestField(LoanTypes."Penalty Paid Account");
                    if cust.get(GenJournalLine."Account No.") then
                        if Cust.ISNormalMember = true then
                            if GenJournalLine."Transaction Type" = GenJournalLine."Transaction Type"::" " then
                                Error('Cannot post with missing transaction type.');
                    TransactionTypestable.reset;
                    TransactionTypestable.SetRange(TransactionTypestable."Transaction Type", GenJournalLine."Transaction Type");
                    if TransactionTypestable.Find('-') then begin
                        CustPostingGroupBuffer.Reset();
                        CustPostingGroupBuffer.SetRange(Code, TransactionTypestable."Posting Group Code");
                        if CustPostingGroupBuffer.FindFirst() then begin
                            CustPostingGroupBuffer."Receivables Account" := LoanTypes."Penalty Charged Account";
                            CustPostingGroupBuffer.Modify();
                            GenJournalLine."Posting Group" := CustPostingGroupBuffer.code;
                            GenJournalLine.Modify();
                        end;
                    end else
                        Error('The transaction setup for transaction %1 is missing', GenJournalLine."Transaction Type");

                end;
            end;

        end;

        if (GenJournalLine."Transaction Type" = GenJournalLine."transaction type"::"Loan Penalty Paid") then begin
            if GenJournalLine."Loan No" = '' then
                Error('Loan No must be specified for Loan, Repayment,Loan Insurance or Interest transactions :- %1', GenJournalLine."Account No.");

            LoanApp.Reset;
            LoanApp.SetCurrentkey(LoanApp."Loan  No.");
            LoanApp.SetRange(LoanApp."Loan  No.", GenJournalLine."Loan No");
            if LoanApp.Find('-') then begin
                if LoanTypes.Get(LoanApp."Loan Product Type") then begin
                    LoanTypes.TestField(LoanTypes."Penalty Charged Account");
                    if cust.get(GenJournalLine."Account No.") then
                        if Cust.ISNormalMember = true then
                            if GenJournalLine."Transaction Type" = GenJournalLine."Transaction Type"::" " then
                                Error('Cannot post with missing transaction type.');
                    TransactionTypestable.reset;
                    TransactionTypestable.SetRange(TransactionTypestable."Transaction Type", GenJournalLine."Transaction Type");
                    if TransactionTypestable.Find('-') then begin
                        CustPostingGroupBuffer.Reset();
                        CustPostingGroupBuffer.SetRange(Code, TransactionTypestable."Posting Group Code");
                        if CustPostingGroupBuffer.FindFirst() then begin
                            CustPostingGroupBuffer."Receivables Account" := LoanTypes."Penalty Charged Account";
                            CustPostingGroupBuffer.Modify();
                            GenJournalLine."Posting Group" := CustPostingGroupBuffer.code;
                            GenJournalLine.Modify();
                        end;
                    end else
                        Error('The transaction setup for transaction %1 is missing', GenJournalLine."Transaction Type");

                end;
            end;

        end;


    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Gen. Jnl.-Post Line", 'OnAfterInitCustLedgEntry', '', false, false)]
    procedure InsertCustomTransactionFields(GenJournalLine: Record "Gen. Journal Line"; var CustLedgerEntry: Record "Cust. Ledger Entry")
    var
        cust: Record Customer;
    begin

        CustLedgerEntry."Transaction Type" := GenJournalLine."Transaction Type";
        CustLedgerEntry."Loan No" := GenJournalLine."Loan No";
        CustLedgerEntry."Loan Type" := GenJournalLine."Loan Product Type";
        CustLedgerEntry."Recoverd Loan" := GenJournalLine."Recoverd Loan";
        CustLedgerEntry."Recovery Transaction Type" := GenJournalLine."Recovery Transaction Type";
        CustLedgerEntry."Transaction Date" := WorkDate();
        CustLedgerEntry."Application Source" := GenJournalLine."Application Source";
        CustLedgerEntry."Created On" := CurrentDateTime;
        CustLedgerEntry.CalcFields(Amount);
        CustLedgerEntry."Transaction Amount" := GenJournalLine.Amount;
    end;

    [EventSubscriber(ObjectType::Table, 179, 'OnAfterReverseEntries', '', false, false)]
    procedure modifyreversedCustLedger(Number: Integer)
    var
        Custledger: Record "Cust. Ledger Entry";
        CustledgeentPage: page "Customer Ledger Entries";
        ReversalEntry: Record "Reversal Entry";

    begin
        Custledger.reset;
        if Custledger.Findlast then begin
            Custledger.CalcFields(Amount);
            if Custledger.Reversed then
                Custledger."Transaction Amount" := Custledger.amount;
            Custledger.Modify();
        end;

    end;


}