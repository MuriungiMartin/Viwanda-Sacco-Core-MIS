table 51000 "MpesaBillings"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; BillingNo; Code[50])
        {
            DataClassification = ToBeClassified;

        }
        field(2; "Bill Account Type"; enum MpesaBillingsEnum)
        {

        }
        field(3; "Bill Account No."; code[30])
        {

        }
        field(4; "Bill Status"; Option)
        {
            OptionMembers = Open,pending,Billed,Failed;
        }
        field(5; "After Billing Status"; Option)
        {
            OptionMembers = Awaiting,Cancelled,Successful,Failed;
        }
        field(6; "Bill to Phone No."; code[12])
        {

        }
        field(7; Description; Text[100])
        {

        }
        field(8; "Transaction Type"; Enum TransactionTypesEnum)
        {

        }
    }

    keys
    {
        key(Key1; BillingNo)
        {
            Clustered = true;
        }
    }

    var
        GenJournalLine: Record "Gen. Journal Line";

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}