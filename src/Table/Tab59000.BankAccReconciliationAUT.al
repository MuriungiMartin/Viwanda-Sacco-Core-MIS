#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 59000 "Bank Acc. ReconciliationAUT"
{
    Caption = 'Bank Acc. Reconciliation';
    DataCaptionFields = "Bank Account No.", "Statement No.";
    ////nownPage59003;
    Permissions = TableData "Data Exch." = rimd;

    fields
    {
        field(1; "Bank Account No."; Code[20])
        {
            Caption = 'Bank Account No.';
            NotBlank = true;
            TableRelation = "Bank Account";

            trigger OnValidate()
            begin
                // IF "Statement No." = '' THEN BEGIN
                //  BankAcc.LOCKTABLE;
                //  BankAcc.GET("Bank Account No.");
                //
                //  IF "Statement Type" = "Statement Type"::"Payment Application" THEN BEGIN
                //    SetLastPaymentStatementNo(BankAcc);
                //    "Statement No." := INCSTR(BankAcc."Last Payment Statement No.");
                //    BankAcc."Last Payment Statement No." := "Statement No.";
                //  END ELSE BEGIN
                //    SetLastStatementNo(BankAcc);
                //    "Statement No." := INCSTR(BankAcc."Last Statement No.");
                //    BankAcc."Last Statement No." := "Statement No.";
                //  END;
                //
                //  "Balance Last Statement" := BankAcc."Balance Last Statement";
                //  BankAcc.MODIFY;
                // END;
                //
                // CreateDim(DATABASE::"Bank Account",BankAcc."No.");
            end;
        }
        field(2; "Statement No."; Code[20])
        {
            Caption = 'Statement No.';
            NotBlank = true;

            trigger OnValidate()
            begin
                // TESTFIELD("Bank Account No.");
                // IF "Statement Type" = "Statement Type"::"Bank Reconciliation" THEN BEGIN
                //  BankAcc.LOCKTABLE;
                //  BankAcc.GET("Bank Account No.");
                //  BankAcc."Last Statement No." := "Statement No.";
                //  BankAcc.MODIFY;
                // END;
            end;
        }
        field(3; "Statement Ending Balance"; Decimal)
        {
            AutoFormatExpression = GetCurrencyCode;
            AutoFormatType = 1;
            Caption = 'Statement Ending Balance';
        }
        field(4; "Statement Date"; Date)
        {
            Caption = 'Statement Date';
        }
        field(5; "Balance Last Statement"; Decimal)
        {
            AutoFormatExpression = GetCurrencyCode;
            AutoFormatType = 1;
            Caption = 'Balance Last Statement';

            trigger OnValidate()
            begin
                // TESTFIELD("Statement Type","Statement Type"::"Bank Reconciliation");
                // BankAcc.GET("Bank Account No.");
                // IF "Balance Last Statement" <> BankAcc."Balance Last Statement" THEN
                //  IF NOT
                //     CONFIRM(
                //       Text002,FALSE,
                //       FIELDCAPTION("Balance Last Statement"),BankAcc.FIELDCAPTION("Balance Last Statement"),
                //       BankAcc.TABLECAPTION)
                //  THEN
                //    "Balance Last Statement" := xRec."Balance Last Statement";
            end;
        }
        field(6; "Bank Statement"; Blob)
        {
            Caption = 'Bank Statement';
        }
        field(7; "Total Balance on Bank Account"; Decimal)
        {
            AutoFormatExpression = GetCurrencyCode;
            AutoFormatType = 1;
            CalcFormula = sum("Bank Account Ledger Entry".Amount where("Bank Account No." = field("Bank Account No.")));
            Caption = 'Total Balance on Bank Account';
            Editable = false;
            FieldClass = FlowField;
        }
        field(8; "Total Applied Amount"; Decimal)
        {
            AutoFormatExpression = GetCurrencyCode;
            CalcFormula = sum("Bank Acc. Reconciliation Lines"."Applied Amount" where("Statement Type" = field("Statement Type"),
                                                                                       "Bank Account No." = field("Bank Account No."),
                                                                                       "Statement No." = field("Statement No.")));
            Caption = 'Total Applied Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(9; "Total Transaction Amount"; Decimal)
        {
            AutoFormatExpression = GetCurrencyCode;
            CalcFormula = sum("Bank Acc. Reconciliation Lines"."Statement Amount" where("Statement Type" = field("Statement Type"),
                                                                                         "Bank Account No." = field("Bank Account No."),
                                                                                         "Statement No." = field("Statement No.")));
            Caption = 'Total Transaction Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(20; "Statement Type"; Option)
        {
            Caption = 'Statement Type';
            OptionCaption = 'Bank Reconciliation,Payment Application';
            OptionMembers = "Bank Reconciliation","Payment Application";
        }
        field(21; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));

            trigger OnValidate()
            begin
                //ValidateShortcutDimCode(1,"Shortcut Dimension 1 Code");
            end;
        }
        field(22; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));

            trigger OnValidate()
            begin
                //ValidateShortcutDimCode(2,"Shortcut Dimension 2 Code");
            end;
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = false;
            TableRelation = "Dimension Set Entry";

            trigger OnLookup()
            begin
                //ShowDocDim;
            end;
        }
        field(50000; "Total Reconcilled"; Decimal)
        {
            CalcFormula = sum("Bank Acc. Reconciliation Lines"."Applied Amount" where("Bank Account No." = field("Bank Account No."),
                                                                                       Difference = filter(0)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50002; "Total Unreconcilled"; Decimal)
        {
            CalcFormula = sum("Bank Acc. Reconciliation Lines".Difference where("Bank Account No." = field("Bank Account No.")));
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Statement Type", "Bank Account No.", "Statement No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        // IF BankAccReconLine.LinesExist(Rec) THEN
        //  BankAccReconLine.DELETEALL(TRUE);
    end;

    trigger OnInsert()
    begin
        TestField("Bank Account No.");
        TestField("Statement No.");
        BankAccRecon.Reset;
        BankAccRecon.SetRange("Statement Type", BankAccRecon."Statement Type");
        BankAccRecon.SetRange("Bank Account No.", "Bank Account No.");
        case "Statement Type" of
            "statement type"::"Bank Reconciliation":
                if PostedBankAccStmt.Get("Bank Account No.", "Statement No.") then
                    Error(Text000, "Statement No.");
            "statement type"::"Payment Application":
                if PostedPaymentReconHdr.Get("Bank Account No.", "Statement No.") then
                    Error(Text000, "Statement No.");
        end;
    end;

    trigger OnRename()
    begin
        // ERROR(Text001,TABLECAPTION);
    end;

    var
        Text000: label 'Statement %1 already exists.';
        Text001: label 'You cannot rename a %1.';
        Text002: label '%1 is different from %2 on the %3. Do you want to change the value?';
        BankAcc: Record "Bank Account";
        BankAccRecon: Record "Bank Acc. ReconciliationAUT";
        BankAccReconLine: Record "Bank Acc. Reconciliation Lines";
        PostedBankAccStmt: Record "Bank Account Statements";
        PostedPaymentReconHdr: Record "Posted Payment Recon. Hdr";
        DimMgt: Codeunit DimensionManagement;
        YouChangedDimQst: label 'You may have changed a dimension.\\Do you want to update the lines?';
        NoBankAccountsMsg: label 'You have not set up a bank account.\To use the payments import process, set up a bank account.';
        NoBankAccWithFileFormatMsg: label 'No bank account exists that is ready for import of bank statement files.\Fill the Bank Statement Import Format field on the card of the bank account that you want to use.';
        PostHighConfidentLinesQst: label 'All imported bank statement lines were applied with high confidence level.\Do you want to post the payment applications?';
        MustHaveValueQst: label 'The bank account must have a value in %1. Do you want to open the bank account card?';

    local procedure CreateDim(Type1: Integer; No1: Code[20])
    var
        SourceCodeSetup: Record "Source Code Setup";
        TableID: array[10] of Integer;
        No: array[10] of Code[20];
        OldDimSetID: Integer;
    begin
        // SourceCodeSetup.GET;
        // TableID[1] := Type1;
        // No[1] := No1;
        // "Shortcut Dimension 1 Code" := '';
        // "Shortcut Dimension 2 Code" := '';
        // OldDimSetID := "Dimension Set ID";
        // "Dimension Set ID" :=
        //  DimMgt.GetDefaultDimID(
        //    TableID,No,SourceCodeSetup."Payment Reconciliation Journal","Shortcut Dimension 1 Code","Shortcut Dimension 2 Code",0,0);
        //
        // IF (OldDimSetID <> "Dimension Set ID") AND LinesExist THEN BEGIN
        //  MODIFY;
        //  UpdateAllLineDim("Dimension Set ID",OldDimSetID);
        // END;
    end;

    local procedure GetCurrencyCode(): Code[10]
    var
        BankAcc2: Record "Bank Account";
    begin
        // IF "Bank Account No." = BankAcc2."No." THEN
        //  EXIT(BankAcc2."Currency Code");
        //
        // IF BankAcc2.GET("Bank Account No.") THEN
        //  EXIT(BankAcc2."Currency Code");
        //
        // EXIT('');
    end;


    procedure MatchSingle(DateRange: Integer)
    var
        MatchBankRecLines: Codeunit "Match Bank Rec. Liness";
    begin
        // MatchBankRecLines.MatchSingle(Rec,DateRange);
    end;


    procedure ImportBankStatement()
    var
        DataExch: Record "Data Exch.";
        ProcessBankAccRecLines: Codeunit "Process Bank Acc. Rec Liness";
    begin
        // IF BankAccountCouldBeUsedForImport THEN BEGIN
        //  DataExch.INIT;
        //  ProcessBankAccRecLines.ImportBankStatement(Rec,DataExch);
        // END;
    end;

    local procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    var
        DimMgt: Codeunit DimensionManagement;
        OldDimSetID: Integer;
    begin
        // OldDimSetID := "Dimension Set ID";
        // DimMgt.ValidateShortcutDimValues(FieldNumber,ShortcutDimCode,"Dimension Set ID");
        //
        // IF OldDimSetID <> "Dimension Set ID" THEN BEGIN
        //  MODIFY;
        //  UpdateAllLineDim("Dimension Set ID",OldDimSetID);
        // END;
    end;


    procedure ShowDocDim()
    var
        OldDimSetID: Integer;
    begin
        // OldDimSetID := "Dimension Set ID";
        // "Dimension Set ID" :=
        //  DimMgt.EditDimensionSet2(
        //    "Dimension Set ID",STRSUBSTNO('%1 %2',TABLECAPTION,"Statement No."),
        //    "Shortcut Dimension 1 Code","Shortcut Dimension 2 Code");
        //
        // IF OldDimSetID <> "Dimension Set ID" THEN BEGIN
        //  MODIFY;
        //  UpdateAllLineDim("Dimension Set ID",OldDimSetID);
        // END;
    end;

    local procedure UpdateAllLineDim(NewParentDimSetID: Integer; OldParentDimSetID: Integer)
    var
        BankAccReconciliationLine: Record "Bank Acc. Reconciliation Lines";
        NewDimSetID: Integer;
    begin
        // // Update all lines with changed dimensions.
        // IF NewParentDimSetID = OldParentDimSetID THEN
        //  EXIT;
        //
        // BankAccReconciliationLine.LOCKTABLE;
        // IF BankAccReconciliationLine.LinesExist(Rec) THEN BEGIN
        //  IF NOT CONFIRM(YouChangedDimQst) THEN
        //    EXIT;
        //
        //  REPEAT
        //    NewDimSetID :=
        //      DimMgt.GetDeltaDimSetID(BankAccReconciliationLine."Dimension Set ID",NewParentDimSetID,OldParentDimSetID);
        //    IF BankAccReconciliationLine."Dimension Set ID" <> NewDimSetID THEN BEGIN
        //      BankAccReconciliationLine."Dimension Set ID" := NewDimSetID;
        //      DimMgt.UpdateGlobalDimFromDimSetID(
        //        BankAccReconciliationLine."Dimension Set ID",
        //        BankAccReconciliationLine."Shortcut Dimension 1 Code",
        //        BankAccReconciliationLine."Shortcut Dimension 2 Code");
        //      BankAccReconciliationLine.MODIFY;
        //    END;
        //  UNTIL BankAccReconciliationLine.NEXT = 0;
        // END;
    end;


    procedure OpenNewWorksheet()
    var
        BankAccount: Record "Bank Account";
        BankAccReconciliation: Record "Bank Acc. ReconciliationAUT";
    begin
        // IF NOT SelectBankAccountToUse(BankAccount,FALSE) THEN
        //  EXIT;
        //
        // CreateNewBankPaymentAppBatch(BankAccount."No.",BankAccReconciliation);
        // OpenWorksheet(BankAccReconciliation);
    end;


    procedure ImportAndProcessToNewStatement()
    var
        BankAccount: Record "Bank Account";
        BankAccReconciliation: Record "Bank Acc. ReconciliationAUT";
        DataExch: Record "Data Exch.";
        DataExchDef: Record "Data Exch. Def";
    begin
        // IF NOT SelectBankAccountToUse(BankAccount,TRUE) THEN
        //  EXIT;
        // BankAccount.GetDataExchDef(DataExchDef);
        //
        // IF NOT DataExch.ImportFileContent(DataExchDef) THEN
        //  EXIT;
        //
        // CreateNewBankPaymentAppBatch(BankAccount."No.",BankAccReconciliation);
        // ImportAndProcessStatement(BankAccReconciliation,DataExch);
    end;

    local procedure ImportAndProcessStatement(BankAccReconciliation: Record "Bank Acc. ReconciliationAUT"; DataExch: Record "Data Exch.")
    var
        ProcessBankAccRecLines: Codeunit "Process Bank Acc. Rec Liness";
    begin
        // IF NOT ProcessBankAccRecLines.ImportBankStatement(BankAccReconciliation,DataExch) THEN
        //  EXIT;
        //
        // COMMIT;
        // CODEUNIT.RUN(CODEUNIT::"Match Bank Pmt. Appl.",BankAccReconciliation);
        //
        // IF ConfidenceLevelPermitToPost(BankAccReconciliation) THEN
        //  CODEUNIT.RUN(CODEUNIT::"Bank Acc. Reconciliation Post",BankAccReconciliation)
        // ELSE
        //  OpenWorksheet(BankAccReconciliation);
    end;


    procedure CreateNewBankPaymentAppBatch(BankAccountNo: Code[20]; var BankAccReconciliation: Record "Bank Acc. ReconciliationAUT")
    begin
        // BankAccReconciliation.INIT;
        // BankAccReconciliation."Statement Type" := BankAccReconciliation."Statement Type"::"Payment Application";
        // BankAccReconciliation.VALIDATE("Bank Account No.",BankAccountNo);
        // BankAccReconciliation.INSERT(TRUE);
    end;

    local procedure SelectBankAccountToUse(var BankAccount: Record "Bank Account"; OnlyWithImportFormatSet: Boolean): Boolean
    var
        PaymentBankAccountList: Page "Payment Bank Account List";
    begin
        // IF OnlyWithImportFormatSet THEN
        //  BankAccount.SETFILTER("Bank Statement Import Format",'<>%1','');
        //
        // CASE BankAccount.COUNT OF
        //  0:
        //    BEGIN
        //      IF NOT BankAccount.GET(CantFindBancAccToUseInPaymentFileImport) THEN
        //        EXIT(FALSE);
        //
        //      EXIT(TRUE);
        //    END;
        //  1:
        //    BankAccount.FINDFIRST;
        //  ELSE BEGIN
        //    PaymentBankAccountList.LOOKUPMODE(TRUE);
        //    PaymentBankAccountList.SETTABLEVIEW(BankAccount);
        //    IF PaymentBankAccountList.RUNMODAL = ACTION::LookupOK THEN
        //      PaymentBankAccountList.GETRECORD(BankAccount)
        //    ELSE
        //      EXIT(FALSE);
        //  END;
        // END;
        //
        // EXIT(TRUE);
    end;


    procedure OpenWorksheet(BankAccReconciliation: Record "Bank Acc. ReconciliationAUT")
    var
        BankAccReconciliationLine: Record "Bank Acc. Reconciliation Lines";
    begin
        // SetFiltersOnBankAccReconLineTable(BankAccReconciliation,BankAccReconciliationLine);
        // PAGE.RUN(PAGE::"Payment Reconciliation Journal",BankAccReconciliationLine);
    end;

    local procedure CantFindBancAccToUseInPaymentFileImport(): Code[20]
    var
        BankAccount: Record "Bank Account";
    begin
        // IF BankAccount.COUNT = 0 THEN
        //  MESSAGE(NoBankAccountsMsg)
        // ELSE
        //  MESSAGE(NoBankAccWithFileFormatMsg);
        //
        // IF PAGE.RUNMODAL(PAGE::"Payment Bank Account List",BankAccount) = ACTION::LookupOK THEN
        //  IF BankAccount."Bank Statement Import Format" <> '' THEN
        //    EXIT(BankAccount."No.");
        //
        // EXIT('');
    end;

    local procedure SetLastPaymentStatementNo(var BankAccount: Record "Bank Account")
    begin
        // IF BankAccount."Last Payment Statement No." = '' THEN BEGIN
        //  BankAccount."Last Payment Statement No." := '0';
        //  BankAccount.MODIFY;
        // END;
    end;

    local procedure SetLastStatementNo(var BankAccount: Record "Bank Account")
    begin
        // IF BankAccount."Last Statement No." = '' THEN BEGIN
        //  BankAccount."Last Statement No." := '0';
        //  BankAccount.MODIFY;
        // END;
    end;


    procedure SetFiltersOnBankAccReconLineTable(BankAccReconciliation: Record "Bank Acc. ReconciliationAUT"; var BankAccReconciliationLine: Record "Bank Acc. Reconciliation Lines")
    begin
        // BankAccReconciliationLine.FILTERGROUP := 2;
        // BankAccReconciliationLine.SETRANGE("Statement Type",BankAccReconciliation."Statement Type");
        // BankAccReconciliationLine.SETRANGE("Bank Account No.",BankAccReconciliation."Bank Account No.");
        // BankAccReconciliationLine.SETRANGE("Statement No.",BankAccReconciliation."Statement No.");
        // BankAccReconciliationLine.FILTERGROUP := 0;
    end;

    local procedure ConfidenceLevelPermitToPost(BankAccReconciliation: Record "Bank Acc. ReconciliationAUT"): Boolean
    var
        BankAccReconciliationLine: Record "Bank Acc. Reconciliation Lines";
    begin
        // SetFiltersOnBankAccReconLineTable(BankAccReconciliation,BankAccReconciliationLine);
        // IF BankAccReconciliationLine.COUNT = 0 THEN
        //  EXIT(FALSE);
        //
        // BankAccReconciliationLine.SETFILTER("Match Confidence",'<>%1',BankAccReconciliationLine."Match Confidence"::High);
        // IF BankAccReconciliationLine.COUNT <> 0 THEN
        //  EXIT(FALSE);
        //
        // IF CONFIRM(PostHighConfidentLinesQst) THEN
        //  EXIT(TRUE);
        //
        // EXIT(FALSE);
    end;

    local procedure LinesExist(): Boolean
    var
        BankAccReconciliationLine: Record "Bank Acc. Reconciliation Lines";
    begin
        //EXIT(BankAccReconciliationLine.LinesExist(Rec));
    end;

    local procedure BankAccountCouldBeUsedForImport(): Boolean
    var
        BankAccount: Record "Bank Account";
    begin
        // BankAccount.GET("Bank Account No.");
        // IF BankAccount."Bank Statement Import Format" <> '' THEN
        //  EXIT(TRUE);
        //
        // IF NOT CONFIRM(MustHaveValueQst,TRUE,BankAccount.FIELDCAPTION("Bank Statement Import Format")) THEN
        //  EXIT(FALSE);
        //
        // IF PAGE.RUNMODAL(PAGE::"Payment Bank Account Card",BankAccount) = ACTION::LookupOK THEN
        //  IF BankAccount."Bank Statement Import Format" <> '' THEN
        //    EXIT(TRUE);
        //
        // EXIT(FALSE);
    end;


    procedure GetTempCopy(var BankAccReconciliation: Record "Bank Acc. ReconciliationAUT")
    begin
        // IF BankAccReconciliation.HASFILTER THEN
        //  COPYFILTERS(BankAccReconciliation);
        //
        // SETRANGE("Statement Type","Statement Type"::"Bank Reconciliation");
        // IF NOT FINDSET THEN
        //  EXIT;
        //
        // REPEAT
        //  BankAccReconciliation := Rec;
        //  BankAccReconciliation.INSERT;
        // UNTIL NEXT = 0;
    end;


    procedure GetTempCopyFromBankRecHeader(var BankAccReconciliation: Record "Bank Acc. ReconciliationAUT")
    var
    //   BankRecHeader: Record "Integration Record";
    begin
        // IF BankAccReconciliation.HASFILTER THEN BEGIN
        //  BankRecHeader.SETFILTER("Bank Account No.",BankAccReconciliation.GETFILTER("Bank Account No."));
        //  BankRecHeader.SETFILTER("Statement No.",BankAccReconciliation.GETFILTER("Statement No."));
        //  BankRecHeader.SETFILTER("Statement Date",BankAccReconciliation.GETFILTER("Statement Date"));
        //  BankRecHeader.SETFILTER("Statement Balance",BankAccReconciliation.GETFILTER("Balance Last Statement"));
        // END;
        //
        // IF NOT BankRecHeader.FINDSET THEN
        //  EXIT;
        //
        // REPEAT
        //  BankAccReconciliation."Statement Type" := BankAccReconciliation."Statement Type"::"Bank Reconciliation";
        //  BankAccReconciliation."Bank Account No." := BankRecHeader."Bank Account No.";
        //  BankAccReconciliation."Statement No." := BankRecHeader."Statement No.";
        //  BankAccReconciliation."Statement Date" := BankRecHeader."Statement Date";
        //  BankAccReconciliation."Balance Last Statement" := BankRecHeader."Statement Balance";
        //  BankAccReconciliation."Statement Ending Balance" := BankRecHeader.CalculateEndingBalance;
        //  BankAccReconciliation.INSERT;
        // UNTIL BankRecHeader.NEXT = 0;
    end;


    procedure InsertRec(StatementType: Option; BankAccountNo: Code[20])
    begin
        // INIT;
        // VALIDATE("Statement Type",StatementType);
        // VALIDATE("Bank Account No.",BankAccountNo);
        // INSERT(TRUE);
    end;
}

