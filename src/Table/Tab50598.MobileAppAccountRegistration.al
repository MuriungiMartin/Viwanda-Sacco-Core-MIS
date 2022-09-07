#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50598 "MobileApp Account Registration"
{

    fields
    {
        field(1; RowID; Integer)
        {
            AutoIncrement = true;
        }
        field(2; MemberNo; Text[30])
        {
        }
        field(3; ProductID; Text[30])
        {
        }
        field(4; IsMinor; Boolean)
        {
        }
        field(5; MinorName; Text[50])
        {
        }
        field(6; BirthCertificateNo; Text[30])
        {
        }
        field(7; DateOfBirth; Date)
        {
        }
        field(8; ApplicationReceivedOn; DateTime)
        {
        }
        field(9; AccountMaintained; Boolean)
        {
        }
        field(10; AccountMaintainedOn; DateTime)
        {
        }
        field(11; ProductSource; Option)
        {
            OptionCaption = 'FOSA,BOSA';
            OptionMembers = FOSA,BOSA;
        }
        field(12; ApplicationSource; Option)
        {
            OptionCaption = 'Mobile App,Internet Banking';
            OptionMembers = "Mobile App","Internet Banking";
        }
    }

    keys
    {
        key(Key1; RowID)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

