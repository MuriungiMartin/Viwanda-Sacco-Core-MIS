#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50469 "ATM Charges"
{
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "ATM Charges";

    layout
    {
        area(content)
        {
            repeater(Control1102756000)
            {
                field("Transaction Type"; "Transaction Type")
                {
                    ApplicationArea = Basic;
                }
                field("Total Amount"; "Total Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Sacco Amount"; "Sacco Amount")
                {
                    ApplicationArea = Basic;
                }
                field(Source; Source)
                {
                    ApplicationArea = Basic;
                }
                field("Atm Income A/c"; "Atm Income A/c")
                {
                    ApplicationArea = Basic;
                }
                field("Atm Bank Settlement A/C"; "Atm Bank Settlement A/C")
                {
                    ApplicationArea = Basic;
                }
                field("Excise Duty"; "Excise Duty")
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

