#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50458 "EFT/RTGS Details"
{

    fields
    {
        field(1; No; Code[20])
        {

            trigger OnValidate()
            begin
                if No <> xRec.No then begin
                    NoSetup.Get();
                    NoSeriesMgt.TestManual(NoSetup."EFT Details Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Account No"; Code[20])
        {
            NotBlank = true;
            TableRelation = Vendor."No.";

            trigger OnValidate()
            begin
                if Accounts.Get("Account No") then begin
                    //Block Payments
                    if (Accounts.Blocked = Accounts.Blocked::Payment) or
                       (Accounts.Blocked = Accounts.Blocked::All) then
                        Error('This account has been blocked from Transacting.');

                    "Account Name" := Accounts.Name;
                    "Destination Account Name" := CopyStr(Accounts.Name, 1, 28);
                    "Account Type" := Accounts."Account Type";
                    "Member No" := Accounts."BOSA Account No";
                    "Staff No" := Accounts."Personal No.";
                    Amount := 0;

                end;

                Validate("Destination Account Type");
            end;
        }
        field(3; "Account Name"; Code[100])
        {
        }
        field(4; "Account Type"; Code[20])
        {
        }
        field(7; Amount; Decimal)
        {

            trigger OnValidate()
            begin
                AvailableBal := 0;

                if Accounts.Get("Account No") then begin
                    Accounts.CalcFields(Accounts.Balance, Accounts."Uncleared Cheques", Accounts."ATM Transactions");
                    if AccountTypes.Get(Accounts."Account Type") then begin
                        AvailableBal := Accounts.Balance - (Accounts."Uncleared Cheques" + Accounts."ATM Transactions" + AccountTypes."Minimum Balance");
                    end;

                    if (Amount + Charges) > AvailableBal then
                        Error('EFT/RTGS Amount+Charges is more than the Members Account Balance,Available Balance is %1 Account No. %2', AvailableBal, "Account No");
                end;
            end;
        }
        field(8; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(11; "Destination Account No"; Code[20])
        {

            trigger OnValidate()
            begin
                if AccountHolders.Get("Destination Account No") then begin
                    "Destination Account Name" := AccountHolders.Name;
                end;
            end;
        }
        field(12; "Destination Account Name"; Text[50])
        {

            trigger OnValidate()
            begin
                if StrLen("Destination Account Name") > 28 then
                    Error('Destintion account name cannot be more than 28 characters.');
            end;
        }
        field(13; "Destination Account Type"; Option)
        {
            OptionMembers = External,Internal;

            trigger OnValidate()
            begin
                /*
                IF Accounts.GET("Account No") THEN BEGIN
                IF AccountTypes.GET(Accounts."Account Type") THEN BEGIN
                IF "Destination Account Type" = "Destination Account Type"::External THEN
                Charges:=AccountTypes."External EFT Charges"
                ELSE
                Charges:=AccountTypes."Internal EFT Charges";
                AccountTypes.TESTFIELD(AccountTypes."EFT Charges Account");
                "EFT Charges Account":=AccountTypes."EFT Charges Account";
                
                
                IF EFTHeader.GET("Header No") THEN BEGIN
                IF EFTHeader.RTGS = TRUE THEN BEGIN
                Charges:=AccountTypes."RTGS Charges";
                AccountTypes.TESTFIELD(AccountTypes."RTGS Charges Account");
                "EFT Charges Account":=AccountTypes."RTGS Charges Account";
                END;
                END;
                
                END;
                END;
                */

            end;
        }
        field(14; Transferred; Boolean)
        {
        }
        field(15; "Date Transferred"; Date)
        {
        }
        field(16; "Time Transferred"; Time)
        {
        }
        field(17; "Transferred By"; Text[60])
        {
        }
        field(18; "Date Entered"; Date)
        {
        }
        field(19; "Time Entered"; Time)
        {
        }
        field(20; "Entered By"; Text[50])
        {
        }
        field(21; "Transaction Description"; Text[150])
        {
        }
        field(22; "Payee Bank Name"; Text[200])
        {
        }
        field(23; "Bank No"; Code[20])
        {
            TableRelation = Banks.Code;

            trigger OnValidate()
            begin
                BanksList.Reset;
                BanksList.SetRange(BanksList.Code, "Bank No");
                if BanksList.Find('-') then begin
                    "Payee Bank Name" := BanksList."Bank Name";
                    "Payee Branch Name" := BanksList.Branch;
                end;

                /*EFTHeader.RESET;
                EFTHeader.SETRANGE(EFTHeader.No,"Header No");
                IF EFTHeader.FIND('-') THEN BEGIN
                IF "Payee Bank Name"<>EFTHeader.Bank THEN
                EFTHeader.RTGS:=TRUE;
                IF AccTypes.GET("Account Type") THEN
                //Charges:=AccTypes."RTGS Charges";
                EFTHeader.MODIFY;
                END;*/



                EFTHeader.Reset;
                EFTHeader.SetRange(EFTHeader.No, "Header No");
                if EFTHeader.Find('-') then begin
                    if "Payee Bank Name" = EFTHeader.Bank then
                        EFTHeader.RTGS := false;
                    EFTHeader.Modify;
                    "Destination Account Type" := "destination account type"::External;
                    Validate("Destination Account Type");
                end;

            end;
        }
        field(24; Charges; Decimal)
        {
        }
        field(25; "Header No"; Code[20])
        {
            TableRelation = "EFT/RTGS Header".No;
        }
        field(26; "Member No"; Code[20])
        {
        }
        field(27; "Amount Text"; Text[20])
        {
        }
        field(28; ExportFormat; Text[78])
        {
        }
        field(29; EAccNo; Text[20])
        {
        }
        field(30; EBankCode; Text[6])
        {
        }
        field(31; EAccName; Text[32])
        {
        }
        field(32; EAmount; Text[10])
        {
        }
        field(33; EReff; Text[5])
        {
        }
        field(34; "Staff No"; Code[20])
        {
        }
        field(35; "Over Drawn"; Boolean)
        {
        }
        field(37; Primary; Decimal)
        {
        }
        field(38; "Standing Order No"; Code[20])
        {
        }
        field(39; "EFT Type"; Option)
        {
            OptionMembers = Normal,"ATM EFT";
        }
        field(40; "EFT Charges Account"; Code[20])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(41; "Standing Order Register No"; Code[20])
        {
        }
        field(42; "Don't Charge"; Boolean)
        {
        }
        field(43; "Phone No."; Text[50])
        {
        }
        field(44; "Not Available"; Boolean)
        {
        }
        field(45; "EFT/RTGS Type"; Code[20])
        {
            TableRelation = "EFT/RTGS Charges Setup".Code;

            trigger OnValidate()
            begin
                if ObjEFRTGSCharges.Get("EFT/RTGS Type") then begin
                    "EFT/RTGS Type Description" := ObjEFRTGSCharges.Description;
                    Charges := ObjEFRTGSCharges."Charge Amount";
                    "Destination Cash Book" := ObjEFRTGSCharges."Bank No";
                    "Destination Cash Book Name" := ObjEFRTGSCharges."Bank Name";
                end;
            end;
        }
        field(46; "EFT/RTGS Type Description"; Text[50])
        {
        }
        field(47; "Destination Cash Book"; Code[20])
        {
            TableRelation = "Bank Account"."No." where("EFT/RTGS Bank" = filter(true));

            trigger OnValidate()
            begin
                if ObjBankAccount.Get("Destination Cash Book") then begin
                    "Destination Cash Book Name" := ObjBankAccount.Name;
                end;
            end;
        }
        field(48; "Destination Cash Book Name"; Text[50])
        {
        }
        field(49; "Cheque No"; Code[30])
        {
            TableRelation = "Cheque Book Register"."Cheque No." where("Bank Account" = field("Destination Cash Book"),
                                                                       Issued = filter(false),
                                                                       Cancelled = filter(false));
        }
        field(50; "Payee Branch Name"; Text[100])
        {
        }
    }

    keys
    {
        key(Key1; "Header No", "Account No", "Destination Account No", No)
        {
            Clustered = true;
            SumIndexFields = Amount;
        }
        key(Key2; "Header No", No)
        {
        }
        key(Key3; "Staff No")
        {
        }
        key(Key4; "Account No", "Not Available", Transferred)
        {
            SumIndexFields = Amount;
        }
        key(Key5; "Date Entered")
        {
            SumIndexFields = Amount;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        if Transferred = true then
            Error('You cannot modify an already posted record.');

        Transactions.Reset;
        Transactions.SetRange(Transactions."Cheque No", No);
        //Transactions.SETRANGE(Transactions."Transaction Type",'EFT');
        //Transactions.SETRANGE(Transactions."Account No","Account No");
        if Transactions.Find('-') then
            Transactions.DeleteAll;

        Transactions.Reset;
        Transactions.SetRange(Transactions."Cheque No", No);
        //Transactions.SETRANGE(Transactions."Transaction Type",'EFTT');
        //Transactions.SETRANGE(Transactions."Account No","Account No");
        if Transactions.Find('-') then
            Transactions.DeleteAll;
    end;

    trigger OnInsert()
    begin
        if No = '' then begin
            NoSetup.Get();
            NoSetup.TestField(NoSetup."EFT Details Nos.");
            NoSeriesMgt.InitSeries(NoSetup."EFT Details Nos.", xRec."No. Series", 0D, No, "No. Series");
        end;

        "Date Entered" := Today;
        "Time Entered" := Time;
        "Entered By" := UserId;
    end;

    trigger OnModify()
    begin
        if Transferred = true then
            Error('You cannot modify an already posted record.');
    end;

    var
        NoSetup: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Accounts: Record Vendor;
        Members: Record Vendor;
        AccountHolders: Record Vendor;
        Banks: Record "Bank Account";
        BanksList: Record Banks;
        StLen: Integer;
        GenAmount: Text[50];
        FundsTransferDetails: Record "EFT/RTGS Details";
        AccountTypes: Record "Account Types-Saving Products";
        MinimumAccBal: Decimal;
        EFTCHG: Decimal;
        GenLedgerSetup: Record "General Ledger Setup";
        ATMBalance: Decimal;
        TotalUnprocessed: Decimal;
        chqtransactions: Record Transactions;
        AccBal: Decimal;
        AvailableBal: Decimal;
        Transactions: Record Transactions;
        EFTDetails: Record "EFT/RTGS Details";
        OtherEFT: Decimal;
        EFTHeader: Record "EFT/RTGS Header";
        AccTypes: Record "Account Types-Saving Products";
        ObjEFRTGSCharges: Record "EFT/RTGS Charges Setup";
        ObjBankAccount: Record "Bank Account";
}

