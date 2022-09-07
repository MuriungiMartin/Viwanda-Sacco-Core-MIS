#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50664 "Members Only"
{
    PageType = CardPart;
    SourceTable = "Membership Cue";

    layout
    {
        area(content)
        {
            cuegroup(Members)
            {
                field("Active Members"; "Active Members")
                {
                    ApplicationArea = Basic;
                    //image ="None";
                    Style = Favorable;
                    StyleExpr = true;
                }
                field("Dormant Members"; "Dormant Members")
                {
                    ApplicationArea = Basic;
                    //image ="None";
                }
                field("Non-Active Members"; "Non-Active Members")
                {
                    ApplicationArea = Basic;
                    //Image = PEople;
                    Style = Attention;
                    StyleExpr = true;
                }
                field("Deceased Members"; "Deceased Members")
                {
                    ApplicationArea = Basic;
                    Image = People;
                }
                field("Withdrawn Members"; "Withdrawn Members")
                {
                    ApplicationArea = Basic;
                    // //image ="None";
                }
            }
            cuegroup("Account Category")
            {
                Caption = 'Account Categories';
                field("Group Accounts"; "Group Accounts")
                {
                    ApplicationArea = Basic;
                }
                field("Joint Accounts"; "Joint Accounts")
                {
                    ApplicationArea = Basic;
                    //image ="None";
                }
            }
            cuegroup("Account Categories")
            {
                Caption = 'Gender';
                field("Female Members"; "Female Members")
                {
                    ApplicationArea = Basic;
                    //image ="None";
                }
                field("Male Members"; "Male Members")
                {
                    ApplicationArea = Basic;
                    //image ="None";
                }
                field("Junior Members"; "Junior Members")
                {
                    ApplicationArea = Basic;
                    Image = Library;
                }
            }
            cuegroup(Control2)
            {
                field("Requests to Approve"; "Requests to Approve")
                {
                    ApplicationArea = Basic;
                    DrillDownPageID = "Requests to Approve";
                }
                field("Requests Sent for Approval"; "Requests Sent for Approval")
                {
                    ApplicationArea = Basic;
                    DrillDownPageID = Approvals;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        if not Get(UserId) then begin
            Init;
            "User ID" := UserId;
            Insert;
        end;
    end;
}

