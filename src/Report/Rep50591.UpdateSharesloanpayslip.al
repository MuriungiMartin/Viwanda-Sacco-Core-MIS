
Report 50591 "Update Shares & loan payslip"
{
    RDLCLayout = 'Layouts/UpdateShares&loanpayslip.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("prPeriod Transactions."; "prPeriod Transactions.")
        {
            RequestFilterFields = "Employee Code";
            trigger OnAfterGetRecord();
            begin
                //Update shares on Payslips manu
                if "prPeriod Transactions."."Transaction Code" = 'D025' then begin
                    memb.SetRange(memb."Customer No.", "prPeriod Transactions."."Employee Code");
                    memb.SetRange(memb."Transaction Type", memb."transaction type"::Loan);
                    if memb.Find('-') then begin
                        Totalshares := 0;
                        repeat
                            Totalshares := Totalshares + memb.Amount;
                        until memb.Next = 0;
                        Totalshares := Totalshares * -1;
                    end;
                    "prPeriod Transactions.".Balance := Totalshares;
                    "prPeriod Transactions.".Modify;
                end;
                //end of shares update
                //Getting Loan OutStanding Balance Manu
                if ("prPeriod Transactions."."Loan Number" <> '') and ("prPeriod Transactions."."coop parameters" = "prPeriod Transactions."."coop parameters"::loan) then begin
                    LoanR.SetRange(LoanR."Loan  No.", "Loan Number");
                    ;
                    if LoanR.Find('-') then begin
                        LNPric := 0;
                        LoanR.CalcFields(LoanR."Outstanding Balance");
                        LNPric := LoanR."Outstanding Balance";
                    end;
                    //End of getting loan
                    //updating Payroll Employee transactions
                    "prPeriod Transactions.".Balance := (LNPric);
                    "prPeriod Transactions.".Modify;
                end;
                if ("prPeriod Transactions."."Loan Number" <> '') and ("prPeriod Transactions."."coop parameters" = "prPeriod Transactions."."coop parameters"::"loan Interest") then begin
                    LoanR.SetRange(LoanR."Loan  No.", "Loan Number");
                    if LoanR.Find('-') then begin
                        LNPric := 0;
                        LoanR.CalcFields(LoanR."Interest Due");
                        LNPric := LoanR."Interest Due";
                    end;
                    //End of getting loan
                    //updating Payroll Employee transactions
                    "prPeriod Transactions.".Balance := (LNPric);
                    "prPeriod Transactions.".Modify;
                end;
                //end of Loan D005 update
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
        Totalshares: Decimal;
        memb: Record "Member Ledger Entry";
        LoanR: Record "Loans Register";
        membRep: Record "Member Ledger Entry";
        LastAmount: Decimal;
        LNRepay: Decimal;
        LNPric: Decimal;

    var

}