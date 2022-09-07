#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50814 "ATM Cards Application - New"
{
    CardPageID = "ATM Applications Card";
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "ATM Card Applications";
    SourceTableView = where("Order ATM Card" = filter(false));

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
                field(Status; Status)
                {
                    ApplicationArea = Basic;
                }
                field("ATM Card Fee Charged"; "ATM Card Fee Charged")
                {
                    ApplicationArea = Basic;
                }
                field("ATM Card Fee Charged On"; "ATM Card Fee Charged On")
                {
                    ApplicationArea = Basic;
                }
                field("ATM Card Fee Charged By"; "ATM Card Fee Charged By")
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

