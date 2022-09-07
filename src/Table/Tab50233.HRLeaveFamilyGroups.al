#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50233 "HR Leave Family Groups"
{
    //nownPage55661;
    //nownPage55661;

    fields
    {
        field(1; "Code"; Code[20])
        {
            NotBlank = true;
        }
        field(2; Description; Text[100])
        {
        }
        field(3; Remarks; Text[200])
        {
        }
        field(4; "Max Employees On Leave"; Integer)
        {
            Description = 'Maximum nmber of employees allowed to be on leave at once';
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

