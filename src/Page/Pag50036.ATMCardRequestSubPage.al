#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50036 "ATM Card Request SubPage"
{
    PageType = ListPart;
    SourceTable = "ATM Card Request Lines";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("ATM Application No"; "ATM Application No")
                {
                    ApplicationArea = Basic;
                }
                field("ATM Card Account No"; "ATM Card Account No")
                {
                    ApplicationArea = Basic;
                }
                field("Account Name"; "Account Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("ATM Card Application Date"; "ATM Card Application Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Request Type"; "Request Type")
                {
                    ApplicationArea = Basic;
                }
                field(Ordered; Ordered)
                {
                    ApplicationArea = Basic;
                }
                field("Ordered On"; "Ordered On")
                {
                    ApplicationArea = Basic;
                }
                field("Ordered By"; "Ordered By")
                {
                    ApplicationArea = Basic;
                }
                field("ATM Card No"; "ATM Card No")
                {
                    ApplicationArea = Basic;
                }
                field("ID No"; "ID No")
                {
                    ApplicationArea = Basic;
                }
                field("Phone No"; "Phone No")
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

