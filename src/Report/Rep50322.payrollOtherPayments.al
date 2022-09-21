#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
//51516322_v6_3_0_2259) { }
// Autogenerated code - do not delete or modify -->

Report 50322 "payroll Other Payments."
{
    RDLCLayout = 'Layouts/payrollOtherPayments..rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Payroll Employee."; "Payroll Employee.")
        {
            DataItemTableView = sorting("No.") order(ascending) where("Bank Account No" = filter(''));
            column(ReportForNavId_8631; 8631) { } // Autogenerated by ForNav - Do not delete
            column(UserId; UserId)
            {
            }
            column(Today; Today)
            {
            }
            column(PeriodName; PeriodName)
            {
            }

            column(companyinfo_Picture; companyinfo.Picture)
            {
            }
            column(EmployeeName; EmployeeName)
            {
            }
            column(TaxablePay; TaxablePay)
            {
            }
            column(HR_Employee__HR_Employee___No__; "Payroll Employee."."No.")
            {
            }
            column(icount; icount)
            {
            }
            column(TotTaxablePay; TotTaxablePay)
            {
            }
            column(User_Name_Caption; User_Name_CaptionLbl)
            {
            }
            column(Print_Date_Caption; Print_Date_CaptionLbl)
            {
            }
            column(FOSA_PAYMENT_REPORTCaption; FOSA_PAYMENT_REPORTCaptionLbl)
            {
            }
            column(Period_Caption; Period_CaptionLbl)
            {
            }
            column(Page_No_Caption; Page_No_CaptionLbl)
            {
            }
            column(Net_Amount_Caption; Net_Amount_CaptionLbl)
            {
            }
            column(Employee_NameCaption; Employee_NameCaptionLbl)
            {
            }
            column(No_Caption; No_CaptionLbl)
            {
            }
            column(Approved_by______________________________________Date_________________Caption; Approved_by______________________________________Date_________________CaptionLbl)
            {
            }
            column(Authorized_by____________________________________Date_________________Caption; Authorized_by____________________________________Date_________________CaptionLbl)
            {
            }
            column(Checked_by________________________________________Date_________________Caption; Checked_by________________________________________Date_________________CaptionLbl)
            {
            }
            column(Prepared_by_______________________________________Date_________________Caption; Prepared_by_______________________________________Date_________________CaptionLbl)
            {
            }
            column(Total_Caption; Total_CaptionLbl)
            {
            }
            dataitem("prSalary Card"; "Payroll Employee.")
            {
                DataItemLink = "No." = field("No.");
                RequestFilterFields = "No.";
                column(ReportForNavId_6207; 6207) { } // Autogenerated by ForNav - Do not delete
                trigger OnAfterGetRecord();
                begin
                    //  bankAcc:='';
                    //  mainBankNM:='';
                    //  BranchBankNM:='';
                end;

            }
            trigger OnAfterGetRecord();
            begin
                mainBankNM := '';
                BranchBankNM := '';
                EmployeeName := Firstname + ' ' + Surname + ' ' + Lastname;
                bankAcc := objEmp."Bank Account No";
                bankStruct.Reset;
                bankStruct.SetRange(bankStruct."Branch Code", "Bank Code");
                bankStruct.SetRange(bankStruct."Bank Code", "Branch Code");
                if bankStruct.Find('-') then begin
                    mainBankNM := bankStruct."Bank Name";
                    BranchBankNM := bankStruct.Branch;
                end;
                PeriodTrans.Reset;
                PeriodTrans.SetRange(PeriodTrans."Employee Code", "No.");
                PeriodTrans.SetRange(PeriodTrans."Payroll Period", SelectedPeriod);
                TaxablePay := 0;
                if PeriodTrans.Find('-') then
                    repeat
                        //TXBP Taxable Pay -  BY DENNIS
                        if (PeriodTrans."Transaction Code" = 'NPAY') then begin
                            TaxablePay := PeriodTrans.Amount;
                        end;
                    until PeriodTrans.Next = 0;
                TotTaxablePay := TotTaxablePay + TaxablePay;
                TotPayeAmount := TotPayeAmount + PayeAmount;
                icount := icount + 1;
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
                field("Payroll Period"; SelectedPeriod)
                {
                    ApplicationArea = Basic;
                    //TableRelation = "HR Job Qualifications".Field10;
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
        if UserSetup.Get(UserId) then begin
            if UserSetup."View Payroll" = false then Error('You dont have permissions for payroll, Contact your system administrator! ')
        end;
        ;


    end;

    trigger OnPostReport()
    begin
        ;

    end;

    trigger OnPreReport()
    begin
        /*PeriodFilter:="prSalary Card".GETFILTER("Period Filter");
		IF PeriodFilter='' THEN ERROR('You must specify the period filter');
		SelectedPeriod:="prSalary Card".GETRANGEMIN("Period Filter");
		*/
        if SelectedPeriod = 0D then Error('You must specify the period filter');
        objPeriod.Reset;
        if objPeriod.Get(SelectedPeriod) then PeriodName := objPeriod."Period Name";
        if companyinfo.Get() then
            companyinfo.CalcFields(companyinfo.Picture);
        ;


    end;

    var
        PeriodTrans: Record "prPeriod Transactions.";
        PayeAmount: Decimal;
        TotPayeAmount: Decimal;
        TaxablePay: Decimal;
        TotTaxablePay: Decimal;
        EmployeeName: Text[30];
        PinNumber: Text[30];
        objPeriod: Record "Payroll Calender.";
        objEmp: Record "Payroll Employee.";
        SelectedPeriod: Date;
        PeriodName: Text[30];
        PeriodFilter: Text[30];
        companyinfo: Record "Company Information";
        bankStruct: Record Banks;
        bankAcc: Text[50];
        BranchBankNM: Text[100];
        mainBankNM: Text[100];
        icount: Integer;
        User_Name_CaptionLbl: label 'User Name:';
        Print_Date_CaptionLbl: label 'Print Date:';
        FOSA_PAYMENT_REPORTCaptionLbl: label 'FOSA PAYMENT REPORT';
        Period_CaptionLbl: label 'Period:';
        Page_No_CaptionLbl: label 'Page No:';
        Net_Amount_CaptionLbl: label 'Net Amount:';
        Employee_NameCaptionLbl: label 'Employee Name';
        No_CaptionLbl: label 'No:';
        Approved_by______________________________________Date_________________CaptionLbl: label 'Approved byÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁ..				DateÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁ';
        Authorized_by____________________________________Date_________________CaptionLbl: label 'Authorized byÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁ..			  DateÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁ';
        Checked_by________________________________________Date_________________CaptionLbl: label 'Checked byÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁ..				   DateÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁ';
        Prepared_by_______________________________________Date_________________CaptionLbl: label 'Prepared byÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁ..				 DateÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁ';
        Total_CaptionLbl: label 'Total:';
        UserSetup: Record "User Setup";

    // --> Reports ForNAV Autogenerated code - do not delete or modify
    //51516322_v6_3_0_2259;






    // Reports ForNAV Autogenerated code - do not delete or modify -->
}
