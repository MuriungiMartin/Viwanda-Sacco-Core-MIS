#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50948 "ATM Card Request Batch Card"
{
    PageType = Card;
    SourceTable = "ATM Card Order Batch";

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
                    Editable = EnableAction;
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
            part(Control11; "ATM Card Request SubPage")
            {
                SubPageLink = "Batch No." = field("Batch No.");
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(OrderCards)
            {
                ApplicationArea = Basic;
                Caption = 'Order Cards';
                Enabled = EnableAction;
                Image = Export;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    ObjGensetup.Get;

                    ObjRequestLine.Reset;
                    ObjRequestLine.SetRange(ObjRequestLine."Batch No.", "Batch No.");
                    ObjRequestLine.SetRange(ObjRequestLine.Ordered, true);
                    if ObjRequestLine.FindSet then begin
                        CardTxtFile.Create(ObjGensetup."ATM Card Request Path" + Format(WorkDate, 0, '<Day,2><Month,2><Year4>') + '_KINGDOM SACCO LIMITED.sfu');
                        CardTxtFile.CreateOutstream(TxtStream);
                        repeat
                            VarApplicantName := ConvertStr(ObjRequestLine."Account Name", ' ', ',') + ',,';

                            TxtStream.WriteText('BEGIN');
                            TxtStream.WriteText();
                            TxtStream.WriteText(SelectStr(1, VarApplicantName) + ' ' + SelectStr(2, VarApplicantName));
                            TxtStream.WriteText();
                            TxtStream.WriteText(SelectStr(3, VarApplicantName) + ' ' + SelectStr(4, VarApplicantName));
                            TxtStream.WriteText();
                            TxtStream.WriteText(ObjRequestLine."ID No");
                            TxtStream.WriteText();
                            TxtStream.WriteText('C.O. GITHURAI');
                            TxtStream.WriteText();
                            TxtStream.WriteText('42993344-' + ObjRequestLine."ATM Card Account No");
                            TxtStream.WriteText();
                            TxtStream.WriteText('47');
                            TxtStream.WriteText();
                            TxtStream.WriteText(ObjRequestLine."Phone No");
                            TxtStream.WriteText();
                            TxtStream.WriteText('42993344');
                            TxtStream.WriteText();
                            TxtStream.WriteText('KINGDOM SACCO LIMITED');
                            TxtStream.WriteText();
                            TxtStream.WriteText('END');
                            TxtStream.WriteText();

                            ObjATMApplications.Reset;
                            ObjATMApplications.SetRange(ObjATMApplications."No.", ObjRequestLine."ATM Application No");
                            if ObjATMApplications.FindSet then begin
                                ObjATMApplications."Order ATM Card" := true;
                                ObjATMApplications."Ordered On" := WorkDate;
                                ObjATMApplications."Ordered By" := UserId;
                                ObjATMApplications.Modify;
                            end;

                        until ObjRequestLine.Next = 0;
                        CardTxtFile.Close;

                        Requested := true;
                        "Requested By" := UserId;

                        ObjRequestLine.Reset;
                        ObjRequestLine.SetRange(ObjRequestLine."Batch No.", "Batch No.");
                        ObjRequestLine.SetRange(ObjRequestLine.Ordered, false);
                        if ObjRequestLine.FindSet then begin
                            ObjRequestLine.DeleteAll;
                        end;

                        Message('The ATM Cards Order File ' + Format(WorkDate, 0, '<Day,2><Month,2><Year4>') + '_KINGDOM SACCO LIMITED.sfu' +
                        ' has Been Generated to ' + ObjGensetup."ATM Card Request Path");
                    end else
                        Message('There are no ATM Cards selected to be ordered');
                end;
            }
            action(LoadAppliedCards)
            {
                ApplicationArea = Basic;
                Caption = 'Load Applied & Not Ordered ATM Cards';
                Enabled = EnableAction;
                Image = Allocate;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    ObjATMApplications.Reset;
                    ObjATMApplications.SetRange(ObjATMApplications."Order ATM Card", false);
                    ObjATMApplications.SetRange(ObjATMApplications.Status, ObjATMApplications.Status::Approved);
                    ObjATMApplications.SetRange(ObjATMApplications."ATM Card Fee Charged", true);
                    if ObjATMApplications.FindSet then begin
                        repeat
                            ObjRequestLine.Init;
                            ObjRequestLine."Batch No." := "Batch No.";
                            ObjRequestLine."ATM Application No" := ObjATMApplications."No.";
                            ObjRequestLine."ATM Card Account No" := ObjATMApplications."Account No";
                            ObjRequestLine."Account Name" := ObjATMApplications."Account Name";
                            ObjRequestLine."ATM Card Application Date" := ObjATMApplications."Application Date";
                            ObjRequestLine."Phone No" := ObjATMApplications."Phone No.";
                            ObjRequestLine."ID No" := ObjATMApplications."ID No";
                            ObjRequestLine.Insert;
                        until ObjATMApplications.Next = 0;
                    end else
                        Message('There are no New ATM Card Applications that have been \approved and charged that are pending to be ordered.')
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        EnableAction := false;
        if Requested = false then
            EnableAction := true;
    end;

    trigger OnAfterGetRecord()
    begin
        EnableAction := false;
        if Requested = false then
            EnableAction := true;
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
        VarApplicantName: Text;
        ObjGensetup: Record "Sacco General Set-Up";
        ObjRequestLine: Record "ATM Card Request Lines";
        EnableAction: Boolean;
}

