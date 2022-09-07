#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50511 "PAYE Tax Brackets Credit"
{
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "PAYE Brackets Credit";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Tax Band"; "Tax Band")
                {
                    ApplicationArea = Basic;
                }
                field("Lower Limit"; "Lower Limit")
                {
                    ApplicationArea = Basic;
                }
                field("Upper Limit"; "Upper Limit")
                {
                    ApplicationArea = Basic;
                }
                field(Percentage; Percentage)
                {
                    ApplicationArea = Basic;
                }
                field("Taxable Amount"; "Taxable Amount")
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

