#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50870 "Guarantor Sub Subform"
{
    DeleteAllowed = false;
    PageType = ListPart;
    SourceTable = "Guarantorship Substitution L";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Loan No."; "Loan No.")
                {
                    ApplicationArea = Basic;
                }
                field("Member No"; "Member No")
                {
                    ApplicationArea = Basic;
                }
                field("Member Name"; "Member Name")
                {
                    ApplicationArea = Basic;
                }
                field("Amount Guaranteed"; "Amount Guaranteed")
                {
                    ApplicationArea = Basic;
                }
                field("Current Commitment"; "Current Commitment")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Substituted; Substituted)
                {
                    ApplicationArea = Basic;
                }
                field("Substitute Member"; "Substitute Member")
                {
                    ApplicationArea = Basic;
                }
                field("Substitute Member Name"; "Substitute Member Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Sub Amount Guaranteed"; "Sub Amount Guaranteed")
                {
                    ApplicationArea = Basic;
                }
                field("Outstanding Balance"; "Outstanding Balance")
                {
                    ApplicationArea = Basic;
                }
                field("Document No"; "Document No")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetCurrRecord()
    begin
        // IF GSubHeader.GET("Document No") THEN BEGIN
        //  IF GSubHeader.Status=GSubHeader.Status::Open THEN BEGIN
        //  SubPageEditable:=TRUE
        //  END ELSE
        //  IF GSubHeader.Status<>GSubHeader.Status::Open THEN BEGIN
        //  SubPageEditable:=FALSE;
        //    END;
        //  END;
    end;

    trigger OnAfterGetRecord()
    begin
        // IF GSubHeader.GET("Document No") THEN BEGIN
        //  IF GSubHeader.Status=GSubHeader.Status::Open THEN BEGIN
        //  SubPageEditable:=TRUE
        //  END ELSE
        //  IF GSubHeader.Status<>GSubHeader.Status::Open THEN BEGIN
        //  SubPageEditable:=FALSE;
        //    END;
        //  END;
    end;

    var
        SubPageEditable: Boolean;
        GSubHeader: Record "Cheque Processing Charges";
}

