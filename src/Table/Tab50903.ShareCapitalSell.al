#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50903 "Share Capital Sell"
{

    fields
    {
        field(1; "Document No"; Code[20])
        {
        }
        field(2; "Selling Member No"; Code[20])
        {
        }
        field(3; "Selling Member Name"; Code[100])
        {
        }
        field(4; "Buyer Member No"; Code[30])
        {
            TableRelation = Customer."No.";

            trigger OnValidate()
            begin
                if ObjCust.Get("Buyer Member No") then begin
                    "Buyer Name" := ObjCust.Name;
                    "Buyer Share Capital Account" := ObjCust."Share Capital No";
                    if ObjCust."Share Capital No" = '' then
                        Error('This Member ' + "Buyer Member No" + ' does not have a Share Capital Account');
                end;
            end;
        }
        field(5; "Buyer Name"; Code[100])
        {
        }
        field(6; Amount; Decimal)
        {
        }
        field(7; "Seller FOSA Account"; Code[20])
        {
            TableRelation = Vendor."No." where("BOSA Account No" = field("Selling Member No"));
        }
        field(8; "Buyer FOSA Account"; Code[20])
        {
            TableRelation = Vendor."No." where("BOSA Account No" = field("Buyer Member No"));

            trigger OnValidate()
            begin
                ObjVendors.Reset;
                ObjVendors.SetRange(ObjVendors."No.", "Buyer FOSA Account");
                if ObjVendors.Find('-') then begin
                    ObjVendors.CalcFields(ObjVendors.Balance, ObjVendors."Uncleared Cheques");
                    AvailableBal := (ObjVendors.Balance - ObjVendors."Uncleared Cheques");

                    ObjAccTypes.Reset;
                    ObjAccTypes.SetRange(ObjAccTypes.Code, ObjVendors."Account Type");
                    if ObjAccTypes.Find('-') then
                        AvailableBal := AvailableBal - ObjAccTypes."Minimum Balance";
                end;
                if AvailableBal < Amount then begin
                    Error('This account does not have sufficient balance to buy the stated amount of share capital,Available Balance is %1', AvailableBal);
                end;
            end;
        }
        field(9; "Buyer Share Capital Account"; Code[30])
        {
        }
    }

    keys
    {
        key(Key1; "Document No", "Selling Member No", "Selling Member Name", "Buyer Member No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        ObjCust: Record Customer;
        ObjVendors: Record Vendor;
        AvailableBal: Decimal;
        ObjAccTypes: Record "Account Types-Saving Products";
}

