#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50941 "Loan Stages"
{
    //nownPage51516997;
    //nownPage51516997;

    fields
    {
        field(1; "Loan Stage"; Code[20])
        {
        }
        field(2; "Loan Stage Description"; Text[50])
        {
        }
        field(3; "Loan Security Applicable"; Option)
        {
            OptionCaption = 'All,Group Guarantorship,Collateral Security,Education Finance,Declined,Salary Security';
            OptionMembers = All,"Group Guarantorship","Collateral Security","Education Finance",Declined,"Salary Security";
        }
        field(4; "Min Loan Amount"; Decimal)
        {
        }
        field(5; "Max Loan Amount"; Decimal)
        {
        }
        field(6; "Loan Purpose"; Code[20])
        {
            TableRelation = "Loans Purpose".Code;

            trigger OnValidate()
            begin
                if ObjLoanPurpose.Get("Loan Purpose") then
                    "Loan Purpose Description" := ObjLoanPurpose.Description;
            end;
        }
        field(7; "Loan Purpose Description"; Text[60])
        {
        }
        field(8; "Mobile App Specific"; Boolean)
        {
        }
        field(9; "Is Cash Flow Enabled"; Boolean)
        {
        }
        field(10; CompletedDescription; Text[250])
        {
        }
        field(11; DeclinedDescription; Text[250])
        {
        }
    }

    keys
    {
        key(Key1; "Loan Stage", "Loan Stage Description")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        ObjLoanPurpose: Record "Loans Purpose";
}

