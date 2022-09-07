#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
XmlPort 50504 "import leave days"
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
            tableelement("HR Journal Line"; "HR Journal Line")
            {
                AutoUpdate = true;
                XmlName = 'PAYBILL';
                fieldelement(A; "HR Journal Line"."Journal Template Name")
                {
                }
                fieldelement(B; "HR Journal Line"."Journal Batch Name")
                {
                }
                fieldelement(C; "HR Journal Line"."Line No.")
                {
                }
                fieldelement(UI; "HR Journal Line"."Staff No.")
                {
                }
                fieldelement(s; "HR Journal Line"."Staff Name")
                {
                }
                fieldelement(t; "HR Journal Line"."Leave Type")
                {
                }
                fieldelement(p; "HR Journal Line"."Leave Entry Type")
                {
                }
                fieldelement(rt; "HR Journal Line"."No. of Days")
                {
                }
                fieldelement(yu; "HR Journal Line"."Document No.")
                {
                }
                fieldelement(YT; "HR Journal Line"."Posting Date")
                {
                }
                fieldelement(gh; "HR Journal Line"."Shortcut Dimension 1 Code")
                {
                }
                fieldelement(ty; "HR Journal Line"."Shortcut Dimension 2 Code")
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

