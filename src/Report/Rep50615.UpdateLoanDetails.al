
Report 50615 "Update Loan Details"
{
    RDLCLayout = 'Layouts/UpdateLoanDetails.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Loans Details Import Buffer"; "Loans Details Import Buffer")
        {
            trigger OnAfterGetRecord();
            begin
                ObjLoans.Init;
                ObjLoans."Loan  No." := "Loans Details Import Buffer"."Loan No";
                ObjLoans."Client Code" := "Loans Details Import Buffer"."Member No";
                ObjLoans."Client Name" := "Loans Details Import Buffer"."Member Name";
                ObjLoans."Loan Product Type" := "Loans Details Import Buffer"."Loan Product Type";
                ObjLoans."Loan Product Type Name" := "Loans Details Import Buffer"."Loan Product Name";
                ObjLoans."Requested Amount" := "Loans Details Import Buffer"."Requested Amount";
                ObjLoans."Approved Amount" := "Loans Details Import Buffer"."Disbursed Amount";
                ObjLoans."Application Date" := "Loans Details Import Buffer"."Application Date";
                ObjLoans."Captured By" := "Loans Details Import Buffer"."Applied By";
                ObjLoans."Issued Date" := "Loans Details Import Buffer"."Disbursed On";
                ObjLoans."Disbursed By" := "Loans Details Import Buffer"."Disbursed By";
                ObjLoans."Loan Disbursement Date" := "Loans Details Import Buffer"."Disbursed On";
                ObjLoans."Repayment Start Date" := "Loans Details Import Buffer"."Repayment Start Date";
                ObjLoans."Repayment Frequency" := ObjLoans."Repayment Frequency";
                ObjLoans."Repayment Method" := "Loans Details Import Buffer"."Repayment Method";
                ObjLoans.Installments := "Loans Details Import Buffer".Instalments;
                ObjLoans.Interest := "Loans Details Import Buffer"."Interest Rate";
                ObjLoans.Rescheduled := "Loans Details Import Buffer".Restructured;
                ObjLoans."Grace Period" := "Loans Details Import Buffer"."Grace Period";
                ObjLoans."Expected Date of Completion" := "Loans Details Import Buffer"."Expected Complition Date";
                ObjLoans."Credit Officer" := "Loans Details Import Buffer"."Credit Officer";
                ObjLoans."Credit Officer II" := "Loans Details Import Buffer"."Credit Officer";
                ObjLoans."Approved By" := "Loans Details Import Buffer"."Approved By";
                ObjLoans."Date Approved" := "Loans Details Import Buffer"."Approved On";
                ObjLoans."Closed On" := "Loans Details Import Buffer"."Closed On";
                ObjLoans."Closed By" := "Loans Details Import Buffer"."Closed By";
                ObjLoans.Repayment := "Loans Details Import Buffer"."Monthly Repayment";
                ObjLoans."Member House Group" := "Loans Details Import Buffer"."House Group ID";
                ObjLoans."Member House Group Name" := "Loans Details Import Buffer"."House Group Name";
                ObjLoans."Loan Recovery Account FOSA" := "Loans Details Import Buffer"."Repayment Account";
                ObjLoans.Posted := true;
                ObjLoans.Insert;
            end;

        }
    }

    requestpage
    {


        SaveValues = false;
        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';

                }
            }
        }

        actions
        {
        }
        trigger OnOpenPage()
        begin

        end;
    }

    trigger OnInitReport()
    begin
        ;


    end;

    trigger OnPostReport()
    begin
        ;

    end;

    trigger OnPreReport()
    begin
        ;

    end;

    var
        ObjLoans: Record "Loans Register";

    var
}

