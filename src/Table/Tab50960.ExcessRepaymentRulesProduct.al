#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50960 "Excess Repayment Rules Product"
{

    fields
    {
        field(1; "Code"; Code[20])
        {
        }
        field(2; "Loan Product"; Code[20])
        {
            TableRelation = "Loan Products Setup".Code;

            trigger OnValidate()
            begin
                if ObjLoanType.Get("Loan Product") then begin
                    "Product Name" := ObjLoanType."Product Description";
                end;
            end;
        }
        field(3; "Product Name"; Text[50])
        {
        }
        field(4; "Add Type"; Option)
        {
            OptionCaption = 'Exempt,Include';
            OptionMembers = Exempt,Include;
        }
        field(5; "FOSA Account Type"; Code[20])
        {
        }
        field(6; "FOSA Account Name"; Text[50])
        {
        }
    }

    keys
    {
        key(Key1; "Code", "Loan Product")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        ObjLoanType: Record "Loan Products Setup";
}

