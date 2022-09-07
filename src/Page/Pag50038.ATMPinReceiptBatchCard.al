#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50038 "ATM Pin Receipt Batch Card"
{
    PageType = Card;
    SourceTable = "ATM Pin Receipt Batch";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Batch No."; "Batch No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Description/Remarks"; "Description/Remarks")
                {
                    ApplicationArea = Basic;
                    Editable = EnableLoad;
                }
                field("Bank Batch No"; "Bank Batch No")
                {
                    ApplicationArea = Basic;
                    Editable = EnableLoad;
                }
                field(Requested; Requested)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Status; Status)
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Date Created"; "Date Created")
                {
                    ApplicationArea = Basic;
                }
                field("Date Requested"; "Date Requested")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Requested By"; "Requested By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Prepared By"; "Prepared By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            part(Control11; "ATM Pin Receipt SubPage")
            {
                SubPageLink = "Batch No." = field("Batch No.");
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(LoadPinNotReceivedApplications)
            {
                ApplicationArea = Basic;
                Caption = 'Load Ordered ATM Cards & Pin Not Received';
                Enabled = EnableLoad;
                Image = Allocate;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    ObjCardsApplied.Reset;
                    ObjCardsApplied.SetRange(ObjCardsApplied."Order ATM Card", true);
                    ObjCardsApplied.SetRange(ObjCardsApplied."Pin Received", false);
                    if ObjCardsApplied.FindSet then begin
                        repeat
                            ObjCardsReceipts.Init;
                            ObjCardsReceipts."Batch No." := "Batch No.";
                            ObjCardsReceipts."ATM Application No" := ObjCardsApplied."No.";
                            ObjCardsReceipts."ATM Card Account No" := ObjCardsApplied."Account No";
                            ObjCardsReceipts."Account Name" := ObjCardsApplied."Account Name";
                            ObjCardsReceipts."ATM Card Application Date" := ObjCardsApplied."Application Date";
                            ObjCardsReceipts.Insert;
                        until ObjCardsApplied.Next = 0;
                        EnableAction := true;
                        EnableLoad := false;
                    end;
                end;
            }
            action(ReceivePINBatch)
            {
                ApplicationArea = Basic;
                Caption = 'Receive PIN Batch';
                Enabled = EnableAction;
                Image = Export;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    ObjCardsReceipts.Reset;
                    ObjCardsReceipts.SetRange(ObjCardsReceipts."Batch No.", "Batch No.");
                    ObjCardsReceipts.SetRange(ObjCardsReceipts."Pin Received", true);
                    if ObjCardsReceipts.FindSet then begin
                        Requested := true;
                        "Requested By" := UserId;

                        ObjCardsReceipts.Reset;
                        ObjCardsReceipts.SetRange(ObjCardsReceipts."Batch No.", "Batch No.");
                        ObjCardsReceipts.SetRange(ObjCardsReceipts."Pin Received", false);
                        if ObjCardsReceipts.FindSet then begin
                            ObjCardsReceipts.DeleteAll;
                        end;
                        EnableAction := false;
                        EnableLoad := false;
                        Message('The ATM PIN Batch has successully been Received');
                    end else
                        Message('There are no ATM Cards PINs selected to be received');
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        if Requested = false then
            EnableLoad := true;
        if Requested = true then
            EnableLoad := false;

        EnableAction := false;

        ObjCardsReceipts.Reset;
        ObjCardsReceipts.SetRange(ObjCardsReceipts."Batch No.", "Batch No.");
        ObjCardsReceipts.SetRange(ObjCardsReceipts."Pin Received", true);
        if ObjCardsReceipts.FindSet then begin
            if Requested = false then
                EnableAction := true;
        end;
    end;

    var
        ObjCardsReceipts: Record "ATM Pin Receipt Lines";
        ObjCardsApplied: Record "ATM Card Applications";
        EnableAction: Boolean;
        EnableLoad: Boolean;
}

