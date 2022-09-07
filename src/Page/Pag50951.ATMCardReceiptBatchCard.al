#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50951 "ATM Card Receipt Batch Card"
{
    PageType = Card;
    SourceTable = "ATM Card Receipt Batch";

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
            part(Control11; "ATM Card Receipt SubPage")
            {
                SubPageLink = "Batch No." = field("Batch No.");
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(LoadATMApplications)
            {
                ApplicationArea = Basic;
                Caption = 'Load Ordered & Not Received ATM Cards';
                Enabled = EnableLoad;
                Image = Allocate;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    ObjCardsApplied.Reset;
                    ObjCardsApplied.SetRange(ObjCardsApplied."Order ATM Card", true);
                    ObjCardsApplied.SetRange(ObjCardsApplied."Card Received", false);
                    if ObjCardsApplied.FindSet then begin
                        repeat
                            ObjCardsReceipts.Init;
                            ObjCardsReceipts."Batch No." := "Batch No.";
                            ObjCardsReceipts."ATM Application No" := ObjCardsApplied."No.";
                            ObjCardsReceipts."ATM Card Account No" := ObjCardsApplied."Account No";
                            ObjCardsReceipts."Account Name" := ObjCardsApplied."Account Name";
                            ObjCardsReceipts."ATM Card Application Date" := ObjCardsApplied."Application Date";
                            //ObjCardsReceipts."Request Type":=ObjCardsApplied."Request Type";
                            ObjCardsReceipts.Insert;
                        until ObjCardsApplied.Next = 0;
                        EnableAction := true;
                        EnableLoad := false;
                    end;
                end;
            }
            action(ReceiveATMCardBatch)
            {
                ApplicationArea = Basic;
                Caption = 'Receive ATM Cards Batch';
                Enabled = EnableAction;
                Image = Export;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    Vend: Record Vendor;
                    sfactory: Codeunit "SURESTEP Factory";
                    msg: Text;
                    sCloud: Codeunit CloudPESALivetest;
                begin
                    ObjCardsReceipts.Reset;
                    ObjCardsReceipts.SetRange(ObjCardsReceipts."Batch No.", "Batch No.");
                    ObjCardsReceipts.SetRange(ObjCardsReceipts.Received, true);
                    if ObjCardsReceipts.FindSet then begin
                        Requested := true;
                        "Requested By" := UserId;
                        repeat
                            Vend.Reset;
                            Vend.SetRange(Vend."No.", ObjCardsReceipts."ATM Card Account No");
                            if Vend.Find('-') then begin
                                msg := 'Dear ' + sfactory.FnRunSplitString(Vend.Name, ' ') + ', your ATM Card and PIN are ready for collection. Please note,' +
                                'after 60 days your ATM card will be discarded. Kindly come with your original ID Card. Kingdom Sacco.';
                                //  sCloud.SMSMessageTBL(ObjCardsReceipts."Batch No.",Vend."No.",Vend."Mobile Phone No",CopyStr(msg,1,250),CopyStr(msg,251,500));
                            end;
                        until ObjCardsReceipts.Next = 0;
                        ObjCardsReceipts.Reset;
                        ObjCardsReceipts.SetRange(ObjCardsReceipts."Batch No.", "Batch No.");
                        ObjCardsReceipts.SetRange(ObjCardsReceipts.Received, false);
                        if ObjCardsReceipts.FindSet then begin
                            ObjCardsReceipts.DeleteAll;
                        end;
                        EnableAction := false;
                        EnableLoad := false;

                        Message('The ATM Cards Batch has successully been Received');
                    end else
                        Message('There are no ATM Cards selected as received');
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
        ObjCardsReceipts.SetRange(ObjCardsReceipts.Received, true);
        if ObjCardsReceipts.FindSet then begin
            if Requested = false then
                EnableAction := true;
        end;
    end;

    var
        ObjCardsReceipts: Record "ATM Card Receipt Lines";
        ObjCardsApplied: Record "ATM Card Applications";
        EnableAction: Boolean;
        EnableLoad: Boolean;
}

