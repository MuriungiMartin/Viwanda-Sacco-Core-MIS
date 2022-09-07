#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50519 "SMS Messages"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "SMS Messages";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No"; "Entry No")
                {
                    ApplicationArea = Basic;
                }
                field(Source; Source)
                {
                    ApplicationArea = Basic;
                }
                field("Account No"; "Account No")
                {
                    ApplicationArea = Basic;
                }
                field("Telephone No"; "Telephone No")
                {
                    ApplicationArea = Basic;
                }
                field("SMS Message"; "SMS Message")
                {
                    ApplicationArea = Basic;
                }
                field("Additional Message"; "Additional Message")
                {
                    ApplicationArea = Basic;
                }
                field("Date Entered"; "Date Entered")
                {
                    ApplicationArea = Basic;
                }
                field("Time Entered"; "Time Entered")
                {
                    ApplicationArea = Basic;
                }
                field("Entered By"; "Entered By")
                {
                    ApplicationArea = Basic;
                }
                field("Sent To Server"; "Sent To Server")
                {
                    ApplicationArea = Basic;
                }
                field("Date Sent to Server"; "Date Sent to Server")
                {
                    ApplicationArea = Basic;
                }
                field(Fetched; Fetched)
                {
                    ApplicationArea = Basic;
                }
                field("Delivery Status"; "Delivery Status")
                {
                    ApplicationArea = Basic;
                }
                field("Bulk SMS Balance"; "Bulk SMS Balance")
                {
                    ApplicationArea = Basic;
                }
                field(ScheduledOn; ScheduledOn)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Resend Message")
            {
                ApplicationArea = Basic;
                Caption = 'Resend Message';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    text001: label 'This batch is already pending approval';
                    ApprovalMgt: Codeunit "Approvals Mgmt.";
                begin
                    SMSMessage.Reset;
                    SMSMessage.SetCurrentkey(SMSMessage."Entry No");
                    if SMSMessage.FindLast then begin
                        iEntryNo := SMSMessage."Entry No" + 10;
                    end
                    else begin
                        iEntryNo := 10;
                    end;

                    SMSMessage.Init;
                    SMSMessage."Entry No" := iEntryNo;
                    SMSMessage."Batch No" := "Batch No";
                    SMSMessage."Document No" := "Document No";
                    SMSMessage."Account No" := "Account No";
                    SMSMessage."Date Entered" := Today;
                    SMSMessage."Time Entered" := Time;
                    SMSMessage.Source := Source;
                    SMSMessage."Entered By" := UserId;
                    SMSMessage."Sent To Server" := SMSMessage."sent to server"::No;
                    SMSMessage."SMS Message" := "SMS Message";
                    SMSMessage."Additional Message" := "Additional Message";
                    SMSMessage."Telephone No" := "Telephone No";
                    SMSMessage.ScheduledOn := ScheduledOn;
                    SMSMessage.Insert;

                    Message('The SMS Message:\\%1\\has been resend to %2', "SMS Message" + ' ' + "Additional Message", "Telephone No");
                end;
            }
        }
    }

    var
        SMSMessage: Record "SMS Messages";
        iEntryNo: Integer;
}

