#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50959 "Excess Repayment Rules"
{

    fields
    {
        field(1; "Code"; Code[30])
        {
        }
        field(2; Description; Text[50])
        {
        }
        field(3; "Account Type Affected"; Code[30])
        {
            TableRelation = "Account Types-Saving Products".Code;

            trigger OnValidate()
            begin
                if ObjAccountType.Get("Account Type Affected") then begin
                    "Account Name" := ObjAccountType.Description;
                end;
            end;
        }
        field(4; "Account Name"; Text[50])
        {
        }
        field(5; "Loan Recovery Priority"; Option)
        {
            OptionCaption = ' ,Exempt From Excess Rule,Biggest Loan,Smallest Loan,Oldest Loan,Newest Loan';
            OptionMembers = " ","Exempt From Excess Rule","Biggest Loan","Smallest Loan","Oldest Loan","Newest Loan";
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        ObjAccountType: Record "Account Types-Saving Products";
}

