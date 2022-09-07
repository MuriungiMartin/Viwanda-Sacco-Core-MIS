#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
XmlPort 50100 "Import/Export Bank Statement"
{
    Caption = 'Import/Export Permissions';
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement("Bank Acc. Reconciliation Line"; "Bank Acc. Reconciliation Line")
            {
                XmlName = 'BankReconLines';
                fieldelement(A; "Bank Acc. Reconciliation Line"."Bank Account No.")
                {
                    FieldValidate = no;
                }
                fieldelement(B; "Bank Acc. Reconciliation Line"."Statement No.")
                {
                }
                fieldelement(C; "Bank Acc. Reconciliation Line"."Transaction Date")
                {
                }
                fieldelement(D; "Bank Acc. Reconciliation Line".Description)
                {
                }
                fieldelement(E; "Bank Acc. Reconciliation Line"."Statement Amount")
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

