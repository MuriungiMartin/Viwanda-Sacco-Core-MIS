#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50789 "CRB Notice Register"
{
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "CRB Notice Register";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Loan No"; "Loan No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Member No"; "Member No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Member Name"; "Member Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Loan Product Type"; "Loan Product Type")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Loan Product Name"; "Loan Product Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Issued Date"; "Issued Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Approved Amount"; "Approved Amount")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Principle Outstanding"; "Principle Outstanding")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Amount In Arrears"; "Amount In Arrears")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Days In Arrears"; "Days In Arrears")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("CRB Listed"; "CRB Listed")
                {
                    ApplicationArea = Basic;
                }
                field("Date Listed"; "Date Listed")
                {
                    ApplicationArea = Basic;
                }
                field("Listed By"; "Listed By")
                {
                    ApplicationArea = Basic;
                }
                field(Delist; Delist)
                {
                    ApplicationArea = Basic;
                }
                field("DeListed On"; "DeListed On")
                {
                    ApplicationArea = Basic;
                }
                field("Delisted By"; "Delisted By")
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

