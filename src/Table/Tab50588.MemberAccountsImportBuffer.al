#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50588 "Member Accounts Import Buffer"
{

    fields
    {
        field(1; "Member No"; Code[58])
        {
        }
        field(2; "Member Name"; Code[56])
        {
        }
        field(3; "Group ID"; Code[60])
        {
        }
        field(4; "Branch Code"; Code[60])
        {
        }
        field(5; "Postal Address"; Code[60])
        {
        }
        field(6; "Postal Code"; Code[100])
        {
        }
        field(7; City; Code[100])
        {
        }
        field(8; Residence; Code[100])
        {
        }
        field(9; Village; Code[100])
        {
        }
        field(10; Location; Code[100])
        {
        }
        field(11; "Sub-Location"; Code[100])
        {
        }
        field(12; District; Code[55])
        {
        }
        field(13; "Date Of Birth"; Date)
        {
        }
        field(14; "Mobile No"; Code[31])
        {
        }
        field(15; "Phone No"; Code[32])
        {
        }
        field(16; Email; Text[150])
        {
        }
        field(17; "Email Indemnified"; Boolean)
        {
        }
        field(18; "ID No"; Code[33])
        {
        }
        field(19; "ID Type"; Option)
        {
            OptionCaption = 'National ID Card,Passport Card,Aliens Card,Birth Certificate,Company Reg. No,Driving License,Not Applicable';
            OptionMembers = "National ID Card","Passport Card","Aliens Card","Birth Certificate","Company Reg. No","Driving License","Not Applicable";
        }
        field(20; "ID Date of Issue"; Date)
        {
        }
        field(21; "KRA Pin"; Code[52])
        {
        }
        field(22; "Marital Status"; Option)
        {
            OptionCaption = ' ,Single,Married,Divorced,Widowed,Separated';
            OptionMembers = " ",Single,Married,Divorced,Widowed,Separated;
        }
        field(23; Gender; Option)
        {
            OptionCaption = ' ,Male,Female';
            OptionMembers = " ",Male,Female;
        }
        field(24; "Literacy Lever"; Code[34])
        {
        }
        field(25; Occupation; Code[51])
        {
        }
        field(26; "Registration Date"; Date)
        {
        }
        field(27; "Created By"; Code[35])
        {
        }
        field(28; "Modified By"; Code[36])
        {
        }
        field(29; "Modified On"; Date)
        {
        }
        field(30; "Supervised By"; Code[37])
        {
        }
        field(31; "Supervised On"; Date)
        {
        }
        field(32; "Introduced By"; Code[38])
        {
        }
        field(33; "Account Status"; Option)
        {
            OptionCaption = 'Active,Awaiting Exit,Exited,Dormant,Deceased';
            OptionMembers = Active,"Awaiting Exit",Exited,Dormant,Deceased;
        }
        field(34; "Group Name"; Text[100])
        {
        }
        field(35; "Closed On"; Date)
        {
        }
        field(36; "Member Type"; Option)
        {
            OptionCaption = 'Individual,Corporate';
            OptionMembers = Individual,Corporate;
        }
        field(37; "Payroll No"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(38; "Has Silver Deposit"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(39; "Silver Deposit Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(40; "Deposit Contribution"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(41; "Share Capital"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Member No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

