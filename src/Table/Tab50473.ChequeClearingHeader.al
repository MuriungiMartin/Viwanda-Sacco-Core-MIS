#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50473 "Cheque Clearing Header"
{

    fields
    {
        field(1; No; Code[20])
        {

            trigger OnValidate()
            begin

                if No <> xRec.No then begin
                    NoSetup.Get();
                    NoSeriesMgt.TestManual(NoSetup."Cheque Clearing Nos");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "No. Series"; Code[20])
        {
        }
        field(3; Posted; Boolean)
        {
            Editable = false;
        }
        field(6; "Cleared  By"; Code[20])
        {
            Editable = false;
        }
        field(7; "Date Entered"; Date)
        {
        }
        field(9; "Entered By"; Text[20])
        {
        }
        field(10; Remarks; Text[150])
        {
        }
        field(19; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(20; "Time Entered"; Time)
        {
        }
        field(21; "Expected Date Of Clearing"; Date)
        {

            trigger OnValidate()
            begin
                ObjChequeClearingLines.Reset;
                ObjChequeClearingLines.SetRange(ObjChequeClearingLines."Header No", No);
                if ObjChequeClearingLines.FindSet then begin
                    ObjChequeClearingLines.DeleteAll;
                end;



                ObjCashierTrans.Reset;
                ObjCashierTrans.SetRange(ObjCashierTrans."Type _Transactions", ObjCashierTrans."type _transactions"::"Cheque Deposit");
                ObjCashierTrans.SetRange(ObjCashierTrans.Posted, true);
                //ObjCashierTrans.SETRANGE(ObjCashierTrans."Expected Maturity Date","Expected Date Of Clearing");
                ObjCashierTrans.SetFilter(ObjCashierTrans."Expected Maturity Date", '<=%1', "Expected Date Of Clearing"); //mutinda **28/06/2019 the client requested all cheques upto maturity date
                ObjCashierTrans.SetRange(ObjCashierTrans."Cheque Processed", false);

                if ObjCashierTrans.FindSet then begin
                    repeat
                        ObjChequeClearingLines.Init;
                        ObjChequeClearingLines."Header No" := No;
                        ObjChequeClearingLines."Transaction No" := ObjCashierTrans.No;
                        ObjChequeClearingLines."Account No" := ObjCashierTrans."Account No";
                        ObjChequeClearingLines."Account Name" := ObjCashierTrans."Account Name";
                        ObjChequeClearingLines.Amount := ObjCashierTrans.Amount;
                        ObjChequeClearingLines."Cheque No" := ObjCashierTrans."Cheque No";
                        ObjChequeClearingLines."Expected Maturity Date" := ObjCashierTrans."Expected Maturity Date";
                        ObjChequeClearingLines."Transaction Type" := ObjCashierTrans."Transaction Type";
                        ObjChequeClearingLines."Cheque Type" := ObjCashierTrans."Cheque Type";
                        ObjChequeClearingLines.Insert;
                    until ObjCashierTrans.Next = 0;
                end;
            end;
        }
        field(24; "Document No"; Code[20])
        {
        }
        field(26; "Scheduled Amount"; Decimal)
        {
            CalcFormula = sum("Cheque Clearing Lines".Amount where("Header No" = field(No)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(27; "Total Count"; Integer)
        {
            CalcFormula = count("Cheque Clearing Lines" where("Header No" = field(No)));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; No)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin

        if No = '' then begin
            NoSetup.Get();
            NoSetup.TestField(NoSetup."Cheque Clearing Nos");
            NoSeriesMgt.InitSeries(NoSetup."Cheque Clearing Nos", xRec."No. Series", 0D, No, "No. Series");
        end;

        "Date Entered" := Today;
        "Time Entered" := Time;
        "Entered By" := UpperCase(UserId);
    end;

    var
        NoSetup: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        cust: Record Customer;
        "GL Account": Record "G/L Account";
        BANKACC: Record "Bank Account";
        ObjCashierTrans: Record Transactions;
        ObjChequeClearingLines: Record "Cheque Clearing Lines";
}

