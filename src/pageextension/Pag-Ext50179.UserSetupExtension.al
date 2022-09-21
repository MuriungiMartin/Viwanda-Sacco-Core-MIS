pageextension 50179 "UserSetupExtension" extends "User Setup"
{
    layout
    {
        // Add changes to page layout here
        addlast(Control1)
        {
            field("Allow FA Posting From"; "Allow FA Posting From")
            {
                applicationarea = all;

            }
            field("Allow FA Posting To"; "Allow FA Posting To")
            {
                applicationarea = all;

            }
            field("Archiving User"; "Archiving User")
            {
                applicationarea = all;

            }
            field("Is Manager"; "Is Manager")
            {
                applicationarea = all;

            }
            field("Allow Process Payroll"; "Allow Process Payroll")
            {
                applicationarea = all;

            }
            field("Member Registration"; "Member Registration")
            {
                applicationarea = all;

            }

            field("Journal Batch Name"; "Journal Batch Name")
            {
                applicationarea = all;

            }
            field("Journal Template Name"; "Journal Template Name")
            {
                applicationarea = all;

            }
            field("Petty C Amount Approval Limit"; "Petty C Amount Approval Limit")
            {
                applicationarea = all;

            }
            field("Post Pv"; "Post Pv") { ApplicationArea = all; }

        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}