#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50680 "Cheque B. Applications SubPage"
{
    PageType = ListPart;
    SourceTable = "Cheque Book Application";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Cheque Book Ordered"; "Cheque Book Ordered")
                {
                    ApplicationArea = Basic;
                }
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
                field("Application Date"; "Application Date")
                {
                    ApplicationArea = Basic;
                }
                field("Ordered On"; "Ordered On")
                {
                    ApplicationArea = Basic;
                }
                field("Received On"; "Received On")
                {
                    ApplicationArea = Basic;
                }
                field(Destroyed; Destroyed)
                {
                    ApplicationArea = Basic;
                }
                field(Collected; Collected)
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

