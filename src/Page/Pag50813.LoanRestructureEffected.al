#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50813 "Loan Restructure - Effected"
{
    CardPageID = "Loan Restructure Card";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Loan Rescheduling";
    SourceTableView = where(Status = filter(Approved),
                            Rescheduled = const(true));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No"; "Document No")
                {
                    ApplicationArea = Basic;
                }
                field("Member No"; "Member No")
                {
                    ApplicationArea = Basic;
                }
                field("Member Name"; "Member Name")
                {
                    ApplicationArea = Basic;
                }
                field("Loan No"; "Loan No")
                {
                    ApplicationArea = Basic;
                }
                field("Issue Date"; "Issue Date")
                {
                    ApplicationArea = Basic;
                }
                field("Approved Amount"; "Approved Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Outstanding Loan Amount"; "Outstanding Loan Amount")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Status)
                {
                    ApplicationArea = Basic;
                }
                field(Rescheduled; Rescheduled)
                {
                    ApplicationArea = Basic;
                }
                field("Rescheduled By"; "Rescheduled By")
                {
                    ApplicationArea = Basic;
                }
                field("Rescheduled Date"; "Rescheduled Date")
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
            action("Members Statistics")
            {
                ApplicationArea = Basic;
                Caption = 'New Schedule';
                Image = Statistics;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    LoanRegister.Reset;
                    LoanRegister.SetRange(LoanRegister."Loan  No.", "Loan No");
                    if LoanRegister.Find('-') then begin
                        Report.Run(50477, true, false, LoanRegister);
                    end;
                end;
            }
        }
    }

    var
        LoanRegister: Record "Loans Register";
}

