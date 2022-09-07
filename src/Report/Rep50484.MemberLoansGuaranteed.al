#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 //  settings

Report 50484 "Member Loans Guaranteed"
{
    RDLCLayout = 'Layouts/MemberLoansGuaranteed.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Members Register"; "Members Register")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.";

            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }

            column(UserId; UserId)
            {
            }
            column(Members__No__; "Members Register"."No.")
            {
            }
            column(Members_Name; "Members Register".Name)
            {
            }
            column(Members__Payroll_Staff_No_; "Members Register"."Payroll No")
            {
            }
            column(Members__Current_Shares_; "Members Register"."Current Shares")
            {
            }
            column(Loan_GuaranteedCaption; Loan_GuaranteedCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Members__No__Caption; FieldCaption("No."))
            {
            }
            column(Members_NameCaption; FieldCaption(Name))
            {
            }
            column(Personal_No_Caption; Personal_No_CaptionLbl)
            {
            }
            column(Loan_Guarantors__Loan_No_Caption; "Loans Guarantee Details".FieldCaption("Loan No"))
            {
            }
            column(NameCaption; NameCaptionLbl)
            {
            }
            column(Loan_Guarantors_SubstitutedCaption; "Loans Guarantee Details".FieldCaption(Substituted))
            {
            }
            column(Oustanding_BalanceCaption; Oustanding_BalanceCaptionLbl)
            {
            }
            column(Loan_AmountCaption; Loan_AmountCaptionLbl)
            {
            }
            column(Current_SharesCaption; Current_SharesCaptionLbl)
            {
            }
            column(Staff_No_Caption; Staff_No_CaptionLbl)
            {
            }
            column(Loan_TypeCaption; Loan_TypeCaptionLbl)
            {
            }
            column(Loan_Guarantors__Amont_Guaranteed_Caption; "Loans Guarantee Details".FieldCaption("Amont Guaranteed"))
            {
            }
            column(Total_DepositsCaption; Total_DepositsCaptionLbl)
            {
            }
            column(MNo_Caption; MNo_CaptionLbl)
            {
            }
            column(Members_FOSA_Account; "Members Register"."FOSA Account No.")
            {
            }
            dataitem("Loans Guarantee Details"; "Loans Guarantee Details")
            {
                DataItemLink = "Member No" = field("No.");
                DataItemTableView = where("Loan Balance" = filter(<> 0));
                RequestFilterFields = Substituted, "Amont Guaranteed";

                column(Loan_Guarantors__Loan_No_; "Loans Guarantee Details"."Loan No")
                {
                }
                column(Loans__Client_Name_; Loans."Client Name")
                {
                }
                column(Loans__Approved_Amount_; Loans."Approved Amount")
                {
                }
                column(Shares__1; Shares * -1)
                {
                }
                column(Loans__Staff_No_; Loans."Staff No")
                {
                }
                column(Loans__Loan_Product_Type_; Loans."Loan Product Type")
                {
                }
                column(Loan_Guarantors__Amont_Guaranteed_; "Loans Guarantee Details"."Amont Guaranteed")
                {
                }
                column(Loan_Guarantors__Member_No_; "Loans Guarantee Details"."Member No")
                {
                }
                column(Loans__Outstanding_Balance_; Loans."Outstanding Balance")
                {
                }
                column(Loan_Guarantors_Substituted; "Loans Guarantee Details".Substituted)
                {
                }
                column(Loans__Outstanding_Balance__Control1102755004; Loans."Outstanding Balance")
                {
                }
                column(Loan_Guarantors_Staff_Payroll_No_; "Loans Guarantee Details"."Staff/Payroll No.")
                {
                }
                dataitem("Loans Register"; "Loans Register")
                {
                    DataItemLink = "Loan  No." = field("Loan No");
                    DataItemTableView = where("Outstanding Balance" = filter(> 200));

                    column(Loan_Guarantors_FOSA_Substituted; "Loans Register"."Approved Amount")
                    {
                    }
                    column(Loans__Outstanding_Balance__Control1102760023; Loans."Outstanding Balance")
                    {
                    }
                    column(Loans__Approved_Amount__Control1102760024; Loans."Approved Amount")
                    {
                    }
                    column(Shares__1_Control1102760025; Shares * -1)
                    {
                    }
                    column(Loans__Client_Name__Control1102760026; Loans."Client Name")
                    {
                    }
                    column(Loan_Guarantors_FOSA__Loan_No_; "Loans Register"."Loan  No.")
                    {
                    }
                    column(Loans__Staff_No__Control1102760029; Loans."Staff No")
                    {
                    }
                    column(Loans__Loan_Product_Type__Control1102760031; Loans."Loan Product Type")
                    {
                    }
                    column(Account_No_; "Loans Register"."Account No")
                    {
                    }
                    column(Loan_Guarantors_FOSA_Staff_Payroll_No_; "Loans Register"."Requested Amount")
                    {
                    }
                    column(Loan_Guarantors_FOSA_Account_No_; "Loans Register"."Application Date")
                    {
                    }
                    column(Loan_Guarantors_FOSA_Signed; "Loans Register"."Client Code")
                    {
                    }
                    trigger OnAfterGetRecord();
                    begin
                        Shares := 0;
                        if Loans.Get("Loan  No.") then begin
                            Loans.CalcFields(Loans."Outstanding Balance");
                            if Cust.Get("Members Register"."No.") then begin
                                Cust.CalcFields(Cust."Current Shares");
                                Shares := Cust."Current Shares";
                            end;
                        end;
                    end;

                }
                trigger OnAfterGetRecord();
                begin
                    Shares := 0;
                    if Loans.Get("Loan No") then begin
                        Loans.CalcFields(Loans."Outstanding Balance");
                        if Cust.Get("Members Register"."No.") then begin
                            Cust.CalcFields(Cust."Current Shares");
                            Shares := Cust."Current Shares";
                        end;
                    end;
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
        ;

    end;

    var
        Loans: Record "Loans Register";
        Cust: Record "Members Register";
        Shares: Decimal;
        Cust2: Record "Members Register";
        LoanGaurantors: Record "Loans Guarantee Details";
        LCount: Integer;
        A: Decimal;
        T: Decimal;
        LoanApps: Record "Loans Register";
        Lamount: Decimal;
        LGBalance: Decimal;
        "Account No": Code[10];
        Loan_GuaranteedCaptionLbl: label 'Loan Guaranteed';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        Personal_No_CaptionLbl: label 'Personal No.';
        NameCaptionLbl: label 'Name';
        Oustanding_BalanceCaptionLbl: label 'Oustanding Balance';
        Loan_AmountCaptionLbl: label 'Loan Amount';
        Current_SharesCaptionLbl: label 'Current Shares';
        Staff_No_CaptionLbl: label 'Staff No.';
        Loan_TypeCaptionLbl: label 'Loan Type';
        Total_DepositsCaptionLbl: label 'Total Deposits';
        MNo_CaptionLbl: label 'MNo.';


    var

}
