#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50200 "HR Leave Applicaitons Factbox"
{
    PageType = CardPart;
    SourceTable = "HR Employees";

    layout
    {
        area(content)
        {
            label(Control1102755011)
            {
                ApplicationArea = Basic;
                CaptionClass = Text1;
                Style = StrongAccent;
                StyleExpr = true;
            }
            field("No."; "No.")
            {
                ApplicationArea = Basic;
            }
            field("First Name"; "First Name")
            {
                ApplicationArea = Basic;
            }
            field("Middle Name"; "Middle Name")
            {
                ApplicationArea = Basic;
            }
            field("Last Name"; "Last Name")
            {
                ApplicationArea = Basic;
            }
            field("Job Title"; "Job Title")
            {
                ApplicationArea = Basic;
            }
            field(Status; Status)
            {
                ApplicationArea = Basic;
            }
            field("E-Mail"; "E-Mail")
            {
                ApplicationArea = Basic;
            }
            label(Control1102755005)
            {
                ApplicationArea = Basic;
                Style = StrongAccent;
                StyleExpr = true;
            }
            label(Control1102755012)
            {
                ApplicationArea = Basic;
                CaptionClass = Text2;
                Style = StrongAccent;
                StyleExpr = true;
            }
            field("Allocated Leave Days"; "Allocated Leave Days")
            {
                ApplicationArea = Basic;
            }
            field("Reimbursed Leave Days 2"; "Reimbursed Leave Days 2")
            {
                ApplicationArea = Basic;
                Caption = 'Reimbursed Leave Days';
            }
            field("Total Leave Taken"; "Total Leave Taken")
            {
                ApplicationArea = Basic;
                Caption = 'Total Leave Days Taken';
            }
            field("Annual Leave Account"; "Annual Leave Account")
            {
                ApplicationArea = Basic;
            }
            field("Compassionate Leave Acc."; "Compassionate Leave Acc.")
            {
                ApplicationArea = Basic;
            }
            field("Maternity Leave Acc."; "Maternity Leave Acc.")
            {
                ApplicationArea = Basic;
            }
            field("Paternity Leave Acc."; "Paternity Leave Acc.")
            {
                ApplicationArea = Basic;
            }
            field("Sick Leave Acc."; "Sick Leave Acc.")
            {
                ApplicationArea = Basic;
            }
            field("Study Leave Acc"; "Study Leave Acc")
            {
                ApplicationArea = Basic;
            }
        }
    }

    actions
    {
    }

    var
        Text1: label 'Employee Details';
        Text2: label 'Employeee Leave Details';
    //Text3: ;
}

