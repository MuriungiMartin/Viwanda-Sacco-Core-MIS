#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50435 "Member Accounts List"
{
    CardPageID = "Member Account Card View";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = Vendor;
    SourceTableView = where("Creditor Type" = filter("FOSA Account"));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; "No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Account No';
                }
                field("BOSA Account No"; "BOSA Account No")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member No';
                }
                field(Name; Name)
                {
                    ApplicationArea = Basic;
                    Caption = 'Account Name';
                }
                field("Account Type"; "Account Type")
                {
                    ApplicationArea = Basic;
                }
                field(Balance; Balance)
                {
                    ApplicationArea = Basic;
                    StyleExpr = CoveragePercentStyle;
                }
                field("Over Draft Limit Amount"; "Over Draft Limit Amount")
                {
                    ApplicationArea = Basic;
                    Caption = 'OD Limit';
                }
                field("ID No."; "ID No.")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Status)
                {
                    ApplicationArea = Basic;
                }
                field("Mobile Phone No"; "Mobile Phone No")
                {
                    ApplicationArea = Basic;
                }
                field("Global Dimension 2 Code"; "Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                    Visible = true;
                }
                field("Signing Instructions"; "Signing Instructions")
                {
                    ApplicationArea = Basic;
                }
                field(Blocked; Blocked)
                {
                    ApplicationArea = Basic;
                }
                field("Certificate No"; "Certificate No")
                {
                    ApplicationArea = Basic;
                }
                field("Registration Date"; "Registration Date")
                {
                    ApplicationArea = Basic;
                }
                field("Created By"; "Created By")
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {
            part(Control1000000001; "FOSA Statistics FactBox")
            {
                Editable = false;
                Enabled = false;
                SubPageLink = "No." = field("No.");
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Account)
            {
                Caption = 'Account';
                action("Ledger E&ntries")
                {
                    ApplicationArea = Basic;
                    Caption = 'Ledger E&ntries';
                    Image = VendorLedger;
                    RunObject = Page "Vendor Ledger Entries";
                    RunPageLink = "Vendor No." = field("No.");
                    RunPageView = sorting("Vendor No.");
                    ShortCutKey = 'Ctrl+F7';
                }
                action("Co&mments")
                {
                    ApplicationArea = Basic;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Comment Sheet";
                    RunPageLink = "Table Name" = const(Vendor),
                                  "No." = field("No.");
                }
                action(Dimensions)
                {
                    ApplicationArea = Basic;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    RunObject = Page "Default Dimensions";
                    RunPageLink = "Table ID" = const(23),
                                  "No." = field("No.");
                    ShortCutKey = 'Shift+Ctrl+D';
                }
                separator(Action1102755228)
                {
                }
                separator(Action1102755226)
                {
                }
                separator(Action1102755225)
                {
                }
                action("Member Details")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member Details';
                    Image = Planning;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Member Account Card";
                    RunPageLink = "No." = field("BOSA Account No");
                }
                separator(Action1102755222)
                {
                }
                action("ATM Cards Linked")
                {
                    ApplicationArea = Basic;
                    Image = List;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "ATM Card Nos Buffer";
                    RunPageLink = "Account No" = field("No.");
                }
                action("Account Signatories")
                {
                    ApplicationArea = Basic;
                    Caption = 'Account Signatories';
                    Image = Form;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Account Signatories Details";
                    RunPageLink = "Account No" = field("No.");
                }
                action("Account Agent Details")
                {
                    ApplicationArea = Basic;
                    Caption = 'Account Agents';
                    Image = Form;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Account Agent List";
                    RunPageLink = "Account No" = field("No.");
                }
                action("Charge Statement Fee")
                {
                    ApplicationArea = Basic;
                    Image = Form;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        ObjAccount.Reset;
                        ObjAccount.SetRange(ObjAccount."No.", "No.");
                        if ObjAccount.Find('-') then
                            Report.run(50142, true, false, ObjAccount)
                    end;
                }
            }
            group(ActionGroup1102755220)
            {
                action("Nominee Details")
                {
                    ApplicationArea = Basic;
                    Caption = 'Nominee Details';
                    Image = Relationship;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "FOSA Account  NOK Details";
                    RunPageLink = "Account No" = field("No.");
                }
                separator(Action1102755217)
                {
                }
                action("Member Statement")
                {
                    ApplicationArea = Basic;
                    Caption = 'Detailed Statement';
                    Image = Customer;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedOnly = true;

                    trigger OnAction()
                    begin

                        /*IF ("Assigned System ID"<>'')  THEN BEGIN //AND ("Assigned System ID"<>USERID)
                          IF UserSetup.GET(USERID) THEN
                          BEGIN
                            IF UserSetup."View Special Accounts"=FALSE THEN ERROR ('You do not have permission to view this account Details, Contact your system administrator! ')
                          END;
                        END;*/
                        Cust.Reset;
                        Cust.SetRange(Cust."No.", "BOSA Account No");
                        if Cust.Find('-') then
                            Report.run(50886, true, false, Cust);

                    end;
                }
                action("Page Vendor Statement")
                {
                    ApplicationArea = Basic;
                    Caption = 'Account Statement';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";

                    trigger OnAction()
                    begin

                        Vend.Reset;
                        Vend.SetRange(Vend."No.", "No.");
                        if Vend.Find('-') then
                            Report.run(50890, true, false, Vend)
                    end;
                }
                action("Page Vendor Statistics")
                {
                    ApplicationArea = Basic;
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Page "Vendor Statistics";
                    RunPageLink = "No." = field("No."),
                                  "Global Dimension 1 Filter" = field("Global Dimension 1 Filter"),
                                  "Global Dimension 2 Filter" = field("Global Dimension 2 Filter");
                    ShortCutKey = 'F7';
                    Visible = false;
                }
                action("Members Statistics")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    RunObject = Page "Members Statistics";
                    RunPageLink = "No." = field("BOSA Account No");
                }
                separator(Action12)
                {
                }
                action("Send Member Statement")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send Detailed Statement';
                    Image = Customer;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        Cust.Reset;
                        Cust.SetRange(Cust."No.", "BOSA Account No");
                        if Cust.Find('-') then
                            Report.run(50073, true, false, Cust);
                    end;
                }
                action("Send Account Statement")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send Account Statement';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin

                        Vend.Reset;
                        Vend.SetRange(Vend."No.", "No.");
                        if Vend.Find('-') then
                            //Report.run(50890,TRUE,FALSE,Vend);
                            Report.run(50072, true, false, Vend);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        SetStyles;
    end;

    trigger OnOpenPage()
    begin
        //SETRANGE("Global Dimension 1 Code",'FOSA');
    end;

    var
        Cust: Record Customer;
        Vend: Record Vendor;
        CoveragePercentStyle: Text;
        MinimumBalance: Decimal;
        ObjAccount: Record Vendor;

    local procedure SetStyles()
    begin
        MinimumBalance := 1000;
        if Balance = 0 then
            CoveragePercentStyle := 'Strong'
        else
            if Balance < MinimumBalance then
                CoveragePercentStyle := 'Unfavorable'
            else
                CoveragePercentStyle := 'Favorable';
    end;
}

