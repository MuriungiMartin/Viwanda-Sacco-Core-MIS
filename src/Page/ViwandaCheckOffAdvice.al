page 59022 "Viwanda CheckOff Advice"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Viwanda Checkoff Off Advice";
    PromotedActionCategories = 'New caption,Process caption,Report caption,Category4 caption';

    layout
    {
        area(Content)
        {

            repeater(GroupName)
            {
                field("Staff/Payroll No"; "Staff/Payroll No")
                {
                    ApplicationArea = All;

                }
                field(Amount; Amount)
                {
                    ApplicationArea = All;

                }
                field("No Repayment"; "No Repayment")
                {
                    ApplicationArea = All;

                }
                field("Staff Not Found"; "Staff Not Found")
                {
                    ApplicationArea = All;

                }
                field("Date Filter"; "Date Filter")
                {
                    ApplicationArea = All;

                }
                field("Transaction Date"; "Transaction Date")
                {
                    ApplicationArea = All;

                }
                field(Generated; Generated)
                {
                    ApplicationArea = All;

                }
                field("Payment No"; "Payment No")
                {
                    ApplicationArea = All;

                }
                field(Posted; Posted)
                {
                    ApplicationArea = All;

                }
                field("Multiple Receipts"; "Multiple Receipts")
                {
                    ApplicationArea = All;

                }
                field(Name; Name)
                {
                    ApplicationArea = All;

                }
                field("Early Remitances"; "Early Remitances")
                {
                    ApplicationArea = All;

                }
                field("Early Remitance Amount"; "Early Remitance Amount")
                {
                    ApplicationArea = All;

                }
                field("Trans Type"; "Trans Type")
                {
                    ApplicationArea = All;

                }
                field(Description; Description)
                {
                    ApplicationArea = All;

                }
                field("Member Found"; "Member Found")
                {
                    ApplicationArea = All;

                }
                field("Search Index"; "Search Index")
                {
                    ApplicationArea = All;

                }
                field("Loan Found"; "Loan Found")
                {
                    ApplicationArea = All;
                }
                field("Loan No"; "Loan No")
                {
                    ApplicationArea = All;

                }
                field(User; User)
                {
                    ApplicationArea = All;

                }
                field("Member Moved"; "Member Moved")
                {
                    ApplicationArea = All;

                }
                field("Employer Code"; "Employer Code")
                {
                    ApplicationArea = All;

                }
                field("Batch No."; "Batch No.")
                {
                    ApplicationArea = All;

                }
                field("Member No"; "Member No")
                {
                    ApplicationArea = All;

                }
                field("ID No."; "ID No.")
                {
                    ApplicationArea = All;

                }
                field("Receipt Header No"; "Receipt Header No")
                {
                    ApplicationArea = All;

                }
                field("Receipt Line No"; "Receipt Line No")
                {
                    ApplicationArea = All;

                }
                field("Account Type"; "Account Type")
                {
                    ApplicationArea = All;

                }
                field("Entry No"; "Entry No")
                {
                    ApplicationArea = All;

                }
                field("Sacco Shares"; "Sacco Shares")
                {
                    ApplicationArea = All;

                }
                field("Sacco Total Loan"; "Sacco Total Loan")
                {
                    ApplicationArea = All;

                }
                field("Sacco Total Interest"; "Sacco Total Interest")
                {
                    ApplicationArea = All;

                }
                field("Saccco Benevolent"; "Saccco Benevolent")
                {
                    ApplicationArea = All;

                }
                field("Sacco Appl Fee"; "Sacco Appl Fee")
                {
                    ApplicationArea = All;

                }












            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {


            action("Generate Advice")

            {
                ApplicationArea = All;
                Promoted = true;

                trigger OnAction();
                begin
                    FnGenerateViwandaAdvice();
                end;
            }
        }
    }
    protected var

        ObjCust: Record Customer;
        ObjLoan: Record "Loans Register";
        ObjSaccoGen: Record "Sacco General Set-Up";
        ObjSaccoEmp: Record "Sacco Employers";
        VarTotalLoan: Decimal;
        VarAppFee: Decimal;
        VarSaccoShares: Decimal;
        VarSaccoTotalInterest: Decimal;
        VarSaccoBenevolent: Decimal;
        VarRegFee: Decimal;
        VarInsuranceFee: Decimal;
        varShareCapital: Decimal;
        varDeposits: Decimal;
        ObjLschedule: Record "Loan Repayment Schedule";
        VarLoanInterest: Decimal;
        VarEntryNo: Integer;
        ObjAdvice: Record "Viwanda Checkoff Off Advice";

    protected procedure FnGenerateViwandaAdvice()
    begin


        ObjSaccoGen.Get();
        ObjCust.Reset();
        ObjCust.SetAutoCalcFields(ObjCust."Registration Fee Paid", ObjCust."Out. Loan Application fee", ObjCust."Out. Loan Insurance fee", ObjCust."Outstanding Balance",
        ObjCust."Outstanding Interest", ObjCust."Shares Retained");
        if ObjCust.FindSet() then begin
            VarAppFee := 0;
            varDeposits := 0;
            VarLoanInterest := 0;
            varShareCapital := 0;
            VarSaccoShares := 0;
            VarTotalLoan := 0;
            VarRegFee := 0;
            VarInsuranceFee := 0;
            VarSaccoBenevolent := 0;
            VarEntryNo := 0;




            repeat

                if ObjCust."Registration Fee Paid" < ObjSaccoGen."BOSA Registration Fee Amount" then begin
                    VarRegFee := (ObjSaccoGen."BOSA Registration Fee Amount" - ObjCust."Registration Fee Paid");
                end;
                if ObjCust."Shares Retained" < ObjSaccoGen."Retained Shares" then begin
                    varShareCapital := (ObjSaccoGen."Retained Shares" - ObjCust."Shares Retained");
                end;
                if ObjCust."Monthly Contribution" > 0 then begin
                    varDeposits := ObjCust."Monthly Contribution";
                end;
                if ObjCust."Out. Loan Application fee" > 0 then begin
                    VarAppFee := ObjCust."Out. Loan Application fee";
                end;
                if ObjCust."Out. Loan Insurance fee" > 0 then begin
                    VarInsuranceFee := ObjCust."Out. Loan Insurance fee";
                end;
                if ObjCust."Outstanding Interest" > 0 then begin
                    VarLoanInterest := ObjCust."Outstanding Interest";
                end;
                if ObjCust."Outstanding Balance" > 0 then begin
                    VarTotalLoan := ObjCust."Outstanding Balance";
                end;
                if ObjCust."Welfare Contribution" > 0 then begin
                    VarSaccoBenevolent := ObjCust."Welfare Contribution";
                end;
                //---------------------In the checkoff blocktemplate sacco interet comprises of interest, insurance and registration fee-------------------------
                VarSaccoTotalInterest := VarLoanInterest + VarInsuranceFee + VarRegFee;
                VarEntryNo += 1;
                ObjAdvice.Init();
                ObjAdvice."Entry No" := VarEntryNo;
                ObjAdvice."Staff/Payroll No" := ObjCust."No.";
                ObjAdvice."Member No" := ObjCust."No.";
                ObjAdvice."Saccco Benevolent" := VarSaccoBenevolent;
                ObjAdvice."Sacco Appl Fee" := VarAppFee;
                ObjAdvice."Sacco Total Interest" := VarSaccoTotalInterest;
                ObjAdvice."Sacco Shares" := varDeposits + varShareCapital;
                ObjAdvice."Sacco Total Loan" := VarTotalLoan;

            until
            ObjCust.Next() = 0;
        end;
    end;




}