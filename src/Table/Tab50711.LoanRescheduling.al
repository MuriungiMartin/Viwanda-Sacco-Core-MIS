#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50711 "Loan Rescheduling"
{

    fields
    {
        field(1; "Document No"; Code[50])
        {

            trigger OnValidate()
            begin
                if "Document No" <> xRec."Document No" then begin
                    SalesSetup.Get;
                    NoSeriesMgt.TestManual(SalesSetup."Loan Restructure");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Member No"; Code[20])
        {
            TableRelation = Customer."No.";

            trigger OnValidate()
            begin
                Cust.Reset;
                Cust.SetRange(Cust."No.", "Member No");
                if Cust.Find('-') then begin
                    "Member Name" := Cust.Name;
                end;
            end;
        }
        field(3; "Member Name"; Text[50])
        {
        }
        field(4; "Loan No"; Code[20])
        {
            TableRelation = "Loans Register"."Loan  No." where("Client Code" = field("Member No"));

            trigger OnValidate()
            begin
                LoansRec.Reset;
                LoansRec.SetRange(LoansRec."Loan  No.", "Loan No");
                if LoansRec.Find('-') then begin
                    LoansRec.CalcFields(LoansRec."Outstanding Loan", LoansRec."Outstanding Interest");
                    "Issue Date" := LoansRec."Application Date";
                    "Approved Amount" := LoansRec."Approved Amount";
                    "Outstanding Loan Amount" := LoansRec."Outstanding Loan";//+LoansRec."Outstanding Interest";
                    Validate("Outstanding Loan Amount");
                    "Original Installments" := LoansRec.Installments;
                end;
            end;
        }
        field(5; "Issue Date"; Date)
        {
        }
        field(6; "Approved Amount"; Decimal)
        {
        }
        field(7; "Requested Amount"; Decimal)
        {
        }
        field(8; Status; Option)
        {
            OptionCaption = 'Open,Pending,Approved';
            OptionMembers = Open,Pending,Approved;
        }
        field(10; Rescheduled; Boolean)
        {
        }
        field(11; "Rescheduled By"; Code[50])
        {
        }
        field(12; "Rescheduled Date"; Date)
        {
        }
        field(13; "No. Series"; Code[20])
        {
        }
        field(14; "Repayment Start Date"; Date)
        {
        }
        field(15; "Outstanding Loan Amount"; Decimal)
        {
            Editable = false;
        }
        field(16; "New Installments"; Integer)
        {

            trigger OnValidate()
            begin
                LoansRec.Reset;
                LoansRec.SetRange(LoansRec."Loan  No.", "Loan No");
                if LoansRec.Find('-') then begin
                    LoansRec.CalcFields(LoansRec."Outstanding Balance", LoansRec."Outstanding Interest");
                    InterestRate := LoansRec.Interest;
                    "Approved Amount" := LoansRec."Approved Amount";

                    //"Total Repayment":=0;

                    if "New Installments" <= 0 then
                        Error('Number of installments must be greater than Zero.');



                    //
                    TotalMRepay := 0;
                    LPrincipal := 0;
                    LInterest := 0;
                    InterestRate := LoansRec.Interest;
                    LoanAmount := LoansRec."Outstanding Balance";//+LoansRec."Outstanding Interest";
                    RepayPeriod := "New Installments";
                    LBalance := LoansRec."Outstanding Balance";//+LoansRec."Outstanding Interest";



                    if LoansRec."Repayment Method" = LoansRec."repayment method"::"Straight Line" then begin
                        //TESTFIELD(Installments);
                        LPrincipal := ROUND(LoanAmount / RepayPeriod, 1, '>');
                        LInterest := ROUND((InterestRate / 1200) * LoanAmount, 1, '>');


                        if LoanAmount > 100000 then begin
                            "Repayment Amount" := LPrincipal + LInterest;//+Insuarence
                        end else
                            "Repayment Amount" := LPrincipal + LInterest;
                        "Loan Principle Repayment" := LPrincipal;
                        "Loan Interest Repayment" := LInterest;
                    end;

                    //Monthly Interest Formula PR(T+1)/200T
                    if LoansRec."Repayment Method" = LoansRec."repayment method"::"Reducing Balance" then begin

                        LPrincipal := ROUND(LoanAmount / RepayPeriod, 1, '>'); //ROUND(LoanAmount/RepayPeriod,0.05,'>');
                        LInterest := ROUND(LoanAmount * LoansRec.Interest / 1200);//*(RepayPeriod+1)/(200*RepayPeriod),1,'>');//ROUND((InterestRate/12/100)*LBalance,0.05,'>');
                                                                                  //MESSAGE('Monthly Interest Repayment=%1, Monthly Principal Repayment=%2, ****Total Monthly Repayment=%3***',LInterest,LPrincipal,LPrincipal+LInterest);
                        "Repayment Amount" := LPrincipal + LInterest;
                        "Loan Principle Repayment" := LPrincipal;
                        "Loan Interest Repayment" := LInterest;
                        "Repayment Amount" := TotalMRepay;
                        Modify;
                    end;
                    //SURESTEP

                    //** kencream Sacco
                    // if LoansRec."Repayment Method"=LoansRec."repayment method"::"4" then begin
                    // ;
                    // LPrincipal:=ROUND(LoanAmount/RepayPeriod,1,'>');
                    // LInterest:=ROUND((InterestRate/100)/12*LoanAmount,1,'>')/"New Installments";
                    // "Repayment Amount":=LPrincipal+LInterest;
                    // "Loan Principle Repayment":=LPrincipal;
                    // "Loan Interest Repayment":=LInterest;
                    // Modify;
                    // end;

                    if LoansRec."Repayment Method" = LoansRec."repayment method"::Amortised then begin
                        TotalMRepay := ROUND((InterestRate / 12 / 100) / (1 - Power((1 + (InterestRate / 12 / 100)), -RepayPeriod)) * LoanAmount, 1, '>');
                        LInterest := ROUND(LBalance / 100 / 12 * InterestRate, 0.05, '>');
                        LPrincipal := TotalMRepay - LInterest;
                        "Loan Principle Repayment" := LPrincipal;
                        "Loan Interest Repayment" := LInterest;
                        //"Approved Repayment":=TotalMRepay;
                        "Repayment Amount" := TotalMRepay;
                        Modify;
                    end;
                end;
            end;
        }
        field(17; "Original Installments"; Integer)
        {
        }
        field(18; "Loan Insurance"; Decimal)
        {
        }
        field(19; "Active Schedule"; Boolean)
        {
        }
        field(20; "Repayment Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Loan Principle Repayment"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Loan Interest Repayment"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Document No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "Document No" = '' then begin
            SalesSetup.Get;
            SalesSetup.TestField(SalesSetup."Loan Restructure");
            NoSeriesMgt.InitSeries(SalesSetup."Loan Restructure", xRec."No. Series", 0D, "Document No", "No. Series");
        end;
        "Rescheduled By" := UserId;
    end;

    var
        Cust: Record Customer;
        LoansRec: Record "Loans Register";
        SalesSetup: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        TotalMRepay: Decimal;
        LPrincipal: Decimal;
        LInterest: Decimal;
        InterestRate: Decimal;
        LoanAmount: Decimal;
        RepayPeriod: Integer;
        LBalance: Decimal;

    local procedure getDisbursedAmount(ClientNo: Code[20]; LoanNo: Code[20]): Decimal
    var
        MembLedEntry: Record "Member Ledger Entry";
    begin
        MembLedEntry.Reset;
        MembLedEntry.SetRange(MembLedEntry."Customer No.", ClientNo);
        MembLedEntry.SetRange(MembLedEntry."Loan No", LoanNo);
        MembLedEntry.SetRange(MembLedEntry."Transaction Type", MembLedEntry."transaction type"::Loan);
        if MembLedEntry.FindSet then begin
            MembLedEntry.CalcSums(MembLedEntry.Amount);
            exit(MembLedEntry.Amount);
        end;
    end;
}

