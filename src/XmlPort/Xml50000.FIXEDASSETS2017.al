#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
XmlPort 50000 "FIXED ASSETS 2017"
{
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement("FA Journal Line";"FA Journal Line")
            {
                XmlName = 'Paybill';
                fieldelement(Mobile_No;"FA Journal Line"."Journal Template Name")
                {
                }
                fieldelement(ddd;"FA Journal Line"."Journal Batch Name")
                {
                }
                fieldelement(aa;"FA Journal Line"."FA Posting Date")
                {
                }
                fieldelement(b;"FA Journal Line"."Document No.")
                {
                }
                fieldelement(c;"FA Journal Line"."FA No.")
                {
                }
                fieldelement(d;"FA Journal Line".Description)
                {
                }
                fieldelement(e;"FA Journal Line"."Depreciation Book Code")
                {
                }
                fieldelement(g;"FA Journal Line"."FA Posting Type")
                {
                }
                fieldelement(yy;"FA Journal Line".Amount)
                {
                }
                fieldelement(tes;"FA Journal Line"."Line No.")
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

