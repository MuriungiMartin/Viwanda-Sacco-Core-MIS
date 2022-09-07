#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50452 "EFT/RTGS Details"
{
    PageType = ListPart;
    SourceTable = "EFT/RTGS Details";
    SourceTableView = sorting("Header No", No);

    layout
    {
        area(content)
        {
            repeater(Control17)
            {
                field("Account No"; "Account No")
                {
                    ApplicationArea = Basic;
                }
                field("Account Name"; "Account Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Phone No."; "Phone No.")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Account Type"; "Account Type")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Transaction Description"; "Transaction Description")
                {
                    ApplicationArea = Basic;
                }
                field("EFT/RTGS Type"; "EFT/RTGS Type")
                {
                    ApplicationArea = Basic;
                }
                field("EFT/RTGS Type Description"; "EFT/RTGS Type Description")
                {
                    ApplicationArea = Basic;
                    Caption = 'EFT/RTGS Type Desc';
                }
                field(Amount; Amount)
                {
                    ApplicationArea = Basic;
                }
                field("Destination Cash Book"; "Destination Cash Book")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cash Book Bank Account';
                }
                field("Destination Cash Book Name"; "Destination Cash Book Name")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cash Book Bank Name';
                }
                field("Cheque No"; "Cheque No")
                {
                    ApplicationArea = Basic;
                }
                field("Destination Account No"; "Destination Account No")
                {
                    ApplicationArea = Basic;
                    Caption = 'Recipient Account';
                }
                field("Destination Account Name"; "Destination Account Name")
                {
                    ApplicationArea = Basic;
                    Caption = 'Recipient Name';
                }
                field("Bank No"; "Bank No")
                {
                    ApplicationArea = Basic;
                    Caption = 'Recipient Bank Code';
                }
                field("Payee Bank Name"; "Payee Bank Name")
                {
                    ApplicationArea = Basic;
                    Caption = 'Recipient Bank Name';
                    Editable = false;
                }
                field("Payee Branch Name"; "Payee Branch Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        DCHAR := 0;
        DCHAR := StrLen("Destination Account No");

        NotAvailable := true;
        AvailableBal := 0;


        //Available Bal
        if Accounts.Get("Account No") then begin
            Accounts.CalcFields(Accounts.Balance, Accounts."Uncleared Cheques", Accounts."ATM Transactions");
            if AccountTypes.Get(Accounts."Account Type") then begin
                AvailableBal := Accounts.Balance - (Accounts."Uncleared Cheques" + Accounts."ATM Transactions" + Charges + AccountTypes."Minimum Balance");

                if Amount <= AvailableBal then
                    NotAvailable := false;

            end;
        end;
    end;

    var
        DCHAR: Integer;
        NotAvailable: Boolean;
        AvailableBal: Decimal;
        Charges: Decimal;
        Accounts: Record Vendor;
        AccountTypes: Record "Account Types-Saving Products";
}

