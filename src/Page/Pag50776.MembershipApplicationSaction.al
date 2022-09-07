#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50776 "Membership Application Saction"
{
    Editable = false;
    PageType = ListPart;
    SourceTable = "Membership Reg Sactions";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Code)
                {
                    ApplicationArea = Basic;
                }
                field("Sanction Type"; "Sanction Type")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                    Style = Attention;
                    StyleExpr = true;
                }
                field("Name of Individual/Entity"; "Name of Individual/Entity")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                    Style = Attention;
                    StyleExpr = true;
                }
                field("Date of Birth"; "Date of Birth")
                {
                    ApplicationArea = Basic;
                }
                field("Palace Of Birth"; "Palace Of Birth")
                {
                    ApplicationArea = Basic;
                }
                field(Citizenship; Citizenship)
                {
                    ApplicationArea = Basic;
                }
                field("Listing Information"; "Listing Information")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                    Style = Attention;
                    StyleExpr = true;
                }
                field("Control Date"; "Control Date")
                {
                    ApplicationArea = Basic;
                }
            }
            group(Control3)
            {
                Visible = VarPepsVisible;
                field("County Code"; "County Code")
                {
                    ApplicationArea = Basic;
                }
                field("County Name"; "County Name")
                {
                    ApplicationArea = Basic;
                }
                field("Position Runing For"; "Position Runing For")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        VarAUSanctionVisible := false;
        VarPepsVisible := false;

        if "Sanction Type" = "sanction type"::"AU Sanction" then begin
            VarAUSanctionVisible := true;
        end;

        if "Sanction Type" = "sanction type"::PEPs then begin
            VarPepsVisible := true;
        end;
    end;

    trigger OnOpenPage()
    begin
        VarAUSanctionVisible := false;
        VarPepsVisible := false;

        if "Sanction Type" = "sanction type"::"AU Sanction" then begin
            VarAUSanctionVisible := true;
        end;

        if "Sanction Type" = "sanction type"::PEPs then begin
            VarPepsVisible := true;
        end;
    end;

    var
        VarAUSanctionVisible: Boolean;
        VarPepsVisible: Boolean;
}

