#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50660 "E-Banking Joint Transactions"
{
    CardPageID = "E-Banking Joint Trans Card";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Funds Transfer Logs";
    SourceTableView = sorting("Document No")
                      order(descending);

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
                    Caption = 'Initiated By (Member No)';
                }
                field(Telephone; Telephone)
                {
                    ApplicationArea = Basic;
                    Caption = 'Initiated By (Mobile No)';
                }
                field("Transaction Type"; "Transaction Type")
                {
                    ApplicationArea = Basic;
                }
                field("Source Account"; "Source Account")
                {
                    ApplicationArea = Basic;
                }
                field("Source Account Name"; "Source Account Name")
                {
                    ApplicationArea = Basic;
                }
                field("Destination Account"; "Destination Account")
                {
                    ApplicationArea = Basic;
                }
                field("Destination Account Name"; "Destination Account Name")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Amount"; "Transaction Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Date"; "Transaction Date")
                {
                    ApplicationArea = Basic;
                }
                field(Description; Description)
                {
                    ApplicationArea = Basic;
                    Caption = 'Transaction Description';
                }
                field(Status; Status)
                {
                    ApplicationArea = Basic;
                }
                field("Posting Date"; "Posting Date")
                {
                    ApplicationArea = Basic;
                }
                field(Comments; Comments)
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

