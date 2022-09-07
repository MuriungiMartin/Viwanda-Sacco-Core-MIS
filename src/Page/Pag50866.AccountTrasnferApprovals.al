#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50866 "Account Trasnfer Approvals"
{
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Mobile tranfer approvals";
    SourceTableView = sorting("Entry No")
                      order(descending);

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No"; "Entry No")
                {
                    ApplicationArea = Basic;
                }
                field("Signatory Name"; "Signatory Name")
                {
                    ApplicationArea = Basic;
                }
                field("Mobile No"; "Mobile No")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Status)
                {
                    ApplicationArea = Basic;
                }
                field("Transaction No"; "Transaction No")
                {
                    ApplicationArea = Basic;
                }
                field(Token; Token)
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Type"; "Transaction Type")
                {
                    ApplicationArea = Basic;
                }
                field("ID Number"; "ID Number")
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

