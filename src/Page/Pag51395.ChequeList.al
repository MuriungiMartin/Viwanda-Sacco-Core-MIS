page 51395 "ChequeList"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = ChequeRegister;
    CardPageId = ChequeCard;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Cheque No"; "Cheque No")
                {
                    ApplicationArea = All;

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
                field("Type of Payment"; "Cheque No")
                {
                    ApplicationArea = All;

                }
                field("Status"; "Status")
                {
                    ApplicationArea = All;

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