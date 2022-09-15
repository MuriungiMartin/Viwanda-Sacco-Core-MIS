#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50494 "Cheque Clearing Header"
{
    PageType = Card;
    SourceTable = "Cheque Clearing Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                field(No; No)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Entered By"; "Entered By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Date Entered"; "Date Entered")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Expected Date Of Clearing"; "Expected Date Of Clearing")
                {
                    ApplicationArea = Basic;
                }
                field(Remarks; Remarks)
                {
                    ApplicationArea = Basic;
                    Enabled = ProcessChequeClearingEnabled;
                }
                field("Total Count"; "Total Count")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Cleared  By"; "Cleared  By")
                {
                    ApplicationArea = Basic;
                }
                field("Document No"; "Document No")
                {
                    ApplicationArea = Basic;
                    Editable = ProcessChequeClearingEnabled;
                }
                field(Posted; Posted)
                {
                    ApplicationArea = Basic;
                }
                field("Scheduled Amount"; "Scheduled Amount")
                {
                    ApplicationArea = Basic;
                    Caption = 'Total Cheques Value';
                }
            }
            part(ApplyBankLedgerEntries; "Cheque Clearing Lines")
            {
                Caption = 'Banked Cheques';
                SubPageLink = "Header No" = field(No);
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(ProcessChequeClearing)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Process Cheque Clearing';
                Ellipsis = true;
                Enabled = ProcessChequeClearingEnabled;
                Image = ReverseRegister;
                Promoted = true;
                PromotedCategory = Process;
                Scope = Repeater;
                ToolTip = 'Reverse an erroneous vendor ledger entry.';

                trigger OnAction()
                var
                    ReversalEntry: Record "Reversal Entry";
                    ObjClearingLine: Record "Cheque Clearing Lines";
                    GenJournalLine: Record "Gen. Journal Line";
                    SFactory: Codeunit "SURESTEP Factory";
                    ObjChequeType: Record "Cheque Types";
                    VarBouncedChqFee: Decimal;
                    VarBouncedChequeAcc: Code[20];
                    ObjGensetup: Record "Sacco General Set-Up";
                begin
                    ObjClearingLine.Reset;
                    ObjClearingLine.SetRange(ObjClearingLine."Header No", No);
                    ObjClearingLine.SetRange(ObjClearingLine."Cheque Clearing Status", ObjClearingLine."cheque clearing status"::Bounced);
                    if ObjClearingLine.FindSet then begin
                        repeat

                            ObjClearingLine.CalcFields(ObjClearingLine."Ledger Entry No", ObjClearingLine."Ledger Transaction No.");
                            Clear(ReversalEntry);
                            if ObjClearingLine."Cheque Bounced" then
                                ReversalEntry.AlreadyReversedEntry(TableCaption, ObjClearingLine."Ledger Entry No");
                            ObjClearingLine.TestField(ObjClearingLine."Ledger Transaction No.");
                            // ReversalEntry.ReverseTransactionBouncedCheques(ObjClearingLine."Ledger Transaction No.");

                            //Post Bounced Cheque fee
                            BATCH_TEMPLATE := 'PURCHASES';
                            BATCH_NAME := 'FTRANS';
                            DOCUMENT_NO := ObjClearingLine."Cheque No";
                            GenJournalLine.Reset;
                            GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                            GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                            GenJournalLine.DeleteAll;
                            ObjGensetup.Get();

                            //Get Cheque Charges
                            ObjChequeType.Reset;
                            ObjChequeType.SetRange(ObjChequeType.Code, ObjClearingLine."Cheque Type");
                            if ObjChequeType.FindSet then begin
                                VarBouncedChqFee := ObjChequeType."Bounced Charges";
                                VarBouncedChequeAcc := ObjChequeType."Bounced Charges GL Account";
                                VarBankCharge := ObjChequeType."Bounced Cheque Bank Charge";
                                VarSaccoIncome := ObjChequeType."Bounced Cheque Sacco Income";
                                VarBankCode := ObjChequeType."Clearing Bank Account";
                                VarBankPosting := (VarBouncedChqFee - VarSaccoIncome) + ((VarBouncedChqFee - VarSaccoIncome) * ObjGensetup."Excise Duty(%)" / 100);
                            end;
                            //MESSAGE('BouncedChqFee %1, BankCharge %2, SaccoIncome %3',VarBouncedChqFee,VarBankCharge,VarSaccoIncome);
                            //------------------------------------1. DEBIT MEMBER A/C---------------------------------------------------------------------------------------------
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                            GenJournalLine."account type"::Vendor, ObjClearingLine."Account No", Today, VarBouncedChqFee, 'FOSA', ObjClearingLine."Cheque No",
                            'Bounced Cheque Fee #' + ObjClearingLine."Cheque No", '', GenJournalLine."application source"::CBS);
                            //--------------------------------(Debit Member Account)---------------------------------------------

                            //------------------------------------2. DEBIT MEMBER A/C EXCISE DUTY---------------------------------------------------------------------------------------------
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                            GenJournalLine."account type"::Vendor, ObjClearingLine."Account No", Today, (VarBouncedChqFee * (ObjGensetup."Excise Duty(%)" / 100)), 'FOSA', ObjClearingLine."Cheque No",
                            'Tax: Bounced Cheque Fee #' + ObjClearingLine."Cheque No", '', GenJournalLine."application source"::CBS);
                            //--------------------------------(Debit Member Account)---------------------------------------------


                            //------------------------------------3. CREDIT Bank A/C---------------------------------------------------------------------------------------------
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                            GenJournalLine."account type"::"Bank Account", VarBankCode, Today, VarBankPosting * -1, 'FOSA', ObjClearingLine."Cheque No",
                            'Bounced Cheque Fee #' + ObjClearingLine."Cheque No" + ' Acc. ' + ObjClearingLine."Account No", '', GenJournalLine."application source"::CBS);
                            //----------------------------------(Credit Income G/L Account)------------------------------------------------

                            //------------------------------------4. CREDIT INCOME G/L A/C---------------------------------------------------------------------------------------------
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                            GenJournalLine."account type"::"G/L Account", VarBouncedChequeAcc, Today, VarSaccoIncome * -1, 'FOSA', ObjClearingLine."Cheque No",
                            'Bounced Cheque Fee #' + ObjClearingLine."Cheque No" + ' Acc. ' + ObjClearingLine."Account No", '', GenJournalLine."application source"::CBS);
                            //----------------------------------(Credit Income G/L Account)------------------------------------------------

                            //------------------------------------5. CREDIT EXCISE DUTY G/L A/C---------------------------------------------------------------------------------------------
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                            GenJournalLine."account type"::"G/L Account", ObjGensetup."Excise Duty Account", Today, (VarSaccoIncome * (ObjGensetup."Excise Duty(%)" / 100)) * -1, 'FOSA', ObjClearingLine."Cheque No",
                            'Tax: Bounced Cheque Fee #' + ObjClearingLine."Cheque No" + ' Acc. ' + ObjClearingLine."Account No", '', GenJournalLine."application source"::CBS);
                            //----------------------------------(Credit Excise Duty G/L Account)------------------------------------------------

                            //CU posting
                            GenJournalLine.Reset;
                            GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                            GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                            if GenJournalLine.Find('-') then
                                Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);


                            ObjTransactions.Reset;
                            ObjTransactions.SetRange(ObjTransactions.No, ObjClearingLine."Transaction No");
                            if ObjTransactions.FindSet then begin
                                ObjTransactions."Cheque Processed" := true;
                                ObjTransactions."Date Cleared" := WorkDate;
                                ObjTransactions.Modify;
                            end;
                        until ObjClearingLine.Next = 0;
                    end;

                    ObjClearingLine.Reset;
                    ObjClearingLine.SetRange(ObjClearingLine."Header No", No);
                    ObjClearingLine.SetRange(ObjClearingLine."Cheque Clearing Status", ObjClearingLine."cheque clearing status"::Cleared);
                    if ObjClearingLine.FindSet then begin
                        repeat
                            ObjTransactions.Reset;
                            ObjTransactions.SetRange(ObjTransactions.No, ObjClearingLine."Transaction No");
                            if ObjTransactions.FindSet then begin
                                ObjTransactions."Cheque Processed" := true;
                                ObjTransactions."Date Cleared" := WorkDate;
                                ObjTransactions.Modify;
                                SFactory.FnRunAfterCashDepositProcess(ObjClearingLine."Account No");
                            end;
                        until ObjClearingLine.Next = 0;
                    end;


                    Message('Cheque Clearing Processed Succesfully');
                    Posted := true;
                    "Cleared  By" := UserId;
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        ProcessChequeClearingEnabled := true;
        if Posted = true then
            ProcessChequeClearingEnabled := false;
    end;

    trigger OnAfterGetRecord()
    begin
        ProcessChequeClearingEnabled := true;
        if Posted = true then
            ProcessChequeClearingEnabled := false;
    end;

    trigger OnOpenPage()
    begin
        ProcessChequeClearingEnabled := true;
        if Posted = true then
            ProcessChequeClearingEnabled := false;
    end;

    var
        Gnljnline: Record "Gen. Journal Line";
        PDate: Date;
        DocNo: Code[20];
        RunBal: Decimal;
        ReceiptsProcessingLines: Record "Checkoff Lines-Distributed";
        LineNo: Integer;
        LBatches: Record "Loan Disburesment-Batching";
        Jtemplate: Code[30];
        JBatch: Code[30];
        "Cheque No.": Code[20];
        DActivityBOSA: Code[20];
        DBranchBOSA: Code[20];
        ReptProcHeader: Record "Checkoff Header-Distributed";
        Cust: Record Customer;
        salarybuffer: Record "Salary Processing Lines";
        SalHeader: Record "Salary Processing Headerr";
        Sto: Record "Standing Orders";
        BATCH_TEMPLATE: Code[20];
        BATCH_NAME: Code[20];
        DOCUMENT_NO: Code[20];
        ObjTransactions: Record Transactions;
        SFactory: Codeunit "SURESTEP Factory";
        ProcessChequeClearingEnabled: Boolean;
        VarBankCharge: Decimal;
        VarBankCode: Code[30];
        VarSaccoIncome: Decimal;
        VarBankPosting: Decimal;
}

