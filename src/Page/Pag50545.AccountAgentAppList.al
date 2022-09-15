#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50545 "Account Agent App List"
{
    CardPageID = "Account Agent App Card";
    PageType = Card;
    SourceTable = "Account Agents App Details";

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                field("Account No"; "Account No")
                {
                    ApplicationArea = Basic;
                }
                field("BOSA No."; "BOSA No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Agent Member No';
                    Editable = false;
                }
                field(Names; Names)
                {
                    ApplicationArea = Basic;
                    Caption = 'agent Name';
                }
                field("ID No."; "ID No.")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        CUST.Reset;
                        CUST.SetRange(CUST."ID No.", "ID No.");
                        if CUST.Find('-') then begin
                            "BOSA No." := CUST."No.";
                            Modify;
                        end;
                    end;
                }
                field("Mobile No."; "Mobile No.")
                {
                    ApplicationArea = Basic;
                }
                field("Email Address"; "Email Address")
                {
                    ApplicationArea = Basic;
                }
                field("Date Of Birth"; "Date Of Birth")
                {
                    ApplicationArea = Basic;
                }
                field("Allowed Balance Enquiry"; "Allowed Balance Enquiry")
                {
                    ApplicationArea = Basic;
                }
                field("Allowed  Correspondence"; "Allowed  Correspondence")
                {
                    ApplicationArea = Basic;
                }
                field("Allowed FOSA Withdrawals"; "Allowed FOSA Withdrawals")
                {
                    ApplicationArea = Basic;
                }
                field("Allowed Loan Processing"; "Allowed Loan Processing")
                {
                    ApplicationArea = Basic;
                }
                field(Designation; Designation)
                {
                    ApplicationArea = Basic;
                }
                field("Expiry Date"; "Expiry Date")
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {
            part(Control8; "Account Agent Picture-App")
            {
                ApplicationArea = All;
                Caption = 'Picture';
            }
            part(Control7; "Account Agent Signature-App")
            {
                ApplicationArea = All;
                Caption = 'Signature';
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
        CUST: Record Customer;
}

