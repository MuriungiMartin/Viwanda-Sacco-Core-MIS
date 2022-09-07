#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50077 "Claims Types List"
{
    CardPageID = "Claim Types Card";
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Funds Transaction Types";
    SourceTableView = where("Transaction Type" = const(Claim));

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
                field("Transaction Type"; "Transaction Type")
                {
                    ApplicationArea = Basic;
                }
                field("Account Type"; "Account Type")
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
                field("Default Grouping"; "Default Grouping")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        "Transaction Type" := "transaction type"::Claim;
    end;
}

