Report 50503 "Loans Guaranteed Report"
{
    RDLCLayout = 'Layouts/LoansGuaranteedReport.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem(Customer; Customer)
        {
            CalcFields = "Current Shares";
            RequestFilterFields = "No.", Name;
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(Company_Name; Company.Name)
            {
            }
            column(Company_Address; Company.Address)
            {
            }
            column(Company_Address_2; Company."Address 2")
            {
            }
            column(Company_Phone_No; Company."Phone No.")
            {
            }
            column(Company_Fax_No; Company."Fax No.")
            {
            }
            column(Company_Picture; Company.Picture)
            {
            }
            column(Company_Email; Company."E-Mail")
            {
            }
            column(UserId; UserId)
            {
            }
            column(No_Members; Customer."No.")
            {
            }
            column(RNo; RNo)
            {
            }
            column(AvailableSH; AvailableSH)
            {
            }
            column(Name_Members; Customer.Name)
            {
            }
            column(PhoneNo_Members; Customer."Phone No.")
            {
            }
            column(OutstandingBalance_Members; Customer."Outstanding Balance")
            {
            }
            column(PayrollNo_MembersRegister; Customer."Payroll No")
            {
            }
            column(CurrentShares_MembersRegister; Customer."Current Shares")
            {
            }
            dataitem("Loans Guarantee Details"; "Loans Guarantee Details")
            {
                DataItemLink = "Member No" = field("No.");
                DataItemTableView = where("Outstanding Balance" = filter(> 0), Substituted = filter(false));
                RequestFilterFields = "Member No", "Loan No";
                column(AmontGuaranteed_LoanGuarantors; "Loans Guarantee Details"."Amont Guaranteed")
                {
                }
                column(NoOfLoansGuaranteed_LoanGuarantors; "Loans Guarantee Details"."No Of Loans Guaranteed")
                {
                }
                column(Name_LoanGuarantors; "Loans Guarantee Details".Name)
                {
                }
                column(MemberNo_LoanGuarantors; "Loans Guarantee Details"."Member No")
                {
                }
                column(LoanNo_LoanGuarantors; "Loans Guarantee Details"."Loan No")
                {
                }
                column(LoanProduct_BOSALoansGuarantors; "Loans Guarantee Details"."Loan Product")
                {
                }
                column(ProductDescription; LoanProductsSetup."Product Description")
                {
                }
                column(No; no)
                {
                }
                column(OutstandingBalance_LoanGuarantors; "Loans Guarantee Details"."Outstanding Balance")
                {
                }
                column(OutstandingBAlSt; OutstandingBAlSt)
                {
                }
                column(OutStandingBal; OutStandingBal)
                {
                }
                column(TotalOutstandingBal; TotalOutstandingBal)
                {
                }
                column(FNo; FNo)
                {
                }
                column(AmountGuar; AmountGuar)
                {
                }
                column(LoaneesName_LoanGuarantors; "Loans Guarantee Details"."Loanees  Name")
                {
                }
                column(LoaneesNo_LoanGuarantors; "Loans Guarantee Details"."Loanees  No")
                {
                }
                column(SubNo; "Loans Guarantee Details"."Substituted Guarantor")
                {
                }
                column(SubName; "Loans Guarantee Details"."Share capital")
                {
                }
                column(VarCurrLiability; VarCurrLiability)
                {
                }
                column(AvailableSH2; AvailableSH)
                {
                }
                dataitem("Loans Register"; "Loans Register")
                {
                    DataItemLink = "Loan  No." = field("Loan No");
                    DataItemTableView = sorting("Loan  No.") order(ascending) where(Posted = const(true));
                    column(Client_Code; "Loans Register"."Client Code")
                    {
                    }
                    column(Client_Name; "Loans Register"."Client Name")
                    {
                    }
                    column(EmployerCode_Loans; "Loans Register"."Employer Code")
                    {
                    }
                    column(ApplicationDate_LoansRegister; "Loans Register"."Application Date")
                    {
                    }
                    column(OutstandingBalance_Loans; "Loans Register"."Outstanding Balance")
                    {
                    }
                    column(ApprovedAmount_LoansRegister; "Loans Register"."Approved Amount")
                    {
                    }
                    column(LoanDisbursementDate_LoansRegister; "Loans Register"."Loan Disbursement Date")
                    {
                    }
                    column(OutStandingBal2; OutStandingBal)
                    {
                    }
                    column(TotalOutstandingBal2; TotalOutstandingBal)
                    {
                    }
                    trigger OnPreDataItem();
                    begin
                        OutStandingBal := 0;
                        TotalOutstandingBal := 0;
                        OutStandingBal := OutStandingBal;
                        TotalOutstandingBal := TotalOutstandingBal;
                    end;

                }
                trigger OnAfterGetRecord();
                begin
                    //Loan.GET();
                    OutstandingBAlSt := 0;
                    Loansr.Reset;
                    Loansr.SetRange(Loansr."Loan  No.", "Loan No");
                    if "Loans Register".Find('-') then //BEGIN
                        Loansr.CalcFields(Loansr."Outstanding Balance");
                    MemberNo := Loansr."Client Code";
                    MemberName := Loansr."Client Name";
                    EmployerCode := Loansr."Employer Code";
                    OutstandingBAlSt := Loansr."Outstanding Balance";
                    FNo := FNo + 1;
                    VarCurrLiability := 0;
                    //END;
                    AmountGuar := AmountGuar + "Amont Guaranteed";
                    "Loans Guarantee Details".CalcFields("Loans Guarantee Details"."Total Loans Guaranteed");
                    if ObjLoans.Get("Loans Guarantee Details"."Loan No") then begin
                        ObjLoans.CalcFields(ObjLoans."Outstanding Balance");
                        if ObjLoans."Outstanding Balance" > 0 then begin
                            if "Loans Guarantee Details"."Total Loans Guaranteed" <> 0 then begin
                                VarCurrLiability := ROUND(("Loans Guarantee Details"."Amont Guaranteed" / "Loans Guarantee Details"."Total Loans Guaranteed") * ObjLoans."Outstanding Balance", 0.5, '=');
                            end;
                        end;
                    end;
                    Cust.CalcFields(Cust."Outstanding Balance", Cust."Current Shares", Cust."Loans Guaranteed");
                    //AvailableSH:=Cust."Current Shares"-Cust."Loans Guaranteed";
                    AvailableSH := Cust."Current Shares" - VarCurrLiability;
                    if LoanProductsSetup.Get("Loans Guarantee Details"."Loan Product") then;
                end;

            }
            trigger OnPreDataItem();
            begin
                LastFieldNo := FieldNo("No.");
                RNo := RNo + 1;
                Company.Get();
                Company.CalcFields(Company.Picture);
            end;

            trigger OnAfterGetRecord();
            begin
                RNo := 1;
                /*//RNo:=INCSTR(FORMAT(RNo));
				Cust.CALCFIELDS(Cust."Outstanding Balance",Cust."Current Shares",Cust."Loans Guaranteed");
				AvailableSH:=Cust."Current Shares"-Cust."Loans Guaranteed";
				Cust.RESET;
				Cust.SETRANGE(Cust."No.","No.");
				IF Cust.FIND('-') THEN BEGIN
				REPEAT
				UNTIL Cust.NEXT=0;
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
    end;

    trigger OnPreReport()
    begin

    end;

    var
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        AvailableSH: Decimal;
        MemberNo: Text;
        MemberName: Text;
        EmployerCode: Text;
        Loansr: Record "Loans Register";
        no: Integer;
        TotalOutstandingBal: Decimal;
        OutStandingBal: Decimal;
        FNo: Integer;
        AmountGuar: Decimal;
        OutstandingBAlSt: Decimal;
        RNo: Integer;
        Cust: Record Customer;
        Company: Record "Company Information";
        VarCurrLiability: Decimal;
        ObjLoans: Record "Loans Register";
        LoanProductsSetup: Record "Loan Products Setup";

}
