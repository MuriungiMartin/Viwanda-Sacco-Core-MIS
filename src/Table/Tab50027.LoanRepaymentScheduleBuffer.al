#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50027 "Loan Repayment Schedule Buffer"
{

    fields
    {
        field(1;"Loan No";Code[30])
        {
        }
        field(2;Instalment;Integer)
        {
        }
        field(3;"Repayment Date";Date)
        {
        }
        field(4;"Loan Balance";Decimal)
        {
        }
        field(5;"Monthly Repayment";Decimal)
        {
        }
        field(6;"Principle Repayment";Decimal)
        {
        }
        field(7;"Monthly Interest";Decimal)
        {
        }
        field(8;"Monthly Insurance";Decimal)
        {
        }
        field(9;"Entry No";Integer)
        {
        }
    }

    keys
    {
        key(Key1;"Loan No","Entry No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

