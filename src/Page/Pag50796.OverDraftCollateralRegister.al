#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50796 "OverDraft Collateral Register"
{
    PageType = ListPart;
    SourceTable = "OD Collateral Details";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Code)
                {
                    ApplicationArea = Basic;
                    Caption = 'Collateral Type';
                }
                field("Collateral Registe Doc"; "Collateral Registe Doc")
                {
                    ApplicationArea = Basic;
                    Caption = 'Collateral Details Register';
                }
                field("Security Details"; "Security Details")
                {
                    ApplicationArea = Basic;
                }
                field(Value; Value)
                {
                    ApplicationArea = Basic;
                }
                field("Collateral Multiplier"; "Collateral Multiplier")
                {
                    ApplicationArea = Basic;
                }
                field("Guarantee Value"; "Guarantee Value")
                {
                    ApplicationArea = Basic;
                }
                field("Motor Vehicle Registration No"; "Motor Vehicle Registration No")
                {
                    ApplicationArea = Basic;
                }
                field("Title Deed No."; "Title Deed No.")
                {
                    ApplicationArea = Basic;
                }
                field("Comitted Collateral Value"; "Comitted Collateral Value")
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

