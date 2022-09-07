#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50530 "Cheque Book Application - New"
{
    CardPageID = "Cheque Application";
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Cheque Book Application";
    SourceTableView = where("Cheque Book Ordered" = filter(false));

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
                field("Cheque Book Account No."; "Cheque Book Account No.")
                {
                    ApplicationArea = Basic;
                }
                field("Application Date"; "Application Date")
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
                field("Cheque Book Fee Charged"; "Cheque Book Fee Charged")
                {
                    ApplicationArea = Basic;
                }
                field("Cheque Book Fee Charged On"; "Cheque Book Fee Charged On")
                {
                    ApplicationArea = Basic;
                }
                field("Cheque Book Fee Charged By"; "Cheque Book Fee Charged By")
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

