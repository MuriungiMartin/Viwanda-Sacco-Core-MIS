#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50569 "CloudPESA Pin Reset Logs"
{
    //nownPage51516582;

    fields
    {
        field(1; "Entry No"; Integer)
        {
            AutoIncrement = true;

            trigger OnValidate()
            begin
                // IF "Entry No" <> xRec."Entry No" THEN BEGIN
                //   SaccoNoSeries.GET;
                //   NoSeriesMgt.TestManual(SaccoNoSeries."CloudPESA Registration Nos");
                //   SentToServer := '';
                // END;
            end;
        }
        field(2; No; Code[20])
        {
        }
        field(3; "Account No"; Code[30])
        {
            TableRelation = Vendor."No.";
        }
        field(4; "Account Name"; Text[50])
        {
        }
        field(5; Telephone; Code[20])
        {
        }
        field(6; "ID No"; Code[20])
        {
        }
        field(8; Date; DateTime)
        {
        }
        field(9; Sent; Boolean)
        {
        }
        field(10; "No. Series"; Code[20])
        {
        }
        field(12; Branch; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(13; "Last PIN Reset"; DateTime)
        {
        }
        field(14; "Reset By"; Text[50])
        {
        }
    }

    keys
    {
        key(Key1; "Entry No")
        {
            Clustered = true;
        }
        key(Key2; "Last PIN Reset")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin

        // IF "Entry No" = '' THEN BEGIN
        //   SaccoNoSeries.GET;
        //   SaccoNoSeries.TESTFIELD(SaccoNoSeries."CloudPESA Registration Nos");
        //   NoSeriesMgt.InitSeries(SaccoNoSeries."CloudPESA Registration Nos",xRec.SentToServer,0D,"Entry No",SentToServer);
        // END;
    end;

    var
        SaccoNoSeries: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Accounts: Record Vendor;
        Temp: Code[15];
        OldRec: Record "Cheque Book Register";
        Emp: Record "Payroll Employee.";
}

