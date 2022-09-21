#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
//51516051_v6_3_0_2259) { }
// Autogenerated code - do not delete or modify -->

Report 50051 "Loans Eligible For Offset"
{
    RDLCLayout = 'Layouts/LoansEligibleForOffset.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Loans Register"; "Loans Register")
        {
            DataItemTableView = where("Outstanding Balance" = filter(> 0));
            PrintOnlyIfDetail = false;
            RequestFilterFields = "Loan  No.", "Loan Product Type", "Client Code", "Issued Date";
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
            column(VarCount; VarCount)
            {
            }
            column(OffsetEligibilityAmount_LoansRegister; "Loans Register"."Offset Eligibility Amount")
            {
            }
            column(OutstandingBalance_LoansRegister; "Loans Register"."Outstanding Balance")
            {
            }
            column(LoanStatus_LoansRegister; "Loans Register"."Loan Status")
            {
            }
            column(IssuedDate_LoansRegister; Format("Loans Register"."Issued Date", 0, '<Day,2> <Month Text,3> <Year4>'))
            {
            }
            column(Installments_LoansRegister; "Loans Register".Installments)
            {
            }
            column(ClientName_LoansRegister; "Loans Register"."Client Name")
            {
            }
            column(LoanNo_LoansRegister; "Loans Register"."Loan  No.")
            {
            }
            column(ApplicationDate_LoansRegister; "Loans Register"."Application Date")
            {
            }
            column(LoanProductType_LoansRegister; "Loans Register"."Loan Product Type")
            {
            }
            column(ClientCode_LoansRegister; "Loans Register"."Client Code")
            {
            }
            column(ApprovedAmount_LoansRegister; "Loans Register"."Approved Amount")
            {
            }
            column(VarEligible; VarEligible)
            {
            }
            trigger OnAfterGetRecord();
            begin
                "Loans Register".CalcFields("Loans Register"."Outstanding Balance");
                VarEligible := false;
                if "Loans Register"."Outstanding Balance" <= "Loans Register"."Offset Eligibility Amount" then
                    VarEligible := true;
                VarAmountinArrears := 0;
                VarCount := VarCount + 1;
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
        Company.Get();
        Company.CalcFields(Company.Picture);
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
        VarAmountinArrears: Decimal;
        ObjRepaymentSchedule: Record "Loan Repayment Schedule";
        VarCount: Integer;
        VarEligible: Boolean;

    // --> Reports ForNAV Autogenerated code - do not delete or modify
    //51516051_v6_3_0_2259;






    // Reports ForNAV Autogenerated code - do not delete or modify -->
}
