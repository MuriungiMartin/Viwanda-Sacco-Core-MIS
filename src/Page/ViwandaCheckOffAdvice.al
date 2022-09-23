page 59022 "Viwanda CheckOff Advice"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Viwanda Checkoff Advice";
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

                field("Member No"; "Member No")
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
                PromotedCategory = Process;
                trigger OnAction();
                begin
                    ObjAdvice.Reset();

                    if ObjAdvice.FindSet() then
                        ObjAdvice.DeleteAll();
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
        ObjAdvice: Record "Viwanda Checkoff Advice";

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
                VarSaccoBenevolent := ObjSaccoGen."Benevolent Fund Contribution";
                //---------------------In the checkoff blocktemplate sacco interet comprises of interest, insurance and registration fee-------------------------
                VarSaccoTotalInterest := VarLoanInterest + VarInsuranceFee + VarRegFee;
                ObjAdvice.Reset();
                ;
                if ObjAdvice.Find('+') then begin
                    VarEntryNo := ObjAdvice."Entry No" + 1;
                end else
                    VarEntryNo := 1;
                ObjAdvice.Init();
                ObjAdvice."Entry No" := VarEntryNo;
                ObjAdvice."Staff/Payroll No" := ObjCust."No.";
                ObjAdvice."Member No" := ObjCust."No.";
                ObjAdvice."Saccco Benevolent" := VarSaccoBenevolent;
                ObjAdvice."Sacco Appl Fee" := VarAppFee;
                ObjAdvice."Sacco Total Interest" := VarSaccoTotalInterest;
                ObjAdvice."Sacco Shares" := varDeposits + varShareCapital;
                ObjAdvice."Sacco Total Loan" := VarTotalLoan;
                if ObjAdvice."Member No" <> '' then
                    ObjAdvice.Insert(true);
            until
            ObjCust.Next() = 0;
        end;
    end;




}