#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Report 50135 "Process Standing Order Ver1"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("Standing Orders"; "Standing Orders")
        {
            DataItemTableView = where(Status = filter(Approved), "Is Active" = filter(true));
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnAfterGetRecord()
            begin
                SFactory.FnRunProcessStandingOrder("No.", WorkDate);
            end;

            trigger OnPreDataItem()
            begin
                //"Standing Orders".SETFILTER("Standing Orders".Status,"Standing Orders".Status::Approved);
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        ObjLoans: Record "Loans Register";
        ObjLoanType: Record "Loan Products Setup";
        ObjAccount: Record Vendor;
        ObjMemberCells: Record "Phone Number Buffer";
        ObjGenSetup: Record "Sacco General Set-Up";
        ObjExcessRuleProducts: Record "Excess Repayment Rules Product";
        ObjMember: Record Customer;
        Name: Decimal;
        SFactory: Codeunit "SURESTEP Factory";
        ObjLoanSchedule: Record "Loan Repayment Schedule";
        ObjAccounts: Record Vendor;
        VarAccountTypes: Text[1024];
        ObjAccountType: Record "Account Types-Saving Products";
        VarAccountDescription: Text[1024];
        ObjGLEntry: Record "G/L Entry";
        ObjMemberLedger: Record "Member Ledger Entry";
        ObjBankLedger: Record "Bank Account Ledger Entry";
        ObjVendorLedger: Record "Vendor Ledger Entry";
        ObjDetailedVendorLedger: Record "Detailed Vendor Ledg. Entry";
        ObjCustLedger: Record "Cust. Ledger Entry";
        ObjDetailedCustLedger: Record "Detailed Cust. Ledg. Entry";
        ObjLoanGuarantors: Record "Loans Guarantee Details";
        ObjLoanCollateral: Record "Loan Collateral Details";
        WeekDay: Text;
        ObjATMApp: Record "ATM Card Applications";
        VarLineNo: Integer;
        GenJournalLine: Record "Gen. Journal Line";
}

