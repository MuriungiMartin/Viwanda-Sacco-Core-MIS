#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50536 "Buffer 2016-b"
{

    fields
    {
        field(1; "Payroll number"; Code[30])
        {
        }
        field(2; "Member No"; Code[30])
        {
        }
        field(3; "Employer Code"; Code[30])
        {
        }
        field(4; Fosa; Code[30])
        {
        }
        field(5; "Loan No"; Code[30])
        {
        }
        field(6; "Loan type"; Code[10])
        {
        }
        field(7; "Member Name"; Text[100])
        {
        }
    }

    keys
    {
        key(Key1; "Payroll number")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

