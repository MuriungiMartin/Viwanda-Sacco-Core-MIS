#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50020 "Internal PV Lines"
{

    fields
    {
        field(1; No; Code[20])
        {
        }
        field(2; Type; Option)
        {
            OptionCaption = 'Debit,Credit';
            OptionMembers = Debit,Credit;

            trigger OnValidate()
            begin
                if (Type = Type::Credit) and ("Debit Amount" <> 0) then
                    Error('The Transaction Type selected is Credit, you cannot have a Debit Amount.');

                if (Type = Type::Debit) and ("Credit Amount" <> 0) then
                    Error('The Transaction Type selected is Debit, you cannot have a Credit Amount.');
            end;
        }
        field(3; "Account Type"; Enum "Gen. Journal Account Type")
        {
            Caption = 'Account Type';
            // OptionCaption = 'G/L Account,Trade Customer,Member Account/Supplier,Bank Account,Fixed Asset,IC Partner,Employee,Loan Account,Investor';
            // OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Employee,Member,Investor;
        }
        field(4; "Account No."; Code[20])
        {
            Caption = 'Account No.';
            TableRelation = if ("Account Type" = const("G/L Account")) "G/L Account" where("Account Type" = const(Posting),
                                                                                          Blocked = const(false))
            else
            if ("Account Type" = const(Customer)) Customer
            else
            if ("Account Type" = const(Vendor)) Vendor
            else
            if ("Account Type" = const("Bank Account")) "Bank Account"
            else
            if ("Account Type" = const("Fixed Asset")) "Fixed Asset"
            else
            if ("Account Type" = const("IC Partner")) "IC Partner"
            else
            if ("Account Type" = const(Employee)) Employee
            else
            if ("Account Type" = const(Member)) Customer;

            trigger OnValidate()
            begin
                case "Account Type" of
                    "account type"::"G/L Account":
                        if ObjGL.Get("Account No.") then
                            "Account Name" := ObjGL.Name;
                    "account type"::Customer:
                        if ObjCust.Get("Account No.") then
                            "Account Name" := ObjCust.Name;
                    "account type"::Vendor:
                        if ObjVend.Get("Account No.") then
                            "Account Name" := ObjVend.Name;
                    "account type"::"Bank Account":
                        if ObjBank.Get("Account No.") then
                            "Account Name" := ObjBank.Name;
                    "account type"::"Fixed Asset":
                        if ObjFA.Get("Account No.") then
                            "Account Name" := ObjFA.Description;
                end;
            end;
        }
        field(5; Description; Text[250])
        {
        }
        field(6; "Credit Amount"; Decimal)
        {

            trigger OnValidate()
            begin
                if "Credit Amount" <> 0 then begin
                    Amount := "Credit Amount" * -1;
                    "Debit Amount" := 0;
                    if Type = Type::Debit then
                        Error('The Transaction Type selected is Debit, you cannot input a Credit Amount.');
                end;
            end;
        }
        field(7; "Debit Amount"; Decimal)
        {

            trigger OnValidate()
            begin
                if "Debit Amount" <> 0 then begin
                    Amount := "Debit Amount";
                    "Credit Amount" := 0;
                    if Type = Type::Credit then
                        Error('The Transaction Type selected is Credit, you cannot input a Debit Amount.');
                end;
            end;
        }
        field(8; Amount; Decimal)
        {
        }
        field(9; "Account Name"; Text[250])
        {
            Editable = false;
        }
        field(10; "Header No"; Code[30])
        {
            TableRelation = "Internal PV Header".No;
        }
        field(11; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));

            trigger OnValidate()
            begin

                /*DimVal.RESET;
                DimVal.SETRANGE(DimVal."Global Dimension No.",1);
                DimVal.SETRANGE(DimVal.Code,"Global Dimension 1 Code");
                 IF DimVal.FIND('-') THEN
                    "Function Name":=DimVal.Name;
                
                ValidateShortcutDimCode(1,"Global Dimension 1 Code");*/

            end;
        }
        field(12; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));

            trigger OnValidate()
            begin

                /*DimVal.RESET;
                DimVal.SETRANGE(DimVal."Global Dimension No.",2);
                DimVal.SETRANGE(DimVal.Code,"Global Dimension 2 Code");
                 IF DimVal.FIND('-') THEN
                    "Budget Center Name":=DimVal.Name;
                
                ValidateShortcutDimCode(2,"Global Dimension 2 Code");*/

            end;
        }
    }

    keys
    {
        key(Key1; "Header No", "Account No.", Amount)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

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
        ObjCust: Record Customer;
        ObjVend: Record Vendor;
        ObjGL: Record "G/L Account";
        ObjBank: Record "Bank Account";
        ObjMember: Record Customer;
        ObjFA: Record "Fixed Asset";
}

