#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50617 "Loan Recovery Details"
{
    ModifyAllowed = true;
    PageType = ListPart;
    SourceTable = "Loan Member Loans";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Guarantor Number"; "Guarantor Number")
                {
                    ApplicationArea = Basic;
                }
                field("Member Name"; "Member Name")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Type"; "Loan Type")
                {
                    ApplicationArea = Basic;
                }
                field("Loan No."; "Loan No.")
                {
                    ApplicationArea = Basic;
                }
                field("Amont Guaranteed"; "Amont Guaranteed")
                {
                    ApplicationArea = Basic;
                }
                field("Current Member Deposits"; "Current Member Deposits")
                {
                    ApplicationArea = Basic;
                }
                field("Guarantor Amount Apportioned"; "Guarantor Amount Apportioned")
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

