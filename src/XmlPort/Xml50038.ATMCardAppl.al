#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
XmlPort 50038 "ATM Card Appl"
{
    Format = VariableText;

    schema
    {
        textelement(ATMCardAppl)
        {
            tableelement(Banks; Banks)
            {
                AutoUpdate = true;
                XmlName = 'ATMCardApp';
                fieldelement(A; Banks."Bank Name")
                {
                }
                fieldelement(B; Banks.Branch)
                {
                }
                fieldelement(C; Banks."Bank Code")
                {
                }
                fieldelement(D; Banks."Branch Code")
                {
                }
                fieldelement(E; Banks.Code)
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

