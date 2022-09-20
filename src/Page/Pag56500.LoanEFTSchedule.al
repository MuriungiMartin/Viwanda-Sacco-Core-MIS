#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 56500 "Loan EFT Schedule"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Loans Register";
    SourceTableView = where("Bank Account No" = filter(<> ''),
                            Posted = const(true));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Staff No"; "Staff No")
                {
                    ApplicationArea = Basic;
                    Caption = 'Ref No';
                }
                field("Client Code"; "Client Code")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Product Type"; "Loan Product Type")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Product Type Name"; "Loan Product Type Name")
                {
                    ApplicationArea = Basic;
                }
                field("Client Name"; "Client Name")
                {
                    ApplicationArea = Basic;
                }
                field("Beneficiary Account"; "Bank Account No")
                {
                    ApplicationArea = Basic;
                }
                field("Bank code"; "Bank code")
                {
                    ApplicationArea = Basic;
                }
                field("Bank Branch"; "Bank Branch")
                {
                    ApplicationArea = Basic;
                }
                field("Net Disbursed"; "Loan Disbursed Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Disbursement Date"; "Loan Disbursement Date")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    var
        ObjLoanProductCharges: Record "Loan Product Charges";
    begin
        GenSetUp.Get;
        Upfronts := 0;
        "Net Disbursed" := 0;
        ProductChargesAmount := 0;
        ObjLoanProductCharges.Reset;
        ObjLoanProductCharges.SetRange(ObjLoanProductCharges."Product Code", "Loan Product Type");
        if ObjLoanProductCharges.Find('-') then begin


            if ObjLoanProductCharges."Use Perc" then begin
                ProductChargesAmount := ProductChargesAmount + ((ObjLoanProductCharges.Percentage * "Approved Amount") / 100);

            end
            else
                ProductChargesAmount := ProductChargesAmount + ObjLoanProductCharges.Amount;
        end;

        CalcFields("Loan Offset Amount", "Offset Commission");
        Upfronts := "Loan Offset Amount" + "Offset Commission" + GenSetUp."Loan Trasfer Fee-Cheque" +
        "Boosted Amount" + "Deposit Reinstatement" + ProductChargesAmount + "Share Capital Due";
        "Net Disbursed" := "Approved Amount" - Upfronts;
    end;

    var
        "Net Disbursed": Decimal;
        Upfronts: Decimal;
        GenSetUp: Record "Sacco General Set-Up";
        ProductChargesAmount: Decimal;
}

