#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50370 "Members Nominee Details List"
{
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Members Next of Kin";

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                field("Member No"; "Member No")
                {
                    ApplicationArea = Basic;
                }
                field(Name; Name)
                {
                    ApplicationArea = Basic;
                }
                field("ID No."; "ID No.")
                {
                    ApplicationArea = Basic;
                }
                field(Address; Address)
                {
                    ApplicationArea = Basic;
                }
                field(Relationship; Relationship)
                {
                    ApplicationArea = Basic;
                }
                field("%Allocation"; "%Allocation")
                {
                    ApplicationArea = Basic;
                }
                field("Next Of Kin Type"; "Next Of Kin Type")
                {
                    ApplicationArea = Basic;
                }
                field("Date of Birth"; "Date of Birth")
                {
                    ApplicationArea = Basic;
                }
                field(Telephone; Telephone)
                {
                    ApplicationArea = Basic;
                }
                field(Description; Description)
                {
                    ApplicationArea = Basic;
                }
                field(Email; Email)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
}

