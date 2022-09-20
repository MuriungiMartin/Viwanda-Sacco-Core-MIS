page 51390 "HRRoleCenter"
{
    PageType = RoleCenter;

    layout
    {
        area(RoleCenter)
        {

        }
    }

    actions
    {
        area(Creation)
        {
            action(Approvalrequests)
            {
                RunObject = Page "Requests to Approve";
            }
        }
        area(Sections)
        {
            group(HREmployeegmt)
            {
                Caption = 'HR Employee Management';
                action(HRemps)
                {
                    Caption = 'HR Employees'' List';
                    RunObject = Page "HR Employee List";
                }
                action(HRempsReport)
                {
                    Caption = 'Employees'' List Report';
                    RunObject = report "HR Employee List";
                }
                action(HRempsPIF)
                {
                    Caption = 'Employees'' PIF';
                    RunObject = report "HR Employee PIF";
                }
            }
            group(HRLEavemgmt)
            {
                caption = 'HR Leave Management';
                action(HRleaveApp)
                {
                    Caption = 'HR Leave Application';
                    RunObject = Page "HR Leave Applications List";
                }
                action(HRLeaveReimbursement)
                {
                    Caption = 'HR Leave Reimbursement';
                    RunObject = Page "HR Leave Reimbursment List";
                }
                action(HrLeaveJournal)
                {
                    Caption = 'HR Leave Journal';
                    RunObject = Page "HR Leave Journal Lines";
                }
                action(HrPostedLeave)
                {
                    Caption = 'Posted Leave Applications';
                    RunObject = Page "Posted Leave Applications";
                }
                group(hrleavereports)
                {
                    action(hrleaveappReport)
                    {
                        Caption = 'HR Leave Application';
                        RunObject = report "HR Leave Application";
                    }
                    action(hrleavelist)
                    {
                        caption = 'HR Leave application List';
                        RunObject = report "HR Leave Applications List";

                    }
                    action("HR Leave Balances")
                    {
                        Caption = 'HR Leave Balances';
                        RunObject = report "HR Leave Balances";
                    }
                }
            }
            group(HRJobsMgmt)
            {
                Caption = 'HR Jobs Management';
                action(HrJobsList)
                {
                    Caption = 'Hr Jobs List';
                    RunObject = page "HR Jobs List";
                }
                action(HrJobAppList)
                {
                    Caption = 'Hr Job Applications';
                    RunObject = page "HR Job Applications List";
                }
                action(HrjobQualifications)
                {
                    Caption = 'HR Job Qualifications';
                    RunObject = page "HR Job Qualifications";
                }
                action(Hrjbappqualified)
                {
                    Caption = 'HR Job Aplicants Qualified';
                    RunObject = page "HR Job Applicants Qualified";
                }
            }
            group(HrTrainingmgt)
            {
                Caption = 'HR Training Management';
                action(HRTrainingNeeds)
                {
                    Caption = 'HR Training Needs';
                    RunObject = page "HR Training Needs";
                }
                action(HRTrainingApp)
                {
                    Caption = 'HR Training Aplication';
                    RunObject = page "HR Training Application List";
                }
                action(HRTrainingGroup)
                {
                    Caption = 'HR Training Group';
                    RunObject = page "HR Training Group";
                }
                group(TrainingReports)
                {
                    Caption = 'HR Trainig Reports';
                    action(HRTrainingReportAction)
                    {
                        Caption = 'HR Trainig Applications Report';
                        RunObject = report "HR Training Applications List";
                    }

                    action(HRTrainingNeedsRpt)
                    {
                        Caption = 'HR Trainig Needs Report';
                        RunObject = report "HR Training Needs";
                    }
                }
            }
            group(HRGenSetup)
            {
                Caption = 'HR General Setup';
                action("HR Setup")
                {
                    RunObject = page "HR Setup";
                }
                action("HR Lookup Values List")
                {
                    RunObject = page "HR Lookup Values List";
                }
                action("HR Leave Types")
                {
                    RunObject = page "HR Leave Types";
                }
                action("HR E-Mail Parameters")
                {
                    RunObject = page "HR E-Mail Parameters";
                }
                action("HR Leave Period List")
                {
                    RunObject = page "HR Leave Period List";
                }
            }
        }
        area(Embedding)
        {
            action(hrleavejournalEmbedded)
            {
                RunObject = Page "HR Leave Journal Lines";
            }
        }
    }
}