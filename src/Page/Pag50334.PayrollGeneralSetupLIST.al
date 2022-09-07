#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50334 "Payroll General Setup LIST."
{
    CardPageID = "Payroll General Setup.";
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Payroll General Setup.";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Tax Relief"; "Tax Relief")
                {
                    ApplicationArea = Basic;
                }
                field("Insurance Relief"; "Insurance Relief")
                {
                    ApplicationArea = Basic;
                }
                field("Max Relief"; "Max Relief")
                {
                    ApplicationArea = Basic;
                }
                field("Mortgage Relief"; "Mortgage Relief")
                {
                    ApplicationArea = Basic;
                }
                field("Max Pension Contribution"; "Max Pension Contribution")
                {
                    ApplicationArea = Basic;
                }
                field("Tax On Excess Pension"; "Tax On Excess Pension")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Market Rate"; "Loan Market Rate")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Corporate Rate"; "Loan Corporate Rate")
                {
                    ApplicationArea = Basic;
                }
                field("Taxable Pay (Normal)"; "Taxable Pay (Normal)")
                {
                    ApplicationArea = Basic;
                }
                field("Staff Net Pay G/L Account"; "Staff Net Pay G/L Account")
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

