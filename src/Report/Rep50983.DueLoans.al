report 50983 "DueLoans"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;




    dataset
    {
        dataitem("Loans Register"; "Loans Register")
        {
            column(Loan__No_; "Loan  No.")
            {

            }
            column(Client_Code; "Client Code")
            {

            }
            column(Client_Name; "Client Name")
            {

            }
            column(Issued_Date; "Issued Date")
            {

            }
            column(Expected_Date_of_Completion; "Expected Date of Completion")
            {

            }
            column(Due; Due)
            {

            }
            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin
                "Due Loans" := false;
                loanapp.Reset();
                loanapp.SetRange(loanapp."Loan  No.", "Loans Register"."Loan  No.");
                loanapp.SetFilter(loanapp."Expected Date of Completion", dfilter);
                if loanapp.Find('-') then begin
                    loanapp."Due Loans" := true;
                end;
                loanapp.Modify();
                loanapp.FilterGroup

            end;
        }
    }
    trigger OnPreReport()

    begin

        dfilter := format(today) + '..' + Format(CalcDate('CM', Today));
    end;

    // requestpage
    // {
    //     layout
    //     {
    //         area(Content)
    //         {
    //             group(GroupName)
    //             {
    //                 field()
    //                 {
    //                     ApplicationArea = All;

    //                 }
    //             }
    //         }
    //     }

    //     actions
    //     {
    //         area(processing)
    //         {
    //             action(ActionName)
    //             {
    //                 ApplicationArea = All;

    //             }
    //         }
    //     }
    // }

    // rendering
    // {
    //     layout(CustomLayout)
    //     {
    //         Type = RDLC;
    //         LayoutFile = 'mylayout.rdlc';
    //     }
    // }

    var
        myInt: Integer;
        dfilter: text;
        Due: Boolean;
        loanapp: Record "Loans Register";



}