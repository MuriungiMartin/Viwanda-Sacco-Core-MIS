#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50940 "Member Agent/Next Of Kin Chang"
{

    fields
    {
        field(1; "Document No"; Code[20])
        {

            trigger OnValidate()
            begin
                if "Document No" <> xRec."Document No" then begin
                    SalesSetup.Get;
                    NoSeriesMgt.TestManual(SalesSetup."Member Agent/NOK Change");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Member No"; Code[20])
        {
            TableRelation = Customer."No.";

            trigger OnValidate()
            begin
                /*IF ObjCust.GET("Member No") THEN BEGIN
                  "Member Name":=ObjCust.Name;
                  END;
                  */

            end;
        }
        field(3; "Member Name"; Code[50])
        {
        }
        field(4; "Account Type"; Option)
        {
            OptionCaption = ' ,BOSA,FOSA';
            OptionMembers = " ",BOSA,FOSA;

            trigger OnValidate()
            begin
                /*IF "Account Type"="Account Type"::BOSA THEN
                  BEGIN
                    "Account No":="Member No";
                    END;*/

            end;
        }
        field(5; "Account No"; Code[30])
        {
            TableRelation = if ("Account Type" = filter(BOSA)) Customer."No."
            else
            if ("Account Type" = filter(FOSA)) Vendor."No." where("BOSA Account No" = field("Member No"));
        }
        field(6; "Change Type"; Option)
        {
            OptionCaption = ' ,Account Agent Change,Account Next Of Kin Change,Account Signatory Change';
            OptionMembers = " ","Account Agent Change","Account Next Of Kin Change","Account Signatory Change";

            trigger OnValidate()
            begin
                if ("Change Type" = "change type"::"Account Signatory Change") and ("Account Type" = "account type"::FOSA) then begin
                    FnRunMemberSignatoryDetailsChange("Document No", "Account No");
                end;


                if ("Account Type" = "account type"::BOSA) and ("Change Type" = "change type"::"Account Next Of Kin Change") then begin
                    FnRunMemberNextofKinChange("Document No");
                end;

                if ("Account Type" = "account type"::BOSA) and ("Change Type" = "change type"::"Account Agent Change") then begin
                    FnRunMemberAgentDetailsChange("Document No");
                end;

                if ("Account Type" = "account type"::FOSA) and ("Change Type" = "change type"::"Account Next Of Kin Change") then begin
                    FnRunAccountNextofKinChange("Document No");
                end;

                if ("Account Type" = "account type"::FOSA) and ("Change Type" = "change type"::"Account Agent Change") then begin
                    FnRunAccountAgentDetailsChange("Document No");
                end;
            end;
        }
        field(7; "Captured By"; Code[20])
        {
        }
        field(8; "Captured On"; Date)
        {
        }
        field(9; "No. Series"; Code[20])
        {
        }
        field(15; "Change Effected"; Boolean)
        {
        }
        field(16; Status; Option)
        {
            OptionCaption = 'Open,Pending Approval,Approved,Rejected';
            OptionMembers = Open,"Pending Approval",Approved,Rejected;
        }
        field(17; "Change Effected On"; Date)
        {
        }
        field(18; "Change Effected By"; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "Document No", "Account No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Document No", "Member No", "Member Name", "Account Type")
        {
        }
    }

    trigger OnInsert()
    begin
        if "Document No" = '' then begin
            SalesSetup.Get;
            SalesSetup.TestField(SalesSetup."Member Agent/NOK Change");
            NoSeriesMgt.InitSeries(SalesSetup."Member Agent/NOK Change", xRec."No. Series", 0D, "Document No", "No. Series");
        end;

        "Captured On" := Today;
        "Captured By" := UserId;
    end;

    var
        SalesSetup: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        ObjAccount: Record Vendor;
        ObjCust: Record Customer;
        ObjLoans: Record "Loans Register";
        ObjSurestep: Codeunit "SURESTEP Factory";
        VarAmountInArrears: Decimal;
        ObjHouses: Record "Member House Groups";
        ObjMemberNextofKinChange: Record "Member NOK Change Request";
        ObjMemberAccountAgent: Record "Account Agents Change Request";
        ObjMemberNOKDetails: Record "Members Next of Kin";
        ObjAccountNOKDetails: Record "FOSA Account NOK Details";
        ObjAccountAgentDetails: Record "Account Agent Details";
        ObjMemberAgentDetails: Record "Member Agent Details";
        ObjNOKAgentChange: Record "Member Agent/Next Of Kin Chang";
        ObjMemberSignatories: Record "FOSA Account Sign. Details";
        ObjMemberSignatoriesChange: Record "Member Acc. Signatories Change";

    local procedure FnRunAccountNextofKinChange(DocumentNo: Code[30])
    begin
        ObjNOKAgentChange.Reset;
        ObjNOKAgentChange.SetRange(ObjNOKAgentChange."Document No", DocumentNo);
        ObjNOKAgentChange.SetRange(ObjNOKAgentChange."Account Type", ObjNOKAgentChange."account type"::FOSA);
        ObjNOKAgentChange.SetRange(ObjNOKAgentChange."Change Type", ObjNOKAgentChange."change type"::"Account Next Of Kin Change");
        if ObjNOKAgentChange.FindSet then begin
            ObjAccountNOKDetails.Reset;
            ObjAccountNOKDetails.SetRange(ObjAccountNOKDetails."Account No", ObjNOKAgentChange."Account No");
            if ObjAccountNOKDetails.FindSet then begin
                repeat

                    ObjMemberNextofKinChange.Init;
                    ObjMemberNextofKinChange."Document No" := "Document No";
                    ObjMemberNextofKinChange.Name := UpperCase(ObjAccountNOKDetails.Name);
                    ObjMemberNextofKinChange.Address := ObjAccountNOKDetails.Address;
                    ObjMemberNextofKinChange."ID No." := ObjAccountNOKDetails."ID No.";
                    ObjMemberNextofKinChange."Account No" := ObjAccountNOKDetails."Account No";
                    ObjMemberNextofKinChange."%Allocation" := ObjAccountNOKDetails."%Allocation";
                    ObjMemberNextofKinChange."Next Of Kin Type" := ObjAccountNOKDetails."Next Of Kin Type";
                    ObjMemberNextofKinChange.Insert;
                until ObjAccountNOKDetails.Next = 0;
            end;
        end;
    end;

    local procedure FnRunMemberNextofKinChange(DocumentNo: Code[30])
    begin

        ObjNOKAgentChange.Reset;
        ObjNOKAgentChange.SetRange(ObjNOKAgentChange."Document No", DocumentNo);
        ObjNOKAgentChange.SetRange(ObjNOKAgentChange."Account Type", ObjNOKAgentChange."account type"::BOSA);
        ObjNOKAgentChange.SetRange(ObjNOKAgentChange."Change Type", ObjNOKAgentChange."change type"::"Account Next Of Kin Change");
        if ObjNOKAgentChange.FindSet then begin
            ObjMemberNOKDetails.Reset;
            ObjMemberNOKDetails.SetRange(ObjMemberNOKDetails."Account No", "Member No");
            if ObjMemberNOKDetails.FindSet then begin
                repeat

                    ObjMemberNextofKinChange.Init;
                    ObjMemberNextofKinChange."Document No" := "Document No";
                    ObjMemberNextofKinChange.Name := UpperCase(ObjMemberNOKDetails.Name);
                    ObjMemberNextofKinChange.Address := ObjMemberNOKDetails.Address;
                    ObjMemberNextofKinChange."ID No." := ObjMemberNOKDetails."ID No.";
                    ObjMemberNextofKinChange."Account No" := ObjMemberNOKDetails."Account No";
                    ObjMemberNextofKinChange."%Allocation" := ObjMemberNOKDetails."%Allocation";
                    ObjMemberNextofKinChange."Next Of Kin Type" := ObjMemberNOKDetails."Next Of Kin Type";
                    ObjMemberNextofKinChange.Insert;
                until ObjMemberNOKDetails.Next = 0;
            end;
        end;
    end;

    local procedure FnRunAccountAgentDetailsChange(DocumentNo: Code[30])
    begin
        ObjNOKAgentChange.Reset;
        ObjNOKAgentChange.SetRange(ObjNOKAgentChange."Document No", DocumentNo);
        ObjNOKAgentChange.SetRange(ObjNOKAgentChange."Account Type", ObjNOKAgentChange."account type"::FOSA);
        ObjNOKAgentChange.SetRange(ObjNOKAgentChange."Change Type", ObjNOKAgentChange."change type"::"Account Agent Change");
        if ObjNOKAgentChange.FindSet then begin
            ObjAccountAgentDetails.Reset;
            ObjAccountAgentDetails.SetRange(ObjAccountAgentDetails."Account No", ObjNOKAgentChange."Account No");
            if ObjAccountAgentDetails.FindSet then begin
                repeat

                    ObjMemberAccountAgent.Init;
                    ObjMemberAccountAgent."Document No" := "Document No";
                    ObjMemberAccountAgent.Names := UpperCase(ObjAccountAgentDetails.Names);
                    ObjMemberAccountAgent."ID No." := ObjAccountAgentDetails."ID No.";
                    ObjMemberAccountAgent."Account No" := ObjAccountAgentDetails."Account No";
                    ObjMemberAccountAgent."Mobile No." := ObjAccountAgentDetails."Mobile No.";
                    ObjMemberAccountAgent."Expiry Date" := ObjAccountAgentDetails."Expiry Date";
                    ObjMemberAccountAgent."Allowed  Correspondence" := ObjAccountAgentDetails."Allowed  Correspondence";
                    ObjMemberAccountAgent."Allowed Balance Enquiry" := ObjAccountAgentDetails."Allowed Balance Enquiry";
                    ObjMemberAccountAgent."Allowed FOSA Withdrawals" := ObjAccountAgentDetails."Allowed FOSA Withdrawals";
                    ObjMemberAccountAgent."Allowed Loan Processing" := ObjAccountAgentDetails."Allowed Loan Processing";
                    ObjMemberAccountAgent.Insert;
                until ObjAccountAgentDetails.Next = 0;
            end;
        end;
    end;

    local procedure FnRunMemberAgentDetailsChange(DocumentNo: Code[30])
    begin
        ObjNOKAgentChange.Reset;
        ObjNOKAgentChange.SetRange(ObjNOKAgentChange."Document No", DocumentNo);
        ObjNOKAgentChange.SetRange(ObjNOKAgentChange."Account Type", ObjNOKAgentChange."account type"::BOSA);
        ObjNOKAgentChange.SetRange(ObjNOKAgentChange."Change Type", ObjNOKAgentChange."change type"::"Account Agent Change");
        if ObjNOKAgentChange.FindSet then begin
            ObjMemberAgentDetails.Reset;
            ObjMemberAgentDetails.SetRange(ObjMemberAgentDetails."Account No", ObjNOKAgentChange."Member No");
            if ObjMemberAgentDetails.FindSet then begin
                repeat

                    ObjMemberAccountAgent.Init;
                    ObjMemberAccountAgent."Document No" := "Document No";
                    ObjMemberAccountAgent.Names := UpperCase(ObjMemberAgentDetails.Names);
                    ObjMemberAccountAgent."ID No." := ObjMemberAgentDetails."ID No.";
                    ObjMemberAccountAgent."Account No" := ObjMemberAgentDetails."Account No";
                    ObjMemberAccountAgent."Mobile No." := ObjMemberAgentDetails."Mobile No.";
                    ObjMemberAccountAgent."Expiry Date" := ObjMemberAgentDetails."Expiry Date";
                    ObjMemberAccountAgent."Allowed  Correspondence" := ObjMemberAgentDetails."Allowed  Correspondence";
                    ObjMemberAccountAgent."Allowed Balance Enquiry" := ObjMemberAgentDetails."Allowed Balance Enquiry";
                    ObjMemberAccountAgent."Allowed FOSA Withdrawals" := ObjMemberAgentDetails."Allowed FOSA Withdrawals";
                    ObjMemberAccountAgent."Allowed Loan Processing" := ObjMemberAgentDetails."Allowed Loan Processing";
                    ObjMemberAccountAgent.Insert;
                until ObjMemberAgentDetails.Next = 0;
            end;
        end;
    end;

    local procedure FnRunMemberSignatoryDetailsChange(DocumentNo: Code[30]; VarAccountNo: Code[30])
    begin
        ObjMemberSignatoriesChange.Reset;
        ObjMemberSignatoriesChange.SetRange(ObjMemberSignatoriesChange."Document No", DocumentNo);
        if ObjMemberSignatoriesChange.FindSet then begin
            ObjMemberSignatoriesChange.DeleteAll;
        end;


        ObjMemberSignatories.Reset;
        ObjMemberSignatories.SetRange(ObjMemberSignatories."Account No", VarAccountNo);
        if ObjMemberSignatories.FindSet then begin
            repeat
                ObjMemberSignatoriesChange.Init;
                ObjMemberSignatoriesChange."Document No" := DocumentNo;
                ObjMemberSignatoriesChange.Names := UpperCase(ObjMemberSignatories.Names);
                ObjMemberSignatoriesChange."ID No." := ObjMemberSignatories."ID No.";
                ObjMemberSignatoriesChange."Account No" := ObjMemberSignatories."Account No";
                ObjMemberSignatoriesChange."Mobile Phone No" := ObjMemberSignatories."Mobile No";
                ObjMemberSignatoriesChange."Expiry Date" := ObjMemberSignatories."Expiry Date";
                ObjMemberSignatoriesChange.Signatory := ObjMemberSignatories.Signatory;
                ObjMemberSignatoriesChange."Must be Present" := ObjMemberSignatories."Must be Present";
                ObjMemberSignatoriesChange."Member No." := ObjMemberSignatories."Member No.";
                ObjMemberSignatoriesChange."Email Address" := ObjMemberSignatories."Email Address";
                ObjMemberSignatoriesChange."Withdrawal Limit" := ObjMemberSignatories."Withdrawal Limit";
                ObjMemberSignatoriesChange."Mobile Banking Limit" := ObjMemberSignatories."Mobile Banking Limit";
                ObjMemberSignatoriesChange."Signed Up For Mobile Banking" := ObjMemberSignatories."Signed Up For Mobile Banking";
                ObjMemberSignatoriesChange."Operating Instructions" := ObjMemberSignatories."Operating Instructions";
                ObjMemberSignatoriesChange.Insert;

            until ObjMemberSignatories.Next = 0;
        end;

    end;
}

