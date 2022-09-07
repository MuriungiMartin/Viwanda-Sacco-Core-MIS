#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50579 "CloudPESA Paybill Trans"
{
    CardPageID = "CloudPESA Paybill Tran Card";
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "CloudPESA MPESA Trans";

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
                field("Transaction Date"; "Transaction Date")
                {
                    ApplicationArea = Basic;
                }
                field("Account No"; "Account No")
                {
                    ApplicationArea = Basic;
                }
                field(Description; Description)
                {
                    ApplicationArea = Basic;
                }
                field(Amount; Amount)
                {
                    ApplicationArea = Basic;
                }
                field(Posted; Posted)
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Time"; "Transaction Time")
                {
                    ApplicationArea = Basic;
                }
                field("Paybill Acc Balance"; "Paybill Acc Balance")
                {
                    ApplicationArea = Basic;
                }
                field("Document Date"; "Document Date")
                {
                    ApplicationArea = Basic;
                }
                field("Date Posted"; "Date Posted")
                {
                    ApplicationArea = Basic;
                }
                field("Time Posted"; "Time Posted")
                {
                    ApplicationArea = Basic;
                }
                field("Approved By"; "Approved By")
                {
                    ApplicationArea = Basic;
                }
                field("Key Word"; "Key Word")
                {
                    ApplicationArea = Basic;
                }
                field(Telephone; Telephone)
                {
                    ApplicationArea = Basic;
                }
                field("Account Name"; "Account Name")
                {
                    ApplicationArea = Basic;
                }
                field("Needs Manual Posting"; "Needs Manual Posting")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(ImportTran)
            {
                ApplicationArea = Basic;

                trigger OnAction()
                begin
                    Xmlport.Run(51516501);
                end;
            }
        }
    }
}

