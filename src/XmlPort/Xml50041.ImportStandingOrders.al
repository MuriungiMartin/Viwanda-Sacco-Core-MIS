#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
XmlPort 50041 "Import Standing Orders"
{
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement("Standing Orders"; "Standing Orders")
            {
                XmlName = 'Paybill';
                fieldelement(A; "Standing Orders"."No.")
                {
                }
                fieldelement(B; "Standing Orders".Frequency)
                {
                }
                fieldelement(C; "Standing Orders"."Source Account Type")
                {
                }
                fieldelement(D; "Standing Orders"."Source Account No.")
                {
                }
                fieldelement(E; "Standing Orders"."Source Global Dimension 2 Code")
                {
                }
                fieldelement(F; "Standing Orders".Amount)
                {
                }
                fieldelement(G; "Standing Orders"."Effective/Start Date")
                {
                }
                fieldelement(H; "Standing Orders"."Next Run Date")
                {
                }
                fieldelement(I; "Standing Orders"."Last Execution Date")
                {
                }
                fieldelement(J; "Standing Orders"."End Date")
                {
                }
                fieldelement(K; "Standing Orders"."Source Account Narrations")
                {
                }
                fieldelement(L; "Standing Orders"."Destination Account Type")
                {
                }
                fieldelement(M; "Standing Orders"."Destination Account No.")
                {
                }
                fieldelement(N; "Standing Orders"."Dest. Global Dimension 2 Code")
                {
                }
                fieldelement(O; "Standing Orders"."Destination Account Narrations")
                {
                }
                fieldelement(P; "Standing Orders"."Created On")
                {
                }
                fieldelement(Q; "Standing Orders"."Created By")
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

    trigger OnPostXmlPort()
    begin
        Message('Bank Statement Import completed!');
    end;
}

