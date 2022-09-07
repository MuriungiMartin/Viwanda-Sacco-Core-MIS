#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50587 "FOSA Accounts Import Buffer"
{

    fields
    {
        field(1;"FOSA Account No";Code[30])
        {
        }
        field(2;"Member No";Code[30])
        {
        }
        field(4;Name;Code[60])
        {
        }
        field(6;"Account Type";Code[20])
        {
        }
        field(7;Status;Option)
        {
            OptionMembers = Active,Closed,Dormant;
        }
        field(8;"Operating Mode";Option)
        {
            OptionCaption = 'Self,Jointly';
            OptionMembers = Self,Jointly;
        }
        field(9;"Account Creation Date";Date)
        {
        }
        field(10;"Account Created By";Code[30])
        {
        }
        field(11;"Modified By";Code[30])
        {
        }
        field(12;"Modified On";Date)
        {
        }
        field(13;"Supervised On";Date)
        {
        }
        field(14;"Supervised By";Code[30])
        {
        }
        field(15;"Account Closed On";Date)
        {
        }
        field(16;"Account Closed By";Code[30])
        {
        }
        field(17;"Account Closure Reason";Text[100])
        {
        }
        field(18;"Activity Code";Code[30])
        {
        }
        field(19;"OD Limit";Decimal)
        {
        }
        field(20;"OD Expiry Date";Date)
        {
        }
        field(21;Frozen;Boolean)
        {
        }
        field(22;"Frozen Amount";Decimal)
        {
        }
    }

    keys
    {
        key(Key1;"FOSA Account No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

