#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50886 "Member Case History"
{
    Editable = false;
    PageType = ListPart;
    SourceTable = "Cases Management";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Case Number"; "Case Number")
                {
                    ApplicationArea = Basic;
                }
                field("Date of Complaint"; "Date of Complaint")
                {
                    ApplicationArea = Basic;
                }
                field("Type of cases"; "Type of cases")
                {
                    ApplicationArea = Basic;
                }
                field("Recommended Action"; "Recommended Action")
                {
                    ApplicationArea = Basic;
                }
                field("Case Description"; "Case Description")
                {
                    ApplicationArea = Basic;
                }
                field("Action Taken"; "Action Taken")
                {
                    ApplicationArea = Basic;
                }
                field("Solution Remarks"; "Solution Remarks")
                {
                    ApplicationArea = Basic;
                }
                field("Case Resolution Details"; "Case Resolution Details")
                {
                    ApplicationArea = Basic;
                }
                field("Caller Reffered To"; "Caller Reffered To")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Status)
                {
                    ApplicationArea = Basic;
                }
                field("Resolved User"; "Resolved User")
                {
                    ApplicationArea = Basic;
                    Caption = 'Resolved By';
                }
                field("Date Resolved"; "Date Resolved")
                {
                    ApplicationArea = Basic;
                }
                field("Time Resolved"; "Time Resolved")
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

