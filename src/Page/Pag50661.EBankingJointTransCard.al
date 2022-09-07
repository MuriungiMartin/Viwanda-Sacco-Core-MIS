#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50661 "E-Banking Joint Trans Card"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = "Funds Transfer Logs";

    layout
    {
        area(content)
        {
            group(Control2)
            {
                field("Document No"; "Document No")
                {
                    ApplicationArea = Basic;
                }
                field("Member No"; "Member No")
                {
                    ApplicationArea = Basic;
                    Caption = 'Initiated By (Member No)';
                }
                field(Telephone; Telephone)
                {
                    ApplicationArea = Basic;
                    Caption = 'Initiated By (Mobile No)';
                }
                field("Transaction Type"; "Transaction Type")
                {
                    ApplicationArea = Basic;
                }
                field("Source Account"; "Source Account")
                {
                    ApplicationArea = Basic;
                }
                field("Source Account Name"; "Source Account Name")
                {
                    ApplicationArea = Basic;
                }
                field("Destination Account"; "Destination Account")
                {
                    ApplicationArea = Basic;
                }
                field("Destination Account Name"; "Destination Account Name")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Amount"; "Transaction Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Date"; "Transaction Date")
                {
                    ApplicationArea = Basic;
                }
                field(Description; Description)
                {
                    ApplicationArea = Basic;
                }
                field(Status; Status)
                {
                    ApplicationArea = Basic;
                }
                field(Posted; Posted)
                {
                    ApplicationArea = Basic;
                }
                field("Posting Date"; "Posting Date")
                {
                    ApplicationArea = Basic;
                }
                field(Comments; Comments)
                {
                    ApplicationArea = Basic;
                }
                field("Signing Instructions"; "Signing Instructions")
                {
                    ApplicationArea = Basic;
                }
            }
            part(Control9; "EBanking Joint Trans Approvers")
            {
                SubPageLink = "Transaction No" = field("Document No");
            }
        }
        area(factboxes)
        {
            part(Control16; "FOSA Statistics FactBox")
            {
                Editable = false;
                Enabled = false;
                SubPageLink = "No." = field("Source Account");
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Account Signatories")
            {
                ApplicationArea = Basic;
                Caption = 'Account Signatories';
                Image = Form;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Account Signatories Details";
                RunPageLink = "Account No" = field("Source Account");
            }
            action("Page Vendor Statement")
            {
                ApplicationArea = Basic;
                Caption = 'Account Statement';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";

                trigger OnAction()
                begin

                    Vend.Reset;
                    Vend.SetRange(Vend."No.", "Source Account");
                    if Vend.Find('-') then
                        Report.run(50890, true, false, Vend)
                end;
            }
        }
    }

    var
        Vend: Record Vendor;
}

