#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50976 "EFT/RTGS Charges Setup"
{
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "EFT/RTGS Charges Setup";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Code)
                {
                    ApplicationArea = Basic;
                }
                field(Description; Description)
                {
                    ApplicationArea = Basic;
                }
                field("EFT/RTGS Type"; "EFT/RTGS Type")
                {
                    ApplicationArea = Basic;
                }
                field("Bank No"; "Bank No")
                {
                    ApplicationArea = Basic;
                }
                field("Bank Name"; "Bank Name")
                {
                    ApplicationArea = Basic;
                }
                field("Charge Amount"; "Charge Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Bank Commission"; "Bank Commission")
                {
                    ApplicationArea = Basic;
                }
                field("SACCO Commission"; "SACCO Commission")
                {
                    ApplicationArea = Basic;
                }
                field("Percentage of Amount"; "Percentage of Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Use Percentage"; "Use Percentage")
                {
                    ApplicationArea = Basic;
                }
                field("GL Account"; "GL Account")
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

