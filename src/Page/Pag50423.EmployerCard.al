#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50423 "Employer Card"
{
    PageType = Card;
    SourceTable = "Employers Register";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Employer Code"; "Employer Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Employer Name"; "Employer Name")
                {
                    ApplicationArea = Basic;
                }
                field("Employer Address"; "Employer Address")
                {
                    ApplicationArea = Basic;
                }
                field("Employer Physical Location"; "Employer Physical Location")
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
                field("Contact Person Mobile No"; "Contact Person Mobile No")
                {
                    ApplicationArea = Basic;
                }
                field("Created On"; "Created On")
                {
                    ApplicationArea = Basic;
                }
                field("Created By"; "Created By")
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

