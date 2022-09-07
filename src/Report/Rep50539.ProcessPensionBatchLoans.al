
Report 50539 "Process Pension Batch-Loans"
{
    RDLCLayout = 'Layouts/ProcessPensionBatch-Loans.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Pension Processing Lines"; "Pension Processing Lines")
        {
            DataItemTableView = sorting("No.") where(Processed = const(false));
            RequestFilterFields = "Account No.", "Date Filter", "Salary Header No.";

            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }

            column(UserId; UserId)
            {
            }
            column(Salary_Processing_Buffer__No__; "Pension Processing Lines"."No.")
            {
            }
            column(Salary_Processing_Buffer__Account_No__; "Pension Processing Lines"."Account No.")
            {
            }
            column(Salary_Processing_Buffer__Staff_No__; "Pension Processing Lines"."Staff No.")
            {
            }
            column(Salary_Processing_Buffer_Name; "Pension Processing Lines".Name)
            {
            }
            column(Salary_Processing_Buffer_Amount; "Pension Processing Lines".Amount)
            {
            }
            column(Salary_Processing_Buffer__Account_Not_Found_; "Pension Processing Lines"."Account Not Found")
            {
            }
            column(Salary_Allowance_Processing_BufferCaption; Salary_Allowance_Processing_BufferCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Salary_Processing_Buffer__No__Caption; FieldCaption("No."))
            {
            }
            column(Salary_Processing_Buffer__Account_No__Caption; FieldCaption("Account No."))
            {
            }
            column(Salary_Processing_Buffer__Staff_No__Caption; FieldCaption("Staff No."))
            {
            }
            column(Salary_Processing_Buffer_NameCaption; FieldCaption(Name))
            {
            }
            column(Salary_Processing_Buffer_AmountCaption; FieldCaption(Amount))
            {
            }
            column(Salary_Processing_Buffer__Account_Not_Found_Caption; FieldCaption("Account Not Found"))
            {
            }
            dataitem("Standing Orders"; "Standing Orders")
            {
                DataItemLink = "Source Account No." = field("Account No.");
                DataItemTableView = where(Status = filter(Approved));

                trigger OnAfterGetRecord();
                begin
                    /*
					DontEffect:=FALSE;
					IF "Standing Orders"."Effective/Start Date" <> 0D THEN BEGIN
					IF "Standing Orders"."Effective/Start Date" > TODAY THEN BEGIN
					IF DATE2DMY(TODAY,2) <> DATE2DMY("Standing Orders"."Effective/Start Date",2) THEN
					DontEffect:=TRUE;
					END;
					END;
					//Check Effective Date
					IF DontEffect = FALSE THEN BEGIN
					IF SittingAll = FALSE THEN BEGIN
					AmountDed:=0;
					"Standing Orders".Effected:=FALSE;
					"Standing Orders".Unsuccessfull:=FALSE;
					"Standing Orders".Balance:=0;
					IF AccountS.GET("Standing Orders"."Source Account No.") THEN BEGIN
					DActivity3:=AccountS."Global Dimension 1 Code";
					DBranch3:=AccountS."Global Dimension 2 Code";
					AccountS.CALCFIELDS(AccountS.Balance,AccountS."Uncleared Cheques");
					//AvailableBal:=(AccountS.Balance-AccountS."Uncleared Cheques")+RunBal;
					AvailableBal:=RunBal;
					IF AccountTypeS.GET(AccountS."Account Type") THEN BEGIN
					//AvailableBal:=AvailableBal-AccountTypeS."Minimum Balance";
					Charges.RESET;
					IF "Destination Account Type" = "Destination Account Type"::External THEN
					Charges.SETRANGE(Charges."Charge Type",Charges."Charge Type"::"External Standing Order Fee")
					ELSE
					Charges.SETRANGE(Charges."Charge Type",Charges."Charge Type"::"Standing Order Fee");
					IF Charges.FIND('-') THEN BEGIN
					AvailableBal:=AvailableBal-Charges."Charge Amount";
					END;
					IF "Standing Orders"."Next Run Date" = 0D THEN
					"Standing Orders"."Next Run Date":="Standing Orders"."Effective/Start Date";
					//IF AvailableBal >= "Standing Orders".Amount THEN BEGIN
					"Standing Orders".CALCFIELDS("Standing Orders"."Allocated Amount");
					IF AvailableBal >= "Standing Orders"."Allocated Amount" THEN BEGIN
					AmountDed:="Standing Orders".Amount;
					DedStatus:=DedStatus::Successfull;
					IF "Standing Orders".Amount >= "Standing Orders".Balance THEN BEGIN
					"Standing Orders".Balance:=0;
					"Standing Orders"."Next Run Date":=CALCDATE("Standing Orders".Frequency,"Standing Orders"."Next Run Date");
					"Standing Orders".Unsuccessfull:=FALSE;
					END ELSE BEGIN
					"Standing Orders".Balance:="Standing Orders".Balance-"Standing Orders".Amount;
					"Standing Orders".Unsuccessfull:=TRUE;
					END;
					END ELSE BEGIN
					IF "Standing Orders"."Don't Allow Partial Deduction" = TRUE THEN BEGIN
					AmountDed:=0;
					DedStatus:=DedStatus::Failed;
					"Standing Orders".Balance:="Standing Orders".Amount;
					"Standing Orders".Unsuccessfull:=TRUE;
					END ELSE BEGIN
					AmountDed:=AvailableBal;
					DedStatus:=DedStatus::"Partial Deduction";
					"Standing Orders".Balance:="Standing Orders".Amount-AmountDed;
					"Standing Orders".Unsuccessfull:=TRUE;
					END;
					END;
					IF AmountDed < 0 THEN BEGIN
					AmountDed:=0;
					DedStatus:=DedStatus::Failed;
					"Standing Orders".Balance:="Standing Orders".Amount;
					"Standing Orders".Unsuccessfull:=TRUE;
					END;
					IF AmountDed > 0 THEN BEGIN
					ActualSTO:=0;
					IF ("Standing Orders"."Destination Account Type" = "Standing Orders"."Destination Account Type"::BOSA) AND ("Standing Orders".Status="Standing Orders".Status::Approved) THEN BEGIN
					//PostBOSAEntries();
					//AmountDed:=ActualSTO;
					AmountDed:=Amount;
					//***********************BOSA  Entries
					IF AmountDed > 0 THEN BEGIN
					STORunBal:=AmountDed;
					ReceiptAllocations.RESET;
					ReceiptAllocations.SETRANGE(ReceiptAllocations."Document No","No.");
					ReceiptAllocations.SETRANGE(ReceiptAllocations."Member No","BOSA Account No.");
					IF ReceiptAllocations.FIND('-') THEN BEGIN
					REPEAT
					ReceiptAllocations."Amount Balance":=0;
					ReceiptAllocations."Interest Balance":=0;
					ReceiptAmount:=ReceiptAllocations.Amount;//-ReceiptAllocations."Amount Balance";
					//Check Loan Balances
					{IF ReceiptAllocations."Transaction Type" = ReceiptAllocations."Transaction Type"::Repayment THEN BEGIN
					Loans.RESET;
					Loans.SETRANGE(Loans."Loan  No.",ReceiptAllocations."Loan No.");
					IF Loans.FIND('-') THEN BEGIN
					Loans.CALCFIELDS(Loans."Outstanding Balance");
					IF ReceiptAmount > Loans."Outstanding Balance" THEN
					ReceiptAmount := Loans."Outstanding Balance";
					END ELSE
					ERROR('Loan No. %1 not Found. :- %2',ReceiptAllocations."Loan No.",ReceiptAllocations."Document No");
					END;}
					IF ReceiptAmount < 0 THEN
					ReceiptAmount:=0;
					IF STORunBal < 0 THEN
					STORunBal:=0;
					LineNo:=LineNo+10000;
					GenJournalLine.INIT;
					GenJournalLine."Journal Template Name":='GENERAL';
					GenJournalLine."Journal Batch Name":='SALARIES';
					GenJournalLine."Line No.":=LineNo;
					GenJournalLine."Document No.":=SalaryHeader."Document No";
					GenJournalLine."External Document No.":=StandingOrders."No.";
					GenJournalLine."Posting Date":=SalaryHeader."Posting date";
					GenJournalLine."Account Type":=GenJournalLine."Bal. Account Type"::Member;
					GenJournalLine."Account No.":=ReceiptAllocations."Member No";
					GenJournalLine.VALIDATE(GenJournalLine."Account No.");
					GenJournalLine.Description:=FORMAT(ReceiptAllocations."Transaction Type");
					IF STORunBal > ReceiptAmount THEN
					GenJournalLine.Amount:=-ReceiptAmount
					ELSE
					GenJournalLine.Amount:=-STORunBal;
					IF ReceiptAllocations."Transaction Type" = ReceiptAllocations."Transaction Type"::"Insurance Contribution" THEN BEGIN
					IF ABS(GenJournalLine.Amount) = 100 THEN
					InsCont:=100;
					GenJournalLine.Amount:=-25;
					END;
					GenJournalLine.VALIDATE(GenJournalLine.Amount);
					IF ReceiptAllocations."Transaction Type" = ReceiptAllocations."Transaction Type"::"Security Fund" THEN
					GenJournalLine."Transaction Type":=GenJournalLine."Transaction Type"::"Security Fund"
					ELSE IF ReceiptAllocations."Transaction Type" = ReceiptAllocations."Transaction Type"::"Deposit Contribution" THEN
					GenJournalLine."Transaction Type":=GenJournalLine."Transaction Type"::"Deposit Contribution"
					ELSE IF ReceiptAllocations."Transaction Type" = ReceiptAllocations."Transaction Type"::Investment THEN
					GenJournalLine."Transaction Type":=GenJournalLine."Transaction Type"::"Insurance Contribution"
					ELSE IF ReceiptAllocations."Transaction Type" = ReceiptAllocations."Transaction Type"::Repayment THEN
					GenJournalLine."Transaction Type":=GenJournalLine."Transaction Type"::Repayment
					ELSE IF ReceiptAllocations."Transaction Type" = ReceiptAllocations."Transaction Type"::"Registration Fee" THEN
					GenJournalLine."Transaction Type":=GenJournalLine."Transaction Type"::"Registration Fee"
					ELSE IF ReceiptAllocations."Transaction Type" = ReceiptAllocations."Transaction Type"::"Shares Capital" THEN
					GenJournalLine."Transaction Type":=GenJournalLine."Transaction Type"::"Shares Capital";
					GenJournalLine."Loan No":=ReceiptAllocations."Loan No.";
					//IF GenJournalLine.Amount<>0 THEN
					GenJournalLine.INSERT;
					ReceiptAllocations."Amount Balance":=ReceiptAllocations."Amount Balance" + (GenJournalLine.Amount * -1);
					STORunBal:=STORunBal+GenJournalLine.Amount;
					ActualSTO:=ActualSTO+(GenJournalLine.Amount*-1);
					IF (ReceiptAllocations."Transaction Type" = ReceiptAllocations."Transaction Type"::"Insurance Contribution")
					   AND (InsCont = 100) THEN BEGIN
					LineNo:=LineNo+10000;
					GenJournalLine.INIT;
					GenJournalLine."Journal Template Name":='GENERAL';
					GenJournalLine."Journal Batch Name":='SALARIES';
					GenJournalLine."Line No.":=LineNo;
					GenJournalLine."Document No.":=SalaryHeader."Document No";
					GenJournalLine."External Document No.":=StandingOrders."No.";
					GenJournalLine."Posting Date":=SalaryHeader."Posting date";
					GenJournalLine."Account Type":=GenJournalLine."Bal. Account Type"::Member;
					GenJournalLine."Account No.":=ReceiptAllocations."Member No";
					GenJournalLine.VALIDATE(GenJournalLine."Account No.");
					GenJournalLine.Description:=FORMAT(ReceiptAllocations."Transaction Type");
					GenJournalLine.Amount:=-75;
					GenJournalLine.VALIDATE(GenJournalLine.Amount);
					//GenJournalLine."Transaction Type":=GenJournalLine."Transaction Type"::BOSAEXC;
					GenJournalLine."Loan No":=ReceiptAllocations."Loan No.";
					//IF GenJournalLine.Amount<>0 THEN
					GenJournalLine.INSERT;
					ReceiptAllocations."Amount Balance":=ReceiptAllocations."Amount Balance" + (GenJournalLine.Amount * -1);
					STORunBal:=STORunBal+GenJournalLine.Amount;
					ActualSTO:=ActualSTO+(GenJournalLine.Amount*-1);
					END;
					IF STORunBal < 0 THEN
					STORunBal:=0;
					IF (ReceiptAllocations."Transaction Type" = ReceiptAllocations."Transaction Type"::Repayment) AND
					   (ReceiptAllocations."Interest Amount" > 0) THEN BEGIN
					LineNo:=LineNo+10000;
					ReceiptAmount:=ReceiptAllocations."Interest Amount";
					//Check Outstanding Interest
					Loans.RESET;
					Loans.SETRANGE(Loans."Loan  No.",ReceiptAllocations."Loan No.");
					IF Loans.FIND('-') THEN BEGIN
					Loans.CALCFIELDS(Loans."Oustanding Interest");
					IF ReceiptAmount > Loans."Oustanding Interest" THEN
					ReceiptAmount := Loans."Oustanding Interest";
					END ELSE
					ERROR('Loan No. %1 not Found. :- %2',ReceiptAllocations."Loan No.",ReceiptAllocations."Document No");
					IF ReceiptAmount < 0 THEN
					ReceiptAmount:=0;
					IF ReceiptAmount > 0 THEN BEGIN
					GenJournalLine.INIT;
					GenJournalLine."Journal Template Name":='GENERAL';
					GenJournalLine."Journal Batch Name":='SALARIES';
					GenJournalLine."Line No.":=LineNo;
					GenJournalLine."Document No.":=SalaryHeader."Document No";
					GenJournalLine."External Document No.":=StandingOrders."No.";
					GenJournalLine."Posting Date":=SalaryHeader."Posting date";
					GenJournalLine."Account Type":=GenJournalLine."Bal. Account Type"::Member;
					GenJournalLine."Account No.":=ReceiptAllocations."Member No";
					GenJournalLine.VALIDATE(GenJournalLine."Account No.");
					GenJournalLine.Description:='Interest Paid';
					IF STORunBal > ReceiptAmount THEN
					GenJournalLine.Amount:=-ReceiptAmount
					ELSE
					GenJournalLine.Amount:=-STORunBal;
					GenJournalLine.VALIDATE(GenJournalLine.Amount);
					GenJournalLine."Transaction Type":=GenJournalLine."Transaction Type"::"Interest Paid";
					GenJournalLine."Loan No":=ReceiptAllocations."Loan No.";
					//IF GenJournalLine.Amount<>0 THEN
					GenJournalLine.INSERT;
					ReceiptAllocations."Interest Balance":=ReceiptAllocations."Interest Balance" + (GenJournalLine.Amount * -1);
					STORunBal:=STORunBal+GenJournalLine.Amount;
					ActualSTO:=ActualSTO+(GenJournalLine.Amount*-1);
					END;
					END;
					ReceiptAllocations.MODIFY;
					UNTIL ReceiptAllocations.NEXT = 0;
					END;
					END;
					//**********************End BOSA Entries
					END;
					LineNo:=LineNo+10000;
					GenJournalLine.INIT;
					GenJournalLine."Journal Template Name":='GENERAL';
					GenJournalLine."Journal Batch Name":='SALARIES';
					GenJournalLine."Document No.":=SalaryHeader."Document No";
					IF "Standing Orders"."Destination Account Type" = "Standing Orders"."Destination Account Type"::External THEN
					GenJournalLine."External Document No.":="Standing Orders"."Destination Account No."
					ELSE
					GenJournalLine."External Document No.":="Standing Orders"."No.";
					GenJournalLine."Line No.":=LineNo;
					GenJournalLine."Account Type":=GenJournalLine."Account Type"::Vendor;
					GenJournalLine."Account No.":="Standing Orders"."Source Account No.";
					GenJournalLine.VALIDATE(GenJournalLine."Account No.");
					GenJournalLine."Posting Date":=SalaryHeader."Posting date";
					GenJournalLine.Description:='Standing Order ' + COPYSTR("Standing Orders".Remarks,1,14);
					GenJournalLine.VALIDATE(GenJournalLine."Currency Code");
					GenJournalLine.Amount:=AmountDed;
					GenJournalLine.VALIDATE(GenJournalLine.Amount);
					GenJournalLine."Shortcut Dimension 1 Code":=DActivity3;
					GenJournalLine."Shortcut Dimension 2 Code":=DBranch3;
					GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
					GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
					IF GenJournalLine.Amount<>0 THEN
					GenJournalLine.INSERT;
					RunBal:=RunBal-AmountDed;
					IF ("Standing Orders"."Destination Account Type" <> "Standing Orders"."Destination Account Type"::BOSA) AND ("Standing Orders".Status="Standing Orders".Status::Approved) THEN BEGIN
					LineNo:=LineNo+10000;
					GenJournalLine.INIT;
					GenJournalLine."Journal Template Name":='GENERAL';
					GenJournalLine."Journal Batch Name":='SALARIES';
					GenJournalLine."Document No.":=SalaryHeader."Document No";
					GenJournalLine."Line No.":=LineNo;
					//GenJournalLine."External Document No.":="Standing Orders"."Source Account No.";
					//To pick staff no of the source
					GenJournalLine."External Document No.":=StandingOrders."Staff/Payroll No.";
					IF GenJournalLine."External Document No." = '' THEN
					GenJournalLine."External Document No.":="Standing Orders"."Source Account No.";
					IF "Standing Orders"."Destination Account Type" = "Standing Orders"."Destination Account Type"::Internal THEN BEGIN
					GenJournalLine."Account Type":=GenJournalLine."Account Type"::Vendor;
					GenJournalLine."Account No.":="Standing Orders"."Destination Account No.";
					END ELSE BEGIN
					GenJournalLine."Account Type":=GenJournalLine."Account Type"::"G/L Account";
					GenJournalLine."Account No.":=AccountTypeS."Standing Orders Suspense";
					END;
					GenJournalLine.VALIDATE(GenJournalLine."Account No.");
					GenJournalLine."Posting Date":=SalaryHeader."Posting date";
					GenJournalLine.Description:='Standing Order ' + COPYSTR("Standing Orders".Remarks,1,14);
					GenJournalLine.VALIDATE(GenJournalLine."Currency Code");
					GenJournalLine.Amount:=-AmountDed;
					GenJournalLine.VALIDATE(GenJournalLine.Amount);
					GenJournalLine."Shortcut Dimension 1 Code":=DActivity3;
					GenJournalLine."Shortcut Dimension 2 Code":=DBranch3;
					GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
					GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
					IF GenJournalLine.Amount<>0 THEN
					GenJournalLine.INSERT;
					END;
					END;
					//Standing Order Charges
					IF AmountDed > 0 THEN BEGIN
					Charges.RESET;
					//IF "Destination Account Type" = "Destination Account Type"::External THEN
					//Charges.SETRANGE(Charges."Charge Type",Charges."Charge Type"::"External Standing Order Fee")
					//ELSE
					Charges.SETRANGE(Charges."Charge Type",Charges."Charge Type"::"Standing Order Fee");
					IF Charges.FIND('-') THEN BEGIN
					LineNo:=LineNo+10000;
					GenJournalLine.INIT;
					GenJournalLine."Journal Template Name":='GENERAL';
					GenJournalLine."Journal Batch Name":='SALARIES';
					GenJournalLine."Document No.":=SalaryHeader."Document No";
					GenJournalLine."Line No.":=LineNo;
					GenJournalLine."External Document No.":="Standing Orders"."No.";
					GenJournalLine."Account Type":=GenJournalLine."Account Type"::Vendor;
					GenJournalLine."Account No.":="Standing Orders"."Source Account No.";
					GenJournalLine.VALIDATE(GenJournalLine."Account No.");
					GenJournalLine."Posting Date":=SalaryHeader."Posting date";
					GenJournalLine.Description:=Charges.Description;
					GenJournalLine.VALIDATE(GenJournalLine."Currency Code");
					GenJournalLine.Amount:=Charges."Charge Amount";
					GenJournalLine.VALIDATE(GenJournalLine.Amount);
					GenJournalLine."Bal. Account Type":=GenJournalLine."Bal. Account Type"::"G/L Account";
					GenJournalLine."Bal. Account No.":=Charges."GL Account";
					GenJournalLine.VALIDATE(GenJournalLine."Bal. Account No.");
					GenJournalLine."Shortcut Dimension 1 Code":=DActivity3;
					GenJournalLine."Shortcut Dimension 2 Code":=DBranch3;
					GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
					GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
					IF GenJournalLine.Amount<>0 THEN
					GenJournalLine.INSERT;
					END;
					END ELSE BEGIN
					IF AccountTypeS.Code <> 'OMEGA' THEN BEGIN
					Charges.RESET;
					Charges.SETRANGE(Charges."Charge Type",Charges."Charge Type"::"Failed Standing Order Fee");
					IF Charges.FIND('-') THEN BEGIN
					LineNo:=LineNo+10000;
					GenJournalLine.INIT;
					GenJournalLine."Journal Template Name":='GENERAL';
					GenJournalLine."Journal Batch Name":='SALARIES';
					GenJournalLine."Document No.":=SalaryHeader."Document No";
					GenJournalLine."Line No.":=LineNo;
					GenJournalLine."External Document No.":="Standing Orders"."No.";
					GenJournalLine."Account Type":=GenJournalLine."Account Type"::Vendor;
					GenJournalLine."Account No.":="Standing Orders"."Source Account No.";
					GenJournalLine.VALIDATE(GenJournalLine."Account No.");
					GenJournalLine."Posting Date":=SalaryHeader."Posting date";
					GenJournalLine.Description:=Charges.Description;
					GenJournalLine.VALIDATE(GenJournalLine."Currency Code");
					GenJournalLine.Amount:=Charges."Charge Amount";
					GenJournalLine.VALIDATE(GenJournalLine.Amount);
					GenJournalLine."Bal. Account Type":=GenJournalLine."Bal. Account Type"::"G/L Account";
					GenJournalLine."Bal. Account No.":=Charges."GL Account";
					GenJournalLine.VALIDATE(GenJournalLine."Bal. Account No.");
					GenJournalLine."Shortcut Dimension 1 Code":=DActivity3;
					GenJournalLine."Shortcut Dimension 2 Code":=DBranch3;
					GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
					GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
					IF GenJournalLine.Amount<>0 THEN
					GenJournalLine.INSERT;
					END;
					END;
					END;
					//Standing Order Charges
					//PostBOSAEntries();
					"Standing Orders".Effected:=TRUE;
					"Standing Orders"."Date Reset":=TODAY;
					"Standing Orders"."Next Run Date":=CALCDATE('-1D',CALCDATE('1M',DMY2DATE(1,DATE2DMY(CALCDATE("Standing Orders".Frequency,TODAY),2),
															   DATE2DMY(CALCDATE("Standing Orders".Frequency,TODAY),3))));
					"Standing Orders".MODIFY;
					STORegister.INIT;
					STORegister."Register No.":='';
					STORegister.VALIDATE(STORegister."Register No.");
					STORegister."Standing Order No.":="Standing Orders"."No.";
					STORegister."Source Account No.":="Standing Orders"."Source Account No.";
					STORegister."Staff/Payroll No.":="Standing Orders"."Staff/Payroll No.";
					STORegister.Date:=TODAY;
					STORegister."Account Name":="Standing Orders"."Account Name";
					STORegister."Destination Account Type":="Standing Orders"."Destination Account Type";
					STORegister."Destination Account No.":="Standing Orders"."Destination Account No.";
					STORegister."Destination Account Name":="Standing Orders"."Destination Account Name";
					STORegister."BOSA Account No.":="Standing Orders"."BOSA Account No.";
					STORegister."Effective/Start Date":="Standing Orders"."Effective/Start Date";
					STORegister."End Date":="Standing Orders"."End Date";
					STORegister.Duration:="Standing Orders".Duration;
					STORegister.Frequency:="Standing Orders".Frequency;
					STORegister."Don't Allow Partial Deduction":="Standing Orders"."Don't Allow Partial Deduction";
					STORegister."Deduction Status":=DedStatus;
					STORegister.Remarks:="Standing Orders".Remarks;
					STORegister.Amount:="Standing Orders".Amount;
					STORegister."Amount Deducted":=AmountDed;
					IF "Standing Orders"."Destination Account Type" = "Standing Orders"."Destination Account Type"::External THEN
					STORegister.EFT:=TRUE;
					STORegister."Document No.":=DocNo;
					STORegister.INSERT(TRUE);
					END;
					END;
					END;
					END;
							   //ollin STO cahnge
					*/

                end;

            }
            trigger OnPreDataItem();
            begin
                /*
				IF DocNo = '' THEN
				ERROR('You must specify the Document No.');
				IF PDate = 0D THEN
				ERROR('You must specify the posting date.');
				IF IssueDate = 0D THEN
				ERROR('You must specify the last issue date.');
				IF SittingAll = TRUE THEN BEGIN
				IF Remarks = '' THEN
				ERROR('You must specify the remarks for other payments.');
				END;
				*/
                if IssueDate = 0D then
                    Error('You must specify the last Loan issue date.');
                STORegister.Reset;
                STORegister.SetRange(STORegister."Document No.", DocNo);
                STORegister.SetRange(STORegister.Date, PDate);
                STORegister.SetRange(STORegister."Transfered to EFT", false);
                if STORegister.Find('-') then
                    STORegister.DeleteAll;
                GenJournalLine.Reset;
                GenJournalLine.SetRange(GenJournalLine."Journal Template Name", 'GENERAL');
                GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", 'SALARIES');
                if GenJournalLine.Find('-') then
                    GenJournalLine.DeleteAll;
                SalFee := 0;
                ExciseFee := 0;
                //IF SittingAll = FALSE THEN BEGIN
                if Charges.Get('SALARYP') then begin
                    SalGLAccount := Charges."GL Account";
                    SalFee := Charges."Charge Amount";
                end;
                if Charges.Get('EXCEISE') then begin
                    ExciseGLAccount := Charges."GL Account";
                    ExciseFee := SalFee * (Charges."Percentage of Amount" / 100);
                end;
                //END;
                /*IF UsersID.GET(USERID) THEN BEGIN
				//UsersID.TESTFIELD(UsersID.Branch);
				DActivity:='FOSA';
				DBranch:='';//UsersID.Branch;
				END;*/

            end;

            trigger OnAfterGetRecord();
            begin
                if SalaryHeader.Get("Salary Header No.") then begin
                    //Loans Recovery
                    if SittingAll = false then begin
                        if Account."Account Category" <> Account."account category"::Branch then
                            RunBal := ("Pension Processing Lines".Amount - SalFee - SMSCharge) + AvailableBal;
                        //Interest
                        Loans.Reset;
                        Loans.SetCurrentkey(Source, "Client Code", "Loan Product Type", "Issued Date");
                        //Loans.SETRANGE(Loans."Client Code","Pension Processing Lines"."Account No.");
                        Loans.SetRange(Loans."BOSA No", "Pension Processing Lines"."Bosa No");
                        Loans.SetRange(Loans."Issued Date", 0D, IssueDate);
                        Loans.SetFilter(Loans."Period Date Filter", GetFilter("Date Filter"));
                        //Loans.SETFILTER(Loans."Loan Product Type",'HSFSPECIAL|HSFADVANCE|FOSAKARIBU|HSF OKOA|HSFDEF|DEFAULTED|DEFAULTER1|DEFAULTED2');
                        //Loans.SETFILTER(Loans.Source,'FOSA');
                        if Loans.Find('-') then begin
                            repeat
                                if LoanType.Get(Loans."Loan Product Type") then begin
                                    //IF LoanType."Recovery Method"=LoanType."Recovery Method"::"Salary " THEN BEGIN
                                    if RunBal > 0 then begin
                                        Loans.CalcFields(Loans."Outstanding Balance", Loans."Outstanding Interest");
                                        //IF Loans."Outstanding Balance" > 0 THEN BEGIN
                                        if Loans."Outstanding Interest" > 0 then begin
                                            Interest := 0;
                                            Interest := Loans."Outstanding Interest";
                                            if Interest > 0 then begin
                                                LineNo := LineNo + 10000;
                                                GenJournalLine.Init;
                                                GenJournalLine."Journal Template Name" := 'GENERAL';
                                                GenJournalLine."Journal Batch Name" := 'SALARIES';
                                                GenJournalLine."Line No." := LineNo;
                                                GenJournalLine."Account Type" := GenJournalLine."account type"::Member;
                                                if Loans."Issued Date" < 20160511D then begin
                                                    GenJournalLine."Account No." := "Pension Processing Lines"."Bosa No"
                                                end else
                                                    GenJournalLine."Account No." := "Pension Processing Lines"."Account No.";
                                                GenJournalLine."Document No." := SalaryHeader."Document No";
                                                GenJournalLine."Posting Date" := SalaryHeader."Posting date";
                                                GenJournalLine.Description := 'Interest Paid';
                                                if RunBal > Interest then
                                                    GenJournalLine.Validate(GenJournalLine.Amount, Interest * -1)
                                                else
                                                    GenJournalLine.Validate(GenJournalLine.Amount, RunBal * -1);
                                                GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Insurance Contribution";
                                                GenJournalLine.Validate(GenJournalLine."Loan No", Loans."Loan  No.");
                                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code", DActivity2);
                                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code", DBranch2);
                                                if GenJournalLine.Amount <> 0 then
                                                    GenJournalLine.Insert;
                                                LineNo := LineNo + 10000;
                                                GenJournalLine.Init;
                                                GenJournalLine."Journal Template Name" := 'GENERAL';
                                                GenJournalLine."Journal Batch Name" := 'SALARIES';
                                                GenJournalLine."Line No." := LineNo;
                                                GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                                GenJournalLine.Validate(GenJournalLine."Account No.", "Pension Processing Lines"."Account No.");
                                                GenJournalLine."Document No." := SalaryHeader."Document No";
                                                GenJournalLine."Posting Date" := SalaryHeader."Posting date";
                                                GenJournalLine.Description := 'Interest Paid - ' + Loans."Loan Product Type";
                                                if RunBal > Interest then
                                                    GenJournalLine.Validate(GenJournalLine.Amount, Interest)
                                                else
                                                    GenJournalLine.Validate(GenJournalLine.Amount, RunBal);
                                                GenJournalLine.Validate(GenJournalLine."Loan No", Loans."Loan  No.");
                                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code", DActivity2);
                                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code", DBranch2);
                                                if GenJournalLine.Amount <> 0 then
                                                    GenJournalLine.Insert;
                                                RunBal := RunBal - Abs(GenJournalLine.Amount);
                                            end;
                                        end;
                                    end;
                                    //END;
                                end;
                            until Loans.Next = 0;
                        end;
                        //Priciple
                        Loans.Reset;
                        Loans.SetCurrentkey(Source, "Client Code", "Loan Product Type", "Issued Date");
                        //Loans.SETRANGE(Loans."Client Code","Pension Processing Lines"."Account No.");
                        Loans.SetRange(Loans."BOSA No", "Pension Processing Lines"."Bosa No");
                        //Loans.SETRANGE(Loans."BOSA No","Pension Processing Lines".);
                        Loans.SetRange(Loans."Issued Date", 0D, IssueDate);
                        Loans.SetFilter(Loans."Period Date Filter", GetFilter("Date Filter"));
                        //Loans.SETFILTER(Loans."Loan Product Type",'HSFSPECIAL|HSFADVANCE|FOSAKARIBU|HSF OKOA|HSFDEF|DEFAULTED|DEFAULTER1|DEFAULTED2');
                        //Loans.SETFILTER(Loans.Source,'FOSA');
                        if Loans.Find('-') then begin
                            repeat
                                if LoanType.Get(Loans."Loan Product Type") then begin
                                    // IF LoanType."Recovery Method"=LoanType."Recovery Method"::"Salary " THEN BEGIN
                                    if RunBal > 0 then begin
                                        Loans.CalcFields(Loans."Outstanding Balance", Loans."Interest Due");
                                        if Loans."Outstanding Balance" > 0 then begin
                                            TotalMRepay := 0;
                                            LPrincipal := 0;
                                            LInterest := 0;
                                            InterestRate := Loans.Interest;
                                            LoanAmount := Loans."Approved Amount";
                                            RepayPeriod := Loans.Installments;
                                            LBalance := Loans."Approved Amount";
                                            if Loans."Loan Product Type" = 'HSFDEF' then
                                                LRepayment := ROUND(Loans."Outstanding Balance" / Loans.Installments, 0.05, '>')
                                            else begin
                                                if Loans."Adjted Repayment" <> 0 then
                                                    LRepayment := Loans."Adjted Repayment" - Loans."Interest Due"
                                                else
                                                    LRepayment := Loans.Repayment - Loans."Interest Due";
                                            end;
                                            if LRepayment = 0 then
                                                LRepayment := Loans.Repayment;
                                            LineNo := LineNo + 10000;
                                            GenJournalLine.Init;
                                            GenJournalLine."Journal Template Name" := 'GENERAL';
                                            GenJournalLine."Journal Batch Name" := 'SALARIES';
                                            GenJournalLine."Line No." := LineNo;
                                            GenJournalLine."Account Type" := GenJournalLine."account type"::Member;
                                            if Loans."Issued Date" < 20160511D then begin
                                                GenJournalLine."Account No." := "Pension Processing Lines"."Bosa No"
                                            end else
                                                GenJournalLine."Account No." := "Pension Processing Lines"."Account No.";
                                            GenJournalLine."Document No." := SalaryHeader."Document No";
                                            GenJournalLine."Posting Date" := SalaryHeader."Posting date";
                                            GenJournalLine.Description := 'Loan Repayment';
                                            if RunBal > LRepayment then
                                                GenJournalLine.Validate(GenJournalLine.Amount, LRepayment * -1)
                                            else
                                                GenJournalLine.Validate(GenJournalLine.Amount, RunBal * -1);
                                            GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Interest Paid";
                                            GenJournalLine.Validate(GenJournalLine."Loan No", Loans."Loan  No.");
                                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code", DActivity2);
                                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code", DBranch2);
                                            if GenJournalLine.Amount <> 0 then
                                                GenJournalLine.Insert;
                                            LineNo := LineNo + 10000;
                                            GenJournalLine.Init;
                                            GenJournalLine."Journal Template Name" := 'GENERAL';
                                            GenJournalLine."Journal Batch Name" := 'SALARIES';
                                            GenJournalLine."Line No." := LineNo;
                                            GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                            GenJournalLine.Validate(GenJournalLine."Account No.", "Pension Processing Lines"."Account No.");
                                            GenJournalLine."Document No." := SalaryHeader."Document No";
                                            GenJournalLine."Posting Date" := SalaryHeader."Posting date";
                                            GenJournalLine.Description := 'Loan Repayment - ' + Loans."Loan Product Type";
                                            if RunBal > LRepayment then
                                                GenJournalLine.Validate(GenJournalLine.Amount, LRepayment)
                                            else
                                                GenJournalLine.Validate(GenJournalLine.Amount, RunBal);
                                            GenJournalLine.Validate(GenJournalLine."Loan No", Loans."Loan  No.");
                                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code", DActivity2);
                                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code", DBranch2);
                                            if GenJournalLine.Amount <> 0 then
                                                GenJournalLine.Insert;
                                            RunBal := RunBal - Abs(GenJournalLine.Amount);
                                        end;
                                    end;
                                    //END;
                                end;
                            until Loans.Next = 0;
                        end;
                    end;
                end else begin
                    "Pension Processing Lines"."Account Not Found" := true;
                end;
                "Pension Processing Lines"."Document No." := DocNo;
                "Pension Processing Lines".Date := PDate;
                "Pension Processing Lines".Modify;
                //Mark Salaried Accounts
                if Account.Get("Pension Processing Lines"."Account No.") then begin
                    Account."Salary Processing" := true;
                    Account.Modify;
                end;
            end;

            trigger OnPostDataItem();
            begin
                //Balance With Employer--------------------------------------------------------------
                if SalaryHeader.Get("Salary Header No.") then begin
                    LineNo := LineNo + 10000;
                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := 'GENERAL';
                    GenJournalLine."Journal Batch Name" := 'SALARIES';
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Account Type" := SalaryHeader."Account Type";
                    GenJournalLine."Account No." := SalaryHeader."Account No";
                    GenJournalLine."External Document No." := SalaryHeader."Cheque No.";
                    GenJournalLine."Document No." := SalaryHeader."Document No";
                    GenJournalLine."Posting Date" := SalaryHeader."Posting date";
                    GenJournalLine.Description := SalaryHeader.Remarks;
                    GenJournalLine.Amount := SalaryHeader.Amount;
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code", DActivity2);
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code", DBranch2);
                    //IF GenJournalLine.Amount<>0 THEN
                    GenJournalLine.Insert;
                end;
                //End Balance With Employer--------------------------------------------------------------
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
                field("Last Loan Issue Date"; IssueDate)
                {
                    ApplicationArea = Basic;
                }

            }
        }

        actions
        {
        }
        trigger OnOpenPage()
        begin

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
        AvailableBal: Decimal;
        STORegister: Record "Standing Order Register";
        AmountDed: Decimal;
        DedStatus: Option Successfull,"Partial Deduction",Failed;
        Charges: Record Charges;
        LineNo: Integer;
        DocNo: Code[20];
        PDate: Date;
        SalFee: Decimal;
        SalGLAccount: Code[20];
        Loans: Record "Loans Register";
        LRepayment: Decimal;
        RunBal: Decimal;
        Interest: Decimal;
        SittingAll: Boolean;
        UsersID: Record User;
        DActivity: Code[20];
        DBranch: Code[20];
        AccountS: Record Vendor;
        AccountTypeS: Record "Account Types-Saving Products";
        IssueDate: Date;
        DActivity2: Code[20];
        DBranch2: Code[20];
        DActivity3: Code[20];
        DBranch3: Code[20];
        BOSABank: Code[20];
        ReceiptAllocations: Record "Receipt Allocation";
        STORunBal: Decimal;
        ReceiptAmount: Decimal;
        StandingOrders: Record "Standing Orders";
        AccountCard: Record Vendor;
        AccountCard2: Record Vendor;
        FlexContribution: Decimal;
        FlexAccountNo: Code[20];
        ActualSTO: Decimal;
        InsCont: Decimal;
        LoanType: Record "Loan Products Setup";
        Remarks: Text[50];
        DontEffect: Boolean;
        TotalMRepay: Decimal;
        InterestRate: Decimal;
        LPrincipal: Decimal;
        LInterest: Decimal;
        LoanAmount: Decimal;
        RepayPeriod: Integer;
        LBalance: Decimal;
        Schedule: Record "Loan Repayment Schedule";
        Salary_Allowance_Processing_BufferCaptionLbl: label 'Salary/Allowance Processing Buffer';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        Vend1: Record Vendor;
        Charges1: Record Charges;
        SMSCharge: Decimal;
        GenLedgerSetup: Record "General Ledger Setup";
        ExciseGLAccount: Code[10];
        ExciseFee: Decimal;
        SalaryHeader: Record "Pension Processing Headerr";

    procedure PostBOSAEntries()
    var
        ReceiptAllocation: Record "Receipt Allocation";
    begin
        if AmountDed > 0 then begin
            STORunBal := AmountDed;
            ReceiptAllocations.Reset;
            ReceiptAllocations.SetRange(ReceiptAllocations."Document No", StandingOrders."No.");
            //ReceiptAllocations.SETRANGE(ReceiptAllocations."Member No",StandingOrders."BOSA Account No.");
            if ReceiptAllocations.Find('-') then begin
                if ReceiptAllocations.Get("Standing Orders"."BOSA Account No.") then begin
                    repeat
                        ReceiptAllocations."Amount Balance" := 0;
                        ReceiptAllocations."Interest Balance" := 0;
                        ReceiptAmount := ReceiptAllocations.Amount;//-ReceiptAllocations."Amount Balance";
                                                                   //Check Loan Balances
                                                                   /*IF ReceiptAllocations."Transaction Type" = ReceiptAllocations."Transaction Type"::Repayment THEN BEGIN
                                                                   Loans.RESET;
                                                                   Loans.SETRANGE(Loans."Loan  No.",ReceiptAllocations."Loan No.");
                                                                   IF Loans.FIND('-') THEN BEGIN
                                                                   Loans.CALCFIELDS(Loans."Outstanding Balance");
                                                                   IF ReceiptAmount > Loans."Outstanding Balance" THEN
                                                                   ReceiptAmount := Loans."Outstanding Balance";
                                                                   END ELSE
                                                                   ERROR('Loan No. %1 not Found. :- %2',ReceiptAllocations."Loan No.",ReceiptAllocations."Document No");
                                                                   END;*/
                        if ReceiptAmount < 0 then
                            ReceiptAmount := 0;
                        if STORunBal < 0 then
                            STORunBal := 0;
                        LineNo := LineNo + 10000;
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := 'GENERAL';
                        GenJournalLine."Journal Batch Name" := 'SALARIES';
                        GenJournalLine."Line No." := LineNo;
                        GenJournalLine."Document No." := SalaryHeader."Document No";
                        GenJournalLine."External Document No." := StandingOrders."No.";
                        GenJournalLine."Posting Date" := SalaryHeader."Posting date";
                        GenJournalLine."Account Type" := GenJournalLine."bal. account type"::Employee;
                        GenJournalLine."Account No." := ReceiptAllocations."Member No";
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine.Description := Format(ReceiptAllocations."Transaction Type");
                        if STORunBal > ReceiptAmount then
                            GenJournalLine.Amount := -ReceiptAmount
                        else
                            GenJournalLine.Amount := -STORunBal;
                        if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"Loan Penalty Paid" then begin
                            if Abs(GenJournalLine.Amount) = 100 then
                                InsCont := 100;
                            GenJournalLine.Amount := -25;
                        end;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"Benevolent Fund" then
                            GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Benevolent Fund"
                        else
                            if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::Loan then
                                GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::Loan
                            else
                                if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"Loan Insurance Charged" then
                                    GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Loan Penalty Paid"
                                else
                                    if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"Interest Paid" then
                                        GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Interest Paid"
                                    else
                                        if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"Registration Fee" then
                                            GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Registration Fee"
                                        else
                                            if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"Recovery Account" then
                                                GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Recovery Account";
                        GenJournalLine."Loan No" := ReceiptAllocations."Loan No.";
                        //IF GenJournalLine.Amount<>0 THEN
                        GenJournalLine.Insert;
                        ReceiptAllocations."Amount Balance" := ReceiptAllocations."Amount Balance" + (GenJournalLine.Amount * -1);
                        STORunBal := STORunBal + GenJournalLine.Amount;
                        ActualSTO := ActualSTO + (GenJournalLine.Amount * -1);
                        if (ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"Loan Penalty Paid")
                           and (InsCont = 100) then begin
                            LineNo := LineNo + 10000;
                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name" := 'GENERAL';
                            GenJournalLine."Journal Batch Name" := 'SALARIES';
                            GenJournalLine."Line No." := LineNo;
                            GenJournalLine."Document No." := SalaryHeader."Document No";
                            GenJournalLine."External Document No." := StandingOrders."No.";
                            GenJournalLine."Posting Date" := SalaryHeader."Posting date";
                            GenJournalLine."Account Type" := GenJournalLine."bal. account type"::Employee;
                            GenJournalLine."Account No." := ReceiptAllocations."Member No";
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine.Description := Format(ReceiptAllocations."Transaction Type");
                            GenJournalLine.Amount := -75;
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            //GenJournalLine."Transaction Type":=GenJournalLine."Transaction Type"::BOSAEXC;
                            GenJournalLine."Loan No" := ReceiptAllocations."Loan No.";
                            //IF GenJournalLine.Amount<>0 THEN
                            GenJournalLine.Insert;
                            ReceiptAllocations."Amount Balance" := ReceiptAllocations."Amount Balance" + (GenJournalLine.Amount * -1);
                            STORunBal := STORunBal + GenJournalLine.Amount;
                            ActualSTO := ActualSTO + (GenJournalLine.Amount * -1);
                        end;
                        if STORunBal < 0 then
                            STORunBal := 0;
                        if (ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"Interest Paid") and
                           (ReceiptAllocations."Interest Amount" > 0) then begin
                            LineNo := LineNo + 10000;
                            ReceiptAmount := ReceiptAllocations."Interest Amount";
                            //Check Outstanding Interest
                            Loans.Reset;
                            Loans.SetRange(Loans."Loan  No.", ReceiptAllocations."Loan No.");
                            if Loans.Find('-') then begin
                                Loans.CalcFields(Loans."Outstanding Interest");
                                if ReceiptAmount > Loans."Outstanding Interest" then
                                    ReceiptAmount := Loans."Outstanding Interest";
                            end else
                                Error('Loan No. %1 not Found. :- %2', ReceiptAllocations."Loan No.", ReceiptAllocations."Document No");
                            if ReceiptAmount < 0 then
                                ReceiptAmount := 0;
                            if ReceiptAmount > 0 then begin
                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := 'GENERAL';
                                GenJournalLine."Journal Batch Name" := 'SALARIES';
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Document No." := SalaryHeader."Document No";
                                GenJournalLine."External Document No." := StandingOrders."No.";
                                GenJournalLine."Posting Date" := SalaryHeader."Posting date";
                                GenJournalLine."Account Type" := GenJournalLine."bal. account type"::Employee;
                                GenJournalLine."Account No." := ReceiptAllocations."Member No";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine.Description := 'Interest Paid';
                                if STORunBal > ReceiptAmount then
                                    GenJournalLine.Amount := -ReceiptAmount
                                else
                                    GenJournalLine.Amount := -STORunBal;
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Insurance Contribution";
                                GenJournalLine."Loan No" := ReceiptAllocations."Loan No.";
                                //IF GenJournalLine.Amount<>0 THEN
                                GenJournalLine.Insert;
                                ReceiptAllocations."Interest Balance" := ReceiptAllocations."Interest Balance" + (GenJournalLine.Amount * -1);
                                STORunBal := STORunBal + GenJournalLine.Amount;
                                ActualSTO := ActualSTO + (GenJournalLine.Amount * -1);
                            end;
                        end;
                        ReceiptAllocations.Modify;
                    until ReceiptAllocations.Next = 0;
                end;
            end;
        end;

    end;

    var
}