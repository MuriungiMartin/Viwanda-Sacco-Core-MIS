#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50236 "HR Appraisal Card"
{
    PageType = Card;
    SourceTable = "HR Appraisal Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Appraisal No"; "Appraisal No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Employee No"; "Employee No")
                {
                    ApplicationArea = Basic;
                }
                field("Employee Name"; "Employee Name")
                {
                    ApplicationArea = Basic;
                }
                field(Supervisor; Supervisor)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Date of Employment"; "Date of Employment")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                }
                field("Job Title"; "Job Title")
                {
                    ApplicationArea = Basic;
                }
                field("Contract Type"; "Contract Type")
                {
                    ApplicationArea = Basic;
                }
                field("Appraisal Period"; "Appraisal Period")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Status; Status)
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("User ID"; "User ID")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Appraisal Approval Status"; "Appraisal Approval Status")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Comments Appraisee"; "Comments Appraisee")
                {
                    ApplicationArea = Basic;
                }
                field("Appraisal Date"; "Appraisal Date")
                {
                    ApplicationArea = Basic;
                }
                field("Evaluation Period Start"; "Evaluation Period Start")
                {
                    ApplicationArea = Basic;
                }
                field("Evaluation Period End"; "Evaluation Period End")
                {
                    ApplicationArea = Basic;
                }
                field("Responsibility/Duties Agrd Sco"; "Responsibility/Duties Agrd Sco")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Attendance&Punctuality Agr Sco"; "Attendance&Punctuality Agr Sco")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Communication Agreed Score"; "Communication Agreed Score")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Cooperation Agreed Score"; "Cooperation Agreed Score")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Customer Service Agreed Score"; "Customer Service Agreed Score")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Initiative Agreed Score"; "Initiative Agreed Score")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Quality Agreed Score"; "Quality Agreed Score")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Teamwork Agreed Score"; "Teamwork Agreed Score")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Sales Skills Agreed Score"; "Sales Skills Agreed Score")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Leadership Agreed Score"; "Leadership Agreed Score")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Performance Coaching Agreed Sc"; "Performance Coaching Agreed Sc")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            part(Control9; "Account AgenSignatory-Uploaded")
            {
                // SubPageLink = "Appraisal No"=field("Appraisal No"),
                //               "Appraisal Period"=field("Appraisal Period"),
                //               "Employee No"=field("Employee No");
                // SubPageView = sorting(Sections)
                //               order(ascending);
            }
        }
        area(factboxes)
        {
            systempart(Control43; Outlook)
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Load Sections")
            {
                ApplicationArea = Basic;
                Image = BinJournal;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if Status <> Status::Open then Error('Sorry, appraisal number %1 is not open for appending the lines', "Appraisal No");

                    //Delete the lines for the period--
                    AppLines.Reset;
                    AppLines.SetRange(AppLines."Appraisal No", "Appraisal No");
                    AppLines.SetRange(AppLines."Appraisal Period", "Appraisal Period");
                    AppLines.SetRange(AppLines."Employee No", "Employee No");
                    if AppLines.Find('-') then begin
                        if Confirm('Lines exist for this appraisal period do you want to overwrite?', false) = true then begin
                            AppLines.DeleteAll(true);
                        end else begin
                            exit;
                        end;
                    end;

                    //Get last no.
                    AppLines.Reset;
                    AppLines.SetRange(AppLines."Line No");
                    if AppLines.Find('+') then LastLineNo := AppLines."Line No";

                    //Load Job responsibilities
                    HRJobResp.Reset;
                    HRJobResp.SetRange(HRJobResp."Job ID", "Job Title");
                    if HRJobResp.Find('-') then
                        repeat
                            AppLines.Init;
                            AppLines."Line No" := AppLines."Line No" + 1;
                            AppLines."Appraisal No" := "Appraisal No";
                            AppLines."Appraisal Period" := "Appraisal Period";
                            AppLines."Employee No" := "Employee No";
                            //AppLines.Sections:=AppLines.Sections::"Core Responsibilities/Duties";
                            AppLines."Perfomance Goals and Targets" := HRJobResp."Responsibility Description";
                            AppLines."Self Rating" := 0;
                            AppLines.Insert;
                        until HRJobResp.Next = 0;

                    //Get current and load the Last appraisal objectives
                    HRLookupValCurr.Reset;
                    HRLookupValCurr.SetRange(HRLookupValCurr.Code, "Appraisal Period");
                    if HRLookupValCurr.Find('-') then begin
                        HRAppraisalLinePrev.Reset;
                        HRAppraisalLinePrev.SetRange(HRAppraisalLinePrev."Appraisal Period", HRLookupValCurr."Previous Appraisal Code");
                        HRAppraisalLinePrev.SetRange(HRAppraisalLinePrev.Sections, HRAppraisalLinePrev.Sections::Objectives);
                        if HRAppraisalLinePrev.Find('-') then
                            repeat
                                AppLines.Init;
                                AppLines."Line No" := AppLines."Line No" + 1;
                                AppLines."Appraisal No" := "Appraisal No";
                                AppLines."Appraisal Period" := "Appraisal Period";
                                AppLines."Employee No" := "Employee No";
                                AppLines.Sections := AppLines.Sections::"Last year's goals";
                                AppLines."Perfomance Goals and Targets" := HRAppraisalLinePrev."Perfomance Goals and Targets";
                                AppLines."Self Rating" := 0;
                                AppLines.Insert;
                            until HRAppraisalLinePrev.Next = 0;
                    end;
                    /*
                     //objAppraisalEvaluationAreas
                     objAppraisalEvaluationAreas.RESET;
                     objAppraisalEvaluationAreas.SETRANGE(objAppraisalEvaluationAreas."Line No",TRUE);
                     IF objAppraisalEvaluationAreas.FIND('-') THEN
                      REPEAT
                                AppLines.INIT;
                                AppLines."Line No":=AppLines."Line No"+1;
                                AppLines."Appraisal No":="Appraisal No";
                                AppLines."Appraisal Period":="Appraisal Period";
                                AppLines."Employee No":="Employee No";
                                //AppLines.Sections:=objAppraisalEvaluationAreas."External Source Code";
                                AppLines."Perfomance Goals and Targets":=objAppraisalEvaluationAreas.Code;
                                AppLines."Self Rating":=0;
                                AppLines.INSERT;
                      UNTIL objAppraisalEvaluationAreas.NEXT=0;
                     */

                end;
            }
            group("Request Approval")
            {
                Caption = 'Request Approval';
                action(SendApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = 'Send A&pproval Request';
                    Enabled = not OpenApprovalEntriesExist;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category9;

                    trigger OnAction()
                    begin
                        //IF ApprovalsMgmt.CheckSalesApprovalsWorkflowEnabled(Rec) THEN
                        //ApprovalsMgmt.OnSendSalesDocForApproval(Rec);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = OpenApprovalEntriesExist;
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category9;

                    trigger OnAction()
                    begin
                        //ApprovalsMgmt.OnCancelSalesApprovalRequest(Rec);
                    end;
                }
            }
            action("Print Form")
            {
                ApplicationArea = Basic;
                Caption = 'Print Form';
                Image = Print;
                Promoted = true;
                PromotedCategory = Category4;

                trigger OnAction()
                begin
                    objAppraisal.Reset;
                    objAppraisal.SetRange(objAppraisal."Appraisal No", "Appraisal No");
                    if objAppraisal.Find('-') then
                        Report.Run(53924, true, true, objAppraisal);
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        //GET APPLICANT DETAILS FROM HR EMPLOYEES TABLE AND COPY THEM TO THE GOAL SETTING TABLE
        HREmp.Reset;
        if HREmp.Get("Employee No") then begin
            "Employee Name" := HREmp."First Name" + ' ' + HREmp."Middle Name" + ' ' + HREmp."Last Name";
            "Date of Employment" := HREmp."Date Of Joining the Company";
            "Global Dimension 1 Code" := HREmp."Global Dimension 1 Code";
            "Global Dimension 2 Code" := HREmp."Global Dimension 2 Code";
            "Job Title" := HREmp."Job Specification";
            "Contract Type" := HREmp."Contract Type";
            "User ID" := HREmp."User ID";
            Supervisor := HREmpCard.GetSupervisor("User ID");
            HREmp.CalcFields(HREmp.Picture);
            Picture := HREmp.Picture;
        end else begin
            Error('Employee No' + ' ' + "Employee No" + ' ' + 'is not assigned to any employee. Consult the HR Officer so as to be setup as an employee')
        end;
    end;

    var
        HRJobResp: Record "HR Job Responsiblities";
        AppLines: Record "HR Appraisal Lines";
        HRAppraisalLinePrev: Record "HR Appraisal Lines";
        LastLineNo: Integer;
        HRLookupValCurr: Record "HR Lookup Values";
        HREmployees: Record "HR Employees";
        objAppraisalEvaluationAreas: Record "HR Appraisal Eval Areas";
        objAppraisal: Record "HR Appraisal Header";
        HREmp: Record "HR Employees";
        HREmpCard: Page "HR Employee Card";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        ShowWorkflowStatus: Boolean;


    procedure enableDisable() enableDisable: Boolean
    begin
        enableDisable := false;
    end;
}

