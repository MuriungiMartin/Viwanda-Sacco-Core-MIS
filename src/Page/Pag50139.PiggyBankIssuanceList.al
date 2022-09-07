#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50139 "Piggy Bank Issuance List"
{
    CardPageID = "Piggy Bank Issuance Card";
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Piggy Bank Issuance";
    SourceTableView = where(Issued = filter(false));

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
                field("Member Account No"; "Member Account No")
                {
                    ApplicationArea = Basic;
                }
                field("Member Name"; "Member Name")
                {
                    ApplicationArea = Basic;
                }
                field("Piggy Bank Account"; "Piggy Bank Account")
                {
                    ApplicationArea = Basic;
                }
                field("Captured On"; "Captured On")
                {
                    ApplicationArea = Basic;
                }
                field("Captured By"; "Captured By")
                {
                    ApplicationArea = Basic;
                }
                field(Issued; Issued)
                {
                    ApplicationArea = Basic;
                }
                field("Issued By"; "Issued By")
                {
                    ApplicationArea = Basic;
                }
                field("Issued On"; "Issued On")
                {
                    ApplicationArea = Basic;
                }
                field("Collected By"; "Collected By")
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

