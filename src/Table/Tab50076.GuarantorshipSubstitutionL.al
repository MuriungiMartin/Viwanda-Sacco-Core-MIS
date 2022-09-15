#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50076 "Guarantorship Substitution L"
{
    // //nownPage51516389;
    // //nownPage51516389;

    fields
    {
        field(1; "Document No"; Code[20])
        {
            Editable = false;
            TableRelation = "Guarantorship Substitution H"."Document No";
        }
        field(2; "Loan No."; Code[20])
        {
            Editable = false;

            trigger OnValidate()
            begin
                if Loans.Get("Loan No.") then begin
                    Loans.CalcFields(Loans."Outstanding Balance", Loans."Outstanding Interest");
                    "Loan Type" := Loans."Loan Product Type";
                    "Approved Loan Amount" := Loans."Approved Amount";
                    "Loan Instalments" := Loans.Installments;
                    "Monthly Repayment" := Loans.Repayment;
                    "Outstanding Balance" := Loans."Outstanding Balance";
                    "Outstanding Interest" := Loans."Outstanding Interest";
                end;

                ObjLoanGuar.Reset;
                ObjLoanGuar.SetRange(ObjLoanGuar."Loan No", "Loan No.");

                if ObjLoanGuar.FindSet then begin
                    TGrAmount := 0;
                    GrAmount := 0;
                    FGrAmount := 0;
                    repeat
                        GrAmount := ObjLoanGuar."Amont Guaranteed";
                        TGrAmount := TGrAmount + GrAmount;
                        FGrAmount := TGrAmount + ObjLoanGuar."Amont Guaranteed";
                    until ObjLoanGuar.Next = 0;
                end;

                ObjLoanGuar.Reset;
                ObjLoanGuar.SetRange(ObjLoanGuar."Loan No", "Loan No.");
                ObjLoanGuar.SetRange(ObjLoanGuar."Member No", "Member No");
                if ObjLoanGuar.FindSet then begin
                    "Amount Guaranteed" := ObjLoanGuar."Amont Guaranteed";
                    "Current Commitment" := ObjLoanGuar."Amont Guaranteed";
                end;
            end;
        }
        field(3; "Member No"; Code[20])
        {
            Editable = false;

            trigger OnValidate()
            begin
                if Cust.Get("Member No") then begin
                    "Member Name" := Cust.Name;
                    "ID. NO" := Cust."ID No.";
                    "Staff No" := Cust."Payroll No";
                end;
            end;
        }
        field(4; "Loan Type"; Code[20])
        {
            Editable = false;
        }
        field(5; "Approved Loan Amount"; Decimal)
        {
        }
        field(6; "Loan Instalments"; Decimal)
        {
        }
        field(7; "Monthly Repayment"; Decimal)
        {
        }
        field(8; "Outstanding Balance"; Decimal)
        {
        }
        field(9; "Outstanding Interest"; Decimal)
        {
        }
        field(10; "Interest Rate"; Decimal)
        {
        }
        field(11; "ID. NO"; Code[20])
        {
        }
        field(12; "Staff No"; Code[20])
        {
        }
        field(13; Posted; Boolean)
        {
        }
        field(14; "Posting Date"; Date)
        {
        }
        field(15; "Amount Guaranteed"; Decimal)
        {
            Editable = true;
        }
        field(16; "Member Name"; Code[60])
        {
            Editable = false;
        }
        field(17; Substituted; Boolean)
        {
            Editable = true;
        }
        field(18; "Current Commitment"; Decimal)
        {
            Editable = false;
        }
        field(19; "Substitute Member"; Code[20])
        {
            TableRelation = Customer."No." where(Status = const(Active));

            trigger OnValidate()
            begin
                if Cust.Get("Substitute Member") then begin
                    "Substitute Member Name" := Cust.Name;
                    "Sub Amount Guaranteed" := "Current Commitment";
                end;
            end;
        }
        field(20; "Substitute Member Name"; Code[60])
        {
        }
        field(21; "Sub Amount Guaranteed"; Decimal)
        {

            trigger OnValidate()
            begin
                if "Sub Amount Guaranteed" < "Current Commitment" then
                    "Partial Substitution" := true;

                //IF "Partial Substitution" THEN
                BalAmount := ("Current Commitment" + "Sub Amount Guaranteed") - "Sub Amount Guaranteed";
                // MESSAGE('%1',BalAmount);
            end;
        }
        field(22; Relax; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Partial Substitution"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Document No", "Member No", "Loan No.", "Substitute Member")
        {
            Clustered = true;
            SumIndexFields = "Monthly Repayment", "Approved Loan Amount";
        }
        key(Key2; "Approved Loan Amount")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Member No", "Loan Type", "Approved Loan Amount", "Loan Instalments", "Monthly Repayment", "Outstanding Balance", "Outstanding Interest", "Interest Rate", "ID. NO", Posted)
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
        ObjLoanGuar: Record "Loans Guarantee Details";
        TGrAmount: Decimal;
        GrAmount: Decimal;
        FGrAmount: Decimal;
        BalAmount: Decimal;
}

