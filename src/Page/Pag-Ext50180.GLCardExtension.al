pageextension 50180 "GLCardExtension" extends "G/L Account Card"
{
    layout
    {
        // Add changes to page layout here
        addlast(General)
        {
            field("Budget Controlled"; "Budget Controlled") { }

        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}