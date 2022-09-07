#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50913 "ATM Card Nos Buffer"
{

    fields
    {
        field(1; "ATM Card No"; Code[50])
        {
            Editable = false;
        }
        field(2; "Account No"; Code[50])
        {
            Editable = false;
        }
        field(3; "Account Name"; Code[50])
        {
            Editable = false;
        }
        field(4; "Account Type"; Code[50])
        {
            Editable = false;
        }
        field(5; Status; Option)
        {
            Editable = false;
            OptionCaption = 'Active,Blocked';
            OptionMembers = Active,Blocked;
        }
        field(6; "ID No"; Code[50])
        {
            Editable = false;
        }
        field(7; "Delink ATM Card"; Boolean)
        {

            trigger OnValidate()
            begin
                if "Delink ATM Card" = true then begin
                    TestField("Reason For Delink");
                    if Confirm('Confirm Card Delink?', false) = true then begin
                        ObjCardsApplications.Reset;
                        ObjCardsApplications.SetRange(ObjCardsApplications."Card No", "ATM Card No");
                        if ObjCardsApplications.FindSet then begin
                            ObjCardsApplications."ATM Delinked" := true;
                            ObjCardsApplications."ATM Delinked By" := UserId;
                            ObjCardsApplications."ATM Delinked On" := WorkDate;
                            Status := Status::Blocked;
                            "Delinked On" := WorkDate;
                            "Delinked By" := UserId;
                            ObjCardsApplications.Modify;
                        end;
                    end;
                end;
                if "Delink ATM Card" = false then begin
                    if Confirm('Confirm Cancel Card Delink?', false) = true then begin
                        ObjCardsApplications.Reset;
                        ObjCardsApplications.SetRange(ObjCardsApplications."Card No", "ATM Card No");
                        if ObjCardsApplications.FindSet then begin
                            ObjCardsApplications."ATM Delinked" := false;
                            Status := Status::Active;
                            ObjCardsApplications.Modify;
                        end;
                    end;
                end;
            end;
        }
        field(8; "Delinked By"; Code[30])
        {
            Editable = false;
        }
        field(9; "Delinked On"; Date)
        {
            Editable = false;
        }
        field(10; "Reason For Delink"; Text[150])
        {
        }
    }

    keys
    {
        key(Key1; "ATM Card No", "Account No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        ObjCardsApplications: Record "ATM Card Applications";
}

