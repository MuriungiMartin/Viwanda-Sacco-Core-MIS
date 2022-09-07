#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50156 "Scheduled Statements"
{
    CardPageID = "Scheduled Statements Card";
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Scheduled Statements";

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
                field("Statement Period"; "Statement Period")
                {
                    ApplicationArea = Basic;
                }
                field(Frequency; Frequency)
                {
                    ApplicationArea = Basic;
                }
                field("Output Format"; "Output Format")
                {
                    ApplicationArea = Basic;
                }
                field("Days of Week"; "Days of Week")
                {
                    ApplicationArea = Basic;
                }
                field("Days Of Month"; "Days Of Month")
                {
                    ApplicationArea = Basic;
                }
                field("Statement Type"; "Statement Type")
                {
                    ApplicationArea = Basic;
                }
                field("Schedule Status"; "Schedule Status")
                {
                    ApplicationArea = Basic;
                }
                field("Created By"; "Created By")
                {
                    ApplicationArea = Basic;
                }
                field("Created On"; "Created On")
                {
                    ApplicationArea = Basic;
                }
                field("Activated By"; "Activated By")
                {
                    ApplicationArea = Basic;
                }
                field("Activated On"; "Activated On")
                {
                    ApplicationArea = Basic;
                }
                field("Stopped By"; "Stopped By")
                {
                    ApplicationArea = Basic;
                }
                field("Stopped On"; "Stopped On")
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

