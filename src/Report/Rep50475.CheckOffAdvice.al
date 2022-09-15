#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // 

Report 50475 "CheckOff Advice"
{
    RDLCLayout = 'Layouts/CheckOffAdvice.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem(Customer; Customer)
        {
            trigger OnAfterGetRecord();
            begin
                LoansRec.Reset;
                LoansRec.SetRange(LoansRec."Client Code", Customer."No.");
                LoansRec.SetRange(LoansRec."Loan Product Type", 'NORMAL');
                if LoansRec.Find('-') then begin
                    if LoansRec."Outstanding Balance" > 0 then begin
                        NormPr := LoansRec."Loan Principle Repayment";
                        NormInt := LoansRec."Loan Interest Repayment";
                    end;
                end;
                LoansRec.Reset;
                LoansRec.SetRange(LoansRec."Client Code", Customer."No.");
                LoansRec.SetRange(LoansRec."Loan Product Type", 'EMERGENCY');
                if LoansRec.Find('-') then begin
                    if LoansRec."Outstanding Balance" > 0 then begin
                        EmerPr := LoansRec."Loan Principle Repayment";
                        EmerInt := LoansRec."Loan Interest Repayment";
                    end;
                end;
                LoansRec.Reset;
                LoansRec.SetRange(LoansRec."Client Code", Customer."No.");
                LoansRec.SetRange(LoansRec."Loan Product Type", 'COLLEGE');
                if LoansRec.Find('-') then begin
                    if LoansRec."Outstanding Balance" > 0 then begin
                        CollegePr := LoansRec."Loan Principle Repayment";
                        CollegeInt := LoansRec."Loan Interest Repayment";
                    end;
                end;
                LoansRec.Reset;
                LoansRec.SetRange(LoansRec."Client Code", Customer."No.");
                LoansRec.SetRange(LoansRec."Loan Product Type", 'TOP - UP');
                if LoansRec.Find('-') then begin
                    if LoansRec."Outstanding Balance" > 0 then begin
                        TopupPr := LoansRec."Loan Principle Repayment";
                        Topupint := LoansRec."Loan Interest Repayment";
                    end;
                end;
                LoansRec.Reset;
                LoansRec.SetRange(LoansRec."Client Code", Customer."No.");
                LoansRec.SetRange(LoansRec."Loan Product Type", 'School');
                if LoansRec.Find('-') then begin
                    if LoansRec."Outstanding Balance" > 0 then begin
                        SchoolPr := LoansRec."Loan Principle Repayment";
                        SchoolInt := LoansRec."Loan Interest Repayment";
                    end;
                end;
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
        LoansRec: Record "Loans Register";
        NormPr: Decimal;
        NormInt: Decimal;
        EmerPr: Decimal;
        EmerInt: Decimal;
        SchoolPr: Decimal;
        SchoolInt: Decimal;
        TopupPr: Decimal;
        Topupint: Decimal;
        CollegePr: Decimal;
        CollegeInt: Decimal;
        DefaulterPr: Decimal;
        DefaulterInt: Decimal;


    var

}
