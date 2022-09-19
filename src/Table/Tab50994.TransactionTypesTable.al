table 50994 "Transaction Types Table"
{
    DataClassification = ToBeClassified;


    fields
    {
        field(1; "Transaction Type"; Enum TransactionTypesEnum)
        {
            DataClassification = ToBeClassified;

        }
        field(2; "Posting Group Code"; code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Customer Posting Group".Code;
        }
    }

    keys
    {
        key(Key1; "Transaction Type")
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

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