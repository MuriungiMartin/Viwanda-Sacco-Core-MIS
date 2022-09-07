#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50247 "HR Calendar List"
{
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "HR Calendar List";

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                Editable = true;
                field(Date; Date)
                {
                    ApplicationArea = Basic;
                }
                field(Day; Day)
                {
                    ApplicationArea = Basic;
                }
                field("Non Working"; "Non Working")
                {
                    ApplicationArea = Basic;
                }
                field(Reason; Reason)
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

