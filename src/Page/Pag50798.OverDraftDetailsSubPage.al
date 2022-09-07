#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50798 "OverDraft Details SubPage"
{
    CardPageID = "Posted OverDraft Applic Card";
    Editable = false;
    PageType = ListPart;
    SourceTable = "OverDraft Application";
    SourceTableView = where("OD Application Effected" = filter(true));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No"; "Document No")
                {
                    ApplicationArea = Basic;
                }
                field("Member No"; "Member No")
                {
                    ApplicationArea = Basic;
                }
                field("Over Draft Account"; "Over Draft Account")
                {
                    ApplicationArea = Basic;
                }
                field("Over Draft Account Name"; "Over Draft Account Name")
                {
                    ApplicationArea = Basic;
                }
                field("Application Date"; "Application Date")
                {
                    ApplicationArea = Basic;
                }
                field("OverDraft Application Type"; "OverDraft Application Type")
                {
                    ApplicationArea = Basic;
                }
                field("OverDraft Application Status"; "OverDraft Application Status")
                {
                    ApplicationArea = Basic;
                    Caption = 'OverDraft  Status';
                }
                field("Security Type"; "Security Type")
                {
                    ApplicationArea = Basic;
                }
                field("Qualifying Overdraft Amount"; "Qualifying Overdraft Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Overdraft Duration"; "Overdraft Duration")
                {
                    ApplicationArea = Basic;
                }
                field("OverDraft Expiry Date"; "OverDraft Expiry Date")
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

