#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50465 "Front Office Charges"
{
    PageType = Card;
    SourceTable = Charges;
    UsageCategory = Administration;
    ApplicationArea = all;
    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                field("Code"; Code)
                {
                    ApplicationArea = Basic;
                }
                field(Description; Description)
                {
                    ApplicationArea = Basic;
                }
                field("Charge Amount"; "Charge Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Charge Type"; "Charge Type")
                {
                    ApplicationArea = Basic;
                }
                field("Use Percentage"; "Use Percentage")
                {
                    ApplicationArea = Basic;
                }
                field("Percentage of Amount"; "Percentage of Amount")
                {
                    ApplicationArea = Basic;
                }
                field(Minimum; Minimum)
                {
                    ApplicationArea = Basic;
                }
                field(Maximum; Maximum)
                {
                    ApplicationArea = Basic;
                }
                field("GL Account"; "GL Account")
                {
                    ApplicationArea = Basic;
                }
                field("Sacco Amount"; "Sacco Amount")
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

