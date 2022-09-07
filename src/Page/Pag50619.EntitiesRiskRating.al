#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50619 "Entities Risk Rating"
{
    Editable = false;
    PageType = Card;
    SourceTable = "Entities Customer Risk Rate";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("What is the Customer Category?"; "What is the Customer Category?")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                grid(Score)
                {
                    Caption = 'Score';
                    GridLayout = Rows;
                    group(Control6)
                    {
                        field("Customer Category Score"; "Customer Category Score")
                        {
                            ApplicationArea = Basic;
                            Importance = Promoted;
                            ShowCaption = false;
                        }
                    }
                }
            }
            group(Control7)
            {
                field("What is the Member residency?"; "What is the Member residency?")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                grid(Control12)
                {
                    GridLayout = Rows;
                    group(Control11)
                    {
                        field("Member Residency Score"; "Member Residency Score")
                        {
                            ApplicationArea = Basic;
                            Importance = Promoted;
                            ShowCaption = false;
                        }
                    }
                }
            }
            group(Control16)
            {
                field("Cust Employment Risk?"; "Cust Employment Risk?")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                grid(Control14)
                {
                    GridLayout = Rows;
                    group(Control13)
                    {
                        field("Cust Employment Risk Score"; "Cust Employment Risk Score")
                        {
                            ApplicationArea = Basic;
                            Importance = Promoted;
                            ShowCaption = false;
                        }
                    }
                }
            }
            group(Control21)
            {
                field("Cust Business Risk Industry?"; "Cust Business Risk Industry?")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                grid(Control19)
                {
                    GridLayout = Rows;
                    group(Control18)
                    {
                        field("Cust Bus. Risk Industry Score"; "Cust Bus. Risk Industry Score")
                        {
                            ApplicationArea = Basic;
                            Importance = Promoted;
                            ShowCaption = false;
                        }
                    }
                }
            }
            group(Control26)
            {
                field("Lenght Of Relationship?"; "Lenght Of Relationship?")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                grid(Control24)
                {
                    GridLayout = Rows;
                    group(Control23)
                    {
                        field("Length Of Relation Score"; "Length Of Relation Score")
                        {
                            ApplicationArea = Basic;
                            Importance = Promoted;
                            ShowCaption = false;
                        }
                    }
                }
            }
            group(Control31)
            {
                field("Cust Involved in Intern. Trade"; "Cust Involved in Intern. Trade")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                grid(Control29)
                {
                    GridLayout = Rows;
                    group(Control28)
                    {
                        field("Involve in Inter. Trade Score"; "Involve in Inter. Trade Score")
                        {
                            ApplicationArea = Basic;
                            CaptionClass = InternationalTrade;
                            Importance = Promoted;
                            ShowCaption = false;
                        }
                    }
                }
            }
            group(Control36)
            {
                field("Account Type Taken?"; "Account Type Taken?")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                grid(Control34)
                {
                    GridLayout = Rows;
                    group(Control33)
                    {
                        field("Account Type Taken Score"; "Account Type Taken Score")
                        {
                            ApplicationArea = Basic;
                            Importance = Promoted;
                            ShowCaption = false;
                        }
                    }
                }
            }
            group(Control41)
            {
                field("Card Type Taken"; "Card Type Taken")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                grid(Control39)
                {
                    GridLayout = Rows;
                    group(Control38)
                    {
                        field("Card Type Taken Score"; "Card Type Taken Score")
                        {
                            ApplicationArea = Basic;
                            Importance = Promoted;
                            ShowCaption = false;
                        }
                    }
                }
            }
            group(Control46)
            {
                field("Channel Taken?"; "Channel Taken?")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                grid(Control44)
                {
                    GridLayout = Rows;
                    group(Control43)
                    {
                        field("Channel Taken Score"; "Channel Taken Score")
                        {
                            ApplicationArea = Basic;
                            Importance = Promoted;
                            ShowCaption = false;
                        }
                    }
                }
            }
            group(Control51)
            {
                field("Electronic Payments?"; "Electronic Payments?")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                grid(Control49)
                {
                    GridLayout = Rows;
                    group(Control48)
                    {
                        field("Electronic Payments Score"; "Electronic Payments Score")
                        {
                            ApplicationArea = Basic;
                            Importance = Promoted;
                            ShowCaption = false;
                        }
                    }
                }
            }
            group("Member Summary")
            {
                Caption = 'Member Summary';
                field("GROSS CUSTOMER AML RISK RATING"; "GROSS CUSTOMER AML RISK RATING")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("BANK'S CONTROL RISK RATING"; "BANK'S CONTROL RISK RATING")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("CUSTOMER NET RISK RATING"; "CUSTOMER NET RISK RATING")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Risk Rate Scale"; "Risk Rate Scale")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    var
        InternationalTrade: label 'Involved In International Trade Score';
}

