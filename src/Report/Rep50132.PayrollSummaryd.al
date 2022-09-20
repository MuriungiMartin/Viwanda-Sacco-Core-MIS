#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
//51516132_v6_3_0_2259) { }
// Autogenerated code - do not delete or modify -->

Report 50132 "Payroll Summary d"
{
    RDLCLayout = 'Layouts/PayrollSummaryd.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Payroll Employee."; "Payroll Employee.")
        {
            column(ReportForNavId_1; 1) { } // Autogenerated by ForNav - Do not delete
            column(PrintBy; 'PRINTED BY NAME:........................................................................................ SIGNATURE:................................... DESIGNATION:...................................... DATE:.......................................')
            {
            }
            column(CheckedBy; 'CHECKED BY NAME:........................................................................................ SIGNATURE:................................... DESIGNATION:...................................... DATE:.......................................')
            {
            }
            column(VerifiedBy; 'VERIFIED BY NAME:........................................................................................ SIGNATURE:................................... DESIGNATION:...................................... DATE:.......................................')
            {
            }
            column(ApprovedBy; 'APPROVED BY NAME:........................................................................................ SIGNATURE:................................... DESIGNATION:...................................... DATE:.......................................')
            {
            }
            column(BasicPayLbl; 'BASIC PAY')
            {
            }
            column(payelbl; 'PAYE.')
            {
            }
            column(nssflbl; 'NSSF')
            {
            }
            column(nhiflbl; 'NHIF')
            {
            }
            column(Netpaylbl; 'Net Pay')
            {
            }
            column(payeamount; payeamount)
            {
            }
            column(nssfam; nssfam)
            {
            }
            column(nhifamt; nhifamt)
            {
            }
            column(NetPay; NetPay)
            {
            }
            column(BasicPay; BasicPay)
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
            column(periods; 'Payroll Summary for ' + Format(periods, 0, 4))
            {
            }
            column(empName; "No." + ': ' + Firstname + ' ' + Surname + ' ' + Lastname)
            {
            }
            column(VarLeaveAllowance; VarLeaveAllowance)
            {
            }
            column(TotalVarLeaveAllowance; TotalVarLeaveAllowance)
            {
            }
            column(VarActingAllowance; VarActingAllowance)
            {
            }
            column(TotalVarActingAllowance; TotalVarActingAllowance)
            {
            }
            column(TransName_1_1; TransName[1, 1])
            {
            }
            column(TransName_1_2; TransName[1, 2])
            {
            }
            column(TransName_1_3; TransName[1, 3])
            {
            }
            column(TransName_1_4; TransName[1, 4])
            {
            }
            column(TransName_1_5; TransName[1, 5])
            {
            }
            column(TransName_1_6; TransName[1, 6])
            {
            }
            column(r; TransName[1, 7])
            {
            }
            column(TransName_1_8; TransName[1, 8])
            {
            }
            column(TransName_1_9; TransName[1, 9])
            {
            }
            column(TransName_1_10; TransName[1, 10])
            {
            }
            column(TransName_1_11; TransName[1, 11])
            {
            }
            column(TransName_1_12; TransName[1, 12])
            {
            }
            column(TransName_1_13; TransName[1, 13])
            {
            }
            column(TransName_1_14; TransName[1, 14])
            {
            }
            column(TransName_1_15; TransName[1, 15])
            {
            }
            column(TransName_1_16; TransName[1, 16])
            {
            }
            column(TransName_1_17; TransName[1, 17])
            {
            }
            column(TransName_1_18; TransName[1, 18])
            {
            }
            column(TransName_1_19; TransName[1, 19])
            {
            }
            column(TransName_1_20; TransName[1, 20])
            {
            }
            column(TransName_1_21; TransName[1, 21])
            {
            }
            column(TransName_1_22; TransName[1, 22])
            {
            }
            column(TransName_1_23; TransName[1, 23])
            {
            }
            column(TransName_1_24; TransName[1, 24])
            {
            }
            column(TransName_1_25; TransName[1, 25])
            {
            }
            column(TransName_1_26; TransName[1, 26])
            {
            }
            column(TransName_1_27; TransName[1, 27])
            {
            }
            column(TransName_1_28; TransName[1, 28])
            {
            }
            column(TranscAmount_1_1; TranscAmount[1, 1])
            {
            }
            column(TranscAmount_1_2; TranscAmount[1, 2])
            {
            }
            column(TranscAmount_1_3; TranscAmount[1, 3])
            {
            }
            column(TranscAmount_1_4; TranscAmount[1, 4])
            {
            }
            column(TranscAmount_1_5; TranscAmount[1, 5])
            {
            }
            column(TranscAmount_1_6; TranscAmount[1, 6])
            {
            }
            column(TranscAmount_1_7; TranscAmount[1, 7])
            {
            }
            column(TranscAmount_1_8; TranscAmount[1, 8])
            {
            }
            column(TranscAmount_1_9; TranscAmount[1, 9])
            {
            }
            column(TranscAmount_1_10; TranscAmount[1, 10])
            {
            }
            column(TranscAmount_1_11; TranscAmount[1, 11])
            {
            }
            column(TranscAmount_1_12; TranscAmount[1, 12])
            {
            }
            column(TranscAmount_1_13; TranscAmount[1, 13])
            {
            }
            column(TranscAmount_1_14; TranscAmount[1, 14])
            {
            }
            column(TranscAmount_1_15; TranscAmount[1, 15])
            {
            }
            column(TranscAmount_1_16; TranscAmount[1, 16])
            {
            }
            column(TranscAmount_1_17; TranscAmount[1, 17])
            {
            }
            column(TranscAmount_1_18; TranscAmount[1, 18])
            {
            }
            column(TranscAmount_1_19; TranscAmount[1, 19])
            {
            }
            column(TranscAmount_1_20; TranscAmount[1, 20])
            {
            }
            column(TranscAmount_1_21; TranscAmount[1, 21])
            {
            }
            column(TranscAmount_1_22; TranscAmount[1, 22])
            {
            }
            column(TranscAmount_1_23; TranscAmount[1, 23])
            {
            }
            column(TranscAmount_1_24; TranscAmount[1, 24])
            {
            }
            column(TranscAmount_1_25; TranscAmount[1, 25])
            {
            }
            column(TranscAmount_1_26; TranscAmount[1, 26])
            {
            }
            column(TranscAmount_1_27; TranscAmount[1, 27])
            {
            }
            column(TranscAmount_1_28; TranscAmount[1, 28])
            {
            }
            trigger OnPreDataItem();
            begin
                if periods = 0D then Error('Please Specify the Period first.');
                counts := 0;
                NetPayTotal := 0;
                BasicPayTotal := 0;
                payeamountTotal := 0;
                nssfamTotal := 0;
                nhifamtTotal := 0;
                Clear(TranscAmountTotal);
                // Make Headers
                // Pick The Earnings First
                prtransCodes.Reset;
                prtransCodes.SetFilter(prtransCodes."Transaction Type", '=%1', prtransCodes."transaction type"::Income);
                if prtransCodes.Find('-') then begin
                    repeat
                    begin
                        prPeriodTransactions.Reset;
                        prPeriodTransactions.SetRange(prPeriodTransactions."Transaction Code", prtransCodes."Transaction Code");
                        prPeriodTransactions.SetRange(prPeriodTransactions."Payroll Period", periods);
                        if prPeriodTransactions.Find('-') then begin
                            counts := counts + 1;
                            TransName[1, counts] := prtransCodes."Transaction Name";
                            Transcode[1, counts] := prtransCodes."Transaction Code";
                        end;
                    end;
                    until prtransCodes.Next = 0;
                end;
                // pick the deductions Here
                prtransCodes.Reset;
                prtransCodes.SetFilter(prtransCodes."Transaction Type", '=%1', prtransCodes."transaction type"::Deduction);
                if prtransCodes.Find('-') then begin
                    repeat
                    begin
                        prPeriodTransactions.Reset;
                        prPeriodTransactions.SetRange(prPeriodTransactions."Transaction Code", prtransCodes."Transaction Code");
                        prPeriodTransactions.SetRange(prPeriodTransactions."Payroll Period", periods);
                        if prPeriodTransactions.Find('-') then begin
                            counts := counts + 1;
                            TransName[1, counts] := prtransCodes."Transaction Name";
                            Transcode[1, counts] := prtransCodes."Transaction Code";
                        end;
                    end;
                    until prtransCodes.Next = 0;
                end;
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
                ObjEmployeePeriodTransactions.Reset;
                ObjEmployeePeriodTransactions.SetRange(ObjEmployeePeriodTransactions."Employee Code", "No.");
                ObjEmployeePeriodTransactions.SetFilter(ObjEmployeePeriodTransactions."Payroll Period", '%1', periods);
                if prPeriodTransactions.Find('-') then begin
                    repeat
                    begin
                        if ObjEmployeePeriodTransactions."Transaction Code" = 'NPAY' then begin
                            NetPay := ObjEmployeePeriodTransactions.Amount;
                            NetPayTotal := (NetPayTotal + (ObjEmployeePeriodTransactions.Amount));
                        end else
                            if ObjEmployeePeriodTransactions."Transaction Code" = 'PAYE' then begin
                                payeamount := ObjEmployeePeriodTransactions.Amount;
                                payeamountTotal := (payeamountTotal + (ObjEmployeePeriodTransactions.Amount));
                            end else
                                if ObjEmployeePeriodTransactions."Transaction Code" = 'NSSF' then begin
                                    nssfam := ObjEmployeePeriodTransactions.Amount;
                                    nssfamTotal := (nssfamTotal + (ObjEmployeePeriodTransactions.Amount));
                                end else
                                    if ObjEmployeePeriodTransactions."Transaction Code" = 'NHIF' then begin
                                        nhifamt := ObjEmployeePeriodTransactions.Amount;
                                        nhifamtTotal := (nhifamtTotal + (ObjEmployeePeriodTransactions.Amount));
                                    end else
                                        if ObjEmployeePeriodTransactions."Transaction Code" = 'BPAY' then begin
                                            BasicPay := ObjEmployeePeriodTransactions.Amount;
                                            BasicPayTotal := (BasicPayTotal + (ObjEmployeePeriodTransactions.Amount));
                                        end else
                                            if ObjEmployeePeriodTransactions."Transaction Code" = 'GPAY' then begin
                                                GrossPay := ObjEmployeePeriodTransactions.Amount;
                                                GrosspayTotal := (GrosspayTotal + (ObjEmployeePeriodTransactions.Amount));
                                            end else
                                                if ObjEmployeePeriodTransactions."Transaction Code" = 'E_0005' then begin
                                                    VarLeaveAllowance := ObjEmployeePeriodTransactions.Amount;
                                                    TotalVarLeaveAllowance := (TotalVarLeaveAllowance + (ObjEmployeePeriodTransactions.Amount));
                                                end else
                                                    if ObjEmployeePeriodTransactions."Transaction Code" = 'E_0002' then begin
                                                        VarActingAllowance := ObjEmployeePeriodTransactions.Amount;
                                                        TotalVarActingAllowance := (TotalVarActingAllowance + (ObjEmployeePeriodTransactions.Amount));
                                                    end;
                    end;
                    until ObjEmployeePeriodTransactions.Next = 0;
                end;
                /*IF "HR Employees"."No."='' THEN showdet:=FALSE;
						IF ((BasicPay=0) OR ("HR Employees"."No."='')) THEN //showdet:=FALSE;
						 CurrReport.SKIP;*/

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
                    TableRelation = "Payroll Calender.";
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
        if UserSetup.Get(UserId) then begin
            if UserSetup."View Payroll" = false then Error('You dont have permissions for payroll, Contact your system administrator! ')
        end;
        ;

    end;

    var
        UserSetup: Record "User Setup";
        prPayrollPeriods: Record "Payroll Calender.";
        periods: Date;
        counts: Integer;
        prPeriodTransactions: Record "prPeriod Transactions.";
        TransName: array[1, 200] of Text[200];
        Transcode: array[1, 200] of Code[100];
        TransCount: Integer;
        TranscAmount: array[1, 200] of Decimal;
        TranscAmountTotal: array[1, 200] of Decimal;
        NetPay: Decimal;
        NetPayTotal: Decimal;
        showdet: Boolean;
        payeamount: Decimal;
        payeamountTotal: Decimal;
        nssfam: Decimal;
        nssfamTotal: Decimal;
        nhifamt: Decimal;
        nhifamtTotal: Decimal;
        BasicPay: Decimal;
        BasicPayTotal: Decimal;
        GrossPay: Decimal;
        GrosspayTotal: Decimal;
        prtransCodes: Record "Payroll Transaction Code.";
        info: Record "Company Information";
        CompName: Text[50];
        Addr1: Text[50];
        Addr2: Text[50];
        Email: Text[50];
        ObjEmployeePeriodTransactions: Record "prPeriod Transactions.";
        VarLeaveAllowance: Decimal;
        TotalVarLeaveAllowance: Integer;
        VarActingAllowance: Decimal;
        TotalVarActingAllowance: Integer;

    // --> Reports ForNAV Autogenerated code - do not delete or modify
    //51516132_v6_3_0_2259;






    // Reports ForNAV Autogenerated code - do not delete or modify -->
}
