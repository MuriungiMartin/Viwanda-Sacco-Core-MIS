#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50646 "New Internal PV List"
{
    CardPageID = "Internal PV Card";
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Internal PV Header";
    SourceTableView = where(Posted = filter(false));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; No)
                {
                    ApplicationArea = Basic;
                }
                field("Date Entered"; "Date Entered")
                {
                    ApplicationArea = Basic;
                }
                field("Time Entered"; "Time Entered")
                {
                    ApplicationArea = Basic;
                }
                field("Entered By"; "Entered By")
                {
                    ApplicationArea = Basic;
                }
                field(Posted; Posted)
                {
                    ApplicationArea = Basic;
                }
                field("Date Posted"; "Date Posted")
                {
                    ApplicationArea = Basic;
                }
                field("Time Posted"; "Time Posted")
                {
                    ApplicationArea = Basic;
                }
                field("Posted By"; "Posted By")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Description"; "Transaction Description")
                {
                    ApplicationArea = Basic;
                }
                field("Total Debits"; "Total Debits")
                {
                    ApplicationArea = Basic;
                }
                field("Total Count"; "Total Count")
                {
                    ApplicationArea = Basic;
                }
                field("Total Credits"; "Total Credits")
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

