#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50461 "ATM Cards Appl. - Processed"
{
    CardPageID = "ATM Applications Card";
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "ATM Card Applications";
    SourceTableView = where("Order ATM Card" = filter(true));

    layout
    {
        area(content)
        {
            repeater(Control15)
            {
                Editable = false;
                field("No."; "No.")
                {
                    ApplicationArea = Basic;
                }
                field("Request Type"; "Request Type")
                {
                    ApplicationArea = Basic;
                }
                field("Account No"; "Account No")
                {
                    ApplicationArea = Basic;
                }
                field("Account Name"; "Account Name")
                {
                    ApplicationArea = Basic;
                }
                field("Branch Code"; "Branch Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'Branch';
                }
                field("Card No"; "Card No")
                {
                    ApplicationArea = Basic;
                }
                field("Phone No."; "Phone No.")
                {
                    ApplicationArea = Basic;
                }
                field("ID No"; "ID No")
                {
                    ApplicationArea = Basic;
                }
                field("Application Date"; "Application Date")
                {
                    ApplicationArea = Basic;
                }
                field("Captured By"; "Captured By")
                {
                    ApplicationArea = Basic;
                }
                field("Order ATM Card"; "Order ATM Card")
                {
                    ApplicationArea = Basic;
                    Caption = 'Ordered';
                }
                field("Ordered On"; "Ordered On")
                {
                    ApplicationArea = Basic;
                }
                field("Ordered By"; "Ordered By")
                {
                    ApplicationArea = Basic;
                }
                field("Card Received"; "Card Received")
                {
                    ApplicationArea = Basic;
                }
                field("Card Received On"; "Card Received On")
                {
                    ApplicationArea = Basic;
                }
                field("Card Received By"; "Card Received By")
                {
                    ApplicationArea = Basic;
                }
                field("Pin Received"; "Pin Received")
                {
                    ApplicationArea = Basic;
                    Caption = 'PIN Received';
                }
                field("Pin Received On"; "Pin Received On")
                {
                    ApplicationArea = Basic;
                    Caption = 'PIN Received On';
                }
                field("Pin Received By"; "Pin Received By")
                {
                    ApplicationArea = Basic;
                    Caption = 'PIN Received By';
                }
                field("ATM Card Linked"; "ATM Card Linked")
                {
                    ApplicationArea = Basic;
                }
                field("ATM Card Linked By"; "ATM Card Linked By")
                {
                    ApplicationArea = Basic;
                }
                field("ATM Card Linked On"; "ATM Card Linked On")
                {
                    ApplicationArea = Basic;
                }
                field(Collected; Collected)
                {
                    ApplicationArea = Basic;
                }
                field("Date Collected"; "Date Collected")
                {
                    ApplicationArea = Basic;
                }
                field("Card Issued By"; "Card Issued By")
                {
                    ApplicationArea = Basic;
                }
                field("ATM Delinked"; "ATM Delinked")
                {
                    ApplicationArea = Basic;
                }
                field("ATM Delinked By"; "ATM Delinked By")
                {
                    ApplicationArea = Basic;
                }
                field("ATM Delinked On"; "ATM Delinked On")
                {
                    ApplicationArea = Basic;
                }
                field(Destroyed; Destroyed)
                {
                    ApplicationArea = Basic;
                }
                field("Destroyed On"; "Destroyed On")
                {
                    ApplicationArea = Basic;
                }
                field("Destroyed By"; "Destroyed By")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
}

