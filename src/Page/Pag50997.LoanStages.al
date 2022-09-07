#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50997 "Loan Stages"
{
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Loan Stages";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Loan Stage"; "Loan Stage")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Stage Description"; "Loan Stage Description")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Security Applicable"; "Loan Security Applicable")
                {
                    ApplicationArea = Basic;
                }
                field("Min Loan Amount"; "Min Loan Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Max Loan Amount"; "Max Loan Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Purpose"; "Loan Purpose")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Purpose Description"; "Loan Purpose Description")
                {
                    ApplicationArea = Basic;
                }
                field("Mobile App Specific"; "Mobile App Specific")
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

