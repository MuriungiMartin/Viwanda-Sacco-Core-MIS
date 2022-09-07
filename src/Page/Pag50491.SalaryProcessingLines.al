#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50491 "Salary Processing Lines"
{
    DelayedInsert = false;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = "Salary Processing Lines";

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                Editable = true;
                field("BOSA No"; "BOSA No")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member Number';
                }
                field("No."; "No.")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                    Visible = false;
                }
                field("Staff No."; "Staff No.")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Account No."; "Account No.")
                {
                    ApplicationArea = Basic;
                    //     Image = Person;
                    StyleExpr = CoveragePercentStyle;
                }
                field("Account Name"; "Account Name")
                {
                    ApplicationArea = Basic;
                }
                field(Name; Name)
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Credit Narration"; "Credit Narration")
                {
                    ApplicationArea = Basic;
                }
                field(Amount; Amount)
                {
                    ApplicationArea = Basic;
                }
                field("Employer Code"; "Employer Code")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Global Dimension 2 Code"; "Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Branch Reff."; "Branch Reff.")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("ID No."; "ID No.")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Original Account No."; "Original Account No.")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Account Not Found"; "Account Not Found")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Document No."; "Document No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field(Date; Date)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("BOSA Schedule"; "BOSA Schedule")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Closed; Closed)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Multiple Salary"; "Multiple Salary")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Salary Header No."; "Salary Header No.")
                {
                    ApplicationArea = Basic;
                    Visible = false;
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

    local procedure SetStyles()
    begin
        CoveragePercentStyle := 'Strong';
        if "Account Name" = '' then
            CoveragePercentStyle := 'Unfavorable';
        if "Account Name" <> '' then
            CoveragePercentStyle := 'Favorable';
    end;
}

