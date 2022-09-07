#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50585 "Standing Order Card Approved"
{
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = "Standing Orders";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; "No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Source Account Type"; "Source Account Type")
                {
                    ApplicationArea = Basic;
                }
                field("Source Account No."; "Source Account No.")
                {
                    ApplicationArea = Basic;
                    AssistEdit = false;
                    Editable = true;
                }
                field("Staff/Payroll No."; "Staff/Payroll No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Account Name"; "Account Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Source Account Narrations"; "Source Account Narrations")
                {
                    ApplicationArea = Basic;
                }
                field("Source Global Dimension 1 Code"; "Source Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'Source Account Activity';
                }
                field("Source Global Dimension 2 Code"; "Source Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'Source Account Branch';
                }
                field(Amount; Amount)
                {
                    ApplicationArea = Basic;
                }
                field("Destination Account Type"; "Destination Account Type")
                {
                    ApplicationArea = Basic;
                }
                field("Destination Account No."; "Destination Account No.")
                {
                    ApplicationArea = Basic;
                }
                field("Destination Account Name"; "Destination Account Name")
                {
                    ApplicationArea = Basic;
                }
                field("Destination Account Narrations"; "Destination Account Narrations")
                {
                    ApplicationArea = Basic;
                }
                field("Dest. Global Dimension 1 Code"; "Dest. Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'Destination Account Activity';
                }
                field("Dest. Global Dimension 2 Code"; "Dest. Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'Destination Account Branch';
                }
                group(BankDetails)
                {
                    Caption = 'BankDetails';
                    Visible = BankDetailsVisible;
                    field("Bank Code"; "Bank Code")
                    {
                        ApplicationArea = Basic;

                        trigger OnValidate()
                        begin
                            BankName := '';
                            if Banks.Get("Bank Code") then
                                BankName := Banks."Bank Name";
                        end;
                    }
                    field(BankName; BankName)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Bank Name';
                    }
                }
                field("BOSA Account No."; "BOSA Account No.")
                {
                    ApplicationArea = Basic;
                    Importance = Additional;
                }
                field("Allocated Amount"; "Allocated Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Effective/Start Date"; "Effective/Start Date")
                {
                    ApplicationArea = Basic;
                }
                field(Duration; Duration)
                {
                    ApplicationArea = Basic;
                }
                field("End Date"; "End Date")
                {
                    ApplicationArea = Basic;
                    Importance = Additional;
                }
                field(Frequency; Frequency)
                {
                    ApplicationArea = Basic;
                }
                field("Execute Condition"; "Execute Condition")
                {
                    ApplicationArea = Basic;
                }
                field("Don't Allow Partial Deduction"; "Don't Allow Partial Deduction")
                {
                    ApplicationArea = Basic;
                }
                field(Unsuccessfull; Unsuccessfull)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Additional;
                }
                field("Next Run Date"; "Next Run Date")
                {
                    ApplicationArea = Basic;
                }
                group("Retry Details:")
                {
                    Caption = 'Retry Details:';
                    Visible = ExecuteConditionVisible;
                    field("No of Tolerance Days"; "No of Tolerance Days")
                    {
                        ApplicationArea = Basic;
                        Caption = 'No of Retry Days';
                        Editable = false;
                        Importance = Additional;
                    }
                    field("Next Attempt Date"; "Next Attempt Date")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Next Retry Date';
                    }
                    field("End of Tolerance Date"; "End of Tolerance Date")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Last Retry Date';
                        Editable = false;
                        ToolTip = 'This is the last date the system will attempt to run the standing order after the tolerance period';
                    }
                }
                field(Balance; Balance)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Additional;
                }
                field(Effected; Effected)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Additional;
                }
                field("Auto Process"; "Auto Process")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Additional;
                }
                field("Standing Order Dedution Type"; "Standing Order Dedution Type")
                {
                    ApplicationArea = Basic;
                }
                field("None Salary"; "None Salary")
                {
                    ApplicationArea = Basic;
                    Importance = Additional;
                }
                field("Date Reset"; "Date Reset")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Additional;
                }
                field(Status; Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Posted By"; "Posted By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Additional;
                }
                field("Is Active"; "Is Active")
                {
                    ApplicationArea = Basic;
                }
                field("Created On"; "Created On")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Created By"; "Created By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            part("Receipt Allocation"; "Receipt Allocation-BOSA")
            {
                SubPageLink = "Document No" = field("No.");
                Visible = ReceiptAllVisible;
            }
        }
        area(factboxes)
        {
            part(Control2; "FOSA Statistics FactBox")
            {
                SubPageLink = "No." = field("Source Account No.");
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Reset)
            {
                ApplicationArea = Basic;
                Caption = 'Reset';
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to reset the standing order?') = true then begin

                        Effected := false;
                        Balance := 0;
                        Unsuccessfull := false;
                        "Auto Process" := false;
                        "Date Reset" := Today;
                        Modify;

                        RAllocations.Reset;
                        RAllocations.SetRange(RAllocations."Document No", "No.");
                        if RAllocations.Find('-') then begin
                            repeat
                                RAllocations."Amount Balance" := 0;
                                RAllocations."Interest Balance" := 0;
                                RAllocations.Modify;
                            until RAllocations.Next = 0;
                        end;

                    end;
                end;
            }
            action(Approve)
            {
                ApplicationArea = Basic;
                Caption = 'Approve';
                Enabled = true;
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                begin
                    TestField("Source Account No.");
                    if "Destination Account Type" <> "destination account type"::"Other Banks Account" then
                        TestField("Destination Account No.");
                    TestField("Effective/Start Date");
                    TestField(Frequency);
                    TestField("Next Run Date");


                    StatusPermissions.Reset;
                    StatusPermissions.SetRange(StatusPermissions."User ID", UserId);
                    StatusPermissions.SetRange(StatusPermissions."Function", StatusPermissions."function"::"Standing Order");
                    if StatusPermissions.Find('-') = false then
                        Error('You do not have permissions to change the standing order status.');
                end;
            }
            action(Reject)
            {
                ApplicationArea = Basic;
                Caption = 'Reject';
                Image = Reject;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                begin
                    StatusPermissions.Reset;
                    StatusPermissions.SetRange(StatusPermissions."User ID", UserId);
                    StatusPermissions.SetRange(StatusPermissions."Function", StatusPermissions."function"::"Standing Order");
                    if StatusPermissions.Find('-') = false then
                        Error('You do not have permissions to change the standing status.');
                end;
            }
            action(Stop)
            {
                ApplicationArea = Basic;
                Caption = 'Stop';
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                begin
                    StatusPermissions.Reset;
                    StatusPermissions.SetRange(StatusPermissions."User ID", UserId);
                    StatusPermissions.SetRange(StatusPermissions."Function", StatusPermissions."function"::"Standing Order");
                    if StatusPermissions.Find('-') = false then
                        Error('You do not have permissions to stop the standing order.');

                    if Confirm('Are you sure you want to stop the standing order?', false) = true then begin
                        //Status:=Status::"2";
                        //MODIFY;
                    end;
                end;
            }
            group(Approvals)
            {
                Visible = false;
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
                        DocumentType := Documenttype::STO;
                        ApprovalEntries.Setfilters(Database::"HR Commitee Members", DocumentType, "No.");
                        ApprovalEntries.Run;
                    end;
                }
                action("Send Approval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send Approval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        Text001: label 'This request is already pending approval';
                        Approvalmgt: Codeunit "Approvals Mgmt.";
                    begin
                        TestField("Source Account No.");
                        if "Destination Account Type" <> "destination account type"::"Other Banks Account" then
                            TestField("Destination Account No.");

                        TestField("Effective/Start Date");
                        TestField(Frequency);
                        TestField("Next Run Date");

                        if "Destination Account Type" = "destination account type"::"Other Banks Account" then begin
                            CalcFields("Allocated Amount");
                            if Amount <> "Allocated Amount" then
                                Error('Allocated amount must be equal to amount');
                        end;

                        if Status <> Status::Open then
                            Error(Text001);


                        /*
                       //End allocate batch number
                       IF Approvalmgt.SendFOSASTOApprovalRequest(Rec) THEN;
                         */
                        Status := Status::Approved;
                        "Posted By" := UserId;

                    end;
                }
                action("Cancel Approval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Request';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        Approvalmgt: Codeunit "Approvals Mgmt.";
                    begin

                        //IF Approvalmgt.CancelFOSASTOApprovalRequest(Rec,TRUE,TRUE) THEN;
                    end;
                }
            }
        }
        area(creation)
        {
            action(Create_STO)
            {
                ApplicationArea = Basic;
                Caption = 'Acitvate STO';
                Enabled = true;
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    TestField("Source Account No.");
                    if "Destination Account Type" <> "destination account type"::"Other Banks Account" then
                        TestField("Destination Account No.");
                    TestField("Effective/Start Date");
                    TestField(Frequency);
                    TestField("Next Run Date");

                    if "Is Active" = true then begin
                        Error('The Standing Order is already Activated');
                        exit;
                    end;

                    if Confirm('Are you sure you want to activate this Standing Order?') = false then
                        exit;
                    "Is Active" := true;
                    "Posted By" := UserId;
                    Modify;
                end;
            }
            action(StopAmend)
            {
                ApplicationArea = Basic;
                Caption = 'Amend Standing Order';
                Image = Edit;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    if Confirm('Confirm Standing Order Amend', false) = true then begin
                        Status := Status::Open;
                        "Modified By" := UserId;
                        "Modified On" := CurrentDatetime;
                        Modify;
                        Message('Standing Order Reopened Succesfully');
                    end;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        BankName := '';
        if Banks.Get("Bank Code") then
            BankName := Banks."Bank Name";

        ReceiptAllVisible := false;
        if "Destination Account Type" = "destination account type"::"Other Banks Account" then begin
            ReceiptAllVisible := true;
        end;

        BankDetailsVisible := false;
        if "Destination Account Type" = "destination account type"::"Member Account" then begin
            BankDetailsVisible := true;
        end;

        ExecuteConditionVisible := false;
        if "Execute Condition" = "execute condition"::"If no Funds Retry Standing Order" then begin
            ExecuteConditionVisible := true;
        end;
    end;

    trigger OnOpenPage()
    begin
        if Status = Status::Approved then
            CurrPage.Editable := false;

        ReceiptAllVisible := false;
        if "Destination Account Type" = "destination account type"::"Other Banks Account" then begin
            ReceiptAllVisible := true;
        end;

        BankDetailsVisible := false;
        if "Destination Account Type" = "destination account type"::"Member Account" then begin
            BankDetailsVisible := true;
        end;

        ExecuteConditionVisible := false;
        if "Execute Condition" = "execute condition"::"If no Funds Retry Standing Order" then begin
            ExecuteConditionVisible := true;
        end;
    end;

    var
        StatusPermissions: Record "Status Change Permision";
        BankName: Text[20];
        Banks: Record Banks;
        UsersID: Record User;
        RAllocations: Record "Receipt Allocation";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None",JV,"Member Closure","Account Opening",Batches,"Payment Voucher","Petty Cash",Requisition,Loan,Interbank,Imprest,Checkoff,"FOSA Account Opening",STO;
        ReceiptAllVisible: Boolean;
        ObjAccount: Record Vendor;
        BankDetailsVisible: Boolean;
        ExecuteConditionVisible: Boolean;

    local procedure AllocatedAmountOnDeactivate()
    begin
        CurrPage.Update := true;
    end;
}

