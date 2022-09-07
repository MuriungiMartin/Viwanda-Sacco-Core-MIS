#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Report 50945 "House Group Statement Process"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("Member House Groups"; "Member House Groups")
        {
            DataItemTableView = sorting("No. Series");
            RequestFilterFields = "No. Series";
            column(ReportForNavId_6437; 6437)
            {
            }
            column(CI_Name; CI.Name)
            {
                IncludeCaption = true;
            }
            column(CI_Address; CI.Address)
            {
                IncludeCaption = true;
            }
            column(CI_Address2; CI."Address 2")
            {
                IncludeCaption = true;
            }
            column(CI_PhoneNo; CI."Phone No.")
            {
                IncludeCaption = true;
            }
            column(CI_Picture; CI.Picture)
            {
                IncludeCaption = true;
            }
            column(CI_City; CI.City)
            {
                IncludeCaption = true;
            }
            column(DOCNAME; DOCNAME)
            {
            }
            column(CellGroupCode_MemberCellGroups; "Member House Groups"."Cell Group Code")
            {
            }
            column(CellGroupName_MemberCellGroups; "Member House Groups"."Cell Group Name")
            {
            }
            column(DateFormed_MemberCellGroups; Format("Member House Groups"."Date Formed"))
            {
            }
            column(MeetingDate_MemberCellGroups; Format("Member House Groups"."Meeting Date"))
            {
            }
            column(GroupLeader_MemberCellGroups; "Member House Groups"."Group Leader")
            {
            }
            column(GroupLeaderName_MemberCellGroups; "Member House Groups"."Group Leader Name")
            {
            }
            column(AssistantgroupLeader_MemberCellGroups; "Member House Groups"."Assistant group Leader")
            {
            }
            column(AssistantGroupName_MemberCellGroups; "Member House Groups"."Assistant Group Name")
            {
            }
            column(MeetingPlace_MemberCellGroups; "Member House Groups"."Meeting Place")
            {
            }
            column(CreatedBy_MemberCellGroups; "Member House Groups"."Created By")
            {
            }
            column(CreatedOn_MemberCellGroups; "Member House Groups"."Created On")
            {
            }
            column(NoSeries_MemberCellGroups; "Member House Groups"."No. Series")
            {
            }
            column(GroupLeaderEmail_MemberCellGroups; "Member House Groups"."Group Leader Email")
            {
            }
            column(AssistantGroupLeaderEmail_MemberCellGroups; "Member House Groups"."Assistant Group Leader Email")
            {
            }
            column(GroupSatatus_MemberCellGroups; "Member House Groups"."Group Satatus")
            {
            }
            column(GlobalDimension2Code_MemberCellGroups; "Member House Groups"."Global Dimension 2 Code")
            {
            }
            column(GroupLeaderPhoneNo_MemberCellGroups; "Member House Groups"."Group Leader Phone No")
            {
            }
            column(AssistantGroupLeaderPhoneN_MemberCellGroups; "Member House Groups"."Assistant Group Leader Phone N")
            {
            }
            column(NoofMembers_MemberCellGroups; "Member House Groups"."No of Members")
            {
            }
            column(VarNoGroupMembers; VarNoGroupMembers)
            {
            }
            column(VarExitDeposits; VarExitDeposits)
            {
            }
            column(VarExitLoans; VarExitLoans)
            {
            }
            dataitem("Members Register"; "Members Register")
            {
                DataItemLink = "Member House Group" = field("Cell Group Code");
                column(ReportForNavId_3474; 3474)
                {
                }
                column(TotalLoansOutstanding_MembersRegister; "Members Register"."Total Loans Outstanding")
                {
                }
                column(CurrentShares_MembersRegister; "Members Register"."Current Shares")
                {
                }
                column(SharesRetained_MembersRegister; "Members Register"."Shares Retained")
                {
                }
                column(No_MembersRegister; "Members Register"."No.")
                {
                }
                column(Name_MembersRegister; "Members Register".Name)
                {
                }
                column(Status_MembersRegister; "Members Register".Status)
                {
                }
                column(VarCollateralSecurity; VarCollateralSecurity)
                {
                }
                column(VarLoanRisk; VarLoanRisk)
                {
                }
                column(VarTotalArrears; VarTotalArrears * -1)
                {
                }
                column(HouseGroupStatus_MembersRegister; "Members Register"."House Group Status")
                {
                }
                column(VarMemberGuarantorshipLiability; VarMemberGuarantorshipLiability)
                {
                }
                column(NoofMonthsArrearsDeposit; "NoofMonthsArrears:Deposit")
                {
                }
                column(AmountArrearsDeposit; "AmountArrears:Deposit")
                {
                }
                column(VarTotalLoansIssued; VarTotalLoansIssued)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    VarCollateralSecurity := 0;
                    VarRepaymentPeriod := WorkDate;
                    VarArrears := 0;
                    VarTotalArrears := 0;

                    ObjLoanCollateral.Reset;
                    ObjLoanCollateral.SetRange(ObjLoanCollateral."Member No", "Members Register"."No.");
                    if ObjLoanCollateral.FindSet then begin
                        repeat

                            ObjLoans.Reset;
                            ObjLoans.SetRange(ObjLoans."Loan  No.", ObjLoanCollateral."Loan No");
                            if ObjLoans.FindSet then begin
                                ObjLoans.CalcFields(ObjLoans."Outstanding Balance");
                                if ObjLoans."Outstanding Balance" > 0 then begin
                                    VarCollateralSecurity := VarCollateralSecurity + ObjLoanCollateral."Guarantee Value";
                                end;
                            end;
                        until ObjLoanCollateral.Next = 0;
                    end;


                    ObjCust.Reset;
                    ObjCust.SetRange(ObjCust."No.", "No.");
                    if ObjCust.FindSet then begin
                        ObjCust.CalcFields(ObjCust."Total Loans Outstanding");
                        if ObjCust."Total Loans Outstanding" > VarCollateralSecurity then begin
                            VarLoanRisk := ObjCust."Total Loans Outstanding" - VarCollateralSecurity
                        end else
                            VarLoanRisk := 0;
                    end;


                    ObjLoans.Reset;
                    ObjLoans.SetRange(ObjLoans."Client Code", "No.");
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
                    VarTotalArrears := VarTotalArrears + VarArrears;

                    VarMemberGuarantorshipLiability := Sfactory.FnGetMemberLiability("Members Register"."No.");


                    //-------------------Deposit Arrears Computation------------------------------------
                    VarLastDayofPreviousMonth := 0D;
                    VarLastDayofPreviousMonth := CalcDate('-1M', WorkDate);
                    VarLastDayofPreviousMonth := CalcDate('CM', VarLastDayofPreviousMonth);

                    CalcFields("Last Deposit Contribution Date");
                    if "Last Deposit Contribution Date" <> 0D then begin
                        "NoofMonthsArrears:Deposit" := ROUND((VarLastDayofPreviousMonth - "Last Deposit Contribution Date") / 30, 1, '=');
                        if "NoofMonthsArrears:Deposit" > 0 then begin
                            "NoofMonthsArrears:Deposit" := "NoofMonthsArrears:Deposit"
                        end else
                            "NoofMonthsArrears:Deposit" := 0;


                        "Monthly Contribution" := Sfactory.FnGetMemberMonthlyContributionDepositstier("No.");
                        Modify;

                        "AmountArrears:Deposit" := "NoofMonthsArrears:Deposit" * "Monthly Contribution";
                        // END;
                    end;
                    //-------------------End Deposit Arrears Computation------------------------------------


                    VarTotalLoansIssued := 0;
                    ObjLoans.CalcFields(ObjLoans."Outstanding Balance");

                    ObjLoans.Reset;
                    ObjLoans.SetRange(ObjLoans."Client Code", "No.");
                    ObjLoans.SetRange(ObjLoans.Posted, true);
                    ObjLoans.SetFilter(ObjLoans."Outstanding Balance", '>%1', 0);
                    if ObjLoans.FindSet then begin
                        repeat
                            VarTotalLoansIssued := VarTotalLoansIssued + ObjLoans."Approved Amount";
                        until ObjLoans.Next = 0;
                    end;
                end;
            }

            trigger OnAfterGetRecord()
            begin

                DOCNAME := 'HOUSE GROUP STATEMENT';

                ObjCust.Reset;
                ObjCust.SetRange(ObjCust."Member House Group", "Cell Group Code");
                if ObjCust.FindSet then begin
                    repeat
                        VarNoGroupMembers := VarNoGroupMembers + 1;
                    until ObjCust.Next = 0;
                end;

                ObjCust.Reset;
                ObjCust.SetRange(ObjCust."Member House Group", "Cell Group Code");
                ObjCust.SetRange(ObjCust."House Group Status", ObjCust."house group status"::"Exiting the Group");
                if ObjCust.FindSet then begin
                    repeat
                        ObjCust.CalcFields(ObjCust."Current Shares", ObjCust."Total Loans Outstanding");
                        VarExitDeposits := VarExitDeposits + ObjCust."Current Shares";
                        VarExitLoans := VarExitLoans + ObjCust."Total Loans Outstanding";
                    until ObjCust.Next = 0;
                end;
            end;

            trigger OnPreDataItem()
            begin

                //LastFieldNo := FIELDNO("Member Cell Groups");
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

    trigger OnPreReport()
    begin
        CI.Get();
        CI.CalcFields(CI.Picture);
    end;

    var
        StrCopyText: Text[30];
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        DimVal: Record "Dimension Value";
        DimValName: Text[30];
        TTotal: Decimal;
        CheckReport: Report Check;
        NumberText: array[2] of Text[80];
        STotal: Decimal;
        InvoiceCurrCode: Code[10];
        CurrCode: Code[10];
        GLSetup: Record "General Ledger Setup";
        DOCNAME: Text[30];
        VATCaptionLbl: label 'VAT';
        PAYMENT_DETAILSCaptionLbl: label 'PAYMENT DETAILS';
        AMOUNTCaptionLbl: label 'AMOUNT';
        NET_AMOUNTCaptionLbl: label 'AMOUNT';
        W_TAXCaptionLbl: label 'W/TAX';
        Document_No___CaptionLbl: label 'Document No. :';
        Currency_CaptionLbl: label 'Currency:';
        Payment_To_CaptionLbl: label 'Payment To:';
        Document_Date_CaptionLbl: label 'Document Date:';
        Cheque_No__CaptionLbl: label 'Cheque No.:';
        R_CENTERCaptionLbl: label 'R.CENTER CODE';
        PROJECTCaptionLbl: label 'PROJECT CODE';
        TotalCaptionLbl: label 'Total';
        Printed_By_CaptionLbl: label 'Printed By:';
        Amount_in_wordsCaptionLbl: label 'Amount in words';
        EmptyStringCaptionLbl: label '================================================================================================================================================================================================';
        EmptyStringCaption_Control1102755013Lbl: label '================================================================================================================================================================================================';
        Amount_in_wordsCaption_Control1102755021Lbl: label 'Amount in words';
        Printed_By_Caption_Control1102755026Lbl: label 'Printed By:';
        TotalCaption_Control1102755033Lbl: label 'Total';
        Signature_CaptionLbl: label 'Signature:';
        Date_CaptionLbl: label 'Date:';
        Name_CaptionLbl: label 'Name:';
        RecipientCaptionLbl: label 'Recipient';
        CompanyInfo: Record "Company Information";
        BudgetLbl: label 'Budget';
        CreationDoc: Boolean;
        DtldVendEntry: Record "Detailed Vendor Ledg. Entry";
        InvNo: Code[20];
        InvAmt: Decimal;
        ApplyEnt: Record "Vendor Ledger Entry";
        VendEnrty: Record "Vendor Ledger Entry";
        CI: Record "Company Information";
        ObjLoanCollateral: Record "Loan Collateral Details";
        VarCollateralSecurity: Decimal;
        VarArreasAmount: Decimal;
        ObjLoans: Record "Loans Register";
        VarLoanRisk: Decimal;
        VarNoGroupMembers: Integer;
        VarGroupNetWorth: Decimal;
        ObjCust: Record "Members Register";
        VarLastMonth: Date;
        ObjRepaymentSch: Record "Loan Repayment Schedule";
        VarArrears: Decimal;
        VarDateFilter: Text;
        VarRepaymentPeriod: Date;
        VarScheduledLoanBal: Decimal;
        VarLBal: Decimal;
        VarLastMonthDate: Integer;
        VarLastMonthMonth: Integer;
        VarLastMonthYear: Integer;
        VarRepaymentDate: Date;
        VarRepayDate: Integer;
        VarTotalArrears: Decimal;
        VarExitDeposits: Decimal;
        VarExitLoans: Decimal;
        VarMemberGuarantorshipLiability: Decimal;
        Sfactory: Codeunit "SURESTEP Factory";
        "NoofMonthsArrears:Deposit": Decimal;
        "AmountArrears:Deposit": Decimal;
        VarLastDayofPreviousMonth: Date;
        VarTotalLoansIssued: Decimal;
}

