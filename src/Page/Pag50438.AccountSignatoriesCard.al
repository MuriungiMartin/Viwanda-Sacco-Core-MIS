#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50438 "Account Signatories Card"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = "FOSA Account Sign. Details";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Document No"; "Document No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Member No."; "Member No.")
                {
                    ApplicationArea = Basic;
                }
                field(Names; Names)
                {
                    ApplicationArea = Basic;
                }
                field("Date Of Birth"; "Date Of Birth")
                {
                    ApplicationArea = Basic;
                }
                field("Mobile No"; "Mobile No")
                {
                    ApplicationArea = Basic;
                }
                field("ID No."; "ID No.")
                {
                    ApplicationArea = Basic;
                }
                field(Signatory; Signatory)
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
                field("Email Address"; "Email Address")
                {
                    ApplicationArea = Basic;
                }
                field("Limit Amount"; "Limit Amount")
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {
            part(Control5; "Account Signatorie Picture")
            {
                ApplicationArea = All;
                Caption = 'Picture';
                Editable = false;
                Enabled = false;
                SubPageLink = "Document No" = field("Document No");
            }
            part(Control4; "Account Signator Signature")
            {
                ApplicationArea = All;
                Caption = 'Signature';
                Editable = false;
                Enabled = false;
                SubPageLink = "Document No" = field("Document No");
            }
        }
    }

    actions
    {
    }
}

