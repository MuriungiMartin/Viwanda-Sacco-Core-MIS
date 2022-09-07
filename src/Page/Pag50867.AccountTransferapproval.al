#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50867 "Account Transfer approval"
{
    Editable = false;
    PageType = Card;
    SourceTable = "Funds Transfer Logs";

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
                field("Source Account"; "Source Account")
                {
                    ApplicationArea = Basic;
                }
                field("Destination Account"; "Destination Account")
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
                field("Member No"; "Member No")
                {
                    ApplicationArea = Basic;
                }
                field("No. Series"; "No. Series")
                {
                    ApplicationArea = Basic;
                }
                field("External Transfer"; "External Transfer")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Code"; "Transaction Code")
                {
                    ApplicationArea = Basic;
                }
                field("Transfer Verified"; "Transfer Verified")
                {
                    ApplicationArea = Basic;
                }
                field("Recipient ID Number"; "Recipient ID Number")
                {
                    ApplicationArea = Basic;
                }
                field("Posting Date"; "Posting Date")
                {
                    ApplicationArea = Basic;
                }
                field(Posted; Posted)
                {
                    ApplicationArea = Basic;
                }
                field("Reference No"; "Reference No")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Status)
                {
                    ApplicationArea = Basic;
                }
                field(Comments; Comments)
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Type"; "Transaction Type")
                {
                    ApplicationArea = Basic;
                }
                field(Telephone; Telephone)
                {
                    ApplicationArea = Basic;
                }
                field(Description; Description)
                {
                    ApplicationArea = Basic;
                }
                field("Source Account Type"; "Source Account Type")
                {
                    ApplicationArea = Basic;
                }
                field("Destination Account Name"; "Destination Account Name")
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

