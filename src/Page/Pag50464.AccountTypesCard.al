#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50464 "Account Types Card"
{
    Editable = true;
    PageType = Card;
    SourceTable = "Account Types-Saving Products";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Code"; Code)
                {
                    ApplicationArea = Basic;
                }
                field("Activity Code"; "Activity Code")
                {
                    ApplicationArea = Basic;
                }
                field(Description; Description)
                {
                    ApplicationArea = Basic;
                }
                field("Account No Prefix"; "Account No Prefix")
                {
                    ApplicationArea = Basic;
                    Caption = 'Account No Prefix';
                }
                field(Branch; Branch)
                {
                    ApplicationArea = Basic;
                    Caption = 'Branch';
                }
                field("Product Code"; "Product Code")
                {
                    ApplicationArea = Basic;
                }
                field("Last No Used"; "Last No Used")
                {
                    ApplicationArea = Basic;
                }
                field("SMS Description"; "SMS Description")
                {
                    ApplicationArea = Basic;
                }
                field("Posting Group"; "Posting Group")
                {
                    ApplicationArea = Basic;
                    Caption = 'Posting Group';
                }
                field("Dormancy Period (M)"; "Dormancy Period (M)")
                {
                    ApplicationArea = Basic;
                }
                field("Dormancy Period (-M)"; "Dormancy Period (-M)")
                {
                    ApplicationArea = Basic;
                }
                field("Withdrawal Interval"; "Withdrawal Interval")
                {
                    ApplicationArea = Basic;
                }
                field("Withdrawal Penalty"; "Withdrawal Penalty")
                {
                    ApplicationArea = Basic;
                }
                field("Withdrawal Interval Account"; "Withdrawal Interval Account")
                {
                    ApplicationArea = Basic;
                }
                field("Requires Opening Deposit"; "Requires Opening Deposit")
                {
                    ApplicationArea = Basic;
                }
                field("Allow Loan Applications"; "Allow Loan Applications")
                {
                    ApplicationArea = Basic;
                }
                field("Use Savings Account Number"; "Use Savings Account Number")
                {
                    ApplicationArea = Basic;
                }
                field("Fixed Deposit"; "Fixed Deposit")
                {
                    ApplicationArea = Basic;
                }
                field("Minimum Balance"; "Minimum Balance")
                {
                    ApplicationArea = Basic;
                }
                field("Bulk Withdrawal Amount"; "Bulk Withdrawal Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Standing Orders Suspense"; "Standing Orders Suspense")
                {
                    ApplicationArea = Basic;
                }
                field("Bankers Cheque Account"; "Bankers Cheque Account")
                {
                    ApplicationArea = Basic;
                }
                field("Maximum Withdrawal Amount"; "Maximum Withdrawal Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Maximum Allowable Deposit"; "Maximum Allowable Deposit")
                {
                    ApplicationArea = Basic;
                }
                field("Check Off Recovery"; "Check Off Recovery")
                {
                    ApplicationArea = Basic;
                }
                field("Recovery Priority"; "Recovery Priority")
                {
                    ApplicationArea = Basic;
                }
                field("Use Graduated Charges"; "Use Graduated Charges")
                {
                    ApplicationArea = Basic;
                }
                field("Default Account"; "Default Account")
                {
                    ApplicationArea = Basic;
                }
                field("Maximum No Of Accounts"; "Maximum No Of Accounts")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specify the maximum no of accounts a member can have for this product';
                }
                field("Individual Account"; "Individual Account")
                {
                    ApplicationArea = Basic;
                }
                field("Corporate Account"; "Corporate Account")
                {
                    ApplicationArea = Basic;
                }
                field("Over Draft Account"; "Over Draft Account")
                {
                    ApplicationArea = Basic;
                }
                field("Maximum Overdraft Period"; "Maximum Overdraft Period")
                {
                    ApplicationArea = Basic;
                }
                field("Default Piggy Bank Issuance"; "Default Piggy Bank Issuance")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Interest Computation")
            {
                Caption = 'Interest Computation';
                field("Earns Interest"; "Earns Interest")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        InterestVisible := false;

                        if "Earns Interest" = true then
                            InterestVisible := true;
                    end;
                }
                field("Interest Calc Min Balance"; "Interest Calc Min Balance")
                {
                    ApplicationArea = Basic;
                    Caption = 'Interest Min. Balance';
                }
                field("Minimum Interest Period (M)"; "Minimum Interest Period (M)")
                {
                    ApplicationArea = Basic;
                }
                field("Tax On Interest"; "Tax On Interest")
                {
                    ApplicationArea = Basic;
                }
                field("Account Openning Fee"; "Account Openning Fee")
                {
                    ApplicationArea = Basic;
                    Caption = 'Account Openning Deposit';
                }
                field("Re-activation Fee"; "Re-activation Fee")
                {
                    ApplicationArea = Basic;
                }
                field("Requires Closure Notice"; "Requires Closure Notice")
                {
                    ApplicationArea = Basic;
                }
                field("Closure Notice Period"; "Closure Notice Period")
                {
                    ApplicationArea = Basic;
                }
                field("Closing Charge"; "Closing Charge")
                {
                    ApplicationArea = Basic;
                }
                field("Closing Prior Notice Charge"; "Closing Prior Notice Charge")
                {
                    ApplicationArea = Basic;
                }
                field("Min Bal. Calc Frequency"; "Min Bal. Calc Frequency")
                {
                    ApplicationArea = Basic;
                }
                field("Fee Below Minimum Balance"; "Fee Below Minimum Balance")
                {
                    ApplicationArea = Basic;
                }
                field("Over Draft Interest Rate"; "Over Draft Interest Rate")
                {
                    ApplicationArea = Basic;
                }
                field("Over Draft Interest Account"; "Over Draft Interest Account")
                {
                    ApplicationArea = Basic;
                }
                field("Overdraft Charge"; "Overdraft Charge")
                {
                    ApplicationArea = Basic;
                }
                field("Authorised Ovedraft Charge"; "Authorised Ovedraft Charge")
                {
                    ApplicationArea = Basic;
                }
                field("Service Charge"; "Service Charge")
                {
                    ApplicationArea = Basic;
                }
                field("Maintenence Fee"; "Maintenence Fee")
                {
                    ApplicationArea = Basic;
                }
                field("External EFT Charges"; "External EFT Charges")
                {
                    ApplicationArea = Basic;
                }
                field("Internal EFT Charges"; "Internal EFT Charges")
                {
                    ApplicationArea = Basic;
                }
                field("RTGS Charges"; "RTGS Charges")
                {
                    ApplicationArea = Basic;
                }
                field("Statement Charge"; "Statement Charge")
                {
                    ApplicationArea = Basic;
                }
                field("New Piggy Bank Fee"; "New Piggy Bank Fee")
                {
                    ApplicationArea = Basic;
                }
                field("Additional Piggy Bank Fee"; "Additional Piggy Bank Fee")
                {
                    ApplicationArea = Basic;
                }
                field("Savings Duration"; "Savings Duration")
                {
                    ApplicationArea = Basic;
                }
                field("Savings Withdrawal penalty"; "Savings Withdrawal penalty")
                {
                    ApplicationArea = Basic;
                }
                field("Term terminatination fee"; "Term terminatination fee")
                {
                    ApplicationArea = Basic;
                }
                field("FOSA Shares"; "FOSA Shares")
                {
                    ApplicationArea = Basic;
                }
                field("Account Type"; "Account Type")
                {
                    ApplicationArea = all;

                }
            }
            part(Control3; "Account Types Interest Rates")
            {
                SubPageLink = "Account Type" = field(Code);
                Visible = InterestVisible;
            }
            group("Fees & Comissions Accounts")
            {
                Caption = 'Fees & Comissions Accounts';
                field("Interest Expense Account"; "Interest Expense Account")
                {
                    ApplicationArea = Basic;
                }
                field("Interest Payable Account"; "Interest Payable Account")
                {
                    ApplicationArea = Basic;
                }
                field("Interest Forfeited Account"; "Interest Forfeited Account")
                {
                    ApplicationArea = Basic;
                }
                field("Interest Tax Account"; "Interest Tax Account")
                {
                    ApplicationArea = Basic;
                }
                field("Account Openning Fee Account"; "Account Openning Fee Account")
                {
                    ApplicationArea = Basic;
                }
                field("Re-activation Fee Account"; "Re-activation Fee Account")
                {
                    ApplicationArea = Basic;
                }
                field("Fee bellow Min. Bal. Account"; "Fee bellow Min. Bal. Account")
                {
                    ApplicationArea = Basic;
                }
                field("EFT Charges Account"; "EFT Charges Account")
                {
                    ApplicationArea = Basic;
                }
                field("RTGS Charges Account"; "RTGS Charges Account")
                {
                    ApplicationArea = Basic;
                }
                field("Savings Penalty Account"; "Savings Penalty Account")
                {
                    ApplicationArea = Basic;
                }
                field("Term Termination Account"; "Term Termination Account")
                {
                    ApplicationArea = Basic;
                }
                field("Piggy Bank Fee Account"; "Piggy Bank Fee Account")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetCurrRecord()
    begin
        InterestVisible := false;

        if "Earns Interest" = true then
            InterestVisible := true;
    end;

    trigger OnAfterGetRecord()
    begin
        InterestVisible := false;

        if "Earns Interest" = true then
            InterestVisible := true;
    end;

    var
        InterestVisible: Boolean;
}

