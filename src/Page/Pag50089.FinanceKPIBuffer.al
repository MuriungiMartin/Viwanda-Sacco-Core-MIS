#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50089 "Finance KPI Buffer"
{
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Finance KPI Buffer";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Caption; Caption)
                {
                    ApplicationArea = Basic;
                }
                field("Entry No"; "Entry No")
                {
                    ApplicationArea = Basic;
                }
                field(Description; Description)
                {
                    ApplicationArea = Basic;
                }
                field("Base G/L Account"; "Base G/L Account")
                {
                    ApplicationArea = Basic;
                }
                field("Denominator G/L Account"; "Denominator G/L Account")
                {
                    ApplicationArea = Basic;
                }
                field("KSACCO Targets"; "KSACCO Targets")
                {
                    ApplicationArea = Basic;
                }
                field(BenchMarks; BenchMarks)
                {
                    ApplicationArea = Basic;
                }
                field("Base G/L Account to Sum"; "Base G/L Account to Sum")
                {
                    ApplicationArea = Basic;
                }
                field("Base G/L Account to Less"; "Base G/L Account to Less")
                {
                    ApplicationArea = Basic;
                }
                field("Denominator G/L Account to Sum"; "Denominator G/L Account to Sum")
                {
                    ApplicationArea = Basic;
                }
                field("Denominator G/L Account to Les"; "Denominator G/L Account to Les")
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

