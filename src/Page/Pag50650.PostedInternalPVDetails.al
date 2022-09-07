#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50650 "Posted Internal PV Details"
{
    PageType = ListPart;
    SourceTable = "Internal PV Lines";

    layout
    {
        area(content)
        {
            repeater(Control17)
            {
                field(Type; Type)
                {
                    ApplicationArea = Basic;
                }
                field("Account Type"; "Account Type")
                {
                    ApplicationArea = Basic;
                }
                field("Account No."; "Account No.")
                {
                    ApplicationArea = Basic;
                }
                field("Account Name"; "Account Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Description; Description)
                {
                    ApplicationArea = Basic;
                }
                field("Credit Amount"; "Credit Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Debit Amount"; "Debit Amount")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    var
        DCHAR: Integer;
        NotAvailable: Boolean;
        AvailableBal: Decimal;
        Charges: Decimal;
        Accounts: Record Vendor;
        AccountTypes: Record "Account Types-Saving Products";
}

