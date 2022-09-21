#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
//51516877_v6_3_0_2259) { }
// Autogenerated code - do not delete or modify -->

Report 50877 "Inward Cheque Processing Ver1"
{
    RDLCLayout = 'Layouts/InwardChequeProcessingVer1.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Cheque Receipts-Family"; "Cheque Receipts-Family")
        {
            DataItemTableView = sorting("No. Series");
            RequestFilterFields = "No. Series";
            column(ReportForNavId_6437; 6437) { } // Autogenerated by ForNav - Do not delete
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
            column(No_ChequeReceiptsFamily; "Cheque Receipts-Family"."No.")
            {
            }
            column(TransactionDate_ChequeReceiptsFamily; Format("Cheque Receipts-Family"."Transaction Date", 0, '<Day,2> <Month Text,3> <Year4>'))
            {
            }
            column(RefferenceDocument_ChequeReceiptsFamily; "Cheque Receipts-Family"."Refference Document")
            {
            }
            column(TransactionTime_ChequeReceiptsFamily; Format("Cheque Receipts-Family"."Transaction Time"))
            {
            }
            column(CreatedBy_ChequeReceiptsFamily; "Cheque Receipts-Family"."Created By")
            {
            }
            column(PostedBy_ChequeReceiptsFamily; "Cheque Receipts-Family"."Posted By")
            {
            }
            column(Posted_ChequeReceiptsFamily; "Cheque Receipts-Family".Posted)
            {
            }
            column(NoSeries_ChequeReceiptsFamily; "Cheque Receipts-Family"."No. Series")
            {
            }
            column(UnpaidBy_ChequeReceiptsFamily; "Cheque Receipts-Family"."Unpaid By")
            {
            }
            column(Unpaid_ChequeReceiptsFamily; "Cheque Receipts-Family".Unpaid)
            {
            }
            column(Imported_ChequeReceiptsFamily; "Cheque Receipts-Family".Imported)
            {
            }
            column(Processed_ChequeReceiptsFamily; "Cheque Receipts-Family".Processed)
            {
            }
            column(DocumentName_ChequeReceiptsFamily; "Cheque Receipts-Family"."Document Name")
            {
            }
            column(BankAccount_ChequeReceiptsFamily; "Cheque Receipts-Family"."Bank Account")
            {
            }
            column(Status_ChequeReceiptsFamily; "Cheque Receipts-Family".Status)
            {
            }
            column(Closed_ChequeReceiptsFamily; "Cheque Receipts-Family".Closed)
            {
            }
            dataitem("Cheque Issue Lines-Family"; "Cheque Issue Lines-Family")
            {
                DataItemLink = "Header No" = field("No.");
                column(ReportForNavId_3474; 3474) { } // Autogenerated by ForNav - Do not delete
                column(ChqReceiptNo_ChequeIssueLinesFamily; "Cheque Issue Lines-Family"."Chq Receipt No")
                {
                }
                column(ChequeSerialNo_ChequeIssueLinesFamily; "Cheque Issue Lines-Family"."Cheque Serial No")
                {
                }
                column(AccountNo_ChequeIssueLinesFamily; "Cheque Issue Lines-Family"."Account No.")
                {
                }
                column(DateRefferenceNo_ChequeIssueLinesFamily; "Cheque Issue Lines-Family"."Date _Refference No.")
                {
                }
                column(TransactionCode_ChequeIssueLinesFamily; "Cheque Issue Lines-Family"."Transaction Code")
                {
                }
                column(BranchCode_ChequeIssueLinesFamily; "Cheque Issue Lines-Family"."Branch Code")
                {
                }
                column(Currency_ChequeIssueLinesFamily; "Cheque Issue Lines-Family".Currency)
                {
                }
                column(Amount_ChequeIssueLinesFamily; "Cheque Issue Lines-Family".Amount)
                {
                }
                column(Date1_ChequeIssueLinesFamily; "Cheque Issue Lines-Family"."Date-1")
                {
                }
                column(Date2_ChequeIssueLinesFamily; "Cheque Issue Lines-Family"."Date-2")
                {
                }
                column(FamilyRoutingNo_ChequeIssueLinesFamily; "Cheque Issue Lines-Family"."Family Routing No.")
                {
                }
                column(Fillers_ChequeIssueLinesFamily; "Cheque Issue Lines-Family".Fillers)
                {
                }
                column(TransactionRefference_ChequeIssueLinesFamily; "Cheque Issue Lines-Family"."Transaction Refference")
                {
                }
                column(AccountName_ChequeIssueLinesFamily; "Cheque Issue Lines-Family"."Account Name")
                {
                }
                column(UnpayCode_ChequeIssueLinesFamily; "Cheque Issue Lines-Family"."Un pay Code")
                {
                }
                column(Interpretation_ChequeIssueLinesFamily; "Cheque Issue Lines-Family".Interpretation)
                {
                }
                column(FamilyAccountNo_ChequeIssueLinesFamily; "Cheque Issue Lines-Family"."Family Account No.")
                {
                }
                column(UnPayChargeAmount_ChequeIssueLinesFamily; "Cheque Issue Lines-Family"."Un Pay Charge Amount")
                {
                }
                column(UnpayDate_ChequeIssueLinesFamily; "Cheque Issue Lines-Family"."Unpay Date")
                {
                }
                column(Status_ChequeIssueLinesFamily; "Cheque Issue Lines-Family".Status)
                {
                }
                column(ChequeNo_ChequeIssueLinesFamily; "Cheque Issue Lines-Family"."Cheque No")
                {
                }
                column(HeaderNo_ChequeIssueLinesFamily; "Cheque Issue Lines-Family"."Header No")
                {
                }
                column(AccountBalance_ChequeIssueLinesFamily; "Cheque Issue Lines-Family"."Account Balance")
                {
                }
                column(FrontImage_ChequeIssueLinesFamily; "Cheque Issue Lines-Family".FrontImage)
                {
                }
                column(FrontGrayImage_ChequeIssueLinesFamily; "Cheque Issue Lines-Family".FrontGrayImage)
                {
                }
                column(BackImages_ChequeIssueLinesFamily; "Cheque Issue Lines-Family".BackImages)
                {
                }
                column(VerificationStatus_ChequeIssueLinesFamily; "Cheque Issue Lines-Family"."Verification Status")
                {
                }
                column(Processed_ChequeIssueLinesFamily; "Cheque Issue Lines-Family".Processed)
                {
                }
                column(TransactionDate_ChequeIssueLinesFamily; "Cheque Issue Lines-Family"."Transaction Date")
                {
                }
                column(MemberBranch_ChequeIssueLinesFamily; "Cheque Issue Lines-Family"."Member Branch")
                {
                }
                column(UnpayUserId_ChequeIssueLinesFamily; "Cheque Issue Lines-Family"."Un pay User Id")
                {
                }
                column(ChargeAmount_ChequeIssueLinesFamily; "Cheque Issue Lines-Family"."Charge Amount")
                {
                }
                column(ChargeAmountSaccoIncome_ChequeIssueLinesFamily; "Cheque Issue Lines-Family"."Charge Amount Sacco Income")
                {
                }
                column(ChargeUnpaySaccoIncome_ChequeIssueLinesFamily; "Cheque Issue Lines-Family"."Charge Unpay Sacco Income")
                {
                }
                column(VarPayStatus; VarPayStatus)
                {
                }
                trigger OnAfterGetRecord();
                begin
                    if "Cheque Issue Lines-Family"."Un pay Code" = '' then
                        VarPayStatus := Varpaystatus::Paid
                    else
                        VarPayStatus := Varpaystatus::Upaid;
                end;

            }
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
            //:= false;
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
        VarPayStatus: Option Paid,Upaid;

    // --> Reports ForNAV Autogenerated code - do not delete or modify
    //51516877_v6_3_0_2259;






    // Reports ForNAV Autogenerated code - do not delete or modify -->
}
