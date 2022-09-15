#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings

Report 50487 "Loans Register - Board(FOSA)"
{
    RDLCLayout = 'Layouts/LoansRegister-Board(FOSA).rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem(Loans2; "Loans Register")
        {
            DataItemTableView = where(Source = filter(BOSA));
            PrintOnlyIfDetail = false;
            RequestFilterFields = "Issued Date", "Loan Product Type";

            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }

            column(UserId; UserId)
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
            column(Verified_By__________________________________________________Caption; Verified_By__________________________________________________CaptionLbl)
            {
            }
            column(Confirmed_By__________________________________________________Caption; Confirmed_By__________________________________________________CaptionLbl)
            {
            }
            column(Sign________________________Caption; Sign________________________CaptionLbl)
            {
            }
            column(Sign________________________Caption_Control1102755003; Sign________________________Caption_Control1102755003Lbl)
            {
            }
            column(Date________________________Caption; Date________________________CaptionLbl)
            {
            }
            column(Date________________________Caption_Control1102755005; Date________________________Caption_Control1102755005Lbl)
            {
            }
            column(NameCreditOff; NameCreditOff)
            {
            }
            column(NameCreditDate; NameCreditDate)
            {
            }
            column(NameCreditSign; NameCreditSign)
            {
            }
            column(NameCreditMNG; NameCreditMNG)
            {
            }
            column(NameCreditMNGDate; NameCreditMNGDate)
            {
            }
            column(NameCreditMNGSign; NameCreditMNGSign)
            {
            }
            column(NameCEO; NameCEO)
            {
            }
            column(NameCEOSign; NameCEOSign)
            {
            }
            column(NameCEODate; NameCEODate)
            {
            }
            column(CreditCom1; CreditCom1)
            {
            }
            column(CreditCom1Date; CreditCom1Date)
            {
            }
            column(CreditCom2; CreditCom2)
            {
            }
            column(CreditCom2Sign; CreditCom2Sign)
            {
            }
            column(CreditCom2Date; CreditCom2Date)
            {
            }
            column(CreditCom3; CreditCom3)
            {
            }
            column(CreditComDate3; CreditComDate3)
            {
            }
            column(CreditComSign3; CreditComSign3)
            {
            }
            column(AmountK; AmountK)
            {
            }
            column(AmountO; AmountO)
            {
            }
            column(AmountHS; AmountHS)
            {
            }
            column(AmountSA; AmountSA)
            {
            }
            column(AmountSp; AmountSp)
            {
            }
            column(ApprovedK; ApprovedK)
            {
            }
            column(ApprovedO; ApprovedO)
            {
            }
            column(ApprovedHS; ApprovedHS)
            {
            }
            column(ApprovedSA; ApprovedSA)
            {
            }
            column(ApprovedSP; ApprovedSP)
            {
            }
            column(NETKAR; NETKAR)
            {
            }
            column(NETOK; NETOK)
            {
            }
            column(NETHS; NETHS)
            {
            }
            column(NETSA; NETSA)
            {
            }
            column(NETSP; NETSP)
            {
            }
            column(netamount; netamount)
            {
            }
            column(MONTH; MONTH)
            {
            }
            trigger OnAfterGetRecord();
            begin
                repeat
                    if "Loan Product Type" = 'FOSAKARIBU' then begin
                        CalcFields("Loan Offset Amount");
                        AmountK := AmountK + "Requested Amount";
                        ApprovedK := ApprovedK + "Approved Amount";
                        //NETNORM:=ROUND(NETNORM+("Approved Amount"-"Top Up Amount"-("Top Up Amount"*0.1)),1,'=')
                        NETKAR := ROUND(NETKAR + ("Approved Amount" - "Loan Offset Amount" - ("Loan Offset Amount" * 0.1)))
                    end else
                        if "Loan Product Type" = 'HISA ADV' then begin
                            CalcFields("Loan Offset Amount");
                            AmountHS := AmountHS + "Requested Amount";
                            ApprovedHS := ApprovedHS + "Approved Amount";
                            //NETNORMT:=ROUND(NETNORMT+("Approved Amount"-"Top Up Amount"-("Top Up Amount"*0.1)),1,'=')
                            NETHS := ROUND(NETHS + ("Approved Amount" - (("Loan Offset Amount" * 0.1) + "Loan Offset Amount")))
                            //ROUND("Approved Amount"-(("Top Up Amount"*0.1)+"Top Up Amount"),1,'=')
                        end else
                            if "Loan Product Type" = 'OKOA' then begin
                                CalcFields("Loan Offset Amount");
                                AmountO := AmountO + "Requested Amount";
                                ApprovedO := ApprovedO + "Approved Amount";
                                //NETEMER:=NETEMER+("Approved Amount"-"Top Up Amount"-("Top Up Amount"*0.1))
                                NETOK := ROUND(NETOK + ("Approved Amount" - (("Loan Offset Amount" * 0.1) + "Loan Offset Amount")), 1, '=')
                            end else
                                if "Loan Product Type" = 'HSFADVANCE' then begin
                                    CalcFields("Loan Offset Amount");
                                    AmountSA := AmountSA + "Requested Amount";
                                    ApprovedSA := ApprovedSA + "Approved Amount";
                                    NETSA := NETSA + ("Approved Amount" - "Loan Offset Amount" - ("Loan Offset Amount" * 0.1))
                                end else
                                    if "Loan Product Type" = 'HSFSPECIAL' then begin
                                        CalcFields("Loan Offset Amount");
                                        AmountSp := AmountSp + "Requested Amount";
                                        ApprovedSP := ApprovedSP + "Approved Amount";
                                        NETSP := NETSP + ("Approved Amount" - "Loan Offset Amount" - ("Loan Offset Amount" * 0.1));
                                    end;
                until Loans2.Next = 0;
            end;

        }
        dataitem(Loans; "Loans Register")
        {
            DataItemTableView = sorting("Loan  No.") where(Source = const(BOSA), "Approved Amount" = filter(>= 1.000));
            RequestFilterFields = "Loan Product Type", "Application Date", "Appraisal Status", "Loan Status", "Issued Date";

            column(Intcount; Intcount)
            {
            }
            column(EmpCode; EmpCode)
            {
            }
            column(Staff_no; Loans."Staff No")
            {
            }
            column(Member_No; Loans."Client Code")
            {
            }
            column(Member_Name; Loans."Client Name")
            {
            }
            column(Loan_Type; Loans."Loan Product Type")
            {
            }
            column(Loan_No; Loans."Loan  No.")
            {
            }
            column(Cheque_No; Loans."Cheque Number")
            {
            }
            column(Requested_Amount; Loans."Requested Amount")
            {
            }
            column(Approved_Amount; Loans."Approved Amount")
            {
            }
            column(Top_Up_Amount; Loans."Loan Offset Amount")
            {
            }
            column(Installments; Loans.Installments)
            {
            }
            trigger OnAfterGetRecord();
            begin
                if MONTH = '' then
                    Error('You Must Specify the Month for the report');
                RPeriod := Loans.Installments;
                if (Loans."Outstanding Balance" > 0) and (Loans.Repayment > 0) then
                    RPeriod := Loans."Outstanding Balance" / Loans.Repayment;
                Cust.Reset;
                Cust.SetRange(Cust."No.", "Client Code");
                if Cust.Find('-') then begin
                    EmpCode := Cust."Employer Code";
                end;
                Intcount += 1;
                if LoanType.Get(Loans."Loan Product Type") then begin
                    Loancode := LoanType."Special Code";
                end;
                netamount := ROUND("Approved Amount" - (("Loan Offset Amount" * 0.1) + "Loan Offset Amount"), 1, '=');
                //Saccodeduct:=0;
                /*
				IF "Loan Product Type"='NORM' THEN BEGIN
				REPEAT
				AmountN:=AmountN+"Requested Amount";
				ApprovedN:=ApprovedN+"Approved Amount";
				UNTIL Loans.NEXT=0;
				END;
				*/

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
                field(MONTH; MONTH)
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
        //***************kyalo************
        if CompanyInfo.Get then begin
            CompanyInfo.CalcFields(Picture);
            //CompanyAddress:=CompanyInfo.Address;
            //CompanyEmail:=CompanyInfo."E-Mail";
        end
        ;

    end;

    var
        Loans_RegisterCaptionLbl: label 'Approved Loans Report';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        Loan_TypeCaptionLbl: label 'Loan Type';
        Client_No_CaptionLbl: label 'Client No.';
        Outstanding_LoanCaptionLbl: label 'Outstanding Loan';
        PeriodCaptionLbl: label 'Period';
        Approved_DateCaptionLbl: label 'Approved Date';
        Loan_TypeCaption_Control1102760043Lbl: label 'Loan Type';
        Verified_By__________________________________________________CaptionLbl: label 'Verified By..................................................';
        Confirmed_By__________________________________________________CaptionLbl: label 'Confirmed By..................................................';
        Sign________________________CaptionLbl: label 'Sign........................';
        Sign________________________Caption_Control1102755003Lbl: label 'Sign........................';
        Date________________________CaptionLbl: label 'Date........................';
        Date________________________Caption_Control1102755005Lbl: label 'Date........................';
        NameCreditOff: label 'Name......................................';
        NameCreditDate: label 'Date........................................';
        NameCreditSign: label 'Signature..................................';
        NameCreditMNG: label 'Name......................................';
        NameCreditMNGDate: label 'Date.....................................';
        NameCreditMNGSign: label 'Signature..................................';
        NameCEO: label 'Name........................................';
        NameCEOSign: label 'Signature...................................';
        NameCEODate: label 'Date.....................................';
        CreditCom1: label 'Name........................................';
        CreditCom1Sign: label 'Signature...................................';
        CreditCom1Date: label 'Date.........................................';
        CreditCom2: label 'Name........................................';
        CreditCom2Sign: label 'Signature....................................';
        CreditCom2Date: label 'Date..........................................';
        CreditCom3: label 'Name.........................................';
        CreditComDate3: label 'Date..........................................';
        CreditComSign3: label 'Signature..................................';
        Comment: label '....................';
        RPeriod: Decimal;
        Cust: Record Customer;
        EmpCode: Code[30];
        Intcount: Integer;
        LoanType: Record "Loan Products Setup";
        Loancode: Code[10];
        MONTH: Code[20];
        AmountK: Decimal;
        ApprovedK: Decimal;
        AmountO: Decimal;
        ApprovedO: Decimal;
        ApprovedS: Decimal;
        AmountS: Decimal;
        AmountC: Decimal;
        ApprovedC: Decimal;
        ApprovedSP: Decimal;
        AmountSp: Decimal;
        BEGINDATE: Date;
        ENDDATE: Date;
        NETKAR: Decimal;
        NETOK: Decimal;
        NETSCH: Decimal;
        NETSP: Decimal;
        NETCOLL: Decimal;
        Lonning: Record "Loans Register";
        APPROVED: Decimal;
        AmountHS: Decimal;
        ApprovedHS: Decimal;
        NETHS: Decimal;
        AmountSA: Decimal;
        ApprovedSA: Decimal;
        NETSA: Decimal;
        AmountS2: Decimal;
        ApprovedS2: Decimal;
        NETSCH2: Decimal;
        AmountC2: Decimal;
        ApprovedC2: Decimal;
        NETCOLL2: Decimal;
        AmountSp2: Decimal;
        ApprovedSP2: Decimal;
        NETSP2: Decimal;
        CompanyInfo: Record "Company Information";
        netamount: Decimal;

    // --> Reports ForNAV Autogenerated code - do not delete or modify
    var

}
