#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50341 "Pension Processing Header"
{
    PageType = Card;
    SourceTable = "Pension Processing Headerr";

    layout
    {
        area(content)
        {
            group(General)
            {
                field(No; No)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Entered By"; "Entered By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Date Entered"; "Date Entered")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Posting date"; "Posting date")
                {
                    ApplicationArea = Basic;
                }
                field("Document No"; "Document No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Remarks; Remarks)
                {
                    ApplicationArea = Basic;
                }
                field("Total Count"; "Total Count")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Posted By"; "Posted By")
                {
                    ApplicationArea = Basic;
                }
                field("Account Type"; "Account Type")
                {
                    ApplicationArea = Basic;
                }
                field("Account No"; "Account No")
                {
                    ApplicationArea = Basic;
                }
                field("Cheque No."; "Cheque No.")
                {
                    ApplicationArea = Basic;
                }
                field(Posted; Posted)
                {
                    ApplicationArea = Basic;
                }
                field(Amount; Amount)
                {
                    ApplicationArea = Basic;
                }
                field("Scheduled Amount"; "Scheduled Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Employer Code"; "Employer Code")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Pre-Post Blocked Status Update"; "Pre-Post Blocked Status Update")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Post-Post Blocked Statu Update"; "Post-Post Blocked Statu Update")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            part("50000"; "Pension Processing Lines")
            {
                Caption = 'Salary Processing Lines';
                SubPageLink = "Salary Header No." = field(No);
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Import Salaries")
            {
                ApplicationArea = Basic;
                Caption = 'Import Salaries';
                //   RunObject = XMLport UnknownXMLport50025;
            }
            group(ActionGroup1102755021)
            {
                action("UnBlocked Accounts Status")
                {
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        salarybuffer.Reset;
                        salarybuffer.SetRange(salarybuffer."Salary Header No.", No);
                        if salarybuffer.Find('-') then
                            Report.run(50862, true, false, salarybuffer);

                        "Pre-Post Blocked Status Update" := true;
                        Modify;
                    end;
                }
                action("Block Blocked Accounts Status")
                {
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        salarybuffer.Reset;
                        salarybuffer.SetRange(salarybuffer."Salary Header No.", No);
                        if salarybuffer.Find('-') then
                            Report.run(50863, true, false, salarybuffer);

                        "Post-Post Blocked Statu Update" := true;
                        Modify;
                    end;
                }
                action("Validate Salary ")
                {
                    ApplicationArea = Basic;

                    trigger OnAction()
                    begin

                        salarybuffer.Reset;
                        salarybuffer.SetRange(salarybuffer."Salary Header No.", No);
                        if salarybuffer.Find('-') then
                            Report.run(50353, true, false, salarybuffer);
                    end;
                }
                action("Generate Pension Batch")
                {
                    ApplicationArea = Basic;
                    Caption = 'Generate Pension Batch';

                    trigger OnAction()
                    begin
                        TestField(Amount);



                        salarybuffer.Reset;
                        salarybuffer.SetRange(salarybuffer."Salary Header No.", No);
                        if salarybuffer.Find('-') then
                            Report.run(50532, true, false, salarybuffer);
                        // Report.run(50539,TRUE,FALSE,salarybuffer);
                        //Posted:=TRUE;
                        //"Posted By":=USERID;
                        //MODIFY;
                    end;
                }
                action("Mark as processed")
                {
                    ApplicationArea = Basic;
                    //  RunObject = Report UnknownReport39004375;
                }
            }
            group(ActionGroup1102755019)
            {
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Pension := true;
    end;

    var
        Gnljnline: Record "Gen. Journal Line";
        PDate: Date;
        DocNo: Code[20];
        RunBal: Decimal;
        ReceiptsProcessingLines: Record "Checkoff Lines-Distributed";
        LineNo: Integer;
        LBatches: Record "Loan Disburesment-Batching";
        Jtemplate: Code[30];
        JBatch: Code[30];
        "Cheque No.": Code[20];
        DActivityBOSA: Code[20];
        DBranchBOSA: Code[20];
        ReptProcHeader: Record "Checkoff Header-Distributed";
        Cust: Record Customer;
        salarybuffer: Record "Pension Processing Lines";
        SalHeader: Record "Pension Processing Headerr";
        Sto: Record "Standing Orders";
}

