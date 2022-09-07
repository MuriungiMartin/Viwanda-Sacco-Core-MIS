#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50972 "Feedback"
{

    fields
    {
        field(1; "No."; Code[30])
        {
        }
        field(2; "Member No."; Code[50])
        {
        }
        field(3; "Action Date"; DateTime)
        {
        }
        field(4; "FeedBack Type"; Option)
        {
            OptionCaption = 'Feedback,Response';
            OptionMembers = Feedback,Response;
        }
        field(5; Message; Text[250])
        {
            Editable = false;
        }
        field(6; Response; Text[250])
        {

            trigger OnValidate()
            begin
                Feedback.Reset;
                SaccoNoSeries.Get;
                SaccoNoSeries.TestField(SaccoNoSeries."Feedback nos");
                // DOCUMENT_NO:=NoSeriesMgt.GetNextNo(SaccoNoSeries."Feedback nos",0D,TRUE);

                Feedback.Init;
                Feedback."No." := NoSeriesMgt.GetNextNo(SaccoNoSeries."Feedback nos", 0D, true);
                Feedback."Member No." := "Member No.";
                Feedback.Message := Response;
                //Feedback.Response:=Response;
                Feedback."Action Date" := CurrentDatetime;
                Feedback."FeedBack Type" := Feedback."feedback type"::Response;
                Feedback.Insert(true);
            end;
        }
        field(7; "No.Series"; Code[30])
        {
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Feedback: Record Feedback;
        SaccoNoSeries: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;
}

