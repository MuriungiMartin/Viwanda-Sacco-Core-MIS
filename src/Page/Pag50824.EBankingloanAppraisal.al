#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50824 "E Banking loan Appraisal"
{
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Mobile Loan Appraisal";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Loan Product"; "Loan Product")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Security"; "Loan Security")
                {
                    ApplicationArea = Basic;
                }
                field("BOSA Multiplier"; "BOSA Multiplier")
                {
                    ApplicationArea = Basic;
                }
                field("BOSA Qualif yAmt"; "BOSA Qualif yAmt")
                {
                    ApplicationArea = Basic;
                }
                field("FOSA Qualify Amt"; "FOSA Qualify Amt")
                {
                    ApplicationArea = Basic;
                }
                field("FOSA Avg Inflows"; "FOSA Avg Inflows")
                {
                    ApplicationArea = Basic;
                }
                field("Avg Salary"; "Avg Salary")
                {
                    ApplicationArea = Basic;
                }
                field("Require CashFlow Docs"; "Require CashFlow Docs")
                {
                    ApplicationArea = Basic;
                }
                field("Share Capital"; "Share Capital")
                {
                    ApplicationArea = Basic;
                }
                field("BOSA Balance"; "BOSA Balance")
                {
                    ApplicationArea = Basic;
                }
                field("Group ID"; "Group ID")
                {
                    ApplicationArea = Basic;
                }
                field("Group NetWorth"; "Group NetWorth")
                {
                    ApplicationArea = Basic;
                }
                field("Group Loans Balance"; "Group Loans Balance")
                {
                    ApplicationArea = Basic;
                }
                field("Group Loans SecurityValue"; "Group Loans SecurityValue")
                {
                    ApplicationArea = Basic;
                }
                field("Group Loans Risk"; "Group Loans Risk")
                {
                    ApplicationArea = Basic;
                }
                field("Non Group Loans Balance"; "Non Group Loans Balance")
                {
                    ApplicationArea = Basic;
                }
                field("Non Group Loans Security Value"; "Non Group Loans Security Value")
                {
                    ApplicationArea = Basic;
                }
                field("Non Group Loans Risk"; "Non Group Loans Risk")
                {
                    ApplicationArea = Basic;
                }
                field("Default History"; "Default History")
                {
                    ApplicationArea = Basic;
                }
                field("Alert Status"; "Alert Status")
                {
                    ApplicationArea = Basic;
                }
                field(Comment; Comment)
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

