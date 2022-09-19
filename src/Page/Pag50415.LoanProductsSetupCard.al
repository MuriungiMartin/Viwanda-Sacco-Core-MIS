#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50415 "Loan Products Setup Card"
{
    DeleteAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = "Loan Products Setup";

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
                field("Product Description"; "Product Description")
                {
                    ApplicationArea = Basic;
                }
                field(Source; Source)
                {
                    ApplicationArea = Basic;
                }
                field("Minimum Interest Rate"; "Minimum Interest Rate")
                {
                    ApplicationArea = Basic;
                }
                field("Maximum Interest Rate"; "Maximum Interest Rate")
                {
                    ApplicationArea = Basic;
                }
                field("Interest rate"; "Interest rate")
                {
                    ApplicationArea = Basic;
                    Caption = 'Default Interest Rate';
                }
                field("Repayment Method"; "Repayment Method")
                {
                    ApplicationArea = Basic;
                }
                field("Grace Period - Principle (M)"; "Grace Period - Principle (M)")
                {
                    ApplicationArea = Basic;
                }
                field("Grace Period - Interest (M)"; "Grace Period - Interest (M)")
                {
                    ApplicationArea = Basic;
                }
                field("Instalment Period"; "Instalment Period")
                {
                    ApplicationArea = Basic;
                }
                field("No of Installment"; "No of Installment")
                {
                    ApplicationArea = Basic;
                }
                field("Default Installements"; "Default Installements")
                {
                    ApplicationArea = Basic;
                }
                field("Penalty Calculation Days"; "Penalty Calculation Days")
                {
                    ApplicationArea = Basic;
                }
                field("Penalty Percentage"; "Penalty Percentage")
                {
                    ApplicationArea = Basic;
                }
                field("Recovery Priority"; "Recovery Priority")
                {
                    ApplicationArea = Basic;
                }
                field("Min No. Of Guarantors"; "Min No. Of Guarantors")
                {
                    ApplicationArea = Basic;
                }
                field("Min Re-application Period"; "Min Re-application Period")
                {
                    ApplicationArea = Basic;
                }
                field("Deposits Multiplier (KIE)"; "Deposits Multiplier (KIE)")
                {
                    ApplicationArea = Basic;
                    Caption = 'Deposits Multiplier';
                }
                field("Deposit Multiplier(IND)"; "Deposit Multiplier(IND)")
                {
                    ApplicationArea = Basic;
                }
                field("Penalty Calculation Method"; "Penalty Calculation Method")
                {
                    ApplicationArea = Basic;
                }
                field("Self guaranteed Multiplier"; "Self guaranteed Multiplier")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Product Expiry Date"; "Loan Product Expiry Date")
                {
                    ApplicationArea = Basic;
                }
                field("Maximum No of Active Loans"; "Maximum No of Active Loans")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specify the Maximum No of Active Loans a Member can have on this Product';
                }
                field("Min. Loan Amount"; "Min. Loan Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Max. Loan Amount"; "Max. Loan Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Check Off Recovery"; "Check Off Recovery")
                {
                    ApplicationArea = Basic;
                }
                field("Allowable Loan Offset(%)"; "Allowable Loan Offset(%)")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("TOPUp Qualification %"; "TOPUp Qualification %")
                {
                    ApplicationArea = Basic;
                }
                field("TOPUp 1 Qualification %"; "TOPUp 1 Qualification %")
                {
                    ApplicationArea = Basic;
                }
                field("Top Up Commision"; "Top Up Commision")
                {
                    ApplicationArea = Basic;
                    Caption = 'Top Up Interest';
                }
                field("Loan Boosting Commission %"; "Loan Boosting Commission %")
                {
                    ApplicationArea = Basic;
                }
                field("Topup1_Super Plus offset Comm%"; "Topup1_Super Plus offset Comm%")
                {
                    ApplicationArea = Basic;
                }
                field("Loan PayOff Fee(%)"; "Loan PayOff Fee(%)")
                {
                    ApplicationArea = Basic;
                }
                field("Repayment Frequency"; "Repayment Frequency")
                {
                    ApplicationArea = Basic;
                }
                field("Dont Recover Repayment"; "Dont Recover Repayment")
                {
                    ApplicationArea = Basic;
                }
                field("Special Code"; "Special Code")
                {
                    ApplicationArea = Basic;
                }
                field("Is Staff Loan"; "Is Staff Loan")
                {
                    ApplicationArea = Basic;
                }
                field("Recovery Method"; "Recovery Method")
                {
                    ApplicationArea = Basic;
                }
                field(Deductible; Deductible)
                {
                    ApplicationArea = Basic;
                }
                field("Qualification for Saver(%)"; "Qualification for Saver(%)")
                {
                    ApplicationArea = Basic;
                }
                field("Amortization Interest Rate(SI)"; "Amortization Interest Rate(SI)")
                {
                    ApplicationArea = Basic;
                    Caption = 'Amortization Interest Rate(Sacco Interest)';
                }
                field("Accrue Total Insurance&Interes"; "Accrue Total Insurance&Interes")
                {
                    ApplicationArea = Basic;
                    Caption = 'Accrue Total Insurance & Interest on Disburesment';
                }
                field("Minimum Deposit For Loan Appl"; "Minimum Deposit For Loan Appl")
                {
                    ApplicationArea = Basic;
                }
                field("FOSA Loan Shares Ratio"; "FOSA Loan Shares Ratio")
                {
                    ApplicationArea = Basic;
                    Caption = 'FOSA Loan Shares Ratio';
                    ToolTip = 'Specify the % of Deposits to Qualify For';
                }
                field("OneOff  Loan Repayment"; "OneOff  Loan Repayment")
                {
                    ApplicationArea = Basic;
                }
                field("Charge Interest Upfront"; "Charge Interest Upfront")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Qualification Criteria")
            {
                Caption = 'Qualification Criteria';
                field("Appraise Deposits"; "Appraise Deposits")
                {
                    ApplicationArea = Basic;
                    Caption = 'Deposits';
                }
                field("Appraise Shares"; "Appraise Shares")
                {
                    ApplicationArea = Basic;
                    Caption = 'Shares';
                }
                field("Appraise Salary"; "Appraise Salary")
                {
                    ApplicationArea = Basic;
                    Caption = 'Salary';
                }
                field("Appraise Bank Statement"; "Appraise Bank Statement")
                {
                    ApplicationArea = Basic;
                }
                field("Appraise Guarantors"; "Appraise Guarantors")
                {
                    ApplicationArea = Basic;
                }
                field("Appraise Business"; "Appraise Business")
                {
                    ApplicationArea = Basic;
                }
                field("Appraise Dividend"; "Appraise Dividend")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Fees & Comissions Accounts")
            {
                Caption = 'Fees & Comissions Accounts';
                field("Penalty Paid Account"; "Penalty Paid Account")
                {
                    ApplicationArea = Basic;
                }
                field("Penalty Charged Account"; "Penalty Charged Account")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Account"; "Loan Account")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Interest Account"; "Loan Interest Account")
                {
                    ApplicationArea = Basic;
                }
                field("Receivable Interest Account"; "Receivable Interest Account")
                {
                    ApplicationArea = Basic;
                }
                field("Top Up Commision Account"; "Top Up Commision Account")
                {
                    ApplicationArea = Basic;
                    Caption = 'Top Up Interest Account';
                }
                field("Interest In Arrears Account"; "Interest In Arrears Account")
                {
                    ApplicationArea = Basic;
                }
                field("Loan PayOff Fee Account"; "Loan PayOff Fee Account")
                {
                    ApplicationArea = Basic;
                }
                field("Receivable Insurance Accounts"; "Receivable Insurance Accounts")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Insurance Accounts"; "Loan Insurance Accounts")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Interest Restructure A/C"; "Loan Interest Restructure A/C")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Insurance Restructure A/C"; "Loan Insurance Restructure A/C")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Penalty Restructure A/C"; "Loan Penalty Restructure A/C")
                {
                    ApplicationArea = Basic;
                }
                field("Loan ApplFee Accounts"; "Loan ApplFee Accounts")
                {

                }
                field("Receivable ApplFee Accounts"; "Receivable ApplFee Accounts")
                {

                }
            }
            group("Loan Numbering")
            {
                Caption = 'Loan Numbering';
                Visible = false;
                field("Loan No(HQ)"; "Loan No(HQ)")
                {
                    ApplicationArea = Basic;
                }
                field("Loan No(NAIV)"; "Loan No(NAIV)")
                {
                    ApplicationArea = Basic;
                }
                field("Loan No(ELD)"; "Loan No(ELD)")
                {
                    ApplicationArea = Basic;
                }
                field("Loan No(MSA)"; "Loan No(MSA)")
                {
                    ApplicationArea = Basic;
                }
                field("Loan No(NKR)"; "Loan No(NKR)")
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
            group(Product)
            {
                Caption = 'Product';
                action("Product Charges")
                {
                    ApplicationArea = Basic;
                    Caption = 'Product Charges';
                    Image = Setup;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Loan Product Charges";
                    RunPageLink = "Product Code" = field(Code);
                }
                action("Loan to Share Ratio Analysis")
                {
                    ApplicationArea = Basic;
                    Image = Setup;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Product Deposit>Loan Analysis";
                    RunPageLink = "Product Code" = field(Code);
                }
            }
        }
    }
}

