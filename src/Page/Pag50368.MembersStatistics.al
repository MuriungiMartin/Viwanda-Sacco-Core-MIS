#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50368 "Members Statistics"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = Customer;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; "No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Name; Name)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("ID No."; "ID No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Mobile Phone No"; "Mobile Phone No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("E-Mail"; "E-Mail")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Email Indemnified"; "Email Indemnified")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Monthly Contribution"; "Monthly Contribution")
                {
                    ApplicationArea = Basic;
                    Width = 50;
                }
                field("Current Shares"; "Current Shares")
                {
                    ApplicationArea = Basic;
                }
                field("Junior Savings"; "Junior Savings")
                {
                    ApplicationArea = Basic;
                }
                field("Safari Savings"; "Safari Savings")
                {
                    ApplicationArea = Basic;
                }
                field("Silver Savings"; "Silver Savings")
                {
                    ApplicationArea = Basic;
                }
                field("Development Loan"; "Development Loan")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Emergency Loan"; "Emergency Loan")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Instant Loan"; "Instant Loan")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Maono Shamba Loan"; "Maono Shamba Loan")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("School Fees Loan"; "School Fees Loan")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Super Plus Loan"; "Super Plus Loan")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Super School Fees Laon"; "Super School Fees Laon")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Top Loan"; "Top Loan")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Top Loan 1"; "Top Loan 1")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Vs Member Loan"; "Vs Member Loan")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Shares Retained"; "Shares Retained")
                {
                    ApplicationArea = Basic;
                }
                group("Share Capital")
                {
                    Caption = 'Share Capital';
                }
            }
            part("Member Accounts"; "Member Accounts")
            {
                SubPageLink = "BOSA Account No" = field("No.");
                Visible = false;
            }
            part(Control7; "Loans Sub-Page List")
            {
                SubPageLink = "Client Code" = field("No.");
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Loan Recovery Logs")
            {
                ApplicationArea = Basic;
                Image = Form;
                Promoted = true;
                RunObject = Page "Loan Recovery Logs List";
                RunPageLink = "Member No" = field("No."),
                              "Member Name" = field(Name);
            }
            action("Guarantor Recovery Report")
            {
                ApplicationArea = Basic;
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";

                trigger OnAction()
                var
                    ObjCust: Record Customer;
                begin
                    ObjCust.Reset;
                    ObjCust.SetRange(ObjCust."No.", "No.");
                    if ObjCust.Find('-') then
                        Report.run(50951, true, false, ObjCust);
                end;
            }
            action("BOSA Account Recovery Report")
            {
                ApplicationArea = Basic;
                Caption = 'BOSA Account Recovery Report';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";

                trigger OnAction()
                var
                    ObjCust: Record Customer;
                begin
                    ObjCust.Reset;
                    ObjCust.SetRange(ObjCust."No.", "No.");
                    if ObjCust.Find('-') then
                        Report.run(50068, true, false, ObjCust);
                end;
            }
            action("Loan Recovery Log Report")
            {
                ApplicationArea = Basic;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedOnly = true;

                trigger OnAction()
                begin
                    ObjCust.Reset;
                    ObjCust.SetRange(ObjCust."No.", "No.");
                    if ObjCust.Find('-') then
                        Report.run(50963, true, false, ObjCust);
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        /*ObjLoans.RESET;
        ObjLoans.SETRANGE("Client Code","No.");
        IF ObjLoans.FIND('-') THEN
        OutstandingInterest:=SFactory.FnGetInterestDueTodate(ObjLoans)-ObjLoans."Interest Paid";*/

    end;

    trigger OnAfterGetRecord()
    begin
        /*IF ("Assigned System ID"<>'') AND ("Assigned System ID"<>USERID) THEN BEGIN
          ERROR('You do not have permission to view this account Details');
          END;*/

        if ("Assigned System ID" <> '') then begin //AND ("Assigned System ID"<>USERID)
            if UserSetup.Get(UserId) then begin
                if UserSetup."View Special Accounts" = false then Error('You do not have permission to view this account Details, Contact your system administrator! ')
            end;
        end;

        SetFieldStyle;

    end;

    var
        UserSetup: Record "User Setup";
        FieldStyle: Text;
        OutstandingInterest: Decimal;
        InterestDue: Decimal;
        SFactory: Codeunit "SURESTEP Factory";
        ObjLoans: Record "Loans Register";
        ObjCust: Record Customer;

    local procedure SetFieldStyle()
    begin
        FieldStyle := '';
        CalcFields("Un-allocated Funds");
        if "Un-allocated Funds" <> 0 then
            FieldStyle := 'Attention';
    end;
}

