#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50411 "Sacco General Set-Up"
{
    PageType = Card;
    SourceTable = "Sacco General Set-Up";
    UsageCategory = Administration;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General Setup';
                field("Min. Member Age"; "Min. Member Age")
                {
                    ApplicationArea = Basic;
                }
                field("Retirement Age"; "Retirement Age")
                {
                    ApplicationArea = Basic;
                }
                field("Min. Contribution"; "Min. Contribution")
                {
                    ApplicationArea = Basic;
                    Caption = 'Individual Minimum Monthly Contributions';
                }
                field("Benevolent Fund Contribution"; "Benevolent Fund Contribution")
                {
                    ApplicationArea = Basic;
                    Caption = 'Benevolent Fund Contibution';
                }
                field("Corporate Minimum Monthly Cont"; "Corporate Minimum Monthly Cont")
                {
                    ApplicationArea = Basic;
                    Caption = 'Corporate Minimum Monthly Contributions';
                }
                field("Retained Shares"; "Retained Shares")
                {
                    ApplicationArea = Basic;
                    Caption = 'Share Capital Amount';
                }
                field("FOSA Shares Amount"; "FOSA Shares Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Min Deposit Cont.(% of Basic)"; "Min Deposit Cont.(% of Basic)")
                {
                    ApplicationArea = Basic;
                }
                field("Minimum Take home"; "Minimum Take home")
                {
                    ApplicationArea = Basic;
                }
                field("Minimum take home FOSA"; "Minimum take home FOSA")
                {
                    ApplicationArea = Basic;
                }
                field("Max. Non Contribution Periods"; "Max. Non Contribution Periods")
                {
                    ApplicationArea = Basic;
                }
                field("Dormancy Period"; "Dormancy Period")
                {
                    ApplicationArea = Basic;
                }
                field("Min. Loan Application Period"; "Min. Loan Application Period")
                {
                    ApplicationArea = Basic;
                }
                field("Bank Statement Period"; "Bank Statement Period")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loan Appraisal Statement Period';
                }
                field("Maximum No of Guarantees"; "Maximum No of Guarantees")
                {
                    ApplicationArea = Basic;
                }
                field("Min. Guarantors"; "Min. Guarantors")
                {
                    ApplicationArea = Basic;
                }
                field("Max. Guarantors"; "Max. Guarantors")
                {
                    ApplicationArea = Basic;
                }
                field("Member Can Guarantee Own Loan"; "Member Can Guarantee Own Loan")
                {
                    ApplicationArea = Basic;
                }
                field("Self Guarantee Multiplier"; "Self Guarantee Multiplier")
                {
                    ApplicationArea = Basic;
                }
                field("Dividend (%)"; "Dividend (%)")
                {
                    ApplicationArea = Basic;
                }
                field("Interest on Deposits (%)"; "Interest on Deposits (%)")
                {
                    ApplicationArea = Basic;
                }
                field("Min. Dividend Proc. Period"; "Min. Dividend Proc. Period")
                {
                    ApplicationArea = Basic;
                }
                field("Div Capitalization Min_Indiv"; "Div Capitalization Min_Indiv")
                {
                    ApplicationArea = Basic;
                    Caption = 'Dividend Capitalization Minimum Deposit_Individula';
                    ToolTip = 'Less this Deposits the System will capitalize part of your dividend based on the Dividend Capitalization %';
                }
                field("Div Capitalization Min_Corp"; "Div Capitalization Min_Corp")
                {
                    ApplicationArea = Basic;
                    Caption = 'Dividend Capitalization Minimum Deposit_Corporate Account';
                    ToolTip = 'Less this Deposits the System will capitalize part of your dividend based on the Dividend Capitalization %';
                }
                field("Div Capitalization %"; "Div Capitalization %")
                {
                    ApplicationArea = Basic;
                    Caption = 'Dividend Capitalization %';
                }
                field("Days for Checkoff"; "Days for Checkoff")
                {
                    ApplicationArea = Basic;
                }
                field("Boosting Shares Maturity (M)"; "Boosting Shares Maturity (M)")
                {
                    ApplicationArea = Basic;
                }
                field("Contactual Shares (%)"; "Contactual Shares (%)")
                {
                    ApplicationArea = Basic;
                }
                field("Use Bands"; "Use Bands")
                {
                    ApplicationArea = Basic;
                }
                field("Max. Contactual Shares"; "Max. Contactual Shares")
                {
                    ApplicationArea = Basic;
                }
                field("Withholding Tax (%)"; "Withholding Tax (%)")
                {
                    ApplicationArea = Basic;
                }
                field("Welfare Contribution"; "Welfare Contribution")
                {
                    ApplicationArea = Basic;
                    Caption = 'Insurance Contribution';
                }
                field("ATM Expiry Duration"; "ATM Expiry Duration")
                {
                    ApplicationArea = Basic;
                }
                field("Monthly Share Contributions"; "Monthly Share Contributions")
                {
                    ApplicationArea = Basic;
                }
                field("Risk Fund Amount"; "Risk Fund Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Deceased Cust Dep Multiplier"; "Deceased Cust Dep Multiplier")
                {
                    ApplicationArea = Basic;
                    Caption = 'Deposit Refund Multiplier-Death';
                }
                field("Begin Of Month"; "Begin Of Month")
                {
                    ApplicationArea = Basic;
                }
                field("End Of Month"; "End Of Month")
                {
                    ApplicationArea = Basic;
                }
                field("E-Loan Qualification (%)"; "E-Loan Qualification (%)")
                {
                    ApplicationArea = Basic;
                }
                field("Charge FOSA Registration Fee"; "Charge FOSA Registration Fee")
                {
                    ApplicationArea = Basic;
                }
                field("Charge BOSA Registration Fee"; "Charge BOSA Registration Fee")
                {
                    ApplicationArea = Basic;
                }
                field("Defaulter LN"; "Defaulter LN")
                {
                    ApplicationArea = Basic;
                }
                field("Last Transaction Duration"; "Last Transaction Duration")
                {
                    ApplicationArea = Basic;
                }
                field("Branch Code No"; "Branch Code No")
                {
                    ApplicationArea = Basic;
                }
                field("Allowable Cheque Discounting %"; "Allowable Cheque Discounting %")
                {
                    ApplicationArea = Basic;
                }
                field("Sto max tolerance Days"; "Sto max tolerance Days")
                {
                    ApplicationArea = Basic;
                    Caption = 'Standing Order Maximum Tolerance Days';
                    ToolTip = 'Specify the Maximum No of  Days the Standing order should keep trying if the Member account has inserficient amount';
                }
                field("Dont Allow Sto Partial Ded."; "Dont Allow Sto Partial Ded.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Dont Allow Sto Partial Deduction';
                }
                field("Standing Order Bank"; "Standing Order Bank")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specify the Cash book account to be credit when a member places an External standing order';
                }
                field("ATM Destruction Period"; "ATM Destruction Period")
                {
                    ApplicationArea = Basic;
                }
                field("Go Live Date"; "Go Live Date")
                {
                    ApplicationArea = Basic;
                }
                field("Cheque Book Request Path"; "Cheque Book Request Path")
                {
                    ApplicationArea = Basic;
                }
                field("ATM Card Request Path"; "ATM Card Request Path")
                {
                    ApplicationArea = Basic;
                }
                field("Collateral Collection Period"; "Collateral Collection Period")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Amount Due Freeze Period"; "Loan Amount Due Freeze Period")
                {
                    ApplicationArea = Basic;
                }
                field(OnlineMemberMonthlyTransLimit; OnlineMemberMonthlyTransLimit)
                {
                    ApplicationArea = Basic;
                    Caption = 'Online Member Monthly Transaction Limit';
                }
                field("Referee Comm. Period"; "Referee Comm. Period")
                {
                    ApplicationArea = Basic;
                }
                field("Recruitment Commission"; "Recruitment Commission")
                {
                    ApplicationArea = Basic;
                }
                field("Recruitment Comm. Expense GL"; "Recruitment Comm. Expense GL")
                {
                    ApplicationArea = Basic;
                }
                field("Last Date of Checkoff Advice"; "Last Date of Checkoff Advice")
                {
                    ApplicationArea = Basic;
                }
                  field("Withdrwal Notice Period";"Withdrwal Notice Period")
                {
                    ApplicationArea = Basic;
                }
                field("Withdrawal Interest Penalty";"Withdrawal Interest Penalty")
                {
                    ApplicationArea = Basic;

                }

            }
            group("Fees & Commissions")
            {
                Caption = 'Fees & Commissions';
                field("Withdrawal Fee"; "Withdrawal Fee")
                {
                    ApplicationArea = Basic;
                    Caption = 'BOSA Account Closure Fee';
                }
                field("FOSA Registration Fee Amount"; "FOSA Registration Fee Amount")
                {
                    ApplicationArea = Basic;
                }
                field("BOSA Registration Fee Amount"; "BOSA Registration Fee Amount")
                {
                    ApplicationArea = Basic;
                    Caption = 'BOSA Registration Fee Individual';
                }
                field("BOSA Reg. Fee Corporate"; "BOSA Reg. Fee Corporate")
                {
                    ApplicationArea = Basic;
                    Caption = 'BOSA Registration Fee Corporate';
                }
                field("Rejoining Fee"; "Rejoining Fee")
                {
                    ApplicationArea = Basic;
                    Caption = 'BOSA Reinstatement Fee';
                }
                field("Boosting Shares %"; "Boosting Shares %")
                {
                    ApplicationArea = Basic;
                }
                field("Dividend Processing Fee"; "Dividend Processing Fee")
                {
                    ApplicationArea = Basic;
                }
                field("Top up Commission"; "Top up Commission")
                {
                    ApplicationArea = Basic;
                }
                field("Excise Duty(%)"; "Excise Duty(%)")
                {
                    ApplicationArea = Basic;
                }
                field("SMS Fee Amount"; "SMS Fee Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Risk Beneficiary (%)"; "Risk Beneficiary (%)")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Cash Clearing Fee(%)"; "Loan Cash Clearing Fee(%)")
                {
                    ApplicationArea = Basic;
                }
                field("Mpesa Withdrawal Fee"; "Mpesa Withdrawal Fee")
                {
                    ApplicationArea = Basic;
                }
                field("Share Transfer Fee %"; "Share Transfer Fee %")
                {
                    ApplicationArea = Basic;
                }
                field("Cheque Discounting Comission"; "Cheque Discounting Comission")
                {
                    ApplicationArea = Basic;
                }
                field("Funeral Expense Amount"; "Funeral Expense Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Share Capital Transfer Fee"; "Share Capital Transfer Fee")
                {
                    ApplicationArea = Basic;
                }
                field("Partial Deposit Refund Fee"; "Partial Deposit Refund Fee")
                {
                    ApplicationArea = Basic;
                }
                field("Penalty On Deposit Arrears"; "Penalty On Deposit Arrears")
                {
                    ApplicationArea = Basic;
                    Caption = 'Penalty on Failed Monthly Contribution';
                    ToolTip = 'Specify the Penalty Amount to Charge a Member who has not meet the minimum Monthly contribution';
                }
                field("ATM Card Fee-New Coop"; "ATM Card Fee-New Coop")
                {
                    ApplicationArea = Basic;
                }
                field("ATM Card Fee-New Sacco"; "ATM Card Fee-New Sacco")
                {
                    ApplicationArea = Basic;
                }
                field("ATM Card Fee-Replacement Coop"; "ATM Card Fee-Replacement Coop")
                {
                    ApplicationArea = Basic;
                }
                field("ATM Card Fee-Replacement SACCO"; "ATM Card Fee-Replacement SACCO")
                {
                    ApplicationArea = Basic;
                }
                field("ATM Card Renewal Fee Coop"; "ATM Card Renewal Fee Coop")
                {
                    ApplicationArea = Basic;
                }
                field("ATM Card Renewal Fee Sacco"; "ATM Card Renewal Fee Sacco")
                {
                    ApplicationArea = Basic;
                }
                field("CRB Check Charge"; "CRB Check Charge")
                {
                    ApplicationArea = Basic;
                }
                field("CRB Check Vendor Charge"; "CRB Check Vendor Charge")
                {
                    ApplicationArea = Basic;
                }
                field("Internal Transfer Fee"; "Internal Transfer Fee")
                {
                    ApplicationArea = Basic;
                }
                field("FB ATM Withdrawal Limit"; "FB ATM Withdrawal Limit")
                {
                    ApplicationArea = Basic;
                    Caption = 'Family Bank ATM Withdrawal Limit';
                }
            }
            group("Fees & Commissions Accounts")
            {
                Caption = 'Fees & Commissions Accounts';
                field("Withdrawal Fee Account"; "Withdrawal Fee Account")
                {
                    ApplicationArea = Basic;
                }
                field("FOSA Registration Fee Account"; "FOSA Registration Fee Account")
                {
                    ApplicationArea = Basic;
                }
                field("BOSA Registration Fee Account"; "BOSA Registration Fee Account")
                {
                    ApplicationArea = Basic;
                }
                field("Rejoining Fees Account"; "Rejoining Fees Account")
                {
                    ApplicationArea = Basic;
                }
                field("Insurance Retension Account"; "Insurance Retension Account")
                {
                    ApplicationArea = Basic;
                }
                field("WithHolding Tax Account"; "WithHolding Tax Account")
                {
                    ApplicationArea = Basic;
                    Caption = 'WithHolding Tax Account FOSA';
                }
                field("Withholding Tax Acc Dividend"; "Withholding Tax Acc Dividend")
                {
                    ApplicationArea = Basic;
                }
                field("Shares Retension Account"; "Shares Retension Account")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Transfer Fees Account"; "Loan Transfer Fees Account")
                {
                    ApplicationArea = Basic;
                }
                field("Boosting Fees Account"; "Boosting Fees Account")
                {
                    ApplicationArea = Basic;
                }
                field("Bridging Commision Account"; "Bridging Commision Account")
                {
                    ApplicationArea = Basic;
                }
                field("Funeral Expenses Account"; "Funeral Expenses Account")
                {
                    ApplicationArea = Basic;
                }
                field("Dividend Payable Account"; "Dividend Payable Account")
                {
                    ApplicationArea = Basic;
                }
                field("Dividend Process Fee Account"; "Dividend Process Fee Account")
                {
                    ApplicationArea = Basic;
                    Caption = 'Dividend Processing Fee Account';
                }
                field("Excise Duty Account"; "Excise Duty Account")
                {
                    ApplicationArea = Basic;
                }
                field("SMS Fee Account"; "SMS Fee Account")
                {
                    ApplicationArea = Basic;
                }
                field("Cheque Discounting Fee Account"; "Cheque Discounting Fee Account")
                {
                    ApplicationArea = Basic;
                }
                field("Deposit Refund On DeathAccount"; "Deposit Refund On DeathAccount")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Attachment Comm. Account"; "Loan Attachment Comm. Account")
                {
                    ApplicationArea = Basic;
                }
                field("Share Capital Transfer Fee Acc"; "Share Capital Transfer Fee Acc")
                {
                    ApplicationArea = Basic;
                }
                field("Partial Deposit Refund Fee A/C"; "Partial Deposit Refund Fee A/C")
                {
                    ApplicationArea = Basic;
                }
                field("Penalty On Deposit Arrears A/C"; "Penalty On Deposit Arrears A/C")
                {
                    ApplicationArea = Basic;
                    Caption = 'Penalty On Failed Monthly Contr. Account';
                }
                field("CRB Vendor Account"; "CRB Vendor Account")
                {
                    ApplicationArea = Basic;
                }
                field("CRB Check SACCO income A/C"; "CRB Check SACCO income A/C")
                {
                    ApplicationArea = Basic;
                }
                field("Benevolent Fund Account"; "Benevolent Fund Account")
                {
                    ApplicationArea = Basic;
                }
                field("ATM Card Co-op Bank Account"; "ATM Card Co-op Bank Account")
                {
                    ApplicationArea = Basic;
                }
                field("ATM Card Income Account"; "ATM Card Income Account")
                {
                    ApplicationArea = Basic;
                }
                field("Cheque Processing Fee Account"; "Cheque Processing Fee Account")
                {
                    ApplicationArea = Basic;
                }
                field("Cheque Clearing Family Income"; "Cheque Clearing Family Income")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cheque Clearing Family Income Control';
                }
                field("Unpaid Cheques Fee Account"; "Unpaid Cheques Fee Account")
                {
                    ApplicationArea = Basic;
                }
                field("Internal Transfer Fee Account"; "Internal Transfer Fee Account")
                {
                    ApplicationArea = Basic;
                }
                field("Paybill Suspense Account"; "Paybill Suspense Account")
                {
                    ApplicationArea = Basic;
                }
                field("Internal PV Control Account"; "Internal PV Control Account")
                {
                    ApplicationArea = Basic;
                }
                field("New Piggy Bank Debit G/L"; "New Piggy Bank Debit G/L")
                {
                    ApplicationArea = Basic;
                }
                field("New Piggy Bank Credit G/L"; "New Piggy Bank Credit G/L")
                {
                    ApplicationArea = Basic;
                }
            }
            group("SMS Notifications")
            {
                field("Send Membership App SMS"; "Send Membership App SMS")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send Membership Application SMS';
                }
                field("Send Membership Reg SMS"; "Send Membership Reg SMS")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send Membership Registration SMS';
                }
                field("Send Loan App SMS"; "Send Loan App SMS")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send Loan Application SMS';
                }
                field("Send Loan Disbursement SMS"; "Send Loan Disbursement SMS")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send Loan Disbursement SMS';
                }
                field("Send Guarantorship SMS"; "Send Guarantorship SMS")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send Guarantorship SMS';
                }
                field("Send Membership Withdrawal SMS"; "Send Membership Withdrawal SMS")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send Membership Withdrawal SMS';
                }
                field("Send ATM Withdrawal SMS"; "Send ATM Withdrawal SMS")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send ATM Withdrawal SMS';
                }
                field("Send Cash Withdrawal SMS"; "Send Cash Withdrawal SMS")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send Cash Withdrawal SMS';
                }
                field("SMS Alert Fees"; "SMS Alert Fees")
                {
                    ApplicationArea = Basic;
                    Caption = 'SMS Alert Fees';
                }
                field("SMS Alert Fee Account"; "SMS Alert Fee Account")
                {
                    ApplicationArea = Basic;
                }
                field("Active SMS Service Provider"; "Active SMS Service Provider")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Email Notifications")
            {
                field("Send Membership App Email"; "Send Membership App Email")
                {
                    ApplicationArea = Basic;
                }
                field("Send Membership Reg Email"; "Send Membership Reg Email")
                {
                    ApplicationArea = Basic;
                }
                field("Send Loan App Email"; "Send Loan App Email")
                {
                    ApplicationArea = Basic;
                }
                field("Send Loan Disbursement Email"; "Send Loan Disbursement Email")
                {
                    ApplicationArea = Basic;
                }
                field("Send Guarantorship Email"; "Send Guarantorship Email")
                {
                    ApplicationArea = Basic;
                }
                field("Send Membship Withdrawal Email"; "Send Membship Withdrawal Email")
                {
                    ApplicationArea = Basic;
                }
                field("Send ATM Withdrawal Email"; "Send ATM Withdrawal Email")
                {
                    ApplicationArea = Basic;
                }
                field("Send Cash Withdrawal Email"; "Send Cash Withdrawal Email")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Departmental Emails")
            {
                field("Credit Department E-mail"; "Credit Department E-mail")
                {
                    ApplicationArea = Basic;
                }
                field("Operations Department E-mail"; "Operations Department E-mail")
                {
                    ApplicationArea = Basic;
                }
                field("Finance Department E-mail"; "Finance Department E-mail")
                {
                    ApplicationArea = Basic;
                }
                field("BD Department E-mail"; "BD Department E-mail")
                {
                    ApplicationArea = Basic;
                }
                field("IT Department E-mail"; "IT Department E-mail")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Demand Notice Period")
            {
                field("1st Demand Notice Days"; "1st Demand Notice Days")
                {
                    ApplicationArea = Basic;
                }
                field("2nd Demand Notice Days"; "2nd Demand Notice Days")
                {
                    ApplicationArea = Basic;
                }
                field("CRB Notice Days"; "CRB Notice Days")
                {
                    ApplicationArea = Basic;
                }
                field("Group Leaders Notice Days"; "Group Leaders Notice Days")
                {
                    ApplicationArea = Basic;
                }
                field("Auctioneer Notice Days"; "Auctioneer Notice Days")
                {
                    ApplicationArea = Basic;
                }
                field("Member Notice Days"; "Member Notice Days")
                {
                    ApplicationArea = Basic;
                }
                field("Repetitive SMS Frequency Days"; "Repetitive SMS Frequency Days")
                {
                    ApplicationArea = Basic;
                }
                field("Group Members Notice Days"; "Group Members Notice Days")
                {
                    ApplicationArea = Basic;
                }
                field("Mobile Loan CRB Notice Days"; "Mobile Loan CRB Notice Days")
                {
                    ApplicationArea = Basic;
                }
            }
            group("SASRA Required Provisions")
            {
                Caption = 'SASRA Required Provision %';
                field("Performing Required Provision%"; "Performing Required Provision%")
                {
                    ApplicationArea = Basic;
                    Caption = 'Performing';
                }
                field("Watch Required Provision%"; "Watch Required Provision%")
                {
                    ApplicationArea = Basic;
                    Caption = 'Watch';
                }
                field("Substandar Required Provision%"; "Substandar Required Provision%")
                {
                    ApplicationArea = Basic;
                    Caption = 'Substandard';
                }
                field("Doubtful Required Provision%"; "Doubtful Required Provision%")
                {
                    ApplicationArea = Basic;
                    Caption = 'Doubtful';
                }
                field("Loss Required Provision%"; "Loss Required Provision%")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loss';
                }
            }
            group("Default Posting Groups")
            {
                field("Default Customer Posting Group"; "Default Customer Posting Group")
                {
                    ApplicationArea = Basic;
                }
                field("Default Micro Credit Posting G"; "Default Micro Credit Posting G")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Shares Bands")
            {
                Caption = 'Shares Bands';
            }
        }
        area(processing)
        {
            action("Reset Data Sheet")
            {
                ApplicationArea = Basic;
                Caption = 'Reset Data Sheet';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Cust.Reset;
                    Cust.SetRange(Cust."Customer Type", Cust."customer type"::Member);
                    if Cust.Find('-') then
                        Cust.ModifyAll(Cust.Advice, false);


                    Loans.Reset;
                    Loans.SetRange(Loans.Source, Loans.Source::" ");
                    if Loans.Find('-') then
                        Loans.ModifyAll(Loans.Advice, false);


                    Message('Reset Completed successfully.');
                end;
            }
        }
    }

    var
        Cust: Record Customer;
        Loans: Record "Loans Register";
}

