#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
//51516050_v6_3_0_2259) { }
// Autogenerated code - do not delete or modify -->

Report 50050 "Pension Contribution"
{
    RDLCLayout = 'Layouts/PensionContribution.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Payroll Employee."; "Payroll Employee.")
        {
            column(ReportForNavId_1; 1) { } // Autogenerated by ForNav - Do not delete
            column(PF_No; "Payroll Employee."."No.")
            {
            }
            column(Main_Bank; "Payroll Employee."."Bank Name")
            {
            }
            column(Branch_Bank; "Payroll Employee."."Branch Name")
            {
            }
            column(Acc_No; "Payroll Employee."."Bank Account No")
            {
            }
            column(id; "Payroll Employee."."National ID No")
            {
            }
            column(CompName; CompName)
            {
            }
            column(pic; info.Picture)
            {
            }
            column(Addr1; Addr1)
            {
            }
            column(Addr2; Addr2)
            {
            }
            column(Email; Email)
            {
            }
            column(Net_Pay; NetPay)
            {
            }
            column(Name; StrName)
            {
            }
            column(BasicPay; BasicPay)
            {
            }
            column(Grosspay; Grosspay)
            {
            }
            column(PeriodName; PeriodName)
            {
            }
            column(EmployerContri; EmployerContri)
            {
            }
            column(CummContribution; CummContribution)
            {
            }
            column(User_Name_Caption; User_Name_CaptionLbl)
            {
            }
            column(Print_Date_Caption; Print_Date_CaptionLbl)
            {
            }
            column(Period_Caption; Period_CaptionLbl)
            {
            }
            column(Page_No_Caption; Page_No_CaptionLbl)
            {
            }
            column(Transaction_Name_Caption; Transaction_Name_CaptionLbl)
            {
            }
            column(Period_Amount_Caption; Period_Amount_CaptionLbl)
            {
            }
            trigger OnPreDataItem();
            begin
                info.Reset;
                if info.Get then info.CalcFields(info.Picture);
                //Pict:=info.Picture;
                CompName := info.Name;
                Addr1 := info.Address;
                Addr2 := info.City;
                Email := info."E-Mail";
            end;

            trigger OnAfterGetRecord();
            begin
                StrName := Firstname + ' ' + Surname + ' ' + Lastname;
                PeriodTrans.Reset;
                PeriodTrans.SetRange(PeriodTrans."Employee Code", "No.");
                PeriodTrans.SetRange(PeriodTrans."Payroll Period", DateFilter);
                PeriodTrans.SetCurrentkey(PeriodTrans."Employee Code", PeriodTrans."Period Month", PeriodTrans."Period Year",
                PeriodTrans."Group Order", PeriodTrans."Sub Group Order");
                Grosspay := 0;
                BasicPay := 0;
                NetPay := 0;
                EmployerContri := 0;
                if PeriodTrans.Find('-') then
                    repeat
                        FnSimpleTransactionAmount(PeriodTrans);
                        CummContribution := Grosspay + EmployerContri;
                    until PeriodTrans.Next = 0
                else
                    CurrReport.Skip;
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
                field(DateFilter; DateFilter)
                {
                    ApplicationArea = Basic;
                    Caption = 'Period Filter';
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
        if UserSetup.Get(UserId) then begin
            if UserSetup."View Payroll" = false then Error('You dont have permissions for payroll, Contact your system administrator! ')
        end;
        SelectedPeriod := DateFilter;
        objPeriod.Reset;
        objPeriod.SetRange(objPeriod."Date Opened", SelectedPeriod);
        if objPeriod.Find('-') then begin
            PeriodName := objPeriod."Period Name";
        end;
        if CompanyInfo.Get() then
            CompanyInfo.CalcFields(CompanyInfo.Picture);
        ;

    end;

    var
        UserSetup: Record "User Setup";
        StrName: Text[100];
        PeriodTrans: Record "prPeriod Transactions.";
        periods: Date;
        info: Record "Company Information";
        CompName: Code[100];
        Addr1: Text[50];
        Addr2: Text[50];
        Email: Text[50];
        NetPay: Decimal;
        DateFilter: Date;
        BasicPay: Decimal;
        Grosspay: Decimal;
        SelectedPeriod: Date;
        objPeriod: Record "Payroll Calender.";
        PeriodName: Code[100];
        CompanyInfo: Record "Company Information";
        EmployerContri: Decimal;
        CummContribution: Decimal;
        TotalFor: label 'Total for ';
        GroupOrder: label '3';
        Allowances_ReportCaptionLbl: label 'Deductions Report';
        User_Name_CaptionLbl: label 'User Name:';
        Print_Date_CaptionLbl: label 'Print Date:';
        Period_CaptionLbl: label 'Period:';
        Page_No_CaptionLbl: label 'Page No:';
        Transaction_Name_CaptionLbl: label 'Transaction Name:';
        Period_Amount_CaptionLbl: label 'Period Amount:';
        Prepared_by_______________________________________Date_________________CaptionLbl: label 'Prepared byÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁ..			  DateÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁ';
        Checked_by________________________________________Date_________________CaptionLbl: label 'Checked byÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁ..				   DateÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁ';
        Authorized_by____________________________________Date_________________CaptionLbl: label 'Authorized byÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁ..			DateÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁ';
        Approved_by______________________________________Date_________________CaptionLbl: label 'Approved byÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁ..			  DateÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁ';

    local procedure FnSimpleTransactionAmount(ObjTransactions: Record "prPeriod Transactions.")
    begin
        case ObjTransactions."Transaction Code" of
            'BPAY':
                BasicPay := ObjTransactions.Amount;
            'PNSR':
                Grosspay := ObjTransactions.Amount;
        end;
        EmployerContri := BasicPay * 0.2 - 200;
    end;

    // --> Reports ForNAV Autogenerated code - do not delete or modify
    //51516050_v6_3_0_2259;






    // Reports ForNAV Autogenerated code - do not delete or modify -->
}
