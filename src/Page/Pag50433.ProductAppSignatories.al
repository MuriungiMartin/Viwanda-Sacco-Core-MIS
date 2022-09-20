page 50433 "Product App Signatories"
{
    // version FOSA ManagementV1.0(Surestep Systems)

    CardPageID = "Product App Signatories Card";
    Editable = false;
    PageType = Card;
    SourceTable = "Product App Signatories";

    layout
    {
        area(content)
        {
            repeater(Content2)
            {
                field("Account No"; "Account No")
                {
                }
                field("Document No"; "Document No")
                {
                    trigger OnValidate()
                    begin
                        DocNo := "Document No";
                    end;

                }
                field("Staff/Payroll"; "Staff/Payroll")
                {
                }
                field("Date Of Birth"; "Date Of Birth")
                {
                    Caption = 'Staff/Payroll No';
                }
                field(Names; Names)
                {
                }
                field("ID No."; "ID No.")
                {
                }
                field(Signatory; Signatory)
                {
                }
                field("Must Sign"; "Must Sign")
                {
                }
                field(Signature; Signature)
                {
                }

                field("Expiry Date"; "Expiry Date")
                {
                    Editable = false;
                }
                field("BOSA No."; "BOSA No.")
                {
                }
                field(DocNo; DocNo)
                {
                    Visible = false;
                }
            }
        }
        area(factboxes)
        {
            part(Picture; "Account Agent Picture-App")
            {
                //  SubPageLink =   = field("Document No");


            }
            part(Signature1; "Account Agent Signature-App")
            {
                ApplicationArea = All;
                Caption = 'Signature';
                // SubPageLink = "Document No" = FIELD("Document No");
            }
        }
    }

    actions
    {

    }

    trigger OnOpenPage()
    begin
        MemberApp.RESET;
        MemberApp.SETRANGE(MemberApp."No.", "Document No");
        IF MemberApp.FIND('-') THEN BEGIN
            IF MemberApp.Status = MemberApp.Status::Approved THEN BEGIN
                CurrPage.EDITABLE := FALSE;
            END ELSE
                CurrPage.EDITABLE := TRUE;
        END;
    end;

    var
        MemberApp: Record "Membership Applications";
        ReltnShipTypeEditable: Boolean;
        CUST: Record Customer;
        DocNo: code[40];
}

