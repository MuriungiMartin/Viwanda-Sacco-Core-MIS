Report 50545 "Send P9 Report Via Mail"
{
    RDLCLayout = 'Layouts/SendP9ReportViaMail.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Payroll Employee."; "Payroll Employee.")
        {
            RequestFilterFields = "No.";
            column(No; "Payroll Employee."."No.")
            {
            }
            trigger OnAfterGetRecord();
            begin
                ObjPayrollEmployee.Reset;
                ObjPayrollEmployee.SetRange(ObjPayrollEmployee."No.", "No.");
                if ObjPayrollEmployee.FindSet then begin
                    SMTPSetup.Get();
                    VarEmployeeEmail := Lowercase(ObjPayrollEmployee."Employee Email");
                    Filename := '';
                    Filename := SMTPSetup."Path to Save Report" + 'P9Report.pdf';
                    Report.SaveAsPdf(Report::"P9Report Send Via Mail", Filename, ObjPayrollEmployee);
                    VarP9Year := Date2dmy(CalcDate('-1Y', WorkDate), 3);
                    VarEmployeeName := SurestepFactory.FnConvertTexttoBeginingWordstostartWithCapital(Firstname);
                    VarEmailSubject := 'P9 Report For the Year - ' + Format(VarP9Year);
                    VarEmailBody := 'Kindly find attached your P9 Report for the year ' + Format(VarP9Year) + '.';
                    SurestepFactory.FnSendStatementViaMail(VarEmployeeName, VarEmailSubject, VarEmailBody, VarEmployeeEmail, 'P9Report.pdf', '');
                end;
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
        Filename: Text[100];
        SMTPSetup: Record "SMTP Mail Setup";
        SMTPMail: Codeunit "SMTP Mail";
        SalCard: Record "Payroll Employee.";
        Attachment: Text[250];
        EmpEmail: Text;
        HrEmps: Record "Salary Processing Header";
        objPeriod: Record "Payroll Calender.";
        SelectedPeriod: Date;
        Contracttype: Option Contract;
        Emps: Record "Payroll Employee.";
        VarEmployeeEmail: Text;
        VarEmployeeName: Text;
        SurestepFactory: Codeunit "SURESTEP Factory";
        VarEmailSubject: Text;
        VarEmailBody: Text;
        ObjPayrollEmployees: Record "Payroll Employee.";
        varPayrollPeriod: Date;
        ObjPayrollEmployee: Record "Payroll Employee.";
        VarP9Year: Integer;

    var
}
