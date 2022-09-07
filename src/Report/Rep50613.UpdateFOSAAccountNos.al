Report 50613 "Update FOSA Account Nos"
{
    RDLCLayout = 'Layouts/UpdateFOSAAccountNos.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("FOSA Accounts Import Buffer"; "FOSA Accounts Import Buffer")
        {

            trigger OnAfterGetRecord();
            begin
                ObjVendor.Init;
                ObjVendor."No." := "FOSA Accounts Import Buffer"."FOSA Account No";
                ObjVendor.Name := "FOSA Accounts Import Buffer".Name;
                ObjVendor."BOSA Account No" := "FOSA Accounts Import Buffer"."Member No";
                ObjVendor."Account Type" := "FOSA Accounts Import Buffer"."Account Type";
                ObjVendor.Status := "FOSA Accounts Import Buffer".Status;
                ObjVendor."Created By" := "FOSA Accounts Import Buffer"."Account Created By";
                ObjVendor."Account Creation Date" := "FOSA Accounts Import Buffer"."Account Creation Date";
                ObjVendor."Modified On" := "FOSA Accounts Import Buffer"."Modified On";
                ObjVendor."Modified By" := "FOSA Accounts Import Buffer"."Modified By";
                ObjVendor."Supervised By" := "FOSA Accounts Import Buffer"."Supervised By";
                ObjVendor."Supervised On" := "FOSA Accounts Import Buffer"."Supervised On";
                ObjVendor."Account Closed On" := "FOSA Accounts Import Buffer"."Account Closed On";
                ObjVendor."Account Closed By" := "FOSA Accounts Import Buffer"."Account Closed By";
                ObjVendor."Operating Mode" := "FOSA Accounts Import Buffer"."Operating Mode";
                ObjVendor."Frozen Amount" := "FOSA Accounts Import Buffer"."Frozen Amount";
                ObjVendor."Account Frozen" := "FOSA Accounts Import Buffer".Frozen;
                ObjVendor."Over Draft Limit Amount" := "FOSA Accounts Import Buffer"."OD Limit";
                ObjVendor."Over Draft Limit Expiry Date" := "FOSA Accounts Import Buffer"."OD Expiry Date";
                ObjVendor.Insert;
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
        ObjVendor: Record Vendor;

    var

}