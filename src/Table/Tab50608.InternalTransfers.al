#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50608 "Internal Transfers"
{

    fields
    {
        field(1; No; Code[20])
        {

            trigger OnValidate()
            begin
                if No <> xRec.No then begin
                    NoSetup.Get(0);
                    NoSeriesMgt.TestManual(No);
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Transaction Date"; Date)
        {
        }
        field(3; "Schedule Total"; Decimal)
        {
            CalcFormula = sum("Sacco Transfers Schedule".Amount where("No." = field(No)));
            FieldClass = FlowField;
        }
        field(4; Approved; Boolean)
        {
        }
        field(5; "Approved By"; Code[10])
        {
        }
        field(6; Posted; Boolean)
        {
        }
        field(7; "No. Series"; Code[20])
        {
        }
        field(8; "Responsibility Center"; Code[10])
        {
        }
        field(9; "Transaction Description"; Code[100])
        {
        }
        field(10; "Source Account Type"; Option)
        {
            OptionCaption = 'Trade Customer,Member Account,Bank Account,G/L Account,Loan Account,Supplier';
            OptionMembers = "Trade Customer","Member Account","Bank Account","G/L Account","Loan Account",Supplier;

            trigger OnValidate()
            begin
                if "Source Account Type" = "source account type"::"Loan Account" then begin
                    "Source Account No" := "Member No";
                end;
            end;
        }
        field(11; "Source Account No"; Code[20])
        {
            TableRelation = if ("Source Account Type" = filter("Member Account"),
                                "Member No" = filter(<> '')) Vendor."No." where("BOSA Account No" = field("Member No"),
                                                                              Status = filter(<> Closed | Deceased),
                                                                              Blocked = filter(<> Payment | All))
            else
            if ("Source Account Type" = filter("Member Account"),
                                                                                       "Member No" = filter('')) Vendor."No." where("BOSA Account No" = filter(<> ''),
                                                                                                                                   Status = filter(<> Closed | Deceased),
                                                                                                                                   Blocked = filter(<> Payment | All))
            else
            if ("Source Account Type" = filter("Bank Account")) "Bank Account"."No."
            else
            if ("Source Account Type" = filter("G/L Account")) "G/L Account"."No."
            else
            if ("Source Account Type" = filter("Loan Account")) Customer."No."
            else
            if ("Source Account Type" = filter(Supplier)) Vendor."No." where("Creditor Type" = filter(Supplier),
                                                                                                                                                                                                        Blocked = filter(<> Payment | All));

            trigger OnValidate()
            begin
                if ObjAccount.Get("Source Account No") then begin
                    "Member No" := ObjAccount."BOSA Account No";
                    "Member Name" := ObjAccount.Name;
                end;

                if "Source Account Type" = "source account type"::"Trade Customer" then begin
                    Cust.Reset;
                    if Cust.Get("Source Account No") then begin
                        "Source Account Name" := Cust.Name;
                        "Source Transaction Type" := "source transaction type"::"Deposit Contribution";
                        //"Source Account No":=Cust."FOSA Account";
                        Validate("Source Account No");
                    end;
                end;

                if "Source Account Type" = "source account type"::"Bank Account" then begin
                    Bank.Reset;
                    if Bank.Get("Source Account No") then begin
                        "Source Account Name" := Bank.Name;
                        "Global Dimension 2 Code" := Bank."Global Dimension 2 Code";
                    end;
                end;

                if "Source Account Type" = "source account type"::"Member Account" then begin
                    Vend.Reset;
                    if Vend.Get("Source Account No") then begin
                        "Source Account Name" := Vend.Name;
                        "Global Dimension 2 Code" := Vend."Global Dimension 2 Code";
                    end;
                end;

                if "Source Account Type" = "source account type"::"Loan Account" then begin
                    memb.Reset;
                    if memb.Get("Source Account No") then begin
                        "Source Account Name" := memb.Name;
                        "Bosa Number" := memb."No.";
                        "Global Dimension 2 Code" := memb."Global Dimension 2 Code";
                    end;
                end;


                if "Source Account Type" = "source account type"::"G/L Account" then begin
                    "G/L".Reset;
                    if "G/L".Get("Source Account No") then begin
                        "Source Account Name" := "G/L".Name;
                    end;
                end;
            end;
        }
        field(12; "Source Transaction Type"; Option)
        {
            OptionCaption = ' ,Registration Fee,Share Capital,Interest Paid,Loan Repayment,Deposit Contribution,Insurance Contribution,Benevolent Fund,Loan,Unallocated Funds,Dividend,FOSA Account';
            OptionMembers = " ","Registration Fee","Share Capital","Interest Paid","Loan Repayment","Deposit Contribution","Insurance Contribution","Benevolent Fund",Loan,"Unallocated Funds",Dividend,"FOSA Account";
        }
        field(13; "Source Account Name"; Text[50])
        {
        }
        field(14; "Source Loan No"; Code[20])
        {
            TableRelation = if ("Source Account Type" = filter("Member Account")) "Loans Register"."Loan  No." where("Client Code" = field("Source Account No"))
            else
            if ("Source Account Type" = filter("Loan Account")) "Loans Register"."Loan  No." where("Client Code" = field("Source Account No"));
        }
        field(15; "Created By"; Code[30])
        {
        }
        field(16; Debit; Text[30])
        {
            Editable = false;
        }
        field(17; Refund; Boolean)
        {
        }
        field(18; "Guarantor Recovery"; Boolean)
        {
        }
        field(19; "Payrol No."; Code[30])
        {
        }
        field(20; "Global Dimension 1 Code"; Code[10])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1),
                                                          "Dimension Value Type" = const(Standard));
        }
        field(21; "Global Dimension 2 Code"; Code[10])
        {
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2),
                                                          "Dimension Value Type" = const(Standard));
        }
        field(22; "Bosa Number"; Code[30])
        {
            Editable = false;
        }
        field(51516061; Status; Option)
        {
            OptionCaption = 'Open,Pending Approval,Approved,Rejected';
            OptionMembers = Open,"Pending Approval",Approved,Rejected;
        }
        field(51516062; "Savings Account Type"; Code[30])
        {
            TableRelation = "Account Types-Saving Products".Code;
        }
        field(51516063; "Deposit Debit Options"; Option)
        {
            OptionCaption = ' ,Partial Refund,Loan Recovery,Posting Adjustment';
            OptionMembers = " ","Partial Refund","Loan Recovery","Posting Adjustment";
        }
        field(51516064; "Member No"; Code[20])
        {
            TableRelation = Customer."No.";

            trigger OnValidate()
            begin
                if ObjCust.Get("Member No") then begin
                    "Member Name" := ObjCust.Name;
                end;
            end;
        }
        field(51516065; "Member Name"; Code[100])
        {
        }
        field(51516066; "Share Capital Sell"; Boolean)
        {
        }
        field(51516067; "Account to Recover Transfer Fe"; Code[30])
        {
            TableRelation = Vendor."No." where("BOSA Account No" = field("Member No"));

            trigger OnValidate()
            begin
                if "Source Account No" = "Account to Recover Transfer Fe" then
                    Error('You can not select the same account as the source account');

                VarAvailableBal := SFactory.FnRunGetAccountAvailableBalance("Account to Recover Transfer Fe");
                VarShareCapitalFeeTax := ObjGensetup."Share Capital Transfer Fee" + (ObjGensetup."Share Capital Transfer Fee" * (ObjGensetup."Excise Duty(%)" / 100));
                if VarShareCapitalFeeTax > VarAvailableBal then
                    Error('This account has insufficeint funds for this transfer, Account Available Balance is %1', VarAvailableBal);
            end;
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

    trigger OnDelete()
    begin
        if Approved or Posted then
            Error('Cannot delete posted or approved batch');
    end;

    trigger OnInsert()
    begin
        if No = '' then begin
            NoSetup.Get;
            NoSetup.TestField(NoSetup."BOSA Transfer Nos");
            NoSeriesMgt.InitSeries(NoSetup."BOSA Transfer Nos", xRec."No. Series", 0D, No, "No. Series");
        end;
        "Transaction Date" := Today;
        "Created By" := UserId;
        Debit := 'Credit';
    end;

    trigger OnModify()
    begin
        if Posted then
            Error('Cannot modify a posted batch');
    end;

    trigger OnRename()
    begin
        if Posted then
            Error('Cannot rename a posted batch');
    end;

    var
        NoSetup: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Cust: Record Customer;
        Bank: Record "Bank Account";
        Vend: Record Vendor;
        memb: Record Customer;
        "G/L": Record "G/L Account";
        ObjCust: Record Customer;
        SFactory: Codeunit "SURESTEP Factory";
        VarAvailableBal: Decimal;
        VarShareCapitalFeeTax: Decimal;
        ObjGensetup: Record "Sacco General Set-Up";
        ObjAccount: Record Vendor;
}

