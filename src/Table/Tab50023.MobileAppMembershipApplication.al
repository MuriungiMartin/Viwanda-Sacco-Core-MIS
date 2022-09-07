#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50023 "MobileAppMembershipApplication"
{

    fields
    {
        field(1; RowID; Integer)
        {
            AutoIncrement = true;
        }
        field(2; MobileNo; Text[30])
        {
        }
        field(3; IDType; Option)
        {
            OptionCaption = 'Nation ID Card,Passport Card';
            OptionMembers = "Nation ID Card","Passport Card";
        }
        field(4; IDNumber; Text[30])
        {
        }
        field(5; Email; Text[100])
        {
        }
        field(6; DateOfBirth; Date)
        {
        }
        field(7; FirstName; Text[30])
        {
        }
        field(8; MiddleName; Text[30])
        {
        }
        field(9; LastName; Text[30])
        {
        }
        field(10; Photo; MediaSet)
        {
            Enabled = false;
        }
        field(11; Signature; MediaSet)
        {
            Enabled = false;
        }
        field(12; FosaAccountOpened; Boolean)
        {
        }
        field(13; BosaAccountOpened; Boolean)
        {
        }
        field(14; NextOfKinIsMinor; Boolean)
        {
        }
        field(15; NextOfKinName; Text[100])
        {
        }
        field(16; NextOfKinIDNumber; Text[30])
        {
        }
        field(17; NextOfKinDOB; Date)
        {
        }
        field(18; NextOfKinMobileNo; Text[30])
        {
        }
        field(19; NextOfKinRelationship; Text[30])
        {
        }
        field(20; RefereeIDNumber; Text[30])
        {
        }
        field(21; RefereeName; Text[100])
        {
        }
        field(22; CountryCode; Text[30])
        {
        }
        field(23; City; Text[50])
        {
        }
        field(24; Residence; Text[100])
        {
        }
        field(25; ApplicationReceivedOn; DateTime)
        {
        }
        field(26; ApplicationMaintained; Boolean)
        {
        }
        field(27; Employed; Boolean)
        {
        }
        field(28; SelfEmployed; Boolean)
        {
        }
        field(29; ExpectedMonthlyIncome; Code[100])
        {
        }
        field(30; Gender; Option)
        {
            OptionCaption = ',Male,Female';
            OptionMembers = ,Male,Female;
        }
        field(31; PassportNumber; Text[30])
        {
        }
        field(32; EmploymentInfo; Option)
        {
            OptionCaption = ' ,Employed,Self-Employed,Contracting,Others,Employed & Self Employed';
            OptionMembers = " ",Employed,"Self-Employed",Contracting,Others,"Employed & Self Employed";
        }
        field(33; RefereeMemberNo; Code[10])
        {
        }
        field(34; GurdianName; Text[100])
        {
        }
        field(35; NextOfKinMemberNo; Code[10])
        {
        }
        field(36; BranchAssigned; Code[20])
        {
        }
        field(37; County; Code[30])
        {
        }
        field(38; ImageFetched; Boolean)
        {
        }
        field(39; RefereeMobileNo; Text[20])
        {
        }
        field(40; InitialDepositPaid; Boolean)
        {
        }
        field(41; AccountCreatedOn; DateTime)
        {
        }
        field(42; ExpectedMonthlyIncomeAmount; Decimal)
        {
        }
        field(43; MBankingRegistered; Boolean)
        {
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

