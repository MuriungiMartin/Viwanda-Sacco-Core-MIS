Report 50404 "Member Saving Listing"
{
    RDLCLayout = 'Layouts/MemberSavingListing.rdlc';
    DefaultLayout = RDLC;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Members Register"; Customer)
        {
            CalcFields = "Current Shares", "Registration Fee", "Principal Balance", "Shares Retained";
            DataItemTableView = sorting("No.") where("Customer Type" = const(Member));
            PrintOnlyIfDetail = false;
            RequestFilterFields = "Registration Date", "Date Filter";
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(Company_Address; Company.Address)
            {
            }
            column(Company_Address2; Company."Address 2")
            {
            }
            column(Company_PhoneNo; Company."Phone No.")
            {
            }
            column(Company_Email; Company."E-Mail")
            {
            }
            column(Company_Picture; Company.Picture)
            {
            }
            column(UserId; UserId)
            {
            }
            column(RNo; RNo)
            {
            }
            column(No; "Members Register"."No.")
            {
            }
            column(Name; "Members Register".Name)
            {
            }
            column(Staff_No; "Members Register"."Payroll No")
            {
            }
            column(Status; "Members Register".Status)
            {
            }
            column(Registration_date; "Members Register"."Registration Date")
            {
            }
            column(Entrance_Fee; "Members Register"."Registration Fee")
            {
            }
            column(Share_Capital; "Members Register"."Shares Retained")
            {
            }
            column(Welfare; "Members Register"."Welfare Contribution")
            {
            }
            column(Deposits; "Members Register"."Monthly Contribution")
            {
            }
            column(Outstanding_Bal; "Members Register"."Outstanding Balance")
            {
            }
            column(Dividend; "Members Register"."Dividend Amount")
            {
            }
            column(Balance1; Balance1)
            {
            }
            column(Balance2; Balance2)
            {
            }
            column(Balance3; Balance3)
            {
            }
            column(Balance4; Balance4)
            {
            }
            column(Balance5; Balance5)
            {
            }
            column(Balance6; Balance6)
            {
            }
            column(Principle_Balance; "Members Register"."Principal Balance")
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
            column(COMPPIC; "Members Register".Piccture)
            {
            }
            column(NAME1; "Members Register".Name)
            {
            }
            trigger OnPreDataItem();
            begin

            end;

            trigger OnAfterGetRecord();
            begin
                BaldateTXT := '01/01/10..' + Format(Baldate);
                LoansB.Reset;
                LoansB.SetRange(LoansB."No.", "No.");
                LoansB.SetFilter(LoansB."Date Filter", BaldateTXT);
                if LoansB.Find('-') then begin
                    LoansB.CalcFields(LoansB."Current Shares", LoansB."Shares Retained", LoansB."Insurance Fund", LoansB."Registration Fee");
                    ///kyalo comment...holiday fund removed above
                    //LoansB.CALCFIELDS(LoansB."Current Shares",LoansB."Shares Retained",LoansB."Insurance Fund",LoansB."Holiday Fund",
                    //LoansB."Entrance Fee");
                    Balance1 := LoansB."Current Shares" * -1;
                    Balance2 := LoansB."Shares Retained" * -1;
                    Balance3 := LoansB."Insurance Fund" * -1;
                    //Balance4:=LoansB."Holiday Fund"*-1;
                    Balance5 := LoansB."Registration Fee" * -1;
                end;
                //DivBal:= "Dividend Amount" *-1;
                Balance6 := Balance6 + "Dividend Amount";
                RNo := RNo + 1;
                /*
				IF Customer."No."='2400' THEN BEGIN
				Loan.INIT;
				Loan."Loan  No.":='DLN51050';
				Loan."Client Code":='2400';
				Loan."Client Name":=Customer.Name;
				Loan."Issued Date":=TODAY;
				Loan.Source:=Loan.Source::BOSA;
				  Loan.INSERT;
				END;
				//Defaulter:=FALSE;
				MODIFY;
				*/
                /*
				Loan.RESET;
				Loan.SETRANGE(Loan."Client Code","No.");
				IF Loan.FIND('-') THEN BEGIN
					REPEAT
						Loan."Company Code":="Company Code";
						Loan.MODIFY;
					UNTIL Loan.NEXT=0;
				END;
				Loan.RESET;
				Loan.SETRANGE(Loan."BOSA No","No.");
				IF Loan.FIND('-') THEN BEGIN
					REPEAT
						Loan."Company Code":="Company Code";
						Loan.MODIFY;
					UNTIL Loan.NEXT=0;
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
        Company.Get();
        Company.CalcFields(Company.Picture);
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
        RNo: Integer;
        BaldateTXT: Text[30];
        Baldate: Date;
        LoansB: Record Customer;
        Balance1: Decimal;
        Balance2: Decimal;
        Balance3: Decimal;
        Balance4: Decimal;
        Balance5: Decimal;
        Balance6: Decimal;
        DivBal: Decimal;
        Loan: Record "Loans Register";
        Company: Record "Company Information";


}
