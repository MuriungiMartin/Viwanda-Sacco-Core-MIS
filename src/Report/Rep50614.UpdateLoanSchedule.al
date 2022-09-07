
Report 50614 "Update Loan Schedule"
{
    RDLCLayout = 'Layouts/UpdateLoanSchedule.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Loan Repayment Schedule Buffer"; "Loan Repayment Schedule Buffer")
        {

            trigger OnAfterGetRecord();
            begin
                if ObjLoanDetails.Get("Loan No") then begin
                    ObjRepaymentSchedule.Init;
                    ObjRepaymentSchedule."Loan No." := "Loan Repayment Schedule Buffer"."Loan No";
                    ObjRepaymentSchedule."Member No." := ObjLoanDetails."Client Code";
                    ObjRepaymentSchedule."Member Name" := ObjLoanDetails."Client Name";
                    ObjRepaymentSchedule."Instalment No" := "Loan Repayment Schedule Buffer".Instalment;
                    ObjRepaymentSchedule."Repayment Date" := "Loan Repayment Schedule Buffer"."Repayment Date";
                    ObjRepaymentSchedule."Loan Balance" := "Loan Repayment Schedule Buffer"."Loan Balance";
                    ObjRepaymentSchedule."Monthly Repayment" := "Loan Repayment Schedule Buffer"."Monthly Repayment";
                    ObjRepaymentSchedule."Principal Repayment" := "Loan Repayment Schedule Buffer"."Principle Repayment";
                    ObjRepaymentSchedule."Monthly Interest" := "Loan Repayment Schedule Buffer"."Monthly Interest";
                    ObjRepaymentSchedule."Monthly Insurance" := "Loan Repayment Schedule Buffer"."Monthly Insurance";
                    ObjRepaymentSchedule."Entry No" := "Loan Repayment Schedule Buffer"."Entry No";
                    ObjRepaymentSchedule.Insert;
                end;
                if ObjLoanDetails.Get("Loan No") then begin
                    ObjRepaymentScheduleTemp.Init;
                    ObjRepaymentScheduleTemp."Loan No." := "Loan Repayment Schedule Buffer"."Loan No";
                    ObjRepaymentScheduleTemp."Member No." := ObjLoanDetails."Client Code";
                    ObjRepaymentScheduleTemp."Member Name" := ObjLoanDetails."Client Name";
                    ObjRepaymentScheduleTemp."Instalment No" := "Loan Repayment Schedule Buffer".Instalment;
                    ObjRepaymentScheduleTemp."Repayment Date" := "Loan Repayment Schedule Buffer"."Repayment Date";
                    ObjRepaymentScheduleTemp."Loan Balance" := "Loan Repayment Schedule Buffer"."Loan Balance";
                    ObjRepaymentScheduleTemp."Monthly Repayment" := "Loan Repayment Schedule Buffer"."Monthly Repayment";
                    ObjRepaymentScheduleTemp."Principal Repayment" := "Loan Repayment Schedule Buffer"."Principle Repayment";
                    ObjRepaymentScheduleTemp."Monthly Interest" := "Loan Repayment Schedule Buffer"."Monthly Interest";
                    ObjRepaymentScheduleTemp."Monthly Insurance" := "Loan Repayment Schedule Buffer"."Monthly Insurance";
                    ObjRepaymentScheduleTemp."Entry No" := "Loan Repayment Schedule Buffer"."Entry No";
                    ObjRepaymentScheduleTemp.Insert;
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
        ObjLoanDetails: Record "Loans Register";
        ObjRepaymentSchedule: Record "Loan Repayment Schedule";
        ObjRepaymentScheduleTemp: Record "Loan Repayment Schedule Temp";

    var
}

