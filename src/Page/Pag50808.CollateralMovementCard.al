#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50808 "Collateral Movement Card"
{
    PageType = Card;
    SourceTable = "Collateral Movement  Register";

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
                field("Action Application date"; "Action Application date")
                {
                    ApplicationArea = Basic;
                }
                field("Collateral ID"; "Collateral ID")
                {
                    ApplicationArea = Basic;
                }
                field("Collateral Description"; "Collateral Description")
                {
                    ApplicationArea = Basic;
                }
                field("Registered Owner"; "Registered Owner")
                {
                    ApplicationArea = Basic;
                }
                field("Member No."; "Member No.")
                {
                    ApplicationArea = Basic;
                }
                field("Member Name"; "Member Name")
                {
                    ApplicationArea = Basic;
                }
                field("Collateral Type"; "Collateral Type")
                {
                    ApplicationArea = Basic;
                }
                field("Date Received"; "Date Received")
                {
                    ApplicationArea = Basic;
                }
                field("Received By"; "Received By")
                {
                    ApplicationArea = Basic;
                }
                field("Reference No"; "Reference No")
                {
                    ApplicationArea = Basic;
                }
                field("Asset Value"; "Asset Value")
                {
                    ApplicationArea = Basic;
                }
                field("Asset Depreciation Amount"; "Asset Depreciation Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Asset Value @Loan Completion"; "Asset Value @Loan Completion")
                {
                    ApplicationArea = Basic;
                }
                field("Depreciation Completion Date"; "Depreciation Completion Date")
                {
                    ApplicationArea = Basic;
                }
                field("Action Type"; "Action Type")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        CustodiansDetailsvisible := false;
                        LawyersDetailsvisible := false;
                        InsuranceDetailsvisible := false;
                        BranchDetailsvisible := false;
                        ReleasetoMemberVisible := false;
                        Auctioneervisible := false;
                        if ObjCollateralActions.Get("Action Type") then begin
                            if ObjCollateralActions."Action Scope" = ObjCollateralActions."action scope"::Lawyer then begin
                                LawyersDetailsvisible := true;
                            end;
                            if ObjCollateralActions."Action Scope" = ObjCollateralActions."action scope"::Insurance then begin
                                InsuranceDetailsvisible := true;
                            end;
                            if ObjCollateralActions."Action Scope" = ObjCollateralActions."action scope"::Branch then begin
                                BranchDetailsvisible := true;
                            end;
                            if ObjCollateralActions."Action Scope" = ObjCollateralActions."action scope"::Auctioneer then begin
                                Auctioneervisible := true;
                            end;
                            if ObjCollateralActions."No Of Users to Effect Action" = ObjCollateralActions."no of users to effect action"::Dual then begin
                                CustodiansDetailsvisible := true;
                            end;
                        end;

                        if "Action Type" = 'RELEASE TO MEMBER' then begin
                            ReleasetoMemberVisible := true;
                        end;
                    end;
                }
                field("Actioned By(Custodian 1)"; "Actioned By(Custodian 1)")
                {
                    ApplicationArea = Basic;
                    Caption = 'Actioned By';
                }
                field("Actioned On(Custodian 1)"; "Actioned On(Custodian 1)")
                {
                    ApplicationArea = Basic;
                    Caption = 'Actioned On';
                }
                group("Custodians Details")
                {
                    Caption = 'Custodian 2 Details';
                    Visible = CustodiansDetailsvisible;
                    field("Actioned By(Custodian 2)"; "Actioned By(Custodian 2)")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Actioned By';
                    }
                    field("Actioned On(Custodian 2)"; "Actioned On(Custodian 2)")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Actioned On';
                    }
                }
                group("Lawyer Details")
                {
                    Visible = LawyersDetailsvisible;
                    field("Lawyer Code"; "Lawyer Code")
                    {
                        ApplicationArea = Basic;
                    }
                    field("Lawyer Name"; "Lawyer Name")
                    {
                        ApplicationArea = Basic;
                    }
                    field("Collateral Registered"; "Collateral Registered")
                    {
                        ApplicationArea = Basic;
                    }
                }
                group("Insurance Details")
                {
                    Visible = InsuranceDetailsvisible;
                    field("Insurance Agent Code"; "Insurance Agent Code")
                    {
                        ApplicationArea = Basic;
                    }
                    field("Insurance Agent Name"; "Insurance Agent Name")
                    {
                        ApplicationArea = Basic;
                    }
                }
                group("Auctioneer Details")
                {
                    Visible = Auctioneervisible;
                    field("Auctioneer Code"; "Auctioneer Code")
                    {
                        ApplicationArea = Basic;
                    }
                    field("Auctioneer Name"; "Auctioneer Name")
                    {
                        ApplicationArea = Basic;
                    }
                }
                group("Branch Details")
                {
                    Visible = BranchDetailsvisible;
                    field("Action Branch"; "Action Branch")
                    {
                        ApplicationArea = Basic;
                    }
                }
                group("Release to Member")
                {
                    Visible = ReleasetoMemberVisible;
                    field("Release Reason"; "Release Reason")
                    {
                        ApplicationArea = Basic;
                    }
                    field("Released to Member"; "Released to Member")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Collected By';
                    }
                }
                field(Picture; Picture)
                {
                    ApplicationArea = Basic;
                }
                field("Last Collateral Action"; "Last Collateral Action")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Action Effected"; "Action Effected")
                {
                    ApplicationArea = Basic;
                }
                field("Action Effected On"; "Action Effected On")
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
            action("Effect Action")
            {
                ApplicationArea = Basic;
                Image = PostDocument;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    ObjCollateralRegister: Record "Loan Collateral Register";
                begin
                    TestField("Action Type");
                    if "Action Effected" = true then
                        Error('Application has already been effected');

                    if Confirm('Confirm Action ?', false) = true then begin
                        if "No Of Users to Effect Action" = "no of users to effect action"::Single then begin
                            FnRunControlFieldInfo;

                            "Actioned By(Custodian 1)" := UserId;
                            "Actioned On(Custodian 1)" := WorkDate;
                            "Action Effected" := true;
                            "Action Effected On" := WorkDate;
                        end;

                        if "No Of Users to Effect Action" = "no of users to effect action"::Dual then begin
                            FnRunControlFieldInfo;

                            ObjCustodians.Reset;
                            ObjCustodians.SetRange(ObjCustodians."Custodian Of", ObjCustodians."custodian of"::"Safe Custody");
                            ObjCustodians.SetRange(ObjCustodians."User ID", UserId);
                            if ObjCustodians.Find('-') = false then begin
                                Error('Not Authorized to Perform this Action');
                            end;

                            if "Actioned By(Custodian 1)" = '' then begin
                                "Actioned By(Custodian 1)" := UserId;
                                "Actioned On(Custodian 1)" := WorkDate;
                            end else
                                if ("Actioned By(Custodian 1)" <> '') and ("Actioned By(Custodian 1)" <> UserId) then
                                    "Actioned By(Custodian 2)" := UserId;
                            "Actioned On(Custodian 2)" := WorkDate;
                        end;

                        if ("Actioned By(Custodian 1)" <> '') and ("Actioned By(Custodian 2)" <> '') then begin
                            "Action Effected" := true;
                            "Action Effected On" := WorkDate;
                        end;

                        if "Action Effected" = true then begin
                            ObjCollateralRegister.Reset;
                            ObjCollateralRegister.SetRange(ObjCollateralRegister."Document No", "Collateral ID");
                            if ObjCollateralRegister.FindSet then begin
                                ObjCollateralRegister.CalcFields("Last Collateral Action Entry");
                                ObjCollateralRegister."Last Collateral Action" := "Action Type";
                                ObjCollateralRegister."Collateral Registered" := "Collateral Registered";
                                ObjCollateralRegister.Modify;
                            end;
                        end;
                    end;

                    if "Action Type" = 'BOOKED TO SAFE CUSTODY' then begin
                        FnRunMoveCollateraltoSafeCustody;
                    end;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        CustodiansDetailsvisible := false;
        LawyersDetailsvisible := false;
        InsuranceDetailsvisible := false;
        BranchDetailsvisible := false;
        Auctioneervisible := false;
        ReleasetoMemberVisible := false;

        if ObjCollateralActions.Get("Action Type") then begin
            if ObjCollateralActions."Action Scope" = ObjCollateralActions."action scope"::Lawyer then begin
                LawyersDetailsvisible := true;
            end;
            if ObjCollateralActions."Action Scope" = ObjCollateralActions."action scope"::Insurance then begin
                InsuranceDetailsvisible := true;
            end;
            if ObjCollateralActions."Action Scope" = ObjCollateralActions."action scope"::Auctioneer then begin
                Auctioneervisible := true;
            end;
            if ObjCollateralActions."Action Scope" = ObjCollateralActions."action scope"::Branch then begin
                BranchDetailsvisible := true;
            end;
            if ObjCollateralActions."No Of Users to Effect Action" = ObjCollateralActions."no of users to effect action"::Dual then begin
                CustodiansDetailsvisible := true;
            end;

        end;

        if "Action Type" = 'RELEASE TO MEMBER' then begin
            ReleasetoMemberVisible := true;
        end;
    end;

    var
        CustodiansDetailsvisible: Boolean;
        LawyersDetailsvisible: Boolean;
        InsuranceDetailsvisible: Boolean;
        BranchDetailsvisible: Boolean;
        Auctioneervisible: Boolean;
        ReleasetoMemberVisible: Boolean;
        ObjCollateralActions: Record "Collateral Movement Actions";
        ObjCustodians: Record "Safe Custody Custodians";
        ObjNoSeries: Record "Sacco No. Series";
        VarDocumentNo: Code[30];
        NoSeriesMgt: Codeunit NoSeriesManagement;
        ObjSafeCustody: Record "Safe Custody Package Register";
        ObjLoanCollateral: Record "Loan Collateral Details";
        ObjLoans: Record "Loans Register";
        VarChargeFOSAAccount: Code[30];
        VarChargeFOSAAccountName: Text[50];
        ObjCollateralMovement: Record "Collateral Movement  Register";

    local procedure FnRunControlFieldInfo()
    begin
        if ObjCollateralActions.Get("Action Type") then begin
            if ObjCollateralActions."Action Scope" = ObjCollateralActions."action scope"::Lawyer then begin
                TestField("Lawyer Code");
            end;
            if ObjCollateralActions."Action Scope" = ObjCollateralActions."action scope"::Insurance then begin
                TestField("Insurance Agent Code");
            end;
            if ObjCollateralActions."Action Scope" = ObjCollateralActions."action scope"::Auctioneer then begin
                TestField("Auctioneer Code");
            end;
            if ObjCollateralActions."Action Scope" = ObjCollateralActions."action scope"::Branch then begin
                TestField("Action Branch");
            end;

        end;

        if "Action Type" = 'RELEASE TO MEMBER' then begin
            TestField("Released to Member");
        end;
    end;

    local procedure FnRunMoveCollateraltoSafeCustody()
    begin
        if ObjNoSeries.Get then begin
            ObjNoSeries.TestField(ObjNoSeries."Safe Custody Package Nos");
            VarDocumentNo := NoSeriesMgt.GetNextNo(ObjNoSeries."Safe Custody Package Nos", 0D, true);
            if VarDocumentNo <> '' then begin

                ObjLoanCollateral.CalcFields(ObjLoanCollateral."Loan Issued Date", ObjLoanCollateral."Outstanding Balance");
                ObjLoanCollateral.Reset;
                ObjLoanCollateral.SetCurrentkey(ObjLoanCollateral."Loan Issued Date");
                ObjLoanCollateral.SetRange(ObjLoanCollateral."Collateral Registe Doc", "Collateral ID");
                ObjLoanCollateral.SetFilter(ObjLoanCollateral."Outstanding Balance", '=%1', 0);
                if ObjLoanCollateral.FindLast then begin

                    ObjLoans.Reset;
                    ObjLoans.SetRange(ObjLoans."Loan  No.", ObjLoanCollateral."Loan No");
                    if ObjLoans.FindSet then begin
                        VarChargeFOSAAccount := ObjLoans."Account No";
                        VarChargeFOSAAccountName := ObjLoans."Client Name";
                    end;

                end;

                ObjSafeCustody.Init;
                ObjSafeCustody."Package ID" := VarDocumentNo;
                ObjSafeCustody."File Serial No" := "Serial No.";
                ObjSafeCustody."Package Type" := 'Envelope';
                ObjSafeCustody."Package Description" := "Collateral Description";
                Evaluate(ObjSafeCustody."Custody Period", '1Y');
                ObjSafeCustody."Maturity Date" := WorkDate;
                ObjSafeCustody."Member No" := "Member No.";
                ObjSafeCustody."Date Received" := WorkDate;
                ObjSafeCustody."Time Received" := Time;
                ObjSafeCustody."Received By" := UserId;
                ObjSafeCustody."Lodged By(Custodian 1)" := "Actioned By(Custodian 1)";
                ObjSafeCustody."Lodged By(Custodian 2)" := "Actioned By(Custodian 2)";
                ObjSafeCustody."Date Lodged" := "Action Effected On";
                ObjSafeCustody."Member Name" := "Member Name";
                ObjSafeCustody."Maturity Instruction" := ObjSafeCustody."maturity instruction"::Rebook;
                ObjSafeCustody.Status := ObjSafeCustody.Status::Approved;
                ObjSafeCustody."Package Status" := ObjSafeCustody."package status"::Lodged;
                ObjSafeCustody."Charge Account" := VarChargeFOSAAccount;
                ObjSafeCustody."Charge Account Name" := VarChargeFOSAAccountName;
                ObjSafeCustody.Insert;
            end;


        end;
    end;
}

