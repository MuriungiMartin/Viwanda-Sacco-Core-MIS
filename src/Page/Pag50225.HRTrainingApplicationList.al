#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50225 "HR Training Application List"
{
    CardPageID = "HR Training Application Card";
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "HR Training Applications";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field("Application No"; "Application No")
                {
                    ApplicationArea = Basic;
                }
                field("Course Title"; "Course Title")
                {
                    ApplicationArea = Basic;
                    Style = StrongAccent;
                    StyleExpr = true;
                }
                field(Description; Description)
                {
                    ApplicationArea = Basic;
                }
                field("Purpose of Training"; "Purpose of Training")
                {
                    ApplicationArea = Basic;
                }
                field("From Date"; "From Date")
                {
                    ApplicationArea = Basic;
                }
                field("To Date"; "To Date")
                {
                    ApplicationArea = Basic;
                }
                field("Cost Of Training"; "Cost Of Training")
                {
                    ApplicationArea = Basic;
                    Caption = 'Estimated Cost';
                }
                field("Approved Cost"; "Approved Cost")
                {
                    ApplicationArea = Basic;
                }
                field(Provider; "Provider Name")
                {
                    ApplicationArea = Basic;
                }
                field("No. of Participant"; "No. of Participant")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Status)
                {
                    ApplicationArea = Basic;
                    Style = Strong;
                    StyleExpr = true;
                }
            }
        }
        area(factboxes)
        {
            part(Control1102755002; "HR Trainings Factbox")
            {
                SubPageLink = "Application No" = field("Application No");
            }
        }
    }

    actions
    {
        area(reporting)
        {
            action("Training Applications List")
            {
                ApplicationArea = Basic;
                Caption = 'Training Applications List';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "HR Training Applications List";
            }
            action("Training Applications")
            {
                ApplicationArea = Basic;
                Caption = 'Training Applications';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "HR Training ApplicationsS";
            }
        }
    }
}

