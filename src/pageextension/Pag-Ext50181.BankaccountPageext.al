pageextension 50181 "BankaccountPageext" extends "Bank Account Card"
{
    layout
    {
        // Add changes to page layout here
        addafter("Bank Clearing Code")
        {
            field("EFT/RTGS Bank"; "EFT/RTGS Bank")
            {

            }
            group("Teller/Treasury Addon")
            {
                Caption = 'Teller/Treasury Addon';
                field("Account Type"; "Account Type")
                {
                    ApplicationArea = Basic;
                }
                field("Maximum Teller Withholding"; "Maximum Teller Withholding")
                {
                    ApplicationArea = Basic;
                }
                field("Max Withdrawal Limit"; "Max Withdrawal Limit")
                {
                    ApplicationArea = Basic;
                }
                field("Max Deposit Limit"; "Max Deposit Limit")
                {
                    ApplicationArea = Basic;
                }
                field("Max Cheque Deposit Limit"; "Max Cheque Deposit Limit")
                {
                    ApplicationArea = Basic;
                }
                field(CashierID; CashierID)
                {
                    ApplicationArea = Basic;
                }
                field("Cheque Clearing Bank"; "Cheque Clearing Bank")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Bankers Cheque Clearing Bank"; "Bankers Cheque Clearing Bank")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}