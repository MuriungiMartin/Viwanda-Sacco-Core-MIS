#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Codeunit 50007 "SURESTEP Factory"
{

    trigger OnRun()
    var
        Loan: Record "Loans Register";
        GenSetUp: Record "Sacco General Set-Up";
        VarLoanDisburesementDay: Integer;
        modify: Boolean;
    begin
        //MESSAGE(FORMAT(FnRunGetMemberLoanAmountDueFreezing('001006142')));
        //FnRunAutoUnFreezeMemberLoanDueAmount;

        //FnUpdateLoanPortfolio(20193101D);
        //FnRunProcessAssetDepreciationCustom
        //FnRunGetDepositArrearsPenalty;

        //FnRunSendScheduledAccountStatements()
        //FnCreateGuarantorRecoveryReimbursment('001018487',20000,'001401006986','REFUND00234');

        //FnAccrueInterestOneOffLoans('00130400027934');
        //FnRunAfterCashDepositProcess('001501004576');

        //FnCreateGuarantorRecoveryReimbursment('001405000016');

        //FnRunGetMembershipDormancyStatus(WORKDATE);

        //FnRunMemberCreditScoring('002000001');
        /*
        GenSetUp.GET;
        Loan.RESET;
        Loan.SETRANGE(Posted,TRUE);
        Loan.SETFILTER("Application Date",'<>%1',0D);
        IF Loan.FINDSET THEN
          REPEAT
                modify:=FALSE;
                 IF Loan."Loan Disbursement Date"=0D THEN BEGIN
                   modify:=TRUE;
                   Loan."Loan Disbursement Date":=Loan."Application Date";
                   VarLoanDisburesementDay:=DATE2DMY(Loan."Loan Disbursement Date",1);
        
                   END;
        
                    IF Loan."Repayment Start Date"=0D THEN BEGIN
                        modify:=TRUE;
        
                      IF VarLoanDisburesementDay>GenSetUp."Last Date of Checkoff Advice" THEN
                        Loan."Repayment Start Date":=CALCDATE('CM',(CALCDATE('1M',Loan."Loan Disbursement Date")))
                      ELSE
                        Loan."Repayment Start Date":=CALCDATE('CM',Loan."Loan Disbursement Date");
        
                    END;
        
                   IF modify THEN BEGIN
                     Loan.MODIFY;
                     COMMIT;
                   END;
        
                FnGenerateLoanRepaymentSchedule(Loan."Loan  No.");
        
        
            UNTIL Loan.NEXT = 0;*/

        Loan.Get('LN10130');



        Message(Format(FnCalculateLoanInterest(Loan, Today)));

        //FnRunPasswordChangeonNextLogin();

    end;

    var
        ObjTransCharges: Record "Transaction Charges";
        UserSetup: Record User;
        ObjVendor: Record Vendor;
        ObjProducts: Record "Account Types-Saving Products";
        ObjMemberLedgerEntry: Record "Cust. Ledger Entry";
        ObjLoans: Record "Loans Register";
        ObjBanks: Record "Bank Account";
        ObjLoanProductSetup: Record "Loan Products Setup";
        ObjProductCharges: Record "Loan Product Charges";
        ObjMembers: Record Customer;
        ObjMembers2: Record Customer;
        ObjGenSetUp: Record "Sacco General Set-Up";
        ObjCompInfo: Record "Company Information";
        BAND1: Decimal;
        BAND2: Decimal;
        BAND3: Decimal;
        BAND4: Decimal;
        BAND5: Decimal;
        ObjMembershipWithdrawal: Record "Membership Exist";
        ObjSalesSetup: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        ObjNoSeriesManagement: Codeunit NoSeriesManagement;
        ObjNextNo: Code[20];
        PostingDate: Date;
        ObjNoSeries: Record "No. Series Line";
        VarRepaymentPeriod: Date;
        VarLoanNo: Code[20];
        VarLastMonth: Date;
        ObjLSchedule: Record "Loan Repayment Schedule";
        VarScheduledLoanBal: Decimal;
        VarDateFilter: Text;
        VarLBal: Decimal;
        VarArrears: Decimal;
        VarDate: Integer;
        VarMonth: Integer;
        VarYear: Integer;
        VarLastMonthBeginDate: Date;
        VarScheduleDateFilter: Text;
        VarScheduleRepayDate: Date;
        ObjCustRiskRates: Record "Customer Risk Rating";
        ObjMembershipApplication: Record "Membership Applications";
        ObjMemberRiskRating: Record "Individual Customer Risk Rate";
        ObjProductRiskRating: Record "Product Risk Rating";
        ObjProductsApp: Record "Membership Reg. Products Appli";
        ObjNetRiskScale: Record "Member Gross Risk Rating Scale";
        GenJournalLine: Record "Gen. Journal Line";
        SMTP: Codeunit "SMTP Mail";
        TextBody: Text;
        TextMessage: Text;
        SMTPSetup: Record "SMTP Mail Setup";
        ObjEmailLogs: Record "Email Logs";
        iEntryNo: Integer;
        FAJournalLine: Record "Gen. Journal Line";
        ScheduledOn: DateTime;
        VarOutputFormat: Text;
        ObjAccountToOpen: Record "MobileApp Account Registration";
        ObjEntitiesRiskRating: Record "Entities Customer Risk Rate";
        ObjEntitiesNetRiskScale: Record "Entities Gross Risk Rate Scale";
        ObjFDAccounts: Record "Fixed Deposit Placement";


    procedure FnGetCashierTransactionBudding(TransactionType: Code[100]; TransAmount: Decimal) TCharge: Decimal
    begin
        ObjTransCharges.Reset;
        ObjTransCharges.SetRange(ObjTransCharges."Transaction Type", TransactionType);
        ObjTransCharges.SetFilter(ObjTransCharges."Minimum Amount", '<=%1', TransAmount);
        ObjTransCharges.SetFilter(ObjTransCharges."Maximum Amount", '>=%1', TransAmount);
        TCharge := 0;
        if ObjTransCharges.FindSet then begin
            repeat
                TCharge := TCharge + ObjTransCharges."Charge Amount" + ObjTransCharges."Charge Amount" * 0.1;
            until ObjTransCharges.Next = 0;
        end;
    end;


    procedure FnGetUserBranch() branchCode: Code[20]
    begin
        UserSetup.Reset;
        UserSetup.SetRange(UserSetup."User Name", UserId);
        if UserSetup.Find('-') then begin
            // branchCode := UserSetup."Branch Code";
        end;
        exit(branchCode);
    end;


    procedure FnSendSMS(SMSSource: Text; SMSBody: Text; CurrentAccountNo: Text; MobileNumber: Text)
    var
        SMSMessage: Record "SMS Messages";
        iEntryNo: Integer;
    begin
        ObjGenSetUp.Get;
        ObjCompInfo.Get;

        SMSMessage.Reset;
        SMSMessage.SetCurrentkey(SMSMessage."Entry No");
        if SMSMessage.FindLast then begin
            iEntryNo := SMSMessage."Entry No" + 1;
        end
        else begin
            iEntryNo := 1;
        end;


        SMSMessage.Init;
        SMSMessage."Entry No" := iEntryNo;
        SMSMessage."Batch No" := CurrentAccountNo;
        SMSMessage."Document No" := '';
        SMSMessage."Account No" := CurrentAccountNo;
        SMSMessage."Date Entered" := Today;
        SMSMessage."Time Entered" := Time;
        SMSMessage.Source := SMSSource;
        SMSMessage."Entered By" := UserId;
        SMSMessage."Sent To Server" := SMSMessage."sent to server"::No;
        SMSMessage."SMS Message" := SMSBody + ObjCompInfo.Name;
        SMSMessage."Telephone No" := MobileNumber;
        if ((MobileNumber <> '') and (SMSBody <> '')) then
            SMSMessage.Insert;
    end;


    procedure FnSendOTPSMS(SMSSource: Text; SMSBody: Text; CurrentAccountNo: Text; MobileNumber: Text; UserID: Code[30]; OTP: Integer)
    var
        SMSMessage: Record "SMS Messages";
        iEntryNo: Integer;
    begin
        ObjGenSetUp.Get;
        ObjCompInfo.Get;

        SMSMessage.Reset;
        SMSMessage.SetCurrentkey(SMSMessage."Entry No");
        if SMSMessage.FindLast then begin
            iEntryNo := SMSMessage."Entry No" + 10;
        end
        else begin
            iEntryNo := 10;
        end;


        SMSMessage.Init;
        SMSMessage."Entry No" := iEntryNo;
        SMSMessage."Batch No" := CurrentAccountNo;
        SMSMessage."Document No" := '';
        SMSMessage."Account No" := CurrentAccountNo;
        SMSMessage."Date Entered" := Today;
        SMSMessage."Time Entered" := Time;
        SMSMessage.Source := SMSSource;
        SMSMessage."Entered By" := UserID;
        SMSMessage."Sent To Server" := SMSMessage."sent to server"::No;
        SMSMessage."SMS Message" := SMSBody + '. Vision Sacco';
        SMSMessage."Telephone No" := MobileNumber;
        SMSMessage.OTP_User := UserID;
        SMSMessage."OTP Code" := OTP;
        if ((MobileNumber <> '') and (SMSBody <> '')) then
            SMSMessage.Insert;
    end;


    procedure FnSendSMSScheduled(SMSSource: Text; SMSBody: Text; CurrentAccountNo: Text; MobileNumber: Text; ScheduledOn: DateTime)
    var
        SMSMessage: Record "SMS Messages";
        iEntryNo: Integer;
    begin
        ObjGenSetUp.Get;
        ObjCompInfo.Get;

        SMSMessage.Reset;
        SMSMessage.SetCurrentkey(SMSMessage."Entry No");
        if SMSMessage.FindLast then begin
            iEntryNo := SMSMessage."Entry No" + 10;
        end
        else begin
            iEntryNo := 10;
        end;


        SMSMessage.Init;
        SMSMessage."Entry No" := iEntryNo;
        SMSMessage."Batch No" := CurrentAccountNo;
        SMSMessage."Document No" := '';
        SMSMessage."Account No" := CurrentAccountNo;
        SMSMessage."Date Entered" := Today;
        SMSMessage."Time Entered" := Time;
        SMSMessage.Source := SMSSource;
        SMSMessage."Entered By" := UserId;
        SMSMessage."Sent To Server" := SMSMessage."sent to server"::No;
        SMSMessage."SMS Message" := SMSBody + '. Vision Sacco';// +' '+ObjGenSetUp."Customer Care No";
        SMSMessage."Telephone No" := MobileNumber;
        SMSMessage.ScheduledOn := ScheduledOn;
        if ((MobileNumber <> '') and (SMSBody <> '')) then
            SMSMessage.Insert;
    end;


    procedure FnCreateGnlJournalLine(TemplateName: Text; BatchName: Text; DocumentNo: Code[30]; LineNo: Integer; TransactionType: Option " ","Registration Fee","Share Capital","Interest Paid","Loan Repayment","Deposit Contribution","Insurance Contribution","Benevolent Fund",Loan,"Unallocated Funds",Dividend,"FOSA Account"; AccountType: Enum "Gen. Journal Account Type"; AccountNo: Code[50]; TransactionDate: Date; TransactionAmount: Decimal; DimensionActivity: Code[40]; ExternalDocumentNo: Code[50]; TransactionDescription: Text; LoanNumber: Code[50]; AppSource: Option " ",CBS,ATM,Mobile,Internet,MPESA,Equity,"Co-op",Family,"SMS Banking")
    var
        GenJournalLine: Record "Gen. Journal Line";
    begin
        GenJournalLine.Init;
        GenJournalLine."Journal Template Name" := TemplateName;
        GenJournalLine."Journal Batch Name" := BatchName;
        GenJournalLine."Document No." := DocumentNo;
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Account Type" := AccountType;
        GenJournalLine."Account No." := AccountNo;
        GenJournalLine."Transaction Type" := TransactionType;
        GenJournalLine."Loan No" := LoanNumber;
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Posting Date" := TransactionDate;
        GenJournalLine.Description := TransactionDescription;
        GenJournalLine."Application Source" := AppSource;
        GenJournalLine.Validate(GenJournalLine."Currency Code");
        GenJournalLine.Amount := TransactionAmount;
        GenJournalLine."External Document No." := ExternalDocumentNo;
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Shortcut Dimension 1 Code" := DimensionActivity;
        GenJournalLine."Shortcut Dimension 2 Code" := FnGetUserBranch();
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert;
    end;


    procedure FnGetFosaAccountBalance(Acc: Code[30]) Bal: Decimal
    begin
        if ObjVendor.Get(Acc) then begin
            ObjVendor.CalcFields(ObjVendor."Balance (LCY)", ObjVendor."ATM Transactions", ObjVendor."Mobile Transactions", ObjVendor."Uncleared Cheques");
            Bal := ObjVendor."Balance (LCY)" - (ObjVendor."ATM Transactions" + ObjVendor."Mobile Transactions" + FnGetMinimumAllowedBalance(ObjVendor."Account Type"));
        end
    end;

    local procedure FnGetMinimumAllowedBalance(ProductCode: Code[60]) MinimumBalance: Decimal
    begin
        ObjProducts.Reset;
        ObjProducts.SetRange(ObjProducts.Code, ProductCode);
        if ObjProducts.Find('-') then
            MinimumBalance := ObjProducts."Minimum Balance";
    end;

    local procedure FnGetMemberLoanBalance(LoanNo: Code[50]; DateFilter: Date; TotalBalance: Decimal)
    begin
        ObjLoans.Reset;
        ObjLoans.SetRange(ObjLoans."Loan  No.", LoanNo);
        ObjLoans.SetFilter(ObjLoans."Date filter", '..%1', DateFilter);
        if ObjMemberLedgerEntry.FindSet then begin
            TotalBalance := TotalBalance + ObjMemberLedgerEntry."Amount (LCY)";
        end;
    end;


    procedure FnGetTellerTillNo() TellerTillNo: Code[40]
    begin
        ObjBanks.Reset;
        ObjBanks.SetRange(ObjBanks."Account Type", ObjBanks."account type"::Cashier);
        ObjBanks.SetRange(ObjBanks.CashierID, UserId);
        if ObjBanks.Find('-') then begin
            TellerTillNo := ObjBanks."No.";
        end;
        exit(TellerTillNo);
    end;


    procedure FnGetMpesaAccount() TellerTillNo: Code[40]
    begin
        ObjBanks.Reset;
        ObjBanks.SetRange(ObjBanks."Account Type", ObjBanks."account type"::Cashier);
        ObjBanks.SetRange(ObjBanks."Bank Account Branch", FnGetUserBranch());
        if ObjBanks.Find('-') then begin
            TellerTillNo := ObjBanks."No.";
        end;
        exit(TellerTillNo);
    end;


    procedure FnGetChargeFee(ProductCode: Code[50]; InsuredAmount: Decimal; ChargeType: Code[100]) FCharged: Decimal
    begin
        if ObjLoanProductSetup.Get(ProductCode) then begin
            if ObjProductCharges."Loan Charge Type" = ObjProductCharges."Loan Charge Type"::"Loan Application Fee" then begin
                ;
                ObjProductCharges.Reset;
                ObjProductCharges.SetRange(ObjProductCharges."Product Code", ProductCode);
                ObjProductCharges.SetRange(ObjProductCharges.Code, ChargeType);
                if ObjProductCharges.Find('-') then begin
                    if ObjProductCharges."Use Perc" = true then begin
                        FCharged := InsuredAmount * (ObjProductCharges.Percentage / 100);
                    end
                    else begin
                        if ProductCode = 'DL' then
                            FCharged := ObjProductCharges."Development Application Fee"
                        else
                            if ProductCode = 'EM' then
                                FCharged := ObjProductCharges."Emergency Application Fee";
                    end;
                end;
            end;
            if ObjProductCharges."Loan Charge Type" = ObjProductCharges."Loan Charge Type"::"Loan Insurance" then begin
                ;
                ObjProductCharges.Reset;
                ObjProductCharges.SetRange(ObjProductCharges."Product Code", ProductCode);
                ObjProductCharges.SetRange(ObjProductCharges.Code, ChargeType);
                if ObjProductCharges.Find('-') then begin
                    if ObjProductCharges."Use Perc" = true then begin
                        FCharged := InsuredAmount * (ObjProductCharges.Percentage / 100);
                    end
                    else
                        FCharged := ObjProductCharges.Amount;
                end;
            end;
        end;
        exit(FCharged);
    end;


    procedure FnGetChargeAccount(ProductCode: Code[50]; MemberCategory: Option Single,Joint,Corporate,Group,Parish,Church,"Church Department",Staff; ChargeType: Code[100]) ChargeGLAccount: Code[50]
    begin
        if ObjLoanProductSetup.Get(ProductCode) then begin
            ObjProductCharges.Reset;
            ObjProductCharges.SetRange(ObjProductCharges."Product Code", ProductCode);
            ObjProductCharges.SetRange(ObjProductCharges.Code, ChargeType);
            if ObjProductCharges.Find('-') then begin
                ChargeGLAccount := ObjProductCharges."G/L Account";
            end;
        end;
        exit(ChargeGLAccount);
    end;

    local procedure FnUpdateMonthlyContributions()
    begin
        ObjMembers.Reset;
        ObjMembers.SetCurrentkey(ObjMembers."No.");
        ObjMembers.SetRange(ObjMembers."Monthly Contribution", 0.0);
        if ObjMembers.FindSet then begin
            repeat
                ObjMembers2."Monthly Contribution" := 500;
                ObjMembers2.Modify;
            until ObjMembers.Next = 0;
            Message('Succesfully done');
        end;


    end;


    procedure FnGetUserBranchB(varUserId: Code[100]) branchCode: Code[20]
    begin
        UserSetup.Reset;
        UserSetup.SetRange(UserSetup."User Name", varUserId);
        if UserSetup.Find('-') then begin
            //  branchCode := UserSetup."Branch Code";
        end;
        exit(branchCode);
    end;


    procedure FnGetMemberBranch(MemberNo: Code[100]) MemberBranch: Code[100]
    var
        ObjMemberLocal: Record Customer;
    begin
        ObjMemberLocal.Reset;
        ObjMemberLocal.SetRange(ObjMemberLocal."No.", MemberNo);
        if ObjMemberLocal.Find('-') then begin
            MemberBranch := ObjMemberLocal."Global Dimension 2 Code";
        end;
        exit(MemberBranch);
    end;

    local procedure FnReturnRetirementDate(MemberNo: Code[50]): Date
    var
        ObjMembers: Record Customer;
    begin
        ObjGenSetUp.Get();
        ObjMembers.Reset;
        ObjMembers.SetRange(ObjMembers."No.", MemberNo);
        if ObjMembers.Find('-') then
            Message(Format(CalcDate(ObjGenSetUp."Retirement Age", ObjMembers."Date of Birth")));
        exit(CalcDate(ObjGenSetUp."Retirement Age", ObjMembers."Date of Birth"));
    end;


    procedure FnGetTransferFee(DisbursementMode: Option " ",Cheque,"Bank Transfer",EFT,RTGS,"Cheque NonMember"): Decimal
    var
        TransferFee: Decimal;
    begin
        ObjGenSetUp.Get();
        case DisbursementMode of
            Disbursementmode::"Bank Transfer":
                TransferFee := ObjGenSetUp."Loan Trasfer Fee-FOSA";

            Disbursementmode::Cheque:
                TransferFee := ObjGenSetUp."Loan Trasfer Fee-Cheque";

            Disbursementmode::"Cheque NonMember":
                TransferFee := ObjGenSetUp."Loan Trasfer Fee-EFT";

            Disbursementmode::EFT:
                TransferFee := ObjGenSetUp."Loan Trasfer Fee-RTGS";
        end;
        exit(TransferFee);
    end;


    procedure FnGetFosaAccount(MemberNo: Code[50]) FosaAccount: Code[50]
    var
        ObjMembers: Record Customer;
    begin
        ObjMembers.Reset;
        ObjMembers.SetRange(ObjMembers."No.", MemberNo);
        if ObjMembers.Find('-') then begin
            FosaAccount := ObjMembers."FOSA Account No.";
        end;
        exit(FosaAccount);
    end;


    procedure FnClearGnlJournalLine(TemplateName: Text; BatchName: Text)
    var
        GenJournalLine: Record "Gen. Journal Line";
    begin
        GenJournalLine.Reset;
        GenJournalLine.SetRange(GenJournalLine."Journal Template Name", TemplateName);
        GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", BatchName);
        if GenJournalLine.FindSet then begin
            GenJournalLine.DeleteAll;
        end;
    end;


    procedure FnPostGnlJournalLine(TemplateName: Text; BatchName: Text)
    var
        GenJournalLine: Record "Gen. Journal Line";
    begin
        GenJournalLine.Reset;
        GenJournalLine.SetRange(GenJournalLine."Journal Template Name", TemplateName);
        GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", BatchName);
        if GenJournalLine.FindSet then begin
            Codeunit.Run(Codeunit::"Gen. Jnl.-Post Line", GenJournalLine);
        end;
    end;


    procedure FnCreateGnlJournalLineBalanced(TemplateName: Text; BatchName: Text; DocumentNo: Code[30]; LineNo: Integer; TransactionType: Option " ","Registration Fee","Share Capital","Interest Paid","Loan Repayment","Deposit Contribution","Insurance Contribution","Benevolent Fund",Loan,"Unallocated Funds",Dividend,"FOSA Account","Loan Insurance Charged","Loan Insurance Paid"; AccountType: enum "Gen. Journal Account Type"; AccountNo: Code[50]; TransactionDate: Date; TransactionDescription: Text; BalancingAccountType: Enum "Gen. Journal Account Type"; BalancingAccountNo: Code[50]; TransactionAmount: Decimal; DimensionActivity: Code[40]; LoanNo: Code[20])
    var
        GenJournalLine: Record "Gen. Journal Line";
    begin
        GenJournalLine.Init;
        GenJournalLine."Journal Template Name" := TemplateName;
        GenJournalLine."Journal Batch Name" := BatchName;
        GenJournalLine."Document No." := DocumentNo;
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Transaction Type" := TransactionType;
        GenJournalLine."Account Type" := AccountType;
        GenJournalLine."Account No." := AccountNo;
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Posting Date" := TransactionDate;
        GenJournalLine.Description := TransactionDescription;
        GenJournalLine.Validate(GenJournalLine."Currency Code");
        GenJournalLine.Amount := TransactionAmount;
        GenJournalLine."Loan No" := LoanNo;
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Bal. Account Type" := BalancingAccountType;
        GenJournalLine."Bal. Account No." := BalancingAccountNo;
        GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
        GenJournalLine."Shortcut Dimension 1 Code" := DimensionActivity;
        GenJournalLine."Shortcut Dimension 2 Code" := FnGetUserBranch();
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert;
    end;


    procedure FnChargeExcise(ChargeCode: Code[100]): Boolean
    var
        ObjProductCharges: Record "Loan Charges";
    begin
        ObjProductCharges.Reset;
        ObjProductCharges.SetRange(Code, ChargeCode);
        if ObjProductCharges.Find('-') then
            exit(ObjProductCharges."Charge Excise");
    end;


    procedure FnGetInterestDueTodate(ObjLoans: Record "Loans Register"): Decimal
    var
        ObjLoanRegister: Record "Loans Register";
    begin
        ObjLoans.SetFilter("Date filter", '..' + Format(Today));
        ObjLoans.CalcFields("Schedule Interest to Date", "Outstanding Balance");
        exit(ObjLoans."Schedule Interest to Date");
    end;


    procedure FnGetPhoneNumber(ObjLoans: Record "Loans Register"): Code[50]
    begin
        ObjMembers.Reset;
        ObjMembers.SetRange("No.", ObjLoans."Client Code");
        if ObjMembers.Find('-') then
            exit(ObjMembers."Mobile Phone No");
    end;

    local procedure FnBoosterLoansDisbursement(ObjLoanDetails: Record "Loans Register"): Code[40]
    var
        GenJournalLine: Record "Gen. Journal Line";
        CUNoSeriesManagement: Codeunit NoSeriesManagement;
        DocNumber: Code[100];
        loanTypes: Record "Loan Products Setup";
        ObjLoanX: Record "Loans Register";
        LoansRec: Record "Loans Register";
        Cust: Record Customer;
    begin
        loanTypes.Reset;
        loanTypes.SetRange(loanTypes.Code, 'BLOAN');
        if loanTypes.Find('-') then begin
            DocNumber := CUNoSeriesManagement.GetNextNo('LOANSB', 0D, true);
            LoansRec.Init;
            LoansRec."Loan  No." := DocNumber;
            // LoansRec.INSERT;

            if LoansRec.Get('BLN_00041') then begin
                LoansRec."Client Code" := ObjLoanDetails."Client Code";
                LoansRec.Validate(LoansRec."Client Code");
                LoansRec."Loan Product Type" := 'BLOAN';
                LoansRec.Validate(LoansRec."Loan Product Type");
                LoansRec.Interest := ObjLoanDetails.Interest;
                LoansRec."Loan Status" := LoansRec."loan status"::Closed;
                LoansRec."Application Date" := ObjLoanDetails."Application Date";
                LoansRec."Issued Date" := ObjLoanDetails."Posting Date";
                LoansRec."Loan Disbursement Date" := ObjLoanDetails."Loan Disbursement Date";
                LoansRec.Validate(LoansRec."Loan Disbursement Date");
                LoansRec."Mode of Disbursement" := LoansRec."mode of disbursement"::"FOSA Account";
                LoansRec."Repayment Start Date" := ObjLoanDetails."Repayment Start Date";
                LoansRec."Global Dimension 1 Code" := 'BOSA';
                LoansRec."Global Dimension 2 Code" := FnGetUserBranch();
                LoansRec.Source := ObjLoanDetails.Source;
                LoansRec."Approval Status" := ObjLoanDetails."Approval Status";
                LoansRec.Repayment := ObjLoanDetails."Boosted Amount";
                LoansRec."Requested Amount" := ObjLoanDetails."Boosted Amount";
                LoansRec."Approved Amount" := ObjLoanDetails."Boosted Amount";
                LoansRec.Interest := ObjLoanDetails.Interest;
                LoansRec."Mode of Disbursement" := LoansRec."mode of disbursement"::"FOSA Account";
                LoansRec.Posted := true;
                LoansRec."Advice Date" := Today;
                LoansRec.Modify;
            end;
        end;
        exit(DocNumber);
    end;

    local procedure FnGenerateRepaymentSchedule(LoanNumber: Code[50])
    var
        LoansRec: Record "Loans Register";
        RSchedule: Record "Loan Repayment Schedule";
        LoanAmount: Decimal;
        InterestRate: Decimal;
        RepayPeriod: Integer;
        InitialInstal: Decimal;
        LBalance: Decimal;
        RunDate: Date;
        InstalNo: Decimal;
        TotalMRepay: Decimal;
        LInterest: Decimal;
        LPrincipal: Decimal;
        GrPrinciple: Integer;
        GrInterest: Integer;
        RepayCode: Code[10];
        WhichDay: Integer;
    begin
        LoansRec.Reset;
        LoansRec.SetRange(LoansRec."Loan  No.", LoanNumber);
        LoansRec.SetFilter(LoansRec."Approved Amount", '>%1', 0);
        LoansRec.SetFilter(LoansRec.Posted, '=%1', true);
        if LoansRec.Find('-') then begin
            if (LoansRec."Loan Product Type" = 'DEFAULTER') and (LoansRec."Issued Date" <> 0D) and (LoansRec."Repayment Start Date" <> 0D) then begin
                LoansRec.TestField(LoansRec."Loan Disbursement Date");
                LoansRec.TestField(LoansRec."Repayment Start Date");

                RSchedule.Reset;
                RSchedule.SetRange(RSchedule."Loan No.", LoansRec."Loan  No.");
                RSchedule.DeleteAll;

                LoanAmount := LoansRec."Approved Amount";
                InterestRate := LoansRec.Interest;
                RepayPeriod := LoansRec.Installments;
                InitialInstal := LoansRec.Installments + LoansRec."Grace Period - Principle (M)";
                LBalance := LoansRec."Approved Amount";
                RunDate := LoansRec."Repayment Start Date";
                InstalNo := 0;

                //Repayment Frequency
                if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Daily then
                    RunDate := CalcDate('-1D', RunDate)
                else
                    if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Weekly then
                        RunDate := CalcDate('-1W', RunDate)
                    else
                        if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Monthly then
                            RunDate := CalcDate('-1M', RunDate)
                        else
                            if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Quaterly then
                                RunDate := CalcDate('-1Q', RunDate);
                //Repayment Frequency


                repeat
                    InstalNo := InstalNo + 1;
                    //Repayment Frequency
                    if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Daily then
                        RunDate := CalcDate('1D', RunDate)
                    else
                        if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Weekly then
                            RunDate := CalcDate('1W', RunDate)
                        else
                            if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Monthly then
                                RunDate := CalcDate('1M', RunDate)
                            else
                                if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Quaterly then
                                    RunDate := CalcDate('1Q', RunDate);

                    if LoansRec."Repayment Method" = LoansRec."repayment method"::Amortised then begin
                        //LoansRec.TESTFIELD(LoansRec.Interest);
                        LoansRec.TestField(LoansRec.Installments);
                        TotalMRepay := ROUND((InterestRate / 12 / 100) / (1 - Power((1 + (InterestRate / 12 / 100)), -(RepayPeriod))) * (LoanAmount), 0.0001, '>');
                        LInterest := ROUND(LBalance / 100 / 12 * InterestRate, 0.0001, '>');
                        LPrincipal := TotalMRepay - LInterest;
                    end;

                    if LoansRec."Repayment Method" = LoansRec."repayment method"::"Straight Line" then begin
                        LoansRec.TestField(LoansRec.Interest);
                        LoansRec.TestField(LoansRec.Installments);
                        LPrincipal := LoanAmount / RepayPeriod;
                        LInterest := (InterestRate / 12 / 100) * LoanAmount / RepayPeriod;
                    end;

                    if LoansRec."Repayment Method" = LoansRec."repayment method"::"Reducing Balance" then begin
                        LoansRec.TestField(LoansRec.Interest);
                        LoansRec.TestField(LoansRec.Installments);
                        LPrincipal := LoanAmount / RepayPeriod;
                        LInterest := (InterestRate / 12 / 100) * LBalance;
                    end;

                    if LoansRec."Repayment Method" = LoansRec."repayment method"::Constants then begin
                        LoansRec.TestField(LoansRec.Repayment);
                        if LBalance < LoansRec.Repayment then
                            LPrincipal := LBalance
                        else
                            LPrincipal := LoansRec.Repayment;
                        LInterest := LoansRec.Interest;
                    end;

                    //Grace Period
                    if GrPrinciple > 0 then begin
                        LPrincipal := 0
                    end else begin
                        LBalance := LBalance - LPrincipal;

                    end;

                    if GrInterest > 0 then
                        LInterest := 0;

                    GrPrinciple := GrPrinciple - 1;
                    GrInterest := GrInterest - 1;
                    Evaluate(RepayCode, Format(InstalNo));


                    RSchedule.Init;
                    RSchedule."Repayment Code" := RepayCode;
                    RSchedule."Interest Rate" := InterestRate;
                    RSchedule."Loan No." := LoansRec."Loan  No.";
                    RSchedule."Loan Amount" := LoanAmount;
                    RSchedule."Instalment No" := InstalNo;
                    RSchedule."Repayment Date" := RunDate;
                    RSchedule."Member No." := LoansRec."Client Code";
                    RSchedule."Loan Category" := LoansRec."Loan Product Type";
                    RSchedule."Monthly Repayment" := LInterest + LPrincipal;
                    RSchedule."Monthly Interest" := LInterest;
                    RSchedule."Principal Repayment" := LPrincipal;
                    RSchedule.Insert;
                    WhichDay := Date2dwy(RSchedule."Repayment Date", 1);
                until LBalance < 1

            end;
        end;

        Commit;
    end;


    procedure FnGetInterestDueFiltered(ObjLoans: Record "Loans Register"; DateFilter: Text): Decimal
    var
        ObjLoanRegister: Record "Loans Register";
    begin
        ObjLoans.SetFilter("Date filter", DateFilter);
        ObjLoans.CalcFields("Schedule Interest to Date", "Outstanding Balance");
        exit(ObjLoans."Schedule Interest to Date");
    end;


    procedure FnGetPAYEBudCharge(ChargeCode: Code[10]): Decimal
    var
        ObjpayeCharges: Record "PAYE Brackets Credit";
    begin
        ObjpayeCharges.Reset;
        ObjpayeCharges.SetRange("Tax Band", ChargeCode);
        if ObjpayeCharges.FindFirst then
            exit(ObjpayeCharges."Taxable Amount" * ObjpayeCharges.Percentage / 100);
    end;


    procedure FnPayeRate(ChargeCode: Code[10]): Decimal
    var
        ObjpayeCharges: Record "PAYE Brackets Credit";
    begin
        ObjpayeCharges.Reset;
        ObjpayeCharges.SetRange("Tax Band", ChargeCode);
        if ObjpayeCharges.FindFirst then
            exit(ObjpayeCharges.Percentage / 100);
    end;


    procedure FnCalculatePaye(Chargeable: Decimal) PAYE: Decimal
    var
        TAXABLEPAY: Record "PAYE Brackets Credit";
        Taxrelief: Decimal;
        OTrelief: Decimal;
    begin
        PAYE := 0;
        if TAXABLEPAY.Find('-') then begin
            repeat
                if Chargeable > 0 then begin
                    case TAXABLEPAY."Tax Band" of
                        '01':
                            begin
                                if Chargeable > TAXABLEPAY."Upper Limit" then begin
                                    BAND1 := FnGetPAYEBudCharge('01');
                                    Chargeable := Chargeable - TAXABLEPAY."Taxable Amount";
                                end else begin
                                    if Chargeable > TAXABLEPAY."Taxable Amount" then begin
                                        BAND1 := FnGetPAYEBudCharge('01');
                                        Chargeable := Chargeable - TAXABLEPAY."Taxable Amount";
                                    end else begin
                                        BAND1 := Chargeable * FnPayeRate('01');
                                        Chargeable := 0;
                                    end;
                                end;
                            end;
                        '02':
                            begin
                                if Chargeable > TAXABLEPAY."Upper Limit" then begin
                                    BAND2 := FnGetPAYEBudCharge('02');
                                    Chargeable := Chargeable - TAXABLEPAY."Taxable Amount";
                                end else begin
                                    if Chargeable > TAXABLEPAY."Taxable Amount" then begin
                                        BAND2 := FnGetPAYEBudCharge('02');
                                        Chargeable := Chargeable - TAXABLEPAY."Taxable Amount";
                                    end else begin
                                        BAND2 := Chargeable * FnPayeRate('02');
                                        Chargeable := 0;
                                    end;
                                end;
                            end;
                        '03':
                            begin
                                if Chargeable > TAXABLEPAY."Upper Limit" then begin
                                    BAND3 := FnGetPAYEBudCharge('03');
                                    Chargeable := Chargeable - TAXABLEPAY."Taxable Amount";
                                end else begin
                                    if Chargeable > TAXABLEPAY."Taxable Amount" then begin
                                        BAND3 := FnGetPAYEBudCharge('03');
                                        Chargeable := Chargeable - TAXABLEPAY."Taxable Amount";
                                    end else begin
                                        BAND3 := Chargeable * FnPayeRate('03');
                                        Chargeable := 0;
                                    end;
                                end;
                            end;
                        '04':
                            begin
                                if Chargeable > TAXABLEPAY."Upper Limit" then begin
                                    BAND4 := FnGetPAYEBudCharge('04');
                                    Chargeable := Chargeable - TAXABLEPAY."Taxable Amount";
                                end else begin
                                    if Chargeable > TAXABLEPAY."Taxable Amount" then begin
                                        BAND4 := FnGetPAYEBudCharge('04');
                                        Chargeable := Chargeable - TAXABLEPAY."Taxable Amount";
                                    end else begin
                                        BAND4 := Chargeable * FnPayeRate('04');
                                        Chargeable := 0;
                                    end;
                                end;
                            end;
                        '05':
                            begin
                                BAND5 := Chargeable * FnPayeRate('05');
                            end;
                    end;
                end;
            until TAXABLEPAY.Next = 0;
        end;
        exit(BAND1 + BAND2 + BAND3 + BAND4 + BAND5 - 1280);
    end;


    procedure FnGetUpfrontsTotal(ProductCode: Code[50]; InsuredAmount: Decimal) FCharged: Decimal
    var
        ObjLoanCharges: Record "Loan Charges";
    begin
        ObjProductCharges.Reset;
        ObjProductCharges.SetRange(ObjProductCharges."Product Code", ProductCode);
        if ObjProductCharges.Find('-') then begin
            repeat
                if ObjProductCharges."Use Perc" = true then begin
                    FCharged := InsuredAmount * (ObjProductCharges.Percentage / 100) + FCharged;
                    if ObjLoanCharges.Get(ObjProductCharges.Code) then begin
                        if ObjLoanCharges."Charge Excise" = true then
                            FCharged := FCharged + (InsuredAmount * (ObjProductCharges.Percentage / 100)) * 0.1;
                    end
                end
                else begin
                    FCharged := ObjProductCharges.Amount + FCharged;
                    if ObjLoanCharges.Get(ObjProductCharges.Code) then begin
                        if ObjLoanCharges."Charge Excise" = true then
                            FCharged := FCharged + ObjProductCharges.Amount * 0.1;
                    end
                end

            until ObjProductCharges.Next = 0;
        end;

        exit(FCharged);
    end;


    procedure FnGetPrincipalDueFiltered(ObjLoans: Record "Loans Register"; DateFilter: Text): Decimal
    var
        ObjLoanRegister: Record "Loans Register";
    begin
        ObjLoans.SetFilter("Date filter", DateFilter);
        ObjLoans.CalcFields("Scheduled Principal to Date", "Outstanding Balance");
        exit(ObjLoans."Scheduled Principal to Date");
    end;


    procedure FnCreateMembershipWithdrawalApplication(MemberNo: Code[20]; ApplicationDate: Date; Reason: Option Relocation,"Financial Constraints","House/Group Challages","Join another Institution","Personal Reasons",Other; ClosureDate: Date)
    begin
        PostingDate := WorkDate;
        /*ObjSalesSetup.GET;
        
        ObjNextNo:=ObjNoSeriesManagement.TryGetNextNo(ObjSalesSetup."Closure  Nos",PostingDate);
          ObjNoSeries.RESET;
          ObjNoSeries.SETRANGE(ObjNoSeries."Series Code",ObjSalesSetup."Closure  Nos");
          IF ObjNoSeries.FINDSET THEN BEGIN
            ObjNoSeries."Last No. Used":=INCSTR(ObjNoSeries."Last No. Used");
            ObjNoSeries."Last Date Used":=TODAY;
            ObjNoSeries.MODIFY;
          END;
        
        
        ObjMembershipWithdrawal.INIT;
        ObjMembershipWithdrawal."No.":=ObjNextNo;
        ObjMembershipWithdrawal."Member No.":=MemberNo;
        //IF ObjMembers.GET(MemberNo) THEN BEGIN
         // ObjMembershipWithdrawal."Member Name":=ObjMembers.Name;
        //END;
        ObjMembershipWithdrawal."Withdrawal Application Date":=ApplicationDate;
        ObjMembershipWithdrawal."Closing Date":=ClosureDate;
        ObjMembershipWithdrawal."Reason For Withdrawal":=Reason;
        ObjMembershipWithdrawal.INSERT;
        
        ObjMembershipWithdrawal.VALIDATE(ObjMembershipWithdrawal."Member No.");
        ObjMembershipWithdrawal.MODIFY;*/

        if ObjMembers.Get(MemberNo) then begin
            ObjMembers.Status := ObjMembers.Status::"Awaiting Exit";
            ObjMembers.Modify;
        end;

        Message('The Member has been marked as awaiting exit.');

    end;

    local procedure FnGetDepreciationValueofCollateral()
    begin
    end;


    procedure FnGetLoanAmountinArrears(VarLoanNo: Code[20]) VarArrears: Decimal
    begin
        VarRepaymentPeriod := WorkDate;

        ObjLoans.Reset;
        ObjLoans.SetRange(ObjLoans."Loan  No.", VarLoanNo);
        if ObjLoans.FindSet then begin
            ObjLoans.CalcFields(ObjLoans."Outstanding Balance", ObjLoans."Interest Due", ObjLoans."Interest Paid", ObjLoans."Penalty Charged");
            VarLoanNo := ObjLoans."Loan  No.";

            //================Get Last Day of the previous month===================================
            if ObjLoans."Repayment Frequency" = ObjLoans."repayment frequency"::Monthly then begin
                if VarRepaymentPeriod = CalcDate('CM', VarRepaymentPeriod) then begin
                    VarLastMonth := VarRepaymentPeriod;
                end else begin
                    VarLastMonth := CalcDate('-1M', VarRepaymentPeriod);
                end;
                VarLastMonth := CalcDate('CM', VarLastMonth);
            end;
            VarDate := 1;
            VarMonth := Date2dmy(VarLastMonth, 2);
            VarYear := Date2dmy(VarLastMonth, 3);
            VarLastMonthBeginDate := Dmy2date(VarDate, VarMonth, VarYear);
            VarScheduleDateFilter := Format(VarLastMonthBeginDate) + '..' + Format(VarLastMonth);
            //End ===========Get Last Day of the previous month==========================================


            //================Get Scheduled Balance=======================================================
            ObjLSchedule.Reset;
            ObjLSchedule.SetRange(ObjLSchedule."Loan No.", VarLoanNo);
            ObjLSchedule.SetRange(ObjLSchedule."Close Schedule", false);
            ObjLSchedule.SetFilter(ObjLSchedule."Repayment Date", VarScheduleDateFilter);
            if ObjLSchedule.FindFirst then begin
                VarScheduledLoanBal := ObjLSchedule."Loan Balance";
                VarScheduleRepayDate := ObjLSchedule."Repayment Date";
            end;

            ObjLSchedule.Reset;
            ObjLSchedule.SetCurrentkey(ObjLSchedule."Repayment Date");
            ObjLSchedule.SetRange(ObjLSchedule."Loan No.", VarLoanNo);
            ObjLSchedule.SetRange(ObjLSchedule."Close Schedule", false);
            if ObjLSchedule.FindLast then begin
                if ObjLSchedule."Repayment Date" < Today then begin
                    VarScheduledLoanBal := ObjLSchedule."Loan Balance";
                    VarScheduleRepayDate := ObjLSchedule."Repayment Date";
                end;
            end;
            //================End Get Scheduled Balance====================================================

            //================Get Loan Bal as per the date filter===========================================
            if VarScheduleRepayDate <> 0D then begin
                VarDateFilter := '..' + Format(VarScheduleRepayDate);
                ObjLoans.SetFilter(ObjLoans."Date filter", VarDateFilter);
                ObjLoans.CalcFields(ObjLoans."Outstanding Balance");
                VarLBal := ObjLoans."Outstanding Balance";
                //===============End Get Loan Bal as per the date filter=========================================

                VarLBal := ObjLoans."Outstanding Balance";

                //============Amount in Arrears================================================================
                VarArrears := VarScheduledLoanBal - VarLBal;
                if (VarArrears > 0) or (VarArrears = 0) then begin
                    VarArrears := 0
                end else
                    VarArrears := VarArrears;
            end;
        end;
        exit(VarArrears * -1);
    end;


    procedure FnCreateGnlJournalLineGuarantorRecovery(TemplateName: Text; BatchName: Text; DocumentNo: Code[30]; LineNo: Integer; TransactionType: Option " ","Registration Fee","Share Capital","Interest Paid","Loan Repayment","Deposit Contribution","Insurance Contribution","Benevolent Fund",Loan,"Unallocated Funds",Dividend,"FOSA Account"; AccountType: Enum "Gen. Journal Account Type"; AccountNo: Code[50]; TransactionDate: Date; TransactionAmount: Decimal; DimensionActivity: Code[40]; ExternalDocumentNo: Code[50]; TransactionDescription: Text; LoanNumber: Code[50]; VarRecoveryType: Option Normal,"Guarantor Recoverd","Guarantor Paid"; VarLoanRecovered: Code[20])
    var
        GenJournalLine: Record "Gen. Journal Line";
    begin
        GenJournalLine.Init;
        GenJournalLine."Journal Template Name" := TemplateName;
        GenJournalLine."Journal Batch Name" := BatchName;
        GenJournalLine."Document No." := DocumentNo;
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Account Type" := AccountType;
        GenJournalLine."Account No." := AccountNo;
        GenJournalLine."Transaction Type" := TransactionType;
        GenJournalLine."Loan No" := LoanNumber;
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Posting Date" := TransactionDate;
        GenJournalLine.Description := TransactionDescription;
        GenJournalLine.Validate(GenJournalLine."Currency Code");
        GenJournalLine.Amount := TransactionAmount;
        GenJournalLine."External Document No." := ExternalDocumentNo;
        GenJournalLine."Recovery Transaction Type" := VarRecoveryType;
        GenJournalLine."Recoverd Loan" := VarLoanRecovered;
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Shortcut Dimension 1 Code" := DimensionActivity;
        GenJournalLine."Shortcut Dimension 2 Code" := FnGetUserBranch();
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert;
    end;


    procedure FnGetMemberApplicationAMLRiskRating(MemberNo: Code[20])
    var
        VarCategoryScore: Integer;
        VarResidencyScore: Integer;
        VarNatureofBusinessScore: Integer;
        VarEntityScore: Integer;
        VarIndustryScore: Integer;
        VarLenghtOfRelationshipScore: Integer;
        VarInternationalTradeScore: Integer;
        VarElectronicPaymentScore: Integer;
        VarCardTypeScore: Integer;
        VarAccountTypeScore: Integer;
        VarChannelTakenScore: Integer;
        VarAccountTypeOption: Option "International Wire Transfers","Local Wire Transfers","Mobile Transfers","None of the Above","Fixed/Call Deposit Accounts","KSA/Imara/MJA/Heritage)","Account with Sealed Safe deposit","Account with  Open Safe Deposit","All Loan Accounts",BOSA," Ufalme","ATM Debit",Credit,Both,"None","Non-face to face channels","Unsolicited Account Origination e.g. Walk-Ins","Cheque book",Others;
        MemberTotalRiskRatingScore: Decimal;
        MemberNetRiskScore: Decimal;
        ObjMemberDueDiligence: Record "Member Due Diligence Measures";
        ObjDueDiligenceSetup: Record "Due Diligence Measures";
        VarRiskRatingDescription: Text[50];
        VarRefereeScore: Decimal;
        VarRefereeRiskRate: Text;
        ObjRefereeSetup: Record "Referee Risk Rating Scale";
        ObjMemberRiskRate: Record "Individual Customer Risk Rate";
        ObjControlRiskRating: Record "Control Risk Rating";
        VarControlRiskRating: Decimal;
        VarAccountTypeScoreVer1: Decimal;
        VarAccountTypeScoreVer2: Decimal;
        VarAccountTypeScoreVer3: Decimal;
        VarAccountTypeOptionVer1: Option "International Wire Transfers","Local Wire Transfers","Mobile Transfers","None of the Above","Fixed/Call Deposit Accounts","KSA/Imara/MJA/Heritage)","Account with Sealed Safe deposit","Account with  Open Safe Deposit","All Loan Accounts",BOSA," Ufalme","ATM Debit",Credit,Both,"None","Non-face to face channels","Unsolicited Account Origination e.g. Walk-Ins","Cheque book",Others;
        VarAccountTypeOptionVer2: Option "International Wire Transfers","Local Wire Transfers","Mobile Transfers","None of the Above","Fixed/Call Deposit Accounts","KSA/Imara/MJA/Heritage)","Account with Sealed Safe deposit","Account with  Open Safe Deposit","All Loan Accounts",BOSA," Ufalme","ATM Debit",Credit,Both,"None","Non-face to face channels","Unsolicited Account Origination e.g. Walk-Ins","Cheque book",Others;
        VarAccountTypeOptionVer3: Option "International Wire Transfers","Local Wire Transfers","Mobile Transfers","None of the Above","Fixed/Call Deposit Accounts","KSA/Imara/MJA/Heritage)","Account with Sealed Safe deposit","Account with  Open Safe Deposit","All Loan Accounts",BOSA," Ufalme","ATM Debit",Credit,Both,"None","Non-face to face channels","Unsolicited Account Origination e.g. Walk-Ins","Cheque book",Others;
    begin


        ObjMembershipApplication.Reset;
        ObjMembershipApplication.SetRange(ObjMembershipApplication."No.", MemberNo);
        if ObjMembershipApplication.FindSet then begin
            ObjCustRiskRates.Reset;
            ObjCustRiskRates.SetRange(ObjCustRiskRates.Category, ObjCustRiskRates.Category::Individuals);
            ObjCustRiskRates.SetRange(ObjCustRiskRates."Sub Category", ObjMembershipApplication."Individual Category");
            if ObjCustRiskRates.FindSet then begin
                VarCategoryScore := ObjCustRiskRates."Risk Score";
            end;
        end;


        ObjMembershipApplication.Reset;
        ObjMembershipApplication.SetRange(ObjMembershipApplication."No.", MemberNo);
        if ObjMembershipApplication.FindSet then begin
            ObjCustRiskRates.Reset;
            ObjCustRiskRates.SetRange(ObjCustRiskRates.Category, ObjCustRiskRates.Category::Entities);
            ObjCustRiskRates.SetRange(ObjCustRiskRates."Sub Category", ObjMembershipApplication.Entities);
            if ObjCustRiskRates.FindSet then begin
                VarEntityScore := ObjCustRiskRates."Risk Score";
            end;
        end;

        ObjMembershipApplication.Reset;
        ObjMembershipApplication.SetRange(ObjMembershipApplication."No.", MemberNo);
        if ObjMembershipApplication.FindSet then begin
            ObjCustRiskRates.Reset;
            ObjCustRiskRates.SetRange(ObjCustRiskRates.Category, ObjCustRiskRates.Category::"Residency Status");
            ObjCustRiskRates.SetRange(ObjCustRiskRates."Sub Category", ObjMembershipApplication."Member Residency Status");
            if ObjCustRiskRates.FindSet then begin
                VarResidencyScore := ObjCustRiskRates."Risk Score";
            end;
        end;


        ObjMembershipApplication.Reset;
        ObjMembershipApplication.SetRange(ObjMembershipApplication."No.", MemberNo);
        if ObjMembershipApplication.FindSet then begin
            //=============================================================Exisiting Referee
            ObjMemberRiskRate.Reset;
            ObjMemberRiskRate.SetRange(ObjMemberRiskRate."Membership Application No", ObjMembershipApplication."Referee Member No");
            if ObjMemberRiskRate.FindSet then begin
                if ObjMembershipApplication."Referee Member No" <> '' then begin

                    ObjRefereeSetup.Reset;
                    if ObjRefereeSetup.FindSet then begin
                        repeat
                            if (ObjMemberRiskRate."GROSS CUSTOMER AML RISK RATING" >= ObjRefereeSetup."Minimum Risk Rate") and
                              (ObjMemberRiskRate."GROSS CUSTOMER AML RISK RATING" <= ObjRefereeSetup."Maximum Risk Rate") then begin
                                VarRefereeScore := ObjRefereeSetup.Score;
                                VarRefereeRiskRate := ObjRefereeSetup.Description;
                            end;
                        until ObjRefereeSetup.Next = 0;
                    end;
                end;

                //=============================================================No Referee
                if ObjMembershipApplication."Referee Member No" = '' then begin
                    ObjRefereeSetup.Reset;
                    ObjRefereeSetup.SetFilter(ObjRefereeSetup.Description, '%1', 'Others with no referee');
                    if ObjRefereeSetup.FindSet then begin
                        VarRefereeScore := ObjRefereeSetup.Score;
                        VarRefereeRiskRate := 'Others with no referee';
                    end;
                end;
            end;


            ObjCustRiskRates.Reset;
            ObjCustRiskRates.SetRange(ObjCustRiskRates.Category, ObjCustRiskRates.Category::"Residency Status");
            ObjCustRiskRates.SetRange(ObjCustRiskRates."Sub Category", ObjMembershipApplication."Member Residency Status");
            if ObjCustRiskRates.FindSet then begin
                VarResidencyScore := ObjCustRiskRates."Risk Score";
            end;
        end;

        ObjMembershipApplication.Reset;
        ObjMembershipApplication.SetRange(ObjMembershipApplication."No.", MemberNo);
        if ObjMembershipApplication.FindSet then begin
            ObjCustRiskRates.Reset;
            ObjCustRiskRates.SetRange(ObjCustRiskRates.Category, ObjCustRiskRates.Category::Industry);
            ObjCustRiskRates.SetRange(ObjCustRiskRates."Sub Category", ObjMembershipApplication."Industry Type");
            if ObjCustRiskRates.FindSet then begin
                VarIndustryScore := ObjCustRiskRates."Risk Score";
            end;
        end;

        ObjMembershipApplication.Reset;
        ObjMembershipApplication.SetRange(ObjMembershipApplication."No.", MemberNo);
        if ObjMembershipApplication.FindSet then begin
            ObjCustRiskRates.Reset;
            ObjCustRiskRates.SetRange(ObjCustRiskRates.Category, ObjCustRiskRates.Category::"Length Of Relationship");
            ObjCustRiskRates.SetRange(ObjCustRiskRates."Sub Category", ObjMembershipApplication."Length Of Relationship");
            if ObjCustRiskRates.FindSet then begin
                VarLenghtOfRelationshipScore := ObjCustRiskRates."Risk Score";
            end;
        end;

        ObjMembershipApplication.Reset;
        ObjMembershipApplication.SetRange(ObjMembershipApplication."No.", MemberNo);
        if ObjMembershipApplication.FindSet then begin
            ObjCustRiskRates.Reset;
            ObjCustRiskRates.SetRange(ObjCustRiskRates.Category, ObjCustRiskRates.Category::"International Trade");
            ObjCustRiskRates.SetRange(ObjCustRiskRates."Sub Category", ObjMembershipApplication."International Trade");
            if ObjCustRiskRates.FindSet then begin
                VarInternationalTradeScore := ObjCustRiskRates."Risk Score";
            end;
        end;


        ObjMembershipApplication.Reset;
        ObjMembershipApplication.SetRange(ObjMembershipApplication."No.", MemberNo);
        if ObjMembershipApplication.FindSet then begin
            ObjProductRiskRating.Reset;
            ObjProductRiskRating.SetCurrentkey(ObjProductRiskRating."Product Type Code");
            ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Category", ObjProductRiskRating."product category"::"Electronic Payment");
            ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Type Code", ObjMembershipApplication."Electronic Payment");
            if ObjProductRiskRating.FindSet then begin
                VarElectronicPaymentScore := ObjProductRiskRating."Risk Score";
            end;
        end;


        //ObjProductRiskRating.GET();
        ObjMembershipApplication.Reset;
        ObjMembershipApplication.SetRange(ObjMembershipApplication."No.", MemberNo);
        if ObjMembershipApplication.FindSet then begin

            ObjProductRiskRating.Reset;
            ObjProductRiskRating.SetCurrentkey(ObjProductRiskRating."Product Type Code");
            ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Category", ObjProductRiskRating."product category"::Cards);
            ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Type Code", ObjMembershipApplication."Cards Type Taken");
            if ObjProductRiskRating.FindSet then begin
                VarCardTypeScore := ObjProductRiskRating."Risk Score";
            end;
        end;

        ObjProductRiskRating.Reset;
        ObjProductRiskRating.SetCurrentkey(ObjProductRiskRating."Product Type Code");
        ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Category", ObjProductRiskRating."product category"::Accounts);
        ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Type Code", ObjMembershipApplication."Accounts Type Taken");
        if ObjProductRiskRating.FindSet then begin
            VarAccountTypeScore := ObjProductRiskRating."Risk Score";
        end;

        ObjProductRiskRating.Reset;
        ObjProductRiskRating.SetCurrentkey(ObjProductRiskRating."Product Type Code");
        ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Category", ObjProductRiskRating."product category"::Others);
        ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Type Code", ObjMembershipApplication."Others(Channels)");
        if ObjProductRiskRating.FindSet then begin
            VarChannelTakenScore := ObjProductRiskRating."Risk Score";
        end;

        ObjProductsApp.Reset;
        ObjProductsApp.SetRange(ObjProductsApp."Membership Applicaton No", MemberNo);
        ObjProductsApp.SetFilter(ObjProductsApp."Product Source", '<>%1', ObjProductsApp."product source"::FOSA);
        if ObjProductsApp.FindSet then begin
            repeat
                ObjProductRiskRating.Reset;
                ObjProductRiskRating.SetCurrentkey(ObjProductRiskRating."Product Type");
                ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Category", ObjProductRiskRating."product category"::Accounts);
                ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Type", ObjProductRiskRating."product type"::Credit);
                if ObjProductRiskRating.FindSet then begin
                    VarAccountTypeScoreVer1 := ObjProductRiskRating."Risk Score";
                    VarAccountTypeOptionVer1 := ObjProductRiskRating."product type"::Credit;
                    VarAccountTypeScore := ObjProductRiskRating."Risk Score";
                    VarAccountTypeOption := ObjProductRiskRating."product type"::Credit;
                end;
            until ObjProductsApp.Next = 0;
        end;

        ObjProductsApp.Reset;
        ObjProductsApp.SetRange(ObjProductsApp."Membership Applicaton No", MemberNo);
        ObjProductsApp.SetFilter(ObjProductsApp."Product Source", '%1', ObjProductsApp."product source"::FOSA);
        ObjProductsApp.SetFilter(ObjProductsApp.Product, '<>%1|%2', '503', '506');
        if ObjProductsApp.FindSet then begin

            repeat
                ObjProductRiskRating.Reset;
                ObjProductRiskRating.SetCurrentkey(ObjProductRiskRating."Product Type");
                ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Category", ObjProductRiskRating."product category"::Accounts);
                ObjProductRiskRating.SetFilter(ObjProductRiskRating."Product Type Code", '%1', 'FOSA (KSA, Imara, Heritage, MJA)');
                if ObjProductRiskRating.FindSet then begin
                    VarAccountTypeScoreVer2 := ObjProductRiskRating."Risk Score";
                    VarAccountTypeOptionVer2 := ObjProductRiskRating."product type"::"KSA/Imara/MJA/Heritage)";
                    VarAccountTypeScore := ObjProductRiskRating."Risk Score";
                    VarAccountTypeOption := ObjProductRiskRating."product type"::"KSA/Imara/MJA/Heritage)";
                end;
            until ObjProductsApp.Next = 0;
        end;


        ObjProductsApp.Reset;
        ObjProductsApp.SetRange(ObjProductsApp."Membership Applicaton No", MemberNo);
        ObjProductsApp.SetFilter(ObjProductsApp.Product, '%1|%2', '503', '506');
        if ObjProductsApp.FindSet then begin
            repeat
                ObjProductRiskRating.Reset;
                ObjProductRiskRating.SetCurrentkey(ObjProductRiskRating."Product Type");
                ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Category", ObjProductRiskRating."product category"::Accounts);
                ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Type", ObjProductRiskRating."product type"::"Fixed/Call Deposit Accounts");
                if ObjProductRiskRating.FindSet then begin
                    VarAccountTypeScoreVer3 := ObjProductRiskRating."Risk Score";
                    VarAccountTypeOptionVer3 := ObjProductRiskRating."product type"::"Fixed/Call Deposit Accounts";
                    VarAccountTypeScore := ObjProductRiskRating."Risk Score";
                    VarAccountTypeOption := ObjProductRiskRating."product type"::"Fixed/Call Deposit Accounts";
                end;
            until ObjProductsApp.Next = 0;
        end;


        if (VarAccountTypeScoreVer1 > VarAccountTypeScoreVer2) and (VarAccountTypeScoreVer1 > VarAccountTypeScoreVer3) then begin
            VarAccountTypeScore := VarAccountTypeScoreVer1;
            VarAccountTypeOption := VarAccountTypeOptionVer1
        end else
            if (VarAccountTypeScoreVer2 > VarAccountTypeScoreVer1) and (VarAccountTypeScoreVer2 > VarAccountTypeScoreVer3) then begin
                VarAccountTypeScore := VarAccountTypeScoreVer2;
                VarAccountTypeOption := VarAccountTypeOptionVer2
            end else
                if (VarAccountTypeScoreVer3 > VarAccountTypeScoreVer1) and (VarAccountTypeScoreVer3 > VarAccountTypeScoreVer2) then begin
                    VarAccountTypeScore := VarAccountTypeScoreVer3;
                    VarAccountTypeOption := VarAccountTypeOptionVer3
                end;


        //Create Entries on Membership Risk Rating Table
        ObjMemberRiskRating.Reset;
        ObjMemberRiskRating.SetRange(ObjMemberRiskRating."Membership Application No", MemberNo);
        if ObjMemberRiskRating.FindSet then begin
            ObjMemberRiskRating.DeleteAll;
        end;


        //===============================================Get Control Risk Rating
        ObjControlRiskRating.Reset;
        if ObjControlRiskRating.FindSet then begin
            ObjControlRiskRating.CalcSums(ObjControlRiskRating."Control Weight Aggregate");
            VarControlRiskRating := ObjControlRiskRating."Control Weight Aggregate";
        end;



        ObjMemberRiskRating.Init;
        ObjMemberRiskRating."Membership Application No" := MemberNo;
        ObjMemberRiskRating."What is the Customer Category?" := ObjMembershipApplication."Individual Category";
        ObjMemberRiskRating."Customer Category Score" := VarCategoryScore;
        ObjMemberRiskRating."What is the Member residency?" := ObjMembershipApplication."Member Residency Status";
        ObjMemberRiskRating."Member Residency Score" := VarResidencyScore;
        ObjMemberRiskRating."Cust Employment Risk?" := ObjMembershipApplication.Entities;
        ObjMemberRiskRating."Cust Employment Risk Score" := VarEntityScore;
        ObjMemberRiskRating."Cust Business Risk Industry?" := ObjMembershipApplication."Industry Type";
        ObjMemberRiskRating."Cust Bus. Risk Industry Score" := VarIndustryScore;
        ObjMemberRiskRating."Lenght Of Relationship?" := ObjMembershipApplication."Length Of Relationship";
        ObjMemberRiskRating."Length Of Relation Score" := VarLenghtOfRelationshipScore;
        ObjMemberRiskRating."Cust Involved in Intern. Trade" := ObjMembershipApplication."International Trade";
        ObjMemberRiskRating."Involve in Inter. Trade Score" := VarInternationalTradeScore;
        ObjMemberRiskRating."Account Type Taken?" := Format(VarAccountTypeOption);
        ObjMemberRiskRating."Account Type Taken Score" := VarAccountTypeScore;
        ObjMemberRiskRating."Card Type Taken" := ObjMembershipApplication."Cards Type Taken";
        ObjMemberRiskRating."Card Type Taken Score" := VarCardTypeScore;
        ObjMemberRiskRating."Channel Taken?" := ObjMembershipApplication."Others(Channels)";
        ObjMemberRiskRating."Channel Taken Score" := VarChannelTakenScore;
        ObjMemberRiskRating."Electronic Payments?" := ObjMembershipApplication."Electronic Payment";
        ObjMemberRiskRating."Referee Score" := VarRefereeScore;
        ObjMemberRiskRating."Member Referee Rate" := VarRefereeRiskRate;
        ObjMemberRiskRating."Electronic Payments Score" := VarElectronicPaymentScore;
        MemberTotalRiskRatingScore := VarCategoryScore + VarEntityScore + VarIndustryScore + VarInternationalTradeScore + VarRefereeScore + VarLenghtOfRelationshipScore + VarResidencyScore + VarAccountTypeScore
        + VarCardTypeScore + VarChannelTakenScore + VarElectronicPaymentScore;
        ObjMemberRiskRating."GROSS CUSTOMER AML RISK RATING" := MemberTotalRiskRatingScore;
        ObjMemberRiskRating."BANK'S CONTROL RISK RATING" := VarControlRiskRating;
        ObjMemberRiskRating."CUSTOMER NET RISK RATING" := ROUND(ObjMemberRiskRating."GROSS CUSTOMER AML RISK RATING" / ObjMemberRiskRating."BANK'S CONTROL RISK RATING", 0.01, '>');
        MemberNetRiskScore := MemberTotalRiskRatingScore / VarControlRiskRating;

        ObjNetRiskScale.Reset;
        if ObjNetRiskScale.FindSet then begin
            repeat
                if (MemberTotalRiskRatingScore >= ObjNetRiskScale."Minimum Risk Rate") and (MemberTotalRiskRatingScore <= ObjNetRiskScale."Maximum Risk Rate") then begin
                    ObjMemberRiskRating."Risk Rate Scale" := ObjNetRiskScale."Risk Scale";
                    VarRiskRatingDescription := ObjNetRiskScale.Description;
                end;
            until ObjNetRiskScale.Next = 0;
        end;
        ObjMemberRiskRating.Insert;
        ObjMemberRiskRating.Validate(ObjMemberRiskRating."Membership Application No");
        ObjMemberRiskRating.Modify;


        ObjMemberDueDiligence.Reset;
        ObjMemberDueDiligence.SetRange(ObjMemberDueDiligence."Member No", MemberNo);
        if ObjMemberDueDiligence.FindSet then begin
            ObjMemberDueDiligence.DeleteAll;
        end;

        ObjDueDiligenceSetup.Reset;
        ObjDueDiligenceSetup.SetRange(ObjDueDiligenceSetup."Risk Rating Level", ObjMemberRiskRating."Risk Rate Scale");
        if ObjDueDiligenceSetup.FindSet then begin
            repeat
                ObjMemberDueDiligence.Init;
                ObjMemberDueDiligence."Member No" := MemberNo;
                if ObjMembershipApplication.Get(MemberNo) then begin
                    ObjMemberDueDiligence."Member Name" := ObjMembershipApplication.Name;
                end;
                ObjMemberDueDiligence."Due Diligence No" := ObjDueDiligenceSetup."Due Diligence No";
                ObjMemberDueDiligence."Risk Rating Level" := ObjMemberRiskRating."Risk Rate Scale";
                ObjMemberDueDiligence."Risk Rating Scale" := VarRiskRatingDescription;
                ObjMemberDueDiligence."Due Diligence Type" := ObjDueDiligenceSetup."Due Diligence Type";
                ObjMemberDueDiligence."Due Diligence Measure" := ObjDueDiligenceSetup."Due Diligence Measure";
                ObjMemberDueDiligence.Insert;
            until ObjDueDiligenceSetup.Next = 0;
        end;

        ObjMembershipApplication.Reset;
        ObjMembershipApplication.SetRange(ObjMembershipApplication."No.", MemberNo);
        if ObjMembershipApplication.FindSet then begin
            ObjMembershipApplication."Member Risk Level" := ObjMemberRiskRating."Risk Rate Scale";
            ObjMembershipApplication."Due Diligence Measure" := ObjDueDiligenceSetup."Due Diligence Type";
            ObjMembershipApplication.Modify;
        end;
    end;


    procedure FnGetEntitiesApplicationAMLRiskRating(MemberNo: Code[20])
    var
        VarCategoryScore: Integer;
        VarResidencyScore: Integer;
        VarNatureofBusinessScore: Integer;
        VarEntityScore: Integer;
        VarIndustryScore: Integer;
        VarLenghtOfRelationshipScore: Integer;
        VarInternationalTradeScore: Integer;
        VarElectronicPaymentScore: Integer;
        VarCardTypeScore: Integer;
        VarAccountTypeScore: Integer;
        VarChannelTakenScore: Integer;
        VarAccountTypeOption: Option "International Wire Transfers","Local Wire Transfers","Mobile Transfers","None of the Above","Fixed/Call Deposit Accounts","FOSA(KSA",Imara," MJA","Heritage)","Account with Sealed Safe deposit","Account with  Open Safe Deposit","All Loan Accounts",BOSA," Ufalme","ATM Debit",Credit,Both,"None","Non-face to face channels","Unsolicited Account Origination e.g. Walk-Ins","Cheque book",Others;
        MemberTotalRiskRatingScore: Decimal;
        MemberNetRiskScore: Decimal;
        ObjMemberDueDiligence: Record "Member Due Diligence Measures";
        ObjDueDiligenceSetup: Record "Due Diligence Measures";
        VarRiskRatingDescription: Text[50];
        ObjControlRiskRating: Record "Control Risk Rating";
        VarControlRiskRating: Decimal;
        ObjMemberRiskRate: Record "Individual Customer Risk Rate";
        ObjRefereeSetup: Record "Referee Risk Rating Scale";
        VarRefereeScore: Decimal;
        VarRefereeRiskRate: Text;
        VarAccountTypeScoreVer1: Decimal;
        VarAccountTypeScoreVer2: Decimal;
        VarAccountTypeScoreVer3: Decimal;
        VarAccountTypeOptionVer1: Option "International Wire Transfers","Local Wire Transfers","Mobile Transfers","None of the Above","Fixed/Call Deposit Accounts","KSA/Imara/MJA/Heritage)","Account with Sealed Safe deposit","Account with  Open Safe Deposit","All Loan Accounts",BOSA," Ufalme","ATM Debit",Credit,Both,"None","Non-face to face channels","Unsolicited Account Origination e.g. Walk-Ins","Cheque book",Others;
        VarAccountTypeOptionVer2: Option "International Wire Transfers","Local Wire Transfers","Mobile Transfers","None of the Above","Fixed/Call Deposit Accounts","KSA/Imara/MJA/Heritage)","Account with Sealed Safe deposit","Account with  Open Safe Deposit","All Loan Accounts",BOSA," Ufalme","ATM Debit",Credit,Both,"None","Non-face to face channels","Unsolicited Account Origination e.g. Walk-Ins","Cheque book",Others;
        VarAccountTypeOptionVer3: Option "International Wire Transfers","Local Wire Transfers","Mobile Transfers","None of the Above","Fixed/Call Deposit Accounts","KSA/Imara/MJA/Heritage)","Account with Sealed Safe deposit","Account with  Open Safe Deposit","All Loan Accounts",BOSA," Ufalme","ATM Debit",Credit,Both,"None","Non-face to face channels","Unsolicited Account Origination e.g. Walk-Ins","Cheque book",Others;
    begin


        ObjMembershipApplication.Reset;
        ObjMembershipApplication.SetRange(ObjMembershipApplication."No.", MemberNo);
        if ObjMembershipApplication.FindSet then begin
            ObjCustRiskRates.Reset;
            ObjCustRiskRates.SetRange(ObjCustRiskRates.Category, ObjCustRiskRates.Category::Individuals);
            ObjCustRiskRates.SetRange(ObjCustRiskRates."Sub Category", ObjMembershipApplication."Individual Category");
            if ObjCustRiskRates.FindSet then begin
                VarCategoryScore := ObjCustRiskRates."Risk Score";
            end;
        end;


        ObjMembershipApplication.Reset;
        ObjMembershipApplication.SetRange(ObjMembershipApplication."No.", MemberNo);
        if ObjMembershipApplication.FindSet then begin
            ObjCustRiskRates.Reset;
            ObjCustRiskRates.SetRange(ObjCustRiskRates.Category, ObjCustRiskRates.Category::Entities);
            ObjCustRiskRates.SetRange(ObjCustRiskRates."Sub Category", ObjMembershipApplication.Entities);
            if ObjCustRiskRates.FindSet then begin
                VarEntityScore := ObjCustRiskRates."Risk Score";
            end;
        end;

        ObjMembershipApplication.Reset;
        ObjMembershipApplication.SetRange(ObjMembershipApplication."No.", MemberNo);
        if ObjMembershipApplication.FindSet then begin
            ObjCustRiskRates.Reset;
            ObjCustRiskRates.SetRange(ObjCustRiskRates.Category, ObjCustRiskRates.Category::"Residency Status");
            ObjCustRiskRates.SetRange(ObjCustRiskRates."Sub Category", ObjMembershipApplication."Member Residency Status");
            if ObjCustRiskRates.FindSet then begin
                VarResidencyScore := ObjCustRiskRates."Risk Score";
            end;
        end;


        ObjMembershipApplication.Reset;
        ObjMembershipApplication.SetRange(ObjMembershipApplication."No.", MemberNo);
        if ObjMembershipApplication.FindSet then begin
            //=============================================================Exisiting Referee
            ObjMemberRiskRate.Reset;
            ObjMemberRiskRate.SetRange(ObjMemberRiskRate."Membership Application No", ObjMembershipApplication."Referee Member No");
            if ObjMemberRiskRate.FindSet then begin
                if ObjMembershipApplication."Referee Member No" <> '' then begin

                    ObjRefereeSetup.Reset;
                    if ObjRefereeSetup.FindSet then begin
                        repeat
                            if (ObjMemberRiskRate."GROSS CUSTOMER AML RISK RATING" >= ObjRefereeSetup."Minimum Risk Rate") and
                              (ObjMemberRiskRate."GROSS CUSTOMER AML RISK RATING" <= ObjRefereeSetup."Maximum Risk Rate") then begin
                                VarRefereeScore := ObjRefereeSetup.Score;
                                VarRefereeRiskRate := ObjRefereeSetup.Description;
                            end;
                        until ObjRefereeSetup.Next = 0;
                    end;
                end;

                //=============================================================No Referee
                if ObjMembershipApplication."Referee Member No" = '' then begin
                    ObjRefereeSetup.Reset;
                    ObjRefereeSetup.SetFilter(ObjRefereeSetup.Description, '%1', 'Others with no referee');
                    if ObjRefereeSetup.FindSet then begin
                        VarRefereeScore := ObjRefereeSetup.Score;
                        VarRefereeRiskRate := 'Others with no referee';
                    end;
                end;
            end;


            ObjCustRiskRates.Reset;
            ObjCustRiskRates.SetRange(ObjCustRiskRates.Category, ObjCustRiskRates.Category::"Residency Status");
            ObjCustRiskRates.SetRange(ObjCustRiskRates."Sub Category", ObjMembershipApplication."Member Residency Status");
            if ObjCustRiskRates.FindSet then begin
                VarResidencyScore := ObjCustRiskRates."Risk Score";
            end;
        end;

        ObjMembershipApplication.Reset;
        ObjMembershipApplication.SetRange(ObjMembershipApplication."No.", MemberNo);
        if ObjMembershipApplication.FindSet then begin
            ObjCustRiskRates.Reset;
            ObjCustRiskRates.SetRange(ObjCustRiskRates.Category, ObjCustRiskRates.Category::Industry);
            ObjCustRiskRates.SetRange(ObjCustRiskRates."Sub Category", ObjMembershipApplication."Industry Type");
            if ObjCustRiskRates.FindSet then begin
                VarIndustryScore := ObjCustRiskRates."Risk Score";
            end;
        end;

        ObjMembershipApplication.Reset;
        ObjMembershipApplication.SetRange(ObjMembershipApplication."No.", MemberNo);
        if ObjMembershipApplication.FindSet then begin
            ObjCustRiskRates.Reset;
            ObjCustRiskRates.SetRange(ObjCustRiskRates.Category, ObjCustRiskRates.Category::"Length Of Relationship");
            ObjCustRiskRates.SetRange(ObjCustRiskRates."Sub Category", ObjMembershipApplication."Length Of Relationship");
            if ObjCustRiskRates.FindSet then begin
                VarLenghtOfRelationshipScore := ObjCustRiskRates."Risk Score";
            end;
        end;

        ObjMembershipApplication.Reset;
        ObjMembershipApplication.SetRange(ObjMembershipApplication."No.", MemberNo);
        if ObjMembershipApplication.FindSet then begin
            ObjCustRiskRates.Reset;
            ObjCustRiskRates.SetRange(ObjCustRiskRates.Category, ObjCustRiskRates.Category::"International Trade");
            ObjCustRiskRates.SetRange(ObjCustRiskRates."Sub Category", ObjMembershipApplication."International Trade");
            if ObjCustRiskRates.FindSet then begin
                VarInternationalTradeScore := ObjCustRiskRates."Risk Score";
            end;
        end;


        ObjMembershipApplication.Reset;
        ObjMembershipApplication.SetRange(ObjMembershipApplication."No.", MemberNo);
        if ObjMembershipApplication.FindSet then begin
            ObjProductRiskRating.Reset;
            ObjProductRiskRating.SetCurrentkey(ObjProductRiskRating."Product Type Code");
            ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Category", ObjProductRiskRating."product category"::"Electronic Payment");
            ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Type Code", ObjMembershipApplication."Electronic Payment");
            if ObjProductRiskRating.FindSet then begin
                VarElectronicPaymentScore := ObjProductRiskRating."Risk Score";
            end;
        end;


        //ObjProductRiskRating.GET();
        ObjMembershipApplication.Reset;
        ObjMembershipApplication.SetRange(ObjMembershipApplication."No.", MemberNo);
        if ObjMembershipApplication.FindSet then begin

            ObjProductRiskRating.Reset;
            ObjProductRiskRating.SetCurrentkey(ObjProductRiskRating."Product Type Code");
            ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Category", ObjProductRiskRating."product category"::Cards);
            ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Type Code", ObjMembershipApplication."Cards Type Taken");
            if ObjProductRiskRating.FindSet then begin
                VarCardTypeScore := ObjProductRiskRating."Risk Score";
            end;
        end;

        ObjProductRiskRating.Reset;
        ObjProductRiskRating.SetCurrentkey(ObjProductRiskRating."Product Type Code");
        ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Category", ObjProductRiskRating."product category"::Accounts);
        ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Type Code", ObjMembershipApplication."Accounts Type Taken");
        if ObjProductRiskRating.FindSet then begin
            VarAccountTypeScore := ObjProductRiskRating."Risk Score";
        end;

        ObjProductRiskRating.Reset;
        ObjProductRiskRating.SetCurrentkey(ObjProductRiskRating."Product Type Code");
        ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Category", ObjProductRiskRating."product category"::Others);
        ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Type Code", ObjMembershipApplication."Others(Channels)");
        if ObjProductRiskRating.FindSet then begin
            VarChannelTakenScore := ObjProductRiskRating."Risk Score";
        end;

        ObjProductsApp.Reset;
        ObjProductsApp.SetRange(ObjProductsApp."Membership Applicaton No", MemberNo);
        ObjProductsApp.SetFilter(ObjProductsApp."Product Source", '<>%1', ObjProductsApp."product source"::FOSA);
        if ObjProductsApp.FindSet then begin
            repeat
                ObjProductRiskRating.Reset;
                ObjProductRiskRating.SetCurrentkey(ObjProductRiskRating."Product Type");
                ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Category", ObjProductRiskRating."product category"::Accounts);
                ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Type", ObjProductRiskRating."product type"::Credit);
                if ObjProductRiskRating.FindSet then begin
                    VarAccountTypeScoreVer1 := ObjProductRiskRating."Risk Score";
                    VarAccountTypeOptionVer1 := ObjProductRiskRating."product type"::Credit;
                    VarAccountTypeScore := ObjProductRiskRating."Risk Score";
                    VarAccountTypeOption := ObjProductRiskRating."product type"::Credit;
                end;
            until ObjProductsApp.Next = 0;
        end;

        ObjProductsApp.Reset;
        ObjProductsApp.SetRange(ObjProductsApp."Membership Applicaton No", MemberNo);
        ObjProductsApp.SetFilter(ObjProductsApp."Product Source", '%1', ObjProductsApp."product source"::FOSA);
        ObjProductsApp.SetFilter(ObjProductsApp.Product, '<>%1|%2', '503', '506');
        if ObjProductsApp.FindSet then begin

            repeat
                ObjProductRiskRating.Reset;
                ObjProductRiskRating.SetCurrentkey(ObjProductRiskRating."Product Type");
                ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Category", ObjProductRiskRating."product category"::Accounts);
                ObjProductRiskRating.SetFilter(ObjProductRiskRating."Product Type Code", '%1', 'FOSA (KSA, Imara, Heritage, MJA)');
                if ObjProductRiskRating.FindSet then begin
                    VarAccountTypeScoreVer2 := ObjProductRiskRating."Risk Score";
                    VarAccountTypeOptionVer2 := ObjProductRiskRating."product type"::"KSA/Imara/MJA/Heritage)";
                    VarAccountTypeScore := ObjProductRiskRating."Risk Score";
                    VarAccountTypeOption := ObjProductRiskRating."product type"::"KSA/Imara/MJA/Heritage)";
                end;
            until ObjProductsApp.Next = 0;
        end;


        ObjProductsApp.Reset;
        ObjProductsApp.SetRange(ObjProductsApp."Membership Applicaton No", MemberNo);
        ObjProductsApp.SetFilter(ObjProductsApp.Product, '%1|%2', '503', '506');
        if ObjProductsApp.FindSet then begin
            repeat
                ObjProductRiskRating.Reset;
                ObjProductRiskRating.SetCurrentkey(ObjProductRiskRating."Product Type");
                ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Category", ObjProductRiskRating."product category"::Accounts);
                ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Type", ObjProductRiskRating."product type"::"Fixed/Call Deposit Accounts");
                if ObjProductRiskRating.FindSet then begin
                    VarAccountTypeScoreVer3 := ObjProductRiskRating."Risk Score";
                    VarAccountTypeOptionVer3 := ObjProductRiskRating."product type"::"Fixed/Call Deposit Accounts";
                    VarAccountTypeScore := ObjProductRiskRating."Risk Score";
                    VarAccountTypeOption := ObjProductRiskRating."product type"::"Fixed/Call Deposit Accounts";
                end;
            until ObjProductsApp.Next = 0;
        end;


        if (VarAccountTypeScoreVer1 > VarAccountTypeScoreVer2) and (VarAccountTypeScoreVer1 > VarAccountTypeScoreVer3) then begin
            VarAccountTypeScore := VarAccountTypeScoreVer1;
            VarAccountTypeOption := VarAccountTypeOptionVer1
        end else
            if (VarAccountTypeScoreVer2 > VarAccountTypeScoreVer1) and (VarAccountTypeScoreVer2 > VarAccountTypeScoreVer3) then begin
                VarAccountTypeScore := VarAccountTypeScoreVer2;
                VarAccountTypeOption := VarAccountTypeOptionVer2
            end else
                if (VarAccountTypeScoreVer3 > VarAccountTypeScoreVer1) and (VarAccountTypeScoreVer3 > VarAccountTypeScoreVer2) then begin
                    VarAccountTypeScore := VarAccountTypeScoreVer3;
                    VarAccountTypeOption := VarAccountTypeOptionVer3
                end;


        //Create Entries on Membership Risk Rating Table
        ObjEntitiesRiskRating.Reset;
        ObjEntitiesRiskRating.SetRange(ObjEntitiesRiskRating."Membership Application No", MemberNo);
        if ObjEntitiesRiskRating.FindSet then begin
            ObjEntitiesRiskRating.DeleteAll;
        end;


        //===============================================Get Control Risk Rating
        ObjControlRiskRating.Reset;
        if ObjControlRiskRating.FindSet then begin
            ObjControlRiskRating.CalcSums(ObjControlRiskRating."Control Weight Aggregate");
            VarControlRiskRating := ObjControlRiskRating."Control Weight Aggregate";
        end;



        ObjEntitiesRiskRating.Init;
        ObjEntitiesRiskRating."Membership Application No" := MemberNo;
        ObjEntitiesRiskRating."What is the Customer Category?" := ObjMembershipApplication."Individual Category";
        ObjEntitiesRiskRating."Customer Category Score" := VarCategoryScore;
        ObjEntitiesRiskRating."What is the Member residency?" := ObjMembershipApplication."Member Residency Status";
        ObjEntitiesRiskRating."Member Residency Score" := VarResidencyScore;
        ObjEntitiesRiskRating."Cust Employment Risk?" := ObjMembershipApplication.Entities;
        ObjEntitiesRiskRating."Cust Employment Risk Score" := VarEntityScore;
        ObjEntitiesRiskRating."Cust Business Risk Industry?" := ObjMembershipApplication."Industry Type";
        ObjEntitiesRiskRating."Cust Bus. Risk Industry Score" := VarIndustryScore;
        ObjEntitiesRiskRating."Lenght Of Relationship?" := ObjMembershipApplication."Length Of Relationship";
        ObjEntitiesRiskRating."Length Of Relation Score" := VarLenghtOfRelationshipScore;
        ObjEntitiesRiskRating."Cust Involved in Intern. Trade" := ObjMembershipApplication."International Trade";
        ObjEntitiesRiskRating."Involve in Inter. Trade Score" := VarInternationalTradeScore;
        ObjEntitiesRiskRating."Account Type Taken?" := Format(VarAccountTypeOption);
        ObjEntitiesRiskRating."Account Type Taken Score" := VarAccountTypeScore;
        ObjEntitiesRiskRating."Card Type Taken" := ObjMembershipApplication."Cards Type Taken";
        ObjEntitiesRiskRating."Card Type Taken Score" := VarCardTypeScore;
        ObjEntitiesRiskRating."Channel Taken?" := ObjMembershipApplication."Others(Channels)";
        ObjEntitiesRiskRating."Channel Taken Score" := VarChannelTakenScore;
        ObjEntitiesRiskRating."Electronic Payments?" := ObjMembershipApplication."Electronic Payment";
        ObjEntitiesRiskRating."Electronic Payments Score" := VarElectronicPaymentScore;
        MemberTotalRiskRatingScore := VarCategoryScore + VarEntityScore + VarIndustryScore + VarInternationalTradeScore + VarLenghtOfRelationshipScore + VarResidencyScore + VarAccountTypeScore
        + VarCardTypeScore + VarChannelTakenScore + VarElectronicPaymentScore;
        ObjEntitiesRiskRating."GROSS CUSTOMER AML RISK RATING" := MemberTotalRiskRatingScore;
        ObjEntitiesRiskRating."BANK'S CONTROL RISK RATING" := VarControlRiskRating;
        ObjEntitiesRiskRating."CUSTOMER NET RISK RATING" := ROUND(ObjEntitiesRiskRating."GROSS CUSTOMER AML RISK RATING" / ObjEntitiesRiskRating."BANK'S CONTROL RISK RATING", 0.01, '>');
        MemberNetRiskScore := MemberTotalRiskRatingScore / VarControlRiskRating;

        ObjEntitiesNetRiskScale.Reset;
        if ObjEntitiesNetRiskScale.FindSet then begin
            repeat
                if (MemberTotalRiskRatingScore >= ObjEntitiesNetRiskScale."Minimum Risk Rate") and (MemberTotalRiskRatingScore <= ObjEntitiesNetRiskScale."Maximum Risk Rate") then begin
                    ObjEntitiesRiskRating."Risk Rate Scale" := ObjEntitiesNetRiskScale."Risk Scale";
                    VarRiskRatingDescription := ObjEntitiesNetRiskScale.Description;
                end;
            until ObjEntitiesNetRiskScale.Next = 0;
        end;
        ObjEntitiesRiskRating.Insert;
        ObjEntitiesRiskRating.Validate(ObjEntitiesRiskRating."Membership Application No");
        ObjEntitiesRiskRating.Modify;


        ObjMemberDueDiligence.Reset;
        ObjMemberDueDiligence.SetRange(ObjMemberDueDiligence."Member No", MemberNo);
        if ObjMemberDueDiligence.FindSet then begin
            ObjMemberDueDiligence.DeleteAll;
        end;

        ObjDueDiligenceSetup.Reset;
        ObjDueDiligenceSetup.SetRange(ObjDueDiligenceSetup."Risk Rating Level", ObjEntitiesRiskRating."Risk Rate Scale");
        if ObjDueDiligenceSetup.FindSet then begin
            repeat
                ObjMemberDueDiligence.Init;
                ObjMemberDueDiligence."Member No" := MemberNo;
                if ObjMembershipApplication.Get(MemberNo) then begin
                    ObjMemberDueDiligence."Member Name" := ObjMembershipApplication.Name;
                end;
                ObjMemberDueDiligence."Due Diligence No" := ObjDueDiligenceSetup."Due Diligence No";
                ObjMemberDueDiligence."Risk Rating Level" := ObjEntitiesRiskRating."Risk Rate Scale";
                ObjMemberDueDiligence."Risk Rating Scale" := VarRiskRatingDescription;
                ObjMemberDueDiligence."Due Diligence Type" := ObjDueDiligenceSetup."Due Diligence Type";
                ObjMemberDueDiligence."Due Diligence Measure" := ObjDueDiligenceSetup."Due Diligence Measure";
                ObjMemberDueDiligence.Insert;
            until ObjDueDiligenceSetup.Next = 0;
        end;

        ObjMembershipApplication.Reset;
        ObjMembershipApplication.SetRange(ObjMembershipApplication."No.", MemberNo);
        if ObjMembershipApplication.FindSet then begin
            ObjMembershipApplication."Member Risk Level" := ObjEntitiesRiskRating."Risk Rate Scale";
            ObjMembershipApplication."Due Diligence Measure" := ObjDueDiligenceSetup."Due Diligence Type";
            ObjMembershipApplication.Modify;
        end;
    end;


    procedure FnGetMemberAMLRiskRating(MemberNo: Code[20])
    var
        VarCategoryScore: Integer;
        VarResidencyScore: Integer;
        VarNatureofBusinessScore: Integer;
        VarEntityScore: Integer;
        VarIndustryScore: Integer;
        VarLenghtOfRelationshipScore: Integer;
        VarInternationalTradeScore: Integer;
        VarElectronicPaymentScore: Integer;
        VarElectronicPayment: Option "International Wire Transfers","Local Wire Transfers","Mobile Transfers","None of the Above","Fixed/Call Deposit Accounts","KSA/Imara/MJA/Heritage)","Account with Sealed Safe deposit","Account with  Open Safe Deposit","All Loan Accounts",BOSA," Ufalme","ATM Debit",Credit,Both,"None","Non-face to face channels","Unsolicited Account Origination e.g. Walk-Ins","Cheque book",Others;
        VarCardTypeScore: Integer;
        VarAccountTypeScore: Integer;
        VarChannelTakenScore: Integer;
        VarAccountTypeOption: Option "International Wire Transfers","Local Wire Transfers","Mobile Transfers","None of the Above","Fixed/Call Deposit Accounts","KSA/Imara/MJA/Heritage)","Account with Sealed Safe deposit","Account with  Open Safe Deposit","All Loan Accounts",BOSA," Ufalme","ATM Debit",Credit,Both,"None","Non-face to face channels","Unsolicited Account Origination e.g. Walk-Ins","Cheque book",Others;
        VarChannelsTaken: Option "International Wire Transfers","Local Wire Transfers","Mobile Transfers","None of the Above","Fixed/Call Deposit Accounts","KSA/Imara/MJA/Heritage)","Account with Sealed Safe deposit","Account with  Open Safe Deposit","All Loan Accounts",BOSA," Ufalme","ATM Debit",Credit,Both,"None","Non-face to face channels","Unsolicited Account Origination e.g. Walk-Ins","Cheque book",Others;
        MemberTotalRiskRatingScore: Decimal;
        MemberNetRiskScore: Decimal;
        VarMemberAnnualIncome: Decimal;
        ObjNetWorth: Record "Customer Net Income Risk Rates";
        ObjPeps: Record "Politically Exposed Persons";
        VarPepsRiskScore: Decimal;
        VarHighNet: Decimal;
        VarIndividualCategoryOption: Option "Politically Exposed Persons (PEPs)","High Net worth",Other,"Publicly Held Companies","Privately Held Companies","Domestic Government Entities",Churches,SMEs,Schools,"Welfare Groups","Financial entities Regulated by local regulators",Resident,"Non-Resident","Money Services Businesses","Charities and Non-Profit Organizations",Trusts,"Real Estate Agencies","High Value Goods Businesses","Precious Metals Businesses","Cash Intensive Businesses","Art Galleries & related businesses","Professional Service Providers","None of the above industries","0 ã 1 Year","1 ã 3 Years","Trade/Export Finance","Local Trade";
        VarLenghtOfRelationshipOption: Option "Politically Exposed Persons (PEPs)","High Net worth",Other,"Publicly Held Companies","Privately Held Companies","Domestic Government Entities",Churches,SMEs,Schools,"Welfare Groups","Financial entities Regulated by local regulators",Resident,"Non-Resident","Money Services Businesses","Charities and Non-Profit Organizations",Trusts,"Real Estate Agencies","High Value Goods Businesses","Precious Metals Businesses","Cash Intensive Businesses","Art Galleries & related businesses","Professional Service Providers","None of the above industries","0 ã 1 Year","1 ã 3 Years","Trade/Export Finance","Local Trade",">3";
        VarMemberSaccoAge: Integer;
        ObjMemberDueDiligence: Record "Member Due Diligence Measures";
        ObjDueDiligenceSetup: Record "Due Diligence Measures";
        VarRiskRatingDescription: Text[50];
        ObjControlRiskRating: Record "Control Risk Rating";
        VarControlRiskRating: Decimal;
        VarAccountTypeScoreVer1: Decimal;
        VarAccountTypeScoreVer2: Decimal;
        VarAccountTypeScoreVer3: Decimal;
        VarAccountTypeOptionVer1: Option "International Wire Transfers","Local Wire Transfers","Mobile Transfers","None of the Above","Fixed/Call Deposit Accounts","KSA/Imara/MJA/Heritage)","Account with Sealed Safe deposit","Account with  Open Safe Deposit","All Loan Accounts",BOSA," Ufalme","ATM Debit",Credit,Both,"None","Non-face to face channels","Unsolicited Account Origination e.g. Walk-Ins","Cheque book",Others;
        VarAccountTypeOptionVer2: Option "International Wire Transfers","Local Wire Transfers","Mobile Transfers","None of the Above","Fixed/Call Deposit Accounts","KSA/Imara/MJA/Heritage)","Account with Sealed Safe deposit","Account with  Open Safe Deposit","All Loan Accounts",BOSA," Ufalme","ATM Debit",Credit,Both,"None","Non-face to face channels","Unsolicited Account Origination e.g. Walk-Ins","Cheque book",Others;
        VarAccountTypeOptionVer3: Option "International Wire Transfers","Local Wire Transfers","Mobile Transfers","None of the Above","Fixed/Call Deposit Accounts","KSA/Imara/MJA/Heritage)","Account with Sealed Safe deposit","Account with  Open Safe Deposit","All Loan Accounts",BOSA," Ufalme","ATM Debit",Credit,Both,"None","Non-face to face channels","Unsolicited Account Origination e.g. Walk-Ins","Cheque book",Others;
        VarAccountTypeScoreVer4: Decimal;
        VarAccountTypeOptionVer4: Option "International Wire Transfers","Local Wire Transfers","Mobile Transfers","None of the Above","Fixed/Call Deposit Accounts","KSA/Imara/MJA/Heritage)","Account with Sealed Safe deposit","Account with  Open Safe Deposit","All Loan Accounts",BOSA," Ufalme","ATM Debit",Credit,Both,"None","Non-face to face channels","Unsolicited Account Origination e.g. Walk-Ins","Cheque book",Others;
        ObjProducts: Record Vendor;
        ObjMemberRiskRate: Record "Individual Customer Risk Rate";
        ObjRefereeSetup: Record "Referee Risk Rating Scale";
        VarRefereeScore: Decimal;
        VarRefereeRiskRate: Text;
        ObjChequeBook: Record "Cheque Book Receipt Lines";
        ObjLoans: Record "Loans Register";
    begin

        //==============================================================================================Member Category(High Net Worth|PEPS|Others)
        ObjMembers.Reset;
        ObjMembers.SetRange(ObjMembers."No.", MemberNo);
        if ObjMembers.FindSet then begin


            //==============================================================================High Net Worth
            ObjNetWorth.Reset;
            if ObjNetWorth.FindSet then begin
                repeat
                    if (ObjMembers."Expected Monthly Income Amount" >= ObjNetWorth."Min Monthly Income") and
                      (ObjMembers."Expected Monthly Income Amount" <= ObjNetWorth."Max Monthlyl Income") then begin
                        VarHighNet := ObjNetWorth."Risk Rate";
                        Message('VarHighNet is %1', VarHighNet);
                    end;
                until ObjNetWorth.Next = 0;
            end;
            //==========================================================================End High Net Worth

            //====================================================================Politicall Exposed Persons

            /*IF VarFirstName='' THEN
            VarFirstName:='$$';
            IF VarMidlleName='' THEN
              VarMidlleName:='$$';
            IF VarLastName='' THEN
              VarLastName:='$$';

            VarFirstName:=ObjMembers.First
            */
            /*ObjPeps.RESET;
            ObjPeps.RESET;
            //ObjPeps.SETFILTER(ObjPeps.Name,'(%1&%2)|(%3&%4)|(%5&%6)','*'+VarFirstName+'*', '*'+VarMidlleName+'*','*'+VarFirstName+'*','*'+VarLastName+'*','*'+VarMidlleName+'*','*'+VarLastName+'*');
            IF ObjPeps.FINDSET THEN
              BEGIN
                 ObjCustRiskRates.RESET;
                 ObjCustRiskRates.SETRANGE(ObjCustRiskRates.Category,ObjCustRiskRates.Category::Individuals);
                 ObjCustRiskRates.SETRANGE(ObjCustRiskRates."Sub Category Option",ObjCustRiskRates."Sub Category Option"::"Politically Exposed Persons (PEPs)");
                 IF ObjCustRiskRates.FINDSET THEN
                   BEGIN
                     VarPepsRiskScore:=ObjCustRiskRates."Risk Score";
                     END;
                END;
            //================================================================End Politicall Exposed Persons*/

            if (VarHighNet < 5) and (VarPepsRiskScore = 0) then begin

                ObjCustRiskRates.Reset;
                ObjCustRiskRates.SetRange(ObjCustRiskRates.Category, ObjCustRiskRates.Category::Individuals);
                ObjCustRiskRates.SetRange(ObjCustRiskRates."Sub Category Option", ObjCustRiskRates."sub category option"::Other);
                if ObjCustRiskRates.FindSet then begin
                    VarCategoryScore := ObjCustRiskRates."Risk Score";
                    VarIndividualCategoryOption := Varindividualcategoryoption::Other;
                end;

            end else
                if (VarHighNet = 5) and (VarPepsRiskScore = 0) then begin

                    ObjCustRiskRates.Reset;
                    ObjCustRiskRates.SetRange(ObjCustRiskRates.Category, ObjCustRiskRates.Category::Individuals);
                    ObjCustRiskRates.SetRange(ObjCustRiskRates."Sub Category Option", ObjCustRiskRates."sub category option"::"High Net worth");
                    if ObjCustRiskRates.FindSet then begin
                        VarCategoryScore := ObjCustRiskRates."Risk Score";
                        VarIndividualCategoryOption := Varindividualcategoryoption::"High Net worth";
                    end;

                end else
                    if (VarHighNet <> 5) and (VarPepsRiskScore = 5) then begin

                        ObjCustRiskRates.Reset;
                        ObjCustRiskRates.SetRange(ObjCustRiskRates.Category, ObjCustRiskRates.Category::Individuals);
                        ObjCustRiskRates.SetRange(ObjCustRiskRates."Sub Category Option", ObjCustRiskRates."sub category option"::"Politically Exposed Persons (PEPs)");
                        if ObjCustRiskRates.FindSet then begin
                            VarCategoryScore := ObjCustRiskRates."Risk Score";
                            VarIndividualCategoryOption := Varindividualcategoryoption::"Politically Exposed Persons (PEPs)";
                        end;
                    end;
        end;
        //=========================================================================END Member Category(High Net Worth|PEPS|Others)


        //=========================================================================Check Entities
        ObjMembers.Reset;
        ObjMembers.SetRange(ObjMembers."No.", MemberNo);
        if ObjMembers.FindSet then begin
            ObjCustRiskRates.Reset;
            ObjCustRiskRates.SetRange(ObjCustRiskRates.Category, ObjCustRiskRates.Category::Entities);
            ObjCustRiskRates.SetRange(ObjCustRiskRates."Sub Category", ObjMembers.Entities);
            if ObjCustRiskRates.FindSet then begin
                VarEntityScore := ObjCustRiskRates."Risk Score";
            end;
        end;


        //========================================================================Check Member Residency
        ObjMembers.Reset;
        ObjMembers.SetRange(ObjMembers."No.", MemberNo);
        if ObjMembers.FindSet then begin
            ObjCustRiskRates.Reset;
            ObjCustRiskRates.SetRange(ObjCustRiskRates.Category, ObjCustRiskRates.Category::"Residency Status");
            ObjCustRiskRates.SetRange(ObjCustRiskRates."Sub Category", ObjMembers."Member Residency Status");
            if ObjCustRiskRates.FindSet then begin
                VarResidencyScore := ObjCustRiskRates."Risk Score";
            end;
        end;


        //=======================================================================Check Member Industry
        ObjMembers.Reset;
        ObjMembers.SetRange(ObjMembers."No.", MemberNo);
        if ObjMembers.FindSet then begin
            ObjCustRiskRates.Reset;
            ObjCustRiskRates.SetRange(ObjCustRiskRates.Category, ObjCustRiskRates.Category::Industry);
            ObjCustRiskRates.SetRange(ObjCustRiskRates."Sub Category", ObjMembers."Industry Type");
            if ObjCustRiskRates.FindSet then begin
                VarIndustryScore := ObjCustRiskRates."Risk Score";
            end;
        end;

        //======================================================================Lenght Of Relationship
        ObjMembers.Reset;
        ObjMembers.SetRange(ObjMembers."No.", MemberNo);
        if ObjMembers.FindSet then begin
            if ObjMembers."Registration Date" <> 0D then
                VarMemberSaccoAge := ROUND((WorkDate - ObjMembers."Registration Date") / 365, 1, '<');

            ObjCustRiskRates.Reset;
            ObjCustRiskRates.SetRange(ObjCustRiskRates.Category, ObjCustRiskRates.Category::"Length Of Relationship");
            if ObjCustRiskRates.FindSet then begin
                repeat
                    if (VarMemberSaccoAge >= ObjCustRiskRates."Min Relationship Length(Years)") and
                     (VarMemberSaccoAge <= ObjCustRiskRates."Max Relationship Length(Years)") then begin
                        VarLenghtOfRelationshipScore := ObjCustRiskRates."Risk Score";
                        VarLenghtOfRelationshipOption := ObjCustRiskRates."Sub Category Option";
                    end;
                until ObjNetWorth.Next = 0;
            end;
        end;

        //======================================================================================Check For International Trade
        ObjMembers.Reset;
        ObjMembers.SetRange(ObjMembers."No.", MemberNo);
        if ObjMembers.FindSet then begin
            ObjCustRiskRates.Reset;
            ObjCustRiskRates.SetRange(ObjCustRiskRates.Category, ObjCustRiskRates.Category::"International Trade");
            ObjCustRiskRates.SetRange(ObjCustRiskRates."Sub Category", ObjMembers."International Trade");
            if ObjCustRiskRates.FindSet then begin
                VarInternationalTradeScore := ObjCustRiskRates."Risk Score";
            end;
        end;

        //==============================================================================Check Electronic Payments
        ObjMembers.Reset;
        ObjMembers.SetRange(ObjMembers."No.", MemberNo);
        ObjMembers.SetRange(ObjMembers."Is Mobile Registered", false);
        if ObjMembers.FindSet then begin
            ObjProductRiskRating.Reset;
            ObjProductRiskRating.SetCurrentkey(ObjProductRiskRating."Product Type Code");
            ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Category", ObjProductRiskRating."product category"::"Electronic Payment");
            ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Type Code", ObjMembers."Electronic Payment");
            if ObjProductRiskRating.FindSet then begin
                VarElectronicPayment := Varelectronicpayment::"None of the Above";
                VarElectronicPaymentScore := ObjProductRiskRating."Risk Score";
            end;
        end;

        ObjMembers.Reset;
        ObjMembers.SetRange(ObjMembers."No.", MemberNo);
        ObjMembers.SetRange(ObjMembers."Is Mobile Registered", true);
        if ObjMembers.FindSet then begin
            ObjProductRiskRating.Reset;
            ObjProductRiskRating.SetCurrentkey(ObjProductRiskRating."Product Type Code");
            ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Category", ObjProductRiskRating."product category"::"Electronic Payment");
            ObjProductRiskRating.SetFilter(ObjProductRiskRating."Product Type Code", '%1', 'Mobile Transfers');
            if ObjProductRiskRating.FindSet then begin
                VarElectronicPayment := Varelectronicpayment::"Mobile Transfers";
                VarElectronicPaymentScore := ObjProductRiskRating."Risk Score";
            end;
        end;


        //ObjProductRiskRating.GET();
        ObjMembers.Reset;
        ObjMembers.SetRange(ObjMembers."No.", MemberNo);
        if ObjMembers.FindSet then begin
            //======================================================================Check Card Type Taken
            ObjProductRiskRating.Reset;
            ObjProductRiskRating.SetCurrentkey(ObjProductRiskRating."Product Type Code");
            ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Category", ObjProductRiskRating."product category"::Cards);
            ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Type Code", ObjMembers."Cards Type Taken");//VarCardType
            if ObjProductRiskRating.FindSet then begin
                VarCardTypeScore := ObjProductRiskRating."Risk Score";
            end;
        end;

        //================================================================Check Account Type Taken
        ObjProductRiskRating.Reset;
        ObjProductRiskRating.SetCurrentkey(ObjProductRiskRating."Product Type Code");
        ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Category", ObjProductRiskRating."product category"::Cards);
        ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Type Code", ObjMembers."Accounts Type Taken");
        if ObjCustRiskRates.FindSet then begin
            VarAccountTypeScore := ObjProductRiskRating."Risk Score";
        end;



        ObjChequeBook.CalcFields(ObjChequeBook."Member No");
        ObjChequeBook.Reset;
        ObjChequeBook.SetRange(ObjChequeBook."Member No", MemberNo);
        if not ObjChequeBook.FindSet then begin
            ObjProductRiskRating.Reset;
            ObjProductRiskRating.SetCurrentkey(ObjProductRiskRating."Product Type Code");
            ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Category", ObjProductRiskRating."product category"::Others);
            ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Type Code", ObjMembers."Others(Channels)");
            if ObjCustRiskRates.FindSet then begin
                VarChannelsTaken := Varchannelstaken::Others;
                VarChannelTakenScore := ObjProductRiskRating."Risk Score";
            end;

        end else
            ObjProductRiskRating.Reset;
        ObjProductRiskRating.SetCurrentkey(ObjProductRiskRating."Product Type Code");
        ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Category", ObjProductRiskRating."product category"::Others);
        ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Type Code", '%1', 'Cheque book');
        if ObjProductRiskRating.FindSet then begin
            VarChannelsTaken := Varchannelstaken::"Cheque book";
            VarChannelTakenScore := ObjProductRiskRating."Risk Score";
        end;

        ObjProducts.Reset;
        ObjProducts.SetRange(ObjProducts."BOSA Account No", MemberNo);
        ObjProducts.SetFilter(ObjProducts."Global Dimension 1 Code", '<>%1', 'FOSA');
        if ObjProducts.FindSet then begin
            repeat
                ObjProductRiskRating.Reset;
                ObjProductRiskRating.SetCurrentkey(ObjProductRiskRating."Product Type");
                ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Category", ObjProductRiskRating."product category"::Accounts);
                ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Type", ObjProductRiskRating."product type"::Credit);
                if ObjProductRiskRating.FindSet then begin
                    VarAccountTypeScoreVer1 := ObjProductRiskRating."Risk Score";
                    VarAccountTypeOptionVer1 := ObjProductRiskRating."product type"::Credit;
                    VarAccountTypeScore := ObjProductRiskRating."Risk Score";
                    VarAccountTypeOption := ObjProductRiskRating."product type"::Credit;
                end;
            until ObjProducts.Next = 0;
        end;

        ObjProducts.Reset;
        ObjProducts.SetRange(ObjProducts."BOSA Account No", MemberNo);
        ObjProducts.SetFilter(ObjProducts."Global Dimension 1 Code", '%1', 'FOSA');
        ObjProducts.SetFilter(ObjProducts."Account Type", '<>%1|%2', '503', '506');
        if ObjProducts.FindSet then begin

            repeat
                ObjProductRiskRating.Reset;
                ObjProductRiskRating.SetCurrentkey(ObjProductRiskRating."Product Type");
                ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Category", ObjProductRiskRating."product category"::Accounts);
                ObjProductRiskRating.SetFilter(ObjProductRiskRating."Product Type Code", '%1', 'FOSA (KSA, Imara, Heritage, MJA)');
                if ObjProductRiskRating.FindSet then begin
                    VarAccountTypeScoreVer2 := ObjProductRiskRating."Risk Score";
                    VarAccountTypeOptionVer2 := ObjProductRiskRating."product type"::"KSA/Imara/MJA/Heritage)";
                    VarAccountTypeScore := ObjProductRiskRating."Risk Score";
                    VarAccountTypeOption := ObjProductRiskRating."product type"::"KSA/Imara/MJA/Heritage)";
                end;
            until ObjProducts.Next = 0;
        end;


        ObjProducts.Reset;
        ObjProducts.SetRange(ObjProducts."BOSA Account No", MemberNo);
        ObjProducts.SetFilter(ObjProducts."Account Type", '%1|%2', '503', '506');
        if ObjProducts.FindSet then begin
            repeat
                ObjProductRiskRating.Reset;
                ObjProductRiskRating.SetCurrentkey(ObjProductRiskRating."Product Type");
                ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Category", ObjProductRiskRating."product category"::Accounts);
                ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Type", ObjProductRiskRating."product type"::"Fixed/Call Deposit Accounts");
                if ObjProductRiskRating.FindSet then begin
                    VarAccountTypeScoreVer3 := ObjProductRiskRating."Risk Score";
                    VarAccountTypeOptionVer3 := ObjProductRiskRating."product type"::"Fixed/Call Deposit Accounts";
                    VarAccountTypeScore := ObjProductRiskRating."Risk Score";
                    VarAccountTypeOption := ObjProductRiskRating."product type"::"Fixed/Call Deposit Accounts";
                end;
            until ObjProducts.Next = 0;
        end;


        ObjLoans.Reset;
        ObjLoans.CalcFields(ObjLoans."Outstanding Balance");
        ObjLoans.SetRange(ObjLoans."Client Code", MemberNo);
        ObjLoans.SetFilter(ObjLoans."Outstanding Balance", '>%1', 0);
        if ObjLoans.FindSet then begin
            ObjLoans.CalcFields(ObjLoans."Outstanding Balance");
            ObjProductRiskRating.Reset;
            ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Category", ObjProductRiskRating."product category"::Accounts);
            ObjProductRiskRating.SetFilter(ObjProductRiskRating."Product Type Code", '%1', 'All Loan Accounts');
            if ObjProductRiskRating.FindSet then begin
                VarAccountTypeScoreVer4 := ObjProductRiskRating."Risk Score";
                VarAccountTypeOptionVer4 := ObjProductRiskRating."product type"::"All Loan Accounts";
                VarAccountTypeScore := ObjProductRiskRating."Risk Score";
                VarAccountTypeOption := ObjProductRiskRating."product type"::"All Loan Accounts";

            end;
        end;

        if (VarAccountTypeScoreVer1 > VarAccountTypeScoreVer2) and (VarAccountTypeScoreVer1 > VarAccountTypeScoreVer3)
         and (VarAccountTypeScoreVer1 > VarAccountTypeScoreVer4) then begin
            VarAccountTypeScore := VarAccountTypeScoreVer1;
            VarAccountTypeOption := VarAccountTypeOptionVer1
        end else
            if (VarAccountTypeScoreVer2 > VarAccountTypeScoreVer1) and (VarAccountTypeScoreVer2 > VarAccountTypeScoreVer3)
            and (VarAccountTypeScoreVer2 > VarAccountTypeScoreVer4) then begin
                VarAccountTypeScore := VarAccountTypeScoreVer2;
                VarAccountTypeOption := VarAccountTypeOptionVer2
            end else
                if (VarAccountTypeScoreVer3 > VarAccountTypeScoreVer1) and (VarAccountTypeScoreVer3 > VarAccountTypeScoreVer2)
                and (VarAccountTypeScoreVer3 > VarAccountTypeScoreVer4) then begin
                    VarAccountTypeScore := VarAccountTypeScoreVer3;
                    VarAccountTypeOption := VarAccountTypeOptionVer3
                end else
                    if (VarAccountTypeScoreVer4 > VarAccountTypeScoreVer1) and (VarAccountTypeScoreVer4 > VarAccountTypeScoreVer2)
                    and (VarAccountTypeScoreVer4 > VarAccountTypeScoreVer3) then begin
                        VarAccountTypeScore := VarAccountTypeScoreVer4;
                        VarAccountTypeOption := VarAccountTypeOptionVer4
                    end;



        //=============================================================================Check Referee
        ObjMembers.Reset;
        ObjMembers.SetRange(ObjMembers."No.", MemberNo);
        if ObjMembers.FindSet then begin
            //=============================================================Exisiting Referee
            ObjMemberRiskRate.Reset;
            ObjMemberRiskRate.SetRange(ObjMemberRiskRate."Membership Application No", ObjMembers."Referee Member No");
            if ObjMemberRiskRate.FindSet then begin
                if ObjMembers."Referee Member No" <> '' then begin

                    ObjRefereeSetup.Reset;
                    if ObjRefereeSetup.FindSet then begin
                        repeat
                            if (ObjMemberRiskRate."GROSS CUSTOMER AML RISK RATING" >= ObjRefereeSetup."Minimum Risk Rate") and
                              (ObjMemberRiskRate."GROSS CUSTOMER AML RISK RATING" <= ObjRefereeSetup."Maximum Risk Rate") then begin
                                VarRefereeScore := ObjRefereeSetup.Score;
                                VarRefereeRiskRate := ObjRefereeSetup.Description;
                            end;
                        until ObjRefereeSetup.Next = 0;
                    end;
                end;
            end;
            //=============================================================No Referee
            if ObjMembers."Referee Member No" = '' then begin
                ObjRefereeSetup.Reset;
                ObjRefereeSetup.SetFilter(ObjRefereeSetup.Description, '%1', 'Others with no referee');
                if ObjRefereeSetup.FindSet then begin
                    VarRefereeScore := ObjRefereeSetup.Score;
                    VarRefereeRiskRate := 'Others with no referee';
                end;
            end;
        end;

        //=============================================================Create Entries on Membership Risk Rating Table
        ObjMemberRiskRating.Reset;
        ObjMemberRiskRating.SetRange(ObjMemberRiskRating."Membership Application No", MemberNo);
        if ObjMemberRiskRating.FindSet then begin
            ObjMemberRiskRating.DeleteAll;
        end;


        if ObjMembers.Get(MemberNo) then begin
            ObjMembers."Individual Category" := Format(VarIndividualCategoryOption);
            ObjMembers."Length Of Relationship" := Format(VarLenghtOfRelationshipOption);
            ObjMembers."Accounts Type Taken" := Format(VarAccountTypeOption);
            ObjMembers.Modify;
        end;


        //===============================================Get Control Risk Rating
        ObjControlRiskRating.Reset;
        if ObjControlRiskRating.FindSet then begin
            ObjControlRiskRating.CalcSums(ObjControlRiskRating."Control Weight Aggregate");
            VarControlRiskRating := ObjControlRiskRating."Control Weight Aggregate";
        end;

        ObjMemberRiskRating.Init;
        ObjMemberRiskRating."Membership Application No" := MemberNo;
        ObjMemberRiskRating."What is the Customer Category?" := Format(VarIndividualCategoryOption);
        ObjMemberRiskRating."Customer Category Score" := VarCategoryScore;
        ObjMemberRiskRating."What is the Member residency?" := ObjMembers."Member Residency Status";
        ObjMemberRiskRating."Member Residency Score" := VarResidencyScore;
        ObjMemberRiskRating."Cust Employment Risk?" := ObjMembers.Entities;
        ObjMemberRiskRating."Cust Employment Risk Score" := VarEntityScore;
        ObjMemberRiskRating."Cust Business Risk Industry?" := ObjMembers."Industry Type";
        ObjMemberRiskRating."Cust Bus. Risk Industry Score" := VarIndustryScore;
        ObjMemberRiskRating."Lenght Of Relationship?" := Format(VarLenghtOfRelationshipOption);
        ObjMemberRiskRating."Length Of Relation Score" := VarLenghtOfRelationshipScore;
        ObjMemberRiskRating."Cust Involved in Intern. Trade" := ObjMembers."International Trade";
        ObjMemberRiskRating."Involve in Inter. Trade Score" := VarInternationalTradeScore;
        ObjMemberRiskRating."Account Type Taken?" := Format(VarAccountTypeOption);
        ObjMemberRiskRating."Account Type Taken Score" := VarAccountTypeScore;
        ObjMemberRiskRating."Card Type Taken" := ObjMembers."Cards Type Taken";
        ObjMemberRiskRating."Card Type Taken Score" := VarCardTypeScore;
        ObjMemberRiskRating."Channel Taken?" := Format(VarChannelsTaken);
        ObjMemberRiskRating."Channel Taken Score" := VarChannelTakenScore;
        ObjMemberRiskRating."Referee Score" := VarRefereeScore;
        ObjMemberRiskRating."Member Referee Rate" := VarRefereeRiskRate;
        ObjMemberRiskRating."Electronic Payments?" := Format(VarElectronicPayment);
        ObjMemberRiskRating."Electronic Payments Score" := VarElectronicPaymentScore;
        MemberTotalRiskRatingScore := VarCategoryScore + VarEntityScore + VarIndustryScore + VarInternationalTradeScore + VarRefereeScore + VarLenghtOfRelationshipScore + VarResidencyScore + VarAccountTypeScore
        + VarCardTypeScore + VarChannelTakenScore + VarElectronicPaymentScore;
        ObjMemberRiskRating."GROSS CUSTOMER AML RISK RATING" := MemberTotalRiskRatingScore;
        ObjMemberRiskRating."BANK'S CONTROL RISK RATING" := VarControlRiskRating;
        ObjMemberRiskRating."CUSTOMER NET RISK RATING" := ROUND(ObjMemberRiskRating."GROSS CUSTOMER AML RISK RATING" / ObjMemberRiskRating."BANK'S CONTROL RISK RATING", 0.5, '>');
        MemberNetRiskScore := MemberTotalRiskRatingScore / VarControlRiskRating;

        ObjNetRiskScale.Reset;
        if ObjNetRiskScale.FindSet then begin
            repeat
                if (MemberTotalRiskRatingScore >= ObjNetRiskScale."Minimum Risk Rate") and (MemberTotalRiskRatingScore <= ObjNetRiskScale."Maximum Risk Rate") then begin
                    ObjMemberRiskRating."Risk Rate Scale" := ObjNetRiskScale."Risk Scale";
                    VarRiskRatingDescription := ObjNetRiskScale.Description;
                end;
            until ObjNetRiskScale.Next = 0;
        end;
        ObjMemberRiskRating.Insert;
        ObjMemberRiskRating.Validate(ObjMemberRiskRating."Membership Application No");
        ObjMemberRiskRating.Modify;


        ObjMemberDueDiligence.Reset;
        ObjMemberDueDiligence.SetRange(ObjMemberDueDiligence."Member No", MemberNo);
        if ObjMemberDueDiligence.FindSet then begin
            ObjMemberDueDiligence.DeleteAll;
        end;

        ObjDueDiligenceSetup.Reset;
        ObjDueDiligenceSetup.SetRange(ObjDueDiligenceSetup."Risk Rating Level", ObjMemberRiskRating."Risk Rate Scale");
        if ObjDueDiligenceSetup.FindSet then begin
            repeat
                ObjMemberDueDiligence.Init;
                ObjMemberDueDiligence."Member No" := MemberNo;
                if ObjMembers.Get(MemberNo) then begin
                    ObjMemberDueDiligence."Member Name" := ObjMembers.Name;
                end;

                ObjMemberDueDiligence."Due Diligence No" := ObjDueDiligenceSetup."Due Diligence No";
                ObjMemberDueDiligence."Risk Rating Level" := ObjMemberRiskRating."Risk Rate Scale";
                ObjMemberDueDiligence."Risk Rating Scale" := VarRiskRatingDescription;
                ObjMemberDueDiligence."Due Diligence Type" := ObjDueDiligenceSetup."Due Diligence Type";
                ObjMemberDueDiligence."Due Diligence Measure" := ObjDueDiligenceSetup."Due Diligence Measure";
                ObjMemberDueDiligence.Insert;
            until ObjDueDiligenceSetup.Next = 0;
        end;

        ObjMembers.Reset;
        ObjMembers.SetRange(ObjMembers."No.", MemberNo);
        if ObjMembers.FindSet then begin
            ObjMembers.CalcFields(ObjMembers."Has ATM Card");
            ObjMembers."Individual Category" := Format(VarIndividualCategoryOption);
            ObjMembers."Member Residency Status" := ObjMembers."Member Residency Status";
            ObjMembers.Entities := ObjMembers.Entities;
            ObjMembers."Industry Type" := ObjMembers."Industry Type";
            ObjMembers."Length Of Relationship" := Format(VarLenghtOfRelationshipOption);
            ObjMembers."International Trade" := ObjMembers."International Trade";
            ObjMembers."Accounts Type Taken" := Format(VarAccountTypeOption);
            if ObjMembers."Has ATM Card" = true then
                ObjMembers."Cards Type Taken" := 'ATM Debit'
            else
                ObjMembers."Cards Type Taken" := 'None';
            ObjMembers."Others(Channels)" := Format(VarChannelsTaken);
            ObjMembers."Referee Risk Rate" := VarRefereeRiskRate;
            ObjMembers."Electronic Payment" := Format(VarElectronicPayment);
            ObjMembers."Member Risk Level" := ObjMemberRiskRating."Risk Rate Scale";
            ObjMembers."Due Diligence Measure" := ObjDueDiligenceSetup."Due Diligence Type";
            ObjMembers.Modify;
        end;

    end;


    procedure FnGetEntitiesAMLRiskRating(MemberNo: Code[20])
    var
        VarCategoryScore: Integer;
        VarResidencyScore: Integer;
        VarNatureofBusinessScore: Integer;
        VarEntityScore: Integer;
        VarIndustryScore: Integer;
        VarLenghtOfRelationshipScore: Integer;
        VarInternationalTradeScore: Integer;
        VarElectronicPaymentScore: Integer;
        VarCardTypeScore: Integer;
        VarAccountTypeScore: Integer;
        VarChannelTakenScore: Integer;
        VarAccountTypeOption: Option "International Wire Transfers","Local Wire Transfers","Mobile Transfers","None of the Above","Fixed/Call Deposit Accounts","KSA/Imara/MJA/Heritage)","Account with Sealed Safe deposit","Account with  Open Safe Deposit","All Loan Accounts",BOSA," Ufalme","ATM Debit",Credit,Both,"None","Non-face to face channels","Unsolicited Account Origination e.g. Walk-Ins","Cheque book",Others;
        MemberTotalRiskRatingScore: Decimal;
        MemberNetRiskScore: Decimal;
        ObjMemberDueDiligence: Record "Member Due Diligence Measures";
        ObjDueDiligenceSetup: Record "Due Diligence Measures";
        VarRiskRatingDescription: Text[50];
        ObjControlRiskRating: Record "Control Risk Rating";
        VarControlRiskRating: Decimal;
        ObjMemberRiskRate: Record "Individual Customer Risk Rate";
        ObjRefereeSetup: Record "Referee Risk Rating Scale";
        VarRefereeScore: Decimal;
        VarRefereeRiskRate: Text;
        VarAccountTypeScoreVer1: Decimal;
        VarAccountTypeScoreVer2: Decimal;
        VarAccountTypeScoreVer3: Decimal;
        VarAccountTypeOptionVer1: Option "International Wire Transfers","Local Wire Transfers","Mobile Transfers","None of the Above","Fixed/Call Deposit Accounts","KSA/Imara/MJA/Heritage)","Account with Sealed Safe deposit","Account with  Open Safe Deposit","All Loan Accounts",BOSA," Ufalme","ATM Debit",Credit,Both,"None","Non-face to face channels","Unsolicited Account Origination e.g. Walk-Ins","Cheque book",Others;
        VarAccountTypeOptionVer2: Option "International Wire Transfers","Local Wire Transfers","Mobile Transfers","None of the Above","Fixed/Call Deposit Accounts","KSA/Imara/MJA/Heritage)","Account with Sealed Safe deposit","Account with  Open Safe Deposit","All Loan Accounts",BOSA," Ufalme","ATM Debit",Credit,Both,"None","Non-face to face channels","Unsolicited Account Origination e.g. Walk-Ins","Cheque book",Others;
        VarAccountTypeOptionVer3: Option "International Wire Transfers","Local Wire Transfers","Mobile Transfers","None of the Above","Fixed/Call Deposit Accounts","KSA/Imara/MJA/Heritage)","Account with Sealed Safe deposit","Account with  Open Safe Deposit","All Loan Accounts",BOSA," Ufalme","ATM Debit",Credit,Both,"None","Non-face to face channels","Unsolicited Account Origination e.g. Walk-Ins","Cheque book",Others;
        VarAccountTypeScoreVer4: Decimal;
        VarAccountTypeOptionVer4: Option "International Wire Transfers","Local Wire Transfers","Mobile Transfers","None of the Above","Fixed/Call Deposit Accounts","KSA/Imara/MJA/Heritage)","Account with Sealed Safe deposit","Account with  Open Safe Deposit","All Loan Accounts",BOSA," Ufalme","ATM Debit",Credit,Both,"None","Non-face to face channels","Unsolicited Account Origination e.g. Walk-Ins","Cheque book",Others;
        ObjNetWorth: Record "Customer Net Income Risk Rates";
        ObjPeps: Record "Politically Exposed Persons";
        VarPepsRiskScore: Decimal;
        VarHighNet: Decimal;
        VarIndividualCategoryOption: Option "Politically Exposed Persons (PEPs)","High Net worth",Other,"Publicly Held Companies","Privately Held Companies","Domestic Government Entities",Churches,SMEs,Schools,"Welfare Groups","Financial entities Regulated by local regulators",Resident,"Non-Resident","Money Services Businesses","Charities and Non-Profit Organizations",Trusts,"Real Estate Agencies","High Value Goods Businesses","Precious Metals Businesses","Cash Intensive Businesses","Art Galleries & related businesses","Professional Service Providers","None of the above industries","0 ã 1 Year","1 ã 3 Years","Trade/Export Finance","Local Trade";
        VarLenghtOfRelationshipOption: Option "Politically Exposed Persons (PEPs)","High Net worth",Other,"Publicly Held Companies","Privately Held Companies","Domestic Government Entities",Churches,SMEs,Schools,"Welfare Groups","Financial entities Regulated by local regulators",Resident,"Non-Resident","Money Services Businesses","Charities and Non-Profit Organizations",Trusts,"Real Estate Agencies","High Value Goods Businesses","Precious Metals Businesses","Cash Intensive Businesses","Art Galleries & related businesses","Professional Service Providers","None of the above industries","0 ã 1 Year","1 ã 3 Years","Trade/Export Finance","Local Trade",">3";
        VarMemberSaccoAge: Integer;
        ObjProducts: Record Vendor;
        ObjChequeBook: Record "Cheque Book Application";
        VarElectronicPayment: Option "International Wire Transfers","Local Wire Transfers","Mobile Transfers","None of the Above","Fixed/Call Deposit Accounts","KSA/Imara/MJA/Heritage)","Account with Sealed Safe deposit","Account with  Open Safe Deposit","All Loan Accounts",BOSA," Ufalme","ATM Debit",Credit,Both,"None","Non-face to face channels","Unsolicited Account Origination e.g. Walk-Ins","Cheque book",Others;
        VarChannelsTaken: Option "International Wire Transfers","Local Wire Transfers","Mobile Transfers","None of the Above","Fixed/Call Deposit Accounts","KSA/Imara/MJA/Heritage)","Account with Sealed Safe deposit","Account with  Open Safe Deposit","All Loan Accounts",BOSA," Ufalme","ATM Debit",Credit,Both,"None","Non-face to face channels","Unsolicited Account Origination e.g. Walk-Ins","Cheque book",Others;
    begin

        //==============================================================================================Member Category(High Net Worth|PEPS|Others)
        ObjMembers.Reset;
        ObjMembers.SetRange(ObjMembers."No.", MemberNo);
        if ObjMembers.FindSet then begin


            //==============================================================================High Net Worth
            ObjNetWorth.Reset;
            if ObjNetWorth.FindSet then begin
                repeat
                    if (ObjMembers."Expected Monthly Income Amount" >= ObjNetWorth."Min Monthly Income") and
                      (ObjMembers."Expected Monthly Income Amount" <= ObjNetWorth."Max Monthlyl Income") then begin
                        VarHighNet := ObjNetWorth."Risk Rate";
                        Message('VarHighNet is %1', VarHighNet);
                    end;
                until ObjNetWorth.Next = 0;
            end;
            //==========================================================================End High Net Worth

            //====================================================================Politicall Exposed Persons

            /*IF VarFirstName='' THEN
            VarFirstName:='$$';
            IF VarMidlleName='' THEN
              VarMidlleName:='$$';
            IF VarLastName='' THEN
              VarLastName:='$$';

            VarFirstName:=ObjMembers.First
            */
            /*ObjPeps.RESET;
            ObjPeps.RESET;
            //ObjPeps.SETFILTER(ObjPeps.Name,'(%1&%2)|(%3&%4)|(%5&%6)','*'+VarFirstName+'*', '*'+VarMidlleName+'*','*'+VarFirstName+'*','*'+VarLastName+'*','*'+VarMidlleName+'*','*'+VarLastName+'*');
            IF ObjPeps.FINDSET THEN
              BEGIN
                 ObjCustRiskRates.RESET;
                 ObjCustRiskRates.SETRANGE(ObjCustRiskRates.Category,ObjCustRiskRates.Category::Individuals);
                 ObjCustRiskRates.SETRANGE(ObjCustRiskRates."Sub Category Option",ObjCustRiskRates."Sub Category Option"::"Politically Exposed Persons (PEPs)");
                 IF ObjCustRiskRates.FINDSET THEN
                   BEGIN
                     VarPepsRiskScore:=ObjCustRiskRates."Risk Score";
                     END;
                END;
            //================================================================End Politicall Exposed Persons*/

            if (VarHighNet < 5) and (VarPepsRiskScore = 0) then begin

                ObjCustRiskRates.Reset;
                ObjCustRiskRates.SetRange(ObjCustRiskRates.Category, ObjCustRiskRates.Category::Individuals);
                ObjCustRiskRates.SetRange(ObjCustRiskRates."Sub Category Option", ObjCustRiskRates."sub category option"::Other);
                if ObjCustRiskRates.FindSet then begin
                    VarCategoryScore := ObjCustRiskRates."Risk Score";
                    VarIndividualCategoryOption := Varindividualcategoryoption::Other;
                end;

            end else
                if (VarHighNet = 5) and (VarPepsRiskScore = 0) then begin

                    ObjCustRiskRates.Reset;
                    ObjCustRiskRates.SetRange(ObjCustRiskRates.Category, ObjCustRiskRates.Category::Individuals);
                    ObjCustRiskRates.SetRange(ObjCustRiskRates."Sub Category Option", ObjCustRiskRates."sub category option"::"High Net worth");
                    if ObjCustRiskRates.FindSet then begin
                        VarCategoryScore := ObjCustRiskRates."Risk Score";
                        VarIndividualCategoryOption := Varindividualcategoryoption::"High Net worth";
                    end;

                end else
                    if (VarHighNet <> 5) and (VarPepsRiskScore = 5) then begin

                        ObjCustRiskRates.Reset;
                        ObjCustRiskRates.SetRange(ObjCustRiskRates.Category, ObjCustRiskRates.Category::Individuals);
                        ObjCustRiskRates.SetRange(ObjCustRiskRates."Sub Category Option", ObjCustRiskRates."sub category option"::"Politically Exposed Persons (PEPs)");
                        if ObjCustRiskRates.FindSet then begin
                            VarCategoryScore := ObjCustRiskRates."Risk Score";
                            VarIndividualCategoryOption := Varindividualcategoryoption::"Politically Exposed Persons (PEPs)";
                        end;
                    end;
        end;
        //=========================================================================END Member Category(High Net Worth|PEPS|Others)



        ObjMembers.Reset;
        ObjMembers.SetRange(ObjMembers."No.", MemberNo);
        if ObjMembers.FindSet then begin
            ObjCustRiskRates.Reset;
            ObjCustRiskRates.SetRange(ObjCustRiskRates.Category, ObjCustRiskRates.Category::Individuals);
            ObjCustRiskRates.SetRange(ObjCustRiskRates."Sub Category", ObjMembers."Individual Category");
            if ObjCustRiskRates.FindSet then begin
                VarCategoryScore := ObjCustRiskRates."Risk Score";
            end;
        end;


        ObjMembers.Reset;
        ObjMembers.SetRange(ObjMembers."No.", MemberNo);
        if ObjMembers.FindSet then begin
            ObjCustRiskRates.Reset;
            ObjCustRiskRates.SetRange(ObjCustRiskRates.Category, ObjCustRiskRates.Category::Entities);
            ObjCustRiskRates.SetRange(ObjCustRiskRates."Sub Category", ObjMembers.Entities);
            if ObjCustRiskRates.FindSet then begin
                VarEntityScore := ObjCustRiskRates."Risk Score";
            end;
        end;

        ObjMembers.Reset;
        ObjMembers.SetRange(ObjMembers."No.", MemberNo);
        if ObjMembers.FindSet then begin
            ObjCustRiskRates.Reset;
            ObjCustRiskRates.SetRange(ObjCustRiskRates.Category, ObjCustRiskRates.Category::"Residency Status");
            ObjCustRiskRates.SetRange(ObjCustRiskRates."Sub Category", ObjMembers."Member Residency Status");
            if ObjCustRiskRates.FindSet then begin
                VarResidencyScore := ObjCustRiskRates."Risk Score";
            end;
        end;


        ObjMembers.Reset;
        ObjMembers.SetRange(ObjMembers."No.", MemberNo);
        if ObjMembers.FindSet then begin
            //=============================================================Exisiting Referee
            ObjMemberRiskRate.Reset;
            ObjMemberRiskRate.SetRange(ObjMemberRiskRate."Membership Application No", ObjMembers."Referee Member No");
            if ObjMemberRiskRate.FindSet then begin
                if ObjMembers."Referee Member No" <> '' then begin

                    ObjRefereeSetup.Reset;
                    if ObjRefereeSetup.FindSet then begin
                        repeat
                            if (ObjMemberRiskRate."GROSS CUSTOMER AML RISK RATING" >= ObjRefereeSetup."Minimum Risk Rate") and
                              (ObjMemberRiskRate."GROSS CUSTOMER AML RISK RATING" <= ObjRefereeSetup."Maximum Risk Rate") then begin
                                VarRefereeScore := ObjRefereeSetup.Score;
                                VarRefereeRiskRate := ObjRefereeSetup.Description;
                            end;
                        until ObjRefereeSetup.Next = 0;
                    end;
                end;

                //=============================================================No Referee
                if ObjMembers."Referee Member No" = '' then begin
                    ObjRefereeSetup.Reset;
                    ObjRefereeSetup.SetFilter(ObjRefereeSetup.Description, '%1', 'Others with no referee');
                    if ObjRefereeSetup.FindSet then begin
                        VarRefereeScore := ObjRefereeSetup.Score;
                        VarRefereeRiskRate := 'Others with no referee';
                    end;
                end;
            end;


            ObjCustRiskRates.Reset;
            ObjCustRiskRates.SetRange(ObjCustRiskRates.Category, ObjCustRiskRates.Category::"Residency Status");
            ObjCustRiskRates.SetRange(ObjCustRiskRates."Sub Category", ObjMembers."Member Residency Status");
            if ObjCustRiskRates.FindSet then begin
                VarResidencyScore := ObjCustRiskRates."Risk Score";
            end;
        end;

        ObjMembers.Reset;
        ObjMembers.SetRange(ObjMembers."No.", MemberNo);
        if ObjMembers.FindSet then begin
            ObjCustRiskRates.Reset;
            ObjCustRiskRates.SetRange(ObjCustRiskRates.Category, ObjCustRiskRates.Category::Industry);
            ObjCustRiskRates.SetRange(ObjCustRiskRates."Sub Category", ObjMembers."Industry Type");
            if ObjCustRiskRates.FindSet then begin
                VarIndustryScore := ObjCustRiskRates."Risk Score";
            end;
        end;

        //======================================================================Lenght Of Relationship
        ObjMembers.Reset;
        ObjMembers.SetRange(ObjMembers."No.", MemberNo);
        if ObjMembers.FindSet then begin
            if ObjMembers."Registration Date" <> 0D then
                VarMemberSaccoAge := ROUND((WorkDate - ObjMembers."Registration Date") / 365, 1, '<');

            ObjCustRiskRates.Reset;
            ObjCustRiskRates.SetRange(ObjCustRiskRates.Category, ObjCustRiskRates.Category::"Length Of Relationship");
            if ObjCustRiskRates.FindSet then begin
                repeat
                    if (VarMemberSaccoAge >= ObjCustRiskRates."Min Relationship Length(Years)") and
                     (VarMemberSaccoAge <= ObjCustRiskRates."Max Relationship Length(Years)") then begin
                        VarLenghtOfRelationshipScore := ObjCustRiskRates."Risk Score";
                        VarLenghtOfRelationshipOption := ObjCustRiskRates."Sub Category Option";
                    end;
                until ObjCustRiskRates.Next = 0;
            end;
        end;




        ObjMembers.Reset;
        ObjMembers.SetRange(ObjMembers."No.", MemberNo);
        if ObjMembers.FindSet then begin
            ObjCustRiskRates.Reset;
            ObjCustRiskRates.SetRange(ObjCustRiskRates.Category, ObjCustRiskRates.Category::"International Trade");
            ObjCustRiskRates.SetRange(ObjCustRiskRates."Sub Category", ObjMembers."International Trade");
            if ObjCustRiskRates.FindSet then begin
                VarInternationalTradeScore := ObjCustRiskRates."Risk Score";
            end;
        end;


        ObjMembers.Reset;
        ObjMembers.SetRange(ObjMembers."No.", MemberNo);
        ObjMembers.SetRange(ObjMembers."Is Mobile Registered", false);
        if ObjMembers.FindSet then begin
            ObjProductRiskRating.Reset;
            ObjProductRiskRating.SetCurrentkey(ObjProductRiskRating."Product Type Code");
            ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Category", ObjProductRiskRating."product category"::"Electronic Payment");
            ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Type Code", ObjMembers."Electronic Payment");
            if ObjProductRiskRating.FindSet then begin
                VarElectronicPayment := Varelectronicpayment::"None of the Above";
                VarElectronicPaymentScore := ObjProductRiskRating."Risk Score";
            end;
        end;

        ObjMembers.Reset;
        ObjMembers.SetRange(ObjMembers."No.", MemberNo);
        ObjMembers.SetRange(ObjMembers."Is Mobile Registered", true);
        if ObjMembers.FindSet then begin
            ObjProductRiskRating.Reset;
            ObjProductRiskRating.SetCurrentkey(ObjProductRiskRating."Product Type Code");
            ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Category", ObjProductRiskRating."product category"::"Electronic Payment");
            ObjProductRiskRating.SetFilter(ObjProductRiskRating."Product Type Code", '%1', 'Mobile Transfers');
            if ObjProductRiskRating.FindSet then begin
                VarElectronicPayment := Varelectronicpayment::"Mobile Transfers";
                VarElectronicPaymentScore := ObjProductRiskRating."Risk Score";
            end;
        end;


        //ObjProductRiskRating.GET();
        ObjMembers.Reset;
        ObjMembers.SetRange(ObjMembers."No.", MemberNo);
        if ObjMembers.FindSet then begin

            ObjProductRiskRating.Reset;
            ObjProductRiskRating.SetCurrentkey(ObjProductRiskRating."Product Type Code");
            ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Category", ObjProductRiskRating."product category"::Cards);
            ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Type Code", ObjMembers."Cards Type Taken");
            if ObjProductRiskRating.FindSet then begin
                VarCardTypeScore := ObjProductRiskRating."Risk Score";
            end;
        end;

        //================================================================Check Account Type Taken
        ObjProductRiskRating.Reset;
        ObjProductRiskRating.SetCurrentkey(ObjProductRiskRating."Product Type Code");
        ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Category", ObjProductRiskRating."product category"::Cards);
        ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Type Code", ObjMembers."Accounts Type Taken");
        if ObjCustRiskRates.FindSet then begin
            VarAccountTypeScore := ObjProductRiskRating."Risk Score";
        end;

        ObjChequeBook.CalcFields(ObjChequeBook."Member No");
        ObjChequeBook.Reset;
        ObjChequeBook.SetRange(ObjChequeBook."Member No", MemberNo);
        if not ObjChequeBook.FindSet then begin
            ObjProductRiskRating.Reset;
            ObjProductRiskRating.SetCurrentkey(ObjProductRiskRating."Product Type Code");
            ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Category", ObjProductRiskRating."product category"::Others);
            ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Type Code", ObjMembers."Others(Channels)");
            if ObjCustRiskRates.FindSet then begin
                VarChannelsTaken := Varchannelstaken::Others;
                VarChannelTakenScore := ObjProductRiskRating."Risk Score";
            end;

        end else
            ObjProductRiskRating.Reset;
        ObjProductRiskRating.SetCurrentkey(ObjProductRiskRating."Product Type Code");
        ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Category", ObjProductRiskRating."product category"::Others);
        ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Type Code", '%1', 'Cheque book');
        if ObjCustRiskRates.FindSet then begin
            VarChannelsTaken := Varchannelstaken::"Cheque book";
            VarChannelTakenScore := ObjProductRiskRating."Risk Score";
        end;

        ObjProducts.Reset;
        ObjProducts.SetRange(ObjProducts."BOSA Account No", MemberNo);
        ObjProducts.SetFilter(ObjProducts."Global Dimension 1 Code", '<>%1', 'FOSA');
        if ObjProducts.FindSet then begin
            repeat
                ObjProductRiskRating.Reset;
                ObjProductRiskRating.SetCurrentkey(ObjProductRiskRating."Product Type");
                ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Category", ObjProductRiskRating."product category"::Accounts);
                ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Type", ObjProductRiskRating."product type"::Credit);
                if ObjProductRiskRating.FindSet then begin
                    VarAccountTypeScoreVer1 := ObjProductRiskRating."Risk Score";
                    VarAccountTypeOptionVer1 := ObjProductRiskRating."product type"::Credit;
                    VarAccountTypeScore := ObjProductRiskRating."Risk Score";
                    VarAccountTypeOption := ObjProductRiskRating."product type"::Credit;
                end;
            until ObjProducts.Next = 0;
        end;

        ObjProducts.Reset;
        ObjProducts.SetRange(ObjProducts."BOSA Account No", MemberNo);
        ObjProducts.SetFilter(ObjProducts."Global Dimension 1 Code", '%1', 'FOSA');
        ObjProducts.SetFilter(ObjProducts."Account Type", '<>%1|%2', '503', '506');
        if ObjProducts.FindSet then begin

            repeat
                ObjProductRiskRating.Reset;
                ObjProductRiskRating.SetCurrentkey(ObjProductRiskRating."Product Type");
                ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Category", ObjProductRiskRating."product category"::Accounts);
                ObjProductRiskRating.SetFilter(ObjProductRiskRating."Product Type Code", '%1', 'FOSA (KSA, Imara, Heritage, MJA)');
                if ObjProductRiskRating.FindSet then begin
                    VarAccountTypeScoreVer2 := ObjProductRiskRating."Risk Score";
                    VarAccountTypeOptionVer2 := ObjProductRiskRating."product type"::"KSA/Imara/MJA/Heritage)";
                    VarAccountTypeScore := ObjProductRiskRating."Risk Score";
                    VarAccountTypeOption := ObjProductRiskRating."product type"::"KSA/Imara/MJA/Heritage)";
                end;
            until ObjProducts.Next = 0;
        end;


        ObjProducts.Reset;
        ObjProducts.SetRange(ObjProducts."BOSA Account No", MemberNo);
        ObjProducts.SetFilter(ObjProducts."Account Type", '%1|%2', '503', '506');
        if ObjProducts.FindSet then begin
            repeat
                ObjProductRiskRating.Reset;
                ObjProductRiskRating.SetCurrentkey(ObjProductRiskRating."Product Type");
                ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Category", ObjProductRiskRating."product category"::Accounts);
                ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Type", ObjProductRiskRating."product type"::"Fixed/Call Deposit Accounts");
                if ObjProductRiskRating.FindSet then begin
                    VarAccountTypeScoreVer3 := ObjProductRiskRating."Risk Score";
                    VarAccountTypeOptionVer3 := ObjProductRiskRating."product type"::"Fixed/Call Deposit Accounts";
                    VarAccountTypeScore := ObjProductRiskRating."Risk Score";
                    VarAccountTypeOption := ObjProductRiskRating."product type"::"Fixed/Call Deposit Accounts";
                end;
            until ObjProducts.Next = 0;
        end;


        ObjLoans.Reset;
        ObjLoans.CalcFields(ObjLoans."Outstanding Balance");
        ObjLoans.SetRange(ObjLoans."Client Code", MemberNo);
        ObjLoans.SetFilter(ObjLoans."Outstanding Balance", '%1', 0);
        if ObjLoans.FindSet then begin
            ObjProductRiskRating.Reset;
            ObjProductRiskRating.SetCurrentkey(ObjProductRiskRating."Product Type");
            ObjProductRiskRating.SetRange(ObjProductRiskRating."Product Category", ObjProductRiskRating."product category"::Accounts);
            ObjProductRiskRating.SetFilter(ObjProductRiskRating."Product Type Code", '%1', 'All Loan Accounts');
            if ObjProductRiskRating.FindSet then begin
                VarAccountTypeScoreVer4 := ObjProductRiskRating."Risk Score";
                VarAccountTypeOptionVer4 := ObjProductRiskRating."product type"::"All Loan Accounts";
                VarAccountTypeScore := ObjProductRiskRating."Risk Score";
                VarAccountTypeOption := ObjProductRiskRating."product type"::"All Loan Accounts";
            end;
        end;

        if (VarAccountTypeScoreVer1 > VarAccountTypeScoreVer2) and (VarAccountTypeScoreVer1 > VarAccountTypeScoreVer3)
         and (VarAccountTypeScoreVer1 > VarAccountTypeScoreVer4) then begin
            VarAccountTypeScore := VarAccountTypeScoreVer1;
            VarAccountTypeOption := VarAccountTypeOptionVer1
        end else
            if (VarAccountTypeScoreVer2 > VarAccountTypeScoreVer1) and (VarAccountTypeScoreVer2 > VarAccountTypeScoreVer3)
            and (VarAccountTypeScoreVer2 > VarAccountTypeScoreVer4) then begin
                VarAccountTypeScore := VarAccountTypeScoreVer2;
                VarAccountTypeOption := VarAccountTypeOptionVer2
            end else
                if (VarAccountTypeScoreVer3 > VarAccountTypeScoreVer1) and (VarAccountTypeScoreVer3 > VarAccountTypeScoreVer2)
                and (VarAccountTypeScoreVer3 > VarAccountTypeScoreVer4) then begin
                    VarAccountTypeScore := VarAccountTypeScoreVer3;
                    VarAccountTypeOption := VarAccountTypeOptionVer3
                end else
                    if (VarAccountTypeScoreVer4 > VarAccountTypeScoreVer1) and (VarAccountTypeScoreVer4 > VarAccountTypeScoreVer2)
                    and (VarAccountTypeScoreVer4 > VarAccountTypeScoreVer3) then begin
                        VarAccountTypeScore := VarAccountTypeScoreVer4;
                        VarAccountTypeOption := VarAccountTypeOptionVer4
                    end;





        //Create Entries on Membership Risk Rating Table
        ObjEntitiesRiskRating.Reset;
        ObjEntitiesRiskRating.SetRange(ObjEntitiesRiskRating."Membership Application No", MemberNo);
        if ObjEntitiesRiskRating.FindSet then begin
            ObjEntitiesRiskRating.DeleteAll;
        end;


        //===============================================Get Control Risk Rating
        ObjControlRiskRating.Reset;
        if ObjControlRiskRating.FindSet then begin
            ObjControlRiskRating.CalcSums(ObjControlRiskRating."Control Weight Aggregate");
            VarControlRiskRating := ObjControlRiskRating."Control Weight Aggregate";
        end;



        ObjEntitiesRiskRating.Init;
        ObjEntitiesRiskRating."Membership Application No" := MemberNo;
        ObjEntitiesRiskRating."What is the Customer Category?" := ObjMembers."Individual Category";
        ObjEntitiesRiskRating."Customer Category Score" := VarCategoryScore;
        ObjEntitiesRiskRating."What is the Member residency?" := ObjMembers."Member Residency Status";
        ObjEntitiesRiskRating."Member Residency Score" := VarResidencyScore;
        ObjEntitiesRiskRating."Cust Employment Risk?" := ObjMembers.Entities;
        ObjEntitiesRiskRating."Cust Employment Risk Score" := VarEntityScore;
        ObjEntitiesRiskRating."Cust Business Risk Industry?" := ObjMembers."Industry Type";
        ObjEntitiesRiskRating."Cust Bus. Risk Industry Score" := VarIndustryScore;
        ObjEntitiesRiskRating."Lenght Of Relationship?" := Format(VarLenghtOfRelationshipOption);
        ObjEntitiesRiskRating."Length Of Relation Score" := VarLenghtOfRelationshipScore;
        ObjEntitiesRiskRating."Cust Involved in Intern. Trade" := ObjMembers."International Trade";
        ObjEntitiesRiskRating."Involve in Inter. Trade Score" := VarInternationalTradeScore;
        ObjEntitiesRiskRating."Account Type Taken?" := Format(VarAccountTypeOption);
        ObjEntitiesRiskRating."Account Type Taken Score" := VarAccountTypeScore;
        ObjEntitiesRiskRating."Card Type Taken" := ObjMembers."Cards Type Taken";
        ObjEntitiesRiskRating."Card Type Taken Score" := VarCardTypeScore;
        ObjEntitiesRiskRating."Channel Taken?" := Format(VarChannelsTaken);
        ObjEntitiesRiskRating."Channel Taken Score" := VarChannelTakenScore;
        ObjEntitiesRiskRating."Electronic Payments?" := Format(VarElectronicPayment);
        ObjEntitiesRiskRating."Electronic Payments Score" := VarElectronicPaymentScore;
        MemberTotalRiskRatingScore := VarCategoryScore + VarEntityScore + VarIndustryScore + VarInternationalTradeScore + VarLenghtOfRelationshipScore + VarResidencyScore + VarAccountTypeScore
        + VarCardTypeScore + VarChannelTakenScore + VarElectronicPaymentScore;
        ObjEntitiesRiskRating."GROSS CUSTOMER AML RISK RATING" := MemberTotalRiskRatingScore;
        ObjEntitiesRiskRating."BANK'S CONTROL RISK RATING" := VarControlRiskRating;
        ObjEntitiesRiskRating."CUSTOMER NET RISK RATING" := ROUND(ObjEntitiesRiskRating."GROSS CUSTOMER AML RISK RATING" / ObjEntitiesRiskRating."BANK'S CONTROL RISK RATING", 0.01, '>');
        MemberNetRiskScore := MemberTotalRiskRatingScore / VarControlRiskRating;

        ObjEntitiesNetRiskScale.Reset;
        if ObjEntitiesNetRiskScale.FindSet then begin
            repeat
                if (MemberTotalRiskRatingScore >= ObjEntitiesNetRiskScale."Minimum Risk Rate") and (MemberTotalRiskRatingScore <= ObjEntitiesNetRiskScale."Maximum Risk Rate") then begin
                    ObjEntitiesRiskRating."Risk Rate Scale" := ObjEntitiesNetRiskScale."Risk Scale";
                    VarRiskRatingDescription := ObjEntitiesNetRiskScale.Description;
                end;
            until ObjEntitiesNetRiskScale.Next = 0;
        end;
        ObjEntitiesRiskRating.Insert;
        ObjEntitiesRiskRating.Validate(ObjEntitiesRiskRating."Membership Application No");
        ObjEntitiesRiskRating.Modify;


        ObjMemberDueDiligence.Reset;
        ObjMemberDueDiligence.SetRange(ObjMemberDueDiligence."Member No", MemberNo);
        if ObjMemberDueDiligence.FindSet then begin
            ObjMemberDueDiligence.DeleteAll;
        end;

        ObjDueDiligenceSetup.Reset;
        ObjDueDiligenceSetup.SetRange(ObjDueDiligenceSetup."Risk Rating Level", ObjEntitiesRiskRating."Risk Rate Scale");
        if ObjDueDiligenceSetup.FindSet then begin
            repeat
                ObjMemberDueDiligence.Init;
                ObjMemberDueDiligence."Member No" := MemberNo;
                if ObjMembers.Get(MemberNo) then begin
                    ObjMemberDueDiligence."Member Name" := ObjMembers.Name;
                end;
                ObjMemberDueDiligence."Due Diligence No" := ObjDueDiligenceSetup."Due Diligence No";
                ObjMemberDueDiligence."Risk Rating Level" := ObjEntitiesRiskRating."Risk Rate Scale";
                ObjMemberDueDiligence."Risk Rating Scale" := VarRiskRatingDescription;
                ObjMemberDueDiligence."Due Diligence Type" := ObjDueDiligenceSetup."Due Diligence Type";
                ObjMemberDueDiligence."Due Diligence Measure" := ObjDueDiligenceSetup."Due Diligence Measure";
                ObjMemberDueDiligence.Insert;
            until ObjDueDiligenceSetup.Next = 0;
        end;

        ObjMembers.Reset;
        ObjMembers.SetRange(ObjMembers."No.", MemberNo);
        if ObjMembers.FindSet then begin
            ObjMembers.CalcFields(ObjMembers."Has ATM Card");
            ObjMembers."Individual Category" := Format(VarIndividualCategoryOption);
            ObjMembers."Member Residency Status" := ObjMembers."Member Residency Status";
            ObjMembers.Entities := ObjMembers.Entities;
            ObjMembers."Industry Type" := ObjMembers."Industry Type";
            ObjMembers."Length Of Relationship" := Format(VarLenghtOfRelationshipOption);
            ObjMembers."International Trade" := ObjMembers."International Trade";
            ObjMembers."Accounts Type Taken" := Format(VarAccountTypeOption);
            if ObjMembers."Has ATM Card" = true then
                ObjMembers."Cards Type Taken" := 'ATM Debit'
            else
                ObjMembers."Cards Type Taken" := 'None';
            ObjMembers."Others(Channels)" := Format(VarChannelsTaken);
            ObjMembers."Referee Risk Rate" := VarRefereeRiskRate;
            ObjMembers."Electronic Payment" := Format(VarElectronicPayment);
            ObjMembers."Member Risk Level" := ObjMemberRiskRating."Risk Rate Scale";
            ObjMembers."Due Diligence Measure" := ObjDueDiligenceSetup."Due Diligence Type";
            ObjMembers.Modify;
        end;

    end;


    procedure FnGetMemberLiability(MemberNo: Code[30]) VarTotaMemberLiability: Decimal
    var
        ObjLoanGuarantors: Record "Loans Guarantee Details";
        ObjLoans: Record "Loans Register";
        ObjLoanSecurities: Record "Loan Collateral Details";
        ObjLoanGuarantors2: Record "Loans Guarantee Details";
        VarTotalGuaranteeValue: Decimal;
        VarMemberAnountGuaranteed: Decimal;
        VarApportionedLiability: Decimal;
        VarLoanOutstandingBal: Decimal;
    begin
        ObjMembers.Reset;
        ObjMembers.SetRange(ObjMembers."No.", MemberNo);
        if ObjMembers.FindSet then begin

            VarTotalGuaranteeValue := 0;
            VarApportionedLiability := 0;
            VarTotaMemberLiability := 0;
            //Loans Guaranteed=======================================================================
            ObjLoanGuarantors.CalcFields(ObjLoanGuarantors."Outstanding Balance");
            ObjLoanGuarantors.Reset;
            ObjLoanGuarantors.SetRange(ObjLoanGuarantors."Member No", MemberNo);
            ObjLoanGuarantors.SetFilter(ObjLoanGuarantors."Outstanding Balance", '>%1', 0);
            if ObjLoanGuarantors.FindSet then begin
                repeat
                    if ObjLoanGuarantors."Amont Guaranteed" > 0 then begin
                        ObjLoanGuarantors.CalcFields(ObjLoanGuarantors."Total Loans Guaranteed");
                        if ObjLoans.Get(ObjLoanGuarantors."Loan No") then begin
                            ObjLoans.CalcFields(ObjLoans."Outstanding Balance");
                            if ObjLoans."Outstanding Balance" > 0 then begin
                                VarLoanOutstandingBal := ObjLoans."Outstanding Balance";
                                if ObjLoanGuarantors."Total Loans Guaranteed" <> 0 then begin
                                    VarApportionedLiability := ROUND((ObjLoanGuarantors."Amont Guaranteed" / ObjLoanGuarantors."Total Loans Guaranteed") * VarLoanOutstandingBal, 0.5, '=');
                                end
                            end
                        end;
                    end;
                    VarTotaMemberLiability := VarTotaMemberLiability + VarApportionedLiability;
                until ObjLoanGuarantors.Next = 0;
            end;
        end;
        exit(VarTotaMemberLiability);

    end;


    procedure FnGetMemberMonthlyContributionDepositstier(MemberNo: Code[30]) VarMemberMonthlyContribution: Decimal
    var
        ObjMember: Record Customer;
        ObjLoans: Record "Loans Register";
        VarTotalLoansIssued: Decimal;
        ObjDeposittier: Record "Member Deposit Tier";
    begin
        VarTotalLoansIssued := 0;
        VarMemberMonthlyContribution := 0;

        ObjMember.Reset;
        ObjMember.SetRange(ObjMember."No.", MemberNo);
        if ObjMember.FindSet then begin
            ObjLoans.CalcFields(ObjLoans."Outstanding Balance");

            ObjLoans.Reset;
            ObjLoans.SetRange(ObjLoans."Client Code", MemberNo);
            ObjLoans.SetRange(ObjLoans.Posted, true);
            ObjLoans.SetFilter(ObjLoans."Outstanding Balance", '>%1', 0);
            if ObjLoans.FindSet then begin
                ObjLoans.CalcSums(ObjLoans."Approved Amount");
                VarTotalLoansIssued := ObjLoans."Approved Amount";
            end;

            ObjDeposittier.Reset;
            ObjDeposittier.SetFilter(ObjDeposittier."Minimum Amount", '<=%1', VarTotalLoansIssued);
            ObjDeposittier.SetFilter(ObjDeposittier."Maximum Amount", '>=%1', VarTotalLoansIssued);
            if ObjDeposittier.FindSet then begin
                VarMemberMonthlyContribution := ObjDeposittier.Amount;
            end;

            ObjGenSetUp.Get;
            if (ObjMember."Account Category" = ObjMember."account category"::Individual)
            and (VarMemberMonthlyContribution < ObjGenSetUp."Min. Contribution") then
                VarMemberMonthlyContribution := ObjGenSetUp."Min. Contribution";
            if (ObjMember."Account Category" <> ObjMember."account category"::Individual)
            and (VarMemberMonthlyContribution < ObjGenSetUp."Corporate Minimum Monthly Cont") then
                VarMemberMonthlyContribution := ObjGenSetUp."Corporate Minimum Monthly Cont";

            exit(VarMemberMonthlyContribution);
        end;

    end;


    procedure FnGetMemberMonthlyContributionAsAt(MemberNo: Code[30]; AsAtDate: Date) VarMemberMonthlyContribution: Decimal
    var
        ObjMember: Record Customer;
        ObjLoans: Record "Loans Register";
        VarTotalLoansIssued: Decimal;
        ObjDeposittier: Record "Member Deposit Tier";
        MonthlyDepositContribution: Decimal;
    begin
        VarTotalLoansIssued := 0;
        VarMemberMonthlyContribution := 0;

        ObjMember.Reset;
        ObjMember.SetRange(ObjMember."No.", MemberNo);
        if ObjMember.FindSet then begin
            ObjLoans.CalcFields(ObjLoans."Outstanding Balance");

            ObjLoans.Reset;
            ObjLoans.SetRange(ObjLoans."Client Code", MemberNo);
            ObjLoans.SetRange(ObjLoans.Posted, true);
            ObjLoans.SetFilter(ObjLoans."Date filter", '..' + Format(AsAtDate));
            ObjLoans.SetFilter(ObjLoans."Issued Date", '<=%1', AsAtDate);
            ObjLoans.SetFilter(ObjLoans."Outstanding Balance", '>%1', 0);
            if ObjLoans.FindSet then begin
                ObjLoans.CalcSums(ObjLoans."Approved Amount");
                VarTotalLoansIssued := ObjLoans."Approved Amount";
            end;

            ObjDeposittier.Reset;
            ObjDeposittier.SetFilter(ObjDeposittier."Minimum Amount", '<=%1', VarTotalLoansIssued);
            ObjDeposittier.SetFilter(ObjDeposittier."Maximum Amount", '>=%1', VarTotalLoansIssued);
            if ObjDeposittier.FindSet then begin
                VarMemberMonthlyContribution := ObjDeposittier.Amount;
            end;

            ObjGenSetUp.Get;
            if (ObjMember."Account Category" = ObjMember."account category"::Individual)
            and (VarMemberMonthlyContribution < ObjGenSetUp."Min. Contribution") then
                VarMemberMonthlyContribution := ObjGenSetUp."Min. Contribution";
            if (ObjMember."Account Category" <> ObjMember."account category"::Individual)
            and (VarMemberMonthlyContribution < ObjGenSetUp."Corporate Minimum Monthly Cont") then
                VarMemberMonthlyContribution := ObjGenSetUp."Corporate Minimum Monthly Cont";

            exit(VarMemberMonthlyContribution);
        end;

    end;


    procedure FnGetAccountMonthlyCredit(VarAccountNo: Code[20]; VarTransactionDate: Date; VarMemberNo: Code[30]) VarMonthCredits: Decimal
    var
        ObjVendorLedger: Record "Detailed Vendor Ledg. Entry";
        VarStartDate: Integer;
        VarMonthMonth: Integer;
        VarMonthYear: Integer;
        VarMonthStartDate: Date;
        VarDateFilter: Text;
        ObjAccount: Record Vendor;
    begin
        VarStartDate := 1;
        VarMonthMonth := Date2dmy(VarTransactionDate, 2);
        VarMonthYear := Date2dmy(VarTransactionDate, 3);
        VarMonthStartDate := Dmy2date(VarStartDate, VarMonthMonth, VarMonthYear);
        VarDateFilter := Format(VarMonthStartDate) + '..' + Format(VarTransactionDate);

        ObjAccount.Reset;
        ObjAccount.SetRange(ObjAccount."BOSA Account No", VarMemberNo);
        if ObjAccount.FindSet then begin
            repeat

                ObjVendorLedger.Reset;
                ObjVendorLedger.SetRange(ObjVendorLedger."Vendor No.", ObjAccount."No.");
                ObjVendorLedger.SetFilter(ObjVendorLedger."Posting Date", VarDateFilter);
                ObjVendorLedger.SetRange(ObjVendorLedger.Reversed, false);
                ObjVendorLedger.SetFilter(ObjVendorLedger.Amount, '<%1', 0);
                if ObjVendorLedger.FindSet then begin
                    ObjVendorLedger.CalcSums(ObjVendorLedger.Amount);
                    VarMonthCredits := VarMonthCredits + (ObjVendorLedger.Amount * -1);
                end;
            until ObjAccount.Next = 0;
            exit(VarMonthCredits);
        end;
    end;


    procedure FnCreateGnlJournalLineMC(TemplateName: Text; BatchName: Text; DocumentNo: Code[30]; LineNo: Integer; TransactionType: Option " ","Registration Fee","Share Capital","Interest Paid","Loan Repayment","Deposit Contribution","Insurance Contribution","Benevolent Fund",Loan,"Unallocated Funds",Dividend,"FOSA Account"; AccountType: enum "Gen. Journal Account Type"; AccountNo: Code[50]; TransactionDate: Date; TransactionAmount: Decimal; DimensionActivity: Code[40]; ExternalDocumentNo: Code[50]; TransactionDescription: Text; LoanNumber: Code[50]; GroupCode: Code[100])
    var
        GenJournalLine: Record "Gen. Journal Line";
    begin
        GenJournalLine.Init;
        GenJournalLine."Journal Template Name" := TemplateName;
        GenJournalLine."Journal Batch Name" := BatchName;
        GenJournalLine."Document No." := DocumentNo;
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Account Type" := AccountType;
        GenJournalLine."Account No." := AccountNo;
        GenJournalLine."Transaction Type" := TransactionType;
        GenJournalLine."Loan No" := LoanNumber;
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Posting Date" := TransactionDate;
        GenJournalLine.Description := TransactionDescription;
        GenJournalLine.Validate(GenJournalLine."Currency Code");
        GenJournalLine.Amount := TransactionAmount;
        GenJournalLine."External Document No." := ExternalDocumentNo;
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Shortcut Dimension 1 Code" := DimensionActivity;
        GenJournalLine."Shortcut Dimension 2 Code" := FnGetUserBranch();
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        GenJournalLine."Group Code" := GroupCode;
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert;
    end;


    procedure FnCreateGnlJournalLineAtm(TemplateName: Text; BatchName: Text; DocumentNo: Code[30]; LineNo: Integer; TransactionType: Option " ","Registration Fee","Share Capital","Interest Paid","Loan Repayment","Deposit Contribution","Insurance Contribution","Benevolent Fund",Loan,"Unallocated Funds",Dividend,"FOSA Account"; AccountType: Enum "Gen. Journal Account Type"; AccountNo: Code[50]; TransactionDate: Date; TransactionAmount: Decimal; DimensionActivity: Code[40]; ExternalDocumentNo: Code[50]; TransactionDescription: Text[250]; LoanNumber: Code[50]; TraceID: Code[100])
    var
        GenJournalLine: Record "Gen. Journal Line";
    begin
        GenJournalLine.Init;
        GenJournalLine."Journal Template Name" := TemplateName;
        GenJournalLine."Journal Batch Name" := BatchName;
        GenJournalLine."Document No." := DocumentNo;
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Account Type" := AccountType;
        GenJournalLine."Account No." := AccountNo;
        GenJournalLine."Transaction Type" := TransactionType;
        GenJournalLine."Loan No" := LoanNumber;
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Posting Date" := TransactionDate;
        GenJournalLine.Description := TransactionDescription;
        GenJournalLine.Validate(GenJournalLine."Currency Code");
        GenJournalLine.Amount := TransactionAmount;
        GenJournalLine."External Document No." := ExternalDocumentNo;
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Shortcut Dimension 1 Code" := DimensionActivity;
        GenJournalLine."Shortcut Dimension 2 Code" := FnGetUserBranch();
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        GenJournalLine."ATM SMS" := true;
        GenJournalLine."Trace ID" := TraceID;
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert;
    end;


    procedure FnGetGroupNetworth(HouseGroupNo: Code[20]) VarNetWorth: Decimal
    var
        ObjCust: Record Customer;
        VarCollateralSecurity: Decimal;
        VarRepaymentPeriod: Date;
        VarArrears: Decimal;
        VarTotalArrears: Decimal;
        ObjLoanCollateral: Record "Loan Collateral Details";
        ObjCustII: Record Customer;
        VarLoanRisk: Decimal;
        VarRepaymentDate: Date;
        VarRepayDate: Integer;
        VarLastMonthDate: Integer;
        VarLastMonthMonth: Integer;
        VarLastMonthYear: Integer;
        ObjRepaymentSch: Record "Loan Repayment Schedule";
        VarTotalDeposits: Decimal;
        VaTotalLoanRisk: Decimal;
    begin

        VarRepaymentPeriod := WorkDate;
        VarArrears := 0;
        VarTotalArrears := 0;
        VaTotalLoanRisk := 0;

        ObjCust.Reset;
        ObjCust.SetFilter(ObjCust."Member House Group", '<>%1&=%2', '', HouseGroupNo);
        if ObjCust.FindSet then begin
            repeat

                ObjCust.CalcFields(ObjCust."Current Shares", ObjCust."Total BOSA Loan Balance");
                VarTotalDeposits := VarTotalDeposits + ObjCust."Current Shares";

                VarCollateralSecurity := 0;
                ObjLoanCollateral.CalcFields(ObjLoanCollateral."Outstanding Balance");
                ObjLoanCollateral.Reset;
                ObjLoanCollateral.SetRange(ObjLoanCollateral."Member No", ObjCust."No.");
                ObjLoanCollateral.SetFilter(ObjLoanCollateral."Outstanding Balance", '<>%1', 0);
                if ObjLoanCollateral.FindSet then begin
                    repeat
                        VarCollateralSecurity := VarCollateralSecurity + ObjLoanCollateral."Guarantee Value";
                    until ObjLoanCollateral.Next = 0;
                end;


                if ObjCust."Total BOSA Loan Balance" > VarCollateralSecurity then begin
                    VarLoanRisk := ObjCust."Total BOSA Loan Balance" - VarCollateralSecurity
                end else
                    VarLoanRisk := 0;


                VaTotalLoanRisk := VaTotalLoanRisk + VarLoanRisk;


                ObjLoans.Reset;
                ObjLoans.SetRange(ObjLoans."Client Code", ObjCust."No.");
                ObjLoans.SetRange(ObjLoans.Posted, true);
                if ObjLoans.FindSet then begin
                    repeat
                        ObjLoans.CalcFields(ObjLoans."Outstanding Balance");
                        if ObjLoans."Outstanding Balance" > 0 then begin
                            if ObjLoans."Repayment Frequency" = ObjLoans."repayment frequency"::Monthly then begin
                                if VarRepaymentPeriod = CalcDate('CM', VarRepaymentPeriod) then begin
                                    VarRepaymentDate := ObjLoans."Repayment Start Date";
                                    VarRepayDate := Date2dmy(VarRepaymentDate, 1);

                                    VarLastMonth := VarRepaymentPeriod;
                                end else begin
                                    VarLastMonth := CalcDate('-1M', VarRepaymentPeriod);
                                    VarLastMonthDate := Date2dmy(VarLastMonth, 1);
                                    VarLastMonthMonth := Date2dmy(VarLastMonth, 2);
                                    VarLastMonthYear := Date2dmy(VarLastMonth, 3);
                                end;
                                VarRepayDate := Date2dmy(VarLastMonth, 1);//DATE2DMY(ObjLoans."Repayment Start Date",1);
                                VarLastMonthMonth := Date2dmy(VarLastMonth, 2);
                                VarLastMonthYear := Date2dmy(VarLastMonth, 3);
                                VarLastMonth := Dmy2date(VarRepayDate, VarLastMonthMonth, VarLastMonthYear);

                            end;


                            ObjRepaymentSch.Reset;
                            ObjRepaymentSch.SetRange(ObjRepaymentSch."Loan No.", ObjLoans."Loan  No.");
                            ObjRepaymentSch.SetRange(ObjRepaymentSch."Repayment Date", VarLastMonth);
                            if ObjRepaymentSch.FindFirst then begin
                                VarScheduledLoanBal := ObjRepaymentSch."Loan Balance";
                            end;

                            VarDateFilter := '..' + Format(VarLastMonth);
                            ObjLoans.SetFilter(ObjLoans."Date filter", VarDateFilter);
                            ObjLoans.CalcFields(ObjLoans."Outstanding Balance");
                            VarLBal := ObjLoans."Outstanding Balance";
                            VarLBal := ObjLoans."Outstanding Balance";

                            //Amount in Arrears
                            VarArrears := VarScheduledLoanBal - VarLBal;
                            if (VarArrears > 0) or (VarArrears = 0) then begin
                                VarArrears := 0
                            end else
                                VarArrears := VarArrears;
                        end;
                    until ObjLoans.Next = 0;
                end;

            until ObjCust.Next = 0;
        end;
        VarTotalArrears := VarTotalArrears + VarArrears;

        //MESSAGE('Total Deposits is %1 Total Loan Risk is %2',VarTotalDeposits,VaTotalLoanRisk);
        VarNetWorth := VarTotalDeposits - VaTotalLoanRisk;
        exit(VarNetWorth);
    end;


    procedure FnGetLoanArrearsAmountII(VarLoanNo: Code[20]) ArrearsAmount: Decimal
    var
        ObjLoanRepaymentschedule: Record "Loan Repayment Schedule";
        ObjLoans: Record "Loans Register";
        VarPrinciplePaid: Decimal;
        VarAmountRemaining: Decimal;
        VarAmountAllocated: Decimal;
        VarDateFilter: Text;
        VarSchedulePrincipletoDate: Decimal;
        VarActualPrincipletoDate: Decimal;
        VarAmountinArrears: Decimal;
        VarNoofDaysinArrears: Integer;
        VarInterestPaid: Decimal;
        VarInsurancePaid: Decimal;
        VarAmountRemainingInterest: Decimal;
        VarAmountRemainingInsurance: Decimal;
        VarAmountAllocatedInterest: Decimal;
        VarAmountAllocatedInsurance: Decimal;
        VarScheduleInteresttoDate: Decimal;
        VarActualInteresttoDate: Decimal;
        VarScheduleInsurancetoDate: Decimal;
        VarActualInsurancetoDate: Decimal;
        VarAmountinArrearsInterest: Decimal;
        VarAmountinArrearsInsurance: Decimal;
        VarOutstandingPenalty: Decimal;
        VarLastInstalmentDueDate: Date;
        ObjLoanInterestAccrued: Record "Interest Due Ledger Entry";
        VarTotalInterestAccrued: Decimal;
        VarRoundedArrears: Decimal;
    begin
        VarAmountRemaining := 0;
        VarAmountAllocated := 0;
        //VarAmountRemainingInterest:=0;
        //VarAmountRemainingInsurance:=0;

        ObjLoans.Reset;
        ObjLoans.SetRange(ObjLoans."Loan  No.", VarLoanNo);
        if ObjLoans.FindSet then begin
            ObjLoans.CalcFields(ObjLoans."Principle Paid to Date", ObjLoans."Loan Insurance Paid", ObjLoans."Interest Paid", ObjLoans."Principle Paid Historical"
            , ObjLoans."Interest Paid Historical", ObjLoans."Insurance Paid Historical", ObjLoans."Penalty Paid Historical");

            VarPrinciplePaid := (ObjLoans."Principle Paid to Date" + ObjLoans."Principle Paid Historical") * -1;
            VarInterestPaid := (ObjLoans."Interest Paid" + ObjLoans."Interest Paid Historical");
            VarInsurancePaid := ((ObjLoans."Loan Insurance Paid" * -1) + ObjLoans."Insurance Paid Historical");
        end;

        VarAmountRemaining := VarPrinciplePaid;
        VarAmountRemainingInterest := VarInterestPaid;
        VarAmountRemainingInsurance := VarInsurancePaid;

        //=================================================Initialize amounts Paid on the Schedule
        ObjLoanRepaymentschedule.Reset;
        ObjLoanRepaymentschedule.SetRange(ObjLoanRepaymentschedule."Loan No.", VarLoanNo);
        if ObjLoanRepaymentschedule.FindSet then begin
            repeat
                ObjLoanRepaymentschedule."Principle Amount Paid" := 0;
                ObjLoanRepaymentschedule."Interest Paid" := 0;
                ObjLoanRepaymentschedule."Insurance Paid" := 0;
                ObjLoanRepaymentschedule."Instalment Fully Settled" := false;
                ObjLoanRepaymentschedule.Modify;
            until ObjLoanRepaymentschedule.Next = 0;
        end;
        //=================================================End Initialize amounts Paid on the Schedule


        //====================================================Loan Principle
        ObjLoanRepaymentschedule.Reset;
        ObjLoanRepaymentschedule.SetRange(ObjLoanRepaymentschedule."Loan No.", VarLoanNo);
        if ObjLoanRepaymentschedule.FindSet then begin
            repeat
                if VarAmountRemaining > 0 then begin
                    if VarAmountRemaining >= ObjLoanRepaymentschedule."Principal Repayment" then begin
                        VarAmountAllocated := ObjLoanRepaymentschedule."Principal Repayment";
                        ObjLoanRepaymentschedule."Instalment Fully Settled" := true;
                        ObjLoanRepaymentschedule.Modify;
                    end;

                    if VarAmountRemaining < ObjLoanRepaymentschedule."Principal Repayment" then begin
                        VarAmountAllocated := VarAmountRemaining;
                    end;

                    ObjLoanRepaymentschedule."Principal Repayment" := ROUND(ObjLoanRepaymentschedule."Principal Repayment", 0.01, '=');
                    ObjLoanRepaymentschedule."Principle Amount Paid" := ROUND(VarAmountAllocated, 0.01, '=');
                    ObjLoanRepaymentschedule.Modify;
                    VarAmountRemaining := VarAmountRemaining - VarAmountAllocated;
                end;
            until ObjLoanRepaymentschedule.Next = 0;
        end;

        //====================================================Loan Interest
        ObjLoanRepaymentschedule.Reset;
        ObjLoanRepaymentschedule.SetRange(ObjLoanRepaymentschedule."Loan No.", VarLoanNo);
        if ObjLoanRepaymentschedule.FindSet then begin
            repeat
                if VarAmountRemainingInterest > 0 then begin

                    if VarAmountRemainingInterest >= ObjLoanRepaymentschedule."Monthly Interest" then begin
                        VarAmountAllocatedInterest := ObjLoanRepaymentschedule."Monthly Interest"
                    end;

                    if VarAmountRemainingInterest < ObjLoanRepaymentschedule."Monthly Interest" then begin
                        VarAmountAllocatedInterest := VarAmountRemainingInterest;
                    end;

                    ObjLoanRepaymentschedule."Interest Paid" := VarAmountAllocatedInterest;
                    ObjLoanRepaymentschedule.Modify;
                    VarAmountRemainingInterest := VarAmountRemainingInterest - VarAmountAllocatedInterest;
                end;
            until ObjLoanRepaymentschedule.Next = 0;
        end;




        //====================================================Loan Insurance
        ObjLoanRepaymentschedule.Reset;
        ObjLoanRepaymentschedule.SetRange(ObjLoanRepaymentschedule."Loan No.", VarLoanNo);
        if ObjLoanRepaymentschedule.FindSet then begin
            repeat
                if VarAmountRemainingInsurance > 0 then begin
                    if VarAmountRemainingInsurance >= ObjLoanRepaymentschedule."Monthly Insurance" then begin
                        VarAmountAllocatedInsurance := ObjLoanRepaymentschedule."Monthly Insurance"
                    end;

                    if VarAmountRemainingInsurance < ObjLoanRepaymentschedule."Monthly Insurance" then begin
                        VarAmountAllocatedInsurance := VarAmountRemainingInsurance;
                    end;

                    ObjLoanRepaymentschedule."Insurance Paid" := VarAmountAllocatedInsurance;
                    ObjLoanRepaymentschedule.Modify;
                    VarAmountRemainingInsurance := VarAmountRemainingInsurance - VarAmountAllocatedInsurance;
                end;
            until ObjLoanRepaymentschedule.Next = 0;
        end;

        VarDateFilter := '..' + Format(WorkDate);

        //===================================================Scheduled Repayment to Date
        ObjLoanRepaymentschedule.Reset;
        ObjLoanRepaymentschedule.SetRange(ObjLoanRepaymentschedule."Loan No.", VarLoanNo);
        ObjLoanRepaymentschedule.SetFilter(ObjLoanRepaymentschedule."Repayment Date", '<%1', WorkDate);
        if ObjLoanRepaymentschedule.FindSet then begin
            repeat
                VarSchedulePrincipletoDate := VarSchedulePrincipletoDate + ObjLoanRepaymentschedule."Principal Repayment";
                VarScheduleInteresttoDate := VarScheduleInteresttoDate + ObjLoanRepaymentschedule."Monthly Interest";
                VarScheduleInsurancetoDate := VarScheduleInsurancetoDate + ObjLoanRepaymentschedule."Monthly Insurance";
            until ObjLoanRepaymentschedule.Next = 0;
        end;

        //===================================================Actual Repayment to Date
        ObjLoanRepaymentschedule.Reset;
        ObjLoanRepaymentschedule.SetRange(ObjLoanRepaymentschedule."Loan No.", VarLoanNo);
        ObjLoanRepaymentschedule.SetFilter(ObjLoanRepaymentschedule."Principle Amount Paid", '<>%1', 0);
        if ObjLoanRepaymentschedule.FindSet then begin
            if ObjLoanRepaymentschedule."Repayment Date" < WorkDate then begin
                repeat
                    VarActualPrincipletoDate := VarActualPrincipletoDate + ObjLoanRepaymentschedule."Principle Amount Paid";
                    VarActualInteresttoDate := VarActualInteresttoDate + ObjLoanRepaymentschedule."Interest Paid";
                    VarActualInsurancetoDate := VarActualInsurancetoDate + ObjLoanRepaymentschedule."Insurance Paid";
                until ObjLoanRepaymentschedule.Next = 0;
            end;
        end;


        //====================================================Get Loan Interest In Arrears
        ObjLoanRepaymentschedule.Reset;
        ObjLoanRepaymentschedule.SetCurrentkey(ObjLoanRepaymentschedule."Repayment Date");
        ObjLoanRepaymentschedule.SetRange(ObjLoanRepaymentschedule."Loan No.", VarLoanNo);
        ObjLoanRepaymentschedule.SetFilter(ObjLoanRepaymentschedule."Repayment Date", '<%1', WorkDate);
        if ObjLoanRepaymentschedule.FindLast then begin
            VarLastInstalmentDueDate := ObjLoanRepaymentschedule."Repayment Date";
        end;

        if VarLastInstalmentDueDate < 20180110D then
            VarLastInstalmentDueDate := 20180110D;

        ObjLoanInterestAccrued.Reset;
        ObjLoanInterestAccrued.SetRange(ObjLoanInterestAccrued."Loan No", VarLoanNo);
        ObjLoanInterestAccrued.SetFilter(ObjLoanInterestAccrued."Posting Date", '<=%1', VarLastInstalmentDueDate);
        if ObjLoanInterestAccrued.FindSet then begin
            repeat
                VarTotalInterestAccrued := VarTotalInterestAccrued + ObjLoanInterestAccrued.Amount;
            until ObjLoanInterestAccrued.Next = 0;
        end;

        VarAmountinArrearsInterest := VarTotalInterestAccrued - VarInterestPaid;
        if VarAmountinArrearsInterest < 0 then
            VarAmountinArrearsInterest := 0;
        //====================================================Get Loan Interest In Arrears

        VarAmountinArrears := 0;

        //=================================Loan Principle


        if ObjLoans.Get(VarLoanNo) then begin
            ObjLoans.CalcFields(ObjLoans."Penalty Charged", ObjLoans."Penalty Paid", ObjLoans."Outstanding Balance");
            if ObjLoans."Outstanding Balance" > 0 then begin
                VarAmountinArrears := VarSchedulePrincipletoDate - VarActualPrincipletoDate;
                VarAmountinArrearsInsurance := VarScheduleInsurancetoDate - VarInsurancePaid;//VarActualInsurancetoDate;
                if VarAmountinArrears < 0 then begin
                    VarAmountinArrears := 0
                end;
            end;
        end;
        //=================================Loan Interest
        if VarAmountinArrearsInterest < 0 then begin
            VarAmountinArrearsInterest := 0
        end else
            VarAmountinArrearsInterest := VarAmountinArrearsInterest;

        //=================================Loan Insurance
        if VarAmountinArrearsInsurance < 0 then begin
            VarAmountinArrearsInsurance := 0
        end else
            VarAmountinArrearsInsurance := VarAmountinArrearsInsurance;

        //=================================Loan Principle
        ObjLoanRepaymentschedule.Reset;
        ObjLoanRepaymentschedule.SetCurrentkey(ObjLoanRepaymentschedule."Repayment Date");
        ObjLoanRepaymentschedule.SetRange(ObjLoanRepaymentschedule."Loan No.", VarLoanNo);
        ObjLoanRepaymentschedule.SetRange(ObjLoanRepaymentschedule."Instalment Fully Settled", false);
        if ObjLoanRepaymentschedule.FindFirst then begin
            VarNoofDaysinArrears := WorkDate - ObjLoanRepaymentschedule."Repayment Date";
        end;



        if VarNoofDaysinArrears < 0 then begin
            VarNoofDaysinArrears := 0
        end else
            VarNoofDaysinArrears := VarNoofDaysinArrears;



        if ObjLoans.Get(VarLoanNo) then begin
            ObjLoans.CalcFields(ObjLoans."Penalty Charged", ObjLoans."Penalty Paid", ObjLoans."Penalty Paid Historical");

            VarOutstandingPenalty := ObjLoans."Penalty Charged" - (ObjLoans."Penalty Paid" + ObjLoans."Penalty Paid Historical");
            if VarOutstandingPenalty < 0 then
                VarOutstandingPenalty := 0;


            VarRoundedArrears := VarAmountinArrears + VarAmountinArrearsInterest + VarAmountinArrearsInsurance + VarOutstandingPenalty;

            if ObjLoans.Closed = true then begin
                VarNoofDaysinArrears := 0;
                VarRoundedArrears := 0;
            end;

            if VarRoundedArrears < 1 then
                VarRoundedArrears := 0;
            if VarRoundedArrears = 0 then
                VarNoofDaysinArrears := 0;

            ObjLoans."Amount in Arrears" := VarRoundedArrears;
            ObjLoans."Days In Arrears" := VarNoofDaysinArrears;

            //==============================================================================Update Loan Category
            if (VarNoofDaysinArrears = 0) then begin
                ObjLoans."Loans Category" := ObjLoans."loans category"::Perfoming;
                ObjLoans."Loans Category-SASRA" := ObjLoans."loans category-sasra"::Perfoming;
            end else
                if (VarNoofDaysinArrears > 0) and (VarNoofDaysinArrears <= 30) then begin
                    ObjLoans."Loans Category" := ObjLoans."loans category"::Watch;
                    ObjLoans."Loans Category-SASRA" := ObjLoans."loans category-sasra"::Watch;
                end else
                    if (VarNoofDaysinArrears >= 31) and (VarNoofDaysinArrears <= 180) then begin
                        ObjLoans."Loans Category" := ObjLoans."loans category"::Substandard;
                        ObjLoans."Loans Category-SASRA" := ObjLoans."loans category-sasra"::Substandard;
                    end else
                        if (VarNoofDaysinArrears >= 181) and (VarNoofDaysinArrears <= 360) then begin
                            ObjLoans."Loans Category" := ObjLoans."loans category"::Doubtful;
                            ObjLoans."Loans Category-SASRA" := ObjLoans."loans category-sasra"::Doubtful
                        end else
                            if (VarNoofDaysinArrears > 360) then begin
                                ObjLoans."Loans Category" := ObjLoans."loans category"::Loss;
                                ObjLoans."Loans Category-SASRA" := ObjLoans."loans category-sasra"::Loss;
                            end;
            //==============================================================================End Update Loan Category

            ObjLoans.Modify;
        end;
        exit(VarRoundedArrears);

    end;


    procedure FnCreateLoanRecoveryJournals(VarLoanNoRecovered: Code[30]; BATCH_TEMPLATE: Code[20]; BATCH_NAME: Code[20]; DOCUMENT_NO: Code[20]; VarMemberNo: Code[20]; VarPostingDate: Date; EXTERNAL_DOC_NO: Code[30]; VarLoanSettlementAcc: Code[30]; VarMemberName: Text[100]; RunningBalance: Decimal)
    var
        ObjLoans: Record "Loans Register";
        AmountToDeduct: Decimal;
        LineNo: Integer;
        SFactory: Codeunit "SURESTEP Factory";
        VarAmounttoDeduct: Decimal;
        VarOutstandingInterest: Decimal;
        VarEndYear: Date;
        VarInsuranceMonths: Integer;
        ObjProductCharge: Record "Loan Product Charges";
        VarInsurancePayoff: Decimal;
        VarOutstandingInsurance: Decimal;
        VarLoanInsuranceBalAccount: Code[30];
        ObjLoanType: Record "Loan Products Setup";
        ObjLoanSchedule: Record "Loan Repayment Schedule";
        VarLoanInsuranceCharged: Decimal;
        VarLoanInsurancePaid: Decimal;
        VarTotalOutstandingInsurance: Decimal;
        VarLoanInterestDueBalAccount: Code[30];
        VarOutstandingPenalty: Decimal;
        VarLoanPenaltyBalAccount: Code[30];
        VarLoanDueAmount: Decimal;
        VarDebtCollectorBaseAmount: Decimal;
        VarDebtCollectorFee: Decimal;
        ObjLoanRepaymentschedule: Record "Loan Repayment Schedule";
        VarLastInstalmentDueDate: Date;
        ObjLoanInterestAccrued: Record "Interest Due Ledger Entry";
        VarTotalInterestAccrued: Decimal;
        VarAmountinArrearsInterest: Decimal;
    begin
        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
        GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
        GenJournalLine.DeleteAll;

        //DOCUMENT_NO:=FnRunGetNextTransactionDocumentNo;

        //============================================================Debt Collector Fee
        if RunningBalance > 0 then begin
            if ObjLoans.Get(VarLoanNoRecovered) then begin
                ObjVendor.Reset;
                ObjVendor.SetRange(ObjVendor."No.", ObjLoans."Loan Debt Collector");
                if ObjVendor.FindSet then begin
                    VarDebtCollectorFee := SFactory.FnRunGetLoanDebtCollectorFee(VarLoanNoRecovered, RunningBalance);

                    if RunningBalance > VarDebtCollectorFee then begin
                        AmountToDeduct := VarDebtCollectorFee
                    end else
                        AmountToDeduct := RunningBalance;

                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLineGuarantorRecovery(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::Vendor, ObjLoans."Loan Debt Collector", VarPostingDate, AmountToDeduct * -1, 'BOSA', EXTERNAL_DOC_NO,
                    'Debt Collection Charge + VAT from ' + VarLoanNoRecovered + ' ' + ObjLoans."Client Name", VarLoanNoRecovered, GenJournalLine."recovery transaction type"::"Guarantor Recoverd", VarLoanNoRecovered);

                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLineGuarantorRecovery(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::Vendor, VarLoanSettlementAcc, VarPostingDate, AmountToDeduct, 'BOSA', EXTERNAL_DOC_NO,
                    'Debt Collection Charge + VAT from ' + VarLoanNoRecovered + ' ' + ObjLoans."Client Name", VarLoanNoRecovered, GenJournalLine."recovery transaction type"::"Guarantor Recoverd", VarLoanNoRecovered);
                    RunningBalance := RunningBalance - AmountToDeduct;
                end;
            end;
        end;

        //============================================================Loan Penalty Repayment
        if RunningBalance > 0 then begin
            ObjLoans.Reset;
            ObjLoans.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
            ObjLoans.SetRange(ObjLoans."Loan  No.", VarLoanNoRecovered);
            if ObjLoans.Find('-') then begin
                ObjLoans.CalcFields(ObjLoans."Outstanding Balance", ObjLoans."Penalty Charged", ObjLoans."Penalty Paid", ObjLoans."Penalty Paid Historical");
                if RunningBalance > 0 then begin
                    AmountToDeduct := 0;

                    VarOutstandingPenalty := ObjLoans."Penalty Charged" - (ObjLoans."Penalty Paid" + ObjLoans."Penalty Paid Historical");
                    if VarOutstandingPenalty < 0 then
                        VarOutstandingPenalty := 0;

                    if VarOutstandingPenalty > 0 then begin
                        if VarOutstandingPenalty < RunningBalance then begin
                            AmountToDeduct := VarOutstandingPenalty
                        end else
                            AmountToDeduct := RunningBalance;
                        AmountToDeduct := ROUND(AmountToDeduct, 0.01, '=');

                        if ObjLoanType.Get(ObjLoans."Loan Product Type") then begin
                            VarLoanPenaltyBalAccount := ObjLoanType."Penalty Paid Account";
                        end;



                        //------------------------------------Debit Loan Penalty Charged---------------------------------------------------------------------------------------------
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLineBalanced(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Penalty Charged",
                        GenJournalLine."account type"::Member, ObjLoans."Client Code", VarPostingDate, 'Loan Penalty Charged - ' + VarLoanNoRecovered, GenJournalLine."bal. account type"::"G/L Account",
                        VarLoanPenaltyBalAccount, AmountToDeduct, 'BOSA', VarLoanNoRecovered);
                        //--------------------------------Debit Loan Penalty Charged-------------------------------------------------------------------------------

                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLineGuarantorRecovery(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Penalty Paid",
                        GenJournalLine."account type"::Member, VarMemberNo, VarPostingDate, AmountToDeduct * -1, 'BOSA', EXTERNAL_DOC_NO,
                        'Loan Penalty Paid - ' + VarLoanNoRecovered, VarLoanNoRecovered, GenJournalLine."recovery transaction type"::"Guarantor Recoverd", VarLoanNoRecovered);

                        RunningBalance := RunningBalance - AmountToDeduct;
                        VarAmounttoDeduct := VarAmounttoDeduct + AmountToDeduct;
                    end;
                end;
            end;
        end;

        //============================================================Loan Interest Repayment
        if RunningBalance > 0 then begin
            ObjLoans.Reset;
            ObjLoans.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
            ObjLoans.SetRange(ObjLoans."Loan  No.", VarLoanNoRecovered);
            if ObjLoans.Find('-') then begin

                //====================================================Get Loan Interest In Arrears
                ObjLoanRepaymentschedule.Reset;
                ObjLoanRepaymentschedule.SetCurrentkey(ObjLoanRepaymentschedule."Repayment Date");
                ObjLoanRepaymentschedule.SetRange(ObjLoanRepaymentschedule."Loan No.", VarLoanNoRecovered);
                ObjLoanRepaymentschedule.SetFilter(ObjLoanRepaymentschedule."Repayment Date", '<=%1', WorkDate);
                if ObjLoanRepaymentschedule.FindLast then begin
                    VarLastInstalmentDueDate := ObjLoanRepaymentschedule."Repayment Date";
                end;

                if VarLastInstalmentDueDate < 20180110D then
                    VarLastInstalmentDueDate := 20180110D;

                ObjLoanInterestAccrued.Reset;
                ObjLoanInterestAccrued.SetRange(ObjLoanInterestAccrued."Loan No", VarLoanNoRecovered);
                ObjLoanInterestAccrued.SetFilter(ObjLoanInterestAccrued."Posting Date", '<=%1', VarLastInstalmentDueDate);
                if ObjLoanInterestAccrued.FindSet then begin
                    repeat
                        VarTotalInterestAccrued := VarTotalInterestAccrued + ObjLoanInterestAccrued.Amount;
                    until ObjLoanInterestAccrued.Next = 0;

                end;

                ObjLoans.CalcFields(ObjLoans."Outstanding Balance", ObjLoans."Interest Due", ObjLoans."Interest Paid", ObjLoans."Penalty Charged",
                ObjLoans."Penalty Paid", ObjLoans."Interest Paid Historical");
                VarAmountinArrearsInterest := VarTotalInterestAccrued - (ObjLoans."Interest Paid" + ObjLoans."Interest Paid Historical");
                if VarAmountinArrearsInterest < 0 then
                    VarAmountinArrearsInterest := 0;
                //====================================================Get Loan Interest In Arrears


                if RunningBalance > 0 then begin
                    VarOutstandingInterest := VarAmountinArrearsInterest;
                    if VarOutstandingInterest < 0 then
                        VarOutstandingInterest := 0;

                    AmountToDeduct := 0;
                    if VarOutstandingInterest > 0 then begin
                        if VarOutstandingInterest < RunningBalance then begin
                            AmountToDeduct := VarOutstandingInterest
                        end else
                            AmountToDeduct := RunningBalance;
                        AmountToDeduct := ROUND(AmountToDeduct, 0.01, '=');


                        if ObjLoanType.Get(ObjLoans."Loan Product Type") then begin
                            VarLoanInterestDueBalAccount := ObjLoanType."Loan Interest Account";
                        end;

                        //------------------------------------Debit Loan Interest Due---------------------------------------------------------------------------------------------
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLineBalanced(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Interest Due",
                        GenJournalLine."account type"::Member, VarMemberNo, VarPostingDate, 'Loan Interest Charged - ' + VarLoanNoRecovered, GenJournalLine."bal. account type"::"G/L Account",
                        VarLoanInterestDueBalAccount, AmountToDeduct, 'BOSA', VarLoanNoRecovered);

                        //--------------------------------Debit Loan Interest Due-------------------------------------------------------------------------------
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLineGuarantorRecovery(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Interest Paid",
                        GenJournalLine."account type"::Member, VarMemberNo, VarPostingDate, AmountToDeduct * -1, 'BOSA', EXTERNAL_DOC_NO,
                        'Loan Interest Paid - ' + VarLoanNoRecovered, VarLoanNoRecovered, GenJournalLine."recovery transaction type"::"Guarantor Recoverd", VarLoanNoRecovered);

                        RunningBalance := RunningBalance - AmountToDeduct;
                        VarAmounttoDeduct := VarAmounttoDeduct + AmountToDeduct;
                    end;
                end;
            end;
        end;


        //============================================================Loan Insurance Repayment

        if RunningBalance > 0 then begin

            ObjLoans.Reset;
            ObjLoans.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
            ObjLoans.SetRange(ObjLoans."Loan  No.", VarLoanNoRecovered);
            if ObjLoans.Find('-') then begin

                ObjLoans.Reset;
                ObjLoans.SetRange(ObjLoans."Loan  No.", VarLoanNoRecovered);
                if ObjLoans.FindSet then begin
                    ObjLoans.CalcFields(ObjLoans."Outstanding Balance", ObjLoans."Penalty Charged", ObjLoans."Penalty Paid", ObjLoans."Interest Due",
                    ObjLoans."Interest Paid", ObjLoans."Insurance Paid Historical");

                    if (ObjLoans."Outstanding Balance" <> 0) and (ObjLoans."Loan Status" = ObjLoans."loan status"::Disbursed) then begin
                        VarEndYear := CalcDate('CY', Today);

                        ObjLoanSchedule.Reset;
                        ObjLoanSchedule.SetRange(ObjLoanSchedule."Loan No.", VarLoanNoRecovered);
                        ObjLoanSchedule.SetFilter(ObjLoanSchedule."Repayment Date", '>%1&<=%2', WorkDate, VarEndYear);
                        if ObjLoanSchedule.FindSet then begin
                            ObjLoanSchedule.CalcSums(ObjLoanSchedule."Monthly Insurance");
                            VarInsurancePayoff := ObjLoanSchedule."Monthly Insurance";
                        end;

                    end;
                end;

                FnGetLoanArrearsAmountII(VarLoanNoRecovered);//===========================Get Amount In Arrears

                ObjLoanSchedule.Reset;
                ObjLoanSchedule.SetRange(ObjLoanSchedule."Loan No.", VarLoanNoRecovered);
                ObjLoanSchedule.SetFilter(ObjLoanSchedule."Repayment Date", '<=%1', WorkDate);
                if ObjLoanSchedule.FindSet then begin
                    repeat
                        VarLoanInsuranceCharged := VarLoanInsuranceCharged + ObjLoanSchedule."Monthly Insurance";
                        VarLoanInsurancePaid := VarLoanInsurancePaid + ObjLoanSchedule."Insurance Paid";
                    until ObjLoanSchedule.Next = 0;
                end;

                VarOutstandingInsurance := VarLoanInsuranceCharged - VarLoanInsurancePaid;
                if ObjLoans."Loan Status" <> ObjLoans."loan status"::Disbursed then
                    VarOutstandingInsurance := 0;

                if RunningBalance > 0 then begin
                    AmountToDeduct := 0;

                    VarTotalOutstandingInsurance := VarOutstandingInsurance;//+VarInsurancePayoff;

                    if VarTotalOutstandingInsurance > 0 then begin
                        if VarTotalOutstandingInsurance < RunningBalance then begin
                            AmountToDeduct := VarTotalOutstandingInsurance
                        end else
                            AmountToDeduct := RunningBalance;
                        AmountToDeduct := ROUND(AmountToDeduct, 0.01, '=');

                        if ObjLoanType.Get(ObjLoans."Loan Product Type") then begin
                            VarLoanInsuranceBalAccount := ObjLoanType."Loan Insurance Accounts";
                        end;

                        //------------------------------------Debit Loan Insurance Due---------------------------------------------------------------------------------------------
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLineBalanced(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Insurance Charged",
                        GenJournalLine."account type"::Member, ObjLoans."Client Code", VarPostingDate, 'Loan Insurance Charged - ' + VarLoanNoRecovered, GenJournalLine."bal. account type"::"G/L Account",
                        VarLoanInsuranceBalAccount, AmountToDeduct, 'BOSA', VarLoanNoRecovered);
                        //--------------------------------Debit Loan Insurance Due-------------------------------------------------------------------------------

                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLineGuarantorRecovery(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Insurance Paid",
                        GenJournalLine."account type"::Member, VarMemberNo, VarPostingDate, AmountToDeduct * -1, 'BOSA', EXTERNAL_DOC_NO,
                        'Loan Insurance Paid - ' + VarLoanNoRecovered, VarLoanNoRecovered, GenJournalLine."recovery transaction type"::"Guarantor Recoverd", VarLoanNoRecovered);

                        RunningBalance := RunningBalance - AmountToDeduct;
                        VarAmounttoDeduct := VarAmounttoDeduct + AmountToDeduct;
                    end;
                end;
            end;
        end;



        //============================================================Loan Principle Repayment
        if RunningBalance > 0 then begin
            ObjLoans.Reset;
            ObjLoans.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
            ObjLoans.SetRange(ObjLoans."Loan  No.", VarLoanNoRecovered);
            if ObjLoans.Find('-') then begin
                ObjLoans.CalcFields(ObjLoans."Outstanding Balance", ObjLoans."Penalty Charged", ObjLoans."Penalty Paid");
                if RunningBalance > 0 then begin
                    AmountToDeduct := 0;
                    if ObjLoans."Outstanding Balance" > 0 then begin
                        if ObjLoans."Outstanding Balance" < RunningBalance then begin
                            AmountToDeduct := ObjLoans."Outstanding Balance"
                        end else
                            AmountToDeduct := RunningBalance;
                        AmountToDeduct := ROUND(AmountToDeduct, 0.01, '=');

                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLineGuarantorRecovery(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Repayment",
                        GenJournalLine."account type"::Member, VarMemberNo, VarPostingDate, AmountToDeduct * -1, 'BOSA', EXTERNAL_DOC_NO,
                        'Loan Principal Repayment - ' + VarLoanNoRecovered, VarLoanNoRecovered, GenJournalLine."recovery transaction type"::"Guarantor Recoverd", VarLoanNoRecovered);
                        RunningBalance := RunningBalance - AmountToDeduct;
                        VarAmounttoDeduct := VarAmounttoDeduct + AmountToDeduct;
                        VarAmounttoDeduct := ROUND(VarAmounttoDeduct, 0.01, '=');
                    end;
                end;
            end;
        end;


        if ObjLoans.Get(VarLoanNoRecovered) then begin
            //==============================================================================================Recover From Loan Settlement Account
            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
            GenJournalLine."account type"::Vendor, VarLoanSettlementAcc, VarPostingDate, VarAmounttoDeduct, 'BOSA', EXTERNAL_DOC_NO,
            'Loan Repayment - ' + VarLoanNoRecovered + ' ' + ObjLoans."Loan Product Type Name", '', GenJournalLine."application source"::" ");
            //==============================================================================================End Recover From Loan Settlement Account
        end;
    end;


    procedure FnCreateGuarantorRecoveryReimbursment(VarFOSAAccountNo: Code[20])
    var
        ObjGuarantorLedger: Record "Guarantor Recovery Ledger";
        VarAmounttoDeduct: Decimal;
        LineNo: Integer;
        BATCH_TEMPLATE: Code[30];
        BATCH_NAME: Code[30];
        DOCUMENT_NO: Code[30];
        EXTERNAL_DOC_NO: Code[40];
        SFactory: Codeunit "SURESTEP Factory";
        VarRecoveryDifference: Decimal;
        VarAmountApportioned: Decimal;
        VarDepositNo: Code[30];
        ObjVendors: Record Vendor;
        ObjAccTypes: Record "Account Types-Saving Products";
        VarBalanceinFOSA: Decimal;
        VarDebtCollectorFee: Decimal;
        VarSumAmountAllocated: Decimal;
        VarSumAmountPaidBack: Decimal;
        VarTotalDifference: Decimal;
        VarTotalAmounttoDeductFromDefaulter: Decimal;
        ObjAccount: Record Vendor;
    begin
        BATCH_TEMPLATE := 'GENERAL';
        BATCH_NAME := 'RECOVERIES';
        DOCUMENT_NO := FnRunGetNextTransactionDocumentNo;
        EXTERNAL_DOC_NO := '';

        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
        GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
        GenJournalLine.DeleteAll;

        ObjVendors.Reset;
        ObjVendors.SetRange(ObjVendors."No.", VarFOSAAccountNo);
        if ObjVendors.Find('-') then begin
            ObjVendors.CalcFields(ObjVendors.Balance, ObjVendors."Uncleared Cheques");
            VarBalanceinFOSA := (ObjVendors.Balance - ObjVendors."Uncleared Cheques");

            ObjAccTypes.Reset;
            ObjAccTypes.SetRange(ObjAccTypes.Code, ObjVendors."Account Type");
            if ObjAccTypes.Find('-') then
                VarBalanceinFOSA := VarBalanceinFOSA - ObjAccTypes."Minimum Balance";

            //==================================================================================================Recover Debt Collector Fee
            ObjGuarantorLedger.Reset;
            ObjGuarantorLedger.SetRange(ObjGuarantorLedger."Defaulter Member No", ObjVendors."BOSA Account No");
            ObjGuarantorLedger.SetFilter(ObjGuarantorLedger."Debt Collector", '<>%1', '');
            if ObjGuarantorLedger.FindSet then begin
                ObjGuarantorLedger.CalcSums(ObjGuarantorLedger."Amount Allocated", ObjGuarantorLedger."Amount Paid Back");
                VarSumAmountAllocated := ObjGuarantorLedger."Amount Allocated";
                VarSumAmountPaidBack := ObjGuarantorLedger."Amount Paid Back";
                VarTotalDifference := VarSumAmountAllocated - VarSumAmountPaidBack;

                if ObjAccount.Get(ObjGuarantorLedger."Debt Collector") then begin
                    if VarTotalDifference > VarBalanceinFOSA then begin
                        VarDebtCollectorFee := ROUND(VarBalanceinFOSA * (ObjAccount."Debt Collector %" / 100), 0.01, '=');
                    end else
                        VarDebtCollectorFee := ROUND(VarTotalDifference * (ObjAccount."Debt Collector %" / 100), 0.01, '=');
                    VarDebtCollectorFee := VarDebtCollectorFee + (VarDebtCollectorFee * 0.16);

                    //======================================================================================================Recover From FOSA Account
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLineGuarantorRecovery(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::Vendor, VarFOSAAccountNo, WorkDate, VarDebtCollectorFee, 'BOSA', EXTERNAL_DOC_NO,
                    'Debt Collector Fee on Guarantor Reimbersment', '', GenJournalLine."recovery transaction type"::"Guarantor Paid", '');

                    //======================================================================================================Recovery to Debt Collector
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLineGuarantorRecovery(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Deposit Contribution",
                    GenJournalLine."account type"::Vendor, VarDepositNo, WorkDate, VarDebtCollectorFee * -1, 'BOSA', EXTERNAL_DOC_NO,
                    'Debt Collection Fee + VAT from ' + ObjGuarantorLedger."Defaulter Name", '', GenJournalLine."recovery transaction type"::"Guarantor Paid", '');

                    VarBalanceinFOSA := VarBalanceinFOSA - VarDebtCollectorFee;
                end;
            end;





            VarAmounttoDeduct := 0;
            VarDebtCollectorFee := 0;

            ObjGuarantorLedger.Reset;
            ObjGuarantorLedger.SetRange(ObjGuarantorLedger."Defaulter Member No", ObjVendors."BOSA Account No");
            ObjGuarantorLedger.SetRange(ObjGuarantorLedger."Fully Settled", false);
            if ObjGuarantorLedger.FindSet then begin
                repeat
                    ObjGuarantorLedger.CalcFields(ObjGuarantorLedger."Total Amount Apportioned");
                    if ObjGuarantorLedger."Total Amount Apportioned" <> 0 then
                        VarAmountApportioned := ObjGuarantorLedger."Amount Allocated" / ObjGuarantorLedger."Total Amount Apportioned" * VarBalanceinFOSA
                    else
                        VarAmountApportioned := 0;

                    VarRecoveryDifference := ObjGuarantorLedger."Amount Allocated" - ObjGuarantorLedger."Amount Paid Back";
                    if ObjMembers.Get(ObjGuarantorLedger."Guarantor No") then begin
                        VarDepositNo := ObjMembers."Deposits Account No";
                    end;

                    if VarAmountApportioned > VarRecoveryDifference then begin
                        VarAmountApportioned := VarRecoveryDifference
                    end;

                    if VarBalanceinFOSA > 0 then begin
                        if VarAmountApportioned > VarBalanceinFOSA then begin
                            VarAmounttoDeduct := VarBalanceinFOSA
                        end else
                            VarAmounttoDeduct := VarAmountApportioned;

                        VarAmounttoDeduct := ROUND(VarAmounttoDeduct, 0.01, '=');

                        //======================================================================================================Recovery to Deposit Account
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLineGuarantorRecovery(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Deposit Contribution",
                        GenJournalLine."account type"::Vendor, VarDepositNo, WorkDate, VarAmounttoDeduct * -1, 'BOSA', EXTERNAL_DOC_NO,
                        'Loan Recovery Reimbursment: ' + ObjGuarantorLedger."Defaulter Name", '', GenJournalLine."recovery transaction type"::"Guarantor Paid", '');

                        ObjGuarantorLedger."Amount Paid Back" := ObjGuarantorLedger."Amount Paid Back" + VarAmounttoDeduct;
                        if ObjGuarantorLedger."Amount Allocated" = ObjGuarantorLedger."Amount Paid Back" then begin
                            ObjGuarantorLedger."Fully Settled" := true;
                            ObjGuarantorLedger.Modify;
                        end;
                        ObjGuarantorLedger.Modify;
                        VarTotalAmounttoDeductFromDefaulter := VarTotalAmounttoDeductFromDefaulter + VarAmounttoDeduct;
                    end;
                until ObjGuarantorLedger.Next = 0;
            end;



            //======================================================================================================Debit Total Guarantor Recovery Amount
            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLineGuarantorRecovery(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
            GenJournalLine."account type"::Vendor, VarFOSAAccountNo, WorkDate, VarTotalAmounttoDeductFromDefaulter, 'BOSA', EXTERNAL_DOC_NO,
            'Loan Guarantors Reimbursment', '', GenJournalLine."recovery transaction type"::"Guarantor Paid", '');
        end;

        //Post New
        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
        GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
        if GenJournalLine.Find('-') then begin
            Codeunit.Run(Codeunit::"Gen. Jnl.-Post Batch", GenJournalLine);
        end;
    end;

    local procedure FnRecoverLoansFromFOSAAccounts()
    var
        ObjLoanScheduleII: Record "Loan Repayment Schedule";
        ObjAccounts: Record Vendor;
    begin
        ObjLSchedule.Reset;
        ObjLSchedule.SetRange(ObjLSchedule."Loan No.", ObjLoanScheduleII."Loan No.");
        ObjLSchedule.SetFilter(ObjLSchedule."Repayment Date", '=%1', WorkDate);
        if ObjLSchedule.FindSet then begin
            if ObjLoans.Get(ObjLSchedule."Loan No.") then begin

                ObjAccounts.Reset;
                ObjAccounts.SetRange(ObjAccounts."BOSA Account No", ObjLoans."Client Code");
                ObjAccounts.SetRange(ObjAccounts."Account Type", '507');
                if ObjAccounts.FindSet then begin

                end;
            end;
        end;
    end;


    procedure FnSendStatementViaMail("Recepient Name": Text; Subject: Text; Body: Text; "Recepient Email": Text; "Report Name": Text; AddCC: Text) Result: Boolean
    var
        Recipients: List of [text];
        CCList: List of [Text];
    begin
        if IsEmailAddressesValid("Recepient Email") = true then begin
            SMTPSetup.Reset;
            SMTPSetup.Get;
            Recipients.Add("Recepient Email");
            CCList.Add(AddCC);
            SMTP.CreateMessage('Vision Sacco', SMTPSetup."Email Sender Address", Recipients, Subject, '', true);
            SMTP.AppendBody('<html> <body> <font face="Maiandra GD,Garamond,Tahoma", size = "3">');
            SMTP.AppendBody('Dear ' + "Recepient Name" + ',');
            SMTP.AppendBody('<br><br>');
            SMTP.AppendBody(Body);
            SMTP.AppendBody('<br><br>');
            SMTP.AppendBody('<HR>');
            SMTP.AppendBody('Kind Regards');
            SMTP.AppendBody('<br>');
            SMTP.AppendBody('<img src="https://visionsacco.com/templates/assets/images/vlogo.png" alt="VSacco Logo">');
            SMTP.AppendBody('<br>');
            SMTP.AppendBody('VISION SACCO SOCIETY LIMITED');
            SMTP.AppendBody('<br>');
            SMTP.AppendBody('P.O. Box 1240 - 00502 Nairobi, Kenya');
            SMTP.AppendBody('<br>');
            SMTP.AppendBody('Tel: 0711086156');
            SMTP.AppendBody('<br>');
            SMTP.AppendBody('info@visionsacco.com');
            SMTP.AppendBody('<br>');
            SMTP.AppendBody('www.visionsacco.com');
            SMTP.AppendBody('<br>');
            SMTP.AppendBody('Empowering People, Transforming Lives');
            SMTP.AppendBody('<br>');
            if IsEmailAddressesValid(AddCC) = true then begin
                SMTP.AddCC(CCList);
            end;
            SMTP.AppendBody('</body></font></html>');
            if Exists(SMTPSetup."Path to Save Report" + "Report Name") then
                SMTP.AddAttachment(SMTPSetup."Path to Save Report" + "Report Name", '');
            SMTP.Send;
            ObjEmailLogs.Reset;
            ObjEmailLogs.SetCurrentkey(ObjEmailLogs.No);
            if ObjEmailLogs.FindLast then begin
                iEntryNo := ObjEmailLogs.No;
                iEntryNo := iEntryNo + 1;
            end
            else begin
                iEntryNo := 1;
            end;

            ObjEmailLogs.Reset;
            ObjEmailLogs.Init;
            ObjEmailLogs.No := iEntryNo;
            ObjEmailLogs.Subject := Subject;
            ObjEmailLogs.Body := CopyStr(Body, 1, 250);
            ObjEmailLogs.Name := "Recepient Name";
            ObjEmailLogs."Recepient EMail" := CopyStr("Recepient Email", 1, 250);
            ObjEmailLogs."Date Sent" := CurrentDatetime;
            ObjEmailLogs."Sender E Mail" := SMTPSetup."Email Sender Address";
            ObjEmailLogs.Status := ObjEmailLogs.Status::Sent;
            ObjEmailLogs.Insert;
            Result := true;
        end;
    end;


    procedure FnCreateLoanRecoveryJournalsLSAUfalme(VarLoanNoRecovered: Code[30]; BATCH_TEMPLATE: Code[20]; BATCH_NAME: Code[20]; DOCUMENT_NO: Code[20]; VarMemberNo: Code[20]; VarPostingDate: Date; EXTERNAL_DOC_NO: Code[30]; VarLoanSettlementAcc: Code[30]; VarMemberName: Text[100]; RunningBalance: Decimal)
    var
        ObjLoans: Record "Loans Register";
        AmountToDeduct: Decimal;
        LineNo: Integer;
        SFactory: Codeunit "SURESTEP Factory";
        VarAmounttoDeduct: Decimal;
        VarOutstandingInterest: Decimal;
        VarEndYear: Date;
        VarInsuranceMonths: Integer;
        ObjProductCharge: Record "Loan Product Charges";
        VarInsurancePayoff: Decimal;
        VarOutstandingInsurance: Decimal;
        VarLoanInsuranceBalAccount: Code[30];
        ObjLoanType: Record "Loan Products Setup";
        ObjLoanSchedule: Record "Loan Repayment Schedule";
        VarLoanInsuranceCharged: Decimal;
        VarLoanInsurancePaid: Decimal;
        VarTotalOutstandingInsurance: Decimal;
        VarLoanInterestDueBalAccount: Code[30];
        VarOutstandingPenalty: Decimal;
        VarLoanPenaltyBalAccount: Code[30];
        ObjRepamentSchedule: Record "Loan Repayment Schedule";
        VarPrincipleRepayment: Decimal;
    begin
        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
        GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
        GenJournalLine.DeleteAll;

        DOCUMENT_NO := FnRunGetNextTransactionDocumentNo;

        if RunningBalance > 0 then begin

            //============================================================Loan Insurance Repayment
            ObjLoans.Reset;
            ObjLoans.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
            ObjLoans.SetRange(ObjLoans."Loan  No.", VarLoanNoRecovered);
            if ObjLoans.Find('-') then begin

                ObjLoans.Reset;
                ObjLoans.SetRange(ObjLoans."Loan  No.", VarLoanNoRecovered);
                if ObjLoans.FindSet then begin
                    ObjLoans.CalcFields(ObjLoans."Outstanding Balance", ObjLoans."Loan Insurance Paid", ObjLoans."Penalty Charged", ObjLoans."Penalty Paid", ObjLoans."Interest Due",
                    ObjLoans."Interest Paid", ObjLoans."Insurance Paid Historical");

                    if (ObjLoans."Outstanding Balance" <> 0) and (ObjLoans."Loan Status" = ObjLoans."loan status"::Disbursed) then begin
                        VarEndYear := CalcDate('CY', Today);

                        ObjLoanSchedule.Reset;
                        ObjLoanSchedule.SetRange(ObjLoanSchedule."Loan No.", VarLoanNoRecovered);
                        ObjLoanSchedule.SetFilter(ObjLoanSchedule."Repayment Date", '>%1&<=%2', WorkDate, VarEndYear);
                        if ObjLoanSchedule.FindSet then begin
                            ObjLoanSchedule.CalcSums(ObjLoanSchedule."Monthly Insurance");
                            VarInsurancePayoff := ObjLoanSchedule."Monthly Insurance";
                        end;
                    end;
                end;

                FnGetLoanArrearsAmountII(VarLoanNoRecovered);//===========================Get Amount In Arrears

                ObjLoanSchedule.Reset;
                ObjLoanSchedule.SetRange(ObjLoanSchedule."Loan No.", VarLoanNoRecovered);
                ObjLoanSchedule.SetFilter(ObjLoanSchedule."Repayment Date", '<=%1', WorkDate);
                if ObjLoanSchedule.FindSet then begin
                    repeat
                        VarLoanInsuranceCharged := VarLoanInsuranceCharged + ObjLoanSchedule."Monthly Insurance";
                        VarLoanInsurancePaid := VarLoanInsurancePaid + ObjLoanSchedule."Insurance Paid";
                    until ObjLoanSchedule.Next = 0;
                end;

                VarOutstandingInsurance := VarLoanInsuranceCharged - VarLoanInsurancePaid;
                if ObjLoans."Loan Status" <> ObjLoans."loan status"::Disbursed then
                    VarOutstandingInsurance := 0;

                if RunningBalance > 0 then begin
                    AmountToDeduct := 0;

                    VarTotalOutstandingInsurance := VarOutstandingInsurance;

                    if VarTotalOutstandingInsurance > 0 then begin
                        if VarTotalOutstandingInsurance < RunningBalance then begin
                            AmountToDeduct := VarTotalOutstandingInsurance
                        end else
                            AmountToDeduct := RunningBalance;

                        AmountToDeduct := ROUND(AmountToDeduct, 0.01, '=');

                        if ObjLoanType.Get(ObjLoans."Loan Product Type") then begin
                            VarLoanInsuranceBalAccount := ObjLoanType."Loan Insurance Accounts";
                        end;

                        //------------------------------------Debit Loan Insurance Due---------------------------------------------------------------------------------------------
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLineBalanced(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Insurance Charged",
                        GenJournalLine."account type"::Member, ObjLoans."Client Code", WorkDate, 'Insurance Charged:_' + DOCUMENT_NO, GenJournalLine."bal. account type"::"G/L Account",
                        VarLoanInsuranceBalAccount, AmountToDeduct, 'BOSA', VarLoanNoRecovered);
                        //--------------------------------Debit Loan Insurance Due-------------------------------------------------------------------------------

                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLineGuarantorRecovery(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Insurance Paid",
                        GenJournalLine."account type"::Member, VarMemberNo, VarPostingDate, AmountToDeduct * -1, 'BOSA', EXTERNAL_DOC_NO,
                        'Insurance Paid', VarLoanNoRecovered, GenJournalLine."recovery transaction type"::"Guarantor Recoverd", VarLoanNoRecovered);

                        RunningBalance := RunningBalance - AmountToDeduct;
                        VarAmounttoDeduct := VarAmounttoDeduct + AmountToDeduct;
                    end;
                end;
            end;
        end;


        //============================================================Loan Penalty Repayment
        if RunningBalance > 0 then begin
            ObjLoans.Reset;
            ObjLoans.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
            ObjLoans.SetRange(ObjLoans."Loan  No.", VarLoanNoRecovered);
            if ObjLoans.Find('-') then begin
                ObjLoans.CalcFields(ObjLoans."Outstanding Balance", ObjLoans."Penalty Charged", ObjLoans."Penalty Paid", ObjLoans."Penalty Paid Historical");
                if RunningBalance > 0 then begin
                    AmountToDeduct := 0;

                    VarOutstandingPenalty := ObjLoans."Penalty Charged" - (ObjLoans."Penalty Paid" + ObjLoans."Penalty Paid Historical");
                    if VarOutstandingPenalty < 0 then
                        VarOutstandingPenalty := 0;

                    if VarOutstandingPenalty > 0 then begin
                        if VarOutstandingPenalty < RunningBalance then begin
                            AmountToDeduct := VarOutstandingPenalty
                        end else
                            AmountToDeduct := RunningBalance;

                        AmountToDeduct := ROUND(AmountToDeduct, 0.01, '=');

                        if ObjLoanType.Get(ObjLoans."Loan Product Type") then begin
                            VarLoanPenaltyBalAccount := ObjLoanType."Penalty Paid Account";
                        end;



                        //------------------------------------Debit Loan Penalty Charged---------------------------------------------------------------------------------------------
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLineBalanced(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Penalty Charged",
                        GenJournalLine."account type"::Member, ObjLoans."Client Code", WorkDate, 'Penalty Charged:_' + DOCUMENT_NO, GenJournalLine."bal. account type"::"G/L Account",
                        VarLoanPenaltyBalAccount, AmountToDeduct, 'BOSA', VarLoanNoRecovered);
                        //--------------------------------Debit Loan Penalty Charged-------------------------------------------------------------------------------

                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLineGuarantorRecovery(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Penalty Paid",
                        GenJournalLine."account type"::Member, VarMemberNo, VarPostingDate, AmountToDeduct * -1, 'BOSA', EXTERNAL_DOC_NO,
                        'Penalty Paid', VarLoanNoRecovered, GenJournalLine."recovery transaction type"::"Guarantor Recoverd", VarLoanNoRecovered);

                        RunningBalance := RunningBalance - AmountToDeduct;
                        VarAmounttoDeduct := VarAmounttoDeduct + AmountToDeduct;
                    end;
                end;
            end;
        end;


        //============================================================Loan Interest Repayment
        if RunningBalance > 0 then begin
            ObjLoans.Reset;
            ObjLoans.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
            ObjLoans.SetRange(ObjLoans."Loan  No.", VarLoanNoRecovered);
            if ObjLoans.Find('-') then begin
                ObjLoans.CalcFields(ObjLoans."Outstanding Balance", ObjLoans."Interest Due", ObjLoans."Interest Paid", ObjLoans."Penalty Charged",
              ObjLoans."Penalty Paid", ObjLoans."Interest Paid Historical");
                if RunningBalance > 0 then begin
                    VarOutstandingInterest := ObjLoans."Interest Due" - (ObjLoans."Interest Paid" + ObjLoans."Interest Paid Historical");
                    if VarOutstandingInterest < 0 then
                        VarOutstandingInterest := 0;

                    AmountToDeduct := 0;
                    if VarOutstandingInterest > 0 then begin
                        if VarOutstandingInterest < RunningBalance then begin
                            AmountToDeduct := VarOutstandingInterest
                        end else
                            AmountToDeduct := RunningBalance;

                        AmountToDeduct := ROUND(AmountToDeduct, 0.01, '=');

                        if ObjLoanType.Get(ObjLoans."Loan Product Type") then begin
                            VarLoanInterestDueBalAccount := ObjLoanType."Loan Interest Account";
                        end;

                        //------------------------------------Debit Loan Interest Due---------------------------------------------------------------------------------------------
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLineBalanced(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Interest Due",
                        GenJournalLine."account type"::Member, ObjLoans."Client Code", WorkDate, 'Interest Charged:_' + DOCUMENT_NO, GenJournalLine."bal. account type"::"G/L Account",
                        VarLoanInterestDueBalAccount, AmountToDeduct, 'BOSA', VarLoanNoRecovered);
                        //--------------------------------Debit Loan Interest Due-------------------------------------------------------------------------------

                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLineGuarantorRecovery(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Interest Paid",
                        GenJournalLine."account type"::Member, VarMemberNo, VarPostingDate, AmountToDeduct * -1, 'BOSA', EXTERNAL_DOC_NO,
                        'Interest Paid', VarLoanNoRecovered, GenJournalLine."recovery transaction type"::"Guarantor Recoverd", VarLoanNoRecovered);

                        RunningBalance := RunningBalance - AmountToDeduct;
                        VarAmounttoDeduct := VarAmounttoDeduct + AmountToDeduct;
                    end;
                end;
            end;
        end;





        //============================================================Loan Principle Repayment
        if RunningBalance > 0 then begin
            ObjLoans.Reset;
            ObjLoans.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
            ObjLoans.SetRange(ObjLoans."Loan  No.", VarLoanNoRecovered);
            if ObjLoans.Find('-') then begin

                ObjRepamentSchedule.Reset;
                ObjRepamentSchedule.SetRange(ObjRepamentSchedule."Loan No.", VarLoanNoRecovered);
                ObjRepamentSchedule.SetRange(ObjRepamentSchedule."Repayment Date", WorkDate);
                if ObjRepamentSchedule.FindSet then begin
                    VarPrincipleRepayment := ObjRepamentSchedule."Principal Repayment";
                end;

                ObjLoans.CalcFields(ObjLoans."Outstanding Balance", ObjLoans."Penalty Charged", ObjLoans."Penalty Paid");
                if RunningBalance > 0 then begin
                    AmountToDeduct := 0;
                    if ObjLoans."Outstanding Balance" > 0 then begin
                        if VarPrincipleRepayment < RunningBalance then begin
                            AmountToDeduct := VarPrincipleRepayment
                        end else
                            AmountToDeduct := RunningBalance;

                        AmountToDeduct := ROUND(AmountToDeduct, 0.01, '=');

                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLineGuarantorRecovery(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Repayment",
                        GenJournalLine."account type"::Member, VarMemberNo, VarPostingDate, AmountToDeduct * -1, 'BOSA', EXTERNAL_DOC_NO,
                        'Loan Recovery', VarLoanNoRecovered, GenJournalLine."recovery transaction type"::"Guarantor Recoverd", VarLoanNoRecovered);
                        RunningBalance := RunningBalance - AmountToDeduct;
                        VarAmounttoDeduct := VarAmounttoDeduct + AmountToDeduct;
                    end;
                end;
            end;
        end;

        //==============================================================================================Recover From Loan Settlement Account
        LineNo := LineNo + 10000;
        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
        GenJournalLine."account type"::Vendor, VarLoanSettlementAcc, VarPostingDate, VarAmounttoDeduct, 'BOSA', EXTERNAL_DOC_NO,
        'Loan Recovery' + '-' + VarMemberNo + '-' + VarMemberName, '', GenJournalLine."application source"::" ");
        //==============================================================================================End Recover From Loan Settlement Account
    end;


    procedure FnGetOutstandingInterest(VarLoanNo: Code[30]) VarOutstandingInterest: Decimal
    var
        ObjLoans: Record "Loans Register";
    begin
        ObjLoans.Reset;
        ObjLoans.SetRange(ObjLoans."Loan  No.", VarLoanNo);
        ObjLoans.CalcFields(ObjLoans."Interest Due", ObjLoans."Interest Paid", ObjLoans."Interest Paid Historical");
        if ObjLoans.FindSet then begin
            VarOutstandingInterest := ObjLoans."Interest Due" - (ObjLoans."Interest Paid" + ObjLoans."Interest Paid Historical");
            //MESSAGE('Interest Due is %1,Loan No %2',ObjLoans."Interest Due",ObjLoans."Loan  No.");
            if VarOutstandingInterest < 0 then
                VarOutstandingInterest := 0;
            exit(VarOutstandingInterest);
        end;
    end;


    procedure FnGetMemberUnsecuredLoanAmount(VarMemberNo: Code[30]) VarTotalUnsecuredLoans: Decimal
    var
        ObjSecurities: Record "Loan Collateral Details";
        VarTotalCollateralValue: Decimal;
        VarTotalLoansnotSecuredbyCollateral: Decimal;
    begin
        VarTotalCollateralValue := 0;

        ObjLoans.CalcFields(ObjLoans."Outstanding Balance");
        //Get Member Collateral Value===========================================
        ObjLoans.Reset;
        ObjLoans.SetRange(ObjLoans."Client Code", VarMemberNo);
        ObjLoans.SetFilter(ObjLoans."Outstanding Balance", '>%1', 0);
        if ObjLoans.FindSet then begin
            repeat
                ObjLoans.CalcFields(ObjLoans."Outstanding Balance");
                ObjSecurities.Reset;
                ObjSecurities.SetRange(ObjSecurities."Loan No", ObjLoans."Loan  No.");
                ObjSecurities.SetFilter(ObjSecurities."Guarantee Value", '<%1', ObjLoans."Outstanding Balance");
                if ObjSecurities.FindSet then begin
                    VarTotalCollateralValue := VarTotalCollateralValue + (ObjLoans."Outstanding Balance" - ObjSecurities."Guarantee Value");
                end;
            until ObjLoans.Next = 0;
        end;
        //End Get Member Collateral Value=======================================

        VarTotalLoansnotSecuredbyCollateral := 0;
        ObjLoans.CalcFields(ObjLoans."Outstanding Balance");
        //Get Loans not Secured by Collateral===========================================
        ObjLoans.Reset;
        ObjLoans.SetRange(ObjLoans."Client Code", VarMemberNo);
        ObjLoans.SetFilter(ObjLoans."Outstanding Balance", '>%1', 0);
        if ObjLoans.FindSet then begin
            repeat
                ObjLoans.CalcFields(ObjLoans."Outstanding Balance");
                ObjSecurities.Reset;
                ObjSecurities.SetRange(ObjSecurities."Loan No", ObjLoans."Loan  No.");
                if ObjSecurities.Find('-') = false then begin
                    VarTotalLoansnotSecuredbyCollateral := VarTotalLoansnotSecuredbyCollateral + ObjLoans."Outstanding Balance";
                end;
            until ObjLoans.Next = 0;
        end;
        //End Get Loans not Secured by Collateral=======================================

        VarTotalUnsecuredLoans := VarTotalCollateralValue + VarTotalLoansnotSecuredbyCollateral;
        exit(VarTotalUnsecuredLoans);
    end;


    procedure FnRunGetLoanPayoffAmount(VarLoanNo: Code[30]) VarLoanPayoffAmount: Decimal
    var
        ObjLoans: Record "Loans Register";
        VarInsurancePayoff: Decimal;
        ObjProductCharge: Record "Loan Product Charges";
        VarEndYear: Date;
        VarInsuranceMonths: Integer;
        VarAmountinArrears: Decimal;
        ObjRepaymentSchedule: Record "Loan Repayment Schedule";
        VarOutstandingInterest: Decimal;
        ObjLoanSchedule: Record "Loan Repayment Schedule";
        VarLoanInsuranceCharged: Decimal;
        VarLoanInsurancePaid: Decimal;
        VarOutstandingInsurance: Decimal;
        VarOutstandingPenalty: Decimal;
        VarTotalInterestPaid: Decimal;
        VarTotalPenaltyPaid: Decimal;
    begin
        ObjLoans.Reset;
        ObjLoans.SetRange(ObjLoans."Loan  No.", VarLoanNo);
        if ObjLoans.FindSet then begin
            ObjLoans.CalcFields(ObjLoans."Outstanding Balance", ObjLoans."Loan Insurance Paid", ObjLoans."Penalty Charged", ObjLoans."Penalty Paid", ObjLoans."Interest Due",
            ObjLoans."Interest Paid");

            /*IF ObjLoans."Outstanding Balance"<>0 THEN
              BEGIN
              VarEndYear:=CALCDATE('CY',TODAY);
              VarInsuranceMonths:=ROUND((VarEndYear-TODAY)/30,1,'=');

              ObjProductCharge.RESET;
              ObjProductCharge.SETRANGE(ObjProductCharge."Product Code",ObjLoans."Loan Product Type");
              ObjProductCharge.SETRANGE(ObjProductCharge."Loan Charge Type",ObjProductCharge."Loan Charge Type"::"Loan Insurance");
              IF ObjProductCharge.FINDSET THEN BEGIN
                  VarInsurancePayoff:=ROUND((ObjLoans."Approved Amount"*(ObjProductCharge.Percentage/100))*VarInsuranceMonths,0.05,'>');
                END;


                  FnGetLoanArrearsAmountII(VarLoanNo);//===========================Get Amount In Arrears

                  ObjLoanSchedule.RESET;
                  ObjLoanSchedule.SETRANGE(ObjLoanSchedule."Loan No.",VarLoanNo);
                  ObjLoanSchedule.SETFILTER(ObjLoanSchedule."Repayment Date",'<=%1',WORKDATE);
                  IF ObjLoanSchedule.FINDSET THEN
                    BEGIN
                      REPEAT
                        VarLoanInsuranceCharged:=VarLoanInsuranceCharged+ObjLoanSchedule."Monthly Insurance";
                        VarLoanInsurancePaid:=VarLoanInsurancePaid+ObjLoanSchedule."Insurance Paid";
                        UNTIL ObjLoanSchedule.NEXT=0;
                      END;

                    VarOutstandingInsurance:=VarLoanInsuranceCharged-VarLoanInsurancePaid;
                    */



            //============================================================Loan Insurance Repayment
            ObjLoans.Reset;
            ObjLoans.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
            ObjLoans.SetRange(ObjLoans."Loan  No.", VarLoanNo);
            if ObjLoans.Find('-') then begin

                ObjLoans.Reset;
                ObjLoans.SetRange(ObjLoans."Loan  No.", VarLoanNo);
                if ObjLoans.FindSet then begin
                    ObjLoans.CalcFields(ObjLoans."Outstanding Balance", ObjLoans."Loan Insurance Paid", ObjLoans."Penalty Charged", ObjLoans."Penalty Paid", ObjLoans."Interest Due",
                    ObjLoans."Interest Paid", ObjLoans."Penalty Paid Historical", ObjLoans."Interest Paid Historical");

                    if (ObjLoans."Outstanding Balance" <> 0) and (ObjLoans."Loan Status" = ObjLoans."loan status"::Disbursed) then begin
                        VarEndYear := CalcDate('CY', Today);

                        ObjLoanSchedule.Reset;
                        ObjLoanSchedule.SetRange(ObjLoanSchedule."Loan No.", VarLoanNo);
                        ObjLoanSchedule.SetFilter(ObjLoanSchedule."Repayment Date", '>%1&<=%2', WorkDate, VarEndYear);
                        if ObjLoanSchedule.FindSet then begin
                            ObjLoanSchedule.CalcSums(ObjLoanSchedule."Monthly Insurance");
                            VarInsurancePayoff := ObjLoanSchedule."Monthly Insurance";
                        end;
                    end;
                end;

                FnGetLoanArrearsAmountII(VarLoanNo);//===========================Get Amount In Arrears

                ObjLoanSchedule.Reset;
                ObjLoanSchedule.SetRange(ObjLoanSchedule."Loan No.", VarLoanNo);
                ObjLoanSchedule.SetFilter(ObjLoanSchedule."Repayment Date", '<=%1', WorkDate);
                if ObjLoanSchedule.FindSet then begin
                    repeat
                        VarLoanInsuranceCharged := VarLoanInsuranceCharged + ObjLoanSchedule."Monthly Insurance";
                        VarLoanInsurancePaid := VarLoanInsurancePaid + ObjLoanSchedule."Insurance Paid";
                    until ObjLoanSchedule.Next = 0;
                end;

                VarOutstandingInsurance := VarLoanInsuranceCharged - VarLoanInsurancePaid;
                if ObjLoans."Loan Status" <> ObjLoans."loan status"::Disbursed then
                    VarOutstandingInsurance := 0;


                VarOutstandingInterest := ObjLoans."Interest Due" - (ObjLoans."Interest Paid" + ObjLoans."Interest Paid Historical");
                if VarOutstandingInterest < 0 then begin
                    VarOutstandingInterest := 0;
                end;

                VarOutstandingPenalty := ObjLoans."Penalty Charged" - (ObjLoans."Penalty Paid" + ObjLoans."Penalty Paid Historical");
                if VarOutstandingPenalty < 0 then begin
                    VarOutstandingPenalty := 0;
                end;

                VarTotalInterestPaid := ObjLoans."Interest Paid" + ObjLoans."Interest Paid Historical";
                VarTotalPenaltyPaid := ObjLoans."Penalty Paid" + ObjLoans."Penalty Paid Historical";
                if ObjLoans.Get(VarLoanNo) then begin
                    ObjLoans."Outstanding Penalty" := VarOutstandingPenalty;
                    ObjLoans."Outstanding Insurance" := VarOutstandingInsurance;
                    ObjLoans."Loan Insurance Charged" := VarLoanInsuranceCharged;
                    ObjLoans."Total Insurance Paid" := VarLoanInsurancePaid;
                    ObjLoans."Total Penalty Paid" := VarTotalPenaltyPaid;
                    ObjLoans."Outstanding Interest" := VarOutstandingInterest;
                    ObjLoans."Total Interest Paid" := VarTotalInterestPaid;
                    ObjLoans."Insurance Payoff" := VarInsurancePayoff;
                    ObjLoans.Modify;
                end;
                ObjLoans.CalcFields(ObjLoans."Outstanding Balance");
                VarLoanPayoffAmount := ObjLoans."Outstanding Balance" + VarOutstandingInterest + VarOutstandingPenalty + (VarOutstandingInsurance + VarInsurancePayoff);
                exit(VarLoanPayoffAmount);

            end;
        end;

    end;


    procedure FnRunGetLoanPayoffRecoveryAmount(VarLoanNo: Code[30]) VarLoanPayoffAmount: Decimal
    var
        ObjLoans: Record "Loans Register";
        VarInsurancePayoff: Decimal;
        ObjProductCharge: Record "Loan Product Charges";
        VarEndYear: Date;
        VarInsuranceMonths: Integer;
        VarAmountinArrears: Decimal;
        ObjRepaymentSchedule: Record "Loan Repayment Schedule";
        VarOutstandingInterest: Decimal;
        ObjLoanSchedule: Record "Loan Repayment Schedule";
        VarLoanInsuranceCharged: Decimal;
        VarLoanInsurancePaid: Decimal;
        VarOutstandingInsurance: Decimal;
        VarOutstandingPenalty: Decimal;
    begin
        ObjLoans.Reset;
        ObjLoans.SetRange(ObjLoans."Loan  No.", VarLoanNo);
        if ObjLoans.FindSet then begin
            ObjLoans.CalcFields(ObjLoans."Outstanding Balance", ObjLoans."Loan Insurance Paid", ObjLoans."Penalty Charged", ObjLoans."Penalty Paid", ObjLoans."Interest Due",
            ObjLoans."Interest Paid", ObjLoans."Interest Paid Historical", ObjLoans."Penalty Paid Historical");


            //============================================================Loan Insurance Repayment
            ObjLoans.Reset;
            ObjLoans.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
            ObjLoans.SetRange(ObjLoans."Loan  No.", VarLoanNo);
            if ObjLoans.Find('-') then begin

                ObjLoans.Reset;
                ObjLoans.SetRange(ObjLoans."Loan  No.", VarLoanNo);
                if ObjLoans.FindSet then begin
                    ObjLoans.CalcFields(ObjLoans."Outstanding Balance", ObjLoans."Loan Insurance Paid", ObjLoans."Penalty Charged", ObjLoans."Penalty Paid", ObjLoans."Interest Due",
                    ObjLoans."Interest Paid", ObjLoans."Interest Paid Historical", ObjLoans."Penalty Paid Historical");

                    if (ObjLoans."Outstanding Balance" <> 0) and (ObjLoans."Loan Status" = ObjLoans."loan status"::Disbursed) then begin
                        VarEndYear := CalcDate('CY', Today);

                        ObjLoanSchedule.Reset;
                        ObjLoanSchedule.SetRange(ObjLoanSchedule."Loan No.", VarLoanNo);
                        ObjLoanSchedule.SetFilter(ObjLoanSchedule."Repayment Date", '>%1&<=%2', WorkDate, VarEndYear);
                        if ObjLoanSchedule.FindSet then begin
                            ObjLoanSchedule.CalcSums(ObjLoanSchedule."Monthly Insurance");
                            VarInsurancePayoff := ObjLoanSchedule."Monthly Insurance";
                        end;
                    end;
                end;

                FnGetLoanArrearsAmountII(VarLoanNo);//===========================Get Amount In Arrears

                ObjLoanSchedule.Reset;
                ObjLoanSchedule.SetRange(ObjLoanSchedule."Loan No.", VarLoanNo);
                ObjLoanSchedule.SetFilter(ObjLoanSchedule."Repayment Date", '<=%1', WorkDate);
                if ObjLoanSchedule.FindSet then begin
                    repeat
                        VarLoanInsuranceCharged := VarLoanInsuranceCharged + ObjLoanSchedule."Monthly Insurance";
                        VarLoanInsurancePaid := VarLoanInsurancePaid + ObjLoanSchedule."Insurance Paid";
                    until ObjLoanSchedule.Next = 0;
                end;

                VarOutstandingInsurance := VarLoanInsuranceCharged - VarLoanInsurancePaid;
                if ObjLoans."Loan Status" <> ObjLoans."loan status"::Disbursed then
                    VarOutstandingInsurance := 0;


                VarOutstandingInterest := ObjLoans."Interest Due" - (ObjLoans."Interest Paid" + ObjLoans."Interest Paid Historical");
                if VarOutstandingInterest < 0 then begin
                    VarOutstandingInterest := 0;
                end;

                VarOutstandingPenalty := ObjLoans."Penalty Charged" - (ObjLoans."Penalty Paid" + ObjLoans."Penalty Paid Historical");
                if VarOutstandingPenalty < 0 then begin
                    VarOutstandingPenalty := 0;
                end;

                if ObjLoans.Get(VarLoanNo) then begin
                    ObjLoans."Outstanding Penalty" := VarOutstandingPenalty;
                    ObjLoans."Outstanding Insurance" := VarOutstandingInsurance;
                    ObjLoans."Loan Insurance Charged" := VarLoanInsuranceCharged;
                    ObjLoans."Loan Insurance Paid" := VarLoanInsurancePaid;
                    ObjLoans.Modify;
                end;
                ObjLoans.CalcFields(ObjLoans."Outstanding Balance");
                VarLoanPayoffAmount := ObjLoans."Outstanding Balance" + VarOutstandingInterest + VarOutstandingPenalty + (VarOutstandingInsurance);
                exit(VarLoanPayoffAmount);

            end;
        end;
    end;


    procedure FnCreateLoanPayOffJournals(VarLoanNoRecovered: Code[30]; BATCH_TEMPLATE: Code[20]; BATCH_NAME: Code[20]; DOCUMENT_NO: Code[20]; VarMemberNo: Code[20]; VarPostingDate: Date; EXTERNAL_DOC_NO: Code[30]; VarLoanSettlementAcc: Code[30]; VarMemberName: Text[100]; RunningBalance: Decimal)
    var
        ObjLoans: Record "Loans Register";
        AmountToDeduct: Decimal;
        LineNo: Integer;
        SFactory: Codeunit "SURESTEP Factory";
        VarAmounttoDeduct: Decimal;
        VarOutstandingInterest: Decimal;
        VarEndYear: Date;
        VarInsuranceMonths: Integer;
        ObjProductCharge: Record "Loan Product Charges";
        VarInsurancePayoff: Decimal;
        VarOutstandingInsurance: Decimal;
        VarLoanInsuranceBalAccount: Code[30];
        ObjLoanType: Record "Loan Products Setup";
        ObjLoanSchedule: Record "Loan Repayment Schedule";
        VarLoanInsuranceCharged: Decimal;
        VarLoanInsurancePaid: Decimal;
        VarTotalOutstandingInsurance: Decimal;
        VarLoanInterestDueBalAccount: Code[30];
        VarOutstandingPenalty: Decimal;
        VarLoanPenaltyBalAccount: Code[30];
        VarLoanDueAmount: Decimal;
        VarDebtCollectorBaseAmount: Decimal;
        VarDebtCollectorFee: Decimal;
        ObjInterestLedger: Record "Interest Due Ledger Entry";
        VarLineNo: Integer;
    begin
        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
        GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
        GenJournalLine.DeleteAll;

        DOCUMENT_NO := FnRunGetNextTransactionDocumentNo;
        //============================================================Debt Collector Fee
        if RunningBalance > 0 then begin
            if ObjLoans.Get(VarLoanNoRecovered) then begin
                ObjVendor.Reset;
                ObjVendor.SetRange(ObjVendor."No.", ObjLoans."Loan Debt Collector");
                if ObjVendor.FindSet then begin
                    VarDebtCollectorFee := SFactory.FnRunGetLoanDebtCollectorFeePayoff(VarLoanNoRecovered, RunningBalance);

                    if RunningBalance > VarDebtCollectorFee then begin
                        AmountToDeduct := VarDebtCollectorFee
                    end else
                        AmountToDeduct := RunningBalance;

                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLineGuarantorRecovery(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::Vendor, ObjLoans."Loan Debt Collector", VarPostingDate, AmountToDeduct * -1, 'BOSA', EXTERNAL_DOC_NO,
                    'Debt Collection Charge + VAT from ' + VarLoanNoRecovered + ObjLoans."Client Name", VarLoanNoRecovered, GenJournalLine."recovery transaction type"::"Guarantor Recoverd", VarLoanNoRecovered);

                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLineGuarantorRecovery(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::Vendor, VarLoanSettlementAcc, VarPostingDate, AmountToDeduct, 'BOSA', EXTERNAL_DOC_NO,
                    'Debt Collection Charge + VAT from ' + VarLoanNoRecovered + ObjLoans."Client Name", VarLoanNoRecovered, GenJournalLine."recovery transaction type"::"Guarantor Recoverd", VarLoanNoRecovered);
                    RunningBalance := RunningBalance - AmountToDeduct;
                end
            end;
        end;


        //============================================================Loan Penalty Repayment
        if RunningBalance > 0 then begin
            ObjLoans.Reset;
            ObjLoans.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
            ObjLoans.SetRange(ObjLoans."Loan  No.", VarLoanNoRecovered);
            if ObjLoans.Find('-') then begin
                ObjLoans.CalcFields(ObjLoans."Outstanding Balance", ObjLoans."Loan Insurance Paid", ObjLoans."Penalty Charged", ObjLoans."Penalty Paid",
                ObjLoans."Interest Paid Historical", ObjLoans."Penalty Paid Historical");
                if RunningBalance > 0 then begin
                    AmountToDeduct := 0;

                    VarOutstandingPenalty := ObjLoans."Penalty Charged" - (ObjLoans."Penalty Paid" + ObjLoans."Penalty Paid Historical");
                    if VarOutstandingPenalty < 0 then
                        VarOutstandingPenalty := 0;

                    if VarOutstandingPenalty > 0 then begin
                        if VarOutstandingPenalty < RunningBalance then begin
                            AmountToDeduct := VarOutstandingPenalty
                        end else
                            AmountToDeduct := RunningBalance;

                        AmountToDeduct := ROUND(AmountToDeduct, 0.01, '=');

                        if ObjLoanType.Get(ObjLoans."Loan Product Type") then begin
                            VarLoanPenaltyBalAccount := ObjLoanType."Penalty Paid Account";
                        end;



                        //------------------------------------Debit Loan Penalty Charged---------------------------------------------------------------------------------------------
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLineBalanced(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Penalty Charged",
                        GenJournalLine."account type"::Member, ObjLoans."Client Code", WorkDate, 'PayOff:Penalty Charged:_' + DOCUMENT_NO, GenJournalLine."bal. account type"::"G/L Account",
                        VarLoanPenaltyBalAccount, AmountToDeduct, 'BOSA', VarLoanNoRecovered);
                        //--------------------------------Debit Loan Penalty Charged-------------------------------------------------------------------------------

                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLineGuarantorRecovery(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Penalty Paid",
                        GenJournalLine."account type"::Member, VarMemberNo, VarPostingDate, AmountToDeduct * -1, 'BOSA', EXTERNAL_DOC_NO,
                        'PayOff:Penalty Paid', VarLoanNoRecovered, GenJournalLine."recovery transaction type"::"Guarantor Recoverd", VarLoanNoRecovered);

                        RunningBalance := RunningBalance - AmountToDeduct;
                        VarAmounttoDeduct := VarAmounttoDeduct + AmountToDeduct;
                    end;
                end;
            end;
        end;

        //============================================================Loan Interest Repayment
        if RunningBalance > 0 then begin

            if ObjLoans."Loan Product Type" <> '322' then
                FnRunAccrueInterestforNewLoansPayoff(VarLoanNo);//=====================Accrue Interest for New Loans Payoff



            ObjLoans.Reset;
            ObjLoans.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
            ObjLoans.SetRange(ObjLoans."Loan  No.", VarLoanNoRecovered);
            if ObjLoans.Find('-') then begin
                ObjLoans.CalcFields(ObjLoans."Outstanding Balance", ObjLoans."Interest Due", ObjLoans."Interest Paid", ObjLoans."Loan Insurance Paid",
              ObjLoans."Penalty Charged", ObjLoans."Penalty Paid", ObjLoans."Interest Paid Historical", ObjLoans."Penalty Paid Historical");
                if RunningBalance > 0 then begin
                    VarOutstandingInterest := ObjLoans."Interest Due" - (ObjLoans."Interest Paid" + ObjLoans."Interest Paid Historical");
                    if VarOutstandingInterest < 0 then
                        VarOutstandingInterest := 0;
                    ObjLoans.CalcFields(ObjLoans."Outstanding Balance", ObjLoans."Interest Due");

                    AmountToDeduct := 0;
                    if VarOutstandingInterest > 0 then begin
                        if VarOutstandingInterest < RunningBalance then begin
                            AmountToDeduct := VarOutstandingInterest
                        end else
                            AmountToDeduct := RunningBalance;

                        AmountToDeduct := ROUND(AmountToDeduct, 0.01, '=');

                        if ObjLoanType.Get(ObjLoans."Loan Product Type") then begin
                            VarLoanInterestDueBalAccount := ObjLoanType."Loan Interest Account";
                        end;

                        //------------------------------------Debit Loan Interest Due---------------------------------------------------------------------------------------------
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLineBalanced(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Interest Due",
                        GenJournalLine."account type"::Member, ObjLoans."Client Code", WorkDate, 'PayOff:Interest Charged:_' + DOCUMENT_NO, GenJournalLine."bal. account type"::"G/L Account",
                        VarLoanInterestDueBalAccount, AmountToDeduct, 'BOSA', VarLoanNoRecovered);
                        //--------------------------------Debit Loan Interest Due-------------------------------------------------------------------------------

                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLineGuarantorRecovery(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Interest Paid",
                        GenJournalLine."account type"::Member, VarMemberNo, VarPostingDate, AmountToDeduct * -1, 'BOSA', EXTERNAL_DOC_NO,
                        'PayOff:Interest Paid', VarLoanNoRecovered, GenJournalLine."recovery transaction type"::"Guarantor Recoverd", VarLoanNoRecovered);

                        RunningBalance := RunningBalance - AmountToDeduct;
                        VarAmounttoDeduct := VarAmounttoDeduct + AmountToDeduct;
                    end;
                end;
            end;
        end;

        //============================================================Loan Insurance Repayment
        if RunningBalance > 0 then begin

            ObjLoans.Reset;
            ObjLoans.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
            ObjLoans.SetRange(ObjLoans."Loan  No.", VarLoanNoRecovered);
            if ObjLoans.Find('-') then begin

                ObjLoans.Reset;
                ObjLoans.SetRange(ObjLoans."Loan  No.", VarLoanNoRecovered);
                if ObjLoans.FindSet then begin
                    ObjLoans.CalcFields(ObjLoans."Outstanding Balance", ObjLoans."Loan Insurance Paid", ObjLoans."Penalty Charged", ObjLoans."Penalty Paid", ObjLoans."Interest Due",
                    ObjLoans."Interest Paid");

                    if (ObjLoans."Outstanding Balance" <> 0) and (ObjLoans."Loan Status" = ObjLoans."loan status"::Disbursed) then begin
                        VarEndYear := CalcDate('CY', Today);

                        ObjLoanSchedule.Reset;
                        ObjLoanSchedule.SetRange(ObjLoanSchedule."Loan No.", VarLoanNoRecovered);
                        ObjLoanSchedule.SetFilter(ObjLoanSchedule."Repayment Date", '>%1&<=%2', WorkDate, VarEndYear);
                        if ObjLoanSchedule.FindSet then begin
                            ObjLoanSchedule.CalcSums(ObjLoanSchedule."Monthly Insurance");
                            VarInsurancePayoff := ObjLoanSchedule."Monthly Insurance";
                        end;
                    end;
                end;

                FnGetLoanArrearsAmountII(VarLoanNoRecovered);//===========================Get Amount In Arrears

                ObjLoanSchedule.Reset;
                ObjLoanSchedule.SetRange(ObjLoanSchedule."Loan No.", VarLoanNoRecovered);
                ObjLoanSchedule.SetFilter(ObjLoanSchedule."Repayment Date", '<=%1', WorkDate);
                if ObjLoanSchedule.FindSet then begin
                    repeat
                        VarLoanInsuranceCharged := VarLoanInsuranceCharged + ObjLoanSchedule."Monthly Insurance";
                        VarLoanInsurancePaid := VarLoanInsurancePaid + ObjLoanSchedule."Insurance Paid";
                    until ObjLoanSchedule.Next = 0;
                end;

                VarOutstandingInsurance := VarLoanInsuranceCharged - VarLoanInsurancePaid;
                if ObjLoans."Loan Status" <> ObjLoans."loan status"::Disbursed then
                    VarOutstandingInsurance := 0;

                if RunningBalance > 0 then begin
                    AmountToDeduct := 0;

                    VarTotalOutstandingInsurance := VarOutstandingInsurance + VarInsurancePayoff;

                    if VarTotalOutstandingInsurance > 0 then begin
                        if VarTotalOutstandingInsurance < RunningBalance then begin
                            AmountToDeduct := VarTotalOutstandingInsurance
                        end else
                            AmountToDeduct := RunningBalance;

                        AmountToDeduct := ROUND(AmountToDeduct, 0.01, '=');

                        if ObjLoanType.Get(ObjLoans."Loan Product Type") then begin
                            VarLoanInsuranceBalAccount := ObjLoanType."Loan Insurance Accounts";
                        end;

                        //------------------------------------Debit Loan Insurance Due---------------------------------------------------------------------------------------------
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLineBalanced(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Insurance Charged",
                        GenJournalLine."account type"::Member, ObjLoans."Client Code", WorkDate, 'PayOff:Insurance Charged:_' + DOCUMENT_NO, GenJournalLine."bal. account type"::"G/L Account",
                        VarLoanInsuranceBalAccount, AmountToDeduct, 'BOSA', VarLoanNoRecovered);
                        //--------------------------------Debit Loan Insurance Due-------------------------------------------------------------------------------

                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLineGuarantorRecovery(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Insurance Paid",
                        GenJournalLine."account type"::Member, VarMemberNo, VarPostingDate, AmountToDeduct * -1, 'BOSA', EXTERNAL_DOC_NO,
                        'PayOff:Insurance Paid', VarLoanNoRecovered, GenJournalLine."recovery transaction type"::"Guarantor Recoverd", VarLoanNoRecovered);

                        RunningBalance := RunningBalance - AmountToDeduct;
                        VarAmounttoDeduct := VarAmounttoDeduct + AmountToDeduct;
                    end;
                end;
            end;
        end;




        //============================================================Loan Principle Repayment
        if RunningBalance > 0 then begin
            ObjLoans.Reset;
            ObjLoans.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
            ObjLoans.SetRange(ObjLoans."Loan  No.", VarLoanNoRecovered);
            if ObjLoans.Find('-') then begin
                ObjLoans.CalcFields(ObjLoans."Outstanding Balance", ObjLoans."Penalty Charged", ObjLoans."Penalty Paid");
                if RunningBalance > 0 then begin
                    AmountToDeduct := 0;
                    if ObjLoans."Outstanding Balance" > 0 then begin
                        if ObjLoans."Outstanding Balance" < RunningBalance then begin
                            AmountToDeduct := ObjLoans."Outstanding Balance"
                        end else
                            AmountToDeduct := RunningBalance;

                        AmountToDeduct := ROUND(AmountToDeduct, 0.01, '=');

                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLineGuarantorRecovery(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Repayment",
                        GenJournalLine."account type"::Member, VarMemberNo, VarPostingDate, AmountToDeduct * -1, 'BOSA', EXTERNAL_DOC_NO,
                        'PayOff:Principle Recovery', VarLoanNoRecovered, GenJournalLine."recovery transaction type"::"Guarantor Recoverd", VarLoanNoRecovered);
                        RunningBalance := RunningBalance - AmountToDeduct;
                        VarAmounttoDeduct := VarAmounttoDeduct + AmountToDeduct;
                    end;
                end;
            end;
        end;

        //==============================================================================================Recover From Loan Settlement Account
        LineNo := LineNo + 10000;
        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
        GenJournalLine."account type"::Vendor, VarLoanSettlementAcc, VarPostingDate, VarAmounttoDeduct, 'BOSA', EXTERNAL_DOC_NO,
        'Loan Payoff Recovery' + '-' + VarMemberNo + '-' + VarMemberName, '', GenJournalLine."application source"::" ");
        //==============================================================================================End Recover From Loan Settlement Account
    end;


    procedure FnGetDailyInterestAccrualOD(VarAccountNo: Code[30])
    var
        ObjAccounts: Record Vendor;
        ObjDailyAccrual: Record "Daily Interest/Penalty Buffer";
        VarInterestCharged: Decimal;
        ObjAccountTypes: Record "Account Types-Saving Products";
        VarEntryNo: Integer;
    begin
        ObjAccounts.CalcFields(ObjAccounts.Balance);
        ObjAccounts.Reset;
        ObjAccounts.SetRange(ObjAccounts."No.", VarAccountNo);
        ObjAccounts.SetFilter(ObjAccounts.Balance, '<%1', 0);
        if ObjAccounts.FindSet then begin
            ObjAccounts.CalcFields(ObjAccounts.Balance);
            if ObjAccountTypes.Get(ObjAccounts."Account Type") then begin
                VarInterestCharged := (ObjAccountTypes."Over Draft Interest Rate" / 36000) * ObjAccounts.Balance;

                ObjDailyAccrual.Reset;
                ObjDailyAccrual.SetCurrentkey(ObjDailyAccrual."Entry No.");
                if ObjDailyAccrual.FindLast then begin
                    VarEntryNo := ObjDailyAccrual."Entry No."
                end else
                    VarEntryNo := 0;

                ObjDailyAccrual.Init;
                ObjDailyAccrual."Entry No." := VarEntryNo + 1;
                ObjDailyAccrual."Account Type" := ObjDailyAccrual."account type"::"FOSA Account";
                ObjDailyAccrual."Account No." := VarAccountNo;
                ObjDailyAccrual."Member Name" := ObjAccounts.Name;
                ObjDailyAccrual."Posting Date" := WorkDate;
                ObjDailyAccrual."Document No." := Format(WorkDate) + ':INT';
                ObjDailyAccrual.Description := 'Interest Accrual For ' + Format(WorkDate);
                ObjDailyAccrual."Base Amount" := ObjAccounts.Balance;
                ObjDailyAccrual.Amount := VarInterestCharged;
                ObjDailyAccrual."Global Dimension 1 Code" := 'FOSA';
                ObjDailyAccrual."Global Dimension 1 Code" := FnGetMemberBranch(ObjAccounts."BOSA Account No");
                ObjDailyAccrual."User ID" := UserId;
                ObjDailyAccrual."Transaction Type" := ObjDailyAccrual."transaction type"::"Interest Accrual";
                ObjDailyAccrual."Loan No" := '';
                if VarInterestCharged <> 0 then
                    ObjDailyAccrual.Insert;

            end;
        end;
    end;


    procedure FnGetDailyPenaltyChargedOnLoans(VarLoanNo: Code[30])
    var
        ObjLoans: Record "Loans Register";
        ObjDailyAccrual: Record "Daily Interest/Penalty Buffer";
        VarPenaltyCharged: Decimal;
        ObjLoanType: Record "Loan Products Setup";
        VarEntryNo: Integer;
        VarPenaltyGraceDays: DateFormula;
        ObjLoanSchedule: Record "Loan Repayment Schedule";
        VarOutstandingPenalty: Decimal;
        VarLastPrincipleRepaymentDate: Date;
        VarLastInterestPaymentDate: Date;
        VarLastInsurancePaymentDate: Date;
        VarScheduleFilter: Text;
        VarDateAftertheGraceDays: Date;
        VarPrincipleCharged: Decimal;
        VarPrinciplePaid: Decimal;
        VarInterestCharged: Decimal;
        VarInterestPaid: Decimal;
        VarInsuranceCharged: Decimal;
        VarInsurancePaid: Decimal;
        VarPrincipleArrears: Decimal;
        VarInterestArrears: Decimal;
        VarPenaltyOnPrincipleinArrears: Decimal;
        VarPenaltyOnInterestinArrears: Decimal;
        ObjLoanRepaymentschedule: Record "Loan Repayment Schedule";
        VarLastInstalmentDueDate: Date;
        ObjLoanInterestAccrued: Record "Interest Due Ledger Entry";
        VarTotalInterestAccrued: Decimal;
        VarAmountinArrearsInterest: Decimal;
        VarTotalArrears: Decimal;
    begin
        VarPenaltyCharged := 0;

        ObjLoans.CalcFields(ObjLoans."Outstanding Balance", ObjLoans."Penalty Paid", ObjLoans."Penalty Charged");

        //=======================================================================Get Outstanding Penalty Amount
        ObjLoans.Reset;
        ObjLoans.SetRange(ObjLoans."Loan  No.", VarLoanNo);
        if ObjLoans.FindSet then begin
            ObjLoans.CalcFields(ObjLoans."Outstanding Balance", ObjLoans."Penalty Paid", ObjLoans."Penalty Charged",
            ObjLoans."Interest Paid Historical", ObjLoans."Penalty Paid Historical");
            VarOutstandingPenalty := ObjLoans."Penalty Charged" - (ObjLoans."Penalty Paid" + ObjLoans."Penalty Paid Historical");
            VarInterestPaid := ObjLoans."Interest Paid" + ObjLoans."Interest Paid Historical";
            if VarOutstandingPenalty < 0 then
                VarOutstandingPenalty := 0;
        end;
        //=======================================================================End Get Outstanding Penalty Amount

        FnGetLoanArrearsAmountII(VarLoanNo);//===================================Update Schedule With Repayments

        ObjLoans.Reset;
        ObjLoans.SetRange(ObjLoans."Loan  No.", VarLoanNo);
        ObjLoans.SetRange(ObjLoans."Except From Penalty", false);
        ObjLoans.SetFilter(ObjLoans."Approved Amount", '>%1', ObjLoans."Penalty Charged");
        ObjLoans.SetFilter(ObjLoans."Outstanding Balance", '>%1', 0);
        if ObjLoans.FindSet then begin
            ObjLoans.CalcFields(ObjLoans."Outstanding Balance");
            if ObjLoanType.Get(ObjLoans."Loan Product Type") then begin

                //======================================================================Get Principle In Arrears
                ObjLoanSchedule.Reset;
                ObjLoanSchedule.SetCurrentkey(ObjLoanSchedule."Repayment Date");
                ObjLoanSchedule.SetRange(ObjLoanSchedule."Loan No.", VarLoanNo);
                ObjLoanSchedule.SetFilter(ObjLoanSchedule."Principal Repayment", '<>%1', ObjLoanSchedule."Principle Amount Paid");
                if ObjLoanSchedule.FindFirst then begin
                    VarLastPrincipleRepaymentDate := ObjLoanSchedule."Repayment Date";
                end;

                if VarLastPrincipleRepaymentDate <> 0D then begin
                    VarPrincipleCharged := 0;
                    VarPrinciplePaid := 0;
                    VarPrincipleArrears := 0;
                    VarDateAftertheGraceDays := CalcDate(ObjLoanType."Penalty Calculation Days", VarLastPrincipleRepaymentDate);

                    ObjLoanSchedule.Reset;
                    ObjLoanSchedule.SetRange(ObjLoanSchedule."Loan No.", VarLoanNo);
                    ObjLoanSchedule.SetFilter(ObjLoanSchedule."Repayment Date", '<%1', WorkDate);
                    if ObjLoanSchedule.FindSet then begin
                        if VarDateAftertheGraceDays < WorkDate then begin
                            repeat
                                VarPrincipleCharged := VarPrincipleCharged + ObjLoanSchedule."Principal Repayment";
                                VarPrinciplePaid := VarPrinciplePaid + ObjLoanSchedule."Principle Amount Paid";
                            until ObjLoanSchedule.Next = 0;
                        end;
                        VarPrincipleArrears := VarPrincipleCharged - VarPrinciplePaid;

                    end;
                end;
                //======================================================================End Get Principle In Arrears



                //====================================================Get Loan Interest In Arrears
                ObjLoanRepaymentschedule.Reset;
                ObjLoanRepaymentschedule.SetCurrentkey(ObjLoanRepaymentschedule."Repayment Date");
                ObjLoanRepaymentschedule.SetRange(ObjLoanRepaymentschedule."Loan No.", VarLoanNo);
                ObjLoanRepaymentschedule.SetFilter(ObjLoanRepaymentschedule."Repayment Date", '<%1', WorkDate);
                if ObjLoanRepaymentschedule.FindLast then begin
                    VarLastInstalmentDueDate := ObjLoanRepaymentschedule."Repayment Date";
                end;

                if VarLastInstalmentDueDate < 20180110D then
                    VarLastInstalmentDueDate := 20180110D;

                ObjLoanInterestAccrued.Reset;
                ObjLoanInterestAccrued.SetRange(ObjLoanInterestAccrued."Loan No", VarLoanNo);
                ObjLoanInterestAccrued.SetFilter(ObjLoanInterestAccrued."Posting Date", '<=%1', VarLastInstalmentDueDate);
                if ObjLoanInterestAccrued.FindSet then begin
                    repeat
                        VarTotalInterestAccrued := VarTotalInterestAccrued + ObjLoanInterestAccrued.Amount;
                    until ObjLoanInterestAccrued.Next = 0;
                end;

                VarAmountinArrearsInterest := VarTotalInterestAccrued - VarInterestPaid;
                if VarAmountinArrearsInterest < 0 then
                    VarAmountinArrearsInterest := 0;
                //====================================================Get Loan Interest In Arrears


                if ObjLoanType.Get(ObjLoans."Loan Product Type") then begin
                    if ObjLoanType."Penalty Calculation Method" = ObjLoanType."penalty calculation method"::"Principal in Arrears" then begin
                        VarTotalArrears := VarPrincipleArrears;
                    end;

                    if ObjLoanType."Penalty Calculation Method" = ObjLoanType."penalty calculation method"::"Principal in Arrears+Interest in Arrears" then begin
                        VarTotalArrears := VarPrincipleArrears + VarAmountinArrearsInterest;
                    end;
                    VarPenaltyCharged := (ObjLoanType."Penalty Percentage" / 36000) * VarTotalArrears;
                end;

            end;
        end;


        ObjDailyAccrual.Reset;
        ObjDailyAccrual.SetCurrentkey(ObjDailyAccrual."Entry No.");
        if ObjDailyAccrual.FindLast then begin
            VarEntryNo := ObjDailyAccrual."Entry No."
        end else
            VarEntryNo := 0;

        ObjDailyAccrual.Init;
        ObjDailyAccrual."Entry No." := VarEntryNo + 1;
        ObjDailyAccrual."Account Type" := ObjDailyAccrual."account type"::"BOSA Account";
        ObjDailyAccrual."Account No." := ObjLoans."Client Code";
        ObjDailyAccrual."Member Name" := ObjLoans."Client Name";
        ObjDailyAccrual."Posting Date" := WorkDate;
        ObjDailyAccrual."Document No." := Format(WorkDate) + ':Pen';
        ObjDailyAccrual.Description := 'Penaly Charged On ' + Format(WorkDate);
        ObjDailyAccrual."Base Amount" := VarTotalArrears;
        ObjDailyAccrual.Amount := VarPenaltyCharged;
        ObjDailyAccrual."Global Dimension 1 Code" := 'BOSA';
        ObjDailyAccrual."Global Dimension 1 Code" := FnGetMemberBranch(ObjLoans."Client Code");
        ObjDailyAccrual."User ID" := UserId;
        ObjDailyAccrual."Transaction Type" := ObjDailyAccrual."transaction type"::"Penalty Charged";
        ObjDailyAccrual."Loan No" := ObjLoans."Loan  No.";
        if VarPenaltyCharged <> 0 then
            ObjDailyAccrual.Insert;
    end;


    procedure FnGetCoreCapital()
    var
        ShareCapitalAmount: Decimal;
        GLEntries: Record "G/L Entry";
        ShareCapitalAcc: Code[50];
        RetainedSurplusAcc: Code[50];
        RetainedSurplusAmount: Decimal;
        CapitalGrantAcc: Code[50];
        CapitalGrantAmount: Decimal;
        StatutoryReserveAcc: Code[50];
        StatutoryReserveAmount: Decimal;
        WithMembersSharesAcc: Code[50];
        WithMembersSharesAmount: Decimal;
        AdditionalSharesAcc: Code[50];
        AdditionalSharesAmount: Decimal;
    begin
    end;


    procedure FnConvertTexttoBeginingWordstostartWithCapital(CurValue: Text[250]) NewValue: Text[250]
    var
        Cap: Boolean;
        Indx: Integer;
    begin
        if (CurValue = '') then exit; //just to save a little extra needless processing in case of empty string

        Cap := true; //Capitalize the first letter of the sentence regardless
        CurValue := Lowercase(CurValue); //convert everything to lowercase "in case" we have rogue uppercase letters

        for Indx := 1 to StrLen(CurValue) do begin
            if (CurValue[Indx] = ' ') then begin
                NewValue += ' '; //by adding a hardcoded space here we avoid having to waste processing on a call to Format()
                Cap := true;
            end else begin
                if Cap then begin
                    NewValue += UpperCase(Format(CurValue[Indx]));
                    Cap := false;
                end else
                    NewValue += Format(CurValue[Indx])
            end;
        end;

        exit(NewValue);
    end;


    procedure FnRunLoanAmountDue(VarLoanNo: Code[20]) VarTotalLoanDueAmount: Decimal
    var
        ObjLoanRepaymentschedule: Record "Loan Repayment Schedule";
        ObjLoans: Record "Loans Register";
        VarPrinciplePaid: Decimal;
        VarAmountRemaining: Decimal;
        VarAmountAllocated: Decimal;
        VarDateFilter: Text;
        VarSchedulePrincipletoDate: Decimal;
        VarActualPrincipletoDate: Decimal;
        VarAmountinArrears: Decimal;
        VarNoofDaysinArrears: Integer;
        VarInterestPaid: Decimal;
        VarInsurancePaid: Decimal;
        VarAmountRemainingInterest: Decimal;
        VarAmountRemainingInsurance: Decimal;
        VarAmountAllocatedInterest: Decimal;
        VarAmountAllocatedInsurance: Decimal;
        VarScheduleInteresttoDate: Decimal;
        VarActualInteresttoDate: Decimal;
        VarScheduleInsurancetoDate: Decimal;
        VarActualInsurancetoDate: Decimal;
        VarAmountinArrearsInterest: Decimal;
        VarAmountinArrearsInsurance: Decimal;
        VarOutstandingPenalty: Decimal;
        VarLastInstalmentDueDate: Date;
        ObjLoanInterestAccrued: Record "Interest Due Ledger Entry";
        VarTotalInterestAccrued: Decimal;
        VarCurrOutstandingInterest: Decimal;
    begin
        VarAmountRemaining := 0;
        VarAmountAllocated := 0;
        //VarAmountRemainingInterest:=0;
        //VarAmountRemainingInsurance:=0;

        //=================================================Initialize amounts Paid on the Schedule
        ObjLoanRepaymentschedule.Reset;
        ObjLoanRepaymentschedule.SetRange(ObjLoanRepaymentschedule."Loan No.", VarLoanNo);
        if ObjLoanRepaymentschedule.FindSet then begin
            repeat
                ObjLoanRepaymentschedule."Principle Amount Paid" := 0;
                ObjLoanRepaymentschedule."Interest Paid" := 0;
                ObjLoanRepaymentschedule."Insurance Paid" := 0;
                ObjLoanRepaymentschedule.Modify;
            until ObjLoanRepaymentschedule.Next = 0;
        end;
        //=================================================End Initialize amounts Paid on the Schedule

        ObjLoans.Reset;
        ObjLoans.SetRange(ObjLoans."Loan  No.", VarLoanNo);
        if ObjLoans.FindSet then begin
            ObjLoans.CalcFields(ObjLoans."Principle Paid to Date", ObjLoans."Loan Insurance Paid", ObjLoans."Interest Paid", ObjLoans."Principle Paid Historical"
            , ObjLoans."Interest Paid Historical", ObjLoans."Insurance Paid Historical", ObjLoans."Penalty Paid Historical");

            VarPrinciplePaid := (ObjLoans."Principle Paid to Date" + ObjLoans."Principle Paid Historical") * -1;
            VarInterestPaid := (ObjLoans."Interest Paid" + ObjLoans."Interest Paid Historical");
            VarInsurancePaid := ((ObjLoans."Loan Insurance Paid" * -1) + ObjLoans."Insurance Paid Historical");
        end;

        VarAmountRemaining := VarPrinciplePaid;
        VarAmountRemainingInterest := VarInterestPaid;
        VarAmountRemainingInsurance := VarInsurancePaid;


        //====================================================Loan Principle
        ObjLoanRepaymentschedule.Reset;
        ObjLoanRepaymentschedule.SetRange(ObjLoanRepaymentschedule."Loan No.", VarLoanNo);
        if ObjLoanRepaymentschedule.FindSet then begin
            repeat
                if VarAmountRemaining > 0 then begin
                    if VarAmountRemaining >= ObjLoanRepaymentschedule."Principal Repayment" then begin
                        VarAmountAllocated := ObjLoanRepaymentschedule."Principal Repayment"
                    end;

                    if VarAmountRemaining < ObjLoanRepaymentschedule."Principal Repayment" then begin
                        VarAmountAllocated := VarAmountRemaining;
                    end;

                    ObjLoanRepaymentschedule."Principle Amount Paid" := VarAmountAllocated;
                    ObjLoanRepaymentschedule.Modify;
                    VarAmountRemaining := VarAmountRemaining - VarAmountAllocated;
                end;
            until ObjLoanRepaymentschedule.Next = 0;
        end;

        //====================================================Loan Interest
        ObjLoanRepaymentschedule.Reset;
        ObjLoanRepaymentschedule.SetRange(ObjLoanRepaymentschedule."Loan No.", VarLoanNo);
        if ObjLoanRepaymentschedule.FindSet then begin
            repeat
                if VarAmountRemainingInterest > 0 then begin

                    if VarAmountRemainingInterest >= ObjLoanRepaymentschedule."Monthly Interest" then begin
                        VarAmountAllocatedInterest := ObjLoanRepaymentschedule."Monthly Interest"
                    end;

                    if VarAmountRemainingInterest < ObjLoanRepaymentschedule."Monthly Interest" then begin
                        VarAmountAllocatedInterest := VarAmountRemainingInterest;
                    end;

                    ObjLoanRepaymentschedule."Interest Paid" := VarAmountAllocatedInterest;
                    ObjLoanRepaymentschedule.Modify;
                    VarAmountRemainingInterest := VarAmountRemainingInterest - VarAmountAllocatedInterest;
                end;
            until ObjLoanRepaymentschedule.Next = 0;
        end;




        //====================================================Loan Insurance
        ObjLoanRepaymentschedule.Reset;
        ObjLoanRepaymentschedule.SetRange(ObjLoanRepaymentschedule."Loan No.", VarLoanNo);
        if ObjLoanRepaymentschedule.FindSet then begin
            repeat
                if VarAmountRemainingInsurance > 0 then begin
                    if VarAmountRemainingInsurance >= ObjLoanRepaymentschedule."Monthly Insurance" then begin
                        VarAmountAllocatedInsurance := ObjLoanRepaymentschedule."Monthly Insurance"
                    end;

                    if VarAmountRemainingInsurance < ObjLoanRepaymentschedule."Monthly Insurance" then begin
                        VarAmountAllocatedInsurance := VarAmountRemainingInsurance;
                    end;

                    ObjLoanRepaymentschedule."Insurance Paid" := VarAmountAllocatedInsurance;
                    ObjLoanRepaymentschedule.Modify;
                    VarAmountRemainingInsurance := VarAmountRemainingInsurance - VarAmountAllocatedInsurance;
                end;
            until ObjLoanRepaymentschedule.Next = 0;
        end;

        VarDateFilter := '..' + Format(WorkDate);

        //===================================================Scheduled Repayment to Date
        ObjLoanRepaymentschedule.Reset;
        ObjLoanRepaymentschedule.SetRange(ObjLoanRepaymentschedule."Loan No.", VarLoanNo);
        ObjLoanRepaymentschedule.SetFilter(ObjLoanRepaymentschedule."Repayment Date", '<=%1', WorkDate);
        if ObjLoanRepaymentschedule.FindSet then begin
            repeat
                VarSchedulePrincipletoDate := VarSchedulePrincipletoDate + ObjLoanRepaymentschedule."Principal Repayment";
                VarScheduleInteresttoDate := VarScheduleInteresttoDate + ObjLoanRepaymentschedule."Monthly Interest";
                VarScheduleInsurancetoDate := VarScheduleInsurancetoDate + ObjLoanRepaymentschedule."Monthly Insurance";
            until ObjLoanRepaymentschedule.Next = 0;
        end;

        //===================================================Actual Repayment to Date
        ObjLoanRepaymentschedule.Reset;
        ObjLoanRepaymentschedule.SetRange(ObjLoanRepaymentschedule."Loan No.", VarLoanNo);
        ObjLoanRepaymentschedule.SetFilter(ObjLoanRepaymentschedule."Principle Amount Paid", '<>%1', 0);
        if ObjLoanRepaymentschedule.FindSet then begin
            if ObjLoanRepaymentschedule."Repayment Date" <= WorkDate then begin
                repeat
                    VarActualPrincipletoDate := VarActualPrincipletoDate + ObjLoanRepaymentschedule."Principle Amount Paid";
                    VarActualInteresttoDate := VarActualInteresttoDate + ObjLoanRepaymentschedule."Interest Paid";
                    VarActualInsurancetoDate := VarActualInsurancetoDate + ObjLoanRepaymentschedule."Insurance Paid";
                until ObjLoanRepaymentschedule.Next = 0;
            end;
        end;


        //====================================================Get Loan Interest In Arrears
        ObjLoanRepaymentschedule.Reset;
        ObjLoanRepaymentschedule.SetCurrentkey(ObjLoanRepaymentschedule."Repayment Date");
        ObjLoanRepaymentschedule.SetRange(ObjLoanRepaymentschedule."Loan No.", VarLoanNo);
        ObjLoanRepaymentschedule.SetFilter(ObjLoanRepaymentschedule."Repayment Date", '<=%1', WorkDate);
        if ObjLoanRepaymentschedule.FindLast then begin
            VarLastInstalmentDueDate := ObjLoanRepaymentschedule."Repayment Date";
        end;

        if VarLastInstalmentDueDate < 20180110D then
            VarLastInstalmentDueDate := 20180110D;

        ObjLoanInterestAccrued.Reset;
        ObjLoanInterestAccrued.SetRange(ObjLoanInterestAccrued."Loan No", VarLoanNo);
        ObjLoanInterestAccrued.SetFilter(ObjLoanInterestAccrued."Posting Date", '<=%1', VarLastInstalmentDueDate);
        if ObjLoanInterestAccrued.FindSet then begin
            repeat
                VarTotalInterestAccrued := VarTotalInterestAccrued + ObjLoanInterestAccrued.Amount;
            until ObjLoanInterestAccrued.Next = 0;

        end;

        VarAmountinArrearsInterest := VarTotalInterestAccrued - VarInterestPaid;
        if VarAmountinArrearsInterest < 0 then
            VarAmountinArrearsInterest := 0;
        //====================================================Get Loan Interest In Arrears


        VarAmountinArrears := 0;

        //=================================Loan Principle
        if ObjLoans.Get(VarLoanNo) then begin
            ObjLoans.CalcFields(ObjLoans."Penalty Charged", ObjLoans."Penalty Paid", ObjLoans."Outstanding Balance");
            if ObjLoans."Outstanding Balance" > 0 then begin

                VarAmountinArrears := VarSchedulePrincipletoDate - VarActualPrincipletoDate;
                VarAmountinArrearsInsurance := VarScheduleInsurancetoDate - VarInsurancePaid;//VarActualInsurancetoDate;

                if VarAmountinArrears < 0 then begin
                    VarAmountinArrears := 0
                end;
            end;
        end;
        //=================================Loan Interest
        if VarAmountinArrearsInterest < 0 then begin
            VarAmountinArrearsInterest := 0
        end else
            VarAmountinArrearsInterest := VarAmountinArrearsInterest;

        //=================================Loan Insurance
        if VarAmountinArrearsInsurance < 0 then begin
            VarAmountinArrearsInsurance := 0
        end else
            VarAmountinArrearsInsurance := VarAmountinArrearsInsurance;


        if ObjLoans.Get(VarLoanNo) then begin
            ObjLoans.CalcFields(ObjLoans."Penalty Charged", ObjLoans."Penalty Paid", ObjLoans."Interest Due", ObjLoans."Interest Paid",
            ObjLoans."Penalty Paid Historical", ObjLoans."Interest Paid Historical");
            VarCurrOutstandingInterest := ObjLoans."Interest Due" - (ObjLoans."Interest Paid" + ObjLoans."Interest Paid Historical");
            if VarCurrOutstandingInterest < 0 then
                VarCurrOutstandingInterest := 0;

            VarOutstandingPenalty := ObjLoans."Penalty Charged" - (ObjLoans."Penalty Paid" + ObjLoans."Penalty Paid Historical");
            if VarOutstandingPenalty < 0 then
                VarOutstandingPenalty := 0;

            VarTotalLoanDueAmount := VarAmountinArrears + VarAmountinArrearsInterest + VarAmountinArrearsInsurance + VarOutstandingPenalty;
            if VarTotalLoanDueAmount < 1 then
                VarTotalLoanDueAmount := 0;

            ObjLoans."Current Principle Due" := VarAmountinArrears;
            ObjLoans."Current Interest Due" := VarAmountinArrearsInterest;
            ObjLoans."Current Insurance Due" := VarAmountinArrearsInsurance;
            ObjLoans."Current Penalty Due" := VarOutstandingPenalty;
            ObjLoans."Loan Amount Due" := VarTotalLoanDueAmount;
            ObjLoans.Modify;
        end;


        exit(VarTotalLoanDueAmount);
    end;


    procedure FnRunSplitString(Text: Text[250]; Separator: Text[50]) TokenI: Text[100]
    var
        Pos: Integer;
        Token: Text[100];
    begin
        Pos := StrPos(Text, Separator);
        if Pos > 0 then begin
            Token := CopyStr(Text, 1, Pos - 1);
            if Pos + 1 <= StrLen(Text) then
                Text := CopyStr(Text, Pos + 1)
            else
                Text := '';
        end else begin
            Token := Text;
            Text := '';
        end;

        TokenI := Token;
        exit(TokenI);
    end;


    procedure FnRunLoanAmountDuePayroll(VarLoanNo: Code[20]) VarTotalLoanDueAmount: Decimal
    var
        ObjLoanRepaymentschedule: Record "Loan Repayment Schedule";
        ObjLoans: Record "Loans Register";
        VarPrinciplePaid: Decimal;
        VarAmountRemaining: Decimal;
        VarAmountAllocated: Decimal;
        VarDateFilter: Text;
        VarSchedulePrincipletoDate: Decimal;
        VarActualPrincipletoDate: Decimal;
        VarAmountinArrears: Decimal;
        VarNoofDaysinArrears: Integer;
        VarInterestPaid: Decimal;
        VarInsurancePaid: Decimal;
        VarAmountRemainingInterest: Decimal;
        VarAmountRemainingInsurance: Decimal;
        VarAmountAllocatedInterest: Decimal;
        VarAmountAllocatedInsurance: Decimal;
        VarScheduleInteresttoDate: Decimal;
        VarActualInteresttoDate: Decimal;
        VarScheduleInsurancetoDate: Decimal;
        VarActualInsurancetoDate: Decimal;
        VarAmountinArrearsInterest: Decimal;
        VarAmountinArrearsInsurance: Decimal;
        VarOutstandingPenalty: Decimal;
        VarLastInstalmentDueDate: Date;
        ObjLoanInterestAccrued: Record "Interest Due Ledger Entry";
        VarTotalInterestAccrued: Decimal;
        VarEndMonthDate: Date;
    begin
        VarAmountRemaining := 0;
        VarAmountAllocated := 0;
        VarEndMonthDate := CalcDate('CM', WorkDate);

        //=================================================Initialize amounts Paid on the Schedule
        ObjLoanRepaymentschedule.Reset;
        ObjLoanRepaymentschedule.SetRange(ObjLoanRepaymentschedule."Loan No.", VarLoanNo);
        if ObjLoanRepaymentschedule.FindSet then begin
            repeat
                ObjLoanRepaymentschedule."Principle Amount Paid" := 0;
                ObjLoanRepaymentschedule."Interest Paid" := 0;
                ObjLoanRepaymentschedule."Insurance Paid" := 0;
                ObjLoanRepaymentschedule.Modify;
            until ObjLoanRepaymentschedule.Next = 0;
        end;
        //=================================================End Initialize amounts Paid on the Schedule

        ObjLoans.Reset;
        ObjLoans.SetRange(ObjLoans."Loan  No.", VarLoanNo);
        if ObjLoans.FindSet then begin
            ObjLoans.CalcFields(ObjLoans."Principle Paid to Date", ObjLoans."Loan Insurance Paid", ObjLoans."Interest Paid", ObjLoans."Principle Paid Historical",
            ObjLoans."Interest Paid Historical", ObjLoans."Penalty Paid Historical", ObjLoans."Insurance Paid Historical");
            VarPrinciplePaid := ((ObjLoans."Principle Paid to Date" + ObjLoans."Principle Paid Historical") * -1);
            VarInterestPaid := (ObjLoans."Interest Paid" + ObjLoans."Interest Paid Historical");
            VarInsurancePaid := ((ObjLoans."Loan Insurance Paid" * -1) + ObjLoans."Insurance Paid Historical");
        end;

        VarAmountRemaining := VarPrinciplePaid;
        VarAmountRemainingInterest := VarInterestPaid;
        VarAmountRemainingInsurance := VarInsurancePaid;


        //====================================================Loan Principle
        ObjLoanRepaymentschedule.Reset;
        ObjLoanRepaymentschedule.SetRange(ObjLoanRepaymentschedule."Loan No.", VarLoanNo);
        if ObjLoanRepaymentschedule.FindSet then begin
            repeat
                if VarAmountRemaining > 0 then begin
                    if VarAmountRemaining >= ObjLoanRepaymentschedule."Principal Repayment" then begin
                        VarAmountAllocated := ObjLoanRepaymentschedule."Principal Repayment"
                    end;

                    if VarAmountRemaining < ObjLoanRepaymentschedule."Principal Repayment" then begin
                        VarAmountAllocated := VarAmountRemaining;
                    end;

                    ObjLoanRepaymentschedule."Principle Amount Paid" := VarAmountAllocated;
                    ObjLoanRepaymentschedule.Modify;
                    VarAmountRemaining := VarAmountRemaining - VarAmountAllocated;
                end;
            until ObjLoanRepaymentschedule.Next = 0;
        end;

        //====================================================Loan Interest
        ObjLoanRepaymentschedule.Reset;
        ObjLoanRepaymentschedule.SetRange(ObjLoanRepaymentschedule."Loan No.", VarLoanNo);
        if ObjLoanRepaymentschedule.FindSet then begin
            repeat
                if VarAmountRemainingInterest > 0 then begin

                    if VarAmountRemainingInterest >= ObjLoanRepaymentschedule."Monthly Interest" then begin
                        VarAmountAllocatedInterest := ObjLoanRepaymentschedule."Monthly Interest"
                    end;

                    if VarAmountRemainingInterest < ObjLoanRepaymentschedule."Monthly Interest" then begin
                        VarAmountAllocatedInterest := VarAmountRemainingInterest;
                    end;

                    ObjLoanRepaymentschedule."Interest Paid" := VarAmountAllocatedInterest;
                    ObjLoanRepaymentschedule.Modify;
                    VarAmountRemainingInterest := VarAmountRemainingInterest - VarAmountAllocatedInterest;
                end;
            until ObjLoanRepaymentschedule.Next = 0;
        end;




        //====================================================Loan Insurance
        ObjLoanRepaymentschedule.Reset;
        ObjLoanRepaymentschedule.SetRange(ObjLoanRepaymentschedule."Loan No.", VarLoanNo);
        if ObjLoanRepaymentschedule.FindSet then begin
            repeat
                if VarAmountRemainingInsurance > 0 then begin
                    if VarAmountRemainingInsurance >= ObjLoanRepaymentschedule."Monthly Insurance" then begin
                        VarAmountAllocatedInsurance := ObjLoanRepaymentschedule."Monthly Insurance"
                    end;

                    if VarAmountRemainingInsurance < ObjLoanRepaymentschedule."Monthly Insurance" then begin
                        VarAmountAllocatedInsurance := VarAmountRemainingInsurance;
                    end;

                    ObjLoanRepaymentschedule."Insurance Paid" := VarAmountAllocatedInsurance;
                    ObjLoanRepaymentschedule.Modify;
                    VarAmountRemainingInsurance := VarAmountRemainingInsurance - VarAmountAllocatedInsurance;
                end;
            until ObjLoanRepaymentschedule.Next = 0;
        end;

        VarDateFilter := '..' + Format(WorkDate);

        //===================================================Scheduled Repayment to Date
        ObjLoanRepaymentschedule.Reset;
        ObjLoanRepaymentschedule.SetRange(ObjLoanRepaymentschedule."Loan No.", VarLoanNo);
        ObjLoanRepaymentschedule.SetFilter(ObjLoanRepaymentschedule."Repayment Date", '<=%1', VarEndMonthDate);
        if ObjLoanRepaymentschedule.FindSet then begin
            repeat
                VarSchedulePrincipletoDate := VarSchedulePrincipletoDate + ObjLoanRepaymentschedule."Principal Repayment";
                VarScheduleInteresttoDate := VarScheduleInteresttoDate + ObjLoanRepaymentschedule."Monthly Interest";
                VarScheduleInsurancetoDate := VarScheduleInsurancetoDate + ObjLoanRepaymentschedule."Monthly Insurance";
            until ObjLoanRepaymentschedule.Next = 0;
        end;

        //===================================================Actual Repayment to Date
        ObjLoanRepaymentschedule.Reset;
        ObjLoanRepaymentschedule.SetRange(ObjLoanRepaymentschedule."Loan No.", VarLoanNo);
        ObjLoanRepaymentschedule.SetFilter(ObjLoanRepaymentschedule."Principle Amount Paid", '<>%1', 0);
        if ObjLoanRepaymentschedule.FindSet then begin
            if ObjLoanRepaymentschedule."Repayment Date" < VarEndMonthDate then begin
                repeat
                    VarActualPrincipletoDate := VarActualPrincipletoDate + ObjLoanRepaymentschedule."Principle Amount Paid";
                    VarActualInteresttoDate := VarActualInteresttoDate + ObjLoanRepaymentschedule."Interest Paid";
                    VarActualInsurancetoDate := VarActualInsurancetoDate + ObjLoanRepaymentschedule."Insurance Paid";
                until ObjLoanRepaymentschedule.Next = 0;
            end;
        end;
        //====================================================Get Loan Interest In Arrears

        ObjLoanRepaymentschedule.Reset;
        ObjLoanRepaymentschedule.SetCurrentkey(ObjLoanRepaymentschedule."Repayment Date");
        ObjLoanRepaymentschedule.SetRange(ObjLoanRepaymentschedule."Loan No.", VarLoanNo);
        ObjLoanRepaymentschedule.SetFilter(ObjLoanRepaymentschedule."Repayment Date", '<=%1', VarEndMonthDate);
        if ObjLoanRepaymentschedule.FindLast then begin
            VarLastInstalmentDueDate := ObjLoanRepaymentschedule."Repayment Date";
        end;

        if VarLastInstalmentDueDate < 20180110D then
            VarLastInstalmentDueDate := 20180110D;

        ObjLoanInterestAccrued.Reset;
        ObjLoanInterestAccrued.SetRange(ObjLoanInterestAccrued."Loan No", VarLoanNo);
        ObjLoanInterestAccrued.SetFilter(ObjLoanInterestAccrued."Posting Date", '<=%1', VarLastInstalmentDueDate);
        if ObjLoanInterestAccrued.FindSet then begin
            repeat
                VarTotalInterestAccrued := VarTotalInterestAccrued + ObjLoanInterestAccrued.Amount;
            until ObjLoanInterestAccrued.Next = 0;

        end;

        VarAmountinArrearsInterest := VarTotalInterestAccrued - VarInterestPaid;
        if VarAmountinArrearsInterest < 0 then
            VarAmountinArrearsInterest := 0;
        //====================================================Get Loan Interest In Arrears


        VarAmountinArrears := 0;

        //=================================Loan Principle
        if ObjLoans.Get(VarLoanNo) then begin
            ObjLoans.CalcFields(ObjLoans."Penalty Charged", ObjLoans."Penalty Paid", ObjLoans."Outstanding Balance");
            if ObjLoans."Outstanding Balance" > 0 then begin

                VarAmountinArrears := VarSchedulePrincipletoDate - VarActualPrincipletoDate;
                VarAmountinArrearsInsurance := VarScheduleInsurancetoDate - VarActualInsurancetoDate;

                if VarAmountinArrears < 0 then begin
                    VarAmountinArrears := 0
                end;
            end;
        end;
        //=================================Loan Interest
        if VarAmountinArrearsInterest < 0 then begin
            VarAmountinArrearsInterest := 0
        end else
            VarAmountinArrearsInterest := VarAmountinArrearsInterest;

        //=================================Loan Insurance
        if VarAmountinArrearsInsurance < 0 then begin
            VarAmountinArrearsInsurance := 0
        end else
            VarAmountinArrearsInsurance := VarAmountinArrearsInsurance;



        if ObjLoans.Get(VarLoanNo) then begin
            ObjLoans.CalcFields(ObjLoans."Penalty Charged", ObjLoans."Penalty Paid", ObjLoans."Penalty Paid Historical");

            VarOutstandingPenalty := ObjLoans."Penalty Charged" - (ObjLoans."Penalty Paid" + ObjLoans."Penalty Paid Historical");
            if VarOutstandingPenalty < 0 then
                VarOutstandingPenalty := 0;

            VarTotalLoanDueAmount := VarAmountinArrears + VarAmountinArrearsInterest + VarAmountinArrearsInsurance + VarOutstandingPenalty;

            ObjLoans."Current Principle Due" := VarAmountinArrears;
            ObjLoans."Current Interest Due" := VarAmountinArrearsInterest;
            ObjLoans."Current Insurance Due" := VarAmountinArrearsInsurance;
            ObjLoans."Current Penalty Due" := VarOutstandingPenalty;
            ObjLoans.Modify;
        end;
        exit(VarTotalLoanDueAmount);
    end;


    procedure FnGetLoanArrearsAmountReport(VarLoanNo: Code[20]; VarReportDate: Date; var VarArrearsAmountOutput: Decimal; var VarArrearsDaysOutput: Integer)
    var
        ObjLoanRepaymentschedule: Record "Loan Repayment Schedule Temp";
        ObjLoans: Record "Loans Register";
        VarPrinciplePaid: Decimal;
        VarAmountRemaining: Decimal;
        VarAmountAllocated: Decimal;
        VarDateFilter: Text;
        VarSchedulePrincipletoDate: Decimal;
        VarActualPrincipletoDate: Decimal;
        VarAmountinArrears: Decimal;
        VarNoofDaysinArrears: Integer;
        VarInterestPaid: Decimal;
        VarInsurancePaid: Decimal;
        VarAmountRemainingInterest: Decimal;
        VarAmountRemainingInsurance: Decimal;
        VarAmountAllocatedInterest: Decimal;
        VarAmountAllocatedInsurance: Decimal;
        VarScheduleInteresttoDate: Decimal;
        VarActualInteresttoDate: Decimal;
        VarScheduleInsurancetoDate: Decimal;
        VarActualInsurancetoDate: Decimal;
        VarAmountinArrearsInterest: Decimal;
        VarAmountinArrearsInsurance: Decimal;
        VarOutstandingPenalty: Decimal;
        VarLastInstalmentDueDate: Date;
        ObjLoanInterestAccrued: Record "Interest Due Ledger Entry";
        VarTotalInterestAccrued: Decimal;
        VarRoundedArrears: Decimal;
    begin
        VarAmountRemaining := 0;
        VarAmountAllocated := 0;
        //VarAmountRemainingInterest:=0;
        //VarAmountRemainingInsurance:=0;

        //=================================================Initialize amounts Paid on the Schedule
        ObjLoanRepaymentschedule.Reset;
        ObjLoanRepaymentschedule.SetRange(ObjLoanRepaymentschedule."Loan No.", VarLoanNo);
        if ObjLoanRepaymentschedule.FindSet then begin
            repeat
                ObjLoanRepaymentschedule."Principle Amount Paid" := 0;
                ObjLoanRepaymentschedule."Interest Paid" := 0;
                ObjLoanRepaymentschedule."Insurance Paid" := 0;
                ObjLoanRepaymentschedule."Instalment Fully Settled" := false;
                ObjLoanRepaymentschedule.Modify;
            until ObjLoanRepaymentschedule.Next = 0;
        end;
        //=================================================End Initialize amounts Paid on the Schedule

        VarDateFilter := '..' + Format(VarReportDate);
        ObjLoans.Reset;
        ObjLoans.SetRange(ObjLoans."Loan  No.", VarLoanNo);
        if ObjLoans.FindSet then begin
            ObjLoans.CalcFields(ObjLoans."Principle Paid to Date", ObjLoans."Loan Insurance Paid", ObjLoans."Interest Paid", ObjLoans."Principle Paid Historical",
            ObjLoans."Interest Paid Historical", ObjLoans."Penalty Paid Historical", ObjLoans."Insurance Paid Historical");
            VarPrinciplePaid := ((ObjLoans."Principle Paid to Date" + ObjLoans."Principle Paid Historical") * -1);
            VarInterestPaid := (ObjLoans."Interest Paid" + ObjLoans."Interest Paid Historical");
            VarInsurancePaid := ((ObjLoans."Loan Insurance Paid" * -1) + ObjLoans."Insurance Paid Historical");
        end;

        VarAmountRemaining := VarPrinciplePaid;
        VarAmountRemainingInterest := VarInterestPaid;
        VarAmountRemainingInsurance := VarInsurancePaid;


        //====================================================Loan Principle
        ObjLoanRepaymentschedule.Reset;
        ObjLoanRepaymentschedule.SetRange(ObjLoanRepaymentschedule."Loan No.", VarLoanNo);
        if ObjLoanRepaymentschedule.FindSet then begin
            repeat
                if VarAmountRemaining > 0 then begin
                    if VarAmountRemaining >= ObjLoanRepaymentschedule."Principal Repayment" then begin
                        VarAmountAllocated := ObjLoanRepaymentschedule."Principal Repayment";
                        ObjLoanRepaymentschedule."Instalment Fully Settled" := true;
                        ObjLoanRepaymentschedule.Modify;
                    end;

                    if VarAmountRemaining < ObjLoanRepaymentschedule."Principal Repayment" then begin
                        VarAmountAllocated := VarAmountRemaining;
                    end;

                    ObjLoanRepaymentschedule."Principle Amount Paid" := VarAmountAllocated;
                    ObjLoanRepaymentschedule.Modify;
                    VarAmountRemaining := VarAmountRemaining - VarAmountAllocated;
                end;
            until ObjLoanRepaymentschedule.Next = 0;
        end;

        //====================================================Loan Interest
        ObjLoanRepaymentschedule.Reset;
        ObjLoanRepaymentschedule.SetRange(ObjLoanRepaymentschedule."Loan No.", VarLoanNo);
        if ObjLoanRepaymentschedule.FindSet then begin
            repeat
                if VarAmountRemainingInterest > 0 then begin

                    if VarAmountRemainingInterest >= ObjLoanRepaymentschedule."Monthly Interest" then begin
                        VarAmountAllocatedInterest := ObjLoanRepaymentschedule."Monthly Interest"
                    end;

                    if VarAmountRemainingInterest < ObjLoanRepaymentschedule."Monthly Interest" then begin
                        VarAmountAllocatedInterest := VarAmountRemainingInterest;
                    end;

                    ObjLoanRepaymentschedule."Interest Paid" := VarAmountAllocatedInterest;
                    ObjLoanRepaymentschedule.Modify;
                    VarAmountRemainingInterest := VarAmountRemainingInterest - VarAmountAllocatedInterest;
                end;
            until ObjLoanRepaymentschedule.Next = 0;
        end;




        //====================================================Loan Insurance
        ObjLoanRepaymentschedule.Reset;
        ObjLoanRepaymentschedule.SetRange(ObjLoanRepaymentschedule."Loan No.", VarLoanNo);
        if ObjLoanRepaymentschedule.FindSet then begin
            repeat
                if VarAmountRemainingInsurance > 0 then begin
                    if VarAmountRemainingInsurance >= ObjLoanRepaymentschedule."Monthly Insurance" then begin
                        VarAmountAllocatedInsurance := ObjLoanRepaymentschedule."Monthly Insurance"
                    end;

                    if VarAmountRemainingInsurance < ObjLoanRepaymentschedule."Monthly Insurance" then begin
                        VarAmountAllocatedInsurance := VarAmountRemainingInsurance;
                    end;

                    ObjLoanRepaymentschedule."Insurance Paid" := VarAmountAllocatedInsurance;
                    ObjLoanRepaymentschedule.Modify;
                    VarAmountRemainingInsurance := VarAmountRemainingInsurance - VarAmountAllocatedInsurance;
                end;
            until ObjLoanRepaymentschedule.Next = 0;
        end;



        //===================================================Scheduled Repayment to Date
        ObjLoanRepaymentschedule.Reset;
        ObjLoanRepaymentschedule.SetRange(ObjLoanRepaymentschedule."Loan No.", VarLoanNo);
        ObjLoanRepaymentschedule.SetFilter(ObjLoanRepaymentschedule."Repayment Date", '<=%1', VarReportDate);
        if ObjLoanRepaymentschedule.FindSet then begin
            repeat
                VarSchedulePrincipletoDate := VarSchedulePrincipletoDate + ObjLoanRepaymentschedule."Principal Repayment";
                VarScheduleInteresttoDate := VarScheduleInteresttoDate + ObjLoanRepaymentschedule."Monthly Interest";
                VarScheduleInsurancetoDate := VarScheduleInsurancetoDate + ObjLoanRepaymentschedule."Monthly Insurance";
            until ObjLoanRepaymentschedule.Next = 0;
        end;

        //===================================================Actual Repayment to Date
        ObjLoanRepaymentschedule.Reset;
        ObjLoanRepaymentschedule.SetRange(ObjLoanRepaymentschedule."Loan No.", VarLoanNo);
        ObjLoanRepaymentschedule.SetFilter(ObjLoanRepaymentschedule."Principle Amount Paid", '<>%1', 0);
        if ObjLoanRepaymentschedule.FindSet then begin
            if ObjLoanRepaymentschedule."Repayment Date" <= VarReportDate then begin
                repeat
                    VarActualPrincipletoDate := VarActualPrincipletoDate + ObjLoanRepaymentschedule."Principle Amount Paid";
                    VarActualInteresttoDate := VarActualInteresttoDate + ObjLoanRepaymentschedule."Interest Paid";
                    VarActualInsurancetoDate := VarActualInsurancetoDate + ObjLoanRepaymentschedule."Insurance Paid";
                until ObjLoanRepaymentschedule.Next = 0;
            end;
        end;


        //====================================================Get Loan Interest In Arrears
        ObjLoanRepaymentschedule.Reset;
        ObjLoanRepaymentschedule.SetCurrentkey(ObjLoanRepaymentschedule."Repayment Date");
        ObjLoanRepaymentschedule.SetRange(ObjLoanRepaymentschedule."Loan No.", VarLoanNo);
        ObjLoanRepaymentschedule.SetFilter(ObjLoanRepaymentschedule."Repayment Date", '<=%1', VarReportDate);
        if ObjLoanRepaymentschedule.FindLast then begin
            VarLastInstalmentDueDate := ObjLoanRepaymentschedule."Repayment Date";
        end;

        if VarLastInstalmentDueDate < 20180110D then
            VarLastInstalmentDueDate := 20180110D;

        ObjLoanInterestAccrued.Reset;
        ObjLoanInterestAccrued.SetRange(ObjLoanInterestAccrued."Loan No", VarLoanNo);
        ObjLoanInterestAccrued.SetFilter(ObjLoanInterestAccrued."Posting Date", '<=%1', VarLastInstalmentDueDate);
        if ObjLoanInterestAccrued.FindSet then begin
            repeat
                VarTotalInterestAccrued := VarTotalInterestAccrued + ObjLoanInterestAccrued.Amount;
            until ObjLoanInterestAccrued.Next = 0;
        end;

        VarAmountinArrearsInterest := VarTotalInterestAccrued - VarInterestPaid;
        if VarAmountinArrearsInterest < 0 then
            VarAmountinArrearsInterest := 0;
        //====================================================Get Loan Interest In Arrears

        VarAmountinArrears := 0;

        //=================================Loan Principle


        if ObjLoans.Get(VarLoanNo) then begin
            ObjLoans.CalcFields(ObjLoans."Penalty Charged", ObjLoans."Penalty Paid", ObjLoans."Outstanding Balance");
            if ObjLoans."Outstanding Balance" > 0 then begin
                VarAmountinArrears := VarSchedulePrincipletoDate - VarActualPrincipletoDate;
                VarAmountinArrearsInsurance := VarScheduleInsurancetoDate - VarActualInsurancetoDate;
                if VarAmountinArrears < 0 then begin
                    VarAmountinArrears := 0
                end;
            end;
        end;
        //=================================Loan Interest
        if VarAmountinArrearsInterest < 0 then begin
            VarAmountinArrearsInterest := 0
        end else
            VarAmountinArrearsInterest := VarAmountinArrearsInterest;

        //=================================Loan Insurance
        if VarAmountinArrearsInsurance < 0 then begin
            VarAmountinArrearsInsurance := 0
        end else
            VarAmountinArrearsInsurance := VarAmountinArrearsInsurance;

        //=================================Loan Principle
        ObjLoanRepaymentschedule.CalcFields("Cummulative Principle Paid");
        ObjLoanRepaymentschedule.Reset;
        ObjLoanRepaymentschedule.SetCurrentkey(ObjLoanRepaymentschedule."Repayment Date");
        ObjLoanRepaymentschedule.SetRange(ObjLoanRepaymentschedule."Loan No.", VarLoanNo);
        ObjLoanRepaymentschedule.SetFilter(ObjLoanRepaymentschedule."Repayment Date", '<=%1', VarLastInstalmentDueDate);
        ObjLoanRepaymentschedule.SetRange(ObjLoanRepaymentschedule."Instalment Fully Settled", false);
        //ObjLoanRepaymentschedule.SETFILTER(ObjLoanRepaymentschedule."Principle Amount Paid",'<>%1',ObjLoanRepaymentschedule."Principal Repayment");
        if ObjLoanRepaymentschedule.FindFirst then begin
            VarNoofDaysinArrears := VarReportDate - ObjLoanRepaymentschedule."Repayment Date"
        end;

        if VarNoofDaysinArrears < 0 then begin
            VarNoofDaysinArrears := 0
        end else
            VarNoofDaysinArrears := VarNoofDaysinArrears;



        if ObjLoans.Get(VarLoanNo) then begin
            ObjLoans.CalcFields(ObjLoans."Penalty Charged", ObjLoans."Penalty Paid", ObjLoans."Penalty Paid Historical", ObjLoans."Outstanding Balance");

            VarOutstandingPenalty := ObjLoans."Penalty Charged" - (ObjLoans."Penalty Paid" + ObjLoans."Penalty Paid Historical");
            if VarOutstandingPenalty < 0 then
                VarOutstandingPenalty := 0;


            VarRoundedArrears := VarAmountinArrears + VarAmountinArrearsInterest + VarAmountinArrearsInsurance + VarOutstandingPenalty;
            if VarRoundedArrears < 1 then
                VarRoundedArrears := 0;

            if ObjLoans."Outstanding Balance" < 1 then begin
                VarNoofDaysinArrears := 0;
                VarAmountinArrears := 0;
            end;

            if VarRoundedArrears = 0 then
                VarNoofDaysinArrears := 0;

            VarArrearsAmountOutput := ROUND(VarRoundedArrears, 0.01, '=');
            VarArrearsDaysOutput := VarNoofDaysinArrears;
        end;

    end;


    procedure FnUpdateLoanPortfolio(VarReportDate: Date)
    var
        ObjLoans: Record "Loans Register";
        ObLoansII: Record "Loans Register";
        ObjLoanPortfolio: Record "Loan Portfolio Provision";
        VarDateFilter: Text;
        SFactory: Codeunit "SURESTEP Factory";
        VarClassification: Option Perfoming,Watch,Substandard,Doubtful,Loss;
        VarPerformingAmount: Decimal;
        VarWatchAmount: Decimal;
        VarSubstandardAmount: Decimal;
        VarDoubtfulAmount: Decimal;
        VarLossAmount: Decimal;
        VarArrearsAmount: Decimal;
        VarArrearsDays: Integer;
        VarMemberAge: Integer;
        VarAge: Integer;
        VarAge2: Integer;
        ObjAccount: Record Vendor;
        VarHouseGroup: Text;
    begin

        ObjLoanPortfolio.Reset;
        ObjLoanPortfolio.SetRange(ObjLoanPortfolio."Report Date", VarReportDate);
        if ObjLoanPortfolio.Find('-') = false then begin
            VarDateFilter := '..' + Format(VarReportDate);
            ObjLoans.CalcFields(ObjLoans."Outstanding Balance");
            ObjLoans.Reset;
            ObjLoans.SetFilter(ObjLoans."Date filter", VarDateFilter);
            ObjLoans.SetFilter(ObjLoans."Outstanding Balance", '<%1|>%2', -1, 1);
            if ObjLoans.Find('-') then begin
                repeat
                    VarPerformingAmount := 0;
                    VarWatchAmount := 0;
                    VarSubstandardAmount := 0;
                    VarDoubtfulAmount := 0;
                    VarLossAmount := 0;

                    FnGetLoanArrearsAmountReport(ObjLoans."Loan  No.", VarReportDate, VarArrearsAmount, VarArrearsDays);
                    FnRunLoanAmountDue(ObjLoans."Loan  No.");

                    ObjLoans.CalcFields(ObjLoans."Outstanding Balance");

                    if (VarArrearsDays = 0) then begin
                        VarClassification := Varclassification::Perfoming;
                        VarPerformingAmount := ObjLoans."Outstanding Balance";
                    end else
                        if (VarArrearsDays > 0) and (VarArrearsDays <= 30) then begin
                            VarClassification := Varclassification::Watch;
                            VarWatchAmount := ObjLoans."Outstanding Balance";
                        end else
                            if (VarArrearsDays >= 31) and (VarArrearsDays <= 180) then begin
                                VarClassification := Varclassification::Substandard;
                                VarSubstandardAmount := ObjLoans."Outstanding Balance";
                            end else
                                if (VarArrearsDays >= 181) and (VarArrearsDays <= 360) then begin
                                    VarDoubtfulAmount := ObjLoans."Outstanding Balance";
                                    VarClassification := Varclassification::Doubtful;
                                end else
                                    if (VarArrearsDays > 360) then begin
                                        VarClassification := Varclassification::Loss;
                                        VarLossAmount := ObjLoans."Outstanding Balance"
                                    end;

                    //===============================================================Insert Member Age
                    if ObjMembers.Get(ObjLoans."Client Code") then begin
                        if ObjMembers."Date of Birth" <> 0D then begin
                            VarAge := VarReportDate - ObjMembers."Date of Birth"; //Returns number of days old
                            VarAge2 := ROUND((VarAge / 365.2364), 1, '<');  //Returns number of years old as Decimal - Takes into Account Leap Years
                            VarMemberAge := VarAge2;
                        end;
                    end;

                    ObjLoanPortfolio.Init;
                    ObjLoanPortfolio."Loan No" := ObjLoans."Loan  No.";
                    ObjLoanPortfolio."Member No" := ObjLoans."Client Code";
                    ObjLoanPortfolio."Member Name" := ObjLoans."Client Name";
                    ObjLoanPortfolio."Outstanding Balance" := ObjLoans."Outstanding Balance";
                    ObjLoanPortfolio."Arrears Amount" := VarArrearsAmount;
                    ObjLoanPortfolio."Arrears Days" := VarArrearsDays;
                    ObjLoanPortfolio.Classification := VarClassification;
                    ObjLoanPortfolio.Performing := VarPerformingAmount;
                    ObjLoanPortfolio.Watch := VarWatchAmount;
                    ObjLoanPortfolio.Substandard := VarSubstandardAmount;
                    ObjLoanPortfolio.Doubtful := VarDoubtfulAmount;
                    ObjLoanPortfolio.Loss := VarLossAmount;
                    ObjLoanPortfolio."Report Date" := VarReportDate;
                    ObjLoanPortfolio.Rescheduled := ObjLoans.Rescheduled;
                    ObjLoanPortfolio."Member Age" := VarMemberAge;
                    ObjLoanPortfolio."Loan Product Code" := ObjLoans."Loan Product Type";
                    ObjLoanPortfolio."Branch Code" := ObjLoans."Branch Code";
                    ObjLoanPortfolio."Group Code" := ObjLoans."Member House Group";
                    ObjLoanPortfolio.Insert;

                until ObjLoans.Next = 0;
            end;


            //Update Over Draft on Loan Portoflio
            ObjAccount.CalcFields(ObjAccount.Balance);
            ObjAccount.Reset;
            ObjAccount.SetRange(ObjAccount."Account Type", '406');
            //ObjAccount.SETFILTER(ObjAccount."Account Creation Date",'<=%1',VarReportDate);
            ObjAccount.SetFilter(ObjAccount."Date Filter", VarDateFilter);
            ObjAccount.SetFilter(ObjAccount.Balance, '<%1|>%1', -1, 1);
            if ObjAccount.Find('-') then begin
                repeat
                    VarPerformingAmount := 0;
                    VarWatchAmount := 0;
                    VarSubstandardAmount := 0;
                    VarDoubtfulAmount := 0;
                    VarLossAmount := 0;

                    ObjAccount.CalcFields(ObjAccount.Balance);

                    if (ObjAccount."Over Draft Limit Expiry Date" <> 0D) and (ObjAccount."Over Draft Limit Expiry Date" < VarReportDate) and (ObjAccount.Balance < 0) then begin
                        VarArrearsDays := VarReportDate - ObjAccount."Over Draft Limit Expiry Date";
                        VarArrearsAmount := ObjAccount.Balance * -1;
                    end else begin
                        VarArrearsDays := 0;
                        VarArrearsAmount := 0;
                    end;

                    if (VarArrearsDays = 0) then begin
                        VarClassification := Varclassification::Perfoming;
                        VarPerformingAmount := ObjAccount.Balance * -1;
                    end else
                        if (VarArrearsDays > 0) and (VarArrearsDays <= 30) then begin
                            VarClassification := Varclassification::Watch;
                            VarWatchAmount := ObjAccount.Balance * -1;
                        end else
                            if (VarArrearsDays >= 31) and (VarArrearsDays <= 180) then begin
                                VarClassification := Varclassification::Substandard;
                                VarSubstandardAmount := ObjAccount.Balance * -1;
                            end else
                                if (VarArrearsDays >= 181) and (VarArrearsDays <= 360) then begin
                                    VarDoubtfulAmount := ObjAccount.Balance * -1;
                                    VarClassification := Varclassification::Doubtful;
                                end else
                                    if (VarArrearsDays > 360) then begin
                                        VarClassification := Varclassification::Loss;
                                        VarLossAmount := ObjAccount.Balance * -1;
                                    end;

                    //===============================================================Insert Member Age
                    if ObjMembers.Get(ObjAccount."BOSA Account No") then begin
                        if ObjMembers."Date of Birth" <> 0D then begin
                            VarAge := VarReportDate - ObjMembers."Date of Birth"; //Returns number of days old
                            VarAge2 := ROUND((VarAge / 365.2364), 1, '<');  //Returns number of years old as Decimal - Takes into Account Leap Years
                            VarMemberAge := VarAge2;
                            VarHouseGroup := ObjMembers."Member House Group"
                        end;

                        ObjLoanPortfolio.Init;
                        ObjLoanPortfolio."Loan No" := ObjAccount."No.";
                        ObjLoanPortfolio."Member No" := ObjAccount."BOSA Account No";
                        ObjLoanPortfolio."Member Name" := ObjAccount.Name;
                        ObjLoanPortfolio."Outstanding Balance" := ObjAccount.Balance * -1;
                        ObjLoanPortfolio."Arrears Amount" := VarArrearsAmount;
                        ObjLoanPortfolio."Arrears Days" := VarArrearsDays;
                        ObjLoanPortfolio.Classification := VarClassification;
                        ObjLoanPortfolio.Performing := VarPerformingAmount;
                        ObjLoanPortfolio.Watch := VarWatchAmount;
                        ObjLoanPortfolio.Substandard := VarSubstandardAmount;
                        ObjLoanPortfolio.Doubtful := VarDoubtfulAmount;
                        ObjLoanPortfolio.Loss := VarLossAmount;
                        ObjLoanPortfolio."Report Date" := VarReportDate;
                        ObjLoanPortfolio.Rescheduled := false;
                        ObjLoanPortfolio."Member Age" := VarMemberAge;
                        ObjLoanPortfolio."Loan Product Code" := ObjAccount."Account Type";
                        ObjLoanPortfolio."Branch Code" := ObjAccount."Global Dimension 2 Code";
                        ObjLoanPortfolio."Group Code" := VarHouseGroup;
                        ObjLoanPortfolio.Insert;
                    end;
                until ObjAccount.Next = 0;
            end;
        end;
    end;


    procedure FnGenerateLoanRepaymentSchedule(VarLoanNo: Code[30])
    var
        ObjLoans: Record "Loans Register";
        ObjRepaymentschedule: Record "Loan Repayment Schedule";
        ObjRepaymentscheduleTemp: Record "Loan Repayment Schedule Temp";
        ObjLoansII: Record "Loans Register";
        VarPeriodDueDate: Date;
        VarRunningDate: Date;
        VarGracePeiodEndDate: Date;
        VarInstalmentEnddate: Date;
        VarGracePerodDays: Integer;
        VarInstalmentDays: Integer;
        VarNoOfGracePeriod: Integer;
        VarLoanAmount: Decimal;
        VarInterestRate: Decimal;
        VarRepayPeriod: Integer;
        VarLBalance: Decimal;
        VarRunDate: Date;
        VarInstalNo: Decimal;
        VarRepayInterval: DateFormula;
        VarTotalMRepay: Decimal;
        VarLInterest: Decimal;
        VarLPrincipal: Decimal;
        VarLInsurance: Decimal;
        VarRepayCode: Code[40];
        VarGrPrinciple: Integer;
        VarGrInterest: Integer;
        VarQPrinciple: Decimal;
        VarQCounter: Integer;
        VarInPeriod: DateFormula;
        VarInitialInstal: Integer;
        VarInitialGraceInt: Integer;
        VarScheduleBal: Decimal;
        VarLNBalance: Decimal;
        ObjProductCharge: Record "Loan Product Charges";
        VarWhichDay: Integer;
        VarRepaymentStartDate: Date;
        VarMonthIncreament: Text;
        ScheduleEntryNo: Integer;
        ScheduleEntryNoTemp: Integer;
        LoanProductsSetup: Record "Loan Products Setup";
        VarApplicationFee: Decimal;

    begin
        //======================================================================================Normal Repayment Schedule
        ObjLoans.Reset;
        ObjLoans.SetRange(ObjLoans."Loan  No.", VarLoanNo);
        if ObjLoans.FindSet then
        //IF (ObjLoans.FINDSET) AND (ObjLoans.Installments+ObjLoans."Grace Period - Principle (M)" > 1) THEN
          begin
            if ObjLoans."Repayment Frequency" = ObjLoans."repayment frequency"::Daily then
                Evaluate(VarInPeriod, '1D')
            else
                if ObjLoans."Repayment Frequency" = ObjLoans."repayment frequency"::Weekly then
                    Evaluate(VarInPeriod, '1W')
                else
                    if ObjLoans."Repayment Frequency" = ObjLoans."repayment frequency"::Monthly then
                        Evaluate(VarInPeriod, '1M')
                    else
                        if ObjLoans."Repayment Frequency" = ObjLoans."repayment frequency"::Quaterly then
                            Evaluate(VarInPeriod, '1Q');

            VarRunDate := 0D;
            VarQCounter := 0;
            VarQCounter := 3;
            VarScheduleBal := 0;

            VarGrPrinciple := ObjLoans."Grace Period - Principle (M)";
            VarGrInterest := ObjLoans."Grace Period - Interest (M)";
            VarInitialGraceInt := ObjLoans."Grace Period - Interest (M)";


            ObjLoansII.Reset;
            ObjLoansII.SetRange(ObjLoansII."Loan  No.", VarLoanNo);
            if ObjLoansII.Find('-') then begin
                ObjLoansII.CalcFields(ObjLoansII."Outstanding Balance");

                ObjLoans.TestField(ObjLoans."Loan Disbursement Date");
                ObjLoans.TestField(ObjLoans."Repayment Start Date");

                //=================================================================Delete From Tables
                ObjRepaymentschedule.Reset;
                ObjRepaymentschedule.SetRange(ObjRepaymentschedule."Loan No.", VarLoanNo);
                ObjRepaymentschedule.DeleteAll;

                ObjRepaymentscheduleTemp.Reset;
                ObjRepaymentscheduleTemp.SetRange(ObjRepaymentscheduleTemp."Loan No.", VarLoanNo);
                ObjRepaymentscheduleTemp.DeleteAll;

                ObjRepaymentschedule.Reset;
                ObjRepaymentschedule.SetCurrentkey(ObjRepaymentschedule."Entry No");
                if ObjRepaymentschedule.FindLast then
                    ScheduleEntryNo := ObjRepaymentschedule."Entry No" + 1;

                ObjRepaymentscheduleTemp.Reset;
                ObjRepaymentscheduleTemp.SetCurrentkey(ObjRepaymentscheduleTemp."Entry No");
                if ObjRepaymentscheduleTemp.FindLast then
                    ScheduleEntryNoTemp := ObjRepaymentscheduleTemp."Entry No" + 1;


                if ObjLoansII.Get(VarLoanNo) then begin
                    if ObjLoansII."Tranch Amount Disbursed" <> 0 then
                        VarLoanAmount := ObjLoansII."Tranch Amount Disbursed" + ObjLoansII."Capitalized Charges"
                    else
                        VarLoanAmount := ObjLoansII."Approved Amount" + ObjLoansII."Capitalized Charges";
                    VarInterestRate := ObjLoansII.Interest;
                    VarRepayPeriod := ObjLoansII.Installments;
                    VarInitialInstal := ObjLoansII.Installments + ObjLoansII."Grace Period - Principle (M)";
                    VarLBalance := VarLoanAmount;
                    VarLNBalance := ObjLoansII."Outstanding Balance";
                    VarRunDate := ObjLoansII."Repayment Start Date";
                    VarRepaymentStartDate := ObjLoansII."Repayment Start Date";

                    VarInstalNo := 0;
                    Evaluate(VarRepayInterval, '1W');

                    repeat
                        VarInstalNo := VarInstalNo + 1;
                        VarScheduleBal := VarLBalance;
                        ScheduleEntryNo := ScheduleEntryNo + 1;
                        ScheduleEntryNoTemp := ScheduleEntryNoTemp + 1;

                        //=======================================================================================Amortised
                        if ObjLoans."Repayment Method" = ObjLoans."repayment method"::Amortised then begin
                            ObjLoans.TestField(ObjLoans.Installments);
                            ObjLoans.TestField(ObjLoans.Interest);
                            ObjLoans.TestField(ObjLoans.Installments);
                            VarTotalMRepay := ROUND((VarInterestRate / 12 / 100) / (1 - Power((1 + (VarInterestRate / 12 / 100)), -VarRepayPeriod)) * VarLoanAmount, 1, '>');
                            VarTotalMRepay := (VarInterestRate / 12 / 100) / (1 - Power((1 + (VarInterestRate / 12 / 100)), -VarRepayPeriod)) * VarLoanAmount;
                            VarLInterest := ROUND(VarLBalance / 100 / 12 * VarInterestRate);

                            VarLPrincipal := VarTotalMRepay - VarLInterest;

                            ObjProductCharge.Reset;
                            ObjProductCharge.SetRange(ObjProductCharge."Product Code", ObjLoans."Loan Product Type");
                            ObjProductCharge.SetRange(ObjProductCharge."Loan Charge Type", ObjProductCharge."loan charge type"::"Loan Insurance");
                            if ObjProductCharge.FindSet then begin
                                if ObjProductCharge."Use Perc" then begin
                                    VarLInsurance := ObjLoans."Approved Amount" * (ObjProductCharge.Percentage / 100);
                                end else
                                    VarLInsurance := ObjProductCharge.Amount;
                            end;

                            ObjProductCharge.Reset;
                            ObjProductCharge.SetRange(ObjProductCharge."Product Code", ObjLoans."Loan Product Type");
                            ObjProductCharge.SetRange(ObjProductCharge."Loan Charge Type", ObjProductCharge."loan charge type"::"Loan Insurance");
                            if ObjProductCharge.FindSet then begin
                                VarApplicationFee := ObjLoans."Approved Amount" * (ObjProductCharge.Percentage / 100);
                            end else
                                VarApplicationFee := ObjLoans."Application Fee";
                        end;

                        //=======================================================================================Strainght Line
                        if ObjLoans."Repayment Method" = ObjLoans."repayment method"::"Straight Line" then begin
                            ObjLoans.TestField(ObjLoans.Installments);
                            VarLPrincipal := ROUND(VarLoanAmount / VarRepayPeriod, 1, '>');
                            VarLInterest := ROUND((VarInterestRate / 1200) * VarLoanAmount, 1, '>');
                            if VarInstalNo - ObjLoans."Grace Period - Interest (M)" = 1 then
                                VarLInterest := VarLInterest * VarInstalNo;

                            ObjLoans.Repayment := VarLPrincipal + VarLInterest;
                            ObjLoans."Loan Principle Repayment" := VarLPrincipal;
                            ObjLoans."Loan Interest Repayment" := VarLInterest;
                            ObjLoans.Modify;

                            ObjProductCharge.Reset;
                            ObjProductCharge.SetRange(ObjProductCharge."Product Code", ObjLoans."Loan Product Type");
                            ObjProductCharge.SetRange(ObjProductCharge."Loan Charge Type", ObjProductCharge."loan charge type"::"Loan Insurance");
                            if ObjProductCharge.FindSet then begin
                                if ObjProductCharge."Use Perc" then begin
                                    VarLInsurance := ObjLoans."Approved Amount" * (ObjProductCharge.Percentage / 100);
                                end else
                                    VarLInsurance := ObjProductCharge.Amount;
                            end;

                            ObjProductCharge.Reset;
                            ObjProductCharge.SetRange(ObjProductCharge."Product Code", ObjLoans."Loan Product Type");
                            ObjProductCharge.SetRange(ObjProductCharge."Loan Charge Type", ObjProductCharge."loan charge type"::"Loan Application Fee");
                            if ObjProductCharge.FindSet then begin
                                VarApplicationFee := ObjLoans."Approved Amount" * (ObjProductCharge.Percentage / 100);
                            end else
                                VarApplicationFee := ObjLoans."Application Fee";
                        end;

                        //=======================================================================================Reducing Balance
                        if ObjLoans."Repayment Method" = ObjLoans."repayment method"::"Reducing Balance" then begin
                            ObjLoans.TestField(ObjLoans.Interest);
                            ObjLoans.TestField(ObjLoans.Installments);
                            VarLPrincipal := ROUND(VarLoanAmount / VarRepayPeriod, 1, '>');
                            VarLInterest := ROUND((VarInterestRate / 12 / 100) * VarLBalance, 1, '>');

                            ObjProductCharge.Reset;
                            ObjProductCharge.SetRange(ObjProductCharge."Product Code", ObjLoans."Loan Product Type");
                            ObjProductCharge.SetRange(ObjProductCharge."Loan Charge Type", ObjProductCharge."loan charge type"::"Loan Insurance");
                            if ObjProductCharge.FindSet then begin
                                if ObjProductCharge."Use Perc" then begin
                                    VarLInsurance := ObjLoans."Approved Amount" * (ObjProductCharge.Percentage / 100);
                                end else
                                    VarLInsurance := ObjProductCharge.Amount;
                            end;

                            ObjProductCharge.Reset;
                            ObjProductCharge.SetRange(ObjProductCharge."Product Code", ObjLoans."Loan Product Type");
                            ObjProductCharge.SetRange(ObjProductCharge."Loan Charge Type", ObjProductCharge."loan charge type"::"Loan Application Fee");
                            if ObjProductCharge.FindSet then begin
                                VarApplicationFee := ObjLoans."Approved Amount" * (ObjProductCharge.Percentage / 100);
                            end else
                                VarApplicationFee := ObjLoans."Application Fee";

                        end;

                        //=======================================================================================Constant
                        if ObjLoans."Repayment Method" = ObjLoans."repayment method"::Constants then begin
                            ObjLoans.TestField(ObjLoans.Repayment);
                            if VarLBalance < ObjLoans.Repayment then
                                VarLPrincipal := VarLBalance
                            else
                                VarLPrincipal := ObjLoans.Repayment;

                            VarLInterest := ObjLoans.Interest;

                            ObjProductCharge.Reset;
                            ObjProductCharge.SetRange(ObjProductCharge."Product Code", ObjLoans."Loan Product Type");
                            ObjProductCharge.SetRange(ObjProductCharge."Loan Charge Type", ObjProductCharge."loan charge type"::"Loan Insurance");
                            if ObjProductCharge.FindSet then begin
                                VarLInsurance := ObjLoans."Approved Amount" * (ObjProductCharge.Percentage / 100);
                            end;

                        end;

                        VarLPrincipal := ROUND(VarLPrincipal, 100, '>');
                        //======================================================================================Grace Period
                        if VarGrPrinciple > 0 then begin
                            VarLPrincipal := 0;
                            VarLInsurance := 0
                        end else begin
                            //IF ObjLoans."Instalment Period" <> VarInPeriod THEN
                            VarLBalance := VarLBalance - VarLPrincipal;
                            VarScheduleBal := VarScheduleBal - VarLPrincipal;
                        end;

                        if VarGrInterest > 0 then
                            VarLInterest := 0;

                        VarGrPrinciple := VarGrPrinciple - 1;
                        VarGrInterest := VarGrInterest - 1;

                        if LoanProductsSetup.Get(ObjLoans."Loan Product Type") then;
                        if LoanProductsSetup."Charge Interest Upfront" then VarLInterest := 0;

                        //======================================================================================Insert Repayment Schedule Table
                        if VarInstalNo <> 1 then begin
                            VarLInsurance := 0;
                            VarApplicationFee := 0;
                        end;
                        ObjRepaymentschedule.Init;
                        ObjRepaymentschedule."Entry No" := ScheduleEntryNo;
                        ObjRepaymentschedule."Repayment Code" := VarRepayCode;
                        ObjRepaymentschedule."Loan No." := ObjLoans."Loan  No.";
                        ObjRepaymentschedule."Loan Amount" := VarLoanAmount;
                        ObjRepaymentschedule."Instalment No" := VarInstalNo;
                        ObjRepaymentschedule."Repayment Date" := VarRunDate;//CALCDATE('CM',RunDate);
                        ObjRepaymentschedule."Member No." := ObjLoans."Client Code";
                        ObjRepaymentschedule."Application Fee" := VarApplicationFee;
                        ObjRepaymentschedule."Loan Category" := ObjLoans."Loan Product Type";
                        ObjRepaymentschedule."Monthly Repayment" := VarLInterest + VarLPrincipal + VarLInsurance + VarApplicationFee;
                        ObjRepaymentschedule."Monthly Interest" := VarLInterest;
                        ObjRepaymentschedule."Principal Repayment" := VarLPrincipal;
                        ObjRepaymentschedule."Monthly Insurance" := VarLInsurance;
                        ObjRepaymentschedule."Loan Balance" := VarLBalance;
                        ObjRepaymentschedule.Insert;
                        VarWhichDay := Date2dwy(ObjRepaymentschedule."Repayment Date", 1);

                        //======================================================================================Insert Repayment Schedule Temp Table
                        ObjRepaymentscheduleTemp.Init;
                        ObjRepaymentscheduleTemp."Entry No" := ScheduleEntryNoTemp;
                        ObjRepaymentscheduleTemp."Repayment Code" := VarRepayCode;
                        ObjRepaymentscheduleTemp."Loan No." := ObjLoans."Loan  No.";
                        ObjRepaymentscheduleTemp."Loan Amount" := VarLoanAmount;
                        ObjRepaymentscheduleTemp."Instalment No" := VarInstalNo;
                        ObjRepaymentscheduleTemp."Repayment Date" := VarRunDate;//CALCDATE('CM',RunDate);
                        ObjRepaymentscheduleTemp."Member No." := ObjLoans."Client Code";
                        ObjRepaymentscheduleTemp."Loan Category" := ObjLoans."Loan Product Type";
                        ObjRepaymentscheduleTemp."Monthly Repayment" := VarLInterest + VarLPrincipal + VarLInsurance;
                        ObjRepaymentscheduleTemp."Monthly Interest" := VarLInterest;
                        ObjRepaymentscheduleTemp."Principal Repayment" := VarLPrincipal;
                        ObjRepaymentscheduleTemp."Monthly Insurance" := VarLInsurance;
                        ObjRepaymentscheduleTemp."Loan Balance" := VarLBalance;
                        ObjRepaymentscheduleTemp.Insert;
                        VarWhichDay := Date2dwy(ObjRepaymentscheduleTemp."Repayment Date", 1);
                        ///Message('balance %1', (VarLBalance));
                        //Message('Linsurance%1', (VarLInsurance));
                        //=======================================================================Get Next Repayment Date
                        VarMonthIncreament := Format(VarInstalNo) + 'M';
                        if ObjLoans."Repayment Frequency" = ObjLoans."repayment frequency"::Daily then
                            VarRunDate := CalcDate('1D', VarRunDate)
                        else
                            if ObjLoans."Repayment Frequency" = ObjLoans."repayment frequency"::Weekly then
                                VarRunDate := CalcDate('1W', VarRunDate)
                            else
                                if ObjLoans."Repayment Frequency" = ObjLoans."repayment frequency"::Monthly then
                                    VarRunDate := CalcDate(VarMonthIncreament, VarRepaymentStartDate)
                                else
                                    if ObjLoans."Repayment Frequency" = ObjLoans."repayment frequency"::Quaterly then
                                        VarRunDate := CalcDate('1Q', VarRunDate);

                    until VarLBalance < 1
                end;
                Commit();
            end;
        end;


    end;


    procedure FnRunGetLoanPayoffAmountRestructure(VarLoanNo: Code[30]) VarLoanPayoffAmount: Decimal
    var
        ObjLoans: Record "Loans Register";
        VarInsurancePayoff: Decimal;
        ObjProductCharge: Record "Loan Product Charges";
        VarEndYear: Date;
        VarInsuranceMonths: Integer;
        VarAmountinArrears: Decimal;
        ObjRepaymentSchedule: Record "Loan Repayment Schedule";
        VarOutstandingInterest: Decimal;
        ObjLoanSchedule: Record "Loan Repayment Schedule";
        VarLoanInsuranceCharged: Decimal;
        VarLoanInsurancePaid: Decimal;
        VarOutstandingInsurance: Decimal;
        VarOutstandingPenalty: Decimal;
    begin
        ObjLoans.Reset;
        ObjLoans.SetRange(ObjLoans."Loan  No.", VarLoanNo);
        if ObjLoans.FindSet then begin
            ObjLoans.CalcFields(ObjLoans."Outstanding Balance", ObjLoans."Loan Insurance Paid", ObjLoans."Penalty Charged", ObjLoans."Penalty Paid", ObjLoans."Interest Due",
            ObjLoans."Interest Paid", ObjLoans."Interest Paid Historical", ObjLoans."Penalty Paid Historical", ObjLoans."Insurance Paid Historical", ObjLoans."Principle Paid Historical");





            //============================================================Loan Insurance Repayment
            ObjLoans.Reset;
            ObjLoans.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
            ObjLoans.SetRange(ObjLoans."Loan  No.", VarLoanNo);
            if ObjLoans.Find('-') then begin

                ObjLoans.Reset;
                ObjLoans.SetRange(ObjLoans."Loan  No.", VarLoanNo);
                if ObjLoans.FindSet then begin
                    ObjLoans.CalcFields(ObjLoans."Outstanding Balance", ObjLoans."Loan Insurance Paid", ObjLoans."Penalty Charged", ObjLoans."Penalty Paid", ObjLoans."Interest Due",
                    ObjLoans."Interest Paid", ObjLoans."Interest Paid Historical", ObjLoans."Penalty Paid Historical", ObjLoans."Insurance Paid Historical", ObjLoans."Principle Paid Historical");

                    if (ObjLoans."Outstanding Balance" <> 0) and (ObjLoans."Loan Status" = ObjLoans."loan status"::Disbursed) then begin
                        VarEndYear := CalcDate('CY', Today);

                        ObjLoanSchedule.Reset;
                        ObjLoanSchedule.SetRange(ObjLoanSchedule."Loan No.", VarLoanNo);
                        ObjLoanSchedule.SetFilter(ObjLoanSchedule."Repayment Date", '>%1&<=%2', WorkDate, VarEndYear);
                        if ObjLoanSchedule.FindSet then begin
                            ObjLoanSchedule.CalcSums(ObjLoanSchedule."Monthly Insurance");
                            VarInsurancePayoff := ObjLoanSchedule."Monthly Insurance";
                        end;
                    end;
                end;

                FnGetLoanArrearsAmountII(VarLoanNo);//===========================Get Amount In Arrears

                ObjLoanSchedule.Reset;
                ObjLoanSchedule.SetRange(ObjLoanSchedule."Loan No.", VarLoanNo);
                ObjLoanSchedule.SetFilter(ObjLoanSchedule."Repayment Date", '<=%1', WorkDate);
                if ObjLoanSchedule.FindSet then begin
                    repeat
                        VarLoanInsuranceCharged := VarLoanInsuranceCharged + ObjLoanSchedule."Monthly Insurance";
                        VarLoanInsurancePaid := VarLoanInsurancePaid + ObjLoanSchedule."Insurance Paid";
                    until ObjLoanSchedule.Next = 0;
                end;

                VarOutstandingInsurance := VarLoanInsuranceCharged - VarLoanInsurancePaid;
                if ObjLoans."Loan Status" <> ObjLoans."loan status"::Disbursed then
                    VarOutstandingInsurance := 0;


                VarOutstandingInterest := ObjLoans."Interest Due" - (ObjLoans."Interest Paid" + ObjLoans."Interest Paid Historical");
                if VarOutstandingInterest < 0 then begin
                    VarOutstandingInterest := 0;
                end;

                VarOutstandingPenalty := ObjLoans."Penalty Charged" - (ObjLoans."Penalty Paid" + ObjLoans."Penalty Paid Historical");
                if VarOutstandingPenalty < 0 then begin
                    VarOutstandingPenalty := 0;
                end;

                if ObjLoans.Get(VarLoanNo) then begin
                    ObjLoans."Outstanding Penalty" := VarOutstandingPenalty;
                    ObjLoans."Outstanding Insurance" := VarOutstandingInsurance;
                    ObjLoans."Loan Insurance Charged" := VarLoanInsuranceCharged;
                    ObjLoans."Loan Insurance Paid" := VarLoanInsurancePaid;
                    ObjLoans.Modify;
                end;
                ObjLoans.CalcFields(ObjLoans."Outstanding Balance");
                VarLoanPayoffAmount := ObjLoans."Outstanding Balance" + VarOutstandingInterest + VarOutstandingPenalty + VarOutstandingInsurance;
                exit(VarLoanPayoffAmount);

            end;
        end;
    end;


    procedure FnRunGetLoanDebtCollectorFee(VarLoanNo: Code[30]; VarLSABalance: Decimal) VarDebtCollectorFee: Decimal
    var
        VarLoanDueAmount: Decimal;
        VarDebtCollectorBaseAmount: Decimal;
    begin
        ObjLoans.Reset;
        ObjLoans.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
        ObjLoans.SetRange(ObjLoans."Loan  No.", VarLoanNo);
        ObjLoans.SetRange(ObjLoans."Loan Under Debt Collection", true);
        if ObjLoans.Find('-') then begin
            ObjVendor.Reset;
            ObjVendor.SetRange(ObjVendor."No.", ObjLoans."Loan Debt Collector");
            if ObjVendor.FindSet then begin
                VarLoanDueAmount := FnRunLoanAmountDue(VarLoanNo);

                ObjLoans.CalcFields(ObjLoans."Outstanding Balance", ObjLoans."Penalty Charged", ObjLoans."Penalty Paid");
                if VarLSABalance > 0 then begin
                    if VarLSABalance > VarLoanDueAmount then begin
                        VarDebtCollectorBaseAmount := VarLoanDueAmount
                    end else
                        VarDebtCollectorBaseAmount := VarLSABalance;

                    VarDebtCollectorFee := VarDebtCollectorBaseAmount * (ObjLoans."Loan Debt Collector Interest %" / 100);
                    VarDebtCollectorFee := VarDebtCollectorFee + (VarDebtCollectorFee * 0.16);
                    exit(VarDebtCollectorFee);
                end;
            end;
        end;
    end;


    procedure FnRunCreateDebtCollectorFeeJournals(VarLoanNoRecovered: Code[30]; BATCH_TEMPLATE: Code[20]; BATCH_NAME: Code[20]; DOCUMENT_NO: Code[20]; VarMemberNo: Code[20]; VarPostingDate: Date; EXTERNAL_DOC_NO: Code[30]; VarLoanSettlementAcc: Code[30]; RunningBalance: Decimal; var LineNo: Integer) VarRunBal: Decimal
    var
        AmountToDeduct: Decimal;
        VarDebtCollectorBaseAmount: Decimal;
        VarDebtCollectorFee: Decimal;
    begin
        //============================================================Debt Collector Fee
        if RunningBalance > 0 then begin
            ObjLoans.Reset;
            ObjLoans.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
            ObjLoans.SetRange(ObjLoans."Loan  No.", VarLoanNoRecovered);
            ObjLoans.SetRange(ObjLoans."Loan Under Debt Collection", true);
            if ObjLoans.Find('-') then begin
                ObjLoans.CalcFields(ObjLoans."Outstanding Balance", ObjLoans."Penalty Charged", ObjLoans."Penalty Paid");
                if RunningBalance > 0 then begin
                    AmountToDeduct := 0;
                    ObjVendor.Reset;
                    ObjVendor.SetRange(ObjVendor."No.", ObjLoans."Loan Debt Collector");
                    if ObjVendor.FindSet then begin
                        if RunningBalance > ObjLoans."Outstanding Balance" then
                            VarDebtCollectorBaseAmount := ObjLoans."Outstanding Balance"
                        else
                            VarDebtCollectorBaseAmount := RunningBalance;

                        VarDebtCollectorFee := VarDebtCollectorBaseAmount * (ObjLoans."Loan Debt Collector Interest %" / 100);
                        VarDebtCollectorFee := VarDebtCollectorFee + (VarDebtCollectorFee * 0.16);

                        if RunningBalance > VarDebtCollectorFee then begin
                            AmountToDeduct := VarDebtCollectorFee
                        end else
                            AmountToDeduct := RunningBalance;

                        DOCUMENT_NO := FnRunGetNextTransactionDocumentNo;
                        //------------------------------------1. Debit FOSA Account---------------------------------------------------------------------------------------------
                        LineNo := LineNo + 10000;
                        FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                        GenJournalLine."account type"::Vendor, VarLoanSettlementAcc, VarPostingDate, AmountToDeduct, 'FOSA', '',
                        'Debt Collection Charge + VAT from ' + VarLoanNoRecovered, '', GenJournalLine."application source"::" ");

                        LineNo := LineNo + 10000;
                        FnCreateGnlJournalLineGuarantorRecovery(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                        GenJournalLine."account type"::Vendor, ObjLoans."Loan Debt Collector", VarPostingDate, AmountToDeduct * -1, 'BOSA', VarLoanNoRecovered,
                        'Debt Collection Charge + VAT from ' + VarLoanNoRecovered + ObjLoans."Client Name", VarLoanNoRecovered, GenJournalLine."recovery transaction type"::"Guarantor Recoverd", VarLoanNoRecovered);
                    end;
                    VarRunBal := RunningBalance - AmountToDeduct;
                    exit(VarRunBal);
                end;
            end else
                exit(RunningBalance);
        end;
    end;


    procedure FnRunGetLoanDebtCollectorFeePayoff(VarLoanNo: Code[30]; VarLSABalance: Decimal) VarDebtCollectorFee: Decimal
    var
        VarLoanDueAmount: Decimal;
        VarDebtCollectorBaseAmount: Decimal;
    begin
        VarDebtCollectorFee := 0;
        ObjLoans.Reset;
        ObjLoans.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
        ObjLoans.SetRange(ObjLoans."Loan  No.", VarLoanNo);
        ObjLoans.SetRange(ObjLoans."Loan Under Debt Collection", true);
        if ObjLoans.Find('-') then begin
            ObjVendor.Reset;
            ObjVendor.SetRange(ObjVendor."No.", ObjLoans."Loan Debt Collector");
            if ObjVendor.FindSet then begin
                VarLoanDueAmount := FnRunGetLoanPayoffAmount(VarLoanNo);

                ObjLoans.CalcFields(ObjLoans."Outstanding Balance", ObjLoans."Penalty Charged", ObjLoans."Penalty Paid");
                if VarLSABalance > 0 then begin
                    if VarLSABalance > VarLoanDueAmount then begin
                        VarDebtCollectorBaseAmount := VarLoanDueAmount
                    end else
                        VarDebtCollectorBaseAmount := VarLSABalance;

                    VarDebtCollectorFee := VarDebtCollectorBaseAmount * (ObjLoans."Loan Debt Collector Interest %" / 100);
                    VarDebtCollectorFee := VarDebtCollectorFee + (VarDebtCollectorFee * 0.16);
                    exit(VarDebtCollectorFee);
                end;
            end;
        end;
        exit(VarDebtCollectorFee);
    end;


    procedure FnRunGetDepositArrearsPenalty()
    var
        ObjMember: Record Customer;
        ObjDetailedVendorLedger: Record "Detailed Vendor Ledg. Entry";
        VarCurrMonthEndMonthDate: Date;
        VarCurrMonthBeginDate: Date;
        VarCurrBeginMonthDay: Integer;
        VarCurrMonthMonth: Integer;
        VarCurrMonthYear: Integer;
        VarMonthlyDepositContribution: Decimal;
        VarDateFilter: Text;
        VarTotalDepositsMade: Decimal;
        ObjDepostPenaltyBuffer: Record "Deposit Arrears Penalty Buffer";
        VarDepositArrearsAmount: Decimal;
        ObjGeneralSetup: Record "Sacco General Set-Up";
        ObjDepostPenaltyBufferII: Record "Deposit Arrears Penalty Buffer";
        VarEntryNo: Integer;
        ObjMemberLedgerHistorical: Record "Member Historical Ledger Entry";
        VarTotalDepositsMadeHistorical: Decimal;
        ObjAccount: Record Vendor;
    begin
        //==========================================Evaluate Dates
        VarCurrMonthEndMonthDate := CalcDate('CM', WorkDate);
        VarCurrBeginMonthDay := 1;
        VarCurrMonthMonth := Date2dmy(WorkDate, 2);
        VarCurrMonthYear := Date2dmy(WorkDate, 3);
        VarCurrMonthBeginDate := Dmy2date(VarCurrBeginMonthDay, VarCurrMonthMonth, VarCurrMonthYear);
        VarDateFilter := Format(VarCurrMonthBeginDate) + '..' + Format(VarCurrMonthEndMonthDate);
        VarMonthlyDepositContribution := 0;

        ObjMember.CalcFields(ObjMember."Deposits Contributed", ObjMember."Deposits Account Status", ObjMember."Deposit Contributed Historical");
        ObjMember.Reset;
        ObjMember.SetFilter(ObjMember."Date Filter", VarDateFilter);
        //ObjMember.SETRANGE(ObjMember."No.",'001000137');
        ObjMember.SetRange(ObjMember."Deposits Account Status", ObjMember."deposits account status"::Active);
        ObjMember.SetFilter(ObjMember."Monthly Contribution", '>%1', (ObjMember."Deposits Contributed" + ObjMember."Deposit Contributed Historical"));
        if ObjMember.FindSet then begin
            repeat
                ObjMember.CalcFields(ObjMember."Deposits Contributed", ObjMember."Deposits Account Status", ObjMember."Deposits Contributed");
                VarMonthlyDepositContribution := ObjMember."Monthly Contribution";
                //MESSAGE('Deposits Contributed %1, Monthly Contribution %2',ObjMember."Deposits Contributed",ObjMember."Monthly Contribution");

                VarDepositArrearsAmount := VarMonthlyDepositContribution - ObjMember."Deposits Contributed";
                if VarDepositArrearsAmount < 0 then
                    VarDepositArrearsAmount := 0;

                ObjGenSetUp.Get;
                ObjDepostPenaltyBufferII.Reset;
                ObjDepostPenaltyBufferII.SetCurrentkey(ObjDepostPenaltyBufferII."Entry No.");
                if ObjDepostPenaltyBufferII.FindLast then begin
                    VarEntryNo := ObjDepostPenaltyBufferII."Entry No.";
                end;

                if VarDepositArrearsAmount > 50 then begin
                    ObjAccount.Reset;
                    ObjAccount.SetRange(ObjAccount."No.", ObjMember."Deposits Account No");
                    if ObjAccount.FindSet then begin
                        if (ObjAccount."Exempt BOSA Penalty" = false) or ((ObjAccount."Exempt BOSA Penalty" = true) and (ObjAccount."Exemption Expiry Date" < WorkDate)) then begin
                            ObjDepostPenaltyBuffer.Init;
                            ObjDepostPenaltyBuffer."Entry No." := VarEntryNo + 1;
                            ObjDepostPenaltyBuffer."Account No." := ObjMember."Deposits Account No";
                            ObjDepostPenaltyBuffer."Account Type" := ObjDepostPenaltyBuffer."account type"::"BOSA Account";
                            ObjDepostPenaltyBuffer."Member No" := ObjMember."No.";
                            ObjDepostPenaltyBuffer."Member Name" := ObjMember.Name;
                            ObjDepostPenaltyBuffer."Posting Date" := WorkDate;
                            ObjDepostPenaltyBuffer.Description := 'Penalty: Deposit Arrears for ' + Format(WorkDate, 0, '<Month Text,3> <Year4>');
                            ObjDepostPenaltyBuffer."Base Amount" := VarDepositArrearsAmount;
                            ObjDepostPenaltyBuffer."Global Dimension 1 Code" := ObjMember."Global Dimension 1 Code";
                            ObjDepostPenaltyBuffer."Global Dimension 2 Code" := ObjMember."Global Dimension 2 Code";
                            ObjDepostPenaltyBuffer.Amount := ObjGenSetUp."Penalty On Deposit Arrears";
                            ObjDepostPenaltyBuffer."User ID" := UserId;
                            ObjDepostPenaltyBuffer.Insert;
                        end;
                    end;
                end;
            until ObjMember.Next = 0;
        end;
    end;


    procedure FnRunCreateDepositArrearsPenaltyJournals(VarAccountNo: Code[30]; BATCH_TEMPLATE: Code[20]; BATCH_NAME: Code[20]; DOCUMENT_NO: Code[20]; VarPostingDate: Date; EXTERNAL_DOC_NO: Code[30]; RunningBalance: Decimal; var LineNo: Integer) VarRunBal: Decimal
    var
        AmountToDeduct: Decimal;
        VarDebtCollectorBaseAmount: Decimal;
        VarDebtCollectorFee: Decimal;
        ObjDepositArrearsPenalty: Record "Deposit Arrears Penalty Buffer";
        VarPenaltyAmount: Decimal;
        ObjGensetup: Record "Sacco General Set-Up";
        VarTaxonDepositArrears: Decimal;
        VarActualPenalty: Decimal;
        VarActualTax: Decimal;
        ObjDepositArrearsPenaltyII: Record "Deposit Arrears Penalty Buffer";
        VarAmountRemaining: Decimal;
        VarAmountAllocated: Decimal;
        VarCurrentMonthBeginDay: Integer;
        VarCurrentMonthMonth: Integer;
        VarCurrentMonthYear: Integer;
        VarCurrMonthBeginDate: Date;
        VarExpectedMonthContribution: Decimal;
        VarCurrMonthDepositArrears: Decimal;
    begin
        //============================================================Deposit Arrrears Penalty
        ObjGensetup.Get();

        if RunningBalance > 0 then begin
            ObjDepositArrearsPenalty.Reset;
            ObjDepositArrearsPenalty.SetCurrentkey("Entry No.");
            ObjDepositArrearsPenalty.SetRange(ObjDepositArrearsPenalty."Account No.", VarAccountNo);
            ObjDepositArrearsPenalty.SetRange(ObjDepositArrearsPenalty.Settled, false);
            if ObjDepositArrearsPenalty.Find('-') then begin
                ObjDepositArrearsPenalty.CalcSums(ObjDepositArrearsPenalty.Amount, ObjDepositArrearsPenalty."Settled Amount");
                VarPenaltyAmount := ObjDepositArrearsPenalty.Amount - ObjDepositArrearsPenalty."Settled Amount";
                VarTaxonDepositArrears := VarPenaltyAmount * ObjGensetup."Excise Duty(%)" / 100;

                if RunningBalance > 0 then begin
                    if RunningBalance > (VarPenaltyAmount + VarTaxonDepositArrears) then begin
                        AmountToDeduct := (VarPenaltyAmount + VarTaxonDepositArrears)
                    end else
                        AmountToDeduct := RunningBalance;

                    VarActualTax := AmountToDeduct * (ObjGensetup."Excise Duty(%)" / (100 + ObjGensetup."Excise Duty(%)"));
                    VarActualPenalty := AmountToDeduct - VarActualTax;

                    ObjVendor.Reset;
                    ObjVendor.SetRange("No.", VarAccountNo);
                    if ObjVendor.FindSet then begin
                        VarCurrentMonthBeginDay := 1;
                        VarCurrentMonthMonth := Date2dmy(WorkDate, 2);
                        VarCurrentMonthYear := Date2dmy(WorkDate, 3);
                        VarCurrMonthBeginDate := Dmy2date(VarCurrentMonthBeginDay, VarCurrentMonthMonth, VarCurrentMonthYear);
                        VarDateFilter := Format(VarCurrMonthBeginDate) + '..' + Format(CalcDate('CM', VarCurrMonthBeginDate));

                        ObjMembers.Reset;
                        ObjMembers.SetRange(ObjMembers."No.", ObjVendor."BOSA Account No");
                        ObjMembers.SetFilter(ObjMembers."Date Filter", VarDateFilter);
                        if ObjMembers.FindSet then begin
                            ObjMembers.CalcFields(ObjMembers."Deposits Contributed");
                            VarExpectedMonthContribution := ObjMembers."Monthly Contribution";
                            VarCurrMonthDepositArrears := VarExpectedMonthContribution - ObjMembers."Deposits Contributed";
                        end;

                        if VarCurrMonthDepositArrears > 50 then begin
                            GenJournalLine.Reset;
                            GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                            GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                            GenJournalLine.DeleteAll;

                            DOCUMENT_NO := FnRunGetNextTransactionDocumentNo;
                            //------------------------------------1. Debit Deposit Contribution Account---------------------------------------------------------------------------------------------
                            LineNo := LineNo + 10000;
                            FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Deposit Contribution",
                            GenJournalLine."account type"::Vendor, VarAccountNo, VarPostingDate, VarActualPenalty, 'BOSA', '',
                            'BOSA Deposits Penalty', '', GenJournalLine."application source"::" ");

                            LineNo := LineNo + 10000;
                            FnCreateGnlJournalLineGuarantorRecovery(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                            GenJournalLine."account type"::"G/L Account", ObjGensetup."Penalty On Deposit Arrears A/C", VarPostingDate, VarActualPenalty * -1, 'BOSA', '',
                            'BOSA Deposits Penalty from ' + VarAccountNo, '', GenJournalLine."recovery transaction type"::"Guarantor Recoverd", '');

                            //=====================================================================Tax On Penalty Deducted
                            LineNo := LineNo + 10000;
                            FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Deposit Contribution",
                            GenJournalLine."account type"::Vendor, VarAccountNo, VarPostingDate, VarActualTax, 'BOSA', '',
                            'Tax: BOSA Deposits Penalty', '', GenJournalLine."application source"::" ");

                            LineNo := LineNo + 10000;
                            FnCreateGnlJournalLineGuarantorRecovery(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                            GenJournalLine."account type"::"G/L Account", ObjGensetup."Excise Duty Account", VarPostingDate, VarActualTax * -1, 'BOSA', '',
                            'Tax: BOSA Deposits Penalty from ' + VarAccountNo, '', GenJournalLine."recovery transaction type"::"Guarantor Recoverd", '');

                            //CU posting
                            GenJournalLine.Reset;
                            GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                            GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                            if GenJournalLine.Find('-') then
                                Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
                        end;
                    end;

                    VarAmountRemaining := VarActualPenalty;
                    //====================================================Update Settled Amount
                    ObjDepositArrearsPenaltyII.Reset;
                    ObjDepositArrearsPenaltyII.SetRange(ObjDepositArrearsPenaltyII."Account No.", VarAccountNo);
                    ObjDepositArrearsPenaltyII.SetRange(ObjDepositArrearsPenaltyII.Settled, false);
                    if ObjDepositArrearsPenaltyII.FindSet then begin
                        repeat
                            if VarAmountRemaining > 0 then begin
                                if VarAmountRemaining >= (ObjDepositArrearsPenaltyII.Amount - ObjDepositArrearsPenaltyII."Settled Amount") then begin
                                    VarAmountAllocated := (ObjDepositArrearsPenaltyII.Amount - ObjDepositArrearsPenaltyII."Settled Amount");
                                    ObjDepositArrearsPenaltyII.Settled := true;
                                    ObjDepositArrearsPenaltyII."Settled On" := WorkDate;
                                    ObjDepositArrearsPenaltyII."Settled Amount" := ObjDepositArrearsPenaltyII."Settled Amount" + VarAmountAllocated;
                                    ObjDepositArrearsPenaltyII.Modify;
                                end;

                                if VarAmountRemaining < (ObjDepositArrearsPenaltyII.Amount - ObjDepositArrearsPenaltyII."Settled Amount") then begin
                                    VarAmountAllocated := VarAmountRemaining;
                                    ObjDepositArrearsPenaltyII."Settled Amount" := ObjDepositArrearsPenaltyII."Settled Amount" + VarAmountAllocated;
                                    ObjDepositArrearsPenaltyII.Modify;
                                end;
                                VarAmountRemaining := VarAmountRemaining - VarAmountAllocated;
                            end;
                        until ObjDepositArrearsPenaltyII.Next = 0;
                    end;

                end;
            end;
        end;
    end;


    procedure FnRunCreateDepositTransferJournalsMonthly(VarAccountNo: Code[30]; VarMemberNo: Code[30]) VarRunBal: Decimal
    var
        AmountToDeduct: Decimal;
        VarDebtCollectorBaseAmount: Decimal;
        VarDebtCollectorFee: Decimal;
        ObjDepositArrearsPenalty: Record "Deposit Arrears Penalty Buffer";
        VarPenaltyAmount: Decimal;
        ObjGensetup: Record "Sacco General Set-Up";
        VarTaxonDepositArrears: Decimal;
        VarActualPenalty: Decimal;
        VarActualTax: Decimal;
        ObjDepositArrearsPenaltyII: Record "Deposit Arrears Penalty Buffer";
        VarAmountRemaining: Decimal;
        VarAmountAllocated: Decimal;
        ObjAccount: Record Vendor;
        ObjVendors: Record Vendor;
        AvailableBal: Decimal;
        ObjAccTypes: Record "Account Types-Saving Products";
        BATCH_TEMPLATE: Code[20];
        BATCH_NAME: Code[20];
        DOCUMENT_NO: Code[20];
        LineNo: Integer;
        ObjDetailedVendorLedger: Record "Detailed Vendor Ledg. Entry";
        VarCurrentMonthTotalDepositCredits: Decimal;
        VarCurrentMonthBeginDay: Integer;
        VarCurrentMonthMonth: Integer;
        VarCurrentMonthYear: Integer;
        VarDateFilter: Text;
        VarCurrMonthBeginDate: Date;
        VarCurrMonthDepositArrears: Decimal;
        VarExpectedMonthContribution: Decimal;
        VarTotalPenaltyAmount: Decimal;
        VarTotalPenaltySettled: Decimal;
        VarTotalAmounttoRecover: Decimal;
        VarRunningBal: Decimal;
        ObjMemberLedgerHistorical: Record "Member Loans Historical Ledger";
        VarCurrentMonthTotalDepositCreditsHistorical: Decimal;
        VarAccountBalBackDated: Decimal;
        VarPostingDate: Date;
    begin
        //============================================================Deposit Arrrears Penalty
        ObjGensetup.Get();

        BATCH_TEMPLATE := 'PURCHASES';
        BATCH_NAME := 'FTRANS';
        DOCUMENT_NO := FnRunGetNextTransactionDocumentNo;

        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
        GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
        GenJournalLine.DeleteAll;

        //================================================================================================Recover Penalty On Deposit Arrears
        ObjDepositArrearsPenalty.Reset;
        ObjDepositArrearsPenalty.SetCurrentkey("Entry No.");
        ObjDepositArrearsPenalty.SetRange(ObjDepositArrearsPenalty."Account No.", VarAccountNo);
        ObjDepositArrearsPenalty.SetRange(ObjDepositArrearsPenalty.Settled, false);
        if ObjDepositArrearsPenalty.FindSet then begin
            ObjDepositArrearsPenalty.CalcSums(ObjDepositArrearsPenalty.Amount);
            ObjDepositArrearsPenalty.CalcSums(ObjDepositArrearsPenalty."Settled Amount");
            VarTotalPenaltyAmount := ObjDepositArrearsPenalty.Amount;
            VarTotalPenaltySettled := ObjDepositArrearsPenalty."Settled Amount";
            VarPenaltyAmount := VarTotalPenaltyAmount - VarTotalPenaltySettled;
        end;

        //===============================================================================================Recover Current Months UnPaid Deposits
        VarCurrentMonthBeginDay := 1;
        VarCurrentMonthMonth := Date2dmy(WorkDate, 2);
        VarCurrentMonthYear := Date2dmy(WorkDate, 3);
        VarCurrMonthBeginDate := Dmy2date(VarCurrentMonthBeginDay, VarCurrentMonthMonth, VarCurrentMonthYear);
        VarDateFilter := Format(VarCurrMonthBeginDate) + '..' + Format(CalcDate('CM', VarCurrMonthBeginDate));

        ObjMembers.Reset;
        ObjMembers.SetRange(ObjMembers."No.", VarMemberNo);
        ObjMembers.SetFilter(ObjMembers."Date Filter", VarDateFilter);
        if ObjMembers.FindSet then begin
            ObjMembers.CalcFields(ObjMembers."Deposits Contributed");
            VarExpectedMonthContribution := ObjMembers."Monthly Contribution";
            VarCurrMonthDepositArrears := VarExpectedMonthContribution - ObjMembers."Deposits Contributed";
        end;


        if VarCurrMonthDepositArrears < 0 then
            VarCurrMonthDepositArrears := 0;
        //===============================================================================================End Recover Current Months UnPaid Deposits

        VarTotalAmounttoRecover := VarPenaltyAmount + VarCurrMonthDepositArrears;
        if VarTotalAmounttoRecover > 0 then begin
            VarRunningBal := VarTotalAmounttoRecover;
            ObjAccount.Reset;
            ObjAccount.SetRange(ObjAccount."BOSA Account No", VarMemberNo);
            ObjAccount.SetFilter(ObjAccount."Account Type", '%1|%2|%3|%4|%5|%6|%7|%8|%9|%10', '401', '402', '403', '404', '405', '406', '501', '508', '509', '507');
            ObjAccount.SetFilter(ObjAccount.Status, '%1|%2', ObjAccount.Status::Active, ObjAccount.Status::Dormant);
            ObjAccount.SetRange(ObjAccount.Blocked, ObjAccount.Blocked::" ");
            if ObjAccount.FindSet then begin
                repeat
                    AmountToDeduct := 0;
                    AvailableBal := 0;

                    AvailableBal := FnRunGetAccountAvailableBalanceWithoutFreeze(ObjVendors."No.", WorkDate);

                    if (VarRunningBal > 0) and (AvailableBal >= 20) then begin

                        if AvailableBal > VarRunningBal then begin
                            AmountToDeduct := VarRunningBal
                        end else
                            AmountToDeduct := AvailableBal;

                        VarPostingDate := WorkDate;
                        //=================================================================================================Transfer Deposits Contribution From FOSA
                        LineNo := LineNo + 10000;
                        FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Deposit Contribution",
                        GenJournalLine."account type"::Vendor, VarAccountNo, VarPostingDate, AmountToDeduct * -1, 'BOSA', '',
                        'BOSA Deposits Transfer ' + Format(VarPostingDate, 0, '<Month Text,3> <Year4>') + ' from ' + ObjAccount."No.", '', GenJournalLine."application source"::" ");

                        LineNo := LineNo + 10000;
                        FnCreateGnlJournalLineGuarantorRecovery(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                        GenJournalLine."account type"::Vendor, ObjAccount."No.", VarPostingDate, AmountToDeduct, 'BOSA', '',
                        'BOSA Deposits Transfer ' + Format(VarPostingDate, 0, '<Month Text,3> <Year4>'), '', GenJournalLine."recovery transaction type"::"Guarantor Recoverd", '');

                        VarRunningBal := VarRunningBal - AmountToDeduct;
                    end;

                until ObjAccount.Next = 0;
            end;
        end;


        //CU posting
        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
        GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
        if GenJournalLine.Find('-') then
            Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);

    end;

    local procedure FnRunCreateFOSASharesRecoveryJournals()
    begin
        /*
        VarAmountPosted:=0;
        CALCFIELDS("Current Shares","Shares Retained","Benevolent Fund");
        IF (VarBenfundCurrYearCredits<ObjGensetup."Benevolent Fund Contribution") AND ("Current Shares">0) THEN
          BEGIN
            VarBenfundVariance:=(ObjGensetup."Benevolent Fund Contribution"-VarBenfundCurrYearCredits);
            IF "Current Shares">=VarBenfundVariance THEN BEGIN
            IF "Current Shares">VarBenfundVariance THEN
              BEGIN
                VarAmountPosted:=VarBenfundVariance
                END ELSE
                VarAmountPosted:="Current Shares";
        
        
                    //======================================================================================================1. DEBIT MEMBER DEPOSITS A/C
                    LineNo:=LineNo+10000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE,BATCH_NAME,DOCUMENT_NO,LineNo,GenJournalLine."Transaction Type"::"Deposit Contribution",
                    GenJournalLine."Account Type"::Vendor,"Deposits Account No",WORKDATE,VarAmountPosted,'BOSA','',
                    'Benevolent Fund Contribution to - '+"Benevolent Fund No",'');
        
        
                    //======================================================================================================2. CREDIT MEMBER BENFUND A/C
                    LineNo:=LineNo+10000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE,BATCH_NAME,DOCUMENT_NO,LineNo,GenJournalLine."Transaction Type"::"Benevolent Fund",
                    GenJournalLine."Account Type"::Vendor,"Benevolent Fund No",WORKDATE,VarAmountPosted*-1,'BOSA','',
                    'Benevolent Fund Contribution from - '+"Deposits Account No",'');
        
        
                  //==========================================================================================================3. DEBIT BENFUND A/C
                    LineNo:=LineNo+10000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE,BATCH_NAME,DOCUMENT_NO,LineNo,GenJournalLine."Transaction Type"::"Benevolent Fund",
                    GenJournalLine."Account Type"::Vendor,"Benevolent Fund No",WORKDATE,VarAmountPosted,'BOSA','',
                    'Benevolent Fund Transfer - '+"No.",'');
        
        
                    //=========================================================================================================4. CREDIT BENFUND G/L A/C
                    LineNo:=LineNo+10000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE,BATCH_NAME,DOCUMENT_NO,LineNo,GenJournalLine."Transaction Type"::"Benevolent Fund",
                    GenJournalLine."Account Type"::"G/L Account",ObjGensetup."Benevolent Fund Account",WORKDATE,VarAmountPosted*-1,'BOSA','',
                    'Benevolent Fund Contribution - '+"No.",'');
        
                    //CU posting
                    GenJournalLine.RESET;
                    GenJournalLine.SETRANGE("Journal Template Name",'GENERAL');
                    GenJournalLine.SETRANGE("Journal Batch Name",'DEFAULT');
                    IF GenJournalLine.FIND('-') THEN
                      CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Sacco",GenJournalLine);
                    END;
         END;*/
        //=======================================================================================================================END Transfer Benevolent Fund Variance

    end;


    procedure FnRunGetStatementDateFilter(DateFilter: Text) VarNewDate: Date
    var
        myDate: Integer;
        myMonth: Integer;
        myYear: Integer;
        VarBalanceFilterBeginDate: Text;
    begin

        VarBalanceFilterBeginDate := CopyStr(DateFilter, 1, 8);
        Evaluate(myDate, CopyStr(VarBalanceFilterBeginDate, 1, 2));
        Evaluate(myMonth, CopyStr(VarBalanceFilterBeginDate, 4, 2));
        Evaluate(myYear, CopyStr(VarBalanceFilterBeginDate, 7, 4));


        VarNewDate := Dmy2date(myDate, myMonth, myYear + 2000) - 1;
    end;


    procedure FnRunGetStatementDateFilterAPP(DateFilter: Text) VarNewDate: Date
    var
        myDate: Integer;
        myMonth: Integer;
        myYear: Integer;
        VarBalanceFilterBeginDate: Text;
    begin

        VarBalanceFilterBeginDate := CopyStr(DateFilter, 1, 8);
        Evaluate(myDate, CopyStr(VarBalanceFilterBeginDate, 1, 2));
        Evaluate(myMonth, CopyStr(VarBalanceFilterBeginDate, 4, 2));
        Evaluate(myYear, CopyStr(VarBalanceFilterBeginDate, 7, 4));


        VarNewDate := Dmy2date(myMonth, myDate, myYear + 2000);
        VarNewDate := CalcDate('-1D', VarNewDate);

    end;


    procedure FnRunSendSubscribedAccountSMSAlert()
    var
        ObjAccountLedger: Record "Vendor Ledger Entry";
        ObjMemberAccount: Record Vendor;
        ObjAccountSignatories: Record "FOSA Account Sign. Details";
        CloudPesa: Codeunit CloudPESALivetest;
        VarSMSBody: Text;
        AvailableBal: Decimal;
        ObjAccTypes: Record "Account Types-Saving Products";
        ObjSaccoGensetup: Record "Sacco General Set-Up";
        JournalTemplate: Code[30];
        JournalBatch: Code[30];
        DocNo: Code[30];
        LineNo: Integer;
        TransDate: Date;
    begin
        TransDate := CalcDate('-2D', WorkDate);
        ObjMemberAccount.Reset;
        ObjMemberAccount.SetFilter(ObjMemberAccount."Transaction Alerts", '<>%1', ObjMemberAccount."transaction alerts"::" ");
        if ObjMemberAccount.FindSet then begin
            repeat
                ObjSaccoGensetup.Get;

                ObjMemberAccount.CalcFields(ObjMemberAccount."No Of Signatories", ObjMemberAccount.Balance, ObjMemberAccount."Uncleared Cheques");
                AvailableBal := (ObjMemberAccount.Balance - ObjMemberAccount."Uncleared Cheques" + ObjMemberAccount."Over Draft Limit Amount");

                ObjAccTypes.Reset;
                ObjAccTypes.SetRange(ObjAccTypes.Code, ObjMemberAccount."Account Type");
                if ObjAccTypes.Find('-') then
                    AvailableBal := AvailableBal - ObjAccTypes."Minimum Balance";

                if AvailableBal >= (ObjSaccoGensetup."SMS Alert Fees") + ((ObjSaccoGensetup."Excise Duty(%)" / 100) * ObjSaccoGensetup."SMS Alert Fees") then begin
                    //==================================================================================================Credits and ALL
                    if (ObjMemberAccount."Transaction Alerts" = ObjMemberAccount."transaction alerts"::"All Credit Transactions") or
                       (ObjMemberAccount."Transaction Alerts" = ObjMemberAccount."transaction alerts"::"All Transactions") then begin

                        ObjAccountLedger.CalcFields(ObjAccountLedger."Credit Amount");
                        ObjAccountLedger.Reset;
                        ObjAccountLedger.SetRange(ObjAccountLedger."Vendor No.", ObjMemberAccount."No.");
                        ObjAccountLedger.SetRange(ObjAccountLedger.Alerted, false);
                        ObjAccountLedger.SetFilter(ObjAccountLedger."Credit Amount", '<>%1', 0);
                        ObjAccountLedger.SetFilter(ObjAccountLedger."Transaction Date", '>=%1', TransDate);
                        ObjAccountLedger.SetFilter(ObjAccountLedger.Description, '<>%1&<>%2&<>%3&<>%4&<>%5', '*Fee*', '*Charge*', '*Tax*', '*Excise*', '*Sweep*');
                        if ObjAccountLedger.FindSet then begin
                            repeat
                                ObjAccountLedger.CalcFields(ObjAccountLedger."Credit Amount");
                                if ObjMemberAccount."No Of Signatories" = 0 then begin
                                    VarSMSBody := 'Ksh. ' + Format(ObjAccountLedger."Credit Amount") + ' credited to your Account No. ' + ObjAccountLedger."Vendor No." +
                                    ' - ' + ObjAccountLedger.Description + '. Vision Sacco';
                                    // CloudPesa.SMSMessage(ObjAccountLedger."Document No.",ObjAccountLedger."Vendor No.",ObjMemberAccount."Mobile Phone No",VarSMSBody);
                                end
                                else begin
                                    ObjAccountSignatories.Reset;
                                    ObjAccountSignatories.SetRange(ObjAccountSignatories."Account No", ObjMemberAccount."No.");
                                    ObjAccountSignatories.SetFilter(ObjAccountSignatories."Mobile No", '<>%1', '');
                                    if ObjAccountSignatories.FindSet then begin
                                        repeat
                                            VarSMSBody := 'Ksh. ' + Format(ObjAccountLedger."Credit Amount") + ' credited to your Account No. ' + ObjAccountLedger."Vendor No." +
                                            ' - ' + ObjAccountLedger.Description + '. Vision Sacco';
                                        // CloudPesa.SMSMessage(ObjAccountLedger."Document No.",ObjAccountLedger."Vendor No.",ObjAccountSignatories."Mobile No",VarSMSBody);
                                        until ObjAccountSignatories.Next = 0;
                                    end;
                                end;
                                ObjAccountLedger.Alerted := true;
                                ObjAccountLedger.Modify;

                                //===================================================================================Post SMS FEE
                                JournalTemplate := 'GENERAL';
                                JournalBatch := 'DEFAULT';
                                DocNo := FnRunGetNextTransactionDocumentNo;


                                FnClearGnlJournalLine(JournalTemplate, JournalBatch);

                                //============================================================================================1. Debit SMS FOSA Account
                                LineNo := LineNo + 10000;
                                FnCreateGnlJournalLine(JournalTemplate, JournalBatch, DocNo, LineNo, GenJournalLine."transaction type"::" ",
                                GenJournalLine."account type"::Vendor, ObjAccountLedger."Vendor No.", WorkDate, ObjSaccoGensetup."SMS Alert Fees", 'FOSA', '',
                                'Credit Transaction Alert Fee', '', GenJournalLine."application source"::CBS);

                                //============================================================================================2. Credit SMS G/L Account
                                LineNo := LineNo + 10000;
                                FnCreateGnlJournalLine(JournalTemplate, JournalBatch, DocNo, LineNo, GenJournalLine."transaction type"::" ",
                                GenJournalLine."account type"::"G/L Account", ObjSaccoGensetup."SMS Alert Fee Account", WorkDate, ObjSaccoGensetup."SMS Alert Fees" * -1, 'FOSA', '',
                                'Credit Transaction Alert Fee ' + ObjAccountLedger."Vendor No.", '', GenJournalLine."application source"::CBS);
                                //=============================================================================================(Credit SMS G/L Account)

                                //===========================================================================================3. Debit SMS TAX FOSA Account
                                LineNo := LineNo + 10000;
                                FnCreateGnlJournalLine(JournalTemplate, JournalBatch, DocNo, LineNo, GenJournalLine."transaction type"::" ",
                                GenJournalLine."account type"::Vendor, ObjAccountLedger."Vendor No.", WorkDate, (ObjSaccoGensetup."SMS Alert Fees" * ObjSaccoGensetup."Excise Duty(%)" / 100), 'FOSA', '',
                                'Tax: Credit Transaction Alert Fee', '', GenJournalLine."application source"::CBS);

                                //===========================================================================================4. Credit SMS TAX G/L Account
                                LineNo := LineNo + 10000;
                                FnCreateGnlJournalLine(JournalTemplate, JournalBatch, DocNo, LineNo, GenJournalLine."transaction type"::" ",
                                GenJournalLine."account type"::"G/L Account", ObjSaccoGensetup."SMS Alert Fee Account", WorkDate, (ObjSaccoGensetup."SMS Alert Fees" * ObjSaccoGensetup."Excise Duty(%)" / 100) * -1, 'FOSA', '',
                                'Tax: Credit Transaction Alert Fee ' + ObjAccountLedger."Vendor No.", '', GenJournalLine."application source"::CBS);
                                //===========================================================================================(Credit SMS TAX G/L Account)

                                //CU posting
                                GenJournalLine.Reset;
                                GenJournalLine.SetRange("Journal Template Name", JournalTemplate);
                                GenJournalLine.SetRange("Journal Batch Name", JournalBatch);
                                if GenJournalLine.Find('-') then
                                    Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
                            until ObjAccountLedger.Next = 0;
                        end;
                    end;

                    //==================================================================================================Debits and ALL
                    if (ObjMemberAccount."Transaction Alerts" = ObjMemberAccount."transaction alerts"::"All Debit Transactions") or
                      (ObjMemberAccount."Transaction Alerts" = ObjMemberAccount."transaction alerts"::"All Transactions") then begin

                        ObjAccountLedger.CalcFields(ObjAccountLedger."Debit Amount");
                        ObjAccountLedger.Reset;
                        ObjAccountLedger.SetRange(ObjAccountLedger."Vendor No.", ObjMemberAccount."No.");
                        ObjAccountLedger.SetRange(ObjAccountLedger.Alerted, false);
                        ObjAccountLedger.SetFilter(ObjAccountLedger."Debit Amount", '<>%1', 0);
                        ObjAccountLedger.SetFilter(ObjAccountLedger."Transaction Date", '>=%1', TransDate);
                        ObjAccountLedger.SetFilter(ObjAccountLedger.Description, '<>%1&<>%2&<>%3&<>%4&<>%5', '*Fee*', '*Charge*', '*Tax*', '*Excise*', '*Sweep*');
                        if ObjAccountLedger.FindSet then begin
                            repeat
                                ObjAccountLedger.CalcFields(ObjAccountLedger."Debit Amount");

                                if ObjMemberAccount."No Of Signatories" = 0 then begin
                                    VarSMSBody := 'Ksh. ' + Format(ObjAccountLedger."Debit Amount") + ' debited from your Account No. ' + ObjAccountLedger."Vendor No." + ' - ' + ObjAccountLedger.Description + '. Vision Sacco';
                                    //  CloudPesa.SMSMessage(ObjAccountLedger."Document No.",ObjAccountLedger."Vendor No.",ObjMemberAccount."Mobile Phone No",VarSMSBody);
                                end
                                else begin
                                    ObjAccountSignatories.Reset;
                                    ObjAccountSignatories.SetRange(ObjAccountSignatories."Account No", ObjMemberAccount."No.");
                                    ObjAccountSignatories.SetFilter(ObjAccountSignatories."Mobile No", '<>%1', '');
                                    if ObjAccountSignatories.FindSet then begin
                                        repeat
                                            VarSMSBody := 'Ksh. ' + Format(ObjAccountLedger."Debit Amount") + ' debited from your Account No. ' + ObjAccountLedger."Vendor No." + ' - ' + ObjAccountLedger.Description + '. Vision Sacco';
                                        //    CloudPesa.SMSMessage(ObjAccountLedger."Document No.",ObjAccountLedger."Vendor No.",ObjAccountSignatories."Mobile No",VarSMSBody);
                                        until ObjAccountSignatories.Next = 0
                                    end;
                                end;
                                ObjAccountLedger.Alerted := true;
                                ObjAccountLedger.Modify;

                                JournalTemplate := 'GENERAL';
                                JournalBatch := 'DEFAULT';
                                DocNo := FnRunGetNextTransactionDocumentNo;


                                FnClearGnlJournalLine(JournalTemplate, JournalBatch);

                                ObjSaccoGensetup.Get;
                                //============================================================================================1. Debit SMS FOSA Account
                                LineNo := LineNo + 10000;
                                FnCreateGnlJournalLine(JournalTemplate, JournalBatch, DocNo, LineNo, GenJournalLine."transaction type"::" ",
                                GenJournalLine."account type"::Vendor, ObjAccountLedger."Vendor No.", WorkDate, ObjSaccoGensetup."SMS Alert Fees", 'FOSA', '',
                                'Debit Transaction Alert Fee', '', GenJournalLine."application source"::CBS);

                                //============================================================================================2. Credit SMS G/L Account
                                LineNo := LineNo + 10000;
                                FnCreateGnlJournalLine(JournalTemplate, JournalBatch, DocNo, LineNo, GenJournalLine."transaction type"::" ",
                                GenJournalLine."account type"::"G/L Account", ObjSaccoGensetup."SMS Alert Fee Account", WorkDate, ObjSaccoGensetup."SMS Alert Fees" * -1, 'FOSA', '',
                                'Debit Transaction Alert Fee ' + ObjAccountLedger."Vendor No.", '', GenJournalLine."application source"::CBS);
                                //=============================================================================================(Credit SMS G/L Account)

                                //===========================================================================================3. Debit SMS TAX FOSA Account
                                LineNo := LineNo + 10000;
                                FnCreateGnlJournalLine(JournalTemplate, JournalBatch, DocNo, LineNo, GenJournalLine."transaction type"::" ",
                                GenJournalLine."account type"::Vendor, ObjAccountLedger."Vendor No.", WorkDate, (ObjSaccoGensetup."SMS Alert Fees" * ObjSaccoGensetup."Excise Duty(%)" / 100), 'FOSA', '',
                                'Tax: Debit Transaction Alert Fee', '', GenJournalLine."application source"::CBS);

                                //===========================================================================================4. Credit SMS TAX G/L Account
                                LineNo := LineNo + 10000;
                                FnCreateGnlJournalLine(JournalTemplate, JournalBatch, DocNo, LineNo, GenJournalLine."transaction type"::" ",
                                GenJournalLine."account type"::"G/L Account", ObjSaccoGensetup."SMS Alert Fee Account", WorkDate, (ObjSaccoGensetup."SMS Alert Fees" * ObjSaccoGensetup."Excise Duty(%)" / 100) * -1, 'FOSA', '',
                                'Tax: Debit Transaction Alert Fee ' + ObjAccountLedger."Vendor No.", '', GenJournalLine."application source"::CBS);
                                //===========================================================================================(Credit SMS TAX G/L Account)

                                //CU posting
                                GenJournalLine.Reset;
                                GenJournalLine.SetRange("Journal Template Name", JournalTemplate);
                                GenJournalLine.SetRange("Journal Batch Name", JournalBatch);
                                if GenJournalLine.Find('-') then
                                    Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
                            until ObjAccountLedger.Next = 0;
                        end;
                    end;
                end;


            until ObjMemberAccount.Next = 0;
        end;

    end;


    procedure FnRunEffectSweepingInstructions()
    var
        ObjSweepingInstructions: Record "Member Sweeping Instructions";
        VarDayofMonth: Integer;
        VarDayofMonthText: Text;
        WeekDay: Text;
        WeekDayOption: Option Sunday,Monday,Tuesday,Wednesday,Thursday,Friday,Saturday;
    begin
        //======================================================================================Daily Sweeping
        ObjSweepingInstructions.Reset;
        ObjSweepingInstructions.SetRange(ObjSweepingInstructions.Effected, true);
        ObjSweepingInstructions.SetRange(ObjSweepingInstructions.Stopped, false);
        ObjSweepingInstructions.SetRange(ObjSweepingInstructions."Schedule Frequency", ObjSweepingInstructions."schedule frequency"::Daily);
        if ObjSweepingInstructions.FindSet then begin
            repeat
                FnRunPostSweepingInstruction(ObjSweepingInstructions."Document No");
            until ObjSweepingInstructions.Next = 0;
        end;

        //======================================================================================Weekly Sweeping
        WeekDay := Format(WorkDate, 0, '<Weekday Text>');

        if WeekDay = 'Sunday' then
            WeekDayOption := Weekdayoption::Sunday;
        if WeekDay = 'Monday' then
            WeekDayOption := Weekdayoption::Monday;
        if WeekDay = 'Tuesday' then
            WeekDayOption := Weekdayoption::Tuesday;
        if WeekDay = 'Wednesday' then
            WeekDayOption := Weekdayoption::Wednesday;
        if WeekDay = 'Thursday' then
            WeekDayOption := Weekdayoption::Thursday;
        if WeekDay = 'Friday' then
            WeekDayOption := Weekdayoption::Friday;
        if WeekDay = 'Saturday' then
            WeekDayOption := Weekdayoption::Saturday;

        ObjSweepingInstructions.Reset;
        ObjSweepingInstructions.SetRange(ObjSweepingInstructions.Effected, true);
        ObjSweepingInstructions.SetRange(ObjSweepingInstructions.Stopped, false);
        ObjSweepingInstructions.SetRange(ObjSweepingInstructions."Schedule Frequency", ObjSweepingInstructions."schedule frequency"::Weekly);
        ObjSweepingInstructions.SetRange(ObjSweepingInstructions."Day Of Week", WeekDayOption);
        if ObjSweepingInstructions.FindSet then begin
            repeat
                FnRunPostSweepingInstruction(ObjSweepingInstructions."Document No");
            until ObjSweepingInstructions.Next = 0;
        end;

        //=====================================================================================Monthly Sweeping
        VarDayofMonth := Date2dmy(WorkDate, 1);
        if VarDayofMonth < 10 then begin
            VarDayofMonthText := '*0' + Format(VarDayofMonth) + '*'
        end else
            VarDayofMonthText := '*' + Format(VarDayofMonth) + '*';

        ObjSweepingInstructions.Reset;
        ObjSweepingInstructions.SetRange(ObjSweepingInstructions.Effected, true);
        ObjSweepingInstructions.SetRange(ObjSweepingInstructions.Stopped, false);
        ObjSweepingInstructions.SetRange(ObjSweepingInstructions."Schedule Frequency", ObjSweepingInstructions."schedule frequency"::Monthly);
        ObjSweepingInstructions.SetFilter(ObjSweepingInstructions."Day Of Month", '%1', VarDayofMonthText);
        if ObjSweepingInstructions.FindSet then begin
            repeat
                FnRunPostSweepingInstruction(ObjSweepingInstructions."Document No");
            until ObjSweepingInstructions.Next = 0;
        end;
    end;


    procedure FnRunPostSweepingInstruction(VarDocumentNo: Code[30])
    var
        ObjSweepingInstructions: Record "Member Sweeping Instructions";
        ObjAccount: Record Vendor;
        VarMonitorAvailableBalance: Decimal;
        VarInvestmentAvailableBalance: Decimal;
        ObjVendors: Record Vendor;
        ObjAccTypes: Record "Account Types-Saving Products";
        VarAmounttoTransferMin: Decimal;
        LineNo: Integer;
        JournalTemplate: Code[30];
        JournalBatch: Code[30];
        DocNo: Code[30];
        VarAmounttoTransferMax: Decimal;
    begin
        ObjSweepingInstructions.Reset;
        ObjSweepingInstructions.SetRange(ObjSweepingInstructions."Document No", VarDocumentNo);
        ObjSweepingInstructions.SetRange(ObjSweepingInstructions.Effected, true);
        ObjSweepingInstructions.SetRange(ObjSweepingInstructions.Stopped, false);
        if ObjSweepingInstructions.FindSet then begin
            //==========================================================Get Available Balance Monitor Account
            ObjVendors.Reset;
            ObjVendors.SetRange(ObjVendors."No.", ObjSweepingInstructions."Monitor Account");
            if ObjVendors.Find('-') then begin
                VarMonitorAvailableBalance := FnRunGetAccountAvailableBalanceWithoutFreeze(ObjVendors."No.", WorkDate);
            end;

            //==========================================================Get Available Balance Investment Account
            ObjVendors.Reset;
            ObjVendors.SetRange(ObjVendors."No.", ObjSweepingInstructions."Investment Account");
            if ObjVendors.Find('-') then begin
                VarInvestmentAvailableBalance := FnRunGetAccountAvailableBalanceWithoutFreeze(ObjVendors."No.", WorkDate);
                ;
            end;

            VarAmounttoTransferMin := (ObjSweepingInstructions."Minimum Account Threshold" - VarMonitorAvailableBalance);


            //=======================================================================================================Minimum Threshold
            if ObjSweepingInstructions."Check Minimum Threshold" = true then begin
                if (VarMonitorAvailableBalance < ObjSweepingInstructions."Minimum Account Threshold") and (VarInvestmentAvailableBalance > 0) then begin
                    if VarInvestmentAvailableBalance < VarAmounttoTransferMin then
                        VarAmounttoTransferMin := VarInvestmentAvailableBalance;

                    JournalTemplate := 'GENERAL';
                    JournalBatch := 'DEFAULT';
                    DocNo := FnRunGetNextTransactionDocumentNo;


                    FnClearGnlJournalLine(JournalTemplate, JournalBatch);
                    //============================================================================================1. Debit Investment Account
                    LineNo := LineNo + 10000;
                    FnCreateGnlJournalLine(JournalTemplate, JournalBatch, DocNo, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::Vendor, ObjSweepingInstructions."Investment Account", WorkDate, VarAmounttoTransferMin, 'FOSA', '',
                    'Sweep Instruction Transfer to ' + ObjSweepingInstructions."Monitor Account", '', GenJournalLine."application source"::CBS);

                    //============================================================================================2. Credit Monitor Account
                    LineNo := LineNo + 10000;
                    FnCreateGnlJournalLine(JournalTemplate, JournalBatch, DocNo, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::Vendor, ObjSweepingInstructions."Monitor Account", WorkDate, VarAmounttoTransferMin * -1, 'FOSA', '',
                    'Sweep Instruction Transfer from ' + ObjSweepingInstructions."Investment Account", '', GenJournalLine."application source"::CBS);

                    //CU posting
                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", JournalTemplate);
                    GenJournalLine.SetRange("Journal Batch Name", JournalBatch);
                    if GenJournalLine.Find('-') then
                        Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);

                    ObjSweepingInstructions."Last Execution" := CurrentDatetime;
                end;
            end;


            //=======================================================================================================Maximum Threshold

            if ObjSweepingInstructions."Check Maximum Threshold" = true then begin

                if (VarMonitorAvailableBalance > ObjSweepingInstructions."Maximum Account Threshold") then begin
                    VarAmounttoTransferMax := VarMonitorAvailableBalance - ObjSweepingInstructions."Maximum Account Threshold";

                    JournalTemplate := 'GENERAL';
                    JournalBatch := 'DEFAULT';
                    DocNo := FnRunGetNextTransactionDocumentNo;


                    FnClearGnlJournalLine(JournalTemplate, JournalBatch);
                    //============================================================================================1. Debit Monitor Account
                    LineNo := LineNo + 10000;
                    FnCreateGnlJournalLine(JournalTemplate, JournalBatch, DocNo, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::Vendor, ObjSweepingInstructions."Monitor Account", WorkDate, VarAmounttoTransferMax, 'FOSA', '',
                    'Sweep Instruction Transfer to ' + ObjSweepingInstructions."Investment Account", '', GenJournalLine."application source"::CBS);

                    //============================================================================================2. Credit Investment Account
                    LineNo := LineNo + 10000;
                    FnCreateGnlJournalLine(JournalTemplate, JournalBatch, DocNo, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::Vendor, ObjSweepingInstructions."Investment Account", WorkDate, VarAmounttoTransferMax * -1, 'FOSA', '',
                    'Sweep Instruction Transfer from ' + ObjSweepingInstructions."Monitor Account", '', GenJournalLine."application source"::CBS);

                    //CU posting
                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", JournalTemplate);
                    GenJournalLine.SetRange("Journal Batch Name", JournalBatch);
                    if GenJournalLine.Find('-') then
                        Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);

                    ObjSweepingInstructions."Last Execution" := CurrentDatetime;
                end;
            end;
        end;
    end;


    procedure FnRunProcessInterestOnFixedDepositAccount(VarProcessDate: Date; VarAccountNo: Code[30])
    var
        ObjAccount: Record Vendor;
        ObjAccountType: Record "Account Types-Saving Products";
        VarInterestEarned: Decimal;
        LineNo: Integer;
        JournalTemplate: Code[30];
        JournalBatch: Code[30];
        DocNo: Code[30];
        ObjGenLedgerSetup: Record "General Ledger Setup";
        ObjInterestBuffer: Record "Interest Buffer";
        VarBufferEntryNo: Integer;
        VarPostingDate: Date;
    begin
        ObjAccount.CalcFields(ObjAccount.Balance);
        ObjAccount.Reset;
        ObjAccount.SetRange(ObjAccount."No.", VarAccountNo);
        ObjAccount.SetFilter(ObjAccount."Account Type", '%1', '503');
        ObjAccount.SetFilter(ObjAccount.Balance, '>%1', 1);
        if ObjAccount.FindSet then begin
            ObjAccount.CalcFields(ObjAccount.Balance);
            if ObjAccountType.Get(ObjAccount."Account Type") then begin
                VarInterestEarned := ObjAccount.Balance * (ObjAccount."Interest rate" / 100 / 360);

                ObjGenLedgerSetup.Get;
                ObjGenSetUp.Get;


                JournalTemplate := 'GENERAL';
                JournalBatch := 'DEFAULT';
                DocNo := FnRunGetNextTransactionDocumentNo;

                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name", JournalTemplate);
                GenJournalLine.SetRange("Journal Batch Name", JournalBatch);
                if GenJournalLine.Find('-') then begin
                    GenJournalLine.DeleteAll;
                end;

                if VarProcessDate < ObjGenSetUp."Go Live Date" then begin
                    VarPostingDate := ObjGenSetUp."Go Live Date";
                end else
                    VarPostingDate := VarProcessDate;

                //============================================================================================1. Debit Expense GL Account
                LineNo := LineNo + 10000;
                FnCreateGnlJournalLine(JournalTemplate, JournalBatch, DocNo, LineNo, GenJournalLine."transaction type"::" ",
                GenJournalLine."account type"::"G/L Account", ObjAccountType."Interest Expense Account", VarPostingDate, VarInterestEarned, 'FOSA', '',
                'Fixed Deposit Interest Earned for ' + ObjAccount."No.", '', GenJournalLine."application source"::CBS);

                //============================================================================================2. Credit Payable GL Account
                LineNo := LineNo + 10000;
                FnCreateGnlJournalLine(JournalTemplate, JournalBatch, DocNo, LineNo, GenJournalLine."transaction type"::" ",
                GenJournalLine."account type"::"G/L Account", ObjAccountType."Interest Payable Account", VarPostingDate, VarInterestEarned * -1, 'FOSA', '',
                'Fixed Deposit Interest Earned for ' + ObjAccount."No.", '', GenJournalLine."application source"::CBS);

                //CU posting
                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name", JournalTemplate);
                GenJournalLine.SetRange("Journal Batch Name", JournalBatch);
                if GenJournalLine.Find('-') then
                    Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);

                //=============================================================Insert Interest Buffer Entries
                ObjInterestBuffer.Reset;
                ObjInterestBuffer.SetCurrentkey(ObjInterestBuffer.No);
                if ObjInterestBuffer.FindLast then begin
                    VarBufferEntryNo := ObjInterestBuffer.No + 1;
                end;

                ObjInterestBuffer.Init;
                ObjInterestBuffer.No := VarBufferEntryNo;
                ObjInterestBuffer."Account No" := ObjAccount."No.";
                ObjInterestBuffer."Account Type" := ObjAccount."Account Type";
                ObjInterestBuffer."Interest Date" := VarProcessDate;
                ObjInterestBuffer."Interest Amount" := VarInterestEarned;
                ObjInterestBuffer."Savings Account Type" := ObjInterestBuffer."savings account type"::"Fixed Deposit";
                ObjInterestBuffer."User ID" := UserId;
                if ObjInterestBuffer."Interest Amount" <> 0 then
                    ObjInterestBuffer.Insert(true);
            end;
        end;
    end;


    procedure FnRunPostInterestOnFixedMaturity(VarProcessDate: Date; VarAccountNo: Code[30])
    var
        ObjAccount: Record Vendor;
        ObjAccountType: Record "Account Types-Saving Products";
        VarInterestEarned: Decimal;
        LineNo: Integer;
        JournalTemplate: Code[30];
        JournalBatch: Code[30];
        DocNo: Code[30];
        ObjGenLedgerSetup: Record "General Ledger Setup";
        ObjInterestBuffer: Record "Interest Buffer";
        VarBufferEntryNo: Integer;
        ObjGenSetup: Record "Sacco General Set-Up";
        VarUntransferedInterest: Decimal;
        VarFDFOSAAccount: Text;
    begin
        ObjAccount.CalcFields(ObjAccount.Balance);
        ObjAccount.Reset;
        ObjAccount.SetRange(ObjAccount."No.", VarAccountNo);
        ObjAccount.SetFilter(ObjAccount."Account Type", '%1', '503');
        ObjAccount.SetFilter(ObjAccount.Balance, '>%1', 0);
        ObjAccount.SetFilter(ObjAccount."FD Maturity Date", '%1', VarProcessDate);

        ObjFDAccounts.Reset;
        ObjFDAccounts.SetRange(ObjFDAccounts."Fixed Deposit Account No", VarAccountNo);
        if ObjFDAccounts.FindLast then
            VarFDFOSAAccount := ObjFDAccounts."Account to Tranfers FD Amount";
        if ObjAccount.FindSet then begin
            ObjGenLedgerSetup.Get;
            ObjGenSetup.Get;
            JournalTemplate := 'GENERAL';
            JournalBatch := 'DEFAULT';
            DocNo := FnRunGetNextTransactionDocumentNo;

            GenJournalLine.Reset;
            GenJournalLine.SetRange("Journal Template Name", JournalTemplate);
            GenJournalLine.SetRange("Journal Batch Name", JournalBatch);
            if GenJournalLine.Find('-') then begin
                GenJournalLine.DeleteAll;
            end;

            ObjAccount.CalcFields(ObjAccount.Balance, ObjAccount."Untranfered Interest");
            VarUntransferedInterest := ObjAccount."Untranfered Interest";
            //============================================================================================1. Debit Payable GL Account
            if ObjAccountType.Get(ObjAccount."Account Type") then begin
                LineNo := LineNo + 10000;
                FnCreateGnlJournalLine(JournalTemplate, JournalBatch, DocNo, LineNo, GenJournalLine."transaction type"::" ",
                GenJournalLine."account type"::"G/L Account", ObjAccountType."Interest Payable Account", VarProcessDate, ObjAccount."Untranfered Interest",
                'FOSA', '', 'Fixed Deposit Interest Transfer to ' + ObjAccount."No.", '', GenJournalLine."application source"::CBS);

                //============================================================================================2. Credit Member FD Account
                LineNo := LineNo + 10000;
                FnCreateGnlJournalLine(JournalTemplate, JournalBatch, DocNo, LineNo, GenJournalLine."transaction type"::" ",
                GenJournalLine."account type"::Vendor, ObjAccount."No.", VarProcessDate, ObjAccount."Untranfered Interest" * -1,
                'FOSA', '', 'Fixed Deposit Interest Earned', '', GenJournalLine."application source"::CBS);

                //============================================================================================3. Tax: Debit Member FD Account
                LineNo := LineNo + 10000;
                FnCreateGnlJournalLine(JournalTemplate, JournalBatch, DocNo, LineNo, GenJournalLine."transaction type"::" ",
                GenJournalLine."account type"::Vendor, ObjAccount."No.", VarProcessDate, ObjAccount."Untranfered Interest" * (ObjGenSetup."Withholding Tax (%)" / 100), 'FOSA', '',
                'Tax: Fixed Deposit Interest Earned', '', GenJournalLine."application source"::CBS);

                //============================================================================================4. Tax:Credit Tax G/L Account
                LineNo := LineNo + 10000;
                FnCreateGnlJournalLine(JournalTemplate, JournalBatch, DocNo, LineNo, GenJournalLine."transaction type"::" ",
                GenJournalLine."account type"::"G/L Account", ObjGenSetup."WithHolding Tax Account", VarProcessDate,
                ObjAccount."Untranfered Interest" * (ObjGenSetup."Withholding Tax (%)" / 100) * -1, 'FOSA', '',
                'Tax: Fixed Deposit Interest Earned for ' + ObjAccount."No.", '', GenJournalLine."application source"::CBS);

                //CU posting
                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name", JournalTemplate);
                GenJournalLine.SetRange("Journal Batch Name", JournalBatch);
                if GenJournalLine.Find('-') then
                    Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);

                //=============================================================Insert Interest Buffer Entries
                ObjInterestBuffer.Reset;
                ObjInterestBuffer.SetRange(ObjInterestBuffer."Account No", ObjAccount."No.");
                if ObjInterestBuffer.FindSet then begin
                    repeat
                        ObjInterestBuffer.Transferred := true;
                        ObjInterestBuffer.Modify;
                    until ObjInterestBuffer.Next = 0;
                end;

                //===============================================================================Pay to FOSA Deposit & Interest
                if ObjAccount."On Term Deposit Maturity" = ObjAccount."on term deposit maturity"::"Pay to FOSA Account_ Deposit+Interest" then begin
                    JournalTemplate := 'GENERAL';
                    JournalBatch := 'DEFAULT';
                    DocNo := FnRunGetNextTransactionDocumentNo;

                    ObjAccount.CalcFields(ObjAccount.Balance);
                    //=====================================================================1. Debit Member FD Account
                    LineNo := LineNo + 10000;
                    FnCreateGnlJournalLine(JournalTemplate, JournalBatch, DocNo, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::Vendor, ObjAccount."No.", VarProcessDate, ObjAccount.Balance, 'FOSA', '',
                    'Fixed Deposit Transfer to ' + VarFDFOSAAccount, '', GenJournalLine."application source"::CBS);

                    //=====================================================================2. Credit Member FOSA Account
                    LineNo := LineNo + 10000;
                    FnCreateGnlJournalLine(JournalTemplate, JournalBatch, DocNo, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::Vendor, VarFDFOSAAccount, VarProcessDate, ObjAccount.Balance * -1, 'FOSA', '',
                    'Fixed Deposit Maturity from ' + ObjAccount."No.", '', GenJournalLine."application source"::CBS);

                    //CU posting
                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", JournalTemplate);
                    GenJournalLine.SetRange("Journal Batch Name", JournalBatch);
                    if GenJournalLine.Find('-') then
                        Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);

                end;
                //===============================================================================Pay to FOSA Deposit & Interest
                if ObjAccount."On Term Deposit Maturity" = ObjAccount."on term deposit maturity"::"Roll Back Deposit Only" then begin
                    JournalTemplate := 'GENERAL';
                    JournalBatch := 'DEFAULT';
                    DocNo := FnRunGetNextTransactionDocumentNo;

                    ObjAccount.CalcFields(ObjAccount.Balance);
                    //===================================================================1. Debit Member FD Account
                    LineNo := LineNo + 10000;
                    FnCreateGnlJournalLine(JournalTemplate, JournalBatch, DocNo, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::Vendor, ObjAccount."No.", VarProcessDate, VarUntransferedInterest, 'FOSA', '',
                    'Fixed Deposit Interest Transfer to ' + VarFDFOSAAccount, '', GenJournalLine."application source"::CBS);

                    //==================================================================2. Credit Member FOSA Account
                    LineNo := LineNo + 10000;
                    FnCreateGnlJournalLine(JournalTemplate, JournalBatch, DocNo, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::Vendor, VarFDFOSAAccount, VarProcessDate, VarUntransferedInterest * -1, 'FOSA', '',
                    'Fixed Deposit Interest Earned from ' + ObjAccount."No.", '', GenJournalLine."application source"::CBS);

                    //CU posting
                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", JournalTemplate);
                    GenJournalLine.SetRange("Journal Batch Name", JournalBatch);
                    if GenJournalLine.Find('-') then
                        Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
                end;
            end;
        end;
    end;


    procedure FnRunGetNextTransactionDocumentNo() VarDocumentNo: Code[30]
    var
        ObjNoSeries: Record "General Ledger Setup";
    begin
        if ObjNoSeries.Get then begin
            ObjNoSeries.TestField(ObjNoSeries."Transaction Document No");
            VarDocumentNo := NoSeriesMgt.GetNextNo(ObjNoSeries."Transaction Document No", 0D, true);
            exit(VarDocumentNo);
        end;
    end;


    procedure FnRunFixedAssetDisposal(VarAssetNo: Code[30]; VarDisposalDate: Date)
    var
        ObjFA: Record "Fixed Asset";
        ObjFADepreciationBook: Record "FA Depreciation Book";
        ObjFAPostingGroup: Record "FA Posting Group";
        FAJournalTemplate: Code[30];
        FAJournalBatch: Code[30];
        DocNo: Code[30];
        LineNo: Integer;
        VarBookValuePreDisposal: Decimal;
        VarDeprValuePreDisposal: Decimal;
        VarBookValueInitialCost: Decimal;
        ObjFADepreciationBookII: Record "FA Depreciation Book";
    begin
        ObjFA.Reset;
        ObjFA.SetRange(ObjFA."No.", VarAssetNo);
        if ObjFA.FindSet then begin
            ObjFADepreciationBook.CalcFields(ObjFADepreciationBook."Book Value");
            ObjFADepreciationBook.Reset;
            ObjFADepreciationBook.SetRange(ObjFADepreciationBook."FA No.", VarAssetNo);
            if ObjFADepreciationBook.FindSet then begin
                ObjFADepreciationBook.CalcFields(ObjFADepreciationBook."Book Value", ObjFADepreciationBook."Total Depr. Value to Date",
                 ObjFADepreciationBook."Acquisition Cost", ObjFADepreciationBook."Initial Cost Value");
                VarBookValuePreDisposal := ObjFADepreciationBook."Book Value";
                VarDeprValuePreDisposal := ObjFADepreciationBook."Total Depr. Value to Date";
                VarBookValueInitialCost := ObjFADepreciationBook."Initial Cost Value";

                FAJournalTemplate := 'ASSETS';
                FAJournalBatch := 'DEFAULT';
                DocNo := FnRunGetNextTransactionDocumentNo;

                FAJournalLine.Reset;
                FAJournalLine.SetRange("Journal Template Name", FAJournalTemplate);
                FAJournalLine.SetRange("Journal Batch Name", FAJournalBatch);
                if FAJournalLine.Find('-') then begin
                    FAJournalLine.DeleteAll;
                end;

                ObjFAPostingGroup.Reset;
                ObjFAPostingGroup.SetRange(ObjFAPostingGroup.Code, ObjFADepreciationBook."FA Posting Group");
                if ObjFAPostingGroup.FindSet then begin

                    //===================================================1. Asset Cumm. Depreciation On Disposal
                    LineNo := LineNo + 10000;
                    FnCreateFAGLJournalLineBalanced(FAJournalTemplate, FAJournalBatch, DocNo, LineNo, GenJournalLine."fa posting type"::Depreciation,
                    GenJournalLine."account type"::"Fixed Asset", VarAssetNo, VarDisposalDate, 'Cost Disposal of ' + VarAssetNo + ' - ' + ObjFA.Description,
                    GenJournalLine."bal. account type"::"G/L Account", ObjFAPostingGroup."Asset Disposal Account", (ObjFADepreciationBook."Total Depr. Value to Date" * -1), ObjFA."Global Dimension 1 Code", ObjFA."Global Dimension 2 Code");

                    //===================================================2.Asset Cost On Disposal
                    LineNo := LineNo + 10000;
                    FnCreateFAGLJournalLineBalanced(FAJournalTemplate, FAJournalBatch, DocNo, LineNo, GenJournalLine."fa posting type"::"Acquisition Cost",
                    GenJournalLine."account type"::"Fixed Asset", VarAssetNo, VarDisposalDate, 'Cumm. Depr Disposal of ' + VarAssetNo + ' - ' + ObjFA.Description,
                    GenJournalLine."bal. account type"::"G/L Account", ObjFAPostingGroup."Asset Disposal Account", ObjFADepreciationBook."Acquisition Cost" * -1, ObjFA."Global Dimension 1 Code", ObjFA."Global Dimension 2 Code");


                    //CU posting
                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", FAJournalTemplate);
                    GenJournalLine.SetRange("Journal Batch Name", FAJournalBatch);
                    if GenJournalLine.Find('-') then
                        Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);

                    ObjFADepreciationBookII.Reset;
                    ObjFADepreciationBookII.SetRange(ObjFADepreciationBookII."FA No.", VarAssetNo);
                    if ObjFADepreciationBookII.FindSet then begin
                        ObjFADepreciationBookII."Book Value on Disposal" := VarBookValuePreDisposal;
                        ObjFADepreciationBookII."Disposal Date" := VarDisposalDate;
                        ObjFADepreciationBookII."Disposal Salvage Value" := VarBookValuePreDisposal;
                        ObjFADepreciationBookII."Disposed/Writtenoff Cost" := VarBookValueInitialCost;
                        ObjFADepreciationBookII."Disposed/Writtenoff Depr" := VarDeprValuePreDisposal;
                        ObjFADepreciationBookII.Modify;
                    end;
                end;
            end;
        end;
    end;


    procedure FnRunFixedAssetWriteOff(VarAssetNo: Code[30]; VarDisposalDate: Date)
    var
        ObjFA: Record "Fixed Asset";
        ObjFADepreciationBook: Record "FA Depreciation Book";
        ObjFAPostingGroup: Record "FA Posting Group";
        FAJournalTemplate: Code[30];
        FAJournalBatch: Code[30];
        DocNo: Code[30];
        LineNo: Integer;
        VarBookValuePreDisposal: Decimal;
        VarDeprValuePreDisposal: Decimal;
        VarBookValueInitialCost: Decimal;
        ObjFADepreciationBookII: Record "FA Depreciation Book";
    begin
        ObjFA.Reset;
        ObjFA.SetRange(ObjFA."No.", VarAssetNo);
        if ObjFA.FindSet then begin
            ObjFADepreciationBook.CalcFields(ObjFADepreciationBook."Book Value");
            ObjFADepreciationBook.Reset;
            ObjFADepreciationBook.SetRange(ObjFADepreciationBook."FA No.", VarAssetNo);
            if ObjFADepreciationBook.FindSet then begin
                ObjFADepreciationBook.CalcFields(ObjFADepreciationBook."Book Value", ObjFADepreciationBook."Total Depr. Value to Date",
                 ObjFADepreciationBook."Acquisition Cost", ObjFADepreciationBook."Initial Cost Value");
                VarBookValuePreDisposal := ObjFADepreciationBook."Book Value";
                VarDeprValuePreDisposal := ObjFADepreciationBook."Total Depr. Value to Date";
                VarBookValueInitialCost := ObjFADepreciationBook."Initial Cost Value";

                FAJournalTemplate := 'ASSETS';
                FAJournalBatch := 'DEFAULT';
                DocNo := FnRunGetNextTransactionDocumentNo;

                FAJournalLine.Reset;
                FAJournalLine.SetRange("Journal Template Name", FAJournalTemplate);
                FAJournalLine.SetRange("Journal Batch Name", FAJournalBatch);
                if FAJournalLine.Find('-') then begin
                    FAJournalLine.DeleteAll;
                end;

                ObjFAPostingGroup.Reset;
                ObjFAPostingGroup.SetRange(ObjFAPostingGroup.Code, ObjFADepreciationBook."FA Posting Group");
                if ObjFAPostingGroup.FindSet then begin

                    //===================================================1. Asset Cumm. Depreciation On Writeoff
                    LineNo := LineNo + 10000;
                    FnCreateFAGLJournalLineBalanced(FAJournalTemplate, FAJournalBatch, DocNo, LineNo, GenJournalLine."fa posting type"::Depreciation,
                    GenJournalLine."account type"::"Fixed Asset", VarAssetNo, VarDisposalDate, 'Cost Writeoff of ' + VarAssetNo + ' - ' + ObjFA.Description,
                    GenJournalLine."bal. account type"::"G/L Account", ObjFAPostingGroup."Asset Writeoff Account", (ObjFADepreciationBook."Total Depr. Value to Date" * -1), ObjFA."Global Dimension 1 Code", ObjFA."Global Dimension 2 Code");

                    //===================================================2.Asset Cost On Writeoff
                    LineNo := LineNo + 10000;
                    FnCreateFAGLJournalLineBalanced(FAJournalTemplate, FAJournalBatch, DocNo, LineNo, GenJournalLine."fa posting type"::"Acquisition Cost",
                    GenJournalLine."account type"::"Fixed Asset", VarAssetNo, VarDisposalDate, 'Cumm. Depr Writeoff of ' + VarAssetNo + ' - ' + ObjFA.Description,
                    GenJournalLine."bal. account type"::"G/L Account", ObjFAPostingGroup."Asset Writeoff Account", ObjFADepreciationBook."Acquisition Cost" * -1, ObjFA."Global Dimension 1 Code", ObjFA."Global Dimension 2 Code");


                    //CU posting
                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", FAJournalTemplate);
                    GenJournalLine.SetRange("Journal Batch Name", FAJournalBatch);
                    if GenJournalLine.Find('-') then
                        Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);

                    ObjFADepreciationBookII.Reset;
                    ObjFADepreciationBookII.SetRange(ObjFADepreciationBookII."FA No.", VarAssetNo);
                    if ObjFADepreciationBookII.FindSet then begin
                        ObjFADepreciationBookII."Book Value on Disposal" := VarBookValuePreDisposal;
                        ObjFADepreciationBookII."Disposal Date" := VarDisposalDate;
                        ObjFADepreciationBookII."Disposal Salvage Value" := VarBookValuePreDisposal;
                        ObjFADepreciationBookII."Disposed/Writtenoff Cost" := VarBookValueInitialCost;
                        ObjFADepreciationBookII."Disposed/Writtenoff Depr" := VarDeprValuePreDisposal;
                        ObjFADepreciationBookII.Modify;
                    end;
                end;
            end;
        end;

    end;


    procedure FnCreateFAGLJournalLineBalanced(TemplateName: Text; BatchName: Text; DocumentNo: Code[30]; LineNo: Integer; FAPostingType: enum "Gen. Journal Line FA Posting Type"; AccountType: enum "Gen. Journal Account Type"; AccountNo: Code[50]; TransactionDate: Date; TransactionDescription: Text; BalancingAccountType: Enum "Gen. Journal Account Type"; BalancingAccountNo: Code[50]; TransactionAmount: Decimal; DimensionActivity: Code[40]; DimensionBranch: Code[40])
    var
        GeneralJournals: Record "Gen. Journal Line";
    begin
        GeneralJournals.Init;
        GeneralJournals."Journal Template Name" := TemplateName;
        GeneralJournals."Journal Batch Name" := BatchName;
        GeneralJournals."Document No." := DocumentNo;
        GeneralJournals."Line No." := LineNo;
        GeneralJournals."FA Posting Type" := FAPostingType;
        GeneralJournals."Account Type" := AccountType;
        GeneralJournals."Account No." := AccountNo;
        GeneralJournals.Validate(GeneralJournals."Account No.");
        GeneralJournals."Posting Date" := TransactionDate;
        GeneralJournals.Description := TransactionDescription;
        GeneralJournals.Amount := TransactionAmount;
        GeneralJournals.Validate(GeneralJournals.Amount);
        GeneralJournals."Bal. Account Type" := BalancingAccountType;
        GeneralJournals."Bal. Account No." := BalancingAccountNo;
        GeneralJournals."Shortcut Dimension 1 Code" := DimensionActivity;
        GeneralJournals."Shortcut Dimension 2 Code" := DimensionBranch;
        GeneralJournals.Validate(GeneralJournals."Shortcut Dimension 1 Code");
        GeneralJournals.Validate(GeneralJournals."Shortcut Dimension 2 Code");
        if GeneralJournals.Amount <> 0 then
            GeneralJournals.Insert;
    end;


    procedure FnCreateLoanRecoveryJournalsAdvance(VarLoanNoRecovered: Code[30]; BATCH_TEMPLATE: Code[20]; BATCH_NAME: Code[20]; DOCUMENT_NO: Code[20]; VarMemberNo: Code[20]; VarPostingDate: Date; EXTERNAL_DOC_NO: Code[30]; VarLoanSettlementAcc: Code[30]; VarMemberName: Text[100]; RunningBalance: Decimal)
    var
        ObjLoans: Record "Loans Register";
        AmountToDeduct: Decimal;
        LineNo: Integer;
        SFactory: Codeunit "SURESTEP Factory";
        VarAmounttoDeduct: Decimal;
        VarOutstandingInterest: Decimal;
        VarEndYear: Date;
        VarInsuranceMonths: Integer;
        ObjProductCharge: Record "Loan Product Charges";
        VarInsurancePayoff: Decimal;
        VarOutstandingInsurance: Decimal;
        VarLoanInsuranceBalAccount: Code[30];
        ObjLoanType: Record "Loan Products Setup";
        ObjLoanSchedule: Record "Loan Repayment Schedule";
        VarLoanInsuranceCharged: Decimal;
        VarLoanInsurancePaid: Decimal;
        VarTotalOutstandingInsurance: Decimal;
        VarLoanInterestDueBalAccount: Code[30];
        VarOutstandingPenalty: Decimal;
        VarLoanPenaltyBalAccount: Code[30];
        VarLoanDueAmount: Decimal;
        VarDebtCollectorBaseAmount: Decimal;
        VarDebtCollectorFee: Decimal;
        ObjLoanRepaymentschedule: Record "Loan Repayment Schedule";
        VarLastInstalmentDueDate: Date;
        ObjLoanInterestAccrued: Record "Interest Due Ledger Entry";
        VarTotalInterestAccrued: Decimal;
        VarAmountinArrearsInterest: Decimal;
        VarEndMonthDate: Date;
    begin
        VarEndMonthDate := CalcDate('CM', WorkDate);
        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
        GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
        GenJournalLine.DeleteAll;

        //DOCUMENT_NO:=FnRunGetNextTransactionDocumentNo;

        //============================================================Debt Collector Fee
        if RunningBalance > 0 then begin
            if ObjLoans.Get(VarLoanNoRecovered) then begin
                ObjVendor.Reset;
                ObjVendor.SetRange(ObjVendor."No.", ObjLoans."Loan Debt Collector");
                if ObjVendor.FindSet then begin
                    VarDebtCollectorFee := SFactory.FnRunGetLoanDebtCollectorFee(VarLoanNoRecovered, RunningBalance);

                    if RunningBalance > VarDebtCollectorFee then begin
                        AmountToDeduct := VarDebtCollectorFee
                    end else
                        AmountToDeduct := RunningBalance;

                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLineGuarantorRecovery(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::Vendor, ObjLoans."Loan Debt Collector", VarPostingDate, AmountToDeduct * -1, 'BOSA', EXTERNAL_DOC_NO,
                    'Debt Collection Charge + VAT from ' + VarLoanNoRecovered + ' ' + ObjLoans."Client Name", VarLoanNoRecovered, GenJournalLine."recovery transaction type"::"Guarantor Recoverd", VarLoanNoRecovered);

                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLineGuarantorRecovery(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::Vendor, VarLoanSettlementAcc, VarPostingDate, AmountToDeduct, 'BOSA', EXTERNAL_DOC_NO,
                    'Debt Collection Charge + VAT from ' + VarLoanNoRecovered + ' ' + ObjLoans."Client Name", VarLoanNoRecovered, GenJournalLine."recovery transaction type"::"Guarantor Recoverd", VarLoanNoRecovered);
                    RunningBalance := RunningBalance - AmountToDeduct;
                end;
            end;
        end;

        //============================================================Loan Penalty Repayment
        if RunningBalance > 0 then begin
            ObjLoans.Reset;
            ObjLoans.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
            ObjLoans.SetRange(ObjLoans."Loan  No.", VarLoanNoRecovered);
            if ObjLoans.Find('-') then begin
                ObjLoans.CalcFields(ObjLoans."Outstanding Balance", ObjLoans."Penalty Charged", ObjLoans."Penalty Paid", ObjLoans."Penalty Paid Historical");
                if RunningBalance > 0 then begin
                    AmountToDeduct := 0;

                    VarOutstandingPenalty := ObjLoans."Penalty Charged" - (ObjLoans."Penalty Paid" + ObjLoans."Penalty Paid Historical");
                    if VarOutstandingPenalty < 0 then
                        VarOutstandingPenalty := 0;

                    if VarOutstandingPenalty > 0 then begin
                        if VarOutstandingPenalty < RunningBalance then begin
                            AmountToDeduct := VarOutstandingPenalty
                        end else
                            AmountToDeduct := RunningBalance;
                        AmountToDeduct := ROUND(AmountToDeduct, 0.01, '=');

                        if ObjLoanType.Get(ObjLoans."Loan Product Type") then begin
                            VarLoanPenaltyBalAccount := ObjLoanType."Penalty Paid Account";
                        end;



                        //------------------------------------Debit Loan Penalty Charged---------------------------------------------------------------------------------------------
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLineBalanced(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Penalty Charged",
                        GenJournalLine."account type"::Member, ObjLoans."Client Code", WorkDate, 'Loan Penalty Charged - ' + VarLoanNoRecovered, GenJournalLine."bal. account type"::"G/L Account",
                        VarLoanPenaltyBalAccount, AmountToDeduct, 'BOSA', VarLoanNoRecovered);
                        //--------------------------------Debit Loan Penalty Charged-------------------------------------------------------------------------------

                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLineGuarantorRecovery(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Penalty Paid",
                        GenJournalLine."account type"::Member, VarMemberNo, VarPostingDate, AmountToDeduct * -1, 'BOSA', EXTERNAL_DOC_NO,
                        'Loan Penalty Paid - ' + VarLoanNoRecovered, VarLoanNoRecovered, GenJournalLine."recovery transaction type"::"Guarantor Recoverd", VarLoanNoRecovered);

                        RunningBalance := RunningBalance - AmountToDeduct;
                        VarAmounttoDeduct := VarAmounttoDeduct + AmountToDeduct;
                    end;
                end;
            end;
        end;

        //============================================================Loan Interest Repayment
        if RunningBalance > 0 then begin
            ObjLoans.Reset;
            ObjLoans.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
            ObjLoans.SetRange(ObjLoans."Loan  No.", VarLoanNoRecovered);
            if ObjLoans.Find('-') then begin

                //====================================================Get Loan Interest In Arrears
                ObjLoanRepaymentschedule.Reset;
                ObjLoanRepaymentschedule.SetCurrentkey(ObjLoanRepaymentschedule."Repayment Date");
                ObjLoanRepaymentschedule.SetRange(ObjLoanRepaymentschedule."Loan No.", VarLoanNoRecovered);
                ObjLoanRepaymentschedule.SetFilter(ObjLoanRepaymentschedule."Repayment Date", '<=%1', VarEndMonthDate);
                if ObjLoanRepaymentschedule.FindLast then begin
                    VarLastInstalmentDueDate := ObjLoanRepaymentschedule."Repayment Date";
                end;

                if VarLastInstalmentDueDate < 20180110D then
                    VarLastInstalmentDueDate := 20180110D;

                ObjLoanInterestAccrued.Reset;
                ObjLoanInterestAccrued.SetRange(ObjLoanInterestAccrued."Loan No", VarLoanNoRecovered);
                ObjLoanInterestAccrued.SetFilter(ObjLoanInterestAccrued."Posting Date", '<=%1', VarLastInstalmentDueDate);
                if ObjLoanInterestAccrued.FindSet then begin
                    repeat
                        VarTotalInterestAccrued := VarTotalInterestAccrued + ObjLoanInterestAccrued.Amount;
                    until ObjLoanInterestAccrued.Next = 0;

                end;

                ObjLoans.CalcFields(ObjLoans."Outstanding Balance", ObjLoans."Interest Due", ObjLoans."Interest Paid", ObjLoans."Penalty Charged",
                ObjLoans."Penalty Paid", ObjLoans."Interest Paid Historical");
                VarAmountinArrearsInterest := VarTotalInterestAccrued - (ObjLoans."Interest Paid" + ObjLoans."Interest Paid Historical");
                if VarAmountinArrearsInterest < 0 then
                    VarAmountinArrearsInterest := 0;
                //====================================================Get Loan Interest In Arrears


                if RunningBalance > 0 then begin
                    VarOutstandingInterest := VarAmountinArrearsInterest;
                    if VarOutstandingInterest < 0 then
                        VarOutstandingInterest := 0;

                    AmountToDeduct := 0;
                    if VarOutstandingInterest > 0 then begin
                        if VarOutstandingInterest < RunningBalance then begin
                            AmountToDeduct := VarOutstandingInterest
                        end else
                            AmountToDeduct := RunningBalance;
                        AmountToDeduct := ROUND(AmountToDeduct, 0.01, '=');


                        if ObjLoanType.Get(ObjLoans."Loan Product Type") then begin
                            VarLoanInterestDueBalAccount := ObjLoanType."Loan Interest Account";
                        end;

                        //------------------------------------Debit Loan Interest Due---------------------------------------------------------------------------------------------
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLineBalanced(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Interest Due",
                        GenJournalLine."account type"::Member, VarMemberNo, VarPostingDate, 'Loan Interest Charged - ' + VarLoanNoRecovered, GenJournalLine."bal. account type"::"G/L Account",
                        VarLoanInterestDueBalAccount, AmountToDeduct, 'BOSA', VarLoanNoRecovered);

                        //--------------------------------Debit Loan Interest Due-------------------------------------------------------------------------------
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLineGuarantorRecovery(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Interest Paid",
                        GenJournalLine."account type"::Member, VarMemberNo, VarPostingDate, AmountToDeduct * -1, 'BOSA', EXTERNAL_DOC_NO,
                        'Loan Interest Paid - ' + VarLoanNoRecovered, VarLoanNoRecovered, GenJournalLine."recovery transaction type"::"Guarantor Recoverd", VarLoanNoRecovered);

                        RunningBalance := RunningBalance - AmountToDeduct;
                        VarAmounttoDeduct := VarAmounttoDeduct + AmountToDeduct;
                    end;
                end;
            end;
        end;


        //============================================================Loan Insurance Repayment

        if RunningBalance > 0 then begin

            ObjLoans.Reset;
            ObjLoans.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
            ObjLoans.SetRange(ObjLoans."Loan  No.", VarLoanNoRecovered);
            if ObjLoans.Find('-') then begin

                ObjLoans.Reset;
                ObjLoans.SetRange(ObjLoans."Loan  No.", VarLoanNoRecovered);
                if ObjLoans.FindSet then begin
                    ObjLoans.CalcFields(ObjLoans."Outstanding Balance", ObjLoans."Penalty Charged", ObjLoans."Penalty Paid", ObjLoans."Interest Due",
                    ObjLoans."Interest Paid", ObjLoans."Insurance Paid Historical");

                    if (ObjLoans."Outstanding Balance" <> 0) and (ObjLoans."Loan Status" = ObjLoans."loan status"::Disbursed) then begin
                        VarEndYear := CalcDate('CY', Today);

                        ObjLoanSchedule.Reset;
                        ObjLoanSchedule.SetRange(ObjLoanSchedule."Loan No.", VarLoanNoRecovered);
                        ObjLoanSchedule.SetFilter(ObjLoanSchedule."Repayment Date", '>%1&<=%2', WorkDate, VarEndYear);
                        if ObjLoanSchedule.FindSet then begin
                            ObjLoanSchedule.CalcSums(ObjLoanSchedule."Monthly Insurance");
                            VarInsurancePayoff := ObjLoanSchedule."Monthly Insurance";
                        end;
                    end;
                end;

                FnGetLoanArrearsAmountII(VarLoanNoRecovered);//===========================Get Amount In Arrears

                ObjLoanSchedule.Reset;
                ObjLoanSchedule.SetRange(ObjLoanSchedule."Loan No.", VarLoanNoRecovered);
                ObjLoanSchedule.SetFilter(ObjLoanSchedule."Repayment Date", '<=%1', VarEndMonthDate);
                if ObjLoanSchedule.FindSet then begin
                    repeat
                        VarLoanInsuranceCharged := VarLoanInsuranceCharged + ObjLoanSchedule."Monthly Insurance";
                        VarLoanInsurancePaid := VarLoanInsurancePaid + ObjLoanSchedule."Insurance Paid";
                    until ObjLoanSchedule.Next = 0;
                end;

                VarOutstandingInsurance := VarLoanInsuranceCharged - VarLoanInsurancePaid;
                if ObjLoans."Loan Status" <> ObjLoans."loan status"::Disbursed then
                    VarOutstandingInsurance := 0;

                if RunningBalance > 0 then begin
                    AmountToDeduct := 0;

                    VarTotalOutstandingInsurance := VarOutstandingInsurance;//+VarInsurancePayoff;

                    if VarTotalOutstandingInsurance > 0 then begin
                        if VarTotalOutstandingInsurance < RunningBalance then begin
                            AmountToDeduct := VarTotalOutstandingInsurance
                        end else
                            AmountToDeduct := RunningBalance;
                        AmountToDeduct := ROUND(AmountToDeduct, 0.01, '=');

                        if ObjLoanType.Get(ObjLoans."Loan Product Type") then begin
                            VarLoanInsuranceBalAccount := ObjLoanType."Loan Insurance Accounts";
                        end;

                        //------------------------------------Debit Loan Insurance Due---------------------------------------------------------------------------------------------
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLineBalanced(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Insurance Charged",
                        GenJournalLine."account type"::Member, ObjLoans."Client Code", WorkDate, 'Loan Insurance Charged - ' + VarLoanNoRecovered, GenJournalLine."bal. account type"::"G/L Account",
                        VarLoanInsuranceBalAccount, AmountToDeduct, 'BOSA', VarLoanNoRecovered);
                        //--------------------------------Debit Loan Insurance Due-------------------------------------------------------------------------------

                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLineGuarantorRecovery(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Insurance Paid",
                        GenJournalLine."account type"::Member, VarMemberNo, VarPostingDate, AmountToDeduct * -1, 'BOSA', EXTERNAL_DOC_NO,
                        'Loan Insurance Paid - ' + VarLoanNoRecovered, VarLoanNoRecovered, GenJournalLine."recovery transaction type"::"Guarantor Recoverd", VarLoanNoRecovered);

                        RunningBalance := RunningBalance - AmountToDeduct;
                        VarAmounttoDeduct := VarAmounttoDeduct + AmountToDeduct;
                    end;
                end;
            end;
        end;



        //============================================================Loan Principle Repayment
        if RunningBalance > 0 then begin
            ObjLoans.Reset;
            ObjLoans.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
            ObjLoans.SetRange(ObjLoans."Loan  No.", VarLoanNoRecovered);
            if ObjLoans.Find('-') then begin
                ObjLoans.CalcFields(ObjLoans."Outstanding Balance", ObjLoans."Penalty Charged", ObjLoans."Penalty Paid");
                if RunningBalance > 0 then begin
                    AmountToDeduct := 0;
                    if ObjLoans."Outstanding Balance" > 0 then begin
                        if ObjLoans."Outstanding Balance" < RunningBalance then begin
                            AmountToDeduct := ObjLoans."Outstanding Balance"
                        end else
                            AmountToDeduct := RunningBalance;
                        AmountToDeduct := ROUND(AmountToDeduct, 0.01, '=');

                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLineGuarantorRecovery(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Repayment",
                        GenJournalLine."account type"::Member, VarMemberNo, VarPostingDate, AmountToDeduct * -1, 'BOSA', EXTERNAL_DOC_NO,
                        'Loan Principal Repayment - ' + VarLoanNoRecovered, VarLoanNoRecovered, GenJournalLine."recovery transaction type"::"Guarantor Recoverd", VarLoanNoRecovered);
                        RunningBalance := RunningBalance - AmountToDeduct;
                        VarAmounttoDeduct := VarAmounttoDeduct + AmountToDeduct;
                        VarAmounttoDeduct := ROUND(VarAmounttoDeduct, 0.01, '=');
                    end;
                end;
            end;
        end;


        if ObjLoans.Get(VarLoanNoRecovered) then begin
            //==============================================================================================Recover From Loan Settlement Account
            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
            GenJournalLine."account type"::Vendor, VarLoanSettlementAcc, VarPostingDate, VarAmounttoDeduct, 'BOSA', EXTERNAL_DOC_NO,
            'Loan Repayment - ' + VarLoanNoRecovered + ' ' + ObjLoans."Loan Product Type Name", '', GenJournalLine."application source"::" ");
            //==============================================================================================End Recover From Loan Settlement Account
        end;
    end;


    procedure FnCreateLoanRecoveryJournalsLoanRestructure(VarLoanNoRecovered: Code[30]; BATCH_TEMPLATE: Code[20]; BATCH_NAME: Code[20]; DOCUMENT_NO: Code[20]; VarMemberNo: Code[20]; VarPostingDate: Date; EXTERNAL_DOC_NO: Code[30]; VarLoanSettlementAcc: Code[30]; VarMemberName: Text[100]; RunningBalance: Decimal)
    var
        ObjLoans: Record "Loans Register";
        AmountToDeduct: Decimal;
        LineNo: Integer;
        SFactory: Codeunit "SURESTEP Factory";
        VarAmounttoDeduct: Decimal;
        VarOutstandingInterest: Decimal;
        VarEndYear: Date;
        VarInsuranceMonths: Integer;
        ObjProductCharge: Record "Loan Product Charges";
        VarInsurancePayoff: Decimal;
        VarOutstandingInsurance: Decimal;
        VarLoanInsuranceBalAccount: Code[30];
        ObjLoanType: Record "Loan Products Setup";
        ObjLoanSchedule: Record "Loan Repayment Schedule";
        VarLoanInsuranceCharged: Decimal;
        VarLoanInsurancePaid: Decimal;
        VarTotalOutstandingInsurance: Decimal;
        VarLoanInterestDueBalAccount: Code[30];
        VarOutstandingPenalty: Decimal;
        VarLoanPenaltyBalAccount: Code[30];
        VarLoanDueAmount: Decimal;
        VarDebtCollectorBaseAmount: Decimal;
        VarDebtCollectorFee: Decimal;
        ObjLoanRepaymentschedule: Record "Loan Repayment Schedule";
        VarLastInstalmentDueDate: Date;
        ObjLoanInterestAccrued: Record "Interest Due Ledger Entry";
        VarTotalInterestAccrued: Decimal;
        VarAmountinArrearsInterest: Decimal;
    begin
        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
        GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
        GenJournalLine.DeleteAll;

        DOCUMENT_NO := FnRunGetNextTransactionDocumentNo;

        //============================================================Debt Collector Fee
        if RunningBalance > 0 then begin
            if ObjLoans.Get(VarLoanNoRecovered) then begin
                ObjVendor.Reset;
                ObjVendor.SetRange(ObjVendor."No.", ObjLoans."Loan Debt Collector");
                if ObjVendor.FindSet then begin
                    VarDebtCollectorFee := SFactory.FnRunGetLoanDebtCollectorFee(VarLoanNoRecovered, RunningBalance);

                    if RunningBalance > VarDebtCollectorFee then begin
                        AmountToDeduct := VarDebtCollectorFee
                    end else
                        AmountToDeduct := RunningBalance;

                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLineGuarantorRecovery(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::Vendor, ObjLoans."Loan Debt Collector", VarPostingDate, AmountToDeduct * -1, 'BOSA', EXTERNAL_DOC_NO,
                    'Debt Collection Charge + VAT from ' + VarLoanNoRecovered + ' ' + ObjLoans."Client Name", VarLoanNoRecovered, GenJournalLine."recovery transaction type"::"Guarantor Recoverd", VarLoanNoRecovered);

                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLineGuarantorRecovery(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::Vendor, VarLoanSettlementAcc, VarPostingDate, AmountToDeduct, 'BOSA', EXTERNAL_DOC_NO,
                    'Debt Collection Charge + VAT from ' + VarLoanNoRecovered + ' ' + ObjLoans."Client Name", VarLoanNoRecovered, GenJournalLine."recovery transaction type"::"Guarantor Recoverd", VarLoanNoRecovered);
                    RunningBalance := RunningBalance - AmountToDeduct;
                end;
            end;
        end;

        //============================================================Loan Penalty Repayment
        if RunningBalance > 0 then begin
            ObjLoans.Reset;
            ObjLoans.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
            ObjLoans.SetRange(ObjLoans."Loan  No.", VarLoanNoRecovered);
            if ObjLoans.Find('-') then begin
                ObjLoans.CalcFields(ObjLoans."Outstanding Balance", ObjLoans."Penalty Charged", ObjLoans."Penalty Paid", ObjLoans."Penalty Paid Historical");
                if RunningBalance > 0 then begin
                    AmountToDeduct := 0;

                    VarOutstandingPenalty := ObjLoans."Penalty Charged" - (ObjLoans."Penalty Paid" + ObjLoans."Penalty Paid Historical");
                    if VarOutstandingPenalty < 0 then
                        VarOutstandingPenalty := 0;

                    if VarOutstandingPenalty > 0 then begin
                        if VarOutstandingPenalty < RunningBalance then begin
                            AmountToDeduct := VarOutstandingPenalty
                        end else
                            AmountToDeduct := RunningBalance;
                        AmountToDeduct := ROUND(AmountToDeduct, 0.01, '=');

                        if ObjLoanType.Get(ObjLoans."Loan Product Type") then begin
                            VarLoanPenaltyBalAccount := ObjLoanType."Loan Penalty Restructure A/C";
                        end;



                        //------------------------------------Debit Loan Penalty Charged---------------------------------------------------------------------------------------------
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLineBalanced(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Penalty Charged",
                        GenJournalLine."account type"::Member, ObjLoans."Client Code", WorkDate, 'Loan Penalty Charged - ' + VarLoanNoRecovered, GenJournalLine."bal. account type"::"G/L Account",
                        VarLoanPenaltyBalAccount, AmountToDeduct, 'BOSA', VarLoanNoRecovered);
                        //--------------------------------Debit Loan Penalty Charged-------------------------------------------------------------------------------

                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLineGuarantorRecovery(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Penalty Paid",
                        GenJournalLine."account type"::Member, VarMemberNo, VarPostingDate, AmountToDeduct * -1, 'BOSA', EXTERNAL_DOC_NO,
                        'Loan Penalty Paid - ' + VarLoanNoRecovered, VarLoanNoRecovered, GenJournalLine."recovery transaction type"::"Guarantor Recoverd", VarLoanNoRecovered);

                        RunningBalance := RunningBalance - AmountToDeduct;
                        VarAmounttoDeduct := VarAmounttoDeduct + AmountToDeduct;
                    end;
                end;
            end;
        end;

        //============================================================Loan Interest Repayment
        if RunningBalance > 0 then begin
            ObjLoans.Reset;
            ObjLoans.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
            ObjLoans.SetRange(ObjLoans."Loan  No.", VarLoanNoRecovered);
            if ObjLoans.Find('-') then begin

                //====================================================Get Loan Interest In Arrears
                ObjLoanRepaymentschedule.Reset;
                ObjLoanRepaymentschedule.SetCurrentkey(ObjLoanRepaymentschedule."Repayment Date");
                ObjLoanRepaymentschedule.SetRange(ObjLoanRepaymentschedule."Loan No.", VarLoanNoRecovered);
                ObjLoanRepaymentschedule.SetFilter(ObjLoanRepaymentschedule."Repayment Date", '<=%1', CalcDate('CM', WorkDate));
                if ObjLoanRepaymentschedule.FindLast then begin
                    VarLastInstalmentDueDate := ObjLoanRepaymentschedule."Repayment Date";
                end;

                if VarLastInstalmentDueDate < 20180110D then
                    VarLastInstalmentDueDate := 20180110D;

                ObjLoanInterestAccrued.Reset;
                ObjLoanInterestAccrued.SetRange(ObjLoanInterestAccrued."Loan No", VarLoanNoRecovered);
                ObjLoanInterestAccrued.SetFilter(ObjLoanInterestAccrued."Posting Date", '<=%1', VarLastInstalmentDueDate);
                if ObjLoanInterestAccrued.FindSet then begin
                    repeat
                        VarTotalInterestAccrued := VarTotalInterestAccrued + ObjLoanInterestAccrued.Amount;
                    until ObjLoanInterestAccrued.Next = 0;

                end;

                ObjLoans.CalcFields(ObjLoans."Outstanding Balance", ObjLoans."Interest Due", ObjLoans."Interest Paid", ObjLoans."Penalty Charged",
                ObjLoans."Penalty Paid", ObjLoans."Interest Paid Historical");
                VarAmountinArrearsInterest := VarTotalInterestAccrued - (ObjLoans."Interest Paid" + ObjLoans."Interest Paid Historical");
                if VarAmountinArrearsInterest < 0 then
                    VarAmountinArrearsInterest := 0;
                //====================================================Get Loan Interest In Arrears


                if RunningBalance > 0 then begin
                    VarOutstandingInterest := VarAmountinArrearsInterest;
                    if VarOutstandingInterest < 0 then
                        VarOutstandingInterest := 0;

                    AmountToDeduct := 0;
                    if VarOutstandingInterest > 0 then begin
                        if VarOutstandingInterest < RunningBalance then begin
                            AmountToDeduct := VarOutstandingInterest
                        end else
                            AmountToDeduct := RunningBalance;
                        AmountToDeduct := ROUND(AmountToDeduct, 0.01, '=');


                        if ObjLoanType.Get(ObjLoans."Loan Product Type") then begin
                            VarLoanInterestDueBalAccount := ObjLoanType."Loan Interest Restructure A/C";
                        end;

                        //------------------------------------Debit Loan Interest Due---------------------------------------------------------------------------------------------
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLineBalanced(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Interest Due",
                        GenJournalLine."account type"::Member, VarMemberNo, VarPostingDate, 'Loan Interest Charged - ' + VarLoanNoRecovered, GenJournalLine."bal. account type"::"G/L Account",
                        VarLoanInterestDueBalAccount, AmountToDeduct, 'BOSA', VarLoanNoRecovered);

                        //--------------------------------Debit Loan Interest Due-------------------------------------------------------------------------------
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLineGuarantorRecovery(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Interest Paid",
                        GenJournalLine."account type"::Member, VarMemberNo, VarPostingDate, AmountToDeduct * -1, 'BOSA', EXTERNAL_DOC_NO,
                        'Loan Interest Paid - ' + VarLoanNoRecovered, VarLoanNoRecovered, GenJournalLine."recovery transaction type"::"Guarantor Recoverd", VarLoanNoRecovered);

                        RunningBalance := RunningBalance - AmountToDeduct;
                        VarAmounttoDeduct := VarAmounttoDeduct + AmountToDeduct;
                    end;
                end;
            end;
        end;


        //============================================================Loan Insurance Repayment

        if RunningBalance > 0 then begin

            ObjLoans.Reset;
            ObjLoans.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
            ObjLoans.SetRange(ObjLoans."Loan  No.", VarLoanNoRecovered);
            if ObjLoans.Find('-') then begin

                ObjLoans.Reset;
                ObjLoans.SetRange(ObjLoans."Loan  No.", VarLoanNoRecovered);
                if ObjLoans.FindSet then begin
                    ObjLoans.CalcFields(ObjLoans."Outstanding Balance", ObjLoans."Penalty Charged", ObjLoans."Penalty Paid", ObjLoans."Interest Due",
                    ObjLoans."Interest Paid", ObjLoans."Insurance Paid Historical");

                    if (ObjLoans."Outstanding Balance" <> 0) and (ObjLoans."Loan Status" = ObjLoans."loan status"::Disbursed) then begin
                        VarEndYear := CalcDate('CY', Today);

                        ObjLoanSchedule.Reset;
                        ObjLoanSchedule.SetRange(ObjLoanSchedule."Loan No.", VarLoanNoRecovered);
                        ObjLoanSchedule.SetFilter(ObjLoanSchedule."Repayment Date", '>%1&<=%2', WorkDate, VarEndYear);
                        if ObjLoanSchedule.FindSet then begin
                            ObjLoanSchedule.CalcSums(ObjLoanSchedule."Monthly Insurance");
                            VarInsurancePayoff := ObjLoanSchedule."Monthly Insurance";
                        end;
                    end;
                end;

                FnGetLoanArrearsAmountII(VarLoanNoRecovered);//===========================Get Amount In Arrears

                ObjLoanSchedule.Reset;
                ObjLoanSchedule.SetRange(ObjLoanSchedule."Loan No.", VarLoanNoRecovered);
                ObjLoanSchedule.SetFilter(ObjLoanSchedule."Repayment Date", '<=%1', WorkDate);
                if ObjLoanSchedule.FindSet then begin
                    repeat
                        VarLoanInsuranceCharged := VarLoanInsuranceCharged + ObjLoanSchedule."Monthly Insurance";
                        VarLoanInsurancePaid := VarLoanInsurancePaid + ObjLoanSchedule."Insurance Paid";
                    until ObjLoanSchedule.Next = 0;
                end;

                VarOutstandingInsurance := VarLoanInsuranceCharged - VarLoanInsurancePaid;
                if ObjLoans."Loan Status" <> ObjLoans."loan status"::Disbursed then
                    VarOutstandingInsurance := 0;

                if RunningBalance > 0 then begin
                    AmountToDeduct := 0;

                    VarTotalOutstandingInsurance := VarOutstandingInsurance;//+VarInsurancePayoff;

                    if VarTotalOutstandingInsurance > 0 then begin
                        if VarTotalOutstandingInsurance < RunningBalance then begin
                            AmountToDeduct := VarTotalOutstandingInsurance
                        end else
                            AmountToDeduct := RunningBalance;
                        AmountToDeduct := ROUND(AmountToDeduct, 0.01, '=');

                        if ObjLoanType.Get(ObjLoans."Loan Product Type") then begin
                            VarLoanInsuranceBalAccount := ObjLoanType."Loan Insurance Restructure A/C";
                        end;

                        //------------------------------------Debit Loan Insurance Due---------------------------------------------------------------------------------------------
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLineBalanced(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Insurance Charged",
                        GenJournalLine."account type"::Member, ObjLoans."Client Code", WorkDate, 'Loan Insurance Charged - ' + VarLoanNoRecovered, GenJournalLine."bal. account type"::"G/L Account",
                        VarLoanInsuranceBalAccount, AmountToDeduct, 'BOSA', VarLoanNoRecovered);
                        //--------------------------------Debit Loan Insurance Due-------------------------------------------------------------------------------

                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLineGuarantorRecovery(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Insurance Paid",
                        GenJournalLine."account type"::Member, VarMemberNo, VarPostingDate, AmountToDeduct * -1, 'BOSA', EXTERNAL_DOC_NO,
                        'Loan Insurance Paid - ' + VarLoanNoRecovered, VarLoanNoRecovered, GenJournalLine."recovery transaction type"::"Guarantor Recoverd", VarLoanNoRecovered);

                        RunningBalance := RunningBalance - AmountToDeduct;
                        VarAmounttoDeduct := VarAmounttoDeduct + AmountToDeduct;
                    end;
                end;
            end;
        end;



        //============================================================Loan Principle Repayment
        if RunningBalance > 0 then begin
            ObjLoans.Reset;
            ObjLoans.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
            ObjLoans.SetRange(ObjLoans."Loan  No.", VarLoanNoRecovered);
            if ObjLoans.Find('-') then begin
                ObjLoans.CalcFields(ObjLoans."Outstanding Balance", ObjLoans."Penalty Charged", ObjLoans."Penalty Paid");
                if RunningBalance > 0 then begin
                    AmountToDeduct := 0;
                    if ObjLoans."Outstanding Balance" > 0 then begin
                        if ObjLoans."Outstanding Balance" < RunningBalance then begin
                            AmountToDeduct := ObjLoans."Outstanding Balance"
                        end else
                            AmountToDeduct := RunningBalance;
                        AmountToDeduct := ROUND(AmountToDeduct, 0.01, '=');

                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLineGuarantorRecovery(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Repayment",
                        GenJournalLine."account type"::Member, VarMemberNo, VarPostingDate, AmountToDeduct * -1, 'BOSA', EXTERNAL_DOC_NO,
                        'Loan Principal Repayment - ' + VarLoanNoRecovered, VarLoanNoRecovered, GenJournalLine."recovery transaction type"::"Guarantor Recoverd", VarLoanNoRecovered);
                        RunningBalance := RunningBalance - AmountToDeduct;
                        VarAmounttoDeduct := VarAmounttoDeduct + AmountToDeduct;
                        VarAmounttoDeduct := ROUND(VarAmounttoDeduct, 0.01, '=');
                    end;
                end;
            end;
        end;


        if ObjLoans.Get(VarLoanNoRecovered) then begin
            //==============================================================================================Recover From Loan Settlement Account
            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
            GenJournalLine."account type"::Vendor, VarLoanSettlementAcc, VarPostingDate, VarAmounttoDeduct, 'BOSA', EXTERNAL_DOC_NO,
            'Loan Repayment - ' + VarLoanNoRecovered + ' ' + ObjLoans."Loan Product Type Name", '', GenJournalLine."application source"::" ");
            //==============================================================================================End Recover From Loan Settlement Account
        end;
    end;


    procedure FnCreateBOSAAccountRecoveryReimbursment(VarFOSAAccountNo: Code[20])
    var
        ObjBOSARefundLedger: Record "BOSA Account Refund Ledger";
        VarAmounttoDeduct: Decimal;
        LineNo: Integer;
        BATCH_TEMPLATE: Code[30];
        BATCH_NAME: Code[30];
        DOCUMENT_NO: Code[30];
        EXTERNAL_DOC_NO: Code[40];
        SFactory: Codeunit "SURESTEP Factory";
        VarRecoveryDifference: Decimal;
        VarAmountApportioned: Decimal;
        VarDepositNo: Code[30];
        ObjVendors: Record Vendor;
        ObjAccTypes: Record "Account Types-Saving Products";
        VarBalanceinFOSA: Decimal;
        DetailedVenderLedger: Record "Detailed Vendor Ledg. Entry";
    begin
        BATCH_TEMPLATE := 'GENERAL';
        BATCH_NAME := 'RECOVERIES';
        DOCUMENT_NO := FnRunGetNextTransactionDocumentNo;
        EXTERNAL_DOC_NO := '';

        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
        GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
        GenJournalLine.DeleteAll;

        ObjVendors.Reset;
        ObjVendors.SetRange(ObjVendors."No.", VarFOSAAccountNo);
        if ObjVendors.FindSet then begin
            ObjVendors.CalcFields(ObjVendors.Balance, ObjVendors."Uncleared Cheques");
            VarBalanceinFOSA := FnRunGetAccountAvailableBalance(VarFOSAAccountNo);
            ;

            if ObjBOSARefundLedger."Account No Recovered" = VarFOSAAccountNo then begin //IF FUNDS ARE DEPOSITED TO BOSA ACCOUNT APPORTION DEPOSITED AMOUNT AS REFUNDED
                DetailedVenderLedger.Reset;
                DetailedVenderLedger.SetCurrentkey(DetailedVenderLedger."Entry No.");
                DetailedVenderLedger.SetRange(DetailedVenderLedger."Vendor No.", VarFOSAAccountNo);
                DetailedVenderLedger.SetFilter(DetailedVenderLedger."Credit Amount", '<>%1', 0);
                if DetailedVenderLedger.FindLast() then
                    VarBalanceinFOSA := DetailedVenderLedger."Credit Amount";
            end;

            VarAmounttoDeduct := 0;
            ObjBOSARefundLedger.Reset;
            ObjBOSARefundLedger.SetRange(ObjBOSARefundLedger."Member No", ObjVendors."BOSA Account No");
            ObjBOSARefundLedger.SetRange(ObjBOSARefundLedger."Fully Settled", false);
            if ObjBOSARefundLedger.FindSet then begin
                repeat
                    VarRecoveryDifference := ObjBOSARefundLedger."Amount Deducted" - ObjBOSARefundLedger."Amount Paid Back";

                    if VarBalanceinFOSA > 0 then begin
                        if VarRecoveryDifference > VarBalanceinFOSA then begin
                            VarAmounttoDeduct := VarBalanceinFOSA
                        end else
                            VarAmounttoDeduct := VarRecoveryDifference;

                        VarBalanceinFOSA := VarBalanceinFOSA - VarAmounttoDeduct;

                        if ObjBOSARefundLedger."Account No Recovered" <> VarFOSAAccountNo then begin
                            //======================================================================================================Recover From FOSA Account
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLineGuarantorRecovery(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                            GenJournalLine."account type"::Vendor, VarFOSAAccountNo, WorkDate, VarAmounttoDeduct, 'BOSA', EXTERNAL_DOC_NO,
                            'Refund of Loan Amount Recovered from BOSA - ' + ObjBOSARefundLedger."Account No Recovered", '', GenJournalLine."recovery transaction type"::"Guarantor Paid", '');

                            //======================================================================================================Recovery to Deposit Account
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLineGuarantorRecovery(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Deposit Contribution",
                            GenJournalLine."account type"::Vendor, ObjBOSARefundLedger."Account No Recovered", WorkDate, VarAmounttoDeduct * -1, 'BOSA', EXTERNAL_DOC_NO,
                            'Refund of Loan Amount Recovered from BOSA - ' + VarFOSAAccountNo, '', GenJournalLine."recovery transaction type"::"Guarantor Paid", '');
                        end;

                        ObjBOSARefundLedger."Amount Paid Back" := ObjBOSARefundLedger."Amount Paid Back" + VarAmounttoDeduct;
                        if ObjBOSARefundLedger."Amount Deducted" = ObjBOSARefundLedger."Amount Paid Back" then begin
                            ObjBOSARefundLedger."Fully Settled" := true;
                            ObjBOSARefundLedger.Modify;
                        end;
                        ObjBOSARefundLedger.Modify
                    end;
                until ObjBOSARefundLedger.Next = 0;
            end;
        end;
        //Post New
        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
        GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
        if GenJournalLine.Find('-') then begin
            Codeunit.Run(Codeunit::"Gen. Jnl.-Post Batch", GenJournalLine);
        end;
    end;


    procedure FnRunGetMemberMonthlyTurnover(VarMemberNo: Code[30])
    var
        ObjCust: Record Customer;
        ObjAccount: Record Vendor;
        ObjAuditSetup: Record "Audit General Setup";
        VarStartingMonthDate: Date;
        ObjVendLedg: Record "Detailed Vendor Ledg. Entry";
        ObjMemberLedgHistorical: Record "Member Historical Ledger Entry";
        VarDateFilter: Text;
        VarVendLedgTotalCredits: Decimal;
        VarMemberHistoricalLedgTotalCredits: Decimal;
        VarNoOfMonths: Integer;
        VarMonthlyTurnOverAmount: Decimal;
    begin
        VarVendLedgTotalCredits := 0;
        VarMemberHistoricalLedgTotalCredits := 0;

        ObjAuditSetup.Get;
        VarStartingMonthDate := CalcDate(ObjAuditSetup."Member TurnOver Period", WorkDate);
        VarDateFilter := Format(VarStartingMonthDate) + '..' + Format(WorkDate);

        ObjAccount.Reset;
        ObjAccount.SetRange(ObjAccount."BOSA Account No", VarMemberNo);
        if ObjAccount.FindSet then begin
            repeat
                //=================================================================Checking Vendor Ledger
                ObjVendLedg.Reset;
                ObjVendLedg.SetRange(ObjVendLedg."Vendor No.", ObjAccount."No.");
                ObjVendLedg.SetFilter(ObjVendLedg."Posting Date", VarDateFilter);
                ObjVendLedg.SetFilter(ObjVendLedg.Description, '<>%1&<>%2&<>%3&<>%4&<>%5', '*Overdraft Sweeping From*',
               '*Loan Repayment Transfer From*', '*Sweep Instruction Transfer from*', '*BOSA Deposits Transfer*', '*Balance B/F 9th Nov 2018*');
                ObjVendLedg.SetFilter(ObjVendLedg."Credit Amount", '<>%1', 0);
                ObjVendLedg.SetRange(ObjVendLedg.Reversed, false);
                if ObjVendLedg.FindSet then begin
                    ObjVendLedg.CalcSums(ObjVendLedg."Credit Amount");
                    VarVendLedgTotalCredits := VarVendLedgTotalCredits + ObjVendLedg."Credit Amount";
                end;

                //=================================================================Checking Historical Ledger
                ObjMemberLedgHistorical.Reset;
                ObjMemberLedgHistorical.SetRange(ObjMemberLedgHistorical."Account No.", ObjAccount."No.");
                ObjMemberLedgHistorical.SetFilter(ObjMemberLedgHistorical."Posting Date", VarDateFilter);
                ObjMemberLedgHistorical.SetFilter(ObjMemberLedgHistorical.Description, '<>%1&<>%2&<>%3&<>%4', '*Overdraft Sweeping From*',
                '*Loan Repayment Transfer From*', '*Sweep Instruction Transfer from*', '*BOSA Deposits Transfer*');
                ObjMemberLedgHistorical.SetFilter(ObjMemberLedgHistorical."Credit Amount", '<>%1', 0);
                if ObjMemberLedgHistorical.FindSet then begin
                    ObjMemberLedgHistorical.CalcSums(ObjMemberLedgHistorical."Credit Amount");
                    VarMemberHistoricalLedgTotalCredits := VarMemberHistoricalLedgTotalCredits + ObjMemberLedgHistorical."Credit Amount";
                end;

            until ObjAccount.Next = 0;

            VarMonthlyTurnOverAmount := ROUND((VarVendLedgTotalCredits + VarMemberHistoricalLedgTotalCredits) / ObjAuditSetup."Member TurnOver Per Interger", 1, '=');

            if ObjCust.Get(VarMemberNo) then begin
                ObjCust."Monthly TurnOver_Actual" := VarMonthlyTurnOverAmount;
                ObjCust.Modify;
            end;


        end;

    end;


    procedure FnRunGetMemberExpectedMonthlyTurnover(VarMemberNo: Code[30])
    var
        ObjCust: Record Customer;
        ObjAccount: Record Vendor;
        ObjAuditSetup: Record "Audit General Setup";
        VarStartingMonthDate: Date;
        ObjVendLedg: Record "Detailed Vendor Ledg. Entry";
        ObjMemberLedgHistorical: Record "Member Historical Ledger Entry";
        VarDateFilter: Text;
        VarVendLedgTotalCredits: Decimal;
        VarMemberHistoricalLedgTotalCredits: Decimal;
        VarNoOfMonths: Integer;
        VarMonthlyTurnOverAmount: Decimal;
        ObjExpectedTurnOversetup: Record "Expected Monthly TurnOver";
        VarTotalAnnualCredit: Decimal;
        VarTotalCredits: Decimal;
        VarCheckPeriod: Integer;
    begin
        VarVendLedgTotalCredits := 0;
        VarMemberHistoricalLedgTotalCredits := 0;
        VarTotalCredits := VarTotalCredits;

        ObjAuditSetup.Get;
        VarStartingMonthDate := CalcDate(ObjAuditSetup."Expected Monthly TurnOver Peri", WorkDate);
        VarDateFilter := Format(VarStartingMonthDate) + '..' + Format(WorkDate);

        ObjAccount.Reset;
        ObjAccount.SetRange(ObjAccount."BOSA Account No", VarMemberNo);
        if ObjAccount.FindSet then begin
            repeat

                //=================================================================Checking Vendor Ledger
                ObjVendLedg.CalcFields(ObjVendLedg.Description);
                ObjVendLedg.Reset;
                ObjVendLedg.SetRange(ObjVendLedg."Vendor No.", ObjAccount."No.");
                ObjVendLedg.SetFilter(ObjVendLedg."Posting Date", VarDateFilter);
                ObjVendLedg.SetFilter(ObjVendLedg.Description, '<>%1&<>%2&<>%3&<>%4&<>%5', '*Overdraft Sweeping From*',
                '*Loan Repayment Transfer From*', '*Sweep Instruction Transfer from*', '*BOSA Deposits Transfer*', '*Balance B/F 9th Nov 2018*');
                ObjVendLedg.SetFilter(ObjVendLedg."Credit Amount", '<>%1', 0);
                ObjVendLedg.SetRange(ObjVendLedg.Reversed, false);
                if ObjVendLedg.FindSet then begin
                    ObjVendLedg.CalcSums(ObjVendLedg."Credit Amount");
                    VarVendLedgTotalCredits := VarVendLedgTotalCredits + ObjVendLedg."Credit Amount";
                end;

                //=================================================================Checking Historical Ledger
                ObjMemberLedgHistorical.Reset;
                ObjMemberLedgHistorical.SetRange(ObjMemberLedgHistorical."Account No.", ObjAccount."No.");
                ObjMemberLedgHistorical.SetFilter(ObjMemberLedgHistorical."Posting Date", VarDateFilter);
                ObjMemberLedgHistorical.SetFilter(ObjMemberLedgHistorical.Description, '<>%1&<>%2&<>%3&<>%4', '*Overdraft Sweeping From*',
                '*Loan Repayment Transfer From*', '*Sweep Instruction Transfer from*', '*BOSA Deposits Transfer*');
                ObjMemberLedgHistorical.SetFilter(ObjMemberLedgHistorical."Credit Amount", '<>%1', 0);
                if ObjMemberLedgHistorical.FindSet then begin
                    ObjMemberLedgHistorical.CalcSums(ObjMemberLedgHistorical."Credit Amount");
                    VarMemberHistoricalLedgTotalCredits := VarMemberHistoricalLedgTotalCredits + ObjMemberLedgHistorical."Credit Amount";
                end;
            until ObjAccount.Next = 0;


            VarTotalAnnualCredit := (VarVendLedgTotalCredits + VarMemberHistoricalLedgTotalCredits);

            //=================================================================Calculate Only for the Period the Member is in Existance
            VarCheckPeriod := ObjAuditSetup."Expected M.TurnOver Period Int" * -1;
            if ObjCust.Get(VarMemberNo) then begin
                if ObjCust."Registration Date" > VarStartingMonthDate then
                    VarCheckPeriod := ROUND((WorkDate - ObjCust."Registration Date") / 30, 1, '=');
            end;
            VarMonthlyTurnOverAmount := ROUND((VarTotalAnnualCredit) / VarCheckPeriod, 1, '=');


            ObjExpectedTurnOversetup.Reset;
            if ObjExpectedTurnOversetup.Find('-') then begin
                repeat
                    if (VarMonthlyTurnOverAmount >= ObjExpectedTurnOversetup."Minimum Amount") and (VarMonthlyTurnOverAmount <= ObjExpectedTurnOversetup."Maximum Amount") then begin
                        if ObjCust.Get(VarMemberNo) then begin
                            ObjCust."Expected Monthly Income" := ObjExpectedTurnOversetup.Code;
                            ObjCust."Expected Monthly Income Amount" := VarMonthlyTurnOverAmount;
                            ObjCust.Modify;
                        end;
                    end;
                until ObjExpectedTurnOversetup.Next = 0;
            end;


        end;

    end;


    procedure FnRunExpiredCollateralManagement()
    var
        ObjLoan: Record "Loans Register";
        ObjLoanCollateralDetails: Record "Loan Collateral Details";
        ObjCollateralRegister: Record "Loan Collateral Register";
        ObjCollateralMovement: Record "Collateral Movement  Register";
        ObjCust: Record Customer;
        VarRecepientEmail: Text;
        VarEmailBody: Text;
        VarEmailSubject: Text;
        VarMemberName: Text;
        ObjCustodyCharge: Record "Package Types";
        CustodyFee: Decimal;
        VarMobileNo: Code[30];
        VarCollateralNoticeDate: Date;
        ObjNoSeries: Record "Sacco No. Series";
        VarDocumentNo: Code[30];
        ObjSafeCustody: Record "Safe Custody Package Register";
    begin
        ObjLoan.Reset;
        ObjLoan.SetRange(ObjLoan."Loan Status", ObjLoan."loan status"::Closed);
        ObjLoan.SetRange(ObjLoan."Closed On", WorkDate);
        if ObjLoan.FindSet then begin
            ObjLoanCollateralDetails.Reset;
            ObjLoanCollateralDetails.SetRange(ObjLoanCollateralDetails."Loan No", ObjLoan."Loan  No.");
            if ObjLoanCollateralDetails.FindSet then begin

                ObjCollateralRegister.Reset;
                ObjCollateralRegister.SetRange(ObjCollateralRegister."Document No", ObjLoanCollateralDetails."Collateral Registe Doc");
                ObjCollateralRegister.SetFilter(ObjCollateralRegister."Collateral Code", '%1|%2', 'LOGBOOK', 'TITLEDEED');
                if ObjCollateralRegister.FindSet then begin

                    ObjCollateralRegister.CalcFields(ObjCollateralRegister."Last Collateral Action Entry");
                    if ObjCollateralMovement.Get(ObjCollateralRegister."Last Collateral Action Entry") then begin
                        if ObjCollateralMovement."Action Type" <> 'RELEASE TO MEMBER' then begin

                            //===============================================================Get Safe Custody Fee Amount
                            ObjCustodyCharge.Reset;
                            ObjCustodyCharge.SetRange(ObjCustodyCharge.Code, 'ENVELOPE');
                            if ObjCustodyCharge.FindSet then begin
                                CustodyFee := ObjCustodyCharge."Package Charge";
                            end;
                            //===============================================================End Get Safe Custody Fee Amount

                            //============================================================Email Notice
                            ObjGenSetUp.Get;
                            if ObjCust.Get(ObjLoan."Client Code") then begin
                                VarRecepientEmail := ObjCust."E-Mail";

                                VarMemberName := FnConvertTexttoBeginingWordstostartWithCapital(ObjCust.Name);

                                VarEmailSubject := 'Cleared Loan Collateral Collection - ' + ObjLoan."Loan  No.";
                                VarEmailBody := 'Kindly not that your Loan  ' + ObjLoan."Loan  No." + ' has been cleared and was attached to the collateral ' +
                                ObjCollateralRegister."Collateral Description" + ' - ' + ObjCollateralRegister."Collateral Code" +
                                '. Kindly arrange to collect the collateral document within 14 days, failover to which it shall be kept in Safe Custody at Ksh. ' +
                                Format(CustodyFee) + ' annually.';

                                FnSendStatementViaMail(VarMemberName, VarEmailSubject, VarEmailBody, VarRecepientEmail, '', ObjGenSetUp."Credit Department E-mail");

                                //=======================================================SMS Notice
                                VarMobileNo := ObjCust."Mobile Phone No";
                                if VarMobileNo <> '' then begin
                                    FnSendSMS('COLLATERALNOTICE', VarEmailBody, VarLoanNo, VarMobileNo);
                                end;

                            end;
                        end;
                    end;

                end;
            end;
        end;



        //===================================================================================Move Uncolletected Collateral to Safe Custody
        VarCollateralNoticeDate := CalcDate(ObjGenSetUp."Collateral Collection Period", WorkDate);
        ObjLoan.Reset;
        ObjLoan.SetRange(ObjLoan."Loan Status", ObjLoan."loan status"::Closed);
        ObjLoan.SetFilter(ObjLoan."Closed On", '<=%1', VarCollateralNoticeDate);
        if ObjLoan.FindSet then begin
            ObjLoanCollateralDetails.Reset;
            ObjLoanCollateralDetails.SetRange(ObjLoanCollateralDetails."Loan No", ObjLoan."Loan  No.");
            if ObjLoanCollateralDetails.FindSet then begin

                ObjCollateralRegister.Reset;
                ObjCollateralRegister.SetRange(ObjCollateralRegister."Document No", ObjLoanCollateralDetails."Collateral Registe Doc");
                ObjCollateralRegister.SetFilter(ObjCollateralRegister."Collateral Code", '%1|%2', 'LOGBOOK', 'TITLEDEED');
                if ObjCollateralRegister.FindSet then begin

                    ObjCollateralRegister.CalcFields(ObjCollateralRegister."Last Collateral Action Entry");
                    if ObjCollateralMovement.Get(ObjCollateralRegister."Last Collateral Action Entry") then begin
                        if ObjCollateralMovement."Action Type" <> 'RELEASE TO MEMBER' then begin

                            //===============================================================Get Safe Custody Fee Amount
                            ObjCustodyCharge.Reset;
                            ObjCustodyCharge.SetRange(ObjCustodyCharge.Code, 'ENVELOPE');
                            if ObjCustodyCharge.FindSet then begin
                                CustodyFee := ObjCustodyCharge."Package Charge";
                            end;
                            //===============================================================End Get Safe Custody Fee Amount

                            if ObjNoSeries.Get then begin
                                ObjNoSeries.TestField(ObjNoSeries."Safe Custody Package Nos");
                                VarDocumentNo := NoSeriesMgt.GetNextNo(ObjNoSeries."Safe Custody Package Nos", 0D, true);
                            end;
                            if VarDocumentNo <> '' then begin

                                ObjSafeCustody.Init;
                                ObjSafeCustody."Package ID" := VarDocumentNo;
                                ObjSafeCustody."File Serial No" := ObjCollateralRegister."File No";
                                ObjSafeCustody."Package Type" := 'Envelope';
                                ObjSafeCustody."Package Description" := ObjCollateralRegister."Collateral Description";
                                Evaluate(ObjSafeCustody."Custody Period", '1Y');
                                ObjSafeCustody."Maturity Date" := WorkDate;
                                ObjSafeCustody."Member No" := ObjCollateralRegister."Member No.";
                                ObjSafeCustody."Date Received" := WorkDate;
                                ObjSafeCustody."Time Received" := Time;
                                ObjSafeCustody."Received By" := UserId;
                                ObjSafeCustody."Lodged By(Custodian 1)" := UserId;
                                ObjSafeCustody."Lodged By(Custodian 2)" := UserId;
                                ObjSafeCustody."Date Lodged" := WorkDate;
                                ObjSafeCustody."Member Name" := ObjCollateralRegister."Member Name";
                                ObjSafeCustody."Maturity Instruction" := ObjSafeCustody."maturity instruction"::Rebook;
                                ObjSafeCustody.Status := ObjSafeCustody.Status::Approved;
                                ObjSafeCustody."Package Status" := ObjSafeCustody."package status"::Lodged;
                                ObjSafeCustody."Charge Account" := ObjLoan."Account No";
                                ObjSafeCustody."Charge Account Name" := ObjLoan."Client Name";
                                ObjSafeCustody.Insert;
                            end;



                            //============================================================Email Notice
                            ObjGenSetUp.Get;
                            if ObjCust.Get(ObjLoan."Client Code") then begin
                                VarRecepientEmail := ObjCust."E-Mail";

                                VarMemberName := FnConvertTexttoBeginingWordstostartWithCapital(ObjCust.Name);

                                VarEmailSubject := 'Loan Collateral Maintained in Safe Custody - ' + ObjCollateralRegister."Collateral Description";
                                VarEmailBody := 'Kindly note that your Loan Collateral ' + ObjCollateralRegister."Collateral Description" + ' - ' +
                                ObjCollateralRegister."Collateral Code" + ' that was securing Loan ' + ObjLoan."Loan  No." +
                                'has been Maintained in Safe Custody. Your Account ' + ObjLoan."Account No" + ' will be charged Ksh. ' +
                                Format(CustodyFee) + ' annually until collected.';

                                FnSendStatementViaMail(VarMemberName, VarEmailSubject, VarEmailBody, VarRecepientEmail, '', ObjGenSetUp."Credit Department E-mail");

                                //=======================================================SMS Notice
                                VarMobileNo := ObjCust."Mobile Phone No";
                                if VarMobileNo <> '' then begin
                                    FnSendSMS('COLLATERALNOTICE', VarEmailBody, VarLoanNo, VarMobileNo);
                                end;

                            end;
                        end;
                    end;

                end;
            end;
        end;
    end;


    procedure IsEmailAddressesValid(Recipients: Text) EmailValid: Boolean
    var
        TmpRecipients: Text;
    begin
        EmailValid := true;
        if Recipients = '' then begin
            EmailValid := false;
            exit(EmailValid);
        end;


        TmpRecipients := DelChr(Recipients, '<>', ';');
        while StrPos(TmpRecipients, ';') > 1 do begin
            EmailValid := IsEmailAddressValid(CopyStr(TmpRecipients, 1, StrPos(TmpRecipients, ';') - 1));
            TmpRecipients := CopyStr(TmpRecipients, StrPos(TmpRecipients, ';') + 1);
        end;
        EmailValid := IsEmailAddressValid(TmpRecipients);

        exit(EmailValid);
    end;


    procedure IsEmailAddressValid(EmailAddress: Text) EmailValid: Boolean
    var
        i: Integer;
        NoOfAtSigns: Integer;
        NoOfDots: Integer;
    begin
        EmailAddress := DelChr(EmailAddress, '<>');
        EmailValid := true;

        if EmailAddress = '' then begin
            EmailValid := false;
            exit(EmailValid);
        end;

        if (EmailAddress[1] = '@') or (EmailAddress[StrLen(EmailAddress)] = '@') then begin
            EmailValid := false;
            exit(EmailValid);
        end;

        if (EmailAddress[1] = '.') or (EmailAddress[StrLen(EmailAddress)] = '.') then begin
            EmailValid := false;
            exit(EmailValid);
        end;

        for i := 1 to StrLen(EmailAddress) do begin
            if EmailAddress[i] = '@' then
                NoOfAtSigns := NoOfAtSigns + 1
            else
                if EmailAddress[i] = '.' then
                    NoOfDots := NoOfDots + 1
                else
                    if EmailAddress[i] = ' ' then begin
                        EmailValid := false;
                        exit(EmailValid);
                    end;
        end;

        if NoOfAtSigns <> 1 then begin
            EmailValid := false;
            exit(EmailValid);
        end;

        if NoOfDots = 0 then begin
            EmailValid := false;
            exit(EmailValid);
        end;

        exit(EmailValid);
    end;


    procedure FnRunGetAccountAvailableBalance(VarAccountNo: Code[30]) AvailableBal: Decimal
    var
        ObjVendors: Record Vendor;
        ObjAccTypes: Record "Account Types-Saving Products";
    begin
        ObjVendors.Reset;
        ObjVendors.SetRange(ObjVendors."No.", VarAccountNo);
        if ObjVendors.Find('-') then begin

            ObjVendors.CalcFields(ObjVendors.Balance, ObjVendors."Cheque Discounted", ObjVendors."Uncleared Cheques", ObjVendors."EFT Transactions",
                                  ObjVendors."ATM Transactions", ObjVendors."Mobile Transactions", ObjVendors."Cheque Discounted Amount");

            AvailableBal := ((ObjVendors.Balance + ObjVendors."Cheque Discounted") - ObjVendors."Uncleared Cheques" + ObjVendors."Over Draft Limit Amount" -
                          ObjVendors."Frozen Amount" - ObjVendors."ATM Transactions" - ObjVendors."EFT Transactions" - ObjVendors."Mobile Transactions");

            ObjAccTypes.Reset;
            ObjAccTypes.SetRange(ObjAccTypes.Code, ObjVendors."Account Type");
            if ObjAccTypes.Find('-') then
                AvailableBal := AvailableBal - ObjAccTypes."Minimum Balance";
        end;
        //Message('message function%1|%2', ObjVendors.Balance, ObjVendors."Balance (LCY)");
        exit(AvailableBal);
    end;


    procedure FnRunGetMemberLoanAmountDueFreezing(VarMemberNo: Code[20]) VarTotalMemberLoanDueAmount: Decimal
    var
        ObjLoanRepaymentschedule: Record "Loan Repayment Schedule";
        ObjLoans: Record "Loans Register";
        VarPrinciplePaid: Decimal;
        VarAmountRemaining: Decimal;
        VarAmountAllocated: Decimal;
        VarDateFilter: Text;
        VarSchedulePrincipletoDate: Decimal;
        VarActualPrincipletoDate: Decimal;
        VarAmountinArrears: Decimal;
        VarNoofDaysinArrears: Integer;
        VarInterestPaid: Decimal;
        VarInsurancePaid: Decimal;
        VarAmountRemainingInterest: Decimal;
        VarAmountRemainingInsurance: Decimal;
        VarAmountAllocatedInterest: Decimal;
        VarAmountAllocatedInsurance: Decimal;
        VarScheduleInteresttoDate: Decimal;
        VarActualInteresttoDate: Decimal;
        VarScheduleInsurancetoDate: Decimal;
        VarActualInsurancetoDate: Decimal;
        VarAmountinArrearsInterest: Decimal;
        VarAmountinArrearsInsurance: Decimal;
        VarOutstandingPenalty: Decimal;
        VarLastInstalmentDueDate: Date;
        ObjLoanInterestAccrued: Record "Interest Due Ledger Entry";
        VarTotalInterestAccrued: Decimal;
        VarFreezingDueDate: Date;
        ObjLoansII: Record "Loans Register";
        VarTotalLoanDueAmount: Decimal;
        ObjAccount: Record Vendor;
        VarLSAUfalmeBalances: Decimal;
    begin

        ObjLoansII.CalcFields(ObjLoansII."Outstanding Balance");
        ObjLoansII.Reset;
        ObjLoansII.SetRange(ObjLoansII."Client Code", VarMemberNo);
        ObjLoansII.SetFilter(ObjLoansII."Outstanding Balance", '>%1', 0);
        ObjLoansII.SetRange(ObjLoansII.Closed, false);
        if ObjLoansII.FindSet then begin
            repeat
                VarTotalMemberLoanDueAmount := VarTotalMemberLoanDueAmount + FnRunGetLoanAmountDueFreezing(ObjLoansII."Loan  No.");
            until ObjLoansII.Next = 0;
        end;

        VarLSAUfalmeBalances := 0;
        ObjAccount.CalcFields(ObjAccount.Balance);
        ObjAccount.Reset;
        ObjAccount.SetRange(ObjAccount."BOSA Account No", VarMemberNo);
        ObjAccount.SetFilter(ObjAccount."Account Type", '%1|%2', '507', '508');
        ObjAccount.SetFilter(ObjAccount.Balance, '>%1', 0);
        if ObjAccount.FindSet then begin
            repeat
                ObjAccount.CalcFields(ObjAccount.Balance);
                VarLSAUfalmeBalances := VarLSAUfalmeBalances + ObjAccount.Balance;
            until ObjAccount.Next = 0;
        end;

        VarTotalMemberLoanDueAmount := VarTotalMemberLoanDueAmount - VarLSAUfalmeBalances;

        if VarTotalMemberLoanDueAmount < 0 then
            VarTotalMemberLoanDueAmount := 0;

        exit(VarTotalMemberLoanDueAmount);
    end;


    procedure FnRunFreezeMemberLoanDueAmount(VarAccountNo: Code[30])
    var
        VarAvailableBalance: Decimal;
        VarLoanDueAmount: Decimal;
        ObjMemberAccountFreezing: Record "Member Account Freeze Details";
        VarAmounttoFreeze: Decimal;
        ObjAccount: Record Vendor;
        ObjNoSeries: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        VarDocumentNo: Code[30];
        ObjAccountType: Record "Account Types-Saving Products";
    begin

        if ObjAccount.Get(VarAccountNo) then begin
            ObjAccountType.Reset;
            ObjAccountType.SetRange(ObjAccountType.Code, ObjAccount."Account Type");
            ObjAccountType.SetRange(ObjAccountType."Product Type", ObjAccountType."product type"::Withdrawable);
            ObjAccountType.SetFilter(ObjAccountType.Code, '<>%1', '502');
            if ObjAccountType.FindSet then begin
                VarLoanDueAmount := FnRunGetMemberLoanAmountDueFreezing(ObjAccount."BOSA Account No");
                if VarLoanDueAmount > 0 then begin
                    ObjMemberAccountFreezing.Reset;
                    ObjMemberAccountFreezing.SetRange(ObjMemberAccountFreezing."Account No", VarAccountNo);
                    ObjMemberAccountFreezing.SetRange(ObjMemberAccountFreezing."Loan Freeze", true);
                    ObjMemberAccountFreezing.SetRange(ObjMemberAccountFreezing.Unfrozen, false);
                    if ObjMemberAccountFreezing.FindSet then begin
                        ObjMemberAccountFreezing.Unfrozen := true;
                        ObjMemberAccountFreezing."Unfrozen By" := 'SYSTEM';
                        ObjMemberAccountFreezing."Unfrozen On" := WorkDate;
                        ObjMemberAccountFreezing.Modify;
                        ObjAccount."Frozen Amount" := ObjAccount."Frozen Amount" - ObjMemberAccountFreezing."Amount to Freeze";
                        ObjAccount.Modify;
                    end;
                    VarAvailableBalance := FnRunGetAccountAvailableBalance(VarAccountNo);
                    if VarAvailableBalance > 0 then begin
                        if VarLoanDueAmount > VarAvailableBalance then begin
                            VarAmounttoFreeze := VarAvailableBalance
                        end else
                            VarAmounttoFreeze := VarLoanDueAmount;

                        if (ObjNoSeries.Get) and (VarAmounttoFreeze > 1) then begin
                            ObjNoSeries.TestField(ObjNoSeries."Account Freezing No");
                            VarDocumentNo := NoSeriesMgt.GetNextNo(ObjNoSeries."Account Freezing No", 0D, true);
                            if VarDocumentNo <> '' then begin
                                ObjMemberAccountFreezing.Init;
                                ObjMemberAccountFreezing."Document No" := VarDocumentNo;
                                ObjMemberAccountFreezing."Member No" := ObjAccount."BOSA Account No";
                                ObjMemberAccountFreezing."Member Name" := ObjAccount.Name;
                                ObjMemberAccountFreezing."Account No" := VarAccountNo;
                                ObjMemberAccountFreezing."Amount to Freeze" := VarAmounttoFreeze;
                                ObjMemberAccountFreezing."Reason For Freezing" := 'Loan Due Amount';
                                ObjMemberAccountFreezing."Loan Freeze" := true;
                                ObjMemberAccountFreezing."Captured On" := WorkDate;
                                ObjMemberAccountFreezing."Captured By" := 'SYSTEM';
                                ObjMemberAccountFreezing.Frozen := true;
                                ObjMemberAccountFreezing."Frozen By" := 'SYSTEM';
                                ObjMemberAccountFreezing."Frozen On" := WorkDate;
                                ObjMemberAccountFreezing."Current Available Balance" := VarAvailableBalance;
                                ObjMemberAccountFreezing."Current Book Balance" := ObjAccount.Balance;
                                ObjMemberAccountFreezing."Uncleared Cheques" := ObjAccount."Uncleared Cheques";
                                ObjMemberAccountFreezing."Current Frozen Amount" := ObjAccount."Frozen Amount";
                                ObjMemberAccountFreezing.Insert;
                            end;
                        end;
                        ObjAccount."Frozen Amount" := ObjAccount."Frozen Amount" + VarAmounttoFreeze;
                        ObjAccount.Modify;
                    end;
                end;
            end;
        end;
    end;


    procedure FnRunAfterCashDepositProcess(VarAccountNo: Code[30])
    begin
        FnCreateGuarantorRecoveryReimbursment(VarAccountNo);
        FnRunFreezeMemberLoanDueAmount(VarAccountNo);
        FnCreateBOSAAccountRecoveryReimbursment(VarAccountNo);
    end;


    procedure FnRunAutoUnFreezeMemberLoanDueAmount()
    var
        ObjMemberAccountFreezing: Record "Member Account Freeze Details";
        ObjAccount: Record Vendor;
        VarMemberAmountDue: Decimal;
    begin
        //=========================================================================UnFreeze Member Loan Due Amount
        ObjMemberAccountFreezing.Reset;
        ObjMemberAccountFreezing.SetRange(ObjMemberAccountFreezing."Loan Freeze", true);
        ObjMemberAccountFreezing.SetRange(ObjMemberAccountFreezing.Unfrozen, false);
        if ObjMemberAccountFreezing.FindSet then begin
            repeat
                //VarMemberAmountDue:=FnRunGetMemberLoanAmountDueFreezing(ObjMemberAccountFreezing."Member No");
                //IF VarMemberAmountDue <= 1 THEN
                //BEGIN
                ObjMemberAccountFreezing.Unfrozen := true;
                ObjMemberAccountFreezing."Unfrozen By" := 'SYSTEM';
                ObjMemberAccountFreezing."Unfrozen On" := WorkDate;
                ObjMemberAccountFreezing.Modify;
                if ObjAccount.Get(ObjMemberAccountFreezing."Account No") then begin
                    ObjAccount."Frozen Amount" := ObjAccount."Frozen Amount" - ObjMemberAccountFreezing."Amount to Freeze";
                    ObjAccount.Modify;
                end;
            //END;
            until ObjMemberAccountFreezing.Next = 0;
        end;
    end;


    procedure FnRunAutoFreezeMemberLoanDueAmount()
    var
        ObjCust: Record Customer;
        VarLoanDueAmount: Decimal;
        ObjAccount: Record Vendor;
        VarAvailableBalance: Decimal;
        VarAmountFrozen: Decimal;
        ObjAccountType: Record "Account Types-Saving Products";
        VarAccountNo: Code[30];
        ObjMemberAccountFreezing: Record "Member Account Freeze Details";
        VarAmounttoFreeze: Decimal;
        ObjNoSeries: Record "Sacco No. Series";
        VarDocumentNo: Code[30];
        ObjMember: Record Customer;
        VarMemberNo: Text[20];
    begin
        ObjMember.CalcFields(ObjMember."Total Loans Outstanding");
        ObjMember.Reset;
        ObjMember.SetFilter(ObjMember."Total Loans Outstanding", '>%1', 1);
        if ObjMember.FindSet then begin
            repeat
                VarMemberNo := ObjMember."No.";
                VarLoanDueAmount := FnRunGetMemberLoanAmountDueFreezing(VarMemberNo);
                if VarLoanDueAmount > 1 then begin

                    ObjAccount.CalcFields(ObjAccount.Balance);
                    ObjAccount.Reset;
                    ObjAccount.SetRange(ObjAccount."BOSA Account No", VarMemberNo);
                    ObjAccount.SetFilter(ObjAccount.Status, '<>%1', ObjAccount.Status::Closed);
                    ObjAccount.SetRange(ObjAccount.Blocked, ObjAccount.Blocked::" ");
                    ObjAccount.SetFilter(ObjAccount.Balance, '>%1', 1);
                    if ObjAccount.FindSet then begin
                        repeat
                            if VarLoanDueAmount > 1 then begin
                                ObjAccountType.Reset;
                                ObjAccountType.SetRange(ObjAccountType.Code, ObjAccount."Account Type");
                                ObjAccountType.SetRange(ObjAccountType."Product Type", ObjAccountType."product type"::Withdrawable);
                                ObjAccountType.SetFilter(ObjAccountType.Code, '<>%1', '502');
                                if ObjAccountType.FindSet then begin
                                    ObjAccount.CalcFields(ObjAccount.Balance, "Uncleared Cheques");
                                    VarAccountNo := ObjAccount."No.";

                                    ObjMemberAccountFreezing.Reset;
                                    ObjMemberAccountFreezing.SetRange(ObjMemberAccountFreezing."Account No", VarAccountNo);
                                    ObjMemberAccountFreezing.SetRange(ObjMemberAccountFreezing."Loan Freeze", true);
                                    ObjMemberAccountFreezing.SetRange(ObjMemberAccountFreezing.Unfrozen, false);
                                    if ObjMemberAccountFreezing.FindSet then begin
                                        ObjMemberAccountFreezing.Unfrozen := true;
                                        ObjMemberAccountFreezing."Unfrozen By" := 'SYSTEM';
                                        ObjMemberAccountFreezing."Unfrozen On" := WorkDate;
                                        ObjMemberAccountFreezing.Modify;
                                        ObjAccount."Frozen Amount" := ObjAccount."Frozen Amount" - ObjMemberAccountFreezing."Amount to Freeze";
                                        ObjAccount.Modify;
                                    end;

                                    VarAvailableBalance := FnRunGetAccountAvailableBalance(VarAccountNo);
                                    if VarAvailableBalance > 1 then begin
                                        if VarLoanDueAmount > VarAvailableBalance then begin
                                            VarAmounttoFreeze := VarAvailableBalance
                                        end else
                                            VarAmounttoFreeze := VarLoanDueAmount;
                                        if (ObjNoSeries.Get) and (VarAmounttoFreeze > 1) then begin
                                            ObjNoSeries.TestField(ObjNoSeries."Account Freezing No");
                                            VarDocumentNo := NoSeriesMgt.GetNextNo(ObjNoSeries."Account Freezing No", 0D, true);
                                            if VarDocumentNo <> '' then begin
                                                ObjMemberAccountFreezing.Init;
                                                ObjMemberAccountFreezing."Document No" := VarDocumentNo;
                                                ObjMemberAccountFreezing."Member No" := ObjAccount."BOSA Account No";
                                                ObjMemberAccountFreezing."Member Name" := ObjAccount.Name;
                                                ObjMemberAccountFreezing."Account No" := VarAccountNo;
                                                ObjMemberAccountFreezing."Amount to Freeze" := VarAmounttoFreeze;
                                                ObjMemberAccountFreezing."Reason For Freezing" := 'Loan Due Amount';
                                                ObjMemberAccountFreezing."Loan Freeze" := true;
                                                ObjMemberAccountFreezing."Captured On" := WorkDate;
                                                ObjMemberAccountFreezing."Captured By" := 'SYSTEM';
                                                ObjMemberAccountFreezing.Frozen := true;
                                                ObjMemberAccountFreezing."Frozen By" := 'SYSTEM';
                                                ObjMemberAccountFreezing."Frozen On" := WorkDate;
                                                ObjMemberAccountFreezing."Current Available Balance" := VarAvailableBalance;
                                                ObjMemberAccountFreezing."Current Book Balance" := ObjAccount.Balance;
                                                ObjMemberAccountFreezing."Uncleared Cheques" := ObjAccount."Uncleared Cheques";
                                                ObjMemberAccountFreezing."Current Frozen Amount" := ObjAccount."Frozen Amount";
                                                ObjMemberAccountFreezing.Insert;
                                            end;
                                        end;
                                        ObjAccount."Frozen Amount" := ObjAccount."Frozen Amount" + VarAmounttoFreeze;
                                        ObjAccount.Modify;
                                        VarLoanDueAmount := VarLoanDueAmount - VarAmounttoFreeze;
                                        if VarLoanDueAmount = 0 then
                                            exit;
                                    end;
                                end;
                            end;
                        until ObjAccount.Next = 0;
                    end;
                end;
            until ObjMember.Next = 0;
        end;
    end;


    procedure FnRunFreezeMemberLoanDueAmountAfterPayoff(VarMemberNo: Text[20])
    var
        ObjCust: Record Customer;
        VarLoanDueAmount: Decimal;
        ObjAccount: Record Vendor;
        VarAvailableBalance: Decimal;
        VarAmountFrozen: Decimal;
        ObjAccountType: Record "Account Types-Saving Products";
        VarAccountNo: Code[30];
        ObjMemberAccountFreezing: Record "Member Account Freeze Details";
        VarAmounttoFreeze: Decimal;
        ObjNoSeries: Record "Sacco No. Series";
        VarDocumentNo: Code[30];
        ObjMember: Record Customer;
    begin
        ObjMember.Reset;
        ObjMember.SetRange(ObjMember."No.", VarMemberNo);
        if ObjMember.FindSet then begin
            VarLoanDueAmount := FnRunGetMemberLoanAmountDueFreezing(VarMemberNo);
            ObjAccount.CalcFields(ObjAccount.Balance);
            ObjAccount.Reset;
            ObjAccount.SetRange(ObjAccount."BOSA Account No", VarMemberNo);
            ObjAccount.SetFilter(ObjAccount.Status, '<>%1', ObjAccount.Status::Closed);
            ObjAccount.SetRange(ObjAccount.Blocked, ObjAccount.Blocked::" ");
            ObjAccount.SetFilter(ObjAccount.Balance, '>%1', 1);
            if ObjAccount.FindSet then begin
                repeat
                    ObjAccountType.Reset;
                    ObjAccountType.SetRange(ObjAccountType.Code, ObjAccount."Account Type");
                    ObjAccountType.SetRange(ObjAccountType."Product Type", ObjAccountType."product type"::Withdrawable);
                    ObjAccountType.SetFilter(ObjAccountType.Code, '<>%1', '502');
                    if ObjAccountType.FindSet then begin
                        VarAccountNo := ObjAccount."No.";

                        ObjMemberAccountFreezing.Reset;
                        ObjMemberAccountFreezing.SetRange(ObjMemberAccountFreezing."Account No", VarAccountNo);
                        ObjMemberAccountFreezing.SetRange(ObjMemberAccountFreezing."Loan Freeze", true);
                        ObjMemberAccountFreezing.SetRange(ObjMemberAccountFreezing.Unfrozen, false);
                        if ObjMemberAccountFreezing.FindSet then begin
                            ObjMemberAccountFreezing.Unfrozen := true;
                            ObjMemberAccountFreezing."Unfrozen By" := 'SYSTEM';
                            ObjMemberAccountFreezing."Unfrozen On" := WorkDate;
                            ObjMemberAccountFreezing.Modify;
                            ObjAccount."Frozen Amount" := ObjAccount."Frozen Amount" - ObjMemberAccountFreezing."Amount to Freeze";
                            ObjAccount.Modify;
                        end;

                        VarAvailableBalance := FnRunGetAccountAvailableBalance(VarAccountNo);
                        if (VarAvailableBalance > 1) and (VarAmounttoFreeze > 1) then begin
                            if VarLoanDueAmount > VarAvailableBalance then begin
                                VarAmounttoFreeze := VarAvailableBalance
                            end else
                                VarAmounttoFreeze := VarLoanDueAmount;

                            if VarAmounttoFreeze > 0 then begin
                                if ObjNoSeries.Get then begin
                                    ObjNoSeries.TestField(ObjNoSeries."Account Freezing No");
                                    VarDocumentNo := NoSeriesMgt.GetNextNo(ObjNoSeries."Account Freezing No", 0D, true);
                                    if VarDocumentNo <> '' then begin
                                        ObjMemberAccountFreezing.Init;
                                        ObjMemberAccountFreezing."Document No" := VarDocumentNo;
                                        ObjMemberAccountFreezing."Member No" := ObjAccount."BOSA Account No";
                                        ObjMemberAccountFreezing."Member Name" := ObjAccount.Name;
                                        ObjMemberAccountFreezing."Account No" := VarAccountNo;
                                        ObjMemberAccountFreezing."Amount to Freeze" := VarAmounttoFreeze;
                                        ObjMemberAccountFreezing."Reason For Freezing" := 'Loan Due Amount';
                                        ObjMemberAccountFreezing."Loan Freeze" := true;
                                        ObjMemberAccountFreezing."Captured On" := WorkDate;
                                        ObjMemberAccountFreezing."Captured By" := 'SYSTEM';
                                        ObjMemberAccountFreezing.Frozen := true;
                                        ObjMemberAccountFreezing."Frozen By" := 'SYSTEM';
                                        ObjMemberAccountFreezing."Frozen On" := WorkDate;
                                        ObjMemberAccountFreezing."Current Available Balance" := VarAvailableBalance;
                                        ObjMemberAccountFreezing."Current Book Balance" := ObjAccount.Balance;
                                        ObjMemberAccountFreezing."Uncleared Cheques" := ObjAccount."Uncleared Cheques";
                                        ObjMemberAccountFreezing."Current Frozen Amount" := ObjAccount."Frozen Amount";
                                        ObjMemberAccountFreezing.Insert;
                                    end;
                                end;
                                ObjAccount."Frozen Amount" := ObjAccount."Frozen Amount" + VarAmounttoFreeze;
                                ObjAccount.Modify;
                                VarLoanDueAmount := VarLoanDueAmount - VarAmounttoFreeze;
                            end;
                        end;
                    end;
                until ObjAccount.Next = 0;
            end;
        end;
    end;


    procedure FnRunGetLoanAmountDueFreezing(VarLoanNo: Code[20]) VarTotalMemberLoanDueAmount: Decimal
    var
        ObjLoanRepaymentschedule: Record "Loan Repayment Schedule";
        ObjLoans: Record "Loans Register";
        VarPrinciplePaid: Decimal;
        VarAmountRemaining: Decimal;
        VarAmountAllocated: Decimal;
        VarDateFilter: Text;
        VarSchedulePrincipletoDate: Decimal;
        VarActualPrincipletoDate: Decimal;
        VarAmountinArrears: Decimal;
        VarNoofDaysinArrears: Integer;
        VarInterestPaid: Decimal;
        VarInsurancePaid: Decimal;
        VarAmountRemainingInterest: Decimal;
        VarAmountRemainingInsurance: Decimal;
        VarAmountAllocatedInterest: Decimal;
        VarAmountAllocatedInsurance: Decimal;
        VarScheduleInteresttoDate: Decimal;
        VarActualInteresttoDate: Decimal;
        VarScheduleInsurancetoDate: Decimal;
        VarActualInsurancetoDate: Decimal;
        VarAmountinArrearsInterest: Decimal;
        VarAmountinArrearsInsurance: Decimal;
        VarOutstandingPenalty: Decimal;
        VarLastInstalmentDueDate: Date;
        ObjLoanInterestAccrued: Record "Interest Due Ledger Entry";
        VarTotalInterestAccrued: Decimal;
        VarFreezingDueDate: Date;
        ObjLoansII: Record "Loans Register";
        VarTotalLoanDueAmount: Decimal;
        ObjAccount: Record Vendor;
        VarLSAUfalmeBalances: Decimal;
    begin
        ObjGenSetUp.Get;

        VarAmountRemaining := 0;
        VarAmountAllocated := 0;
        VarTotalMemberLoanDueAmount := 0;
        VarFreezingDueDate := CalcDate(ObjGenSetUp."Loan Amount Due Freeze Period", WorkDate);

        //=================================================Initialize amounts Paid on the Schedule
        ObjLoanRepaymentschedule.Reset;
        ObjLoanRepaymentschedule.SetRange(ObjLoanRepaymentschedule."Loan No.", VarLoanNo);
        if ObjLoanRepaymentschedule.FindSet then begin
            repeat
                ObjLoanRepaymentschedule."Principle Amount Paid" := 0;
                ObjLoanRepaymentschedule."Interest Paid" := 0;
                ObjLoanRepaymentschedule."Insurance Paid" := 0;
                ObjLoanRepaymentschedule.Modify;
            until ObjLoanRepaymentschedule.Next = 0;
        end;
        //=================================================End Initialize amounts Paid on the Schedule

        ObjLoans.Reset;
        ObjLoans.SetRange(ObjLoans."Loan  No.", VarLoanNo);
        if ObjLoans.FindSet then begin
            ObjLoans.CalcFields(ObjLoans."Principle Paid to Date", ObjLoans."Loan Insurance Paid", ObjLoans."Interest Paid", ObjLoans."Principle Paid Historical",
            ObjLoans."Interest Paid Historical", ObjLoans."Penalty Paid Historical", ObjLoans."Insurance Paid Historical");
            VarPrinciplePaid := ((ObjLoans."Principle Paid to Date" + ObjLoans."Principle Paid Historical") * -1);
            VarInterestPaid := (ObjLoans."Interest Paid" + ObjLoans."Interest Paid Historical");
            VarInsurancePaid := ((ObjLoans."Loan Insurance Paid" * -1) + ObjLoans."Insurance Paid Historical");
        end;

        VarAmountRemaining := VarPrinciplePaid;
        VarAmountRemainingInterest := VarInterestPaid;
        VarAmountRemainingInsurance := VarInsurancePaid;


        //====================================================Loan Principle
        ObjLoanRepaymentschedule.Reset;
        ObjLoanRepaymentschedule.SetRange(ObjLoanRepaymentschedule."Loan No.", VarLoanNo);
        if ObjLoanRepaymentschedule.FindSet then begin
            repeat
                if VarAmountRemaining > 0 then begin
                    if VarAmountRemaining >= ObjLoanRepaymentschedule."Principal Repayment" then begin
                        VarAmountAllocated := ObjLoanRepaymentschedule."Principal Repayment"
                    end;

                    if VarAmountRemaining < ObjLoanRepaymentschedule."Principal Repayment" then begin
                        VarAmountAllocated := VarAmountRemaining;
                    end;

                    ObjLoanRepaymentschedule."Principle Amount Paid" := VarAmountAllocated;
                    ObjLoanRepaymentschedule.Modify;
                    VarAmountRemaining := VarAmountRemaining - VarAmountAllocated;
                end;
            until ObjLoanRepaymentschedule.Next = 0;
        end;

        //====================================================Loan Interest
        ObjLoanRepaymentschedule.Reset;
        ObjLoanRepaymentschedule.SetRange(ObjLoanRepaymentschedule."Loan No.", VarLoanNo);
        if ObjLoanRepaymentschedule.FindSet then begin
            repeat
                if VarAmountRemainingInterest > 0 then begin

                    if VarAmountRemainingInterest >= ObjLoanRepaymentschedule."Monthly Interest" then begin
                        VarAmountAllocatedInterest := ObjLoanRepaymentschedule."Monthly Interest"
                    end;

                    if VarAmountRemainingInterest < ObjLoanRepaymentschedule."Monthly Interest" then begin
                        VarAmountAllocatedInterest := VarAmountRemainingInterest;
                    end;

                    ObjLoanRepaymentschedule."Interest Paid" := VarAmountAllocatedInterest;
                    ObjLoanRepaymentschedule.Modify;
                    VarAmountRemainingInterest := VarAmountRemainingInterest - VarAmountAllocatedInterest;
                end;
            until ObjLoanRepaymentschedule.Next = 0;
        end;




        //====================================================Loan Insurance
        ObjLoanRepaymentschedule.Reset;
        ObjLoanRepaymentschedule.SetRange(ObjLoanRepaymentschedule."Loan No.", VarLoanNo);
        if ObjLoanRepaymentschedule.FindSet then begin
            repeat
                if VarAmountRemainingInsurance > 0 then begin
                    if VarAmountRemainingInsurance >= ObjLoanRepaymentschedule."Monthly Insurance" then begin
                        VarAmountAllocatedInsurance := ObjLoanRepaymentschedule."Monthly Insurance"
                    end;

                    if VarAmountRemainingInsurance < ObjLoanRepaymentschedule."Monthly Insurance" then begin
                        VarAmountAllocatedInsurance := VarAmountRemainingInsurance;
                    end;

                    ObjLoanRepaymentschedule."Insurance Paid" := VarAmountAllocatedInsurance;
                    ObjLoanRepaymentschedule.Modify;
                    VarAmountRemainingInsurance := VarAmountRemainingInsurance - VarAmountAllocatedInsurance;
                end;
            until ObjLoanRepaymentschedule.Next = 0;
        end;

        VarDateFilter := '..' + Format(WorkDate);

        //===================================================Scheduled Repayment to Date
        ObjLoanRepaymentschedule.Reset;
        ObjLoanRepaymentschedule.SetRange(ObjLoanRepaymentschedule."Loan No.", VarLoanNo);
        ObjLoanRepaymentschedule.SetFilter(ObjLoanRepaymentschedule."Repayment Date", '<=%1', VarFreezingDueDate);
        if ObjLoanRepaymentschedule.FindSet then begin
            repeat
                VarSchedulePrincipletoDate := VarSchedulePrincipletoDate + ObjLoanRepaymentschedule."Principal Repayment";
                VarScheduleInteresttoDate := VarScheduleInteresttoDate + ObjLoanRepaymentschedule."Monthly Interest";
                VarScheduleInsurancetoDate := VarScheduleInsurancetoDate + ObjLoanRepaymentschedule."Monthly Insurance";
            until ObjLoanRepaymentschedule.Next = 0;
        end;

        //===================================================Actual Repayment to Date
        ObjLoanRepaymentschedule.Reset;
        ObjLoanRepaymentschedule.SetRange(ObjLoanRepaymentschedule."Loan No.", VarLoanNo);
        ObjLoanRepaymentschedule.SetFilter(ObjLoanRepaymentschedule."Principle Amount Paid", '<>%1', 0);
        if ObjLoanRepaymentschedule.FindSet then begin
            if ObjLoanRepaymentschedule."Repayment Date" < VarFreezingDueDate then begin
                repeat
                    VarActualPrincipletoDate := VarActualPrincipletoDate + ObjLoanRepaymentschedule."Principle Amount Paid";
                    VarActualInteresttoDate := VarActualInteresttoDate + ObjLoanRepaymentschedule."Interest Paid";
                    VarActualInsurancetoDate := VarActualInsurancetoDate + ObjLoanRepaymentschedule."Insurance Paid";
                until ObjLoanRepaymentschedule.Next = 0;
            end;
        end;
        //====================================================Get Loan Interest In Arrears

        ObjLoanRepaymentschedule.Reset;
        ObjLoanRepaymentschedule.SetCurrentkey(ObjLoanRepaymentschedule."Repayment Date");
        ObjLoanRepaymentschedule.SetRange(ObjLoanRepaymentschedule."Loan No.", VarLoanNo);
        ObjLoanRepaymentschedule.SetFilter(ObjLoanRepaymentschedule."Repayment Date", '<=%1', VarFreezingDueDate);
        if ObjLoanRepaymentschedule.FindLast then begin
            VarLastInstalmentDueDate := ObjLoanRepaymentschedule."Repayment Date";
        end;

        ObjLoanInterestAccrued.Reset;
        ObjLoanInterestAccrued.SetRange(ObjLoanInterestAccrued."Loan No", VarLoanNo);
        ObjLoanInterestAccrued.SetFilter(ObjLoanInterestAccrued."Posting Date", '<=%1', VarLastInstalmentDueDate);
        if ObjLoanInterestAccrued.FindSet then begin
            repeat
                VarTotalInterestAccrued := VarTotalInterestAccrued + ObjLoanInterestAccrued.Amount;
            until ObjLoanInterestAccrued.Next = 0;

        end;

        VarAmountinArrearsInterest := VarTotalInterestAccrued - VarInterestPaid;
        if VarAmountinArrearsInterest < 0 then
            VarAmountinArrearsInterest := 0;
        //====================================================Get Loan Interest In Arrears


        VarAmountinArrears := 0;

        //=================================Loan Principle
        if ObjLoans.Get(VarLoanNo) then begin
            ObjLoans.CalcFields(ObjLoans."Penalty Charged", ObjLoans."Penalty Paid", ObjLoans."Outstanding Balance");
            if ObjLoans."Outstanding Balance" > 0 then begin

                VarAmountinArrears := VarSchedulePrincipletoDate - VarActualPrincipletoDate;
                VarAmountinArrearsInsurance := VarScheduleInsurancetoDate - VarActualInsurancetoDate;

                if VarAmountinArrears < 0 then begin
                    VarAmountinArrears := 0
                end;
            end;
        end;
        //=================================Loan Interest
        if VarAmountinArrearsInterest < 0 then begin
            VarAmountinArrearsInterest := 0
        end else
            VarAmountinArrearsInterest := VarAmountinArrearsInterest;

        //=================================Loan Insurance
        if VarAmountinArrearsInsurance < 0 then begin
            VarAmountinArrearsInsurance := 0
        end else
            VarAmountinArrearsInsurance := VarAmountinArrearsInsurance;



        if ObjLoans.Get(VarLoanNo) then begin
            ObjLoans.CalcFields(ObjLoans."Penalty Charged", ObjLoans."Penalty Paid", ObjLoans."Penalty Paid Historical");

            VarOutstandingPenalty := ObjLoans."Penalty Charged" - (ObjLoans."Penalty Paid" + ObjLoans."Penalty Paid Historical");
            if VarOutstandingPenalty < 0 then
                VarOutstandingPenalty := 0;


            VarTotalLoanDueAmount := VarAmountinArrears + VarAmountinArrearsInterest + VarAmountinArrearsInsurance + VarOutstandingPenalty;
        end;

        exit(VarTotalLoanDueAmount);
    end;


    procedure FnCreateGnlJournalLineBalancedChequeNo(TemplateName: Text; BatchName: Text; DocumentNo: Code[30]; LineNo: Integer; TransactionType: Option " ","Registration Fee","Share Capital","Interest Paid","Loan Repayment","Deposit Contribution","Insurance Contribution","Benevolent Fund",Loan,"Unallocated Funds",Dividend,"FOSA Account","Loan Insurance Charged","Loan Insurance Paid"; AccountType: enum "Gen. Journal Account Type"; AccountNo: Code[50];
                                                                                                                                                                                                                                                                                                                                                                                                                     TransactionDate: Date;
                                                                                                                                                                                                                                                                                                                                                                                                                     TransactionDescription: Text;
                                                                                                                                                                                                                                                                                                                                                                                                                     BalancingAccountType: enum "Gen. Journal Account Type";
                                                                                                                                                                                                                                                                                                                                                                                                                     BalancingAccountNo: Code[50];
                                                                                                                                                                                                                                                                                                                                                                                                                     TransactionAmount: Decimal;
                                                                                                                                                                                                                                                                                                                                                                                                                     DimensionActivity: Code[40];
                                                                                                                                                                                                                                                                                                                                                                                                                     LoanNo: Code[20];
                                                                                                                                                                                                                                                                                                                                                                                                                     ExternalDocumentNumber: Code[100];
                                                                                                                                                                                                                                                                                                                                                                                                                     MemberBranch: Code[100])
    var
        GenJournalLine: Record "Gen. Journal Line";
    begin
        GenJournalLine.Init;
        GenJournalLine."Journal Template Name" := TemplateName;
        GenJournalLine."Journal Batch Name" := BatchName;
        GenJournalLine."Document No." := DocumentNo;
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Transaction Type" := TransactionType;
        GenJournalLine."Account Type" := AccountType;
        GenJournalLine."Account No." := AccountNo;
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Posting Date" := TransactionDate;
        GenJournalLine.Description := TransactionDescription;
        GenJournalLine."External Document No." := ExternalDocumentNumber;
        GenJournalLine.Validate(GenJournalLine."Currency Code");
        GenJournalLine.Amount := TransactionAmount;
        GenJournalLine."Loan No" := LoanNo;
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Bal. Account Type" := BalancingAccountType;
        GenJournalLine."Bal. Account No." := BalancingAccountNo;
        GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
        GenJournalLine."Shortcut Dimension 1 Code" := DimensionActivity;
        GenJournalLine."Shortcut Dimension 2 Code" := MemberBranch;
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert;
    end;


    procedure "FnRunGetMembersLoanDue&ArrearsAmount"(VarMemberNo: Code[30])
    var
        ObjLoans: Record "Loans Register";
    begin
        ObjLoans.Reset;
        ObjLoans.SetRange(ObjLoans."Client Code", VarMemberNo);
        if ObjLoans.FindSet then begin
            repeat
                ObjLoans."Loan Current Payoff Amount" := FnRunGetLoanPayoffAmount(ObjLoans."Loan  No.");
                ObjLoans."Loan Amount Due" := FnRunLoanAmountDue(ObjLoans."Loan  No.");
                ObjLoans.Modify;
            until ObjLoans.Next = 0;
        end;
    end;


    procedure FnRunGetAccountBookBalance(VarAccountNo: Code[30]) AvailableBal: Decimal
    var
        ObjVendors: Record Vendor;
        ObjAccTypes: Record "Account Types-Saving Products";
    begin
        ObjVendors.Reset;
        ObjVendors.SetRange(ObjVendors."No.", VarAccountNo);
        if ObjVendors.Find('-') then begin
            ObjVendors.CalcFields(ObjVendors.Balance, ObjVendors."Uncleared Cheques", ObjVendors."EFT Transactions", ObjVendors."ATM Transactions", ObjVendors."Mobile Transactions",
            ObjVendors."Cheque Discounted Amount");
            AvailableBal := (ObjVendors.Balance + ObjVendors."Over Draft Limit Amount" - ObjVendors."ATM Transactions"
            - ObjVendors."EFT Transactions" - ObjVendors."Mobile Transactions");

        end;
        exit(AvailableBal);
    end;

    local procedure FnRunAccrueInterestforNewLoansPayoff(VarLoanNo: Code[30])
    var
        ObjInterestLedger: Record "Interest Due Ledger Entry";
        ObjLoan: Record "Loans Register";
        VarLineNo: Integer;
    begin
        ObjInterestLedger.Reset;
        ObjInterestLedger.SetRange("Loan No", VarLoanNo);
        if ObjInterestLedger.FindSet = false then begin
            ObjLoans.Reset;
            ObjLoans.SetRange("Loan  No.", VarLoanNo);
            if ObjLoans.FindSet then begin
                ObjLoans.CalcFields(ObjLoans."Outstanding Balance");
                ObjInterestLedger.Reset;
                ObjInterestLedger.SetCurrentkey(ObjInterestLedger."Entry No.");
                if ObjInterestLedger.FindLast then
                    VarLineNo := ObjInterestLedger."Entry No." + 1;

                ObjInterestLedger.Init;
                ObjInterestLedger."Journal Batch Name" := 'INTRESTDUE';
                ObjInterestLedger."Entry No." := VarLineNo;
                ObjInterestLedger."Customer No." := ObjLoans."Client Code";
                ObjInterestLedger."Transaction Type" := ObjInterestLedger."transaction type"::"Interest Due";
                ObjInterestLedger."Document No." := FnRunGetNextTransactionDocumentNo;
                ObjInterestLedger."Posting Date" := WorkDate;
                ObjInterestLedger.Description := ObjLoans."Loan  No." + ' ' + 'Interest charged';
                ObjInterestLedger.Amount := ROUND(ObjLoans."Outstanding Balance" * (ObjLoans.Interest / 1200), 1, '>');
                if ObjLoans.Source = ObjLoans.Source::" " then begin
                    ObjInterestLedger."Global Dimension 2 Code" := ObjLoans."Branch Code";
                end;
                if ObjLoans.Source = ObjLoans.Source::BOSA then begin
                    ObjInterestLedger."Global Dimension 2 Code" := ObjLoans."Branch Code";
                end;
                ObjInterestLedger."Global Dimension 1 Code" := Format(ObjLoans.Source);
                ObjInterestLedger.Validate(ObjInterestLedger."Global Dimension 2 Code");
                ObjInterestLedger.Validate(ObjInterestLedger."Global Dimension 1 Code");
                ObjInterestLedger."Loan No" := ObjLoans."Loan  No.";
                ObjInterestLedger."Interest Accrual Date" := WorkDate;
                if ObjInterestLedger.Amount <> 0 then
                    ObjInterestLedger.Insert;
            end;
        end;
    end;


    procedure FnRunProcessStandingOrder(VarStandingOrderNo: Code[30]; VarStandingRunDate: Date)
    var
        ObjStandingOrders: Record "Standing Orders";
        ObjStandingOrderReg: Record "Standing Order Register";
        VarAmountDed: Decimal;
        AvailableBal: Decimal;
        LineNo: Integer;
        BATCH_TEMPLATE: Code[30];
        BATCH_NAME: Code[30];
        DOCUMENT_NO: Code[30];
        ObjReceiptAllocations: Record "Receipt Allocation";
        VarCurrMonthEndDate: Date;
        VarCurrMonthBeginDate: Date;
        VarScheduleInterest: Decimal;
        VarScheduleInsurance: Decimal;
        ObjFosaCharges: Record "Charges";
        VarStoFeeSuccess: Decimal;
        VarStoFeeAccount: Code[30];
        VarNextRetryDate: Date;
        VarDedStatus: Option Successfull,"Partial Deduction",Failed;
        ObjStoRegister: Record "Standing Order Register";
        VarSourceAccountType: Enum "Gen. Journal Account Type";
        VarDestinationAccountType: Enum "Gen. Journal Account Type";
    begin
        BATCH_TEMPLATE := 'PURCHASES';
        BATCH_NAME := 'STO';

        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
        GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
        if GenJournalLine.Find('-') then begin
            GenJournalLine.DeleteAll;
        end;


        ObjStandingOrders.Reset;
        ObjStandingOrders.SetRange(ObjStandingOrders."No.", VarStandingOrderNo);
        ObjStandingOrders.SetRange(ObjStandingOrders."Source Account Type", ObjStandingOrders."source account type"::"Member Standing Order");
        if ObjStandingOrders.FindSet then begin
            if (ObjStandingOrders."Next Run Date" = VarStandingRunDate) or (ObjStandingOrders."Next Attempt Date" = VarStandingRunDate) then begin

                VarAmountDed := 0;

                BATCH_TEMPLATE := 'PURCHASES';
                BATCH_NAME := 'STO';
                DOCUMENT_NO := VarStandingOrderNo;

                //============================================================================================Get Account Available Account Balance
                AvailableBal := FnRunGetAccountAvailableBalanceWithoutFreeze(ObjStandingOrders."Source Account No.", WorkDate);

                //============================================================================================Post When Account Available is > than Standing Order Amount
                if AvailableBal >= ObjStandingOrders.Amount then begin



                    //=====================================================================================1. DEBIT SOURCE  A/C
                    LineNo := FnRunGetNextJvLineNo(BATCH_TEMPLATE, BATCH_NAME);
                    FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::Vendor, ObjStandingOrders."Source Account No.", Today, ObjStandingOrders.Amount, 'FOSA', '',
                    ObjStandingOrders."Source Account Narrations", '', GenJournalLine."application source"::CBS);

                    /*//=======================================================================================Post to the Loan Account
                    IF ObjStandingOrders."Destination Account Type"=ObjStandingOrders."Destination Account Type"::"Other Banks Account" THEN
                      BEGIN

                        ObjReceiptAllocations.RESET;
                        ObjReceiptAllocations.SETRANGE(ObjReceiptAllocations."Document No",ObjStandingOrders."No.");
                        ObjReceiptAllocations.SETFILTER(ObjReceiptAllocations."Transaction Type",'<>%1',ObjReceiptAllocations."Transaction Type"::"Loan Repayment");
                        IF ObjReceiptAllocations.FIND('-') THEN
                           BEGIN
                            REPEAT
                              //==============================================================================1. CREDIT DESTINATION  A/C
                                LineNo:=FnRunGetNextJvLineNo(BATCH_TEMPLATE,BATCH_NAME);
                               FnCreateGnlJournalLine(BATCH_TEMPLATE,BATCH_NAME,DOCUMENT_NO,LineNo,ObjReceiptAllocations."Transaction Type",
                                ObjReceiptAllocations."Account Type",ObjReceiptAllocations."Member No",TODAY,ObjReceiptAllocations.Amount*-1,'BOSA','',
                                ObjStandingOrders."Standing Order Description",ObjReceiptAllocations."Loan No.",GenJournalLine."Application Source"::CBS);
                              UNTIL ObjReceiptAllocations.NEXT = 0;
                             END;

                              ObjReceiptAllocations.RESET;
                              ObjReceiptAllocations.SETRANGE(ObjReceiptAllocations."Document No",ObjStandingOrders."No.");
                              ObjReceiptAllocations.SETFILTER(ObjReceiptAllocations."Transaction Type",'=%1',ObjReceiptAllocations."Transaction Type"::"Loan Repayment");
                              IF ObjReceiptAllocations.FIND('-') THEN
                                 BEGIN
                                   REPEAT

                                    //===========================================================================================Get Loan Interest/Insurance and Repayment

                                      ObjLoans.RESET;
                                      ObjLoans.SETRANGE(ObjLoans."Loan  No.",ObjReceiptAllocations."Loan No.");
                                      IF ObjLoans.FINDSET THEN BEGIN
                                        ObjLoans.CALCFIELDS(ObjLoans."Outstanding Balance",ObjLoans."Interest Due",ObjLoans."Outstanding Interest",ObjLoans."Penalty Charged");
                                        VarLoanNo:=ObjLoans."Loan  No.";

                                        VarCurrMonthEndDate:=CALCDATE('CM',VarStandingRunDate);
                                        VarDate:=1;
                                        VarMonth:=DATE2DMY(VarStandingRunDate,2);
                                        VarYear:=DATE2DMY(VarStandingRunDate,3);
                                        VarCurrMonthBeginDate:=DMY2DATE(VarDate,VarMonth,VarYear);
                                        VarScheduleDateFilter:=FORMAT(VarCurrMonthBeginDate)+'..'+FORMAT(VarCurrMonthEndDate);


                                      //================Get Scheduled Balance=======================================================
                                        ObjLSchedule.RESET;
                                        ObjLSchedule.SETRANGE(ObjLSchedule."Loan No.",ObjReceiptAllocations."Loan No.");
                                        ObjLSchedule.SETRANGE(ObjLSchedule."Close Schedule",FALSE);
                                        ObjLSchedule.SETFILTER(ObjLSchedule."Repayment Date",VarScheduleDateFilter);
                                          IF ObjLSchedule.FINDFIRST THEN BEGIN
                                            VarScheduledLoanBal:=ObjLSchedule."Loan Balance";
                                            VarScheduleRepayDate:=ObjLSchedule."Repayment Date";
                                            VarScheduleInterest:=ObjLSchedule."Monthly Interest";
                                            VarScheduleInsurance:=ObjLSchedule."Monthly Insurance";
                                          END;

                                        ObjLSchedule.RESET;
                                        ObjLSchedule.SETCURRENTKEY(ObjLSchedule."Repayment Date");
                                        ObjLSchedule.SETRANGE(ObjLSchedule."Loan No.",ObjReceiptAllocations."Loan No.");
                                        ObjLSchedule.SETRANGE(ObjLSchedule."Close Schedule",FALSE);
                                            IF ObjLSchedule.FINDLAST THEN BEGIN
                                              IF ObjLSchedule."Repayment Date"<TODAY THEN BEGIN
                                                VarScheduledLoanBal:=ObjLSchedule."Loan Balance";
                                                VarScheduleRepayDate:=ObjLSchedule."Repayment Date";
                                                VarScheduleInterest:=ObjLSchedule."Monthly Interest";
                                                VarScheduleInsurance:=ObjLSchedule."Monthly Insurance";
                                            END;
                                            END;
                                      //==========================================================================End Get Scheduled Balance



                                    //===========================================================================1.1. MONTHLY INTEREST  A/C
                                      LineNo:=FnRunGetNextJvLineNo(BATCH_TEMPLATE,BATCH_NAME);
                                      FnCreateGnlJournalLine(BATCH_TEMPLATE,BATCH_NAME,DOCUMENT_NO,LineNo,ObjReceiptAllocations."Transaction Type"::"Interest Paid",
                                      ObjReceiptAllocations."Account Type",ObjReceiptAllocations."Member No",TODAY,VarScheduleInterest*-1,'BOSA','',
                                      ObjStandingOrders."Standing Order Description",ObjReceiptAllocations."Loan No.",GenJournalLine."Application Source"::CBS);
                                      //==========================================================================(Monthly Interest Account)



                                    //------------------------------------1.2 CREDIT MONTHLY INSURANCE  A/C---------------------------------------------------------------------------------------------
                                      LineNo:=FnRunGetNextJvLineNo(BATCH_TEMPLATE,BATCH_NAME);
                                      FnCreateGnlJournalLine(BATCH_TEMPLATE,BATCH_NAME,DOCUMENT_NO,LineNo,ObjReceiptAllocations."Transaction Type"::"Loan Insurance Paid",
                                      ObjReceiptAllocations."Account Type",ObjReceiptAllocations."Member No",TODAY,VarScheduleInsurance*-1,'BOSA','',
                                      ObjStandingOrders."Standing Order Description",ObjReceiptAllocations."Loan No.",GenJournalLine."Application Source"::CBS);
                                      //--------------------------------(Credit Monthly Insurance Account)-------------------------------------------------------------------------------


                                    //------------------------------------1. CREDIT PRINCIPLE  A/C---------------------------------------------------------------------------------------------
                                      LineNo:=FnRunGetNextJvLineNo(BATCH_TEMPLATE,BATCH_NAME);
                                      FnCreateGnlJournalLine(BATCH_TEMPLATE,BATCH_NAME,DOCUMENT_NO,LineNo,ObjReceiptAllocations."Transaction Type",
                                      ObjReceiptAllocations."Account Type",ObjReceiptAllocations."Member No",TODAY,(ObjReceiptAllocations.Amount-(VarScheduleInterest+VarScheduleInsurance))*-1,'BOSA','',
                                      ObjStandingOrders."Standing Order Description",ObjReceiptAllocations."Loan No.",GenJournalLine."Application Source"::CBS);
                                      //--------------------------------(Credit Principle Account)-------------------------------------------------------------------------------
                              END;
                              UNTIL ObjLSchedule.NEXT=0;
                              END;
                        END;*/

                    if ObjStandingOrders."Destination Account Type" = ObjStandingOrders."destination account type"::"Member Account" then begin

                        //=================================================================================================================1. CREDIT FOSA  A/C
                        LineNo := FnRunGetNextJvLineNo(BATCH_TEMPLATE, BATCH_NAME);
                        FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                        GenJournalLine."account type"::Vendor, ObjStandingOrders."Destination Account No.", Today, ObjStandingOrders.Amount * -1, 'FOSA', '',
                        ObjStandingOrders."Destination Account Narrations", '', GenJournalLine."application source"::CBS);
                    end;

                    if ObjStandingOrders."Destination Account Type" = ObjStandingOrders."destination account type"::"Other Banks Account" then begin
                        ObjGenSetUp.Get();
                        //==============================================================================================================1. CREDIT BANK  A/C
                        LineNo := FnRunGetNextJvLineNo(BATCH_TEMPLATE, BATCH_NAME);
                        FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                        GenJournalLine."account type"::"Bank Account", ObjGenSetUp."Standing Order Bank", Today, ObjStandingOrders.Amount * -1, 'FOSA', '',
                        ObjStandingOrders."Destination Account Narrations", '', GenJournalLine."application source"::CBS);
                    end;
                    //=====================================================================================================================End Post to the Respective Destination Account

                    //===========================================================================Post Standing Order Fee
                    ObjGenSetUp.Get();

                    ObjFosaCharges.Reset;
                    ObjFosaCharges.SetRange(ObjFosaCharges."Charge Type", ObjFosaCharges."charge type"::"Standing Order Fee");
                    if ObjFosaCharges.FindSet then begin
                        if ObjFosaCharges."Use Percentage" = true then begin
                            VarStoFeeSuccess := ObjStandingOrders.Amount * (ObjFosaCharges."Percentage of Amount" / 100)
                        end else
                            VarStoFeeSuccess := ObjFosaCharges."Charge Amount";
                        VarStoFeeAccount := ObjFosaCharges."GL Account";
                    end;

                    //==================================================================================================1. DEBIT FOSA  A/C STO Charge
                    LineNo := FnRunGetNextJvLineNo(BATCH_TEMPLATE, BATCH_NAME);
                    FnCreateGnlJournalLineBalanced(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::Vendor, ObjStandingOrders."Source Account No.", Today, ObjStandingOrders."Standing Order Description", GenJournalLine."bal. account type"::"G/L Account",
                    VarStoFeeAccount, VarStoFeeSuccess, 'FOSA', '');


                    //====================================================================================================2. DEBIT FOSA  A/C Tax
                    LineNo := FnRunGetNextJvLineNo(BATCH_TEMPLATE, BATCH_NAME);
                    FnCreateGnlJournalLineBalanced(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::Vendor, ObjStandingOrders."Source Account No.", Today, ObjStandingOrders."Standing Order Description", GenJournalLine."bal. account type"::"G/L Account",
                    ObjGenSetUp."Excise Duty Account", VarStoFeeSuccess * (ObjGenSetUp."Excise Duty(%)" / 100), 'FOSA', '');

                    VarNextRetryDate := CalcDate(ObjStandingOrders.Frequency, ObjStandingOrders."Next Run Date");
                    ObjStandingOrders.Effected := true;
                    ObjStandingOrders."Auto Process" := true;
                    ObjStandingOrders."Next Run Date" := CalcDate(ObjStandingOrders.Frequency, ObjStandingOrders."Next Run Date");
                    ObjStandingOrders."Next Attempt Date" := VarNextRetryDate;
                    ObjStandingOrders."End of Tolerance Date" := CalcDate(ObjStandingOrders."No of Tolerance Days", ObjStandingOrders."Next Run Date");
                    ObjStandingOrders.Modify;
                    VarDedStatus := Vardedstatus::Successfull;

                    //=============================================================================================Standing Order Register
                    ObjStoRegister.Init;
                    ObjStoRegister."Register No." := '';
                    ObjStoRegister.Validate(ObjStoRegister."Register No.");
                    ObjStoRegister."Standing Order No." := ObjStandingOrders."No.";
                    ObjStoRegister."Source Account No." := ObjStandingOrders."Source Account No.";
                    ObjStoRegister."Staff/Payroll No." := ObjStandingOrders."Staff/Payroll No.";
                    ObjStoRegister.Date := Today;
                    ObjStoRegister."Account Name" := ObjStandingOrders."Account Name";
                    ObjStoRegister."Destination Account Type" := ObjStandingOrders."Destination Account Type";
                    ObjStoRegister."Destination Account No." := ObjStandingOrders."Destination Account No.";
                    ObjStoRegister."Destination Account Name" := ObjStandingOrders."Destination Account Name";
                    ObjStoRegister."BOSA Account No." := ObjStandingOrders."BOSA Account No.";
                    ObjStoRegister."Effective/Start Date" := ObjStandingOrders."Effective/Start Date";
                    ObjStoRegister."End Date" := ObjStandingOrders."End Date";
                    ObjStoRegister.Duration := ObjStandingOrders.Duration;
                    ObjStoRegister.Frequency := ObjStandingOrders.Frequency;
                    ObjStoRegister."Don't Allow Partial Deduction" := ObjStandingOrders."Don't Allow Partial Deduction";
                    ObjStoRegister."Deduction Status" := VarDedStatus;
                    ObjStoRegister.Remarks := ObjStandingOrders."Standing Order Description";
                    ObjStoRegister.Amount := ObjStandingOrders.Amount;
                    ObjStoRegister."Amount Deducted" := VarAmountDed;
                    if ObjStandingOrders."Destination Account Type" = ObjStandingOrders."destination account type"::"Other Banks Account" then
                        ObjStoRegister.EFT := true;
                    ObjStoRegister.Insert(true);

                end;

                //==========================================================================End Post When Account Available is > than Standing Order Amount

                if ObjStandingOrders."Execute Condition" = ObjStandingOrders."execute condition"::"If no Funds Retry Standing Order" then begin


                    //==============================================================================================================Finalize for Failed Standing Order
                    if (AvailableBal < ObjStandingOrders.Amount) and (ObjStandingOrders."Next Attempt Date" = ObjStandingOrders."End of Tolerance Date") then begin
                        ObjGenSetUp.Get();
                        ObjFosaCharges.Reset;
                        ObjFosaCharges.SetRange(ObjFosaCharges."Charge Type", ObjFosaCharges."charge type"::"Failed Standing Order Fee");
                        if ObjFosaCharges.FindSet then begin
                            if ObjFosaCharges."Use Percentage" = true then begin
                                VarStoFeeSuccess := ObjStandingOrders.Amount * (ObjFosaCharges."Percentage of Amount" / 100)
                            end else
                                VarStoFeeSuccess := ObjFosaCharges."Charge Amount";
                            VarStoFeeAccount := ObjFosaCharges."GL Account";
                        end;

                        AvailableBal := FnRunGetAccountAvailableBalanceWithoutFreeze(ObjStandingOrders."Source Account No.", WorkDate);
                        if AvailableBal > (VarStoFeeSuccess + (VarStoFeeSuccess * ObjGenSetUp."Excise Duty(%)" / 100)) then begin
                            //=======================================================================================================1. DEBIT FOSA  A/C STO Charge
                            LineNo := FnRunGetNextJvLineNo(BATCH_TEMPLATE, BATCH_NAME);
                            FnCreateGnlJournalLineBalanced(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                            GenJournalLine."account type"::Vendor, ObjStandingOrders."Source Account No.", Today, 'Failed Standing Order Fee', GenJournalLine."bal. account type"::"G/L Account",
                            VarStoFeeAccount, VarStoFeeSuccess, 'FOSA', '');

                            //========================================================================================================2. DEBIT FOSA  A/C Tax
                            LineNo := FnRunGetNextJvLineNo(BATCH_TEMPLATE, BATCH_NAME);
                            FnCreateGnlJournalLineBalanced(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                            GenJournalLine."account type"::Vendor, ObjStandingOrders."Source Account No.", Today, 'Tax: Failed Standing Order Fee', GenJournalLine."bal. account type"::"G/L Account",
                            ObjGenSetUp."Excise Duty Account", VarStoFeeSuccess * (ObjGenSetUp."Excise Duty(%)" / 100), 'FOSA', '');

                        end else
                            FnRunCreateUnchargedFailedStandingOrderFeeEntries(ObjStandingOrders."No.", WorkDate, VarStoFeeSuccess + (VarStoFeeSuccess * (ObjGenSetUp."Excise Duty(%)" / 100)));

                        ObjStandingOrders.Unsuccessfull := true;
                        ObjStandingOrders."Auto Process" := true;
                        ObjStandingOrders."Next Run Date" := CalcDate(ObjStandingOrders.Frequency, ObjStandingOrders."Next Run Date");
                        ObjStandingOrders."Next Attempt Date" := CalcDate(ObjStandingOrders.Frequency, ObjStandingOrders."Next Run Date");
                        ObjStandingOrders."End of Tolerance Date" := CalcDate(ObjStandingOrders."No of Tolerance Days", ObjStandingOrders."Next Run Date");
                        ObjStandingOrders.Modify;
                        VarDedStatus := Vardedstatus::Failed;




                        //=============================================================================================Standing Order Register
                        ObjStoRegister.Init;
                        ObjStoRegister."Register No." := '';
                        ObjStoRegister.Validate(ObjStoRegister."Register No.");
                        ObjStoRegister."Standing Order No." := ObjStandingOrders."No.";
                        ObjStoRegister."Source Account No." := ObjStandingOrders."Source Account No.";
                        ObjStoRegister."Staff/Payroll No." := ObjStandingOrders."Staff/Payroll No.";
                        ObjStoRegister.Date := Today;
                        ObjStoRegister."Account Name" := ObjStandingOrders."Account Name";
                        ObjStoRegister."Destination Account Type" := ObjStandingOrders."Destination Account Type";
                        ObjStoRegister."Destination Account No." := ObjStandingOrders."Destination Account No.";
                        ObjStoRegister."Destination Account Name" := ObjStandingOrders."Destination Account Name";
                        ObjStoRegister."BOSA Account No." := ObjStandingOrders."BOSA Account No.";
                        ObjStoRegister."Effective/Start Date" := ObjStandingOrders."Effective/Start Date";
                        ObjStoRegister."End Date" := ObjStandingOrders."End Date";
                        ObjStoRegister.Duration := ObjStandingOrders.Duration;
                        ObjStoRegister.Frequency := ObjStandingOrders.Frequency;
                        ObjStoRegister."Don't Allow Partial Deduction" := ObjStandingOrders."Don't Allow Partial Deduction";
                        ObjStoRegister."Deduction Status" := VarDedStatus;
                        ObjStoRegister.Remarks := ObjStandingOrders."Standing Order Description";
                        ObjStoRegister.Amount := ObjStandingOrders.Amount;
                        ObjStoRegister."Amount Deducted" := VarAmountDed;
                        if ObjStandingOrders."Destination Account Type" = ObjStandingOrders."destination account type"::"Member Account" then
                            ObjStoRegister.EFT := true;
                        ObjStoRegister.Insert(true);
                    end else begin
                        //===============================================================================================================Update Next Attempt Date
                        if AvailableBal < ObjStandingOrders.Amount then begin
                            ObjStandingOrders."Next Attempt Date" := CalcDate('1D', VarStandingRunDate);
                            ObjStandingOrders.Modify;
                        end;
                    end;
                    //==============================================================================================================End Update Next Attempt Date

                    //=============================================================================================================End Finalize for Failed Standing Order
                end;


                //=================================================================================================================Failed Standing Order
                if ObjStandingOrders."Execute Condition" = ObjStandingOrders."execute condition"::"If no Funds Fail Standing Order" then begin
                    AvailableBal := FnRunGetAccountAvailableBalanceWithoutFreeze(ObjStandingOrders."Source Account No.", WorkDate);
                    if (AvailableBal < ObjStandingOrders.Amount) then begin


                        ObjGenSetUp.Get();
                        ObjFosaCharges.Reset;
                        ObjFosaCharges.SetRange(ObjFosaCharges."Charge Type", ObjFosaCharges."charge type"::"Failed Standing Order Fee");
                        if ObjFosaCharges.FindSet then begin
                            if ObjFosaCharges."Use Percentage" = true then begin
                                VarStoFeeSuccess := ObjStandingOrders.Amount * (ObjFosaCharges."Percentage of Amount" / 100)
                            end else
                                VarStoFeeSuccess := ObjFosaCharges."Charge Amount";
                            VarStoFeeAccount := ObjFosaCharges."GL Account";
                        end;

                        AvailableBal := FnRunGetAccountAvailableBalanceWithoutFreeze(ObjStandingOrders."Source Account No.", WorkDate);
                        if AvailableBal > VarStoFeeSuccess + (VarStoFeeSuccess * ObjGenSetUp."Excise Duty(%)" / 100) then begin
                            //=======================================================================================================1. DEBIT FOSA  A/C STO Charge
                            LineNo := FnRunGetNextJvLineNo(BATCH_TEMPLATE, BATCH_NAME);
                            FnCreateGnlJournalLineBalanced(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                            GenJournalLine."account type"::Vendor, ObjStandingOrders."Source Account No.", Today, 'Failed Standing Order Fee', GenJournalLine."bal. account type"::"G/L Account",
                            VarStoFeeAccount, VarStoFeeSuccess, 'FOSA', '');

                            //========================================================================================================2. DEBIT FOSA  A/C Tax
                            LineNo := FnRunGetNextJvLineNo(BATCH_TEMPLATE, BATCH_NAME);
                            FnCreateGnlJournalLineBalanced(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                            GenJournalLine."account type"::Vendor, ObjStandingOrders."Source Account No.", Today, 'Tax: Failed Standing Order Fee', GenJournalLine."bal. account type"::"G/L Account",
                            ObjGenSetUp."Excise Duty Account", VarStoFeeSuccess * (ObjGenSetUp."Excise Duty(%)" / 100), 'FOSA', '');
                        end else
                            FnRunCreateUnchargedFailedStandingOrderFeeEntries(ObjStandingOrders."No.", WorkDate, VarStoFeeSuccess + (VarStoFeeSuccess * (ObjGenSetUp."Excise Duty(%)" / 100)));



                        VarNextRetryDate := CalcDate(ObjStandingOrders.Frequency, ObjStandingOrders."Next Run Date");
                        ObjStandingOrders.Unsuccessfull := true;
                        ObjStandingOrders."Auto Process" := true;
                        ObjStandingOrders."Next Run Date" := CalcDate(ObjStandingOrders.Frequency, ObjStandingOrders."Next Run Date");
                        ObjStandingOrders."Next Attempt Date" := CalcDate(ObjStandingOrders.Frequency, ObjStandingOrders."Next Run Date");
                        ObjStandingOrders."End of Tolerance Date" := CalcDate(ObjStandingOrders."No of Tolerance Days", ObjStandingOrders."Next Run Date");
                        ObjStandingOrders.Modify;

                        VarDedStatus := Vardedstatus::Failed;
                        //=============================================================================================Standing Order Register
                        ObjStoRegister.Init;
                        ObjStoRegister."Register No." := '';
                        ObjStoRegister.Validate(ObjStoRegister."Register No.");
                        ObjStoRegister."Standing Order No." := ObjStandingOrders."No.";
                        ObjStoRegister."Source Account No." := ObjStandingOrders."Source Account No.";
                        ObjStoRegister."Staff/Payroll No." := ObjStandingOrders."Staff/Payroll No.";
                        ObjStoRegister.Date := Today;
                        ObjStoRegister."Account Name" := ObjStandingOrders."Account Name";
                        ObjStoRegister."Destination Account Type" := ObjStandingOrders."Destination Account Type";
                        ObjStoRegister."Destination Account No." := ObjStandingOrders."Destination Account No.";
                        ObjStoRegister."Destination Account Name" := ObjStandingOrders."Destination Account Name";
                        ObjStoRegister."BOSA Account No." := ObjStandingOrders."BOSA Account No.";
                        ObjStoRegister."Effective/Start Date" := ObjStandingOrders."Effective/Start Date";
                        ObjStoRegister."End Date" := ObjStandingOrders."End Date";
                        ObjStoRegister.Duration := ObjStandingOrders.Duration;
                        ObjStoRegister.Frequency := ObjStandingOrders.Frequency;
                        ObjStoRegister."Don't Allow Partial Deduction" := ObjStandingOrders."Don't Allow Partial Deduction";
                        ObjStoRegister."Deduction Status" := VarDedStatus;
                        ObjStoRegister.Remarks := ObjStandingOrders."Standing Order Description";
                        ObjStoRegister.Amount := ObjStandingOrders.Amount;
                        ObjStoRegister."Amount Deducted" := VarAmountDed;
                        if ObjStandingOrders."Destination Account Type" = ObjStandingOrders."destination account type"::"Member Account" then
                            ObjStoRegister.EFT := true;
                        ObjStoRegister.Insert(true);
                    end;
                    //==================================================================================================================Failed Standing Order

                end;
            end;
        end;



        ObjStandingOrders.Reset;
        ObjStandingOrders.SetRange(ObjStandingOrders."No.", VarStandingOrderNo);
        ObjStandingOrders.SetFilter(ObjStandingOrders."Source Account Type", '%1|%2', ObjStandingOrders."source account type"::"G/L Standing Order",
        ObjStandingOrders."source account type"::"Supplier Standing Order");
        if ObjStandingOrders.FindSet then begin
            if (ObjStandingOrders."Next Run Date" = VarStandingRunDate) or (ObjStandingOrders."Next Attempt Date" = VarStandingRunDate) then begin


                BATCH_TEMPLATE := 'PURCHASES';
                BATCH_NAME := 'STO';
                DOCUMENT_NO := VarStandingOrderNo;

                if ObjStandingOrders."Source Account Type" = ObjStandingOrders."source account type"::"G/L Standing Order" then begin
                    VarSourceAccountType := Varsourceaccounttype::"G/L Account"
                end else
                    if ObjStandingOrders."Source Account Type" = ObjStandingOrders."source account type"::"Supplier Standing Order" then begin
                        VarSourceAccountType := Varsourceaccounttype::Vendor
                    end;

                if ObjStandingOrders."Destination Account Type" = ObjStandingOrders."destination account type"::"G/L Account" then begin
                    VarDestinationAccountType := Vardestinationaccounttype::"G/L Account"
                end else
                    if ObjStandingOrders."Destination Account Type" = ObjStandingOrders."destination account type"::"Supplier Account" then begin
                        VarDestinationAccountType := Vardestinationaccounttype::Vendor;
                    end;


                //=====================================================================================1. DEBIT SOURCE  A/C
                LineNo := FnRunGetNextJvLineNo(BATCH_TEMPLATE, BATCH_NAME);
                FnCreateGnlJournalLineBranch(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                VarSourceAccountType, ObjStandingOrders."Source Account No.", Today, ObjStandingOrders.Amount, 'BOSA', '',
                ObjStandingOrders."Source Account Narrations", '', GenJournalLine."application source"::CBS, ObjStandingOrders."Source Global Dimension 2 Code");

                //==============================================================================1. CREDIT DESTINATION  A/C
                LineNo := FnRunGetNextJvLineNo(BATCH_TEMPLATE, BATCH_NAME);

                FnCreateGnlJournalLineBranch(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                VarDestinationAccountType, ObjStandingOrders."Destination Account No.", Today, ObjStandingOrders.Amount * -1, 'BOSA', '',
                ObjStandingOrders."Destination Account Narrations", '', GenJournalLine."application source"::CBS, ObjStandingOrders."Dest. Global Dimension 2 Code");


                //=============================================================================================Standing Order Register
                ObjStoRegister.Init;
                ObjStoRegister."Register No." := '';
                ObjStoRegister.Validate(ObjStoRegister."Register No.");
                ObjStoRegister."Standing Order No." := ObjStandingOrders."No.";
                ObjStoRegister."Source Account No." := ObjStandingOrders."Source Account No.";
                ObjStoRegister."Staff/Payroll No." := ObjStandingOrders."Staff/Payroll No.";
                ObjStoRegister.Date := Today;
                ObjStoRegister."Account Name" := ObjStandingOrders."Account Name";
                ObjStoRegister."Destination Account Type" := ObjStandingOrders."Destination Account Type";
                ObjStoRegister."Destination Account No." := ObjStandingOrders."Destination Account No.";
                ObjStoRegister."Destination Account Name" := ObjStandingOrders."Destination Account Name";
                ObjStoRegister."BOSA Account No." := ObjStandingOrders."BOSA Account No.";
                ObjStoRegister."Effective/Start Date" := ObjStandingOrders."Effective/Start Date";
                ObjStoRegister."End Date" := ObjStandingOrders."End Date";
                ObjStoRegister.Duration := ObjStandingOrders.Duration;
                ObjStoRegister.Frequency := ObjStandingOrders.Frequency;
                ObjStoRegister."Don't Allow Partial Deduction" := ObjStandingOrders."Don't Allow Partial Deduction";
                ObjStoRegister."Deduction Status" := ObjStoRegister."deduction status"::Successfull;
                ObjStoRegister.Remarks := ObjStandingOrders."Standing Order Description";
                ObjStoRegister.Amount := ObjStandingOrders.Amount;
                ObjStoRegister."Amount Deducted" := VarAmountDed;
                ObjStoRegister.Insert(true);

                ObjStandingOrders."Auto Process" := true;
                ObjStandingOrders."Next Run Date" := CalcDate(ObjStandingOrders.Frequency, ObjStandingOrders."Next Run Date");
                ObjStandingOrders."Next Attempt Date" := CalcDate(ObjStandingOrders.Frequency, ObjStandingOrders."Next Run Date");
                ObjStandingOrders."End of Tolerance Date" := CalcDate(ObjStandingOrders."No of Tolerance Days", ObjStandingOrders."Next Run Date");
                ObjStandingOrders.Modify;


            end;
        end;


        //CU posting
        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
        GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
        if GenJournalLine.Find('-') then
            Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);

        FnRunRecoverUnPaidStandingOrderFees;

    end;


    procedure FnRunGetNextJvLineNo(JournalTemplate: Code[30]; JournalBatch: Code[30]) VarLineNo: Integer
    var
        General: Record "Gen. Journal Line";
    begin
        GenJournalLine.Reset;
        GenJournalLine.SetCurrentkey(GenJournalLine."Line No.");
        GenJournalLine.SetRange("Journal Template Name", JournalTemplate);
        GenJournalLine.SetRange("Journal Batch Name", JournalBatch);
        if GenJournalLine.FindLast then begin
            VarLineNo := GenJournalLine."Line No.";
        end;
        exit(VarLineNo + 100000);
    end;


    procedure FnRunOverdraftSweeping()
    var
        ObjAccounts: Record Vendor;
        ObjAccountsII: Record Vendor;
        VarODBalance: Decimal;
        VarAvailableOtherFOSAAccounts: Decimal;
        ObjAccTypes: Record "Account Types-Saving Products";
        VarAmountDeducted: Decimal;
        GenJournalLine: Record "Gen. Journal Line";
        BATCH_TEMPLATE: Code[30];
        BATCH_NAME: Code[30];
        LineNo: Integer;
        DOCUMENT_NO: Code[30];
    begin
        BATCH_TEMPLATE := 'GENERAL';
        BATCH_NAME := 'DEFAULT';
        DOCUMENT_NO := FnRunGetNextTransactionDocumentNo;

        ObjAccountsII.CalcFields(ObjAccountsII."Balance (LCY)");
        ObjAccountsII.Reset;
        ObjAccountsII.SetFilter(ObjAccountsII."Account Type", '%1', '406');
        ObjAccountsII.SetFilter(ObjAccountsII.Status, '%1|%2', ObjAccountsII.Status::Active, ObjAccountsII.Status::Dormant);
        ObjAccountsII.SetFilter(ObjAccountsII.Blocked, '%1', ObjAccountsII.Blocked::" ");
        ObjAccountsII.SetFilter(ObjAccountsII."Balance (LCY)", '<%1', 0);
        if ObjAccountsII.FindSet then begin
            repeat

                VarODBalance := ObjAccountsII."Balance (LCY)";


                VarAvailableOtherFOSAAccounts := 0;
                ObjAccounts.Reset;
                ObjAccounts.SetRange(ObjAccounts."BOSA Account No", ObjAccountsII."BOSA Account No");
                ObjAccounts.SetFilter(ObjAccounts.Status, '%1|%2', ObjAccounts.Status::Active, ObjAccounts.Status::Dormant);
                ObjAccounts.SetFilter(ObjAccounts.Blocked, '%1', ObjAccounts.Blocked::" ");
                ObjAccounts.SetFilter(ObjAccounts."Account Type", '%1|%2|%3|%4|%5', '401', '402', '403', '404', '501');
                if ObjAccounts.FindSet then begin
                    repeat
                        if (ObjAccountsII."Overdraft Sweeping Source" = ObjAccountsII."overdraft sweeping source"::"All FOSA Accounts")
                        or ((ObjAccountsII."Overdraft Sweeping Source" = ObjAccountsII."overdraft sweeping source"::"Specific FOSA Account") and
                            (ObjAccountsII."Specific OD Sweeping Account" = ObjAccounts."No.")) then begin
                            ObjAccounts.CalcFields(ObjAccounts.Balance, ObjAccounts."Uncleared Cheques");
                            VarAvailableOtherFOSAAccounts := ((ObjAccounts.Balance + ObjAccounts."Over Draft Limit Amount") - ObjAccounts."Uncleared Cheques");

                            ObjAccTypes.Reset;
                            ObjAccTypes.SetRange(ObjAccTypes.Code, ObjAccounts."Account Type");
                            if ObjAccTypes.Find('-') then
                                VarAvailableOtherFOSAAccounts := VarAvailableOtherFOSAAccounts - ObjAccTypes."Minimum Balance";

                            ObjAccountsII.CalcFields(ObjAccountsII."Balance (LCY)");
                            VarODBalance := ObjAccountsII."Balance (LCY)";
                            if (VarAvailableOtherFOSAAccounts > 0) and (VarODBalance < 0) then begin
                                if (VarODBalance * -1) > VarAvailableOtherFOSAAccounts then begin
                                    VarAmountDeducted := VarAvailableOtherFOSAAccounts
                                end else
                                    VarAmountDeducted := (VarODBalance * -1);

                                FnRunRecoverODDebtCollectorFee(ObjAccountsII."No.", VarODBalance, VarAmountDeducted);

                                ObjAccountsII.CalcFields(ObjAccountsII."Balance (LCY)");
                                VarODBalance := ObjAccountsII."Balance (LCY)";

                                if (VarODBalance * -1) > VarAvailableOtherFOSAAccounts then begin
                                    VarAmountDeducted := VarAvailableOtherFOSAAccounts
                                end else
                                    VarAmountDeducted := (VarODBalance * -1);



                                GenJournalLine.Reset;
                                GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                                GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                                GenJournalLine.DeleteAll;

                                //------------------------------------1. Debit FOSA Account---------------------------------------------------------------------------------------------

                                LineNo := LineNo + 10000;
                                FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                                GenJournalLine."account type"::Vendor, ObjAccounts."No.", WorkDate, VarAmountDeducted, 'FOSA', '',
                                'Overdraft Sweeping to - ' + ObjAccountsII."No.", '', GenJournalLine."application source"::CBS);

                                //------------------------------------2. Credit OD Account---------------------------------------------------------------------------------------------
                                LineNo := LineNo + 10000;
                                FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                                GenJournalLine."account type"::Vendor, ObjAccountsII."No.", WorkDate, VarAmountDeducted * -1, 'FOSA', '',
                                'Overdraft Sweeping From - ' + ObjAccounts."No.", '', GenJournalLine."application source"::CBS);
                                //--------------------------------(Credit OD Account)---------------------------------------------

                                //CU posting
                                GenJournalLine.Reset;
                                GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                                GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                                if GenJournalLine.Find('-') then
                                    Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);


                            end;
                        end;
                    until ObjAccounts.Next = 0;
                end;
            until ObjAccountsII.Next = 0;
        end;
    end;


    procedure FnRunTransferOverdrawAmounttoOD()
    var
        ObjAccounts: Record Vendor;
        ObjAccountsII: Record Vendor;
        VarODBalance: Decimal;
        VarAvailableOtherFOSAAccounts: Decimal;
        ObjAccTypes: Record "Account Types-Saving Products";
        VarAmountDeducted: Decimal;
        GenJournalLine: Record "Gen. Journal Line";
        BATCH_TEMPLATE: Code[30];
        BATCH_NAME: Code[30];
        LineNo: Integer;
        DOCUMENT_NO: Code[30];
    begin
        BATCH_TEMPLATE := 'GENERAL';
        BATCH_NAME := 'DEFAULT';
        DOCUMENT_NO := FnRunGetNextTransactionDocumentNo;

        ObjAccountsII.Reset;
        ObjAccountsII.SetFilter(ObjAccountsII."Account Type", '%1', '406');
        ObjAccountsII.SetFilter(ObjAccountsII.Status, '%1|%2', ObjAccountsII.Status::Active, ObjAccountsII.Status::Dormant);
        ObjAccountsII.SetFilter(ObjAccountsII.Blocked, '%1', ObjAccountsII.Blocked::" ");
        ObjAccountsII.SetFilter(ObjAccountsII."Over Draft Limit Expiry Date", '>=%1', WorkDate);
        if ObjAccountsII.FindSet then begin
            repeat
                VarODBalance := ObjAccountsII."Balance (LCY)";


                VarAvailableOtherFOSAAccounts := 0;
                ObjAccounts.CalcFields(ObjAccounts."Balance (LCY)");
                ObjAccounts.Reset;
                ObjAccounts.SetRange(ObjAccounts."BOSA Account No", ObjAccountsII."BOSA Account No");
                ObjAccounts.SetFilter(ObjAccounts.Status, '%1|%2', ObjAccounts.Status::Active, ObjAccounts.Status::Dormant);
                ObjAccounts.SetFilter(ObjAccounts.Blocked, '%1', ObjAccounts.Blocked::" ");
                ObjAccounts.SetFilter(ObjAccounts."Account Type", '%1|%2|%3|%4|%5', '401', '402', '403', '404', '501');
                if ObjAccounts.FindSet then begin
                    repeat

                        ObjAccounts.CalcFields(ObjAccounts.Balance, ObjAccounts."Uncleared Cheques");
                        VarAvailableOtherFOSAAccounts := ((ObjAccounts.Balance + ObjAccounts."Over Draft Limit Amount") - ObjAccounts."Uncleared Cheques");

                        ObjAccTypes.Reset;
                        ObjAccTypes.SetRange(ObjAccTypes.Code, ObjAccounts."Account Type");
                        if ObjAccTypes.Find('-') then
                            VarAvailableOtherFOSAAccounts := VarAvailableOtherFOSAAccounts - ObjAccTypes."Minimum Balance";

                        if VarAvailableOtherFOSAAccounts < 0 then begin


                            GenJournalLine.Reset;
                            GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                            GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                            GenJournalLine.DeleteAll;

                            //------------------------------------1. Debit OD Account---------------------------------------------------------------------------------------------

                            LineNo := LineNo + 10000;
                            FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                            GenJournalLine."account type"::Vendor, ObjAccountsII."No.", WorkDate, VarAvailableOtherFOSAAccounts * -1, 'FOSA', '',
                            'Overdraft Sweeping to - ' + ObjAccounts."No.", '', GenJournalLine."application source"::CBS);

                            //------------------------------------2. Credit FOSA Account---------------------------------------------------------------------------------------------
                            LineNo := LineNo + 10000;
                            FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                            GenJournalLine."account type"::Vendor, ObjAccounts."No.", WorkDate, VarAvailableOtherFOSAAccounts, 'FOSA', '',
                            'Overdraft Sweeping From - ' + ObjAccountsII."No.", '', GenJournalLine."application source"::CBS);
                            //--------------------------------(Credit OD Account)---------------------------------------------

                            //CU posting
                            GenJournalLine.Reset;
                            GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                            GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                            if GenJournalLine.Find('-') then
                                Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);


                        end;
                    until ObjAccounts.Next = 0;
                end;
            until ObjAccountsII.Next = 0;
        end;
    end;


    procedure FnRunCreateUnchargedFailedStandingOrderFeeEntries(VarStandingOrderNo: Code[30]; VarTransactionDate: Date; VarChargeAmount: Decimal)
    var
        ObjStandingOrderFee: Record "Failed Standing Order Buffer";
        VarEntryNo: Integer;
        ObjStandingOrders: Record "Standing Orders";
    begin

        ObjStandingOrderFee.Reset;
        ObjStandingOrderFee.SetCurrentkey(ObjStandingOrderFee."Entry No");
        if ObjStandingOrderFee.FindLast then
            VarEntryNo := ObjStandingOrderFee."Entry No";

        ObjStandingOrders.Reset;
        ObjStandingOrders.SetRange(ObjStandingOrders."No.", VarStandingOrderNo);
        if ObjStandingOrders.FindSet then begin
            ObjStandingOrderFee.Init;
            ObjStandingOrderFee."Entry No" := VarEntryNo + 1;
            ObjStandingOrderFee."Document No" := VarStandingOrderNo;
            ObjStandingOrderFee."Account No" := ObjStandingOrders."Source Account No.";
            ObjStandingOrderFee."Account Name" := ObjStandingOrders."Account Name";
            ObjStandingOrderFee."Date Posted" := VarTransactionDate;
            ObjStandingOrderFee."Standing Order Narration" := ObjStandingOrders."Source Account Narrations";
            ObjStandingOrderFee."Amount Charged" := VarChargeAmount;
            ObjStandingOrderFee.Insert;
        end;
    end;


    procedure FnRunRecoverUnPaidStandingOrderFees()
    var
        ObjUnPaidStoCharge: Record "Failed Standing Order Buffer";
        VarAmounttoDeduct: Decimal;
        LineNo: Integer;
        BATCH_TEMPLATE: Code[30];
        BATCH_NAME: Code[30];
        DOCUMENT_NO: Code[30];
        EXTERNAL_DOC_NO: Code[40];
        SFactory: Codeunit "SURESTEP Factory";
        VarRecoveryDifference: Decimal;
        VarAmountApportioned: Decimal;
        VarDepositNo: Code[30];
        ObjVendors: Record Vendor;
        ObjAccTypes: Record "Account Types-Saving Products";
        VarBalanceinFOSA: Decimal;
        VarChargeAmount: Decimal;
        VarChargeTax: Decimal;
        ObjFosaCharges: Record "Charges";
        VarChargeAccount: Code[30];
    begin
        BATCH_TEMPLATE := 'GENERAL';
        BATCH_NAME := 'RECOVERIES';
        DOCUMENT_NO := FnRunGetNextTransactionDocumentNo;
        EXTERNAL_DOC_NO := '';

        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
        GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
        GenJournalLine.DeleteAll;

        VarAmounttoDeduct := 0;
        ObjUnPaidStoCharge.Reset;
        ObjUnPaidStoCharge.SetRange(ObjUnPaidStoCharge."Fully Settled", false);
        if ObjUnPaidStoCharge.FindSet then begin
            repeat
                VarBalanceinFOSA := FnRunGetAccountAvailableBalanceWithoutFreeze(ObjUnPaidStoCharge."Account No", WorkDate);
                VarRecoveryDifference := ObjUnPaidStoCharge."Amount Charged" - ObjUnPaidStoCharge."Amount Paid Back";

                if VarBalanceinFOSA >= ObjUnPaidStoCharge."Amount Charged" then begin

                    VarAmounttoDeduct := VarRecoveryDifference;

                    VarChargeAmount := ObjUnPaidStoCharge."Amount Charged" / ((ObjGenSetUp."Excise Duty(%)" / 100) + 1);
                    VarChargeTax := VarChargeAmount - VarChargeAmount;

                    ObjFosaCharges.Reset;
                    ObjFosaCharges.SetRange(ObjFosaCharges."Charge Type", ObjFosaCharges."charge type"::"Failed Standing Order Fee");
                    if ObjFosaCharges.FindSet then begin
                        VarChargeAccount := ObjFosaCharges."GL Account";
                    end;

                    //======================================================================================================Debit  FOSA Account Charge
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLineGuarantorRecovery(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::Vendor, ObjUnPaidStoCharge."Account No", WorkDate, VarChargeAmount, 'FOSA', EXTERNAL_DOC_NO,
                    'Unpaid Failed Standing Order Charge - ' + ObjUnPaidStoCharge."Document No", '', GenJournalLine."recovery transaction type"::"Guarantor Paid", '');

                    //======================================================================================================Debit FOSA Account Tax
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLineGuarantorRecovery(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::Vendor, ObjUnPaidStoCharge."Account No", WorkDate, VarChargeTax, 'FOSA', EXTERNAL_DOC_NO,
                    'Tax: Unpaid Failed Standing Order Charge - ' + ObjUnPaidStoCharge."Document No", '', GenJournalLine."recovery transaction type"::"Guarantor Paid", '');

                    //======================================================================================================Credit Income G/L Account
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLineGuarantorRecovery(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Deposit Contribution",
                    GenJournalLine."account type"::"G/L Account", VarChargeAccount, WorkDate, VarChargeAmount * -1, 'FOSA', EXTERNAL_DOC_NO,
                    'Unpaid Failed Standing Order Charge - ' + ObjUnPaidStoCharge."Account No", '', GenJournalLine."recovery transaction type"::"Guarantor Paid", '');

                    //======================================================================================================Credit Tax G/L Account
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLineGuarantorRecovery(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Deposit Contribution",
                    GenJournalLine."account type"::"G/L Account", ObjGenSetUp."Excise Duty Account", WorkDate, VarChargeTax * -1, 'FOSA', EXTERNAL_DOC_NO,
                    'Tax: Unpaid Failed Standing Order Charge - ' + ObjUnPaidStoCharge."Account No", '', GenJournalLine."recovery transaction type"::"Guarantor Paid", '');

                    ObjUnPaidStoCharge."Amount Paid Back" := ObjUnPaidStoCharge."Amount Paid Back" + VarAmounttoDeduct;
                    if ObjUnPaidStoCharge."Amount Charged" = ObjUnPaidStoCharge."Amount Paid Back" then begin
                        ObjUnPaidStoCharge."Fully Settled" := true;
                        ObjUnPaidStoCharge.Modify;
                    end;
                    ObjUnPaidStoCharge.Modify
                end;
            until ObjUnPaidStoCharge.Next = 0;
        end;

        //CU Post
        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
        GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
        if GenJournalLine.Find('-') then begin
            Codeunit.Run(Codeunit::"Gen. Jnl.-Post Batch", GenJournalLine);
        end;
    end;


    procedure FnRunSendScheduledAccountStatements()
    var
        ObjScheduledStatement: Record "Scheduled Statements";
        VarDayofMonth: Integer;
        VarDayofMonthText: Text;
        WeekDay: Text;
        WeekDayOption: Option Sunday,Monday,Tuesday,Wednesday,Thursday,Friday,Saturday;
        VarWeekDay: Text;
        VarDayofWeekFilter: Text;
        ObjAccount: Record Vendor;
        VarAccountName: Text;
        VarMemberEmail: Text[250];
        Filename: Text[250];
        SMTPSetup: Record "SMTP Mail Setup";
        VarMailSubject: Text;
        VarMailBody: Text;
        VarAccountType: Text;
        ObjMember: Record Customer;
        VarReportStartDate: Date;
        VarDateFilter: Text;
        FilePath: Text;
        MonthDay: Text;
        VarDayofMonthFilter: Text;
    begin
        //======================================================================================Daily Schedule

        ObjScheduledStatement.Reset;
        ObjScheduledStatement.SetRange(ObjScheduledStatement."Statement Type", ObjScheduledStatement."statement type"::"Account Statement");
        ObjScheduledStatement.SetRange(ObjScheduledStatement."Schedule Status", ObjScheduledStatement."schedule status"::Active);
        ObjScheduledStatement.SetRange(ObjScheduledStatement.Frequency, ObjScheduledStatement.Frequency::Daily);
        if ObjScheduledStatement.FindSet then begin
            repeat
                VarReportStartDate := CalcDate(ObjScheduledStatement."Statement Period", WorkDate);
                VarDateFilter := Format(VarReportStartDate) + '..' + Format(WorkDate);
                ObjVendor.Reset;
                ObjVendor.SetRange(ObjVendor."No.", ObjScheduledStatement."Account No");
                ObjVendor.SetFilter(ObjVendor."Date Filter", VarDateFilter);
                if ObjVendor.FindSet then begin
                    SMTPSetup.Get;
                    Filename := '';
                    FilePath := '';
                    if ObjScheduledStatement."Output Format" = ObjScheduledStatement."output format"::EXCEL then begin
                        Filename := 'Account Statement - ' + ObjVendor."No." + '.xlsx';
                        FilePath := SMTPSetup."Path to Save Report" + Filename;
                        Report.SaveAsExcel(Report::"FOSA Account Statement (App)", FilePath, ObjVendor);
                    end else
                        if ObjScheduledStatement."Output Format" = ObjScheduledStatement."output format"::Pdf then begin
                            Filename := 'Account Statement - ' + ObjVendor."No." + '.pdf';
                            FilePath := SMTPSetup."Path to Save Report" + Filename;
                            Report.SaveAsPdf(Report::"FOSA Account Statement (App)", FilePath, ObjVendor);
                        end;

                    VarMemberEmail := ObjScheduledStatement."Account Email";
                    VarMailSubject := 'Account Statement: ' + ObjVendor."No." + ' - ' +
                    Format(VarReportStartDate, 0, '<Day,2> <Month Text,3> <Year4>') + ' to ' +
                    Format(WorkDate, 0, '<Day,2> <Month Text,3> <Year4>');

                    VarMailBody := 'Kindly find attached your Account Statement for the period ' +
                    Format(VarReportStartDate, 0, '<Day,2> <Month Text,3> <Year4>') + ' to ' +
                    Format(WorkDate, 0, '<Day,2> <Month Text,3> <Year4>') + '. You can save, view or print the statement at your convenience.';

                    FnSendStatementViaMail(ObjScheduledStatement."Member Name", VarMailSubject, VarMailBody, VarMemberEmail, Filename, '');
                end;
            until ObjScheduledStatement.Next = 0;
        end;

        //======================================================================================Weekly Schedule
        WeekDay := Format(WorkDate, 0, '<Weekday Text>');
        VarWeekDay := CopyStr(WeekDay, 1, 2);
        VarDayofWeekFilter := '*' + VarWeekDay + '*';
        ObjScheduledStatement.Reset;
        ObjScheduledStatement.SetRange(ObjScheduledStatement."Statement Type", ObjScheduledStatement."statement type"::"Account Statement");
        ObjScheduledStatement.SetRange(ObjScheduledStatement."Schedule Status", ObjScheduledStatement."schedule status"::Active);
        ObjScheduledStatement.SetRange(ObjScheduledStatement.Frequency, ObjScheduledStatement.Frequency::Weekly);
        ObjScheduledStatement.SetFilter(ObjScheduledStatement."Days of Week", VarDayofWeekFilter);
        if ObjScheduledStatement.FindSet then begin
            repeat
                VarReportStartDate := CalcDate(ObjScheduledStatement."Statement Period", WorkDate);
                VarDateFilter := Format(VarReportStartDate) + '..' + Format(WorkDate);


                ObjVendor.Reset;
                ObjVendor.SetRange(ObjVendor."No.", ObjScheduledStatement."Account No");
                ObjVendor.SetFilter(ObjVendor."Date Filter", VarDateFilter);
                if ObjVendor.FindSet then begin
                    SMTPSetup.Get;
                    Filename := '';
                    FilePath := '';

                    if ObjScheduledStatement."Output Format" = ObjScheduledStatement."output format"::EXCEL then begin
                        Filename := 'Account Statement - ' + ObjVendor."No." + '.xlsx';
                        FilePath := SMTPSetup."Path to Save Report" + Filename;
                        Report.SaveAsExcel(Report::"FOSA Account Statement (App)", FilePath, ObjVendor);
                    end else
                        if ObjScheduledStatement."Output Format" = ObjScheduledStatement."output format"::Pdf then begin
                            Filename := 'Account Statement - ' + ObjVendor."No." + '.pdf';
                            FilePath := SMTPSetup."Path to Save Report" + Filename;
                            Report.SaveAsPdf(Report::"FOSA Account Statement (App)", FilePath, ObjVendor);
                        end;

                    VarMemberEmail := ObjScheduledStatement."Account Email";
                    VarMailSubject := 'Account Statement: ' + ObjVendor."No." + ' - ' +
                    Format(VarReportStartDate, 0, '<Day,2> <Month Text,3> <Year4>') + ' to ' +
                    Format(WorkDate, 0, '<Day,2> <Month Text,3> <Year4>');

                    VarMailBody := 'Kindly find attached your Account Statement for the period ' +
                    Format(VarReportStartDate, 0, '<Day,2> <Month Text,3> <Year4>') + ' to ' +
                    Format(WorkDate, 0, '<Day,2> <Month Text,3> <Year4>') + '. You can save, view or print the statement at your convenience.';

                    FnSendStatementViaMail(ObjScheduledStatement."Member Name", VarMailSubject, VarMailBody, VarMemberEmail, Filename, '');
                end;
            until ObjScheduledStatement.Next = 0;
        end;

        //======================================================================================Monthly Schedule
        MonthDay := Format(WorkDate, 0, '<Day,2>');
        VarDayofMonthFilter := '*' + MonthDay + '*';

        ObjScheduledStatement.Reset;
        ObjScheduledStatement.SetRange(ObjScheduledStatement."Statement Type", ObjScheduledStatement."statement type"::"Account Statement");
        ObjScheduledStatement.SetRange(ObjScheduledStatement."Schedule Status", ObjScheduledStatement."schedule status"::Active);
        ObjScheduledStatement.SetRange(ObjScheduledStatement.Frequency, ObjScheduledStatement.Frequency::Mothly);
        ObjScheduledStatement.SetFilter(ObjScheduledStatement."Days Of Month", VarDayofMonthFilter);
        if ObjScheduledStatement.FindSet then begin
            repeat
                VarReportStartDate := CalcDate(ObjScheduledStatement."Statement Period", WorkDate);
                VarDateFilter := Format(VarReportStartDate) + '..' + Format(WorkDate);


                ObjVendor.Reset;
                ObjVendor.SetRange(ObjVendor."No.", ObjScheduledStatement."Account No");
                ObjVendor.SetFilter(ObjVendor."Date Filter", VarDateFilter);
                if ObjVendor.FindSet then begin
                    SMTPSetup.Get;
                    Filename := '';
                    FilePath := '';

                    if ObjScheduledStatement."Output Format" = ObjScheduledStatement."output format"::EXCEL then begin
                        Filename := 'Account Statement - ' + ObjVendor."No." + '.xlsx';
                        FilePath := SMTPSetup."Path to Save Report" + Filename;
                        Report.SaveAsExcel(Report::"FOSA Account Statement (App)", FilePath, ObjVendor);
                    end else
                        if ObjScheduledStatement."Output Format" = ObjScheduledStatement."output format"::Pdf then begin
                            Filename := 'Account Statement - ' + ObjVendor."No." + '.pdf';
                            FilePath := SMTPSetup."Path to Save Report" + Filename;
                            Report.SaveAsPdf(Report::"FOSA Account Statement (App)", FilePath, ObjVendor);
                        end;

                    VarMemberEmail := ObjScheduledStatement."Account Email";
                    VarMailSubject := 'Account Statement: ' + ObjVendor."No." + ' - ' +
                    Format(VarReportStartDate, 0, '<Day,2> <Month Text,3> <Year4>') + ' to ' +
                    Format(WorkDate, 0, '<Day,2> <Month Text,3> <Year4>');

                    VarMailBody := 'Kindly find attached your Account Statement for the period ' +
                    Format(VarReportStartDate, 0, '<Day,2> <Month Text,3> <Year4>') + ' to ' +
                    Format(WorkDate, 0, '<Day,2> <Month Text,3> <Year4>') + '. You can save, view or print the statement at your convenience.';

                    FnSendStatementViaMail(ObjScheduledStatement."Member Name", VarMailSubject, VarMailBody, VarMemberEmail, Filename, '');
                end;
            until ObjScheduledStatement.Next = 0;
        end;
    end;


    procedure FnRunSendScheduledStatements()
    var
        ObjScheduledStatement: Record "Scheduled Statements";
        VarDayofMonth: Integer;
        VarDayofMonthText: Text;
        WeekDay: Text;
        WeekDayOption: Option Sunday,Monday,Tuesday,Wednesday,Thursday,Friday,Saturday;
        VarWeekDay: Text;
        VarDayofWeekFilter: Text;
        ObjAccount: Record Vendor;
        VarAccountName: Text;
        VarMemberEmail: Text[250];
        Filename: Text[250];
        SMTPSetup: Record "SMTP Mail Setup";
        VarMailSubject: Text;
        VarMailBody: Text;
        VarAccountType: Text;
        ObjMember: Record Customer;
        VarReportStartDate: Date;
        VarDateFilter: Text;
        FilePath: Text;
        MonthDay: Text;
        VarDayofMonthFilter: Text;
        VarStatementFormat: Text;
    begin
        //======================================================================================Daily Schedule
        ObjScheduledStatement.Reset;
        ObjScheduledStatement.SetRange(ObjScheduledStatement."Statement Type", ObjScheduledStatement."statement type"::"Member Statement");
        ObjScheduledStatement.SetRange(ObjScheduledStatement."Schedule Status", ObjScheduledStatement."schedule status"::Active);
        ObjScheduledStatement.SetRange(ObjScheduledStatement.Frequency, ObjScheduledStatement.Frequency::Daily);
        if ObjScheduledStatement.FindSet then begin
            repeat

                VarReportStartDate := CalcDate(ObjScheduledStatement."Statement Period", WorkDate);
                VarDateFilter := Format(VarReportStartDate) + '..' + Format(WorkDate);

                ObjMember.Reset;
                ObjMember.SetRange(ObjMember."No.", ObjScheduledStatement."Member No");
                ObjMember.SetFilter(ObjMember."Date Filter", VarDateFilter);
                if ObjMember.FindSet then begin
                    SMTPSetup.Get;
                    Filename := '';
                    FilePath := '';
                    if ObjScheduledStatement."Output Format" = ObjScheduledStatement."output format"::EXCEL then begin
                        Filename := 'Member Account Statement - ' + ObjMember."No." + '.xlsx';
                        FilePath := SMTPSetup."Path to Save Report" + Filename;
                        Report.SaveAsExcel(Report::"Member Account Statement(xls)", FilePath, ObjMember);
                    end else
                        if ObjScheduledStatement."Output Format" = ObjScheduledStatement."output format"::Pdf then begin
                            Filename := 'Member Account Statement - ' + ObjMember."No." + '.pdf';
                            FilePath := SMTPSetup."Path to Save Report" + Filename;
                            Report.SaveAsPdf(Report::"Member Account Statement(App)", FilePath, ObjMember);
                        end;

                    VarMemberEmail := ObjMember."E-Mail";
                    VarMailSubject := 'Account Statement: ' + ObjMember."No." + ' - ' +
                    Format(VarReportStartDate, 0, '<Day,2> <Month Text,3> <Year4>') + ' to ' +
                    Format(WorkDate, 0, '<Day,2> <Month Text,3> <Year4>');

                    VarMailBody := 'Kindly find attached your Account Statement for the period ' +
                    Format(VarReportStartDate, 0, '<Day,2> <Month Text,3> <Year4>') + ' to ' +
                    Format(WorkDate, 0, '<Day,2> <Month Text,3> <Year4>') + '. You can save, view or print the statement at your convenience.';

                    FnSendStatementViaMail(ObjScheduledStatement."Member Name", VarMailSubject, VarMailBody, VarMemberEmail, Filename, '');
                end;
            until ObjScheduledStatement.Next = 0;
        end;

        //======================================================================================Weekly Schedule
        WeekDay := Format(WorkDate, 0, '<Weekday Text>');
        VarWeekDay := CopyStr(WeekDay, 1, 2);
        VarDayofWeekFilter := '*' + VarWeekDay + '*';


        ObjScheduledStatement.Reset;
        ObjScheduledStatement.SetRange(ObjScheduledStatement."Statement Type", ObjScheduledStatement."statement type"::"Member Statement");
        ObjScheduledStatement.SetRange(ObjScheduledStatement."Schedule Status", ObjScheduledStatement."schedule status"::Active);
        ObjScheduledStatement.SetRange(ObjScheduledStatement.Frequency, ObjScheduledStatement.Frequency::Weekly);
        ObjScheduledStatement.SetFilter(ObjScheduledStatement."Days of Week", VarDayofWeekFilter);
        if ObjScheduledStatement.FindSet then begin
            repeat
                VarReportStartDate := CalcDate(ObjScheduledStatement."Statement Period", WorkDate);
                VarDateFilter := Format(VarReportStartDate) + '..' + Format(WorkDate);


                ObjMember.Reset;
                ObjMember.SetRange(ObjMember."No.", ObjScheduledStatement."Member No");
                ObjMember.SetFilter(ObjMember."Date Filter", VarDateFilter);
                if ObjMember.FindSet then begin
                    SMTPSetup.Get;
                    Filename := '';
                    FilePath := '';

                    if ObjScheduledStatement."Output Format" = ObjScheduledStatement."output format"::EXCEL then begin
                        Filename := 'Member Account Statement - ' + ObjMember."No." + '.xlsx';
                        FilePath := SMTPSetup."Path to Save Report" + Filename;
                        Report.SaveAsExcel(Report::"Member Account Statement(xls)", FilePath, ObjMember);
                    end else
                        if ObjScheduledStatement."Output Format" = ObjScheduledStatement."output format"::Pdf then begin
                            Filename := 'Member Account Statement - ' + ObjMember."No." + '.pdf';
                            FilePath := SMTPSetup."Path to Save Report" + Filename;
                            Report.SaveAsPdf(Report::"Member Account Statement(App)", FilePath, ObjMember);
                        end;

                    VarMemberEmail := ObjMember."E-Mail";
                    VarMailSubject := 'Account Statement: ' + ObjMember."No." + ' - ' +
                    Format(VarReportStartDate, 0, '<Day,2> <Month Text,3> <Year4>') + ' to ' +
                    Format(WorkDate, 0, '<Day,2> <Month Text,3> <Year4>');

                    VarMailBody := 'Kindly find attached your Account Statement for the period ' +
                    Format(VarReportStartDate, 0, '<Day,2> <Month Text,3> <Year4>') + ' to ' +
                    Format(WorkDate, 0, '<Day,2> <Month Text,3> <Year4>') + '. You can save, view or print the statement at your convenience.';

                    FnSendStatementViaMail(ObjScheduledStatement."Member Name", VarMailSubject, VarMailBody, VarMemberEmail, Filename, '');
                end;
            until ObjScheduledStatement.Next = 0;
        end;


        //======================================================================================Monthly Schedule
        MonthDay := Format(WorkDate, 0, '<Day,2>');
        VarDayofMonthFilter := '*' + MonthDay + '*';
        ;


        ObjScheduledStatement.Reset;
        ObjScheduledStatement.SetRange(ObjScheduledStatement."Statement Type", ObjScheduledStatement."statement type"::"Member Statement");
        ObjScheduledStatement.SetRange(ObjScheduledStatement."Schedule Status", ObjScheduledStatement."schedule status"::Active);
        ObjScheduledStatement.SetRange(ObjScheduledStatement.Frequency, ObjScheduledStatement.Frequency::Mothly);
        ObjScheduledStatement.SetFilter(ObjScheduledStatement."Days of Week", VarDayofMonthFilter);
        if ObjScheduledStatement.FindSet then begin
            repeat
                VarReportStartDate := CalcDate(ObjScheduledStatement."Statement Period", WorkDate);
                VarDateFilter := Format(VarReportStartDate) + '..' + Format(WorkDate);


                ObjMember.Reset;
                ObjMember.SetRange(ObjMember."No.", ObjScheduledStatement."Member No");
                ObjMember.SetFilter(ObjMember."Date Filter", VarDateFilter);
                if ObjMember.FindSet then begin
                    SMTPSetup.Get;
                    Filename := '';
                    FilePath := '';

                    if ObjScheduledStatement."Output Format" = ObjScheduledStatement."output format"::EXCEL then begin
                        Filename := 'Member Account Statement - ' + ObjMember."No." + '.xlsx';
                        FilePath := SMTPSetup."Path to Save Report" + Filename;
                        Report.SaveAsExcel(Report::"Member Account Statement(xls)", FilePath, ObjMember);
                    end else
                        if ObjScheduledStatement."Output Format" = ObjScheduledStatement."output format"::Pdf then begin
                            Filename := 'Member Account Statement - ' + ObjMember."No." + '.pdf';
                            FilePath := SMTPSetup."Path to Save Report" + Filename;
                            Report.SaveAsPdf(Report::"Member Account Statement(App)", FilePath, ObjMember);
                        end;

                    VarMemberEmail := ObjMember."E-Mail";
                    VarMailSubject := 'Account Statement: ' + ObjMember."No." + ' - ' +
                    Format(VarReportStartDate, 0, '<Day,2> <Month Text,3> <Year4>') + ' to ' +
                    Format(WorkDate, 0, '<Day,2> <Month Text,3> <Year4>');

                    VarMailBody := 'Kindly find attached your Account Statement for the period ' +
                    Format(VarReportStartDate, 0, '<Day,2> <Month Text,3> <Year4>') + ' to ' +
                    Format(WorkDate, 0, '<Day,2> <Month Text,3> <Year4>') + '. You can save, view or print the statement at your convenience.';

                    FnSendStatementViaMail(ObjScheduledStatement."Member Name", VarMailSubject, VarMailBody, VarMemberEmail, Filename, '');
                end;
            until ObjScheduledStatement.Next = 0;
        end;
    end;


    procedure FnCreateGnlJournalLineBranch(TemplateName: Text; BatchName: Text; DocumentNo: Code[30]; LineNo: Integer; TransactionType: Option " ","Registration Fee","Share Capital","Interest Paid","Loan Repayment","Deposit Contribution","Insurance Contribution","Benevolent Fund",Loan,"Unallocated Funds",Dividend,"FOSA Account"; AccountType: Enum "Gen. Journal Account Type"; AccountNo: Code[50];
                                                                                                                                                                                                                                                                                                                                                            TransactionDate: Date;
                                                                                                                                                                                                                                                                                                                                                            TransactionAmount: Decimal;
                                                                                                                                                                                                                                                                                                                                                            DimensionActivity: Code[40];
                                                                                                                                                                                                                                                                                                                                                            ExternalDocumentNo: Code[50];
                                                                                                                                                                                                                                                                                                                                                            TransactionDescription: Text;
                                                                                                                                                                                                                                                                                                                                                            LoanNumber: Code[50];
                                                                                                                                                                                                                                                                                                                                                            AppSource: Option " ",CBS,ATM,Mobile,Internet,MPESA,Equity,"Co-op",Family,"SMS Banking";
                                                                                                                                                                                                                                                                                                                                                            BranchCode: Code[30])
    var
        GenJournalLine: Record "Gen. Journal Line";
    begin
        GenJournalLine.Init;
        GenJournalLine."Journal Template Name" := TemplateName;
        GenJournalLine."Journal Batch Name" := BatchName;
        GenJournalLine."Document No." := DocumentNo;
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Account Type" := AccountType;
        GenJournalLine."Account No." := AccountNo;
        GenJournalLine."Transaction Type" := TransactionType;
        GenJournalLine."Loan No" := LoanNumber;
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Posting Date" := TransactionDate;
        GenJournalLine.Description := TransactionDescription;
        GenJournalLine."Application Source" := AppSource;
        GenJournalLine.Validate(GenJournalLine."Currency Code");
        GenJournalLine.Amount := TransactionAmount;
        GenJournalLine."External Document No." := ExternalDocumentNo;
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Shortcut Dimension 1 Code" := DimensionActivity;
        GenJournalLine."Shortcut Dimension 2 Code" := BranchCode;
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert;
    end;


    procedure FnRunGetStatementFromDateApp(DateFilter: Text) VarNewDate: Date
    var
        myDate: Integer;
        myMonth: Integer;
        myYear: Integer;
        VarBalanceFilterBeginDate: Text;
    begin

        VarBalanceFilterBeginDate := CopyStr(DateFilter, 1, 8);
        Evaluate(myDate, CopyStr(VarBalanceFilterBeginDate, 1, 2));
        Evaluate(myMonth, CopyStr(VarBalanceFilterBeginDate, 4, 2));
        Evaluate(myYear, CopyStr(VarBalanceFilterBeginDate, 7, 4));

        VarNewDate := Dmy2date(myMonth, myDate, myYear + 2000);
    end;


    procedure FnRunGetStatementToDateApp(DateFilter: Text) VarNewDate: Date
    var
        myDate: Integer;
        myMonth: Integer;
        myYear: Integer;
        VarBalanceFilterBeginDate: Text;
    begin

        if StrLen(DateFilter) = 8 then
            VarBalanceFilterBeginDate := CopyStr(DateFilter, 1, 8)
        else
            VarBalanceFilterBeginDate := CopyStr(DateFilter, 11, 18);

        Evaluate(myDate, CopyStr(VarBalanceFilterBeginDate, 1, 2));
        Evaluate(myMonth, CopyStr(VarBalanceFilterBeginDate, 4, 2));
        Evaluate(myYear, CopyStr(VarBalanceFilterBeginDate, 7, 4));

        VarNewDate := Dmy2date(myMonth, myDate, myYear + 2000);
    end;


    procedure FnRunGetStatementFromDate(DateFilter: Text) VarNewDate: Date
    var
        myDate: Integer;
        myMonth: Integer;
        myYear: Integer;
        VarBalanceFilterBeginDate: Text;
    begin

        VarBalanceFilterBeginDate := CopyStr(DateFilter, 1, 8);
        Evaluate(myDate, CopyStr(VarBalanceFilterBeginDate, 1, 2));
        Evaluate(myMonth, CopyStr(VarBalanceFilterBeginDate, 4, 2));
        Evaluate(myYear, CopyStr(VarBalanceFilterBeginDate, 7, 4));

        VarNewDate := Dmy2date(myDate, myMonth, myYear + 2000);
    end;


    procedure FnRunGetStatementToDate(DateFilter: Text) VarNewDate: Date
    var
        myDate: Integer;
        myMonth: Integer;
        myYear: Integer;
        VarBalanceFilterBeginDate: Text;
    begin
        if StrLen(DateFilter) = 8 then
            VarBalanceFilterBeginDate := CopyStr(DateFilter, 1, 8)
        else
            VarBalanceFilterBeginDate := CopyStr(DateFilter, 11, 18);

        Evaluate(myDate, CopyStr(VarBalanceFilterBeginDate, 1, 2));
        Evaluate(myMonth, CopyStr(VarBalanceFilterBeginDate, 4, 2));
        Evaluate(myYear, CopyStr(VarBalanceFilterBeginDate, 7, 4));

        VarNewDate := Dmy2date(myDate, myMonth, myYear + 2000);
    end;


    procedure FnRunProcessAssetDepreciationCustom()
    var
        ObjFixedAsset: Record "Fixed Asset";
        ObjFixedAssetDeprDetails: Record "FA Depreciation Book";
        ObjFixedAsetPostingGroup: Record "FA Posting Group";
        VarAssetDeprValue: Decimal;
        LineNo: Integer;
        FAJournalTemplate: Code[30];
        FAJournalBatch: Code[30];
        DocNo: Code[30];
        FaJournals: Record "FA Journal Line";
    begin
        VarAssetDeprValue := 0;

        FAJournalTemplate := 'GENERAL';
        FAJournalBatch := 'DEFAULT';


        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", FAJournalTemplate);
        GenJournalLine.SetRange("Journal Batch Name", FAJournalBatch);
        if GenJournalLine.FindSet then begin
            GenJournalLine.DeleteAll;
        end;

        ObjFixedAssetDeprDetails.CalcFields(ObjFixedAssetDeprDetails."Book Value", ObjFixedAssetDeprDetails."Acquisition Cost");
        ObjFixedAssetDeprDetails.Reset;
        ObjFixedAssetDeprDetails.SetFilter(ObjFixedAssetDeprDetails."Disposal Date", '%1', 0D);
        ObjFixedAssetDeprDetails.SetFilter(ObjFixedAssetDeprDetails."Next Depreciation Date", '%1', WorkDate);
        ObjFixedAssetDeprDetails.SetFilter(ObjFixedAssetDeprDetails."Book Value", '>%1', 0);
        ObjFixedAssetDeprDetails.SetFilter(ObjFixedAssetDeprDetails."Acquisition Cost", '>%1', 0);
        ObjFixedAssetDeprDetails.SetRange(ObjFixedAssetDeprDetails."Exempt From Depreciation", false);
        if ObjFixedAssetDeprDetails.FindSet then begin
            repeat
                DocNo := FnRunGetNextTransactionDocumentNo;
                ObjFixedAssetDeprDetails.CalcFields(ObjFixedAssetDeprDetails."Book Value", ObjFixedAssetDeprDetails."Acquisition Cost");
                VarAssetDeprValue := ObjFixedAssetDeprDetails."Acquisition Cost" / ObjFixedAssetDeprDetails."No. of Depreciation Months";

                if ObjFixedAssetDeprDetails."Book Value" < VarAssetDeprValue then
                    VarAssetDeprValue := ObjFixedAssetDeprDetails."Book Value";

                if ObjFixedAsset.Get(ObjFixedAssetDeprDetails."FA No.") then begin
                    if ObjFixedAsetPostingGroup.Get(ObjFixedAssetDeprDetails."FA Posting Group") then begin
                        if VarAssetDeprValue > 1 then begin
                            LineNo := LineNo + 10000;

                            FnCreateFAGLJournalLineBalanced(FAJournalTemplate, FAJournalBatch, DocNo, LineNo, GenJournalLine."fa posting type"::Depreciation,
                            GenJournalLine."account type"::"Fixed Asset", ObjFixedAsset."No.", WorkDate, 'Cummulated Depreciation ' + Format(WorkDate, 0, '<Month Text,3> <Year4>'),
                            GenJournalLine."bal. account type"::"G/L Account", ObjFixedAsetPostingGroup."Depreciation Expense Acc.", VarAssetDeprValue * -1, ObjFixedAsset."Global Dimension 1 Code", ObjFixedAsset."Global Dimension 2 Code");
                        end;
                    end;
                end;


            until ObjFixedAssetDeprDetails.Next = 0;
        end;


        //CU Post
        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", FAJournalTemplate);
        GenJournalLine.SetRange("Journal Batch Name", FAJournalBatch);
        if GenJournalLine.Find('-') then begin
            Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
        end;

        //================================================================================================Next Depreciation Date
        ObjFixedAssetDeprDetails.CalcFields(ObjFixedAssetDeprDetails."Book Value", ObjFixedAssetDeprDetails."Acquisition Cost");
        ObjFixedAssetDeprDetails.Reset;
        ObjFixedAssetDeprDetails.SetFilter(ObjFixedAssetDeprDetails."Next Depreciation Date", '%1', WorkDate);
        ObjFixedAssetDeprDetails.SetFilter(ObjFixedAssetDeprDetails."Disposal Date", '%1', 0D);
        ObjFixedAssetDeprDetails.SetFilter(ObjFixedAssetDeprDetails."Book Value", '>%1', 0);
        ObjFixedAssetDeprDetails.SetRange(ObjFixedAssetDeprDetails."Exempt From Depreciation", false);
        if ObjFixedAssetDeprDetails.FindSet then begin
            repeat
                ObjFixedAssetDeprDetails."Next Depreciation Date" := CalcDate('1M', ObjFixedAssetDeprDetails."Next Depreciation Date");
                ObjFixedAssetDeprDetails.Modify;
            until ObjFixedAssetDeprDetails.Next = 0;
        end;

    end;


    procedure FnCreateFADepreciationJournalLines(TemplateName: Text; BatchName: Text; DocumentNo: Code[30]; LineNo: Integer; FAPostingType: Enum "Gen. Journal Line FA Posting Type"; AccountNo: Code[50];
                                                                                                                                                TransactionDate: Date;
                                                                                                                                                TransactionDescription: Text;
                                                                                                                                                TransactionAmount: Decimal;
                                                                                                                                                DimensionActivity: Code[40];
                                                                                                                                                DimensionBranch: Code[40];
                                                                                                                                                FAPostingDate: Date)
    var
        FixedassetJournals: Record "FA Journal Line";
    begin
        FixedassetJournals.Init;
        FixedassetJournals."Journal Template Name" := TemplateName;
        FixedassetJournals."Journal Batch Name" := BatchName;
        FixedassetJournals."Document No." := DocumentNo;
        FixedassetJournals."Line No." := LineNo;
        FixedassetJournals."FA Posting Type" := FAPostingType;
        FixedassetJournals."FA No." := AccountNo;
        FixedassetJournals.Validate(FixedassetJournals."FA No.");
        FixedassetJournals."Posting Date" := TransactionDate;
        FixedassetJournals."FA Posting Date" := FAPostingDate;
        FixedassetJournals.Description := TransactionDescription;
        FixedassetJournals.Amount := TransactionAmount;
        FixedassetJournals.Validate(FixedassetJournals.Amount);
        FixedassetJournals."Shortcut Dimension 1 Code" := DimensionActivity;
        FixedassetJournals."Shortcut Dimension 2 Code" := DimensionBranch;
        FixedassetJournals.Validate(FixedassetJournals."Shortcut Dimension 1 Code");
        FixedassetJournals.Validate(FixedassetJournals."Shortcut Dimension 2 Code");
        if FixedassetJournals.Amount <> 0 then
            FixedassetJournals.Insert;
    end;


    procedure FnGenerateLoanRepaymentScheduleLoanCalculator(VarMemberNo: Code[30])
    var
        ObjLoanCalculator: Record "Loan Calculator";
        ObjRepaymentschedule: Record "Loan Repay Schedule-Calc";
        ObjLoansII: Record "Loans Register";
        VarPeriodDueDate: Date;
        VarRunningDate: Date;
        VarGracePeiodEndDate: Date;
        VarInstalmentEnddate: Date;
        VarGracePerodDays: Integer;
        VarInstalmentDays: Integer;
        VarNoOfGracePeriod: Integer;
        VarLoanAmount: Decimal;
        VarInterestRate: Decimal;
        VarRepayPeriod: Integer;
        VarLBalance: Decimal;
        VarRunDate: Date;
        VarInstalNo: Decimal;
        VarRepayInterval: DateFormula;
        VarTotalMRepay: Decimal;
        VarLInterest: Decimal;
        VarLPrincipal: Decimal;
        VarLInsurance: Decimal;
        VarRepayCode: Code[40];
        VarGrPrinciple: Integer;
        VarGrInterest: Integer;
        VarQPrinciple: Decimal;
        VarQCounter: Integer;
        VarInPeriod: DateFormula;
        VarInitialInstal: Integer;
        VarInitialGraceInt: Integer;
        VarScheduleBal: Decimal;
        VarLNBalance: Decimal;
        ObjProductCharge: Record "Loan Product Charges";
        VarWhichDay: Integer;
        VarRepaymentStartDate: Date;
    begin
        //======================================================================================Normal Repayment Schedule
        ObjLoanCalculator.Reset;
        ObjLoanCalculator.SetRange(ObjLoanCalculator."Member No", VarMemberNo);
        if ObjLoanCalculator.FindSet then begin
            if ObjLoanCalculator."Repayment Frequency" = ObjLoanCalculator."repayment frequency"::Daily then
                Evaluate(VarInPeriod, '1D')
            else
                if ObjLoanCalculator."Repayment Frequency" = ObjLoanCalculator."repayment frequency"::Weekly then
                    Evaluate(VarInPeriod, '1W')
                else
                    if ObjLoanCalculator."Repayment Frequency" = ObjLoanCalculator."repayment frequency"::Monthly then
                        Evaluate(VarInPeriod, '1M')
                    else
                        if ObjLoanCalculator."Repayment Frequency" = ObjLoanCalculator."repayment frequency"::Quaterly then
                            Evaluate(VarInPeriod, '1Q');

            VarRunDate := 0D;
            VarQCounter := 0;
            VarQCounter := 3;
            VarScheduleBal := 0;

            VarGrPrinciple := ObjLoanCalculator."Grace Period - Principle (M)";
            VarGrInterest := ObjLoanCalculator."Grace Period - Interest (M)";
            VarInitialGraceInt := ObjLoanCalculator."Grace Period - Interest (M)";

            ObjLoanCalculator.TestField(ObjLoanCalculator."Repayment Start Date");

            //=================================================================Delete From Tables
            ObjRepaymentschedule.Reset;
            ObjRepaymentschedule.SetRange(ObjRepaymentschedule."Loan No.", VarMemberNo);
            ObjRepaymentschedule.DeleteAll;




            VarLoanAmount := ObjLoanCalculator."Requested Amount";
            VarInterestRate := ObjLoanCalculator."Interest rate";
            VarRepayPeriod := ObjLoanCalculator.Installments;
            VarInitialInstal := ObjLoanCalculator.Installments + ObjLoanCalculator."Grace Period - Principle (M)";
            VarLBalance := ObjLoanCalculator."Requested Amount";
            VarLNBalance := ObjLoanCalculator."Requested Amount";
            VarRunDate := ObjLoanCalculator."Repayment Start Date";
            VarRepaymentStartDate := ObjLoanCalculator."Repayment Start Date";

            VarInstalNo := 0;
            Evaluate(VarRepayInterval, '1W');

            //=================================================================================Repayment Frequency
            if ObjLoanCalculator."Repayment Frequency" = ObjLoanCalculator."repayment frequency"::Daily then
                VarRunDate := CalcDate('-1D', VarRunDate)
            else
                if ObjLoanCalculator."Repayment Frequency" = ObjLoanCalculator."repayment frequency"::Weekly then
                    VarRunDate := CalcDate('-1W', VarRunDate)
                else
                    if ObjLoanCalculator."Repayment Frequency" = ObjLoanCalculator."repayment frequency"::Monthly then
                        VarRunDate := CalcDate('-1M', VarRunDate)
                    else
                        if ObjLoanCalculator."Repayment Frequency" = ObjLoanCalculator."repayment frequency"::Quaterly then
                            VarRunDate := CalcDate('-1Q', VarRunDate);

            repeat
                VarInstalNo := VarInstalNo + 1;
                VarScheduleBal := VarLBalance;

                //=====================================================================================Repayment Frequency
                if ObjLoanCalculator."Repayment Frequency" = ObjLoanCalculator."repayment frequency"::Daily then
                    VarRunDate := CalcDate('1D', VarRunDate)
                else
                    if ObjLoanCalculator."Repayment Frequency" = ObjLoanCalculator."repayment frequency"::Weekly then
                        VarRunDate := CalcDate('1W', VarRunDate)
                    else
                        if ObjLoanCalculator."Repayment Frequency" = ObjLoanCalculator."repayment frequency"::Monthly then
                            VarRunDate := CalcDate('1M', VarRunDate)
                        else
                            if ObjLoanCalculator."Repayment Frequency" = ObjLoanCalculator."repayment frequency"::Quaterly then
                                VarRunDate := CalcDate('1Q', VarRunDate);


                //=======================================================================================Amortised
                if ObjLoanCalculator."Repayment Method" = ObjLoanCalculator."repayment method"::Amortised then begin
                    ObjLoanCalculator.TestField(ObjLoanCalculator.Installments);
                    ObjLoanCalculator.TestField(ObjLoanCalculator."Interest rate");
                    ObjLoanCalculator.TestField(ObjLoanCalculator.Installments);
                    VarTotalMRepay := ROUND((VarInterestRate / 12 / 100) / (1 - Power((1 + (VarInterestRate / 12 / 100)), -VarRepayPeriod)) * VarLoanAmount, 1, '>');
                    VarTotalMRepay := (VarInterestRate / 12 / 100) / (1 - Power((1 + (VarInterestRate / 12 / 100)), -VarRepayPeriod)) * VarLoanAmount;
                    VarLInterest := ROUND(VarLBalance / 100 / 12 * VarInterestRate);

                    VarLPrincipal := VarTotalMRepay - VarLInterest;

                    ObjProductCharge.Reset;
                    ObjProductCharge.SetRange(ObjProductCharge."Product Code", ObjLoanCalculator."Loan Product Type");
                    ObjProductCharge.SetRange(ObjProductCharge."Loan Charge Type", ObjProductCharge."loan charge type"::"Loan Insurance");
                    if ObjProductCharge.FindSet then begin
                        VarLInsurance := ObjLoanCalculator."Requested Amount" * (ObjProductCharge.Percentage / 100);
                    end;
                end;

                //=======================================================================================Strainght Line
                if ObjLoanCalculator."Repayment Method" = ObjLoanCalculator."repayment method"::"Straight Line" then begin
                    ObjLoanCalculator.TestField(ObjLoanCalculator.Installments);
                    VarLPrincipal := ROUND(VarLoanAmount / VarRepayPeriod, 1, '>');
                    VarLInterest := ROUND((VarInterestRate / 1200) * VarLoanAmount, 1, '>');


                    ObjLoanCalculator.Repayment := VarLPrincipal + VarLInterest;
                    ObjLoanCalculator."Loan Principle Repayment" := VarLPrincipal;
                    ObjLoanCalculator."Loan Interest Repayment" := VarLInterest;
                    ObjLoanCalculator.Modify;

                    ObjProductCharge.Reset;
                    ObjProductCharge.SetRange(ObjProductCharge."Product Code", ObjLoanCalculator."Loan Product Type");
                    ObjProductCharge.SetRange(ObjProductCharge."Loan Charge Type", ObjProductCharge."loan charge type"::"Loan Insurance");
                    if ObjProductCharge.FindSet then begin
                        VarLInsurance := ObjLoanCalculator."Requested Amount" * (ObjProductCharge.Percentage / 100);
                        if ObjLoanCalculator."One Off Repayment" = true then
                            VarLInsurance := 0;
                    end;
                end;

                //=======================================================================================Reducing Balance
                if ObjLoanCalculator."Repayment Method" = ObjLoanCalculator."repayment method"::"Reducing Balance" then begin
                    ObjLoanCalculator.TestField(ObjLoanCalculator."Interest rate");
                    ObjLoanCalculator.TestField(ObjLoanCalculator.Installments);
                    VarLPrincipal := ROUND(VarLoanAmount / VarRepayPeriod, 1, '>');
                    VarLInterest := ROUND((VarInterestRate / 12 / 100) * VarLBalance, 1, '>');

                    ObjProductCharge.Reset;
                    ObjProductCharge.SetRange(ObjProductCharge."Product Code", ObjLoanCalculator."Loan Product Type");
                    ObjProductCharge.SetRange(ObjProductCharge."Loan Charge Type", ObjProductCharge."loan charge type"::"Loan Insurance");
                    if ObjProductCharge.FindSet then begin
                        VarLInsurance := ObjLoanCalculator."Requested Amount" * (ObjProductCharge.Percentage / 100);
                    end;
                end;

                //=======================================================================================Constant
                if ObjLoanCalculator."Repayment Method" = ObjLoanCalculator."repayment method"::Constants then begin
                    ObjLoanCalculator.TestField(ObjLoanCalculator.Repayment);
                    if VarLBalance < ObjLoanCalculator.Repayment then
                        VarLPrincipal := VarLBalance
                    else
                        VarLPrincipal := ObjLoanCalculator.Repayment;
                    VarLInterest := ObjLoanCalculator."Interest rate";

                    ObjProductCharge.Reset;
                    ObjProductCharge.SetRange(ObjProductCharge."Product Code", ObjLoanCalculator."Loan Product Type");
                    ObjProductCharge.SetRange(ObjProductCharge."Loan Charge Type", ObjProductCharge."loan charge type"::"Loan Insurance");
                    if ObjProductCharge.FindSet then begin
                        VarLInsurance := ObjLoanCalculator."Requested Amount" * (ObjProductCharge.Percentage / 100);
                    end;
                end;


                //======================================================================================Grace Period
                if VarGrPrinciple > 0 then begin
                    VarLPrincipal := 0
                end else begin
                    if ObjLoanCalculator."Instalment Period" <> VarInPeriod then
                        VarLBalance := VarLBalance - VarLPrincipal;
                    VarScheduleBal := VarScheduleBal - VarLPrincipal;
                end;

                if VarGrInterest > 0 then
                    VarLInterest := 0;

                VarGrPrinciple := VarGrPrinciple - 1;
                VarGrInterest := VarGrInterest - 1;

                //======================================================================================Insert Repayment Schedule Table
                ObjRepaymentschedule.Init;
                ObjRepaymentschedule."Repayment Code" := VarRepayCode;
                ObjRepaymentschedule."Loan No." := VarMemberNo;
                ObjRepaymentschedule."Loan Amount" := VarLoanAmount;
                ObjRepaymentschedule."Instalment No" := VarInstalNo;
                ObjRepaymentschedule."Repayment Date" := VarRunDate;//CALCDATE('CM',RunDate);
                ObjRepaymentschedule."Member No." := ObjLoanCalculator."Member No";
                ObjRepaymentschedule."Loan Category" := ObjLoanCalculator."Loan Product Type";
                ObjRepaymentschedule."Monthly Repayment" := VarLInterest + VarLPrincipal + VarLInsurance;
                ObjRepaymentschedule."Monthly Interest" := VarLInterest;
                ObjRepaymentschedule."Principal Repayment" := VarLPrincipal;
                ObjRepaymentschedule."Monthly Insurance" := VarLInsurance;
                ObjRepaymentschedule."Loan Balance" := VarScheduleBal;
                ObjRepaymentschedule.Insert;
                VarWhichDay := Date2dwy(ObjRepaymentschedule."Repayment Date", 1);



            until VarLBalance < 1
        end;
    end;


    procedure FnRunGetAccountAvailableBalanceWithoutFreeze(VarAccountNo: Code[30]; VarBalanceDate: Date) AvailableBal: Decimal
    var
        ObjVendors: Record Vendor;
        ObjAccTypes: Record "Account Types-Saving Products";
        VarDateFilter: Text;
    begin
        VarDateFilter := '..' + Format(VarBalanceDate);

        ObjVendors.Reset;
        ObjVendors.SetRange(ObjVendors."No.", VarAccountNo);
        ObjVendors.SetFilter(ObjVendors."Date Filter", VarDateFilter);
        if ObjVendors.Find('-') then begin
            ObjVendors.CalcFields(ObjVendors.Balance, ObjVendors."Cheque Discounted", ObjVendors."Uncleared Cheques", ObjVendors."EFT Transactions",
                                    ObjVendors."ATM Transactions", ObjVendors."Mobile Transactions", ObjVendors."Cheque Discounted Amount");
            AvailableBal := ((ObjVendors.Balance + ObjVendors."Cheque Discounted") - ObjVendors."Uncleared Cheques" + ObjVendors."Over Draft Limit Amount" -
                          ObjVendors."ATM Transactions" - ObjVendors."EFT Transactions" - ObjVendors."Mobile Transactions");

            ObjAccTypes.Reset;
            ObjAccTypes.SetRange(ObjAccTypes.Code, ObjVendors."Account Type");
            if ObjAccTypes.Find('-') then
                AvailableBal := AvailableBal - ObjAccTypes."Minimum Balance";
        end;

        exit(AvailableBal);
    end;


    procedure FnRunProcessDailyInterestonFOSAAccounts(VarProcessDate: Date)
    var
        ObjAccount: Record Vendor;
        VarDateFilter: Text;
        ObjAccountType: Record "Account Types-Saving Products";
        VarMinInterestCalcAmount: Decimal;
        VarInterestEarned: Decimal;
        ObjInterestEarnedBuffer: Record "Interest Buffer";
        VarEntryNo: Integer;
        ObjInterestRatessetup: Record "Account Types Interest Rates";
        VarInterestRate: Decimal;
    begin
        VarDateFilter := '..' + Format(VarProcessDate);
        ObjAccountType.Reset;
        ObjAccountType.SetRange(ObjAccountType."Earns Interest", true);
        if ObjAccountType.FindSet then begin
            repeat

                ObjInterestRatessetup.Reset;
                ObjInterestRatessetup.SetCurrentkey(ObjInterestRatessetup."Minimum Balance");
                if ObjInterestRatessetup.FindLast then begin
                    VarMinInterestCalcAmount := ObjAccountType."Interest Calc Min Balance";
                end;


                ObjAccount.CalcFields(ObjAccount.Balance);
                ObjAccount.Reset;
                ObjAccount.SetFilter(ObjAccount."Account Type", '%1&<>%2', ObjAccountType.Code, '503');
                ObjAccount.SetFilter(ObjAccount."Date Filter", VarDateFilter);
                ObjAccount.SetFilter(ObjAccount.Balance, '>=%1', VarMinInterestCalcAmount);
                if ObjAccount.FindSet then begin
                    repeat
                        VarInterestRate := 0;
                        ObjAccount.CalcFields(ObjAccount.Balance);
                        ObjInterestRatessetup.Reset;
                        ObjInterestRatessetup.SetRange(ObjInterestRatessetup."Account Type", ObjAccount."Account Type");
                        if ObjInterestRatessetup.Find('-') then begin
                            repeat
                                if (ObjAccount.Balance >= ObjInterestRatessetup."Minimum Balance") and (ObjAccount.Balance <= ObjInterestRatessetup."Maximum Balance") then begin
                                    VarInterestRate := ObjInterestRatessetup."Interest Rate";
                                end;
                            until ObjInterestRatessetup.Next = 0;
                        end;

                        VarInterestEarned := ROUND(ObjAccount.Balance * VarInterestRate / 36000, 0.01, '=');

                        ObjInterestEarnedBuffer.Reset;
                        ObjInterestEarnedBuffer.SetCurrentkey(ObjInterestEarnedBuffer.No);
                        if ObjInterestEarnedBuffer.FindLast then begin
                            VarEntryNo := ObjInterestEarnedBuffer.No;
                        end;

                        //============================================================Insert Interest Earned on the  interest Buffer
                        ObjInterestEarnedBuffer.Init;
                        ObjInterestEarnedBuffer.No := VarEntryNo + 1;
                        ObjInterestEarnedBuffer."Account No" := ObjAccount."No.";
                        ObjInterestEarnedBuffer."Account Type" := ObjAccountType.Code;
                        ObjInterestEarnedBuffer."Interest Date" := VarProcessDate;
                        ObjInterestEarnedBuffer."Interest Amount" := VarInterestEarned;
                        ObjInterestEarnedBuffer."User ID" := UserId;
                        ObjInterestEarnedBuffer."Base Amount" := ObjAccount.Balance;
                        ObjInterestEarnedBuffer.Insert;


                    until ObjAccount.Next = 0;
                end;
            until ObjAccountType.Next = 0;
        end;
    end;


    procedure FnRunPostInterestEarnedonFOSAAccountsMonthly()
    var
        ObjAccount: Record Vendor;
        BATCH_TEMPLATE: Code[30];
        BATCH_NAME: Code[30];
        DOCUMENT_NO: Code[30];
        LineNo: Integer;
        ObjAccountType: Record "Account Types-Saving Products";
        ObjInterestBuffer: Record "Interest Buffer";
    begin

        ObjAccount.CalcFields(ObjAccount."Untranfered Interest");
        ObjAccount.Reset;
        ObjAccount.SetFilter(ObjAccount."Account Type", '<>%1', '503');
        ObjAccount.SetFilter(ObjAccount."Untranfered Interest", '>%1', 0);
        if ObjAccount.FindSet then begin
            repeat
                if ObjAccountType.Get(ObjAccount."Account Type") then begin
                    ObjAccount.CalcFields(ObjAccount."Untranfered Interest");
                    //==============================================================================================================Post GL Entries
                    BATCH_TEMPLATE := 'GENERAL';
                    BATCH_NAME := 'DEFAULT';
                    DOCUMENT_NO := FnRunGetNextTransactionDocumentNo;
                    ObjGenSetUp.Get;
                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                    GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                    GenJournalLine.DeleteAll;

                    //=========================================================================================1. Debit interest Expense GL
                    LineNo := LineNo + 10000;
                    FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::"G/L Account", ObjAccountType."Interest Expense Account", WorkDate,
                    ObjAccount."Untranfered Interest", 'FOSA', '',
                    'Interest Paid to ' + ObjAccount."No." + ' - ' + Format(WorkDate, 0, '<Month Text,3> <Year4>'), '',
                    GenJournalLine."application source"::CBS);

                    //==========================================================================================2. Credit Interest Payable G/L
                    LineNo := LineNo + 10000;
                    FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::"G/L Account", ObjAccountType."Interest Payable Account", WorkDate,
                    ObjAccount."Untranfered Interest" * -1, 'FOSA', '',
                    'Interest Earned for ' + ObjAccount."No." + ' - ' + Format(WorkDate, 0, '<Month Text,3> <Year4>') + ' : ' + ObjAccount."No.", '',
                    GenJournalLine."application source"::CBS);

                    //============================================================================================3. Debit Interest Payable G/L
                    LineNo := LineNo + 10000;
                    FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::"G/L Account", ObjAccountType."Interest Payable Account", WorkDate,
                    ObjAccount."Untranfered Interest", 'FOSA', '',
                    'Interest Paid to ' + ObjAccount."No." + ' - ' + Format(WorkDate, 0, '<Month Text,3> <Year4>'), '',
                    GenJournalLine."application source"::CBS);

                    //=====================================================================================4. Credit Member Account With Gross Interest
                    LineNo := LineNo + 10000;
                    FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::Vendor, ObjAccount."No.", WorkDate, ObjAccount."Untranfered Interest" * -1, 'FOSA', '',
                    'Interest Earned ' + Format(WorkDate, 0, '<Month Text,3> <Year4>') + ' : ' + ObjAccount."No.", '',
                    GenJournalLine."application source"::CBS);

                    //====================================================================================5. Debit Member Account Withholding Tax
                    LineNo := LineNo + 10000;
                    FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::Vendor, ObjAccount."No.", WorkDate,
                    (ObjAccount."Untranfered Interest" * ObjGenSetUp."Withholding Tax (%)" / 100), 'FOSA', '',
                    'Tax: Interest Earned ' + Format(WorkDate, 0, '<Month Text,3> <Year4>'), '', GenJournalLine."application source"::CBS);

                    //=======================================================================================6. Credit Withholding Tax G/L
                    LineNo := LineNo + 10000;
                    FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::"G/L Account", ObjGenSetUp."WithHolding Tax Account", WorkDate,
                    (ObjAccount."Untranfered Interest" * ObjGenSetUp."Withholding Tax (%)" / 100) * -1, 'FOSA', '',
                    'Tax: Interest Paid to ' + ObjAccount."No." + ' - ' + Format(WorkDate, 0, '<Month Text,3> <Year4>') + ' : ' + ObjAccount."No.", '',
                    GenJournalLine."application source"::CBS);



                    //CU posting
                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                    GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                    if GenJournalLine.Find('-') then
                        Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);


                    //===================================================================================Update Interest Buffer As Transfered
                    ObjInterestBuffer.Reset;
                    ObjInterestBuffer.SetRange(ObjInterestBuffer."Account No", ObjAccount."No.");
                    ObjInterestBuffer.SetRange(ObjInterestBuffer.Transferred, false);
                    if ObjInterestBuffer.FindSet then begin
                        repeat
                            ObjInterestBuffer.Transferred := true;
                            ObjInterestBuffer.Modify;
                        until ObjInterestBuffer.Next = 0;
                    end;

                end;
            until ObjAccount.Next = 0;
        end;
    end;


    procedure FnRunCreatNewAccount(VarAccountType: Code[30]; VarAccountBranch: Code[30]; VarMemberNo: Code[30]) VarAccountNo: Code[30]
    var
        ObjAccountII: Record Vendor;
        ObjNoSeries: Record "Member Accounts No Series";
        VarDocumentNo: Code[30];
        NoSeriesMgt: Codeunit NoSeriesManagement;
        ObjAccountTypes: Record "Account Types-Saving Products";
        VarAccountPostingGroup: Code[30];
        ObjMember: Record Customer;
    begin
        ObjMember.Reset;
        ObjMember.SetRange(ObjMember."No.", VarMemberNo);
        if ObjMember.FindSet then begin
            ObjNoSeries.Reset;
            ObjNoSeries.SetRange(ObjNoSeries."Account Type", VarAccountType);
            ObjNoSeries.SetRange(ObjNoSeries."Branch Code", VarAccountBranch);
            if ObjNoSeries.FindSet then begin
                ObjNoSeries.TestField(ObjNoSeries."Account No");
                // VarDocumentNo:=NoSeriesMgt.GetNextNo(ObjNoSeries."Account No",0D,TRUE);
                VarDocumentNo := ObjNoSeries."Account No";
                if VarDocumentNo <> '' then begin
                    if ObjAccountTypes.Get(VarAccountType) then begin
                        VarAccountPostingGroup := ObjAccountTypes."Posting Group";
                    end;
                    ObjAccountII.Init;
                    ObjAccountII."No." := VarDocumentNo;
                    ObjAccountII.Name := ObjMember.Name;
                    ObjAccountII.Address := ObjMember.Address;
                    ObjAccountII."Address 2" := ObjMember."Address 2";
                    ObjAccountII.City := ObjMember.City;
                    ObjAccountII."Phone No." := ObjMember."Phone No.";
                    ObjAccountII."Global Dimension 1 Code" := 'BOSA';
                    ObjAccountII."Global Dimension 2 Code" := ObjMember."Global Dimension 2 Code";
                    ObjAccountII."Vendor Posting Group" := VarAccountPostingGroup;
                    //ObjAccountII.Picture:=ObjMember.Picture;
                    //ObjAccountII.Signature:=ObjMember.Signature;
                    ObjAccountII."Post Code" := ObjMember."Post Code";
                    ObjAccountII."E-Mail" := ObjMember."E-Mail";
                    ObjAccountII.Status := ObjAccountII.Status::Active;
                    ObjAccountII."ID No." := ObjMember."ID No.";
                    ObjAccountII."Mobile Phone No" := ObjMember."Mobile Phone No";
                    ObjAccountII."Marital Status" := ObjMember."Marital Status";
                    ObjAccountII."BOSA Account No" := ObjMember."No.";
                    ObjAccountII."Account Type" := VarAccountType;
                    ObjAccountII."Creditor Type" := ObjAccountII."creditor type"::"FOSA Account";
                    ObjAccountII."Date of Birth" := ObjMember."Date of Birth";
                    ObjAccountII."Account Creation Date" := WorkDate;
                    ObjAccountII."Registration Date" := WorkDate;
                    ObjAccountII."Created By" := UserId;
                    ObjAccountII.Created := true;
                    ObjAccountII."System Created" := true;
                    ObjAccountII.Insert;

                    ObjNoSeries."Account No" := IncStr(VarDocumentNo);
                    ObjNoSeries.Modify;

                    VarAccountNo := VarDocumentNo;
                    exit(VarAccountNo);
                end;
            end;
        end;
    end;


    procedure FnRunPostExcessRepaymentFundsDaily()
    var
        VarLoansCount: Integer;
        VarLoantoOverpay: Code[30];
        VarBiggestAmount: Decimal;
        VarSmallestAmount: Decimal;
        VarAmounttoDeduct: Decimal;
        VarMemberNo: Code[30];
        BATCH_TEMPLATE: Code[30];
        BATCH_NAME: Code[30];
        LineNo: Integer;
        DOCUMENT_NO: Code[30];
        ObjAccounts: Record Vendor;
        AvailableBal: Decimal;
        ObjRepamentSchedule: Record "Loan Repayment Schedule";
        VarRunningBal: Decimal;
    begin
        ObjGenSetUp.Get();
        BATCH_TEMPLATE := 'GENERAL';
        BATCH_NAME := 'DEFAULT';

        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
        GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
        if GenJournalLine.Find('-') then begin
            GenJournalLine.DeleteAll;
        end;

        ObjAccounts.CalcFields(ObjAccounts.Balance, ObjAccounts."Uncleared Cheques");
        ObjAccounts.Reset;
        ObjAccounts.SetRange(ObjAccounts."BOSA Account No", VarMemberNo);
        ObjAccounts.SetRange(ObjAccounts."Account Type", '507');
        ObjAccounts.SetFilter(ObjAccounts.Balance, '>%1', 1);
        if ObjAccounts.FindSet then begin
            repeat
                ObjAccounts.CalcFields(ObjAccounts.Balance, ObjAccounts."Uncleared Cheques");
                AvailableBal := (ObjAccounts.Balance - ObjAccounts."Uncleared Cheques");

                if (AvailableBal > 0) and (ObjAccounts."Excess Repayment Rule" <> ObjAccounts."excess repayment rule"::"Exempt From Excess Rule") then begin

                    ObjLoans.CalcFields(ObjLoans."Outstanding Balance");
                    ObjLoans.Reset;
                    ObjLoans.SetCurrentkey(ObjLoans."Issued Date");
                    ObjLoans.SetRange(ObjLoans."Client Code", VarMemberNo);
                    ObjLoans.SetFilter(ObjLoans."Outstanding Balance", '>%1', 0);
                    if ObjLoans.FindSet then begin
                        VarLoansCount := ObjLoans.Count;
                        if VarLoansCount = 1 then begin
                            VarLoantoOverpay := ObjLoans."Loan  No.";
                            ObjRepamentSchedule.Reset;
                            ObjRepamentSchedule.SetRange(ObjRepamentSchedule."Loan No.", ObjLoans."Loan  No.");
                            ObjRepamentSchedule.SetRange(ObjRepamentSchedule."Repayment Date", WorkDate);
                            if ObjRepamentSchedule.FindSet then begin
                                VarRunningBal := FnRunRecoverDebtCollectorFee(VarLoantoOverpay, AvailableBal, ObjAccounts."No.");

                                if VarRunningBal > ObjLoans."Outstanding Balance" then
                                    VarAmounttoDeduct := ObjLoans."Outstanding Balance"
                                else
                                    VarAmounttoDeduct := VarRunningBal;

                                DOCUMENT_NO := FnRunGetNextTransactionDocumentNo;

                                //------------------------------------1. Debit FOSA Account---------------------------------------------------------------------------------------------
                                LineNo := LineNo + 10000;
                                FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                                GenJournalLine."account type"::Vendor, ObjAccounts."No.", WorkDate, VarAmounttoDeduct, 'FOSA', '',
                                'Excess Principal Paid from ' + ObjAccounts."No." + ' to ' + ObjLoans."Loan Product Type Name", '', GenJournalLine."application source"::CBS);

                                //------------------------------------2. Credit Loan Account---------------------------------------------------------------------------------------------
                                LineNo := LineNo + 10000;
                                FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Repayment",
                                GenJournalLine."account type"::Member, VarMemberNo, WorkDate, VarAmounttoDeduct * -1, 'BOSA', '',
                                'Excess Principal Paid from ' + ObjAccounts."No." + ' to ' + ObjLoans."Loan Product Type Name", VarLoantoOverpay, GenJournalLine."application source"::CBS);
                                //--------------------------------(Credit Loan Account)---------------------------------------------

                            end;
                        end;
                    end;
                end;
            until ObjAccounts.Next = 0;
        end;

        //CU posting
        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
        GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
        if GenJournalLine.Find('-') then
            Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
    end;

    local procedure FnRunRecoverDebtCollectorFee(VarLoanNo: Code[30]; RunningBalance: Decimal; VarFOSAAccount: Code[30]) VarRunBal: Decimal
    var
        AmountToDeduct: Decimal;
        VarDebtCollectorBaseAmount: Decimal;
        VarDebtCollectorFee: Decimal;
        LineNo: Integer;
        BATCH_TEMPLATE: Code[30];
        BATCH_NAME: Code[30];
        DOCUMENT_NO: Code[30];
    begin
        //============================================================Debt Collector Fee
        if RunningBalance > 0 then begin
            ObjLoans.Reset;
            ObjLoans.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
            ObjLoans.SetRange(ObjLoans."Loan  No.", VarLoanNo);
            ObjLoans.SetRange(ObjLoans."Loan Under Debt Collection", true);
            if ObjLoans.Find('-') then begin
                ObjVendor.Reset;
                ObjVendor.SetRange(ObjVendor."No.", ObjLoans."Loan Debt Collector");
                if ObjVendor.FindSet then begin
                    ObjLoans.CalcFields(ObjLoans."Outstanding Balance", ObjLoans."Penalty Charged", ObjLoans."Penalty Paid");
                    if RunningBalance > 0 then begin
                        AmountToDeduct := 0;

                        if RunningBalance > ObjLoans."Outstanding Balance" then
                            VarDebtCollectorBaseAmount := ObjLoans."Outstanding Balance"
                        else
                            VarDebtCollectorBaseAmount := RunningBalance;

                        VarDebtCollectorFee := VarDebtCollectorBaseAmount * (ObjLoans."Loan Debt Collector Interest %" / 100);
                        VarDebtCollectorFee := VarDebtCollectorFee + (VarDebtCollectorFee * 0.16);

                        if RunningBalance > VarDebtCollectorFee then begin
                            AmountToDeduct := VarDebtCollectorFee
                        end else
                            AmountToDeduct := RunningBalance;

                        //------------------------------------1. Debit FOSA Account---------------------------------------------------------------------------------------------
                        LineNo := LineNo + 10000;
                        FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                        GenJournalLine."account type"::Vendor, VarFOSAAccount, WorkDate, AmountToDeduct, 'FOSA', '',
                        'Debt Collection Charge + VAT from ' + VarLoanNo + ObjLoans."Client Name", '', GenJournalLine."application source"::CBS);

                        LineNo := LineNo + 10000;
                        FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                        GenJournalLine."account type"::Vendor, ObjLoans."Loan Debt Collector", WorkDate, AmountToDeduct * -1, 'BOSA', VarLoanNo,
                        'Debt Collection Charge + VAT from ' + VarLoanNo + ObjLoans."Client Name", VarLoanNo, GenJournalLine."application source"::CBS);
                        VarRunBal := RunningBalance - AmountToDeduct;
                        exit(VarRunBal);
                    end;
                end;
            end;
        end;
        exit(RunningBalance);
    end;


    procedure FnAccrueInterestOneOffLoans(VarLoanNo: Code[30])
    var
        ObjLoans: Record "Loans Register";
        ObjInterestLedger: Record "Interest Due Ledger Entry";
        VarLineNo: Integer;
    begin
        ObjLoans.Reset;
        ObjLoans.SetRange("Loan  No.", VarLoanNo);
        ObjLoans.SetRange("OneOff Loan Repayment", true);
        if ObjLoans.FindSet then begin
            ObjLoans.CalcFields(ObjLoans."Outstanding Balance");
            ObjInterestLedger.Reset;
            ObjInterestLedger.SetCurrentkey(ObjInterestLedger."Entry No.");
            if ObjInterestLedger.FindLast then
                VarLineNo := ObjInterestLedger."Entry No." + 1;

            ObjInterestLedger.Init;
            ObjInterestLedger."Journal Batch Name" := 'INTRESTDUE';
            ObjInterestLedger."Entry No." := VarLineNo;
            ObjInterestLedger."Customer No." := ObjLoans."Client Code";
            ObjInterestLedger."Transaction Type" := ObjInterestLedger."transaction type"::"Interest Due";
            ObjInterestLedger."Document No." := FnRunGetNextTransactionDocumentNo;
            ObjInterestLedger."Posting Date" := CalcDate(Format(ObjLoans.Installments + ObjLoans."Grace Period - Interest (M)") + 'M', ObjLoans."Loan Disbursement Date");
            ObjInterestLedger.Description := ObjLoans."Loan  No." + ' ' + 'Interest charged';
            ObjInterestLedger.Amount := ROUND(ObjLoans."Outstanding Balance" * (ObjLoans.Interest / 1200), 1, '>') * ObjLoans.Installments;
            ObjInterestLedger."Global Dimension 2 Code" := ObjLoans."Branch Code";
            ObjInterestLedger."Global Dimension 1 Code" := FnProductSource(ObjLoans."Loan Product Type");
            ObjInterestLedger.Validate(ObjInterestLedger."Global Dimension 2 Code");
            ObjInterestLedger.Validate(ObjInterestLedger."Global Dimension 1 Code");
            ObjInterestLedger."Loan No" := ObjLoans."Loan  No.";
            ObjInterestLedger."Interest Accrual Date" := ObjLoans."Loan Disbursement Date";
            if ObjInterestLedger.Amount <> 0 then
                ObjInterestLedger.Insert;
        end;
    end;


    procedure FnProductSource(Product: Code[50]) Source: Code[50]
    var
        ObjProducts: Record "Loan Products Setup";
    begin
        ObjProducts.Reset;
        ObjProducts.SetRange(ObjProducts.Code, Product);
        if ObjProducts.Find('-') then begin
            if ObjProducts.Source = ObjProducts.Source::BOSA then
                Source := 'BOSA'
            else
                Source := 'FOSA';
        end;
        exit(Source);
    end;

    local procedure fnCreateMBankingMemberAccount(RowID: Integer)
    begin
        /*
        ObjAccountToOpen.RESET;
        ObjAccountToOpen.SETRANGE("RowID",RowID);
        ObjAccountToOpen.SETRANGE("AccountMaintained",TRUE);
        IF ObjAccountToOpen.FIND('-'); THEN
          ERROR('This Account has been Maintained.');
        
        //-----End Check Mandatory Fields---------
        
        //----Check If account Already Exists------
        Acc.RESET;
        Acc.SETRANGE(Acc."BOSA Account No",ObjAccountToOpen."MemberNo");
        Acc.SETRANGE(Acc."Account Type",ObjAccountToOpen."ProductID");
        Acc.SETFILTER(Acc.Status,'<>%1',Acc.Status::Closed);
        Acc.SETFILTER(Acc.Status,'<>%1',Acc.Status::Deceased);
        Acc.SETRANGE(Acc.Status,Acc.Status::Active);
          IF Acc.FIND('-') THEN
            ERROR('Account already exists. %1',Acc."No.");
        //----End Check If account Already Exists------
        
        
        //---Checkfields If Fixed Deposit------------
        IF AccoutTypes.GET(ObjAccountToOpen."ProductID" ) THEN BEGIN
          IF AccoutTypes."Fixed Deposit" = TRUE THEN BEGIN
            TESTFIELD("Savings Account No.");
            //TESTFIELD("Maturity Type");
            //TESTFIELD("Fixed Deposit Type");
        END;
        //---End Checkfields If Fixed Deposit------------
        
        IF CONFIRM('Are you sure you want to create this account?',TRUE) = FALSE THEN
        EXIT;
        "Application Status" := "Application Status"::Converted;
        "Registration Date":=TODAY;
        MODIFY;
        
        //--Assign Account Nos Based On The Product Type-----
        //FOSA A/C FORMAT =PREFIX-MEMBERNO-PRODUCTCODE
        IF AccoutTypes.GET("Account Type") THEN
           AcctNo:=AccoutTypes."Account No Prefix"+'-'+ "BOSA Account No" +'-'+AccoutTypes."Product Code";
        
        //---Create Account on Vendor Table----
        Accounts.INIT;
        Accounts."No.":=AcctNo;
        Accounts."Date of Birth":="Date of Birth";
        Accounts.Name:=Name;
        Accounts."Creditor Type":=Accounts."Creditor Type"::"FOSA Account";
        Accounts."Personal No.":="Staff No";
        Accounts."ID No.":="ID No.";
        Accounts."Mobile Phone No":="Mobile Phone No";
        Accounts."Registration Date":="Registration Date";
        Accounts."Employer Code":="Employer Code";
        Accounts."BOSA Account No":="BOSA Account No";
        Accounts.Picture:=Picture;
        Accounts.Signature:=Signature;
        Accounts."Passport No.":="Passport No.";
        Accounts.Status:=Accounts.Status::Active;
        Accounts."Account Type":="Account Type";
        Accounts."Account Category":="Account Category";
        Accounts."Date of Birth":="Date of Birth";
        Accounts."Global Dimension 1 Code":='FOSA';
        Accounts."Global Dimension 2 Code":="Global Dimension 2 Code";
        Accounts.Address:=Address;
        Accounts."Address 2":="Address 2";
        Accounts.City:=City;
        Accounts."Phone No.":="Phone No.";
        Accounts."Telex No.":="Telex No.";
        Accounts."Post Code":="Post Code";
        Accounts.County:=County;
        Accounts."E-Mail":="E-Mail";
        Accounts."Home Page":="Home Page";
        Accounts."Registration Date":=TODAY;
        Accounts.Status:=Status::Approved;
        Accounts.Section:=Section;
        Accounts."Home Address":="Home Address";
        Accounts.District:=District;
        Accounts.Location:=Location;
        Accounts."Sub-Location":="Sub-Location";
        Accounts."Savings Account No.":="Savings Account No.";
        Accounts."Registration Date":=TODAY;
        Accounts."Vendor Posting Group":="Vendor Posting Group";
        Accounts.INSERT;
        "Application Status":="Application Status"::Converted;
        END;
        AccoutTypes."Last No Used":=INCSTR(AccoutTypes."Last No Used");
        AccoutTypes.MODIFY;
        
        Accounts.RESET;
        IF Accounts.GET(AcctNo) THEN BEGIN
          Accounts.VALIDATE(Accounts.Name);
          Accounts.VALIDATE(Accounts."Account Type");
          Accounts.VALIDATE(Accounts."Global Dimension 1 Code");
          Accounts.VALIDATE(Accounts."Global Dimension 2 Code");
          Accounts.MODIFY;
        
          //---Update BOSA with FOSA Account----
          IF ("Account Type" = 'SAVINGS') THEN BEGIN
            IF Cust.GET("BOSA Account No") THEN BEGIN
            Cust."FOSA Account No.":=AcctNo;
            Cust.MODIFY;
            END;
          END;
          //---End Update BOSA with FOSA Account----
          END;
        
        //----Insert Nominee Information------
        NextOfKinApp.RESET;
        NextOfKinApp.SETRANGE(NextOfKinApp."Account No","No.");
          IF NextOfKinApp.FIND('-') THEN BEGIN
            REPEAT
              NextOfKin.INIT;
              NextOfKin."Account No":="No.";
              NextOfKin.Name:=NextOfKinApp.Name;
              NextOfKin.Relationship:=NextOfKinApp.Relationship;
              NextOfKin.Beneficiary:=NextOfKinApp.Beneficiary;
              NextOfKin."Date of Birth":=NextOfKinApp."Date of Birth";
              NextOfKin.Address:=NextOfKinApp.Address;
              NextOfKin.Telephone:=NextOfKinApp.Telephone;
              //NextOfKin.Fax:=NextOfKinApp.Fax;
              NextOfKin.Email:=NextOfKinApp.Email;
              NextOfKin."ID No.":=NextOfKinApp."ID No.";
              NextOfKin."%Allocation":=NextOfKinApp."%Allocation";
              NextOfKin.INSERT;
             UNTIL NextOfKinApp.NEXT = 0;
          END;
        //----End Insert Nominee Information------
        
        //Insert Account Signatories------
        AccountSignApp.RESET;
        AccountSignApp.SETRANGE(AccountSignApp."Document No","No.");
          IF AccountSignApp.FIND('-') THEN BEGIN
            REPEAT
            AccountSign.INIT;
            AccountSign."Account No":=AcctNo;
            AccountSign.Names:=AccountSignApp."Account No";
            AccountSign."Date Of Birth":=AccountSignApp."Date Of Birth";
            AccountSign."ID No.":=AccountSignApp."ID No.";
            AccountSign.Signatory:=AccountSignApp.Signatory;
            AccountSign."Must Sign":=AccountSignApp."Must Sign";
            AccountSign."Must be Present":=AccountSignApp."Must be Present";
            AccountSign.Picture:=AccountSignApp.Picture;
            AccountSign.Signature:=AccountSignApp.Signature;
            AccountSign."Expiry Date":=AccountSignApp."Expiry Date";
            AccountSign.INSERT;
            "Application Status":="Application Status"::Converted;
            UNTIL AccountSignApp.NEXT = 0;
        END;
        //Insert Account Signatories------
        
        //--Send Confirmation Sms to The Member------
         SFactory.FnSendSMS('FOSA ACC','Your Account successfully created.Account No='+AcctNo,AcctNo,"Mobile Phone No");
         MESSAGE('You have successfully created a %1 Product, A/C No=%2. Member will be notified via SMS',"Account Type",AcctNo);
        
         */

    end;


    procedure FnGetComputerName() ComputerName: Code[100]
    var
        ActiveSession: Record "Active Session";
    begin
        ActiveSession.Reset;
        ActiveSession.SetRange("User ID", UserId);
        if ActiveSession.Find('-') then
            ComputerName := ActiveSession."Client Computer Name";
        exit(ComputerName);
    end;


    procedure FnRunAccountDormancyStatus(VarAccountNo: Code[30])
    var
        ObjAccountLedger: Record "Vendor Ledger Entry";
        ObjProductType: Record "Account Types-Saving Products";
        ObjAccounts: Record Vendor;
        DateFilter: Text;
        ObjDormancyRegister: Record "Accounts Dormancy Status";
        VarEntryNo: Integer;
    begin
        //=========================================================Active Accounts to Dormant
        ObjAccounts.Reset;
        ObjAccounts.SetRange(ObjAccounts."No.", VarAccountNo);
        ObjAccounts.SetFilter(ObjAccounts.Status, '<>%1|<>%2|<>%3', ObjAccounts.Status::Deceased, ObjAccounts.Status::Frozen, ObjAccounts.Status::Closed);
        if ObjAccounts.FindSet then begin
            if ObjProductType.Get(ObjAccounts."Account Type") then begin
                DateFilter := Format(CalcDate(ObjProductType."Dormancy Period (M)_I", WorkDate)) + '..' + Format(WorkDate);
            end;

            ObjAccountLedger.Reset;
            ObjAccountLedger.SetRange(ObjAccountLedger."Vendor No.", ObjAccounts."No.");
            ObjAccountLedger.SetFilter(ObjAccountLedger."Posting Date", DateFilter);
            if not ObjAccountLedger.FindSet then begin

                ObjDormancyRegister.Reset;
                ObjDormancyRegister.SetCurrentkey(ObjDormancyRegister."Entry No");
                if ObjDormancyRegister.FindLast then begin
                    VarEntryNo := ObjDormancyRegister."Entry No";
                end;

                ObjDormancyRegister.Init;
                ObjDormancyRegister."Entry No" := VarEntryNo + 1;
                ObjDormancyRegister."Effect Date" := WorkDate;
                ObjDormancyRegister."Status Pre_Change" := ObjAccounts.Status;
                ObjDormancyRegister."Status Post_Change" := ObjDormancyRegister."status post_change"::Dormant;
                ObjDormancyRegister."Account No" := ObjAccounts."No.";
                ObjDormancyRegister."Account Name" := ObjAccounts.Name;
                ObjDormancyRegister.Insert;

                ObjAccounts.Status := ObjAccounts.Status::Dormant;
                //ObjAccounts.MODIFY;
            end;
        end;

        //=========================================================Dormant Accounts to Active
        ObjAccounts.Reset;
        ObjAccounts.SetRange(ObjAccounts."No.", VarAccountNo);
        ObjAccounts.SetFilter(ObjAccounts.Status, '<>%1|<>%2|<>%3', ObjAccounts.Status::Deceased, ObjAccounts.Status::Frozen, ObjAccounts.Status::Closed);
        if ObjAccounts.FindSet then begin
            if ObjProductType.Get(ObjAccounts."Account Type") then begin
                DateFilter := Format(CalcDate(ObjProductType."Dormancy Period (M)_I", WorkDate)) + '..' + Format(WorkDate);
            end;

            ObjAccountLedger.Reset;
            ObjAccountLedger.SetRange(ObjAccountLedger."Vendor No.", ObjAccounts."No.");
            ObjAccountLedger.SetFilter(ObjAccountLedger."Posting Date", DateFilter);
            if ObjAccountLedger.FindSet then begin

                ObjDormancyRegister.Reset;
                ObjDormancyRegister.SetCurrentkey(ObjDormancyRegister."Entry No");
                if ObjDormancyRegister.FindLast then begin
                    VarEntryNo := ObjDormancyRegister."Entry No";
                end;

                ObjDormancyRegister.Init;
                ObjDormancyRegister."Entry No" := VarEntryNo + 1;
                ObjDormancyRegister."Effect Date" := WorkDate;
                ObjDormancyRegister."Status Pre_Change" := ObjAccounts.Status;
                ObjDormancyRegister."Status Post_Change" := ObjDormancyRegister."status post_change"::Dormant;
                ObjDormancyRegister."Account No" := ObjAccounts."No.";
                ObjDormancyRegister."Account Name" := ObjAccounts.Name;
                ObjDormancyRegister.Insert;

                if (ObjAccounts.Status <> ObjAccounts.Status::Deceased) or (ObjAccounts.Status <> ObjAccounts.Status::Closed) or
                  (ObjAccounts.Status <> ObjAccounts.Status::Frozen) then begin
                    ObjAccounts.Status := ObjAccounts.Status::Active;
                    //ObjAccounts.MODIFY;
                end;
            end;
        end;
    end;


    procedure FnRunProcessRefereeComissions()
    var
        ObjMembersIV: Record Customer;
        VarStartDate: Date;
        DateFilter: Text;
        ObjGenSetup: Record "Sacco General Set-Up";
        RefereeMonth1DateFilter: Text;
        RefereeMonth2DateFilter: Text;
        RefereeMonth3DateFilter: Text;
        VarMonth1Contributed: Boolean;
        VarMonth2Contributed: Boolean;
        VarMonth3Contributed: Boolean;
        ObjAccountLedger: Record "Detailed Vendor Ledg. Entry";
        ObjReferee: Record Customer;
        VarMonth1ContributedValue: Integer;
        VarMonth2ContributedValue: Integer;
        VarMonth3ContributedValue: Integer;
        VarContributionsTotal: Integer;
        ObjAccounts: Record Vendor;
        BATCH_TEMPLATE: Code[50];
        BATCH_NAME: Code[50];
        DOCUMENT_NO: Code[50];
        LineNo: Integer;
        EXTERNAL_DOC_NO: Code[50];
        GenJournalLine: Record "Gen. Journal Line";
        ObjAccountLedgerII: Record "Detailed Vendor Ledg. Entry";
        ObjAccountLedgerIII: Record "Detailed Vendor Ledg. Entry";
        VarDepositAccountNo: Code[30];
    begin
        ObjGenSetup.Get;
        VarStartDate := CalcDate(ObjGenSetup."Referee Comm. Period", WorkDate);
        RefereeMonth1DateFilter := Format(VarStartDate) + '..' + Format(CalcDate('1M', VarStartDate));
        RefereeMonth2DateFilter := Format(CalcDate('1M', VarStartDate)) + '..' + Format(CalcDate('2M', VarStartDate));
        RefereeMonth3DateFilter := Format(CalcDate('2M', VarStartDate)) + '..' + Format(CalcDate('3M', VarStartDate));
        DateFilter := Format(VarStartDate) + '..' + Format(WorkDate);



        ObjMembersIV.Reset;
        ObjMembersIV.SetFilter(ObjMembersIV."Referee Member No", '<>%1', '');
        ObjMembersIV.SetFilter(ObjMembersIV."Registration Date", DateFilter);
        ObjMembersIV.SetRange(ObjMembersIV."Referee Commission Paid", false);
        if ObjMembersIV.FindSet then begin
            repeat
                VarDepositAccountNo := ObjMembersIV."Deposits Account No";
                VarMonth1Contributed := false;
                VarMonth2Contributed := false;
                VarMonth3Contributed := false;
                VarMonth1ContributedValue := 0;
                VarMonth2ContributedValue := 0;
                VarMonth3ContributedValue := 0;
                VarContributionsTotal := 0;

                //======================================================Month 1 Contributions

                ObjAccountLedger.Reset;
                //ObjAccountLedger.SETCURRENTKEY("Entry No.");
                ObjAccountLedger.SetFilter(ObjAccountLedger."Vendor No.", VarDepositAccountNo);//
                ObjAccountLedger.SetFilter(ObjAccountLedger."Posting Date", RefereeMonth1DateFilter);
                ObjAccountLedger.SetFilter(ObjAccountLedger.Amount, '<%1', 0);
                if ObjAccountLedger.FindSet then begin
                    VarMonth1Contributed := true;
                    VarMonth1ContributedValue := 1;
                end;

                //======================================================Month 2 Contributions

                ObjAccountLedgerII.Reset;
                ObjAccountLedgerII.SetFilter(ObjAccountLedgerII."Vendor No.", VarDepositAccountNo);
                ObjAccountLedgerII.SetFilter(ObjAccountLedgerII."Posting Date", RefereeMonth2DateFilter);
                ObjAccountLedgerII.SetFilter(ObjAccountLedgerII.Amount, '<%1', 0);
                if ObjAccountLedgerII.FindSet then begin
                    VarMonth2Contributed := true;
                    VarMonth2ContributedValue := 1;
                end;

                //======================================================Month 3 Contributions

                ObjAccountLedgerIII.Reset;
                ObjAccountLedgerIII.SetFilter(ObjAccountLedgerIII."Vendor No.", VarDepositAccountNo);
                ObjAccountLedgerIII.SetFilter(ObjAccountLedgerIII."Posting Date", RefereeMonth3DateFilter);
                ObjAccountLedgerIII.SetFilter(ObjAccountLedgerIII.Amount, '<%1', 0);
                if ObjAccountLedgerIII.FindSet then begin
                    VarMonth3Contributed := true;
                    VarMonth3ContributedValue := 1;
                end;

                VarContributionsTotal := VarMonth1ContributedValue + VarMonth2ContributedValue + VarMonth3ContributedValue;

                if VarContributionsTotal > 2 then begin

                    ObjAccounts.Reset;
                    ObjAccounts.SetCurrentkey(ObjAccounts."Account Type");
                    ObjAccounts.SetRange(ObjAccounts."BOSA Account No", ObjMembersIV."Referee Member No");
                    if ObjAccounts.FindFirst then begin

                        BATCH_TEMPLATE := 'GENERAL';
                        BATCH_NAME := 'DEFAULT';
                        DOCUMENT_NO := 'REF - ' + ObjMembersIV."Referee Member No";


                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                        GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                        if GenJournalLine.Find('-') then begin
                            GenJournalLine.DeleteAll;
                        end;

                        LineNo := LineNo + 10000;
                        FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                        GenJournalLine."account type"::Vendor, ObjAccounts."No.", WorkDate, ObjGenSetup."Recruitment Commission" * -1, 'BOSA', EXTERNAL_DOC_NO,
                        'Member Recruitment Comm. - ' + Format(WorkDate, 0, '<Month Text,3> <Year4>'), '', GenJournalLine."recovery transaction type"::"Guarantor Recoverd");

                        LineNo := LineNo + 10000;
                        FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                        GenJournalLine."account type"::"G/L Account", ObjGenSetup."Recruitment Comm. Expense GL", WorkDate, ObjGenSetup."Recruitment Commission", 'BOSA', EXTERNAL_DOC_NO,
                        'Member Recruitment Comm. - ' + ObjMembersIV."Referee Member No" + ' - ' + Format(WorkDate, 0, '<Month Text,3> <Year4>'), '', GenJournalLine."recovery transaction type"::"Guarantor Recoverd");

                        //CU posting
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                        GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                        if GenJournalLine.Find('-') then
                            Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);

                        ObjMembersIV."Referee Commission Paid" := true;
                        ObjMembersIV.Modify;
                    end;
                end;
            until ObjMembersIV.Next = 0;
        end;

    end;


    procedure FnRunManageAudit_Tracker()
    var
        ObjIssuesTracker: Record "Audit Issues Tracker";
        ObjAuditSetup: Record "Audit General Setup";
    begin
        ObjIssuesTracker.Reset;
        ObjIssuesTracker.SetFilter(ObjIssuesTracker.Status, '<>%1|<>%2', ObjIssuesTracker.Status::OverDue,
        ObjIssuesTracker.Status::Closed);
        if ObjIssuesTracker.FindSet then begin
            repeat
                if ObjIssuesTracker."Action Date" <> 0D then begin
                    ObjIssuesTracker."Day Past" := WorkDate - ObjIssuesTracker."Action Date";

                    ObjAuditSetup.Get;
                    if ObjIssuesTracker."Audit Opinion On Closure" = ObjIssuesTracker."audit opinion on closure"::Closed then begin
                        ObjIssuesTracker.Status := ObjIssuesTracker.Status::Closed
                    end else
                        if ObjIssuesTracker."Audit Opinion On Closure" = ObjIssuesTracker."audit opinion on closure"::Failed then begin
                            ObjIssuesTracker.Status := ObjIssuesTracker.Status::Failed
                        end else
                            if (ObjIssuesTracker."Audit Opinion On Closure" = ObjIssuesTracker."audit opinion on closure"::"Issue Assurance Not Yet Done") and
                             (ObjIssuesTracker."Day Past" > ObjAuditSetup."Over Due Date") then begin
                                ObjIssuesTracker.Status := ObjIssuesTracker.Status::OverDue
                            end else
                                if (ObjIssuesTracker."Audit Opinion On Closure" = ObjIssuesTracker."audit opinion on closure"::"Issue Assurance Not Yet Done") and
                                 (ObjIssuesTracker."Day Past" > ObjAuditSetup."Due Date") then begin
                                    ObjIssuesTracker.Status := ObjIssuesTracker.Status::Due
                                end;
                end;

                ObjIssuesTracker."Combined Status" := Format(ObjIssuesTracker.Status) + ' ' + Format(ObjIssuesTracker."Mgt Response");
                ObjIssuesTracker.Modify;
            until ObjIssuesTracker.Next = 0;
        end;
    end;


    procedure FnRunCheckForSuspiciousTransactions(VarAccountNo: Code[30]; VarTransactionAmount: Decimal; VarTransactionDate: Date) VarSuspicious: Boolean
    var
        ObjMemberAccounts: Record Vendor;
        VarMonthsCredittoDate: Decimal;
        VarMonthsCreditWithTolerance: Decimal;
        ObjAuditGeneralSetup: Record "Audit General Setup";
        ObjCust: Record Customer;
        VarMonthlyTurnOver: Decimal;
    begin

        ObjMemberAccounts.Reset;
        ObjMemberAccounts.SetRange(ObjMemberAccounts."No.", VarAccountNo);
        if ObjMemberAccounts.FindSet then begin
            if ObjCust.Get(ObjMemberAccounts."BOSA Account No") then begin
                VarMonthlyTurnOver := ObjCust."Expected Monthly Income Amount";
            end;

            ObjAuditGeneralSetup.Get();
            VarMonthsCredittoDate := FnGetAccountMonthlyCredit(VarAccountNo, VarTransactionDate, ObjMemberAccounts."BOSA Account No");
            VarMonthsCreditWithTolerance := VarMonthlyTurnOver + (VarMonthlyTurnOver * (ObjAuditGeneralSetup."Monthy Credits V TurnOver C%" / 100));

            ObjAuditGeneralSetup.Get;
            if ((VarMonthsCredittoDate + VarTransactionAmount) > VarMonthsCreditWithTolerance) and (VarMonthsCreditWithTolerance > 0) then begin
                VarSuspicious := true;
                exit(VarSuspicious);
            end;
        end;
    end;

    local procedure FnRunCreateSuspiciousTransactionsLog(VarSuspicious: Boolean; VarDocumentNo: Code[30]; VarAccountNo: Code[30]; VarAccountName: Text; VarTransactionDate: Date; VarAmount: Decimal; VarUser: Code[30]; VarMaxCreditAllowable: Decimal; VarMonthTurnoverAmount: Decimal)
    var
        ObjAuditSuspiciousTrans: Record "Audit Suspicious Transactions";
        ObjAuditGeneralSetup: Record "Audit General Setup";
    begin
        ObjAuditGeneralSetup.Get;
        if VarSuspicious = true then begin
            ObjAuditSuspiciousTrans.Reset;
            ObjAuditSuspiciousTrans.SetRange(ObjAuditSuspiciousTrans."Document No", VarDocumentNo);
            if ObjAuditSuspiciousTrans.FindSet then begin
                ObjAuditSuspiciousTrans.DeleteAll;
            end;

            ObjAuditSuspiciousTrans.Init;
            ObjAuditSuspiciousTrans."Document No" := VarDocumentNo;
            ObjAuditSuspiciousTrans."Account No" := VarAccountNo;
            ObjAuditSuspiciousTrans."Account Name" := VarAccountName;
            ObjAuditSuspiciousTrans."Transaction Date" := VarTransactionDate;
            ObjAuditSuspiciousTrans."Transaction Amount" := VarAmount;
            //ObjAuditSuspiciousTrans."Transaction Type":=FORMAT("Type _Transactions");
            ObjAuditSuspiciousTrans."Transacted By" := VarUser;
            ObjAuditSuspiciousTrans."Max Credits Allowable" := VarMaxCreditAllowable;
            ObjAuditSuspiciousTrans."Month TurnOver Amount" := VarMonthTurnoverAmount;
            ObjAuditSuspiciousTrans."Violation Transaction Type" := ObjAuditSuspiciousTrans."violation transaction type"::"Monthly Turnover Exceed";
            ObjAuditSuspiciousTrans.Insert;

            //FnRunEmailSuspiciousTransaction;
        end;
    end;


    procedure FnRunRecoverODDebtCollectorFee(VarAccountNo: Code[30]; VarAccountODBalance: Decimal; VarTransactionAmount: Decimal)
    var
        ObjAccount: Record Vendor;
        VarODDebtCollectorFeeBaseAmount: Decimal;
        VarDebtCollectorFee: Decimal;
        ObjAccountII: Record Vendor;
        BATCH_TEMPLATE: Code[30];
        BATCH_NAME: Code[30];
        DOCUMENT_NO: Code[30];
        EXTERNAL_DOC_NO: Code[30];
        GenJournalLine: Record "Gen. Journal Line";
        LineNo: Integer;
    begin
        ObjAccount.CalcFields(ObjAccount.Balance);
        ObjAccount.Reset;
        ObjAccount.SetRange(ObjAccount."No.", VarAccountNo);
        ObjAccount.SetRange(ObjAccount."OD Under Debt Collection", true);
        ObjAccount.SetFilter(ObjAccount.Balance, '<%1', 0);
        if ObjAccount.FindSet then begin
            if VarTransactionAmount > (VarAccountODBalance * -1) then begin
                VarODDebtCollectorFeeBaseAmount := VarAccountODBalance * -1;
            end else
                VarODDebtCollectorFeeBaseAmount := VarTransactionAmount;


            BATCH_TEMPLATE := 'GENERAL';
            BATCH_NAME := 'RECOVERIES';
            DOCUMENT_NO := FnRunGetNextTransactionDocumentNo;
            EXTERNAL_DOC_NO := '';

            GenJournalLine.Reset;
            GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
            GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
            GenJournalLine.DeleteAll;


            if ObjAccountII.Get(ObjAccount."OD Debt Collector") then begin
                VarDebtCollectorFee := ROUND(VarODDebtCollectorFeeBaseAmount * (ObjAccountII."Debt Collector %" / 100), 0.01, '=');
                VarDebtCollectorFee := VarDebtCollectorFee + (VarDebtCollectorFee * 0.16);


                //======================================================================================================Recover From FOSA Account
                LineNo := LineNo + 10000;
                FnCreateGnlJournalLineGuarantorRecovery(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                GenJournalLine."account type"::Vendor, VarAccountNo, WorkDate, VarDebtCollectorFee, 'BOSA', EXTERNAL_DOC_NO,
                'Debt Collector Fee on OD', '', GenJournalLine."recovery transaction type"::"Guarantor Paid", '');

                //======================================================================================================Recovery to Debt Collector
                LineNo := LineNo + 10000;
                FnCreateGnlJournalLineGuarantorRecovery(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                GenJournalLine."account type"::Vendor, ObjAccount."OD Debt Collector", WorkDate, VarDebtCollectorFee * -1, 'BOSA', EXTERNAL_DOC_NO,
                'Debt Collection Fee + VAT from ' + ObjAccount.Name, '', GenJournalLine."recovery transaction type"::"Guarantor Paid", '');

                //Post New
                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                if GenJournalLine.Find('-') then begin
                    Codeunit.Run(Codeunit::"Gen. Jnl.-Post Batch", GenJournalLine);
                end;

            end;

        end;
    end;


    procedure FnRunGetMembershipDormancyStatus(VarActionDate: Date)
    var
        ObjMember: Record Customer;
        VarDormancyBaseDate: Date;
        ObjGensetup: Record "Sacco General Set-Up";
        VarSixMonthsBack: Date;
        ObjMemberStatusLog: Record "Member Account Status  Logs";
        VarEntryNo: Integer;
    begin
        ObjGensetup.Get;
        VarSixMonthsBack := CalcDate(ObjGensetup."Dormancy Period", VarActionDate);
        ObjMember.CalcFields(ObjMember."Member Last Transaction Date");
        ObjMember.Reset;
        ObjMember.SetRange(ObjMember.Status, ObjMember.Status::Active);
        ObjMember.SetFilter(ObjMember."Member Last Transaction Date", '<%1|%2', VarSixMonthsBack, 0D);
        ObjMember.SetFilter(ObjMember."Registration Date", '<%1', VarSixMonthsBack);
        if ObjMember.FindSet then begin
            repeat
                ObjMember.CalcFields(ObjMember."Member Last Transaction Date");
                if ObjMember."Member Last Transaction Date" <> 0D then begin
                    VarDormancyBaseDate := CalcDate(ObjGensetup."Max. Non Contribution Periods", ObjMember."Member Last Transaction Date");
                    if VarDormancyBaseDate < VarActionDate then begin
                        ObjMember.Status := ObjMember.Status::Dormant;
                        //ObjMember.Blocked:=ObjMember.Blocked::All;
                        ObjMember."Last Transaction Date VerII" := ObjMember."Member Last Transaction Date";
                        ObjMember."Dormant Date" := WorkDate;
                        ObjMember.Modify;

                        //=================================Insert Member Status Log
                        ObjMemberStatusLog.Reset;
                        ObjMemberStatusLog.SetCurrentkey("Entry No");
                        if ObjMemberStatusLog.FindLast then begin
                            VarEntryNo := ObjMemberStatusLog."Entry No" + 1
                        end else
                            VarEntryNo := 1;

                        ObjMemberStatusLog.Init;
                        ObjMemberStatusLog."Entry No" := VarEntryNo;
                        ObjMemberStatusLog.Date := WorkDate;
                        ObjMemberStatusLog."Member No" := ObjMember."No.";
                        ObjMemberStatusLog."Member Name" := ObjMember.Name;
                        ObjMemberStatusLog."Change Type" := ObjMemberStatusLog."change type"::"Membership Status Change";
                        ObjMemberStatusLog."Account Status" := ObjMember.Status;
                        ObjMemberStatusLog."User ID" := UserId;
                        ObjMemberStatusLog."Last Transaction Date" := ObjMember."Last Transaction Date VerII";
                        ObjMemberStatusLog.Insert;
                    end;
                end else
                    if (ObjMember."Member Last Transaction Date" = 0D) and (ObjMember."Registration Date" <> 0D) then begin
                        VarDormancyBaseDate := CalcDate(ObjGensetup."Max. Non Contribution Periods", ObjMember."Registration Date");
                        if VarDormancyBaseDate < VarActionDate then begin
                            ObjMember.Status := ObjMember.Status::Dormant;

                            //ObjMember.Blocked:=ObjMember.Blocked::All;
                            ObjMember."Dormant Date" := WorkDate;
                            ObjMember.Modify;


                            //=================================Insert Member Status Log
                            ObjMemberStatusLog.Reset;
                            ObjMemberStatusLog.SetCurrentkey("Entry No");
                            if ObjMemberStatusLog.FindLast then begin
                                VarEntryNo := ObjMemberStatusLog."Entry No" + 1;
                            end else
                                VarEntryNo := 1;

                            ObjMemberStatusLog.Init;
                            ObjMemberStatusLog."Entry No" := VarEntryNo;
                            ObjMemberStatusLog.Date := WorkDate;
                            ObjMemberStatusLog."Member No" := ObjMember."No.";
                            ObjMemberStatusLog."Member Name" := ObjMember.Name;
                            ObjMemberStatusLog."Change Type" := ObjMemberStatusLog."change type"::"Membership Status Change";
                            ObjMemberStatusLog."Account Status" := ObjMember.Status;
                            ObjMemberStatusLog."User ID" := UserId;
                            ObjMemberStatusLog."Last Transaction Date" := ObjMember."Last Transaction Date VerII";
                            ObjMemberStatusLog.Insert;
                        end;
                    end;
            until ObjMember.Next = 0;
        end;
    end;


    procedure FnRunGetMemberAccountDormancyStatus(VarActionDate: Date)
    var
        ObjMemberAccount: Record Vendor;
        VarDormancyBaseDate: Date;
        ObjGensetup: Record "Sacco General Set-Up";
        ObjAccountType: Record "Account Types-Saving Products";
        VarSixMonthsBack: Date;
        ODF: Text;
        ObjMemberStatusLog: Record "Member Account Status  Logs";
        VarEntryNo: Integer;
    begin
        ObjGensetup.Get;
        VarSixMonthsBack := CalcDate(ObjGensetup."Dormancy Period", VarActionDate);
        ObjMemberAccount.CalcFields(ObjMemberAccount."Last Transaction Date", ObjMemberAccount."Account Dormancy Period");

        ObjMemberAccount.Reset;
        ObjMemberAccount.SetRange(ObjMemberAccount."Account Dormancy Period", true);
        ObjMemberAccount.SetRange(ObjMemberAccount.Status, ObjMemberAccount.Status::Active);
        ObjMemberAccount.SetFilter(ObjMemberAccount."Last Transaction Date", '<%1|%2', VarSixMonthsBack, 0D);
        ObjMemberAccount.SetFilter(ObjMemberAccount."Registration Date", '<%1', VarSixMonthsBack);
        if ObjMemberAccount.FindSet then begin
            repeat
                ObjMemberAccount.CalcFields(ObjMemberAccount."Last Transaction Date");
                if ObjAccountType.Get(ObjMemberAccount."Account Type") then begin
                    if ObjMemberAccount."Last Transaction Date" <> 0D then begin
                        VarDormancyBaseDate := CalcDate(ObjGensetup."Max. Non Contribution Periods", ObjMemberAccount."Last Transaction Date");
                        if VarDormancyBaseDate < VarActionDate then begin
                            ObjMemberAccount.Status := ObjMemberAccount.Status::Dormant;
                            //ObjMemberAccount.Blocked:=ObjMemberAccount.Blocked::All;
                            ObjMemberAccount."Dormant Date" := WorkDate;
                            ObjMemberAccount."Last Transaction Date VerII" := ObjMemberAccount."Last Transaction Date";
                            ObjMemberAccount.Modify;


                            //=================================Insert Member Status Log
                            ObjMemberStatusLog.Reset;
                            ObjMemberStatusLog.SetCurrentkey("Entry No");
                            if ObjMemberStatusLog.FindLast then begin
                                VarEntryNo := ObjMemberStatusLog."Entry No" + 1
                            end else
                                VarEntryNo := 1;

                            ObjMemberStatusLog.Init;
                            ObjMemberStatusLog."Entry No" := VarEntryNo;
                            ObjMemberStatusLog.Date := WorkDate;
                            ObjMemberStatusLog."Member No" := ObjMemberAccount."BOSA Account No";
                            ObjMemberStatusLog."Member Name" := ObjMemberAccount.Name;
                            ObjMemberStatusLog."Account No" := ObjMemberAccount."No.";
                            ObjMemberStatusLog."Change Type" := ObjMemberStatusLog."change type"::"Account Status Change";
                            ObjMemberStatusLog."Account Status" := ObjMemberAccount.Status;
                            ObjMemberStatusLog."User ID" := UserId;
                            ObjMemberStatusLog."Last Transaction Date" := ObjMemberAccount."Last Transaction Date VerII";
                            ObjMemberStatusLog.Insert;

                        end;
                    end else
                        if (ObjMemberAccount."Last Transaction Date" = 0D) and (ObjMemberAccount."Registration Date" <> 0D) then begin
                            VarDormancyBaseDate := CalcDate(ObjGensetup."Max. Non Contribution Periods", ObjMemberAccount."Registration Date");
                            if VarDormancyBaseDate < VarActionDate then begin
                                ObjMemberAccount.Status := ObjMemberAccount.Status::Dormant;
                                //ObjMemberAccount.Blocked:=ObjMemberAccount.Blocked::All;
                                ObjMemberAccount."Dormant Date" := WorkDate;
                                ObjMemberAccount."Last Transaction Date VerII" := ObjMemberAccount."Last Transaction Date";
                                ObjMemberAccount.Modify;

                                //=================================Insert Member Status Log
                                ObjMemberStatusLog.Reset;
                                ObjMemberStatusLog.SetCurrentkey("Entry No");
                                if ObjMemberStatusLog.FindLast then begin
                                    VarEntryNo := ObjMemberStatusLog."Entry No" + 1
                                end else
                                    VarEntryNo := 1;

                                ObjMemberStatusLog.Init;
                                ObjMemberStatusLog."Entry No" := VarEntryNo;
                                ObjMemberStatusLog.Date := WorkDate;
                                ObjMemberStatusLog."Member No" := ObjMemberAccount."BOSA Account No";
                                ObjMemberStatusLog."Member Name" := ObjMemberAccount.Name;
                                ObjMemberStatusLog."Account No" := ObjMemberAccount."No.";
                                ObjMemberStatusLog."Change Type" := ObjMemberStatusLog."change type"::"Account Status Change";
                                ObjMemberStatusLog."Account Status" := ObjMemberAccount.Status;
                                ObjMemberStatusLog."User ID" := UserId;
                                ObjMemberStatusLog."Last Transaction Date" := ObjMemberAccount."Last Transaction Date VerII";
                                ObjMemberStatusLog.Insert;
                            end;
                        end;
                end;
            until ObjMemberAccount.Next = 0;
        end;
    end;


    procedure FnCreateGnlJournalLineBalancedII(TemplateName: Text; BatchName: Text; DocumentNo: Code[30]; LineNo: Integer; TransactionType: Option " ","Registration Fee","Share Capital","Interest Paid","Loan Repayment","Deposit Contribution","Insurance Contribution","Benevolent Fund",Loan,"Unallocated Funds",Dividend,"FOSA Account","Loan Insurance Charged","Loan Insurance Paid"; AccountType: enum "Gen. Journal Account Type"; AccountNo: Code[50];
                                                                                                                                                                                                                                                                                                                                                                                                               TransactionDate: Date;
                                                                                                                                                                                                                                                                                                                                                                                                               TransactionDescription: Text;
                                                                                                                                                                                                                                                                                                                                                                                                               BalancingAccountType: Enum "Gen. Journal Account Type";
                                                                                                                                                                                                                                                                                                                                                                                                               BalancingAccountNo: Code[50];
                                                                                                                                                                                                                                                                                                                                                                                                               TransactionAmount: Decimal;
                                                                                                                                                                                                                                                                                                                                                                                                               DimensionActivity: Code[40];
                                                                                                                                                                                                                                                                                                                                                                                                               LoanNo: Code[20];
                                                                                                                                                                                                                                                                                                                                                                                                               External_Doc_No: Code[10])
    var
        GenJournalLine: Record "Gen. Journal Line";
    begin
        GenJournalLine.Init;
        GenJournalLine."Journal Template Name" := TemplateName;
        GenJournalLine."Journal Batch Name" := BatchName;
        GenJournalLine."Document No." := DocumentNo;
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Transaction Type" := TransactionType;
        GenJournalLine."Account Type" := AccountType;
        GenJournalLine."Account No." := AccountNo;
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Posting Date" := TransactionDate;
        GenJournalLine.Description := TransactionDescription;
        GenJournalLine.Validate(GenJournalLine."Currency Code");
        GenJournalLine.Amount := TransactionAmount;
        GenJournalLine."Loan No" := LoanNo;
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Bal. Account Type" := BalancingAccountType;
        GenJournalLine."Bal. Account No." := BalancingAccountNo;
        GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
        GenJournalLine."Shortcut Dimension 1 Code" := DimensionActivity;
        GenJournalLine."Shortcut Dimension 2 Code" := FnGetUserBranch();
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        if GenJournalLine.Amount <> 0 then
            GenJournalLine.Insert;
    end;


    procedure FnRunMemberCreditScoring(VarMemberNo: Code[30])
    var
        ObjMembers: Record Customer;
        ObjMember: Record Customer;
        VarAge: Integer;
        VarAge2: Integer;
        ObjCreditScoreCriteria: Record "Credit Score Criteria";
        ObjMemberCreditScore: Record "Member Credit Scoring";
        VarPeriodOfMembership: Integer;
        VarPeriodOfMembership2: Integer;
        VarDepositInconsistencyStartDate: Date;
        VarDepositInconsistencyCount: Integer;
        ObjDetailedLedger: Record "Detailed Vendor Ledg. Entry";
        VarDepositInconsistencyStartMonth: Integer;
        VarDepositInconsistencyStartYear: Integer;
        VarDepositInconsistencyStartDay: Integer;
        VarDepositInconsistencyStartDateActual: Date;
        VarDepositInconsistencyEndMonth: Date;
        VarDepositInconsistencyDateFilter: Text;
        VarTotalCredits: Decimal;
        VarDepositBoostingStartDate: Date;
        VarDepositBoostingEndMonth: Date;
        VarDepositBoostingDateFilter: Text;
        VarDepositBoostingStartYear: Integer;
        VarDepositBoostingStartDay: Integer;
        VarDepositBoostingStartDateActual: Date;
        VarDepositBoostingStartMonth: Integer;
        VarSharesBoosted: Boolean;
        VarEntryNo: Integer;
        VarLoanRecoveryStartDate: Date;
        VarLoanRecoveryDateFilter: Text;
        ObjRefundLedger: Record "BOSA Account Refund Ledger";
        VarDepositRecovered: Boolean;
        ObjLoansLongTerm: Record "Loans Register";
        VarLongTermLoansCount: Integer;
        VarShortTermLoansCount: Integer;
        ObjLoanPortolioProvision: Record "Loan Portfolio Provision";
        VarLastMonthEndMonthDate: Date;
        VarTotalDaysPastDue: Integer;
        VarMaximumDeliquencyDays: Integer;
        VarAvarageDeliquencyDaysSum: Integer;
        VarAvarageDeliquencyDaysCount: Integer;
        VarAvarageDeliquency: Integer;
        Var30DaysPlusDeliquentDays: Integer;
        Var1DaysPlusDeliquentDays: Integer;
        VarFOSANoOfCreditsStartMonth: Integer;
        VarFOSANoOfCreditsStartYear: Integer;
        VarFOSANoOfCreditsStartDay: Integer;
        VarFOSANoOfCreditsStartDateActual: Date;
        VarFOSANoOfCreditsEndMonth: Date;
        VarFOSANoOfCreditsDateFilter: Text;
        ObjMemberAccount: Record Vendor;
        VarFOSANoOfCreditsCount: Integer;
        VarFOSANoOfCreditsTotalCount: Integer;
        VarFOSANoOfCreditsStartDate: Date;
        VarFOSAMonthlyInflowsStartMonth: Integer;
        VarFOSAMonthlyInflowsStartYear: Integer;
        VarFOSAMonthlyInflowsStartDay: Integer;
        VarFOSAMonthlyInflowsStartDateActual: Date;
        VarFOSAMonthlyInflowsEndMonth: Date;
        VarFOSAMonthlyInflowsDateFilter: Text;
        VarFOSAMonthlyInflowsAvaregeCredits: Decimal;
        VarFOSAMonthlyInflowsTotalSum: Decimal;
        VarFOSAMonthlyInflowsStartDate: Date;
        VarFOSAMonthlyInflowsEndOfLastMonth: Date;
        VarFOSAMonthlyInflowsMonthNoOfDays: Integer;
        VarFOSATotalMonthlyInflows: Decimal;
        ObjHistoricalLedger: Record "Member Historical Ledger Entry";
        VarMonthlyDepositContribution: Decimal;
        VarMaxScore_Age: Decimal;
        VarMaxScore_MembershipPeriod: Decimal;
        VarMaxScore_DepositInconsistency: Decimal;
        VarMaxScore_DepositBoosting: Decimal;
        VarMaxScore_LoanRecoveriesFromDeposits: Decimal;
        VarMaxScore_LongTermLoans: Decimal;
        VarMaxScore_ShortTermLoans: Decimal;
        VarMaxScore_NoofDaysDuePastDueLastMonth: Decimal;
        VarMaxScore_MaximumNoOfDeliquentDays: Decimal;
        VarMaxScore_AvaregeNoOfDeliquentDays: Decimal;
        VarMaxScore_Morethan30DaysofDeliquency: Decimal;
        VarMaxScore_Morethan1DaysofDeliquency: Decimal;
        VarMaxScore_NoofCreditTransactionsIndividual: Decimal;
        VarMaxScore_NoofCreditTransactionsCorporate: Decimal;
        VarMaxScore_AvaregeInflowsIndividual: Decimal;
        VarMaxScore_AvaregeInflowsCorporate: Decimal;
        VarMaxScoreTotal: Decimal;
        VarMemberCreditScorePercentage: Decimal;
        VarMemberTotalScore: Decimal;
        ObjCreditScoreScale: Record "Credit Score Rating Scale.";
        VarScore_Age: Decimal;
        VarScore_MembershipPeriod: Decimal;
        VarScore_DepositInconsistency: Decimal;
        VarScore_DepositBoosting: Decimal;
        VarScore_LoanRecoveriesFromDeposits: Decimal;
        VarScore_LongTermLoans: Decimal;
        VarScore_ShortTermLoans: Decimal;
        VarScore_NoofDaysDuePastDueLastMonth: Decimal;
        VarScore_MaximumNoOfDeliquentDays: Decimal;
        VarScore_AvaregeNoOfDeliquentDays: Decimal;
        VarScore_Morethan30DaysofDeliquency: Decimal;
        VarScore_Morethan1DaysofDeliquency: Decimal;
        VarScore_NoofCreditTransactionsIndividual: Decimal;
        VarScore_NoofCreditTransactionsCorporate: Decimal;
        VarScore_AvaregeInflowsIndividual: Decimal;
        VarScore_AvaregeInflowsCorporate: Decimal;
    begin

        ObjMemberCreditScore.Reset;
        ObjMemberCreditScore.SetRange(ObjMemberCreditScore."Member No", VarMemberNo);
        ObjMemberCreditScore.SetFilter(ObjMemberCreditScore."Report Date", '%1', WorkDate);
        if ObjMemberCreditScore.FindSet then begin
            ObjMemberCreditScore.DeleteAll;
        end;



        //===========================================================================================Member Age
        ObjMembers.Reset;
        ObjMembers.SetRange(ObjMembers."No.", VarMemberNo);
        if ObjMembers.FindSet then begin
            if ObjMembers."Date of Birth" <> 0D then begin
                VarAge := WorkDate - ObjMembers."Date of Birth"; //Returns number of days old
                VarAge2 := ROUND((VarAge / 365.2364), 1, '<');  //Returns number of years old as Decimal - Takes into Account Leap Years

                ObjCreditScoreCriteria.Reset;
                ObjCreditScoreCriteria.SetCurrentkey(ObjCreditScoreCriteria."Credit Score");
                ObjCreditScoreCriteria.SetRange(ObjCreditScoreCriteria.Category, ObjCreditScoreCriteria.Category::"Member Age");
                ObjCreditScoreCriteria.SetFilter(ObjCreditScoreCriteria."Min Relationship Length(Years)", '<=%1', VarAge2);
                ObjCreditScoreCriteria.SetFilter(ObjCreditScoreCriteria."Max Relationship Length(Years)", '>=%1', VarAge2);
                if ObjCreditScoreCriteria.FindSet then begin
                    VarScore_Age := ObjCreditScoreCriteria."Credit Score";

                    ObjMemberCreditScore.Reset;
                    ObjMemberCreditScore.SetCurrentkey(ObjMemberCreditScore."Entry No");
                    if ObjMemberCreditScore.FindLast then begin
                        VarEntryNo := ObjMemberCreditScore."Entry No";
                    end;

                    ObjCreditScoreCriteria.Reset;
                    ObjCreditScoreCriteria.SetCurrentkey(ObjCreditScoreCriteria."Credit Score");
                    ObjCreditScoreCriteria.SetRange(ObjCreditScoreCriteria.Category, ObjCreditScoreCriteria.Category::"Member Age");
                    if ObjCreditScoreCriteria.FindLast then
                        VarMaxScore_Age := ObjCreditScoreCriteria."Credit Score";

                    ObjMemberCreditScore.Init;
                    ObjMemberCreditScore."Entry No" := VarEntryNo + 1;
                    ObjMemberCreditScore."Member No" := ObjMembers."No.";
                    ObjMemberCreditScore."Member Name" := ObjMembers.Name;
                    ObjMemberCreditScore.Category := ObjCreditScoreCriteria.Category;
                    ObjMemberCreditScore."Score Base Value" := Format(VarAge2);
                    ObjMemberCreditScore.Score := VarScore_Age;
                    ObjMemberCreditScore."Out Of" := VarMaxScore_Age;
                    ObjMemberCreditScore."Report Date" := WorkDate;
                    ObjMemberCreditScore.Insert;



                end;
            end;

            //===========================================================================================Period Of Membership

            if ObjMembers."Registration Date" <> 0D then begin
                VarPeriodOfMembership := WorkDate - ObjMembers."Registration Date"; //Returns number of days old
                VarPeriodOfMembership2 := ROUND((VarPeriodOfMembership / 365.2364), 1, '<');  //Returns number of years old as Decimal - Takes into Account Leap Years

                ObjCreditScoreCriteria.Reset;
                ObjCreditScoreCriteria.SetCurrentkey(ObjCreditScoreCriteria."Credit Score");
                ObjCreditScoreCriteria.SetRange(ObjCreditScoreCriteria.Category, ObjCreditScoreCriteria.Category::"Period Of Membership");
                ObjCreditScoreCriteria.SetFilter(ObjCreditScoreCriteria."Min Relationship Length(Years)", '<=%1', VarPeriodOfMembership2);
                ObjCreditScoreCriteria.SetFilter(ObjCreditScoreCriteria."Max Relationship Length(Years)", '>=%1', VarPeriodOfMembership2);
                if ObjCreditScoreCriteria.FindSet then begin
                    VarScore_MembershipPeriod := ObjCreditScoreCriteria."Credit Score";

                    ObjMemberCreditScore.Reset;
                    ObjMemberCreditScore.SetCurrentkey(ObjMemberCreditScore."Entry No");
                    if ObjMemberCreditScore.FindLast then begin
                        VarEntryNo := ObjMemberCreditScore."Entry No";
                    end;

                    ObjCreditScoreCriteria.Reset;
                    ObjCreditScoreCriteria.SetCurrentkey(ObjCreditScoreCriteria."Credit Score");
                    ObjCreditScoreCriteria.SetRange(ObjCreditScoreCriteria.Category, ObjCreditScoreCriteria.Category::"Period Of Membership");
                    if ObjCreditScoreCriteria.FindLast then
                        VarMaxScore_MembershipPeriod := ObjCreditScoreCriteria."Credit Score";

                    ObjMemberCreditScore.Init;
                    ObjMemberCreditScore."Entry No" := VarEntryNo + 1;
                    ObjMemberCreditScore."Member No" := ObjMembers."No.";
                    ObjMemberCreditScore."Member Name" := ObjMembers.Name;
                    ObjMemberCreditScore.Category := ObjCreditScoreCriteria.Category;
                    ObjMemberCreditScore."Score Base Value" := Format(VarPeriodOfMembership2);
                    ObjMemberCreditScore.Score := VarScore_MembershipPeriod;
                    ObjMemberCreditScore."Out Of" := VarMaxScore_MembershipPeriod;
                    ObjMemberCreditScore."Report Date" := WorkDate;
                    ObjMemberCreditScore.Insert;


                end;
            end;


            //===========================================================================================Deposit Inconsistency For Last 1 Year

            VarDepositInconsistencyStartDate := CalcDate('-1Y', WorkDate);
            VarDepositInconsistencyStartDay := 1;
            VarDepositInconsistencyStartMonth := Date2dmy(VarDepositInconsistencyStartDate, 2);
            VarDepositInconsistencyStartYear := Date2dmy(VarDepositInconsistencyStartDate, 3);
            VarDepositInconsistencyStartDateActual := Dmy2date(VarDepositInconsistencyStartDay, VarDepositInconsistencyStartMonth, VarDepositInconsistencyStartYear);
            VarLastMonthEndMonthDate := CalcDate('CM', CalcDate('-1M', WorkDate));

            repeat
                if VarDepositInconsistencyStartDateActual <= VarLastMonthEndMonthDate then begin
                    VarDepositInconsistencyEndMonth := CalcDate('CM', VarDepositInconsistencyStartDateActual);
                    VarDepositInconsistencyDateFilter := Format(VarDepositInconsistencyStartDateActual) + '..' + Format(VarDepositInconsistencyEndMonth);

                    ObjMember.Reset;
                    ObjMember.SetRange(ObjMember."No.", VarMemberNo);
                    ObjMember.SetFilter(ObjMember."Date Filter", VarDepositInconsistencyDateFilter);
                    if ObjMember.FindSet then begin
                        ObjMember.CalcFields(ObjMember."Deposits Contributed", ObjMember."Deposit Contributed Historical");
                        VarTotalCredits := ObjMember."Deposits Contributed" + ObjMember."Deposit Contributed Historical";
                        VarMonthlyDepositContribution := FnGetMemberMonthlyContributionAsAt(VarMemberNo, VarDepositInconsistencyEndMonth);
                        if VarTotalCredits < VarMonthlyDepositContribution then
                            VarDepositInconsistencyCount := VarDepositInconsistencyCount + 1;
                    end;

                    VarDepositInconsistencyStartDateActual := CalcDate('1M', VarDepositInconsistencyStartDateActual);
                end;
            until VarDepositInconsistencyStartDateActual >= VarLastMonthEndMonthDate;

            ObjCreditScoreCriteria.Reset;
            ObjCreditScoreCriteria.SetCurrentkey(ObjCreditScoreCriteria."Credit Score");
            ObjCreditScoreCriteria.SetRange(ObjCreditScoreCriteria.Category, ObjCreditScoreCriteria.Category::"Deposit Inconsistency In A Year");
            ObjCreditScoreCriteria.SetFilter(ObjCreditScoreCriteria."Min Count Range", '<=%1', VarDepositInconsistencyCount);
            ObjCreditScoreCriteria.SetFilter(ObjCreditScoreCriteria."Max Count Range", '>=%1', VarDepositInconsistencyCount);
            if ObjCreditScoreCriteria.FindSet then begin
                VarScore_DepositInconsistency := ObjCreditScoreCriteria."Credit Score";

                ObjMemberCreditScore.Reset;
                ObjMemberCreditScore.SetCurrentkey(ObjMemberCreditScore."Entry No");
                if ObjMemberCreditScore.FindLast then begin
                    VarEntryNo := ObjMemberCreditScore."Entry No";
                end;

                ObjCreditScoreCriteria.Reset;
                ObjCreditScoreCriteria.SetCurrentkey(ObjCreditScoreCriteria."Credit Score");
                ObjCreditScoreCriteria.SetRange(ObjCreditScoreCriteria.Category, ObjCreditScoreCriteria.Category::"Deposit Inconsistency In A Year");
                if ObjCreditScoreCriteria.FindLast then
                    VarMaxScore_DepositInconsistency := ObjCreditScoreCriteria."Credit Score";

                ObjMemberCreditScore.Init;
                ObjMemberCreditScore."Entry No" := VarEntryNo + 1;
                ObjMemberCreditScore."Member No" := ObjMembers."No.";
                ObjMemberCreditScore."Member Name" := ObjMembers.Name;
                ObjMemberCreditScore.Category := ObjCreditScoreCriteria.Category;
                ObjMemberCreditScore."Score Base Value" := Format(VarDepositInconsistencyCount);
                ObjMemberCreditScore.Score := VarScore_DepositInconsistency;
                ObjMemberCreditScore."Out Of" := VarMaxScore_DepositInconsistency;
                ObjMemberCreditScore."Report Date" := WorkDate;
                ObjMemberCreditScore.Insert;




            end;


            //===========================================================================================Deposit Boosting For A Year

            VarDepositBoostingStartDate := CalcDate('-1Y', WorkDate);
            VarDepositBoostingStartDay := 1;
            VarDepositBoostingStartMonth := Date2dmy(VarDepositBoostingStartDate, 2);
            VarDepositBoostingStartYear := Date2dmy(VarDepositBoostingStartDate, 3);
            VarDepositBoostingStartDateActual := Dmy2date(VarDepositBoostingStartDay, VarDepositBoostingStartMonth, VarDepositBoostingStartYear);

            repeat
                if WorkDate > VarDepositBoostingStartDateActual then begin
                    VarDepositBoostingEndMonth := CalcDate('CM', VarDepositBoostingStartDateActual);
                    VarDepositBoostingDateFilter := Format(VarDepositBoostingStartDateActual) + '..' + Format(VarDepositBoostingEndMonth);

                    VarSharesBoosted := FnRunGetShareBoostingDetailsCreditScoring(ObjMembers."No.", VarDepositBoostingDateFilter, VarDepositBoostingEndMonth, VarDepositBoostingStartDateActual, VarDepositBoostingStartDateActual);
                    VarDepositBoostingStartDateActual := CalcDate('1M', VarDepositBoostingStartDateActual);
                end;
            until (VarDepositBoostingStartDateActual >= WorkDate) or (VarSharesBoosted = true);




            ObjCreditScoreCriteria.Reset;
            ObjCreditScoreCriteria.SetCurrentkey(ObjCreditScoreCriteria."Credit Score");
            ObjCreditScoreCriteria.SetRange(ObjCreditScoreCriteria.Category, ObjCreditScoreCriteria.Category::"Deposits Boosting Within A Year");
            ObjCreditScoreCriteria.SetRange(ObjCreditScoreCriteria."YES/No", VarSharesBoosted);
            if ObjCreditScoreCriteria.FindSet then begin
                VarScore_DepositBoosting := ObjCreditScoreCriteria."Credit Score";

                ObjMemberCreditScore.Reset;
                ObjMemberCreditScore.SetCurrentkey(ObjMemberCreditScore."Entry No");
                if ObjMemberCreditScore.FindLast then begin
                    VarEntryNo := ObjMemberCreditScore."Entry No";
                end;

                ObjCreditScoreCriteria.Reset;
                ObjCreditScoreCriteria.SetCurrentkey(ObjCreditScoreCriteria."Credit Score");
                ObjCreditScoreCriteria.SetRange(ObjCreditScoreCriteria.Category, ObjCreditScoreCriteria.Category::"Deposits Boosting Within A Year");
                if ObjCreditScoreCriteria.FindLast then
                    VarMaxScore_DepositBoosting := ObjCreditScoreCriteria."Credit Score";

                ObjMemberCreditScore.Init;
                ObjMemberCreditScore."Entry No" := VarEntryNo + 1;
                ObjMemberCreditScore."Member No" := ObjMembers."No.";
                ObjMemberCreditScore."Member Name" := ObjMembers.Name;
                ObjMemberCreditScore.Category := ObjCreditScoreCriteria.Category;
                ObjMemberCreditScore."Score Base Value" := Format(VarSharesBoosted);
                ObjMemberCreditScore.Score := VarScore_DepositBoosting;
                ObjMemberCreditScore."Out Of" := VarMaxScore_DepositBoosting;
                ObjMemberCreditScore."Report Date" := WorkDate;
                ObjMemberCreditScore.Insert;


            end;


            //===========================================================================================Loan Recoveries From Deposits Within 3 Years

            VarLoanRecoveryStartDate := CalcDate('-3Y', WorkDate);
            VarLoanRecoveryDateFilter := Format(VarLoanRecoveryStartDate) + '..' + Format(WorkDate);

            VarDepositRecovered := false;
            ObjRefundLedger.Reset;
            ObjRefundLedger.SetRange(ObjRefundLedger."Account No Recovered", ObjMembers."Deposits Account No");
            ObjRefundLedger.SetFilter(ObjRefundLedger."Posting Date", VarLoanRecoveryDateFilter);
            if ObjRefundLedger.FindSet then begin
                VarDepositRecovered := true;
            end;

            ObjCreditScoreCriteria.Reset;
            ObjCreditScoreCriteria.SetCurrentkey(ObjCreditScoreCriteria."Credit Score");
            ObjCreditScoreCriteria.SetRange(ObjCreditScoreCriteria.Category, ObjCreditScoreCriteria.Category::"Loan Recoveries from Deposits Within 3 Years");
            ObjCreditScoreCriteria.SetRange(ObjCreditScoreCriteria."YES/No", VarDepositRecovered);
            if ObjCreditScoreCriteria.FindSet then begin
                VarScore_LoanRecoveriesFromDeposits := ObjCreditScoreCriteria."Credit Score";

                ObjMemberCreditScore.Reset;
                ObjMemberCreditScore.SetCurrentkey(ObjMemberCreditScore."Entry No");
                if ObjMemberCreditScore.FindLast then begin
                    VarEntryNo := ObjMemberCreditScore."Entry No";
                end;

                ObjCreditScoreCriteria.Reset;
                ObjCreditScoreCriteria.SetCurrentkey(ObjCreditScoreCriteria."Credit Score");
                ObjCreditScoreCriteria.SetRange(ObjCreditScoreCriteria.Category, ObjCreditScoreCriteria.Category::"Loan Recoveries from Deposits Within 3 Years");
                if ObjCreditScoreCriteria.FindLast then
                    VarMaxScore_LoanRecoveriesFromDeposits := ObjCreditScoreCriteria."Credit Score";

                ObjMemberCreditScore.Init;
                ObjMemberCreditScore."Entry No" := VarEntryNo + 1;
                ObjMemberCreditScore."Member No" := ObjMembers."No.";
                ObjMemberCreditScore."Member Name" := ObjMembers.Name;
                ObjMemberCreditScore.Category := ObjCreditScoreCriteria.Category;
                ObjMemberCreditScore."Score Base Value" := Format(VarDepositRecovered);
                ObjMemberCreditScore.Score := VarScore_LoanRecoveriesFromDeposits;
                ObjMemberCreditScore."Out Of" := VarMaxScore_LoanRecoveriesFromDeposits;
                ObjMemberCreditScore."Report Date" := WorkDate;
                ObjMemberCreditScore.Insert;


            end;



            //===========================================================================================Loan History Long Term
            ObjLoansLongTerm.Reset;
            ObjLoansLongTerm.SetRange(ObjLoansLongTerm."Client Code", VarMemberNo);
            ObjLoansLongTerm.SetRange(ObjLoansLongTerm.Posted, true);
            ObjLoansLongTerm.SetRange(ObjLoansLongTerm.Rescheduled, false);
            ObjLoansLongTerm.SetFilter(ObjLoansLongTerm.Installments, '>%1', 24);
            if ObjLoansLongTerm.FindSet then begin
                VarLongTermLoansCount := ObjLoansLongTerm.Count;
            end;

            ObjCreditScoreCriteria.Reset;
            ObjCreditScoreCriteria.SetCurrentkey(ObjCreditScoreCriteria."Credit Score");
            ObjCreditScoreCriteria.SetRange(ObjCreditScoreCriteria.Category, ObjCreditScoreCriteria.Category::"Loan History_Long Term");
            ObjCreditScoreCriteria.SetFilter(ObjCreditScoreCriteria."Min Count Range", '<=%1', VarLongTermLoansCount);
            ObjCreditScoreCriteria.SetFilter(ObjCreditScoreCriteria."Max Count Range", '>=%1', VarLongTermLoansCount);
            if ObjCreditScoreCriteria.FindSet then begin
                VarScore_LongTermLoans := ObjCreditScoreCriteria."Credit Score";

                ObjMemberCreditScore.Reset;
                ObjMemberCreditScore.SetCurrentkey(ObjMemberCreditScore."Entry No");
                if ObjMemberCreditScore.FindLast then begin
                    VarEntryNo := ObjMemberCreditScore."Entry No";
                end;

                ObjCreditScoreCriteria.Reset;
                ObjCreditScoreCriteria.SetCurrentkey(ObjCreditScoreCriteria."Credit Score");
                ObjCreditScoreCriteria.SetRange(ObjCreditScoreCriteria.Category, ObjCreditScoreCriteria.Category::"Loan History_Long Term");
                if ObjCreditScoreCriteria.FindLast then
                    VarMaxScore_LongTermLoans := ObjCreditScoreCriteria."Credit Score";

                ObjMemberCreditScore.Init;
                ObjMemberCreditScore."Entry No" := VarEntryNo + 1;
                ObjMemberCreditScore."Member No" := ObjMembers."No.";
                ObjMemberCreditScore."Member Name" := ObjMembers.Name;
                ObjMemberCreditScore.Category := ObjCreditScoreCriteria.Category;
                ObjMemberCreditScore."Score Base Value" := Format(VarLongTermLoansCount);
                ObjMemberCreditScore.Score := VarScore_LongTermLoans;
                ObjMemberCreditScore."Out Of" := VarMaxScore_LongTermLoans;
                ObjMemberCreditScore."Report Date" := WorkDate;
                ObjMemberCreditScore.Insert;


            end;


            //===========================================================================================Loan History Short Term

            ObjLoansLongTerm.Reset;
            ObjLoansLongTerm.SetRange(ObjLoansLongTerm."Client Code", VarMemberNo);
            ObjLoansLongTerm.SetRange(ObjLoansLongTerm.Posted, true);
            ObjLoansLongTerm.SetRange(ObjLoansLongTerm.Rescheduled, false);
            ObjLoansLongTerm.SetFilter(ObjLoansLongTerm.Installments, '<=%1', 24);
            if ObjLoansLongTerm.FindSet then begin
                VarShortTermLoansCount := ObjLoansLongTerm.Count;
            end;

            ObjCreditScoreCriteria.Reset;
            ObjCreditScoreCriteria.SetCurrentkey(ObjCreditScoreCriteria."Credit Score");
            ObjCreditScoreCriteria.SetRange(ObjCreditScoreCriteria.Category, ObjCreditScoreCriteria.Category::"Loan History_Short Term");
            ObjCreditScoreCriteria.SetFilter(ObjCreditScoreCriteria."Min Count Range", '<=%1', VarShortTermLoansCount);
            ObjCreditScoreCriteria.SetFilter(ObjCreditScoreCriteria."Max Count Range", '>=%1', VarShortTermLoansCount);
            if ObjCreditScoreCriteria.FindSet then begin
                VarScore_ShortTermLoans := ObjCreditScoreCriteria."Credit Score";

                ObjMemberCreditScore.Reset;
                ObjMemberCreditScore.SetCurrentkey(ObjMemberCreditScore."Entry No");
                if ObjMemberCreditScore.FindLast then begin
                    VarEntryNo := ObjMemberCreditScore."Entry No";
                end;

                ObjCreditScoreCriteria.Reset;
                ObjCreditScoreCriteria.SetCurrentkey(ObjCreditScoreCriteria."Credit Score");
                ObjCreditScoreCriteria.SetRange(ObjCreditScoreCriteria.Category, ObjCreditScoreCriteria.Category::"Loan History_Short Term");
                if ObjCreditScoreCriteria.FindLast then
                    VarMaxScore_ShortTermLoans := ObjCreditScoreCriteria."Credit Score";

                ObjMemberCreditScore.Init;
                ObjMemberCreditScore."Entry No" := VarEntryNo + 1;
                ObjMemberCreditScore."Member No" := ObjMembers."No.";
                ObjMemberCreditScore."Member Name" := ObjMembers.Name;
                ObjMemberCreditScore.Category := ObjCreditScoreCriteria.Category;
                ObjMemberCreditScore."Score Base Value" := Format(VarShortTermLoansCount);
                ObjMemberCreditScore.Score := VarScore_ShortTermLoans;
                ObjMemberCreditScore."Out Of" := VarMaxScore_ShortTermLoans;
                ObjMemberCreditScore."Report Date" := WorkDate;
                ObjMemberCreditScore.Insert;



            end;


            //===========================================================================================Loan Repayment History-Days Past Due as At Last End Month

            VarLastMonthEndMonthDate := CalcDate('CM', CalcDate('-1M', WorkDate));
            ObjLoanPortolioProvision.Reset;
            ObjLoanPortolioProvision.SetRange(ObjLoanPortolioProvision."Member No", VarMemberNo);
            ObjLoanPortolioProvision.SetFilter(ObjLoanPortolioProvision."Arrears Days", '>%1', 0);
            ObjLoanPortolioProvision.SetFilter(ObjLoanPortolioProvision."Report Date", '%1', VarLastMonthEndMonthDate);
            if ObjLoanPortolioProvision.FindSet then begin
                ObjLoanPortolioProvision.CalcSums(ObjLoanPortolioProvision."Arrears Days");
                VarTotalDaysPastDue := ObjLoanPortolioProvision."Arrears Days";
            end;

            ObjCreditScoreCriteria.Reset;
            ObjCreditScoreCriteria.SetCurrentkey(ObjCreditScoreCriteria."Credit Score");
            ObjCreditScoreCriteria.SetRange(ObjCreditScoreCriteria.Category, ObjCreditScoreCriteria.Category::"Repayment History_Number of Days Past Due at last month End");
            ObjCreditScoreCriteria.SetFilter(ObjCreditScoreCriteria."Min Count Range", '<=%1', VarTotalDaysPastDue);
            ObjCreditScoreCriteria.SetFilter(ObjCreditScoreCriteria."Max Count Range", '>=%1', VarTotalDaysPastDue);
            if ObjCreditScoreCriteria.FindSet then begin
                VarScore_MaximumNoOfDeliquentDays := ObjCreditScoreCriteria."Credit Score";

                ObjMemberCreditScore.Reset;
                ObjMemberCreditScore.SetCurrentkey(ObjMemberCreditScore."Entry No");
                if ObjMemberCreditScore.FindLast then begin
                    VarEntryNo := ObjMemberCreditScore."Entry No";
                end;

                ObjCreditScoreCriteria.Reset;
                ObjCreditScoreCriteria.SetCurrentkey(ObjCreditScoreCriteria."Credit Score");
                ObjCreditScoreCriteria.SetRange(ObjCreditScoreCriteria.Category, ObjCreditScoreCriteria.Category::"Repayment History_Number of Days Past Due at last month End");
                if ObjCreditScoreCriteria.FindLast then
                    VarMaxScore_MaximumNoOfDeliquentDays := ObjCreditScoreCriteria."Credit Score";

                ObjMemberCreditScore.Init;
                ObjMemberCreditScore."Entry No" := VarEntryNo + 1;
                ObjMemberCreditScore."Member No" := ObjMembers."No.";
                ObjMemberCreditScore."Member Name" := ObjMembers.Name;
                ObjMemberCreditScore.Category := ObjCreditScoreCriteria.Category;
                ObjMemberCreditScore."Score Base Value" := Format(VarTotalDaysPastDue);
                ObjMemberCreditScore.Score := VarScore_MaximumNoOfDeliquentDays;
                ObjMemberCreditScore."Out Of" := VarMaxScore_MaximumNoOfDeliquentDays;
                ObjMemberCreditScore."Report Date" := WorkDate;
                ObjMemberCreditScore.Insert;


            end;

            //===========================================================================================Loan Repayment History-Maximum Deliquency Days
            ObjLoanPortolioProvision.Reset;
            ObjLoanPortolioProvision.SetCurrentkey(ObjLoanPortolioProvision."Arrears Days");
            ObjLoanPortolioProvision.SetRange(ObjLoanPortolioProvision."Member No", VarMemberNo);
            ObjLoanPortolioProvision.SetFilter(ObjLoanPortolioProvision."Arrears Days", '>%1', 0);
            if ObjLoanPortolioProvision.FindLast then begin
                VarMaximumDeliquencyDays := ObjLoanPortolioProvision."Arrears Days";
            end;

            ObjCreditScoreCriteria.Reset;
            ObjCreditScoreCriteria.SetCurrentkey(ObjCreditScoreCriteria."Credit Score");
            ObjCreditScoreCriteria.SetRange(ObjCreditScoreCriteria.Category, ObjCreditScoreCriteria.Category::"Repayment History_Maximum Number of Days a Client was delinquent");
            ObjCreditScoreCriteria.SetFilter(ObjCreditScoreCriteria."Min Count Range", '<=%1', VarMaximumDeliquencyDays);
            ObjCreditScoreCriteria.SetFilter(ObjCreditScoreCriteria."Max Count Range", '>=%1', VarMaximumDeliquencyDays);
            if ObjCreditScoreCriteria.FindSet then begin
                VarScore_MaximumNoOfDeliquentDays := ObjCreditScoreCriteria."Credit Score";

                ObjMemberCreditScore.Reset;
                ObjMemberCreditScore.SetCurrentkey(ObjMemberCreditScore."Entry No");
                if ObjMemberCreditScore.FindLast then begin
                    VarEntryNo := ObjMemberCreditScore."Entry No";
                end;

                ObjCreditScoreCriteria.Reset;
                ObjCreditScoreCriteria.SetCurrentkey(ObjCreditScoreCriteria."Credit Score");
                ObjCreditScoreCriteria.SetRange(ObjCreditScoreCriteria.Category, ObjCreditScoreCriteria.Category::"Repayment History_Maximum Number of Days a Client was delinquent");
                if ObjCreditScoreCriteria.FindLast then
                    VarMaxScore_MaximumNoOfDeliquentDays := ObjCreditScoreCriteria."Credit Score";

                ObjMemberCreditScore.Init;
                ObjMemberCreditScore."Entry No" := VarEntryNo + 1;
                ObjMemberCreditScore."Member No" := ObjMembers."No.";
                ObjMemberCreditScore."Member Name" := ObjMembers.Name;
                ObjMemberCreditScore.Category := ObjCreditScoreCriteria.Category;
                ObjMemberCreditScore."Score Base Value" := Format(VarMaximumDeliquencyDays);
                ObjMemberCreditScore.Score := VarScore_MaximumNoOfDeliquentDays;
                ObjMemberCreditScore."Out Of" := VarMaxScore_MaximumNoOfDeliquentDays;
                ObjMemberCreditScore."Report Date" := WorkDate;
                ObjMemberCreditScore.Insert;


            end;

            //===========================================================================================Loan Repayment History-Avarage Number of Days Being Deliquent
            ObjLoanPortolioProvision.Reset;
            ObjLoanPortolioProvision.SetRange(ObjLoanPortolioProvision."Member No", VarMemberNo);
            ObjLoanPortolioProvision.SetFilter(ObjLoanPortolioProvision."Arrears Days", '>%1', 0);
            if ObjLoanPortolioProvision.FindSet then begin
                ObjLoanPortolioProvision.CalcSums(ObjLoanPortolioProvision."Arrears Days");
                VarAvarageDeliquencyDaysSum := ObjLoanPortolioProvision."Arrears Days";
                VarAvarageDeliquencyDaysCount := ObjLoanPortolioProvision.Count;
                VarAvarageDeliquency := ROUND(VarAvarageDeliquencyDaysSum / VarAvarageDeliquencyDaysCount, 1, '=');
            end;

            ObjCreditScoreCriteria.Reset;
            ObjCreditScoreCriteria.SetCurrentkey(ObjCreditScoreCriteria."Credit Score");
            ObjCreditScoreCriteria.SetRange(ObjCreditScoreCriteria.Category, ObjCreditScoreCriteria.Category::"Repayment History_Average Number of Days a client was Delinquent");
            ObjCreditScoreCriteria.SetFilter(ObjCreditScoreCriteria."Min Count Range", '<=%1', VarAvarageDeliquency);
            ObjCreditScoreCriteria.SetFilter(ObjCreditScoreCriteria."Max Count Range", '>=%1', VarAvarageDeliquency);
            if ObjCreditScoreCriteria.FindSet then begin
                VarScore_AvaregeNoOfDeliquentDays := ObjCreditScoreCriteria."Credit Score";

                ObjMemberCreditScore.Reset;
                ObjMemberCreditScore.SetCurrentkey(ObjMemberCreditScore."Entry No");
                if ObjMemberCreditScore.FindLast then begin
                    VarEntryNo := ObjMemberCreditScore."Entry No";
                end;

                ObjCreditScoreCriteria.Reset;
                ObjCreditScoreCriteria.SetCurrentkey(ObjCreditScoreCriteria."Credit Score");
                ObjCreditScoreCriteria.SetRange(ObjCreditScoreCriteria.Category, ObjCreditScoreCriteria.Category::"Repayment History_Average Number of Days a client was Delinquent");
                if ObjCreditScoreCriteria.FindLast then
                    VarMaxScore_AvaregeNoOfDeliquentDays := ObjCreditScoreCriteria."Credit Score";

                ObjMemberCreditScore.Init;
                ObjMemberCreditScore."Entry No" := VarEntryNo + 1;
                ObjMemberCreditScore."Member No" := ObjMembers."No.";
                ObjMemberCreditScore."Member Name" := ObjMembers.Name;
                ObjMemberCreditScore.Category := ObjCreditScoreCriteria.Category;
                ObjMemberCreditScore."Score Base Value" := Format(VarAvarageDeliquency);
                ObjMemberCreditScore.Score := VarScore_AvaregeNoOfDeliquentDays;
                ObjMemberCreditScore."Out Of" := VarMaxScore_AvaregeNoOfDeliquentDays;
                ObjMemberCreditScore."Report Date" := WorkDate;
                ObjMemberCreditScore.Insert;


            end;

            //===========================================================================================Loan Repayment History-Number of times 30+ Deliquency Days

            ObjLoanPortolioProvision.Reset;
            ObjLoanPortolioProvision.SetRange(ObjLoanPortolioProvision."Member No", VarMemberNo);
            ObjLoanPortolioProvision.SetFilter(ObjLoanPortolioProvision."Arrears Days", '>%1', 30);
            if ObjLoanPortolioProvision.FindSet then begin
                Var30DaysPlusDeliquentDays := ObjLoanPortolioProvision.Count;
            end;

            ObjCreditScoreCriteria.Reset;
            ObjCreditScoreCriteria.SetCurrentkey(ObjCreditScoreCriteria."Credit Score");
            ObjCreditScoreCriteria.SetRange(ObjCreditScoreCriteria.Category, ObjCreditScoreCriteria.Category::"Repayment History_Number of times Client was more than 30 days Delinquent");
            ObjCreditScoreCriteria.SetFilter(ObjCreditScoreCriteria."Min Count Range", '<=%1', Var30DaysPlusDeliquentDays);
            ObjCreditScoreCriteria.SetFilter(ObjCreditScoreCriteria."Max Count Range", '>=%1', Var30DaysPlusDeliquentDays);
            if ObjCreditScoreCriteria.FindSet then begin
                VarScore_Morethan30DaysofDeliquency := ObjCreditScoreCriteria."Credit Score";

                ObjMemberCreditScore.Reset;
                ObjMemberCreditScore.SetCurrentkey(ObjMemberCreditScore."Entry No");
                if ObjMemberCreditScore.FindLast then begin
                    VarEntryNo := ObjMemberCreditScore."Entry No";
                end;


                ObjCreditScoreCriteria.Reset;
                ObjCreditScoreCriteria.SetCurrentkey(ObjCreditScoreCriteria."Credit Score");
                ObjCreditScoreCriteria.SetRange(ObjCreditScoreCriteria.Category, ObjCreditScoreCriteria.Category::"Repayment History_Number of times Client was more than 30 days Delinquent");
                if ObjCreditScoreCriteria.FindLast then
                    VarMaxScore_Morethan30DaysofDeliquency := ObjCreditScoreCriteria."Credit Score";

                ObjMemberCreditScore.Init;
                ObjMemberCreditScore."Entry No" := VarEntryNo + 1;
                ObjMemberCreditScore."Member No" := ObjMembers."No.";
                ObjMemberCreditScore."Member Name" := ObjMembers.Name;
                ObjMemberCreditScore.Category := ObjCreditScoreCriteria.Category;
                ObjMemberCreditScore."Score Base Value" := Format(Var30DaysPlusDeliquentDays);
                ObjMemberCreditScore.Score := VarScore_Morethan30DaysofDeliquency;
                ObjMemberCreditScore."Out Of" := VarMaxScore_Morethan30DaysofDeliquency;
                ObjMemberCreditScore."Report Date" := WorkDate;
                ObjMemberCreditScore.Insert;


            end;

            //===========================================================================================Loan Repayment History-Number of times 1+ Deliquency Days

            ObjLoanPortolioProvision.Reset;
            ObjLoanPortolioProvision.SetRange(ObjLoanPortolioProvision."Member No", VarMemberNo);
            ObjLoanPortolioProvision.SetFilter(ObjLoanPortolioProvision."Arrears Days", '>%1', 1);
            if ObjLoanPortolioProvision.FindSet then begin
                Var1DaysPlusDeliquentDays := ObjLoanPortolioProvision.Count;
            end;

            ObjCreditScoreCriteria.Reset;
            ObjCreditScoreCriteria.SetCurrentkey(ObjCreditScoreCriteria."Credit Score");
            ObjCreditScoreCriteria.SetRange(ObjCreditScoreCriteria.Category, ObjCreditScoreCriteria.Category::"Repayment History_Number of times client was more than one day delinquent");
            ObjCreditScoreCriteria.SetFilter(ObjCreditScoreCriteria."Min Count Range", '<=%1', Var1DaysPlusDeliquentDays);
            ObjCreditScoreCriteria.SetFilter(ObjCreditScoreCriteria."Max Count Range", '>=%1', Var1DaysPlusDeliquentDays);
            if ObjCreditScoreCriteria.FindSet then begin
                VarScore_Morethan1DaysofDeliquency := ObjCreditScoreCriteria."Credit Score";

                ObjMemberCreditScore.Reset;
                ObjMemberCreditScore.SetCurrentkey(ObjMemberCreditScore."Entry No");
                if ObjMemberCreditScore.FindLast then begin
                    VarEntryNo := ObjMemberCreditScore."Entry No";
                end;

                ObjCreditScoreCriteria.Reset;
                ObjCreditScoreCriteria.SetCurrentkey(ObjCreditScoreCriteria."Credit Score");
                ObjCreditScoreCriteria.SetRange(ObjCreditScoreCriteria.Category, ObjCreditScoreCriteria.Category::"Repayment History_Number of times client was more than one day delinquent");
                if ObjCreditScoreCriteria.FindLast then
                    VarMaxScore_Morethan1DaysofDeliquency := ObjCreditScoreCriteria."Credit Score";

                ObjMemberCreditScore.Init;
                ObjMemberCreditScore."Entry No" := VarEntryNo + 1;
                ObjMemberCreditScore."Member No" := ObjMembers."No.";
                ObjMemberCreditScore."Member Name" := ObjMembers.Name;
                ObjMemberCreditScore.Category := ObjCreditScoreCriteria.Category;
                ObjMemberCreditScore."Score Base Value" := Format(Var1DaysPlusDeliquentDays);
                ObjMemberCreditScore.Score := VarScore_Morethan1DaysofDeliquency;
                ObjMemberCreditScore."Out Of" := VarMaxScore_Morethan1DaysofDeliquency;
                ObjMemberCreditScore."Report Date" := WorkDate;
                ObjMemberCreditScore.Insert;


            end;

            //===========================================================================================FOSA Activity Monthly Inflows
            ObjMemberAccount.Reset;
            ObjMemberAccount.SetRange(ObjMemberAccount."BOSA Account No", VarMemberNo);
            ObjMemberAccount.SetRange(ObjMemberAccount."Global Dimension 1 Code", 'FOSA');
            if ObjMemberAccount.FindSet then begin
                repeat
                    VarFOSAMonthlyInflowsEndOfLastMonth := CalcDate('CM', CalcDate('-1M', WorkDate));
                    VarFOSAMonthlyInflowsStartDate := CalcDate('1D', CalcDate('-1Y', VarFOSAMonthlyInflowsEndOfLastMonth));

                    VarFOSAMonthlyInflowsMonthNoOfDays := 0;
                    VarFOSAMonthlyInflowsTotalSum := 0;
                    VarFOSAMonthlyInflowsDateFilter := Format(VarFOSAMonthlyInflowsStartDate) + '..' + Format(VarFOSAMonthlyInflowsEndOfLastMonth);

                    ObjDetailedLedger.Reset;
                    ObjDetailedLedger.SetRange(ObjDetailedLedger."Vendor No.", ObjMemberAccount."No.");
                    ObjDetailedLedger.SetFilter(ObjDetailedLedger."Posting Date", VarFOSAMonthlyInflowsDateFilter);
                    ObjDetailedLedger.SetFilter(ObjDetailedLedger."Credit Amount", '<>%1', 0);
                    ObjDetailedLedger.SetFilter(ObjDetailedLedger."Document No.", '<>%1', 'BALB/F9THNOV2018');
                    ObjDetailedLedger.SetFilter(ObjDetailedLedger.Description, '<>%1&<>%2&<>%3&<>%4&<>%5&<>%6&<>%7&<>%8&<>%9', '*Fee*', '*Charge*', '*Tax*', '*Excise*', '*Sweep*', '*Loan Repayment Transfer*', '*Loan Recovered*', '*Reverse*', '*Loan Disbursement*');
                    if ObjDetailedLedger.FindSet then begin
                        ObjDetailedLedger.CalcSums(ObjDetailedLedger."Credit Amount");
                        VarFOSAMonthlyInflowsTotalSum := ObjDetailedLedger."Credit Amount";
                        VarFOSANoOfCreditsCount := ObjDetailedLedger.Count;
                    end;
                    VarFOSAMonthlyInflowsAvaregeCredits := VarFOSAMonthlyInflowsAvaregeCredits + VarFOSAMonthlyInflowsTotalSum;
                    VarFOSANoOfCreditsTotalCount := VarFOSANoOfCreditsTotalCount + VarFOSANoOfCreditsCount;
                until ObjMemberAccount.Next = 0;
                VarFOSAMonthlyInflowsAvaregeCredits := ROUND(VarFOSAMonthlyInflowsAvaregeCredits / 12, 0.01, '=');
                VarFOSANoOfCreditsTotalCount := ROUND(VarFOSANoOfCreditsTotalCount / 12, 1, '=');
            end;


            if ObjMembers."Account Category" = ObjMembers."account category"::Individual then begin
                ObjCreditScoreCriteria.Reset;
                ObjCreditScoreCriteria.SetCurrentkey(ObjCreditScoreCriteria."Credit Score");
                ObjCreditScoreCriteria.SetRange(ObjCreditScoreCriteria.Category, ObjCreditScoreCriteria.Category::"Monthly Average Inflows _From Last Month 1 Year Back_Individual");
                ObjCreditScoreCriteria.SetFilter(ObjCreditScoreCriteria."Min Amount Range", '<=%1', VarFOSAMonthlyInflowsAvaregeCredits);
                ObjCreditScoreCriteria.SetFilter(ObjCreditScoreCriteria."Max Amount Range", '>=%1', VarFOSAMonthlyInflowsAvaregeCredits);
                if ObjCreditScoreCriteria.FindSet then begin
                    VarScore_AvaregeInflowsIndividual := ObjCreditScoreCriteria."Credit Score";

                    ObjMemberCreditScore.Reset;
                    ObjMemberCreditScore.SetCurrentkey(ObjMemberCreditScore."Entry No");
                    if ObjMemberCreditScore.FindLast then begin
                        VarEntryNo := ObjMemberCreditScore."Entry No";
                    end;

                    ObjCreditScoreCriteria.Reset;
                    ObjCreditScoreCriteria.SetCurrentkey(ObjCreditScoreCriteria."Credit Score");
                    ObjCreditScoreCriteria.SetRange(ObjCreditScoreCriteria.Category, ObjCreditScoreCriteria.Category::"Monthly Average Inflows _From Last Month 1 Year Back_Individual");
                    if ObjCreditScoreCriteria.FindLast then
                        VarMaxScore_AvaregeInflowsIndividual := ObjCreditScoreCriteria."Credit Score";

                    ObjMemberCreditScore.Init;
                    ObjMemberCreditScore."Entry No" := VarEntryNo + 1;
                    ObjMemberCreditScore."Member No" := ObjMembers."No.";
                    ObjMemberCreditScore."Member Name" := ObjMembers.Name;
                    ObjMemberCreditScore.Category := ObjCreditScoreCriteria.Category;
                    ObjMemberCreditScore."Score Base Value" := Format(VarFOSAMonthlyInflowsAvaregeCredits);
                    ObjMemberCreditScore.Score := VarScore_AvaregeInflowsIndividual;
                    ObjMemberCreditScore."Out Of" := VarMaxScore_AvaregeInflowsIndividual;
                    ObjMemberCreditScore."Report Date" := WorkDate;
                    ObjMemberCreditScore.Insert;


                end;
            end;

            if ObjMembers."Account Category" <> ObjMembers."account category"::Individual then begin
                ObjCreditScoreCriteria.Reset;
                ObjCreditScoreCriteria.SetCurrentkey(ObjCreditScoreCriteria."Credit Score");
                ObjCreditScoreCriteria.SetRange(ObjCreditScoreCriteria.Category, ObjCreditScoreCriteria.Category::"Monthly Average Inflows _From Last Month 1 Year Back_Corporate");
                ObjCreditScoreCriteria.SetFilter(ObjCreditScoreCriteria."Min Amount Range", '<=%1', VarFOSAMonthlyInflowsAvaregeCredits);
                ObjCreditScoreCriteria.SetFilter(ObjCreditScoreCriteria."Max Amount Range", '>=%1', VarFOSAMonthlyInflowsAvaregeCredits);
                if ObjCreditScoreCriteria.FindSet then begin
                    VarScore_AvaregeInflowsCorporate := ObjCreditScoreCriteria."Credit Score";

                    ObjMemberCreditScore.Reset;
                    ObjMemberCreditScore.SetCurrentkey(ObjMemberCreditScore."Entry No");
                    if ObjMemberCreditScore.FindLast then begin
                        VarEntryNo := ObjMemberCreditScore."Entry No";
                    end;

                    ObjCreditScoreCriteria.Reset;
                    ObjCreditScoreCriteria.SetCurrentkey(ObjCreditScoreCriteria."Credit Score");
                    ObjCreditScoreCriteria.SetRange(ObjCreditScoreCriteria.Category, ObjCreditScoreCriteria.Category::"Monthly Average Inflows _From Last Month 1 Year Back_Corporate");
                    if ObjCreditScoreCriteria.FindLast then
                        VarMaxScore_AvaregeInflowsCorporate := ObjCreditScoreCriteria."Credit Score";

                    ObjMemberCreditScore.Init;
                    ObjMemberCreditScore."Entry No" := VarEntryNo + 1;
                    ObjMemberCreditScore."Member No" := ObjMembers."No.";
                    ObjMemberCreditScore."Member Name" := ObjMembers.Name;
                    ObjMemberCreditScore.Category := ObjCreditScoreCriteria.Category;
                    ObjMemberCreditScore."Score Base Value" := Format(VarFOSAMonthlyInflowsAvaregeCredits);
                    ObjMemberCreditScore.Score := VarScore_AvaregeInflowsCorporate;
                    ObjMemberCreditScore."Out Of" := VarMaxScore_AvaregeInflowsCorporate;
                    ObjMemberCreditScore."Report Date" := WorkDate;
                    ObjMemberCreditScore.Insert;


                end;
            end;

            //===========================================================================================FOSA Activity No Of Credit Transactions

            if ObjMembers."Account Category" = ObjMembers."account category"::Individual then begin
                ObjCreditScoreCriteria.Reset;
                ObjCreditScoreCriteria.SetCurrentkey(ObjCreditScoreCriteria."Credit Score");
                ObjCreditScoreCriteria.SetRange(ObjCreditScoreCriteria.Category, ObjCreditScoreCriteria.Category::"FOSA Activity_No of Credit Transactions Within 12 Months_Individual");
                ObjCreditScoreCriteria.SetFilter(ObjCreditScoreCriteria."Min Count Range", '<=%1', VarFOSANoOfCreditsTotalCount);
                ObjCreditScoreCriteria.SetFilter(ObjCreditScoreCriteria."Max Count Range", '>=%1', VarFOSANoOfCreditsTotalCount);
                if ObjCreditScoreCriteria.FindSet then begin
                    VarScore_NoofCreditTransactionsIndividual := ObjCreditScoreCriteria."Credit Score";

                    ObjMemberCreditScore.Reset;
                    ObjMemberCreditScore.SetCurrentkey(ObjMemberCreditScore."Entry No");
                    if ObjMemberCreditScore.FindLast then begin
                        VarEntryNo := ObjMemberCreditScore."Entry No";
                    end;


                    ObjCreditScoreCriteria.Reset;
                    ObjCreditScoreCriteria.SetCurrentkey(ObjCreditScoreCriteria."Credit Score");
                    ObjCreditScoreCriteria.SetRange(ObjCreditScoreCriteria.Category, ObjCreditScoreCriteria.Category::"FOSA Activity_No of Credit Transactions Within 12 Months_Individual");
                    if ObjCreditScoreCriteria.FindLast then
                        VarMaxScore_NoofCreditTransactionsIndividual := ObjCreditScoreCriteria."Credit Score";

                    ObjMemberCreditScore.Init;
                    ObjMemberCreditScore."Entry No" := VarEntryNo + 1;
                    ObjMemberCreditScore."Member No" := ObjMembers."No.";
                    ObjMemberCreditScore."Member Name" := ObjMembers.Name;
                    ObjMemberCreditScore.Category := ObjCreditScoreCriteria.Category;
                    ObjMemberCreditScore."Score Base Value" := Format(VarFOSANoOfCreditsTotalCount);
                    ObjMemberCreditScore.Score := ObjCreditScoreCriteria."Credit Score";
                    ObjMemberCreditScore."Out Of" := VarMaxScore_NoofCreditTransactionsIndividual;
                    ObjMemberCreditScore."Report Date" := WorkDate;
                    ObjMemberCreditScore.Insert;


                end;
            end;

            if ObjMembers."Account Category" <> ObjMembers."account category"::Individual then begin
                ObjCreditScoreCriteria.Reset;
                ObjCreditScoreCriteria.SetCurrentkey(ObjCreditScoreCriteria."Credit Score");
                ObjCreditScoreCriteria.SetRange(ObjCreditScoreCriteria.Category, ObjCreditScoreCriteria.Category::"FOSA Activity_No of Credit Transactions Within 12 Months_Corporate");
                ObjCreditScoreCriteria.SetFilter(ObjCreditScoreCriteria."Min Count Range", '<=%1', VarFOSANoOfCreditsTotalCount);
                ObjCreditScoreCriteria.SetFilter(ObjCreditScoreCriteria."Max Count Range", '>=%1', VarFOSANoOfCreditsTotalCount);
                if ObjCreditScoreCriteria.FindSet then begin
                    VarScore_NoofCreditTransactionsCorporate := ObjCreditScoreCriteria."Credit Score";

                    ObjMemberCreditScore.Reset;
                    ObjMemberCreditScore.SetCurrentkey(ObjMemberCreditScore."Entry No");
                    if ObjMemberCreditScore.FindLast then begin
                        VarEntryNo := ObjMemberCreditScore."Entry No";
                    end;

                    ObjCreditScoreCriteria.Reset;
                    ObjCreditScoreCriteria.SetCurrentkey(ObjCreditScoreCriteria."Credit Score");
                    ObjCreditScoreCriteria.SetRange(ObjCreditScoreCriteria.Category, ObjCreditScoreCriteria.Category::"FOSA Activity_No of Credit Transactions Within 12 Months_Corporate");
                    if ObjCreditScoreCriteria.FindLast then
                        VarMaxScore_NoofCreditTransactionsCorporate := ObjCreditScoreCriteria."Credit Score";

                    ObjMemberCreditScore.Init;
                    ObjMemberCreditScore."Entry No" := VarEntryNo + 1;
                    ObjMemberCreditScore."Member No" := ObjMembers."No.";
                    ObjMemberCreditScore."Member Name" := ObjMembers.Name;
                    ObjMemberCreditScore.Category := ObjCreditScoreCriteria.Category;
                    ObjMemberCreditScore."Score Base Value" := Format(VarFOSANoOfCreditsTotalCount);
                    ObjMemberCreditScore.Score := VarScore_NoofCreditTransactionsCorporate;
                    ObjMemberCreditScore."Out Of" := VarMaxScore_NoofCreditTransactionsCorporate;
                    ObjMemberCreditScore."Report Date" := WorkDate;
                    ObjMemberCreditScore.Insert;


                end;
            end;
        end;

        /*VarMaxScoreTotal:=VarMaxScore_Age+VarMaximumDeliquencyDays+VarMaxScore_AvaregeInflowsCorporate+VarMaxScore_AvaregeInflowsIndividual+VarMaxScore_AvaregeNoOfDeliquentDays+
                          VarMaxScore_DepositBoosting+VarMaxScore_DepositInconsistency+VarMaxScore_LoanRecoveriesFromDeposits+VarMaxScore_LongTermLoans+
                          VarMaxScore_MaximumNoOfDeliquentDays+VarMaxScore_MembershipPeriod+VarMaxScore_Morethan1DaysofDeliquency+VarMaxScore_Morethan30DaysofDeliquency+
                          VarMaxScore_NoofCreditTransactionsCorporate+VarMaxScore_NoofCreditTransactionsIndividual+VarMaxScore_NoofDaysDuePastDueLastMonth+
                          VarMaxScore_ShortTermLoans;*/




        //=========================================================================Get Member Percentage Score
        ObjMemberCreditScore.Reset;
        ObjMemberCreditScore.SetFilter(ObjMemberCreditScore."Member No", '%1', VarMemberNo);
        ObjMemberCreditScore.SetFilter(ObjMemberCreditScore."Report Date", '%1', WorkDate);
        if ObjMemberCreditScore.FindSet then begin
            ObjMemberCreditScore.CalcSums(ObjMemberCreditScore.Score, ObjMemberCreditScore."Out Of");
            VarMemberTotalScore := ObjMemberCreditScore.Score;
            VarMaxScoreTotal := ObjMemberCreditScore."Out Of";

            ObjMemberCreditScore.Reset;
            ObjMemberCreditScore.SetCurrentkey(ObjMemberCreditScore."Entry No");
            if ObjMemberCreditScore.FindLast then begin
                VarEntryNo := ObjMemberCreditScore."Entry No";
            end;

            ObjMemberCreditScore.Init;
            ObjMemberCreditScore."Entry No" := VarEntryNo + 1;
            ObjMemberCreditScore."Member No" := ObjMembers."No.";
            ObjMemberCreditScore."Member Name" := ObjMembers.Name;
            ObjMemberCreditScore.Category := ObjMemberCreditScore.Category::Totals;
            ObjMemberCreditScore."Score Base Value" := '';
            ObjMemberCreditScore.Score := VarMemberTotalScore;
            ObjMemberCreditScore."Out Of" := VarMaxScoreTotal;
            ObjMemberCreditScore."Report Date" := WorkDate;
            ObjMemberCreditScore.Insert;
        end;

        VarMemberCreditScorePercentage := ROUND((VarMemberTotalScore / VarMaxScoreTotal) * 100, 0.01, '=');


        ObjCreditScoreScale.Reset;
        ObjCreditScoreScale.SetFilter(ObjCreditScoreScale."Minimum Credit Score", '<=%1', VarMemberCreditScorePercentage);
        ObjCreditScoreScale.SetFilter(ObjCreditScoreScale."Maximum Credit Score", '>=%1', VarMemberCreditScorePercentage);
        if ObjCreditScoreScale.FindSet then begin
            ObjMembers."Member Credit Score" := VarMemberCreditScorePercentage;
            ObjMembers."Member Credit Score Desc." := ObjCreditScoreScale.Description;
            ObjMembers.Modify;
        end;

    end;


    procedure FnRunGetShareBoostingDetailsCreditScoring(VarMemberNo: Code[30]; VarDateFilterLocal: Text; VarBoostingEndMonthDate: Date; VarShareBoostingCheckDate: Date; VarBoostingBeginMonthDate: Date) VarBoosted: Boolean
    var
        ObjMember: Record Customer;
        ObjGenSetUp: Record "Sacco General Set-Up";
        ObjDetailedLedg: Record "Detailed Vendor Ledg. Entry";
        VarBoostedAmount2: Decimal;
        ObjHistoricalLedg: Record "Member Historical Ledger Entry";
        VarHistoricalBoostedAmount: Decimal;
        VarBoostingDateFilter: Text;
        ObjAccount: Record Vendor;
        VarDepositHalfBeforeBoosting: Decimal;
        VarGoLiveDate: Text;
        VarBoostedAmount: Decimal;
        VarBalance: Decimal;
    begin

        //==================================================================================================CHECK SHARES BOOSTING
        VarBoostedAmount := 0;
        VarBoostedAmount2 := 0;
        VarHistoricalBoostedAmount := 0;
        VarDepositHalfBeforeBoosting := 0;

        ObjGenSetUp.Get();
        VarGoLiveDate := '<>' + Format(ObjGenSetUp."Go Live Date");

        ObjMember.Reset;
        ObjMember.SetRange(ObjMember."No.", VarMemberNo);
        if ObjMember.FindSet then begin
            ObjDetailedLedg.Reset;
            ObjDetailedLedg.SetRange(ObjDetailedLedg."Vendor No.", ObjMember."Deposits Account No");
            ObjDetailedLedg.SetFilter(ObjDetailedLedg."Posting Date", VarDateFilterLocal);
            ObjDetailedLedg.SetFilter(ObjDetailedLedg."Document No.", '<>%1', 'BALB/F9THNOV2018');
            ObjDetailedLedg.SetFilter(ObjDetailedLedg.Description, '<>%1&<>%2&<>%3&<>%4&<>%5', '*Fee*', '*Charge*', '*Tax*', '*Excise*', '*Refund*');
            if ObjDetailedLedg.FindSet then begin
                ObjDetailedLedg.CalcSums(ObjDetailedLedg.Amount);
                VarBoostedAmount := ObjDetailedLedg.Amount * -1;
            end;

            ObjHistoricalLedg.Reset;
            ObjHistoricalLedg.SetRange(ObjHistoricalLedg."Account No.", ObjMember."Deposits Account No");
            ObjHistoricalLedg.SetFilter(ObjHistoricalLedg."Posting Date", VarDateFilterLocal);
            if ObjHistoricalLedg.FindSet then begin
                ObjHistoricalLedg.CalcSums(ObjHistoricalLedg.Amount);
                VarHistoricalBoostedAmount := ObjHistoricalLedg.Amount * -1;
            end;

            if VarBoostingBeginMonthDate > ObjGenSetUp."Go Live Date" then begin
                VarBoostingDateFilter := '..' + Format(VarBoostingBeginMonthDate);
                ObjAccount.Reset;
                ObjAccount.SetRange(ObjAccount."No.", ObjMember."Deposits Account No");
                ObjAccount.SetFilter(ObjAccount."Date Filter", VarBoostingDateFilter);
                if ObjAccount.FindSet then begin
                    ObjAccount.CalcFields(ObjAccount.Balance);
                    VarDepositHalfBeforeBoosting := ObjAccount.Balance / 2;
                    VarBalance := ObjAccount.Balance;
                end;
            end else begin
                VarBoostingDateFilter := '..' + Format(VarBoostingBeginMonthDate);
                ObjAccount.Reset;
                ObjAccount.SetRange(ObjAccount."No.", ObjMember."Deposits Account No");
                ObjAccount.SetFilter(ObjAccount."Date Filter", VarBoostingDateFilter);
                if ObjAccount.FindSet then begin
                    ObjAccount.CalcFields(ObjAccount."Balance Historical");
                    VarDepositHalfBeforeBoosting := (ObjAccount."Balance Historical" * -1) / 2;
                    VarBalance := ObjAccount."Balance Historical";
                end;
            end;

            VarBoostedAmount2 := VarBoostedAmount + VarHistoricalBoostedAmount;

            if VarBoostedAmount2 > VarDepositHalfBeforeBoosting then begin
                VarBoosted := true;
            end;

            exit(VarBoosted);
        end;
    end;


    procedure FnRunPasswordChangeonNextLogin()
    var
        ObjUsers: Record User;
    begin
        /*ObjUsers.RESET;
        ObjUsers.SETFILTER(ObjUsers."Authentication Type",'<=%1',WORKDATE);
        ObjUsers.SETRANGE(ObjUsers."Change Password",FALSE);
        ObjUsers.SETFILTER(ObjUsers."User Name",'<>%1','SYSTEM');
        IF ObjUsers.FINDSET THEN
        BEGIN
          REPEAT
            ObjUsers."Change Password":=TRUE;
            ObjUsers.MODIFY;
          UNTIL ObjUsers.NEXT=0;
        END;
        */

    end;


    procedure FnRunPostPiggyBankCharges(VarPiggyBankAccount: Code[30]; VarExistingPiggyBank: Boolean)
    var
        ObjAccount: Record Vendor;
        ObjAccountType: Record "Account Types-Saving Products";
        VarPiggyBankFee: Decimal;
        VarTransactionNarrationDebit: Text;
        VarTransactionNarrationCredit: Text;
        VarTaxAmount: Decimal;
        VarAccountAvailableBal: Decimal;
        LineNo: Integer;
        BATCH_TEMPLATE: Code[20];
        BATCH_NAME: Code[20];
        DOCUMENT_NO: Code[20];
        EXTERNAL_DOC_NO: Code[20];
    begin
        ObjGenSetUp.Get;
        if ObjAccount.Get(VarPiggyBankAccount) then begin
            ObjAccountType.Reset;
            ObjAccountType.SetRange(ObjAccountType.Code, ObjAccount."Account Type");
            if ObjAccountType.FindSet then begin


                BATCH_TEMPLATE := 'GENERAL';
                BATCH_NAME := 'DEFAULT';
                DOCUMENT_NO := FnRunGetNextTransactionDocumentNo;
                EXTERNAL_DOC_NO := '';

                //==========================================================================Existing Piggy Bank
                if (VarExistingPiggyBank = true) or (ObjAccountType."Default Piggy Bank Issuance" = false) then begin
                    VarPiggyBankFee := ObjAccountType."Additional Piggy Bank Fee";
                    VarTransactionNarrationDebit := 'Additional Piggy Bank Purchase';
                    VarTransactionNarrationCredit := 'Piggy Bank Purchased by ' + ObjAccount."No." + ' ' + ObjAccount.Name;


                    VarTaxAmount := VarPiggyBankFee * (ObjGenSetUp."Excise Duty(%)" / 100);
                    VarAccountAvailableBal := FnRunGetAccountAvailableBalance(VarPiggyBankAccount);

                    if VarAccountAvailableBal < (VarPiggyBankFee + VarTaxAmount) then
                        Error('The Account does not have sufficient Balance to perform this Transaction. Available Bal is %1', VarAccountAvailableBal);

                    //=======================================================================================Debit FOSA Account
                    LineNo := LineNo + 10000;
                    FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ", GenJournalLine."account type"::Vendor,
                    ObjAccount."No.", WorkDate, VarPiggyBankFee, 'FOSA', DOCUMENT_NO, VarTransactionNarrationDebit, '', GenJournalLine."application source"::" ");

                    LineNo := LineNo + 10000;
                    FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ", GenJournalLine."account type"::Vendor,
                   ObjAccount."No.", WorkDate, VarTaxAmount, 'FOSA', DOCUMENT_NO, 'Tax: Piggy Bank Fees', '', GenJournalLine."application source"::" ");


                    //=======================================================================================Credit Income Account
                    LineNo := LineNo + 10000;
                    FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ", GenJournalLine."account type"::"G/L Account",
                    ObjAccountType."Piggy Bank Fee Account", WorkDate, VarPiggyBankFee * -1, 'FOSA', DOCUMENT_NO, VarTransactionNarrationCredit, '', GenJournalLine."application source"::" ");

                    //=======================================================================================Credit Tax:ATM Card Fee G/L Account
                    LineNo := LineNo + 10000;
                    FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ", GenJournalLine."account type"::"G/L Account",
                    ObjGenSetUp."Excise Duty Account", WorkDate, VarTaxAmount * -1, 'FOSA', DOCUMENT_NO, 'Tax: Piggy Bank Fees - ' + ObjAccount."No.", '', GenJournalLine."application source"::" ");

                end else
                    if (ObjAccountType."Default Piggy Bank Issuance" = true) and (VarExistingPiggyBank = false) then begin
                        ObjGenSetUp.Get;
                        VarPiggyBankFee := ObjAccountType."New Piggy Bank Fee";

                        //=======================================================================================Debit Source G/L
                        LineNo := LineNo + 10000;
                        FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ", GenJournalLine."account type"::"G/L Account",
                        ObjGenSetUp."New Piggy Bank Debit G/L", WorkDate, VarPiggyBankFee, 'FOSA', DOCUMENT_NO, 'Piggy Bank Issue to ' + ObjAccount."No." + ' ' + ObjAccount.Name, '',
                         GenJournalLine."application source"::" ");


                        //=======================================================================================Credit Destination G/L
                        LineNo := LineNo + 10000;
                        FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ", GenJournalLine."account type"::"G/L Account",
                        ObjGenSetUp."New Piggy Bank Credit G/L", WorkDate, VarPiggyBankFee * -1, 'FOSA', DOCUMENT_NO, 'Piggy Bank Issue to ' + ObjAccount."No." + ' ' + ObjAccount.Name, '',
                        GenJournalLine."application source"::" ");
                    end;

                //CU Post
                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                if GenJournalLine.Find('-') then begin
                    Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
                end;
            end;
        end;
    end;


    procedure FnCalculateLoanInterest(Loan: Record "Loans Register"; AsAt: Date) Int: Decimal
    var
        LBalance: Decimal;
    begin
        Int := 0;
        with Loan do begin
            SetFilter("Date filter", '..%1', AsAt);
            CalcFields("Outstanding Balance");
            LBalance := Loan."Outstanding Balance";
            if (Installments > 0) and (Interest > 0) then begin
                case Loan."Repayment Method" of
                    Loan."repayment method"::Amortised:
                        begin
                            Int := ROUND(LBalance / 100 / 12 * Loan.Interest);
                        end;
                    Loan."repayment method"::"Straight Line":
                        begin
                            Int := ROUND((Loan.Interest / 1200) * Loan."Approved Amount", 1, '>');
                        end;
                    Loan."repayment method"::"Reducing Balance":
                        begin
                            Int := ROUND((Loan.Interest / 12 / 100) * LBalance, 1, '>');
                        end;
                end;
            end;
        end;
    end;

    // progress Dialog
    procedure fnCreateProgressDialog(TheRec: RecordRef)

    var
        PDialog: Dialog;
        TheCount: Integer;
        CurrentCount: Integer;
        TheTextToUpdate: Label 'Processing #1#######################\Customer No #2##################';
    begin


    end;


}

