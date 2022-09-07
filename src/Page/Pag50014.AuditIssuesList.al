#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50014 "Audit Issues List"
{
    CardPageID = "Audit Tracker Card";
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Audit Issues Tracker";

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
                field("Date Of Audit"; "Date Of Audit")
                {
                    ApplicationArea = Basic;
                }
                field("Theme Description"; "Theme Description")
                {
                    ApplicationArea = Basic;
                }
                field("Mgt Action Point"; "Mgt Action Point")
                {
                    ApplicationArea = Basic;
                }
                field("Action Date"; "Action Date")
                {
                    ApplicationArea = Basic;
                }
                field("Day Past"; "Day Past")
                {
                    ApplicationArea = Basic;
                }
                field("Action Owner"; "Action Owner")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Status)
                {
                    ApplicationArea = Basic;
                }
                field("Combined Status"; "Combined Status")
                {
                    ApplicationArea = Basic;
                }
                field("Mgt Response"; "Mgt Response")
                {
                    ApplicationArea = Basic;
                }
                field("Revised Mgt Comment"; "Revised Mgt Comment")
                {
                    ApplicationArea = Basic;
                }
                field("Audit Opinion On Closure"; "Audit Opinion On Closure")
                {
                    ApplicationArea = Basic;
                }
                field("Mgt Comment After Review"; "Mgt Comment After Review")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        UserSetup.Reset;
        UserSetup.SetRange(UserSetup."User ID", UserId);
        if UserSetup.FindSet then begin
            if UserSetup."Is Manager" = false then
                Error('You do not have rights to view this page.');
        end;
    end;

    var
        UserSetup: Record "User Setup";
}

