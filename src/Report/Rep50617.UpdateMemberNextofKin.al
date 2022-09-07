Report 50617 "Update Member Next of Kin"
{
    RDLCLayout = 'Layouts/UpdateMemberNextofKin.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Member Next Of Kin Buffer"; "Member Next Of Kin Buffer")
        {

            trigger OnAfterGetRecord();
            begin
                ObjNextofKin.Init;
                ObjNextofKin."Member No" := "Member Next Of Kin Buffer"."Member No";
                ObjNextofKin.Name := "Member Next Of Kin Buffer"."Next of Kin Name";
                ObjNextofKin."%Allocation" := "Member Next Of Kin Buffer"."Allocation Percentage";
                ObjNextofKin."ID No." := "Member Next Of Kin Buffer"."ID No";
                ObjNextofKin.Relationship := "Member Next Of Kin Buffer"."RelationShip Type";
                ObjNextofKin.Telephone := "Member Next Of Kin Buffer"."Mobile No";
                ObjNextofKin.Email := "Member Next Of Kin Buffer".Email;
                ObjNextofKin.Guardian := "Member Next Of Kin Buffer"."Guardian Details";
                ObjNextofKin."Next Of Kin Type" := ObjNextofKin."next of kin type"::Beneficiary;
                ObjNextofKin."Created By" := "Member Next Of Kin Buffer"."Created By";
                ObjNextofKin."Date Created" := "Member Next Of Kin Buffer"."Created On";
                ObjNextofKin."Modified by" := "Member Next Of Kin Buffer"."Modified By";
                ObjNextofKin."Last date Modified" := "Member Next Of Kin Buffer"."Modified On";
                ObjNextofKin."Entry No" := "Member Next Of Kin Buffer"."Entry No";
                ObjNextofKin.Insert;
            end;

        }
    }

    requestpage
    {


        SaveValues = false;
        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';

                }
            }
        }

        actions
        {
        }
        trigger OnOpenPage()
        begin

        end;
    }

    trigger OnInitReport()
    begin
        ;


    end;

    trigger OnPostReport()
    begin
        ;

    end;

    trigger OnPreReport()
    begin
        ;

    end;

    var
        ObjNextofKin: Record "Members Next of Kin";

    var

}

