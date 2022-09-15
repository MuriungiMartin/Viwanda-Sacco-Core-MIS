#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
XmlPort 50002 "Import Checkoff Block"
{
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement("ReceiptsProcessing_L-Checkoff"; "ReceiptsProcessing_L-Checkoff")
            {
                XmlName = 'Checkoff';
                fieldelement(Header_No; "ReceiptsProcessing_L-Checkoff"."Receipt Header No")
                {
                }
                fieldelement(Member_No; "ReceiptsProcessing_L-Checkoff"."Member No")
                {
                }
                fieldelement(SharesAmount; "ReceiptsProcessing_L-Checkoff"."Sacco Shares")
                {
                }
                fieldelement(APPLAmount; "ReceiptsProcessing_L-Checkoff"."Sacco Appl Fee")
                {
                }
                fieldelement(TotalLoanAmount; "ReceiptsProcessing_L-Checkoff"."Sacco Total Loan")

                {

                }
                fieldelement(TotalInterest; "ReceiptsProcessing_L-Checkoff"."Sacco Total Interest")

                {

                }
                fieldelement(Benevolent; "ReceiptsProcessing_L-Checkoff"."Saccco Benevolent")

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

