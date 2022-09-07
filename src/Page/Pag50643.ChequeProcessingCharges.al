#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50643 "Cheque Processing Charges"
{
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Cheque Processing Charges";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Lower Limit"; "Lower Limit")
                {
                    ApplicationArea = Basic;
                }
                field("Upper Limit"; "Upper Limit")
                {
                    ApplicationArea = Basic;
                }
                field(Charges; Charges)
                {
                    ApplicationArea = Basic;
                }
                field("Sacco Income"; "Sacco Income")
                {
                    ApplicationArea = Basic;
                }
                field(Range; Range)
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

