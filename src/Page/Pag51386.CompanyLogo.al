page 51386 "CompanyLogo"
{
    PageType = HeadlinePart;
    RefreshOnActivate = true;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Company Information";

    layout
    {
        area(Content)
        {

            cuegroup(Logo)
            {

                field(Picture; Picture)
                {
                    ApplicationArea = basic;
                    ShowCaption = false;

                }
            }
        }
    }
}