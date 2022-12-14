#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
//51516288_v6_3_0_2259) { }
// Autogenerated code - do not delete or modify -->

Report 50288 "Accounts Dormancy Report"
{
    RDLCLayout = 'Layouts/AccountsDormancyReport.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Accounts Dormancy Status"; "Accounts Dormancy Status")
        {
            PrintOnlyIfDetail = false;
            RequestFilterFields = "Effect Date";
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
            column(EntryNo_AccountsDormancyStatus; "Accounts Dormancy Status"."Entry No")
            {
            }
            column(EffectDate_AccountsDormancyStatus; Format("Accounts Dormancy Status"."Effect Date", 0, '<Day,2> <Month Text,3> <Year4>'))
            {
            }
            column(StatusPreChange_AccountsDormancyStatus; "Accounts Dormancy Status"."Status Pre_Change")
            {
            }
            column(StatusPostChange_AccountsDormancyStatus; "Accounts Dormancy Status"."Status Post_Change")
            {
            }
            column(AccountNo_AccountsDormancyStatus; "Accounts Dormancy Status"."Account No")
            {
            }
            column(AccountName_AccountsDormancyStatus; "Accounts Dormancy Status"."Account Name")
            {
            }
            trigger OnAfterGetRecord();
            begin
                VarAmountinArrears := 0;
                VarCount := VarCount + 1;
                /*IF ObjCust.GET("Client Code") THEN
				  BEGIN
					ObjCust.CALCFIELDS(ObjCust."Current Shares",ObjCust."Shares Retained");
					VarDepositsBal:=ObjCust."Current Shares";
					VarShareCapitalBal:=ObjCust."Shares Retained";
					END;*/

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
        VarDepositsBal: Decimal;
        VarShareCapitalBal: Decimal;
        ObjCust: Record Customer;

    // --> Reports ForNAV Autogenerated code - do not delete or modify
    //51516288_v6_3_0_2259;






    // Reports ForNAV Autogenerated code - do not delete or modify -->
}
