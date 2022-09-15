#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50663 "Member Acc. Signatory Change"
{
    CardPageID = "Member Acc. Sign. Card Change";
    PageType = ListPart;
    SourceTable = "Member Acc. Signatories Change";

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                field("Member No."; "Member No.")
                {
                    ApplicationArea = Basic;
                }
                field(Names; Names)
                {
                    ApplicationArea = Basic;
                }
                field("Mobile Phone No"; "Mobile Phone No")
                {
                    ApplicationArea = Basic;
                }
                field("ID No."; "ID No.")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        CUST.Reset;
                        CUST.SetRange(CUST."ID No.", "ID No.");
                        if CUST.Find('-') then begin
                            "Member No." := CUST."No.";
                            Modify;
                        end;
                    end;
                }
                field("Date Of Birth"; "Date Of Birth")
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
                }
                field("Email Address"; "Email Address")
                {
                    ApplicationArea = Basic;
                }
                field("Expiry Date"; "Expiry Date")
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

