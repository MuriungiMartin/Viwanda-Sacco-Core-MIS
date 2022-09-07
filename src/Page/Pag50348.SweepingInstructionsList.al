#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50348 "Sweeping Instructions List"
{
    CardPageID = "Sweeping Instructions Card";
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Member Sweeping Instructions";
    SourceTableView = where(Effected = filter(false));

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
                field("Monitor Account"; "Monitor Account")
                {
                    ApplicationArea = Basic;
                }
                field("Monitor Account Type Desc"; "Monitor Account Type Desc")
                {
                    ApplicationArea = Basic;
                }
                field("Minimum Account Threshold"; "Minimum Account Threshold")
                {
                    ApplicationArea = Basic;
                }
                field("Maximum Account Threshold"; "Maximum Account Threshold")
                {
                    ApplicationArea = Basic;
                }
                field("Investment Account"; "Investment Account")
                {
                    ApplicationArea = Basic;
                }
                field("Investment Account Type Desc"; "Investment Account Type Desc")
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

