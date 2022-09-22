#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50428 "Member Statistics FactBox"
{
    Caption = 'Member FactBox';
    Editable = false;
    PageType = CardPart;
    SaveValues = true;
    SourceTable = Customer;

    layout
    {
        area(content)
        {
            // usercontrol(Mpesa; MpesaAddin)
            // {

            //     ApplicationArea = all;

            //     trigger ControlReady()
            //     var
            //         myInt: Integer;
            //     begin
            //         //Message('ready to execute javascript');
            //         //myInt := 0704536696;
            //         //CurrPage.Mpesa.pay();

            //     end;

            // }
            field("No."; "No.")
            {
                ApplicationArea = Basic;
                Caption = 'Member No.';
            }
            field(Name; Name)
            {
                ApplicationArea = Basic;
            }
            field("ID No."; "ID No.")
            {
                ApplicationArea = Basic;
            }
            field("Mobile Phone No"; "Mobile Phone No")
            {
                ApplicationArea = Basic;
            }
            field("No of BD Trainings Attended"; "No of BD Trainings Attended")
            {
                ApplicationArea = Basic;
                Editable = false;
            }
            group("Member Details FactBox")
            {
                Caption = 'Member Details FactBox';
                field("Registration Fee Paid"; "Registration Fee Paid")
                {

                }
                field("Current Shares"; "Current Shares")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member Deposits';
                    //  Image = Star;
                    Importance = Promoted;
                    Style = StrongAccent;
                    StyleExpr = true;
                }
                field("Shares Retained"; "Shares Retained")
                {
                    ApplicationArea = Basic;
                    Caption = 'Share Capital';
                }
                field("Benevolent Fund"; "Benevolent Fund")
                {
                    ApplicationArea = Basic;
                }
                field("Outstanding Balance"; "Outstanding Balance")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loan Outstanding Balance';
                    StyleExpr = FieldStyleL;
                }
                field("Outstanding Interest"; "Outstanding Interest")
                {
                    ApplicationArea = Basic;
                }
                field("Out. Loan Insurance fee"; "Out. Loan Insurance fee")
                {

                }
                field("Development Loan"; "Development Loan")
                {
                    ApplicationArea = Basic;
                }
                field("Emergency Loan"; "Emergency Loan")
                {
                    ApplicationArea = Basic;
                }

                field("Out. Loan Application fee"; "Out. Loan Application fee")
                {
                    Caption = 'Out. Loan Application fee';
                }
                field(VarMemberLiability; VarMemberLiability)
                {
                    ApplicationArea = Basic;
                    Caption = 'Member Liability';
                    Importance = Promoted;
                    Style = Attention;
                    StyleExpr = true;
                }
            }
            group("File Movement FactBox")
            {
                Caption = 'File Movement FactBox';
                Visible = false;
                field("Currect File Location"; "Currect File Location")
                {
                    ApplicationArea = Basic;
                }
                field("Loc Description"; "Loc Description")
                {
                    ApplicationArea = Basic;
                }
                field(User; User)
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
        /*ObjLoans.RESET;
        ObjLoans.SETRANGE("Client Code","No.");
        IF ObjLoans.FIND('-') THEN
        OutstandingInterest:=SFactory.FnGetInterestDueTodate(ObjLoans)-ObjLoans."Interest Paid";*/

        //VarMemberLiability:=SFactory.FnGetMemberLiability("No.");

        VarTotalInterestCharged := 0;
        VarTotalInterestPaid := 0;
        VarOutstandingInterest := 0;

        ObjLoans.Reset;
        ObjLoans.SetRange(ObjLoans."Client Code", "No.");
        if ObjLoans.FindSet then begin
            repeat
                VarLoanOutstandingInt := SFactory.FnRunLoanAmountDue(ObjLoans."Loan  No.");
                VarOutstandingInterest := VarOutstandingInterest + ObjLoans."Current Interest Due";
            until ObjLoans.Next = 0;
        end;


    end;

    trigger OnAfterGetRecord()
    begin
        if ("Assigned System ID" <> '') then begin //AND ("Assigned System ID"<>USERID)
            if UserSetup.Get(UserId) then begin
                if UserSetup."View Special Accounts" = false then Error('You do not have permission to view this account Details, Contact your system administrator! ')
            end;

        end;


        ChangeCustomer;
        GetLatestPayment;
        CalculateAging;


        SetFieldStyle;

        //VarMemberLiability:=SFactory.FnGetMemberLiability("No.");
    end;

    trigger OnOpenPage()
    begin
        // Default the Aging Period to 30D
        Evaluate(AgingPeriod, '<30D>');
        // Initialize Record Variables
        LatestCustLedgerEntry.Reset;
        LatestCustLedgerEntry.SetCurrentkey("Document Type", "Customer No.", "Posting Date");
        LatestCustLedgerEntry.SetRange("Document Type", LatestCustLedgerEntry."document type"::Payment);
        for I := 1 to ArrayLen(CustLedgerEntry) do begin
            CustLedgerEntry[I].Reset;
            CustLedgerEntry[I].SetCurrentkey("Customer No.", Open, Positive, "Due Date");
            CustLedgerEntry[I].SetRange(Open, true);
        end;
    end;

    var
        LatestCustLedgerEntry: Record "Cust. Ledger Entry";
        CustLedgerEntry: array[4] of Record "Cust. Ledger Entry";
        AgingTitle: array[4] of Text[30];
        AgingPeriod: DateFormula;
        I: Integer;
        PeriodStart: Date;
        PeriodEnd: Date;
        Text002: label 'Not Yet Due';
        Text003: label 'Over %1 Days';
        Text004: label '%1-%2 Days';
        LoanGuarantors: Record "Loans Guarantee Details";
        ComittedShares: Decimal;
        Loans: Record "Loans Register";
        FreeShares: Decimal;
        UserSetup: Record "User Setup";
        FieldStyle: Text;
        FieldStyleL: Text;
        FieldStyleI: Text;
        LoanNo: Code[20];
        LoanGuar: Record "Loans Guarantee Details";
        TGrAmount: Decimal;
        GrAmount: Decimal;
        FGrAmount: Decimal;
        TAmountGuaranteed: Decimal;
        AllGuaratorsTotal: Decimal;
        AmounttoRelease: Decimal;
        TotalOutstaningBal: Decimal;
        TotalApprovedAmount: Decimal;
        TotalAmountPaid: Decimal;
        OutstandingInterest: Decimal;
        InterestDue: Decimal;
        SFactory: Codeunit "SURESTEP Factory";
        ObjLoans: Record "Loans Register";
        VarMemberLiability: Decimal;
        VarOutstandingInterest: Decimal;
        VarTotalInterestCharged: Decimal;
        VarTotalInterestPaid: Decimal;
        VarLoanOutstandingInt: Decimal;


    procedure CalculateAgingForPeriod(PeriodBeginDate: Date; PeriodEndDate: Date; Index: Integer)
    var
        CustLedgerEntry2: Record "Cust. Ledger Entry";
        NumDaysToBegin: Integer;
        NumDaysToEnd: Integer;
    begin
        // Calculate the Aged Balance for a particular Date Range
        if PeriodEndDate = 0D then
            CustLedgerEntry[Index].SetFilter("Due Date", '%1..', PeriodBeginDate)
        else
            CustLedgerEntry[Index].SetRange("Due Date", PeriodBeginDate, PeriodEndDate);

        CustLedgerEntry2.Copy(CustLedgerEntry[Index]);
        CustLedgerEntry[Index]."Remaining Amt. (LCY)" := 0;
        if CustLedgerEntry2.Find('-') then
            repeat
                CustLedgerEntry2.CalcFields("Remaining Amt. (LCY)");
                CustLedgerEntry[Index]."Remaining Amt. (LCY)" :=
                  CustLedgerEntry[Index]."Remaining Amt. (LCY)" + CustLedgerEntry2."Remaining Amt. (LCY)";
            until CustLedgerEntry2.Next = 0;

        if PeriodBeginDate <> 0D then
            NumDaysToBegin := WorkDate - PeriodBeginDate;
        if PeriodEndDate <> 0D then
            NumDaysToEnd := WorkDate - PeriodEndDate;
        if PeriodEndDate = 0D then
            AgingTitle[Index] := Text002
        else
            if PeriodBeginDate = 0D then
                AgingTitle[Index] := StrSubstNo(Text003, NumDaysToEnd - 1)
            else
                AgingTitle[Index] := StrSubstNo(Text004, NumDaysToEnd, NumDaysToBegin);
    end;


    procedure CalculateAging()
    begin
        // Calculate the Entire Aging (four Periods)
        for I := 1 to ArrayLen(CustLedgerEntry) do begin
            case I of
                1:
                    begin
                        PeriodEnd := 0D;
                        PeriodStart := WorkDate;
                    end;
                ArrayLen(CustLedgerEntry):
                    begin
                        PeriodEnd := PeriodStart - 1;
                        PeriodStart := 0D;
                    end;
                else begin
                    PeriodEnd := PeriodStart - 1;
                    PeriodStart := CalcDate('-' + Format(AgingPeriod), PeriodStart);
                end;
            end;
            CalculateAgingForPeriod(PeriodStart, PeriodEnd, I);
        end;
    end;


    procedure GetLatestPayment()
    begin
        // Find the Latest Payment
        if LatestCustLedgerEntry.FindLast then
            LatestCustLedgerEntry.CalcFields("Amount (LCY)")
        else
            LatestCustLedgerEntry.Init;
    end;


    procedure ChangeCustomer()
    begin
        // Change the Customer Filters
        LatestCustLedgerEntry.SetRange("Customer No.", "No.");
        for I := 1 to ArrayLen(CustLedgerEntry) do
            CustLedgerEntry[I].SetRange("Customer No.", "No.");
    end;


    procedure DrillDown(Index: Integer)
    begin
        if Index = 0 then
            Page.RunModal(Page::"Customer Ledger Entries", LatestCustLedgerEntry)
        else
            Page.RunModal(Page::"Customer Ledger Entries", CustLedgerEntry[Index]);
    end;

    local procedure SetFieldStyle()
    begin
        FieldStyle := '';
        CalcFields("Un-allocated Funds");
        if "Un-allocated Funds" <> 0 then
            FieldStyle := 'Attention';
        CalcFields("Outstanding Balance", "Outstanding Interest");
        if ("Outstanding Balance" < 0) then
            FieldStyleL := 'Attention';

        CalcFields("Outstanding Balance", "Outstanding Interest");
        if ("Outstanding Interest" < 0) then
            FieldStyleI := 'Attention';
    end;
}

