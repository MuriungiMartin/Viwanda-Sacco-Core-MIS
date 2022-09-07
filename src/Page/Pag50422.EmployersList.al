#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50422 "Employers List"
{
    CardPageID = "Employer Card";
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Employers Register";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Employer Code"; "Employer Code")
                {
                    ApplicationArea = Basic;
                }
                field("Employer Name"; "Employer Name")
                {
                    ApplicationArea = Basic;
                }
                field("Employer Address"; "Employer Address")
                {
                    ApplicationArea = Basic;
                }
                field("Employer Email"; "Employer Email")
                {
                    ApplicationArea = Basic;
                }
                field("Employer Phone No"; "Employer Phone No")
                {
                    ApplicationArea = Basic;
                }
                field("Contact Person"; "Contact Person")
                {
                    ApplicationArea = Basic;
                }
                field("Payment Type"; "Payment Type")
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

