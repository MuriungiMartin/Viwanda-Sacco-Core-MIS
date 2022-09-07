#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50977 "Collateral Movement"
{
    Editable = false;
    PageType = ListPart;
    SourceTable = "Collateral Movement  Register";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No"; "Document No")
                {
                    ApplicationArea = Basic;
                }
                field("Action Application date"; "Action Application date")
                {
                    ApplicationArea = Basic;
                }
                field("Action Type"; "Action Type")
                {
                    ApplicationArea = Basic;
                }
                field("Actioned By(Custodian 1)"; "Actioned By(Custodian 1)")
                {
                    ApplicationArea = Basic;
                }
                field("Actioned By(Custodian 2)"; "Actioned By(Custodian 2)")
                {
                    ApplicationArea = Basic;
                }
                field("Actioned On(Custodian 1)"; "Actioned On(Custodian 1)")
                {
                    ApplicationArea = Basic;
                }
                field("Actioned On(Custodian 2)"; "Actioned On(Custodian 2)")
                {
                    ApplicationArea = Basic;
                }
                field("Lawyer Code"; "Lawyer Code")
                {
                    ApplicationArea = Basic;
                }
                field("Lawyer Name"; "Lawyer Name")
                {
                    ApplicationArea = Basic;
                }
                field("Insurance Agent Code"; "Insurance Agent Code")
                {
                    ApplicationArea = Basic;
                }
                field("Insurance Agent Name"; "Insurance Agent Name")
                {
                    ApplicationArea = Basic;
                }
                field("Action Branch"; "Action Branch")
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
    begin
        CustodiansDetailsvisible := false;
        LawyersDetailsvisible := false;
        InsuranceDetailsvisible := false;
        BranchDetailsvisible := false;
        Auctioneervisible := false;

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
    end;

    var
        CustodiansDetailsvisible: Boolean;
        LawyersDetailsvisible: Boolean;
        InsuranceDetailsvisible: Boolean;
        BranchDetailsvisible: Boolean;
        Auctioneervisible: Boolean;
        ObjCollateralActions: Record "Collateral Movement Actions";
        ObjCustodians: Record "Safe Custody Custodians";
}

