#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50654 "Finance UpLoads Lines"
{
    DelayedInsert = false;
    PageType = ListPart;
    SourceTable = "Finance Uploads Lines";

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                Editable = true;
                field("Debit Account Type"; "Debit Account Type")
                {
                    ApplicationArea = Basic;
                }
                field("Debit Account No"; "Debit Account No")
                {
                    ApplicationArea = Basic;
                    StyleExpr = CoveragePercentStyle;
                }
                field("Debit Narration"; "Debit Narration")
                {
                    ApplicationArea = Basic;
                }
                field("Debit Account Balance Status"; "Debit Account Balance Status")
                {
                    ApplicationArea = Basic;
                    StyleExpr = CoveragePercentStyle;
                }
                field("Debit Account Status"; "Debit Account Status")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    StyleExpr = CoveragePercentStyleII;
                }
                field("Reference No"; "Reference No")
                {
                    ApplicationArea = Basic;
                }
                field(Amount; Amount)
                {
                    ApplicationArea = Basic;
                }
                field("Credit Account Type"; "Credit Account Type")
                {
                    ApplicationArea = Basic;
                }
                field("Credit Account No"; "Credit Account No")
                {
                    ApplicationArea = Basic;
                }
                field("Credit Narration"; "Credit Narration")
                {
                    ApplicationArea = Basic;
                }
                field("Credit Account Status"; "Credit Account Status")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    StyleExpr = CoveragePercentStyleIII;
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

    trigger OnOpenPage()
    begin

        //SETRANGE(USER,USERID);
    end;

    var
        CoveragePercentStyle: Text;
        CoveragePercentStyleII: Text;
        CoveragePercentStyleIII: Text;

    local procedure SetStyles()
    begin
        if "Debit Account Balance Status" = "debit account balance status"::" " then
            CoveragePercentStyle := 'Strong';
        if "Debit Account Balance Status" = "debit account balance status"::"Insufficient Balance" then
            CoveragePercentStyle := 'Unfavorable';
        if "Debit Account Balance Status" = "debit account balance status"::"Sufficient Balance" then
            CoveragePercentStyle := 'Favorable';

    end;

    local procedure SetStylesII()
    begin
        CoveragePercentStyleII := 'Strong';
        if "Debit Account Status" <> "debit account status"::Active then
            CoveragePercentStyleII := 'Unfavorable';
        if "Debit Account Status" = "debit account status"::Active then
            CoveragePercentStyleII := 'Favorable';

    end;

    local procedure SetStylesIII()
    begin
        CoveragePercentStyleIII := 'Strong';
        if "Credit Account Status" <> "credit account status"::Active then
            CoveragePercentStyleIII := 'Unfavorable';
        if "Credit Account Status" = "credit account status"::Active then
            CoveragePercentStyleIII := 'Favorable';

    end;
}

