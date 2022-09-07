#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50380 "Loan Calculator"
{
    

    fields
    {
        field(2; "Loan Product Type"; Code[20])
        {
            TableRelation = "Loan Products Setup".Code;

            trigger OnValidate()
            begin
                ObjLoanType.Reset;
                ObjLoanType.SetRange(ObjLoanType.Code, "Loan Product Type");
                if ObjLoanType.Find('-') then begin
                    "Interest rate" := ObjLoanType."Interest rate";
                    "Repayment Method" := ObjLoanType."Repayment Method";
                    "Product Description" := ObjLoanType."Product Description";
                    Installments := ObjLoanType."No of Installment";
                    "Instalment Period" := ObjLoanType."Instalment Period";
                    "Qualification As Per Deposit" := ("Current Deposits" * ObjLoanType."Shares Multiplier") - "Total Loans Outstanding";
                    "Repayment Frequency" := ObjLoanType."Repayment Frequency";
                end;



                ObjProductDepositLoan.Reset;
                ObjProductDepositLoan.SetCurrentkey(ObjProductDepositLoan."Deposit Multiplier");
                ObjProductDepositLoan.SetRange(ObjProductDepositLoan."Product Code", "Loan Product Type");
                if ObjProductDepositLoan.FindSet then begin
                    repeat
                        if ("Current Deposits" >= ObjProductDepositLoan."Minimum Deposit") and ("Current Deposits" >= ObjProductDepositLoan."Minimum Share Capital") and
                            ("Membership Duration(Years)" >= ObjProductDepositLoan."Minimum No of Membership Month") then begin
                            "Deposit Multiplier" := ObjProductDepositLoan."Deposit Multiplier";
                            Modify;
                        end;
                    until ObjProductDepositLoan.Next = 0;
                end;

                "Qualification As Per Deposit" := ("Current Deposits" * "Deposit Multiplier");
            end;
        }
        field(3; Installments; Integer)
        {

            trigger OnValidate()
            begin

                TotalMRepay := 0;
                LPrincipal := 0;
                LInterest := 0;
                InterestRate := "Interest rate";
                LoanAmount := "Requested Amount";
                RepayPeriod := Installments;
                LBalance := "Requested Amount";





                //Repayments for amortised method
                if "Repayment Method" = "repayment method"::Amortised then begin
                    TestField("Interest rate");
                    TestField(Installments);
                    TotalMRepay := ROUND((InterestRate / 12 / 100) / (1 - Power((1 + (InterestRate / 12 / 100)), -RepayPeriod)) * LoanAmount, 0.05, '>');
                    LInterest := ROUND(LBalance / 100 / 12 * InterestRate, 0.05, '>');
                    LPrincipal := TotalMRepay - LInterest;
                    Repayment := TotalMRepay;
                    "Principle Repayment" := LPrincipal;
                    "Interest Repayment" := LInterest;
                    "Total Monthly Repayment" := "Principle Repayment" + "Interest Repayment" + "Administration Fee";
                    "Average Repayment" := "Total Monthly Repayment" * RepayPeriod / RepayPeriod;

                end;
                //End Repayments for amortised method


                //Repayments for Straight line method

                if "Repayment Method" = "repayment method"::"Straight Line" then begin
                    TestField("Interest rate");
                    TestField(Installments);
                    LPrincipal := ROUND(LoanAmount / RepayPeriod, 0.05, '>');
                    LInterest := ROUND((InterestRate / 12 / 100) * LoanAmount, 0.05, '>');
                    //Grace Period Interest
                    //LInterest:=ROUND((LInterest*InitialInstal)/(InitialInstal-InitialGraceInt),0.05,'>');
                    Repayment := LPrincipal + LInterest;
                    "Principle Repayment" := LPrincipal;
                    "Interest Repayment" := LInterest;
                    "Total Monthly Repayment" := "Principle Repayment" + "Interest Repayment" + "Administration Fee";
                    "Average Repayment" := "Total Monthly Repayment" * RepayPeriod / RepayPeriod;

                end;

                //End Repayments for Straight Line method


                //Repayments for reducing balance method
                if "Repayment Method" = "repayment method"::"Reducing Balance" then begin
                    TestField("Interest rate");
                    TestField(Installments);
                    LPrincipal := ROUND(LoanAmount / RepayPeriod, 0.05, '>');
                    LInterest := ROUND((InterestRate / 12 / 100) * LBalance, 0.05, '>');
                    Repayment := LPrincipal + LInterest;
                    "Principle Repayment" := LPrincipal;
                    "Interest Repayment" := LInterest;
                    "Total Monthly Repayment" := "Principle Repayment" + "Interest Repayment" + "Administration Fee";
                    "Average Repayment" := "Total Monthly Repayment" * RepayPeriod / RepayPeriod;
                    //MESSAGE('%1',RepayPeriod);
                end;
            end;
        }
        field(4; "Principle Repayment"; Decimal)
        {
        }
        field(5; "Interest Repayment"; Decimal)
        {
        }
        field(6; "Total Monthly Repayment"; Decimal)
        {
        }
        field(7; "Product Description"; Text[30])
        {
        }
        field(8; "Interest rate"; Decimal)
        {
        }
        field(9; "Repayment Method"; Option)
        {
            OptionMembers = Amortised,"Reducing Balance","Straight Line",Constants;

            trigger OnValidate()
            begin

                TotalMRepay := 0;
                LPrincipal := 0;
                LInterest := 0;
                InterestRate := "Interest rate";
                LoanAmount := "Requested Amount";
                RepayPeriod := Installments;
                LBalance := "Requested Amount";





                //Repayments for amortised method
                if "Repayment Method" = "repayment method"::Amortised then begin
                    TestField("Interest rate");
                    TestField(Installments);
                    TotalMRepay := ROUND((InterestRate / 12 / 100) / (1 - Power((1 + (InterestRate / 12 / 100)), -RepayPeriod)) * LoanAmount, 0.05, '>');
                    LInterest := ROUND(LBalance / 100 / 12 * InterestRate, 0.05, '>');
                    LPrincipal := TotalMRepay - LInterest;
                    Repayment := TotalMRepay;
                    "Principle Repayment" := LPrincipal;
                    "Interest Repayment" := LInterest;
                    "Total Monthly Repayment" := "Principle Repayment" + "Interest Repayment" + "Administration Fee";
                    "Average Repayment" := "Total Monthly Repayment" * RepayPeriod / RepayPeriod;

                end;
                //End Repayments for amortised method


                //Repayments for Straight line method

                if "Repayment Method" = "repayment method"::"Straight Line" then begin
                    TestField("Interest rate");
                    TestField(Installments);
                    LPrincipal := ROUND(LoanAmount / RepayPeriod, 0.05, '>');
                    LInterest := ROUND((InterestRate / 12 / 100) * LoanAmount, 0.05, '>');
                    //Grace Period Interest
                    //LInterest:=ROUND((LInterest*InitialInstal)/(InitialInstal-InitialGraceInt),0.05,'>');
                    Repayment := LPrincipal + LInterest;
                    "Principle Repayment" := LPrincipal;
                    "Interest Repayment" := LInterest;
                    "Total Monthly Repayment" := "Principle Repayment" + "Interest Repayment" + "Administration Fee";
                    "Average Repayment" := "Total Monthly Repayment" * RepayPeriod / RepayPeriod;

                end;

                //End Repayments for Straight Line method


                //Repayments for reducing balance method
                if "Repayment Method" = "repayment method"::"Reducing Balance" then begin
                    TestField("Interest rate");
                    TestField(Installments);
                    LPrincipal := ROUND(LoanAmount / RepayPeriod, 0.05, '>');
                    LInterest := ROUND((InterestRate / 12 / 100) * LBalance, 0.05, '>');
                    Repayment := LPrincipal + LInterest;
                    "Principle Repayment" := LPrincipal;
                    "Interest Repayment" := LInterest;
                    "Total Monthly Repayment" := "Principle Repayment" + "Interest Repayment" + "Administration Fee";
                    "Average Repayment" := "Total Monthly Repayment" * RepayPeriod / RepayPeriod;
                    //MESSAGE('%1',RepayPeriod);
                end;
            end;
        }
        field(10; "Requested Amount"; Decimal)
        {

            trigger OnValidate()
            begin

                TotalMRepay := 0;
                LPrincipal := 0;
                LInterest := 0;
                InterestRate := "Interest rate";
                LoanAmount := "Requested Amount";
                RepayPeriod := Installments;
                LBalance := "Requested Amount";





                //Repayments for amortised method
                if "Repayment Method" = "repayment method"::Amortised then begin
                    TestField("Interest rate");
                    TestField(Installments);
                    TotalMRepay := ROUND((InterestRate / 12 / 100) / (1 - Power((1 + (InterestRate / 12 / 100)), -RepayPeriod)) * LoanAmount, 0.05, '>');
                    LInterest := ROUND(LBalance / 100 / 12 * InterestRate, 0.05, '>');
                    LPrincipal := TotalMRepay - LInterest;
                    Repayment := TotalMRepay;
                    "Principle Repayment" := LPrincipal;
                    "Interest Repayment" := LInterest;
                    "Total Monthly Repayment" := "Principle Repayment" + "Interest Repayment";
                    "Average Repayment" := "Total Monthly Repayment" * RepayPeriod / RepayPeriod;

                end;
                //End Repayments for amortised method


                //Repayments for Straight line method

                if "Repayment Method" = "repayment method"::"Straight Line" then begin
                    TestField("Interest rate");
                    TestField(Installments);
                    LPrincipal := ROUND(LoanAmount / RepayPeriod, 0.05, '>');
                    LInterest := ROUND((InterestRate / 12 / 100) * LoanAmount, 0.05, '>');
                    //Grace Period Interest
                    //LInterest:=ROUND((LInterest*InitialInstal)/(InitialInstal-InitialGraceInt),0.05,'>');
                    Repayment := LPrincipal + LInterest;
                    "Principle Repayment" := LPrincipal;
                    "Interest Repayment" := LInterest;
                    "Total Monthly Repayment" := "Principle Repayment" + "Interest Repayment" + "Administration Fee";
                    "Average Repayment" := "Total Monthly Repayment" * RepayPeriod / RepayPeriod;

                end;

                //End Repayments for Straight Line method


                //Repayments for reducing balance method
                if "Repayment Method" = "repayment method"::"Reducing Balance" then begin
                    TestField("Interest rate");
                    TestField(Installments);
                    LPrincipal := ROUND(LoanAmount / RepayPeriod, 0.05, '>');
                    LInterest := ROUND((InterestRate / 12 / 100) * LBalance, 0.05, '>');
                    Repayment := LPrincipal + LInterest;
                    "Principle Repayment" := LPrincipal;
                    "Interest Repayment" := LInterest;
                    "Total Monthly Repayment" := "Principle Repayment" + "Interest Repayment" + "Administration Fee";
                    "Average Repayment" := "Total Monthly Repayment" * RepayPeriod / RepayPeriod;
                    //MESSAGE('%1',RepayPeriod);
                end;

                if "Loan Calculator Type" = "loan calculator type"::"Member Specific" then begin
                    //Qualification As Per Salary
                    Psalary := "2/3rds" - "Total Deduction";

                    Msalary := ROUND((Psalary * "Requested Amount") / Repayment, 100, '<');
                    if (Psalary > Repayment) or (Psalary = Repayment) then
                        Msalary := "Requested Amount"
                    else
                        //Msalary:=ROUND((salary*100*Installments)/(100+Installments),100,'<');
                        Msalary := ROUND((Psalary * "Requested Amount") / Repayment, 100, '<');
                    "Qualification As Per Salary" := Msalary;
                    // End Qualification As Per Salary

                    /*//Qualification As Per Deposits
                    ObjLoanType.RESET;
                     ObjLoanType.SETRANGE(ObjLoanType.Code,"Loan Product Type");
                    IF ObjLoanType.FIND('-') THEN BEGIN
                    "Qualification As Per Deposit":=("Current Deposits"*ObjLoanType."Shares Multiplier")-("Total Loans Outstanding"-"Total Loans To Offset");
                      IF "Qualification As Per Deposit">"Requested Amount"THEN
                      "Qualification As Per Deposit":="Requested Amount"
                      ELSE
                      "Qualification As Per Deposit":="Qualification As Per Deposit"
                    END;
                      "Deficit on Deposit":=("Requested Amount"-"Qualification As Per Deposit")/ObjLoanType."Shares Multiplier";
                    //End Qualification As Per Deposits
                    */
                    if "Qualification As Per Deposit" < "Qualification As Per Salary" then
                        "Eligible Amount" := "Qualification As Per Deposit"
                    else
                        if "Qualification As Per Salary" < "Qualification As Per Deposit" then
                            "Eligible Amount" := "Qualification As Per Salary"
                end;

            end;
        }
        field(11; "Administration Fee"; Decimal)
        {
        }
        field(12; Repayment; Decimal)
        {
        }
        field(13; "Average Repayment"; Decimal)
        {
        }
        field(14; "Repayment Start Date"; Date)
        {
        }
        field(15; "Instalment Period"; DateFormula)
        {
        }
        field(16; "Grace Period - Principle (M)"; Integer)
        {
        }
        field(17; "Grace Period - Interest (M)"; Integer)
        {
        }
        field(18; "Eligible Amount"; Decimal)
        {
        }
        field(19; "Princible Repayment 2"; Decimal)
        {
        }
        field(20; "Interest Repayment 2"; Decimal)
        {
        }
        field(21; "Total Monthly Repayment 2"; Decimal)
        {
        }
        field(22; "Total Outstanding Bosa Loans"; Decimal)
        {
        }
        field(23; "Member No"; Code[20])
        {
            TableRelation = Customer."No.";

            trigger OnValidate()
            begin
                ObjCust.Reset;
                ObjCust.SetRange(ObjCust."No.", "Member No");
                if ObjCust.Find('-') then begin
                    ObjCust.CalcFields(ObjCust."Total Loans Outstanding", ObjCust."Current Shares");
                    "Total Loans Outstanding" := ObjCust."Total Loans Outstanding";
                    "Member Name" := ObjCust.Name;
                    "Current Deposits" := ObjCust."Current Shares";
                    "Membership Duration(Years)" := ROUND((WorkDate - ObjCust."Registration Date") / 30, 1, '<');
                    "Member House Group" := ObjCust."Member House Group";
                    "Member House Group Name" := ObjCust."Member House Group Name";
                end;


                "Qualification As Per House" := SFactory.FnGetGroupNetworth("Member House Group");
            end;
        }
        field(24; "Total Loans Outstanding"; Decimal)
        {
        }
        field(25; "Member Name"; Text[50])
        {
        }
        field(26; "Current Deposits"; Decimal)
        {
        }
        field(27; "Net Pay"; Decimal)
        {
        }
        field(28; "Qualification As Per Deposit"; Decimal)
        {
        }
        field(29; "Qualification As Per Salary"; Decimal)
        {
        }
        field(30; "Total Loans To Offset"; Decimal)
        {
            CalcFormula = sum("Loan Calc. Loans to Offset"."Total Top Up" where("Client Code" = field("Member No")));
            FieldClass = FlowField;
        }
        field(31; "Basic Pay"; Decimal)
        {

            trigger OnValidate()
            begin
                //2Thirds
                "2/3rds" := ROUND(("Basic Pay") * 2 / 3, 0.05, '>');
                "1/3rd" := ROUND(("Basic Pay") * 1 / 3, 0.05, '>');
            end;
        }
        field(32; "Total Deduction"; Decimal)
        {
        }
        field(33; "2/3rds"; Decimal)
        {

            trigger OnValidate()
            begin
                "Qualification As Per Salary" := ("2/3rds" * 100 * Installments) / (100 + Installments);
            end;
        }
        field(34; "1/3rd"; Decimal)
        {
        }
        field(35; "Deficit on Deposit"; Decimal)
        {
        }
        field(36; "Repayment Frequency"; Option)
        {
            OptionCaption = 'Daily,Weekly,Monthly,Quaterly';
            OptionMembers = Daily,Weekly,Monthly,Quaterly;
        }
        field(37; "Loan Disbursement Date"; Date)
        {
        }
        field(38; "Loan Principle Repayment"; Decimal)
        {
        }
        field(39; "Loan Interest Repayment"; Decimal)
        {
        }
        field(40; "Loan Calculator Type"; Option)
        {
            OptionCaption = ' ,Member Specific,Product Specific';
            OptionMembers = " ","Member Specific","Product Specific";
        }
        field(41; "One Off Repayment"; Boolean)
        {
        }
        field(42; "Deposit Multiplier"; Decimal)
        {
        }
        field(43; "Membership Duration(Years)"; Integer)
        {
        }
        field(44; "Member House Group"; Code[30])
        {
            Editable = false;
        }
        field(45; "Member House Group Name"; Text[50])
        {
            Editable = false;
        }
        field(46; "Qualification As Per House"; Decimal)
        {
        }
        field(47; "Entry No"; Integer)
        {
            AutoIncrement = true;
        }
    }

    keys
    {
        key(Key1; "Loan Product Type", "Entry No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        "Repayment Start Date" := WorkDate;
    end;

    var
        ObjLoanType: Record "Loan Products Setup";
        TotalMRepay: Decimal;
        LPrincipal: Decimal;
        LInterest: Decimal;
        InterestRate: Decimal;
        LoanAmount: Decimal;
        RepayPeriod: Integer;
        LBalance: Decimal;
        BosaLoans: Record "Loans Register";
        FosaLoans: Record Vendor;
        ObjCust: Record Customer;
        Psalary: Decimal;
        Msalary: Decimal;
        ObjProductDepositLoan: Record "Product Deposit>Loan Analysis";
        SFactory: Codeunit "SURESTEP Factory";
}

