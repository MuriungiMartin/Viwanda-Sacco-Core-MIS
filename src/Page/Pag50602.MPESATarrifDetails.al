#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50602 "MPESA Tarrif Details"
{
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Tariff Details";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Code)
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
                field("Charge Amount"; "Charge Amount")
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

