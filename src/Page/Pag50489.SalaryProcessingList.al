#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50489 "Salary Processing List"
{
    CardPageID = "Salary Processing Header";
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Salary Processing Headerr";
    SourceTableView = where(Posted = const(false));

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
                field("Account No"; "Account No")
                {
                    ApplicationArea = Basic;
                    Caption = 'Employer Account No';
                }
                field("Account Name"; "Account Name")
                {
                    ApplicationArea = Basic;
                    Caption = 'Employer Account Name';
                }
                field("Account Type"; "Account Type")
                {
                    ApplicationArea = Basic;
                }
                field("Entered By"; "Entered By")
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
                field("Posting date"; "Posting date")
                {
                    ApplicationArea = Basic;
                }
                field("Cheque No."; "Cheque No.")
                {
                    ApplicationArea = Basic;
                }
                field("Employer Code"; "Employer Code")
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

