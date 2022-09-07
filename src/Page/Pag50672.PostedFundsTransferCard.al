#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50672 "Posted Funds Transfer Card"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = "Funds Transfer Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; "No.")
                {
                    ApplicationArea = Basic;
                }
                field("Pay Mode"; "Pay Mode")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Document Date"; "Document Date")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Posting Date"; "Posting Date")
                {
                    ApplicationArea = Basic;
                }
                field("Paying Bank Account"; "Paying Bank Account")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Paying Bank Name"; "Paying Bank Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Bank Balance"; "Bank Balance")
                {
                    ApplicationArea = Basic;
                }
                field("Bank Account No."; "Bank Account No.")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Currency Code"; "Currency Code")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Amount to Transfer"; "Amount to Transfer")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Amount to Transfer(LCY)"; "Amount to Transfer(LCY)")
                {
                    ApplicationArea = Basic;
                }
                field("Total Line Amount"; "Total Line Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Total Line Amount(LCY)"; "Total Line Amount(LCY)")
                {
                    ApplicationArea = Basic;
                }
                field(Description; Description)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Cheque/Doc. No"; "Cheque/Doc. No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Created By"; "Created By")
                {
                    ApplicationArea = Basic;
                }
                field("Date Created"; "Date Created")
                {
                    ApplicationArea = Basic;
                }
                field("Time Created"; "Time Created")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Status)
                {
                    ApplicationArea = Basic;
                }
            }
            part(Control24; "Funds Transfer Lines")
            {
                SubPageLink = "Document No" = field("No.");
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Post Transfer")
            {
                ApplicationArea = Basic;
                Image = Payment;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = false;

                trigger OnAction()
                begin
                    CheckRequiredItems;
                    CalcFields("Total Line Amount");
                    TestField("Amount to Transfer", "Total Line Amount");

                    if FundsUser.Get(UserId) then begin
                        FundsUser.TestField(FundsUser."FundsTransfer Template Name");
                        FundsUser.TestField(FundsUser."FundsTransfer Batch Name");
                        JTemplate := FundsUser."FundsTransfer Template Name";
                        JBatch := FundsUser."FundsTransfer Batch Name";
                        //Post Transfer
                        FundsManager.PostFundsTransfer(Rec, JTemplate, JBatch);
                    end else begin
                        Error('User Account Not Setup, Contact the System Administrator');
                    end
                end;
            }
            action(Print)
            {
                ApplicationArea = Basic;
                Caption = 'Reprint';
                Image = Print;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    /*FHeader.RESET;
                    FHeader.SETRANGE(FHeader."No.","No.");
                    IF FHeader.FINDFIRST THEN BEGIN
                      REPORT.RUNMODAL(REPORT::"Funds Transfer Voucher",TRUE,FALSE,FHeader);
                    END;
                    */

                    FHeader.Reset;
                    FHeader.SetRange(FHeader."No.", "No.");
                    if FHeader.FindFirst then
                        Report.run(50011, true, true, FHeader);

                end;
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        //"Pay Mode":="Pay Mode"::Cash;
        "Transfer Type" := "transfer type"::InterBank;
    end;

    var
        FundsManager: Codeunit "Funds Management";
        FundsUser: Record "Funds User Setup";
        JTemplate: Code[50];
        JBatch: Code[50];
        FHeader: Record "Funds Transfer Header";
        FLine: Record "Funds Transfer Line";

    local procedure CheckRequiredItems()
    begin
        TestField("Posting Date");
        TestField("Paying Bank Account");
        TestField("Amount to Transfer");
        if "Pay Mode" = "pay mode"::Cheque then
            TestField("Cheque/Doc. No");
        TestField(Description);
        //TESTFIELD("Transfer To");

        FLine.Reset;
        FLine.SetRange(FLine."Document No", "No.");
        FLine.SetFilter(FLine."Amount to Receive", '<>%1', 0);
        if FLine.FindSet then begin
            repeat
                FLine.TestField(FLine."Receiving Bank Account");
            until FLine.Next = 0;
        end;
    end;
}

