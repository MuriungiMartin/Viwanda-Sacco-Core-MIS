#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50356 "New Account Freeze Amount"
{
    CardPageID = "Account Freeze Amount Card";
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Member Account Freeze Details";
    SourceTableView = where(Frozen = filter(false));

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
                field("Member No"; "Member No")
                {
                    ApplicationArea = Basic;
                }
                field("Member Name"; "Member Name")
                {
                    ApplicationArea = Basic;
                }
                field("Account No"; "Account No")
                {
                    ApplicationArea = Basic;
                }
                field("Amount to Freeze"; "Amount to Freeze")
                {
                    ApplicationArea = Basic;
                }
                field("Reason For Freezing"; "Reason For Freezing")
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
                field(Frozen; Frozen)
                {
                    ApplicationArea = Basic;
                }
                field("Frozen On"; "Frozen On")
                {
                    ApplicationArea = Basic;
                }
                field("Frozen By"; "Frozen By")
                {
                    ApplicationArea = Basic;
                }
                field(Unfrozen; Unfrozen)
                {
                    ApplicationArea = Basic;
                }
                field("Unfrozen On"; "Unfrozen On")
                {
                    ApplicationArea = Basic;
                }
                field("Unfrozen By"; "Unfrozen By")
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

