#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50085 "Tellers  Role Centre"
{
    Caption = 'Tellers  Role Centre';
    PageType = RoleCenter;
    RefreshOnActivate = true;

    layout
    {
        area(rolecenter)
        {
            group(Control2)
            {
                part(Control1000000018; "Members Only")
                {
                }
            }
            group(Cheques)
            {
                Caption = 'Cheques';
            }
            part(Control9; "Teller Cues")
            {
                Caption = 'Outward Cheques';
            }
            group(Outlook)
            {
                Caption = 'Outlook';
            }
            systempart(Control12; Outlook)
            {
            }
        }
    }

    actions
    {
        area(reporting)
        {
            action("Customer Care logs")
            {
                ApplicationArea = Basic;
                Caption = 'Customer Care logs';
                Image = "Report";
                RunObject = Report "Staff Claim  Slip Ver1";
            }
            action("Member Statement")
            {
                ApplicationArea = Basic;
                Caption = 'Member Statement';
                Image = "Report";
                RunObject = Report "Member Account Statement-New";
            }
        }
        area(embedding)
        {
            action(Vendors)
            {
                ApplicationArea = Basic;
                Caption = 'Vendors';
                Image = Vendor;
                RunObject = Page "Vendor List";
            }
            action("Bank Account List")
            {
                ApplicationArea = Basic;
                Caption = 'Bank Account List';
                RunObject = Page "Bank Account List";
            }
        }
        area(sections)
        {
            group(Members)
            {
                Caption = 'Members';
                Image = Journals;
                action("Member List")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member List';
                    RunObject = Page "Members List";
                }
                action("Member List-Editable")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member List-Editable';
                    RunObject = Page "Member List-Editable";
                }
            }
            group("Members Regiatration")
            {
                Caption = 'Members Regiatration';
                Image = Journals;
                action("Individual/Joint Application list")
                {
                    ApplicationArea = Basic;
                    Caption = 'Individual/Joint Application list';
                    RunObject = Page "Membership Application List";
                }
                action("Group/Corporate Applications List")
                {
                    ApplicationArea = Basic;
                    Caption = 'Group/Corporate Applications List';
                    RunObject = Page "Group/Corporate Applic List";
                }
                action("Church  Applications List")
                {
                    ApplicationArea = Basic;
                    Caption = 'Church  Applications List';
                    RunObject = Page "Loans  List- pending approval";
                }
                action("Membership Application List")
                {
                    ApplicationArea = Basic;
                    Caption = 'Membership Application List';
                    RunObject = Page "Membership Application List";
                }
                action("Group/Corporate Applic List")
                {
                    ApplicationArea = Basic;
                    Caption = 'Group/Corporate Applic List';
                    RunObject = Page "Group/Corporate Applic List";
                }
            }
            group("FOSA Membership")
            {
                Caption = 'FOSA Membership';
                Image = Journals;
                action("51516430")
                {
                    ApplicationArea = Basic;
                    Caption = 'FOSA Product Applications';
                    RunObject = Page "Member Account Application";
                }
                action("51516435")
                {
                    ApplicationArea = Basic;
                    Caption = 'Savings product list';
                    RunObject = Page "Member Accounts List";
                }
            }
            group("Teller/Tresury Management")
            {
                Caption = 'Teller/Tresury Management';
                Image = Journals;
                action("Teller Till List")
                {
                    ApplicationArea = Basic;
                    RunObject = Page "Teller Till List";
                }
                action("Teller/Treasury Transactions")
                {
                    ApplicationArea = Basic;
                    RunObject = Page "Teller & Treasury Trans List";
                }
            }
            group(Loans)
            {
                Caption = 'Loans';
                Image = Journals;
                action("Loans Applications BOSA")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loans Applications BOSA';
                    RunObject = Page "Loans Applied  List";
                }
                action("Loans Applications FOSA")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loans Applications FOSA';
                    RunObject = Page "Loan Application FOSA(New)";
                }
                action("Approved Loans")
                {
                    ApplicationArea = Basic;
                    Caption = 'Approved Loans';
                    RunObject = Page "Loans Application List(Approv)";
                }
            }
            group("Payment Processes")
            {
                Caption = 'Payment Processes';
                action("Petty Cash Payments")
                {
                    ApplicationArea = Basic;
                    Caption = 'Petty Cash Payments';
                    RunObject = Page "New Petty Cash Payments List";
                }
            }
            group("Common Requisitions")
            {
                Caption = 'Common Requisitions';
                Image = FixedAssets;
                action("Leave Application")
                {
                    ApplicationArea = Basic;
                    Caption = 'Leave Application';
                    RunObject = Page "HR Leave Applications List";
                }
                action("Medical Claims")
                {
                    ApplicationArea = Basic;
                    Caption = 'Medical Claims';
                    RunObject = Page "HR Medical Claims List";
                }
                action("Store Requisitions")
                {
                    ApplicationArea = Basic;
                    Caption = 'Store Requisitions';
                    RunObject = Page "Open Store Requisitions List";
                }
            }
            group("Cashier Transactions")
            {
                Caption = 'Cashier Transactions';
                action("Cashier Transactions - List")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cashier Transactions - List';
                    RunObject = Page "Cashier Transactions - List";
                }
                action("Posted Cashier Transactions")
                {
                    ApplicationArea = Basic;
                    Caption = 'Posted Cashier Transactions';
                    RunObject = Page "Posted Cashier Transactions";
                }
                action("Sacco Transfer")
                {
                    ApplicationArea = Basic;
                    Caption = 'Sacco Transfer List';
                    // RunObject = Page "Internal Transfer List";
                }
                action("EFT List")
                {
                    ApplicationArea = Basic;
                    Caption = 'EFT List';
                    RunObject = Page "New EFT/RTGS List";
                }
                action("Paybill Processing List")
                {
                    ApplicationArea = Basic;
                    Caption = 'Paybill Processing List';
                    RunObject = Page "Paybill Processing List";
                }
            }
            group("Customer Care")
            {
                Caption = 'Customer Care';
                action("Customer Care List")
                {
                    ApplicationArea = Basic;
                    Caption = 'Customer Care List';
                    RunObject = Page "Customer Care List";
                }
                action("Customer Care Log List")
                {
                    ApplicationArea = Basic;
                    Caption = 'Customer Care Log List';
                    RunObject = Page "Customer Care Log List";
                }
            }
            group("Document Approvals")
            {
                Caption = 'Document Approvals';
                action("Approval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Approval Request';
                    Image = Approvals;
                    RunObject = Page "Requests to Approve";
                }
            }
        }
    }
}

