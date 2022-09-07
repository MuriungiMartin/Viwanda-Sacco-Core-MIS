#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50570 "Cheque Receipt Line-Family"
{
    Editable = true;
    PageType = ListPart;
    SourceTable = "Cheque Issue Lines-Family";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Cheque Serial No"; "Cheque Serial No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Cheque No"; "Cheque No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Account No."; "Account No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Account Name"; "Account Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Amount; Amount)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Style = Favorable;
                    StyleExpr = true;
                }
                field("Account Balance"; "Account Balance")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Charge Amount"; "Charge Amount")
                {
                    ApplicationArea = Basic;
                    Style = AttentionAccent;
                    StyleExpr = true;
                }
                field("Un pay Code"; "Un pay Code")
                {
                    ApplicationArea = Basic;
                }
                field(Interpretation; Interpretation)
                {
                    ApplicationArea = Basic;
                }
                field("Verification Status"; "Verification Status")
                {
                    ApplicationArea = Basic;
                    Style = Attention;
                    StyleExpr = true;

                    trigger OnValidate()
                    begin
                        Modify;
                    end;
                }
                field("Transaction Date"; "Transaction Date")
                {
                    ApplicationArea = Basic;
                }
                field("Un Pay Charge Amount"; "Un Pay Charge Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Family Account No."; "Family Account No.")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Code"; "Transaction Code")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Refference"; "Transaction Refference")
                {
                    ApplicationArea = Basic;
                }
                field("Unpay Date"; "Unpay Date")
                {
                    ApplicationArea = Basic;
                }
                field(FrontImage; FrontImage)
                {
                    ApplicationArea = Basic;
                }
                field(FrontGrayImage; FrontGrayImage)
                {
                    ApplicationArea = Basic;
                }
                field(BackImages; BackImages)
                {
                    ApplicationArea = Basic;
                }
                field("Un pay User Id"; "Un pay User Id")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
}

