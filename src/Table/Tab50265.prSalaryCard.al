#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50265 "prSalary Card"
{

    fields
    {
        field(1; "Employee Code"; Code[20])
        {
            TableRelation = "HR Employees"."No.";
        }
        field(2; "Basic Pay"; Decimal)
        {

            trigger OnValidate()
            begin
                /*objPeriod.RESET;
                objPeriod.SETRANGE(objPeriod.Closed,FALSE);
                IF objPeriod.FIND('-') THEN;
                SelectedPeriod:=objPeriod."Date Opened";
                
                //  IF "Basic Pay"<>xRec."Basic Pay" THEN BEGIN
                  IF "Pays NSSF"=FALSE THEN BEGIN
                  prTrans.RESET;
                  prTrans.SETRANGE(prTrans."coop parameters",prTrans."coop parameters"::Pension);
                  IF prTrans.FIND('-') THEN BEGIN
                  prEmpTran.RESET;
                  prEmpTran.SETRANGE(prEmpTran."Employee Code","Employee Code");
                  prEmpTran.SETRANGE(prEmpTran."Transaction Code",prTrans."Transaction Code");
                  prEmpTran.SETRANGE(prEmpTran."Payroll Period",SelectedPeriod);
                  IF prEmpTran.FIND('-') THEN BEGIN
                  prEmpTran.Amount:="Basic Pay"*(10/100);
                  prEmpTran.MODIFY;
                  END;
                  END;
                  END;
                 */

            end;
        }
        field(3; "Payment Mode"; Option)
        {
            Description = 'Bank Transfer,Cheque,Cash,SACCO';
            OptionMembers = " ","Bank Transfer",Cheque,Cash,FOSA;
        }
        field(4; Currency; Code[20])
        {
            // TableRelation = Table39003987.Field1;
        }
        field(5; "Pays NSSF"; Boolean)
        {

            trigger OnValidate()
            begin
                /*objPeriod.RESET;
                objPeriod.SETRANGE(objPeriod.Closed,FALSE);
                IF objPeriod.FIND('-') THEN;
                SelectedPeriod:=objPeriod."Date Opened";
                
                //  IF "Basic Pay"<>xRec."Basic Pay" THEN BEGIN
                  IF "Pays NSSF"=FALSE THEN BEGIN
                  prTrans.RESET;
                  prTrans.SETRANGE(prTrans."coop parameters",prTrans."coop parameters"::Pension);
                  IF prTrans.FIND('-') THEN BEGIN
                  prEmpTran.RESET;
                  prEmpTran.SETRANGE(prEmpTran."Employee Code","Employee Code");
                  prEmpTran.SETRANGE(prEmpTran."Transaction Code",prTrans."Transaction Code");
                  prEmpTran.SETRANGE(prEmpTran."Payroll Period",SelectedPeriod);
                  IF NOT prEmpTran.FIND('-') THEN BEGIN
                  prEmpTran2.INIT;
                  prEmpTran2."Employee Code":="Employee Code";
                  prEmpTran2."Transaction Code":=prTrans."Transaction Code";
                  prEmpTran2."Period Month":=objPeriod."Period Month";
                  prEmpTran2."Period Year":=objPeriod."Period Year";
                  prEmpTran2."Payroll Period":=objPeriod."Date Opened";
                  prEmpTran2."Transaction Name":=prTrans."Transaction Name";
                  prEmpTran2.Amount:="Basic Pay"*(10/100);
                  prEmpTran2.INSERT;
                  END;
                  END;
                  END;
                  */

            end;
        }
        field(6; "Pays NHIF"; Boolean)
        {
        }
        field(7; "Pays PAYE"; Boolean)
        {
        }
        field(8; "Payslip Message"; Text[100])
        {
        }
        field(9; "Cumm BasicPay"; Decimal)
        {
            CalcFormula = sum("prEmployee P9 Info"."Basic Pay" where("Employee Code" = field("Employee Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(10; "Cumm GrossPay"; Decimal)
        {
            CalcFormula = sum("prEmployee P9 Info"."Gross Pay" where("Employee Code" = field("Employee Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(11; "Cumm NetPay"; Decimal)
        {
            CalcFormula = sum("prEmployee P9 Info"."Net Pay" where("Employee Code" = field("Employee Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(12; "Cumm Allowances"; Decimal)
        {
            CalcFormula = sum("prPeriod Transactions".Amount where("Group Order" = filter(3),
                                                                    "Sub Group Order" = filter(0),
                                                                    "Employee Code" = field("Employee Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(13; "Cumm Deductions"; Decimal)
        {
            CalcFormula = sum("prPeriod Transactions".Amount where("Group Order" = filter(8),
                                                                    "Sub Group Order" = filter(0 | 1),
                                                                    "Employee Code" = field("Employee Code"),
                                                                    "Transaction Code" = filter(<> 'Total Deductions')));
            Editable = false;
            FieldClass = FlowField;
        }
        field(14; "Suspend Pay"; Boolean)
        {
        }
        field(15; "Suspension Date"; Date)
        {
        }
        field(16; "Suspension Reasons"; Text[200])
        {
        }
        field(17; "Period Filter"; Date)
        {
            FieldClass = FlowFilter;
            TableRelation = "prPayroll Periods"."Date Opened";
        }
        field(18; Exists; Boolean)
        {
        }
        field(19; "Cumm PAYE"; Decimal)
        {
            CalcFormula = sum("prPeriod Transactions".Amount where("Transaction Code" = filter('PAYE'),
                                                                    "Employee Code" = field("Employee Code")));
            FieldClass = FlowField;
        }
        field(20; "Cumm NSSF"; Decimal)
        {
            CalcFormula = sum("prPeriod Transactions".Amount where("Transaction Code" = filter('NSSF'),
                                                                    "Employee Code" = field("Employee Code")));
            FieldClass = FlowField;
        }
        field(21; "Cumm Pension"; Decimal)
        {
            CalcFormula = sum("prPeriod Transactions".Amount where("Transaction Code" = filter('D0005'),
                                                                    "Employee Code" = field("Employee Code")));
            FieldClass = FlowField;
        }
        field(22; "Cumm HELB"; Decimal)
        {
            CalcFormula = sum("prPeriod Transactions".Amount where("Employee Code" = field("Employee Code"),
                                                                    "Transaction Code" = filter('320')));
            FieldClass = FlowField;
        }
        field(23; "Cumm NHIF"; Decimal)
        {
            CalcFormula = sum("prPeriod Transactions".Amount where("Employee Code" = field("Employee Code"),
                                                                    "Transaction Code" = filter('NHIF')));
            FieldClass = FlowField;
        }
        field(24; "Bank Account Number"; Code[50])
        {
        }
        field(25; "Bank Branch"; Code[50])
        {
        }
        field(26; "Employee's Bank"; Code[50])
        {
        }
        field(27; "Posting Group"; Code[20])
        {
            NotBlank = false;
            TableRelation = Employee;
        }
        field(28; "Cumm Employer Pension"; Decimal)
        {
            CalcFormula = sum("prPeriod Transactions".Amount where("Transaction Code" = filter('D0005'),
                                                                    "Employee Code" = field("Employee Code")));
            FieldClass = FlowField;
        }
        field(29; "Pays Pension"; Boolean)
        {
        }
        field(30; "Gratuity %"; Code[20])
        {
        }
        field(31; "Gratuity Amount"; Decimal)
        {
        }
        field(32; Gratuity; Integer)
        {
        }
        field(33; "Fosa Accounts"; Code[50])
        {
            TableRelation = Vendor."No.";
        }
        field(34; "Sacco Paying Bank"; Code[20])
        {
            CalcFormula = lookup("HR Employees"."Sacco Paying Bank Code" where("No." = field("Employee Code")));
            FieldClass = FlowField;
        }
        field(35; "Cheque No"; Code[20])
        {
            CalcFormula = lookup("HR Employees"."Cheque No" where("No." = field("Employee Code")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Employee Code")
        {
            Clustered = true;
            SumIndexFields = "Basic Pay";
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        Error('Delete not allowed');
    end;

    var
        Employee: Record "HR Employees";
        HREmp: Record "HR Employees";
}

