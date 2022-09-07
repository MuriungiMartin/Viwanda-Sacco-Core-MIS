#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50358 "Audit Issues Tracker"
{

    fields
    {
        field(1; "Document No"; Code[30])
        {
            Editable = false;

            trigger OnValidate()
            begin
                if "Document No" <> xRec."Document No" then begin
                    SalesSetup.Get;
                    NoSeriesMgt.TestManual(SalesSetup."Audit issue Tracker");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Date Of Audit"; Date)
        {
        }
        field(3; Theme; Code[50])
        {
            TableRelation = "Audit Themes";

            trigger OnValidate()
            begin
                ObjAuditThemes.Reset;
                ObjAuditThemes.SetRange(ObjAuditThemes.Code, Theme);
                if ObjAuditThemes.FindSet then begin
                    "Theme Description" := ObjAuditThemes.Description;
                end;
            end;
        }
        field(4; "Issue Description"; Text[250])
        {
        }
        field(5; "Mgt Action Point"; Text[250])
        {
        }
        field(6; "Action Owner"; Option)
        {
            OptionCaption = ' ,HOD Credit,HOD Operations,HOD Business Development,HOD Finance,HOD ICT,Board Chair,CEO';
            OptionMembers = " ","HOD Credit","HOD Operations","HOD Business Development","HOD Finance","HOD ICT","Board Chair",CEO;
        }
        field(7; "Action Date"; Date)
        {
        }
        field(8; "Action Due Date"; Date)
        {
            Editable = false;
        }
        field(9; "Action Over Due Date"; Date)
        {
            Editable = false;
        }
        field(10; "Day Past"; Integer)
        {
        }
        field(11; Status; Option)
        {
            OptionCaption = ' ,Open,Due,OverDue,Closed,Failed';
            OptionMembers = " ",Open,Due,OverDue,Closed,Failed;
        }
        field(12; "Combined Status"; Text[100])
        {
        }
        field(13; "Mgt Response"; Option)
        {
            OptionCaption = ' ,Open,Complete';
            OptionMembers = " ",Open,Complete;
        }
        field(14; "Revised Mgt Comment"; Text[250])
        {
        }
        field(15; "Audit Opinion On Closure"; Option)
        {
            OptionCaption = 'Issue Assurance Not Yet Done,Failed,Closed';
            OptionMembers = "Issue Assurance Not Yet Done",Failed,Closed;
        }
        field(16; "Why Issue Failed/Passed"; Text[250])
        {
        }
        field(17; "Mgt Comment After Review"; Text[250])
        {
        }
        field(18; "Revised Implementation"; Date)
        {
        }
        field(19; "Mnt response on failed"; Option)
        {
            OptionCaption = ' ,Open,Closed';
            OptionMembers = " ",Open,Closed;
        }
        field(20; "No. Series"; Code[30])
        {
        }
        field(21; "Theme Description"; Text[100])
        {
        }
        field(22; Recomendations; Text[250])
        {
        }
        field(23; "Revised Mgt Comment Additional"; Text[250])
        {
        }
        field(24; "Issue Description Additional"; Text[250])
        {
        }
        field(25; "Audit Comments After Review"; Text[250])
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
    var
        SalesSetup: Record "Sacco No. Series";
    begin
        if "Document No" = '' then begin
            SalesSetup.Get;
            SalesSetup.TestField(SalesSetup."Audit issue Tracker");
            NoSeriesMgt.InitSeries(SalesSetup."Audit issue Tracker", xRec."No. Series", 0D, "Document No", "No. Series");
        end;
    end;

    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
        SalesSetup: Record "Sacco No. Series";
        ObjAuditThemes: Record "Audit Themes";
}

