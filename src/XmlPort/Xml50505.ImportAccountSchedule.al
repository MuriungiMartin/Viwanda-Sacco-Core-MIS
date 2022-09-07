#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
XmlPort 50505 "Import Account Schedule"
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
            tableelement("Acc. Schedule Line"; "Acc. Schedule Line")
            {
                AutoUpdate = true;
                XmlName = 'PAYBILL';
                fieldelement(A; "Acc. Schedule Line"."Schedule Name")
                {
                }
                fieldelement(B; "Acc. Schedule Line"."Line No.")
                {
                }
                fieldelement(C; "Acc. Schedule Line"."Row No.")
                {
                }
                fieldelement(D; "Acc. Schedule Line".Description)
                {
                }
                fieldelement(E; "Acc. Schedule Line".Totaling)
                {
                }
                fieldelement(F; "Acc. Schedule Line"."Totaling Type")
                {
                }
                fieldelement(G; "Acc. Schedule Line"."New Page")
                {
                }
                fieldelement(H; "Acc. Schedule Line".Indentation)
                {
                }
                fieldelement(I; "Acc. Schedule Line".Show)
                {
                }
                fieldelement(J; "Acc. Schedule Line".Bold)
                {
                }
                fieldelement(K; "Acc. Schedule Line".Italic)
                {
                }
                fieldelement(L; "Acc. Schedule Line".Underline)
                {
                }
                fieldelement(M; "Acc. Schedule Line"."Show Opposite Sign")
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

