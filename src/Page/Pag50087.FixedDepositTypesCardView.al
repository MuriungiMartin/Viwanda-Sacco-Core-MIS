#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50087 "Fixed Deposit Types Card View"
{
    DeleteAllowed = false;
    Editable = false;
    PageType = Card;
    SourceTable = "Fixed Deposit Type";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Code"; Code)
                {
                    ApplicationArea = Basic;
                }
                field(Duration; Duration)
                {
                    ApplicationArea = Basic;
                }
                field(Description; Description)
                {
                    ApplicationArea = Basic;
                }
                field("No. of Months"; "No. of Months")
                {
                    ApplicationArea = Basic;
                }
            }
            part(Control1102755006; "Fixed Deposit Interest Rates V")
            {
                Caption = 'Interest Computation';
                Editable = false;
                SubPageLink = Code = field(Code);
            }
        }
    }

    actions
    {
    }
}

