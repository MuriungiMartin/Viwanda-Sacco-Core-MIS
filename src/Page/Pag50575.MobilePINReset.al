#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50575 "Mobile PIN Reset"
{
    //CardPageID = "CloudPESA PIN Reset Card";
    DelayedInsert = true;
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "CloudPESA Applications";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Account No"; "Account No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Enabled = false;
                }
                field("Account Name"; "Account Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Telephone; Telephone)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(SentToServer; SentToServer)
                {
                    ApplicationArea = Basic;
                    Caption = 'Reset PIN';
                }
                field("ID No"; "ID No")
                {
                    ApplicationArea = Basic;
                }
                field("Date Applied"; "Date Applied")
                {
                    ApplicationArea = Basic;
                }
                field("Last PIN Reset"; "Last PIN Reset")
                {
                    ApplicationArea = Basic;
                }
                field("Reset By"; "Reset By")
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

