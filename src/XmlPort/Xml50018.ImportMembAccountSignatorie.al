#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
XmlPort 50018 "Import Memb Account Signatorie"
{
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement("Member Signatories Buffer"; "Member Signatories Buffer")
            {
                AutoReplace = true;
                XmlName = 'Paybill';
                fieldelement(A; "Member Signatories Buffer"."Account No")
                {
                }
                fieldelement(B; "Member Signatories Buffer"."Member No")
                {
                }
                fieldelement(C; "Member Signatories Buffer"."Member Name")
                {
                }
                fieldelement(D; "Member Signatories Buffer"."Date Of Birth")
                {
                }
                fieldelement(E; "Member Signatories Buffer"."ID No")
                {
                }
                fieldelement(F; "Member Signatories Buffer"."Mobile No")
                {
                }
                fieldelement(G; "Member Signatories Buffer".Email)
                {
                }
                fieldelement(H; "Member Signatories Buffer"."Operating Instructions")
                {
                }
                fieldelement(I; "Member Signatories Buffer"."Must Sign")
                {
                }
                fieldelement(J; "Member Signatories Buffer"."WithDrawal Limit")
                {
                }
                fieldelement(K; "Member Signatories Buffer"."Signed Up For Mobile Banking")
                {
                }
                fieldelement(L; "Member Signatories Buffer"."Mobile Banking Limit")
                {
                }
                fieldelement(M; "Member Signatories Buffer"."Created On")
                {
                }
                fieldelement(N; "Member Signatories Buffer"."Created By")
                {
                }
                fieldelement(O; "Member Signatories Buffer"."Modified By")
                {
                }
                fieldelement(P; "Member Signatories Buffer"."Modified On")
                {
                }
                fieldelement(Q; "Member Signatories Buffer"."Entry No")
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

