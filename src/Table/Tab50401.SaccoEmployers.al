#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50401 "Sacco Employers"
{
    //nownPage51516422;
    //nownPage51516422;

    fields
    {
        field(1; "Code"; Code[20])
        {

            trigger OnValidate()
            begin
                if Code <> xRec.Code then begin
                    ObjNoSeries.Get;
                    NoSeriesMgt.TestManual(ObjNoSeries."Employers Nos");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; Description; Text[50])
        {
        }
        field(3; "Repayment Method"; Option)
        {
            OptionMembers = " ",Amortised,"Reducing Balance","Straight Line",Constants;
        }
        field(4; "Check Off"; Boolean)
        {
        }
        field(5; "No. of Members"; Integer)
        {
            CalcFormula = count(Customer where(Status = filter(Active | Dormant | Deceased | "Awaiting Exit" | Exited),
                                                          "Employer Code" = field(Code),
                                                          "Customer Posting Group" = const('MEMBER')));
            FieldClass = FlowField;
        }
        field(6; Male; Integer)
        {
            CalcFormula = count(Customer where(Status = filter(Active | Dormant | Deceased | "Awaiting Exit" | Exited),
                                                          "Employer Code" = field(Code),
                                                          "Customer Posting Group" = const('MEMBER'),
                                                          Gender = const(" ")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(7; Female; Integer)
        {
            CalcFormula = count(Customer where(Status = filter(Active | Dormant | Deceased | "Awaiting Exit" | Exited),
                                                          "Employer Code" = field(Code),
                                                          "Customer Posting Group" = const('MEMBER'),
                                                          Gender = const(Male)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(8; "Vote Code"; Code[20])
        {
        }
        field(9; "Can Guarantee Loan"; Boolean)
        {
        }
        field(10; "Active Members"; Integer)
        {
            CalcFormula = count(Customer where(Status = filter(Active),
                                                          "Employer Code" = field(Code),
                                                          "Customer Posting Group" = const('MEMBER')));
            Editable = false;
            FieldClass = FlowField;
        }
        field(11; "Dormant Members"; Integer)
        {
            CalcFormula = count(Customer where(Status = filter(Dormant),
                                                          "Employer Code" = field(Code),
                                                          "Customer Posting Group" = const('MEMBER')));
            Editable = false;
            FieldClass = FlowField;
        }
        field(12; Withdrawn; Integer)
        {
            CalcFormula = count(Customer where(Status = filter(Exited),
                                                          "Employer Code" = field(Code),
                                                          "Customer Posting Group" = const('MEMBER')));
            Editable = false;
            FieldClass = FlowField;
        }
        field(13; Deceased; Integer)
        {
            CalcFormula = count(Customer where(Status = filter(Deceased),
                                                          "Employer Code" = field(Code),
                                                          "Customer Posting Group" = const('MEMBER')));
            Editable = false;
            FieldClass = FlowField;
        }
        field(14; "Join Date"; Date)
        {
        }
        field(15; "No. Series"; Code[30])
        {
        }
        field(69219; "Payment Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Checkoff,Standing Order';
            OptionMembers = " ",Checkoff,"Standing Order";
        }
    }

    keys
    {
        key(Key1; "Code", Description)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Code", Description)
        {
        }
    }

    trigger OnInsert()
    begin
        if Code = '' then begin
            ObjNoSeries.Get;
            ObjNoSeries.TestField(ObjNoSeries."Employers Nos");
            NoSeriesMgt.InitSeries(ObjNoSeries."Employers Nos", xRec."No. Series", 0D, Code, "No. Series");
        end;
    end;

    var
        cust: Record Customer;
        ObjNoSeries: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;
}

