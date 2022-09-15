#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50357 "Status Update"
{

    fields
    {
        field(1; "Member No"; Code[10])
        {

            trigger OnValidate()
            begin
                Memb.Reset;
                Memb.SetRange(Memb."No.", SUpdate."Member No");
                if Memb.Find('-') then begin
                    SUpdate."Member No" := Memb."No.";
                    SUpdate."Member Name" := Memb.Name;
                    SUpdate."Old Status" := Memb.Status;
                end;
                SUpdate.Modify;
            end;
        }
        field(2; "Member Name"; Text[50])
        {
        }
        field(3; "Old Status"; Option)
        {
            OptionCaption = 'Active,Awaiting Exit,Exited,Dormant,Deceased';
            OptionMembers = Active,"Awaiting Exit",Exited,Dormant,Deceased;
        }
        field(4; "New Status"; Option)
        {
            OptionCaption = 'Active,Awaiting Exit,Exited,Dormant,Deceased';
            OptionMembers = Active,"Awaiting Exit",Exited,Dormant,Deceased;
        }
        field(5; "Date of Dormancy"; Date)
        {
        }
        field(6; "Activation date"; Date)
        {
        }
        field(7; UserID; Code[20])
        {
        }
        field(8; "Activation Reason"; Text[30])
        {
        }
    }

    keys
    {
        key(Key1; "Member No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Memb: Record Customer;
        SUpdate: Record "Status Update";
}

