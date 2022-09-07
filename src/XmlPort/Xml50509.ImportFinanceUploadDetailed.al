#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
XmlPort 50509 "Import Finance Upload Detailed"
{
    Format = VariableText;

    schema
    {
        textelement(Salaries_Processing)
        {
            tableelement("Finance Uploads Lines"; "Finance Uploads Lines")
            {
                AutoReplace = true;
                XmlName = 'FinanceUpload';
                fieldelement(BatchHeader; "Finance Uploads Lines"."Header No.")
                {
                }
                fieldelement(No; "Finance Uploads Lines"."No.")
                {
                }
                fieldelement(DebitAccountType; "Finance Uploads Lines"."Debit Account Type")
                {
                }
                fieldelement(DebitAccountNo; "Finance Uploads Lines"."Debit Account No")
                {
                }
                fieldelement(DebitNarration; "Finance Uploads Lines"."Debit Narration")
                {
                }
                fieldelement(ReferenceNo; "Finance Uploads Lines"."Reference No")
                {
                }
                fieldelement(Amount; "Finance Uploads Lines".Amount)
                {
                }
                fieldelement(CreditAccountType; "Finance Uploads Lines"."Credit Account Type")
                {
                }
                fieldelement(CreditAccountNo; "Finance Uploads Lines"."Credit Account No")
                {
                }
                fieldelement(CreditNarration; "Finance Uploads Lines"."Credit Narration")
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

    local procedure FnRunGetHeaderNo(VarHeaderNo: Code[30])
    begin
    end;
}

