#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50653 "Finance UpLoads Header"
{
    PageType = Card;
    SourceTable = "Finance Uploads Header";

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
                field("Transaction Description"; "Transaction Description")
                {
                    ApplicationArea = Basic;
                }
                field("Posting date"; "Posting date")
                {
                    ApplicationArea = Basic;
                }
                field("Document No"; "Document No")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field(Remarks; Remarks)
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Account Balancing Type"; "Account Balancing Type")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        FnRunEnableImporttype;
                    end;
                }
                field("Upload Type"; "Upload Type")
                {
                    ApplicationArea = Basic;
                }
                field("Total Count"; "Total Count")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                    Style = Strong;
                    StyleExpr = true;
                }
                field("Posted By"; "Posted By")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Account Type"; "Account Type")
                {
                    ApplicationArea = Basic;
                    Editable = EnableSingleFields;
                }
                field("Account No"; "Account No")
                {
                    ApplicationArea = Basic;
                    Editable = EnableSingleFields;
                }
                field("Balancing Account Balance"; "Balancing Account Balance")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Cheque No."; "Cheque No.")
                {
                    ApplicationArea = Basic;
                    Editable = EnableSingleFields;
                    ShowMandatory = true;
                }
                field(Posted; Posted)
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Amount; Amount)
                {
                    ApplicationArea = Basic;
                    Editable = EnableSingleFields;
                }
                field("Scheduled Amount"; "Scheduled Amount")
                {
                    ApplicationArea = Basic;
                    Style = Strong;
                    StyleExpr = true;
                }
                field("Debit Account Validated"; "Debit Account Validated")
                {
                    ApplicationArea = Basic;
                }
            }
            part("Finance UpLoads Lines"; "Finance UpLoads Lines")
            {
                Caption = 'Finance UpLoads Lines';
                SubPageLink = "Header No." = field(No);
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(ActionGroup1102755021)
            {
                action("Clear Lines")
                {
                    ApplicationArea = Basic;
                    Enabled = not ActionEnabled;
                    Image = CheckList;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        if Confirm('This Action will clear all the Lines for the current Salary Document. Do you want to Continue') = false then
                            exit;
                        ObjUpLoadsLines.Reset;
                        ObjUpLoadsLines.SetRange(ObjUpLoadsLines."Header No.", No);
                        ObjUpLoadsLines.DeleteAll;

                        BATCH_TEMPLATE := 'GENERAL';
                        BATCH_NAME := 'UPLOAD';
                        DOCUMENT_NO := Remarks;
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                        GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                        GenJournalLine.DeleteAll;
                    end;
                }
                action(ImportMultipleAccountsBalancing)
                {
                    ApplicationArea = Basic;
                    Caption = 'Import Multiple Accounts Balancing';
                    Enabled = EnableMultipleAccountBalancing;
                    Image = UpdateXML;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    RunObject = XMLport "Import Finance Upload Detailed";
                }
                action(ImportSingleAccountBalancing)
                {
                    ApplicationArea = Basic;
                    Caption = 'Import Single Account Balancing';
                    Enabled = EnableSinglAccountBalancing;
                    Image = UpdateXML;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    RunObject = XMLport "Import Finance Uploads LampSum";
                }
                action("Validate Data")
                {
                    ApplicationArea = Basic;
                    Enabled = not ActionEnabled;
                    Image = ViewCheck;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        TestField(No);
                        TestField("Document No");
                        //=======================================================================================Check Account Balance
                        VarAccountAvailableBal := 0;
                        ObjUpLoadsLines.Reset;
                        ObjUpLoadsLines.SetRange("Header No.", No);
                        ObjUpLoadsLines.SetRange(ObjUpLoadsLines."Debit Account Type", ObjUpLoadsLines."debit account type"::"Member Account/Supplier");
                        ObjUpLoadsLines.SetFilter(ObjUpLoadsLines."Debit Narration", '<>%1&<>%2&<>%3&<>%4&<>%5', '*Fee*', '*Charge*', '*Tax*', '*Commission*', '*Revers*');
                        if ObjUpLoadsLines.Find('-') then begin
                            repeat
                                VarAccountAvailableBal := SFactory.FnRunGetAccountAvailableBalance(ObjUpLoadsLines."Debit Account No");
                                if ObjUpLoadsLines.Amount > VarAccountAvailableBal then begin
                                    ObjUpLoadsLines."Debit Account Balance Status" := ObjUpLoadsLines."debit account balance status"::"Insufficient Balance"
                                end else
                                    ObjUpLoadsLines."Debit Account Balance Status" := ObjUpLoadsLines."debit account balance status"::"Sufficient Balance";

                                ObjUpLoadsLines.Modify;
                            until ObjUpLoadsLines.Next = 0;
                        end;

                        //=======================================================================================Check Debit Account Status
                        VarAccountAvailableBal := 0;
                        ObjUpLoadsLines.Reset;
                        ObjUpLoadsLines.SetRange("Header No.", No);
                        ObjUpLoadsLines.SetRange(ObjUpLoadsLines."Debit Account Type", ObjUpLoadsLines."debit account type"::"Member Account/Supplier");
                        if ObjUpLoadsLines.Find('-') then begin
                            repeat
                                if ObjVendor.Get(ObjUpLoadsLines."Debit Account No") then begin
                                    ObjUpLoadsLines."Debit Account Status" := ObjVendor.Status;
                                end;
                                ObjUpLoadsLines.Modify;
                            until ObjUpLoadsLines.Next = 0;
                        end;


                        //=======================================================================================Check Credit Account Status
                        VarAccountAvailableBal := 0;
                        ObjUpLoadsLines.Reset;
                        ObjUpLoadsLines.SetRange("Header No.", No);
                        ObjUpLoadsLines.SetRange(ObjUpLoadsLines."Credit Account Type", ObjUpLoadsLines."credit account type"::"Member Account/Supplier");
                        if ObjUpLoadsLines.Find('-') then begin
                            repeat
                                if ObjVendor.Get(ObjUpLoadsLines."Credit Account No") then begin
                                    ObjUpLoadsLines."Credit Account Status" := ObjVendor.Status;
                                end;
                                ObjUpLoadsLines.Modify;
                            until ObjUpLoadsLines.Next = 0;
                        end;

                        "Debit Account Validated" := true;
                        Message('Validation completed successfully.');
                    end;
                }
                action(ProcessUpLoad)
                {
                    ApplicationArea = Basic;
                    Caption = 'Post UpLoad';
                    Enabled = not ActionEnabled;
                    Image = Apply;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        if "Debit Account Validated" = false then
                            Error('You have to validate debit accounts before processing');


                        //=========================================================================================================Check Account Sufficient Balance
                        ObjUpLoadsLines.Reset;
                        ObjUpLoadsLines.SetRange("Header No.", No);
                        ObjUpLoadsLines.SetRange(ObjUpLoadsLines."Debit Account Type", ObjUpLoadsLines."debit account type"::"Member Account/Supplier");
                        ObjUpLoadsLines.SetRange(ObjUpLoadsLines."Debit Account Balance Status", ObjUpLoadsLines."debit account balance status"::"Insufficient Balance");
                        ObjUpLoadsLines.SetFilter(ObjUpLoadsLines."Debit Narration", '<>%1&<>%2&<>%3&<>%4&<>%5', '*Fee*', '*Charge*', '*Tax*', '*Commission*', '*Revers*');
                        if ObjUpLoadsLines.FindSet then begin
                            Error('You have a Member''s account with insufficient Balance on the lines');
                        end;



                        if Confirm('Confirm Upload Post?') = false then
                            exit;

                        TestField("Document No");
                        TestField("Transaction Description");
                        //Datefilter:='..'+FORMAT("Posting date");


                        BATCH_TEMPLATE := 'GENERAL';
                        BATCH_NAME := 'UPLOAD';
                        DOCUMENT_NO := "Document No";
                        EXTERNAL_DOC_NO := "Cheque No.";


                        if "Account Balancing Type" = "account balancing type"::"Detailed Balancing" then begin
                            FnMultipleProcessing;
                        end else begin
                            FnSingleProcessing;
                        end
                    end;
                }
                action("Mark as Posted")
                {
                    ApplicationArea = Basic;
                    Enabled = ActionEnabled;
                    Image = PostBatch;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        if Confirm('Are you sure you want to mark this upload as posted?') = false then
                            exit;
                        Posted := true;
                        "Posted By" := UserId;
                        Message('Process Completed Successfully.');
                    end;
                }
                action(Journals)
                {
                    ApplicationArea = Basic;
                    Caption = 'General Journal';
                    Image = Journals;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedOnly = true;
                    RunObject = Page "General Journal";
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        /*ObjVendorLedger.RESET;
        ObjVendorLedger.SETRANGE(ObjVendorLedger."Document No.","Document No");
        ObjVendorLedger.SETRANGE("External Document No.","Cheque No.");
        IF ObjVendorLedger.FIND('-') THEN
        ActionEnabled:=TRUE;*/

        FnRunEnableImporttype;

    end;

    trigger OnAfterGetRecord()
    begin
        FnRunEnableImporttype;
    end;

    trigger OnOpenPage()
    begin
        FnRunEnableImporttype;
    end;

    var
        EnableSinglAccountBalancing: Boolean;
        EnableMultipleAccountBalancing: Boolean;
        BATCH_TEMPLATE: Code[30];
        BATCH_NAME: Code[30];
        DOCUMENT_NO: Code[30];
        EXTERNAL_DOC_NO: Code[30];
        GenJournalLine: Record "Gen. Journal Line";
        ObjGenSetup: Record "Sacco General Set-Up";
        ObjUpLoadsHeader: Record "Finance Uploads Header";
        ObjUpLoadsLines: Record "Finance Uploads Lines";
        LineNo: Integer;
        SFactory: Codeunit "SURESTEP Factory";
        VarAccountType: Enum "Gen. Journal Account Type";
        VarBalAccountType: Enum "Gen. Journal Account Type";
        ActionEnabled: Boolean;
        ObjVendor: Record Vendor;
        EnableSingleFields: Boolean;
        EnableMultipleFields: Boolean;
        VarAccountAvailableBal: Decimal;

    local procedure FnSingleProcessing()
    begin
        ObjGenSetup.Get;

        BATCH_TEMPLATE := 'GENERAL';
        BATCH_NAME := 'UPLOAD';
        DOCUMENT_NO := "Document No";
        EXTERNAL_DOC_NO := "Cheque No.";

        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
        GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
        GenJournalLine.DeleteAll;


        ObjUpLoadsLines.Reset;
        ObjUpLoadsLines.SetRange(ObjUpLoadsLines."Header No.", No);
        if ObjUpLoadsLines.Find('-') then begin
            repeat

                //------------------------------------1.1. Credit A/C---------------------------------------------------------------------------------------------
                if ObjUpLoadsLines."Credit Account Type" = ObjUpLoadsLines."credit account type"::"Member Account/Supplier" then begin
                    VarAccountType := Varaccounttype::Vendor
                end else
                    VarAccountType := ObjUpLoadsLines."Credit Account Type";


                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLineBranch(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                VarAccountType, ObjUpLoadsLines."Credit Account No", "Posting date", ObjUpLoadsLines.Amount * -1, 'FOSA', '',
                ObjUpLoadsLines."Credit Narration", '', GenJournalLine."application source"::" ", '');


            until ObjUpLoadsLines.Next = 0;
        end;

        //Balancing Account
        LineNo := LineNo + 10000;
        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
        "Account Type", "Account No", "Posting date", Amount, 'FOSA', EXTERNAL_DOC_NO, DOCUMENT_NO, '', GenJournalLine."application source"::" ");

        Message('Upload Posted Successfully ');
    end;

    local procedure FnMultipleProcessing()
    begin
        BATCH_TEMPLATE := 'GENERAL';
        BATCH_NAME := 'UPLOAD';
        DOCUMENT_NO := "Document No";
        EXTERNAL_DOC_NO := "Cheque No.";
        GenJournalLine.Reset;

        ObjGenSetup.Get;

        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
        GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
        GenJournalLine.DeleteAll;

        ObjUpLoadsLines.Reset;
        ObjUpLoadsLines.SetRange(ObjUpLoadsLines."Header No.", No);
        if "Upload Type" = "upload type"::"Dividend & Interest" then
            ObjUpLoadsLines.SetRange(ObjUpLoadsLines.Posted, false);
        if ObjUpLoadsLines.Find('-') then begin
            repeat

                if ObjUpLoadsLines."Debit Account Type" = ObjUpLoadsLines."debit account type"::"Member Account/Supplier" then begin
                    VarAccountType := Varaccounttype::Vendor
                end else
                    VarAccountType := ObjUpLoadsLines."Debit Account Type";

                if ObjUpLoadsLines."Credit Account Type" = ObjUpLoadsLines."credit account type"::"Member Account/Supplier" then begin
                    VarBalAccountType := Varaccounttype::Vendor
                end else
                    VarBalAccountType := ObjUpLoadsLines."Credit Account Type";

                if "Upload Type" = "upload type"::"Dividend & Interest" then begin
                    DOCUMENT_NO := SFactory.FnRunGetNextTransactionDocumentNo;
                    EXTERNAL_DOC_NO := ObjUpLoadsLines."Header No.";
                end;

                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLineBranch(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                VarAccountType, ObjUpLoadsLines."Debit Account No", "Posting date", ObjUpLoadsLines.Amount, 'FOSA', '',
                ObjUpLoadsLines."Debit Narration", '', GenJournalLine."application source"::" ", '');

                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLineBranch(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                VarBalAccountType, ObjUpLoadsLines."Credit Account No", "Posting date", ObjUpLoadsLines.Amount * -1, 'FOSA', '',
                ObjUpLoadsLines."Credit Narration", '', GenJournalLine."application source"::" ", '');

                FnDividendInterestPostings;

                ObjUpLoadsLines.Posted := true;
                ObjUpLoadsLines.Modify;
            // MESSAGE('%1, %2',ObjUpLoadsLines."No.",ObjUpLoadsLines."Credit Account No");
            until ObjUpLoadsLines.Next = 0;
        end;
    end;

    local procedure FnDividendInterestPostings()
    var
        WithholdingTaxAmount: Decimal;
        ObjMember: Record Customer;
        RecommendedShareCapital: Decimal;
        AmountToCapitalize: Decimal;
        NetDividend: Decimal;
        ObjAccounts: Record Vendor;
    begin
        if "Upload Type" = "upload type"::"Dividend & Interest" then begin
            //POST WITHHOLDING TAX
            ObjGenSetup.Get;
            WithholdingTaxAmount := ObjUpLoadsLines.Amount * (ObjGenSetup."Withholding Tax (%)" / 100);
            //======================================================================================================= DEBIT TAX ON MEMBER A/C
            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
            GenJournalLine."account type"::Vendor, ObjUpLoadsLines."Credit Account No", WorkDate, WithholdingTaxAmount, 'BOSA', '',
            'Tax: ' + ObjUpLoadsLines."Credit Narration", '', GenJournalLine."application source"::CBS);

            //===================================================================================================== CREDIT TAX TO GL A/C
            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
            GenJournalLine."account type"::"G/L Account", ObjGenSetup."Withholding Tax Acc Dividend", WorkDate, WithholdingTaxAmount * -1, 'BOSA', '',
            'Tax: ' + ObjUpLoadsLines."Credit Narration" + ' - ' + ObjUpLoadsLines."Credit Account No", '', GenJournalLine."application source"::CBS);

            //CAPITALIZE PECENTAGE OF INTEREST & DIVIDEND
            ObjVendor.Reset;
            ObjVendor.SetRange(ObjVendor."No.", ObjUpLoadsLines."Credit Account No");
            if ObjVendor.FindSet then begin
                ObjMember.Reset;
                ObjMember.SetRange(ObjMember."No.", ObjVendor."BOSA Account No");
                if ObjMember.FindSet then begin
                    ObjMember.CalcFields(ObjMember."Shares Retained");
                    if ObjMember."Account Category" = ObjMember."account category"::Individual then
                        RecommendedShareCapital := ObjGenSetup."Div Capitalization Min_Indiv"
                    else
                        RecommendedShareCapital := ObjGenSetup."Div Capitalization Min_Corp";

                    if (ObjMember."Shares Retained" < RecommendedShareCapital) and (ObjMember."Share Capital No" <> ObjUpLoadsLines."Credit Account No") then begin
                        NetDividend := ObjUpLoadsLines.Amount - WithholdingTaxAmount;
                        AmountToCapitalize := ROUND(NetDividend * (ObjGenSetup."Div Capitalization %" / 100), 20, '<');
                        if (AmountToCapitalize + ObjMember."Shares Retained") > RecommendedShareCapital then
                            AmountToCapitalize := RecommendedShareCapital - ObjMember."Shares Retained";

                        ObjAccounts.Reset;
                        ObjAccounts.SetRange(ObjAccounts."No.", ObjMember."Share Capital No");
                        ObjAccounts.SetRange(ObjAccounts.Blocked, ObjAccounts.Blocked::" ");
                        ObjAccounts.SetFilter(ObjAccounts.Status, '<>%1|<>%2', ObjAccounts.Status::Closed, ObjAccounts.Status::Deceased);
                        if ObjAccounts.FindSet then begin
                            if AmountToCapitalize > 0 then begin
                                DOCUMENT_NO := SFactory.FnRunGetNextTransactionDocumentNo;
                                //Debit FOSA Account
                                LineNo := LineNo + 10000;
                                SFactory.FnCreateGnlJournalLineBranch(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                                GenJournalLine."account type"::Vendor, ObjUpLoadsLines."Credit Account No", WorkDate, AmountToCapitalize, 'BOSA', '',
                                Format(ObjGenSetup."Div Capitalization %") + '% Capitalized Net of ' + ObjUpLoadsLines."Credit Narration", '', GenJournalLine."application source"::" ", '');

                                //Credit Share Capital Account
                                LineNo := LineNo + 10000;
                                SFactory.FnCreateGnlJournalLineBranch(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                                GenJournalLine."account type"::Vendor, ObjMember."Share Capital No", WorkDate, AmountToCapitalize * -1, 'BOSA', '',
                                Format(ObjGenSetup."Div Capitalization %") + '% Capitalized Net of ' + ObjUpLoadsLines."Credit Narration", '', GenJournalLine."application source"::" ", '');
                            end;
                        end;
                    end;
                end;
            end;

            //POST INTEREST & DIVIDENDS & CAPITALIZATION
            GenJournalLine.Reset;
            GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
            GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
            if GenJournalLine.Find('-') then
                Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
        end;
    end;

    local procedure FnRunEnableImporttype()
    begin
        EnableMultipleAccountBalancing := false;
        EnableSinglAccountBalancing := false;

        if "Account Balancing Type" = "account balancing type"::"Detailed Balancing" then begin
            EnableMultipleAccountBalancing := true
        end else
            if "Account Balancing Type" = "account balancing type"::"LampSum Balancing" then begin
                EnableSinglAccountBalancing := true;
            end;



        EnableSingleFields := false;
        EnableMultipleFields := false;

        if "Account Balancing Type" = "account balancing type"::"Detailed Balancing" then begin
            EnableMultipleFields := true
        end else
            if "Account Balancing Type" = "account balancing type"::"LampSum Balancing" then begin
                EnableSingleFields := true;
            end;
    end;
}

