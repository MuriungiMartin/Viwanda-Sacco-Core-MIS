
Report 50507 "Staff Claim  Slip Ver1"
{
    RDLCLayout = 'Layouts/StaffClaimSlipVer1.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Staff Claims Header"; "Staff Claims Header")
        {
            CalcFields = "Total Net Amount";
            DataItemTableView = sorting("No. Series");
            RequestFilterFields = "No. Series";

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
            column(VarApproverI; VarApproverI)
            {
            }
            column(VarApproverIDate; VarApproverIDate)
            {
            }
            column(VarApproverII; VarApproverII)
            {
            }
            column(VarApproverIIDate; VarApproverIIDate)
            {
            }
            column(UserId; UserId)
            {
            }
            column(NumberText_1_; NumberText[1])
            {
            }
            column(TTotal; TTotal)
            {
            }
            column(TIME_PRINTED_____FORMAT_TIME_; 'TIME PRINTED:' + Format(Time))
            {
                AutoFormatType = 1;
            }
            column(DATE_PRINTED_____FORMAT_TODAY_0_4_; 'DATE PRINTED:' + Format(Today, 0, 4))
            {
                AutoFormatType = 1;
            }
            column(CurrCode_Control1102756010; CurrCode)
            {
            }
            column(CurrCode_Control1102756012; CurrCode)
            {
            }
            column(Approved_; 'Approved')
            {
                AutoFormatType = 1;
            }
            column(Approval_Status_____; 'Approval Status' + ':')
            {
                AutoFormatType = 1;
            }
            column(TIME_PRINTED_____FORMAT_TIME__Control1102755003; 'TIME PRINTED:' + Format(Time))
            {
                AutoFormatType = 1;
            }
            column(DATE_PRINTED_____FORMAT_TODAY_0_4__Control1102755004; 'DATE PRINTED:' + Format(Today, 0, 4))
            {
                AutoFormatType = 1;
            }
            column(USERID_Control1102755012; UserId)
            {
            }
            column(NumberText_1__Control1102755016; NumberText[1])
            {
            }
            column(CompanyInfoName; CompanyInfo.Name)
            {
            }
            column(CompanyInfoAddress; CompanyInfo.Address)
            {
            }
            column(CompanyInfoAddress2; CompanyInfo."Address 2")
            {
            }
            column(CompanyInfoPic; CompanyInfo.Picture)
            {
            }
            column(No_StaffClaimsHeader; "Staff Claims Header"."No.")
            {
            }
            column(Date_StaffClaimsHeader; Format("Staff Claims Header".Date, 0, '<Day,2> <Month Text,3> <Year4>'))
            {
            }
            column(CurrencyFactor_StaffClaimsHeader; "Staff Claims Header"."Currency Factor")
            {
            }
            column(CurrencyCode_StaffClaimsHeader; "Staff Claims Header"."Currency Code")
            {
            }
            column(Payee; "Staff Claims Header".Payee)
            {
            }
            column(OnBehalfOf_StaffClaimsHeader; "Staff Claims Header"."On Behalf Of")
            {
            }
            column(Cashier_StaffClaimsHeader; "Staff Claims Header".Cashier)
            {
            }
            column(Posted_StaffClaimsHeader; "Staff Claims Header".Posted)
            {
            }
            column(DatePosted_StaffClaimsHeader; Format("Staff Claims Header"."Date Posted", 0, '<Day,2> <Month Text,3> <Year4>'))
            {
            }
            column(TimePosted_StaffClaimsHeader; "Staff Claims Header"."Time Posted")
            {
            }
            column(PostedBy_StaffClaimsHeader; "Staff Claims Header"."Posted By")
            {
            }
            column(TotalPaymentAmount_StaffClaimsHeader; "Staff Claims Header"."Total Payment Amount")
            {
            }
            column(PayingType_StaffClaimsHeader; "Staff Claims Header"."Paying Type")
            {
            }
            column(PayingBankAccount_StaffClaimsHeader; "Staff Claims Header"."Paying Bank Account")
            {
            }
            column(GlobalDimension1Code_StaffClaimsHeader; "Staff Claims Header"."Global Dimension 1 Code")
            {
            }
            column(Status_StaffClaimsHeader; "Staff Claims Header".Status)
            {
            }
            column(PaymentType_StaffClaimsHeader; "Staff Claims Header"."Payment Type")
            {
            }
            column(ShortcutDimension2Code_StaffClaimsHeader; "Staff Claims Header"."Shortcut Dimension 2 Code")
            {
            }
            column(FunctionName_StaffClaimsHeader; "Staff Claims Header"."Function Name")
            {
            }
            column(BudgetCenterName_StaffClaimsHeader; "Staff Claims Header"."Budget Center Name")
            {
            }
            column(BankName_StaffClaimsHeader; "Staff Claims Header"."Bank Name")
            {
            }
            column(NoSeries_StaffClaimsHeader; "Staff Claims Header"."No. Series")
            {
            }
            column(Select_StaffClaimsHeader; "Staff Claims Header".Select)
            {
            }
            column(TotalVATAmount_StaffClaimsHeader; "Staff Claims Header"."Total VAT Amount")
            {
            }
            column(TotalWitholdingTaxAmount_StaffClaimsHeader; "Staff Claims Header"."Total Witholding Tax Amount")
            {
            }
            column(TotalNetAmount_StaffClaimsHeader; "Staff Claims Header"."Total Net Amount")
            {
            }
            column(CurrentStatus_StaffClaimsHeader; "Staff Claims Header"."Current Status")
            {
            }
            column(ChequeNo_StaffClaimsHeader; "Staff Claims Header"."Cheque No.")
            {
            }
            column(PayMode_StaffClaimsHeader; "Staff Claims Header"."Pay Mode")
            {
            }
            column(PaymentReleaseDate_StaffClaimsHeader; Format("Staff Claims Header"."Payment Release Date", 0, '<Day,2> <Month Text,3> <Year4>'))
            {
            }
            column(NoPrinted_StaffClaimsHeader; "Staff Claims Header"."No. Printed")
            {
            }
            column(VATBaseAmount_StaffClaimsHeader; "Staff Claims Header"."VAT Base Amount")
            {
            }
            column(ExchangeRate_StaffClaimsHeader; "Staff Claims Header"."Exchange Rate")
            {
            }
            column(CurrencyReciprical_StaffClaimsHeader; "Staff Claims Header"."Currency Reciprical")
            {
            }
            column(CurrentSourceACBal_StaffClaimsHeader; "Staff Claims Header"."Current Source A/C Bal.")
            {
            }
            column(CancellationRemarks_StaffClaimsHeader; "Staff Claims Header"."Cancellation Remarks")
            {
            }
            column(RegisterNumber_StaffClaimsHeader; "Staff Claims Header"."Register Number")
            {
            }
            column(FromEntryNo_StaffClaimsHeader; "Staff Claims Header"."From Entry No.")
            {
            }
            column(ToEntryNo_StaffClaimsHeader; "Staff Claims Header"."To Entry No.")
            {
            }
            column(InvoiceCurrencyCode_StaffClaimsHeader; "Staff Claims Header"."Invoice Currency Code")
            {
            }
            column(TotalNetAmountLCY_StaffClaimsHeader; "Staff Claims Header"."Total Net Amount LCY")
            {
            }
            column(DocumentType_StaffClaimsHeader; "Staff Claims Header"."Document Type")
            {
            }
            column(ShortcutDimension3Code_StaffClaimsHeader; "Staff Claims Header"."Shortcut Dimension 3 Code")
            {
            }
            column(ShortcutDimension4Code_StaffClaimsHeader; "Staff Claims Header"."Shortcut Dimension 4 Code")
            {
            }
            column(Dim3_StaffClaimsHeader; "Staff Claims Header".Dim3)
            {
            }
            column(Dim4_StaffClaimsHeader; "Staff Claims Header".Dim4)
            {
            }
            column(ResponsibilityCenter_StaffClaimsHeader; "Staff Claims Header"."Responsibility Center")
            {
            }
            column(AccountType_StaffClaimsHeader; "Staff Claims Header"."Account Type")
            {
            }
            column(AccountNo_StaffClaimsHeader; "Staff Claims Header"."Account No.")
            {
            }
            column(SurrenderStatus_StaffClaimsHeader; "Staff Claims Header"."Surrender Status")
            {
            }
            column(Purpose_StaffClaimsHeader; "Staff Claims Header".Purpose)
            {
            }
            column(ExternalDocumentNo_StaffClaimsHeader; "Staff Claims Header"."External Document No")
            {
            }
            column(CreationDocNo_StaffClaimsHeader; "Staff Claims Header"."Creation Doc No")
            {
            }
            column(DimensionSetID_StaffClaimsHeader; "Staff Claims Header"."Dimension Set ID")
            {
            }
            dataitem("Staff Claim Lines"; "Staff Claim Lines")
            {
                DataItemLink = No = field("No.");

                column(No_StaffClaimLines; "Staff Claim Lines".No)
                {
                }
                column(AccountNo_StaffClaimLines; "Staff Claim Lines"."Account No:")
                {
                }
                column(AccountName_StaffClaimLines; "Staff Claim Lines"."Account Name")
                {
                }
                column(Amount_StaffClaimLines; "Staff Claim Lines".Amount)
                {
                }
                column(DueDate_StaffClaimLines; "Staff Claim Lines"."Due Date")
                {
                }
                column(ImprestHolder_StaffClaimLines; "Staff Claim Lines"."Imprest Holder")
                {
                }
                column(ActualSpent_StaffClaimLines; "Staff Claim Lines"."Actual Spent")
                {
                }
                column(GlobalDimension1Code_StaffClaimLines; "Staff Claim Lines"."Global Dimension 1 Code")
                {
                }
                column(Applyto_StaffClaimLines; "Staff Claim Lines"."Apply to")
                {
                }
                column(ApplytoID_StaffClaimLines; "Staff Claim Lines"."Apply to ID")
                {
                }
                column(SurrenderDate_StaffClaimLines; "Staff Claim Lines"."Surrender Date")
                {
                }
                column(Surrendered_StaffClaimLines; "Staff Claim Lines".Surrendered)
                {
                }
                column(MRNo_StaffClaimLines; "Staff Claim Lines"."M.R. No")
                {
                }
                column(DateIssued_StaffClaimLines; "Staff Claim Lines"."Date Issued")
                {
                }
                column(TypeofSurrender_StaffClaimLines; "Staff Claim Lines"."Type of Surrender")
                {
                }
                column(DeptVchNo_StaffClaimLines; "Staff Claim Lines"."Dept. Vch. No.")
                {
                }
                column(CashSurrenderAmt_StaffClaimLines; "Staff Claim Lines"."Cash Surrender Amt")
                {
                }
                column(BankPettyCash_StaffClaimLines; "Staff Claim Lines"."Bank/Petty Cash")
                {
                }
                column(SurrenderDocNo_StaffClaimLines; "Staff Claim Lines"."Surrender Doc No.")
                {
                }
                column(DateTaken_StaffClaimLines; "Staff Claim Lines"."Date Taken")
                {
                }
                column(Purpose_StaffClaimLines; "Staff Claim Lines".Purpose)
                {
                }
                column(ShortcutDimension2Code_StaffClaimLines; "Staff Claim Lines"."Shortcut Dimension 2 Code")
                {
                }
                column(BudgetaryControlAC_StaffClaimLines; "Staff Claim Lines"."Budgetary Control A/C")
                {
                }
                column(ShortcutDimension3Code_StaffClaimLines; "Staff Claim Lines"."Shortcut Dimension 3 Code")
                {
                }
                column(ShortcutDimension4Code_StaffClaimLines; "Staff Claim Lines"."Shortcut Dimension 4 Code")
                {
                }
                column(Committed_StaffClaimLines; "Staff Claim Lines".Committed)
                {
                }
                column(AdvanceType_StaffClaimLines; "Staff Claim Lines"."Advance Type")
                {
                }
                column(CurrencyFactor_StaffClaimLines; "Staff Claim Lines"."Currency Factor")
                {
                }
                column(CurrencyCode_StaffClaimLines; "Staff Claim Lines"."Currency Code")
                {
                }
                column(AmountLCY_StaffClaimLines; "Staff Claim Lines"."Amount LCY")
                {
                }
                column(LineNo_StaffClaimLines; "Staff Claim Lines"."Line No.")
                {
                }
                column(ClaimReceiptNo_StaffClaimLines; "Staff Claim Lines"."Claim Receipt No")
                {
                }
                column(ExpenditureDate_StaffClaimLines; "Staff Claim Lines"."Expenditure Date")
                {
                }
                column(AttendeeOrganizationNames_StaffClaimLines; "Staff Claim Lines"."Attendee/Organization Names")
                {
                }
                column(Grouping_StaffClaimLines; "Staff Claim Lines".Grouping)
                {
                }
                column(DimensionSetID_StaffClaimLines; "Staff Claim Lines"."Dimension Set ID")
                {
                }
                column(AccountType_StaffClaimLines; "Staff Claim Lines"."Account Type")
                {
                }
                column(AccountNo_StaffClaimLinesII; "Staff Claim Lines"."Account No.")
                {
                }
            }
            trigger OnAfterGetRecord();
            begin
                DOCNAME := 'INTERNAL PAYMENT VOUCHER SLIP';
                ObjApprovalEntry.Reset;
                ObjApprovalEntry.SetRange(ObjApprovalEntry."Document No.", "No.");
                ObjApprovalEntry.SetRange(ObjApprovalEntry.Status, ObjApprovalEntry.Status::Approved);
                if ObjApprovalEntry.FindFirst then begin
                    VarApproverI := ObjApprovalEntry."First Modified By User ID";
                    VarApproverIDate := Format(ObjApprovalEntry."First Modified On", 0, '<Day,2> <Month Text,3> <Year4>');
                end;
                ObjApprovalEntry.Reset;
                ObjApprovalEntry.SetRange(ObjApprovalEntry."Document No.", "No.");
                ObjApprovalEntry.SetRange(ObjApprovalEntry.Status, ObjApprovalEntry.Status::Approved);
                if ObjApprovalEntry.FindLast then begin
                    VarApproverII := ObjApprovalEntry."Last Modified By User ID";
                    VarApproverIIDate := Format(ObjApprovalEntry."Last Date-Time Modified", 0, '<Day,2> <Month Text,3> <Year4>');
                end;
                CalcFields("Staff Claims Header"."Total Net Amount");
                CheckReport.InitTextVariable();
                CheckReport.FormatNoText(NumberText, ("Staff Claims Header"."Total Net Amount"), '');
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
                group(Options)
                {
                    Caption = 'Options';

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
        CI.Get();
        CI.CalcFields(CI.Picture);
        ;

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
        ObjApprovalEntry: Record "Approval Entry";
        VarApproverI: Code[20];
        VarApproverIDate: Text;
        VarApproverII: Code[20];
        VarApproverIIDate: Text;


    var
}