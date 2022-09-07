#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50477 "Teller Till List"
{
    CardPageID = "Teller Till Card";
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Bank Account";
    SourceTableView = where("Account Type" = filter(Cashier));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; "No.")
                {
                    ApplicationArea = Basic;
                }
                field(Name; Name)
                {
                    ApplicationArea = Basic;
                }
                field(CashierID; CashierID)
                {
                    ApplicationArea = Basic;
                }
                field("Balance (LCY)"; "Balance (LCY)")
                {
                    ApplicationArea = Basic;
                    Caption = 'Running Balance';
                }
            }
        }
    }

    actions
    {
    }
}

