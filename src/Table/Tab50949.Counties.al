#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50949 "Counties"
{

    fields
    {
        field(1; No; Code[30])
        {
        }
        field(2; "County Code"; Code[30])
        {
        }
        field(3; "County Name"; Text[250])
        {
        }
        field(4; "No.Series"; Code[30])
        {
        }
        field(5; Region; Text[30])
        {
        }
    }

    keys
    {
        key(Key1; No, "County Code", "County Name")
        {
            Clustered = true;
        }
        key(Key2; "County Code")
        {
        }
        key(Key3; "County Name")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "County Name", "County Code")
        {
        }
    }

    trigger OnInsert()
    begin
        /* IF No='' THEN
          BEGIN
            NoSetups.GET;
            NoSetups.TESTFIELD(NoSetups."County Nos");
            NoSeriesMgt.InitSeries(NoSetups."County Nos", xRec.No, 0D, No, "No.Series");
          END;
          */

    end;

    var
        NoSetups: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;
}

