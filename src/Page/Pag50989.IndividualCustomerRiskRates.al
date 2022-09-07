#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50989 "Individual Customer Risk Rates"
{
    Editable = false;
    PageType = NavigatePage;
    SourceTable = "Individual Customer Risk Rate";

    layout
    {
        area(content)
        {
            group(Control26)
            {
                field("What is the Customer Category?"; "What is the Customer Category?")
                {
                    ApplicationArea = Basic;
                }
                grid(Control29)
                {
                    GridLayout = Rows;
                    group(Control5)
                    {
                        field("Customer Category Score"; "Customer Category Score")
                        {
                            ApplicationArea = Basic;
                        }
                    }
                }
                field("What is the Member residency?"; "What is the Member residency?")
                {
                    ApplicationArea = Basic;
                }
                grid(Control30)
                {
                    GridLayout = Rows;
                    field("Member Residency Score"; "Member Residency Score")
                    {
                        ApplicationArea = Basic;
                    }
                }
                field("Cust Employment Risk?"; "Cust Employment Risk?")
                {
                    ApplicationArea = Basic;
                }
                grid(Control24)
                {
                    GridLayout = Rows;
                    field("Cust Employment Risk Score"; "Cust Employment Risk Score")
                    {
                        ApplicationArea = Basic;
                    }
                }
                grid(Control31)
                {
                    GridLayout = Rows;
                }
                field("Cust Business Risk Industry?"; "Cust Business Risk Industry?")
                {
                    ApplicationArea = Basic;
                }
                grid(Control35)
                {
                    GridLayout = Rows;
                    field("Cust Bus. Risk Industry Score"; "Cust Bus. Risk Industry Score")
                    {
                        ApplicationArea = Basic;
                    }
                }
                field("Lenght Of Relationship?"; "Lenght Of Relationship?")
                {
                    ApplicationArea = Basic;
                }
                grid(Control34)
                {
                    GridLayout = Rows;
                }
                field("Cust Involved in Intern. Trade"; "Cust Involved in Intern. Trade")
                {
                    ApplicationArea = Basic;
                }
                grid(Control38)
                {
                    GridLayout = Rows;
                    field("Length Of Relation Score"; "Length Of Relation Score")
                    {
                        ApplicationArea = Basic;
                    }
                }
                field("Electronic Payments?"; "Electronic Payments?")
                {
                    ApplicationArea = Basic;
                }
                grid(Control39)
                {
                    GridLayout = Rows;
                    field("Electronic Payments Score"; "Electronic Payments Score")
                    {
                        ApplicationArea = Basic;
                    }
                }
                field("Account Type Taken?"; "Account Type Taken?")
                {
                    ApplicationArea = Basic;
                }
                grid(Control11)
                {
                    GridLayout = Rows;
                    field("Account Type Taken Score"; "Account Type Taken Score")
                    {
                        ApplicationArea = Basic;
                    }
                }
                field("Card Type Taken"; "Card Type Taken")
                {
                    ApplicationArea = Basic;
                }
                grid(Control9)
                {
                    GridLayout = Rows;
                    field("Card Type Taken Score"; "Card Type Taken Score")
                    {
                        ApplicationArea = Basic;
                    }
                }
                field("Channel Taken?"; "Channel Taken?")
                {
                    ApplicationArea = Basic;
                }
                grid(Control7)
                {
                    GridLayout = Rows;
                    field("Channel Taken Score"; "Channel Taken Score")
                    {
                        ApplicationArea = Basic;
                    }
                }
                field("GROSS CUSTOMER AML RISK RATING"; "GROSS CUSTOMER AML RISK RATING")
                {
                    ApplicationArea = Basic;
                }
                field("CUSTOMER NET RISK RATING"; "CUSTOMER NET RISK RATING")
                {
                    ApplicationArea = Basic;
                }
                field("BANK'S CONTROL RISK RATING"; "BANK'S CONTROL RISK RATING")
                {
                    ApplicationArea = Basic;
                }
                field("Risk Rate Scale"; "Risk Rate Scale")
                {
                    ApplicationArea = Basic;
                    StyleExpr = FieldStyle;
                }
            }
        }
    }

    actions
    {
    }

    var
        FieldStyle: Text;

    local procedure SetFieldStyle()
    begin
        FieldStyle := '';
        if "Risk Rate Scale" = "risk rate scale"::"Low Risk" then begin
            FieldStyle := 'Standard'
        end else
            if "Risk Rate Scale" = "risk rate scale"::"Medium Risk" then begin
                FieldStyle := 'Strong'

            end else
                if "Risk Rate Scale" = "risk rate scale"::"High Risk" then
                    FieldStyle := 'Attention'
    end;
}

