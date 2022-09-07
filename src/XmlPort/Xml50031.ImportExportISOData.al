#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
XmlPort 50031 "Import/Export ISO Data"
{
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement("Audit Volume Trans. Entries"; "Audit Volume Trans. Entries")
            {
                XmlName = 'tbl';
                // fieldelement(a;"ISO-Defined Data Elements"."Entry No")
                // {
                // }
                // fieldelement(b;"ISO-Defined Data Elements"."Posting Date")
                // {
                // }
                // fieldelement(c;"ISO-Defined Data Elements"."Account No")
                // {
                // }
                // fieldelement(d;"ISO-Defined Data Elements"."Document No")
                // {
                // }
                // fieldelement(e;"ISO-Defined Data Elements".Description)
                // {
                // // }
                // fieldelement(f;"ISO-Defined Data Elements"."Debit Amount")
                // {
                // }
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

