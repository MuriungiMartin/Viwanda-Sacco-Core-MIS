#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50662 "EBanking Joint Trans Approvers"
{
    PageType = ListPart;
    SourceTable = "Mobile tranfer approvals";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Mobile No"; "Mobile No")
                {
                    ApplicationArea = Basic;
                }
                field("Signatory Name"; "Signatory Name")
                {
                    ApplicationArea = Basic;
                }
                field("ID Number"; "ID Number")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Status)
                {
                    ApplicationArea = Basic;
                }
                field(Token; Token)
                {
                    ApplicationArea = Basic;
                }
                field("Generated On"; "Generated On")
                {
                    ApplicationArea = Basic;
                }
                field("Responded On"; "Responded On")
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

