#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50363 "Membership App Signatories"
{
    CardPageID = "Membership App Signatory Card";
    Editable = false;
    PageType = Card;
    SourceTable = "Member App Signatories";

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                field(Names; Names)
                {
                    ApplicationArea = Basic;
                }
                field("ID No."; "ID No.")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        /*CUST.RESET;
                        CUST.SETRANGE(CUST."ID No.","ID No.");
                        IF CUST.FIND('-')  THEN BEGIN
                        "BOSA No.":=CUST."No.";
                        MODIFY;
                        END;*/

                    end;
                }
                field("Date Of Birth"; "Date Of Birth")
                {
                    ApplicationArea = Basic;
                }
                field(Designation; Designation)
                {
                    ApplicationArea = Basic;
                }
                field(Control1102760009; Signatory)
                {
                    ApplicationArea = Basic;
                }
                field("Must Sign"; "Must Sign")
                {
                    ApplicationArea = Basic;
                }
                field("Must be Present"; "Must be Present")
                {
                    ApplicationArea = Basic;
                }
                field("Expiry Date"; "Expiry Date")
                {
                    ApplicationArea = Basic;
                }
                field("Account No"; "Account No")
                {
                    ApplicationArea = Basic;
                }
                field("BOSA No."; "BOSA No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Email Address"; "Email Address")
                {
                    ApplicationArea = Basic;
                }
                field(Title; Title)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Signatory)
            {
                Caption = 'Signatory';
                action("Page Account Signatories Card")
                {
                    ApplicationArea = Basic;
                    Caption = 'Card';
                    Image = EditLines;
                    RunObject = Page "HR Training Application List";
                    RunPageLink = "Application No" = field("Account No"),
                                  "Course Title" = field(Names);
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        MemberApp.Reset;
        MemberApp.SetRange(MemberApp."No.", "Account No");
        if MemberApp.Find('-') then begin
            if MemberApp.Status = MemberApp.Status::Approved then begin
                CurrPage.Editable := false;
            end else
                CurrPage.Editable := true;
        end;
    end;

    var
        MemberApp: Record "Membership Applications";
        ReltnShipTypeEditable: Boolean;
        CUST: Record "Members Register";
}

