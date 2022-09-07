#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50775 "Suspicious Transactions"
{
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Audit Suspicious Transactions";

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
                field("Account No"; "Account No")
                {
                    ApplicationArea = Basic;
                }
                field("Account Name"; "Account Name")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Date"; "Transaction Date")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Type"; "Transaction Type")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Amount"; "Transaction Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Transacted By"; "Transacted By")
                {
                    ApplicationArea = Basic;
                }
                field("Max Credits Allowable"; "Max Credits Allowable")
                {
                    ApplicationArea = Basic;
                    Caption = 'Max Credits Allowable For the Month';
                }
                field("Month TurnOver Amount"; "Month TurnOver Amount")
                {
                    ApplicationArea = Basic;
                    Caption = 'Monthly TurnOver Amount';
                }
                field("Violation Transaction Type"; "Violation Transaction Type")
                {
                    ApplicationArea = Basic;
                    Caption = 'Violation Type';
                    Importance = Promoted;
                    Style = AttentionAccent;
                    StyleExpr = true;
                }
            }
        }
    }

    actions
    {
    }
}

