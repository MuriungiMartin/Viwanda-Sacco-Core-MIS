page 51396 "ChequeCard"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = ChequeRegister;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Cheque No"; "Cheque No")
                {
                    ApplicationArea = All;
                    Editable = false;

                }
                field("Bank"; "Bank")
                {
                    ApplicationArea = All;

                }
                field("Payment To"; "Payment To")
                {
                    ApplicationArea = All;

                }
                field("Date"; "Date")
                {
                    ApplicationArea = All;

                }
                field("Type of PAyment"; "Type of Payment")
                {
                    ApplicationArea = All;

                }
                field("Status"; "Status")
                {
                    ApplicationArea = All;
                    Editable = false;

                }

                field("Description"; "Description")
                {
                    ApplicationArea = All;

                }

            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Send Approval Request")
            {
                ApplicationArea = All;
                Image = SendApprovalRequest;


                trigger OnAction()

                begin
                    if workflowIntergration.CheckChequeApprovalsWorkflowEnabled(Rec) then
                        workflowIntergration
                        .OnSendChequeForApproval(Rec);
                end;
            }
            action("Add Responses")
            {
                ApplicationArea = All;


                trigger OnAction()

                begin
                    Codeunit.Run(Codeunit::"Custom Workflow Events");

                end;
            }


        }
    }

    var
        workflowIntergration: Codeunit WorkflowIntegration;
}