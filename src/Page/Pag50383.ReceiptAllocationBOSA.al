#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50383 "Receipt Allocation-BOSA"
{
    PageType = ListPart;
    SourceTable = "Receipt Allocation";

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                field("Account Type"; "Account Type")
                {
                    ApplicationArea = Basic;
                }
                field("Member No"; "Member No")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Type"; "Transaction Type")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        if ("Transaction Type" <> "transaction type"::"FOSA Account") and ("Transaction Type" <> "transaction type"::" ") then begin
                            "Account Type" := "account type"::Customer
                        end else
                            "Account Type" := "account type"::Vendor;
                    end;
                }
                field(Description; Description)
                {
                    ApplicationArea = Basic;
                }
                field("Loan No."; "Loan No.")
                {
                    ApplicationArea = Basic;
                }
                field(Amount; Amount)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        "Account Type" := "account type"::Member;
    end;

    trigger OnOpenPage()
    begin
        /*sto.RESET;
        sto.SETRANGE(sto."No.","Document No");
        IF sto.FIND('-') THEN BEGIN
        IF sto.Status=sto.Status::Approved THEN BEGIN
        CurrPage.EDITABLE:=FALSE;
        END ELSE
        CurrPage.EDITABLE:=TRUE;
        END;
        */

    end;

    var
        sto: Record "Standing Orders";
        Loan: Record "Loans Register";
        ReceiptAllocation: Record "Receipt Allocation";
        ReceiptH: Record "Receipts & Payments";
}

