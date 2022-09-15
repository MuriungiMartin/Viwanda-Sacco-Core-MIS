#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50425 "Member Credit Scoring"
{

    fields
    {
        field(1; "Entry No"; Integer)
        {
        }
        field(2; "Member No"; Code[30])
        {
            TableRelation = Customer."No.";
        }
        field(3; "Member Name"; Code[100])
        {
        }
        field(4; Category; Option)
        {
            OptionCaption = ' ,Member Age,Period Of Membership,Deposit Inconsistency In A Year,Deposits Boosting Within A Year,Loan Recoveries from Deposits Within 3 Years,Loan History_Long Term,Loan History_Short Term,Repayment History_Number of Days Past Due at last month End,Repayment History_Maximum Number of Days a Client was delinquent,Repayment History_Average Number of Days a client was Delinquent,Repayment History_Number of times Client was more than 30 days Delinquent,Repayment History_Number of times client was more than one day delinquent,FOSA Activity_No of Credit Transactions Within 12 Months_Individual,FOSA Activity_No of Credit Transactions Within 12 Months_Corporate,Monthly Average Inflows _From Last Month 1 Year Back_Individual,Monthly Average Inflows _From Last Month 1 Year Back_Corporate,Totals';
            OptionMembers = " ","Member Age","Period Of Membership","Deposit Inconsistency In A Year","Deposits Boosting Within A Year","Loan Recoveries from Deposits Within 3 Years","Loan History_Long Term","Loan History_Short Term","Repayment History_Number of Days Past Due at last month End","Repayment History_Maximum Number of Days a Client was delinquent","Repayment History_Average Number of Days a client was Delinquent","Repayment History_Number of times Client was more than 30 days Delinquent","Repayment History_Number of times client was more than one day delinquent","FOSA Activity_No of Credit Transactions Within 12 Months_Individual","FOSA Activity_No of Credit Transactions Within 12 Months_Corporate","Monthly Average Inflows _From Last Month 1 Year Back_Individual","Monthly Average Inflows _From Last Month 1 Year Back_Corporate",Totals;
        }
        field(5; "Score Base Value"; Code[30])
        {
        }
        field(6; Score; Decimal)
        {
        }
        field(7; "Report Date"; Date)
        {
        }
        field(8; "Out Of"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Entry No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

