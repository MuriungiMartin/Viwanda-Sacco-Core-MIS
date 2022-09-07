#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50622 "CloudPESA Transactions"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "CloudPESA Transactions";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Entry; Entry)
                {
                    ApplicationArea = Basic;
                }
                field("Document No"; "Document No")
                {
                    ApplicationArea = Basic;
                }
                field("Document Date"; "Document Date")
                {
                    ApplicationArea = Basic;
                }
                field("Account No"; "Account No")
                {
                    ApplicationArea = Basic;
                }
                field("Acc Name"; "Acc Name")
                {
                    ApplicationArea = Basic;
                    Caption = 'Account Name';
                }
                field(Amount; Amount)
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Time"; "Transaction Time")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Type"; "Transaction Type")
                {
                    ApplicationArea = Basic;
                }
                field("Telephone Number"; "Telephone Number")
                {
                    ApplicationArea = Basic;
                }
                field(Posted; Posted)
                {
                    ApplicationArea = Basic;
                }
                field("Date Posted"; "Date Posted")
                {
                    ApplicationArea = Basic;
                }
                field("Account No2"; "Account No2")
                {
                    ApplicationArea = Basic;
                }
                field("Loan No"; "Loan No")
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
                field(Charge; Charge)
                {
                    ApplicationArea = Basic;
                }
                field(Description; Description)
                {
                    ApplicationArea = Basic;
                }
                field(Client; Client)
                {
                    ApplicationArea = Basic;
                }
                field("Posting Date"; "Posting Date")
                {
                    ApplicationArea = Basic;
                }
                field(Reversed; Reversed)
                {
                    ApplicationArea = Basic;
                }
                field("Reversed On"; "Reversed On")
                {
                    ApplicationArea = Basic;
                }
                field("Mpesa Receipt NO"; "Mpesa Receipt NO")
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

