#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50026 "Member Signatories Buffer"
{

    fields
    {
        field(1;"Account No";Code[30])
        {
        }
        field(2;"Member No";Code[30])
        {
        }
        field(3;"Member Name";Code[100])
        {
        }
        field(4;"Date Of Birth";Date)
        {
        }
        field(5;"ID No";Code[50])
        {
        }
        field(6;"Mobile No";Code[50])
        {
        }
        field(7;Email;Text[100])
        {
        }
        field(8;"Operating Instructions";Text[250])
        {
        }
        field(9;"Must Sign";Boolean)
        {
        }
        field(10;"WithDrawal Limit";Decimal)
        {
        }
        field(11;"Signed Up For Mobile Banking";Boolean)
        {
        }
        field(12;"Mobile Banking Limit";Decimal)
        {
        }
        field(13;"Created On";Date)
        {
        }
        field(14;"Created By";Code[30])
        {
        }
        field(15;"Modified By";Code[30])
        {
        }
        field(16;"Modified On";Date)
        {
        }
        field(17;"Entry No";Integer)
        {
        }
    }

    keys
    {
        key(Key1;"Account No","Member No","Entry No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

