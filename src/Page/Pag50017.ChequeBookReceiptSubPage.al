#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50017 "Cheque Book Receipt SubPage"
{
    PageType = ListPart;
    SourceTable = "Cheque Book Receipt Lines";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Cheque Book Application No"; "Cheque Book Application No")
                {
                    ApplicationArea = Basic;
                }
                field("Cheque Book Account No"; "Cheque Book Account No")
                {
                    ApplicationArea = Basic;
                }
                field("Account Name"; "Account Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Cheque Book Application Date"; "Cheque Book Application Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Received; Received)
                {
                    ApplicationArea = Basic;
                }
                field("Received By"; "Received By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Received On"; "Received On")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }
}

