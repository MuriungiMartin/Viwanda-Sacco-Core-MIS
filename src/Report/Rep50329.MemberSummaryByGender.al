#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
//51516329_v6_3_0_2259) { }
// Autogenerated code - do not delete or modify -->

Report 50329 "Member Summary By Gender"
{
    RDLCLayout = 'Layouts/MemberSummaryByGender.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem(Customer; Customer)
        {
            RequestFilterFields = "Registration Date", "Global Dimension 2 Code";
            column(ReportForNavId_4645; 4645) { } // Autogenerated by ForNav - Do not delete
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(Company_Name; Company.Name)
            {
            }
            column(Company_Address; Company.Address)
            {
            }
            column(Company_Address_2; Company."Address 2")
            {
            }
            column(Company_Phone_No; Company."Phone No.")
            {
            }
            column(Company_Fax_No; Company."Fax No.")
            {
            }
            column(Company_Picture; Company.Picture)
            {
            }
            column(Company_Email; Company."E-Mail")
            {
            }

            column(UserId; UserId)
            {
            }
            column(VarMaleCount; VarMaleCount)
            {
            }
            column(VarMalePercentage; VarMalePercentage)
            {
            }
            column(VarFeMaleCount; VarFeMaleCount)
            {
            }
            column(VarFeMalePercentage; VarFeMalePercentage)
            {
            }
            column(VarCorporateCount; VarCorporateCount)
            {
            }
            column(VarCorporatePercentage; VarCorporatePercentage)
            {
            }
            trigger OnPreDataItem();
            begin
                Company.Get();
                Company.CalcFields(Company.Picture);
            end;

            trigger OnAfterGetRecord();
            begin
                FnRunGetGenderCategory;
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
            //:= false;
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
        AsAt: Date;
        Company: Record "Company Information";
        SFactory: Codeunit "SURESTEP Factory";
        ObjGensetup: Record "Sacco General Set-Up";
        CurrReport_PAGENOCaptionLbl: label 'Page';
        RISK_CLASSIFICATION_OF_ASSETS_AND_PROVISIONINGCaptionLbl: label 'RISK CLASSIFICATION OF ASSETS AND PROVISIONING';
        FORM_4CaptionLbl: label 'FORM 4';
        SASRA_2_004CaptionLbl: label 'SASRA 2/004';
        R__46_CaptionLbl: label 'R.(46)';
        VarMaleCount: Integer;
        VarMalePercentage: Decimal;
        VarFeMaleCount: Integer;
        VarFeMalePercentage: Decimal;
        VarCorporateCount: Integer;
        VarCorporatePercentage: Decimal;
        ObjMembers: Record Customer;

    local procedure FnRunGetGenderCategory()
    begin
        ObjGensetup.Get();
        //======================================================== Male
        ObjMembers.Reset;
        ObjMembers.SetFilter(ObjMembers."Account Category", '%1', ObjMembers."account category"::Individual);
        ObjMembers.SetRange(ObjMembers.Gender, ObjMembers.Gender::Male);
        if ObjMembers.FindSet then begin
            ObjGensetup.CalcFields("Total Membership");
            VarMaleCount := ObjMembers.Count;
            VarMalePercentage := (VarMaleCount / ObjGensetup."Total Membership") * 100;
        end;
        //========================================================Female
        ObjMembers.Reset;
        ObjMembers.SetFilter(ObjMembers."Account Category", '%1', ObjMembers."account category"::Individual);
        ObjMembers.SetRange(ObjMembers.Gender, ObjMembers.Gender::Female);
        if ObjMembers.FindSet then begin
            ObjGensetup.CalcFields("Total Membership");
            VarFeMaleCount := ObjMembers.Count;
            VarFeMalePercentage := (VarFeMaleCount / ObjGensetup."Total Membership") * 100;
        end;
        //========================================================Corporate
        ObjMembers.Reset;
        ObjMembers.SetFilter(ObjMembers.Gender, '%1', ObjMembers.Gender::" ");
        if ObjMembers.FindSet then begin
            ObjGensetup.CalcFields("Total Membership");
            VarCorporateCount := ObjMembers.Count;
            VarCorporatePercentage := (VarCorporateCount / ObjGensetup."Total Membership") * 100;
        end;
    end;

    // --> Reports ForNAV Autogenerated code - do not delete or modify
    //51516329_v6_3_0_2259;






    // Reports ForNAV Autogenerated code - do not delete or modify -->
}
