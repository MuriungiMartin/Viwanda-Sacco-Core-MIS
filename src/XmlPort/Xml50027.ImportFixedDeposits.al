#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
XmlPort 50027 "Import Fixed Deposits"
{
    Format = VariableText;

    schema
    {
        textelement(Salaries_Processing)
        {
            tableelement("Payroll Employee Transactions."; "Payroll Employee Transactions.")
            {
                XmlName = 'ChequeImport';
                fieldelement(A; "Payroll Employee Transactions."."Sacco Membership No.")
                {
                }
                fieldelement(B; "Payroll Employee Transactions."."No.")
                {
                }
                fieldelement(C; "Payroll Employee Transactions."."Transaction Code")
                {
                }
                fieldelement(D; "Payroll Employee Transactions."."Transaction Name")
                {
                }
                fieldelement(E; "Payroll Employee Transactions."."Transaction Type")
                {
                }
                fieldelement(F; "Payroll Employee Transactions.".Amount)
                {
                }
                fieldelement(G; "Payroll Employee Transactions."."Amount(LCY)")
                {
                }
                fieldelement(H; "Payroll Employee Transactions.".Balance)
                {
                }
                fieldelement(I; "Payroll Employee Transactions."."Balance(LCY)")
                {
                }
                fieldelement(J; "Payroll Employee Transactions."."Period Month")
                {
                }
                fieldelement(K; "Payroll Employee Transactions."."Period Year")
                {
                }
                fieldelement(L; "Payroll Employee Transactions."."Payroll Period")
                {
                }
                fieldelement(M; "Payroll Employee Transactions.".Membership)
                {
                }
                fieldelement(N; "Payroll Employee Transactions."."Amtzd Loan Repay Amt")
                {
                }
                fieldelement(O; "Payroll Employee Transactions."."Amtzd Loan Repay Amt(LCY)")
                {
                }
                fieldelement(P; "Payroll Employee Transactions."."Loan Number")
                {
                }
                fieldelement(Q; "Payroll Employee Transactions."."Original Deduction Amount")
                {
                }
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }
}

