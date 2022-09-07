#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50953 "ATM Card Nos Buffer"
{
    CardPageID = "Linked ATM No Card";
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "ATM Card Nos Buffer";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("ATM Card No"; "ATM Card No")
                {
                    ApplicationArea = Basic;
                }
                field("Account No"; "Account No")
                {
                    ApplicationArea = Basic;
                }
                field("Account Name"; "Account Name")
                {
                    ApplicationArea = Basic;
                }
                field("Account Type"; "Account Type")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Status)
                {
                    ApplicationArea = Basic;
                }
                field("ID No"; "ID No")
                {
                    ApplicationArea = Basic;
                }
                field("Reason For Delink"; "Reason For Delink")
                {
                    ApplicationArea = Basic;
                }
                field("Delink ATM Card"; "Delink ATM Card")
                {
                    ApplicationArea = Basic;
                }
                field("Delinked By"; "Delinked By")
                {
                    ApplicationArea = Basic;
                }
                field("Delinked On"; "Delinked On")
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

