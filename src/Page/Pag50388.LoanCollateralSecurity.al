#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50388 "Loan Collateral Security"
{
    PageType = ListPart;
    SourceTable = "Loan Collateral Details";

    layout
    {
        area(content)
        {
            repeater(Control1102756000)
            {
                field("Collateral Registe Doc"; "Collateral Registe Doc")
                {
                    ApplicationArea = Basic;
                }
                field("Registered Owner"; "Registered Owner")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Reference No"; "Reference No")
                {
                    ApplicationArea = Basic;
                }
                field(Type; Type)
                {
                    ApplicationArea = Basic;
                }
                field("Security Details"; "Security Details")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Registration/Reference No"; "Registration/Reference No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Value; Value)
                {
                    ApplicationArea = Basic;
                }
                field("Collateral Multiplier"; "Collateral Multiplier")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Comitted Collateral Value"; "Comitted Collateral Value")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Category; Category)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Guarantee Value"; "Guarantee Value")
                {
                    ApplicationArea = Basic;
                }
                field(Remarks; Remarks)
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

