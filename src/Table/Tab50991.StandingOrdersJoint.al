#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50991 "Standing Orders Joint"
{

    fields
    {
        field(1; "Document No"; Code[100])
        {
        }
        field(2; "Account No"; Code[50])
        {
        }
        field(3; "Source Account No"; Code[30])
        {

            trigger OnValidate()
            begin
                Vendor.Reset;
                Vendor.SetRange(Vendor."No.", "Source Account No");
                if Vendor.Find('-') then begin
                    //REPEAT
                    AccountTypes.Reset;
                    AccountTypes.SetRange(AccountTypes.Code, Vendor."Account Type");
                    if AccountTypes.Find('-') then begin

                        "Source Account Type" := "Source Account Type" + AccountTypes.Description;
                        //"Source Account Type":="Source Account Type"+Vendor."No."+' - '+AccountTypes.Description;
                    end;
                    //UNTIL Vendor.NEXT=0;
                end;
            end;
        }
        field(4; Frequency; DateFormula)
        {
        }
        field(5; "Destination Account No"; Code[30])
        {

            trigger OnValidate()
            begin
                Vendor.Reset;
                Vendor.SetRange(Vendor."No.", "Destination Account No");
                if Vendor.Find('-') then begin
                    //REPEAT
                    "Destination Account Name" := "Destination Account Name" + Vendor.Name;
                end;
            end;
        }
        field(6; "Effective/Start Date"; Date)
        {
        }
        field(7; "End Date"; Date)
        {
        }
        field(8; Amount; Decimal)
        {
        }
        field(9; "Standing Order Description"; Text[200])
        {
        }
        field(10; "Destination Account Type"; Option)
        {
            OptionCaption = 'Internal,External,BOSA,FOSA Loan';
            OptionMembers = Internal,External,BOSA,"FOSA Loan";
        }
        field(11; Status; Option)
        {
            OptionCaption = 'Pending,Approved,Declined';
            OptionMembers = Pending,Approved,Declined;
        }
        field(12; "Reference No"; Code[100])
        {
        }
        field(13; Comments; Text[250])
        {
        }
        field(14; Approved; Boolean)
        {
        }
        field(15; "ID Number"; Code[40])
        {
        }
        field(16; "No. Series"; Code[100])
        {
        }
        field(21; "Source Account Type"; Code[100])
        {
        }
        field(22; "Destination Account Name"; Code[150])
        {
        }
        field(23; "Loan No"; Code[50])
        {
        }
        field(24; "Bosa No"; Code[50])
        {
        }
        field(25; "Mobile No"; Code[30])
        {
        }
    }

    keys
    {
        key(Key1; "Document No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "Document No" = '' then begin
            SalesSetup.Get;
            SalesSetup.TestField(SalesSetup."Standing Orders Nos.");
            NoSeriesMgt.InitSeries(SalesSetup."Standing Orders Nos.", xRec."No. Series", 0D, "Document No", "No. Series");
        end
    end;

    var
        SalesSetup: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Vendor: Record Vendor;
        AccountTypes: Record "Account Types-Saving Products";
}

