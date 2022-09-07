#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
XmlPort 50039 "Import Collateral Details"
{
    Format = VariableText;

    schema
    {
        textelement(ATMCardAppl)
        {
            tableelement("Collateral Details Buffer"; "Collateral Details Buffer")
            {
                XmlName = 'ATMCardApp';
                fieldelement(A; "Collateral Details Buffer"."Collateral ID")
                {
                }
                fieldelement(B; "Collateral Details Buffer"."Loan No")
                {
                }
                fieldelement(C; "Collateral Details Buffer"."Member No")
                {
                }
                fieldelement(D; "Collateral Details Buffer"."Member Name")
                {
                }
                fieldelement(E; "Collateral Details Buffer"."Collateral Type")
                {
                }
                fieldelement(F; "Collateral Details Buffer"."Market Value")
                {
                }
                fieldelement(G; "Collateral Details Buffer"."Forced Sale Value")
                {
                }
                fieldelement(H; "Collateral Details Buffer"."Last Valued On")
                {
                }
                fieldelement(I; "Collateral Details Buffer"."Collateral Description")
                {
                }
                fieldelement(J; "Collateral Details Buffer"."Registered Owner")
                {
                }
                fieldelement(K; "Collateral Details Buffer"."File No")
                {
                }
                fieldelement(L; "Collateral Details Buffer"."Released By")
                {
                }
                fieldelement(M; "Collateral Details Buffer"."Released On")
                {
                }
                fieldelement(N; "Collateral Details Buffer"."Last Actions")
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

    var
        ObjATMApp: Record "ATM Card Applications";
}

