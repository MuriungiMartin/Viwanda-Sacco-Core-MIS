#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50771 "Cheque  Nos Register"
{
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Audit General Setup";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Monthy Credits V TurnOver C%"; "Monthy Credits V TurnOver C%")
                {
                    ApplicationArea = Basic;
                }
                field("Cumm. Daily Credits Limit Amt"; "Cumm. Daily Credits Limit Amt")
                {
                    ApplicationArea = Basic;
                }
                field("Cumm. Daily Debits Limit Amt"; "Cumm. Daily Debits Limit Amt")
                {
                    ApplicationArea = Basic;
                }
                field("Primary key"; "Primary key")
                {
                    ApplicationArea = Basic;
                }
                field("Notification Group Email"; "Notification Group Email")
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

