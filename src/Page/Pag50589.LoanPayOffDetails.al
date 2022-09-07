#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50589 "Loan PayOff Details"
{
    PageType = ListPart;
    SourceTable = "Loans PayOff Details";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Source; Source)
                {
                    ApplicationArea = Basic;
                }
                field("Loan to PayOff"; "Loan to PayOff")
                {
                    ApplicationArea = Basic;
                }
                field("Member No"; "Member No")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Type"; "Loan Type")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Outstanding"; "Loan Outstanding")
                {
                    ApplicationArea = Basic;
                }
                field("Outstanding Interest"; "Outstanding Interest")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Outstanding Insurance"; "Outstanding Insurance")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Outstanding Penalty"; "Outstanding Penalty")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Debt Collector Fee"; "Debt Collector Fee")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Total PayOff"; "Total PayOff")
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

