#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50272 "Mobile Membership Appl List"
{
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = MobileAppMembershipApplication;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(MobileNo; MobileNo)
                {
                    ApplicationArea = Basic;
                }
                field(IDNumber; IDNumber)
                {
                    ApplicationArea = Basic;
                }
                field(FirstName; FirstName)
                {
                    ApplicationArea = Basic;
                }
                field(MiddleName; MiddleName)
                {
                    ApplicationArea = Basic;
                }
                field(LastName; LastName)
                {
                    ApplicationArea = Basic;
                }
                field(FosaAccountOpened; FosaAccountOpened)
                {
                    ApplicationArea = Basic;
                }
                field(NextOfKinDOB; NextOfKinDOB)
                {
                    ApplicationArea = Basic;
                }
                field(BosaAccountOpened; BosaAccountOpened)
                {
                    ApplicationArea = Basic;
                }
                field(ApplicationReceivedOn; ApplicationReceivedOn)
                {
                    ApplicationArea = Basic;
                }
                field(ApplicationMaintained; ApplicationMaintained)
                {
                    ApplicationArea = Basic;
                }
                field(RefereeName; RefereeName)
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

