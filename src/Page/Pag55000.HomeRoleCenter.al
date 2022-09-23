page 55000 "Home Role Center" // default role center change to comapny name
{
    Caption = 'INDEX PAGE';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {

            part(Control75; "Headline RC Accountant")
            {
                ApplicationArea = Basic, Suite;
            }

            // part("Logo Cue"; "Sacco Logo")
            // {
            //     ApplicationArea = Basic, Suite;
            //     Caption = '';
            // }
            part(Control99; "Finance Performance")
            {
                ApplicationArea = Basic, Suite;
                Visible = false;
            }
            part(Control1902304208; "Membership Cue")
            {
                ApplicationArea = Basic, Suite;

            }
            part("User Tasks Activities"; "User Tasks Activities")
            {
                ApplicationArea = Suite;
            }
            part("Emails"; "Email Activities")
            {
                ApplicationArea = Basic, Suite;
            }
            part(Control123; "Team Member Activities")
            {
                ApplicationArea = Suite;
            }
            part(Control1907692008; "My Accounts")
            {
                ApplicationArea = Basic, Suite;
            }
            part(Control103; "Trailing Sales Orders Chart")
            {
                ApplicationArea = Basic, Suite;
                Visible = false;
            }

            part(Control106; "My Job Queue")
            {
                ApplicationArea = Basic, Suite;
                Visible = false;
            }
            part(Control9; "Help And Chart Wrapper")
            {
                ApplicationArea = Basic, Suite;
            }
            part(Control10; "Product Video Topics")
            {
                ObsoleteState = Pending;
                ObsoleteReason = 'Replaced with Assisted Setup.';
                Visible = false;
                ApplicationArea = All;
                ObsoleteTag = '17.0';
            }
            part(Control100; "Cash Flow Forecast Chart")
            {
                ApplicationArea = Basic, Suite;
            }
            part(Control108; "Report Inbox Part")
            {
                AccessByPermission = TableData "Report Inbox" = IMD;
                ApplicationArea = Basic, Suite;
                Visible = false;
            }
            part(Control122; "Power BI Report Spinner Part")
            {
                ApplicationArea = Basic, Suite;
                Visible = false;
            }
            systempart(Control1901377608; MyNotes)
            {
                ApplicationArea = Basic, Suite;
            }
        }
    }

    actions
    {
        area(reporting)
        {
            group("G/L Reports")
            {
                Caption = 'G/L Reports';
                action("&G/L Trial Balance")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = '&G/L Trial Balance';
                    Image = "Report";
                    RunObject = Report "Trial Balance";
                    ToolTip = 'View, print, or send a report that shows the balances for the general ledger accounts, including the debits and credits. You can use this report to ensure accurate accounting practices.';
                }
                action("&Bank Detail Trial Balance")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = '&Bank Detail Trial Balance';
                    Image = "Report";
                    RunObject = Report "Bank Acc. - Detail Trial Bal.";
                    ToolTip = 'View, print, or send a report that shows a detailed trial balance for selected bank accounts. You can use the report at the close of an accounting period or fiscal year.';
                }
                action("&Account Schedule")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = '&Account Schedule';
                    Image = "Report";
                    RunObject = Report "Account Schedule";
                    ToolTip = 'Open an account schedule to analyze figures in general ledger accounts or to compare general ledger entries with general ledger budget entries.';
                }
                action("Bu&dget")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Bu&dget';
                    Image = "Report";
                    RunObject = Report Budget;
                    ToolTip = 'View or edit estimated amounts for a range of accounting periods.';
                }
                action("Trial Bala&nce/Budget")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Trial Bala&nce/Budget';
                    Image = "Report";
                    RunObject = Report "Trial Balance/Budget";
                    ToolTip = 'View a trial balance in comparison to a budget. You can choose to see a trial balance for selected dimensions. You can use the report at the close of an accounting period or fiscal year.';
                }
                action("Trial Balance by &Period")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Trial Balance by &Period';
                    Image = "Report";
                    RunObject = Report "Trial Balance by Period";
                    ToolTip = 'Show the opening balance by general ledger account, the movements in the selected period of month, quarter, or year, and the resulting closing balance.';
                }
                action("&Fiscal Year Balance")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = '&Fiscal Year Balance';
                    Image = "Report";
                    RunObject = Report "Fiscal Year Balance";
                    ToolTip = 'View, print, or send a report that shows balance sheet movements for selected periods. The report shows the closing balance by the end of the previous fiscal year for the selected ledger accounts. It also shows the fiscal year until this date, the fiscal year by the end of the selected period, and the balance by the end of the selected period, excluding the closing entries. The report can be used at the close of an accounting period or fiscal year.';
                }
                action("Balance Comp. - Prev. Y&ear")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Balance Comp. - Prev. Y&ear';
                    Image = "Report";
                    RunObject = Report "Balance Comp. - Prev. Year";
                    ToolTip = 'View a report that shows your company''s assets, liabilities, and equity compared to the previous year.';
                }
                action("&Closing Trial Balance")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = '&Closing Trial Balance';
                    Image = "Report";
                    RunObject = Report "Closing Trial Balance";
                    ToolTip = 'View, print, or send a report that shows this year''s and last year''s figures as an ordinary trial balance. The closing of the income statement accounts is posted at the end of a fiscal year. The report can be used in connection with closing a fiscal year.';
                }
                action("Dimensions - Total")
                {
                    ApplicationArea = Dimensions;
                    Caption = 'Dimensions - Total';
                    Image = "Report";
                    RunObject = Report "Dimensions - Total";
                    ToolTip = 'View how dimensions or dimension sets are used on entries based on total amounts over a specified period and for a specified analysis view.';
                }
            }
            group("Cash Flow")
            {
                Caption = 'Cash Flow';
                action("Cash Flow Date List")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cash Flow Date List';
                    Image = "Report";
                    RunObject = Report "Cash Flow Date List";
                    ToolTip = 'View forecast entries for a period of time that you specify. The registered cash flow forecast entries are organized by source types, such as receivables, sales orders, payables, and purchase orders. You specify the number of periods and their length.';
                }
            }
            group("Member Accounts")
            {
                Caption = 'Members Accounts';
                action("Member List")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Members List';
                    Image = "Report";
                    RunObject = Report "Member List";
                    ToolTip = 'View an overview of Member Accounts';
                }
                action("Loan Balances")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Loan Balances';
                    Image = "Report";
                    RunObject = Report "Loans Register";
                    ToolTip = 'View an overview of loans';
                }
            }
            group("Cost Accounting")
            {
                Caption = 'Cost Accounting';
                action("Cost Accounting P/L Statement")
                {
                    ApplicationArea = all;
                    Caption = 'Cost Accounting P/L Statement';
                    Image = "Report";
                    RunObject = Report "Cost Acctg. Statement";
                    ToolTip = 'View the credit and debit balances per cost type, together with the chart of cost types.';
                }
                action("CA P/L Statement per Period")
                {
                    ApplicationArea = all;
                    Caption = 'CA P/L Statement per Period';
                    Image = "Report";
                    RunObject = Report "Cost Acctg. Stmt. per Period";
                    ToolTip = 'View profit and loss for cost types over two periods with the comparison as a percentage.';
                }
                action("CA P/L Statement with Budget")
                {
                    ApplicationArea = all;
                    Caption = 'CA P/L Statement with Budget';
                    Image = "Report";
                    RunObject = Report "Cost Acctg. Statement/Budget";
                    ToolTip = 'View a comparison of the balance to the budget figures and calculates the variance and the percent variance in the current accounting period, the accumulated accounting period, and the fiscal year.';
                }
                action("Cost Accounting Analysis")
                {
                    ApplicationArea = all;
                    Caption = 'Cost Accounting Analysis';
                    Image = "Report";
                    RunObject = Report "Cost Acctg. Analysis";
                    ToolTip = 'View balances per cost type with columns for seven fields for cost centers and cost objects. It is used as the cost distribution sheet in Cost accounting. The structure of the lines is based on the chart of cost types. You define up to seven cost centers and cost objects that appear as columns in the report.';
                }
            }
        }
        area(embedding)
        {
            action("Chart of Accounts")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Chart of Accounts';
                RunObject = Page "Chart of Accounts";
                ToolTip = 'Open the chart of accounts.';
            }
            action("Bank Accounts")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Bank Accounts';
                Image = BankAccount;
                RunObject = Page "Bank Account List";
                ToolTip = 'View or set up detailed information about your bank account, such as which currency to use, the format of bank files that you import and export as electronic payments, and the numbering of checks.';
            }
            action(Members)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Members';
                Image = Customer;
                RunObject = Page "Members List";
                ToolTip = 'View or edit detailed information for the Members.';
            }
            action(FOSAAccounts)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'FOSA Accounts';
                Image = Vendor;
                RunObject = Page "Vendor List";
                ToolTip = 'View or edit detailed information for the FOSA Savings Accounts.';
                Visible = false;
            }
            action(FOSAAccountsBalance)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'FOSA Account Balances';
                Image = Balance;
                RunObject = Page "Vendor List";
                RunPageView = WHERE("Balance (LCY)" = FILTER(<> 0));
                ToolTip = 'View a summary of the bank account balance in different periods.';
                Visible = false;
            }
            action(OutstandingLoans)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Outstanding Loan Balances';
                Image = Balance;
                RunObject = Page "Loans  List All";
                RunPageView = WHERE("Outstanding Balance" = FILTER(<> 0));
                ToolTip = 'View a summary of the Outstanding Loan Balances In The Sacco.';
            }
            action("Receipts List")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'View Posted Receipts';
                Image = Documents;
                RunObject = Page "Posted BOSA Receipts List";
                ToolTip = 'View Posted BOSA Receipts';
            }
        }
        area(sections)
        {

            group(Action172)
            {
                Caption = 'Finance';
                Image = Journals;
                ToolTip = 'Collect and make payments, prepare statements, and reconcile bank accounts.';
                action("General Journals")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'General Journals';
                    Image = Journal;
                    RunObject = Page "General Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST(General),
                                        Recurring = CONST(false));
                    ToolTip = 'Post financial transactions directly to general ledger accounts and other accounts, such as bank, customer, vendor, and employee accounts. Posting with a general journal always creates entries on general ledger accounts. This is true even when, for example, you post a journal line to a customer account, because an entry is posted to a general ledger receivables account through a posting group.';
                }
                action(Action170)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Chart of Accounts';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Chart of Accounts";
                    ToolTip = 'View or organize the general ledger accounts that store your financial data. All values from business transactions or internal adjustments end up in designated G/L accounts. Business Central includes a standard chart of accounts that is ready to support businesses in your country, but you can change the default accounts and add new ones.';
                }
                action("G/L Account Categories")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'G/L Account Categories';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "G/L Account Categories";
                    ToolTip = 'Personalize the structure of your financial statements by mapping general ledger accounts to account categories. You can create category groups by indenting subcategories under them. Each grouping shows a total balance. When you choose the Generate Account Schedules action, the account schedules for the underlying financial reports are updated. The next time you run one of these reports, such as the balance statement, new totals and subentries are added, based on your changes.';
                }
                action(Currencies)
                {
                    ApplicationArea = Suite;
                    Caption = 'Currencies';
                    Image = Currency;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page Currencies;
                    ToolTip = 'View the different currencies that you trade in or update the exchange rates by getting the latest rates from an external service provider.';
                }
                action(Employees)
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Employees';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Employee List";
                    ToolTip = 'View or modify employees'' details and related information, such as qualifications and pictures, or register and analyze employee absence. Keeping up-to-date records about your employees simplifies personnel tasks. For example, if an employee''s address changes, you register this on the employee card.';
                }
                action("Analysis Views")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Analysis Views';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Analysis View List";
                    ToolTip = 'Analyze amounts in your general ledger by their dimensions using analysis views that you have set up.';
                }
                action("Account Schedules")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Account Schedules';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Account Schedule Names";
                    ToolTip = 'Get insight into the financial data stored in your chart of accounts. Account schedules analyze figures in G/L accounts, and compare general ledger entries with general ledger budget entries. For example, you can view the general ledger entries as percentages of the budget entries. Account schedules provide the data for core financial statements and views, such as the Cash Flow chart.';
                }
                action(Dimensions)
                {
                    ApplicationArea = Suite;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page Dimensions;
                    ToolTip = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';
                }
#if not CLEAN19
#endif
#if not CLEAN19
                action(Action144)
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Employees';
                    Visible = false;
                    RunObject = Page "Employee List";
                    ToolTip = 'Manage employees'' details and related information, such as qualifications and pictures, or register and analyze employee absence. Keeping up-to-date records about your employees simplifies personnel tasks. For example, if an employee''s address changes, you register this on the employee card.';
                    ObsoleteState = Pending;
                    ObsoleteReason = 'Duplicated action use action(Employees)';
                    ObsoleteTag = '19.0';
                }
#endif                
                action("Accounting Periods")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Accounting Periods';
                    Image = AccountingPeriods;
                    RunObject = Page "Accounting Periods";
                    ToolTip = 'Set up the number of accounting periods, such as 12 monthly periods, within the fiscal year and specify which period is the start of the new fiscal year.';
                }
                action("Number Series")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Number Series';
                    RunObject = Page "No. Series";
                    ToolTip = 'View or edit the number series that are used to organize transactions';
                }
#if not CLEAN19
                action(Action116)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'G/L Account Categories';
                    RunObject = Page "G/L Account Categories";
                    ToolTip = 'Personalize the structure of your financial statements by mapping general ledger accounts to account categories. You can create category groups by indenting subcategories under them. Each grouping shows a total balance. When you choose the Generate Account Schedules action, the account schedules for the underlying financial reports are updated. The next time you run one of these reports, such as the balance statement, new totals and subentries are added, based on your changes.';
                    ObsoleteState = Pending;
                    ObsoleteReason = 'Duplicated action use action("G/L Account Categories")';
                    ObsoleteTag = '19.0';
                }
#endif
                action("Bank Account Posting Groups")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Bank Account Posting Groups';
                    RunObject = Page "Bank Account Posting Groups";
                    ToolTip = 'Set up posting groups, so that payments in and out of each bank account are posted to the specified general ledger account.';
                }
            }
            group(Journals)
            {
                Caption = 'Journals';
                Image = Journals;
                ToolTip = 'Post financial transactions.';
                action(GeneralJournals)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'General Journals';
                    Image = Journal;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "General Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST(General),
                                        Recurring = CONST(false));
                    ToolTip = 'Post financial transactions directly to general ledger accounts and other accounts, such as bank, customer, vendor, and employee accounts. Posting with a general journal always creates entries on general ledger accounts. This is true even when, for example, you post a journal line to a customer account, because an entry is posted to a general ledger receivables account through a posting group.';
                }
                action("<Action3>")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Recurring General Journals';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "General Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST(General),
                                        Recurring = CONST(true));
                    ToolTip = 'Define how to post transactions that recur with few or no changes to general ledger, bank, customer, vendor, or fixed asset accounts';
                }
                action(PurchaseJournals)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Purchase Journals';
                    RunObject = Page "General Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST(Purchases),
                                        Recurring = CONST(false));
                    ToolTip = 'Post any purchase-related transaction directly to a vendor, bank, or general ledger account instead of using dedicated documents. You can post all types of financial purchase transactions, including payments, refunds, and finance charge amounts. Note that you cannot post item quantities with a purchase journal.';
                }
                action(SalesJournals)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sales Journals';
                    RunObject = Page "General Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST(Sales),
                                        Recurring = CONST(false));
                    ToolTip = 'Post any sales-related transaction directly to a customer, bank, or general ledger account instead of using dedicated documents. You can post all types of financial sales transactions, including payments, refunds, and finance charge amounts. Note that you cannot post item quantities with a sales journal.';
                }
                action(PostedGeneralJournals)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted General Journals';
                    RunObject = Page "Posted General Journal";
                    ToolTip = 'Open the list of posted general journal lines.';
                }
            }
            group("Cash Management")
            {
                Caption = 'Cash Management';
                ToolTip = 'Process incoming and outgoing payments. Set up bank accounts and service connections for electronic banking.  ';

                group("Cheque Manangement")
                {
                    action(CollectedCheques)
                    {
                        ApplicationArea = Basic, Suite;
                        caption = 'Collected Cheques';
                        promoted = true;
                        PromotedCategory = Process;
                        RunObject = page CollectedCheques;
                    }
                    action(ProcessedCheques)
                    {
                        ApplicationArea = Basic, Suite;
                        caption = 'Procesed Cheques';
                        promoted = true;
                        PromotedCategory = Process;
                        RunObject = page ProccesedCheques;
                    }
                    action("OpenCheques")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Open Cheques';
                        promoted = true;
                        PromotedCategory = Process;
                        RunObject = Page OpenCheques;

                    }
                    action("RejectedCheques")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Rejected Cheques';
                        promoted = true;
                        PromotedCategory = Process;
                        RunObject = Page RejectedCheques;

                    }
                    action("ApprovedCheques")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Approved Cheques';
                        promoted = true;
                        PromotedCategory = Process;
                        RunObject = Page ApprovedCheques;

                    }
                    action("PendingCheques")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Pending Cheques';
                        promoted = true;
                        PromotedCategory = Process;
                        RunObject = Page PendingCheques;

                    }

                }
                action(CashReceiptJournals)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cash Receipt Journals';
                    Image = Journals;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "General Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST("Cash Receipts"),
                                        Recurring = CONST(false));
                    ToolTip = 'Register received payments by manually applying them to the related customer, vendor, or bank ledger entries. Then, post the payments to G/L accounts and thereby close the related ledger entries.';
                }
                action(PaymentJournals)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Payment Journals';
                    Image = Journals;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "General Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST(Payments),
                                        Recurring = CONST(false));
                    ToolTip = 'Register payments to vendors. A payment journal is a type of general journal that is used to post outgoing payment transactions to G/L, bank, customer, vendor, employee, and fixed assets accounts. The Suggest Vendor Payments functions automatically fills the journal with payments that are due. When payments are posted, you can export the payments to a bank file for upload to your bank if your system is set up for electronic banking. You can also issue computer checks from the payment journal.';
                }

                action(Action164)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Bank Accounts';
                    Image = BankAccount;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Bank Account List";
                    ToolTip = 'View or set up detailed information about your bank account, such as which currency to use, the format of bank files that you import and export as electronic payments, and the numbering of checks.';
                }
                action("Payment Recon. Journals")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Payment Recon. Journals';
                    Image = ApplyEntries;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Pmt. Reconciliation Journals";
                    ToolTip = 'Reconcile unpaid documents automatically with their related bank transactions by importing a bank statement feed or file. In the payment reconciliation journal, incoming or outgoing payments on your bank are automatically, or semi-automatically, applied to their related open customer or vendor ledger entries. Any open bank account ledger entries related to the applied customer or vendor ledger entries will be closed when you choose the Post Payments and Reconcile Bank Account action. This means that the bank account is automatically reconciled for payments that you post with the journal.';
                }
                action("Bank Acc. Statements")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Bank Acc. Statements';
                    Image = BankAccountStatement;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Bank Account Statement List";
                    ToolTip = 'View statements for selected bank accounts. For each bank transaction, the report shows a description, an applied amount, a statement amount, and other information.';
                }
                action("Cash Flow Forecasts")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cash Flow Forecasts';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Cash Flow Forecast List";
                    ToolTip = 'Combine various financial data sources to find out when a cash surplus or deficit might happen or whether you should pay down debt, or borrow to meet upcoming expenses.';
                }
                action("Chart of Cash Flow Accounts")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Chart of Cash Flow Accounts';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Chart of Cash Flow Accounts";
                    ToolTip = 'View a chart contain a graphical representation of one or more cash flow accounts and one or more cash flow setups for the included general ledger, purchase, sales, services, or fixed assets accounts.';
                }
                action("Cash Flow Manual Revenues")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cash Flow Manual Revenues';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Cash Flow Manual Revenues";
                    ToolTip = 'Record manual revenues, such as rental income, interest from financial assets, or new private capital to be used in cash flow forecasting.';
                }
                action("Cash Flow Manual Expenses")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cash Flow Manual Expenses';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Cash Flow Manual Expenses";
                    ToolTip = 'Record manual expenses, such as salaries, interest on credit, or planned investments to be used in cash flow forecasting.';
                }
                action(BankAccountReconciliations)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Bank Account Reconciliations';
                    Image = BankAccountRec;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Bank Acc. Reconciliation List";
                    ToolTip = 'Reconcile bank accounts in your system with bank statements received from your bank.';
                }
            }
            group(Action84)
            {
                Caption = 'Membership Management';
                group("Individual Membership")
                {
                    action(MembershipApp)
                    {
                        ApplicationArea = All;
                        Caption = 'Membership Application';
                        Promoted = true;
                        PromotedCategory = Process;
                        RunObject = Page "Membership Application List";
                        ToolTip = 'Apply New Members.';
                    }
                    action(MembersList)
                    {
                        ApplicationArea = all;
                        Caption = 'Member Accounts List';
                        Promoted = true;
                        PromotedCategory = Process;
                        RunObject = Page "Members List";
                        ToolTip = 'Manage Member Accounts';
                    }
                    group("Membership Reports")
                    {
                        action("Members Applications List")
                        {
                            ApplicationArea = all;
                            promoted = true;
                            PromotedCategory = Process;
                            RunObject = report "Members Applications List";
                            ToolTip = 'Members Appplications List Report';
                        }
                        action("Members Register")
                        {
                            ApplicationArea = all;
                            promoted = true;
                            PromotedCategory = Process;
                            RunObject = report "Member List Report";
                            ToolTip = 'Members Register';

                        }
                        action("Share Capital Balances Report")
                        {
                            ApplicationArea = all;
                            promoted = true;
                            PromotedCategory = Process;
                            RunObject = report "Share Capital Balances Report.";
                            ToolTip = 'Share Capital Balances Report';
                        }
                        action("Member Deposit Balances Report")
                        {
                            ApplicationArea = all;
                            promoted = true;
                            PromotedCategory = Process;
                            RunObject = report "Member Deposit Balances Repor.";
                            ToolTip = 'Member Deposit Balances Report';
                        }
                        action("Member Benevolent Statement")
                        {
                            ApplicationArea = all;
                            promoted = true;
                            PromotedCategory = Process;
                            RunObject = report "Benevolent Fund Report.";
                            ToolTip = 'Member Benevolent Statement';





                        }
                    }

                    group("Membership Withdrawal")
                    {
                        action("Member Withdrawal List")
                        {
                            ApplicationArea = all;
                            Promoted = true;
                            RunObject = page "Membership Exit List";

                        }
                        action("Posted Membership Withdrawal")
                        {
                            ApplicationArea = all;
                            Promoted = true;
                            RunObject = page "Posted Member Withdrawal List";
                        }
                        group("Withdrawal Reports")
                        {
                            action("Member Exit list")
                            {
                                ApplicationArea = all;
                                Promoted = true;
                                RunObject = report "Membership Withdrawal Report";
                            }
                        }
                    }

                    group(ChangeRequest)
                    {
                        Caption = 'Change Request';
                        action("Change Request")
                        {
                            ApplicationArea = All;
                            Caption = 'Change Request List';
                            Promoted = true;
                            PromotedCategory = Process;
                            RunObject = Page "Change Request List";
                            ToolTip = 'Change Member Details';
                        }
                        action(AgentNOKSignatoriesChange)
                        {
                            ApplicationArea = all;
                            Caption = 'Agent/NOK/Signatories Change';
                            Promoted = true;
                            PromotedCategory = Process;
                            RunObject = Page "New Agent/NOK/Sign Change List";
                        }

                        group(ReportsChangereq)
                        {
                            caption = 'Reports Change Request';
                            action(ChangeReqMobile)
                            {
                                ApplicationArea = All;
                                Caption = 'Change Req(mobile)';
                                Promoted = true;
                                PromotedCategory = Process;
                                RunObject = report "Change Request Report(Mobile)";
                            }
                            action(ChangeReqAcc)
                            {
                                ApplicationArea = All;
                                Caption = 'Change Req(Account)';
                                Promoted = true;
                                PromotedCategory = Process;
                                RunObject = report "Change Request Report(Account)";
                            }
                        }
                        group(EffectedChangeReqs)

                        {
                            Caption = 'Effected Change Requests';
                            action(updatedchangereqslist)
                            {
                                ApplicationArea = All;
                                Caption = 'Updated Change requests';
                                Promoted = true;
                                PromotedCategory = Process;
                                RunObject = page "Updated Change Request List";
                            }

                            action(updatedNOKAgentSign)
                            {
                                Caption = 'Updated NOK/Agent & Signatories';
                                RunObject = page "Agent/NOK Change - Effected";
                            }
                        }

                    }

                }
                group(Action16)
                {
                    Caption = 'Fixed Assets';
                    Image = FixedAssets;
                    ToolTip = 'Manage depreciation and insurance of your fixed assets.';
                    action(Action17)
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'Fixed Assets';
                        Promoted = true;
                        PromotedCategory = Process;
                        RunObject = Page "Fixed Asset List";
                        ToolTip = 'Manage periodic depreciation of your machinery or machines, keep track of your maintenance costs, manage insurance policies related to fixed assets, and monitor fixed asset statistics.';
                    }
                    action("Fixed Assets G/L Journals")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'Fixed Assets G/L Journals';
                        Promoted = true;
                        PromotedCategory = Process;
                        RunObject = Page "General Journal Batches";
                        RunPageView = WHERE("Template Type" = CONST(Assets),
                                        Recurring = CONST(false));
                        ToolTip = 'Post fixed asset transactions, such as acquisition and depreciation, in integration with the general ledger. The FA G/L Journal is a general journal, which is integrated into the general ledger.';
                    }
                    action("Fixed Assets Journals")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'Fixed Assets Journals';
                        Promoted = true;
                        PromotedCategory = Process;
                        RunObject = Page "FA Journal Batches";
                        RunPageView = WHERE(Recurring = CONST(false));
                        ToolTip = 'Post fixed asset transactions, such as acquisition and depreciation book without integration to the general ledger.';
                    }
                    action("Fixed Assets Reclass. Journals")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'Fixed Assets Reclass. Journals';
                        Promoted = true;
                        PromotedCategory = Process;
                        RunObject = Page "FA Reclass. Journal Batches";
                        ToolTip = 'Transfer, split, or combine fixed assets by preparing reclassification entries to be posted in the fixed asset journal.';
                    }
                    action(Insurance)
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'Insurance';
                        Promoted = true;
                        PromotedCategory = Process;
                        RunObject = Page "Insurance List";
                        ToolTip = 'Manage insurance policies for fixed assets and monitor insurance coverage.';
                    }
                    action("Insurance Journals")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'Insurance Journals';
                        Promoted = true;
                        PromotedCategory = Process;
                        RunObject = Page "Insurance Journal Batches";
                        ToolTip = 'Post entries to the insurance coverage ledger.';
                    }
                    action("Recurring Fixed Asset Journals")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'Recurring Fixed Asset Journals';
                        Promoted = true;
                        PromotedCategory = Process;
                        RunObject = Page "FA Journal Batches";
                        RunPageView = WHERE(Recurring = CONST(true));
                        ToolTip = 'Post recurring fixed asset transactions, such as acquisition and depreciation book without integration to the general ledger.';
                    }
                }
                group("Saving Products Management")
                {
                    Caption = 'Saving Products Management';
                    Image = Bank;
                    ToolTip = 'Manage Saving Accounts Eg. FOSA Savings and Fixed Deposits';
                    Visible = false;
                    action("Account Applications")
                    {
                        ApplicationArea = basic, suite;
                        Caption = 'Membership Products Application';
                        Image = Customer;
                        RunObject = page "Member Account Application";
                        ToolTip = 'Open New membership products accounts Application.';

                    }
                    action("Member FOSA Accounts")
                    {
                        ApplicationArea = basic, suite;
                        Caption = 'Member Savings Accounts';
                        Image = Customer;
                        RunObject = page "Member Accounts List";
                        ToolTip = 'Open Members'' FOSA Accounts';
                        Visible = false;

                    }
                    group("Fixed Deposits Mgmt ")
                    {
                        Caption = 'Fixed Deposits Mgmt';
                        Image = Bank;
                        ToolTip = 'Open Fixed Deposits Submodule';
                        action("Fixed Deposits List")
                        {
                            ApplicationArea = basic, suite;
                            Caption = 'Fixed Deposits Savings Accounts';
                            Image = Account;
                            RunObject = page "Fixed Deposit Acc. List";
                            ToolTip = 'Open Fixed Deposits'' FOSA Accounts';

                        }
                        action("Fixed Deposits Setup")
                        {
                            ApplicationArea = basic, suite;
                            Caption = 'Fixed Deposits Types';
                            Image = Account;
                            RunObject = page "Fixed deposit Types list";
                            ToolTip = 'Open Fixed Deposits'' Types';

                        }
                        action("Fixed Deposits interest")
                        {
                            ApplicationArea = basic, suite;
                            Caption = 'Fixed Deposits Interest';
                            Image = Account;
                            RunObject = page "Fixed Deposit Interest Rates";
                            ToolTip = 'Open Fixed Deposits'' Interest Rates';

                        }
                    }
                    group("Cashier Banking")
                    {
                        Caption = 'Cashier-Banking';
                        Image = FixedAssets;

                        action("Cashier Transactions Authorisation")
                        {
                            ApplicationArea = Basic;
                            Caption = 'Cashier Transactions Authorisation';
                            RunObject = Page "Cashier Trans Authorisations";
                        }
                        action("EFT List")
                        {
                            ApplicationArea = Basic;
                            Caption = 'EFT List';
                            RunObject = Page "New EFT/RTGS List";
                        }
                        action("Petty Cash")
                        {
                            ApplicationArea = Basic;
                            Caption = 'Petty Cash';
                            RunObject = Page "New Petty Cash Payments List";
                        }
                        action("Posted Petty Cash")
                        {
                            ApplicationArea = Basic;
                            Caption = 'Posted Petty Cash';
                            RunObject = Page "Posted Petty Cash Payments";
                        }
                        action("Funds Transfer")
                        {
                            ApplicationArea = Basic;
                            Caption = 'Funds Transfer';
                            RunObject = Page "Funds Transfer List";
                        }
                    }
                    group("ATM Banking")
                    {
                        Caption = 'ATM Banking';
                        action(ATMApplication)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'ATM Card Application';
                            RunObject = page "ATM Cards Application - New";

                        }
                        action(ATMProcessed)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Processed ATM Cards';
                            RunObject = page "ATM Cards Appl. - Processed";

                        }
                        action(ATMTransactionDetails)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'ATM Transaction Details';
                            RunObject = page "Atm Transaction Details";

                        }
                        action(ATMRequestBatch)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'ATM Card Request Batch List';
                            RunObject = page "ATM Card Request Batch List";

                        }
                        action(ATMBatchReceiptsBatch)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'ATM Card Receipt Batch List';
                            RunObject = page "ATM Card Receipt Batch List";

                        }
                    }

                }
                group("Loans Management")
                {
                    Caption = 'Loan Management';
                    Image = CreditCard;
                    ToolTip = 'Loans'' Management Module';
                    group("BOSA Loans Management")
                    {
                        Caption = 'BOSA Loan Management';
                        Image = CreditCard;
                        ToolTip = 'BOSA Loans'' Management Module';
                        action("BOSA Loan Application")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'BOSA Loan Application';
                            Image = CreditCard;
                            RunObject = Page "Loan Application BOSA(New)";
                            ToolTip = 'Open BOSA Loan Applications';
                        }
                        action("Pending BOSA Loan Application")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Pending BOSA Loan Applications';
                            Image = CreditCard;
                            RunObject = Page "Loans  List- pending approval";
                            ToolTip = 'Open the list of Pending BOSA Loan Applications.';
                        }
                        action("Approved Loans")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Approved Loans Pending Disbursement.';
                            RunObject = Page "Loans Application List(Approv)";
                            ToolTip = 'Open the list of Approved Loans Pending Disbursement.';
                        }
                        action("Batch List")
                        {
                            ApplicationArea = Basic, Suite;
                            RunObject = page "Loans Disbursment Batch List";
                            Caption = 'Loan Batch List';
                        }
                        action("Posted Loans")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Posted Loans';
                            RunObject = Page "Loans Posted List";
                            ToolTip = 'Open the list of the Loans Posted.';
                        }

                        group("Guarantor Substitution")
                        {
                            action("Guarantor Substitution List")
                            {
                                ApplicationArea = Basic, Suite;
                                RunObject = Page "Guarantorship Sub List";
                            }
                            action("Effected Guarantor Substitution")
                            {
                                ApplicationArea = Basic, Suite;
                                RunObject = Page "Processed Guarantor Sub List";
                            }

                        }
                        group("Loans' Reports")
                        {
                            action("Loans Balances Report")
                            {
                                ApplicationArea = all;
                                promoted = true;
                                PromotedCategory = Process;
                                RunObject = report "Loans Balances Report";
                                ToolTip = 'Loans Balances Report';
                            }
                            action("Loan Defaulter Aging")
                            {
                                ApplicationArea = all;
                                promoted = true;
                                PromotedCategory = Process;
                                RunObject = report "Loan Defaulter Aging";
                                ToolTip = 'Loan Defaulter Aging';
                            }
                            action("Loans Monthly Expectation")
                            {
                                ApplicationArea = all;
                                promoted = true;
                                PromotedCategory = Process;
                                RunObject = report "Loans Monthly Expectation";
                                ToolTip = 'Loans Monthly Expectation';
                            }
                            action("Loans Guard Report")
                            {
                                ApplicationArea = all;
                                promoted = true;
                                PromotedCategory = Process;
                                RunObject = report "Loans Guard Report";
                                ToolTip = 'Loans Guard Report';
                            }
                            action("Guaranters List")
                            {
                                ApplicationArea = all;
                                promoted = true;
                                PromotedCategory = Process;
                                RunObject = report "Guaranters List";
                                ToolTip = 'Guaranters List';
                            }
                            action("Loans Disbursement Listing")
                            {
                                ApplicationArea = all;
                                promoted = true;
                                PromotedCategory = Process;
                                RunObject = report "Loan Disbursement List";
                                ToolTip = 'Loans Disbursment Listing';
                            }
                            action("Loan Movement  Report")
                            {
                                ApplicationArea = all;
                                promoted = true;
                                PromotedCategory = Process;
                                RunObject = report "Loan Movement Report";
                                ToolTip = 'Loan Movement Report';
                            }
                            action("Loans Register")
                            {
                                ApplicationArea = all;
                                promoted = true;
                                PromotedCategory = Process;
                                RunObject = Report "Loans Register";
                                ToolTip = 'Loan Register Report';
                            }
                            action("Loan Batch Payments")
                            {
                                ApplicationArea = all;
                                promoted = true;
                                PromotedCategory = Process;
                                RunObject = Report "Loans Batch Payments";
                                ToolTip = 'Loan Batch Payments Report';
                            }
                            action("Loan Movement Report")
                            {
                                ApplicationArea = all;
                                promoted = true;
                                PromotedCategory = Process;
                                RunObject = Report "Loan Movement Report";
                                ToolTip = 'Loan Movement Report';
                            }
                            action("Loans Areas Report")
                            {
                                ApplicationArea = all;
                                promoted = true;
                                PromotedCategory = Process;
                                RunObject = Report "Loan Arrears Report";
                                ToolTip = 'Loan Areas Report';
                            }
                            action("Loans Monthly Expectatuion")
                            {
                                ApplicationArea = all;
                                promoted = true;
                                PromotedCategory = Process;
                                RunObject = Report "Loan Monthly Expectation";
                                ToolTip = 'Loan Register Report';
                            }

                        }

                    }
                }
                group("FOSA Loans MAnagement")
                {
                    Caption = 'FOSA Loan Management';
                    Image = CreditCard;
                    ToolTip = 'FOSA Loans'' Management Module';
                    Visible = false;

                    action("New FOSA Loans")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'New FOSA Loans.';
                        RunObject = Page "Loan Application FOSA(New)";
                        ToolTip = 'Open new FOSA Loan Applications';

                    }

                    action("Pending FOSA Loans")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Pending FOSA Loan Applications';
                        RunObject = Page "Loan Application FOSA(Pending)";
                        ToolTip = 'Open Pending FOSA Loan Applications';

                    }
                    action("Approved FOSA Loans")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Approved FOSA Loan Applications';
                        RunObject = Page "Loan Application FOSA(Approv)";
                        ToolTip = 'Approved Pending FOSA Loan Applications';

                    }
                    action("Posted FOSA Loans")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Posted FOSA Loan Applications';
                        RunObject = Page "Loan Application FOSA(Posted)";
                        ToolTip = 'Open Posted FOSA Loan Applications';

                    }


                }
                group(loanssetup)
                {
                    Caption = 'Loans Setup';
                    action(LoansproductSetup)
                    {
                        Caption = 'Loans Product Setup';
                        Image = Setup;
                        RunObject = page "Loan Products Setup List";
                    }
                    action(LoanStages)
                    {
                        Caption = 'Loan Stages';
                        Image = Setup;
                        RunObject = page "Loan Stages";
                    }
                    action(CreditOfficers)
                    {
                        Caption = 'Credit Officers';
                        Image = Setup;
                        RunObject = page "Credit/Field Officers";
                    }

                }
                group(Collateralmgmt)
                {
                    Caption = 'Collateral Management';
                    Visible = false;
                    action(Collateralreg)
                    {
                        Caption = 'Loan Collateral Register';
                        Image = Register;
                        RunObject = page "Loan Collateral Register List";
                    }
                    action(Collateralmvmt)
                    {
                        Caption = 'Loan Collateral Movement';
                        RunObject = page "Collateral Movement List";
                    }

                    group(CollateralReports)
                    {
                        Caption = 'Collateral Movement';
                        action(ColateralsReport)
                        {
                            Caption = 'Collateral Report';
                            RunObject = report "Collaterals Report";
                        }

                    }
                    group(ArchiveCollateral)
                    {
                        Caption = 'Archive';
                        action(Effectedcollatmvmt)
                        {
                            Caption = 'Effective Collateral Movement';
                            RunObject = page "Effected Collateral Movement";
                        }
                    }
                }
                group(DefaulterManagememnt)
                {
                    group(loanRecovery)
                    {
                        Caption = 'Loan Recovery';
                        action(LoanRecovList)
                        {
                            Caption = 'Loan Recovery List';
                            RunObject = page "Loan Recovery List";

                        }
                        action(LoanRecoveryApprov)
                        {
                            Caption = 'Approved Loan Recovery';
                            runobject = page "Loan Recovery - Approved";
                        }
                        action(LoanRecoveryPosted)
                        {
                            Caption = 'Posted Loan Recovery';
                            RunObject = page "Posted Loan Recovery Header";
                        }
                    }
                    group(demandnotices)
                    {
                        caption = 'Demand Notices';
                        action(LoanDemandnoticeslist)
                        {
                            caption = 'Loan Demand Notices List';
                            RunObject = page "Loan Demand Notices List";
                        }
                        group(DemnandTask)
                        {
                            Caption = 'Create Demand Notices';
                            action(CreateDemand)
                            {
                                Caption = 'Create Demand';
                                RunObject = report "Create Demand Notices";
                                Image = Report2;
                            }
                        }
                        group(DemandReports)
                        {
                            action(Ldemandnotice)
                            {
                                Caption = 'Loan Demand Notice';
                                RunObject = report "Loan Demand Notice";
                                Image = Report;
                            }
                            action(LcrbNotice)
                            {
                                Caption = 'Loan CRB Notice';
                                RunObject = report "Loan CRB Notice";
                                Image = Report;
                            }
                        }
                    }
                }

            }
            group("Periodic Activities")
            {
                action("Viwanda CheckOff Adivice")
                {
                    ApplicationArea = All;

                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = page "Viwanda CheckOff Advice";
                }

            }

            group(Receipts)
            {
                Caption = 'BOSA Receipts';
                Image = Receivables;
                ToolTip = 'Member Receipting Process.';

                action("BOSA Receipts")
                {
                    Caption = 'Open BOSA Receipts';
                    Image = Receipt;
                    RunObject = page "BOSA Receipts List";
                    ToolTip = 'New Member Receipts for payments done.';

                }
                action("Posted BOSA Receipts")
                {
                    Caption = 'Posted BOSA Receipts';
                    Image = PostedReceipt;
                    RunObject = page "Posted BOSA Receipts List";
                    ToolTip = 'New Member Receipts for payments done.';

                }
            }
            group("Payment Management")
            {
                Caption = 'Payment Process';
                Image = Payables;
                ToolTip = 'Payment Process.';
                action("Check Payment")
                {

                    Caption = 'Check Payment ';
                    ApplicationArea = Basic, Suite;
                    Image = Check;
                    RunObject = page "Payment Voucher List";
                    ToolTip = 'Payment Voucher List.';
                }

                action("Cash Payment")
                {

                    Caption = 'New Petty Cash Payments List ';
                    ApplicationArea = Basic, Suite;
                    Image = Check;
                    RunObject = page "New Petty Cash Payments List";
                    ToolTip = 'New Petty Cash Payments List.';
                }
                action("Posted Cash Payment")
                {

                    Caption = 'Posted Cash Payment';
                    ApplicationArea = Basic, Suite;
                    Image = Check;
                    RunObject = page "Posted Petty Cash Payments";
                    ToolTip = 'Posted Cash Payment';
                }
                action("Posted Cheque Payment")
                {

                    Caption = 'Posted Cheque Payment';
                    ApplicationArea = Basic, Suite;
                    Image = Check;
                    RunObject = page "Posted Cheque Payment Vouchers";
                    ToolTip = 'Posted Cheque Payment';
                }





                action("Funds Transfer List")
                {
                    Caption = 'Funds Transfer List';
                    ApplicationArea = Basic, Suite;
                    Image = Check;
                    RunObject = page "Funds Transfer List";
                    ToolTip = 'Funds Transfer List';
                }

                action("Posted Funds Transfer List")
                {
                    Caption = 'Posted Funds Transfer List';
                    ApplicationArea = Basic, Suite;
                    Image = Check;
                    RunObject = page "Posred Funds Transfer List";
                    ToolTip = 'Posted Funds Transfer List';
                }

                action("Receipt Header List")
                {
                    Caption = 'Receipt Header List';
                    ApplicationArea = Basic, Suite;
                    Image = Check;
                    RunObject = page "Receipt Header List";
                    ToolTip = 'Receipt Header List';
                }

                action("Posted Receipt Header List ")
                {
                    Caption = 'Posted Receipt Header List ';
                    ApplicationArea = Basic, Suite;
                    Image = PostedOrder;
                    RunObject = page "Posted Receipt Header List";
                    ToolTip = 'Posted Receipt Header List ';
                }

            }
            group("Payments Setup")
            {
                Caption = 'Payment Setup';
                Image = Setup;
                ToolTip = 'Payment Setup.';
                action("Funds Genral Setup")
                {

                    Caption = 'Funds General Setup. ';
                    ApplicationArea = Basic, Suite;
                    Image = Check;
                    RunObject = page "Funds General Setup";
                    ToolTip = 'Funds General Setup.';
                }

                action("Budgetary Control Setup")
                {

                    Caption = 'Budgetary Control Setup ';
                    ApplicationArea = Basic, Suite;
                    Image = Check;
                    RunObject = page "Budgetary Control Setup";
                    ToolTip = 'Budgetary Control Setup';
                }
                action("Funds User Setup")
                {

                    Caption = 'Funds User Setup ';
                    ApplicationArea = Basic, Suite;
                    Image = Check;
                    RunObject = page "Funds User Setup";
                    ToolTip = 'Funds User Setup';
                }
                action("Receipt and Payment Types List")
                {

                    Caption = 'Receipt and Payment Types List';
                    ApplicationArea = Basic, Suite;
                    Image = Setup;
                    RunObject = page "Receipt and Payment Types List";
                    ToolTip = 'Receipt and Payment Types List';
                }
            }

            group("Banking Services")
            {
                Visible = false;
                action("Cashier Transactions")
                {
                    Caption = 'cashier transactions';
                    ApplicationArea = basic, suite;
                    Image = Payment;
                    RunObject = page "Cashier Transactions - List";
                    ToolTip = 'cashier transaction list';
                }
                action("banking Setup")
                {
                    Caption = 'Transaction Type - List';
                    ApplicationArea = basic, suite;
                    Image = Setup;
                    RunObject = page "Transaction Type - List";
                    ToolTip = 'Transaction Type - List';
                }
            }


            group(SaccoCRM)
            {
                Caption = 'SACCO CRM';
                group("Case Management")
                {
                    action("Case Registration")
                    {
                        Caption = 'Case Enquiry Registration List';
                        ApplicationArea = basic, suite;
                        Image = Capacity;
                        RunObject = page "Crm Log List";
                        ToolTip = 'Book a New Case enquiry';

                    }
                    action("Assigned Cases")
                    {
                        Caption = 'Cases List';
                        ApplicationArea = basic, suite;
                        Image = Capacity;
                        RunObject = page "Case Assigned  list";
                        ToolTip = 'New Cases';

                    }
                    action("Resolved Case Enquiries")
                    {
                        Caption = 'Resolved Cases Enquiries';
                        ApplicationArea = basic, suite;
                        Image = Capacity;
                        //RunObject = page resolved;
                        ToolTip = 'Resolved Cases Enquiries';

                    }
                    action("Resolved Cases")
                    {
                        Caption = 'Resolved Cases';
                        ApplicationArea = basic, suite;
                        Image = Capacity;
                        RunObject = page "Case Assigned  solved";
                        ToolTip = 'Resolved Cases';

                    }
                }
                group("CRM Gen Setup")
                {
                    action("CRM General setup")
                    {
                        Caption = 'CRM General Setup';
                        ApplicationArea = basic, suite;
                        Image = Capacity;
                        RunObject = page "Crm Nos series Card";
                        ToolTip = 'CRM Setup';

                    }
                    action("CRM Case types")
                    {
                        Caption = 'CRM Case types';
                        ApplicationArea = basic, suite;
                        Image = Capacity;
                        RunObject = page "CRM Case Types";
                        ToolTip = 'CRM Case Types';

                    }
                }

            }

            Group(SaccoPayroll)
            {
                Caption = 'Payroll Management';
                Visible = false;
                group(payrollEmployees)
                {
                    Caption = 'Payroll Employees';
                    action(payrollemp)
                    {
                        Caption = 'Payroll Employees list';
                        ApplicationArea = basic, suite;
                        Image = Employee;
                        RunObject = page "Payroll Employee List.";
                        tooltip = 'Open Payroll Employees list';
                    }
                    action(Exitedpayrollemp)
                    {
                        Caption = 'Exited Payroll Employees list';
                        ApplicationArea = basic, suite;
                        Image = Employee;
                        RunObject = page "Exited Payroll Employees";
                        tooltip = 'Open exited Payroll Employees list';
                    }
                }
                group(PayrollEarnings)
                {
                    Caption = 'Earnings&Deductions';
                    action(Earnings)
                    {
                        Caption = 'Payroll Earnings';
                        ApplicationArea = basic, suite;
                        Image = Card;
                        RunObject = page "Payroll Earnings List.";

                    }
                    action(Deductions)
                    {
                        Caption = 'Payroll Deductions';
                        ApplicationArea = basic, suite;
                        Image = Card;
                        RunObject = page "Payroll Deductions List.";

                    }
                }
                group(payrollsetup)
                {
                    action(payesetup)
                    {
                        Caption = 'PAYE SETUP';
                        ApplicationArea = basic, suite;
                        RunObject = page "Payroll PAYE Setup.";
                    }
                    action(NHIF)
                    {
                        Caption = 'NHIF SETUP';
                        ApplicationArea = basic, suite;
                        RunObject = page "Payroll NHIF Setup.";
                    }
                    action(NSSF)
                    {
                        Caption = 'NHIF SETUP';
                        ApplicationArea = basic, suite;
                        RunObject = page "Payroll NSSF Setup.";
                    }
                    action(Payrolposting)
                    {
                        Caption = 'Payroll Posting group';
                        ApplicationArea = basic, suite;
                        RunObject = page "Payroll Posting Group.";
                    }
                    action(payrollpostingsetup)
                    {
                        caption = 'Payroll posting setup';
                        ApplicationArea = basic, suite;
                        RunObject = page "Payroll Posting Setup Ver1";
                    }

                }
                group(payrollperiodicactivities)
                {
                    Caption = 'Payroll Periodic Activities';
                    action(payrollperiods)
                    {
                        Caption = 'Payroll Periods';
                        ApplicationArea = basic, suite;
                        RunObject = page "Payroll Periods.";
                    }
                    action(Transfertojournal)
                    {
                        Caption = 'Payroll journal transfer';
                        ApplicationArea = basic, suite;
                        RunObject = report "Payroll JournalTransfer Ver1";
                        //Better call saul  
                    }
                    action(Payrolnettransfer)
                    {
                        Caption = 'Payroll Net Transfer';
                        ApplicationArea = basic, suite;
                        RunObject = report "Payroll Net Pay Transfer Ver1";
                    }
                    action(SendP9)
                    {
                        Caption = 'Send P9 via Mail';
                        ApplicationArea = basic, suite;
                        RunObject = report "Send P9 Report Via Mail";
                    }

                }


            }

#if not CLEAN18
            group(SetupAndExtensions)
            {
                Caption = 'Setup & Extensions';
                Image = Setup;
                ToolTip = 'Overview and change system and application settings, and manage extensions and services';
                Visible = false;
                ObsoleteState = Pending;
                ObsoleteReason = 'The new common entry points to all Settings is introduced in the app bar''s cogwheel menu (aligned with the Office apps).';
                ObsoleteTag = '18.0';
                action("Assisted Setup")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Assisted Setup';
                    Image = QuestionaireSetup;
                    RunObject = Page "Assisted Setup";
                    ToolTip = 'Set up core functionality such as sales tax, sending documents as email, and approval workflow by running through a few pages that guide you through the information.';
                    ObsoleteState = Pending;
                    ObsoleteReason = 'The new common entry points to all Settings is introduced in the app bar''s cogwheel menu (aligned with the Office apps).';
                    ObsoleteTag = '18.0';
                }
                action("Manual Setup")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Manual Setup';
                    RunObject = Page "Manual Setup";
                    ToolTip = 'Define your company policies for business departments and for general activities.';
                    ObsoleteState = Pending;
                    ObsoleteReason = 'The new common entry points to all Settings is introduced in the app bar''s cogwheel menu (aligned with the Office apps).';
                    ObsoleteTag = '18.0';
                }
                action("Service Connections")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Service Connections';
                    Image = ServiceTasks;
                    RunObject = Page "Service Connections";
                    ToolTip = 'Enable and configure external services, such as exchange rate updates, Microsoft Social Engagement, and electronic bank integration.';
                    ObsoleteState = Pending;
                    ObsoleteReason = 'The new common entry points to all Settings is introduced in the app bar''s cogwheel menu (aligned with the Office apps).';
                    ObsoleteTag = '18.0';
                }
                action(Extensions)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Extensions';
                    Image = NonStockItemSetup;
                    RunObject = Page "Extension Management";
                    ToolTip = 'Install Extensions for greater functionality of the system.';
                    ObsoleteState = Pending;
                    ObsoleteReason = 'The new common entry points to all Settings is introduced in the app bar''s cogwheel menu (aligned with the Office apps).';
                    ObsoleteTag = '18.0';
                }
                action(Workflows)
                {
                    ApplicationArea = Suite;
                    Caption = 'Workflows';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page Workflows;
                    ToolTip = 'Set up or enable workflows that connect business-process tasks performed by different users. System tasks, such as automatic posting, can be included as steps in workflows, preceded or followed by user tasks. Requesting and granting approval to create new records are typical workflow steps.';
                    ObsoleteState = Pending;
                    ObsoleteReason = 'The new common entry points to all Settings is introduced in the app bar''s cogwheel menu (aligned with the Office apps).';
                    ObsoleteTag = '18.0';
                }
            }
#endif
        }
        area(creation)
        {
            action("Process checkoff")
            {
                AccessByPermission = TableData "Checkoff Header-Distributed" = IMD;
                ApplicationArea = Basic, Suite;
                Caption = 'Process Block Checkoff';
                RunObject = Page "Bosa Receipts H List-Checkoff";
                RunPageMode = Create;
                ToolTip = 'Create new Block checkoff';
            }
            action("Posted checkoff")
            {
                AccessByPermission = TableData "Checkoff Header-Distributed" = IMD;
                ApplicationArea = Basic, Suite;
                Caption = 'Posted Block Checkoff';
                RunObject = Page "Posted Bosa Rcpt List-Checkof";
                RunPageMode = Create;
                ToolTip = 'See Posted Block checkoff';
            }
            action("Process Interest")
            {
                AccessByPermission = TableData "Loans Register" = IMD;
                ApplicationArea = Basic, Suite;
                Caption = 'Process Loan Monthly Interest';
                RunObject = report "Process Loan Monthly Interest";
                RunPageMode = Create;
                ToolTip = 'Charge Monthly Loan Interest.';
            }
            action("Salary Processing")
            {
                AccessByPermission = TableData "Salary Processing Headerr" = IMD;
                ApplicationArea = Basic, Suite;
                Caption = 'Salary Processing ';
                RunObject = Page "Salary Processing List";
                ToolTip = 'Prepare Salaries.';
            }
            action("Payment Journal Entry")
            {
                AccessByPermission = TableData "Gen. Journal Batch" = IMD;
                ApplicationArea = Basic, Suite;
                Caption = 'Payment Journal Entry';
                RunObject = Page "Payment Journal";
                ToolTip = 'Pay your vendors by filling the payment journal automatically according to payments due, and potentially export all payment to your bank for automatic processing.';
            }
        }
        area(processing)
        {
            group(Payments)
            {
                Caption = 'Payments';
                action("Cas&h Receipt Journal")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cas&h Receipt Journal';
                    Image = CashReceiptJournal;
                    RunObject = Page "Cash Receipt Journal";
                    ToolTip = 'Apply received payments to the related non-posted sales documents.';
                }
                action("Pa&yment Journal")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Pa&yment Journal';
                    Image = PaymentJournal;
                    RunObject = Page "Payment Journal";
                    ToolTip = 'Make payments to vendors.';
                }
            }
            group(Analysis)
            {
                Caption = 'Analysis';
                action("Analysis &Views")
                {
                    ApplicationArea = Dimensions;
                    Caption = 'Analysis &Views';
                    Image = AnalysisView;
                    RunObject = Page "Analysis View List";
                    ToolTip = 'Analyze amounts in your general ledger by their dimensions using analysis views that you have set up.';
                }
                action("Analysis by &Dimensions")
                {
                    ApplicationArea = Dimensions;
                    Caption = 'Analysis by &Dimensions';
                    Image = AnalysisViewDimension;
                    RunObject = Page "Analysis by Dimensions";
                    ToolTip = 'Analyze activities using dimensions information.';
                    Visible = false;
                    ObsoleteState = Pending;
                    ObsoleteReason = 'This functionality runs correctly from the Analysis View List page';
                    ObsoleteTag = '18.0';
                }
            }
            group(Tasks)
            {
                Caption = 'Tasks';
                action("Calculate Deprec&iation")
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'Calculate Deprec&iation';
                    Ellipsis = true;
                    Image = CalculateDepreciation;
                    RunObject = Report "Calculate Depreciation";
                    ToolTip = 'Calculate depreciation according to the conditions that you define. If the fixed assets that are included in the batch job are integrated with the general ledger (defined in the depreciation book that is used in the batch job), the resulting entries are transferred to the fixed assets general ledger journal. Otherwise, the batch job transfers the entries to the fixed asset journal. You can then post the journal or adjust the entries before posting, if necessary.';
                }
                action("Import Co&nsolidation from Database")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Import Co&nsolidation from Database';
                    Ellipsis = true;
                    Image = ImportDatabase;
                    RunObject = Report "Import Consolidation from DB";
                    ToolTip = 'Import entries from the business units that will be included in a consolidation. You can use the batch job if the business unit comes from the same database in Business Central as the consolidated company.';
                }
                action("Bank Account R&econciliation")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Bank Account R&econciliation';
                    Image = BankAccountRec;
                    RunObject = Page "Bank Acc. Reconciliation";
                    ToolTip = 'View the entries and the balance on your bank accounts against a statement from the bank.';
                }
                action("Payment Reconciliation Journals")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Payment Reconciliation Journals';
                    Image = ApplyEntries;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "Pmt. Reconciliation Journals";
                    RunPageMode = View;
                    ToolTip = 'Reconcile unpaid documents automatically with their related bank transactions by importing a bank statement feed or file. In the payment reconciliation journal, incoming or outgoing payments on your bank are automatically, or semi-automatically, applied to their related open customer or vendor ledger entries. Any open bank account ledger entries related to the applied customer or vendor ledger entries will be closed when you choose the Post Payments and Reconcile Bank Account action. This means that the bank account is automatically reconciled for payments that you post with the journal.';
                }
                action("Adjust E&xchange Rates")
                {
                    ApplicationArea = Suite;
                    Caption = 'Adjust E&xchange Rates';
                    Ellipsis = true;
                    Image = AdjustExchangeRates;
                    RunObject = Codeunit "Exch. Rate Adjmt. Run Handler";
                    ToolTip = 'Adjust general ledger, customer, vendor, and bank account entries to reflect a more updated balance if the exchange rate has changed since the entries were posted.';
                }
                action("P&ost Inventory Cost to G/L")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'P&ost Inventory Cost to G/L';
                    Image = PostInventoryToGL;
                    RunObject = Report "Post Inventory Cost to G/L";
                    ToolTip = 'Record the quantity and value changes to the inventory in the item ledger entries and the value entries when you post inventory transactions, such as sales shipments or purchase receipts.';
                }
                action("Intrastat &Journal")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Intrastat &Journal';
                    Image = Journal;
                    RunObject = Page "Intrastat Jnl. Batches";
                    ToolTip = 'Summarize the value of your purchases and sales with business partners in the EU for statistical purposes and prepare to send it to the relevant authority.';
                }
                action("Calc. and Pos&t VAT Settlement")
                {
                    ApplicationArea = VAT;
                    Caption = 'Calc. and Pos&t VAT Settlement';
                    Image = SettleOpenTransactions;
                    RunObject = Report "Calc. and Post VAT Settlement";
                    ToolTip = 'Close open VAT entries and transfers purchase and sales VAT amounts to the VAT settlement account. For every VAT posting group, the batch job finds all the VAT entries in the VAT Entry table that are included in the filters in the definition window.';
                }
            }
            group(Create)
            {
                Caption = 'Create';
                action("C&reate Reminders")
                {
                    ApplicationArea = Suite;
                    Caption = 'C&reate Reminders';
                    Ellipsis = true;
                    Image = CreateReminders;
                    RunObject = Report "Create Reminders";
                    ToolTip = 'Create reminders for one or more customers with overdue payments.';
                }
                action("Create Finance Charge &Memos")
                {
                    ApplicationArea = Suite;
                    Caption = 'Create Finance Charge &Memos';
                    Ellipsis = true;
                    Image = CreateFinanceChargememo;
                    RunObject = Report "Create Finance Charge Memos";
                    ToolTip = 'Create finance charge memos for one or more customers with overdue payments.';
                }
            }
            group(Reports)
            {
                Caption = 'Reports';
                group("Financial Statements")
                {
                    Caption = 'Financial Statements';
                    Image = ReferenceData;
                    action("Balance Sheet")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Balance Sheet';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report "Balance Sheet";
                        ToolTip = 'View a report that shows your company''s assets, liabilities, and equity.';
                    }
                    action("Income Statement")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Income Statement';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report "Income Statement";
                        ToolTip = 'View a report that shows your company''s income and expenses.';
                    }
                    action("Statement of Cash Flows")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Statement of Cash Flows';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report "Statement of Cashflows";
                        ToolTip = 'View a financial statement that shows how changes in balance sheet accounts and income affect the company''s cash holdings, displayed for operating, investing, and financing activities respectively.';
                    }
                    action("Statement of Retained Earnings")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Statement of Retained Earnings';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report "Retained Earnings Statement";
                        ToolTip = 'View a report that shows your company''s changes in retained earnings for a specified period by reconciling the beginning and ending retained earnings for the period, using information such as net income from the other financial statements.';
                    }
                }
                group("Excel Reports")
                {
                    Caption = 'Excel Reports';
                    Image = Excel;
                    action(ExcelTemplatesBalanceSheet)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Balance Sheet';
                        Image = "Report";
                        RunObject = Codeunit "Run Template Balance Sheet";
                        ToolTip = 'Open a spreadsheet that shows your company''s assets, liabilities, and equity.';
                    }
                    action(ExcelTemplateIncomeStmt)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Income Statement';
                        Image = "Report";
                        RunObject = Codeunit "Run Template Income Stmt.";
                        ToolTip = 'Open a spreadsheet that shows your company''s income and expenses.';
                    }
                    action(ExcelTemplateCashFlowStmt)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Cash Flow Statement';
                        Image = "Report";
                        RunObject = Codeunit "Run Template CashFlow Stmt.";
                        ToolTip = 'Open a spreadsheet that shows how changes in balance sheet accounts and income affect the company''s cash holdings.';
                    }
                    action(ExcelTemplateRetainedEarn)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Retained Earnings Statement';
                        Image = "Report";
                        RunObject = Codeunit "Run Template Retained Earn.";
                        ToolTip = 'Open a spreadsheet that shows your company''s changes in retained earnings based on net income from the other financial statements.';
                    }
                    action(ExcelTemplateTrialBalance)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Trial Balance';
                        Image = "Report";
                        RunObject = Codeunit "Run Template Trial Balance";
                        ToolTip = 'Open a spreadsheet that shows a summary trial balance by account.';
                    }
                    action(ExcelTemplateAgedAccPay)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Aged Accounts Payable';
                        Image = "Report";
                        RunObject = Codeunit "Run Template Aged Acc. Pay.";
                        ToolTip = 'Open a spreadsheet that shows a list of aged remaining balances for each vendor by period.';
                    }
                    action(ExcelTemplateAgedAccRec)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Aged Accounts Receivable';
                        Image = "Report";
                        RunObject = Codeunit "Run Template Aged Acc. Rec.";
                        ToolTip = 'Open a spreadsheet that shows when customer payments are due or overdue by period.';
                    }
                }
                action("Run Consolidation")
                {
                    ApplicationArea = Suite;
                    Caption = 'Run Consolidation';
                    Ellipsis = true;
                    Image = ImportDatabase;
                    RunObject = Report "Import Consolidation from DB";
                    ToolTip = 'Run the Consolidation report.';
                }
            }
#if not CLEAN19
            group(Setup)
            {
                Caption = 'Setup';
                Visible = false;
                ObsoleteState = Pending;
                ObsoleteReason = 'Setup is no longer shown in this page.';
                ObsoleteTag = '19.0';

                action(Action112)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Assisted Setup';
                    Image = QuestionaireSetup;
                    RunObject = Page "Assisted Setup";
                    ToolTip = 'Set up core functionality such as sales tax, sending documents as email, and approval workflow by running through a few pages that guide you through the information.';
                    ObsoleteState = Pending;
                    ObsoleteReason = 'Setup is no longer shown in this page.';
                    ObsoleteTag = '19.0';
                }
                action("General &Ledger Setup")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'General &Ledger Setup';
                    Image = Setup;
                    RunObject = Page "General Ledger Setup";
                    ToolTip = 'Define your general accounting policies, such as the allowed posting period and how payments are processed. Set up your default dimensions for financial analysis.';
                    ObsoleteState = Pending;
                    ObsoleteReason = 'Setup is no longer shown in this page.';
                    ObsoleteTag = '19.0';
                }
                action("&Sales && Receivables Setup")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = '&Sales && Receivables Setup';
                    Image = Setup;
                    RunObject = Page "Sales & Receivables Setup";
                    ToolTip = 'Define your general policies for sales invoicing and returns, such as when to show credit and stockout warnings and how to post sales discounts. Set up your number series for creating customers and different sales documents.';
                    ObsoleteState = Pending;
                    ObsoleteReason = 'Setup is no longer shown in this page.';
                    ObsoleteTag = '19.0';
                }
                action("&Purchases && Payables Setup")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = '&Purchases && Payables Setup';
                    Image = Setup;
                    RunObject = Page "Purchases & Payables Setup";
                    ToolTip = 'Define your general policies for purchase invoicing and returns, such as whether to require vendor invoice numbers and how to post purchase discounts. Set up your number series for creating vendors and different purchase documents.';
                    ObsoleteState = Pending;
                    ObsoleteReason = 'Setup is no longer shown in this page.';
                    ObsoleteTag = '19.0';
                }
                action("&Fixed Asset Setup")
                {
                    ApplicationArea = FixedAssets;
                    Caption = '&Fixed Asset Setup';
                    Image = Setup;
                    RunObject = Page "Fixed Asset Setup";
                    ToolTip = 'Define your accounting policies for fixed assets, such as the allowed posting period and whether to allow posting to main assets. Set up your number series for creating new fixed assets.';
                    ObsoleteState = Pending;
                    ObsoleteReason = 'Setup is no longer shown in this page.';
                    ObsoleteTag = '19.0';
                }
                action("Cash Flow Setup")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cash Flow Setup';
                    Image = CashFlowSetup;
                    RunObject = Page "Cash Flow Setup";
                    ToolTip = 'Set up the accounts where cash flow figures for sales, purchase, and fixed-asset transactions are stored.';
                    ObsoleteState = Pending;
                    ObsoleteReason = 'Setup is no longer shown in this page.';
                    ObsoleteTag = '19.0';
                }
                action("Cost Accounting Setup")
                {
                    ApplicationArea = all;
                    Caption = 'Cost Accounting Setup';
                    Image = allSetup;
                    RunObject = Page "Cost Accounting Setup";
                    ToolTip = 'Specify how you transfer general ledger entries to cost accounting, how you link dimensions to cost centers and cost objects, and how you handle the allocation ID and allocation document number.';
                    ObsoleteState = Pending;
                    ObsoleteReason = 'Setup is no longer shown in this page.';
                    ObsoleteTag = '19.0';
                }
                action("Business Units")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Business Units';
                    Image = Setup;
                    RunObject = Page "Business Unit List";
                    ToolTip = 'Set up Business Units that you need to consolidate into this company.';
                    ObsoleteState = Pending;
                    ObsoleteReason = 'Setup is no longer shown in this page.';
                    ObsoleteTag = '19.0';
                }
            }
#endif
            group(History)
            {
                Caption = 'History';
                action("Navi&gate")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Find entries...';
                    Image = Navigate;
                    RunObject = Page Navigate;
                    ShortCutKey = 'Shift+Ctrl+I';
                    ToolTip = 'Find entries and documents that exist for the document number and posting date on the selected document. (Formerly this action was named Navigate.)';
                }
            }
            group("Load Disbursement")
            {
                Caption = 'Loan disbursement';
                action("Loan disbursement batch list")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Loan disbursement batch list';
                    Image = Navigate;
                    RunObject = Page "Loans Disbursment Batch List";

                }
            }
            group("Sacco Transfer")
            {
                caption = 'Sacco Transfer';
                action("Sacco Transfer List")
                {
                    Applicationarea = basic, suite;
                    Caption = 'Open Sacco Transfer List';
                    Image = Payment;
                    RunObject = page "Internal Transfer List.";
                }

                action("POsted Sacco Transfers")
                {
                    Caption = 'Posted Sacco Transfers';
                    ApplicationArea = basic, suite;
                    Image = PostedPayment;
                    RunObject = page "Posted Internal Transfer List.";
                }

            }
        }
    }
}

