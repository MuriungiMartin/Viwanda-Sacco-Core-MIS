#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50785 "Excess Repayment Rule Products"
{
    PageType = ListPart;
    SourceTable = "Excess Repayment Rules Product";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Loan Product"; "Loan Product")
                {
                    ApplicationArea = Basic;
                }
                field("Product Name"; "Product Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Add Type"; "Add Type")
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

