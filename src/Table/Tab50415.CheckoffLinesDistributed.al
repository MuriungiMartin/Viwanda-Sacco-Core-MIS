#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50415 "Checkoff Lines-Distributed"
{

    fields
    {
        field(1; "Payroll No"; Code[20])
        {
        }
        field(2; "Employee Name"; Text[150])
        {
        }
        field(3; "Member No"; Code[30])
        {
        }
        field(4; "Checkoff No"; Code[40])
        {
        }
        field(5; Deposits; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6; DL_P; Decimal)
        {
        }
        field(7; DL_I; Decimal)
        {
        }
        field(8; EL_P; Decimal)
        {
        }
        field(9; EL_I; Decimal)
        {
        }
        field(10; EMER_P; Decimal)
        {
        }
        field(11; EMER_I; Decimal)
        {
        }
        field(12; IL_P; Decimal)
        {
        }
        field(13; IL_I; Decimal)
        {
        }
        field(14; MSL_P; Decimal)
        {
        }
        field(15; MSL_I; Decimal)
        {
        }
        field(16; INSURANCE; Decimal)
        {
        }
        field(17; "SILVER SAVINGS"; Decimal)
        {
        }
        field(18; THIRDPARTY; Decimal)
        {
        }
        field(19; BENEVOLENT; Decimal)
        {
        }
        field(20; SFL_P; Decimal)
        {
        }
        field(21; SFL_I; Decimal)
        {
        }
        field(22; PHONE_P; Decimal)
        {
        }
        field(23; PHONE_I; Decimal)
        {
        }
        field(24; SPL_P; Decimal)
        {
        }
        field(25; SPL_I; Decimal)
        {
        }
        field(26; SHARES; Decimal)
        {
        }
        field(27; TOTAL_DISTRIBUTED; Decimal)
        {
            FieldClass = Normal;
        }
        field(28; "ID No"; Code[20])
        {
        }
        field(29; SSFL_P; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(30; SSFL_I; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(31; TL_P; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(32; TL_I; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(33; "VS-MEMBER"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(34; DL; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(35; EL; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(36; IL; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(37; MSL; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(38; SL; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(39; SPL; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(40; SSL; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(41; TL; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(42; "DL_Loan No"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(43; "EL_Loan No"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(44; "IL_Loan No"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(45; "MSL_Loan No"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(46; "SL_Loan No"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(47; "SPL_Loan No"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(48; "SSL_Loan No"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(49; "TL_Loan No"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50; "TL1_Loan No"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(51; "SSPL_Loan No"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(52; TL1_P; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(53; TL1_I; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(54; REGFEE; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(55; SAD; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(56; SAI; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(57; "MAONO-H"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(58; "MAONO-MEMB"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(59; "SHAMBAL-P"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(60; "SHAMBA-I"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(62; "SAFARI SAVINGS"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(63; "JUNIOR SAVINGS"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(64; "SACCO PREMIUM"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(65; SHARECAP; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(66; "VSMEMBER_Loan No"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(67; "Benevolent Fund"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Payroll No", "Checkoff No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Cust: Record Customer;
}

