#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
//51516875_v6_3_0_2259) { }
// Autogenerated code - do not delete or modify -->

Report 50875 "Internal PV  Slip Ver1"
{
    RDLCLayout = 'Layouts/InternalPVSlipVer1.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Internal PV Header"; "Internal PV Header")
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
            column(No_InternalPVHeader; "Internal PV Header".No)
            {
            }
            column(NoSeries_InternalPVHeader; "Internal PV Header"."No. Series")
            {
            }
            column(Posted_InternalPVHeader; "Internal PV Header".Posted)
            {
            }
            column(DatePosted_InternalPVHeader; Format("Internal PV Header"."Date Posted", 0, '<Day,2> <Month Text,3> <Year4>'))
            {
            }
            column(TimePosted_InternalPVHeader; Format("Internal PV Header"."Time Posted"))
            {
            }
            column(PostedBy_InternalPVHeader; "Internal PV Header"."Posted By")
            {
            }
            column(DateEntered_InternalPVHeader; Format("Internal PV Header"."Date Entered", 0, '<Day,2> <Month Text,3> <Year4>'))
            {
            }
            column(TimeEntered_InternalPVHeader; "Internal PV Header"."Time Entered")
            {
            }
            column(EnteredBy_InternalPVHeader; "Internal PV Header"."Entered By")
            {
            }
            column(TransactionDescription_InternalPVHeader; "Internal PV Header"."Transaction Description")
            {
            }
            column(TotalDebits_InternalPVHeader; "Internal PV Header"."Total Debits")
            {
            }
            column(TotalCount_InternalPVHeader; "Internal PV Header"."Total Count")
            {
            }
            column(TotalCredits_InternalPVHeader; "Internal PV Header"."Total Credits")
            {
            }
            column(Status_InternalPVHeader; "Internal PV Header".Status)
            {
            }
            column(ChequeNo_InternalPVHeader; "Internal PV Header"."Cheque No")
            {
            }
            column(GlobalDimension1Code_InternalPVHeader; "Internal PV Header"."Global Dimension 1 Code")
            {
            }
            column(GlobalDimension2Code_InternalPVHeader; "Internal PV Header"."Global Dimension 2 Code")
            {
            }
            dataitem("Internal PV Lines"; "Internal PV Lines")
            {
                DataItemLink = "Header No" = field(No);
                column(ReportForNavId_3474; 3474) { } // Autogenerated by ForNav - Do not delete
                column(No_InternalPVLines; "Internal PV Lines".No)
                {
                }
                column(Type_InternalPVLines; "Internal PV Lines".Type)
                {
                }
                column(AccountType_InternalPVLines; "Internal PV Lines"."Account Type")
                {
                }
                column(AccountNo_InternalPVLines; "Internal PV Lines"."Account No.")
                {
                }
                column(Description_InternalPVLines; "Internal PV Lines".Description)
                {
                }
                column(CreditAmount_InternalPVLines; "Internal PV Lines"."Credit Amount")
                {
                }
                column(DebitAmount_InternalPVLines; "Internal PV Lines"."Debit Amount")
                {
                }
                column(Amount_InternalPVLines; "Internal PV Lines".Amount)
                {
                }
                column(AccountName_InternalPVLines; "Internal PV Lines"."Account Name")
                {
                }
                column(HeaderNo_InternalPVLines; "Internal PV Lines"."Header No")
                {
                }
            }
            trigger OnAfterGetRecord();
            begin
                DOCNAME := 'INTERNAL PAYMENT VOUCHER SLIP';
                ObjApprovalEntry.Reset;
                ObjApprovalEntry.SetRange(ObjApprovalEntry."Document No.", No);
                ObjApprovalEntry.SetRange(ObjApprovalEntry.Status, ObjApprovalEntry.Status::Approved);
                if ObjApprovalEntry.FindFirst then begin
                    VarApproverI := ObjApprovalEntry."First Modified By User ID";
                    VarApproverIDate := Format(ObjApprovalEntry."First Modified On", 0, '<Day,2> <Month Text,3> <Year4>');
                end;
                ObjApprovalEntry.Reset;
                ObjApprovalEntry.SetRange(ObjApprovalEntry."Document No.", No);
                ObjApprovalEntry.SetRange(ObjApprovalEntry.Status, ObjApprovalEntry.Status::Approved);
                if ObjApprovalEntry.FindLast then begin
                    VarApproverII := ObjApprovalEntry."Last Modified By User ID";
                    VarApproverIIDate := Format(ObjApprovalEntry."Last Date-Time Modified", 0, '<Day,2> <Month Text,3> <Year4>');
                end;
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

    // --> Reports ForNAV Autogenerated code - do not delete or modify
    //51516875_v6_3_0_2259;






    // Reports ForNAV Autogenerated code - do not delete or modify -->
}
