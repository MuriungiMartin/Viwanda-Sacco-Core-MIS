#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50413 "Sacco No. Series"
{
    DeleteAllowed = false;
    Editable = true;
    SourceTable = "Sacco No. Series";
    UsageCategory = Administration;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Primary Key"; "Primary Key")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("SMS Request Series"; "SMS Request Series")
                {
                    ApplicationArea = Basic;
                }
            }
            group(Credit)
            {
                Caption = 'Credit';
                field("Member Application Nos"; "Member Application Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Micro Loans"; "Micro Loans")
                {
                    ApplicationArea = Basic;
                }
                field("Members Nos"; "Members Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Emergency Loans Nos";"Emergency Loans Nos")
                {
                    ApplicationArea = Basic;
                }
                field("E-Loan Nos"; "E-Loan Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Loans Batch Nos"; "Loans Batch Nos")
                {
                    ApplicationArea = Basic;
                }
                field("BOSA Receipts Nos"; "BOSA Receipts Nos")
                {
                    ApplicationArea = Basic;
                }
                field("BOSA Transfer Nos"; "BOSA Transfer Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Closure  Nos"; "Closure  Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Bosa Transaction Nos"; "Bosa Transaction Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Paybill Processing"; "Paybill Processing")
                {
                    ApplicationArea = Basic;
                }
                field("Checkoff-Proc Distributed Nos"; "Checkoff-Proc Distributed Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Checkoff Proc Block Nos"; "Checkoff Proc Block Nos")
                {
                    ApplicationArea = Basic;
                }
                field(BosaNumber; BosaNumber)
                {
                    ApplicationArea = Basic;
                    Caption = 'Member No Used';
                }
                field("Loan PayOff Nos"; "Loan PayOff Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Microfinance Last No Used"; "Microfinance Last No Used")
                {
                    ApplicationArea = Basic;
                }
                field("MicroFinance Account Prefix"; "MicroFinance Account Prefix")
                {
                    ApplicationArea = Basic;
                }
                field("Micro Transactions"; "Micro Transactions")
                {
                    ApplicationArea = Basic;
                }
                field("Micro Finance Transactions"; "Micro Finance Transactions")
                {
                    ApplicationArea = Basic;
                }
                field("Collateral Register No"; "Collateral Register No")
                {
                    ApplicationArea = Basic;
                }
                field("Cloudpesa Reg No."; "Cloudpesa Reg No.")
                {
                    ApplicationArea = Basic;
                }
                field("Safe Custody Package Nos"; "Safe Custody Package Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Safe Custody Agent Nos"; "Safe Custody Agent Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Safe Custody Item Nos"; "Safe Custody Item Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Package Retrieval Nos"; "Package Retrieval Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Member Cell Group Nos"; "Member Cell Group Nos")
                {
                    ApplicationArea = Basic;
                }
                field("House Change Request No"; "House Change Request No")
                {
                    ApplicationArea = Basic;
                }
                field("BD Training Nos"; "BD Training Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Member Agent/NOK Change"; "Member Agent/NOK Change")
                {
                    ApplicationArea = Basic;
                }
                field("House Group Application"; "House Group Application")
                {
                    ApplicationArea = Basic;
                }
                field("House Group Nos"; "House Group Nos")
                {
                    ApplicationArea = Basic;
                }
                field("CRB Charge"; "CRB Charge")
                {
                    ApplicationArea = Basic;
                    Caption = 'CRB Check Charge No';
                }
                field("Over Draft Application No"; "Over Draft Application No")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Restructure"; "Loan Restructure")
                {
                    ApplicationArea = Basic;
                }
                field("Collateral Movement No"; "Collateral Movement No")
                {
                    ApplicationArea = Basic;
                }
                field("Sweeping Instructions"; "Sweeping Instructions")
                {
                    ApplicationArea = Basic;
                }
                field("Employers Nos"; "Employers Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Scheduled Statements"; "Scheduled Statements")
                {
                    ApplicationArea = Basic;
                }
                field("Payroll Document No"; "Payroll Document No")
                {
                    ApplicationArea = Basic;
                }
                field("Audit issue Tracker"; "Audit issue Tracker")
                {
                    ApplicationArea = Basic;
                }
                field("Guarantor Sub No."; "Guarantor Sub No.")
                {
                    ApplicationArea = Basic;
                }
                field("Standing Order Members Nos"; "Standing Order Members Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Cheque No."; "Cheque No.")
                {
                    ApplicationArea = Basic;
                }


            }
            group("Banking Services")
            {
                Caption = 'Banking Services';
                field("Development Loans Nos";"Development Loans Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Nos."; "Transaction Nos.")
                {
                    ApplicationArea = Basic;
                }
                field("Treasury Nos."; "Treasury Nos.")
                {
                    ApplicationArea = Basic;
                }
                field("Standing Orders Nos."; "Standing Orders Nos.")
                {
                    ApplicationArea = Basic;
                }
                field("FOSA Current Account"; "FOSA Current Account")
                {
                    ApplicationArea = Basic;
                }
                field("BOSA Current Account"; "BOSA Current Account")
                {
                    ApplicationArea = Basic;
                }
                field("Teller Transactions No"; "Teller Transactions No")
                {
                    ApplicationArea = Basic;
                }
                field("Treasury Transactions No"; "Treasury Transactions No")
                {
                    ApplicationArea = Basic;
                }
                field("Applicants Nos."; "Applicants Nos.")
                {
                    ApplicationArea = Basic;
                }
                field("STO Register No"; "STO Register No")
                {
                    ApplicationArea = Basic;
                }
                field("EFT Header Nos."; "EFT Header Nos.")
                {
                    ApplicationArea = Basic;
                }
                field("EFT Details Nos."; "EFT Details Nos.")
                {
                    ApplicationArea = Basic;
                }
                field("Salary Processing Nos"; "Salary Processing Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Salaries Nos."; "Salaries Nos.")
                {
                    ApplicationArea = Basic;
                }
                field("ATM Applications"; "ATM Applications")
                {
                    ApplicationArea = Basic;
                }
                field("Cheque Clearing Nos"; "Cheque Clearing Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Cheque Application Nos"; "Cheque Application Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Cheque Receipts Nos"; "Cheque Receipts Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Customer Care Log Nos"; "Customer Care Log Nos")
                {
                    ApplicationArea = Basic;
                }
                field("S_Mobile Registration Nos"; "S_Mobile Registration Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Trunch Disbursment Nos"; "Trunch Disbursment Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Change Request No"; "Change Request No")
                {
                    ApplicationArea = Basic;
                }
                field("Agent Serial Nos"; "Agent Serial Nos")
                {
                    ApplicationArea = Basic;
                }
                field("ATM Card Batch Nos"; "ATM Card Batch Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Cheque Book Batch Nos"; "Cheque Book Batch Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Demand Notice Nos"; "Demand Notice Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Fixed Deposit Placement"; "Fixed Deposit Placement")
                {
                    ApplicationArea = Basic;
                }
                field("Cheque Book Account Nos"; "Cheque Book Account Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Signatories Application Doc No"; "Signatories Application Doc No")
                {
                    ApplicationArea = Basic;
                }
                field("Signatories Document No"; "Signatories Document No")
                {
                    ApplicationArea = Basic;
                }
                field("Member Account Agent App"; "Member Account Agent App")
                {
                    ApplicationArea = Basic;
                    Caption = 'Account Agent Document No';
                }
                field("Member Account Agent"; "Member Account Agent")
                {
                    ApplicationArea = Basic;
                    Caption = 'Account Agent Document No';
                }
                field("Account Freezing No"; "Account Freezing No")
                {
                    ApplicationArea = Basic;
                }
                field("Internal PV Document"; "Internal PV Document")
                {
                    ApplicationArea = Basic;
                }
                field("Journal Batch Doc. No"; "Journal Batch Doc. No")
                {
                    ApplicationArea = Basic;
                }
                field("Piggy Bank No"; "Piggy Bank No")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Finance/Others")
            {
                Caption = 'Finance/Others';
                field("Finance UpLoads"; "Finance UpLoads")
                {
                    ApplicationArea = Basic;
                }
                field("Requisition No"; "Requisition No")
                {
                    ApplicationArea = Basic;
                }
                field("Internal Requisition No."; "Internal Requisition No.")
                {
                    ApplicationArea = Basic;
                }
                field("Internal Purchase No."; "Internal Purchase No.")
                {
                    ApplicationArea = Basic;
                }
                field("Quatation Request No"; "Quatation Request No")
                {
                    ApplicationArea = Basic;
                }
                field("Stores Requisition No"; "Stores Requisition No")
                {
                    ApplicationArea = Basic;
                }
                field("Requisition Default Vendor"; "Requisition Default Vendor")
                {
                    ApplicationArea = Basic;
                }
                field("Use Procurement limits"; "Use Procurement limits")
                {
                    ApplicationArea = Basic;
                }
                field("Request for Quotation Nos"; "Request for Quotation Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Investors Nos"; "Investors Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Property Nos"; "Property Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Investment Project Nos"; "Investment Project Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Withholding Tax %"; "Withholding Tax %")
                {
                    ApplicationArea = Basic;
                }
                field("Withholding Tax Account"; "Withholding Tax Account")
                {
                    ApplicationArea = Basic;
                }
                field("VAT %"; "VAT %")
                {
                    ApplicationArea = Basic;
                }
                field("VAT Account"; "VAT Account")
                {
                    ApplicationArea = Basic;
                }
            }
            group(Investor)
            {
                Caption = 'Investor';
                field("Investor Application Nos"; "Investor Application Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Investor Nos"; "Investor Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Paybill No."; "Paybill No.")
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

