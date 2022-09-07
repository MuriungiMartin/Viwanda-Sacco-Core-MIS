#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50822 "E Banking Loans Applied"
{
    CardPageID = "E Banking Loan App Card";
    DeleteAllowed = true;
    Editable = false;
    InsertAllowed = true;
    ModifyAllowed = true;
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Loans Register";
    SourceTableView = where(Posted = filter(false),
                            "Application type" = filter(Mobile),
                            "Approval Status" = filter(Open),
                            "Loan Status" = filter(Application | Appraisal));

    layout
    {
        area(content)
        {
            repeater(Control1000000010)
            {
                field("Loan  No."; "Loan  No.")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Product Type"; "Loan Product Type")
                {
                    ApplicationArea = Basic;
                }
                field("Client Code"; "Client Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member No';
                }
                field("Client Name"; "Client Name")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member Name';
                }
                field("ID NO"; "ID NO")
                {
                    ApplicationArea = Basic;
                }
                field("Application Date"; "Application Date")
                {
                    ApplicationArea = Basic;
                }
                field("Requested Amount"; "Requested Amount")
                {
                    ApplicationArea = Basic;
                }
                field(Installments; Installments)
                {
                    ApplicationArea = Basic;
                }
                field(Source; Source)
                {
                    ApplicationArea = Basic;
                }
                field("Loan Status"; "Loan Status")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Branch Code"; "Branch Code")
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {
            part(Control1000000001; "Member Statistics FactBox")
            {
                SubPageLink = "No." = field("Client Code");
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Member Accounts")
            {
                ApplicationArea = Basic;
                Image = List;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Member Accounts List";
                RunPageLink = "BOSA Account No" = field("Client Code");
            }
        }
    }

    trigger OnOpenPage()
    begin
        /*//IF UserSet.GET(USERID) THEN BEGIN
        //SETRANGE("Captured By",USERID);
        //END;
        ObjUserSetup.RESET;
        ObjUserSetup.SETRANGE("User ID",USERID);
        IF ObjUserSetup.FIND('-') THEN BEGIN
          IF ObjUserSetup."Approval Administrator"<>TRUE THEN
            //SETRANGE("Captured By",USERID);
          END;
        */

    end;

    var
        UserSet: Record User;
        ObjUserSetup: Record "User Setup";
}

