
Report 50534 "Ollin Bank Schedule"
{
    RDLCLayout = 'Layouts/OllinBankSchedule.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Payroll Employee."; "Payroll Employee.")
        {
            RequestFilterFields = "Bank Code", "Branch Code";

            column(PF_No; "Payroll Employee."."No.")
            {
            }
            column(Main_Bank; "Payroll Employee."."Bank Code")
            {
            }
            column(Branch_Bank; "Payroll Employee."."Branch Name")
            {
            }
            column(Bank_Code; "Payroll Employee."."Bank Name")
            {
            }
            column(Branch_Code; "Payroll Employee."."Branch Code")
            {
            }
            column(Acc_No; "Payroll Employee."."Bank Account No")
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
            column(ContractType; "Payroll Employee."."Period Filter")
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
                StrName := "Payroll Employee.".Surname + ' ' + "Payroll Employee.".Firstname + ' ' + "Payroll Employee.".Lastname;
                if "Payroll Employee.".Status = "Payroll Employee.".Status::Active then begin
                    prPeriodTransactions.Reset;
                    prPeriodTransactions.SetRange(prPeriodTransactions."Payroll Period", periods);
                    prPeriodTransactions.SetRange(prPeriodTransactions."Employee Code", "Payroll Employee."."No.");
                    prPeriodTransactions.SetRange(prPeriodTransactions."Transaction Code", 'Net Pay');
                    if prPeriodTransactions.Find('-') then begin
                        NetPay := prPeriodTransactions.Amount;
                        //NetPay:=ROUND(NetPay,1,'=');
                    end
                end else begin
                    CurrReport.Skip;
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
                field(Period; periods)
                {
                    ApplicationArea = Basic;
                    Caption = 'Period:';
                    TableRelation = "Payroll Calender."."Date Opened";
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
        ;

    end;

    var
        UserSetup: Record "User Setup";
        StrName: Text[100];
        prPeriodTransactions: Record "prPeriod Transactions.";
        periods: Date;
        info: Record "Company Information";
        CompName: Text[50];
        Addr1: Text[50];
        Addr2: Text[50];
        Email: Text[50];
        NetPay: Decimal;

    var
}
