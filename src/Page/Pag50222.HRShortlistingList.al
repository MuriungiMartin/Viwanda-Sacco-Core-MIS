#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50222 "HR Shortlisting List"
{
    CardPageID = "HR Shortlisting Card";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "HR Employee Requisitions";
    SourceTableView = where(Status = const(Approved),
                            Closed = const(false));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Requisition No."; "Requisition No.")
                {
                    ApplicationArea = Basic;
                }
                field("Job Description"; "Job Description")
                {
                    ApplicationArea = Basic;
                }
                field("Requisition Date"; "Requisition Date")
                {
                    ApplicationArea = Basic;
                }
                field(Requestor; Requestor)
                {
                    ApplicationArea = Basic;
                }
                field("Reason For Request"; "Reason For Request")
                {
                    ApplicationArea = Basic;
                }
                field(Closed; Closed)
                {
                    ApplicationArea = Basic;
                }
                field("Closing Date"; "Closing Date")
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {
            part(Control1102755006; "HR Jobs Factbox")
            {
                SubPageLink = "Job ID" = field("Job ID");
            }
            systempart(Control1102755005; Outlook)
            {
            }
        }
    }

    actions
    {
    }
}

