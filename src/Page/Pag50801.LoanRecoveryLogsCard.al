#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50801 "Loan Recovery Logs Card"
{
    PageType = Card;
    SourceTable = "Loan Recovery Logs";

    layout
    {
        area(content)
        {
            group(Control11)
            {
                field("Member No"; "Member No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Member Name"; "Member Name")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                }
                field("Loan No"; "Loan No")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Product Type"; "Loan Product Type")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Loan Product Name"; "Loan Product Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Loan Balance"; "Loan Balance")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Loan Amount In Arrears"; "Loan Amount In Arrears")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Promoted;
                    Style = Attention;
                    StyleExpr = true;
                }
                field("Loan Arrears Days"; "Loan Arrears Days")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Promoted;
                    Style = Attention;
                    StyleExpr = true;
                }
                field("Log Description"; "Log Description")
                {
                    ApplicationArea = Basic;
                    MultiLine = true;
                }
                field("Log Date"; "Log Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("User ID"; "User ID")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            part(Control10; "Loans Recovery Logs History")
            {
                Editable = false;
                SubPageLink = "Loan No" = field("Loan No");
            }
        }
    }

    actions
    {
    }
}

