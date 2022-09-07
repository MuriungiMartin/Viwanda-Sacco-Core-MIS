#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Report 50937 "Post Repayment From Settlement"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("Loans Register"; "Loans Register")
        {
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnAfterGetRecord()
            begin

                ObjRepamentSchedule.Reset;
                ObjRepamentSchedule.SetRange(ObjRepamentSchedule."Loan No.", "Loan  No.");
                //ObjRepamentSchedule.SETFILTER(ObjRepamentSchedule."Repayment Date",'=%1',TODAY);
                ObjRepamentSchedule.SetRange(ObjRepamentSchedule."Repayment Date", WorkDate);
                if ObjRepamentSchedule.FindSet then begin
                    ObjAccounts.Reset;
                    ObjAccounts.SetRange(ObjAccounts."BOSA Account No", "Client Code");
                    ObjAccounts.SetRange(ObjAccounts."Account Type", '507');
                    if ObjAccounts.FindSet then begin
                        ObjAccounts.CalcFields(ObjAccounts.Balance, ObjAccounts."Uncleared Cheques");
                        AvailableBal := (ObjAccounts.Balance - ObjAccounts."Uncleared Cheques");

                        ObjAccTypes.Reset;
                        ObjAccTypes.SetRange(ObjAccTypes.Code, ObjAccounts."Account Type");
                        if ObjAccTypes.Find('-') then
                            AvailableBal := AvailableBal - ObjAccTypes."Minimum Balance";


                        ObjGensetup.Get();
                        BATCH_TEMPLATE := 'GENERAL';
                        BATCH_NAME := 'DEFAULT';
                        DOCUMENT_NO := 'AutoR' + Format(Today);
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                        GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                        GenJournalLine.DeleteAll;


                        //Loan Settlement Account has more or equal to the monthly repayment==================================
                        CalcFields("Outstanding Insurance", "Outstanding Interest", "Outstanding Balance", "Outstanding Penalty");
                        VarPrincipalRepayment := ObjRepamentSchedule."Principal Repayment";//Repayment-("Outstanding Balance"*(Interest/1200));
                        VarTotalRepaymentDue := VarPrincipalRepayment + "Outstanding Insurance" + "Outstanding Interest" + "Outstanding Penalty";

                        if AvailableBal >= VarTotalRepaymentDue then begin

                            //------------------------------------1. Repay Insurance---------------------------------------------------------------------------------------------

                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Insurance Paid",
                            GenJournalLine."account type"::None, "Client Code", Today, "Outstanding Insurance" * -1, 'BOSA', "Loan  No.",
                            'Insurance Paid from Settlement', "Loan  No.", GenJournalLine."application source"::CBS);

                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                            GenJournalLine."account type"::Vendor, ObjAccounts."No.", Today, "Outstanding Insurance", 'BOSA', "Loan  No.",
                            'Insurance Paid from Settlement', "Loan  No.", GenJournalLine."application source"::CBS);
                            //--------------------------------(Repay Insurance)---------------------------------------------

                            //------------------------------------2. Interest Paid---------------------------------------------------------------------------------------------
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Interest Paid",
                            GenJournalLine."account type"::None, "Client Code", Today, "Outstanding Interest" * -1, 'BOSA', "Loan  No.",
                            'Interest Paid from Settlement', "Loan  No.", GenJournalLine."application source"::CBS);

                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                            GenJournalLine."account type"::Vendor, ObjAccounts."No.", Today, "Outstanding Interest", 'BOSA', "Loan  No.",
                            'Interest Paid from Settlement', "Loan  No.", GenJournalLine."application source"::CBS);
                            //--------------------------------(Interest Paid)---------------------------------------------

                            //------------------------------------3. Principle Repayment---------------------------------------------------------------------------------------------
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Interest Paid",
                            GenJournalLine."account type"::None, "Client Code", Today, VarPrincipalRepayment * -1, 'BOSA', "Loan  No.",
                            'Principle Repayment from Settlement', "Loan  No.", GenJournalLine."application source"::CBS);

                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                            GenJournalLine."account type"::Vendor, ObjAccounts."No.", Today, VarPrincipalRepayment, 'BOSA', "Loan  No.",
                            'Principle Repayment from Settlement', "Loan  No.", GenJournalLine."application source"::CBS);
                            //--------------------------------(Principle Repayment)---------------------------------------------
                        end;
                        //End Loan Settlement Account has more or equal to the monthly repayment===============================
                    end;



                    //Loan Settlement Account has Less than Monthly Repayment
                    if AvailableBal < VarTotalRepaymentDue then begin

                        //------------------------------------1. Repay Insurance---------------------------------------------------------------------------------------------

                        if "Outstanding Insurance" < AvailableBal then begin
                            VarInsuranceAmountDed := AvailableBal
                        end else
                            VarInsuranceAmountDed := "Outstanding Insurance";

                        if AvailableBal > 0 then begin

                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Insurance Paid",
                            GenJournalLine."account type"::None, "Client Code", Today, VarInsuranceAmountDed * -1, 'BOSA', "Loan  No.",
                            'Insurance Paid from Settlement', "Loan  No.", GenJournalLine."application source"::CBS);

                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                            GenJournalLine."account type"::Vendor, ObjAccounts."No.", Today, VarInsuranceAmountDed, 'BOSA', "Loan  No.",
                            'Insurance Paid from Settlement', "Loan  No.", GenJournalLine."application source"::CBS);

                            AvailableBal := AvailableBal - VarInsuranceAmountDed;
                        end;
                        //--------------------------------(Repay Insurance)---------------------------------------------

                        //------------------------------------2. Interest Paid---------------------------------------------------------------------------------------------
                        if "Outstanding Interest" > AvailableBal then begin
                            VarInterestAmountDed := AvailableBal
                        end else
                            VarInterestAmountDed := "Outstanding Interest";

                        if AvailableBal > 0 then begin
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Interest Paid",
                            GenJournalLine."account type"::None, "Client Code", Today, VarInterestAmountDed * -1, 'BOSA', "Loan  No.",
                            'Interest Paid from Settlement', "Loan  No.", GenJournalLine."application source"::CBS);

                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                            GenJournalLine."account type"::Vendor, ObjAccounts."No.", Today, VarInterestAmountDed, 'BOSA', "Loan  No.",
                            'Interest Paid from Settlement', "Loan  No.", GenJournalLine."application source"::CBS);
                            AvailableBal := AvailableBal - VarInsuranceAmountDed;
                        end;
                        //--------------------------------(Interest Paid)---------------------------------------------

                        //------------------------------------3. Principle Repayment---------------------------------------------------------------------------------------------
                        if VarPrincipalRepayment > AvailableBal then begin
                            VarPrincipleAmountDed := AvailableBal
                        end else
                            VarPrincipleAmountDed := VarPrincipalRepayment;

                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Interest Paid",
                        GenJournalLine."account type"::None, "Client Code", Today, VarPrincipalRepayment * -1, 'BOSA', "Loan  No.",
                        'Principle Repayment from Settlement', "Loan  No.", GenJournalLine."application source"::CBS);

                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                        GenJournalLine."account type"::Vendor, ObjAccounts."No.", Today, VarPrincipalRepayment, 'BOSA', "Loan  No.",
                        'Principle Repayment from Settlement', "Loan  No.", GenJournalLine."application source"::CBS);
                        AvailableBal := AvailableBal - VarPrincipleAmountDed;
                        //--------------------------------(Principle Repayment)---------------------------------------------

                    end;
                end;

                /*
                //CU posting
                GenJournalLine.RESET;
                GenJournalLine.SETRANGE("Journal Template Name",'GENERAL');
                GenJournalLine.SETRANGE("Journal Batch Name",'DEFAULT');
                IF GenJournalLine.FIND('-') THEN
                CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Sacco",GenJournalLine);
                */
                FnRunPostExcessFundSingleLoan("Loan  No.", "Client Code");//============================Post Excess to a Single Loan

            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        ObjGensetup: Record "Sacco General Set-Up";
        GenJournalLine: Record "Gen. Journal Line";
        BATCH_TEMPLATE: Code[30];
        BATCH_NAME: Code[30];
        DOCUMENT_NO: Code[30];
        LineNo: Integer;
        SFactory: Codeunit "SURESTEP Factory";
        ObjRepamentSchedule: Record "Loan Repayment Schedule";
        ObjAccounts: Record Vendor;
        ObjAccTypes: Record "Account Types-Saving Products";
        AvailableBal: Decimal;
        VarPrincipalRepayment: Decimal;
        VarTotalRepaymentDue: Decimal;
        VarInsuranceAmountDed: Decimal;
        VarInterestAmountDed: Decimal;
        VarPrincipleAmountDed: Decimal;
        ObjLoans: Record "Loans Register";
        ObjExcessRepaymentProducts: Record "Excess Repayment Rules Product";

    local procedure FnRunPostExcessFundSingleLoan(VarLoanNo: Code[30]; VarMemberNo: Code[30])
    var
        VarLoansCount: Integer;
    begin
        ObjLoans.CalcFields(ObjLoans."Outstanding Balance");

        ObjLoans.Reset;
        ObjLoans.SetRange(ObjLoans."Loan  No.", VarLoanNo);
        ObjLoans.SetFilter(ObjLoans."Outstanding Balance", '>%1', 0);
        if ObjLoans.FindSet then begin
            ObjExcessRepaymentProducts.Reset;
            ObjExcessRepaymentProducts.SetRange(ObjExcessRepaymentProducts."Add Type", ObjExcessRepaymentProducts."add type"::Exempt);
            if ObjExcessRepaymentProducts.FindSet then begin
                repeat
                    VarLoansCount := ObjLoans.Count;
                until ObjExcessRepaymentProducts.Next = 0;
            end;

        end;


        if VarLoansCount = 1 then begin
            ObjRepamentSchedule.Reset;
            ObjRepamentSchedule.SetRange(ObjRepamentSchedule."Loan No.", VarLoanNo);
            //ObjRepamentSchedule.SETFILTER(ObjRepamentSchedule."Repayment Date",'=%1',TODAY);
            ObjRepamentSchedule.SetRange(ObjRepamentSchedule."Repayment Date", WorkDate);
            if ObjRepamentSchedule.FindSet then begin
                ObjAccounts.Reset;
                ObjAccounts.SetRange(ObjAccounts."BOSA Account No", VarMemberNo);
                ObjAccounts.SetRange(ObjAccounts."Account Type", '507');
                if ObjAccounts.FindSet then begin
                    ObjAccounts.CalcFields(ObjAccounts.Balance, ObjAccounts."Uncleared Cheques");
                    AvailableBal := (ObjAccounts.Balance - ObjAccounts."Uncleared Cheques");

                    ObjAccTypes.Reset;
                    ObjAccTypes.SetRange(ObjAccTypes.Code, ObjAccounts."Account Type");
                    if ObjAccTypes.Find('-') then
                        AvailableBal := AvailableBal - ObjAccTypes."Minimum Balance";


                    ObjGensetup.Get();
                    BATCH_TEMPLATE := 'GENERAL';
                    BATCH_NAME := 'DEFAULT';
                    DOCUMENT_NO := 'AutoR' + Format(Today);
                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                    GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                    GenJournalLine.DeleteAll;



                    //------------------------------------1. Repay Principle---------------------------------------------------------------------------------------------
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLineBalanced(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Insurance Paid",
                    GenJournalLine."account type"::None, VarMemberNo, Today, 'Excess_Principle Paid from Settlement', GenJournalLine."bal. account type"::Vendor, ObjAccounts."No.",
                    AvailableBal * -1, 'BOSA', VarLoanNo);

                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Interest Paid",
                    GenJournalLine."account type"::None, VarMemberNo, Today, AvailableBal * -1, 'BOSA', VarLoanNo,
                    'Excess_Principle Paid from Settlement', VarLoanNo, GenJournalLine."application source"::CBS);

                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::Vendor, ObjAccounts."No.", Today, AvailableBal, 'BOSA', VarLoanNo,
                    'Excess_Principle Paid from Settlement', VarLoanNo, GenJournalLine."application source"::CBS);
                    //--------------------------------(Repay Principle)---------------------------------------------
                end;
            end;
        end;
        /*
        //CU posting
        GenJournalLine.RESET;
        GenJournalLine.SETRANGE("Journal Template Name",'GENERAL');
        GenJournalLine.SETRANGE("Journal Batch Name",'DEFAULT');
        IF GenJournalLine.FIND('-') THEN
        CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Sacco",GenJournalLine);
        */

    end;

    local procedure FnRunPostExcessFundtoBiggestLoan(VarLoanNo: Code[30]; VarMemberNo: Code[30])
    var
        VarLoansCount: Integer;
        VarLoantoOverpay: Code[30];
        VarBiggestAmount: Decimal;
        VarSmallestAmount: Decimal;
    begin
        ObjRepamentSchedule.Reset;
        ObjRepamentSchedule.SetRange(ObjRepamentSchedule."Loan No.", VarLoanNo);
        ObjRepamentSchedule.SetRange(ObjRepamentSchedule."Repayment Date", WorkDate);
        if ObjRepamentSchedule.FindSet then begin
            ObjAccounts.Reset;
            ObjAccounts.SetRange(ObjAccounts."BOSA Account No", VarMemberNo);
            ObjAccounts.SetRange(ObjAccounts."Account Type", '507');
            if ObjAccounts.FindSet then begin
                ObjAccounts.CalcFields(ObjAccounts.Balance, ObjAccounts."Uncleared Cheques");
                AvailableBal := (ObjAccounts.Balance - ObjAccounts."Uncleared Cheques");

                ObjAccTypes.Reset;
                ObjAccTypes.SetRange(ObjAccTypes.Code, ObjAccounts."Account Type");
                if ObjAccTypes.Find('-') then
                    AvailableBal := AvailableBal - ObjAccTypes."Minimum Balance";
            end;

            //=========================================================================Excess to Oldest Loan
            if ObjAccounts."Excess Repayment Rule" <> ObjAccounts."excess repayment rule"::" " then begin
                if ObjAccounts."Excess Repayment Rule" = ObjAccounts."excess repayment rule"::"Smallest Loan" then begin
                    ObjLoans.CalcFields(ObjLoans."Outstanding Balance");

                    ObjLoans.Reset;
                    ObjLoans.SetCurrentkey(ObjLoans."Issued Date");
                    ObjLoans.SetRange(ObjLoans."Client Code", VarMemberNo);
                    ObjLoans.SetFilter(ObjLoans."Outstanding Balance", '>%1', 0);
                    if ObjLoans.FindFirst then begin
                        VarLoantoOverpay := ObjLoans."Loan  No.";
                    end;
                end;
            end;

            //=========================================================================Excess to Newest Loan
            if ObjAccounts."Excess Repayment Rule" <> ObjAccounts."excess repayment rule"::" " then begin
                if ObjAccounts."Excess Repayment Rule" = ObjAccounts."excess repayment rule"::"Oldest Loan" then begin
                    ObjLoans.CalcFields(ObjLoans."Outstanding Balance");

                    ObjLoans.Reset;
                    ObjLoans.SetCurrentkey(ObjLoans."Issued Date");
                    ObjLoans.SetRange(ObjLoans."Client Code", VarMemberNo);
                    ObjLoans.SetFilter(ObjLoans."Outstanding Balance", '>%1', 0);
                    if ObjLoans.FindLast then begin
                        VarLoantoOverpay := ObjLoans."Loan  No.";
                    end;
                end;
            end;

            //=========================================================================Excess to  Biggest Loan
            if ObjAccounts."Excess Repayment Rule" <> ObjAccounts."excess repayment rule"::" " then begin
                if ObjAccounts."Excess Repayment Rule" = ObjAccounts."excess repayment rule"::"Exempt From Excess Rule" then begin
                    ObjLoans.CalcFields(ObjLoans."Outstanding Balance");

                    ObjLoans.Reset;
                    ObjLoans.SetCurrentkey(ObjLoans."Issued Date");
                    ObjLoans.SetRange(ObjLoans."Client Code", VarMemberNo);
                    ObjLoans.SetFilter(ObjLoans."Outstanding Balance", '>%1', 0);
                    if ObjLoans.FindSet then begin
                        VarBiggestAmount := ObjLoans.GetRangemax("Outstanding Balance");
                        if ObjLoans."Outstanding Balance" = VarBiggestAmount then begin
                            VarLoantoOverpay := ObjLoans."Loan  No.";
                        end;
                    end;
                end;
            end;

            //=========================================================================Excess to  Smallest Loan
            if ObjAccounts."Excess Repayment Rule" <> ObjAccounts."excess repayment rule"::" " then begin
                if ObjAccounts."Excess Repayment Rule" = ObjAccounts."excess repayment rule"::"Biggest Loan" then begin
                    ObjLoans.CalcFields(ObjLoans."Outstanding Balance");

                    ObjLoans.Reset;
                    ObjLoans.SetCurrentkey(ObjLoans."Issued Date");
                    ObjLoans.SetRange(ObjLoans."Client Code", VarMemberNo);
                    ObjLoans.SetFilter(ObjLoans."Outstanding Balance", '>%1', 0);
                    if ObjLoans.FindSet then begin
                        VarSmallestAmount := ObjLoans.GetRangeMin("Outstanding Balance");
                        if ObjLoans."Outstanding Balance" = VarSmallestAmount then begin
                            VarLoantoOverpay := ObjLoans."Loan  No.";
                        end;
                    end;
                end;
            end;
        end;


        ObjGensetup.Get();
        BATCH_TEMPLATE := 'GENERAL';
        BATCH_NAME := 'DEFAULT';
        DOCUMENT_NO := 'AutoR' + Format(Today);
        /*
        GenJournalLine.RESET;
        GenJournalLine.SETRANGE("Journal Template Name",BATCH_TEMPLATE);
        GenJournalLine.SETRANGE("Journal Batch Name",BATCH_NAME);
        GenJournalLine.DELETEALL;
         */

        //------------------------------------1. Repay Principle---------------------------------------------------------------------------------------------
        LineNo := LineNo + 10000;
        SFactory.FnCreateGnlJournalLineBalanced(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Repayment",
        GenJournalLine."account type"::None, VarMemberNo, Today, 'Excess_Principle Paid from Settlement', GenJournalLine."bal. account type"::Vendor, ObjAccounts."No.",
        AvailableBal * -1, 'BOSA', VarLoantoOverpay);

    end;
}

