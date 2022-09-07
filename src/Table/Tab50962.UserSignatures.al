#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50962 "User Signatures"
{

    fields
    {
        field(1; "User ID"; Code[20])
        {
            TableRelation = User."User Name";

            trigger OnLookup()
            begin
                // UserMgnt.LookupUserID("User ID");
            end;

            trigger OnValidate()
            begin
                //  UserMgnt.ValidateUserID("User ID");
            end;
        }
        field(2; Designation; Code[50])
        {
        }
        field(3; Signature; MediaSet)
        {
        }
        field(4; Process; Option)
        {
            OptionCaption = ' ,Demand Notice,CRB Notice,Auctioneer Notice,Loan Repayment Schedule';
            OptionMembers = " ","Demand Notice","CRB Notice","Auctioneer Notice","Loan Repayment Schedule";
        }
    }

    keys
    {
        key(Key1; "User ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        UserMgnt: Codeunit "User Management";
}

