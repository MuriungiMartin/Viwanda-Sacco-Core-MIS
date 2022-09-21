page 56000 "CahshierRoleCenter"
{
    PageType = RoleCenter;

    layout
    {
        area(RoleCenter)
        {

        }
    }

    actions
    {
        area(Creation)
        {
            action(ActionBarAction)
            {
                RunObject = Page "Cashier Transactions - List";
            }
        }
        area(Sections)
        {
            group(CashierBanking)
            {
                action(TransactionNew)
                {
                    Caption = 'Transactions List';
                    RunObject = Page "Cashier Transactions - List";
                }
                action(PostedTransactionsCashier)
                {
                    Caption = 'Posted Cashier Transactions';
                    ToolTip = 'View the posted cashier transactions.';
                    RunObject = page "Posted Cashier Transactions";


                }
            }
        }
        area(Embedding)
        {
            action(EmbeddingAction)
            {
                RunObject = Page "Cashier Trans Authorisations";
                Caption = 'Cashier transaction authorisations';
            }
        }
    }
}