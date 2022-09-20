report 51000 "AdeventSToLibrary"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem(DataItemName; "Company Information")
        {
            trigger OnAfterGetRecord()
            var
            // myInt: Integer;
            begin
                WFEvents.AddEventsToLib();
                WFEvents.AddResponsesToLib();
                WFEvents.AddEventsPredecessor();
            end;


        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }


    var
        WFEvents: codeunit "Custom Workflow Events";
}