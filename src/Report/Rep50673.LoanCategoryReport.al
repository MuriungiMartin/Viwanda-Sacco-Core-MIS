#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Report 50673 "LoanCategoryReport"
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
                lineBr[1] := 10;
                ReportRunable := false;
                performing := false;
                datetxt := Date2dmy(Today, 2);
                if (datetxt = 2) and (((Date2dmy(Today, 1)) = 28) or ((Date2dmy(Today, 1)) = 29)) then begin
                    ReportRunable := true;
                end;
                if (((Date2dmy(Today, 1)) = 22)) or (((Date2dmy(Today, 1)) = 15)) or (((Date2dmy(Today, 1)) = 30)) then begin
                    ReportRunable := true;
                    performing := true;


                end;

                if performing = true then begin
                    paydate := CalcDate('1D', Today);

                    if ("Loans Register"."Loans Category" = "Loans Register"."loans category"::Perfoming) then begin
                        // REPEAT
                        schedule.Reset;
                        schedule.SetRange(schedule."Loan No.", "Loans Register"."Loan  No.");
                        schedule.SetRange(schedule."Repayment Date", paydate);
                        if schedule.Find('-') then begin

                            //performing:=paydate=schedule."Repayment Date";

                            SMSMessage.Reset;
                            if SMSMessage.Find('+') then begin
                                iEntryNo := SMSMessage."Entry No";
                                iEntryNo := iEntryNo + 1;
                            end
                            else begin
                                iEntryNo := 1;
                            end;

                            SMSMessage.Reset;
                            SMSMessage.Init;
                            SMSMessage."Entry No" := iEntryNo;
                            SMSMessage."Account No" := "loans reg"."Client Code";
                            SMSMessage."Date Entered" := Today;
                            SMSMessage."Time Entered" := Time;
                            SMSMessage.Source := 'LOAN PERF SMS';
                            SMSMessage."Entered By" := UserId;
                            SMSMessage."Sent To Server" := SMSMessage."sent to server"::No;
                            SMSMessage."SMS Message" := 'Dear ' + "Loans Register"."Client Name" + ' your loan installment is due tomorrow. ' + "Loans Register"."Loan  No." + ' ' +
                             lineBr + ' Kindly ingnore if full installment is paid.';
                            cust.Reset;
                            if cust.Get("Loans Register"."Client Code") then
                                if cust."Phone No." <> '' then
                                    SMSMessage."Telephone No" := cust."Phone No."
                                else
                                    SMSMessage."Telephone No" := cust."Mobile Phone No";
                            SMSMessage.Insert;
                        end;
                        //UNTIL "Loans Register".NEXT=0;
                    end;
                end;
                if ReportRunable = true then begin
                    if ("Loans Register"."Loans Category" = "Loans Register"."loans category"::Substandard)
                      or ("Loans Register"."Loans Category" = "Loans Register"."loans category"::Doubtful)
                      or ("Loans Register"."Loans Category" = "Loans Register"."loans category"::Loss) then begin
                        //REPEAT
                        SMSMessage.Reset;
                        if SMSMessage.Find('+') then begin
                            iEntryNo := SMSMessage."Entry No";
                            iEntryNo := iEntryNo + 1;
                        end
                        else begin
                            iEntryNo := 1;
                        end;

                        SMSMessage.Reset;
                        SMSMessage.Init;
                        SMSMessage."Entry No" := iEntryNo;
                        SMSMessage."Account No" := "loans reg"."Client Code";
                        SMSMessage."Date Entered" := Today;
                        SMSMessage."Time Entered" := Time;
                        SMSMessage.Source := 'LOAN CATEGORY SMS';
                        SMSMessage."Entered By" := UserId;
                        SMSMessage."Sent To Server" := SMSMessage."sent to server"::No;
                        SMSMessage."SMS Message" := 'Dear ' + "Loans Register"."Client Name" + ' we are in the process of listing you with the CRB and notifying your guarantors.' +
                         lineBr + ' We shall enforce payment through the auctioneers immediately.';
                        cust.Reset;
                        if cust.Get("Loans Register"."Client Code") then
                            if cust."Phone No." <> '' then
                                SMSMessage."Telephone No" := cust."Phone No."
                            else
                                SMSMessage."Telephone No" := cust."Mobile Phone No";
                        if SMSMessage."Telephone No" <> '' then
                            SMSMessage.Insert;

                        //UNTIL NEXT=0;
                        // MESSAGE('one done');
                    end;
                    //MESSAGE('one 1 done');
                end;

                if ReportRunable = true then begin
                    if ("Loans Register"."Loans Category" = "Loans Register"."loans category"::Watch) then begin
                        //REPEAT
                        SMSMessage.Reset;
                        if SMSMessage.Find('+') then begin
                            iEntryNo := SMSMessage."Entry No";
                            iEntryNo := iEntryNo + 1;
                        end
                        else begin
                            iEntryNo := 1;
                        end;

                        SMSMessage.Reset;
                        SMSMessage.Init;
                        SMSMessage."Entry No" := iEntryNo;
                        SMSMessage."Account No" := "loans reg"."Client Code";
                        SMSMessage."Date Entered" := Today;
                        SMSMessage."Time Entered" := Time;
                        SMSMessage.Source := 'LOAN WATCH SMS';
                        SMSMessage."Entered By" := UserId;
                        SMSMessage."Sent To Server" := SMSMessage."sent to server"::No;
                        SMSMessage."SMS Message" := 'Dear ' + "Loans Register"."Client Name" + ', Kindly clear your loan arrears within 7 days to avoid penalties';
                        cust.Reset;
                        if cust.Get("Loans Register"."Client Code") then
                            if cust."Phone No." <> '' then
                                SMSMessage."Telephone No" := cust."Phone No."
                            else
                                SMSMessage."Telephone No" := cust."Mobile Phone No";
                        if SMSMessage."Telephone No" <> '' then
                            SMSMessage.Insert;

                        //UNTIL NEXT=0;
                        //MESSAGE('one done');
                    end;
                    //MESSAGE('one 1 done');
                end;
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
        cust: Record Customer;
        Category: Text;
        "loans reg": Record "Loans Register";
        SMSMessage: Record "SMS Messages";
        iEntryNo: Integer;
        lineBr: Text;
        date: Date;
        datetxt: Integer;
        ReportRunable: Boolean;
        schedule: Record "Loan Repayment Schedule";
        paydate: Date;
        performing: Boolean;
}

