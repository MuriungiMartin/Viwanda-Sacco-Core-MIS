#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Report 50968 "Daily Loan Porfolio Process"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("Loans Register"; "Loans Register")
        {
            DataItemTableView = where("Loan Status" = filter(<> Closed), "Loan Amount Due" = filter(> 0));
            RequestFilterFields = "Loan  No.", "Client Code";
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnPostDataItem()
            begin
                FnRunDemandNotices();
                //FnUpdateLoanDueAmounts();
            end;

            trigger OnPreDataItem()
            begin
                ReportDate := CalcDate('-1D', WorkDate);
                SFactory.FnUpdateLoanPortfolio(ReportDate);
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        ObjGensetup: Record "Sacco General Set-Up";
        GenJournalLine: Record "Gen. Journal Line";
        BATCH_TEMPLATE: Code[30];
        BATCH_NAME: Code[30];
        DOCUMENT_NO: Code[30];
        LineNo: Integer;
        SFactory: Codeunit "SURESTEP Factory";
        ObjRepamentSchedule: Record "Loan Repayment Schedule";
        ObjAccounts: Record Vendor;
        ObjAccTypes: Record "Account Types-Saving Products";
        AvailableBal: Decimal;
        VarPrincipalRepayment: Decimal;
        VarTotalRepaymentDue: Decimal;
        VarInsuranceAmountDed: Decimal;
        VarInterestAmountDed: Decimal;
        VarPrincipleAmountDed: Decimal;
        ObjLoans: Record "Loans Register";
        ObjExcessRepaymentProducts: Record "Excess Repayment Rules Product";
        VarExcessRuleType: Option " ","Exempt From Excess Rule","Biggest Loan","Smallest Loan","Oldest Loan","Newest Loan";
        ObjExcessRule: Record "Excess Repayment Rules";
        VarNoofLoansCount: Integer;
        VarLoanAmountDue: Decimal;
        VarAvailableBalRecoveryAccount: Decimal;
        VarRuningBal: Decimal;
        VarAmountDeducted: Decimal;
        VarLSAAccount: Code[30];
        VarAvailableOtherFOSAAccounts: Decimal;
        VarAmouttoRecover: Decimal;
        VarDebtCollectorFee: Decimal;
        ObjCust: Record Customer;
        VarAmountInArrears: Decimal;
        ObjSurestep: Codeunit "SURESTEP Factory";
        ObjDemands: Record "Default Notices Register";
        ObjSaccoNoSeries: Record "Sacco No. Series";
        VarDocumentNo: Code[20];
        ObjNoSeriesMgt: Codeunit NoSeriesManagement;
        ObjLSchedule: Record "Loan Repayment Schedule";
        VarScheduleDate: Date;
        SurestpFactory: Codeunit "SURESTEP Factory";
        VarMobileNo: Code[30];
        VarSmsBody: Text[250];
        ObjLoanTypes: Record "Loan Products Setup";
        VarHsLeaderMobile: Code[20];
        VarAssHsLeaderMobile: Code[20];
        ObjHouse: Record "Member House Groups";
        ObjLoansGuarantors: Record "Loans Guarantee Details";
        SMSScheduledOn: DateTime;
        ObjMemberLedger: Record "Member Ledger Entry";
        ReportDate: Date;

    local procedure FnRunDemandNotices()
    var
        ObjLoanPortfolio: Record "Loan Portfolio Provision";
        ObjLoan: Record "Loans Register";
        ObjCRBRegister: Record "CRB Notice Register";
    begin
        SMSScheduledOn := CreateDatetime(WorkDate, 110000T);

        ObjGensetup.Get();
        ObjLoanPortfolio.Reset;
        ObjLoanPortfolio.SetRange(ObjLoanPortfolio."Report Date", ReportDate);
        ObjLoanPortfolio.SetFilter(ObjLoanPortfolio."Arrears Days", '>%1', 1);
        ObjLoanPortfolio.SetFilter(ObjLoanPortfolio."Arrears Amount", '>%1', 1);
        ObjLoanPortfolio.SetRange(ObjLoanPortfolio.Alerted, false);
        if ObjLoanPortfolio.FindSet then begin
            repeat
                ObjLoan.Reset;
                ObjLoan.SetRange(ObjLoan."Loan  No.", ObjLoanPortfolio."Loan No");
                if ObjLoan.FindSet then begin
                    ObjCust.Reset;
                    ObjCust.SetRange(ObjCust."No.", ObjLoanPortfolio."Member No");
                    ObjCust.SetFilter(ObjCust.Status, '<>%1', ObjCust.Status::Deceased);//Do not Alert or Accrue Penalty for Deceased Member
                    if ObjCust.FindSet then begin

                        //==========================================Charge Daily Penalty
                        SurestpFactory.FnGetDailyPenaltyChargedOnLoans(ObjLoanPortfolio."Loan No");

                        //=============Create 1st Demand Notice======================================================
                        if ObjLoanPortfolio."Arrears Days" = ObjGensetup."1st Demand Notice Days" then begin
                            if ObjSaccoNoSeries.Get then begin
                                ObjSaccoNoSeries.TestField(ObjSaccoNoSeries."Demand Notice Nos");
                                VarDocumentNo := ObjNoSeriesMgt.GetNextNo(ObjSaccoNoSeries."Demand Notice Nos", 0D, true);

                                ObjDemands.Init;
                                ObjDemands."Document No" := VarDocumentNo;
                                ObjDemands."Member No" := ObjLoanPortfolio."Member No";
                                ObjDemands."Member Name" := ObjLoanPortfolio."Member Name";
                                ObjDemands."Amount In Arrears" := ObjLoanPortfolio."Arrears Amount";
                                ObjDemands."Days In Arrears" := ObjLoanPortfolio."Arrears Days";
                                ObjDemands."Loan In Default" := ObjLoanPortfolio."Loan No";
                                ObjDemands."Notice Type" := ObjDemands."notice type"::"1st Demand Notice";
                                ObjDemands."Demand Notice Date" := ReportDate;
                                ObjDemands.Insert;
                                /*ObjDemands.VALIDATE(ObjDemands."Loan In Default");
                                ObjDemands.MODIFY;*/
                            end;
                        end;
                        //=============End Create 1st Demand Notice======================================================

                        //=============Create 2nd Demand Notice======================================================
                        if ObjLoanPortfolio."Arrears Days" = ObjGensetup."2nd Demand Notice Days" then begin
                            if ObjSaccoNoSeries.Get then begin
                                ObjSaccoNoSeries.TestField(ObjSaccoNoSeries."Demand Notice Nos");
                                VarDocumentNo := ObjNoSeriesMgt.GetNextNo(ObjSaccoNoSeries."Demand Notice Nos", 0D, true);

                                ObjDemands.Init;
                                ObjDemands."Document No" := VarDocumentNo;
                                ObjDemands."Document No" := VarDocumentNo;
                                ObjDemands."Member No" := ObjLoanPortfolio."Member No";
                                ObjDemands."Member Name" := ObjLoanPortfolio."Member Name";
                                ObjDemands."Amount In Arrears" := ObjLoanPortfolio."Arrears Amount";
                                ObjDemands."Days In Arrears" := ObjLoanPortfolio."Arrears Days";
                                ObjDemands."Loan In Default" := ObjLoanPortfolio."Loan No";
                                ObjDemands."Notice Type" := ObjDemands."notice type"::"2nd Demand Notice";
                                ObjDemands."Demand Notice Date" := ReportDate;
                                ObjDemands.Insert;
                                /*ObjDemands.VALIDATE(ObjDemands."Loan In Default");
                                ObjDemands.MODIFY;*/
                            end;
                        end;
                        //=============End Create 2nd Demand Notice======================================================

                        //=============Create CRB Demand Notice======================================================
                        if ObjLoanPortfolio."Arrears Days" = ObjGensetup."CRB Notice Days" then begin
                            if ObjSaccoNoSeries.Get then begin
                                ObjSaccoNoSeries.TestField(ObjSaccoNoSeries."Demand Notice Nos");
                                VarDocumentNo := ObjNoSeriesMgt.GetNextNo(ObjSaccoNoSeries."Demand Notice Nos", 0D, true);

                                ObjDemands.Init;
                                ObjDemands."Document No" := VarDocumentNo;
                                ObjDemands."Member No" := ObjLoanPortfolio."Member No";
                                ObjDemands."Member Name" := ObjLoanPortfolio."Member Name";
                                ObjDemands."Loan In Default" := ObjLoanPortfolio."Loan No";
                                ObjDemands."Amount In Arrears" := ObjLoanPortfolio."Arrears Amount";
                                ObjDemands."Days In Arrears" := ObjLoanPortfolio."Arrears Days";
                                ObjDemands."Notice Type" := ObjDemands."notice type"::"CRB Notice";
                                ObjDemands."Demand Notice Date" := Today;
                                ObjDemands.Insert;
                                /*ObjDemands.VALIDATE(ObjDemands."Loan In Default");
                                ObjDemands.MODIFY;*/
                                ObjLoan."Loans Under CRB Notice" := true;
                                ObjLoan.Modify;

                                //=======================================Create A CRB Register
                                ObjLoan.CalcFields(ObjLoan."Outstanding Balance");
                                ObjCRBRegister.Reset;
                                ObjCRBRegister.SetRange(ObjCRBRegister."Loan No", ObjLoanPortfolio."Loan No");
                                if ObjCRBRegister.FindSet = false then begin
                                    ObjCRBRegister.Init;
                                    ObjCRBRegister."Loan No" := ObjLoanPortfolio."Loan No";
                                    ObjCRBRegister."Member No" := ObjLoanPortfolio."Member No";
                                    ObjCRBRegister."Member Name" := ObjLoanPortfolio."Member Name";
                                    ObjCRBRegister."Loan Product Type" := ObjLoanPortfolio."Loan Product Code";
                                    ObjCRBRegister."Loan Product Name" := ObjLoan."Loan Product Type Name";
                                    ObjCRBRegister."Approved Amount" := ObjLoan."Approved Amount";
                                    ObjCRBRegister."Issued Date" := ObjLoan."Issued Date";
                                    ObjCRBRegister."Principle Outstanding" := ObjLoanPortfolio."Outstanding Balance";
                                    ObjCRBRegister."Amount In Arrears" := ObjLoanPortfolio."Arrears Amount";
                                    ObjCRBRegister."Days In Arrears" := ObjLoanPortfolio."Arrears Days";
                                    ObjCRBRegister."Date Of Notice" := ReportDate;
                                    ObjCRBRegister.Insert;
                                end;
                            end;
                        end;
                        //=============End Create CRB Demand Notice======================================================


                        //=============Create Auctioneer Demand Notice======================================================
                        if ObjLoanPortfolio."Arrears Days" = ObjGensetup."Auctioneer Notice Days" then begin
                            if ObjSaccoNoSeries.Get then begin
                                ObjSaccoNoSeries.TestField(ObjSaccoNoSeries."Demand Notice Nos");
                                VarDocumentNo := ObjNoSeriesMgt.GetNextNo(ObjSaccoNoSeries."Demand Notice Nos", 0D, true);

                                ObjDemands.Init;
                                ObjDemands."Document No" := VarDocumentNo;
                                ObjDemands."Member No" := ObjLoanPortfolio."Member No";
                                ObjDemands."Member Name" := ObjLoanPortfolio."Member Name";
                                ObjDemands."Loan In Default" := ObjLoanPortfolio."Loan No";
                                ObjDemands."Amount In Arrears" := ObjLoanPortfolio."Arrears Amount";
                                ObjDemands."Days In Arrears" := ObjLoanPortfolio."Arrears Days";
                                ObjDemands."Notice Type" := ObjDemands."notice type"::"Debt Collector Notice";
                                ObjDemands."Demand Notice Date" := Today;
                                ObjDemands.Insert;
                                /*ObjDemands.VALIDATE(ObjDemands."Loan In Default");
                                ObjDemands.MODIFY;*/
                            end;
                        end;
                        //=============End Create Auctioneer Demand Notice======================================================


                        //=========================================Send SMS Notifications
                        FnRunSMSMember(ObjLoanPortfolio."Member No", ObjLoan."Loan Product Type Name", ROUND(ObjLoanPortfolio."Arrears Amount", 1, '>'),
                        ObjLoanPortfolio."Arrears Days", ObjLoan."Client Name", ObjLoan."Loan Under Debt Collection", ObjLoanPortfolio."Loan No");

                        FnRunSMSHouseLeaders(ObjLoan."Member House Group", ObjLoan."Client Name", ObjLoan."Member House Group Name", ObjLoan."Loan Product Type Name",
                        ROUND(ObjLoanPortfolio."Arrears Amount", 1, '>'), ObjLoanPortfolio."Arrears Days", ObjLoan."Client Code", ObjLoan."Loan  No.");

                        FnRunSMSGroupMembers(ObjLoan."Loan  No.", ROUND(ObjLoanPortfolio."Arrears Amount", 1, '>'), ObjLoanPortfolio."Arrears Days", ObjLoan."Client Name",
                        ObjLoan."Loan Product Type Name", ObjLoan."Client Code");

                        FnRunSMSMemberCRBNotice(ObjLoan."Client Code", ObjLoan."Loan Product Type Name", ROUND(ObjLoanPortfolio."Arrears Amount", 1, '>'),
                        ObjLoanPortfolio."Arrears Days", ObjLoan."Client Name", ObjLoan."Loan Under Debt Collection", ObjLoan."Loan  No.");

                        FnRunSMSMemberCRBNoticeMobileLoans(ObjLoan."Client Code", ObjLoan."Loan Product Type Name", ROUND(ObjLoanPortfolio."Arrears Amount", 1, '>'),
                        ObjLoanPortfolio."Arrears Days", ObjLoan."Client Name", ObjLoan."Loan Under Debt Collection", ObjLoan."Loan Product Type", ObjLoan."Loan  No.");
                        //========================================End Send SMS Notifications
                    end;
                end;

                ObjLoanPortfolio.Alerted := true;
                ObjLoanPortfolio.Modify;

            until ObjLoanPortfolio.Next = 0;
        end

    end;

    local procedure FnRunSMSMember(VarMemberNo: Code[30]; VarLoanProductName: Text[100]; VarAmountinArrears: Decimal; VarDaysinArrears: Decimal; VarMemberName: Text[100]; VarLoanUnderDebtCollection: Boolean; VarLoanNo: Code[30])
    begin
        ObjGensetup.Get();
        if (VarAmountinArrears <> 0) and ((VarDaysinArrears = ObjGensetup."Member Notice Days") or (VarDaysinArrears MOD ObjGensetup."Repetitive SMS Frequency Days" = 0)) and (VarLoanUnderDebtCollection = false) then begin
            if ObjCust.Get(VarMemberNo) then begin
                VarMobileNo := ObjCust."Mobile Phone No";
            end;
            VarMemberName := SurestpFactory.FnRunSplitString(VarMemberName, ' ');
            VarMemberName := SurestpFactory.FnConvertTexttoBeginingWordstostartWithCapital(VarMemberName);
            if VarMobileNo <> '' then begin
                VarSmsBody := 'Dear ' + Format(VarMemberName) + ', ' + 'reminder; ' + 'your ' + VarLoanProductName + ' is in arrears of Ksh. ' +
                Format(VarAmountinArrears) + ' and accrues penalty daily. Submit any bankslips.' + ' Our Paybill is 521000';
                SurestpFactory.FnSendSMSScheduled('MEMBERNOTICE', VarSmsBody, VarLoanNo, VarMobileNo, SMSScheduledOn);
            end;
        end;
    end;

    local procedure FnRunSMSHouseLeaders(VarHouseGroup: Code[30]; VarMemberName: Text[100]; VarHouseGroupName: Text[100]; VarLoanProductName: Text[100]; VarAmountinArrears: Decimal; VarDaysinArrears: Decimal; VarMemberNo: Code[30]; VarLoanNo: Code[30])
    var
        VarGroupLeaderName: Text[100];
        VarAssistantGroupLeaderName: Text[100];
        VarMemberHouseGroupStatus: Option Active,"Exiting the Group";
    begin
        ObjGensetup.Get();
        if ObjCust.Get(VarMemberNo) then begin
            VarMemberHouseGroupStatus := ObjCust."House Group Status";
        end;

        VarHsLeaderMobile := '';
        VarAssHsLeaderMobile := '';
        VarGroupLeaderName := '';
        VarAssistantGroupLeaderName := '';

        ObjLoans.Get(VarLoanNo);
        if ObjLoans.Source = ObjLoans.Source::BOSA then begin
            if (VarAmountinArrears <> 0) and ((VarDaysinArrears = ObjGensetup."Group Leaders Notice Days") or (VarDaysinArrears MOD ObjGensetup."Repetitive SMS Frequency Days" = 0))
            and (VarMemberHouseGroupStatus <> Varmemberhousegroupstatus::"Exiting the Group") then begin
                ObjHouse.Reset;
                ObjHouse.SetRange(ObjHouse."Cell Group Code", VarHouseGroup);
                if ObjHouse.FindSet then begin
                    VarHsLeaderMobile := ObjHouse."Group Leader Phone No";
                    VarAssHsLeaderMobile := ObjHouse."Assistant Group Leader Phone N";
                    VarGroupLeaderName := ObjHouse."Group Leader Name";
                    VarAssistantGroupLeaderName := ObjHouse."Assistant Group Name";


                    if (VarHsLeaderMobile <> '') and (ObjHouse."Group Leader" <> VarMemberNo) then begin
                        VarGroupLeaderName := SurestpFactory.FnRunSplitString(VarGroupLeaderName, ' ');
                        VarGroupLeaderName := SurestpFactory.FnConvertTexttoBeginingWordstostartWithCapital(VarGroupLeaderName);

                        VarSmsBody := 'Dear ' + (VarGroupLeaderName) + ', ' + 'Kindly note that ' + Format(VarMemberName) + ' ' + VarLoanProductName + ' is in Arrears of Ksh. ' +
                        Format(VarAmountinArrears) + ' and affects your Group Performance';
                        SurestpFactory.FnSendSMSScheduled('LEADERSNOTICE', VarSmsBody, VarLoanNo, VarHsLeaderMobile, SMSScheduledOn);
                    end;


                    if (VarAssHsLeaderMobile <> '') and (ObjHouse."Assistant group Leader" <> VarMemberNo) then begin
                        VarAssistantGroupLeaderName := SurestpFactory.FnRunSplitString(VarAssistantGroupLeaderName, ' ');
                        VarAssistantGroupLeaderName := SurestpFactory.FnConvertTexttoBeginingWordstostartWithCapital(VarAssistantGroupLeaderName);

                        VarSmsBody := 'Dear ' + (VarAssistantGroupLeaderName) + ', ' + 'Kindly note that ' + Format(VarMemberName) + ' ' + VarLoanProductName + ' is in Arrears of Ksh. ' +
                        Format(VarAmountinArrears) + ' and affects your Group Performance';
                        SurestpFactory.FnSendSMSScheduled('LEADERSNOTICE', VarSmsBody, VarLoanNo, VarAssHsLeaderMobile, SMSScheduledOn);
                    end;
                end;
            end;
        end;
    end;

    local procedure FnRunSMSGroupMembers(VarLoanNo: Code[30]; VarAmountinArrears: Decimal; VarDaysinArrears: Integer; VarMemberName: Text[100]; VarLoanProductName: Text[100]; VarMemberNo: Code[30])
    var
        VarGuarantorName: Text[100];
    begin
        ObjGensetup.Get();
        if (VarAmountinArrears <> 0) and (VarDaysinArrears = ObjGensetup."Group Members Notice Days") then begin
            ObjLoansGuarantors.Reset;
            ObjLoansGuarantors.SetRange(ObjLoansGuarantors."Loan No", VarLoanNo);
            ObjLoansGuarantors.SetFilter(ObjLoansGuarantors."Member No", '<>%1', VarMemberNo);
            if ObjLoansGuarantors.FindSet then begin
                repeat
                    if ObjCust.Get(ObjLoansGuarantors."Member No") then begin
                        if ObjCust."House Group Status" <> ObjCust."house group status"::"Exiting the Group" then begin
                            VarGuarantorName := ObjLoansGuarantors.Name;

                            VarGuarantorName := SurestpFactory.FnRunSplitString(VarGuarantorName, ' ');
                            VarGuarantorName := SurestpFactory.FnConvertTexttoBeginingWordstostartWithCapital(VarGuarantorName);

                            VarSmsBody := 'Dear ' + VarGuarantorName + ', Kindly note that ' + (VarMemberName) + ' ' + Format(VarLoanProductName) + ' is '
                            + Format(ObjGensetup."Group Members Notice Days") + ' Days in arrears. We will proceed to recover the ' +
                             'loan from your group deposits if the arrears are not paid in 14 days';
                            SurestpFactory.FnSendSMSScheduled('GMEMBERSNOTICE', VarSmsBody, VarLoanNo, ObjCust."Mobile Phone No", SMSScheduledOn);
                        end;
                    end;
                until ObjLoansGuarantors.Next = 0;
            end;
        end;
    end;

    local procedure FnRunSMSMemberCRBNotice(VarMemberNo: Code[30]; VarLoanProductName: Text[100]; VarAmountinArrears: Decimal; VarDaysinArrears: Integer; VarMemberName: Text[100]; VarLoanUnderDebtCollection: Boolean; VarLoanNo: Code[30])
    begin
        ObjGensetup.Get();
        if (VarAmountinArrears <> 0) and (VarDaysinArrears = ObjGensetup."CRB Notice Days") and (VarLoanUnderDebtCollection = false) then begin
            if ObjCust.Get(VarMemberNo) then begin
                VarMobileNo := ObjCust."Mobile Phone No";
            end;

            VarMemberName := SurestpFactory.FnRunSplitString(VarMemberName, ' ');
            VarMemberName := SurestpFactory.FnConvertTexttoBeginingWordstostartWithCapital(VarMemberName);

            VarSmsBody := 'Dear ' + Format(VarMemberName) + ', your ' + VarLoanProductName + ' arrears of Ksh. ' +
            Format(VarAmountinArrears) + ' are 60 days overdue and you will be listed with CRB in 30 days if the arrears are not fully Cleared';
            SurestpFactory.FnSendSMSScheduled('CRBNOTICE', VarSmsBody, VarLoanNo, VarMobileNo, SMSScheduledOn);
        end;
    end;

    local procedure FnRunSMSMemberCRBNoticeMobileLoans(VarMemberNo: Code[30]; VarLoanProductName: Text[100]; VarAmountinArrears: Decimal; VarDaysinArrears: Integer; VarMemberName: Text[100]; VarLoanUnderDebtCollection: Boolean; VarLoanProductType: Code[30]; VarLoanNo: Code[30])
    begin
        ObjGensetup.Get();
        if (VarAmountinArrears <> 0) and (VarDaysinArrears = ObjGensetup."Mobile Loan CRB Notice Days") and (VarLoanProductType = '322') then begin
            if ObjCust.Get(VarMemberNo) then begin
                VarMobileNo := ObjCust."Mobile Phone No";
            end;

            VarMemberName := SurestpFactory.FnRunSplitString(VarMemberName, ' ');
            VarMemberName := SurestpFactory.FnConvertTexttoBeginingWordstostartWithCapital(VarMemberName);

            VarSmsBody := 'Dear ' + Format(VarMemberName) + ', your ' + VarLoanProductName + ' arrears of Ksh. ' +
            Format(VarAmountinArrears) + ' are overdue and you will be listed with CRB in ' + Format((30 - VarDaysinArrears)) + ' days if the arrears are not fully Cleared. KSACCO';
            SurestpFactory.FnSendSMSScheduled('CRBNOTICE', VarSmsBody, VarLoanNo, VarMobileNo, SMSScheduledOn);
        end;
    end;

    local procedure FnUpdateLoanDueAmounts()
    var
        ObjLoans: Record "Loans Register";
    begin
        ObjLoans.CalcFields(ObjLoans."Outstanding Balance");
        ObjLoans.Reset;
        ObjLoans.SetFilter(ObjLoans."Outstanding Balance", '>%1', 1);
        if ObjLoans.FindSet then begin
            repeat
                SFactory.FnRunLoanAmountDue(ObjLoans."Loan  No.");
            until ObjLoans.Next = 0
        end;
    end;
}

