
Report 50606 "Insider Loans Board"
{
    RDLCLayout = 'Layouts/InsiderLoansBoard.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Loans Register"; "Loans Register")
        {
            DataItemTableView = where("Outstanding Balance" = filter(> 0), "Insider-Board" = filter(true));

            column(StartDate; StartDate)
            {
            }
            column(MStartDate; MStartDate)
            {
            }
            column(MEndDate; MEndDate)
            {
            }
            column(AsAt; AsAt)
            {
            }
            column(EmplNme; EmplNme)
            {
            }
            column(EmplNme1; EmplNme1)
            {
            }
            column(LoanNo_LoansRegister; "Loans Register"."Loan  No.")
            {
            }
            column(qwe; qwe)
            {
            }
            column(EmplNmeboard; EmplNmeboard)
            {
            }
            column(EmplNme1board; EmplNme1board)
            {
            }
            column(LoanNo; LoanNo)
            {
            }
            column(LoanNo1; LoanNo1)
            {
            }
            column(LoanNo2; LoanNo2)
            {
            }
            column(LoanNo3; LoanNo3)
            {
            }
            column(InsiderBoard_LoansRegister; "Loans Register"."Insider-Board")
            {
            }
            column(insiderEmployee_LoansRegister; "Loans Register"."Insider-Employee")
            {
            }
            column(t; T)
            {
            }
            column(MEMBERNUMBER; MEMBERNUMBER)
            {
            }
            column(POSITIONHELD; POSITIONHELD)
            {
            }
            column(AMOUNTGRANTED; AMOUNTGRANTED)
            {
            }
            column(DATEAPPROVED; DATEAPPROVED)
            {
            }
            column(AMOUNTrequested; AMOUNT)
            {
            }
            column(AMOUNTOFBOSADEPOSITS; AMOUNTOFBOSADEPOSITS)
            {
            }
            column(NATUREOFSECURITY; NATUREOFSECURITY)
            {
            }
            column(REPAYMENTCOMMENCEMENT; REPAYMENTCOMMENCEMENT)
            {
            }
            column(REPAYMENTPERIOD; REPAYMENTPERIOD)
            {
            }
            column(LOANTYPENAME; LOANTYPENAME)
            {
            }
            column(OUTSTANDINGAMOUNT; OUTSTANDINGAMOUNT)
            {
            }
            column(PERFORMANCE; PERFORMANCE)
            {
            }
            column(LoansCategorySASRA_LoansRegister; "Loans Register"."Loans Category-SASRA")
            {
            }
            column(name; CompanyProperty.DisplayName)
            {
            }
            column(LoansCategory_LoansRegister; "Loans Register"."Loans Category")
            {
            }
            column(SN; SN)
            {
            }
            trigger OnAfterGetRecord();
            begin
                qwe := '';
                T := true;
                F := false;
                AMOUNT := 0;
                AMOUNTGRANTED := 0;
                MEMBERNUMBER := '';
                LoanNo1 := '';
                EmplNme1 := '';
                SN := SN + 1;
                LoanApp.Reset;
                LoanApp.SetRange(LoanApp."Loan  No.", "Loan  No.");
                LoanApp.SetRange(LoanApp."Client Code", "Loans Register"."Client Code");
                LoanApp.SetAutocalcFields("Current Shares", "Outstanding Balance");
                if LoanApp.Find('-') then begin
                    if "Loans Register"."Insider-Board" = true then begin
                        if (LoanApp."Issued Date" >= MStartDate) and (LoanApp."Issued Date" <= MEndDate) then
                            // IF  "Loans Register"."Issued Date" >=MStartDate THEN
                            EmplNme := LoanApp."Client Name";
                        MEMBERNUMBER := LoanApp."Client Code";
                        POSITIONHELD := 'Employee';
                        AMOUNT := LoanApp."Requested Amount";
                        AMOUNTGRANTED := LoanApp."Approved Amount";
                        AMOUNTOFBOSADEPOSITS := (LoanApp."Current Shares");
                        DATEAPPROVED := LoanApp."Issued Date";
                        REPAYMENTCOMMENCEMENT := LoanApp."Repayment Start Date";
                        REPAYMENTPERIOD := LoanApp."Instalment Period";
                        LOANTYPENAME := LoanApp."Loan Product Type Name";
                        // LoanNo:="Loans Register"."Loan  No.";
                        if LoanApp."Issued Date" < MStartDate then
                            EmplNme1 := LoanApp."Client Name";
                        LoanNo1 := LoanApp."Loan  No.";
                        MEMBERNUMBER := LoanApp."Client Code";
                        POSITIONHELD := 'Employee';
                        AMOUNT := LoanApp."Requested Amount";
                        AMOUNTGRANTED := LoanApp."Approved Amount";
                        AMOUNTOFBOSADEPOSITS := (LoanApp."Current Shares");
                        DATEAPPROVED := LoanApp."Issued Date";
                        REPAYMENTCOMMENCEMENT := LoanApp."Repayment Start Date";
                        REPAYMENTPERIOD := LoanApp."Instalment Period";
                        LOANTYPENAME := LoanApp."Loan Product Type Name";
                        //PERFORMANCE:=LoanApp."Loans Category-SASRA";
                        OUTSTANDINGAMOUNT := LoanApp."Outstanding Balance";
                    end;
                end else
                    CurrReport.Skip;
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
                field(AsAt; AsAt)
                {
                    ApplicationArea = Basic;
                    Caption = 'AsAt....';
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
        StartDate := CalcDate('-CY', AsAt);
        MStartDate := CalcDate('-CM', AsAt);
        MEndDate := CalcDate('CM', AsAt);
        NEWLoanFilter := Format(MStartDate) + '..' + Format(MEndDate);
        //MESSAGE('%1',NEWLoanFilter);
        OldLoanFilter := '..' + Format(MStartDate);
        ;

    end;

    var
        StartDate: Date;
        MStartDate: Date;
        MEndDate: Date;
        NEWLoanFilter: Text;
        OldLoanFilter: Text;
        AsAt: Date;
        LoanApp: Record "Loans Register";
        EmplNme: Text;
        EmplNme1: Text[50];
        LoansRegister: Record "Loans Register";
        qwe: Text[50];
        EmplNmeboard: Text;
        EmplNme1board: Text;
        LoanNo: Code[20];
        LoanNo1: Code[20];
        LoanNo2: Code[20];
        LoanNo3: Code[20];
        T: Boolean;
        F: Boolean;
        MEMBERNUMBER: Code[30];
        POSITIONHELD: Text;
        LOANTYPENAME: Text;
        AMOUNT: Decimal;
        AMOUNTGRANTED: Decimal;
        DATEAPPROVED: Date;
        AMOUNTOFBOSADEPOSITS: Decimal;
        NATUREOFSECURITY: Text;
        REPAYMENTCOMMENCEMENT: Date;
        REPAYMENTPERIOD: DateFormula;
        OUTSTANDINGAMOUNT: Decimal;
        PERFORMANCE: Text;
        SN: Integer;
        MembersRegister: Record Customer;

    var
}

