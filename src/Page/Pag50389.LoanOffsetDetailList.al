#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50389 "Loan Offset Detail List"
{
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Loan Offset Details";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("FOSA Account"; "FOSA Account")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specify the Member FOSA Account to Debit when reducing the Loan Balance,Only Specify When the Customer has not meet the Minimum Offset amount';
                    Visible = false;
                }
                field("Loan Top Up"; "Loan Top Up")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loan to Offset';
                }
                field("Client Code"; "Client Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Enabled = false;
                }
                field("BOSA No"; "BOSA No")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Type"; "Loan Type")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Principle Top Up"; "Principle Top Up")
                {
                    ApplicationArea = Basic;
                }
                field("Interest Top Up"; "Interest Top Up")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Monthly Repayment"; "Monthly Repayment")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Outstanding Balance"; "Outstanding Balance")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Commision; Commision)
                {
                    ApplicationArea = Basic;
                    Caption = 'Booster Interest';
                    Editable = false;
                }
                field("Tax On Comission"; "Tax On Comission")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Loan Insurance: Current Year"; "Loan Insurance: Current Year")
                {
                    ApplicationArea = Basic;
                }
                field("Interest Due at Clearance"; "Interest Due at Clearance")
                {
                    ApplicationArea = Basic;
                    Caption = ' Interest Due';
                    Visible = false;
                }
                field("Total Top Up"; "Total Top Up")
                {
                    ApplicationArea = Basic;
                    Caption = 'Total Recovery(P+I+Leavy)';
                    Editable = false;
                    Importance = Promoted;
                    Style = Attention;
                    StyleExpr = true;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Loan Payoff")
            {
                ApplicationArea = Basic;
                Image = Document;
                Promoted = true;
                RunObject = Page "Loan PayOff List";
            }
            action(ReduceLoanBalance)
            {
                ApplicationArea = Basic;
                Image = Post;
                Promoted = true;

                trigger OnAction()
                begin

                    ObjLoanOffset.Reset;
                    ObjLoanOffset.SetRange(ObjLoanOffset."Loan Top Up", "Loan Top Up");
                    ObjLoanOffset.SetRange(ObjLoanOffset."FOSA Account", "FOSA Account");
                    if ObjLoanOffset.Find('-') then begin
                        if ObjLoanOffset."FOSA Account" = '' then begin
                            Error('Specify the FOSA Account to be Debited When reducing the Loan');
                        end;
                        Report.run(50934, true, false, ObjLoanOffset);
                    end;
                end;
            }
        }
    }

    var
        ObjLoanOffset: Record "Loan Offset Details";
}

