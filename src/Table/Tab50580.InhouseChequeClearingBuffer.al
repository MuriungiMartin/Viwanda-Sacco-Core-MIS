#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50580 "Inhouse Cheque Clearing Buffer"
{

    fields
    {
        field(1; "No."; Code[10])
        {
        }
        field(2; "Transaction No"; Code[20])
        {

            trigger OnValidate()
            begin
                // IF "Cheque No"="Cheque No"::"0" THEN BEGIN
                // Cust.RESET;
                // IF Cust.GET("Transaction No") THEN BEGIN
                // "Account No":=Cust.Name;
                // "Account Name":="Account Name"::"0";
                // //"Destination Account No.":=Cust."FOSA Account";
                // VALIDATE("Transaction Type");
                // END;
                // END;
                //
                // IF "Cheque No"="Cheque No":: "2" THEN BEGIN
                // Bank.RESET;
                // IF Bank.GET("Transaction No") THEN BEGIN
                // "Account No":=Bank.Name;
                // END;
                // END;
                //
                // IF "Cheque No"="Cheque No"::"1" THEN BEGIN
                // Vend.RESET;
                // IF Vend.GET("Transaction No") THEN BEGIN
                // "Account No":=Vend.Name;
                // "Drawers Member No":=Vend."BOSA Account No";
                //
                // END;
                // END;
                //
                // IF "Cheque No"="Cheque No"::"4" THEN BEGIN
                // memb.RESET;
                // IF memb.GET("Transaction No") THEN BEGIN
                // "Account No":=memb.Name;
                //  "Drawers Member No":=memb.Name;
                // END;
                // END;
                //
                //
                // IF "Cheque No"="Cheque No"::"3" THEN BEGIN
                // "G/L".RESET;
                // IF "G/L".GET("Transaction No") THEN BEGIN
                // "Account No":="G/L".Name;
                // END;
                // END;
                //
                // IF Accounttype.GET('CURRENT') THEN BEGIN
                //  Charge:=50;
                //  END;
            end;
        }
        field(3; "Account No"; Code[50])
        {
        }
        field(4; "Account Name"; Code[100])
        {

            trigger OnValidate()
            begin
                /*IF "Destination Account Type"="Destination Account Type"::BANK THEN BEGIN
                "Destination Account No.":='5-02-09276-01';
                VALIDATE("Destination Account No.");
                END;
                   */

            end;
        }
        field(5; "Transaction Type"; Code[20])
        {

            trigger OnValidate()
            begin
                // IF "Account Name" = "Account Name"::"0" THEN BEGIN
                // Vend.RESET;
                // IF Vend.GET("Transaction Type") THEN
                // "Expected Maturity Date":=Vend.Name;
                // END ELSE
                // IF "Account Name" = "Account Name"::"2" THEN BEGIN
                // Cust.RESET;
                // IF Cust.GET("Transaction Type") THEN
                // "Expected Maturity Date":=Cust.Name;
                // END;
                //
                // IF "Account Name"="Account Name"::"3" THEN BEGIN
                // "G/L".RESET;
                // IF "G/L".GET("Transaction Type") THEN BEGIN
                // "Expected Maturity Date":="G/L".Name;
                // END;
                // END;
                //
                // IF "Account Name"="Account Name"::"4" THEN BEGIN
                // memb.RESET;
                // IF memb.GET("Transaction Type") THEN BEGIN
                // "Expected Maturity Date":=memb.Name;
                // END;
                // END;
                // IF "Account Name"="Account Name"::"1" THEN BEGIN
                // Bank.RESET;
                // IF Bank.GET("Transaction Type") THEN BEGIN
                // "Expected Maturity Date":=Bank.Name;
                // END;
                // END;
            end;
        }
        field(6; Amount; Decimal)
        {
        }
        field(7; "Cheque No"; Code[50])
        {
        }
        field(8; "Expected Maturity Date"; Date)
        {
        }
        field(9; "Cheque Clearing Status"; Option)
        {
            OptionCaption = ' ,Cleared,Bounced';
            OptionMembers = " ",Cleared,Bounced;
        }
    }

    keys
    {
        key(Key1; "No.", "Transaction No")
        {
            Clustered = true;
            SumIndexFields = Amount;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        if "Transaction No" <> '' then begin
            Bosa.Reset;
            if Bosa.Get("No.") then begin
                if (Bosa.Posted) or (Bosa.Approved) then
                    Error('Cannot delete approved or posted batch');
            end;
        end;
    end;

    trigger OnModify()
    begin
        if "Transaction No" <> '' then begin
            Bosa.Reset;
            if Bosa.Get("No.") then begin
                if (Bosa.Posted) or (Bosa.Approved) then
                    Error('Cannot modify approved or posted batch');
            end;
        end;
    end;

    trigger OnRename()
    begin
        Bosa.Reset;
        if Bosa.Get("No.") then begin
            if (Bosa.Posted) or (Bosa.Approved) then
                Error('Cannot rename approved or posted batch');
        end;
    end;

    var
        Cust: Record Customer;
        Vend: Record Vendor;
        Bank: Record "Bank Account";
        Bosa: Record "BOSA Transfers";
        "G/L": Record "G/L Account";
        memb: Record Customer;
        Accounttype: Record "Account Types-Saving Products";
}

