page 51401 "MpesaBilling"
{
    PageType = Card;
    // ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = MpesaBillings;


    layout
    {
        area(Content)
        {
            // usercontrol(Mpesa; MpesaAddin)
            // {

            //     ApplicationArea = all;

            //     trigger ControlReady()
            //     var
            //         myInt: Integer;
            //     begin
            //         //Message('ready to execute javascript');
            //         CurrPage.Mpesa.pay(myInt);

            //     end;

            // }
            group(GroupName)
            {
                field(BillingNo; BillingNo)
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            // action(Pay)
            // {
            //     ApplicationArea = All;

            //     trigger OnAction()
            //     var
            //         No: Integer;
            //     begin
            //         CurrPage.Mpesa.Pay(No);


            //     end;
            // }
        }
    }


}