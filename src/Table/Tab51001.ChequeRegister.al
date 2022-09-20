table 51001 "ChequeRegister"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Cheque No"; Code[30])
        {
            DataClassification = ToBeClassified;
            trigger onvalidate()
            var
                myInt: Integer;
            begin
                if "Cheque No" <> xRec."Cheque No" then begin
                    SalesSetup.Get;
                    NoSeriesManagement.TestManual(SalesSetup."Cheque No.");
                    "No. Series" := '';
                end;
            end;

        }
        field(2; "Bank"; Code[30])
        {
            DataClassification = ToBeClassified;

        }
        field(3; "Payment To"; Text[30])
        {
            DataClassification = ToBeClassified;

        }

        field(4; "Date"; Date)
        {
            DataClassification = ToBeClassified;

        }
        field(5; "Type of Payment"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Development,Emergency,others;


        }
        field(6; "Description"; Text[30])
        {
            DataClassification = ToBeClassified;

        }
        field(7; "No. Series"; Code[30])
        {
            DataClassification = ToBeClassified;

        }
        field(8; "Cheque Amount"; Decimal)
        {
            DataClassification = ToBeClassified;

        }
        field(9; "Status"; option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Open,Pending,Approved,Rejected;


        }
        field(10; "Cheque Processed"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Cheque Collected"; Boolean)
        {
            DataClassification = ToBeClassified;
        }


    }

    keys
    {
        key(key1; "Cheque No")
        {
            Clustered = true;
        }
    }

    var
        SalesSetup: Record "Sacco No. Series";
        NoSeriesManagement: codeunit NoSeriesManagement;


    trigger OnInsert()
    begin
        if "Cheque No" = '' then begin
            SalesSetup.Get;
            SalesSetup.TestField(SalesSetup."Cheque No.");
            NoSeriesManagement.InitSeries(SalesSetup."Cheque No.", xRec."No. Series", 0D, "Cheque No", "No. Series");
        end;
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