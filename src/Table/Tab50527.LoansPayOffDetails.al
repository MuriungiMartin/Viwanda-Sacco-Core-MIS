#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50527 "Loans PayOff Details"
{
    //nownPage51516389;
    //nownPage51516389;

    fields
    {
        field(1; "Document No"; Code[20])
        {
            TableRelation = "Loan PayOff"."Document No";
        }
        field(2; "Loan to PayOff"; Code[20])
        {
            TableRelation = if (Source = filter(BOSA)) "Loans Register"."Loan  No." where("Client Code" = field("Member No"),
                                                                                         Posted = const(true),
                                                                                         "Outstanding Balance" = filter(> 0))
            else
            if (Source = filter(FOSA)) "Loans Register"."Loan  No." where("BOSA No" = field("Member No"));

            trigger OnValidate()
            begin

                if Confirm('Are you Sure you Want to PayOff this loan?', true) = true then begin

                    "Loan Type" := '';
                    "Principle PayOff" := 0;
                    "Interest On PayOff" := 0;
                    "Total PayOff" := 0;
                    Loantypes.Reset;
                    Loantypes.SetRange(Loantypes.Code, "Loan Type");



                    Loans.Reset;
                    Loans.SetRange(Loans."Loan  No.", "Loan to PayOff");
                    if Loans.Find('-') then begin
                        Loans.CalcFields(Loans."Outstanding Balance", Loans."Interest Due");
                        "Loan Type" := Loans."Loan Product Type";
                        if Cust.Get(Loans."Client Code") then begin
                            "ID. NO" := Cust."ID No.";
                            "Staff No" := Cust."Payroll No";
                        end;


                        //"Total PayOff":=SFactory.FnRunGetLoanPayoffAmount("Loan to PayOff");
                        "Loan Outstanding" := Loans."Outstanding Balance";
                        "Monthly Repayment" := Loans.Repayment;
                        GenSetUp.Get();
                    end;
                    //"Total PayOff":="Principle PayOff" +"Interest On PayOff"+"Commision on PayOff";
                    Loans.Bridged := true;
                    Loans.Modify
                end;


                if Loans.Get("Document No") then begin
                    if "Total PayOff" > Loans."Requested Amount" then
                        Error('You Can not PayOff more than the requested amount');
                end;
                "Total PayOff" := FnRunGetInsuranceForPeriodRemaining;
            end;
        }
        field(3; "Member No"; Code[20])
        {
            TableRelation = if (Source = filter(BOSA)) Customer;
        }
        field(4; "Loan Type"; Code[20])
        {
        }
        field(5; "Principle PayOff"; Decimal)
        {

            trigger OnValidate()
            begin
                /*//IF Loantypes.GET("Loan Type") THEN BEGIN
                //"Interest On PayOff":="Principle PayOff"*(Loantypes."Interest rate"/100);
                //END;
                
                //"Interest On PayOff":="Principle PayOff"*(1.75/100);
                
                
                Loans.RESET;
                Loans.SETRANGE(Loans."Loan  No.","Loan to PayOff");
                IF Loans.FIND('-') THEN BEGIN
                Loans.CALCFIELDS(Loans."Outstanding Balance");
                IF "Principle PayOff" > Loans."Outstanding Balance" THEN
                ERROR('Amount cannot be greater than the loan oustanding balance.');
                // "Interest On PayOff":="Principle PayOff"*(Loans.Interest/100);
                END;
                
                IF "Principle PayOff" > Loans."Requested Amount" THEN
                ERROR('Amount cannot be greater than the loan oustanding balance.');
                 //"Interest On PayOff":="Principle PayOff"*(Loans.Interest/100);
                //END;
                
                
                IF  "Commision on PayOff" < 500 THEN BEGIN
                 "Commision on PayOff":=500
                END ELSE BEGIN
                "Commision on PayOff":=ROUND(("Principle PayOff"+"Interest On PayOff")*(GenSetUp."Top up Commission"/100),1,'>');
                
                END;
                 "Total PayOff":="Principle PayOff" +"Interest On PayOff";//+Commision;
                
                
                "Total PayOff":="Principle PayOff" +"Interest On PayOff";
                */

            end;
        }
        field(6; "Interest On PayOff"; Decimal)
        {

            trigger OnValidate()
            begin
                /*{"Total PayOff":="Principle PayOff" +"Interest On PayOff"+Commision;
                
                Loans.RESET;
                Loans.SETRANGE(Loans."Loan  No.","Loan Top Up");
                IF Loans.FIND('-') THEN BEGIN
                Loans.CALCFIELDS(Loans."Interest Due");
                IF "Principle PayOff" < Loans."Outstanding Balance" THEN
                ERROR('Amount cannot be greater than the interest due.');
                
                END;
                }
                GenSetUp.GET();
                "Commision on PayOff":=ROUND(("Principle PayOff"+"Interest On PayOff")*(GenSetUp."Top up Commission"/100),1,'>');
                 "Total PayOff":="Principle PayOff" +"Interest On PayOff";//+Commision;
                "Commision on PayOff":=ROUND(("Principle PayOff"+"Interest On PayOff")*(GenSetUp."Top up Commission"/100),1,'>');
                
                IF  "Commision on PayOff" < 500 THEN BEGIN
                 "Commision on PayOff":=500
                END ELSE BEGIN
                "Commision on PayOff":=ROUND(("Principle PayOff"+"Interest On PayOff")*(GenSetUp."Top up Commission"/100),1,'>');
                
                END;
                */

            end;
        }
        field(7; "Total PayOff"; Decimal)
        {
        }
        field(8; "Monthly Repayment"; Decimal)
        {
        }
        field(9; "Interest Paid"; Decimal)
        {
            CalcFormula = sum("Member Ledger Entry".Amount where("Customer No." = field("Member No"),
                                                                  "Loan No" = field("Loan to PayOff"),
                                                                  "Transaction Type" = filter("Insurance Contribution")));
            FieldClass = FlowField;
        }
        field(10; "Outstanding Balance"; Decimal)
        {
            FieldClass = Normal;
        }
        field(11; "Interest Rate"; Decimal)
        {
            CalcFormula = sum("Loans Register".Interest where("Loan  No." = field("Loan to PayOff"),
                                                               "Client Code" = field("Member No")));
            FieldClass = FlowField;
        }
        field(12; "ID. NO"; Code[50])
        {
        }
        field(13; "Commision on PayOff"; Decimal)
        {

            trigger OnValidate()
            begin
                "Total PayOff" := "Principle PayOff" + "Interest On PayOff" + "Commision on PayOff";
            end;
        }
        field(14; "Partial Bridged"; Boolean)
        {

            trigger OnValidate()
            begin

                LoansTop.Reset;
                LoansTop.SetRange(LoansTop."Loan  No.", "Loan to PayOff");
                if LoansTop.Find('-') then begin
                    if "Partial Bridged" = true then
                        LoansTop."partially Bridged" := true;
                    LoansTop.Modify;
                end;
            end;
        }
        field(15; "Remaining Installments"; Decimal)
        {
        }
        field(16; "Finale Instalment"; Decimal)
        {
        }
        field(17; "Penalty Charged"; Decimal)
        {
        }
        field(18; "Staff No"; Code[20])
        {
        }
        field(19; "Commissioning Balance"; Decimal)
        {

            trigger OnValidate()
            begin
                /*GenSetUp.GET();
                "Commision on PayOff":=ROUND(("Commissioning Balance")*(GenSetUp."Top up Commission"/100),1,'>');
                "Total PayOff":="Principle PayOff" +"Interest On PayOff"+"Commision on PayOff";
                */

            end;
        }
        field(20; Source; Option)
        {
            OptionCaption = ' ,BOSA,FOSA';
            OptionMembers = " ",BOSA,FOSA;
        }
        field(21; "Loan Outstanding"; Decimal)
        {
        }
        field(22; Posted; Boolean)
        {
        }
        field(23; "Posting Date"; Date)
        {
        }
        field(24; "Outstanding Interest"; Decimal)
        {
        }
        field(25; "Outstanding Insurance"; Decimal)
        {
        }
        field(26; "Outstanding Penalty"; Decimal)
        {
        }
        field(27; "Debt Collector Fee"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Document No", "Member No", "Loan to PayOff")
        {
            Clustered = true;
            SumIndexFields = "Total PayOff", "Principle PayOff";
        }
        key(Key2; "Principle PayOff")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Member No", "Loan Type", "Principle PayOff", "Interest On PayOff", "Total PayOff", "Monthly Repayment", "Interest Paid", "Outstanding Balance", "Interest Rate", "Commision on PayOff")
        {
        }
    }

    var
        Loans: Record "Loans Register";
        Loantypes: Record "Loan Products Setup";
        Interest: Decimal;
        Cust: Record Customer;
        LoansTop: Record "Loans Register";
        GenSetUp: Record "Sacco General Set-Up";
        SFactory: Codeunit "SURESTEP Factory";
        VarLoanDue: Decimal;
        ObjPayOffHeader: Record "Loan PayOff";
        VarFOSAAvailableBalance: Decimal;
        VarDebtCollectorFee: Decimal;

    local procedure FnRunGetInsuranceForPeriodRemaining() VarLoanPayoffAmount: Decimal
    var
        ObjLoans: Record "Loans Register";
        VarInsurancePayoff: Decimal;
        ObjProductCharge: Record "Loan Product Charges";
        VarEndYear: Date;
        VarInsuranceMonths: Integer;
        VarAmountinArrears: Decimal;
        ObjRepaymentSchedule: Record "Loan Repayment Schedule";
        VarInterestNewLoans: Decimal;
        ObjInterestLedger: Record "Interest Due Ledger Entry";
    begin
        ObjLoans.Reset;
        ObjLoans.SetRange(ObjLoans."Loan  No.", "Loan to PayOff");
        if ObjLoans.FindSet then begin
            ObjLoans.CalcFields(ObjLoans."Outstanding Balance");
            if ObjLoans."Outstanding Balance" <> 0 then begin

                if ObjLoans."Loan Product Type" <> '322' then begin
                    ObjInterestLedger.Reset;
                    ObjInterestLedger.SetRange("Loan No", "Loan to PayOff");
                    if ObjInterestLedger.FindSet = false then begin
                        VarInterestNewLoans := ROUND(ObjLoans."Outstanding Balance" * (ObjLoans.Interest / 1200), 0.01, '=');
                    end;
                end;

                VarLoanPayoffAmount := SFactory.FnRunGetLoanPayoffAmount("Loan to PayOff");

                ObjPayOffHeader.Reset;
                ObjPayOffHeader.SetRange(ObjPayOffHeader."Document No", "Document No");
                if ObjPayOffHeader.FindSet then begin
                    VarFOSAAvailableBalance := ObjPayOffHeader."FOSA Account Available Balance";
                end;
                if Loantypes.Get("Loan Type") then begin
                    "Commision on PayOff" := ROUND((VarLoanPayoffAmount) * (Loantypes."Loan PayOff Fee(%)" / 100), 1, '>');
                end;

                VarLoanDue := SFactory.FnRunLoanAmountDue("Loan to PayOff");
                VarDebtCollectorFee := SFactory.FnRunGetLoanDebtCollectorFeePayoff("Loan to PayOff", VarFOSAAvailableBalance);
                "Principle PayOff" := Loans."Outstanding Balance";
                "Interest On PayOff" := Loans."Outstanding Interest";
                "Outstanding Interest" := Loans."Outstanding Interest";
                "Outstanding Penalty" := Loans."Outstanding Penalty";
                "Outstanding Insurance" := Loans."Outstanding Insurance" + Loans."Insurance Payoff";
                "Debt Collector Fee" := VarDebtCollectorFee;
                VarLoanPayoffAmount := "Principle PayOff" + "Outstanding Interest" + "Outstanding Penalty" + "Outstanding Insurance" + "Debt Collector Fee" + VarInterestNewLoans;
                "Total PayOff" := VarLoanPayoffAmount;

            end;
        end;
    end;
}

