#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50456 "Banks"
{
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Banks Ver2";

    layout
    {
        area(content)
        {
            repeater(Control5)
            {
                field("Bank Code"; "Bank Code")
                {
                    ApplicationArea = Basic;
                }
                field("Bank Name"; "Bank Name")
                {
                    ApplicationArea = Basic;
                }
                field("Branch Code"; "Branch Code")
                {
                    ApplicationArea = Basic;
                }
                field("Branch Name"; "Branch Name")
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

