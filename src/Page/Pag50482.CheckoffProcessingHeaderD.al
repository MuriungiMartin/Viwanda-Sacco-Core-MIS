#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50482 "Checkoff Processing Header-D"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Checkoff Header-Distributed";
    SourceTableView = where(Posted = const(false));

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
                    Enabled = false;
                }
                field("Date Entered"; "Date Entered")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Posting date"; "Posting date")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Loan CutOff Date"; "Loan CutOff Date")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Remarks; Remarks)
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Posted By"; "Posted By")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Account Type"; "Account Type")
                {
                    ApplicationArea = Basic;
                }
                field("Account No"; "Account No")
                {
                    ApplicationArea = Basic;
                }
                field("Account Name"; "Account Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Enabled = false;
                }
                field("Employer Name"; "Employer Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Employer Code"; "Employer Code")
                {
                    ApplicationArea = Basic;
                }
                field("Document No"; "Document No")
                {
                    ApplicationArea = Basic;
                    Caption = 'Document No./ Cheque No.';
                    ShowMandatory = true;
                }
                field(Posted; Posted)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field(Amount; Amount)
                {
                    ApplicationArea = Basic;
                }
                field("Total Scheduled"; "Total Scheduled")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                    Importance = Promoted;
                    Style = Strong;
                    StyleExpr = true;
                }
                field("Total Count"; "Total Count")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                    Importance = Promoted;
                    Style = Favorable;
                    StyleExpr = true;
                }
            }
            part("Checkoff Lines-Distributed"; "Checkoff Processing Lines-D")
            {
                Caption = 'Checkoff Lines-Distributed';
                SubPageLink = "Checkoff No" = field(No);
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Clear Lines")
            {
                ApplicationArea = Basic;
                Enabled = ActionEnabled;
                Image = CheckList;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    if Confirm('This Action will clear all the Lines for the current Check off. Do you want to Continue') = false then
                        exit;
                    ReceiptLine.Reset;
                    ReceiptLine.SetRange(ReceiptLine."Checkoff No", No);
                    ReceiptLine.DeleteAll;

                    BATCH_TEMPLATE := 'GENERAL';
                    BATCH_NAME := 'CHECKOFF';
                    DOCUMENT_NO := Remarks;
                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                    GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                    GenJournalLine.DeleteAll;
                end;
            }
            action("Import Checkoff Distributed")
            {
                ApplicationArea = Basic;
                Caption = 'Import Checkoff';
                Enabled = ActionEnabled;
                Image = Import;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                RunObject = XMLport "Import Checkoff Distributed";
            }
            group(ActionGroup1102755021)
            {
            }
            action("Validate Checkoff")
            {
                ApplicationArea = Basic;
                Caption = 'Validate Checkoff';
                Enabled = ActionEnabled;
                Image = ViewCheck;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    TestField("Document No");
                    TestField(Amount);

                    BATCH_TEMPLATE := 'GENERAL';
                    BATCH_NAME := 'CHECKOFF';
                    DOCUMENT_NO := Remarks;
                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                    GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                    GenJournalLine.DeleteAll;

                    MembLedg.Reset;
                    MembLedg.SetRange(MembLedg."Document No.", "Document No");
                    if MembLedg.Find('-') = true then
                        Error('Sorry,You have already posted this Document. Validation not Allowed.');
                    ReceiptLine.Reset;
                    ReceiptLine.SetRange(ReceiptLine."Checkoff No", No);
                    if ReceiptLine.FindSet(true, true) then begin
                        repeat
                            ReceiptLine."Member No" := '';
                            ReceiptLine."Employee Name" := '';
                            ReceiptLine.TOTAL_DISTRIBUTED := 0;
                            ReceiptLine.Modify;
                        until ReceiptLine.Next = 0;
                    end;

                    ReceiptLine.Reset;
                    ReceiptLine.SetRange(ReceiptLine."Checkoff No", No);
                    if ReceiptLine.Find('-') then begin
                        repeat
                            Memb.Reset;
                            Memb.SetRange("Payroll No", ReceiptLine."Payroll No");
                            Memb.SetFilter(Status, '<>%1', Memb.Status::Dormant);
                            if Memb.Find('-') then begin
                                ReceiptLine."Member No" := Memb."No.";
                                ReceiptLine."Employee Name" := Memb.Name;
                                //      ReceiptLine.TOTAL_DISTRIBUTED:=
                                //      ReceiptLine.Deposits+
                                //      ReceiptLine.DL_P+
                                //      ReceiptLine.DL_I+
                                //      ReceiptLine.EL_P+
                                //      ReceiptLine.EL_I+
                                //      ReceiptLine.EMER_P+
                                //      ReceiptLine.EMER_I+
                                //      ReceiptLine.IL_P+
                                //      ReceiptLine.IL_I+
                                //      ReceiptLine.MSL_P+
                                //      ReceiptLine.MSL_I+
                                //      ReceiptLine.INSURANCE+
                                //      ReceiptLine."SILVER SAVINGS"+
                                //      //ReceiptLine.THIRDPARTY+
                                //      ReceiptLine."ID No"+
                                //      ReceiptLine.BENEVOLENT+
                                //      ReceiptLine.SFL_P+
                                //      ReceiptLine.SFL_I+
                                //      ReceiptLine.PHONE_P+
                                //      ReceiptLine.PHONE_I+
                                //      ReceiptLine.SPL_P+
                                //      ReceiptLine.SPL_I+
                                //      ReceiptLine.SSFL_P+
                                //      ReceiptLine.SSFL_I+
                                //      ReceiptLine.SHARES;
                                ReceiptLine.Modify;
                            end;
                        until ReceiptLine.Next = 0;
                    end;
                    Message('Validation was successfully completed');
                end;
            }
            action("Unallocated Funds")
            {
                ApplicationArea = Basic;
                Promoted = true;
                PromotedCategory = "Report";
                Visible = false;

                trigger OnAction()
                begin
                    ReptProcHeader.Reset;
                    ReptProcHeader.SetRange(ReptProcHeader.No, No);
                    if ReptProcHeader.Find('-') then
                        Report.run(50542, true, false, ReptProcHeader);
                end;
            }
            group(ActionGroup1102755019)
            {
            }
            action("Process Checkoff Distributed")
            {
                ApplicationArea = Basic;
                Caption = 'Process Checkoff';
                Enabled = ActionEnabled;
                Image = Apply;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;

                trigger OnAction()
                var
                    LoanProductCode: Code[100];
                begin
                    /*IF CONFIRM('Are you sure you want to Transfer this Checkoff to Journals ?')=TRUE THEN BEGIN
                    TESTFIELD("Document No");
                    TESTFIELD(Amount);
                    IF Amount<>"Total Scheduled" THEN
                      ERROR('Scheduled Amount must be equal to the Cheque Amount');
                    
                    Datefilter:='..'+FORMAT("Posting date");
                    
                    BATCH_TEMPLATE:='GENERAL';
                    BATCH_NAME:='CHECKOFF';
                    DOCUMENT_NO:=Remarks;
                    Counter:=0;
                    Percentage:=0;
                    TotalCount:=0;
                    
                    GenJournalLine.RESET;
                    GenJournalLine.SETRANGE("Journal Template Name",BATCH_TEMPLATE);
                    GenJournalLine.SETRANGE("Journal Batch Name",BATCH_NAME);
                    GenJournalLine.DELETEALL;
                    LineNo:=0;
                    ReceiptLine.RESET;
                    ReceiptLine.SETRANGE("Checkoff No",No);
                    //ReceiptLine.SETRANGE("Member No",'01845');
                    
                    IF ReceiptLine.FIND('-') THEN BEGIN
                      Window.OPEN('@1@');
                      TotalCount:=ReceiptLine.COUNT;
                      REPEAT
                       //////Get Savings Account
                       MembersR.RESET;
                       MembersR.SETRANGE("No.",ReceiptLine."Member No");
                      IF MembersR.FIND('-') THEN
                      Savaccount:=MembersR."FOSA Account No.";
                      //MESSAGE('Savings Account %1',Savaccount);
                      //////End Get Savings Account
                        FnUpdateProgressBar();
                    
                        IF ReceiptLine."Member No"<>'' THEN BEGIN
                        //----------------------------1. DEPOSITS----------------------------------------------------------------
                        LineNo:=LineNo+10000;
                    //    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE,BATCH_NAME,DOCUMENT_NO,LineNo,GenJournalLine."Transaction Type"::"Deposit Contribution",
                    //    GenJournalLine."Account Type"::Member,ReceiptLine."Member No","Posting date",ReceiptLine.Deposits* -1,'BOSA',"Document No",
                    //    FORMAT(GenJournalLine."Transaction Type"::"Deposit Contribution"),'');
                    
                        //------------------SUPER LOAN_P ----------------------------------------------------
                    //    IF FnCheckLoanErrors('SUPER LOAN',ReceiptLine.SSFL_P,ReceiptLine."Member No") THEN BEGIN
                    //        LineNo:=LineNo+10000;
                    //        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE,BATCH_NAME,DOCUMENT_NO,LineNo,GenJournalLine."Transaction Type"::" ",
                    //        GenJournalLine."Account Type"::Vendor,Savaccount,"Posting date",(ReceiptLine.SSFL_P+ReceiptLine.SSFL_I)*-1,'BOSA',"Document No",
                    //        'Checkoff-Missing Loan-SUPER','');
                        END ELSE
                        BEGIN
                        LineNo:=LineNo+10000;
                    //    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE,BATCH_NAME,DOCUMENT_NO,LineNo,GenJournalLine."Transaction Type"::"Loan Repayment",
                    //    GenJournalLine."Account Type"::Member,ReceiptLine."Member No","Posting date",ReceiptLine.SSFL_P*-1,'BOSA',"Document No",
                    //    FORMAT(GenJournalLine."Transaction Type"::"Loan Repayment"),FnGetLoanNumber(ReceiptLine."Member No",'SUPER LOAN'));
                        //----------------------------5.SUPER_I------------------------------------------------------------------
                    //    LineNo:=LineNo+10000;
                    //    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE,BATCH_NAME,DOCUMENT_NO,LineNo,GenJournalLine."Transaction Type"::"Interest Paid",
                    //    GenJournalLine."Account Type"::Member,ReceiptLine."Member No","Posting date",ReceiptLine.SSFL_I*-1,'BOSA',"Document No",
                    //    FORMAT(GenJournalLine."Transaction Type"::"Interest Paid"),FnGetLoanNumber(ReceiptLine."Member No",'SUPER LOAN'));
                        END;
                        //END  SUPERLOAN RECOVERY
                        //NOTE: Normal & Normal Top up cannot exist together.
                        //----------------------------2. NORM_P------------------------------------------------------------------
                    //    IF FnCheckLoanErrorsN('NORM|NRM TOPUP',ReceiptLine.DL_P,ReceiptLine.DL_I,ReceiptLine."Member No") THEN BEGIN
                    //        LineNo:=LineNo+10000;
                    //        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE,BATCH_NAME,DOCUMENT_NO,LineNo,GenJournalLine."Transaction Type"::" ",
                    //        GenJournalLine."Account Type"::Vendor,Savaccount,"Posting date",(ReceiptLine.DL_P+ReceiptLine.DL_I)*-1,'BOSA',"Document No",
                    //        'Checkoff-Missing Loan-NORM','');
                    //    END ELSE
                        BEGIN
                        LoanProductCode:=FnReturnNormaOrTopupCode('NORM|NRM TOPUP',ReceiptLine.DL_P,ReceiptLine.DL_I,ReceiptLine."Member No");
                        LineNo:=LineNo+10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE,BATCH_NAME,DOCUMENT_NO,LineNo,GenJournalLine."Transaction Type"::"Loan Repayment",
                        GenJournalLine."Account Type"::Member,ReceiptLine."Member No","Posting date",ReceiptLine.DL_P*-1,'BOSA',"Document No",
                        FORMAT(GenJournalLine."Transaction Type"::"Loan Repayment"),FnGetLoanNumber(ReceiptLine."Member No",LoanProductCode));
                        //----------------------------3. NORM_I------------------------------------------------------------------
                        LineNo:=LineNo+10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE,BATCH_NAME,DOCUMENT_NO,LineNo,GenJournalLine."Transaction Type"::"Interest Paid",
                        GenJournalLine."Account Type"::Member,ReceiptLine."Member No","Posting date",ReceiptLine.DL_I*-1,'BOSA',"Document No",
                        FORMAT(GenJournalLine."Transaction Type"::"Interest Paid"),FnGetLoanNumber(ReceiptLine."Member No",LoanProductCode));
                        END;
                    
                        //----------------------------4. REFIN_P------------------------------------------------------------------
                        IF FnCheckLoanErrors('REFIN',ReceiptLine.EL_P,ReceiptLine."Member No") THEN BEGIN
                            LineNo:=LineNo+10000;
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE,BATCH_NAME,DOCUMENT_NO,LineNo,GenJournalLine."Transaction Type"::" ",
                            GenJournalLine."Account Type"::Vendor,Savaccount,"Posting date",(ReceiptLine.EL_P+ReceiptLine.EL_I)*-1,'BOSA',"Document No",
                            'Checkoff-Missing Loan-REFIN','');
                        END ELSE
                        BEGIN
                        LineNo:=LineNo+10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE,BATCH_NAME,DOCUMENT_NO,LineNo,GenJournalLine."Transaction Type"::"Loan Repayment",
                        GenJournalLine."Account Type"::Member,ReceiptLine."Member No","Posting date",ReceiptLine.EL_P*-1,'BOSA',"Document No",
                        FORMAT(GenJournalLine."Transaction Type"::"Loan Repayment"),FnGetLoanNumber(ReceiptLine."Member No",'REFIN'));
                        //----------------------------5. REFIN_I------------------------------------------------------------------
                        LineNo:=LineNo+10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE,BATCH_NAME,DOCUMENT_NO,LineNo,GenJournalLine."Transaction Type"::"Interest Paid",
                        GenJournalLine."Account Type"::Member,ReceiptLine."Member No","Posting date",ReceiptLine.EL_I*-1,'BOSA',"Document No",
                        FORMAT(GenJournalLine."Transaction Type"::"Interest Paid"),FnGetLoanNumber(ReceiptLine."Member No",'REFIN'));
                        END;
                    
                    
                        //----------------------------6. EMER_P------------------------------------------------------------------
                         IF FnCheckLoanErrors('EMER',ReceiptLine.EMER_P,ReceiptLine."Member No") THEN BEGIN
                            LineNo:=LineNo+10000;
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE,BATCH_NAME,DOCUMENT_NO,LineNo,GenJournalLine."Transaction Type"::" ",
                            GenJournalLine."Account Type"::Vendor,Savaccount,"Posting date",(ReceiptLine.EMER_P+ReceiptLine.EMER_I)*-1,'BOSA',"Document No",
                            'Checkoff-Missing Loan-EMER','');
                        END ELSE
                        BEGIN
                            LineNo:=LineNo+10000;
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE,BATCH_NAME,DOCUMENT_NO,LineNo,GenJournalLine."Transaction Type"::"Loan Repayment",
                            GenJournalLine."Account Type"::Member,ReceiptLine."Member No","Posting date",ReceiptLine.EMER_P*-1,'BOSA',"Document No",
                            FORMAT(GenJournalLine."Transaction Type"::"Loan Repayment"),FnGetLoanNumber(ReceiptLine."Member No",'EMER'));
                            //----------------------------7. EMER_I------------------------------------------------------------------
                            LineNo:=LineNo+10000;
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE,BATCH_NAME,DOCUMENT_NO,LineNo,GenJournalLine."Transaction Type"::"Interest Paid",
                            GenJournalLine."Account Type"::Member,ReceiptLine."Member No","Posting date",ReceiptLine.EMER_I*-1,'BOSA',"Document No",
                            FORMAT(GenJournalLine."Transaction Type"::"Interest Paid"),FnGetLoanNumber(ReceiptLine."Member No",'EMER'));
                        END;
                    
                    
                        //----------------------------8. SCHOOL_P------------------------------------------------------------------
                         IF FnCheckLoanErrors('SCH LOAN',ReceiptLine.IL_P,ReceiptLine."Member No") THEN BEGIN
                            LineNo:=LineNo+10000;
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE,BATCH_NAME,DOCUMENT_NO,LineNo,GenJournalLine."Transaction Type"::" ",
                            GenJournalLine."Account Type"::Vendor,Savaccount,"Posting date",(ReceiptLine.IL_P+ReceiptLine.IL_I)*-1,'BOSA',"Document No",
                            'Checkoff-Missing Loan-SCHOOL','');
                        END ELSE
                        BEGIN
                        LineNo:=LineNo+10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE,BATCH_NAME,DOCUMENT_NO,LineNo,GenJournalLine."Transaction Type"::"Loan Repayment",
                        GenJournalLine."Account Type"::Member,ReceiptLine."Member No","Posting date",ReceiptLine.IL_P*-1,'BOSA',"Document No",
                        FORMAT(GenJournalLine."Transaction Type"::"Loan Repayment"),FnGetLoanNumber(ReceiptLine."Member No",'SCH LOAN'));
                        //----------------------------9. SCHOOL_I------------------------------------------------------------------
                        LineNo:=LineNo+10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE,BATCH_NAME,DOCUMENT_NO,LineNo,GenJournalLine."Transaction Type"::"Interest Paid",
                        GenJournalLine."Account Type"::Member,ReceiptLine."Member No","Posting date",ReceiptLine.IL_I*-1,'BOSA',"Document No",
                        FORMAT(GenJournalLine."Transaction Type"::"Interest Paid"),FnGetLoanNumber(ReceiptLine."Member No",'SCH LOAN'));
                        END;
                    
                    
                        //----------------------------10. SPECIAL_P------------------------------------------------------------------
                         IF FnCheckLoanErrors('SP',ReceiptLine.MSL_P,ReceiptLine."Member No") THEN BEGIN
                            LineNo:=LineNo+10000;
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE,BATCH_NAME,DOCUMENT_NO,LineNo,GenJournalLine."Transaction Type"::" ",
                            GenJournalLine."Account Type"::Vendor,Savaccount,"Posting date",(ReceiptLine.MSL_P+ReceiptLine.MSL_I)*-1,'BOSA',"Document No",
                            'Checkoff-Missing Loan-SPECIAL','');
                        END ELSE
                        BEGIN
                          FnCheckLoanErrors('SP',ReceiptLine.MSL_P,ReceiptLine."Member No");
                          LineNo:=LineNo+10000;
                          SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE,BATCH_NAME,DOCUMENT_NO,LineNo,GenJournalLine."Transaction Type"::"Loan Repayment",
                          GenJournalLine."Account Type"::Member,ReceiptLine."Member No","Posting date",ReceiptLine.MSL_P*-1,'BOSA',"Document No",
                          FORMAT(GenJournalLine."Transaction Type"::"Loan Repayment"),FnGetLoanNumber(ReceiptLine."Member No",'SP'));
                          //----------------------------11. SPECIAL_I------------------------------------------------------------------
                          LineNo:=LineNo+10000;
                          SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE,BATCH_NAME,DOCUMENT_NO,LineNo,GenJournalLine."Transaction Type"::"Interest Paid",
                          GenJournalLine."Account Type"::Member,ReceiptLine."Member No","Posting date",ReceiptLine.MSL_I*-1,'BOSA',"Document No",
                          FORMAT(GenJournalLine."Transaction Type"::"Interest Paid"),FnGetLoanNumber(ReceiptLine."Member No",'SP'));
                        END;
                    
                    
                        //----------------------------12.INSURANCE-------------------------------------------------------------------
                    
                        LineNo:=LineNo+10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE,BATCH_NAME,DOCUMENT_NO,LineNo,GenJournalLine."Transaction Type"::"Insurance Contribution",
                        GenJournalLine."Account Type"::Member,ReceiptLine."Member No","Posting date",ReceiptLine.INSURANCE* -1,'BOSA',"Document No",
                        FORMAT(GenJournalLine."Transaction Type"::"Insurance Contribution"),'');
                    
                        //----------------------------13.GOLDSAVE-------------------------------------------------------------------
                        IF(FnCheckGoldSaveErrors(ReceiptLine."SILVER SAVINGS",ReceiptLine."Member No") ) THEN
                        MESSAGE('Missing GoldSave Account for '+ReceiptLine."Member No"+'. Consult systems administrator.');
                        LineNo:=LineNo+10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE,BATCH_NAME,DOCUMENT_NO,LineNo,GenJournalLine."Transaction Type"::" ",
                        GenJournalLine."Account Type"::Vendor,FnGetFosaAccountNo(ReceiptLine."Member No",'GOLDSAVE'),"Posting date",ReceiptLine."SILVER SAVINGS"*-1,'BOSA',"Document No",
                        'Gold Save','');
                    
                        //----------------------------15.THIRDPARTY(GUR) Loan------------------------------------------------------------------
                        RunBal:=0;
                        RunBal:=ReceiptLine.THIRDPARTY+ReceiptLine."ID No";
                        RunBal:=FnRunInterest(ReceiptLine,RunBal);
                        RunBal:=FnRunPrinciple(ReceiptLine,RunBal);
                        LineNo:=LineNo+10000;
                        FnRunPrincipleExcessThirdParty(ReceiptLine,RunBal);
                        //Engineer Mweene Added
                       // LineNo:=LineNo+10000;
                        IF FnCheckLoanErrorsGUR('GUR',ReceiptLine.THIRDPARTY,ReceiptLine."Member No") THEN BEGIN
                          LineNo:=LineNo+10000;
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE,BATCH_NAME,DOCUMENT_NO,LineNo,GenJournalLine."Transaction Type"::"Deposit Contribution",
                            GenJournalLine."Account Type"::Member,ReceiptLine."Member No","Posting date",(ReceiptLine.THIRDPARTY+ReceiptLine."ID No")*-1,'BOSA',"Document No",
                            FORMAT(GenJournalLine."Transaction Type"::"Deposit Contribution"),'');
                            END;
                    
                      //FnRunPrincipleExcessThirdParty(ReceiptLine,RunBal);
                    
                        //---------------------------16.BENEVOLENT------------------------------------------------------------------
                        LineNo:=LineNo+10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE,BATCH_NAME,DOCUMENT_NO,LineNo,GenJournalLine."Transaction Type"::"Benevolent Fund",
                        GenJournalLine."Account Type"::Member,ReceiptLine."Member No","Posting date",ReceiptLine.BENEVOLENT* -1,'BOSA',"Document No",
                        FORMAT(GenJournalLine."Transaction Type"::"Benevolent Fund"),'');
                    
                    
                        //----------------------------17.ADVANCE_P------------------------------------------------------------------
                         IF FnCheckLoanErrors('SAL ADV',ReceiptLine.SFL_P,ReceiptLine."Member No") THEN BEGIN
                            LineNo:=LineNo+10000;
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE,BATCH_NAME,DOCUMENT_NO,LineNo,GenJournalLine."Transaction Type"::" ",
                            GenJournalLine."Account Type"::Member,Savaccount,"Posting date",(ReceiptLine.SFL_P+ReceiptLine.SFL_I)*-1,'BOSA',"Document No",
                            'ATM TRANS','');
                        END ELSE
                        BEGIN
                          LineNo:=LineNo+10000;
                          SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE,BATCH_NAME,DOCUMENT_NO,LineNo,GenJournalLine."Transaction Type"::"Loan Repayment",
                          GenJournalLine."Account Type"::Member,ReceiptLine."Member No","Posting date",ReceiptLine.SFL_P*-1,'BOSA',"Document No",
                          FORMAT(GenJournalLine."Transaction Type"::"Loan Repayment"),FnGetLoanNumber(ReceiptLine."Member No",'SAL ADV'));
                          //----------------------------18.ADVANCE_I------------------------------------------------------------------
                          LineNo:=LineNo+10000;
                          SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE,BATCH_NAME,DOCUMENT_NO,LineNo,GenJournalLine."Transaction Type"::"Interest Paid",
                          GenJournalLine."Account Type"::Member,ReceiptLine."Member No","Posting date",ReceiptLine.SFL_I*-1,'BOSA',"Document No",
                          FORMAT(GenJournalLine."Transaction Type"::"Interest Paid"),FnGetLoanNumber(ReceiptLine."Member No",'SAL ADV'));
                        END;
                        //17.PHONE_P
                        //18.PHONE_I
                    
                        //----------------------------19.ADVANCENSE_P------------------------------------------------------------------
                         IF FnCheckLoanErrors('NSE',ReceiptLine.SPL_P,ReceiptLine."Member No") THEN BEGIN
                            LineNo:=LineNo+10000;
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE,BATCH_NAME,DOCUMENT_NO,LineNo,GenJournalLine."Transaction Type"::" ",
                            GenJournalLine."Account Type"::Member,Savaccount,"Posting date",(ReceiptLine.SPL_P+ReceiptLine.SPL_I)*-1,'BOSA',"Document No",
                            'ATM TRANS','');
                        END ELSE
                        BEGIN
                            LineNo:=LineNo+10000;
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE,BATCH_NAME,DOCUMENT_NO,LineNo,GenJournalLine."Transaction Type"::"Loan Repayment",
                            GenJournalLine."Account Type"::Member,ReceiptLine."Member No","Posting date",ReceiptLine.SPL_P*-1,'BOSA',"Document No",
                            FORMAT(GenJournalLine."Transaction Type"::"Loan Repayment"),FnGetLoanNumber(ReceiptLine."Member No",'NSE'));
                    
                            //----------------------------20.ADVANCENSE_I------------------------------------------------------------------
                            LineNo:=LineNo+10000;
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE,BATCH_NAME,DOCUMENT_NO,LineNo,GenJournalLine."Transaction Type"::"Interest Paid",
                            GenJournalLine."Account Type"::Member,ReceiptLine."Member No","Posting date",ReceiptLine.SPL_I*-1,'BOSA',"Document No",
                            FORMAT(GenJournalLine."Transaction Type"::"Interest Paid"),FnGetLoanNumber(ReceiptLine."Member No",'NSE'));
                        END;
                        //-----------------------------21.SHARES--------------------------------------------------------------------
                        LineNo:=LineNo+10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE,BATCH_NAME,DOCUMENT_NO,LineNo,GenJournalLine."Transaction Type"::"Share Capital",
                        GenJournalLine."Account Type"::Member,ReceiptLine."Member No","Posting date",ReceiptLine.SHARES* -1,'BOSA',"Document No",
                        FORMAT(GenJournalLine."Transaction Type"::"Share Capital"),'');
                        END;
                      UNTIL ReceiptLine.NEXT=0;
                    END;
                       //Balancing Journal Entry
                        LineNo:=LineNo+10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE,BATCH_NAME,DOCUMENT_NO,LineNo,GenJournalLine."Transaction Type"::" ",
                        "Account Type","Account No","Posting date",Amount,'BOSA',"Document No",
                        Remarks,'');
                    
                    Window.CLOSE;
                    MESSAGE('Checkoff successfully Generated Jouranls ready for posting');
                    END;
                    */

                end;
            }
            action("Process Checkoff Unallocated")
            {
                ApplicationArea = Basic;
                Visible = false;

                trigger OnAction()
                begin
                    MembLedg.Reset;
                    MembLedg.SetRange(MembLedg."Document No.", Remarks);
                    if MembLedg.Find('-') = false then begin
                        Error('You Can Only do this process on Already Posted Checkoffs')
                    end;
                    ReceiptLine.Reset;
                    //ReceiptLine.SETRANGE(ReceiptLine."Receipt Header No",No);
                    //IF ReceiptLine.FIND('-') THEN
                    //Report.run(50543,TRUE,FALSE,ReceiptLine);
                end;
            }
            action("Process Annual Charge")
            {
                ApplicationArea = Basic;
                Image = AuthorizeCreditCard;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                begin
                    TestField("Document No");
                    TestField(Amount);
                    ReceiptLine.Reset;
                    //ReceiptLine.SETRANGE(ReceiptLine."Receipt Header No",No);
                    //IF ReceiptLine.FIND('-') THEN
                    //REPORT.RUN(50100,TRUE,FALSE,ReceiptLine);
                end;
            }
            action("Mark as Posted")
            {
                ApplicationArea = Basic;
                Enabled = not ActionEnabled;
                Image = PostBatch;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to mark this Checkoff as Posted ?', false) = true then begin
                        MembLedg.Reset;
                        MembLedg.SetRange(MembLedg."Document No.", Remarks);
                        if MembLedg.Find('-') = false then
                            Error('Sorry,You can only do this process on already posted Checkoffs');
                        Posted := true;
                        "Posted By" := UserId;
                        "Posting date" := Today;
                        Modify;
                        if "Employer Code" = 'NCPB' then begin
                            Gensetup.Get;
                            //Gensetup."Checkoff Date":="Posting date";
                            Gensetup.Modify;
                        end;
                    end;
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

    trigger OnAfterGetCurrRecord()
    begin
        ActionEnabled := true;
        MembLedg.Reset;
        MembLedg.SetRange(MembLedg."Document No.", Remarks);
        MembLedg.SetRange(MembLedg."External Document No.", "Document No");
        if MembLedg.Find('-') then begin
            ActionEnabled := false;
        end;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        "Posting date" := Today;
        "Date Entered" := Today;

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
        MembPostGroup: Record "Customer Posting Group";
        Loantable: Record "Loans Register";
        LRepayment: Decimal;
        RcptBufLines: Record "Checkoff Lines-Distributed";
        LoanType: Record "Loan Products Setup";
        LoanApp: Record "Loans Register";
        Interest: Decimal;
        LineN: Integer;
        TotalRepay: Decimal;
        MultipleLoan: Integer;
        LType: Text;
        MonthlyAmount: Decimal;
        ShRec: Decimal;
        SHARESCAP: Decimal;
        DIFF: Decimal;
        DIFFPAID: Decimal;
        genstup: Record "Sacco General Set-Up";
        Memb: Record Customer;
        INSURANCE: Decimal;
        GenBatches: Record "Gen. Journal Batch";
        Datefilter: Text[50];
        ReceiptLine: Record "Checkoff Lines-Distributed";
        MembLedg: Record "Member Ledger Entry";
        SFactory: Codeunit "SURESTEP Factory";
        BATCH_NAME: Code[50];
        BATCH_TEMPLATE: Code[50];
        DOCUMENT_NO: Code[40];
        GenJournalLine: Record "Gen. Journal Line";
        ActionEnabled: Boolean;
        XMLCheckOff: XmlPort "Import Checkoff Distributed";
        Window: Dialog;
        TotalCount: Integer;
        Counter: Integer;
        Percentage: Integer;
        Gensetup: Record "General Ledger Setup";
        MembersR: Record Customer;
        Savaccount: Code[20];

    local procedure FnGetLoanNumber(MemberNo: Code[40]; "Loan Product Code": Code[100]): Code[100]
    var
        ObjLoans: Record "Loans Register";
    begin
        ObjLoans.CalcFields("Outstanding Balance");
        ObjLoans.Reset;
        ObjLoans.SetRange("Client Code", MemberNo);
        ObjLoans.SetRange("Loan Product Type", "Loan Product Code");
        ObjLoans.SetFilter(Posted, 'Yes');
        ObjLoans.SetFilter(ObjLoans."Outstanding Balance", '>0');
        if ObjLoans.FindFirst then
            exit(ObjLoans."Loan  No.");
    end;

    local procedure FnGetFosaAccountNo(BosaAccountNo: Code[40]; "Product Code": Code[100]): Code[100]
    var
        ObjVendor: Record Vendor;
    begin
        ObjVendor.Reset;
        ObjVendor.SetRange("BOSA Account No", BosaAccountNo);
        ObjVendor.SetRange("Account Type", "Product Code");
        if ObjVendor.Find('-') then
            exit(ObjVendor."No.");
    end;

    local procedure FnCheckLoanErrors(LoanProduct: Code[100]; Amount: Decimal; MemberNo: Code[40]) IsInvalidLoan: Boolean
    var
        ObjLoans: Record "Loans Register";
    begin
        if Amount > 0 then begin
            IsInvalidLoan := true;
            ObjLoans.Reset;
            ObjLoans.SetRange("Client Code", MemberNo);
            ObjLoans.SetRange("Loan Product Type", LoanProduct);
            ObjLoans.SetFilter("Date filter", Datefilter);
            ObjLoans.SetFilter(Posted, 'Yes');
            ObjLoans.SetFilter(ObjLoans."Outstanding Balance", '>0');
            //ObjLoans.SETFILTER(ObjLoans."Loan Product Type",'<>%1','GUR');
            if ObjLoans.FindFirst then begin
                IsInvalidLoan := false;
            end
        end;
        exit(IsInvalidLoan);
    end;

    local procedure FnRunPrinciple(ObjRcptBuffer: Record "Checkoff Lines-Distributed"; RunningBalance: Decimal): Decimal
    var
        AmountToDeduct: Decimal;
        ObjReceiptTransactions: Record "Receipt Allocation";
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayment: Decimal;
        PRpayment: Decimal;
        ReceiptLine: Record "Checkoff Lines-Distributed";
    begin
        LoanApp.CalcFields(LoanApp."Outstanding Balance");
        if RunningBalance > 0 then begin
            varTotalRepay := 0;
            varMultipleLoan := 0;
            LoanApp.Reset;
            LoanApp.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
            LoanApp.SetRange(LoanApp."Client Code", ObjRcptBuffer."Member No");
            LoanApp.SetFilter(LoanApp."Date filter", Datefilter);
            LoanApp.SetFilter(LoanApp."Loan Product Type", 'GUR');
            LoanApp.SetFilter(LoanApp."Outstanding Balance", '>0');
            LoanApp.SetFilter(Posted, 'Yes');

            if LoanApp.Find('-') then begin
                repeat
                    if RunningBalance > 0 then begin
                        LoanApp.CalcFields(LoanApp."Outstanding Balance");
                        if LoanApp."Outstanding Balance" > 0 then begin
                            /*18/02/2020
                            varLRepayment:=0;
                            PRpayment:=0;
                            IF LoanApp."Loan Interest Repayment"> 0 THEN
                            varLRepayment:=ROUND(LoanApp."Loan Principle Repayment",1,'>')
                             ELSE varLRepayment:=ROUND(LoanApp."Loan Repayment",1,'>');
                             */
                            varLRepayment := 0;
                            PRpayment := 0;
                            varLRepayment := ROUND(LoanApp."Loan Principle Repayment", 1, '>');
                            if varLRepayment > 0 then begin
                                if varLRepayment > LoanApp."Outstanding Balance" then
                                    varLRepayment := LoanApp."Outstanding Balance";

                                if RunningBalance > 0 then
                                    AmountToDeduct := RunningBalance;

                                begin
                                    if RunningBalance > varLRepayment then begin
                                        AmountToDeduct := varLRepayment;
                                    end
                                    else
                                        AmountToDeduct := RunningBalance;
                                end;

                                LineNo := LineNo + 10000;
                                //                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE,BATCH_NAME,DOCUMENT_NO,LineNo,GenJournalLine."Transaction Type"::"Loan Repayment",
                                //                    GenJournalLine."Account Type"::Member,LoanApp."Client Code","Posting date",AmountToDeduct*-1,FORMAT(LoanApp.Source),"Document No",
                                //                    FORMAT(GenJournalLine."Transaction Type"::"Loan Repayment"),LoanApp."Loan  No.",,'');
                                RunningBalance := RunningBalance - AmountToDeduct;
                            end;
                        end;
                    end;


                until LoanApp.Next = 0;
            end;
            exit(RunningBalance);
        end;

    end;

    local procedure FnRunPrincipleExcessThirdParty(ObjRcptBuffer: Record "Checkoff Lines-Distributed"; RunningBalance: Decimal)
    var
        AmountToDeduct: Decimal;
        ObjReceiptTransactions: Record "Receipt Allocation";
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayment: Decimal;
        PRpayment: Decimal;
        ReceiptLine: Record "Checkoff Lines-Distributed";
    begin
        LoanApp.CalcFields(LoanApp."Outstanding Balance");
        if RunningBalance > 0 then begin
            varTotalRepay := 0;
            varMultipleLoan := 0;
            LoanApp.Reset;
            LoanApp.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
            LoanApp.SetRange(LoanApp."Client Code", ObjRcptBuffer."Member No");
            LoanApp.SetFilter(LoanApp."Date filter", Datefilter);
            LoanApp.SetFilter(LoanApp."Loan Product Type", 'GUR');
            LoanApp.SetFilter(LoanApp."Outstanding Balance", '>0');
            LoanApp.SetFilter(Posted, 'Yes');
            if LoanApp.FindFirst then begin
                //IF LoanApp.FIND('-') THEN BEGIN
                //  SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE,BATCH_NAME,DOCUMENT_NO,LineNo,GenJournalLine."Transaction Type"::"Loan Repayment",
                //    GenJournalLine."Account Type"::Member,LoanApp."Client Code","Posting date",RunningBalance*-1,FORMAT(LoanApp.Source),"Document No",
                //    FORMAT(GenJournalLine."Transaction Type"::"Loan Repayment"),LoanApp."Loan  No.");


            end else begin
                //  SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE,BATCH_NAME,DOCUMENT_NO,LineNo,GenJournalLine."Transaction Type"::"Deposit Contribution",
                //    GenJournalLine."Account Type"::Member,ReceiptLine."Member No","Posting date",(ReceiptLine.THIRDPARTY)* -1,'BOSA',"Document No",
                //    FORMAT(GenJournalLine."Transaction Type"::"Deposit Contribution"),'');





                // // FRED start
                // IF FnCheckLoanErrors('GUR',ReceiptLine.THIRDPARTY,ReceiptLine."Member No") THEN BEGIN
                //        LineNo:=LineNo+10000;
                //        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE,BATCH_NAME,DOCUMENT_NO,LineNo,GenJournalLine."Transaction Type"::"Deposit Contribution",
                //        GenJournalLine."Account Type"::Member,ReceiptLine."Member No","Posting date",(ReceiptLine.THIRDPARTY)*-1,'BOSA',"Document No",
                //        FORMAT(GenJournalLine."Transaction Type"::"Deposit Contribution"),'');
                //    END ELSE
                //    BEGIN
                //        LineNo:=LineNo+10000;
                //       SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE,BATCH_NAME,DOCUMENT_NO,LineNo,GenJournalLine."Transaction Type"::"Loan Repayment",
                //       GenJournalLine."Account Type"::Member,LoanApp."Client Code","Posting date",RunningBalance*-1,FORMAT(LoanApp.Source),"Document No",
                //       FORMAT(GenJournalLine."Transaction Type"::"Loan Repayment"),LoanApp."Loan  No.");
                //        //SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE,BATCH_NAME,DOCUMENT_NO,LineNo,GenJournalLine."Transaction Type"::"Loan Repayment",
                //        //GenJournalLine."Account Type"::Member,ReceiptLine."Member No","Posting date",ReceiptLine.THIRDPARTY*-1,'BOSA',"Document No",
                //        //FORMAT(GenJournalLine."Transaction Type"::"Loan Repayment"),FnGetLoanNumber(ReceiptLine."Member No",'GUR'));
                //
                // END;
                //Fred end
            end;
        end;
    end;

    local procedure FnInitiateProgressBar()
    begin
    end;

    local procedure FnUpdateProgressBar()
    begin
        Percentage := (ROUND(Counter / TotalCount * 10000, 1));
        Counter := Counter + 1;
        Window.Update(1, Percentage);
    end;

    local procedure FnCheckLoanErrorsN(LoanProduct: Code[100]; Amount: Decimal; Amount_int: Decimal; MemberNo: Code[40]) IsInvalidLoan: Boolean
    var
        ObjLoans: Record "Loans Register";
    begin
        if ((Amount > 0) or (Amount_int > 0)) then begin
            IsInvalidLoan := true;
            ObjLoans.Reset;
            ObjLoans.SetRange("Client Code", MemberNo);
            ObjLoans.SetFilter("Loan Product Type", LoanProduct);
            ObjLoans.SetFilter("Date filter", Datefilter);
            ObjLoans.SetFilter(Posted, 'Yes');
            ObjLoans.SetFilter(ObjLoans."Outstanding Balance", '>0');
            if ObjLoans.FindFirst then begin
                IsInvalidLoan := false;
            end
        end;
        exit(IsInvalidLoan);
    end;

    local procedure FnReturnNormaOrTopupCode(LoanProduct: Code[100]; Amount: Decimal; Amount_int: Decimal; MemberNo: Code[40]) LoanCode: Code[100]
    var
        ObjLoans: Record "Loans Register";
    begin
        if ((Amount > 0) or (Amount_int > 0)) then begin
            LoanCode := '';
            ObjLoans.Reset;
            ObjLoans.SetRange("Client Code", MemberNo);
            ObjLoans.SetFilter("Loan Product Type", LoanProduct);
            ObjLoans.SetFilter("Date filter", Datefilter);
            ObjLoans.SetFilter(Posted, 'Yes');
            ObjLoans.SetFilter(ObjLoans."Outstanding Balance", '>0');
            if ObjLoans.FindFirst then begin
                LoanCode := ObjLoans."Loan Product Type";
            end
        end;
        exit(LoanCode);
    end;

    local procedure FnCheckGoldSaveErrors(Amount: Decimal; MemberNo: Code[40]) IsInvalidAccount: Boolean
    var
        ObjVendor: Record Vendor;
    begin
        if Amount > 0 then begin
            IsInvalidAccount := true;
            ObjVendor.Reset;
            ObjVendor.SetRange("BOSA Account No", MemberNo);
            ObjVendor.SetRange("Account Type", 'GOLDSAVE');
            if ObjVendor.Find('-') then
                IsInvalidAccount := false;
            exit(IsInvalidAccount);
        end;
    end;

    local procedure FnCheckLoanErrorsGUR(LoanProduct: Code[100]; Amount: Decimal; MemberNo: Code[40]) IsInvalidLoan: Boolean
    var
        ObjLoans: Record "Loans Register";
    begin
        if Amount > 0 then begin
            IsInvalidLoan := true;
            ObjLoans.Reset;
            ObjLoans.SetRange("Client Code", MemberNo);
            ObjLoans.SetRange("Loan Product Type", LoanProduct);
            ObjLoans.SetFilter("Date filter", Datefilter);
            ObjLoans.SetFilter(Posted, 'Yes');
            ObjLoans.SetFilter(ObjLoans."Outstanding Balance", '>0');
            //ObjLoans.SETFILTER(ObjLoans."Loan Product Type",'<>%1','GUR');
            //IF ObjLoans.FINDFIRST THEN BEGIN
            if ObjLoans.Find('-') then begin
                IsInvalidLoan := false;
            end
        end;
        exit(IsInvalidLoan);
    end;

    local procedure FnRunInterest(ObjRcptBuffer: Record "Checkoff Lines-Distributed"; RunningBalance: Decimal): Decimal
    var
        AmountToDeduct: Decimal;
        ObjReceiptTransactions: Record "Receipt Allocation";
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayment: Decimal;
        PRpayment: Decimal;
        ReceiptLine: Record "Checkoff Lines-Distributed";
    begin
        LoanApp.CalcFields(LoanApp."Outstanding Balance");
        if RunningBalance > 0 then begin
            varTotalRepay := 0;
            varMultipleLoan := 0;
            LoanApp.Reset;
            LoanApp.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
            LoanApp.SetRange(LoanApp."Client Code", ObjRcptBuffer."Member No");
            LoanApp.SetFilter(LoanApp."Date filter", Datefilter);
            LoanApp.SetFilter(LoanApp."Loan Product Type", 'GUR');
            LoanApp.SetFilter(LoanApp."Outstanding Balance", '>0');
            LoanApp.SetFilter(Posted, 'Yes');

            if LoanApp.Find('-') then begin
                repeat
                    if RunningBalance > 0 then begin
                        LoanApp.CalcFields(LoanApp."Outstanding Balance");
                        if LoanApp."Outstanding Balance" > 0 then begin
                            varLRepayment := 0;
                            PRpayment := 0;
                            varLRepayment := ROUND(LoanApp."Loan Interest Repayment", 1, '>');
                            if varLRepayment > 0 then begin

                                if RunningBalance > 0 then
                                    AmountToDeduct := RunningBalance;

                                begin
                                    if RunningBalance > varLRepayment then begin
                                        AmountToDeduct := varLRepayment;
                                    end
                                    else
                                        AmountToDeduct := RunningBalance;
                                end;

                                LineNo := LineNo + 10000;
                                //                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE,BATCH_NAME,DOCUMENT_NO,LineNo,GenJournalLine."Transaction Type"::"Interest Paid",
                                //                    GenJournalLine."Account Type"::Member,LoanApp."Client Code","Posting date",AmountToDeduct*-1,FORMAT(LoanApp.Source),"Document No",
                                //                    FORMAT(GenJournalLine."Transaction Type"::"Interest Paid"),LoanApp."Loan  No.");
                                RunningBalance := RunningBalance - AmountToDeduct;
                            end;
                        end;
                    end;


                until LoanApp.Next = 0;
            end;
            exit(RunningBalance);
        end;
    end;
}

