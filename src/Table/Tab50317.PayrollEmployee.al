#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50317 "Payroll Employee."
{

    fields
    {
        field(10; "No."; Code[20])
        {
            Editable = true;
        }
        field(11; Surname; Text[30])
        {
        }
        field(12; Firstname; Text[30])
        {
        }
        field(13; Lastname; Text[30])
        {
        }
        field(14; "Joining Date"; Date)
        {
        }
        field(15; "Currency Code"; Code[20])
        {
            TableRelation = Currency.Code;
        }
        field(16; "Currency Factor"; Decimal)
        {
        }
        field(17; "Global Dimension 1"; Code[20])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1),
                                                          "Dimension Value Type" = const(Standard));
        }
        field(18; "Global Dimension 2"; Code[20])
        {
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2),
                                                          "Dimension Value Type" = const(Standard));
        }
        field(19; "Shortcut Dimension 3"; Code[20])
        {
            CaptionClass = '1,2,3';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3));
        }
        field(20; "Shortcut Dimension 4"; Code[20])
        {
            CaptionClass = '1,2,4';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(4));
        }
        field(21; "Shortcut Dimension 5"; Code[20])
        {
            CaptionClass = '1,2,5';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(5));
        }
        field(22; "Shortcut Dimension 6"; Code[20])
        {
            CaptionClass = '1,2,6';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(6));
        }
        field(23; "Shortcut Dimension 7"; Code[20])
        {
            CaptionClass = '1,2,7';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(7));
        }
        field(24; "Shortcut Dimension 8"; Code[20])
        {
            CaptionClass = '1,2,8';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(8));
        }
        field(25; "Basic Pay"; Decimal)
        {

            trigger OnValidate()
            begin
                if "Currency Code" = '' then
                    "Basic Pay(LCY)" := "Basic Pay"
                else
                    "Basic Pay(LCY)" := ROUND(CurrExchRate.ExchangeAmtFCYToLCY(Today, "Currency Code", "Basic Pay", "Currency Factor"));
            end;
        }
        field(26; "Basic Pay(LCY)"; Decimal)
        {
        }
        field(27; "Cummulative Basic Pay"; Decimal)
        {
            CalcFormula = sum("prPeriod Transactions.".Amount where("Transaction Code" = filter('BPAY'),
                                                                     "Employee Code" = field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(28; "Cummulative Gross Pay"; Decimal)
        {
            CalcFormula = sum("prPeriod Transactions.".Amount where("Transaction Code" = filter('GPAY'),
                                                                     "Employee Code" = field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(29; "Cummulative Allowances"; Decimal)
        {
            CalcFormula = sum("prPeriod Transactions.".Amount where("Transaction Code" = filter('E001' | 'E003'),
                                                                     "Employee Code" = field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(30; "Cummulative Deductions"; Decimal)
        {
            CalcFormula = sum("prPeriod Transactions.".Amount where("Transaction Code" = filter('TOT-DED'),
                                                                     "Employee Code" = field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(31; "Cummulative Net Pay"; Decimal)
        {
            CalcFormula = sum("prPeriod Transactions.".Amount where("Transaction Code" = filter('NPAY'),
                                                                     "Employee Code" = field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(32; "Cummulative PAYE"; Decimal)
        {
            CalcFormula = sum("prPeriod Transactions.".Amount where("Transaction Code" = filter('PAYE'),
                                                                     "Employee Code" = field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(33; "Cummulative NSSF"; Decimal)
        {
            CalcFormula = sum("prPeriod Transactions.".Amount where("Transaction Code" = filter('NSSF'),
                                                                     "Employee Code" = field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(34; "Cummulative Pension"; Decimal)
        {
            CalcFormula = sum("prPeriod Transactions.".Amount where("Transaction Code" = filter('D022'),
                                                                     "Employee Code" = field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(35; "Cummulative HELB"; Decimal)
        {
            CalcFormula = sum("prPeriod Transactions.".Amount where("Transaction Code" = filter('HELB'),
                                                                     "Employee Code" = field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(36; "Cummulative NHIF"; Decimal)
        {
            CalcFormula = sum("prPeriod Transactions.".Amount where("Transaction Code" = filter('NHIF'),
                                                                     "Employee Code" = field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(37; "Cummulative Employer Pension"; Decimal)
        {
        }
        field(38; "Cummulative TopUp"; Decimal)
        {
        }
        field(39; "Cummulative Basic Pay(LCY)"; Decimal)
        {
            Editable = false;
        }
        field(40; "Cummulative Gross Pay(LCY)"; Decimal)
        {
            Editable = false;
        }
        field(41; "Cummulative Allowances(LCY)"; Decimal)
        {
            Editable = false;
        }
        field(42; "Cummulative Deductions(LCY)"; Decimal)
        {
            Editable = false;
        }
        field(43; "Cummulative Net Pay(LCY)"; Decimal)
        {
            Editable = false;
        }
        field(44; "Cummulative PAYE(LCY)"; Decimal)
        {
        }
        field(45; "Cummulative NSSF(LCY)"; Decimal)
        {
        }
        field(46; "Cummulative Pension(LCY)"; Decimal)
        {
        }
        field(47; "Cummulative HELB(LCY)"; Decimal)
        {
        }
        field(48; "Cummulative NHIF(LCY)"; Decimal)
        {
        }
        field(49; "Cumm Employer Pension(LCY)"; Decimal)
        {
        }
        field(50; "Cummulative TopUp(LCY)"; Decimal)
        {
        }
        field(51; "Non Taxable"; Decimal)
        {

            trigger OnValidate()
            begin
                if "Currency Code" = '' then
                    "Non Taxable(LCY)" := "Non Taxable"
                else
                    "Non Taxable(LCY)" := ROUND(CurrExchRate.ExchangeAmtFCYToLCY(Today, "Currency Code", "Non Taxable", "Currency Factor"));
            end;
        }
        field(52; "Non Taxable(LCY)"; Decimal)
        {
        }
        field(53; "Posting Group"; Code[20])
        {
            TableRelation = "Payroll Posting Groups."."Posting Code";
        }
        field(54; "Payment Mode"; Option)
        {
            OptionCaption = 'Bank Transfer,Cheque,Cash,SACCO';
            OptionMembers = "Bank Transfer",Cheque,Cash,SACCO;
        }
        field(55; "Pays PAYE"; Boolean)
        {
        }
        field(56; "Pays NSSF"; Boolean)
        {
        }
        field(57; "Pays NHIF"; Boolean)
        {
        }
        field(58; "Bank Code"; Code[20])
        {

            trigger OnValidate()
            begin
                BankCodes.Reset;
                BankCodes.SetRange(BankCodes."Bank Code", "Bank Code");
                if BankCodes.FindFirst then begin
                    BankCodes.TestField(BankCodes."Bank Name");
                    "Bank Name" := BankCodes."Bank Name";
                end;
            end;
        }
        field(59; "Bank Name"; Text[100])
        {
        }
        field(60; "Branch Code"; Code[20])
        {

            trigger OnValidate()
            begin
                BankBranches.Reset;
                BankBranches.SetRange(BankBranches."Bank Code", "Bank Code");
                BankBranches.SetRange(BankBranches."Branch Code", "Branch Code");
                if BankBranches.FindFirst then begin
                    BankBranches.TestField(BankBranches."Branch Name");
                    "Branch Name" := BankBranches."Branch Name";
                end;
            end;
        }
        field(61; "Branch Name"; Text[100])
        {
        }
        field(62; "Bank Account No"; Code[50])
        {
        }
        field(63; "Suspend Pay"; Boolean)
        {
        }
        field(64; "Suspend Date"; Date)
        {
        }
        field(65; "Suspend Reason"; Text[100])
        {
        }
        field(66; "Hourly Rate"; Decimal)
        {
        }
        field(67; Gratuity; Boolean)
        {
        }
        field(68; "Gratuity Percentage"; Decimal)
        {
        }
        field(69; "Gratuity Provision"; Decimal)
        {

            trigger OnValidate()
            begin
                if "Currency Code" = '' then
                    "Gratuity Provision(LCY)" := "Gratuity Provision"
                else
                    "Gratuity Provision(LCY)" := ROUND(CurrExchRate.ExchangeAmtFCYToLCY(Today, "Currency Code", "Gratuity Provision", "Currency Factor"));
            end;
        }
        field(70; "Gratuity Provision(LCY)"; Decimal)
        {
        }
        field(71; "Cummulative Gratuity"; Decimal)
        {
        }
        field(72; "Cummulative Gratuity(LCY)"; Decimal)
        {
        }
        field(73; "Days Absent"; Decimal)
        {
        }
        field(74; "Payslip Message"; Text[100])
        {
        }
        field(75; "Paid per Hour"; Boolean)
        {
        }
        field(76; "Full Name"; Text[90])
        {
        }
        field(77; Status; Option)
        {
            OptionCaption = 'Active,Inactive';
            OptionMembers = Active,Inactive;
        }
        field(78; "Date of Leaving"; Date)
        {
        }
        field(79; GetsPayeRelief; Boolean)
        {
        }
        field(80; GetsPayeBenefit; Boolean)
        {
        }
        field(81; Secondary; Boolean)
        {
        }
        field(82; PayeBenefitPercent; Decimal)
        {
        }
        field(83; "NSSF No"; Code[20])
        {
        }
        field(84; "NHIF No"; Code[20])
        {
        }
        field(85; "PIN No"; Code[20])
        {
        }
        field(86; Company; Option)
        {
            OptionCaption = 'RIRUTA,KIAMBU,KANGEMI,KISERIAN,NGONG,LIMURU,WANGIGE';
            OptionMembers = RIRUTA,KIAMBU,KANGEMI,KISERIAN,NGONG,LIMURU,WANGIGE;
        }
        field(87; "Current Month Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(88; "National ID No"; Code[20])
        {
        }
        field(89; "Employee Email"; Text[100])
        {
        }
        field(90; Department; Text[30])
        {
            TableRelation = "Loan Rescheduling";
        }
        field(91; "Job Group"; Code[50])
        {
        }
        field(92; Category; Option)
        {
            OptionCaption = ' ,Permanent, On Contract,Intern,Probation,Dismissed,Resigned,Retired,Retrenched,Termintaed,Deceased,Attachment';
            OptionMembers = " ",Permanent," On Contract",Intern,Probation,Dismissed,Resigned,Retired,Retrenched,Termintaed,Deceased,"Attachment>";
        }
        field(93; "Sacco Membership No."; Code[20])
        {
        }
        field(94; "Insurance Premium"; Decimal)
        {
        }
        field(95; "Payroll No"; Code[20])
        {
            TableRelation = Customer."No.";

            trigger OnValidate()
            begin
                if ObjCust.Get("Payroll No") then begin
                    Surname := ObjCust.Name;
                    "Employee Email" := ObjCust."E-Mail";
                    "National ID No" := ObjCust."ID No.";
                    "PIN No" := ObjCust.Pin;

                    ObjAccounts.Reset;
                    ObjAccounts.SetRange(ObjAccounts."BOSA Account No", "Payroll No");
                    ObjAccounts.SetRange(ObjAccounts."Account Type", '405');
                    if ObjAccounts.FindSet then begin
                        "Bank Account No" := ObjAccounts."No.";
                    end;

                end;
            end;
        }
        field(96; "Period Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(97; "Selected Period"; Date)
        {
        }
        field(98; "Loan Settlement Account"; Code[20])
        {
            TableRelation = Vendor."No." where("BOSA Account No" = field("Sacco Membership No."));
        }
        field(99; "Earns Leave Allowance"; Boolean)
        {

            trigger OnValidate()
            begin
                ObjPayrollCalender.Reset;
                ObjPayrollCalender.SetCurrentkey(ObjPayrollCalender."Date Opened");
                ObjPayrollCalender.SetRange(ObjPayrollCalender.Closed, false);
                if ObjPayrollCalender.FindLast then begin
                    VarOpenPeriod := ObjPayrollCalender."Date Opened";
                    VarPeriodMonth := Date2dmy(VarOpenPeriod, 2);
                    VarPeriodYear := Date2dmy(VarOpenPeriod, 3);
                end;


                if "Earns Leave Allowance" = true then begin
                    if Confirm('Confirm the Staff Earns Leave Allowance', false) = true then begin
                        FnRunGetLeaveAllowanceAmount("Sacco Membership No.", "No.");
                    end;
                end;

                if "Earns Leave Allowance" = false then begin
                    //============================================Delete Entries For the Same Period
                    ObjPayrollEmployeeTransII.Reset;
                    ObjPayrollEmployeeTransII.SetRange(ObjPayrollEmployeeTransII."No.", "No.");
                    ObjPayrollEmployeeTransII.SetRange(ObjPayrollEmployeeTransII."Transaction Code", 'E_0005');
                    ObjPayrollEmployeeTransII.SetRange(ObjPayrollEmployeeTransII."Payroll Period", VarOpenPeriod);
                    if ObjPayrollEmployeeTransII.FindSet then begin
                        ObjPayrollEmployeeTransII.DeleteAll;
                    end;
                end;
                //============================================Delete Entries For the Same Period
            end;
        }
        field(100; "Earns Acting Allowance"; Boolean)
        {

            trigger OnValidate()
            begin
                ObjPayrollCalender.Reset;
                ObjPayrollCalender.SetCurrentkey(ObjPayrollCalender."Date Opened");
                ObjPayrollCalender.SetRange(ObjPayrollCalender.Closed, false);
                if ObjPayrollCalender.FindLast then begin
                    VarOpenPeriod := ObjPayrollCalender."Date Opened";
                    VarPeriodMonth := Date2dmy(VarOpenPeriod, 2);
                    VarPeriodYear := Date2dmy(VarOpenPeriod, 3);
                end;


                if "Earns Acting Allowance" = true then begin
                    if Confirm('Confirm the Staff Earns Acting Allowance', false) = true then begin
                        FnRunGetActingAllowanceAmount("Sacco Membership No.", "No.");
                    end;
                end;

                if "Earns Acting Allowance" = false then begin
                    //============================================Delete Entries For the Same Period
                    ObjPayrollEmployeeTransII.Reset;
                    ObjPayrollEmployeeTransII.SetRange(ObjPayrollEmployeeTransII."No.", "No.");
                    ObjPayrollEmployeeTransII.SetRange(ObjPayrollEmployeeTransII."Transaction Code", 'E_0002');
                    ObjPayrollEmployeeTransII.SetRange(ObjPayrollEmployeeTransII."Payroll Period", VarOpenPeriod);
                    if ObjPayrollEmployeeTransII.FindSet then begin
                        ObjPayrollEmployeeTransII.DeleteAll;
                    end;
                end;
                //============================================Delete Entries For the Same Period
            end;
        }
        field(101; "Exit Staff"; Boolean)
        {

            trigger OnValidate()
            begin

                if Confirm('Confirm you want to exit this Staff', false) = true then begin
                    /*IF "Reason For Exiting Staff"='' THEN BEGIN
                      ERROR('Please Specify Reason for Exiting Staff!');
                      END;*/
                    "Date Exited" := WorkDate;
                    "Exited By" := UserId;
                    "Suspend Pay" := true;
                    "Suspend Reason" := "Reason For Exiting Staff";
                    "Suspend Date" := WorkDate;
                end;

            end;
        }
        field(102; "Date Exited"; Date)
        {
        }
        field(103; "Exited By"; Code[30])
        {
        }
        field(104; "Reason For Exiting Staff"; Text[100])
        {
        }
        field(105; "Managerial Position"; Boolean)
        {
        }
        field(106; "Last Payroll Period"; Date)
        {
        }
        field(107; "Pays Pension"; Boolean)
        {

            trigger OnValidate()
            begin
                ObjPayrollCalender.Reset;
                ObjPayrollCalender.SetCurrentkey(ObjPayrollCalender."Date Opened");
                ObjPayrollCalender.SetRange(ObjPayrollCalender.Closed, false);
                if ObjPayrollCalender.FindLast then begin
                    VarOpenPeriod := ObjPayrollCalender."Date Opened";
                    VarPeriodMonth := Date2dmy(VarOpenPeriod, 2);
                    VarPeriodYear := Date2dmy(VarOpenPeriod, 3);
                end;


                if "Pays Pension" = true then begin
                    if Confirm('Confirm the Staff Pays Pension', false) = true then begin
                        FnRunGetPensionAmount("Sacco Membership No.", "No.");
                    end;
                end;

                if "Pays Pension" = false then begin
                    //============================================Delete Entries For the Same Period
                    ObjPayrollEmployeeTransII.Reset;
                    ObjPayrollEmployeeTransII.SetRange(ObjPayrollEmployeeTransII."No.", "No.");
                    ObjPayrollEmployeeTransII.SetRange(ObjPayrollEmployeeTransII."Transaction Code", 'D_0007');
                    ObjPayrollEmployeeTransII.SetRange(ObjPayrollEmployeeTransII."Payroll Period", VarOpenPeriod);
                    if ObjPayrollEmployeeTransII.FindSet then begin
                        ObjPayrollEmployeeTransII.DeleteAll;
                    end;
                end;
                //============================================Delete Entries For the Same Period
            end;
        }
        field(108; "Pay Bonus"; Boolean)
        {
        }
        field(109; "Bonus Amount"; Decimal)
        {

            trigger OnValidate()
            begin
                ObjPayrollCalender.Reset;
                ObjPayrollCalender.SetCurrentkey(ObjPayrollCalender."Date Opened");
                ObjPayrollCalender.SetRange(ObjPayrollCalender.Closed, false);
                if ObjPayrollCalender.FindLast then begin
                    VarOpenPeriod := ObjPayrollCalender."Date Opened";
                    VarPeriodMonth := Date2dmy(VarOpenPeriod, 2);
                    VarPeriodYear := Date2dmy(VarOpenPeriod, 3);
                end;


                if "Bonus Amount" > 0 then begin
                    if Confirm('Confirm the Staff Earns Bonus', false) = true then begin
                        FnRunGetBonusAmount("Sacco Membership No.", "No.");
                    end;
                end;

                if "Bonus Amount" = 0 then begin
                    //============================================Delete Entries For the Same Period
                    ObjPayrollEmployeeTransII.Reset;
                    ObjPayrollEmployeeTransII.SetRange(ObjPayrollEmployeeTransII."No.", "No.");
                    ObjPayrollEmployeeTransII.SetRange(ObjPayrollEmployeeTransII."Transaction Code", 'E_0007');
                    ObjPayrollEmployeeTransII.SetRange(ObjPayrollEmployeeTransII."Payroll Period", VarOpenPeriod);
                    if ObjPayrollEmployeeTransII.FindSet then begin
                        ObjPayrollEmployeeTransII.DeleteAll;
                    end;
                end;
                //============================================Delete Entries For the Same Period
            end;
        }
        field(110; "Job Title"; Code[35])
        {
        }
        field(111; "Voluntary Deposit Contribution"; Decimal)
        {
        }
        field(112; "Pays Voluntary Pension"; Boolean)
        {
        }
        field(113; "Voluntary Pension Amount"; Decimal)
        {

            trigger OnValidate()
            begin
                ObjPayrollCalender.Reset;
                ObjPayrollCalender.SetCurrentkey(ObjPayrollCalender."Date Opened");
                ObjPayrollCalender.SetRange(ObjPayrollCalender.Closed, false);
                if ObjPayrollCalender.FindLast then begin
                    VarOpenPeriod := ObjPayrollCalender."Date Opened";
                    VarPeriodMonth := Date2dmy(VarOpenPeriod, 2);
                    VarPeriodYear := Date2dmy(VarOpenPeriod, 3);
                end;


                if "Voluntary Pension Amount" > 0 then begin
                    if Confirm('Confirm the Staff Contributes Voluntary Pension', false) = true then begin
                        FnRunGetVoluntaryPensionAmount("Sacco Membership No.", "No.");
                    end;
                end;

                if "Voluntary Pension Amount" = 0 then begin
                    //============================================Delete Entries For the Same Period
                    ObjPayrollEmployeeTransII.Reset;
                    ObjPayrollEmployeeTransII.SetRange(ObjPayrollEmployeeTransII."No.", "No.");
                    ObjPayrollEmployeeTransII.SetRange(ObjPayrollEmployeeTransII."Transaction Code", 'D_0008');
                    ObjPayrollEmployeeTransII.SetRange(ObjPayrollEmployeeTransII."Payroll Period", VarOpenPeriod);
                    if ObjPayrollEmployeeTransII.FindSet then begin
                        ObjPayrollEmployeeTransII.DeleteAll;
                    end;
                end;
                //============================================Delete Entries For the Same Period
            end;
        }
        field(115; "Salary Arrears Amount"; Decimal)
        {

            trigger OnValidate()
            begin
                ObjPayrollCalender.Reset;
                ObjPayrollCalender.SetCurrentkey(ObjPayrollCalender."Date Opened");
                ObjPayrollCalender.SetRange(ObjPayrollCalender.Closed, false);
                if ObjPayrollCalender.FindLast then begin
                    VarOpenPeriod := ObjPayrollCalender."Date Opened";
                    VarPeriodMonth := Date2dmy(VarOpenPeriod, 2);
                    VarPeriodYear := Date2dmy(VarOpenPeriod, 3);
                end;


                //============================================Delete Entries For the Same Period
                ObjPayrollEmployeeTransII.Reset;
                ObjPayrollEmployeeTransII.SetRange(ObjPayrollEmployeeTransII."No.", "No.");
                ObjPayrollEmployeeTransII.SetRange(ObjPayrollEmployeeTransII."Transaction Code", 'E_0006');
                ObjPayrollEmployeeTransII.SetRange(ObjPayrollEmployeeTransII."Payroll Period", VarOpenPeriod);
                if ObjPayrollEmployeeTransII.FindSet then begin
                    ObjPayrollEmployeeTransII.DeleteAll;
                end;
                //============================================Delete Entries For the Same Period



                if "Salary Arrears Amount" > 0 then begin
                    if Confirm('Confirm the Staff has a salary arrears', false) = true then begin
                        FnRunGetSalaryArrearsAmount("Sacco Membership No.", "No.");
                    end;
                end;
            end;
        }
        field(116; "EOY Amount"; Decimal)
        {

            trigger OnValidate()
            begin
                ObjPayrollCalender.Reset;
                ObjPayrollCalender.SetCurrentkey(ObjPayrollCalender."Date Opened");
                ObjPayrollCalender.SetRange(ObjPayrollCalender.Closed, false);
                if ObjPayrollCalender.FindLast then begin
                    VarOpenPeriod := ObjPayrollCalender."Date Opened";
                    VarPeriodMonth := Date2dmy(VarOpenPeriod, 2);
                    VarPeriodYear := Date2dmy(VarOpenPeriod, 3);
                end;


                if "EOY Amount" > 0 then begin
                    if Confirm('Confirm the Staff Earns EOY Appreciation', false) = true then begin
                        FnRunGetEOYAmount("Sacco Membership No.", "No.");
                    end;
                end;

                if "EOY Amount" = 0 then begin
                    //============================================Delete Entries For the Same Period
                    ObjPayrollEmployeeTransII.Reset;
                    ObjPayrollEmployeeTransII.SetRange(ObjPayrollEmployeeTransII."No.", "No.");
                    ObjPayrollEmployeeTransII.SetRange(ObjPayrollEmployeeTransII."Transaction Code", 'E_0009');
                    ObjPayrollEmployeeTransII.SetRange(ObjPayrollEmployeeTransII."Payroll Period", VarOpenPeriod);
                    if ObjPayrollEmployeeTransII.FindSet then begin
                        ObjPayrollEmployeeTransII.DeleteAll;
                    end;
                end;
                //============================================Delete Entries For the Same Period
            end;
        }
        field(117; MileageAllowance; Decimal)
        {

            trigger OnValidate()
            begin
                ObjPayrollCalender.Reset;
                ObjPayrollCalender.SetCurrentkey(ObjPayrollCalender."Date Opened");
                ObjPayrollCalender.SetRange(ObjPayrollCalender.Closed, false);
                if ObjPayrollCalender.FindLast then begin
                    VarOpenPeriod := ObjPayrollCalender."Date Opened";
                    VarPeriodMonth := Date2dmy(VarOpenPeriod, 2);
                    VarPeriodYear := Date2dmy(VarOpenPeriod, 3);
                end;


                if MileageAllowance > 0 then begin
                    if Confirm('Confirm the Staff Milleage Allowance', false) = true then begin
                        FnRunGetMileageAllowanceAmount("Sacco Membership No.", "No.");
                    end;
                end;

                if MileageAllowance = 0 then begin
                    //============================================Delete Entries For the Same Period
                    ObjPayrollEmployeeTransII.Reset;
                    ObjPayrollEmployeeTransII.SetRange(ObjPayrollEmployeeTransII."No.", "No.");
                    ObjPayrollEmployeeTransII.SetRange(ObjPayrollEmployeeTransII."Transaction Code", 'E_0010');
                    ObjPayrollEmployeeTransII.SetRange(ObjPayrollEmployeeTransII."Payroll Period", VarOpenPeriod);
                    if ObjPayrollEmployeeTransII.FindSet then begin
                        ObjPayrollEmployeeTransII.DeleteAll;
                    end;
                end;
                //============================================Delete Entries For the Same Period
            end;
        }
        field(118; "Other Taxable Benefits Amount"; Decimal)
        {

            trigger OnValidate()
            begin
                ObjPayrollCalender.Reset;
                ObjPayrollCalender.SetCurrentkey(ObjPayrollCalender."Date Opened");
                ObjPayrollCalender.SetRange(ObjPayrollCalender.Closed, false);
                if ObjPayrollCalender.FindLast then begin
                    VarOpenPeriod := ObjPayrollCalender."Date Opened";
                    VarPeriodMonth := Date2dmy(VarOpenPeriod, 2);
                    VarPeriodYear := Date2dmy(VarOpenPeriod, 3);
                end;


                if "Other Taxable Benefits Amount" > 0 then begin
                    if Confirm('Confirm the Staff Earns Other Taxable Benefits', false) = true then begin
                        FnRunGetOtherTaxableBenefitsAmount("Sacco Membership No.", "No.");
                    end;
                end;

                if "Other Taxable Benefits Amount" = 0 then begin
                    //============================================Delete Entries For the Same Period
                    ObjPayrollEmployeeTransII.Reset;
                    ObjPayrollEmployeeTransII.SetRange(ObjPayrollEmployeeTransII."No.", "No.");
                    ObjPayrollEmployeeTransII.SetRange(ObjPayrollEmployeeTransII."Transaction Code", 'E_0015');
                    ObjPayrollEmployeeTransII.SetRange(ObjPayrollEmployeeTransII."Payroll Period", VarOpenPeriod);
                    if ObjPayrollEmployeeTransII.FindSet then begin
                        ObjPayrollEmployeeTransII.DeleteAll;
                    end;
                end;
                //============================================Delete Entries For the Same Period
            end;
        }
        field(119; "Other Non Taxable Benefits"; Decimal)
        {

            trigger OnValidate()
            begin
                ObjPayrollCalender.Reset;
                ObjPayrollCalender.SetCurrentkey(ObjPayrollCalender."Date Opened");
                ObjPayrollCalender.SetRange(ObjPayrollCalender.Closed, false);
                if ObjPayrollCalender.FindLast then begin
                    VarOpenPeriod := ObjPayrollCalender."Date Opened";
                    VarPeriodMonth := Date2dmy(VarOpenPeriod, 2);
                    VarPeriodYear := Date2dmy(VarOpenPeriod, 3);
                end;


                if "Other Non Taxable Benefits" > 0 then begin
                    if Confirm('Confirm the Staff Earns Other Non Taxable Benefits', false) = true then begin
                        FnRunGetOtherNonTaxableBenefitsAmount("Sacco Membership No.", "No.");
                    end;
                end;

                if "Other Non Taxable Benefits" = 0 then begin
                    //============================================Delete Entries For the Same Period
                    ObjPayrollEmployeeTransII.Reset;
                    ObjPayrollEmployeeTransII.SetRange(ObjPayrollEmployeeTransII."No.", "No.");
                    ObjPayrollEmployeeTransII.SetRange(ObjPayrollEmployeeTransII."Transaction Code", 'E_0016');
                    ObjPayrollEmployeeTransII.SetRange(ObjPayrollEmployeeTransII."Payroll Period", VarOpenPeriod);
                    if ObjPayrollEmployeeTransII.FindSet then begin
                        ObjPayrollEmployeeTransII.DeleteAll;
                    end;
                end;
                //============================================Delete Entries For the Same Period
            end;
        }
        field(120; "Salary Advance Amount"; Decimal)
        {

            trigger OnValidate()
            begin
                ObjPayrollCalender.Reset;
                ObjPayrollCalender.SetCurrentkey(ObjPayrollCalender."Date Opened");
                ObjPayrollCalender.SetRange(ObjPayrollCalender.Closed, false);
                if ObjPayrollCalender.FindLast then begin
                    VarOpenPeriod := ObjPayrollCalender."Date Opened";
                    VarPeriodMonth := Date2dmy(VarOpenPeriod, 2);
                    VarPeriodYear := Date2dmy(VarOpenPeriod, 3);
                end;


                if "Salary Advance Amount" > 0 then begin
                    if Confirm('Confirm the Staff has a salary advance', false) = true then begin
                        FnRunGetSalaryAdvanceAmount("Sacco Membership No.", "No.");
                    end;
                end;

                if "Salary Advance Amount" = 0 then begin
                    //============================================Delete Entries For the Same Period
                    ObjPayrollEmployeeTransII.Reset;
                    ObjPayrollEmployeeTransII.SetRange(ObjPayrollEmployeeTransII."No.", "No.");
                    ObjPayrollEmployeeTransII.SetRange(ObjPayrollEmployeeTransII."Transaction Code", 'D_0006');
                    ObjPayrollEmployeeTransII.SetRange(ObjPayrollEmployeeTransII."Payroll Period", VarOpenPeriod);
                    if ObjPayrollEmployeeTransII.FindSet then begin
                        ObjPayrollEmployeeTransII.DeleteAll;
                    end;
                end;
                //============================================Delete Entries For the Same Period
            end;
        }
        field(121; "Helb Loan Amount"; Decimal)
        {

            trigger OnValidate()
            begin
                ObjPayrollCalender.Reset;
                ObjPayrollCalender.SetCurrentkey(ObjPayrollCalender."Date Opened");
                ObjPayrollCalender.SetRange(ObjPayrollCalender.Closed, false);
                if ObjPayrollCalender.FindLast then begin
                    VarOpenPeriod := ObjPayrollCalender."Date Opened";
                    VarPeriodMonth := Date2dmy(VarOpenPeriod, 2);
                    VarPeriodYear := Date2dmy(VarOpenPeriod, 3);
                end;


                if "Helb Loan Amount" > 0 then begin
                    if Confirm('Confirm the Staff has a HELB Loan', false) = true then begin
                        FnRunGetHelbLoanAmount("Sacco Membership No.", "No.");
                    end;
                end;

                if "Helb Loan Amount" = 0 then begin
                    //============================================Delete Entries For the Same Period
                    ObjPayrollEmployeeTransII.Reset;
                    ObjPayrollEmployeeTransII.SetRange(ObjPayrollEmployeeTransII."No.", "No.");
                    ObjPayrollEmployeeTransII.SetRange(ObjPayrollEmployeeTransII."Transaction Code", 'D_0009');
                    ObjPayrollEmployeeTransII.SetRange(ObjPayrollEmployeeTransII."Payroll Period", VarOpenPeriod);
                    if ObjPayrollEmployeeTransII.FindSet then begin
                        ObjPayrollEmployeeTransII.DeleteAll;
                    end;
                end;
                //============================================Delete Entries For the Same Period
            end;
        }
        field(122; "Pays Housing Levy"; Boolean)
        {

            trigger OnValidate()
            begin
                ObjPayrollCalender.Reset;
                ObjPayrollCalender.SetCurrentkey(ObjPayrollCalender."Date Opened");
                ObjPayrollCalender.SetRange(ObjPayrollCalender.Closed, false);
                if ObjPayrollCalender.FindLast then begin
                    VarOpenPeriod := ObjPayrollCalender."Date Opened";
                    VarPeriodMonth := Date2dmy(VarOpenPeriod, 2);
                    VarPeriodYear := Date2dmy(VarOpenPeriod, 3);
                end;


                if "Pays Housing Levy" = true then begin
                    if Confirm('Staff Pays Housing Levy', false) = true then begin
                        FnRunGetHousingLevyAmount("Sacco Membership No.", "No.");
                    end;
                end;

                if "Pays Housing Levy" = false then begin
                    //============================================Delete Entries For the Same Period
                    ObjPayrollEmployeeTransII.Reset;
                    ObjPayrollEmployeeTransII.SetRange(ObjPayrollEmployeeTransII."No.", "No.");
                    ObjPayrollEmployeeTransII.SetRange(ObjPayrollEmployeeTransII."Transaction Code", 'D_0017');
                    ObjPayrollEmployeeTransII.SetRange(ObjPayrollEmployeeTransII."Payroll Period", VarOpenPeriod);
                    if ObjPayrollEmployeeTransII.FindSet then begin
                        ObjPayrollEmployeeTransII.DeleteAll;
                    end;
                end;
                //============================================Delete Entries For the Same Period
            end;
        }
        field(123; "House Allowance Amount"; Decimal)
        {

            trigger OnValidate()
            begin
                ObjPayrollCalender.Reset;
                ObjPayrollCalender.SetCurrentkey(ObjPayrollCalender."Date Opened");
                ObjPayrollCalender.SetRange(ObjPayrollCalender.Closed, false);
                if ObjPayrollCalender.FindLast then begin
                    VarOpenPeriod := ObjPayrollCalender."Date Opened";
                    VarPeriodMonth := Date2dmy(VarOpenPeriod, 2);
                    VarPeriodYear := Date2dmy(VarOpenPeriod, 3);
                end;


                //============================================Delete Entries For the Same Period
                ObjPayrollEmployeeTransII.Reset;
                ObjPayrollEmployeeTransII.SetRange(ObjPayrollEmployeeTransII."No.", "No.");
                ObjPayrollEmployeeTransII.SetRange(ObjPayrollEmployeeTransII."Transaction Code", 'E_0001');
                ObjPayrollEmployeeTransII.SetRange(ObjPayrollEmployeeTransII."Payroll Period", VarOpenPeriod);
                if ObjPayrollEmployeeTransII.FindSet then begin
                    ObjPayrollEmployeeTransII.DeleteAll;
                end;
                //============================================Delete Entries For the Same Period



                if "House Allowance Amount" > 0 then begin
                    if Confirm('Confirm the Staff Earns House Allowance', false) = true then begin
                        FnRunGetHouseAllowanceAmount("Sacco Membership No.", "No.");
                    end;
                end;
            end;
        }
        field(124; "Document No"; Code[30])
        {

            trigger OnValidate()
            begin
                if "Document No" <> xRec."Document No" then begin
                    SalesSetup.Get;
                    NoSeriesMgt.TestManual(SalesSetup."House Change Request No");
                    "No. Series" := '';
                end;
            end;
        }
        field(125; "No. Series"; Code[30])
        {
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", Surname, Firstname, Lastname)
        {
        }
    }

    trigger OnDelete()
    begin
        //ERROR('DELETION NOT ALLOWED! THANK YOU.');
    end;

    trigger OnInsert()
    begin
        /*IF "Document No" = '' THEN BEGIN
          SalesSetup.GET;
          SalesSetup.TESTFIELD(SalesSetup."House Change Request No");
          NoSeriesMgt.InitSeries(SalesSetup."House Change Request No",xRec."No. Series",0D,"Document No","No. Series");
        END;
        */

    end;

    var
        CurrExchRate: Record "Currency Exchange Rate";
        BankCodes: Record "Payroll Bank Codes.";
        BankBranches: Record "Payroll Bank Branches.";
        ObjTransactionCodes: Record "Payroll Transaction Code.";
        BPAY: Decimal;
        ObjPayrollCalender: Record "Payroll Calender.";
        VarOpenPeriod: Date;
        ObjPayrollEmployeeTransII: Record "Payroll Employee Transactions.";
        VarPeriodMonth: Integer;
        VarPeriodYear: Integer;
        ObjCust: Record Customer;
        ObjAccounts: Record Vendor;
        SalesSetup: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;

    local procedure FnRunGetLeaveAllowanceAmount(VarMemberNo: Code[30]; VarPayrollNo: Code[30])
    var
        ObjCust: Record Customer;
        VarOpenPeriod: Date;
        VarPeriodMonth: Integer;
        VarPeriodYear: Integer;
        VarDepositBal: Decimal;
        strExtractedFrml: Text;
        PayrollProcessing: Codeunit "Payroll Processing";
        VarDeductionAmount: Decimal;
    begin
        ObjPayrollCalender.Reset;
        ObjPayrollCalender.SetCurrentkey(ObjPayrollCalender."Date Opened");
        ObjPayrollCalender.SetRange(ObjPayrollCalender.Closed, false);
        if ObjPayrollCalender.FindLast then begin
            VarOpenPeriod := ObjPayrollCalender."Date Opened";
            VarPeriodMonth := Date2dmy(VarOpenPeriod, 2);
            VarPeriodYear := Date2dmy(VarOpenPeriod, 3);
        end;

        ObjTransactionCodes.Reset;
        ObjTransactionCodes.SetRange(ObjTransactionCodes."Transaction Code", 'E_0005');
        if ObjTransactionCodes.FindSet then begin

            if ObjCust.Get(VarMemberNo) then begin
                ObjCust.CalcFields(ObjCust."Current Shares");

                if ObjTransactionCodes."Is Formulae" then begin
                    strExtractedFrml := PayrollProcessing.fnPureFormula("No.", VarPeriodMonth, VarPeriodYear, ObjTransactionCodes.Formulae);
                    VarDeductionAmount := ROUND(PayrollProcessing.fnFormulaResult(strExtractedFrml), 0.05, '<'); //Get the calculated amount
                end;

                ObjPayrollEmployeeTransII.Init;
                ObjPayrollEmployeeTransII."Sacco Membership No." := VarMemberNo;
                ObjPayrollEmployeeTransII."No." := VarPayrollNo;
                ObjPayrollEmployeeTransII."Loan Number" := '';
                ObjPayrollEmployeeTransII."Transaction Code" := ObjTransactionCodes."Transaction Code";
                ObjPayrollEmployeeTransII."Transaction Name" := ObjTransactionCodes."Transaction Name";
                ObjPayrollEmployeeTransII."Transaction Type" := ObjTransactionCodes."Transaction Type";
                ObjPayrollEmployeeTransII."Payroll Period" := VarOpenPeriod;
                ObjPayrollEmployeeTransII."Period Month" := VarPeriodMonth;
                ObjPayrollEmployeeTransII."Period Year" := VarPeriodYear;
                ObjPayrollEmployeeTransII.Amount := VarDeductionAmount;
                ObjPayrollEmployeeTransII."Amount(LCY)" := VarDeductionAmount;
                ObjPayrollEmployeeTransII.Balance := 0;
                ObjPayrollEmployeeTransII."Balance(LCY)" := 0;
                ObjPayrollEmployeeTransII."Amtzd Loan Repay Amt" := 0;
                ObjPayrollEmployeeTransII.Insert;
            end;
        end;
    end;

    local procedure FnRunGetActingAllowanceAmount(VarMemberNo: Code[30]; VarPayrollNo: Code[30])
    var
        ObjCust: Record Customer;
        VarOpenPeriod: Date;
        VarPeriodMonth: Integer;
        VarPeriodYear: Integer;
        VarDepositBal: Decimal;
        strExtractedFrml: Text;
        PayrollProcessing: Codeunit "Payroll Processing";
        VarDeductionAmount: Decimal;
    begin
        ObjPayrollCalender.Reset;
        ObjPayrollCalender.SetCurrentkey(ObjPayrollCalender."Date Opened");
        ObjPayrollCalender.SetRange(ObjPayrollCalender.Closed, false);
        if ObjPayrollCalender.FindLast then begin
            VarOpenPeriod := ObjPayrollCalender."Date Opened";
            VarPeriodMonth := Date2dmy(VarOpenPeriod, 2);
            VarPeriodYear := Date2dmy(VarOpenPeriod, 3);
        end;

        ObjTransactionCodes.Reset;
        ObjTransactionCodes.SetRange(ObjTransactionCodes."Transaction Code", 'E_0002');
        if ObjTransactionCodes.FindSet then begin

            if ObjCust.Get(VarMemberNo) then begin
                ObjCust.CalcFields(ObjCust."Current Shares");

                if ObjTransactionCodes."Is Formulae" then begin
                    strExtractedFrml := PayrollProcessing.fnPureFormula("No.", VarPeriodMonth, VarPeriodYear, ObjTransactionCodes.Formulae);
                    VarDeductionAmount := ROUND(PayrollProcessing.fnFormulaResult(strExtractedFrml), 0.05, '<'); //Get the calculated amount
                end;

                ObjPayrollEmployeeTransII.Init;
                ObjPayrollEmployeeTransII."Sacco Membership No." := VarMemberNo;
                ObjPayrollEmployeeTransII."No." := VarPayrollNo;
                ObjPayrollEmployeeTransII."Loan Number" := '';
                ObjPayrollEmployeeTransII."Transaction Code" := ObjTransactionCodes."Transaction Code";
                ObjPayrollEmployeeTransII."Transaction Name" := ObjTransactionCodes."Transaction Name";
                ObjPayrollEmployeeTransII."Transaction Type" := ObjTransactionCodes."Transaction Type";
                ObjPayrollEmployeeTransII."Payroll Period" := VarOpenPeriod;
                ObjPayrollEmployeeTransII."Period Month" := VarPeriodMonth;
                ObjPayrollEmployeeTransII."Period Year" := VarPeriodYear;
                ObjPayrollEmployeeTransII.Amount := VarDeductionAmount;
                ObjPayrollEmployeeTransII."Amount(LCY)" := VarDeductionAmount;
                ObjPayrollEmployeeTransII.Balance := 0;
                ObjPayrollEmployeeTransII."Balance(LCY)" := 0;
                ObjPayrollEmployeeTransII."Amtzd Loan Repay Amt" := 0;
                ObjPayrollEmployeeTransII.Insert;
            end;
        end;
    end;

    local procedure FnRunGetHouseAllowanceAmount(VarMemberNo: Code[30]; VarPayrollNo: Code[30])
    var
        ObjCust: Record Customer;
        VarOpenPeriod: Date;
        VarPeriodMonth: Integer;
        VarPeriodYear: Integer;
        VarDepositBal: Decimal;
        strExtractedFrml: Text;
        PayrollProcessing: Codeunit "Payroll Processing";
        VarDeductionAmount: Decimal;
    begin
        ObjPayrollCalender.Reset;
        ObjPayrollCalender.SetCurrentkey(ObjPayrollCalender."Date Opened");
        ObjPayrollCalender.SetRange(ObjPayrollCalender.Closed, false);
        if ObjPayrollCalender.FindLast then begin
            VarOpenPeriod := ObjPayrollCalender."Date Opened";
            VarPeriodMonth := Date2dmy(VarOpenPeriod, 2);
            VarPeriodYear := Date2dmy(VarOpenPeriod, 3);
        end;

        ObjTransactionCodes.Reset;
        ObjTransactionCodes.SetRange(ObjTransactionCodes."Transaction Code", 'E_0001');
        if ObjTransactionCodes.FindSet then begin

            if ObjCust.Get(VarMemberNo) then begin
                ObjCust.CalcFields(ObjCust."Current Shares");

                /*IF ObjTransactionCodes."Is Formulae" THEN BEGIN
                   strExtractedFrml := PayrollProcessing.fnPureFormula("No.", VarPeriodMonth, VarPeriodYear, ObjTransactionCodes.Formulae);
                   VarDeductionAmount := ROUND(PayrollProcessing.fnFormulaResult(strExtractedFrml),0.05,'<'); //Get the calculated amount
                   END;*/

                VarDeductionAmount := "House Allowance Amount";

                ObjPayrollEmployeeTransII.Init;
                ObjPayrollEmployeeTransII."Sacco Membership No." := VarMemberNo;
                ObjPayrollEmployeeTransII."No." := VarPayrollNo;
                ObjPayrollEmployeeTransII."Loan Number" := '';
                ObjPayrollEmployeeTransII."Transaction Code" := ObjTransactionCodes."Transaction Code";
                ObjPayrollEmployeeTransII."Transaction Name" := ObjTransactionCodes."Transaction Name";
                ObjPayrollEmployeeTransII."Transaction Type" := ObjTransactionCodes."Transaction Type";
                ObjPayrollEmployeeTransII."Payroll Period" := VarOpenPeriod;
                ObjPayrollEmployeeTransII."Period Month" := VarPeriodMonth;
                ObjPayrollEmployeeTransII."Period Year" := VarPeriodYear;
                ObjPayrollEmployeeTransII.Amount := VarDeductionAmount;
                ObjPayrollEmployeeTransII."Amount(LCY)" := VarDeductionAmount;
                ObjPayrollEmployeeTransII.Balance := 0;
                ObjPayrollEmployeeTransII."Balance(LCY)" := 0;
                ObjPayrollEmployeeTransII."Amtzd Loan Repay Amt" := 0;
                ObjPayrollEmployeeTransII.Insert;
            end;
        end;

    end;

    local procedure FnRunGetPensionAmount(VarMemberNo: Code[30]; VarPayrollNo: Code[30])
    var
        ObjCust: Record Customer;
        VarOpenPeriod: Date;
        VarPeriodMonth: Integer;
        VarPeriodYear: Integer;
        VarDepositBal: Decimal;
        strExtractedFrml: Text;
        PayrollProcessing: Codeunit "Payroll Processing";
        VarDeductionAmount: Decimal;
    begin
        ObjPayrollCalender.Reset;
        ObjPayrollCalender.SetCurrentkey(ObjPayrollCalender."Date Opened");
        ObjPayrollCalender.SetRange(ObjPayrollCalender.Closed, false);
        if ObjPayrollCalender.FindLast then begin
            VarOpenPeriod := ObjPayrollCalender."Date Opened";
            VarPeriodMonth := Date2dmy(VarOpenPeriod, 2);
            VarPeriodYear := Date2dmy(VarOpenPeriod, 3);
        end;

        ObjTransactionCodes.Reset;
        ObjTransactionCodes.SetRange(ObjTransactionCodes."Transaction Code", 'D_0007');
        if ObjTransactionCodes.FindSet then begin

            if ObjTransactionCodes."Is Formulae" then begin
                strExtractedFrml := PayrollProcessing.fnPureFormula("No.", VarPeriodMonth, VarPeriodYear, ObjTransactionCodes.Formulae);
                VarDeductionAmount := ROUND(PayrollProcessing.fnFormulaResult(strExtractedFrml), 0.05, '<'); //Get the calculated amount
            end;

            ObjPayrollEmployeeTransII.Init;
            ObjPayrollEmployeeTransII."Sacco Membership No." := VarMemberNo;
            ObjPayrollEmployeeTransII."No." := VarPayrollNo;
            ObjPayrollEmployeeTransII."Loan Number" := '';
            ObjPayrollEmployeeTransII."Transaction Code" := ObjTransactionCodes."Transaction Code";
            ObjPayrollEmployeeTransII."Transaction Name" := ObjTransactionCodes."Transaction Name";
            ObjPayrollEmployeeTransII."Transaction Type" := ObjTransactionCodes."Transaction Type";
            ObjPayrollEmployeeTransII."Payroll Period" := VarOpenPeriod;
            ObjPayrollEmployeeTransII."Period Month" := VarPeriodMonth;
            ObjPayrollEmployeeTransII."Period Year" := VarPeriodYear;
            ObjPayrollEmployeeTransII.Amount := VarDeductionAmount;
            ObjPayrollEmployeeTransII."Amount(LCY)" := VarDeductionAmount;
            ObjPayrollEmployeeTransII.Balance := 0;
            ObjPayrollEmployeeTransII."Balance(LCY)" := 0;
            ObjPayrollEmployeeTransII."Amtzd Loan Repay Amt" := 0;
            ObjPayrollEmployeeTransII.Insert;
        end;
    end;

    local procedure FnRunGetBonusAmount(VarMemberNo: Code[30]; VarPayrollNo: Code[30])
    var
        ObjCust: Record Customer;
        VarOpenPeriod: Date;
        VarPeriodMonth: Integer;
        VarPeriodYear: Integer;
        VarDepositBal: Decimal;
        strExtractedFrml: Text;
        PayrollProcessing: Codeunit "Payroll Processing";
        VarDeductionAmount: Decimal;
    begin
        ObjPayrollCalender.Reset;
        ObjPayrollCalender.SetCurrentkey(ObjPayrollCalender."Date Opened");
        ObjPayrollCalender.SetRange(ObjPayrollCalender.Closed, false);
        if ObjPayrollCalender.FindLast then begin
            VarOpenPeriod := ObjPayrollCalender."Date Opened";
            VarPeriodMonth := Date2dmy(VarOpenPeriod, 2);
            VarPeriodYear := Date2dmy(VarOpenPeriod, 3);
        end;

        ObjTransactionCodes.Reset;
        ObjTransactionCodes.SetRange(ObjTransactionCodes."Transaction Code", 'E_0007');
        if ObjTransactionCodes.FindSet then begin

            if ObjCust.Get(VarMemberNo) then begin
                ObjCust.CalcFields(ObjCust."Current Shares");

                /*IF ObjTransactionCodes."Is Formulae" THEN BEGIN
                   strExtractedFrml := PayrollProcessing.fnPureFormula("No.", VarPeriodMonth, VarPeriodYear, ObjTransactionCodes.Formulae);
                   VarDeductionAmount := ROUND(PayrollProcessing.fnFormulaResult(strExtractedFrml),0.05,'<'); //Get the calculated amount
                   END;*/

                VarDeductionAmount := "Bonus Amount";


                ObjPayrollEmployeeTransII.Init;
                ObjPayrollEmployeeTransII."Sacco Membership No." := VarMemberNo;
                ObjPayrollEmployeeTransII."No." := VarPayrollNo;
                ObjPayrollEmployeeTransII."Loan Number" := '';
                ObjPayrollEmployeeTransII."Transaction Code" := ObjTransactionCodes."Transaction Code";
                ObjPayrollEmployeeTransII."Transaction Name" := ObjTransactionCodes."Transaction Name";
                ObjPayrollEmployeeTransII."Transaction Type" := ObjTransactionCodes."Transaction Type";
                ObjPayrollEmployeeTransII."Payroll Period" := VarOpenPeriod;
                ObjPayrollEmployeeTransII."Period Month" := VarPeriodMonth;
                ObjPayrollEmployeeTransII."Period Year" := VarPeriodYear;
                ObjPayrollEmployeeTransII.Amount := VarDeductionAmount;
                ObjPayrollEmployeeTransII."Amount(LCY)" := VarDeductionAmount;
                ObjPayrollEmployeeTransII.Balance := 0;
                ObjPayrollEmployeeTransII."Balance(LCY)" := 0;
                ObjPayrollEmployeeTransII."Amtzd Loan Repay Amt" := 0;
                ObjPayrollEmployeeTransII.Insert;
            end;
        end;

    end;

    local procedure FnRunGetVoluntaryPensionAmount(VarMemberNo: Code[30]; VarPayrollNo: Code[30])
    var
        ObjCust: Record Customer;
        VarOpenPeriod: Date;
        VarPeriodMonth: Integer;
        VarPeriodYear: Integer;
        VarDepositBal: Decimal;
        strExtractedFrml: Text;
        PayrollProcessing: Codeunit "Payroll Processing";
        VarDeductionAmount: Decimal;
    begin
        ObjPayrollCalender.Reset;
        ObjPayrollCalender.SetCurrentkey(ObjPayrollCalender."Date Opened");
        ObjPayrollCalender.SetRange(ObjPayrollCalender.Closed, false);
        if ObjPayrollCalender.FindLast then begin
            VarOpenPeriod := ObjPayrollCalender."Date Opened";
            VarPeriodMonth := Date2dmy(VarOpenPeriod, 2);
            VarPeriodYear := Date2dmy(VarOpenPeriod, 3);
        end;

        ObjTransactionCodes.Reset;
        ObjTransactionCodes.SetRange(ObjTransactionCodes."Transaction Code", 'D_0008');
        if ObjTransactionCodes.FindSet then begin

            if ObjCust.Get(VarMemberNo) then begin
                ObjCust.CalcFields(ObjCust."Current Shares");


                VarDeductionAmount := "Voluntary Pension Amount";


                ObjPayrollEmployeeTransII.Init;
                ObjPayrollEmployeeTransII."Sacco Membership No." := VarMemberNo;
                ObjPayrollEmployeeTransII."No." := VarPayrollNo;
                ObjPayrollEmployeeTransII."Loan Number" := '';
                ObjPayrollEmployeeTransII."Transaction Code" := ObjTransactionCodes."Transaction Code";
                ObjPayrollEmployeeTransII."Transaction Name" := ObjTransactionCodes."Transaction Name";
                ObjPayrollEmployeeTransII."Transaction Type" := ObjTransactionCodes."Transaction Type";
                ObjPayrollEmployeeTransII."Payroll Period" := VarOpenPeriod;
                ObjPayrollEmployeeTransII."Period Month" := VarPeriodMonth;
                ObjPayrollEmployeeTransII."Period Year" := VarPeriodYear;
                ObjPayrollEmployeeTransII.Amount := VarDeductionAmount;
                ObjPayrollEmployeeTransII."Amount(LCY)" := VarDeductionAmount;
                ObjPayrollEmployeeTransII.Balance := 0;
                ObjPayrollEmployeeTransII."Balance(LCY)" := 0;
                ObjPayrollEmployeeTransII."Amtzd Loan Repay Amt" := 0;
                ObjPayrollEmployeeTransII.Insert;
            end;
        end;
    end;

    local procedure FnRunGetSalaryArrearsAmount(VarMemberNo: Code[30]; VarPayrollNo: Code[30])
    var
        ObjCust: Record Customer;
        VarOpenPeriod: Date;
        VarPeriodMonth: Integer;
        VarPeriodYear: Integer;
        VarDepositBal: Decimal;
        strExtractedFrml: Text;
        PayrollProcessing: Codeunit "Payroll Processing";
        VarDeductionAmount: Decimal;
    begin
        ObjPayrollCalender.Reset;
        ObjPayrollCalender.SetCurrentkey(ObjPayrollCalender."Date Opened");
        ObjPayrollCalender.SetRange(ObjPayrollCalender.Closed, false);
        if ObjPayrollCalender.FindLast then begin
            VarOpenPeriod := ObjPayrollCalender."Date Opened";
            VarPeriodMonth := Date2dmy(VarOpenPeriod, 2);
            VarPeriodYear := Date2dmy(VarOpenPeriod, 3);
        end;

        ObjTransactionCodes.Reset;
        ObjTransactionCodes.SetRange(ObjTransactionCodes."Transaction Code", 'E_0006');
        if ObjTransactionCodes.FindSet then begin

            if ObjCust.Get(VarMemberNo) then begin
                ObjCust.CalcFields(ObjCust."Current Shares");


                VarDeductionAmount := "Salary Arrears Amount";
                ObjPayrollEmployeeTransII.Init;
                ObjPayrollEmployeeTransII."Sacco Membership No." := VarMemberNo;
                ObjPayrollEmployeeTransII."No." := VarPayrollNo;
                ObjPayrollEmployeeTransII."Loan Number" := '';
                ObjPayrollEmployeeTransII."Transaction Code" := ObjTransactionCodes."Transaction Code";
                ObjPayrollEmployeeTransII."Transaction Name" := ObjTransactionCodes."Transaction Name";
                ObjPayrollEmployeeTransII."Transaction Type" := ObjTransactionCodes."Transaction Type";
                ObjPayrollEmployeeTransII."Payroll Period" := VarOpenPeriod;
                ObjPayrollEmployeeTransII."Period Month" := VarPeriodMonth;
                ObjPayrollEmployeeTransII."Period Year" := VarPeriodYear;
                ObjPayrollEmployeeTransII.Amount := VarDeductionAmount;
                ObjPayrollEmployeeTransII."Amount(LCY)" := VarDeductionAmount;
                ObjPayrollEmployeeTransII.Balance := 0;
                ObjPayrollEmployeeTransII."Balance(LCY)" := 0;
                ObjPayrollEmployeeTransII."Amtzd Loan Repay Amt" := 0;
                ObjPayrollEmployeeTransII.Insert;
            end;
        end;
    end;

    local procedure FnRunGetEOYAmount(VarMemberNo: Code[30]; VarPayrollNo: Code[30])
    var
        ObjCust: Record Customer;
        VarOpenPeriod: Date;
        VarPeriodMonth: Integer;
        VarPeriodYear: Integer;
        VarDepositBal: Decimal;
        strExtractedFrml: Text;
        PayrollProcessing: Codeunit "Payroll Processing";
        VarDeductionAmount: Decimal;
    begin
        ObjPayrollCalender.Reset;
        ObjPayrollCalender.SetCurrentkey(ObjPayrollCalender."Date Opened");
        ObjPayrollCalender.SetRange(ObjPayrollCalender.Closed, false);
        if ObjPayrollCalender.FindLast then begin
            VarOpenPeriod := ObjPayrollCalender."Date Opened";
            VarPeriodMonth := Date2dmy(VarOpenPeriod, 2);
            VarPeriodYear := Date2dmy(VarOpenPeriod, 3);
        end;

        ObjTransactionCodes.Reset;
        ObjTransactionCodes.SetRange(ObjTransactionCodes."Transaction Code", 'E_0009');
        if ObjTransactionCodes.FindSet then begin

            if ObjCust.Get(VarMemberNo) then begin
                ObjCust.CalcFields(ObjCust."Current Shares");


                VarDeductionAmount := "EOY Amount";
                ObjPayrollEmployeeTransII.Init;
                ObjPayrollEmployeeTransII."Sacco Membership No." := VarMemberNo;
                ObjPayrollEmployeeTransII."No." := VarPayrollNo;
                ObjPayrollEmployeeTransII."Loan Number" := '';
                ObjPayrollEmployeeTransII."Transaction Code" := ObjTransactionCodes."Transaction Code";
                ObjPayrollEmployeeTransII."Transaction Name" := ObjTransactionCodes."Transaction Name";
                ObjPayrollEmployeeTransII."Transaction Type" := ObjTransactionCodes."Transaction Type";
                ObjPayrollEmployeeTransII."Payroll Period" := VarOpenPeriod;
                ObjPayrollEmployeeTransII."Period Month" := VarPeriodMonth;
                ObjPayrollEmployeeTransII."Period Year" := VarPeriodYear;
                ObjPayrollEmployeeTransII.Amount := VarDeductionAmount;
                ObjPayrollEmployeeTransII."Amount(LCY)" := VarDeductionAmount;
                ObjPayrollEmployeeTransII.Balance := 0;
                ObjPayrollEmployeeTransII."Balance(LCY)" := 0;
                ObjPayrollEmployeeTransII."Amtzd Loan Repay Amt" := 0;
                ObjPayrollEmployeeTransII.Insert;
            end;
        end;
    end;

    local procedure FnRunGetMileageAllowanceAmount(VarMemberNo: Code[30]; VarPayrollNo: Code[30])
    var
        ObjCust: Record Customer;
        VarOpenPeriod: Date;
        VarPeriodMonth: Integer;
        VarPeriodYear: Integer;
        VarDepositBal: Decimal;
        strExtractedFrml: Text;
        PayrollProcessing: Codeunit "Payroll Processing";
        VarDeductionAmount: Decimal;
    begin
        ObjPayrollCalender.Reset;
        ObjPayrollCalender.SetCurrentkey(ObjPayrollCalender."Date Opened");
        ObjPayrollCalender.SetRange(ObjPayrollCalender.Closed, false);
        if ObjPayrollCalender.FindLast then begin
            VarOpenPeriod := ObjPayrollCalender."Date Opened";
            VarPeriodMonth := Date2dmy(VarOpenPeriod, 2);
            VarPeriodYear := Date2dmy(VarOpenPeriod, 3);
        end;

        ObjTransactionCodes.Reset;
        ObjTransactionCodes.SetRange(ObjTransactionCodes."Transaction Code", 'E_0010');
        if ObjTransactionCodes.FindSet then begin

            if ObjCust.Get(VarMemberNo) then begin
                ObjCust.CalcFields(ObjCust."Current Shares");


                VarDeductionAmount := MileageAllowance;
                ObjPayrollEmployeeTransII.Init;
                ObjPayrollEmployeeTransII."Sacco Membership No." := VarMemberNo;
                ObjPayrollEmployeeTransII."No." := VarPayrollNo;
                ObjPayrollEmployeeTransII."Loan Number" := '';
                ObjPayrollEmployeeTransII."Transaction Code" := ObjTransactionCodes."Transaction Code";
                ObjPayrollEmployeeTransII."Transaction Name" := ObjTransactionCodes."Transaction Name";
                ObjPayrollEmployeeTransII."Transaction Type" := ObjTransactionCodes."Transaction Type";
                ObjPayrollEmployeeTransII."Payroll Period" := VarOpenPeriod;
                ObjPayrollEmployeeTransII."Period Month" := VarPeriodMonth;
                ObjPayrollEmployeeTransII."Period Year" := VarPeriodYear;
                ObjPayrollEmployeeTransII.Amount := VarDeductionAmount;
                ObjPayrollEmployeeTransII."Amount(LCY)" := VarDeductionAmount;
                ObjPayrollEmployeeTransII.Balance := 0;
                ObjPayrollEmployeeTransII."Balance(LCY)" := 0;
                ObjPayrollEmployeeTransII."Amtzd Loan Repay Amt" := 0;
                ObjPayrollEmployeeTransII.Insert;
            end;
        end;
    end;

    local procedure FnRunGetOtherTaxableBenefitsAmount(VarMemberNo: Code[30]; VarPayrollNo: Code[30])
    var
        ObjCust: Record Customer;
        VarOpenPeriod: Date;
        VarPeriodMonth: Integer;
        VarPeriodYear: Integer;
        VarDepositBal: Decimal;
        strExtractedFrml: Text;
        PayrollProcessing: Codeunit "Payroll Processing";
        VarDeductionAmount: Decimal;
    begin
        ObjPayrollCalender.Reset;
        ObjPayrollCalender.SetCurrentkey(ObjPayrollCalender."Date Opened");
        ObjPayrollCalender.SetRange(ObjPayrollCalender.Closed, false);
        if ObjPayrollCalender.FindLast then begin
            VarOpenPeriod := ObjPayrollCalender."Date Opened";
            VarPeriodMonth := Date2dmy(VarOpenPeriod, 2);
            VarPeriodYear := Date2dmy(VarOpenPeriod, 3);
        end;

        ObjTransactionCodes.Reset;
        ObjTransactionCodes.SetRange(ObjTransactionCodes."Transaction Code", 'E_0015');
        if ObjTransactionCodes.FindSet then begin

            if ObjCust.Get(VarMemberNo) then begin
                ObjCust.CalcFields(ObjCust."Current Shares");


                VarDeductionAmount := "Other Taxable Benefits Amount";
                ObjPayrollEmployeeTransII.Init;
                ObjPayrollEmployeeTransII."Sacco Membership No." := VarMemberNo;
                ObjPayrollEmployeeTransII."No." := VarPayrollNo;
                ObjPayrollEmployeeTransII."Loan Number" := '';
                ObjPayrollEmployeeTransII."Transaction Code" := ObjTransactionCodes."Transaction Code";
                ObjPayrollEmployeeTransII."Transaction Name" := ObjTransactionCodes."Transaction Name";
                ObjPayrollEmployeeTransII."Transaction Type" := ObjTransactionCodes."Transaction Type";
                ObjPayrollEmployeeTransII."Payroll Period" := VarOpenPeriod;
                ObjPayrollEmployeeTransII."Period Month" := VarPeriodMonth;
                ObjPayrollEmployeeTransII."Period Year" := VarPeriodYear;
                ObjPayrollEmployeeTransII.Amount := VarDeductionAmount;
                ObjPayrollEmployeeTransII."Amount(LCY)" := VarDeductionAmount;
                ObjPayrollEmployeeTransII.Balance := 0;
                ObjPayrollEmployeeTransII."Balance(LCY)" := 0;
                ObjPayrollEmployeeTransII."Amtzd Loan Repay Amt" := 0;
                ObjPayrollEmployeeTransII.Insert;
            end;
        end;
    end;

    local procedure FnRunGetOtherNonTaxableBenefitsAmount(VarMemberNo: Code[30]; VarPayrollNo: Code[30])
    var
        ObjCust: Record Customer;
        VarOpenPeriod: Date;
        VarPeriodMonth: Integer;
        VarPeriodYear: Integer;
        VarDepositBal: Decimal;
        strExtractedFrml: Text;
        PayrollProcessing: Codeunit "Payroll Processing";
        VarDeductionAmount: Decimal;
    begin
        ObjPayrollCalender.Reset;
        ObjPayrollCalender.SetCurrentkey(ObjPayrollCalender."Date Opened");
        ObjPayrollCalender.SetRange(ObjPayrollCalender.Closed, false);
        if ObjPayrollCalender.FindLast then begin
            VarOpenPeriod := ObjPayrollCalender."Date Opened";
            VarPeriodMonth := Date2dmy(VarOpenPeriod, 2);
            VarPeriodYear := Date2dmy(VarOpenPeriod, 3);
        end;

        ObjTransactionCodes.Reset;
        ObjTransactionCodes.SetRange(ObjTransactionCodes."Transaction Code", 'E_0016');
        if ObjTransactionCodes.FindSet then begin

            if ObjCust.Get(VarMemberNo) then begin
                ObjCust.CalcFields(ObjCust."Current Shares");


                VarDeductionAmount := "Other Non Taxable Benefits";
                ObjPayrollEmployeeTransII.Init;
                ObjPayrollEmployeeTransII."Sacco Membership No." := VarMemberNo;
                ObjPayrollEmployeeTransII."No." := VarPayrollNo;
                ObjPayrollEmployeeTransII."Loan Number" := '';
                ObjPayrollEmployeeTransII."Transaction Code" := ObjTransactionCodes."Transaction Code";
                ObjPayrollEmployeeTransII."Transaction Name" := ObjTransactionCodes."Transaction Name";
                ObjPayrollEmployeeTransII."Transaction Type" := ObjTransactionCodes."Transaction Type";
                ObjPayrollEmployeeTransII."Payroll Period" := VarOpenPeriod;
                ObjPayrollEmployeeTransII."Period Month" := VarPeriodMonth;
                ObjPayrollEmployeeTransII."Period Year" := VarPeriodYear;
                ObjPayrollEmployeeTransII.Amount := VarDeductionAmount;
                ObjPayrollEmployeeTransII."Amount(LCY)" := VarDeductionAmount;
                ObjPayrollEmployeeTransII.Balance := 0;
                ObjPayrollEmployeeTransII."Balance(LCY)" := 0;
                ObjPayrollEmployeeTransII."Amtzd Loan Repay Amt" := 0;
                ObjPayrollEmployeeTransII.Insert;
            end;
        end;
    end;

    local procedure FnRunGetSalaryAdvanceAmount(VarMemberNo: Code[30]; VarPayrollNo: Code[30])
    var
        ObjCust: Record Customer;
        VarOpenPeriod: Date;
        VarPeriodMonth: Integer;
        VarPeriodYear: Integer;
        VarDepositBal: Decimal;
        strExtractedFrml: Text;
        PayrollProcessing: Codeunit "Payroll Processing";
        VarDeductionAmount: Decimal;
    begin
        ObjPayrollCalender.Reset;
        ObjPayrollCalender.SetCurrentkey(ObjPayrollCalender."Date Opened");
        ObjPayrollCalender.SetRange(ObjPayrollCalender.Closed, false);
        if ObjPayrollCalender.FindLast then begin
            VarOpenPeriod := ObjPayrollCalender."Date Opened";
            VarPeriodMonth := Date2dmy(VarOpenPeriod, 2);
            VarPeriodYear := Date2dmy(VarOpenPeriod, 3);
        end;

        ObjTransactionCodes.Reset;
        ObjTransactionCodes.SetRange(ObjTransactionCodes."Transaction Code", 'D_0006');
        if ObjTransactionCodes.FindSet then begin

            if ObjCust.Get(VarMemberNo) then begin
                ObjCust.CalcFields(ObjCust."Current Shares");


                VarDeductionAmount := "Salary Advance Amount";
                ObjPayrollEmployeeTransII.Init;
                ObjPayrollEmployeeTransII."Sacco Membership No." := VarMemberNo;
                ObjPayrollEmployeeTransII."No." := VarPayrollNo;
                ObjPayrollEmployeeTransII."Loan Number" := '';
                ObjPayrollEmployeeTransII."Transaction Code" := ObjTransactionCodes."Transaction Code";
                ObjPayrollEmployeeTransII."Transaction Name" := ObjTransactionCodes."Transaction Name";
                ObjPayrollEmployeeTransII."Transaction Type" := ObjTransactionCodes."Transaction Type";
                ObjPayrollEmployeeTransII."Payroll Period" := VarOpenPeriod;
                ObjPayrollEmployeeTransII."Period Month" := VarPeriodMonth;
                ObjPayrollEmployeeTransII."Period Year" := VarPeriodYear;
                ObjPayrollEmployeeTransII.Amount := VarDeductionAmount;
                ObjPayrollEmployeeTransII."Amount(LCY)" := VarDeductionAmount;
                ObjPayrollEmployeeTransII.Balance := 0;
                ObjPayrollEmployeeTransII."Balance(LCY)" := 0;
                ObjPayrollEmployeeTransII."Amtzd Loan Repay Amt" := 0;
                ObjPayrollEmployeeTransII.Insert;
            end;
        end;
    end;

    local procedure FnRunGetHelbLoanAmount(VarMemberNo: Code[30]; VarPayrollNo: Code[30])
    var
        ObjCust: Record Customer;
        VarOpenPeriod: Date;
        VarPeriodMonth: Integer;
        VarPeriodYear: Integer;
        VarDepositBal: Decimal;
        strExtractedFrml: Text;
        PayrollProcessing: Codeunit "Payroll Processing";
        VarDeductionAmount: Decimal;
    begin
        ObjPayrollCalender.Reset;
        ObjPayrollCalender.SetCurrentkey(ObjPayrollCalender."Date Opened");
        ObjPayrollCalender.SetRange(ObjPayrollCalender.Closed, false);
        if ObjPayrollCalender.FindLast then begin
            VarOpenPeriod := ObjPayrollCalender."Date Opened";
            VarPeriodMonth := Date2dmy(VarOpenPeriod, 2);
            VarPeriodYear := Date2dmy(VarOpenPeriod, 3);
        end;

        ObjTransactionCodes.Reset;
        ObjTransactionCodes.SetRange(ObjTransactionCodes."Transaction Code", 'D_0009');
        if ObjTransactionCodes.FindSet then begin

            if ObjCust.Get(VarMemberNo) then begin
                ObjCust.CalcFields(ObjCust."Current Shares");


                VarDeductionAmount := "Helb Loan Amount";
                ObjPayrollEmployeeTransII.Init;
                ObjPayrollEmployeeTransII."Sacco Membership No." := VarMemberNo;
                ObjPayrollEmployeeTransII."No." := VarPayrollNo;
                ObjPayrollEmployeeTransII."Loan Number" := '';
                ObjPayrollEmployeeTransII."Transaction Code" := ObjTransactionCodes."Transaction Code";
                ObjPayrollEmployeeTransII."Transaction Name" := ObjTransactionCodes."Transaction Name";
                ObjPayrollEmployeeTransII."Transaction Type" := ObjTransactionCodes."Transaction Type";
                ObjPayrollEmployeeTransII."Payroll Period" := VarOpenPeriod;
                ObjPayrollEmployeeTransII."Period Month" := VarPeriodMonth;
                ObjPayrollEmployeeTransII."Period Year" := VarPeriodYear;
                ObjPayrollEmployeeTransII.Amount := VarDeductionAmount;
                ObjPayrollEmployeeTransII."Amount(LCY)" := VarDeductionAmount;
                ObjPayrollEmployeeTransII.Balance := 0;
                ObjPayrollEmployeeTransII."Balance(LCY)" := 0;
                ObjPayrollEmployeeTransII."Amtzd Loan Repay Amt" := 0;
                ObjPayrollEmployeeTransII.Insert;
            end;
        end;
    end;

    local procedure FnRunGetHousingLevyAmount(VarMemberNo: Code[30]; VarPayrollNo: Code[30])
    var
        ObjCust: Record Customer;
        VarOpenPeriod: Date;
        VarPeriodMonth: Integer;
        VarPeriodYear: Integer;
        VarDepositBal: Decimal;
        strExtractedFrml: Text;
        PayrollProcessing: Codeunit "Payroll Processing";
        VarDeductionAmount: Decimal;
    begin
        ObjPayrollCalender.Reset;
        ObjPayrollCalender.SetCurrentkey(ObjPayrollCalender."Date Opened");
        ObjPayrollCalender.SetRange(ObjPayrollCalender.Closed, false);
        if ObjPayrollCalender.FindLast then begin
            VarOpenPeriod := ObjPayrollCalender."Date Opened";
            VarPeriodMonth := Date2dmy(VarOpenPeriod, 2);
            VarPeriodYear := Date2dmy(VarOpenPeriod, 3);
        end;

        ObjTransactionCodes.Reset;
        ObjTransactionCodes.SetRange(ObjTransactionCodes."Transaction Code", 'D_0017');
        if ObjTransactionCodes.FindSet then begin

            if ObjTransactionCodes."Is Formulae" then begin
                strExtractedFrml := PayrollProcessing.fnPureFormula("No.", VarPeriodMonth, VarPeriodYear, ObjTransactionCodes.Formulae);
                VarDeductionAmount := ROUND(PayrollProcessing.fnFormulaResult(strExtractedFrml), 0.05, '<'); //Get the calculated amount
            end;

            ObjPayrollEmployeeTransII.Init;
            ObjPayrollEmployeeTransII."Sacco Membership No." := VarMemberNo;
            ObjPayrollEmployeeTransII."No." := VarPayrollNo;
            ObjPayrollEmployeeTransII."Loan Number" := '';
            ObjPayrollEmployeeTransII."Transaction Code" := ObjTransactionCodes."Transaction Code";
            ObjPayrollEmployeeTransII."Transaction Name" := ObjTransactionCodes."Transaction Name";
            ObjPayrollEmployeeTransII."Transaction Type" := ObjTransactionCodes."Transaction Type";
            ObjPayrollEmployeeTransII."Payroll Period" := VarOpenPeriod;
            ObjPayrollEmployeeTransII."Period Month" := VarPeriodMonth;
            ObjPayrollEmployeeTransII."Period Year" := VarPeriodYear;
            ObjPayrollEmployeeTransII.Amount := VarDeductionAmount;
            ObjPayrollEmployeeTransII."Amount(LCY)" := VarDeductionAmount;
            ObjPayrollEmployeeTransII.Balance := 0;
            ObjPayrollEmployeeTransII."Balance(LCY)" := 0;
            ObjPayrollEmployeeTransII."Amtzd Loan Repay Amt" := 0;
            ObjPayrollEmployeeTransII.Insert;
        end;
    end;
}

