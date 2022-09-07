#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50015 "Audit Tracker Card"
{
    PageType = Card;
    SourceTable = "Audit Issues Tracker";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Document No";"Document No")
                {
                    ApplicationArea = Basic;
                }
                field("Date Of Audit";"Date Of Audit")
                {
                    ApplicationArea = Basic;
                    Editable = IsInternalAuditor;
                }
                field(Theme;Theme)
                {
                    ApplicationArea = Basic;
                    Editable = IsInternalAuditor;
                }
                field("Theme Description";"Theme Description")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Issue Description";"Issue Description")
                {
                    ApplicationArea = Basic;
                    Editable = IsInternalAuditor;
                    MultiLine = true;
                }
                field("Issue Description Additional";"Issue Description Additional")
                {
                    ApplicationArea = Basic;
                    Caption = 'Audit Recommendations';
                    Editable = IsInternalAuditor;
                    MultiLine = true;
                }
                field("Mgt Action Point";"Mgt Action Point")
                {
                    ApplicationArea = Basic;
                    Editable = IsInternalAuditor;
                    MultiLine = true;
                }
                field("Action Owner";"Action Owner")
                {
                    ApplicationArea = Basic;
                    Editable = IsInternalAuditor;
                }
                field("Action Date";"Action Date")
                {
                    ApplicationArea = Basic;
                    Editable = IsInternalAuditor;
                }
                field("Day Past";"Day Past")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Status;Status)
                {
                    ApplicationArea = Basic;
                    OptionCaption = ' ,Open,Due,OverDue,Closed,Failed';
                }
                field("Combined Status";"Combined Status")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Mgt Response";"Mgt Response")
                {
                    ApplicationArea = Basic;
                }
                field("Revised Mgt Comment";"Revised Mgt Comment")
                {
                    ApplicationArea = Basic;
                    MultiLine = true;
                }
                field("Revised Mgt Comment Additional";"Revised Mgt Comment Additional")
                {
                    ApplicationArea = Basic;
                    Caption = 'Revised Mgt Comment Additional Details';
                    MultiLine = true;
                }
                field("Audit Opinion On Closure";"Audit Opinion On Closure")
                {
                    ApplicationArea = Basic;
                    Editable = IsInternalAuditor;
                }
                field("Audit Comments After Review";"Audit Comments After Review")
                {
                    ApplicationArea = Basic;
                    Editable = IsInternalAuditor;
                    MultiLine = true;
                }
                field("Mgt Comment After Review";"Mgt Comment After Review")
                {
                    ApplicationArea = Basic;
                    Editable = IsInternalAuditor;
                    MultiLine = true;
                }
                field("Revised Implementation";"Revised Implementation")
                {
                    ApplicationArea = Basic;
                    Editable = IsInternalAuditor;
                }
                field("Mnt response on failed";"Mnt response on failed")
                {
                    ApplicationArea = Basic;
                    Editable = IsInternalAuditor;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetCurrRecord()
    begin
        FnRunUpdateStatus;
        SetStyles
    end;

    trigger OnAfterGetRecord()
    begin
         //FnRunUpdateStatus;
         //SetStyles
    end;

    trigger OnOpenPage()
    begin
        UserSetup.Reset;
        UserSetup.SetRange(UserSetup."User ID",UserId);
        if UserSetup.FindSet then
        begin
          IsInternalAuditor:=UserSetup."Is Internal Auditor";
        end;
    end;

    var
        ObjAuditSetup: Record "Audit General Setup";
        CoveragePercentStyle: Text;
        UserSetup: Record "User Setup";
        IsInternalAuditor: Boolean;

    local procedure FnRunUpdateStatus()
    begin
        if "Action Date" <> 0D then
        begin
          "Day Past":=WorkDate-"Action Date";

          Status:=Status::" ";
          ObjAuditSetup.Get;
          if "Audit Opinion On Closure"="audit opinion on closure"::Closed then
          begin
            Status:=Status::Closed
          end else
          if "Audit Opinion On Closure"="audit opinion on closure"::Failed then
          begin
            Status:=Status::Failed
          end else
          if ("Audit Opinion On Closure"="audit opinion on closure"::"Issue Assurance Not Yet Done") and
           ("Day Past">ObjAuditSetup."Over Due Date") then
          begin
            Status:=Status::OverDue
          end else
          if ("Audit Opinion On Closure"="audit opinion on closure"::"Issue Assurance Not Yet Done") and
           ("Day Past">ObjAuditSetup."Due Date") then
          begin
            Status:=Status::Due
          end;
        end;

        "Combined Status":=Format(Status)+' '+Format("Mgt Response");
        Modify;
    end;

    local procedure SetStyles()
    begin
        CoveragePercentStyle:='Strong';
        if (Status =Status::Due) or (Status =Status::Closed)  then
           CoveragePercentStyle := 'Unfavorable';
        if (Status =Status::Open) or (Status =Status::OverDue)  then
            CoveragePercentStyle := 'Favorable';
    end;
}

