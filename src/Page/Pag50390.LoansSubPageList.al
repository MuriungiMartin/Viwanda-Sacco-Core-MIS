#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50390 "Loans Sub-Page List"
{
    CardPageID = "Loans Application Card(Posted)";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    PageType = ListPart;
    RefreshOnActivate = true;
    SourceTable = "Loans Register";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field("Loan  No."; "Loan  No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Loan Product Type"; "Loan Product Type")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loan Product';
                }
                field("Loan Product Type Name"; "Loan Product Type Name")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loan Product Name';
                    Editable = false;
                }
                field("Client Code"; "Client Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member No';
                }
                field("Client Name"; "Client Name")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member Name';
                }
                field("Application Date"; "Application Date")
                {
                    ApplicationArea = Basic;
                }
                field("Requested Amount"; "Requested Amount")
                {
                    ApplicationArea = Basic;
                    Caption = 'Requested Amount';
                }
                field("Approved Amount"; "Approved Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Collateral Secured"; "Loan Collateral Secured")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Promoted;
                    Style = Strong;
                    StyleExpr = true;
                }
                field("Issued Date"; "Issued Date")
                {
                    ApplicationArea = Basic;
                }
                field("Repayment Start Date"; "Repayment Start Date")
                {
                    ApplicationArea = Basic;
                }
                field("Outstanding Balance"; "Outstanding Balance")
                {
                    ApplicationArea = Basic;
                    Caption = 'Principle Balance';
                    Editable = false;
                    StyleExpr = FieldStyle;
                }
                field("Current Principle Due"; "Current Principle Due")
                {
                    ApplicationArea = Basic;
                    Caption = ' Principle Due';
                }
                field("Interest Due"; "Interest Due")
                {
                    ApplicationArea = Basic;
                    Caption = 'Total Interest Accrued';
                    Editable = false;
                    Importance = Additional;
                }
                field("Total Interest Paid"; "Total Interest Paid")
                {
                    ApplicationArea = Basic;
                }
                field("Outstanding Interest"; "Outstanding Interest")
                {
                    ApplicationArea = Basic;
                    Caption = 'Outstanding Interest';
                }
                field("Loan Insurance Charged"; "Loan Insurance Charged")
                {
                    ApplicationArea = Basic;
                    Caption = 'Insurance Charged';
                    Editable = false;
                    Importance = Additional;
                }
                field("Total Insurance Paid"; "Total Insurance Paid")
                {
                    ApplicationArea = Basic;
                }
                field("Outstanding Insurance"; "Outstanding Insurance")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Penalty Charged"; "Penalty Charged")
                {
                    ApplicationArea = Basic;
                    Importance = Additional;
                }
                field("Total Penalty Paid"; "Total Penalty Paid")
                {
                    ApplicationArea = Basic;
                }
                field("Outstanding Penalty"; "Outstanding Penalty")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Current Payoff Amount"; "Loan Current Payoff Amount")
                {
                    ApplicationArea = Basic;
                    Caption = 'Payoff Amount';
                    Editable = false;
                }
                field("Loan Amount Due"; "Loan Amount Due")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                    Style = Strong;
                    StyleExpr = true;
                }
                field("Amount in Arrears"; "Amount in Arrears")
                {
                    ApplicationArea = Basic;
                    Caption = 'Arrears Amount';
                    Editable = false;
                    Importance = Promoted;
                    Style = Attention;
                    StyleExpr = FieldStyleArrears;
                }
                field("Days In Arrears"; "Days In Arrears")
                {
                    ApplicationArea = Basic;
                    Caption = 'Arrears Days';
                    Editable = false;
                    Importance = Promoted;
                    Style = Attention;
                    StyleExpr = FieldStyleArrears;
                }
                field(Repayment; Repayment)
                {
                    ApplicationArea = Basic;
                }
                field("Loan Status"; "Loan Status")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Additional;
                }
                field("Loans Category-SASRA"; "Loans Category-SASRA")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loans Category';
                }
                field("Approval Status"; "Approval Status")
                {
                    ApplicationArea = Basic;
                }
                field("Application type"; "Application type")
                {
                    ApplicationArea = Basic;
                }
                field(Posted; Posted)
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
        /*InterestDue:=SFactory.FnGetInterestDueTodate(Rec);
        OutstandingInterest:=SFactory.FnGetInterestDueTodate(Rec)-"Interest Paid";
        
        
        SFactory.FnGetLoanArrearsAmountII("Loan  No.");
        
        CALCFIELDS("Interest Due","Interest Paid");
        "Outstanding Interest":="Interest Due"-("Interest Paid");
        
        "Loan Current Payoff Amount":=SFactory.FnRunGetLoanPayoffAmount("Loan  No.");
        
        "Loan Amount Due":=SFactory.FnRunLoanAmountDue("Loan  No.");
        */

    end;

    trigger OnAfterGetRecord()
    begin
        //SFactory.FnGetLoanArrearsAmountII("Loan  No.");


        "Loan Current Payoff Amount" := SFactory.FnRunGetLoanPayoffAmount("Loan  No.");

        "Loan Amount Due" := SFactory.FnRunLoanAmountDue("Loan  No.");
    end;

    trigger OnOpenPage()
    begin
        SetFilter("Loan Status", '<>%1', "loan status"::Closed);

        /*"Loan Current Payoff Amount":=SFactory.FnRunGetLoanPayoffAmount("Loan  No.");
        
        "Loan Amount Due":=SFactory.FnRunLoanAmountDue("Loan  No.");*/

    end;

    var
        LoanType: Record "Loan Products Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        FieldStyle: Text;
        FieldStyleI: Text;
        OutstandingInterest: Decimal;
        InterestDue: Decimal;
        SFactory: Codeunit "SURESTEP Factory";
        ObjLoans: Record "Loans Register";
        VarLoanPayoffAmount: Decimal;
        VarInsurancePayoff: Decimal;
        ObjProductCharge: Record "Loan Product Charges";
        VarEndYear: Date;
        VarInsuranceMonths: Integer;
        VarAmountinArrears: Decimal;
        ObjRepaymentSchedule: Record "Loan Repayment Schedule";
        VarOutstandingInterestI: Decimal;
        FieldStyleArrears: Text;


    procedure GetVariables(var LoanNo: Code[20]; var LoanProductType: Code[20]; var MemberNo: Code[20])
    begin
        LoanNo := "Loan  No.";
        LoanProductType := "Loan Product Type";
        MemberNo := "Client Code";
    end;

    local procedure SetFieldStyle()
    begin
        FieldStyle := '';
        CalcFields("Outstanding Balance", "Outstanding Interest");
        if ("Outstanding Balance" < 0) then
            FieldStyle := 'Attention';

        if ("Outstanding Interest" < 0) then
            FieldStyleI := 'Attention';


        FieldStyleArrears := 'Strong';
        if ("Amount in Arrears" > 0) then
            FieldStyleArrears := 'Unfavorable';
        if ("Amount in Arrears" = 0) then
            FieldStyleArrears := 'Favorable';
    end;
}

