#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50667 "Loans Cue"
{
    PageType = CardPart;
    SourceTable = "Membership Cue";

    layout
    {
        area(content)
        {
            cuegroup("Memberhip Applications")
            {
                Caption = 'Memberhip Applications';
                field("New Members"; "New Members")
                {
                    ApplicationArea = Basic;
                }
                field("Approved Applications"; "Approved Applications")
                {
                    ApplicationArea = Basic;
                }
            }
            cuegroup(Loans)
            {
                Caption = 'Loans';
                field("Loans Pending Approval"; "Loans Pending Approval")
                {
                    ApplicationArea = Basic;
                }
                field("Approved Loans"; "Approved Loans")
                {
                    ApplicationArea = Basic;
                    Caption = 'Pending Disbursement';
                    Image = "None";
                }
                field("Rejected Loans"; "Rejected Loans")
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

