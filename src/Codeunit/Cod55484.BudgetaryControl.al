#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Codeunit 55484 "Budgetary Control"
{

    trigger OnRun()
    begin
    end;

    var
        BCSetup: Record "Budgetary Control Setup";
        DimMgt: Codeunit DimensionManagement;
        ShortcutDimCode: array [8] of Code[20];
        BudgetGL: Code[20];
        Text0001: label 'You Have exceeded the Budget by ';
        Text0002: label ' Do you want to Continue?';
        Text0003: label 'There is no Budget to Check against do you wish to continue?';
        objJobs: Record Jobs;


    procedure CheckPurchase(var PurchHeader: Record "Purchase Header")
    var
        PurchLine: Record "Purchase Line";
        Commitments: Record Committment;
        Amount: Decimal;
        GLAcc: Record "G/L Account";
        Item: Record Item;
        FirstDay: Date;
        LastDay: Date;
        CurrMonth: Integer;
        Budget: Record "G/L Budget Entry";
        BudgetAmount: Decimal;
        Actuals: Record "Analysis View Entry";
        ActualsAmount: Decimal;
        CommitmentAmount: Decimal;
        FixedAssetsDet: Record "Fixed Asset";
        FAPostingGRP: Record "FA Posting Group";
        EntryNo: Integer;
        GLAccount: Record "G/L Account";
        dimSetEntry: Record "Dimension Set Entry";
    begin
        /*//First Update Analysis View
        //UpdateAnalysisView();
        
        //get the budget control setup first to determine if it mandatory or not
        BCSetup.RESET;
        BCSetup.GET();
        IF BCSetup.Mandatory THEN//budgetary control is mandatory
          BEGIN
            //check if the dates are within the specified range in relation to the payment header table
            IF (PurchHeader."Document Date"< BCSetup."Current Budget Start Date") THEN
              BEGIN
                ERROR('The Current Date %1 In The Order Does Not Fall Within Budget Dates %2 - %3',PurchHeader."Document Date",
                BCSetup."Current Budget Start Date",BCSetup."Current Budget End Date");
              END
            ELSE IF (PurchHeader."Document Date">BCSetup."Current Budget End Date") THEN
              BEGIN
                ERROR('The Current Date %1 In The Order Does Not Fall Within Budget Dates %2 - %3',PurchHeader."Document Date",
                BCSetup."Current Budget Start Date",BCSetup."Current Budget End Date");
        
              END;
            //Is budget Available
            CheckIfBlocked(BCSetup."Current Budget Code");
            //Get Commitment Lines
                 IF Commitments.FIND('+') THEN
                EntryNo:=Commitments."Line No.";
        
            //get the lines related to the payment header
              PurchLine.RESET;
              PurchLine.SETRANGE(PurchLine."Document Type",PurchHeader."Document Type");
              PurchLine.SETRANGE(PurchLine."Document No.",PurchHeader."No.");
              IF PurchLine.FINDFIRST THEN
                BEGIN
                  REPEAT
        
                 //Get the Dimension Here
                   IF PurchLine."Line No." <> 0 THEN
                        DimMgt.ShowDocDim(
                          DATABASE::"Purchase Line",PurchLine."Document Type",PurchLine."Dimension Set ID",
                          PurchLine."Line No.",ShortcutDimCode)
                      ELSE
                       DimMgt.ShowTempDim(ShortcutDimCode);
                 //Had to be put here for the sake of Calculating Individual Line Entries
        
                    //check the type of account in the payments line
                    //Item
                      IF PurchLine.Type=PurchLine.Type::Item THEN BEGIN
                          Item.RESET;
                          IF NOT Item.GET(PurchLine."No.") THEN
                             ERROR('Item Does not Exist');
        
                          Item.TESTFIELD("Item G/L Budget Account");
                          BudgetGL:=Item."Item G/L Budget Account";
                       END;
                      //  MESSAGE('FOUND');
                       IF PurchLine.Type=PurchLine.Type::"Fixed Asset" THEN BEGIN
                               FixedAssetsDet.RESET;
                               FixedAssetsDet.SETRANGE(FixedAssetsDet."No.",PurchLine."No.");
                                 IF FixedAssetsDet.FIND('-') THEN BEGIN
                                // FixedAssetsDet.CALCFIELDS(FixedAssetsDet."FA Posting Group");
                                     FAPostingGRP.RESET;
                                     FAPostingGRP.SETRANGE(FAPostingGRP.Code,FixedAssetsDet."FA Posting Group");
                                     IF FAPostingGRP.FIND('-') THEN
                                       IF PurchLine."FA Posting Type"=PurchLine."FA Posting Type"::Maintenance THEN
                                        BEGIN
                                           BudgetGL:=FAPostingGRP."Maintenance Expense Account";
                                             IF BudgetGL ='' THEN
                                               ERROR('Ensure Fixed Asset No %1 has the Maintenance G/L Account',PurchLine."No.");
                                       END ELSE BEGIN
                                           BudgetGL:=FAPostingGRP."Acquisition Cost Account";
                                              IF BudgetGL ='' THEN
                                                 ERROR('Ensure Fixed Asset No %1 has the Acquisition G/L Account',PurchLine."No.");
                                        END;
                                 END;
                       END;
        
                       IF PurchLine.Type=PurchLine.Type::"G/L Account" THEN BEGIN
                          BudgetGL:=PurchLine."No.";
                          IF GLAcc.GET(PurchLine."No.") THEN
                             GLAcc.TESTFIELD(GLAcc."Budget Controlled",TRUE);
                       END;
        
                    //End Checking Account in Payment Line
        
                               //check the votebook now
                               FirstDay:=DMY2DATE(1,DATE2DMY(PurchHeader."Document Date",2),DATE2DMY(PurchHeader."Document Date",3));
                               CurrMonth:=DATE2DMY(PurchHeader."Document Date",2);
                               IF CurrMonth=12 THEN
                                BEGIN
                                  LastDay:=DMY2DATE(1,1,DATE2DMY(PurchHeader."Document Date",3) +1);
                                  LastDay:=CALCDATE('-1D',LastDay);
                                END
                               ELSE
                                BEGIN
                                  CurrMonth:=CurrMonth +1;
                                  LastDay:=DMY2DATE(1,CurrMonth,DATE2DMY(PurchHeader."Document Date",3));
                                  LastDay:=CALCDATE('-1D',LastDay);
                                END;
                               //check the summation of the budget in the database
                               BudgetAmount:=0;
                               Budget.RESET;
                               Budget.SETRANGE(Budget."Budget Name",BCSetup."Current Budget Code");
                               Budget.SETFILTER(Budget.Date,'%1..%2',BCSetup."Current Budget Start Date",BCSetup."Current Budget End Date");
                               Budget.SETRANGE(Budget."G/L Account No.",BudgetGL);
                               Budget.SETRANGE(Budget."Global Dimension 1 Code",PurchLine."Shortcut Dimension 1 Code");
                              // IF PurchHeader."Purchase Type"<>PurchHeader."Purchase Type"::"2" THEN
                               Budget.SETRANGE(Budget."Global Dimension 2 Code",PurchLine."Shortcut Dimension 2 Code");
                               Budget.SETRANGE(Budget."Budget Dimension 1 Code",ShortcutDimCode[3]);
                               Budget.SETRANGE(Budget."Budget Dimension 2 Code",ShortcutDimCode[4]);
                                 IF Budget.FIND('-') THEN BEGIN
                                 REPEAT
                                  BudgetAmount:=BudgetAmount+Budget.Amount;
                                 UNTIL Budget.NEXT=0;
                                 END;
        
                                   {
                          //get the summation on the actuals
                            ActualsAmount:=0;
                            "G/L Entry".RESET;
                            "G/L Entry".SETRANGE("G/L Entry"."G/L Account No.",BudgetGL);
                            "G/L Entry".SETRANGE("G/L Entry"."Posting Date",BCSetup."Current Budget Start Date",BCSetup."Current Budget End Date");
                            "G/L Entry".SETRANGE("G/L Entry"."Global Dimension 1 Code",PurchLine."Shortcut Dimension 1 Code");
                            IF PurchHeader."Purchase Type"<>PurchHeader."Purchase Type"::"2" THEN
                            "G/L Entry".SETRANGE("G/L Entry"."Global Dimension 2 Code",PurchLine."Shortcut Dimension 2 Code");
                            IF "G/L Entry".FIND('-') THEN BEGIN
                            REPEAT
                            ActualsAmount:=ActualsAmount+"G/L Entry".Amount;
                            UNTIL "G/L Entry".NEXT=0;
                            END;
                           // error(format(ActualsAmount));
                                  }
        
                          //get the summation on the actuals
                            ActualsAmount:=0;
                            Actuals.RESET;
                            Actuals.SETCURRENTKEY(Actuals."Analysis View Code",Actuals."Dimension 1 Value Code",
                            Actuals."Dimension 2 Value Code",Actuals."Dimension 3 Value Code",Actuals."Dimension 4 Value Code",
                            Actuals."Posting Date",Actuals."Account No.");
                            Actuals.SETRANGE(Actuals."Analysis View Code",BCSetup."Analysis View Code");
                            Actuals.SETRANGE(Actuals."Dimension 1 Value Code",PurchLine."Shortcut Dimension 1 Code");
                           // IF PurchHeader."Purchase Type"<>PurchHeader."Purchase Type"::Global THEN
                            Actuals.SETRANGE(Actuals."Dimension 2 Value Code",PurchLine."Shortcut Dimension 2 Code");
                            Actuals.SETRANGE(Actuals."Dimension 3 Value Code",ShortcutDimCode[3]);
                            Actuals.SETRANGE(Actuals."Dimension 4 Value Code",ShortcutDimCode[4]);
                            Actuals.SETRANGE(Actuals."Posting Date",BCSetup."Current Budget Start Date",LastDay);
                            Actuals.SETRANGE(Actuals."Account No.",BudgetGL);
                               Actuals.CALCSUMS(Actuals.Amount);
                               ActualsAmount:= Actuals.Amount;
        
                          //get the committments
                            CommitmentAmount:=0;
                            Commitments.RESET;
                            Commitments.SETCURRENTKEY(Commitments.Budget,Commitments."G/L Account No.",
                            Commitments."Posting Date",Commitments."Shortcut Dimension 1 Code",Commitments."Shortcut Dimension 2 Code",
                            Commitments."Shortcut Dimension 3 Code",Commitments."Shortcut Dimension 4 Code");
                            Commitments.SETRANGE(Commitments.Budget,BCSetup."Current Budget Code");
                            Commitments.SETRANGE(Commitments."G/L Account No.",BudgetGL);
                            Commitments.SETRANGE(Commitments."Posting Date",BCSetup."Current Budget Start Date",LastDay);
                            Commitments.SETRANGE(Commitments."Shortcut Dimension 1 Code",PurchLine."Shortcut Dimension 1 Code");
        //                    IF PurchHeader."Purchase Type"<>PurchHeader."Purchase Type"::"2" THEN
                            Commitments.SETRANGE(Commitments."Shortcut Dimension 2 Code",PurchLine."Shortcut Dimension 2 Code");
                            Commitments.SETRANGE(Commitments."Shortcut Dimension 3 Code",ShortcutDimCode[3]);
                            Commitments.SETRANGE(Commitments."Shortcut Dimension 4 Code",ShortcutDimCode[4]);
                               Commitments.CALCSUMS(Commitments.Amount);
                               CommitmentAmount:= Commitments.Amount;
                           //check if there is any budget
                           IF (BudgetAmount<=0) THEN
                            BEGIN
                              ERROR('No Budget To Check Against');
                            END;
        
                           //check if the actuals plus the amount is greater then the budget amount
                           IF ((CommitmentAmount + PurchLine."Outstanding Amount (LCY)")>BudgetAmount) AND
                           (BCSetup."Allow OverExpenditure"=FALSE) THEN
                            BEGIN
                              ERROR('The Amount On Order No %1  %2 %3  Exceeds The Budget By %4',
                              PurchLine."Document No.",PurchLine.Type ,PurchLine."No.",
                                FORMAT(ABS(BudgetAmount-(CommitmentAmount + ActualsAmount+PurchLine."Outstanding Amount (LCY)"))));
                            END ELSE BEGIN
                                Commitments.RESET;
                                Commitments.INIT;
                                EntryNo+=1;
                                Commitments."Line No.":=EntryNo;
                                Commitments.Date:=TODAY;
                                Commitments."Posting Date":=PurchHeader."Document Date";
                                IF PurchHeader.DocApprovalType=PurchHeader.DocApprovalType::"0" THEN
                                    Commitments."Document Type":=Commitments."Document Type"::LPO
                                ELSE
                                    Commitments."Document Type":=Commitments."Document Type"::Requisition;
        
                                IF PurchHeader."Document Type"=PurchHeader."Document Type"::Invoice THEN
                                    Commitments."Document Type":=Commitments."Document Type"::PurchInvoice;
        
                                Commitments."Document No.":=PurchHeader."No.";
                                Commitments.Amount:=PurchLine."Outstanding Amount (LCY)";
                                Commitments."Month Budget":=BudgetAmount;
                                Commitments."Month Actual":=ActualsAmount;
                                Commitments.Committed:=TRUE;
                                Commitments."Committed By":=USERID;
                                Commitments."Committed Date":=PurchHeader."Document Date";
                                Commitments."G/L Account No.":=BudgetGL;
                                Commitments."Committed Time":=TIME;
                                //Commitments."Committed Machine":=ENVIRON('COMPUTERNAME');
                                Commitments."Shortcut Dimension 1 Code":=PurchLine."Shortcut Dimension 1 Code";
                                Commitments."Shortcut Dimension 2 Code":=PurchLine."Shortcut Dimension 2 Code";
                                Commitments."Shortcut Dimension 3 Code":=ShortcutDimCode[3];
                                Commitments."Shortcut Dimension 4 Code":=ShortcutDimCode[4];
                                Commitments.Committed:=TRUE;
                                Commitments.Budget:=BCSetup."Current Budget Code";
                                Commitments.Type:=Commitments.Type::Vendor;
                                Commitments."Vendor/Cust No.":=PurchHeader."Buy-from Vendor No.";
                                Commitments.INSERT;
                                //Tag the Purchase Line as Committed
                                  PurchLine.Committed:=TRUE;
                                  PurchLine.MODIFY;
                                //End Tagging PurchLines as Committed
                            END;
        
                  UNTIL PurchLine.NEXT=0;
                END;
          END
        ELSE//budget control not mandatory
          BEGIN
        
          END;
          {****III
        //  error(format(BudgetAmount));
        PurchHeader.RESET;
        PurchHeader.SETRANGE(PurchHeader."No.",PurchLine."Document No.");
        IF PurchHeader.FIND('-') THEN BEGIN
        PurchHeader."Budgeted Amount":=BudgetAmount;
        PurchHeader."Actual Expenditure":=ActualsAmount;
        PurchHeader."Committed Amount":=CommitmentAmount;
        PurchHeader."Budget Balance":=BudgetAmount-(ActualsAmount+CommitmentAmount+PurchHeader."Order Amount");
        PurchHeader.MODIFY;
        END;
                  ********III}
        
        
        {****************************************************************
        //First Update Analysis View
        UpdateAnalysisView();
        
        //get the budget control setup first to determine if it mandatory or not
        BCSetup.RESET;
        BCSetup.GET();
        IF BCSetup.Mandatory THEN//budgetary control is mandatory
          BEGIN
            //check if the dates are within the specified range in relation to the payment header table
            IF (PurchHeader."Document Date"< BCSetup."Current Budget Start Date") THEN
              BEGIN
                ERROR('The Current Date %1 In The Order Does Not Fall Within Budget Dates %2 - %3',PurchHeader."Document Date",
                BCSetup."Current Budget Start Date",BCSetup."Current Budget End Date");
              END
            ELSE IF (PurchHeader."Document Date">BCSetup."Current Budget End Date") THEN
              BEGIN
                ERROR('The Current Date %1 In The Order Does Not Fall Within Budget Dates %2 - %3',PurchHeader."Document Date",
                BCSetup."Current Budget Start Date",BCSetup."Current Budget End Date");
        
              END;
            //Is budget Available
            CheckIfBlocked(BCSetup."Current Budget Code");
            //Get Commitment Lines
                 IF Commitments.FIND('+') THEN
                EntryNo:=Commitments."Line No.";
        
            //get the lines related to the payment header
              PurchLine.RESET;
              PurchLine.SETRANGE(PurchLine."Document Type",PurchHeader."Document Type");
              PurchLine.SETRANGE(PurchLine."Document No.",PurchHeader."No.");
              IF PurchLine.FINDFIRST THEN
                BEGIN
                  REPEAT
        
                 //Get the Dimension Here
                   IF PurchLine."Line No." <> 0 THEN
                       DimMgt.GetShortcutDimensions(PurchLine."Dimension Set ID",ShortcutDimCode);
        
                    //    DimMgt.ShowDocDim(
                     //     DATABASE::"Purchase Line",PurchLine."Document Type",PurchLine."Document No.",
                    //      PurchLine."Line No.",ShortcutDimCode)
                    //  ELSE
                    //    DimMgt.ClearDimSetFilter(ShortcutDimCode);
                 //Had to be put here for the sake of Calculating Individual Line Entries
        
                    //check the type of account in the payments line
                  //Item
                      IF PurchLine.Type=PurchLine.Type::Item THEN BEGIN
                          Item.RESET;
                          IF NOT Item.GET(PurchLine."No.") THEN
                             ERROR('Item Does not Exist');
        
                          Item.TESTFIELD("Item G/L Budget Account");
                          BudgetGL:=Item."Item G/L Budget Account";
                       END;
        
                       IF PurchLine.Type=PurchLine.Type::"Fixed Asset" THEN BEGIN
                               FixedAssetsDet.RESET;
                               FixedAssetsDet.SETRANGE(FixedAssetsDet."No.",PurchLine."No.");
                                 IF FixedAssetsDet.FIND('-') THEN BEGIN
                                     FAPostingGRP.RESET;
                                     FAPostingGRP.SETRANGE(FAPostingGRP.Code,FixedAssetsDet."FA Posting Group");
                                     IF FAPostingGRP.FIND('-') THEN
                                       IF PurchLine."FA Posting Type"=PurchLine."FA Posting Type"::Maintenance THEN
                                        BEGIN
                                           BudgetGL:=FAPostingGRP."Maintenance Expense Account";
                                             IF BudgetGL ='' THEN
                                               ERROR('Ensure Fixed Asset No %1 has the Maintenance G/L Account',PurchLine."No.");
                                       END ELSE BEGIN
                                         IF PurchLine."FA Posting Type"=PurchLine."FA Posting Type"::"Acquisition Cost" THEN BEGIN
                                           BudgetGL:=FAPostingGRP."Acquisition Cost Account";
                                              IF BudgetGL ='' THEN
                                                 ERROR('Ensure Fixed Asset No %1 has the Acquisition G/L Account',PurchLine."No.");
                                         END;
                                         //To Accomodate any Additional Item under Custom 1 and Custom 2
                                         IF PurchLine."FA Posting Type"=PurchLine."FA Posting Type"::"Custom 1" THEN BEGIN
                                           BudgetGL:=FAPostingGRP."Custom 2 Account";
                                              IF BudgetGL ='' THEN
                                                 ERROR('Ensure Fixed Asset No %1 has the %2 G/L Account',PurchLine."No.",
                                                 FAPostingGRP."Custom 1 Account");
                                         END;
        
                                         IF PurchLine."FA Posting Type"=PurchLine."FA Posting Type"::"Custom 2" THEN BEGIN
                                           BudgetGL:=FAPostingGRP."Custom 2 Account";
                                              IF BudgetGL ='' THEN
                                                 ERROR('Ensure Fixed Asset No %1 has the %2 G/L Account',PurchLine."No.",
                                                 FAPostingGRP."Custom 1 Account");
                                         END;
                                         //To Accomodate any Additional Item under Custom 1 and Custom 2
        
                                        END;
                                 END;
                       END;
        
                       IF PurchLine.Type=PurchLine.Type::"G/L Account" THEN BEGIN
                          BudgetGL:=PurchLine."No.";
                          IF GLAcc.GET(PurchLine."No.") THEN
                             GLAcc.TESTFIELD("Budget Controlled",TRUE);
                       END;
        
                    //End Checking Account in Payment Line
        
                               //check the votebook now
                               FirstDay:=DMY2DATE(1,DATE2DMY(PurchHeader."Document Date",2),DATE2DMY(PurchHeader."Document Date",3));
                               CurrMonth:=DATE2DMY(PurchHeader."Document Date",2);
                               IF CurrMonth=12 THEN
                                BEGIN
                                  LastDay:=DMY2DATE(1,1,DATE2DMY(PurchHeader."Document Date",3) +1);
                                  LastDay:=CALCDATE('-1D',LastDay);
                                END
                               ELSE
                                BEGIN
                                  CurrMonth:=CurrMonth +1;
                                  LastDay:=DMY2DATE(1,CurrMonth,DATE2DMY(PurchHeader."Document Date",3));
                                  LastDay:=CALCDATE('-1D',LastDay);
                                END;
        
                              //--ADDED Denno for AMPATH Projects obligated---------------------------------
                              objJobs.RESET;
                              objJobs.SETRANGE(objJobs."No.",PurchHeader."Shortcut Dimension 2 Code");
                              IF objJobs.FIND('-') THEN BEGIN
                               BudgetAmount:=0;
                               IF objJobs."Obligated Amount">0 THEN BudgetAmount:=objJobs."Obligated Amount";
        
                              END ELSE BEGIN
                               //---------------------------------------------------------------------------
        
                               //check the summation of the budget in the database
                               BudgetAmount:=0;
                               Budget.RESET;
                               Budget.SETCURRENTKEY(Budget."Budget Name",Budget."Posting Date",Budget."G/L Account No.",
                               Budget."Dimension 1 Value Code",Budget."Dimension 2 Value Code",Budget."Dimension 3 Value Code",
                               Budget."Dimension 4 Value Code");
                               Budget.SETRANGE(Budget."Budget Name",BCSetup."Current Budget Code");
                               Budget.SETRANGE(Budget."Posting Date",BCSetup."Current Budget Start Date",LastDay);
                               Budget.SETRANGE(Budget."G/L Account No.",BudgetGL);
                               Budget.SETRANGE(Budget."Dimension 1 Value Code",PurchLine."Shortcut Dimension 1 Code");
                               Budget.SETRANGE(Budget."Dimension 2 Value Code",PurchLine."Shortcut Dimension 2 Code");
                               Budget.SETRANGE(Budget."Dimension 3 Value Code",ShortcutDimCode[3]);
                               Budget.SETRANGE(Budget."Dimension 4 Value Code",ShortcutDimCode[4]);
                                   Budget.CALCSUMS(Budget.Amount);
                                   BudgetAmount:= Budget.Amount;
        
                            END; // Denno  Added--------------------------------
        
                          //get the summation on the actuals
                            ActualsAmount:=0;
                            Actuals.RESET;
                            Actuals.SETCURRENTKEY(Actuals."Analysis View Code",Actuals."Dimension 1 Value Code",
                            Actuals."Dimension 2 Value Code",Actuals."Dimension 3 Value Code",Actuals."Dimension 4 Value Code",
                            Actuals."Posting Date",Actuals."G/L Account No.");
                            Actuals.SETRANGE(Actuals."Analysis View Code",BCSetup."Analysis View Code");
                            Actuals.SETRANGE(Actuals."Dimension 1 Value Code",PurchLine."Shortcut Dimension 1 Code");
                            Actuals.SETRANGE(Actuals."Dimension 2 Value Code",PurchLine."Shortcut Dimension 2 Code");
                            Actuals.SETRANGE(Actuals."Dimension 3 Value Code",ShortcutDimCode[3]);
                            Actuals.SETRANGE(Actuals."Dimension 4 Value Code",ShortcutDimCode[4]);
                            Actuals.SETRANGE(Actuals."Posting Date",BCSetup."Current Budget Start Date",LastDay);
                            Actuals.SETRANGE(Actuals."G/L Account No.",BudgetGL);
                               Actuals.CALCSUMS(Actuals.Amount);
                               ActualsAmount:= Actuals.Amount;
        
                          //get the committments
                            CommitmentAmount:=0;
                            Commitments.RESET;
                            Commitments.SETCURRENTKEY(Commitments.Budget,Commitments."G/L Account No.",
                            Commitments."Posting Date",Commitments."Shortcut Dimension 1 Code",Commitments."Shortcut Dimension 2 Code",
                            Commitments."Shortcut Dimension 3 Code",Commitments."Shortcut Dimension 4 Code");
                            Commitments.SETRANGE(Commitments.Budget,BCSetup."Current Budget Code");
                            Commitments.SETRANGE(Commitments."G/L Account No.",BudgetGL);
                            Commitments.SETRANGE(Commitments."Posting Date",BCSetup."Current Budget Start Date",LastDay);
                            Commitments.SETRANGE(Commitments."Shortcut Dimension 1 Code",PurchLine."Shortcut Dimension 1 Code");
                            Commitments.SETRANGE(Commitments."Shortcut Dimension 2 Code",PurchLine."Shortcut Dimension 2 Code");
                            Commitments.SETRANGE(Commitments."Shortcut Dimension 3 Code",ShortcutDimCode[3]);
                            Commitments.SETRANGE(Commitments."Shortcut Dimension 4 Code",ShortcutDimCode[4]);
                               Commitments.CALCSUMS(Commitments.Amount);
                               CommitmentAmount:= Commitments.Amount;
        
                           //check if there is any budget
                           IF (BudgetAmount<=0) AND NOT (BCSetup."Allow OverExpenditure") THEN  BEGIN
                              ERROR('No Budget To Check Against');
                           END ELSE BEGIN
                            IF (BudgetAmount<=0) THEN BEGIN
                             IF NOT CONFIRM(Text0003,TRUE) THEN BEGIN
                                ERROR('Budgetary Checking Process Aborted');
                             END;
                            END;
                           END;
        
                           //check if the actuals plus the amount is greater then the budget amount
                           IF ((CommitmentAmount + PurchLine."Outstanding Amount (LCY)")+ ActualsAmount>BudgetAmount)
                           AND NOT (BCSetup."Allow OverExpenditure") THEN
                            BEGIN
                              ERROR('The Amount On Order No %1  %2 %3  Exceeds The Budget By %4',
                              PurchLine."Document No.",PurchLine.Type ,PurchLine."No.",
                                FORMAT(ABS(BudgetAmount-(CommitmentAmount + ActualsAmount+PurchLine."Outstanding Amount (LCY)"))));
                            END ELSE BEGIN
                                //ADD A CONFIRMATION TO ALLOW USER TO DECIDE WHETHER TO CONTINUE
                                IF ((CommitmentAmount + PurchLine."Outstanding Amount (LCY)")+ ActualsAmount>BudgetAmount) THEN BEGIN
                                    IF NOT CONFIRM(Text0001+
                                    FORMAT(ABS(BudgetAmount-(CommitmentAmount + ActualsAmount+PurchLine."Outstanding Amount (LCY)")))
                                    +Text0002,TRUE) THEN BEGIN
                                       ERROR('Budgetary Checking Process Aborted');
                                    END;
                                END;
                                //END ADDING CONFIRMATION
                                Commitments.RESET;
                                Commitments.INIT;
                                EntryNo+=1;
                                Commitments."Line No.":=EntryNo;
                                Commitments.Date:=TODAY;
                                Commitments."Posting Date":=PurchHeader."Document Date";
                                IF PurchHeader.DocApprovalType=PurchHeader.DocApprovalType::Purchase THEN
                                    Commitments."Document Type":=Commitments."Document Type"::LPO
                                ELSE
                                    Commitments."Document Type":=Commitments."Document Type"::Requisition;
        
                                IF PurchHeader."Document Type"=PurchHeader."Document Type"::Invoice THEN
                                    Commitments."Document Type":=Commitments."Document Type"::PurchInvoice;
        
                                Commitments."Document No.":=PurchHeader."No.";
                                Commitments.Amount:=PurchLine."Outstanding Amount (LCY)";
                                Commitments."Month Budget":=BudgetAmount;
                                Commitments."Month Actual":=ActualsAmount;
                                Commitments.Committed:=TRUE;
                                Commitments."Committed By":=USERID;
                                Commitments."Committed Date":=PurchHeader."Document Date";
                                Commitments."G/L Account No.":=BudgetGL;
                                Commitments."Committed Time":=TIME;
        //                        Commitments."Committed Machine":=ENVIRON('COMPUTERNAME');
                                Commitments."Shortcut Dimension 1 Code":=PurchLine."Shortcut Dimension 1 Code";
                                Commitments."Shortcut Dimension 2 Code":=PurchLine."Shortcut Dimension 2 Code";
                                Commitments."Shortcut Dimension 3 Code":=ShortcutDimCode[3];
                                Commitments."Shortcut Dimension 4 Code":=ShortcutDimCode[4];
                                Commitments.Budget:=BCSetup."Current Budget Code";
                                Commitments.Type:=Commitments.Type::Vendor;
                                Commitments."Vendor/Cust No.":=PurchHeader."Buy-from Vendor No.";
                                Commitments.INSERT;
                                //Tag the Purchase Line as Committed
                                  PurchLine.Committed:=TRUE;
                                  PurchLine.MODIFY;
                                //End Tagging PurchLines as Committed
                            END;
                  UNTIL PurchLine.NEXT=0;
                END;
          END
        ELSE//budget control not mandatory
          BEGIN
        
          END;
        *******************************************************************}
        */

    end;


    procedure CheckPayments(var PaymentHeader: Record "Payment Header.")
    var
        PayLine: Record "Supervisors Approval Levels";
        Commitments: Record "Transaction Types";
        Amount: Decimal;
        GLAcc: Record "G/L Account";
        Item: Record Item;
        FirstDay: Date;
        LastDay: Date;
        CurrMonth: Integer;
        Budget: Record "Analysis View Budget Entry";
        BudgetAmount: Decimal;
        Actuals: Record "Analysis View Entry";
        ActualsAmount: Decimal;
        CommitmentAmount: Decimal;
        FixedAssetsDet: Record "Fixed Asset";
        FAPostingGRP: Record "FA Posting Group";
        EntryNo: Integer;
    begin
        /*
        //First Update Analysis View
        UpdateAnalysisView();
        
        //get the budget control setup first to determine if it mandatory or not
        BCSetup.RESET;
        BCSetup.GET();
        IF BCSetup.Mandatory THEN//budgetary control is mandatory
          BEGIN
            //check if the dates are within the specified range in relation to the payment header table
            IF (PaymentHeader.Date< BCSetup."Current Budget Start Date") THEN
              BEGIN
                ERROR('The Current Date %1 In The Payment Voucher Does Not Fall Within Budget Dates %2 - %3',PaymentHeader.Date,
                BCSetup."Current Budget Start Date",BCSetup."Current Budget End Date");
              END
            ELSE IF (PaymentHeader.Date>BCSetup."Current Budget End Date") THEN
              BEGIN
                ERROR('The Current Date %1 In The Payment Voucher Does Not Fall Within Budget Dates %2 - %3',PaymentHeader.Date,
                BCSetup."Current Budget Start Date",BCSetup."Current Budget End Date");
              END;
            //Is budget Available
            CheckIfBlocked(BCSetup."Current Budget Code");
        
        
            //Get Commitment Lines
             IF Commitments.FIND('+') THEN
                EntryNo:=Commitments."Line No.";
        
            //get the lines related to the payment header
              PayLine.RESET;
              PayLine.SETRANGE(PayLine.No,PaymentHeader."No.");
              PayLine.SETRANGE(PayLine."Account Type",PayLine."Account Type"::"G/L Account");
              //PayLine.SETRANGE(PayLine."Budgetary Control A/C",TRUE);
              IF PayLine.FINDFIRST THEN
                BEGIN
                  REPEAT
                               //check the votebook now
                               FirstDay:=DMY2DATE(1,DATE2DMY(PaymentHeader.Date,2),DATE2DMY(PaymentHeader.Date,3));
                               CurrMonth:=DATE2DMY(PaymentHeader.Date,2);
                               IF CurrMonth=12 THEN
                                BEGIN
                                  LastDay:=DMY2DATE(1,1,DATE2DMY(PaymentHeader.Date,3) +1);
                                  LastDay:=CALCDATE('-1D',LastDay);
                                END
                               ELSE
                                BEGIN
                                  CurrMonth:=CurrMonth +1;
                                  LastDay:=DMY2DATE(1,CurrMonth,DATE2DMY(PaymentHeader.Date,3));
                                  LastDay:=CALCDATE('-1D',LastDay);
                                END;
        
                               BudgetGL:=PayLine."Account No.";
                               //check the summation of the budget in the database
                               BudgetAmount:=0;
                               Budget.RESET;
                               Budget.SETCURRENTKEY(Budget."Budget Name",Budget."Posting Date",Budget."G/L Account No.",
                               Budget."Dimension 1 Value Code",Budget."Dimension 2 Value Code",Budget."Dimension 3 Value Code",
                               Budget."Dimension 4 Value Code");
                               Budget.SETRANGE(Budget."Budget Name",BCSetup."Current Budget Code");
                               Budget.SETRANGE(Budget."Posting Date",BCSetup."Current Budget Start Date",BCSetup."Current Budget End Date");
                               Budget.SETRANGE(Budget."G/L Account No.",BudgetGL);
                              { Budget.SETRANGE(Budget."Dimension 1 Value Code",PayLine."Global Dimension 1 Code");
                               Budget.SETRANGE(Budget."Dimension 2 Value Code",PayLine."Shortcut Dimension 2 Code");
                               Budget.SETRANGE(Budget."Dimension 3 Value Code",PayLine."Shortcut Dimension 3 Code");
                               Budget.SETRANGE(Budget."Dimension 4 Value Code",PayLine."Shortcut Dimension 4 Code"); }
                                   Budget.CALCSUMS(Budget.Amount);
                                   BudgetAmount:= Budget.Amount;
                               MESSAGE(FORMAT(BudgetAmount));
                          //get the summation on the actuals
                            ActualsAmount:=0;
                            Actuals.RESET;
                            Actuals.SETCURRENTKEY(Actuals."Analysis View Code",Actuals."Dimension 1 Value Code",
                            Actuals."Dimension 2 Value Code",Actuals."Dimension 3 Value Code",Actuals."Dimension 4 Value Code",
                            Actuals."Posting Date",Actuals."Account No.");
                            Actuals.SETRANGE(Actuals."Analysis View Code",BCSetup."Analysis View Code");
                            Actuals.SETRANGE(Actuals."Dimension 1 Value Code",PayLine."Global Dimension 1 Code");
                            Actuals.SETRANGE(Actuals."Dimension 2 Value Code",PayLine."Shortcut Dimension 2 Code");
                            //Actuals.SETRANGE(Actuals."Dimension 3 Value Code",PayLine."Shortcut Dimension 3 Code");
                            //Actuals.SETRANGE(Actuals."Dimension 4 Value Code",PayLine."Shortcut Dimension 4 Code");
                            Actuals.SETRANGE(Actuals."Posting Date",BCSetup."Current Budget Start Date",LastDay);
                            Actuals.SETRANGE(Actuals."Account No.",BudgetGL);
                               Actuals.CALCSUMS(Actuals.Amount);
                               ActualsAmount:= Actuals.Amount;
        
                          //get the committments
                            CommitmentAmount:=0;
                            Commitments.RESET;
                            Commitments.SETCURRENTKEY(Commitments.Budget,Commitments."G/L Account No.",
                            Commitments."Posting Date",Commitments."Shortcut Dimension 1 Code",Commitments."Shortcut Dimension 2 Code",
                            Commitments."Shortcut Dimension 3 Code",Commitments."Shortcut Dimension 4 Code");
                            Commitments.SETRANGE(Commitments.Budget,BCSetup."Current Budget Code");
                            Commitments.SETRANGE(Commitments."G/L Account No.",BudgetGL);
                            Commitments.SETRANGE(Commitments."Posting Date",BCSetup."Current Budget Start Date",LastDay);
                            Commitments.SETRANGE(Commitments."Shortcut Dimension 1 Code",PayLine."Global Dimension 1 Code");
                            Commitments.SETRANGE(Commitments."Shortcut Dimension 2 Code",PayLine."Shortcut Dimension 2 Code");
                            Commitments.SETRANGE(Commitments."Shortcut Dimension 3 Code",PayLine."Shortcut Dimension 3 Code");
                            Commitments.SETRANGE(Commitments."Shortcut Dimension 4 Code",PayLine."Shortcut Dimension 4 Code");
                               Commitments.CALCSUMS(Commitments.Amount);
                               CommitmentAmount:= Commitments.Amount;
        
                           //check if there is any budget
                           IF (BudgetAmount<=0) AND NOT (BCSetup."Allow OverExpenditure") THEN  BEGIN
                              ERROR('No Budget To Check Against');
                           END ELSE BEGIN
                            IF (BudgetAmount<=0) THEN BEGIN
                             IF NOT CONFIRM(Text0003,TRUE) THEN BEGIN
                                ERROR('Budgetary Checking Process Aborted');
                             END;
                            END;
                           END;
        
                           //check if the actuals plus the amount is greater then the budget amount
                           IF ((CommitmentAmount + PayLine."NetAmount LCY"+ActualsAmount)>BudgetAmount )
                           AND NOT ( BCSetup."Allow OverExpenditure") THEN  BEGIN
                              ERROR('The Amount Voucher No %1  %2 %3  Exceeds The Budget By %4',
                              PayLine.No,PayLine.Type ,PayLine.No,
                                FORMAT(ABS(BudgetAmount-(CommitmentAmount + ActualsAmount+PayLine."NetAmount LCY"))));
                            END ELSE BEGIN
                            //ADD A CONFIRMATION TO ALLOW USER TO DECIDE WHETHER TO CONTINUE
                                IF ((CommitmentAmount + PayLine."NetAmount LCY"+ ActualsAmount)>BudgetAmount) THEN BEGIN
                                    IF NOT CONFIRM(Text0001+
                                    FORMAT(ABS(BudgetAmount-(CommitmentAmount + ActualsAmount+PayLine."NetAmount LCY")))
                                    +Text0002,TRUE) THEN BEGIN
                                       ERROR('Budgetary Checking Process Aborted');
                                    END;
                                END;
        
                                Commitments.RESET;
                                Commitments.INIT;
                                EntryNo+=1;
                                Commitments."Line No.":=EntryNo;
                                Commitments.Date:=TODAY;
                                Commitments."Posting Date":=PaymentHeader.Date;
                                IF PaymentHeader."Payment Type"=PaymentHeader."Payment Type"::Normal THEN
                                 Commitments."Document Type":=Commitments."Document Type"::"Payment Voucher"
                                ELSE
                                  Commitments."Document Type":=Commitments."Document Type"::PettyCash;
                                Commitments."Document No.":=PaymentHeader."No.";
                                Commitments.Amount:=PayLine."NetAmount LCY";
                                Commitments."Month Budget":=BudgetAmount;
                                Commitments."Month Actual":=ActualsAmount;
                                Commitments.Committed:=TRUE;
                                Commitments."Committed By":=USERID;
                                Commitments."Committed Date":=PaymentHeader.Date;
                                Commitments."G/L Account No.":=BudgetGL;
                                Commitments."Committed Time":=TIME;
        //                        Commitments."Committed Machine":=ENVIRON('COMPUTERNAME');
                                Commitments."Shortcut Dimension 1 Code":=PayLine."Global Dimension 1 Code";
                                Commitments."Shortcut Dimension 2 Code":=PayLine."Shortcut Dimension 2 Code";
                                Commitments."Shortcut Dimension 3 Code":=PayLine."Shortcut Dimension 3 Code";
                                Commitments."Shortcut Dimension 4 Code":=PayLine."Shortcut Dimension 4 Code";
                                Commitments.Budget:=BCSetup."Current Budget Code";
                                Commitments.INSERT;
                               // MESSAGE('Done');
                                //Tag the Payment Line as Committed
                                  PayLine.Committed:=TRUE;
                                  PayLine.MODIFY;
                                //End Tagging Payment Lines as Committed
                            END;
        
                  UNTIL PayLine.NEXT=0;
                END;
          END
        ELSE//budget control not mandatory
          BEGIN
        
          END;
        MESSAGE('Budgetary Checking Completed Successfully');
        */

    end;


    procedure CheckImprest(var ImprestHeader: Record "Suspense Vendor")
    var
        PayLine: Record "Bulk SMS Header";
        Commitments: Record "Transaction Types";
        Amount: Decimal;
        GLAcc: Record "G/L Account";
        Item: Record Item;
        FirstDay: Date;
        LastDay: Date;
        CurrMonth: Integer;
        Budget: Record "Analysis View Budget Entry";
        BudgetAmount: Decimal;
        Actuals: Record "Analysis View Entry";
        ActualsAmount: Decimal;
        CommitmentAmount: Decimal;
        FixedAssetsDet: Record "Fixed Asset";
        FAPostingGRP: Record "FA Posting Group";
        EntryNo: Integer;
    begin
        /*//First Update Analysis View
        UpdateAnalysisView();
        
        //get the budget control setup first to determine if it mandatory or not
        BCSetup.RESET;
        BCSetup.GET();
        IF BCSetup.Mandatory THEN//budgetary control is mandatory
          BEGIN
            //check if the dates are within the specified range in relation to the payment header table
            IF (ImprestHeader.Date< BCSetup."Current Budget Start Date") THEN
              BEGIN
                ERROR('The Current Date %1 for the Imprest Does Not Fall Within Budget Dates %2 - %3',ImprestHeader.Date,
                BCSetup."Current Budget Start Date",BCSetup."Current Budget End Date");
              END
            ELSE IF (ImprestHeader.Date>BCSetup."Current Budget End Date") THEN
              BEGIN
                ERROR('The Current Date %1 for the Imprest Does Not Fall Within Budget Dates %2 - %3',ImprestHeader.Date,
                BCSetup."Current Budget Start Date",BCSetup."Current Budget End Date");
        
              END;
            //Is budget Available
            CheckIfBlocked(BCSetup."Current Budget Code");
        
            //Get Commitment Lines
             IF Commitments.FIND('+') THEN
                EntryNo:=Commitments."Line No.";
        
            //get the lines related to the payment header
              PayLine.RESET;
              PayLine.SETRANGE(PayLine.No,ImprestHeader."No.");
              PayLine.SETRANGE(PayLine."Budgetary Control A/C",TRUE);
              IF PayLine.FINDFIRST THEN
                BEGIN
                  REPEAT
                               //check the votebook now
                               FirstDay:=DMY2DATE(1,DATE2DMY(ImprestHeader.Date,2),DATE2DMY(ImprestHeader.Date,3));
                               CurrMonth:=DATE2DMY(ImprestHeader.Date,2);
                               IF CurrMonth=12 THEN
                                BEGIN
                                  LastDay:=DMY2DATE(1,1,DATE2DMY(ImprestHeader.Date,3) +1);
                                  LastDay:=CALCDATE('-1D',LastDay);
                                END
                               ELSE
                                BEGIN
                                  CurrMonth:=CurrMonth +1;
                                  LastDay:=DMY2DATE(1,CurrMonth,DATE2DMY(ImprestHeader.Date,3));
                                  LastDay:=CALCDATE('-1D',LastDay);
                                END;
        
                               //The GL Account
                                BudgetGL:=PayLine."Account No:";
        
                               //check the summation of the budget in the database
                               BudgetAmount:=0;
                               Budget.RESET;
                               Budget.SETCURRENTKEY(Budget."Budget Name",Budget."Posting Date",Budget."G/L Account No.",
                               Budget."Dimension 1 Value Code",Budget."Dimension 2 Value Code",Budget."Dimension 3 Value Code",
                               Budget."Dimension 4 Value Code");
                               Budget.SETRANGE(Budget."Budget Name",BCSetup."Current Budget Code");
                               Budget.SETRANGE(Budget."Posting Date",BCSetup."Current Budget Start Date",LastDay);
                               Budget.SETRANGE(Budget."G/L Account No.",BudgetGL);
                               Budget.SETRANGE(Budget."Dimension 1 Value Code",PayLine."Global Dimension 1 Code");
                               Budget.SETRANGE(Budget."Dimension 2 Value Code",PayLine."Shortcut Dimension 2 Code");
                               Budget.SETRANGE(Budget."Dimension 3 Value Code",PayLine."Shortcut Dimension 3 Code");
                               Budget.SETRANGE(Budget."Dimension 4 Value Code",PayLine."Shortcut Dimension 4 Code");
                               IF Budget.FIND('-') THEN BEGIN
                                   Budget.CALCSUMS(Budget.Amount);
                                   BudgetAmount:= Budget.Amount;
                               END;
        
                          //get the summation on the actuals
                            ActualsAmount:=0;
                            Actuals.RESET;
                            Actuals.SETCURRENTKEY(Actuals."Analysis View Code",Actuals."Dimension 1 Value Code",
                            Actuals."Dimension 2 Value Code",Actuals."Dimension 3 Value Code",Actuals."Dimension 4 Value Code",
                            Actuals."Posting Date",Actuals."Account No.");
                            Actuals.SETRANGE(Actuals."Analysis View Code",BCSetup."Analysis View Code");
                            Actuals.SETRANGE(Actuals."Dimension 1 Value Code",PayLine."Global Dimension 1 Code");
                            Actuals.SETRANGE(Actuals."Dimension 2 Value Code",PayLine."Shortcut Dimension 2 Code");
                            Actuals.SETRANGE(Actuals."Dimension 3 Value Code",PayLine."Shortcut Dimension 3 Code");
                            Actuals.SETRANGE(Actuals."Dimension 4 Value Code",PayLine."Shortcut Dimension 4 Code");
                            Actuals.SETRANGE(Actuals."Posting Date",BCSetup."Current Budget Start Date",LastDay);
                            Actuals.SETRANGE(Actuals."Account No.",BudgetGL);
                               Actuals.CALCSUMS(Actuals.Amount);
                               ActualsAmount:= Actuals.Amount;
        
                          //get the committments
                            CommitmentAmount:=0;
                            Commitments.RESET;
                            Commitments.SETCURRENTKEY(Commitments.Budget,Commitments."G/L Account No.",
                            Commitments."Posting Date",Commitments."Shortcut Dimension 1 Code",Commitments."Shortcut Dimension 2 Code",
                            Commitments."Shortcut Dimension 3 Code",Commitments."Shortcut Dimension 4 Code");
                            Commitments.SETRANGE(Commitments.Budget,BCSetup."Current Budget Code");
                            Commitments.SETRANGE(Commitments."G/L Account No.",BudgetGL);
                            Commitments.SETRANGE(Commitments."Posting Date",BCSetup."Current Budget Start Date",LastDay);
                            Commitments.SETRANGE(Commitments."Shortcut Dimension 1 Code",PayLine."Global Dimension 1 Code");
                            Commitments.SETRANGE(Commitments."Shortcut Dimension 2 Code",PayLine."Shortcut Dimension 2 Code");
                            Commitments.SETRANGE(Commitments."Shortcut Dimension 3 Code",PayLine."Shortcut Dimension 3 Code");
                            Commitments.SETRANGE(Commitments."Shortcut Dimension 4 Code",PayLine."Shortcut Dimension 4 Code");
                               Commitments.CALCSUMS(Commitments.Amount);
                               CommitmentAmount:= Commitments.Amount;
        
                           //check if there is any budget
                           IF (BudgetAmount<=0) AND NOT (BCSetup."Allow OverExpenditure") THEN  BEGIN
                              ERROR('No Budget To Check Against');
                           END ELSE BEGIN
                            IF (BudgetAmount<=0) THEN BEGIN
                             IF NOT CONFIRM(Text0003,TRUE) THEN BEGIN
                                ERROR('Budgetary Checking Process Aborted');
                             END;
                            END;
                           END;
        
                           //check if the actuals plus the amount is greater then the budget amount
                           IF ((CommitmentAmount + PayLine."Amount LCY"+ActualsAmount)>BudgetAmount )
                           AND NOT ( BCSetup."Allow OverExpenditure") THEN  BEGIN
                              ERROR('The Amount Voucher No %1  %2 %3  Exceeds The Budget By %4',
                              PayLine.No,'Staff Imprest' ,PayLine.No,
                                FORMAT(ABS(BudgetAmount-(CommitmentAmount + PayLine."Amount LCY"))));
                            END ELSE BEGIN
                            //ADD A CONFIRMATION TO ALLOW USER TO DECIDE WHETHER TO CONTINUE
                                IF ((CommitmentAmount + PayLine."Amount LCY"+ ActualsAmount)>BudgetAmount) THEN BEGIN
                                    IF NOT CONFIRM(Text0001+
                                    FORMAT(ABS(BudgetAmount-(CommitmentAmount + ActualsAmount+PayLine."Amount LCY")))
                                    +Text0002,TRUE) THEN BEGIN
                                       ERROR('Budgetary Checking Process Aborted');
                                    END;
                                END;
        
                                Commitments.RESET;
                                Commitments.INIT;
                                EntryNo+=1;
                                Commitments."Line No.":=EntryNo;
                                Commitments.Date:=TODAY;
                                Commitments."Posting Date":=ImprestHeader.Date;
                                Commitments."Document Type":=Commitments."Document Type"::Imprest;
                                Commitments."Document No.":=ImprestHeader."No.";
                                Commitments.Amount:=PayLine."Amount LCY";
                                Commitments."Month Budget":=BudgetAmount;
                                Commitments."Month Actual":=ActualsAmount;
                                Commitments.Committed:=TRUE;
                                Commitments."Committed By":=USERID;
                                Commitments."Committed Date":=ImprestHeader.Date;
                                Commitments."G/L Account No.":=BudgetGL;
                                Commitments."Committed Time":=TIME;
        //                        Commitments."Committed Machine":=ENVIRON('COMPUTERNAME');
                                Commitments."Shortcut Dimension 1 Code":=PayLine."Global Dimension 1 Code";
                                Commitments."Shortcut Dimension 2 Code":=PayLine."Shortcut Dimension 2 Code";
                                Commitments."Shortcut Dimension 3 Code":=PayLine."Shortcut Dimension 3 Code";
                                Commitments."Shortcut Dimension 4 Code":=PayLine."Shortcut Dimension 4 Code";
                                Commitments.Budget:=BCSetup."Current Budget Code";
                                Commitments.Type:=ImprestHeader."Account Type";
                                Commitments."Vendor/Cust No.":=ImprestHeader."Account No.";
                                Commitments.INSERT;
                                //Tag the Imprest Line as Committed
                                  PayLine.Committed:=TRUE;
                                  PayLine.MODIFY;
                                //End Tagging Imprest Lines as Committed
                            END;
        
                  UNTIL PayLine.NEXT=0;
                END;
          END
        ELSE//budget control not mandatory
          BEGIN
        
          END;
        MESSAGE('Budgetary Checking Completed Successfully');
        */

    end;


    procedure ReverseEntries(DocumentType: Option LPO,Requisition,Imprest,"Payment Voucher",PettyCash,PurchInvoice,StaffClaim,StaffAdvance;DocNo: Code[20])
    var
        Commitments: Record "Transaction Types";
        EntryNo: Integer;
        CommittedLines: Record "Transaction Types";
    begin
        /*//Get Commitment Lines
        Commitments.RESET;
         IF Commitments.FIND('+') THEN
            EntryNo:=Commitments."Line No.";
        
        CommittedLines.RESET;
        CommittedLines.SETRANGE(CommittedLines."Document Type",DocumentType);
        CommittedLines.SETRANGE(CommittedLines."Document No.",DocNo);
        CommittedLines.SETRANGE(CommittedLines.Committed,TRUE);
        IF CommittedLines.FIND('-') THEN BEGIN
           REPEAT
             Commitments.RESET;
             Commitments.INIT;
             EntryNo+=1;
             Commitments."Line No.":=EntryNo;
             Commitments.Date:=TODAY;
             Commitments."Posting Date":=CommittedLines."Posting Date";
             Commitments."Document Type":=CommittedLines."Document Type";
             Commitments."Document No.":=CommittedLines."Document No.";
             Commitments.Amount:=-CommittedLines.Amount;
             Commitments."Month Budget":=CommittedLines."Month Budget";
             Commitments."Month Actual":=CommittedLines."Month Actual";
             Commitments.Committed:=FALSE;
             Commitments."Committed By":=USERID;
             Commitments."Committed Date":=CommittedLines."Committed Date";
             Commitments."G/L Account No.":=CommittedLines."G/L Account No.";
             Commitments."Committed Time":=TIME;
        //     Commitments."Committed Machine":=ENVIRON('COMPUTERNAME');
             Commitments."Shortcut Dimension 1 Code":= CommittedLines."Shortcut Dimension 1 Code";
             Commitments."Shortcut Dimension 2 Code":=CommittedLines."Shortcut Dimension 2 Code";
             Commitments."Shortcut Dimension 3 Code":=CommittedLines."Shortcut Dimension 3 Code";
             Commitments."Shortcut Dimension 4 Code":=CommittedLines."Shortcut Dimension 4 Code";
             Commitments.Budget:=CommittedLines.Budget;
             Commitments.INSERT;
        
           UNTIL CommittedLines.NEXT=0;
        END;
        */

    end;


    procedure CheckFundsAvailability(Payments: Record "Payment Header.")
    var
        BankAcc: Record "Bank Account";
        "Current Source A/C Bal.": Decimal;
    begin
        /*//get the source account balance from the database table
        BankAcc.RESET;
        BankAcc.SETRANGE(BankAcc."No.",Payments."Paying Bank Account");
        BankAcc.SETRANGE(BankAcc."Bank Type",BankAcc."Bank Type"::"1");
        IF BankAcc.FINDFIRST THEN
          BEGIN
            BankAcc.CALCFIELDS(BankAcc.Balance);
            "Current Source A/C Bal.":=BankAcc.Balance;
            IF ("Current Source A/C Bal."-Payments."Total Net Amount")<0 THEN
              BEGIN
                ERROR('The transaction will result in a negative balance in the BANK ACCOUNT. %1:%2',BankAcc."No.",
                BankAcc.Name);
              END;
          END;
          */

    end;


    procedure UpdateAnalysisView()
    var
        UpdateAnalysisView: Codeunit "Update Analysis View";
        BudgetaryControl: Record "Budgetary Control Setup";
        AnalysisView: Record "Analysis View";
    begin
        /*//Update Budget Lines
        IF BudgetaryControl.GET THEN BEGIN
          IF BudgetaryControl."Analysis View Code"<>'' THEN BEGIN
           AnalysisView.RESET;
           AnalysisView.SETRANGE(AnalysisView.Code,BudgetaryControl."Analysis View Code");
           IF AnalysisView.FIND('-') THEN
             UpdateAnalysisView.UpdateAnalysisView_Budget(AnalysisView);
          END;
        END;  */
        
        /*//Update Budget Lines
        IF BudgetaryControl.GET THEN BEGIN
          IF BudgetaryControl."Actual Source"=BudgetaryControl."Actual Source"::"Analysis View Entry" THEN BEGIN
             IF BudgetaryControl."Analysis View Code"='' THEN
                ERROR('The Analysis view code can not be blank in the budgetary control setup');
          END;
          IF BudgetaryControl."Analysis View Code"<>''  THEN BEGIN
           AnalysisView.RESET;
           AnalysisView.SETRANGE(AnalysisView.Code,BudgetaryControl."Analysis View Code");
           IF AnalysisView.FIND('-') THEN
             UpdateAnalysisView.UpdateAnalysisView_Budget(AnalysisView);
          END;
        END;
        */

    end;


    procedure UpdateDim(DimCode: Code[20];DimValueCode: Code[20])
    var
        GLBudgetDim: Integer;
    begin
        //In 2013 this is not applicable table 361 not supported
        /*IF DimCode = '' THEN
          EXIT;
        WITH GLBudgetDim DO BEGIN
          IF GET(Rec."Entry No.",DimCode) THEN
            DELETE;
          IF DimValueCode <> '' THEN BEGIN
            INIT;
            "Entry No." := Rec."Entry No.";
            "Dimension Code" := DimCode;
            "Dimension Value Code" := DimValueCode;
            INSERT;
          END;
        END; */

    end;


    procedure CheckIfBlocked(BudgetName: Code[20])
    var
        GLBudgetName: Record "G/L Budget Name";
    begin
        GLBudgetName.Get(BudgetName);
        GLBudgetName.TestField(Blocked,false);
    end;


    procedure CheckStaffClaim(var ImprestHeader: Record "Imprest Header")
    var
        PayLine: Record "Staff Claim Lines";
        Commitments: Record Committment;
        Amount: Decimal;
        GLAcc: Record "G/L Account";
        Item: Record Item;
        FirstDay: Date;
        LastDay: Date;
        CurrMonth: Integer;
        Budget: Record "Analysis View Budget Entry";
        BudgetAmount: Decimal;
        Actuals: Record "Analysis View Entry";
        ActualsAmount: Decimal;
        CommitmentAmount: Decimal;
        FixedAssetsDet: Record "Fixed Asset";
        FAPostingGRP: Record "FA Posting Group";
        EntryNo: Integer;
        GLAccount: Record "G/L Account";
    begin
        
        UpdateAnalysisView();
        
        //get the budget control setup first to determine if it mandatory or not
        BCSetup.Reset;
        BCSetup.Get();
        if BCSetup.Mandatory then//budgetary control is mandatory
          begin
            //check if the dates are within the specified range in relation to the payment header table
            if (ImprestHeader.Date< BCSetup."Current Budget Start Date") then
              begin
                Error('The Current Date %1 for the Imprest Does Not Fall Within Budget Dates %2 - %3',ImprestHeader.Date,
                BCSetup."Current Budget Start Date",BCSetup."Current Budget End Date");
              end
            else if (ImprestHeader.Date>BCSetup."Current Budget End Date") then
              begin
                Error('The Current Date %1 for the Imprest Does Not Fall Within Budget Dates %2 - %3',ImprestHeader.Date,
                BCSetup."Current Budget Start Date",BCSetup."Current Budget End Date");
        
              end;
            //Is budget Available
            CheckIfBlocked(BCSetup."Current Budget Code");
        
            //Get Commitment Lines
             if Commitments.Find('+') then
                EntryNo:=Commitments."Line No.";
        
            //get the lines related to the payment header
              PayLine.Reset;
              PayLine.SetRange(PayLine.No,ImprestHeader."No.");
              PayLine.SetRange(PayLine."Budgetary Control A/C",true);
              if PayLine.FindFirst then
                begin
                  repeat
                               //check the votebook now
                               FirstDay:=Dmy2date(1,Date2dmy(ImprestHeader.Date,2),Date2dmy(ImprestHeader.Date,3));
                               CurrMonth:=Date2dmy(ImprestHeader.Date,2);
                               if CurrMonth=12 then
                                begin
                                  LastDay:=Dmy2date(1,1,Date2dmy(ImprestHeader.Date,3) +1);
                                  LastDay:=CalcDate('-1D',LastDay);
                                end
                               else
                                begin
                                  CurrMonth:=CurrMonth +1;
                                  LastDay:=Dmy2date(1,CurrMonth,Date2dmy(ImprestHeader.Date,3));
                                  LastDay:=CalcDate('-1D',LastDay);
                                end;
        
                               //If Budget is annual then change the Last day
                               if BCSetup."Budget Check Criteria"=BCSetup."budget check criteria"::"Whole Year" then
                                   LastDay:=BCSetup."Current Budget End Date";
        
                               //The GL Account
                                BudgetGL:=PayLine."Account No:";
        
                               //check the summation of the budget in the database
                               BudgetAmount:=0;
                               Budget.Reset;
                               Budget.SetCurrentkey(Budget."Budget Name",Budget."Posting Date",Budget."G/L Account No.",
                               Budget."Dimension 1 Value Code",Budget."Dimension 2 Value Code",Budget."Dimension 3 Value Code",
                               Budget."Dimension 4 Value Code");
                               Budget.SetRange(Budget."Budget Name",BCSetup."Current Budget Code");
                               Budget.SetRange(Budget."Posting Date",BCSetup."Current Budget Start Date",LastDay);
                               Budget.SetRange(Budget."G/L Account No.",BudgetGL);
                               Budget.SetRange(Budget."Dimension 1 Value Code",PayLine."Global Dimension 1 Code");
                               Budget.SetRange(Budget."Dimension 2 Value Code",PayLine."Shortcut Dimension 2 Code");
                               Budget.SetRange(Budget."Dimension 3 Value Code",PayLine."Shortcut Dimension 3 Code");
                               Budget.SetRange(Budget."Dimension 4 Value Code",PayLine."Shortcut Dimension 4 Code");
                                   Budget.CalcSums(Budget.Amount);
                                   BudgetAmount:= Budget.Amount;
        
                          //get the summation on the actuals
                          //Separate Analysis View and G/L Entry
                            if BCSetup."Actual Source"=BCSetup."actual source"::"Analysis View Entry" then begin
                            ActualsAmount:=0;
                            Actuals.Reset;
                            Actuals.SetCurrentkey(Actuals."Analysis View Code",Actuals."Dimension 1 Value Code",
                            Actuals."Dimension 2 Value Code",Actuals."Dimension 3 Value Code",Actuals."Dimension 4 Value Code",
                            Actuals."Posting Date",Actuals."Account No.");
                            Actuals.SetRange(Actuals."Analysis View Code",BCSetup."Analysis View Code");
                            Actuals.SetRange(Actuals."Dimension 1 Value Code",PayLine."Global Dimension 1 Code");
                            Actuals.SetRange(Actuals."Dimension 2 Value Code",PayLine."Shortcut Dimension 2 Code");
                            Actuals.SetRange(Actuals."Dimension 3 Value Code",PayLine."Shortcut Dimension 3 Code");
                            Actuals.SetRange(Actuals."Dimension 4 Value Code",PayLine."Shortcut Dimension 4 Code");
                            Actuals.SetRange(Actuals."Posting Date",BCSetup."Current Budget Start Date",LastDay);
                            Actuals.SetRange(Actuals."Account No.",BudgetGL);
                               Actuals.CalcSums(Actuals.Amount);
                               ActualsAmount:= Actuals.Amount;
                            end else begin
                                GLAccount.Reset;
                                GLAccount.SetRange(GLAccount."No.",BudgetGL);
                                GLAccount.SetRange(GLAccount."Date Filter",BCSetup."Current Budget Start Date",LastDay);
                                if PayLine."Global Dimension 1 Code" <> '' then
                                  GLAccount.SetRange(GLAccount."Global Dimension 1 Filter",PayLine."Global Dimension 1 Code");
                                if PayLine."Shortcut Dimension 2 Code" <> '' then
                                  GLAccount.SetRange(GLAccount."Global Dimension 2 Filter",PayLine."Shortcut Dimension 2 Code");
                                if GLAccount.Find('-') then begin
                                 GLAccount.CalcFields(GLAccount."Budgeted Amount",GLAccount."Net Change");
                                 ActualsAmount:=GLAccount."Net Change";
                                end;
                            end;
                          //get the committments
                            CommitmentAmount:=0;
                            Commitments.Reset;
                            Commitments.SetCurrentkey(Commitments.Budget,Commitments."G/L Account No.",
                            Commitments."Posting Date",Commitments."Shortcut Dimension 1 Code",Commitments."Shortcut Dimension 2 Code",
                            Commitments."Shortcut Dimension 3 Code",Commitments."Shortcut Dimension 4 Code");
                            Commitments.SetRange(Commitments.Budget,BCSetup."Current Budget Code");
                            Commitments.SetRange(Commitments."G/L Account No.",BudgetGL);
                            Commitments.SetRange(Commitments."Posting Date",BCSetup."Current Budget Start Date",LastDay);
                            Commitments.SetRange(Commitments."Shortcut Dimension 1 Code",PayLine."Global Dimension 1 Code");
                            Commitments.SetRange(Commitments."Shortcut Dimension 2 Code",PayLine."Shortcut Dimension 2 Code");
                            Commitments.SetRange(Commitments."Shortcut Dimension 3 Code",PayLine."Shortcut Dimension 3 Code");
                            Commitments.SetRange(Commitments."Shortcut Dimension 4 Code",PayLine."Shortcut Dimension 4 Code");
                               Commitments.CalcSums(Commitments.Amount);
                               CommitmentAmount:= Commitments.Amount;
        
                           //check if there is any budget
                           if (BudgetAmount<=0) and not (BCSetup."Allow OverExpenditure") then  begin
                              Error('No Budget To Check Against');
                           end else begin
                            if (BudgetAmount<=0) then begin
                             if not Confirm(Text0003,true) then begin
                                Error('Budgetary Checking Process Aborted');
                             end;
                            end;
                           end;
        
                           //check if the actuals plus the amount is greater then the budget amount
                           if ((CommitmentAmount + PayLine."Amount LCY"+ActualsAmount)>BudgetAmount )
                           and not ( BCSetup."Allow OverExpenditure") then  begin
                              Error('The Amount Voucher No %1  %2 %3  Exceeds The Budget By %4',
                              PayLine.No,'Staff Imprest' ,PayLine.No,
                                Format(Abs(BudgetAmount-(CommitmentAmount + PayLine."Amount LCY"))));
                            end else begin
                            //ADD A CONFIRMATION TO ALLOW USER TO DECIDE WHETHER TO CONTINUE
                                if ((CommitmentAmount + PayLine."Amount LCY"+ ActualsAmount)>BudgetAmount) then begin
                                    if not Confirm(Text0001+
                                    Format(Abs(BudgetAmount-(CommitmentAmount + ActualsAmount+PayLine."Amount LCY")))
                                    +Text0002,true) then begin
                                       Error('Budgetary Checking Process Aborted');
                                    end;
                                end;
        
                                Commitments.Reset;
                                Commitments.Init;
                                EntryNo+=1;
                                Commitments."Line No.":=EntryNo;
                                Commitments.Date:=Today;
                                Commitments."Posting Date":=ImprestHeader.Date;
                                Commitments."Document Type":=Commitments."document type"::StaffAdvance;
                                Commitments."Document No.":=ImprestHeader."No.";
                                Commitments.Amount:=PayLine."Amount LCY";
                                Commitments."Month Budget":=BudgetAmount;
                                Commitments."Month Actual":=ActualsAmount;
                                Commitments.Committed:=true;
                                Commitments."Committed By":=UserId;
                                Commitments."Committed Date":=ImprestHeader.Date;
                                Commitments."G/L Account No.":=BudgetGL;
                                Commitments."Committed Time":=Time;
                               // Commitments."Committed Machine":=ENVIRON('COMPUTERNAME');
                                Commitments."Shortcut Dimension 1 Code":=PayLine."Global Dimension 1 Code";
                                Commitments."Shortcut Dimension 2 Code":=PayLine."Shortcut Dimension 2 Code";
                                Commitments."Shortcut Dimension 3 Code":=PayLine."Shortcut Dimension 3 Code";
                                Commitments."Shortcut Dimension 4 Code":=PayLine."Shortcut Dimension 4 Code";
                                Commitments.Budget:=BCSetup."Current Budget Code";
                                Commitments.Type:=ImprestHeader."Account Type";
                                Commitments."Vendor/Cust No.":=ImprestHeader."Account No.";
        //                        Commitments."Budget Check Criteria":=BCSetup."Budget Check Criteria";
        //                        Commitments."Actual Source":=BCSetup."Actual Source";
                                Commitments.Insert;
                                //Tag the Imprest Line as Committed
                                  PayLine.Committed:=true;
                                  PayLine.Modify;
                                //End Tagging Imprest Lines as Committed
                            end;
        
                  until PayLine.Next=0;
                end;
          end
        else//budget control not mandatory
          begin
        
          end;
        Message('Budgetary Checking Completed Successfully');
        
        
        
        
        
        
        /**********************************************************
        //First Update Analysis View
        UpdateAnalysisView();
        
        //get the budget control setup first to determine if it mandatory or not
        BCSetup.RESET;
        BCSetup.GET();
        IF BCSetup.Mandatory THEN//budgetary control is mandatory
          BEGIN
            //check if the dates are within the specified range in relation to the payment header table
            IF (ImprestHeader.Date< BCSetup."Current Budget Start Date") THEN
              BEGIN
                ERROR('The Current Date %1 for the Imprest Does Not Fall Within Budget Dates %2 - %3',ImprestHeader.Date,
                BCSetup."Current Budget Start Date",BCSetup."Current Budget End Date");
              END
            ELSE IF (ImprestHeader.Date>BCSetup."Current Budget End Date") THEN
              BEGIN
                ERROR('The Current Date %1 for the Imprest Does Not Fall Within Budget Dates %2 - %3',ImprestHeader.Date,
                BCSetup."Current Budget Start Date",BCSetup."Current Budget End Date");
        
              END;
            //Is budget Available
            CheckIfBlocked(BCSetup."Current Budget Code");
        
            //Get Commitment Lines
             IF Commitments.FIND('+') THEN
                EntryNo:=Commitments."Line No.";
        
            //get the lines related to the payment header
              PayLine.RESET;
              PayLine.SETRANGE(PayLine.No,ImprestHeader."No.");
              PayLine.SETRANGE(PayLine."Budgetary Control A/C",TRUE);
              IF PayLine.FINDFIRST THEN
                BEGIN
                  REPEAT
                               //check the votebook now
                               FirstDay:=DMY2DATE(1,DATE2DMY(ImprestHeader.Date,2),DATE2DMY(ImprestHeader.Date,3));
                               CurrMonth:=DATE2DMY(ImprestHeader.Date,2);
                               IF CurrMonth=12 THEN
                                BEGIN
                                  LastDay:=DMY2DATE(1,1,DATE2DMY(ImprestHeader.Date,3) +1);
                                  LastDay:=CALCDATE('-1D',LastDay);
                                END
                               ELSE
                                BEGIN
                                  CurrMonth:=CurrMonth +1;
                                  LastDay:=DMY2DATE(1,CurrMonth,DATE2DMY(ImprestHeader.Date,3));
                                  LastDay:=CALCDATE('-1D',LastDay);
                                END;
        
                               //The GL Account
                                BudgetGL:=PayLine."Account No:";
        
                               //check the summation of the budget in the database
                               BudgetAmount:=0;
                               Budget.RESET;
                               Budget.SETCURRENTKEY(Budget."Budget Name",Budget."Posting Date",Budget."G/L Account No.",
                               Budget."Dimension 1 Value Code",Budget."Dimension 2 Value Code",Budget."Dimension 3 Value Code",
                               Budget."Dimension 4 Value Code");
                               Budget.SETRANGE(Budget."Budget Name",BCSetup."Current Budget Code");
                               Budget.SETRANGE(Budget."Posting Date",BCSetup."Current Budget Start Date",LastDay);
                               Budget.SETRANGE(Budget."G/L Account No.",BudgetGL);
                               Budget.SETRANGE(Budget."Dimension 1 Value Code",PayLine."Global Dimension 1 Code");
                               Budget.SETRANGE(Budget."Dimension 2 Value Code",PayLine."Shortcut Dimension 2 Code");
                               Budget.SETRANGE(Budget."Dimension 3 Value Code",PayLine."Shortcut Dimension 3 Code");
                               Budget.SETRANGE(Budget."Dimension 4 Value Code",PayLine."Shortcut Dimension 4 Code");
                                   Budget.CALCSUMS(Budget.Amount);
                                   BudgetAmount:= Budget.Amount;
        
                          //get the summation on the actuals
                            ActualsAmount:=0;
                            Actuals.RESET;
                            Actuals.SETCURRENTKEY(Actuals."Analysis View Code",Actuals."Dimension 1 Value Code",
                            Actuals."Dimension 2 Value Code",Actuals."Dimension 3 Value Code",Actuals."Dimension 4 Value Code",
                            Actuals."Posting Date",Actuals."G/L Account No.");
                            Actuals.SETRANGE(Actuals."Analysis View Code",BCSetup."Analysis View Code");
                            Actuals.SETRANGE(Actuals."Dimension 1 Value Code",PayLine."Global Dimension 1 Code");
                            Actuals.SETRANGE(Actuals."Dimension 2 Value Code",PayLine."Shortcut Dimension 2 Code");
                            Actuals.SETRANGE(Actuals."Dimension 3 Value Code",PayLine."Shortcut Dimension 3 Code");
                            Actuals.SETRANGE(Actuals."Dimension 4 Value Code",PayLine."Shortcut Dimension 4 Code");
                            Actuals.SETRANGE(Actuals."Posting Date",BCSetup."Current Budget Start Date",LastDay);
                            Actuals.SETRANGE(Actuals."G/L Account No.",BudgetGL);
                               Actuals.CALCSUMS(Actuals.Amount);
                               ActualsAmount:= Actuals.Amount;
        
                          //get the committments
                            CommitmentAmount:=0;
                            Commitments.RESET;
                            Commitments.SETCURRENTKEY(Commitments.Budget,Commitments."G/L Account No.",
                            Commitments."Posting Date",Commitments."Shortcut Dimension 1 Code",Commitments."Shortcut Dimension 2 Code",
                            Commitments."Shortcut Dimension 3 Code",Commitments."Shortcut Dimension 4 Code");
                            Commitments.SETRANGE(Commitments.Budget,BCSetup."Current Budget Code");
                            Commitments.SETRANGE(Commitments."G/L Account No.",BudgetGL);
                            Commitments.SETRANGE(Commitments."Posting Date",BCSetup."Current Budget Start Date",LastDay);
                            Commitments.SETRANGE(Commitments."Shortcut Dimension 1 Code",PayLine."Global Dimension 1 Code");
                            Commitments.SETRANGE(Commitments."Shortcut Dimension 2 Code",PayLine."Shortcut Dimension 2 Code");
                            Commitments.SETRANGE(Commitments."Shortcut Dimension 3 Code",PayLine."Shortcut Dimension 3 Code");
                            Commitments.SETRANGE(Commitments."Shortcut Dimension 4 Code",PayLine."Shortcut Dimension 4 Code");
                               Commitments.CALCSUMS(Commitments.Amount);
                               CommitmentAmount:= Commitments.Amount;
        
                           //check if there is any budget
                           IF (BudgetAmount<=0) AND NOT (BCSetup."Allow OverExpenditure") THEN  BEGIN
                              ERROR('No Budget To Check Against');
                           END ELSE BEGIN
                            IF (BudgetAmount<=0) THEN BEGIN
                             IF NOT CONFIRM(Text0003,TRUE) THEN BEGIN
                                ERROR('Budgetary Checking Process Aborted');
                             END;
                            END;
                           END;
        
                           //check if the actuals plus the amount is greater then the budget amount
                           IF ((CommitmentAmount + PayLine."Amount LCY"+ActualsAmount)>BudgetAmount )
                           AND NOT ( BCSetup."Allow OverExpenditure") THEN  BEGIN
                              ERROR('The Amount Voucher No %1  %2 %3  Exceeds The Budget By %4',
                              PayLine.No,'Staff Imprest' ,PayLine.No,
                                FORMAT(ABS(BudgetAmount-(CommitmentAmount + PayLine."Amount LCY"))));
                            END ELSE BEGIN
                            //ADD A CONFIRMATION TO ALLOW USER TO DECIDE WHETHER TO CONTINUE
                                IF ((CommitmentAmount + PayLine."Amount LCY"+ ActualsAmount)>BudgetAmount) THEN BEGIN
                                    IF NOT CONFIRM(Text0001+
                                    FORMAT(ABS(BudgetAmount-(CommitmentAmount + ActualsAmount+PayLine."Amount LCY")))
                                    +Text0002,TRUE) THEN BEGIN
                                       ERROR('Budgetary Checking Process Aborted');
                                    END;
                                END;
        
                                Commitments.RESET;
                                Commitments.INIT;
                                EntryNo+=1;
                                Commitments."Line No.":=EntryNo;
                                Commitments.Date:=TODAY;
                                Commitments."Posting Date":=ImprestHeader.Date;
                                Commitments."Document Type":=Commitments."Document Type"::StaffClaim;
                                Commitments."Document No.":=ImprestHeader."No.";
                                Commitments.Amount:=PayLine."Amount LCY";
                                Commitments."Month Budget":=BudgetAmount;
                                Commitments."Month Actual":=ActualsAmount;
                                Commitments.Committed:=TRUE;
                                Commitments."Committed By":=USERID;
                                Commitments."Committed Date":=ImprestHeader.Date;
                                Commitments."G/L Account No.":=BudgetGL;
                                Commitments."Committed Time":=TIME;
        //                        Commitments."Committed Machine":=ENVIRON('COMPUTERNAME');
                                Commitments."Shortcut Dimension 1 Code":=PayLine."Global Dimension 1 Code";
                                Commitments."Shortcut Dimension 2 Code":=PayLine."Shortcut Dimension 2 Code";
                                Commitments."Shortcut Dimension 3 Code":=PayLine."Shortcut Dimension 3 Code";
                                Commitments."Shortcut Dimension 4 Code":=PayLine."Shortcut Dimension 4 Code";
                                Commitments.Budget:=BCSetup."Current Budget Code";
                                Commitments.Type:=ImprestHeader."Account Type";
                                Commitments."Vendor/Cust No.":=ImprestHeader."Account No.";
                                Commitments.INSERT;
                                //Tag the Imprest Line as Committed
                                  PayLine.Committed:=TRUE;
                                  PayLine.MODIFY;
                                //End Tagging Imprest Lines as Committed
                            END;
        
                  UNTIL PayLine.NEXT=0;
                END;
          END
        ELSE//budget control not mandatory
          BEGIN
        
          END;
        MESSAGE('Budgetary Checking Completed Successfully');
        ****************************************/

    end;


    procedure CheckStaffAdvance(var ImprestHeader: Record "Imprest Header")
    var
        PayLine: Record "Customer Care Logs";
        Commitments: Record "Transaction Types";
        Amount: Decimal;
        GLAcc: Record "G/L Account";
        Item: Record Item;
        FirstDay: Date;
        LastDay: Date;
        CurrMonth: Integer;
        Budget: Record "Analysis View Budget Entry";
        BudgetAmount: Decimal;
        Actuals: Record "Analysis View Entry";
        ActualsAmount: Decimal;
        CommitmentAmount: Decimal;
        FixedAssetsDet: Record "Fixed Asset";
        FAPostingGRP: Record "FA Posting Group";
        EntryNo: Integer;
        GLAccount: Record "G/L Account";
    begin
        /*
        //First Update Analysis View
        UpdateAnalysisView();
        
        //get the budget control setup first to determine if it mandatory or not
        BCSetup.RESET;
        BCSetup.GET();
        IF BCSetup.Mandatory THEN//budgetary control is mandatory
          BEGIN
            //check if the dates are within the specified range in relation to the payment header table
            IF (ImprestHeader.Date< BCSetup."Current Budget Start Date") THEN
              BEGIN
                ERROR('The Current Date %1 for the Imprest Does Not Fall Within Budget Dates %2 - %3',ImprestHeader.Date,
                BCSetup."Current Budget Start Date",BCSetup."Current Budget End Date");
              END
            ELSE IF (ImprestHeader.Date>BCSetup."Current Budget End Date") THEN
              BEGIN
                ERROR('The Current Date %1 for the Imprest Does Not Fall Within Budget Dates %2 - %3',ImprestHeader.Date,
                BCSetup."Current Budget Start Date",BCSetup."Current Budget End Date");
        
              END;
            //Is budget Available
            CheckIfBlocked(BCSetup."Current Budget Code");
        
            //Get Commitment Lines
             IF Commitments.FIND('+') THEN
                EntryNo:=Commitments."Line No.";
        
            //get the lines related to the payment header
              PayLine.RESET;
              PayLine.SETRANGE(PayLine.No,ImprestHeader."No.");
              PayLine.SETRANGE(PayLine."Budgetary Control A/C",TRUE);
              IF PayLine.FINDFIRST THEN
                BEGIN
                  REPEAT
                               //check the votebook now
                               FirstDay:=DMY2DATE(1,DATE2DMY(ImprestHeader.Date,2),DATE2DMY(ImprestHeader.Date,3));
                               CurrMonth:=DATE2DMY(ImprestHeader.Date,2);
                               IF CurrMonth=12 THEN
                                BEGIN
                                  LastDay:=DMY2DATE(1,1,DATE2DMY(ImprestHeader.Date,3) +1);
                                  LastDay:=CALCDATE('-1D',LastDay);
                                END
                               ELSE
                                BEGIN
                                  CurrMonth:=CurrMonth +1;
                                  LastDay:=DMY2DATE(1,CurrMonth,DATE2DMY(ImprestHeader.Date,3));
                                  LastDay:=CALCDATE('-1D',LastDay);
                                END;
        
                               //If Budget is annual then change the Last day
                               IF BCSetup."Budget Check Criteria"=BCSetup."Budget Check Criteria"::"Whole Year" THEN
                                   LastDay:=BCSetup."Current Budget End Date";
        
                               //The GL Account
                                BudgetGL:=PayLine."Account No:";
        
                               //check the summation of the budget in the database
                               BudgetAmount:=0;
                               Budget.RESET;
                               Budget.SETCURRENTKEY(Budget."Budget Name",Budget."Posting Date",Budget."G/L Account No.",
                               Budget."Dimension 1 Value Code",Budget."Dimension 2 Value Code",Budget."Dimension 3 Value Code",
                               Budget."Dimension 4 Value Code");
                               Budget.SETRANGE(Budget."Budget Name",BCSetup."Current Budget Code");
                               Budget.SETRANGE(Budget."Posting Date",BCSetup."Current Budget Start Date",LastDay);
                               Budget.SETRANGE(Budget."G/L Account No.",BudgetGL);
                               Budget.SETRANGE(Budget."Dimension 1 Value Code",PayLine."Global Dimension 1 Code");
                               Budget.SETRANGE(Budget."Dimension 2 Value Code",PayLine."Shortcut Dimension 2 Code");
                               Budget.SETRANGE(Budget."Dimension 3 Value Code",PayLine."Shortcut Dimension 3 Code");
                               Budget.SETRANGE(Budget."Dimension 4 Value Code",PayLine."Shortcut Dimension 4 Code");
                                   Budget.CALCSUMS(Budget.Amount);
                                   BudgetAmount:= Budget.Amount;
        
                          //get the summation on the actuals
                          //Separate Analysis View and G/L Entry
                            IF BCSetup."Actual Source"=BCSetup."Actual Source"::"Analysis View Entry" THEN BEGIN
                            ActualsAmount:=0;
                            Actuals.RESET;
                            Actuals.SETCURRENTKEY(Actuals."Analysis View Code",Actuals."Dimension 1 Value Code",
                            Actuals."Dimension 2 Value Code",Actuals."Dimension 3 Value Code",Actuals."Dimension 4 Value Code",
                            Actuals."Posting Date",Actuals."Account No.");
                            Actuals.SETRANGE(Actuals."Analysis View Code",BCSetup."Analysis View Code");
                            Actuals.SETRANGE(Actuals."Dimension 1 Value Code",PayLine."Global Dimension 1 Code");
                            Actuals.SETRANGE(Actuals."Dimension 2 Value Code",PayLine."Shortcut Dimension 2 Code");
                            Actuals.SETRANGE(Actuals."Dimension 3 Value Code",PayLine."Shortcut Dimension 3 Code");
                            Actuals.SETRANGE(Actuals."Dimension 4 Value Code",PayLine."Shortcut Dimension 4 Code");
                            Actuals.SETRANGE(Actuals."Posting Date",BCSetup."Current Budget Start Date",LastDay);
                            Actuals.SETRANGE(Actuals."Account No.",BudgetGL);
                               Actuals.CALCSUMS(Actuals.Amount);
                               ActualsAmount:= Actuals.Amount;
                            END ELSE BEGIN
                                GLAccount.RESET;
                                GLAccount.SETRANGE(GLAccount."No.",BudgetGL);
                                GLAccount.SETRANGE(GLAccount."Date Filter",BCSetup."Current Budget Start Date",LastDay);
                                IF PayLine."Global Dimension 1 Code" <> '' THEN
                                  GLAccount.SETRANGE(GLAccount."Global Dimension 1 Filter",PayLine."Global Dimension 1 Code");
                                IF PayLine."Shortcut Dimension 2 Code" <> '' THEN
                                  GLAccount.SETRANGE(GLAccount."Global Dimension 2 Filter",PayLine."Shortcut Dimension 2 Code");
                                IF GLAccount.FIND('-') THEN BEGIN
                                 GLAccount.CALCFIELDS(GLAccount."Budgeted Amount",GLAccount."Net Change");
                                 ActualsAmount:=GLAccount."Net Change";
                                END;
                            END;
                          //get the committments
                            CommitmentAmount:=0;
                            Commitments.RESET;
                            Commitments.SETCURRENTKEY(Commitments.Budget,Commitments."G/L Account No.",
                            Commitments."Posting Date",Commitments."Shortcut Dimension 1 Code",Commitments."Shortcut Dimension 2 Code",
                            Commitments."Shortcut Dimension 3 Code",Commitments."Shortcut Dimension 4 Code");
                            Commitments.SETRANGE(Commitments.Budget,BCSetup."Current Budget Code");
                            Commitments.SETRANGE(Commitments."G/L Account No.",BudgetGL);
                            Commitments.SETRANGE(Commitments."Posting Date",BCSetup."Current Budget Start Date",LastDay);
                            Commitments.SETRANGE(Commitments."Shortcut Dimension 1 Code",PayLine."Global Dimension 1 Code");
                            Commitments.SETRANGE(Commitments."Shortcut Dimension 2 Code",PayLine."Shortcut Dimension 2 Code");
                            Commitments.SETRANGE(Commitments."Shortcut Dimension 3 Code",PayLine."Shortcut Dimension 3 Code");
                            Commitments.SETRANGE(Commitments."Shortcut Dimension 4 Code",PayLine."Shortcut Dimension 4 Code");
                               Commitments.CALCSUMS(Commitments.Amount);
                               CommitmentAmount:= Commitments.Amount;
        
                           //check if there is any budget
                           IF (BudgetAmount<=0) AND NOT (BCSetup."Allow OverExpenditure") THEN  BEGIN
                              ERROR('No Budget To Check Against');
                           END ELSE BEGIN
                            IF (BudgetAmount<=0) THEN BEGIN
                             IF NOT CONFIRM(Text0003,TRUE) THEN BEGIN
                                ERROR('Budgetary Checking Process Aborted');
                             END;
                            END;
                           END;
        
                           //check if the actuals plus the amount is greater then the budget amount
                           IF ((CommitmentAmount + PayLine."Amount LCY"+ActualsAmount)>BudgetAmount )
                           AND NOT ( BCSetup."Allow OverExpenditure") THEN  BEGIN
                              ERROR('The Amount Voucher No %1  %2 %3  Exceeds The Budget By %4',
                              PayLine.No,'Staff Imprest' ,PayLine.No,
                                FORMAT(ABS(BudgetAmount-(CommitmentAmount + PayLine."Amount LCY"))));
                            END ELSE BEGIN
                            //ADD A CONFIRMATION TO ALLOW USER TO DECIDE WHETHER TO CONTINUE
                                IF ((CommitmentAmount + PayLine."Amount LCY"+ ActualsAmount)>BudgetAmount) THEN BEGIN
                                    IF NOT CONFIRM(Text0001+
                                    FORMAT(ABS(BudgetAmount-(CommitmentAmount + ActualsAmount+PayLine."Amount LCY")))
                                    +Text0002,TRUE) THEN BEGIN
                                       ERROR('Budgetary Checking Process Aborted');
                                    END;
                                END;
        
                                Commitments.RESET;
                                Commitments.INIT;
                                EntryNo+=1;
                                Commitments."Line No.":=EntryNo;
                                Commitments.Date:=TODAY;
                                Commitments."Posting Date":=ImprestHeader.Date;
                                Commitments."Document Type":=Commitments."Document Type"::StaffAdvance;
                                Commitments."Document No.":=ImprestHeader."No.";
                                Commitments.Amount:=PayLine."Amount LCY";
                                Commitments."Month Budget":=BudgetAmount;
                                Commitments."Month Actual":=ActualsAmount;
                                Commitments.Committed:=TRUE;
                                Commitments."Committed By":=USERID;
                                Commitments."Committed Date":=ImprestHeader.Date;
                                Commitments."G/L Account No.":=BudgetGL;
                                Commitments."Committed Time":=TIME;
                             //   Commitments."Committed Machine":=ENVIRON('COMPUTERNAME');
                                Commitments."Shortcut Dimension 1 Code":=PayLine."Global Dimension 1 Code";
                                Commitments."Shortcut Dimension 2 Code":=PayLine."Shortcut Dimension 2 Code";
                                Commitments."Shortcut Dimension 3 Code":=PayLine."Shortcut Dimension 3 Code";
                                Commitments."Shortcut Dimension 4 Code":=PayLine."Shortcut Dimension 4 Code";
                                Commitments.Budget:=BCSetup."Current Budget Code";
                                Commitments.Type:=ImprestHeader."Account Type";
                                Commitments."Vendor/Cust No.":=ImprestHeader."Account No.";
        //                        Commitments."Budget Check Criteria":=BCSetup."Budget Check Criteria";
        //                        Commitments."Actual Source":=BCSetup."Actual Source";
                                Commitments.INSERT;
                                //Tag the Imprest Line as Committed
                                  PayLine.Committed:=TRUE;
                                  PayLine.MODIFY;
                                //End Tagging Imprest Lines as Committed
                            END;
        
                  UNTIL PayLine.NEXT=0;
                END;
          END
        ELSE//budget control not mandatory
          BEGIN
        
          END;
        MESSAGE('Budgetary Checking Completed Successfully');
        
        
        
        {********************
        //First Update Analysis View
        UpdateAnalysisView();
        
        //get the budget control setup first to determine if it mandatory or not
        BCSetup.RESET;
        BCSetup.GET();
        IF BCSetup.Mandatory THEN//budgetary control is mandatory
          BEGIN
            //check if the dates are within the specified range in relation to the payment header table
            IF (ImprestHeader.Date< BCSetup."Current Budget Start Date") THEN
              BEGIN
                ERROR('The Current Date %1 for the Imprest Does Not Fall Within Budget Dates %2 - %3',ImprestHeader.Date,
                BCSetup."Current Budget Start Date",BCSetup."Current Budget End Date");
              END
            ELSE IF (ImprestHeader.Date>BCSetup."Current Budget End Date") THEN
              BEGIN
                ERROR('The Current Date %1 for the Imprest Does Not Fall Within Budget Dates %2 - %3',ImprestHeader.Date,
                BCSetup."Current Budget Start Date",BCSetup."Current Budget End Date");
        
              END;
            //Is budget Available
            CheckIfBlocked(BCSetup."Current Budget Code");
        
            //Get Commitment Lines
             IF Commitments.FIND('+') THEN
                EntryNo:=Commitments."Line No.";
        
            //get the lines related to the payment header
              PayLine.RESET;
              PayLine.SETRANGE(PayLine.No,ImprestHeader."No.");
              PayLine.SETRANGE(PayLine."Budgetary Control A/C",TRUE);
              IF PayLine.FINDFIRST THEN
                BEGIN
                  REPEAT
                               //check the votebook now
                               FirstDay:=DMY2DATE(1,DATE2DMY(ImprestHeader.Date,2),DATE2DMY(ImprestHeader.Date,3));
                               CurrMonth:=DATE2DMY(ImprestHeader.Date,2);
                               IF CurrMonth=12 THEN
                                BEGIN
                                  LastDay:=DMY2DATE(1,1,DATE2DMY(ImprestHeader.Date,3) +1);
                                  LastDay:=CALCDATE('-1D',LastDay);
                                END
                               ELSE
                                BEGIN
                                  CurrMonth:=CurrMonth +1;
                                  LastDay:=DMY2DATE(1,CurrMonth,DATE2DMY(ImprestHeader.Date,3));
                                  LastDay:=CALCDATE('-1D',LastDay);
                                END;
        
                               //The GL Account
                                BudgetGL:=PayLine."Account No:";
        
                               //check the summation of the budget in the database
                               BudgetAmount:=0;
                               Budget.RESET;
                               Budget.SETCURRENTKEY(Budget."Budget Name",Budget."Posting Date",Budget."G/L Account No.",
                               Budget."Dimension 1 Value Code",Budget."Dimension 2 Value Code",Budget."Dimension 3 Value Code",
                               Budget."Dimension 4 Value Code");
                               Budget.SETRANGE(Budget."Budget Name",BCSetup."Current Budget Code");
                               Budget.SETRANGE(Budget."Posting Date",BCSetup."Current Budget Start Date",LastDay);
                               Budget.SETRANGE(Budget."G/L Account No.",BudgetGL);
                               Budget.SETRANGE(Budget."Dimension 1 Value Code",PayLine."Global Dimension 1 Code");
                               Budget.SETRANGE(Budget."Dimension 2 Value Code",PayLine."Shortcut Dimension 2 Code");
                               Budget.SETRANGE(Budget."Dimension 3 Value Code",PayLine."Shortcut Dimension 3 Code");
                               Budget.SETRANGE(Budget."Dimension 4 Value Code",PayLine."Shortcut Dimension 4 Code");
                                   Budget.CALCSUMS(Budget.Amount);
                                   BudgetAmount:= Budget.Amount;
        
                          //get the summation on the actuals
                            ActualsAmount:=0;
                            Actuals.RESET;
                            Actuals.SETCURRENTKEY(Actuals."Analysis View Code",Actuals."Dimension 1 Value Code",
                            Actuals."Dimension 2 Value Code",Actuals."Dimension 3 Value Code",Actuals."Dimension 4 Value Code",
                            Actuals."Posting Date",Actuals."G/L Account No.");
                            Actuals.SETRANGE(Actuals."Analysis View Code",BCSetup."Analysis View Code");
                            Actuals.SETRANGE(Actuals."Dimension 1 Value Code",PayLine."Global Dimension 1 Code");
                            Actuals.SETRANGE(Actuals."Dimension 2 Value Code",PayLine."Shortcut Dimension 2 Code");
                            Actuals.SETRANGE(Actuals."Dimension 3 Value Code",PayLine."Shortcut Dimension 3 Code");
                            Actuals.SETRANGE(Actuals."Dimension 4 Value Code",PayLine."Shortcut Dimension 4 Code");
                            Actuals.SETRANGE(Actuals."Posting Date",BCSetup."Current Budget Start Date",LastDay);
                            Actuals.SETRANGE(Actuals."G/L Account No.",BudgetGL);
                               Actuals.CALCSUMS(Actuals.Amount);
                               ActualsAmount:= Actuals.Amount;
        
                          //get the committments
                            CommitmentAmount:=0;
                            Commitments.RESET;
                            Commitments.SETCURRENTKEY(Commitments.Budget,Commitments."G/L Account No.",
                            Commitments."Posting Date",Commitments."Shortcut Dimension 1 Code",Commitments."Shortcut Dimension 2 Code",
                            Commitments."Shortcut Dimension 3 Code",Commitments."Shortcut Dimension 4 Code");
                            Commitments.SETRANGE(Commitments.Budget,BCSetup."Current Budget Code");
                            Commitments.SETRANGE(Commitments."G/L Account No.",BudgetGL);
                            Commitments.SETRANGE(Commitments."Posting Date",BCSetup."Current Budget Start Date",LastDay);
                            Commitments.SETRANGE(Commitments."Shortcut Dimension 1 Code",PayLine."Global Dimension 1 Code");
                            Commitments.SETRANGE(Commitments."Shortcut Dimension 2 Code",PayLine."Shortcut Dimension 2 Code");
                            Commitments.SETRANGE(Commitments."Shortcut Dimension 3 Code",PayLine."Shortcut Dimension 3 Code");
                            Commitments.SETRANGE(Commitments."Shortcut Dimension 4 Code",PayLine."Shortcut Dimension 4 Code");
                               Commitments.CALCSUMS(Commitments.Amount);
                               CommitmentAmount:= Commitments.Amount;
        
                           //check if there is any budget
                           IF (BudgetAmount<=0) AND NOT (BCSetup."Allow OverExpenditure") THEN  BEGIN
                              ERROR('No Budget To Check Against');
                           END ELSE BEGIN
                            IF (BudgetAmount<=0) THEN BEGIN
                             IF NOT CONFIRM(Text0003,TRUE) THEN BEGIN
                                ERROR('Budgetary Checking Process Aborted');
                             END;
                            END;
                           END;
        
                           //check if the actuals plus the amount is greater then the budget amount
                           IF ((CommitmentAmount + PayLine."Amount LCY"+ActualsAmount)>BudgetAmount )
                           AND NOT ( BCSetup."Allow OverExpenditure") THEN  BEGIN
                              ERROR('The Amount Voucher No %1  %2 %3  Exceeds The Budget By %4',
                              PayLine.No,'Staff Imprest' ,PayLine.No,
                                FORMAT(ABS(BudgetAmount-(CommitmentAmount + PayLine."Amount LCY"))));
                            END ELSE BEGIN
                            //ADD A CONFIRMATION TO ALLOW USER TO DECIDE WHETHER TO CONTINUE
                                IF ((CommitmentAmount + PayLine."Amount LCY"+ ActualsAmount)>BudgetAmount) THEN BEGIN
                                    IF NOT CONFIRM(Text0001+
                                    FORMAT(ABS(BudgetAmount-(CommitmentAmount + ActualsAmount+PayLine."Amount LCY")))
                                    +Text0002,TRUE) THEN BEGIN
                                       ERROR('Budgetary Checking Process Aborted');
                                    END;
                                END;
        
                                Commitments.RESET;
                                Commitments.INIT;
                                EntryNo+=1;
                                Commitments."Line No.":=EntryNo;
                                Commitments.Date:=TODAY;
                                Commitments."Posting Date":=ImprestHeader.Date;
                                Commitments."Document Type":=Commitments."Document Type"::StaffAdvance;
                                Commitments."Document No.":=ImprestHeader."No.";
                                Commitments.Amount:=PayLine."Amount LCY";
                                Commitments."Month Budget":=BudgetAmount;
                                Commitments."Month Actual":=ActualsAmount;
                                Commitments.Committed:=TRUE;
                                Commitments."Committed By":=USERID;
                                Commitments."Committed Date":=ImprestHeader.Date;
                                Commitments."G/L Account No.":=BudgetGL;
                                Commitments."Committed Time":=TIME;
        //                       // Commitments."Committed Machine":=ENVIRON('COMPUTERNAME');
                                Commitments."Shortcut Dimension 1 Code":=PayLine."Global Dimension 1 Code";
                                Commitments."Shortcut Dimension 2 Code":=PayLine."Shortcut Dimension 2 Code";
                                Commitments."Shortcut Dimension 3 Code":=PayLine."Shortcut Dimension 3 Code";
                                Commitments."Shortcut Dimension 4 Code":=PayLine."Shortcut Dimension 4 Code";
                                Commitments.Budget:=BCSetup."Current Budget Code";
                                Commitments.Type:=ImprestHeader."Account Type";
                                Commitments."Vendor/Cust No.":=ImprestHeader."Account No.";
                                Commitments.INSERT;
                                //Tag the Imprest Line as Committed
                                  PayLine.Committed:=TRUE;
                                  PayLine.MODIFY;
                                //End Tagging Imprest Lines as Committed
                            END;
        
                  UNTIL PayLine.NEXT=0;
                END;
          END
        ELSE//budget control not mandatory
          BEGIN
        
          END;
        MESSAGE('Budgetary Checking Completed Successfully');
        ******************************}
        */

    end;


    procedure CheckStaffAdvSurr(var ImprestHeader: Record "Imprest Surrender Header")
    var
        PayLine: Record "Cheque Issue Lines";
        Commitments: Record "Transaction Types";
        Amount: Decimal;
        GLAcc: Record "G/L Account";
        Item: Record Item;
        FirstDay: Date;
        LastDay: Date;
        CurrMonth: Integer;
        Budget: Record "Analysis View Budget Entry";
        BudgetAmount: Decimal;
        Actuals: Record "Analysis View Entry";
        ActualsAmount: Decimal;
        CommitmentAmount: Decimal;
        FixedAssetsDet: Record "Fixed Asset";
        FAPostingGRP: Record "FA Posting Group";
        EntryNo: Integer;
    begin
        /*//First Update Analysis View
        UpdateAnalysisView();
        
        //get the budget control setup first to determine if it mandatory or not
        BCSetup.RESET;
        BCSetup.GET();
        IF BCSetup.Mandatory THEN//budgetary control is mandatory
          BEGIN
            //check if the dates are within the specified range in relation to the payment header table
            IF (ImprestHeader."Surrender Date"< BCSetup."Current Budget Start Date") THEN
              BEGIN
                ERROR('The Current Date %1 for the Imprest Does Not Fall Within Budget Dates %2 - %3',ImprestHeader."Surrender Date",
                BCSetup."Current Budget Start Date",BCSetup."Current Budget End Date");
              END
            ELSE IF (ImprestHeader."Surrender Date">BCSetup."Current Budget End Date") THEN
              BEGIN
                ERROR('The Current Date %1 for the Imprest Does Not Fall Within Budget Dates %2 - %3',ImprestHeader."Surrender Date",
                BCSetup."Current Budget Start Date",BCSetup."Current Budget End Date");
        
              END;
            //Is budget Available
            CheckIfBlocked(BCSetup."Current Budget Code");
        
            //Get Commitment Lines
             IF Commitments.FIND('+') THEN
                EntryNo:=Commitments."Line No.";
        
            //get the lines related to the payment header
              PayLine.RESET;
              PayLine.SETRANGE(PayLine."Surrender Doc No.",ImprestHeader.No);
              PayLine.SETRANGE(PayLine."Budgetary Control A/C",TRUE);
              IF PayLine.FINDFIRST THEN
                BEGIN
                  REPEAT
                               //check the votebook now
                               FirstDay:=DMY2DATE(1,DATE2DMY(ImprestHeader."Surrender Date",2),DATE2DMY(ImprestHeader."Surrender Date",3));
                               CurrMonth:=DATE2DMY(ImprestHeader."Surrender Date",2);
                               IF CurrMonth=12 THEN
                                BEGIN
                                  LastDay:=DMY2DATE(1,1,DATE2DMY(ImprestHeader."Surrender Date",3) +1);
                                  LastDay:=CALCDATE('-1D',LastDay);
                                END
                               ELSE
                                BEGIN
                                  CurrMonth:=CurrMonth +1;
                                  LastDay:=DMY2DATE(1,CurrMonth,DATE2DMY(ImprestHeader."Surrender Date",3));
                                  LastDay:=CALCDATE('-1D',LastDay);
                                END;
        
                               //The GL Account
                                BudgetGL:=PayLine."Account No:";
        
                               //check the summation of the budget in the database
                               BudgetAmount:=0;
                               Budget.RESET;
                               Budget.SETCURRENTKEY(Budget."Budget Name",Budget."Posting Date",Budget."G/L Account No.",
                               Budget."Dimension 1 Value Code",Budget."Dimension 2 Value Code",Budget."Dimension 3 Value Code",
                               Budget."Dimension 4 Value Code");
                               Budget.SETRANGE(Budget."Budget Name",BCSetup."Current Budget Code");
                               Budget.SETRANGE(Budget."Posting Date",BCSetup."Current Budget Start Date",LastDay);
                               Budget.SETRANGE(Budget."G/L Account No.",BudgetGL);
                               Budget.SETRANGE(Budget."Dimension 1 Value Code",PayLine."Shortcut Dimension 1 Code");
                               Budget.SETRANGE(Budget."Dimension 2 Value Code",PayLine."Shortcut Dimension 2 Code");
                               Budget.SETRANGE(Budget."Dimension 3 Value Code",PayLine."Shortcut Dimension 3 Code");
                               Budget.SETRANGE(Budget."Dimension 4 Value Code",PayLine."Shortcut Dimension 4 Code");
                                   Budget.CALCSUMS(Budget.Amount);
                                   BudgetAmount:= Budget.Amount;
        
                          //get the summation on the actuals
                            ActualsAmount:=0;
                            Actuals.RESET;
                            Actuals.SETCURRENTKEY(Actuals."Analysis View Code",Actuals."Dimension 1 Value Code",
                            Actuals."Dimension 2 Value Code",Actuals."Dimension 3 Value Code",Actuals."Dimension 4 Value Code",
                            Actuals."Posting Date",Actuals."Account No.");
                            Actuals.SETRANGE(Actuals."Analysis View Code",BCSetup."Analysis View Code");
                            Actuals.SETRANGE(Actuals."Dimension 1 Value Code",PayLine."Shortcut Dimension 1 Code");
                            Actuals.SETRANGE(Actuals."Dimension 2 Value Code",PayLine."Shortcut Dimension 2 Code");
                            Actuals.SETRANGE(Actuals."Dimension 3 Value Code",PayLine."Shortcut Dimension 3 Code");
                            Actuals.SETRANGE(Actuals."Dimension 4 Value Code",PayLine."Shortcut Dimension 4 Code");
                            Actuals.SETRANGE(Actuals."Posting Date",BCSetup."Current Budget Start Date",LastDay);
                            Actuals.SETRANGE(Actuals."Account No.",BudgetGL);
                               Actuals.CALCSUMS(Actuals.Amount);
                               ActualsAmount:= Actuals.Amount;
        
                          //get the committments
                            CommitmentAmount:=0;
                            Commitments.RESET;
                            Commitments.SETCURRENTKEY(Commitments.Budget,Commitments."G/L Account No.",
                            Commitments."Posting Date",Commitments."Shortcut Dimension 1 Code",Commitments."Shortcut Dimension 2 Code",
                            Commitments."Shortcut Dimension 3 Code",Commitments."Shortcut Dimension 4 Code");
                            Commitments.SETRANGE(Commitments.Budget,BCSetup."Current Budget Code");
                            Commitments.SETRANGE(Commitments."G/L Account No.",BudgetGL);
                            Commitments.SETRANGE(Commitments."Posting Date",BCSetup."Current Budget Start Date",LastDay);
                            Commitments.SETRANGE(Commitments."Shortcut Dimension 1 Code",PayLine."Shortcut Dimension 1 Code");
                            Commitments.SETRANGE(Commitments."Shortcut Dimension 2 Code",PayLine."Shortcut Dimension 2 Code");
                            Commitments.SETRANGE(Commitments."Shortcut Dimension 3 Code",PayLine."Shortcut Dimension 3 Code");
                            Commitments.SETRANGE(Commitments."Shortcut Dimension 4 Code",PayLine."Shortcut Dimension 4 Code");
                               Commitments.CALCSUMS(Commitments.Amount);
                               CommitmentAmount:= Commitments.Amount;
        
                           //check if there is any budget
                           IF (BudgetAmount<=0) AND NOT (BCSetup."Allow OverExpenditure") THEN  BEGIN
                              ERROR('No Budget To Check Against');
                           END ELSE BEGIN
                            IF (BudgetAmount<=0) THEN BEGIN
                             IF NOT CONFIRM(Text0003,TRUE) THEN BEGIN
                                ERROR('Budgetary Checking Process Aborted');
                             END;
                            END;
                           END;
        
                           //check if the actuals plus the amount is greater then the budget amount
                           IF ((CommitmentAmount + PayLine."Amount LCY"+ActualsAmount)>BudgetAmount )
                           AND NOT ( BCSetup."Allow OverExpenditure") THEN  BEGIN
                              ERROR('The Amount Voucher No %1  %2 %3  Exceeds The Budget By %4',
                              PayLine."Surrender Doc No.",'Staff Imprest' ,PayLine."Surrender Doc No.",
                                FORMAT(ABS(BudgetAmount-(CommitmentAmount + PayLine."Amount LCY"))));
                            END ELSE BEGIN
                            //ADD A CONFIRMATION TO ALLOW USER TO DECIDE WHETHER TO CONTINUE
                                IF ((CommitmentAmount + PayLine."Amount LCY"+ ActualsAmount)>BudgetAmount) THEN BEGIN
                                    IF NOT CONFIRM(Text0001+
                                    FORMAT(ABS(BudgetAmount-(CommitmentAmount + ActualsAmount+PayLine."Amount LCY")))
                                    +Text0002,TRUE) THEN BEGIN
                                       ERROR('Budgetary Checking Process Aborted');
                                    END;
                                END;
        
                                Commitments.RESET;
                                Commitments.INIT;
                                EntryNo+=1;
                                Commitments."Line No.":=EntryNo;
                                Commitments.Date:=TODAY;
                                Commitments."Posting Date":=ImprestHeader."Surrender Date";
                                Commitments."Document Type":=Commitments."Document Type"::StaffSurrender;
                                Commitments."Document No.":=ImprestHeader.No;
                                Commitments.Amount:=PayLine."Amount LCY";
                                Commitments."Month Budget":=BudgetAmount;
                                Commitments."Month Actual":=ActualsAmount;
                                Commitments.Committed:=TRUE;
                                Commitments."Committed By":=USERID;
                                Commitments."Committed Date":=ImprestHeader."Surrender Date";
                                Commitments."G/L Account No.":=BudgetGL;
                                Commitments."Committed Time":=TIME;
        //                        Commitments."Committed Machine":=ENVIRON('COMPUTERNAME');
                                Commitments."Shortcut Dimension 1 Code":=PayLine."Shortcut Dimension 1 Code";
                                Commitments."Shortcut Dimension 2 Code":=PayLine."Shortcut Dimension 2 Code";
                                Commitments."Shortcut Dimension 3 Code":=PayLine."Shortcut Dimension 3 Code";
                                Commitments."Shortcut Dimension 4 Code":=PayLine."Shortcut Dimension 4 Code";
                                Commitments.Budget:=BCSetup."Current Budget Code";
                                Commitments.Type:=ImprestHeader."Account Type";
                                Commitments."Vendor/Cust No.":=ImprestHeader."Account No.";
                                Commitments.INSERT;
                                //Tag the Imprest Line as Committed
                                  PayLine.Committed:=TRUE;
                                  PayLine.MODIFY;
                                //End Tagging Imprest Lines as Committed
                            END;
        
                  UNTIL PayLine.NEXT=0;
                END;
          END
        ELSE//budget control not mandatory
          BEGIN
        
          END;
        MESSAGE('Budgetary Checking Completed Successfully');
        */

    end;


    procedure CheckGrantSurr(var GrantHeader: Record "Imprest Surrender Header")
    var
        GrantLine: Record "HR Appraisal Eval Areas";
        Commitments: Record "Transaction Types";
        Amount: Decimal;
        GLAcc: Record "G/L Account";
        Item: Record Item;
        FirstDay: Date;
        LastDay: Date;
        CurrMonth: Integer;
        Budget: Record "Analysis View Budget Entry";
        BudgetAmount: Decimal;
        Actuals: Record "Analysis View Entry";
        ActualsAmount: Decimal;
        CommitmentAmount: Decimal;
        FixedAssetsDet: Record "Fixed Asset";
        FAPostingGRP: Record "FA Posting Group";
        EntryNo: Integer;
    begin
        /*//First Update Analysis View
        UpdateAnalysisView();
        
        //get the budget control setup first to determine if it mandatory or not
        BCSetup.RESET;
        BCSetup.GET();
        IF BCSetup.Mandatory THEN//budgetary control is mandatory
          BEGIN
            //check if the dates are within the specified range in relation to the payment header table
            IF (GrantHeader."Surrender Date"< BCSetup."Current Budget Start Date") THEN
              BEGIN
                ERROR('The Current Date %1 for the Grant Does Not Fall Within Budget Dates %2 - %3',GrantHeader."Surrender Date",
                BCSetup."Current Budget Start Date",BCSetup."Current Budget End Date");
              END
            ELSE IF (GrantHeader."Surrender Date">BCSetup."Current Budget End Date") THEN
              BEGIN
                ERROR('The Current Date %1 for the Grant Does Not Fall Within Budget Dates %2 - %3',GrantHeader."Surrender Date",
                BCSetup."Current Budget Start Date",BCSetup."Current Budget End Date");
        
              END;
            //Is budget Available
            CheckIfBlocked(BCSetup."Current Budget Code");
        
            //Get Commitment Lines
             IF Commitments.FIND('+') THEN
                EntryNo:=Commitments."Line No.";
        
            //get the lines related to the payment header
              GrantLine.RESET;
              GrantLine.SETRANGE(GrantLine."Surrender Doc No.",GrantHeader.No);
              GrantLine.SETRANGE(GrantLine."Budgetary Control A/C",TRUE);
              IF GrantLine.FINDFIRST THEN
                BEGIN
                  REPEAT
                               //check the votebook now
                               FirstDay:=DMY2DATE(1,DATE2DMY(GrantHeader."Surrender Date",2),DATE2DMY(GrantHeader."Surrender Date",3))
        ;
                               CurrMonth:=DATE2DMY(GrantHeader."Surrender Date",2);
                               IF CurrMonth=12 THEN
                                BEGIN
                                  LastDay:=DMY2DATE(1,1,DATE2DMY(GrantHeader."Surrender Date",3) +1);
                                  LastDay:=CALCDATE('-1D',LastDay);
                                END
                               ELSE
                                BEGIN
                                  CurrMonth:=CurrMonth +1;
                                  LastDay:=DMY2DATE(1,CurrMonth,DATE2DMY(GrantHeader."Surrender Date",3));
                                  LastDay:=CALCDATE('-1D',LastDay);
                                END;
        
                               //The GL Account
                                BudgetGL:=GrantLine."Account No:";
        
                               //check the summation of the budget in the database
                               BudgetAmount:=0;
                               Budget.RESET;
                               Budget.SETCURRENTKEY(Budget."Budget Name",Budget."Posting Date",Budget."G/L Account No.",
                               Budget."Dimension 1 Value Code",Budget."Dimension 2 Value Code",Budget."Dimension 3 Value Code",
                               Budget."Dimension 4 Value Code");
                               Budget.SETRANGE(Budget."Budget Name",BCSetup."Current Budget Code");
                               Budget.SETRANGE(Budget."Posting Date",BCSetup."Current Budget Start Date",LastDay);
                               Budget.SETRANGE(Budget."G/L Account No.",BudgetGL);
                               Budget.SETRANGE(Budget."Dimension 1 Value Code",GrantLine."Shortcut Dimension 1 Code");
                               Budget.SETRANGE(Budget."Dimension 2 Value Code",GrantLine."Shortcut Dimension 2 Code");
                               Budget.SETRANGE(Budget."Dimension 3 Value Code",GrantLine."Shortcut Dimension 3 Code");
                               Budget.SETRANGE(Budget."Dimension 4 Value Code",GrantLine."Shortcut Dimension 4 Code");
                                   Budget.CALCSUMS(Budget.Amount);
                                   BudgetAmount:= Budget.Amount;
        
                          //get the summation on the actuals
                            ActualsAmount:=0;
                            Actuals.RESET;
                            Actuals.SETCURRENTKEY(Actuals."Analysis View Code",Actuals."Dimension 1 Value Code",
                            Actuals."Dimension 2 Value Code",Actuals."Dimension 3 Value Code",Actuals."Dimension 4 Value Code",
                            Actuals."Posting Date",Actuals."Account No.");
                            Actuals.SETRANGE(Actuals."Analysis View Code",BCSetup."Analysis View Code");
                            Actuals.SETRANGE(Actuals."Dimension 1 Value Code",GrantLine."Shortcut Dimension 1 Code");
                            Actuals.SETRANGE(Actuals."Dimension 2 Value Code",GrantLine."Shortcut Dimension 2 Code");
                            Actuals.SETRANGE(Actuals."Dimension 3 Value Code",GrantLine."Shortcut Dimension 3 Code");
                            Actuals.SETRANGE(Actuals."Dimension 4 Value Code",GrantLine."Shortcut Dimension 4 Code");
                            Actuals.SETRANGE(Actuals."Posting Date",BCSetup."Current Budget Start Date",LastDay);
                            Actuals.SETRANGE(Actuals."Account No.",BudgetGL);
                               Actuals.CALCSUMS(Actuals.Amount);
                               ActualsAmount:= Actuals.Amount;
        
                          //get the committments
                            CommitmentAmount:=0;
                            Commitments.RESET;
                            Commitments.SETCURRENTKEY(Commitments.Budget,Commitments."G/L Account No.",
                            Commitments."Posting Date",Commitments."Shortcut Dimension 1 Code",Commitments."Shortcut Dimension 2 Code",
                            Commitments."Shortcut Dimension 3 Code",Commitments."Shortcut Dimension 4 Code");
                            Commitments.SETRANGE(Commitments.Budget,BCSetup."Current Budget Code");
                            Commitments.SETRANGE(Commitments."G/L Account No.",BudgetGL);
                            Commitments.SETRANGE(Commitments."Posting Date",BCSetup."Current Budget Start Date",LastDay);
                            Commitments.SETRANGE(Commitments."Shortcut Dimension 1 Code",GrantLine."Shortcut Dimension 1 Code");
                            Commitments.SETRANGE(Commitments."Shortcut Dimension 2 Code",GrantLine."Shortcut Dimension 2 Code");
                            Commitments.SETRANGE(Commitments."Shortcut Dimension 3 Code",GrantLine."Shortcut Dimension 3 Code");
                            Commitments.SETRANGE(Commitments."Shortcut Dimension 4 Code",GrantLine."Shortcut Dimension 4 Code");
                               Commitments.CALCSUMS(Commitments.Amount);
                               CommitmentAmount:= Commitments.Amount;
        
                           //check if there is any budget
                           IF (BudgetAmount<=0) AND NOT (BCSetup."Allow OverExpenditure") THEN  BEGIN
                              ERROR('No Budget To Check Against');
                           END ELSE BEGIN
                            IF (BudgetAmount<=0) THEN BEGIN
                             IF NOT CONFIRM(Text0003,TRUE) THEN BEGIN
                                ERROR('Budgetary Checking Process Aborted');
                             END;
                            END;
                           END;
        
                           //check if the actuals plus the amount is greater then the budget amount
                           IF ((CommitmentAmount + GrantLine."Amount LCY"+ActualsAmount)>BudgetAmount )
                           AND NOT ( BCSetup."Allow OverExpenditure") THEN  BEGIN
                              ERROR('The Amount Voucher No %1  %2 %3  Exceeds The Budget By %4',
                              GrantLine."Surrender Doc No.",'Grant' ,GrantLine."Surrender Doc No.",
                                FORMAT(ABS(BudgetAmount-(CommitmentAmount + GrantLine."Amount LCY"))));
                            END ELSE BEGIN
                            //ADD A CONFIRMATION TO ALLOW USER TO DECIDE WHETHER TO CONTINUE
                                IF ((CommitmentAmount + GrantLine."Amount LCY"+ ActualsAmount)>BudgetAmount) THEN BEGIN
                                    IF NOT CONFIRM(Text0001+
                                    FORMAT(ABS(BudgetAmount-(CommitmentAmount + ActualsAmount+GrantLine."Amount LCY")))
                                    +Text0002,TRUE) THEN BEGIN
                                       ERROR('Budgetary Checking Process Aborted');
                                    END;
                                END;
        
                                Commitments.RESET;
                                Commitments.INIT;
                                EntryNo+=1;
                                Commitments."Line No.":=EntryNo;
                                Commitments.Date:=TODAY;
                                Commitments."Posting Date":=GrantHeader."Surrender Date";
                                Commitments."Document Type":=Commitments."Document Type"::StaffSurrender;
                                Commitments."Document No.":=GrantHeader.No;
                                Commitments.Amount:=GrantLine."Amount LCY";
                                Commitments."Month Budget":=BudgetAmount;
                                Commitments."Month Actual":=ActualsAmount;
                                Commitments.Committed:=TRUE;
                                Commitments."Committed By":=USERID;
                                Commitments."Committed Date":=GrantHeader."Surrender Date";
                                Commitments."G/L Account No.":=BudgetGL;
                                Commitments."Committed Time":=TIME;
                                Commitments."Committed Machine":=ENVIRON('COMPUTERNAME');
                                Commitments."Shortcut Dimension 1 Code":=GrantLine."Shortcut Dimension 1 Code";
                                Commitments."Shortcut Dimension 2 Code":=GrantLine."Shortcut Dimension 2 Code";
                                Commitments."Shortcut Dimension 3 Code":=GrantLine."Shortcut Dimension 3 Code";
                                Commitments."Shortcut Dimension 4 Code":=GrantLine."Shortcut Dimension 4 Code";
                                Commitments.Budget:=BCSetup."Current Budget Code";
                                Commitments.Type:=GrantHeader."Account Type";
                                Commitments."Vendor/Cust No.":=GrantHeader."Account No.";
                                Commitments.INSERT;
                                //Tag the Grant Surrender Line as Committed
                                  GrantLine.Committed:=TRUE;
                                  GrantLine.MODIFY;
                                //End Tagging Grant Surrender Lines as Committed
                            END;
        
                  UNTIL GrantLine.NEXT=0;
                END;
          END
        ELSE//budget control not mandatory
          BEGIN
        
          END;
        MESSAGE('Budgetary Checking Completed Successfully');
        */

    end;
}

