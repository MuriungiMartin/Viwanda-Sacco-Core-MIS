#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50372 "Member Account Signatory Card"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Member Account Signatories";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Member No."; "Member No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member No.';
                }
                field("Account No"; "Account No")
                {
                    ApplicationArea = Basic;
                    Caption = 'Group No.';
                }
                field(Names; Names)
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field("Date Of Birth"; "Date Of Birth")
                {
                    ApplicationArea = Basic;
                }
                field("Staff/Payroll"; "Staff/Payroll")
                {
                    ApplicationArea = Basic;
                }
                field("ID No."; "ID No.")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field(Designation; Designation)
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
            }
        }
        area(factboxes)
        {
            part(Control2; "AC_Signatory Picture-Uploaded")
            {
                ApplicationArea = All;
                Caption = 'Picture';
                SubPageLink = "Account No" = field("Account No");
            }
            part(Control1; "AC_Signatory Sign-Uploaded")
            {
                ApplicationArea = All;
                Caption = 'Signature';
                SubPageLink = "Account No" = field("Account No");
            }
        }
    }

    actions
    {
    }
}

