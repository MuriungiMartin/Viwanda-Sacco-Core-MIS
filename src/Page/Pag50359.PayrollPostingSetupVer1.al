#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50359 "Payroll Posting Setup Ver1"
{
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Payroll Posting Setup Ver1";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Transaction Code"; "Transaction Code")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Description"; "Transaction Description")
                {
                    ApplicationArea = Basic;
                }
                field("Debit G/L Account"; "Debit G/L Account")
                {
                    ApplicationArea = Basic;
                }
                field("Debit G/L Account Name"; "Debit G/L Account Name")
                {
                    ApplicationArea = Basic;
                }
                field("Credit G/L Account"; "Credit G/L Account")
                {
                    ApplicationArea = Basic;
                }
                field("Credit G/L Account Name"; "Credit G/L Account Name")
                {
                    ApplicationArea = Basic;
                }
                field("Sacco Deduction Type"; "Sacco Deduction Type")
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

