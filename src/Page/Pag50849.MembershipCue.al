#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50849 "Membership Cue"
{
    PageType = CardPart;
    SourceTable = "Membership Cue";
    // DataAccessIntent

    layout
    {
        area(content)
        {
            // usercontrol(logo; "Logo Control Addin")
            // {
            //     ApplicationArea = basic, suite;
            // }
            cuegroup(Members)
            {
                field("Active Members"; "Active Members")
                {
                    ApplicationArea = Basic;
                    Image = "None";
                    Style = Favorable;
                    StyleExpr = true;
                    DrillDownPageId = "Members List";

                }
                field("Dormant Members"; "Dormant Members")
                {
                    ApplicationArea = Basic;
                    Image = "None";
                    DrillDownPageId = "Members List";

                }
                field("Non-Active Members"; "Non-Active Members")
                {
                    ApplicationArea = Basic;
                    Image = PEople;
                    Style = Attention;
                    StyleExpr = true;
                    Visible = true;
                    DrillDownPageId = "Members List";

                }
                field("Deceased Members"; "Deceased Members")
                {
                    ApplicationArea = Basic;
                    Image = People;
                    DrillDownPageId = "Members List";

                }
                field("Withdrawn Members"; "Withdrawn Members")
                {
                    ApplicationArea = Basic;
                    Image = "None";
                    DrillDownPageId = "Members List";

                }
                //     field("Group Accounts"; "Group Accounts")
                //     {
                //         ApplicationArea = Basic;
                //         DrillDownPageId = "Members List";

                //     }
                //     field("Joint Accounts"; "Joint Accounts")
                //     {
                //         ApplicationArea = Basic;
                //         DrillDownPageId = "Members List";

                //     }
            }
            cuegroup("Account Categories")
            {
                field("Female Members"; "Female Members")
                {
                    ApplicationArea = Basic;
                    Image = "None";
                    DrillDownPageId = "Members List";

                }
                field("Male Members"; "Male Members")
                {
                    ApplicationArea = Basic;
                    Image = "None";
                    DrillDownPageId = "Members List";


                }
                // field("Junior Members"; "Junior Members")
                // {
                //     ApplicationArea = Basic;
                //     Image = Library;
                //     DrillDownPageId = "Members List";
                // }
            }
            cuegroup(Loans)
            {
                Caption = 'Loans';
                field("Development Loan"; "Development Loan")
                {
                    ApplicationArea = Basic;
                    DrillDownPageID = "Loans  List All";
                    Image = "None";
                    LookupPageID = "Loans  List All";
                }
                field("Emergency Loan"; "Emergency Loan")
                {
                    ApplicationArea = Basic;
                    DrillDownPageID = "Loans  List All";
                    Image = "None";
                    LookupPageID = "Loans  List All";
                }
                field("Loans due In a Month"; "Loans due In a Month")
                {
                    ApplicationArea = Basic;
                }

                // field("Business Loan"; "Business Loan")
                // {
                //     ApplicationArea = Basic;
                //     Caption = 'Instant Laons';
                //     DrillDownPageID = "Loans  List All";
                //     Image = "None";
                //     LookupPageID = "Loans  List All";
                // }
                // field("Jijenge Loan"; "Jijenge Loan")
                // {
                //     ApplicationArea = Basic;
                //     Caption = 'Maono Shamba Loans';
                //     DrillDownPageID = "Loans  List All";
                //     Image = "None";
                //     LookupPageID = "Loans  List All";
                // }
                // field("School Fees Loan"; "School Fees Loan")
                // {
                //     ApplicationArea = Basic;
                //     DrillDownPageID = "Loans  List All";
                //     Image = "None";
                //     LookupPageID = "Loans  List All";
                // }
                // field("Corporate Loan"; "Corporate Loan")
                // {
                //     ApplicationArea = Basic;
                //     Caption = 'Super School Fees Loan';
                // }
                // field("Personal Loan"; "Personal Loan")
                // {
                //     ApplicationArea = Basic;
                //     Caption = 'Super Plus Loan';
                //     DrillDownPageID = "Loans  List All";
                //     Image = "None";
                //     LookupPageID = "Loans  List All";
                // }
                // field("Asset Finance"; "Asset Finance")
                // {
                //     ApplicationArea = Basic;
                //     Caption = 'Top Up Loan';
                //     DrillDownPageID = "Loans  List All";
                //     Image = "None";
                //     LookupPageID = "Loans  List All";
                // }
                // field("Community Development Loan"; "Community Development Loan")
                // {
                //     ApplicationArea = Basic;
                //     Caption = 'Vision Advance Loan';
                // }
                // field("Ufalme Project Loan"; "Ufalme Project Loan")
                // {
                //     ApplicationArea = Basic;
                //     Caption = 'Top Up Loan 1';
                //     DrillDownPageID = "Loans  List All";
                //     Image = "None";
                //     LookupPageID = "Loans  List All";
                // }

            }
            cuegroup(Approvals)
            {
                Caption = 'Approvals';
                field("Requests Sent for Approval"; "Requests Sent for Approval")
                {
                    ApplicationArea = Basic;
                    DrillDownPageID = "Approval Entries";
                }
                field("Requests to Approve"; "Requests to Approve")
                {
                    ApplicationArea = Basic;
                    DrillDownPageID = "Requests to Approve";
                }
            }
            // cuegroup(Leave)
            // {
            //     Caption = 'Leave';
            //     field("Leave Pending"; "Leave Pending")
            //     {
            //         ApplicationArea = Basic;
            //         DrillDownPageID = "HR Leave Applications List";
            //     }
            //     field("Leave Approved"; "Leave Approved")
            //     {
            //         ApplicationArea = Basic;
            //         DrillDownPageID = "HR Leave Applications List";
            //     }
            // }
            cuegroup("Pending Documents")
            {
                Caption = 'Pending Documents';
                field("Staff Claims Pending"; "Staff Claims Pending")
                {
                    ApplicationArea = Basic;
                }
                field("Staff Claims Approved"; "Staff Claims Approved")
                {
                    ApplicationArea = Basic;
                }
                field("Pending Cheque Payments"; "Pending Cheque Payments")
                {
                    ApplicationArea = Basic;
                }
                field("Approved Cheque Payments"; "Approved Cheque Payments")
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
        if not Get(UserId) then begin
            Init;
            "User ID" := UserId;
            Insert;
        end;
    end;


}

