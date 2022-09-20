page 51341 "ProccesedCheques"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = ChequeRegister;
    SourceTableView = where("Cheque Processed" = Filter(true));
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Cheque No"; "Cheque No")
                {
                    ApplicationArea = All;
                    Editable = false;

                }
                field("Bank"; "Bank")
                {
                    ApplicationArea = All;

                }
                field("Payment To"; "Payment To")
                {
                    ApplicationArea = All;

                }
                field("Date"; "Date")
                {
                    ApplicationArea = All;

                }
                field("Type of PAyment"; "Type of Payment")
                {
                    ApplicationArea = All;

                }
                field("Status"; "Status")
                {
                    ApplicationArea = All;
                    Editable = false;

                }

                field("Description"; "Description")
                {
                    ApplicationArea = All;

                }

            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }
        }
    }
}