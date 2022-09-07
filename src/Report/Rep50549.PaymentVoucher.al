
Report 50549 "Payment Voucher."
{
    RDLCLayout = 'Layouts/PaymentVoucher..rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Payment Header."; "Payment Header.")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.";

            column(DOCNAME; DOCNAME)
            {
            }
            column(Payments_Header__No__; "Payment Header."."No.")
            {
            }
            column(CurrCode; CurrCode)
            {
            }
            column(StrCopyText; StrCopyText)
            {
            }
            column(Payments_Header__Cheque_No__; "Payment Header."."Cheque No")
            {
            }
            column(Payments_Header_Payee; "Payment Header.".Payee)
            {
            }
            column(PMODE; "Payment Header."."Pay Mode")
            {
            }
            column(Payments_Header__Payments_Header__Date; "Payment Header.".Date)
            {
            }
            column(Payments_Header__Global_Dimension_1_Code_; "Payment Header."."Global Dimension 1 Code")
            {
            }
            column(Payments_Header__Shortcut_Dimension_2_Code_; "Payment Header."."Global Dimension 2 Code")
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
            column(Tell; "Payment Header.".Cashier)
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
            column(TTotal_Control1102755034; TTotal)
            {
            }
            column(Bname; "Payment Header."."Bank Account Name")
            {
            }
            column(CurrCode_Control1102755035; CurrCode)
            {
            }
            column(CurrCode_Control1102755037; CurrCode)
            {
            }
            column(VATCaption; VATCaptionLbl)
            {
            }
            column(PAYMENT_DETAILSCaption; PAYMENT_DETAILSCaptionLbl)
            {
            }
            column(AMOUNTCaption; AMOUNTCaptionLbl)
            {
            }
            column(NET_AMOUNTCaption; NET_AMOUNTCaptionLbl)
            {
            }
            column(W_TAXCaption; W_TAXCaptionLbl)
            {
            }
            column(Document_No___Caption; Document_No___CaptionLbl)
            {
            }
            column(Currency_Caption; Currency_CaptionLbl)
            {
            }
            column(Payment_To_Caption; Payment_To_CaptionLbl)
            {
            }
            column(Document_Date_Caption; Document_Date_CaptionLbl)
            {
            }
            column(Cheque_No__Caption; Cheque_No__CaptionLbl)
            {
            }
            column(Payments_Header__Global_Dimension_1_Code_Caption; FieldCaption("Global Dimension 1 Code"))
            {
            }
            column(Payments_Header__Shortcut_Dimension_2_Code_Caption; FieldCaption("Global Dimension 2 Code"))
            {
            }
            column(R_CENTERCaption; R_CENTERCaptionLbl)
            {
            }
            column(PROJECTCaption; PROJECTCaptionLbl)
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }
            column(Printed_By_Caption; Printed_By_CaptionLbl)
            {
            }
            column(Amount_in_wordsCaption; Amount_in_wordsCaptionLbl)
            {
            }
            column(EmptyStringCaption; EmptyStringCaptionLbl)
            {
            }
            column(EmptyStringCaption_Control1102755013; EmptyStringCaption_Control1102755013Lbl)
            {
            }
            column(Amount_in_wordsCaption_Control1102755021; Amount_in_wordsCaption_Control1102755021Lbl)
            {
            }
            column(Printed_By_Caption_Control1102755026; Printed_By_Caption_Control1102755026Lbl)
            {
            }
            column(TotalCaption_Control1102755033; TotalCaption_Control1102755033Lbl)
            {
            }
            column(Signature_Caption; Signature_CaptionLbl)
            {
            }
            column(Date_Caption; Date_CaptionLbl)
            {
            }
            column(Name_Caption; Name_CaptionLbl)
            {
            }
            column(RecipientCaption; RecipientCaptionLbl)
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
            column(Bank; "Payment Header."."Bank Account")
            {
                IncludeCaption = true;
            }
            column(BankName; "Payment Header."."Bank Account Name")
            {
                IncludeCaption = true;
            }
            column(PayMode; "Payment Header."."Payment Mode")
            {
                IncludeCaption = true;
            }
            column(CreationDocNo_PaymentsHeader; "Payment Header."."No.")
            {
            }
            column(CreationDoc; CreationDoc)
            {
            }
            column(PVNOS; "Payment Header."."Manual No")
            {
            }
            dataitem("Vendor Ledger Entry"; "Vendor Ledger Entry")
            {
                DataItemLink = "Applies-to ID" = field("No.");

                column(DocNo; "Vendor Ledger Entry"."Document No.")
                {
                }
                column(Amt; "Vendor Ledger Entry"."Amount (LCY)")
                {
                }
                trigger OnAfterGetRecord();
                begin
                    "Vendor Ledger Entry"."Amount (LCY)" := -("Vendor Ledger Entry"."Amount (LCY)")
                end;

            }
            dataitem("Payment Line."; "Payment Line.")
            {
                DataItemLink = No = field("No.");
                DataItemTableView = sorting("Line No.", No, Type) order(ascending);
                column(Payment_Line__Net_Amount__; "Payment Line."."Net Amount")
                {
                }
                column(Payment_Line_Amount; "Payment Line.".Amount)
                {
                }
                column(Transaction_Name_______Account_No________Account_Name_____; "Transaction Name" + '[' + "Account No." + ':' + "Account Name" + ']')
                {
                }
                column(AccountNo_PaymentLine; "Payment Line."."Account No.")
                {
                }
                column(AccountName_PaymentLine; "Payment Line."."Account Name")
                {
                }
                column(Payment_remarks; "Payment Line.".Remarks)
                {
                }
                column(Payment_Line__Withholding_Tax_Amount_; "Payment Line."."Withholding Tax Amount")
                {
                }
                column(Payment_Line__VAT_Amount_; "Payment Line."."VAT Amount")
                {
                }
                column(Payment_Line__Global_Dimension_1_Code_; "Payment Line."."Global Dimension 1 Code")
                {
                }
                column(Payment_Line__Shortcut_Dimension_2_Code_; "Payment Line."."Shortcut Dimension 2 Code")
                {
                }
                column(Payment_Line_Line_No_; "Payment Line."."Line No.")
                {
                }
                column(Payment_Line_No; "Payment Line.".No)
                {
                }
                column(Payment_Line_Type; "Payment Line.".Type)
                {
                }
                column(InvNum; InvNo)
                {
                }
                column(InvAmt; InvAmt)
                {
                }
                column(TTotal2; TTotal)
                {
                }
                trigger OnAfterGetRecord();
                begin
                    DimVal.Reset;
                    DimVal.SetRange(DimVal."Dimension Code", 'DEPARTMENT');
                    DimVal.SetRange(DimVal.Code, "Shortcut Dimension 2 Code");
                    DimValName := '';
                    if DimVal.FindFirst then begin
                        DimValName := DimVal.Name;
                    end;
                    TTotal := TTotal + "Net Amount";
                    //IF "Payment Line".COUNT>1 THEN CurrReport.SKIP;
                end;

            }
            dataitem(Total; Integer)
            {
                DataItemTableView = sorting(Number) order(ascending) where(Number = const(1));
                trigger OnAfterGetRecord();
                begin
                    /*CheckReport.InitTextVariable();
					CheckReport.FormatNoText(NumberText,TTotal,'');*/

                end;

            }
            dataitem(Summary; "Supervisors Approval Levels")
            {
                DataItemLink = "Supervisor ID" = field("No.");
                trigger OnAfterGetRecord();
                begin
                    DimVal.Reset;
                    DimVal.SetRange(DimVal."Dimension Code", 'Branch');
                    //DimVal.SETRANGE(DimVal.Code,"Global Dimension 2 Code");
                    DimValName := '';
                    if DimVal.FindFirst then begin
                        DimValName := DimVal.Name;
                    end;
                    //Hazina STotal:=STotal + "Amount";
                end;

            }
            dataitem(Integer; Integer)
            {
                DataItemTableView = sorting(Number) order(ascending) where(Number = const(1));

            }
            dataitem("CshMgt Application"; "CshMgt Application")
            {
                DataItemLink = "Document No." = field("No.");
                DataItemTableView = sorting("Line Number") order(ascending) where("Document Type" = const(PV));

            }
            dataitem("Approval Entry"; "Approval Entry")
            {
                DataItemLink = "Document No." = field("No.");
                DataItemTableView = where(Status = const(Approved));

                column(SequenceNo_ApprovalEntry; "Approval Entry"."Sequence No.")
                {
                }
                column(LastDateTimeModified_ApprovalEntry; "Approval Entry"."Last Date-Time Modified")
                {
                }
                column(ApproverID_ApprovalEntry; "Approval Entry"."Approver ID")
                {
                }
                column(SenderID_ApprovalEntry; "Approval Entry"."Sender ID")
                {
                }
            }
            dataitem(CreationApprovalEntry; "Approval Entry")
            {
                DataItemLink = "Document No." = field("No.");
                DataItemTableView = where(Status = const(Approved));

                column(SequenceNo_CreationApprovalEntry; CreationApprovalEntry."Sequence No.")
                {
                }
                column(SenderID_CreationApprovalEntry; CreationApprovalEntry."Sender ID")
                {
                }
                column(ApproverID_CreationApprovalEntry; CreationApprovalEntry."Approver ID")
                {
                }
                column(DateTimeSentforApproval_CreationApprovalEntry; CreationApprovalEntry."Date-Time Sent for Approval")
                {
                }
                column(LastDateTimeModified_CreationApprovalEntry; CreationApprovalEntry."Last Date-Time Modified")
                {
                }
                trigger OnAfterGetRecord();
                begin
                    //message('%1 %2',CreationApprovalEntry."Document No.",CreationApprovalEntry."Approver ID");
                end;

            }
            trigger OnPreDataItem();
            begin
                LastFieldNo := FieldNo("No.");
            end;

            trigger OnAfterGetRecord();
            begin
                VendEnrty.Reset;
                VendEnrty.SetRange(VendEnrty."Applies-to ID", "Payment Header."."No.");
                if VendEnrty.Find('-') then begin
                    repeat
                        VendEnrty."Document No." := VendEnrty."Document No.";
                        VendEnrty."Applies-to ID" := VendEnrty."Applies-to ID";
                        VendEnrty.Modify;
                    until VendEnrty.Next = 0;
                end;
                StrCopyText := '';
                if "No. Printed" >= 1 then begin
                    StrCopyText := 'DUPLICATE';
                end;
                TTotal := 0;
                if "Payment Type" <> "payment type"::"Petty Cash" then
                    DOCNAME := 'PAYMENT VOUCHER'
                else
                    DOCNAME := 'PETTY CASH VOUCHER';
                //Set currcode to Default if blank
                GLSetup.Get();
                if "Currency Code" = '' then begin
                    CurrCode := GLSetup."LCY Code";
                end else
                    CurrCode := "Currency Code";
                //For Inv Curr Code
                if InvoiceCurrCode = '' then begin
                    InvoiceCurrCode := GLSetup."LCY Code";
                end else
                    InvoiceCurrCode := InvoiceCurrCode;
                //End;
                CalcFields("Net Amount", "WithHolding Tax Amount");
                CheckReport.InitTextVariable();
                CheckReport.FormatNoText(NumberText, ("Net Amount" - "WithHolding Tax Amount"), '');
                if "No." = '' then
                    CreationDoc := false
                else
                    CreationDoc := true;
            end;

            trigger OnPostDataItem();
            begin
                if CurrReport.Preview = false then begin
                    "No. Printed" := "No. Printed" + 1;
                    Modify;
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
        CompanyInfo.Get;
        CompanyInfo.CalcFields(Picture);
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

    var
}