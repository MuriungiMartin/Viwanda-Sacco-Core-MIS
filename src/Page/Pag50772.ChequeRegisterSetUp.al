#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50772 "Cheque Register SetUp"
{
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = "Audit General Setup";

    layout
    {
        area(content)
        {
            repeater(Control6)
            {
                field("Monthy Credits V TurnOver C%"; "Monthy Credits V TurnOver C%")
                {
                    ApplicationArea = Basic;
                }
                field("Cumm. Daily Credits Limit Amt"; "Cumm. Daily Credits Limit Amt")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Cumm. Daily Debits Limit Amt"; "Cumm. Daily Debits Limit Amt")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
            }
            field("Cheque Book Starting No"; BankerCh)
            {
                ApplicationArea = Basic;
            }
            field("No Of Leaflets"; NoOfLeaves)
            {
                ApplicationArea = Basic;
            }
            field("Primary key"; "Primary key")
            {
                ApplicationArea = Basic;
            }
            field("Notification Group Email"; "Notification Group Email")
            {
                ApplicationArea = Basic;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Generate)
            {
                ApplicationArea = Basic;
                Caption = 'Generate';
                Image = Grid;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to generate bankers cheque No.?', false) = false then
                        exit;

                    i := 0;

                    repeat
                        i := i + 1;

                        ObjChequeRegister.Init;
                        // ObjChequeRegister."Monthy Credits V TurnOver C%":=BankerCh;
                        ObjChequeRegister."Primary key" := "Primary key";
                        ObjChequeRegister."Notification Group Email" := "Notification Group Email";
                        ObjChequeRegister.Insert;

                        BankerCh := IncStr(BankerCh);
                    until i = NoOfLeaves;
                end;
            }
        }
    }

    var
        BankerCh: Code[20];
        NoOfLeaves: Integer;
        i: Integer;
        ObjChequeRegister: Record "Audit General Setup";
}

