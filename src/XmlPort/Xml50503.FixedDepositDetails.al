#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
XmlPort 50503 "Fixed Deposit Details"
{
    //Encoding = UTF8;
    Format = VariableText;
    FormatEvaluate = Legacy;
    PreserveWhiteSpace = true;
    TextEncoding = UTF8;

    schema
    {
        textelement("<paybilltran>")
        {
            XmlName = 'PAYBILLTRAN';
            tableelement("Fixed Deposit Placement"; "Fixed Deposit Placement")
            {
                AutoUpdate = true;
                XmlName = 'PAYBILL';
                fieldelement(A; "Fixed Deposit Placement"."Document No")
                {
                }
                fieldelement(B; "Fixed Deposit Placement"."Member No")
                {
                }
                fieldelement(C; "Fixed Deposit Placement"."Member Name")
                {
                }
                fieldelement(D; "Fixed Deposit Placement"."Fixed Deposit Account No")
                {
                }
                fieldelement(E; "Fixed Deposit Placement"."Account to Tranfers FD Amount")
                {
                }
                fieldelement(F; "Fixed Deposit Placement"."Amount to Fix")
                {
                }
                fieldelement(G; "Fixed Deposit Placement"."Application Date")
                {
                }
                fieldelement(H; "Fixed Deposit Placement"."Fixed Deposit Type")
                {
                }
                fieldelement(I; "Fixed Deposit Placement"."Fixed Duration")
                {
                }
                fieldelement(J; "Fixed Deposit Placement"."Fixed Deposit Start Date")
                {
                }
                fieldelement(K; "Fixed Deposit Placement"."FD Interest Rate")
                {
                }
                fieldelement(L; "Fixed Deposit Placement"."FD Maturity Date")
                {
                }
                fieldelement(M; "Fixed Deposit Placement"."Maturity Instructions")
                {
                }
                fieldelement(N; "Fixed Deposit Placement"."Created By")
                {
                }
                fieldelement(O; "Fixed Deposit Placement"."Created On")
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

