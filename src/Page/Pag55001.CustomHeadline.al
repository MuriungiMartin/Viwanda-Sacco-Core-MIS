page 55001 "Custom Headline"
{
    Caption = 'Headline';
    PageType = HeadlinePart;
    RefreshOnActivate = true;


    layout
    {
        area(Content)
        {
            group(logo)
            {
                usercontrol("Sacco Logo"; "Logo Control Addin")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        myInt: Integer;
}