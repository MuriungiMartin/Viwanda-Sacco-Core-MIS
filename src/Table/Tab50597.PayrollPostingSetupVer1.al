#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50597 "Payroll Posting Setup Ver1"
{

    fields
    {
        field(1; "Transaction Code"; Code[30])
        {
        }
        field(2; "Transaction Description"; Text[250])
        {
        }
        field(3; "Debit G/L Account"; Code[30])
        {
            TableRelation = "G/L Account";

            trigger OnValidate()
            begin
                if ObjGLAccounts.Get("Debit G/L Account") then
                    "Debit G/L Account Name" := ObjGLAccounts.Name;
            end;
        }
        field(4; "Debit G/L Account Name"; Text[150])
        {
            Editable = false;
        }
        field(5; "Credit G/L Account"; Code[30])
        {
            TableRelation = "G/L Account";

            trigger OnValidate()
            begin
                if ObjGLAccounts.Get("Credit G/L Account") then
                    "Credit G/L Account Name" := ObjGLAccounts.Name;
            end;
        }
        field(6; "Credit G/L Account Name"; Text[150])
        {
            Editable = false;
        }
        field(7; "Sacco Deduction Type"; Option)
        {
            OptionCaption = ' ,Deposits Contribution,Loan Repayments';
            OptionMembers = " ","Deposits Contribution","Loan Repayments";
        }
    }

    keys
    {
        key(Key1; "Transaction Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        ObjGLAccounts: Record "G/L Account";
}

