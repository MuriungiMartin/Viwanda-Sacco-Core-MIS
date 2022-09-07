#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50353 "Cheque Register Bank"
{
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = "Cheque Book Register";

    layout
    {
        area(content)
        {
            repeater(Control6)
            {
            }
            field(BankAccount; BankAccount)
            {
                ApplicationArea = Basic;
                Caption = 'Bank Account No';
                TableRelation = "Bank Account"."No.";
            }
            field(ChequeBookStartingNo; ChequeBookStartingNo)
            {
                ApplicationArea = Basic;
                Caption = 'Cheque Book Starting No';
            }
            field(NoOfLeaves; NoOfLeaves)
            {
                ApplicationArea = Basic;
                Caption = 'No of Leaves';
            }
            repeater(Control8)
            {
                field("Cheque No."; "Cheque No.")
                {
                    ApplicationArea = Basic;
                }
                field(Issued; Issued)
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field(Cancelled; Cancelled)
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Bank Account"; "Bank Account")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(ChequeNosGeneration)
            {
                ApplicationArea = Basic;
                Caption = 'Generate Cheque Nos';
                Image = Grid;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to generate Cheque Book Nos.?', false) = false then
                        exit;

                    i := 0;

                    repeat
                        i := i + 1;

                        ObjChequeBook.Init;
                        ObjChequeBook."Cheque No." := ChequeBookStartingNo;
                        ObjChequeBook."Bank Account" := BankAccount;
                        ObjChequeBook.Insert;

                        ChequeBookStartingNo := IncStr(ChequeBookStartingNo);
                    until i = NoOfLeaves;
                end;
            }
        }
    }

    var
        ChequeBookStartingNo: Code[20];
        NoOfLeaves: Integer;
        i: Integer;
        ObjChequeBook: Record "Cheque Book Register";
        BankAccount: Code[30];
}

