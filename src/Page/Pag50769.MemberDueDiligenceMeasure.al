#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50769 "Member Due Diligence Measure"
{
    PageType = ListPart;
    SourceTable = "Member Due Diligence Measures";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Due Diligence Measure"; "Due Diligence Measure")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Due Diligence Done"; "Due Diligence Done")
                {
                    ApplicationArea = Basic;
                }
                field("Due Diligence Done By"; "Due Diligence Done By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }
}

