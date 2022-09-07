#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50020 "Member Summary By Branch"
{
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Member Summary By Branch";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Branch Code"; "Branch Code")
                {
                    ApplicationArea = Basic;
                }
                field("Active Members"; "Active Members")
                {
                    ApplicationArea = Basic;
                }
                field("Awaiting Exit Members"; "Awaiting Exit Members")
                {
                    ApplicationArea = Basic;
                }
                field("Exited Members"; "Exited Members")
                {
                    ApplicationArea = Basic;
                }
                field("Dormant Members"; "Dormant Members")
                {
                    ApplicationArea = Basic;
                }
                field("Deceased Members"; "Deceased Members")
                {
                    ApplicationArea = Basic;
                }
                field("Total Members"; "Total Members")
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

