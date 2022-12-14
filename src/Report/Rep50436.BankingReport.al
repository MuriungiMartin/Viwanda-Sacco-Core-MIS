#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
//51516436_v6_3_0_2259) { }
// Autogenerated code - do not delete or modify -->

Report 50436 "Banking Report"
{
    RDLCLayout = 'Layouts/BankingReport.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem(Transactions; Transactions)
        {
            DataItemTableView = sorting(No) where(Type = const('Cheque Deposit'), Posted = const(true), "Banking Posted" = const(true));
            RequestFilterFields = "Date Banked", "Transaction Date";
            column(ReportForNavId_4645; 4645) { } // Autogenerated by ForNav - Do not delete
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
            column(No; Transactions.No)
            {
            }
            column(Account_No; Transactions."Account No")
            {
            }
            column(Account_Name; Transactions."Account Name")
            {
            }
            column(Transaction_Date; Transactions."Transaction Date")
            {
            }
            column(Cheque_No; Transactions."Cheque No")
            {
            }
            column(Cheque_Date; Transactions."Cheque Date")
            {
            }
            column(BIH_No; Transactions."BIH No")
            {
            }
            column(Amount; Transactions.Amount)
            {
            }
            column(Date_Banked; Transactions."Date Banked")
            {
            }
            column(Banked_BY; Transactions."Banked By")
            {
            }
            column(S_No; SN)
            {
            }
            trigger OnPreDataItem();
            begin
                SN := SN + 1;
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
            //:= false;
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
        AccountType: Record "Account Types-Saving Products";
        Accname: Code[40];
        SN: Integer;
        Company: Record "Company Information";

    // --> Reports ForNAV Autogenerated code - do not delete or modify
    //51516436_v6_3_0_2259;






    // Reports ForNAV Autogenerated code - do not delete or modify -->
}
