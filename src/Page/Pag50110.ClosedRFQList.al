#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50110 "Closed RFQ List"
{
    CardPageID = "Released Internal Requisitions";
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Purchase Header";
    SourceTableView = WHERE("Document Type" = FILTER(Quote), DocApprovalType = FILTER(Requisition), Status = CONST(Released), PR = CONST(true), Completed = FILTER(true));

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; "No.")
                {
                    ApplicationArea = Basic;
                }
                field("Posting Description"; "Posting Description")
                {
                    ApplicationArea = Basic;
                }
                field("Ship-to Code"; "Ship-to Code")
                {
                    ApplicationArea = Basic;
                }
                field("Ship-to Name"; "Ship-to Name")
                {
                    ApplicationArea = Basic;
                }
                // field("Expected Closing Date";"Expected Closing Date")
                // {
                //     ApplicationArea = Basic;
                // }
                field("Location Code"; "Location Code")
                {
                    ApplicationArea = Basic;
                }
                field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                }
                field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Status)
                {
                    ApplicationArea = Basic;
                }
                field("Currency Code"; "Currency Code")
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

