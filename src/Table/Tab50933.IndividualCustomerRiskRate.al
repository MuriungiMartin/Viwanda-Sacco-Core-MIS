#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50933 "Individual Customer Risk Rate"
{

    fields
    {
        field(1; "Membership Application No"; Code[20])
        {

            trigger OnValidate()
            begin
                if ObjMemberApplication.Get("Membership Application No") then begin
                    "Member Name" := ObjMemberApplication.Name;
                    "Member ID" := ObjMemberApplication."ID No.";
                end;
            end;
        }
        field(2; "Member Name"; Code[50])
        {
        }
        field(3; "Member ID"; Code[30])
        {
        }
        field(4; "What is the Customer Category?"; Text[60])
        {
        }
        field(5; "Customer Category Score"; Decimal)
        {
        }
        field(6; "What is the Member residency?"; Text[60])
        {
        }
        field(7; "Member Residency Score"; Decimal)
        {
        }
        field(8; "Cust Employment Risk?"; Text[60])
        {
            Description = 'What Is the Industry Type?';
        }
        field(9; "Cust Employment Risk Score"; Decimal)
        {
        }
        field(10; "Cust Business Risk Industry?"; Text[60])
        {
        }
        field(11; "Cust Bus. Risk Industry Score"; Decimal)
        {
        }
        field(12; "Lenght Of Relationship?"; Text[60])
        {
            Description = 'What Is the Lenght Of the Relationship';
        }
        field(13; "Length Of Relation Score"; Decimal)
        {
        }
        field(14; "Cust Involved in Intern. Trade"; Text[60])
        {
            Description = 'Is the customer involved in International Trade?';
        }
        field(15; "Involve in Inter. Trade Score"; Decimal)
        {
        }
        field(16; "Account Type Taken?"; Text[60])
        {
        }
        field(17; "Account Type Taken Score"; Decimal)
        {
        }
        field(18; "Card Type Taken"; Text[60])
        {
        }
        field(19; "Card Type Taken Score"; Decimal)
        {
        }
        field(20; "Channel Taken?"; Text[60])
        {
        }
        field(21; "Channel Taken Score"; Decimal)
        {
        }
        field(22; "GROSS CUSTOMER AML RISK RATING"; Decimal)
        {
        }
        field(23; "BANK'S CONTROL RISK RATING"; Decimal)
        {
        }
        field(24; "CUSTOMER NET RISK RATING"; Decimal)
        {
        }
        field(25; "Electronic Payments?"; Text[60])
        {
        }
        field(26; "Electronic Payments Score"; Decimal)
        {
        }
        field(27; "Risk Rate Scale"; Option)
        {
            OptionCaption = 'Low Risk,Medium Risk,High Risk';
            OptionMembers = "Low Risk","Medium Risk","High Risk";
        }
        field(28; "Referee Score"; Decimal)
        {
        }
        field(29; "Member Referee Rate"; Text[150])
        {
        }
    }

    keys
    {
        key(Key1; "Membership Application No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        ObjMemberApplication: Record "Membership Applications";
}

