#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50770 "Control Risk Rating"
{
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Control Risk Rating";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Control Factor"; "Control Factor")
                {
                    ApplicationArea = Basic;
                }
                field("Control Weighting(%)"; "Control Weighting(%)")
                {
                    ApplicationArea = Basic;
                    Caption = 'Control Weighting:[To be Based on the SACCO''s Annual Complience Report]';
                }
                field("Does  Control Cure Risk(1-3)"; "Does  Control Cure Risk(1-3)")
                {
                    ApplicationArea = Basic;
                    Caption = 'Does  Control Cure the Risk Effectively?[Scale 1-3]';
                }
                field("Control Been Documented(1-3)"; "Control Been Documented(1-3)")
                {
                    ApplicationArea = Basic;
                    Caption = 'Has the Control Been Documented & Approved?[Scale 1-3]';
                }
                field("Control Been Communicated(1-3)"; "Control Been Communicated(1-3)")
                {
                    ApplicationArea = Basic;
                    Caption = 'Has the Control Been Officially Communicated?[Scale 1-3]';
                }
                field("Control Weight Aggregate"; "Control Weight Aggregate")
                {
                    ApplicationArea = Basic;
                    Caption = 'Wighted Control Risk Score:[Control Weighting*Agg. Score]';
                }
            }
        }
    }

    actions
    {
    }
}

