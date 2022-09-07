#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50816 "Cheque Book Appl. - Processed"
{
    CardPageID = "Cheque Application";
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Cheque Book Application";
    SourceTableView = where("Cheque Book Ordered" = filter(true));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; "No.")
                {
                    ApplicationArea = Basic;
                }
                field("Account No."; "Account No.")
                {
                    ApplicationArea = Basic;
                }
                field(Name; Name)
                {
                    ApplicationArea = Basic;
                }
                field("ID No."; "ID No.")
                {
                    ApplicationArea = Basic;
                }
                field("Application Date"; "Application Date")
                {
                    ApplicationArea = Basic;
                }
                field("Cheque Book Account No."; "Cheque Book Account No.")
                {
                    ApplicationArea = Basic;
                }
                field("Begining Cheque No."; "Begining Cheque No.")
                {
                    ApplicationArea = Basic;
                }
                field("End Cheque No."; "End Cheque No.")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Status)
                {
                    ApplicationArea = Basic;
                }
                field("Requested By"; "Requested By")
                {
                    ApplicationArea = Basic;
                }
                field("Cheque Book Ordered"; "Cheque Book Ordered")
                {
                    ApplicationArea = Basic;
                }
                field("Ordered On"; "Ordered On")
                {
                    ApplicationArea = Basic;
                }
                field("Cheque Book Received"; "Cheque Book Received")
                {
                    ApplicationArea = Basic;
                }
                field("Received On"; "Received On")
                {
                    ApplicationArea = Basic;
                }
                field(Collected; Collected)
                {
                    ApplicationArea = Basic;
                }
                field("Date Collected"; "Date Collected")
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

