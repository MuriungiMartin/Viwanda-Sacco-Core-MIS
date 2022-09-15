
Report 50508 "Member Accounts  Sum By Branch"
{
    RDLCLayout = 'Layouts/MemberAccountsSumByBranch.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Member A/C  Summary By Branch"; "Member A/C  Summary By Branch")
        {
            RequestFilterFields = "Registration Date Filter", "Product Filter";

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
            column(VarEntryNo; VarEntryNo)
            {
            }
            column(BranchCode_MemberACSummaryByBranch; "Member A/C  Summary By Branch"."Branch Code")
            {
            }
            column(ActiveAccounts_MemberACSummaryByBranch; "Member A/C  Summary By Branch"."Active Accounts")
            {
            }
            column(ClosedAccounts_MemberACSummaryByBranch; "Member A/C  Summary By Branch"."Closed Accounts")
            {
            }
            column(DormantAccounts_MemberACSummaryByBranch; "Member A/C  Summary By Branch"."Dormant Accounts")
            {
            }
            column(FrozenAccounts_MemberACSummaryByBranch; "Member A/C  Summary By Branch"."Frozen Accounts")
            {
            }
            column(DeceasedAccounts_MemberACSummaryByBranch; "Member A/C  Summary By Branch"."Deceased Accounts")
            {
            }
            column(TotalAccounts_MemberACSummaryByBranch; "Member A/C  Summary By Branch"."Total Accounts")
            {
            }
            column(RegistrationDateFilter_MemberACSummaryByBranch; "Member A/C  Summary By Branch"."Registration Date Filter")
            {
            }
            column(VarDateFilter; VarDateFilter)
            {
            }
            column(VarProductFilter; VarProductFilter)
            {
            }
            trigger OnPreDataItem();
            begin
                Company.Get();
                Company.CalcFields(Company.Picture);
                VarDateFilter := "Member A/C  Summary By Branch".GetFilter("Member A/C  Summary By Branch"."Registration Date Filter");
                VarProductFilter := "Member A/C  Summary By Branch".GetFilter("Member A/C  Summary By Branch"."Product Filter");
            end;

            trigger OnAfterGetRecord();
            begin
                VarEntryNo := VarEntryNo + 1;
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
        AsAt: Date;
        Company: Record "Company Information";
        SFactory: Codeunit "SURESTEP Factory";
        ObjGensetup: Record "Sacco General Set-Up";
        CurrReport_PAGENOCaptionLbl: label 'Page';
        RISK_CLASSIFICATION_OF_ASSETS_AND_PROVISIONINGCaptionLbl: label 'RISK CLASSIFICATION OF ASSETS AND PROVISIONING';
        FORM_4CaptionLbl: label 'FORM 4';
        SASRA_2_004CaptionLbl: label 'SASRA 2/004';
        R__46_CaptionLbl: label 'R.(46)';
        ObjMembers: Record Customer;
        VarActiveCount: Integer;
        VarActivePercentage: Decimal;
        VarAwaitingExitCount: Integer;
        VarAwaitingExitPercentage: Decimal;
        VarExitedCount: Integer;
        VarExitedPercentage: Decimal;
        VarDormantCount: Integer;
        VarDormantPercentage: Decimal;
        VarDeceasedCount: Integer;
        VarDeceasedPercentage: Decimal;
        VarEntryNo: Integer;
        VarDateFilter: Text;
        VarProductFilter: Text;


    var
}