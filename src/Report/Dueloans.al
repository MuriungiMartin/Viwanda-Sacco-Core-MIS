report 50983 DueLoans
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
                "Loans Register".Reset();

                "Loans Register".SetFilter("Loans Register"."Expected Date of Completion", dfilter);
                if "Loans Register".Find('-') then begin
                    "Loans Register"."Due Loans" := true;
                end;
                "Loans Register".Modify();

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
    //         LayoutFile = 'mylayout.rdl';
    //     }
    // }

    var
        myInt: Integer;
        dfilter: text;
        Due: Boolean;



}