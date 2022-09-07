#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50638 "Loan Reschedule List"
{
    CardPageID = "Loan Reschedule Card";
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Loan Rescheduling";
    SourceTableView = where(Rescheduled = filter(false));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No"; "Document No")
                {
                    ApplicationArea = Basic;
                }
                field("Member No"; "Member No")
                {
                    ApplicationArea = Basic;
                }
                field("Loan No"; "Loan No")
                {
                    ApplicationArea = Basic;
                }
                field("Rescheduled By"; "Rescheduled By")
                {
                    ApplicationArea = Basic;
                }
                field("Rescheduled Date"; "Rescheduled Date")
                {
                    ApplicationArea = Basic;
                }
                field("Repayment Amount"; "Repayment Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Principle Repayment"; "Loan Principle Repayment")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Interest Repayment"; "Loan Interest Repayment")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
}

