pageextension 50178 "ACCHealineExt" extends "Headline RC Accountant"
{
    layout
    {
        // Add changes to page layout here
        addfirst(content)
        {
            usercontrol("Sacco Logo"; "Logo Control Addin")
            {
                ApplicationArea = Basic, Suite;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}