#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50070 "Portfolio Summary Bands"
{

    fields
    {
        field(1; Band; Code[50])
        {
        }
        field(2; Classification; Option)
        {
            OptionCaption = 'Perfoming,Watch,Substandard,Doubtful,Loss';
            OptionMembers = Perfoming,Watch,Substandard,Doubtful,Loss;
        }
        field(3; "Entry No"; Integer)
        {
        }
        field(4; "Band Description"; Code[100])
        {
        }
    }

    keys
    {
        key(Key1; "Entry No", Band, Classification)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

