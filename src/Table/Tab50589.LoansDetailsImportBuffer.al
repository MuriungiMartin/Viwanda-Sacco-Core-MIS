#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50589 "Loans Details Import Buffer"
{

    fields
    {
        field(1; "Loan No"; Code[20])
        {
        }
        field(2; "Member No"; Code[20])
        {
        }
        field(3; "Member Name"; Code[100])
        {
        }
        field(4; "Loan Product Type"; Code[30])
        {
        }
        field(5; "Loan Product Name"; Text[50])
        {
        }
        field(6; "Application Date"; Date)
        {
        }
        field(7; "Applied By"; Code[30])
        {
        }
        field(8; "Approved On"; Date)
        {
        }
        field(9; "Approved By"; Code[30])
        {
        }
        field(10; "Disbursed On"; Date)
        {
        }
        field(11; "Disbursed By"; Code[30])
        {
        }
        field(12; "Requested Amount"; Decimal)
        {
        }
        field(13; "Disbursed Amount"; Decimal)
        {
        }
        field(14; "Repayment Amount"; Decimal)
        {
        }
        field(15; "Repayment Method"; Option)
        {
            OptionCaption = 'Amortised,Reducing Balance,Straight Line,Constants';
            OptionMembers = Amortised,"Reducing Balance","Straight Line",Constants;
        }
        field(16; "Interest Rate"; Decimal)
        {
        }
        field(17; Instalments; Integer)
        {
        }
        field(18; "Repayment Frequency"; Option)
        {
            OptionCaption = 'Daily,Weekly,Monthly,Quaterly';
            OptionMembers = Daily,Weekly,Monthly,Quaterly;
        }
        field(19; "Repayment Start Date"; Date)
        {
        }
        field(20; "Expected Complition Date"; Date)
        {
        }
        field(21; "Credit Officer"; Code[30])
        {
        }
        field(22; Restructured; Boolean)
        {
        }
        field(23; "Closed On"; Date)
        {
        }
        field(24; "Closed By"; Code[30])
        {
        }
        field(25; "Grace Period"; DateFormula)
        {
        }
        field(26; "Monthly Repayment"; Decimal)
        {
        }
        field(27; "Repayment Account"; Code[50])
        {
        }
        field(28; "House Group ID"; Code[50])
        {
        }
        field(29; "House Group Name"; Text[250])
        {
        }
        field(30; "Loan Found"; Boolean)
        {
            CalcFormula = exist("Loans Register" where("Loan  No." = field("Loan No")));
            FieldClass = FlowField;
        }
        field(31; "Outstanding Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(32; "Outstanding Interest"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Loan No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

