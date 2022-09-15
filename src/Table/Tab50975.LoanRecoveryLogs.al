#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50975 "Loan Recovery Logs"
{

    fields
    {
        field(1; "Entry No"; Integer)
        {
        }
        field(2; "Member No"; Code[30])
        {
            TableRelation = Customer."No.";
        }
        field(3; "Member Name"; Code[100])
        {
        }
        field(4; "Loan No"; Code[30])
        {
            TableRelation = "Loans Register"."Loan  No." where("Client Code" = field("Member No"),
                                                                "Outstanding Loan" = filter(> 0));

            trigger OnValidate()
            begin
                if ObjLoans.Get("Loan No") then begin
                    ObjLoans.CalcFields(ObjLoans."Outstanding Balance");
                    "Loan Product Type" := ObjLoans."Loan Product Type";
                    "Loan Balance" := ObjLoans."Outstanding Balance";
                    "Loan Product Name" := ObjLoans."Loan Product Type Name";
                    "Loan Arrears Days" := ObjLoans."Days In Arrears";
                    "Loan Amount In Arrears" := ObjLoans."Amount in Arrears";
                end;
            end;
        }
        field(5; "Loan Product Type"; Code[50])
        {
        }
        field(6; "Loan Balance"; Decimal)
        {
        }
        field(7; "Log Date"; Date)
        {
        }
        field(8; "User ID"; Code[30])
        {
        }
        field(9; "Log Description"; Text[250])
        {
        }
        field(10; "Loan Product Name"; Text[100])
        {
        }
        field(11; "Loan Amount In Arrears"; Decimal)
        {
        }
        field(12; "Loan Arrears Days"; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Entry No", "Member No", "Member Name")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        ObjLoanRecoveryLogs.Reset;
        ObjLoanRecoveryLogs.SetCurrentkey(ObjLoanRecoveryLogs."Entry No");
        if ObjLoanRecoveryLogs.FindLast then begin
            "Entry No" := ObjLoanRecoveryLogs."Entry No" + 1;
            "Log Date" := WorkDate;
            "User ID" := UserId;
        end else
            "Entry No" := 1;
    end;

    var
        ObjLoanRecoveryLogs: Record "Loan Recovery Logs";
        ObjLoans: Record "Loans Register";
}

