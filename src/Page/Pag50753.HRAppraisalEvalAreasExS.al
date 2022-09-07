#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50753 "HR Appraisal Eval Areas - ExS"
{
    Caption = 'HR Appraisal Evaluation Areas - External Sources';
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "HR Appraisal Eval Areas";
    SourceTableView = where("Categorize As" = const("External Sources"));

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                Editable = true;
                field("Code"; Code)
                {
                    ApplicationArea = Basic;
                }
                field(Description; Description)
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        TestField(Code);
                    end;
                }
                field("Categorize As"; "Categorize As")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Sub Category"; "Sub Category")
                {
                    ApplicationArea = Basic;
                }
                field("Include in Evaluation Form"; "Include in Evaluation Form")
                {
                    ApplicationArea = Basic;
                }
                field("Appraisal Period"; "Appraisal Period")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        "Categorize As" := "categorize as"::"External Sources";
        "Include in Evaluation Form" := true;
    end;
}

