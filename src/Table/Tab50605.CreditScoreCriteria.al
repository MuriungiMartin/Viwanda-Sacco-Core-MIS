#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50605 "Credit Score Criteria"
{

    fields
    {
        field(1; Category; Option)
        {
            OptionCaption = ' ,Member Age,Period Of Membership,Deposit Inconsistency In A Year,Deposits Boosting Within A Year,Loan Recoveries from Deposits Within 3 Years,Loan History_Long Term,Loan History_Short Term,Repayment History_Number of Days Past Due at last month End,Repayment History_Maximum Number of Days a Client was delinquent,Repayment History_Average Number of Days a client was Delinquent,Repayment History_Number of times Client was more than 30 days Delinquent,Repayment History_Number of times client was more than one day delinquent,FOSA Activity_No of Credit Transactions Within 12 Months_Individual,FOSA Activity_No of Credit Transactions Within 12 Months_Corporate,Monthly Average Inflows _From Last Month 1 Year Back_Individual,Monthly Average Inflows _From Last Month 1 Year Back_Corporate,Totals';
            OptionMembers = " ","Member Age","Period Of Membership","Deposit Inconsistency In A Year","Deposits Boosting Within A Year","Loan Recoveries from Deposits Within 3 Years","Loan History_Long Term","Loan History_Short Term","Repayment History_Number of Days Past Due at last month End","Repayment History_Maximum Number of Days a Client was delinquent","Repayment History_Average Number of Days a client was Delinquent","Repayment History_Number of times Client was more than 30 days Delinquent","Repayment History_Number of times client was more than one day delinquent","FOSA Activity_No of Credit Transactions Within 12 Months_Individual","FOSA Activity_No of Credit Transactions Within 12 Months_Corporate","Monthly Average Inflows _From Last Month 1 Year Back_Individual","Monthly Average Inflows _From Last Month 1 Year Back_Corporate",Totals;
        }
        field(2; "Sub Category"; Text[50])
        {
        }
        field(3; "Credit Score"; Decimal)
        {
        }
        field(4; "Min Relationship Length(Years)"; Integer)
        {
        }
        field(5; "Max Relationship Length(Years)"; Integer)
        {
        }
        field(7; "Entry No"; Integer)
        {
            AutoIncrement = true;
        }
        field(8; "Min Count Range"; Integer)
        {
        }
        field(9; "Max Count Range"; Integer)
        {
        }
        field(10; "YES/No"; Boolean)
        {
        }
        field(11; "Min Amount Range"; Decimal)
        {
        }
        field(12; "Max Amount Range"; Decimal)
        {
        }
        field(13; "Max Score"; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Entry No")
        {
            Clustered = true;
        }
        key(Key2; Category)
        {
        }
        key(Key3; "Credit Score")
        {
        }
        key(Key4; "Min Relationship Length(Years)")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; Category, "Sub Category", "Credit Score", "Min Relationship Length(Years)")
        {
        }
    }

    var
        ObjCreditScoreCriteria: Record "Credit Score Criteria";
}

