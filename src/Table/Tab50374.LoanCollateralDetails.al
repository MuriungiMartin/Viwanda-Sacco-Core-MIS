#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50374 "Loan Collateral Details"
{

    DrillDownPageId = "Loan Collateral Security";
    LookupPageId = "Loan Collateral Security";

    fields
    {
        field(1; "Loan No"; Code[20])
        {
            NotBlank = true;
            TableRelation = "Loans Register"."Loan  No.";

            trigger OnValidate()
            begin
                if LoanApplications.Get("Loan No") then begin
                    "Member No" := LoanApplications."BOSA No";
                    "Loan Type" := LoanApplications."Loan Product Type";
                end
            end;
        }
        field(2; Type; Option)
        {
            NotBlank = true;
            OptionCaption = ' ,Shares,Deposits,Collateral,Fixed Deposit';
            OptionMembers = " ",Shares,Deposits,Collateral,"Fixed Deposit";
        }
        field(3; "Security Details"; Text[150])
        {
        }
        field(4; Remarks; Text[250])
        {
        }
        field(5; "Loan Type"; Code[20])
        {
            TableRelation = "Loan Products Setup"."Source of Financing";
        }
        field(6; Value; Decimal)
        {

            trigger OnValidate()
            begin
                //"Guarantee Value":=Value*0.7;
                if Type = Type::"Fixed Deposit" then
                    Error('The cannot change the value for fixed deposit');
                "Guarantee Value" := (Value * "Collateral Multiplier") - "Comitted Collateral Value";

                //===============Update Collateral Reg Details=================================================
                if ObjCollateralReg.Get("Collateral Registe Doc") then begin
                    "Registered Owner" := ObjCollateralReg."Registered Owner";
                    "Reference No" := ObjCollateralReg."Registration/Reference No";

                    ObjLoans.Reset;
                    ObjLoans.SetRange(ObjLoans."Loan  No.", "Loan No");
                    if ObjLoans.FindSet then begin
                        ObjCollateralReg."Depreciation Completion Date" := ObjLoans."Expected Date of Completion";
                        ObjCollateralReg."Asset Value" := Value;
                        ObjCollateralReg.Modify;
                    end;

                end;
                //===============End Update Collateral Reg Details=================================================
            end;
        }
        field(7; "Guarantee Value"; Decimal)
        {
            Editable = true;
        }
        field(8; "Code"; Code[20])
        {
            TableRelation = "Loan Collateral Set-up".Code;

            trigger OnValidate()
            begin
                //IF SecSetup.GET(Code) THEN BEGIN
                SecSetup.Reset;
                SecSetup.SetRange(SecSetup.Code, Code);
                if SecSetup.Find('-') then begin

                    Type := SecSetup.Type;
                    "Security Details" := SecSetup."Security Description";
                    "Collateral Multiplier" := SecSetup."Collateral Multiplier";
                    "Guarantee Value" := Value * "Collateral Multiplier";
                    Category := SecSetup.Category;

                end;
                //END;

                if ObjLoans.Get("Loan No") then begin
                    "Member No" := ObjLoans."Client Code";
                end;
            end;
        }
        field(9; Category; Option)
        {
            OptionCaption = ' ,Cash,Government Securities,Corporate Bonds,Equity,Morgage Securities';
            OptionMembers = " ",Cash,"Government Securities","Corporate Bonds",Equity,"Morgage Securities";
        }
        field(10; "Collateral Multiplier"; Decimal)
        {

            trigger OnValidate()
            begin
                "Guarantee Value" := "Collateral Multiplier" * Value;
            end;
        }
        field(11; "View Document"; Code[20])
        {

            trigger OnValidate()
            begin
                Hyperlink('C:\SAMPLIR.DOC');
            end;
        }
        field(12; "Assesment Done"; Boolean)
        {
        }
        field(13; "Account No"; Code[20])
        {
            TableRelation = Vendor."No." where("Vendor Posting Group" = const('FIXED'));

            trigger OnValidate()
            begin
                if Vendor.Get("Account No") then begin
                    Vendor.CalcFields(Vendor."Balance (LCY)");
                    Value := Vendor."Balance (LCY)";
                end;
            end;
        }
        field(14; "Registration/Reference No"; Code[50])
        {
        }
        field(16; "Comitted Collateral Value"; Decimal)
        {
        }
        field(17; "Collateral Registe Doc"; Code[50])
        {
            TableRelation = "Loan Collateral Register"."Document No";

            trigger OnValidate()
            begin
                if ObjCollateralReg.Get("Collateral Registe Doc") then begin
                    "Registered Owner" := ObjCollateralReg."Registered Owner";
                    "Reference No" := ObjCollateralReg."Registration/Reference No";
                    Type := ObjCollateralReg."Collateral Type";
                    "Security Details" := ObjCollateralReg."Collateral Description";
                    "Collateral Multiplier" := ObjCollateralReg."Collateral Multiplier";
                    "Guarantee Value" := Value * "Collateral Multiplier";
                    Category := ObjCollateralReg."Collateral Category";
                    "Registration/Reference No" := ObjCollateralReg."Registration/Reference No";
                    Code := ObjCollateralReg."Collateral Code";

                    ObjLoans.Reset;
                    ObjLoans.SetRange(ObjLoans."Loan  No.", "Loan No");
                    if ObjLoans.FindSet then begin
                        ObjCollateralReg."Depreciation Completion Date" := ObjLoans."Expected Date of Completion";
                        ObjCollateralReg."Asset Value" := Value;
                        ObjCollateralReg.Modify;
                    end;

                end;
            end;
        }
        field(18; "Document No"; Code[50])
        {
        }
        field(19; "Registered Owner"; Code[100])
        {
        }
        field(20; "Reference No"; Code[50])
        {
        }
        field(21; "Member No"; Code[50])
        {
        }
        field(22; "Loan Issued Date"; Date)
        {
            CalcFormula = lookup("Loans Register"."Issued Date" where("Loan  No." = field("Loan No")));
            FieldClass = FlowField;
        }
        field(23; "Outstanding Balance"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Transaction Amount" where("Loan No" = field("Loan No"),
                                                                  "Transaction Type" = filter(Loan | "Loan Repayment")));
            FieldClass = FlowField;
        }
        field(24; "Market Value"; Decimal)
        {
        }
        field(25; "Forced Sale Value"; Decimal)
        {
        }

        field(26; "Title Deed No."; Code[40])
        {
        }
    }

    keys
    {
        key(Key1; "Loan No", Type, "Security Details", "Code", "Document No", "Registration/Reference No", "Collateral Registe Doc")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        LoanApplications: Record "Loans Register";
        SecSetup: Record "Loan Collateral Set-up";
        Vendor: Record Vendor;
        Collateral: Record "Loan Collateral Details";
        ObjCollateralReg: Record "Loan Collateral Register";
        ObjLoans: Record "Loans Register";
}

