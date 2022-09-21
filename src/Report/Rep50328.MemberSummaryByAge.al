#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
//51516328_v6_3_0_2259) { }
// Autogenerated code - do not delete or modify -->

Report 50328 "Member Summary By Age"
{
    RDLCLayout = 'Layouts/MemberSummaryByAge.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem(Customer; Customer)
        {
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
            column(CountLessthan18; "Var<18Count")
            {
            }
            column(Lessthan18Pec; "Var<18%")
            {
            }
            column(Count18to24; "Var18<24Count")
            {
            }
            column(Pec18to24; "Var18<24%")
            {
            }
            column(Count25to34; "Var25<34Count")
            {
            }
            column(Pec25to34; "Var25<34%")
            {
            }
            column(Count35to44; "Var35<44Count")
            {
            }
            column(Pec35to44; "Var35<44%")
            {
            }
            column(Count45to54; "Var45<54Count")
            {
            }
            column(Pec45to54; "Var45<54%")
            {
            }
            column(Count55to64; "Var55<64Count")
            {
            }
            column(Pec55to64; "Var55<64%")
            {
            }
            column(Count65to74; "Var65<74Count")
            {
            }
            column(Pec65to74; "Var65<74%")
            {
            }
            column(CountGreaterthan75; "Var>75Count")
            {
            }
            column(Greaterthan75Pec; "Var>75%")
            {
            }
            trigger OnPreDataItem();
            begin
                Company.Get();
                Company.CalcFields(Company.Picture);
                if AsAt = 0D then
                    Error('Specify the As At Date on the Report');
            end;

            trigger OnAfterGetRecord();
            begin
                ObjMemberII.Reset;
                ObjMemberII.SetRange(ObjMemberII."No.", Customer."No.");
                ObjMemberII.SetFilter(ObjMemberII."Date of Birth", '<>%1', 0D);
                if ObjMemberII.FindSet then begin
                    VarAge := AsAt - ObjMemberII."Date of Birth"; //Returns number of days old
                    VarAge2 := ROUND((VarAge / 365.2364), 1, '<');  //Returns number of years old as Decimal - Takes into Account Leap Years
                    ObjMemberII.Age := format(VarAge2);
                    ObjMemberII.Modify;
                end;
                FnRunGetMemberAgeBracket;
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
                field("As At"; AsAt)
                {
                    ApplicationArea = Basic;
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
        "Var<18Count": Integer;
        "Var<18%": Decimal;
        "Var18<24Count": Integer;
        "Var18<24%": Decimal;
        "Var25<34Count": Integer;
        "Var25<34%": Decimal;
        "Var35<44Count": Integer;
        "Var35<44%": Decimal;
        "Var45<54Count": Integer;
        "Var45<54%": Decimal;
        "Var55<64Count": Integer;
        "Var55<64%": Decimal;
        "Var65<74Count": Integer;
        "Var65<74%": Decimal;
        "Var>75Count": Integer;
        "Var>75%": Decimal;
        ObjMembers: Record Customer;
        CurrReport_PAGENOCaptionLbl: label 'Page';
        RISK_CLASSIFICATION_OF_ASSETS_AND_PROVISIONINGCaptionLbl: label 'RISK CLASSIFICATION OF ASSETS AND PROVISIONING';
        FORM_4CaptionLbl: label 'FORM 4';
        SASRA_2_004CaptionLbl: label 'SASRA 2/004';
        R__46_CaptionLbl: label 'R.(46)';
        ObjMemberII: Record Customer;
        VarAge: Integer;
        VarAge2: Integer;

    local procedure FnRunGetMemberAgeBracket()
    begin
        /*
        ObjGensetup.Get();
        //======================================================== Less than 18
        ObjMembers.Reset;
        ObjMembers.SetFilter(ObjMembers.Age, '<%1', 18);
        if ObjMembers.FindSet then begin
            ObjGensetup.CalcFields("Total Membership");
            "Var<18Count" := ObjMembers.Count;
            "Var<18%" := ("Var<18Count" / ObjGensetup."Total Membership") * 100;
        end;
        //========================================================18 to 24
        ObjMembers.Reset;
        ObjMembers.SetFilter(ObjMembers.Age, '>=%1&<=%2', 18, 24);
        if ObjMembers.FindSet then begin
            ObjGensetup.CalcFields("Total Membership");
            "Var18<24Count" := ObjMembers.Count;
            "Var18<24%" := ("Var18<24Count" / ObjGensetup."Total Membership") * 100;
        end;
        //========================================================25 to 34
        ObjMembers.Reset;
        ObjMembers.SetFilter(ObjMembers.Age, '>=%1&<=%2', 25, 34);
        if ObjMembers.FindSet then begin
            ObjGensetup.CalcFields("Total Membership");
            "Var25<34Count" := ObjMembers.Count;
            "Var25<34%" := ("Var25<34Count" / ObjGensetup."Total Membership") * 100;
        end;
        //========================================================35 to 44
        ObjMembers.Reset;
        ObjMembers.SetFilter(ObjMembers.Age, '>=%1&<=%2', 35, 44);
        if ObjMembers.FindSet then begin
            ObjGensetup.CalcFields("Total Membership");
            "Var35<44Count" := ObjMembers.Count;
            "Var35<44%" := ("Var35<44Count" / ObjGensetup."Total Membership") * 100;
        end;
        //========================================================45 to 54
        ObjMembers.Reset;
        ObjMembers.SetFilter(ObjMembers.Age, '>=%1&<=%2', 45, 54);
        if ObjMembers.FindSet then begin
            ObjGensetup.CalcFields("Total Membership");
            "Var45<54Count" := ObjMembers.Count;
            "Var45<54%" := ("Var45<54Count" / ObjGensetup."Total Membership") * 100;
        end;
        //========================================================55 to 64
        ObjMembers.Reset;
        ObjMembers.SetFilter(ObjMembers.Age, '>=%1&<=%2', 55, 64);
        if ObjMembers.FindSet then begin
            ObjGensetup.CalcFields("Total Membership");
            "Var55<64Count" := ObjMembers.Count;
            "Var55<64%" := ("Var55<64Count" / ObjGensetup."Total Membership") * 100;
        end;
        //========================================================65 to 74
        ObjMembers.Reset;
        ObjMembers.SetFilter(ObjMembers.Age, '>=%1&<=%2', 65, 74);
        if ObjMembers.FindSet then begin
            ObjGensetup.CalcFields("Total Membership");
            "Var65<74Count" := ObjMembers.Count;
            "Var65<74%" := ("Var65<74Count" / ObjGensetup."Total Membership") * 100;
        end;
        //========================================================75 and Above
        ObjMembers.Reset;
        ObjMembers.SetFilter(ObjMembers.Age, '>=%1', 75);
        if ObjMembers.FindSet then begin
            ObjGensetup.CalcFields("Total Membership");
            "Var>75Count" := ObjMembers.Count;
            "Var>75%" := ("Var>75Count" / ObjGensetup."Total Membership") * 100;
        end;
        */
    end;

    local procedure FnRunUpdateMemberAge()
    begin
    end;

    // --> Reports ForNAV Autogenerated code - do not delete or modify
    //51516328_v6_3_0_2259;






    // Reports ForNAV Autogenerated code - do not delete or modify -->
}
