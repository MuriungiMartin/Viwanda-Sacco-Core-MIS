#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
//50020_v6_3_0_2259) { }
// Autogenerated code - do not delete or modify -->

Report 50630 "Update Account Agents"
{
    RDLCLayout = 'Layouts/UpdateAccountAgents.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Account Agent Details Buffer"; "Account Agent Details Buffer")
        {
            column(ReportForNavId_1; 1) { } // Autogenerated by ForNav - Do not delete
            trigger OnAfterGetRecord();
            var
                VarEntry: Code[30];
            begin
                ObjAcccountAgent.Init;
                ObjAcccountAgent."Account No" := "Account Agent Details Buffer"."Account No";
                ObjAcccountAgent."BOSA No." := "Account Agent Details Buffer"."Member No";
                ObjAcccountAgent.Names := "Account Agent Details Buffer"."Member Name";
                ObjAcccountAgent."Date Of Birth" := "Account Agent Details Buffer"."Date of Birth";
                ObjAcccountAgent."ID No." := "Account Agent Details Buffer"."ID No";
                ObjAcccountAgent."Mobile No." := "Account Agent Details Buffer"."Mobile No";
                ObjAcccountAgent."Withdrawal Limit" := "Account Agent Details Buffer"."Withdrawal Limit";
                ObjAcccountAgent."Operation Instruction" := "Account Agent Details Buffer".Instructions;
                ObjAcccountAgent."Allow Cheque Processing" := "Account Agent Details Buffer"."Can Draw Cheque";
                ObjAcccountAgent."Allowed  Correspondence" := "Account Agent Details Buffer"."Allow Correspondence";
                ObjAcccountAgent."Allowed Balance Enquiry" := "Account Agent Details Buffer"."Allow Balance Enquiry";
                ObjAcccountAgent."Allowed FOSA Withdrawals" := "Account Agent Details Buffer"."Allow FOSA Withdrawal";
                ObjAcccountAgent."Allowed Loan Processing" := "Account Agent Details Buffer"."Can Process Loan";
                ObjAcccountAgent.Insert;
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
        SFactory: Codeunit "SURESTEP Factory";
        ObjAccount: Record Vendor;
        ObjCollateralMov: Record "Collateral Movement  Register";
        ObjAcccountAgent: Record "Account Agent Details";

    // --> Reports ForNAV Autogenerated code - do not delete or modify
    //50020_v6_3_0_2259;






    // Reports ForNAV Autogenerated code - do not delete or modify -->
}
