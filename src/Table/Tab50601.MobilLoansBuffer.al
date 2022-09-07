#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50601 "Mobil Loans Buffer"
{

    fields
    {
        field(1; "Loan No"; Code[30])
        {
        }
        field(2; "Application Date"; Date)
        {
        }
        field(3; "Loan Product"; Code[50])
        {
        }
        field(4; "Member No"; Code[30])
        {
        }
        field(5; "Requested Amount"; Decimal)
        {
        }
        field(6; Instalment; Integer)
        {
        }
        field(7; "Repayment Start Date"; Date)
        {
        }
        field(8; "Loan Purpose"; Code[30])
        {
        }
        field(9; "Interest Rate"; Decimal)
        {
        }
        field(10; Repayment; Decimal)
        {
        }
        field(11; "Income Type"; Option)
        {
            OptionCaption = 'Payslip,Bank Statement,Payslip & Bank Statement,Business';
            OptionMembers = Payslip,"Bank Statement","Payslip & Bank Statement",Business;
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

