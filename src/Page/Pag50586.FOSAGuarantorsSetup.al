#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50586 "FOSA Guarantors Setup"
{
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "FOSA Guarantors Setup";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Minimum Amount"; "Minimum Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Maximum Amount"; "Maximum Amount")
                {
                    ApplicationArea = Basic;
                }
                field("No of Guarantors"; "No of Guarantors")
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

