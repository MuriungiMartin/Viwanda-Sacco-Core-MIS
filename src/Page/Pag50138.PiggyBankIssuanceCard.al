#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50138 "Piggy Bank Issuance Card"
{
    PageType = Card;
    SourceTable = "Piggy Bank Issuance";

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
                field("Member Account No"; "Member Account No")
                {
                    ApplicationArea = Basic;
                }
                field("Member Name"; "Member Name")
                {
                    ApplicationArea = Basic;
                }
                field("Piggy Bank Account"; "Piggy Bank Account")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        PiggyBankIssuance.Reset;
                        PiggyBankIssuance.SetRange(PiggyBankIssuance."Piggy Bank Account", "Piggy Bank Account");
                        PiggyBankIssuance.SetRange(PiggyBankIssuance.Issued, true);
                        if PiggyBankIssuance.FindSet then
                            "Exisiting piggy Bank" := true;
                    end;
                }
                field("Piggy Bank Account Name"; "Piggy Bank Account Name")
                {
                    ApplicationArea = Basic;
                }
                field("Exisiting piggy Bank"; "Exisiting piggy Bank")
                {
                    ApplicationArea = Basic;
                    Caption = 'Has Existing Piggy Bank';
                }
                field("Issued By"; "Issued By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Issued On"; "Issued On")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Collected By"; "Collected By")
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
            action("Issue Piggy Bank")
            {
                ApplicationArea = Basic;
                Image = PostDocument;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    if Confirm('Confirm Piggy Bank Charge?', false) = true then begin
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                        GenJournalLine.SetRange("Journal Batch Name", 'DEFAULT');
                        GenJournalLine.DeleteAll;

                        SFactory.FnRunPostPiggyBankCharges("Piggy Bank Account", "Exisiting piggy Bank");
                    end;
                    Message('Piggy Bank Issued Successfully Successfully');


                    "Issued On" := WorkDate;
                    "Issued By" := UserId;
                    Issued := true;
                end;
            }
        }
    }

    var
        GenJournalLine: Record "Gen. Journal Line";
        LineNo: Integer;
        SFactory: Codeunit "SURESTEP Factory";
        VarPiggyBankFee: Decimal;
        ObjAccountType: Record "Account Types-Saving Products";
        ObjAccount: Record Vendor;
        ObjGensetup: Record "Sacco General Set-Up";
        VarTaxAmount: Decimal;
        VarAccountAvailableBal: Decimal;
        PiggyBankIssuance: Record "Piggy Bank Issuance";
        VarTransactionNarrationDebit: Text;
        VarTransactionNarrationCredit: Text;
}

