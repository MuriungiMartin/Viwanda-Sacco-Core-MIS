#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
//51516069_v6_3_0_2259) { }
// Autogenerated code - do not delete or modify -->

Report 50069 "New Accounts Summary"
{
    RDLCLayout = 'Layouts/NewAccountsSummary.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Account Types-Saving Products"; "Account Types-Saving Products")
        {
            RequestFilterFields = "Date Filter";
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
            column(VarEntryNo; VarEntryNo)
            {
            }
            column(NoofAccounts_AccountTypesSavingProducts; "Account Types-Saving Products"."No of Accounts")
            {
            }
            column(TotalProductBalance_AccountTypesSavingProducts; "Account Types-Saving Products"."Total Product Balance")
            {
            }
            column(Code_AccountTypesSavingProducts; "Account Types-Saving Products".Code)
            {
            }
            column(VarAccountTypeBalance; VarAccountTypeBalance * -1)
            {
            }
            column(Description_AccountTypesSavingProducts; "Account Types-Saving Products".Description)
            {
            }
            column(VarReportDate; Format(VarReportDate, 0, '<Day,2> <Month Text,3> <Year4>'))
            {
            }
            trigger OnPreDataItem();
            begin
                Company.Get();
                Company.CalcFields(Company.Picture);
            end;

            trigger OnAfterGetRecord();
            begin
                "Account Types-Saving Products".CalcFields("Account Types-Saving Products"."No of Accounts");
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
                field(VarReportDate; VarReportDate)
                {
                    ApplicationArea = Basic;
                    Caption = 'As At';
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
        Company: Record "Company Information";
        SFactory: Codeunit "SURESTEP Factory";
        ObjGensetup: Record "Sacco General Set-Up";
        CurrReport_PAGENOCaptionLbl: label 'Page';
        RISK_CLASSIFICATION_OF_ASSETS_AND_PROVISIONINGCaptionLbl: label 'RISK CLASSIFICATION OF ASSETS AND PROVISIONING';
        FORM_4CaptionLbl: label 'FORM 4';
        SASRA_2_004CaptionLbl: label 'SASRA 2/004';
        R__46_CaptionLbl: label 'R.(46)';
        ObjMembers: Record Customer;
        VarEntryNo: Integer;
        ObjDetailedVendLedger: Record "Detailed Vendor Ledg. Entry";
        VarReportDate: Date;
        VarLedgerDateFilter: Text;
        VarAccountTypeBalance: Decimal;

    // --> Reports ForNAV Autogenerated code - do not delete or modify
    //51516069_v6_3_0_2259;






    // Reports ForNAV Autogenerated code - do not delete or modify -->
}
