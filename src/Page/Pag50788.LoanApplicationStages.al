#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50788 "Loan Application Stages"
{
    PageType = ListPart;
    SourceTable = "Loan Application Stages";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Loan Stage"; "Loan Stage")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Loan Stage Description"; "Loan Stage Description")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Stage Status"; "Stage Status")
                {
                    ApplicationArea = Basic;
                }
                field("Date Upated"; "Date Upated")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Updated By"; "Updated By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Comment; Comment)
                {
                    ApplicationArea = Basic;
                    Width = 10;
                }
            }
        }
    }

    actions
    {
    }
}

