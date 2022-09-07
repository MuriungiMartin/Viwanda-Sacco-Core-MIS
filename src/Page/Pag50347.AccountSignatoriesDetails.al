#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50347 "Account Signatories Details"
{
    CardPageID = "Account Signatories Card";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "FOSA Account Sign. Details";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Member No."; "Member No.")
                {
                    ApplicationArea = Basic;
                }
                field(Names; Names)
                {
                    ApplicationArea = Basic;
                }
                field("Mobile No"; "Mobile No")
                {
                    ApplicationArea = Basic;
                }
                field("Date Of Birth"; "Date Of Birth")
                {
                    ApplicationArea = Basic;
                }
                field("ID No."; "ID No.")
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
                field("Email Address"; "Email Address")
                {
                    ApplicationArea = Basic;
                }
                field("Withdrawal Limit"; "Withdrawal Limit")
                {
                    ApplicationArea = Basic;
                }
                field("Mobile Banking Limit"; "Mobile Banking Limit")
                {
                    ApplicationArea = Basic;
                }
                field("Signed Up For Mobile Banking"; "Signed Up For Mobile Banking")
                {
                    ApplicationArea = Basic;
                    Caption = 'Signed Up For MBanking';
                }
                field("Expiry Date"; "Expiry Date")
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {
            part(Control2; "Account Signatorie Picture")
            {
                ApplicationArea = All;
                Caption = 'Picture';
                SubPageLink = "Document No" = field("Document No");
            }
            part(Control1; "Account Signator Signature")
            {
                ApplicationArea = All;
                Caption = 'Signature';
                SubPageLink = "Document No" = field("Document No");
            }
        }
    }

    actions
    {
    }
}

