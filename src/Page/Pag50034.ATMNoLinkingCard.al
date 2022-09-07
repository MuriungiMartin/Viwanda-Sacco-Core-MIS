#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50034 "ATM No Linking Card"
{
    PageType = Card;
    SourceTable = "ATM Card Applications";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; "No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Account No"; "Account No")
                {
                    ApplicationArea = Basic;
                }
                field("Account Name"; "Account Name")
                {
                    ApplicationArea = Basic;
                }
                field("Account Type"; "Account Type")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Branch Code"; "Branch Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Application Date"; "Application Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Card No"; "Card No")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("ATM Card Linked"; "ATM Card Linked")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("ATM Card Linked By"; "ATM Card Linked By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("ATM Card Linked On"; "ATM Card Linked On")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Link ATM Card")
            {
                ApplicationArea = Basic;
                Caption = 'Link ATM Card';
                Enabled = EnableActions;
                Image = Link;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    if Status <> Status::Approved then
                        Error('This ATM Card application has not been approved');

                    //IF "ATM Card Fee Charged"=FALSE THEN
                    //ERROR('ATM Card Fee has not been Charged on this Application');

                    //Linking Details*******************************************************************************
                    if Confirm('Are you sure you want to link this ATM Card to the Account', false) = true then begin
                        if ObjAccount.Get("Account No") then begin

                            ObjATMCardsBuffer.Init;
                            ObjATMCardsBuffer."Account No" := "Account No";
                            ObjATMCardsBuffer."Account Name" := "Account Name";
                            ObjATMCardsBuffer."Account Type" := "Account Type C";
                            ObjATMCardsBuffer."ATM Card No" := "Card No";
                            ObjATMCardsBuffer."ID No" := "ID No";
                            ObjATMCardsBuffer.Status := ObjATMCardsBuffer.Status::Active;
                            ObjATMCardsBuffer.Insert;
                            //ObjAccount."ATM No.":="Card No";
                            //ObjAccount.MODIFY;
                        end;
                        "ATM Card Linked" := true;
                        "ATM Card Linked By" := UserId;
                        "ATM Card Linked On" := Today;
                        Modify;
                    end;
                    Message('ATM Card linked to Succesfuly to Account No %1', "Account No");
                    //End Linking Details****************************************************************************

                    //Collection Details***********************************
                    Collected := true;
                    "Date Collected" := Today;
                    "Card Issued By" := UserId;
                    "Card Status" := "card status"::Active;
                    Modify;
                    //End Collection Details******************************



                    ObjAccount.Get("Account No");
                    ObjAccount."ATM No." := "Card No";
                    ObjAccount."Atm card ready" := true;
                    ObjAccount.Modify;

                    ObjGensetup.Get();
                    "ATM Expiry Date" := CalcDate(ObjGensetup."ATM Expiry Duration", Today);
                end;
            }
            group(Approvals)
            {
                action(Approval)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approvals';
                    Image = Approval;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                    begin
                        DocumentType := Documenttype::ATMCard;
                        ApprovalEntries.Setfilters(Database::"ATM Card Applications", DocumentType, "No.");
                        ApprovalEntries.Run;
                    end;
                }
                action("Send Approval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send Approval Request';
                    Enabled = (not OpenApprovalEntriesExist) and EnabledApprovalWorkflowsExist;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        Text001: label 'This request is already pending approval';
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin

                        ObjGensetup.Get;

                        /*ObjAccount.RESET;
                        ObjAccount.SETRANGE(ObjAccount."No.","Account No");
                        IF ObjAccount.FIND('-') THEN BEGIN
                        ObjAccount.CALCFIELDS(ObjAccount.Balance,ObjAccount."Uncleared Cheques");
                        AvailableBal:=(ObjAccount.Balance-ObjAccount."Uncleared Cheques");

                        ObjAccTypes.RESET;
                        ObjAccTypes.SETRANGE(ObjAccTypes.Code,ObjAccount."Account Type");
                        IF ObjAccTypes.FIND('-') THEN
                        AvailableBal:=AvailableBal-ObjAccTypes."Minimum Balance";
                        END;*/

                        AvailableBal := SFactory.FnRunGetAccountAvailableBalance("Account No");
                        if "Request Type" = "request type"::New then begin
                            VarTotalATMCardCharge := (ObjGensetup."ATM Card Fee-New Sacco" + ObjGensetup."ATM Card Fee-New Coop") +
                            ((ObjGensetup."ATM Card Fee-New Sacco" + ObjGensetup."ATM Card Fee-New Coop") * (ObjGensetup."Excise Duty(%)" / 100))
                        end else
                            if "Request Type" = "request type"::Replacement then begin
                                VarTotalATMCardCharge := (ObjGensetup."ATM Card Fee-Replacement SACCO" + ObjGensetup."ATM Card Fee-Replacement Coop") +
                                ((ObjGensetup."ATM Card Fee-Replacement SACCO" + ObjGensetup."ATM Card Fee-Replacement Coop") * (ObjGensetup."Excise Duty(%)" / 100))
                            end else
                                if "Request Type" = "request type"::Renewal then begin
                                    VarTotalATMCardCharge := (ObjGensetup."ATM Card Renewal Fee Sacco" + ObjGensetup."ATM Card Renewal Fee Coop") +
                                    ((ObjGensetup."ATM Card Renewal Fee Sacco" + ObjGensetup."ATM Card Renewal Fee Coop") * (ObjGensetup."Excise Duty(%)" / 100))
                                end;

                        if (VarTotalATMCardCharge > AvailableBal) and ("ATM Card Fee Charged" = false) and ("Product Code" <> '403') then
                            Error('Member Account has insufficient Balance for this Application. Available Balance is %1', AvailableBal);





                        /*ATMCardApplication.RESET;
                        ATMCardApplication.SETRANGE(ATMCardApplication."Account No","Account No");
                        ATMCardApplication.SETRANGE(ATMCardApplication."ID No","ID No");
                        ATMCardApplication.SETRANGE(ATMCardApplication."Order ATM Card",FALSE);
                        IF ATMCardApplication.FIND('-') THEN
                          IF ATMCardApplication.COUNT>1 THEN
                          ERROR('This Account already has an ATM Card Application \for the same ID Number that is pending to be ordered.');*/

                        if StrLen("Account Name") > 21 then
                            Error('The ATM Card Applicant Name cannot be more than 21 characters.');

                        if Workflowintegration.CheckATMCardApprovalsWorkflowEnabled(Rec) then
                            Workflowintegration.OnSendATMCardForApproval(Rec);

                    end;
                }
                action("Cancel Approval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Request';
                    Enabled = CanCancelApprovalForRecord;
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        Approvalmgt: Codeunit "Approvals Mgmt.";
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin

                        if Workflowintegration.CheckATMCardApprovalsWorkflowEnabled(Rec) then
                            Workflowintegration.OnCancelATMCardApprovalRequest(Rec);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        EnableActions := false;
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RecordId);
        EnabledApprovalWorkflowsExist := true;

        if ((Rec.Status = Status::Approved)) then
            EnableActions := true;
    end;

    var
        EnableActions: Boolean;
        ObjAccount: Record Vendor;
        ObjATMCardsBuffer: Record "ATM Card Nos Buffer";
        ObjGensetup: Record "Sacco General Set-Up";
        DocumentType: enum "Approval Document Type";
        OpenApprovalEntriesExist: Boolean;
        EnabledApprovalWorkflowsExist: Boolean;
        AvailableBal: Decimal;
        SFactory: Codeunit "SURESTEP Factory";
        VarTotalATMCardCharge: Decimal;
        ATMCardApplication: Record "ATM Card Applications";
        CanCancelApprovalForRecord: Boolean;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        Workflowintegration: Codeunit WorkflowIntegration;
}

