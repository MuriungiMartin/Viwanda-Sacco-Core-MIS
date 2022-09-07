#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50863 "Equity Bank Deposits"
{
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Equity Transaction";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Id; Id)
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Id"; "Transaction Id")
                {
                    ApplicationArea = Basic;
                }
                field("Reference No"; "Reference No")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Date"; "Transaction Date")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Amount"; "Transaction Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Currency"; "Transaction Currency")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Type"; "Transaction Type")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Particular"; "Transaction Particular")
                {
                    ApplicationArea = Basic;
                }
                field("Phone No"; "Phone No")
                {
                    ApplicationArea = Basic;
                }
                field("Debit Account"; "Debit Account")
                {
                    ApplicationArea = Basic;
                }
                field("Debit Customer Name"; "Debit Customer Name")
                {
                    ApplicationArea = Basic;
                }
                field("Date Posted"; "Date Posted")
                {
                    ApplicationArea = Basic;
                }
                field("Date Processed"; "Date Processed")
                {
                    ApplicationArea = Basic;
                }
                field("BrTransaction Id"; "BrTransaction Id")
                {
                    ApplicationArea = Basic;
                }
                field(Processed; Processed)
                {
                    ApplicationArea = Basic;
                }
                field(Comments; Comments)
                {
                    ApplicationArea = Basic;
                }
                field(Posted; Posted)
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

