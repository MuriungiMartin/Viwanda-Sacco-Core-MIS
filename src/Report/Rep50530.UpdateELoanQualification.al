Report 50530 "Update E-Loan Qualification"
{
    RDLCLayout = 'Layouts/UpdateE-LoanQualification.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem(Vendor; Vendor)
        {
            trigger OnAfterGetRecord();
            begin
                //*****Get Member Deposit Contribution
                if Cust.Get(Vendor."BOSA Account No") then begin
                    Cust.CalcFields(Cust."Current Shares");
                    DepositShareBal := Cust."Current Shares";
                end;
                //*****Get Member Default Status
                LoansRec.Reset;
                LoansRec.SetRange(LoansRec."BOSA No", Vendor."BOSA Account No");
                if LoansRec.Find('-') then begin
                    repeat
                        if LoansRec."Loans Category" <> LoansRec."loans category"::Watch then begin
                            Defaulter := true;
                        end;
                    until LoansRec.Next = 0;
                end;
                //******Get Salary Deductable Amount
                //******Get Standing Order Amount
                StoDedAmount := 0;
                STO.Reset;
                STO.SetRange(STO."Source Account No.", Vendor."No.");
                STO.SetRange(STO."None Salary", false);
                if STO.Find('-') then begin
                    repeat
                        StoDedAmount := StoDedAmount + STO.Amount;
                    until STO.Next = 0;
                end;
                //***Get FOSA Loan Deductions
                LoanRepayAmount := 0;
                LoansRec.Reset;
                LoansRec.SetRange(LoansRec."Account No", Vendor."No.");
                LoansRec.SetRange(LoansRec.Source, LoansRec.Source::BOSA);
                LoansRec.SetRange(LoansRec.Posted, true);
                LoansRec.CalcFields(LoansRec."Outstanding Balance");
                if LoansRec.Find('-') then begin
                    repeat
                        if LoansRec."Outstanding Balance" > 0 then begin
                            LoanRepayAmount := LoanRepayAmount + (LoansRec."Loan Principle Repayment" + LoansRec."Loan Interest Repayment");
                        end;
                    until LoansRec.Next = 0;
                end;
                //***Get Avarege Net Pay
                //CummulativeNet:=0;
                ESalaryBuffer.Reset;
                ESalaryBuffer.SetCurrentkey(ESalaryBuffer."Salary Processing Date");
                ESalaryBuffer.SetRange(ESalaryBuffer."Account No", Vendor."BOSA Account No");
                if ESalaryBuffer.FindLast then begin
                    ESalaryLastSalaryDate := ESalaryBuffer."Salary Processing Date";
                    ESalaryFirstSalaryDate := CalcDate('-91D', ESalaryBuffer."Salary Processing Date");
                    if ESalaryBuffer.Find('-') then begin
                        repeat
                            if (ESalaryBuffer."Salary Processing Date" >= ESalaryFirstSalaryDate) and (ESalaryBuffer."Salary Processing Date" <= ESalaryLastSalaryDate) then begin
                                CummulativeNet := CummulativeNet + ESalaryBuffer.Amount;
                                AvarageNetPay := CummulativeNet / 3;
                            end;
                        until ESalaryBuffer.Next = 0;
                    end;
                end;
                Gensetup.Get();
                //***IF Member Meets the Above Parameters the Check for Qualification Amount
                if (Vendor."Salary Processing" = true) and (DepositShareBal > 10000) and (Defaulter = false) then begin
                    EQualificationAmount := AvarageNetPay * (Gensetup."E-Loan Qualification (%)" / 100);
                    Vendor."E-Loan Qualification Amount" := EQualificationAmount;
                    Vendor.Modify;
                end;
                /*
				MESSAGE('ESalaryLastDate is %1',ESalaryLastSalaryDate);
				MESSAGE('ESalaryFistDate is %1',ESalaryFirstSalaryDate);
				MESSAGE('CummulativeNet is %1',CummulativeNet);
				MESSAGE('AvarageNet Pay is %1',AvarageNetPay);
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
        ;

    end;

    trigger OnPreReport()
    begin
        ;

    end;

    var
        Cust: Record "Members Register";
        DepositShareBal: Decimal;
        LoansRec: Record "Loans Register";
        Defaulter: Boolean;
        STO: Record "Standing Orders";
        StoDedAmount: Decimal;
        LoanRepayAmount: Decimal;
        ESalaryBuffer: Record "E-Loan Salary Buffer";
        ESalaryLastSalaryDate: Date;
        ESalaryFirstSalaryDate: Date;
        CummulativeNet: Decimal;
        AvarageNetPay: Decimal;
        Gensetup: Record "Sacco General Set-Up";
        EQualificationAmount: Decimal;

    var
}