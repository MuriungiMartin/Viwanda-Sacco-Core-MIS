#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50357 "Account Freeze Amount Card"
{
    PageType = Card;
    SourceTable = "Member Account Freeze Details";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Document No"; "Document No")
                {
                    ApplicationArea = Basic;
                }
                field("Member No"; "Member No")
                {
                    ApplicationArea = Basic;
                    Editable = EnableFreeze;
                }
                field("Member Name"; "Member Name")
                {
                    ApplicationArea = Basic;
                }
                field("Account No"; "Account No")
                {
                    ApplicationArea = Basic;
                    Editable = EnableFreeze;
                }
                field("Current Book Balance"; "Current Book Balance")
                {
                    ApplicationArea = Basic;
                }
                field("Uncleared Cheques"; "Uncleared Cheques")
                {
                    ApplicationArea = Basic;
                }
                field("Overdraft Limit"; "Overdraft Limit")
                {
                    ApplicationArea = Basic;
                }
                field("Current Frozen Amount"; "Current Frozen Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Current Available Balance"; "Current Available Balance")
                {
                    ApplicationArea = Basic;
                }
                field("Amount to Freeze"; "Amount to Freeze")
                {
                    ApplicationArea = Basic;
                    Editable = EnableFreeze;
                }
                field("Reason For Freezing"; "Reason For Freezing")
                {
                    ApplicationArea = Basic;
                    Editable = EnableFreeze;
                }
                field("Loan Freeze"; "Loan Freeze")
                {
                    ApplicationArea = Basic;
                }
                field("Captured On"; "Captured On")
                {
                    ApplicationArea = Basic;
                }
                field("Captured By"; "Captured By")
                {
                    ApplicationArea = Basic;
                }
                field(Frozen; Frozen)
                {
                    ApplicationArea = Basic;
                }
                field("Frozen On"; "Frozen On")
                {
                    ApplicationArea = Basic;
                }
                field("Frozen By"; "Frozen By")
                {
                    ApplicationArea = Basic;
                }
                field(Unfrozen; Unfrozen)
                {
                    ApplicationArea = Basic;
                }
                field("Unfrozen On"; "Unfrozen On")
                {
                    ApplicationArea = Basic;
                }
                field("Unfrozen By"; "Unfrozen By")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Freeze Amount")
            {
                ApplicationArea = Basic;
                Enabled = EnableFreeze;
                Image = Lock;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    TestField("Reason For Freezing");
                    if Frozen = true then
                        Error('The amount is already frozen');

                    if Confirm('Confirm Freeze Action?', false) = true then begin

                        if ObjAccount.Get("Account No") then begin
                            ObjAccount."Frozen Amount" := ObjAccount."Frozen Amount" + "Amount to Freeze";
                            Frozen := true;
                            "Frozen On" := WorkDate;
                            "Frozen By" := UserId;
                            ObjAccount.Modify;
                        end;
                    end;
                end;
            }
            action("UnFreeze Amount")
            {
                ApplicationArea = Basic;
                Enabled = EnableUnFreeze;
                Image = UnLinkAccount;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    if Unfrozen = true then
                        Error('The amount is already unfrozen');

                    if Confirm('Confirm Freeze Action?', false) = true then begin
                        if ObjAccount.Get("Account No") then begin
                            ObjAccount."Frozen Amount" := ObjAccount."Frozen Amount" - "Amount to Freeze";
                            Unfrozen := true;
                            "Unfrozen On" := WorkDate;
                            "Unfrozen By" := UserId;
                            ObjAccount.Modify;
                        end;
                    end;
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        FnEnableActions;
    end;

    trigger OnAfterGetRecord()
    begin
        FnEnableActions;
    end;

    trigger OnOpenPage()
    begin
        FnEnableActions;
    end;

    var
        ObjAccount: Record Vendor;
        EnableFreeze: Boolean;
        EnableUnFreeze: Boolean;

    local procedure FnEnableActions()
    begin
        EnableFreeze := false;
        EnableUnFreeze := false;

        if Frozen = true then
            EnableUnFreeze := true;

        if Frozen = false then
            EnableFreeze := true;

        if Unfrozen = true then
            EnableUnFreeze := false;
    end;
}

