#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50774 "Audit General Setup"
{
    PageType = Card;
    SourceTable = "Audit General Setup";
    UsageCategory = Administration;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Monthy Credits V TurnOver C%"; "Monthy Credits V TurnOver C%")
                {
                    ApplicationArea = Basic;
                    Caption = 'Monthy Credits Vs TurnOver Control %';
                }
                field("Cumm. Daily Credits Limit Amt"; "Cumm. Daily Credits Limit Amt")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cumm. Daily Credits Limit Amount';
                }
                field("Cumm. Daily Debits Limit Amt"; "Cumm. Daily Debits Limit Amt")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cumm. Daily Debits Limit Amount';
                }
                field("Notification Group Email"; "Notification Group Email")
                {
                    ApplicationArea = Basic;
                }
                field("Member TurnOver Period"; "Member TurnOver Period")
                {
                    ApplicationArea = Basic;
                }
                field("Member TurnOver Per Interger"; "Member TurnOver Per Interger")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member TurnOver Period Interger';
                }
                field("Expected Monthly TurnOver Peri"; "Expected Monthly TurnOver Peri")
                {
                    ApplicationArea = Basic;
                    Caption = 'Expected Monthly TurnOver Period';
                }
                field("Expected M.TurnOver Period Int"; "Expected M.TurnOver Period Int")
                {
                    ApplicationArea = Basic;
                    Caption = 'Expected Annual TurnOver Period Integer';
                }
            }
            group("Issue Tracker")
            {
                field("Over Due Date"; "Over Due Date")
                {
                    ApplicationArea = Basic;
                }
                field("Due Date"; "Due Date")
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

