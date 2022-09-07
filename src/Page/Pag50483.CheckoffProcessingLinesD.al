#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50483 "Checkoff Processing Lines-D"
{
    DelayedInsert = false;
    DeleteAllowed = true;
    Editable = true;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = "Checkoff Lines-Distributed";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Payroll No"; "Payroll No")
                {
                    ApplicationArea = Basic;
                    StyleExpr = CoveragePercentStyle;
                }
                field("Employee Name"; "Employee Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Member No"; "Member No")
                {
                    ApplicationArea = Basic;
                }
                field("Checkoff No"; "Checkoff No")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(REGFEE; REGFEE)
                {
                    ApplicationArea = Basic;
                    Caption = 'REGISTRATION FEE';
                }
                field(Deposits; Deposits)
                {
                    ApplicationArea = Basic;
                    Caption = 'SHARE CAPITAL';
                }
                field(BENEVOLENT; BENEVOLENT)
                {
                    ApplicationArea = Basic;
                }
                field(SHARES; SHARES)
                {
                    ApplicationArea = Basic;
                    Caption = 'DEPOSIT CONTRIBUTION';
                }
                field(DL_P; DL_P)
                {
                    ApplicationArea = Basic;
                }
                field(DL_I; DL_I)
                {
                    ApplicationArea = Basic;
                }
                field(EL_P; EL_P)
                {
                    ApplicationArea = Basic;
                }
                field(EL_I; EL_I)
                {
                    ApplicationArea = Basic;
                }
                field(SFL_P; SFL_P)
                {
                    ApplicationArea = Basic;
                }
                field(SFL_I; SFL_I)
                {
                    ApplicationArea = Basic;
                }
                field(IL_P; IL_P)
                {
                    ApplicationArea = Basic;
                }
                field(IL_I; IL_I)
                {
                    ApplicationArea = Basic;
                }
                field(TL_P; TL_P)
                {
                    ApplicationArea = Basic;
                }
                field(TL_I; TL_I)
                {
                    ApplicationArea = Basic;
                }
                field(SSFL_P; SSFL_P)
                {
                    ApplicationArea = Basic;
                }
                field(SSFL_I; SSFL_I)
                {
                    ApplicationArea = Basic;
                }
                field(SAD; SAD)
                {
                    ApplicationArea = Basic;
                }
                field("SILVER SAVINGS"; "SILVER SAVINGS")
                {
                    ApplicationArea = Basic;
                }
                field(SAI; SAI)
                {
                    ApplicationArea = Basic;
                }
                field("MAONO-MEMB"; "MAONO-MEMB")
                {
                    ApplicationArea = Basic;
                }
                field("MAONO-H"; "MAONO-H")
                {
                    ApplicationArea = Basic;
                }
                field(SPL_P; SPL_P)
                {
                    ApplicationArea = Basic;
                }
                field(SPL_I; SPL_I)
                {
                    ApplicationArea = Basic;
                }
                field("SHAMBAL-P"; "SHAMBAL-P")
                {
                    ApplicationArea = Basic;
                }
                field("SHAMBA-I"; "SHAMBA-I")
                {
                    ApplicationArea = Basic;
                }
                field("SAFARI SAVINGS"; "SAFARI SAVINGS")
                {
                    ApplicationArea = Basic;
                }
                field("JUNIOR SAVINGS"; "JUNIOR SAVINGS")
                {
                    ApplicationArea = Basic;
                }
                field(TOTAL_DISTRIBUTED; TOTAL_DISTRIBUTED)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        SetStyles();
    end;

    var
        CoveragePercentStyle: Text;

    local procedure SetStyles()
    begin
        CoveragePercentStyle := 'Strong';
        if "Member No" = '' then
            CoveragePercentStyle := 'Unfavorable';
        if "Member No" <> '' then
            CoveragePercentStyle := 'Favorable';
    end;
}

