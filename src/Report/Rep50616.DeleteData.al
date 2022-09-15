
Report 50616 "Delete Data"
{
    RDLCLayout = 'Layouts/DeleteData.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Loans Register"; "Loans Register")
        {

            trigger OnPreDataItem();
            begin
                /*ObjMemberLedger.DELETEALL;
				ObjBankLedger.DELETEALL;
				ObjCustLedger.DELETEALL;
				ObjDetailedCustLedger.DELETEALL;
				ObjDetailedVendorLedger.DELETEALL;
				ObjGLEntry.DELETEALL;
				ObjVendorLedger.DELETEALL;*/
                /*"Membership Applications".Created:=FALSE;
				"Membership Applications".MODIFY;*/

            end;

            trigger OnAfterGetRecord();
            begin
                /*{"Loans Register"."Loan Status":="Loans Register"."Loan Status"::Disbursed;
				"Loans Register".Posted:=TRUE;
				"Loans Register"."Approval Status":="Loans Register"."Approval Status"::Approved;
				"Loans Register".MODIFY;} Blocked:=Blocked::" ";
				MODIFY;
				*/
                "Loans Register"."Repayment Method" := "Loans Register"."repayment method"::"Reducing Balance";
                "Loans Register".Modify;

            end;

        }
    }

    requestpage
    {


        SaveValues = false;
        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';

                }
            }
        }

        actions
        {
        }
        trigger OnOpenPage()
        begin

        end;
    }

    trigger OnInitReport()
    begin
        ;


    end;

    trigger OnPostReport()
    begin
        ;

    end;

    trigger OnPreReport()
    begin
        ;

    end;

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

    var
}

