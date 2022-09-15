#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50978 "Loan Restructure"
{

    fields
    {
        field(1; "Document No"; Code[30])
        {
            Editable = false;

            trigger OnValidate()
            begin
                if "Document No" <> xRec."Document No" then begin
                    SalesSetup.Get;
                    NoSeriesMgt.TestManual(SalesSetup."Loan Restructure");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Member No"; Code[30])
        {
            TableRelation = Customer."No.";

            trigger OnValidate()
            begin
                if ObjCust.Get("Member No") then begin
                    "Member Name" := ObjCust.Name;
                end;
            end;
        }
        field(3; "Member Name"; Text[100])
        {
            Editable = false;
        }
        field(4; "Loan to Restructure"; Code[30])
        {
            TableRelation = "Loans Register"."Loan  No." where("Client Code" = field("Member No"),
                                                                "Outstanding Balance" = filter(> 0));

            trigger OnValidate()
            begin
                ObjLoans.CalcFields(ObjLoans."Outstanding Balance");
                if ObjLoans.Get("Loan to Restructure") then begin
                    "Loan Product Type" := ObjLoans."Loan Product Type";
                    "Loan Product Name" := ObjLoans."Loan Product Type Name";
                    "Approved Amount" := ObjLoans."Approved Amount";
                    "Loan Interest Rate" := ObjLoans.Interest;
                    "Initial Instalment" := ObjLoans.Installments;
                    "Loan Issued Date" := ObjLoans."Issued Date";
                    "Branch Code" := ObjLoans."Branch Code";
                    "Current Payoff Amount" := SFactory.FnRunGetLoanPayoffAmountRestructure("Loan to Restructure");
                    FnRunGetRemainingPeriod;
                end;
            end;
        }
        field(5; "Loan Product Type"; Code[30])
        {
            Editable = false;
        }
        field(6; "Loan Product Name"; Text[100])
        {
            Editable = false;
        }
        field(7; "Approved Amount"; Decimal)
        {
            Editable = false;
        }
        field(8; "Current Payoff Amount"; Decimal)
        {
            Editable = false;
        }
        field(9; "Initial Instalment"; Integer)
        {
            Editable = false;
        }
        field(10; "New Loan Period"; Integer)
        {

            trigger OnValidate()
            begin
                //==================================================================================================================Amortised

                if "Repayment Method" = "repayment method"::Amortised then begin
                    VarTotalMRepay := ROUND(("Loan Interest Rate" / 12 / 100) / (1 - Power((1 + ("Loan Interest Rate" / 12 / 100)), -"New Loan Period")) * "Current Payoff Amount", 1, '>');
                    VarLInterest := ROUND("Current Payoff Amount" / 100 / 12 * "Loan Interest Rate", 0.05, '>');
                end;

                //==================================================================================================================Straight Line

                if "Repayment Method" = "repayment method"::"Straight Line" then begin
                    VarLPrincipal := ROUND("Current Payoff Amount" / "New Loan Period", 1, '>');
                    VarLInterest := ROUND(("Loan Interest Rate" / 1200) * "Current Payoff Amount", 1, '>');
                    VarTotalMRepay := VarLPrincipal + VarLInterest;
                end;

                //==================================================================================================================Get Insurance Amount
                ObjProductCharge.Reset;
                ObjProductCharge.SetRange(ObjProductCharge."Product Code", "Loan Product Type");
                ObjProductCharge.SetRange(ObjProductCharge."Loan Charge Type", ObjProductCharge."loan charge type"::"Loan Insurance");
                if ObjProductCharge.FindSet then begin
                    VarLInsurance := "Current Payoff Amount" * (ObjProductCharge.Percentage / 100);
                end;

                "New Monthly Repayment" := VarTotalMRepay + VarLInsurance;
            end;
        }
        field(11; "New Monthly Repayment"; Decimal)
        {
            Editable = false;
        }
        field(12; "Application Date"; Date)
        {
            Editable = false;
        }
        field(13; "User ID"; Code[30])
        {
            Editable = false;
        }
        field(14; "No. Series"; Code[30])
        {
        }
        field(15; "Repayment Method"; Option)
        {
            Editable = false;
            OptionCaption = 'Amortised,Reducing Balance,Straight Line,Constants';
            OptionMembers = Amortised,"Reducing Balance","Straight Line",Constants;
        }
        field(16; "Loan Issued Date"; Date)
        {
            Editable = false;
        }
        field(17; "Initial Monthly Repayment"; Decimal)
        {
            Editable = false;
        }
        field(18; "Remaining Period(Months)"; Integer)
        {
            Editable = false;
        }
        field(19; "Loan Interest Rate"; Decimal)
        {
            Editable = false;
        }
        field(20; Status; Option)
        {
            OptionCaption = 'Open,Pending Approval,Approved,Rejected';
            OptionMembers = Open,"Pending Approval",Approved,Rejected;
        }
        field(21; "Branch Code"; Code[30])
        {
        }
        field(22; "Date Restructure"; Date)
        {
            Editable = false;
        }
        field(23; "Restructured By"; Code[30])
        {
            Editable = false;
        }
        field(24; "New Repayment Start Date"; Date)
        {
        }
        field(25; Effected; Boolean)
        {
        }
        field(26; "Grace Period"; Integer)
        {
        }
        field(27; "New Loan No"; Code[30])
        {
        }
        field(28; "Reason For Restructure"; Text[150])
        {
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

        "Application Date" := WorkDate;
        "User ID" := UserId;
    end;

    var
        ObjCust: Record Customer;
        ObjLoans: Record "Loans Register";
        SalesSetup: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        ObjLoanRepaymentSchedule: Record "Loan Repayment Schedule";
        SFactory: Codeunit "SURESTEP Factory";
        VarTotalMRepay: Decimal;
        VarLInterest: Decimal;
        ObjProductCharge: Record "Loan Product Charges";
        VarLPrincipal: Decimal;
        VarLInsurance: Decimal;

    local procedure FnRunGetRemainingPeriod()
    begin
        ObjLoanRepaymentSchedule.Reset;
        ObjLoanRepaymentSchedule.SetCurrentkey(ObjLoanRepaymentSchedule."Repayment Date");
        ObjLoanRepaymentSchedule.SetRange(ObjLoanRepaymentSchedule."Loan No.", "Loan to Restructure");
        ObjLoanRepaymentSchedule.SetFilter(ObjLoanRepaymentSchedule."Repayment Date", '>=%1', WorkDate);
        if ObjLoanRepaymentSchedule.FindSet then begin
            "Remaining Period(Months)" := ObjLoanRepaymentSchedule.Count;
            "Initial Monthly Repayment" := ObjLoanRepaymentSchedule."Monthly Repayment";
        end;
    end;
}

