#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50013 "Cheque Book Request Batch Card"
{
    PageType = Card;
    SourceTable = "Cheque Book  Order Batch";

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
                    Editable = EnabledAction;
                }
                field(Requested; Requested)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Status; Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
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
                }
                field("Prepared By"; "Prepared By")
                {
                    ApplicationArea = Basic;
                }
            }
            part(Control11; "Cheque Book Request SubPage")
            {
                SubPageLink = "Batch No." = field("Batch No.");
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(OrderChequeBook)
            {
                ApplicationArea = Basic;
                Caption = 'Order Cheque Book';
                Enabled = EnabledAction;
                Image = Export;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin

                    ObjGensetup.Get;

                    ObjChqBookRequestLines.Reset;
                    ObjChqBookRequestLines.SetRange(ObjChqBookRequestLines."Batch No.", "Batch No.");
                    ObjChqBookRequestLines.SetRange(ObjChqBookRequestLines.Ordered, true);
                    if ObjChqBookRequestLines.FindSet then begin
                        CardTxtFile.Create(ObjGensetup."Cheque Book Request Path" + 'Cheque Book Application ' + Format(WorkDate, 0, '<Day,2> <Month Text,3> <Year4>') + '.txt');

                        CardTxtFile.CreateOutstream(TxtStream);
                        repeat
                            TxtStream.WriteText('KINGDOM SACCO-' + ObjChqBookRequestLines."Account Name" + ',' + ObjChqBookRequestLines."Cheque Book No");
                            TxtStream.WriteText();

                            ObjChequeBookApplication.Reset;
                            ObjChequeBookApplication.SetRange(ObjChequeBookApplication."No.", ObjChqBookRequestLines."Cheque Book Application No");
                            if ObjChequeBookApplication.FindSet then begin
                                ObjChequeBookApplication."Cheque Book Ordered" := true;
                                ObjChequeBookApplication."Ordered On" := WorkDate;
                                ObjChequeBookApplication."Ordered By" := UserId;
                                ObjChequeBookApplication.Modify;
                            end;

                        until ObjChqBookRequestLines.Next = 0;
                        CardTxtFile.Close;
                        Requested := true;
                        "Requested By" := UserId;

                        ObjRequestLine.Reset;
                        ObjRequestLine.SetRange(ObjRequestLine.Ordered, false);
                        if ObjRequestLine.FindSet then begin
                            ObjRequestLine.DeleteAll;
                        end;

                        Message('The Cheque Books Order File has Been Generated to ' + ObjGensetup."Cheque Book Request Path");
                    end else
                        Message('Load Cheque Books not ordered and select the specific cheque books to order first');
                end;
            }
            action(LoadAppliedChequeBooks)
            {
                ApplicationArea = Basic;
                Caption = 'Load Applied & Not Ordered Cheque Books';
                Enabled = EnabledAction;
                Image = Allocate;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    ObjChequeBookApplication.Reset;
                    ObjChequeBookApplication.SetRange(ObjChequeBookApplication."Cheque Book Ordered", false);
                    ObjChequeBookApplication.SetRange(ObjChequeBookApplication.Status, ObjChequeBookApplication.Status::Approved);
                    ObjChequeBookApplication.SetRange(ObjChequeBookApplication."Cheque Book Fee Charged", true);
                    if ObjChequeBookApplication.FindSet then begin
                        repeat
                            ObjRequestLine.Init;
                            ObjRequestLine."Batch No." := "Batch No.";
                            ObjRequestLine."Cheque Book Application No" := ObjChequeBookApplication."No.";
                            ObjRequestLine."Cheque Book Account No" := ObjChequeBookApplication."Account No.";
                            ObjRequestLine."Cheque Book No" := ObjChequeBookApplication."Cheque Book Account No.";
                            ObjRequestLine."Account Name" := ObjChequeBookApplication.Name;
                            ObjRequestLine."Cheque Book Application Date" := ObjChequeBookApplication."Application Date";
                            ObjRequestLine.Insert;
                        until ObjChequeBookApplication.Next = 0;
                    end else
                        Message('There are no New Cheque Book Applications that have been \Approved and Charged that are pending to be ordered');
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        EnabledAction := false;
        if Requested = false then begin
            EnabledAction := true;
        end;
    end;

    trigger OnAfterGetRecord()
    begin
        EnabledAction := false;
        if Requested = false then begin
            EnabledAction := true;
        end;
    end;

    trigger OnInit()
    begin
        "Date Requested" := Today;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        "Date Requested" := Today;
    end;

    var
        FileMgt: Codeunit "File Management";
        DestinationFile: Text[150];
        ObjATMApplications: Record "ATM Card Applications";
        CardTxtFile: File;
        TxtStream: OutStream;
        varTxtData: XmlPort "ATM Card Appl";
        ObjChequeBookApplication: Record "Cheque Book Application";
        ObjGensetup: Record "Sacco General Set-Up";
        ObjRequestLine: Record "Cheque Book Request Lines";
        EnabledAction: Boolean;
        ObjChqBookRequestLines: Record "Cheque Book Request Lines";
}

