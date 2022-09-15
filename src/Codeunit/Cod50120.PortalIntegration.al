#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Codeunit 50120 "PortalIntegration"
{

    trigger OnRun()
    var
        str: BigText;
    begin
        //MESSAGE(fnGetNextofkin('2491'));
        //MESSAGE( fnMemberStatement('000002','','');
        //fnTotalDepositsGraph('055000005','2013');
        //fnCurrentShareGraph('10000','2013');
        //fnTotalRepaidGraph('055000005','2013');
        //MESSAGE(MiniStatement('0003'));
        //fnMemberStatement('1024','006995Thox.pdf');
        //FnDepositsStatement('006995','dstatemnt.pdf');
        //FnLoanStatement('ACI015683','lsmnt.pdf');
        //MESSAGE(MiniStatement('006995'));
        //MESSAGE(FORMAT( FnLoanApplication('1023','D303',20000,'DEV',2,FALSE,FALSE,TRUE)));
        //fnFosaStatement('2483-05-1-1189','fosa1.pdf');
        //fnLoanRepaymentShedule('L03666',str);
        //fndividentstatement('000547','divident.pdf')
        //fnLoanGuranteed('006995','loansguaranteed.pdf');
        //fnLoanRepaymentShedule('10000','victorLoanrepay.pdf');
        //fnLoanGurantorsReport('10000','Guarantors.pdf');
        //fnAtmApplications('0101-001-00266')
        //FnLoanStatement('1024','jk');
        //MESSAGE(fnUpdatePassword('M469','20007072','1234', ''));
        //fnChangePassword('0001','test','pass123');
        //FnUpdateMonthlyContrib('2439', 2000);
        //fnUpdatePassword('10001','8340224','1340');
        //fnAtmApplications('2483-05-1-1189');
        //FnStandingOrders('2439','2483-05-1-1189','1W','1Y','2483-05-06-1189',20170913D,240,1);
        //MESSAGE(FORMAT( FnLoanApplication('2439','TANK LOAN',12500,'DEVELOPMENT',6,TRUE, FALSE, FALSE)));
        //fnFosaStatement('2747-006995-01', 'thox.pdf')
        //MESSAGE(FORMAT( Fnlogin('1024','')));
        //MESSAGE( MiniStatementNew('1558','5-02-40000106-00'));
        //MESSAGE( MiniStatement('1558'));
        //MESSAGE(FORMAT(fnLoanDetails('d308')));
        // MESSAGE(fnGetFosaAccountno('1024'));
        //MESSAGE(Fnloanssetup());
        //fnFeedback('1024', 'I have a big problem');
        Message(Format(FnCreatePassword('22128482', '1234')));
        //MESSAGE( FnNotifications());
        //MESSAGE(fnLoanDetails('ss'));
        //FnApproveGurarantors(
        //fnGuarantorsPortal('1024', '1023', 'BLN00148', 'Has requested you to quarantee laon');
        //FnApproveGurarantors(1, '000001',5, '',10000);
        //MESSAGE( FNAppraisalLoans('1024'));
        //MESSAGE( FnGetLoansForGuarantee('000001'));
        //MESSAGE(FnEditableLoans('1024','BLN00167'));
        //MESSAGE(fnLoans('2013-2064'));
        //MESSAGE(FnmemberInfo('2003-53'));
        //MESSAGE(FnGetLoansForGuarantee('000005'));
        //MESSAGE(FnApprovedGuarantors('1024', 'BLN00051'));
        //MESSAGE(FnloanCalc(40000,12,'D301'));
        //MESSAGE(FORMAT(fnTotalLoanAm('BLN00019')));
        //MESSAGE(fnGetLoanNumber('2003-53'));
        //Fnquestionaire('000005', 'ASKDL', 'WATCH','TIME','FND','1',2,3,2,'Hellen');
        //FnNotifications('bln00084','manu1.pdf');
        //fnLoanApplicationform('10230');
        //fnLoanApplicationform('1050',TODAY, '10');
        //MESSAGE(fnGetJuniorAccount('2012-1511'));
        //MESSAGE(fnAccountInfo('2003-53'));

        //FnLoanStatement('2012-1470','',str);
    end;

    var
        objMember: Record Customer;
        Vendor: Record Vendor;
        VendorLedgEntry: Record "Vendor Ledger Entry";
        FILESPATH: label 'D:\Kentours Revised\KENTOURS\Kentours\Kentours\Downloads\';
        objLoanRegister: Record "Loans Register";
        objAtmapplication: Record "ATM Card Applications";
        objRegMember: Record "Membership Applications";
        objNextKin: Record "Members Next of Kin";
        GenSetup: Record "Sacco General Set-Up";
        FreeShares: Decimal;
        glamount: Decimal;
        LoansGuaranteeDetails: Record "Loans Guarantee Details";
        objStandingOrders: Record "Standing Orders";
        freq: DateFormula;
        dur: DateFormula;
        phoneNumber: Code[20];
        SMSMessages: Record "SMS Messages";
        iEntryNo: Integer;
        FAccNo: Text[250];
        sms: Text[250];
        objLoanApplication: Record "Meetings Schedule";
        ClientName: Code[20];
        Loansetup: Record "Loan Products Setup";
        LoansPurpose: Record "Loans Purpose";
        ObjLoansregister: Record "Loans Register";
        LPrincipal: Decimal;
        LInterest: Decimal;
        Amount: Decimal;
        LBalance: Decimal;
        LoansRec: Record "Loans Register";
        TotalMRepay: Decimal;
        InterestRate: Decimal;
        Date: Date;
        FormNo: Code[40];
        Loanperiod: Integer;
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        Cust: Record Customer;
        StartDate: Date;
        DateFilter: Text[100];
        FromDate: Date;
        ToDate: Date;
        FromDateS: Text[100];
        ToDateS: Text[100];
        DivTotal: Decimal;
        CDeposits: Decimal;
        CustDiv: Record Customer;
        DivProg: Record "Dividends Progression";
        CDiv: Decimal;
        BDate: Date;
        CustR: Record Customer;
        CapDiv: Decimal;
        DivCapTotal: Decimal;
        RunningPeriod: Code[10];
        LineNo: Integer;
        Gnjlline: Record "Gen. Journal Line";
        PostingDate: Date;
        "W/Tax": Decimal;
        CommDiv: Decimal;
        DivInTotal: Decimal;
        WTaxInTotal: Decimal;
        CapTotal: Decimal;
        Period: Code[20];
        WTaxShareCap: Decimal;


    procedure fnUpdatePassword(MemberNo: Code[50]; idNo: Code[10]; NewPassword: Text[100]; smsport: Text) emailAddress: Text
    begin
        sms := smsport + NewPassword;

        objMember.Reset;
        objMember.SetRange(objMember."No.", MemberNo);
        objMember.SetRange(objMember."ID No.", idNo);
        if objMember.Find('-') then begin

            phoneNumber := objMember."Mobile Phone No";
            FAccNo := objMember."No.";
            objMember.Password := NewPassword;
            emailAddress := objMember."E-Mail";

            objMember.Modify;
            FnSMSMessage(FAccNo, phoneNumber, sms);
            //emailAddress:=TRUE;
        end
        else begin
            objMember.Reset;
            objMember.SetRange(objMember."Old Account No.", MemberNo);
            objMember.SetRange(objMember."ID No.", idNo);
            if objMember.Find('-') then begin

                phoneNumber := objMember."Mobile Phone No";
                FAccNo := objMember."FOSA Account No.";
                objMember.Password := NewPassword;
                emailAddress := objMember."E-Mail";
                objMember.Modify;
                FnSMSMessage(FAccNo, phoneNumber, sms);
                //emailAddress:=TRUE;
            end
            else begin
                objMember.Reset;
                objMember.SetRange(objMember."No.", MemberNo);
                objMember.SetRange(objMember."ID No.", idNo);
                if objMember.Find('-') then begin

                    phoneNumber := objMember."Mobile Phone No";
                    FAccNo := objMember."FOSA Account No.";
                    objMember.Password := NewPassword;
                    emailAddress := objMember."E-Mail";
                    objMember.Modify;
                    FnSMSMessage(FAccNo, phoneNumber, sms);
                    //emailAddress:=TRUE;
                end
            end
        end;
        exit(emailAddress);
    end;


    procedure MiniStatement(MemberNo: Text[100]) MiniStmt: Text
    var
        minimunCount: Integer;
        amount: Decimal;
        fosano: Code[100];
    begin
        begin
            MiniStmt := '';
            objMember.Reset;
            objMember.SetRange("No.", MemberNo);
            //  Vendor.RESET;
            //  Vendor.SETRANGE("BOSA Account No",MemberNo);
            //  Vendor.SETRANGE("No.", Fosano);

            if objMember.Find('-') then begin
                fosano := objMember."FOSA Account No.";

                Vendor.Reset;
                Vendor.SetRange("No.", fosano);
                if Vendor.Find('-') then
                    minimunCount := 1;
                Vendor.CalcFields(Vendor.Balance);
                VendorLedgEntry.SetCurrentkey(VendorLedgEntry."Entry No.");
                VendorLedgEntry.Ascending(false);
                VendorLedgEntry.SetRange(VendorLedgEntry."Vendor No.", fosano);
                VendorLedgEntry.SetRange(VendorLedgEntry.Reversed, false);
                if VendorLedgEntry.FindSet then begin
                    MiniStmt := '';
                    repeat
                        VendorLedgEntry.CalcFields(Amount);
                        amount := VendorLedgEntry.Amount;
                        if amount < 1 then amount := amount * -1;
                        MiniStmt := MiniStmt + Format(VendorLedgEntry."Posting Date") + ':::' + CopyStr(Format(VendorLedgEntry.Description), 1, 25) + ':::' +
                        Format(amount) + '::::';
                        minimunCount := minimunCount + 1;
                        if minimunCount > 20 then begin
                            exit(MiniStmt);
                        end
                    until VendorLedgEntry.Next = 0;
                end;

            end;

        end;
        exit(MiniStmt);
    end;


    procedure fnMemberStatement(MemberNo: Code[50]; "filter": Text; var BigText: BigText) exitString: Text
    var
        Filename: Text[100];
        Convert: dotnet Convert;
        Path: dotnet Path;
        _File: dotnet File;
        //FileAccess: dotnet//FileAccess;
        FileMode: dotnet FileMode;
        MemoryStream: dotnet MemoryStream;
        FileStream: dotnet FileStream;
        Outputstream: OutStream;
    begin

        objMember.Reset;
        objMember.SetRange(objMember."No.", MemberNo);


        if objMember.Find('-') then begin
            objMember.SetFilter("Date Filter", filter);
            Filename := Path.GetTempPath() + Path.GetRandomFileName();
            Report.SaveAsPdf(51516886, Filename, objMember);

            FileMode := 4;
            //FileAccess:=1;

            // FileStream:=_File.Open(Filename,FileMode,FileAccess);

            MemoryStream := MemoryStream.MemoryStream();

            MemoryStream.SetLength(FileStream.Length);
            FileStream.Read(MemoryStream.GetBuffer(), 0, FileStream.Length);

            BigText.AddText((Convert.ToBase64String(MemoryStream.GetBuffer())));
            Message(Format(BigText));
            // exitString:=BigText;
            //MESSAGE(exitString);
            MemoryStream.Close();
            MemoryStream.Dispose();
            FileStream.Close();
            FileStream.Dispose();
            _File.Delete(Filename);

        end;
    end;


    procedure fnFosaStatement(MemberNo: Code[50]; "filter": Text; var BigText: BigText)
    var
        Filename: Text[100];
        Convert: dotnet Convert;
        Path: dotnet Path;
        _File: dotnet File;
        //FileAccess: dotnet//FileAccess;
        FileMode: dotnet FileMode;
        MemoryStream: dotnet MemoryStream;
        FileStream: dotnet FileStream;
        Outputstream: OutStream;
    begin

        Vendor.Reset;
        Vendor.SetRange(Vendor."No.", MemberNo);


        if Vendor.Find('-') then begin
            //  objMember.SETFILTER("Date Filter", filter);
            Filename := Path.GetTempPath() + Path.GetRandomFileName();
            Report.SaveAsPdf(51516248, Filename, Vendor);

            FileMode := 4;
            //FileAccess:=1;

            //  FileStream:=_File.Open(Filename,FileMode,FileAccess);

            MemoryStream := MemoryStream.MemoryStream();

            MemoryStream.SetLength(FileStream.Length);
            FileStream.Read(MemoryStream.GetBuffer(), 0, FileStream.Length);

            BigText.AddText((Convert.ToBase64String(MemoryStream.GetBuffer())));
            Message(Format(BigText));
            // exitString:=BigText;
            //MESSAGE(exitString);
            MemoryStream.Close();
            MemoryStream.Dispose();
            FileStream.Close();
            FileStream.Dispose();
            _File.Delete(Filename);

        end;
    end;


    procedure fnFosaStatementArchived(MemberNo: Code[50]; "filter": Text; var BigText: BigText)
    var
        Filename: Text[100];
        Convert: dotnet Convert;
        Path: dotnet Path;
        _File: dotnet File;
        //FileAccess: dotnet//FileAccess;
        FileMode: dotnet FileMode;
        MemoryStream: dotnet MemoryStream;
        FileStream: dotnet FileStream;
        Outputstream: OutStream;
    begin

        Vendor.Reset;
        Vendor.SetRange(Vendor."No.", MemberNo);


        if Vendor.Find('-') then begin
            //  objMember.SETFILTER("Date Filter", filter);
            Filename := Path.GetTempPath() + Path.GetRandomFileName();
            Report.SaveAsPdf(51516890, Filename, Vendor);

            FileMode := 4;
            //FileAccess:=1;

            // FileStream:=_File.Open(Filename,FileMode,FileAccess);

            MemoryStream := MemoryStream.MemoryStream();

            MemoryStream.SetLength(FileStream.Length);
            FileStream.Read(MemoryStream.GetBuffer(), 0, FileStream.Length);

            BigText.AddText((Convert.ToBase64String(MemoryStream.GetBuffer())));
            Message(Format(BigText));
            // exitString:=BigText;
            //MESSAGE(exitString);
            MemoryStream.Close();
            MemoryStream.Dispose();
            FileStream.Close();
            FileStream.Dispose();
            _File.Delete(Filename);

        end;
    end;


    procedure fndividentstatement(No: Code[50]; Path: Text[100])
    var
        filename: Text;
        "Member No": Code[50];
    begin
        filename := FILESPATH + Path;
        if Exists(filename) then
            Erase(filename);
        objMember.Reset;
        objMember.SetRange(objMember."No.", No);

        if objMember.Find('-') then begin
            Report.SaveAsPdf(51516241, filename, objMember);

        end;
    end;


    procedure fnLoanGuranteed(MemberNo: Code[50]; "filter": Text; var BigText: BigText)
    var
        Filename: Text[100];
        Convert: dotnet Convert;
        Path: dotnet Path;
        _File: dotnet File;
        //FileAccess: dotnet//FileAccess;
        FileMode: dotnet FileMode;
        MemoryStream: dotnet MemoryStream;
        FileStream: dotnet FileStream;
        Outputstream: OutStream;
    begin

        objMember.Reset;
        objMember.SetRange(objMember."No.", MemberNo);


        if objMember.Find('-') then begin
            //  objMember.SETFILTER("Date Filter", filter);
            Filename := Path.GetTempPath() + Path.GetRandomFileName();
            Report.SaveAsPdf(51516503, Filename, objMember);

            FileMode := 4;
            //FileAccess:=1;

            //  FileStream:=_File.Open(Filename,FileMode,FileAccess);

            MemoryStream := MemoryStream.MemoryStream();

            MemoryStream.SetLength(FileStream.Length);
            FileStream.Read(MemoryStream.GetBuffer(), 0, FileStream.Length);

            BigText.AddText((Convert.ToBase64String(MemoryStream.GetBuffer())));
            Message(Format(BigText));
            // exitString:=BigText;
            //MESSAGE(exitString);
            MemoryStream.Close();
            MemoryStream.Dispose();
            FileStream.Close();
            FileStream.Dispose();
            _File.Delete(Filename);

        end;
    end;


    procedure fnLoanRepaymentShedule(MemberNo: Code[50]; var BigText: BigText)
    var
        Filename: Text[100];
        Convert: dotnet Convert;
        Path: dotnet Path;
        _File: dotnet File;
        //FileAccess: dotnet//FileAccess;
        FileMode: dotnet FileMode;
        MemoryStream: dotnet MemoryStream;
        FileStream: dotnet FileStream;
        Outputstream: OutStream;
    begin
        Message(FILESPATH);
        if Exists(Filename) then
            Erase(Filename);
        objLoanRegister.Reset;
        objLoanRegister.SetRange(objLoanRegister."Loan  No.", MemberNo);
        Filename := Path.GetTempPath() + Path.GetRandomFileName();
        if objLoanRegister.Find('-') then begin
            Report.SaveAsPdf(50477, Filename, objLoanRegister);
            FileMode := 4;
            //FileAccess:=1;

            //  FileStream:=_File.Open(Filename,FileMode,FileAccess);

            MemoryStream := MemoryStream.MemoryStream();

            MemoryStream.SetLength(FileStream.Length);
            FileStream.Read(MemoryStream.GetBuffer(), 0, FileStream.Length);

            BigText.AddText((Convert.ToBase64String(MemoryStream.GetBuffer())));
            Message(Format(BigText));
            // exitString:=BigText;
            //MESSAGE(exitString);
            MemoryStream.Close();
            MemoryStream.Dispose();
            FileStream.Close();
            FileStream.Dispose();
            _File.Delete(Filename);

        end;
    end;


    procedure fnLoanGurantorsReport(MemberNo: Code[50]; "filter": Text; var BigText: BigText)
    var
        Filename: Text[100];
        Convert: dotnet Convert;
        Path: dotnet Path;
        _File: dotnet File;
        //FileAccess: dotnet//FileAccess;
        FileMode: dotnet FileMode;
        MemoryStream: dotnet MemoryStream;
        FileStream: dotnet FileStream;
        Outputstream: OutStream;
    begin

        objMember.Reset;
        objMember.SetRange(objMember."No.", MemberNo);


        if objMember.Find('-') then begin
            //  objMember.SETFILTER("Date Filter", filter);
            Filename := Path.GetTempPath() + Path.GetRandomFileName();
            Report.SaveAsPdf(51516504, Filename, objMember);

            FileMode := 4;
            //FileAccess:=1;

            //  FileStream:=_File.Open(Filename,FileMode,FileAccess);

            MemoryStream := MemoryStream.MemoryStream();

            MemoryStream.SetLength(FileStream.Length);
            FileStream.Read(MemoryStream.GetBuffer(), 0, FileStream.Length);

            BigText.AddText((Convert.ToBase64String(MemoryStream.GetBuffer())));
            Message(Format(BigText));
            // exitString:=BigText;
            //MESSAGE(exitString);
            MemoryStream.Close();
            MemoryStream.Dispose();
            FileStream.Close();
            FileStream.Dispose();
            _File.Delete(Filename);

        end;
    end;


    procedure fnAtmApplications(Account: Code[100])
    var
        SaccoSetup: Record "Sacco No. Series";
        NoSeriesMgmt: Codeunit NoSeriesManagement;
    begin
        /*
        SaccoSetup.GET();
        SaccoSetup.TESTFIELD("ATM Applications");
        objAtmapplication.INIT;
        objAtmapplication."Account No":=NoSeriesMgmt.GetNextNo(SaccoSetup."ATM Applications",0D,TRUE);
        objAtmapplication."Branch Code":=Account;
        objAtmapplication."Card No":=TODAY;
        objAtmapplication."Application Date":=objAtmapplication."Application Date"::"0";
        objAtmapplication."Date Activated":=objAtmapplication."Date Activated"::"0";
        objAtmapplication.VALIDATE(objAtmapplication."Branch Code");
        objAtmapplication.INSERT;
        */

    end;


    procedure fnAtmBlocking(Account: Code[100]; ReasonForBlock: Text[250])
    begin
        /*
        objAtmapplication.RESET;
        objAtmapplication.SETRANGE(objAtmapplication."Branch Code",Account);
        IF objAtmapplication.FIND('-') THEN BEGIN
        objAtmapplication."Date Activated":=objAtmapplication."Date Activated"::"2";
        objAtmapplication."Reason for Account blocking":=ReasonForBlock;
        objAtmapplication.MODIFY;
        END;
        */

    end;


    procedure fnChangePassword(memberNumber: Code[100]; currentPass: Text; newPass: Text) updated: Boolean
    begin
        sms := 'You have successfully updated your password.';
        updated := false;
        objMember.Reset;
        objMember.SetRange(objMember."No.", memberNumber);
        objMember.SetRange(objMember.Password, currentPass);
        if objMember.Find('-') then
            objMember.Password := newPass;
        phoneNumber := objMember."Mobile Phone No";
        FAccNo := objMember."FOSA Account No.";
        updated := objMember.Modify;
        Message('Successful pass change');
        FnSMSMessage(FAccNo, phoneNumber, sms);
        exit(updated);
    end;


    procedure fnTotalRepaidGraph(Mno: Code[10]; year: Code[10]) total: Decimal
    begin
        objMember.Reset;
        objMember.SetRange("No.", Mno);
        if objMember.Find('-') then begin

            objMember.SetFilter("Date Filter", '0101' + year + '..1231' + year);
            //objMember.CALCFIELDS("Current Shares");
            total := objMember."Total Repayments";
            Message('current repaid is %1', total);
        end;
    end;


    procedure fnCurrentShareGraph(Mno: Code[10]; year: Code[10]) total: Decimal
    begin
        objMember.Reset;
        objMember.SetRange("No.", Mno);
        if objMember.Find('-') then begin

            objMember.SetFilter("Date Filter", '0101' + year + '..1231' + year);
            objMember.CalcFields("Current Shares");
            total := objMember."Current Shares";
            Message('current shares is %1', total);
        end;
    end;


    procedure fnTotalDepositsGraph(Mno: Code[10]; year: Code[10]) total: Decimal
    begin
        objMember.Reset;
        objMember.SetRange("No.", Mno);
        if objMember.Find('-') then begin

            objMember.SetFilter("Date Filter", '0101' + year + '..1231' + year);
            objMember.CalcFields("Shares Retained");
            total := objMember."Shares Retained";
            Message('current deposits is %1', total);
        end;
    end;


    procedure FnRegisterKin("Full Names": Text; Relationship: Text; "ID Number": Code[10]; "Phone Contact": Code[10]; Address: Text; Idnomemberapp: Code[10])
    begin
        begin
            objRegMember.Reset;
            objNextKin.Reset;
            objNextKin.Init();
            objRegMember.SetRange("ID No.", Idnomemberapp);
            if objRegMember.Find('-') then begin
                objNextKin."Account No" := objRegMember."No.";
                objNextKin.Name := "Full Names";
                objNextKin.Relationship := Relationship;
                objNextKin."ID No." := "ID Number";
                objNextKin.Telephone := "Phone Contact";
                objNextKin.Address := Address;
                objNextKin.Insert(true);
            end;
        end;
    end;


    procedure FnMemberApply("First Name": Code[30]; "Mid Name": Code[30]; "Last Name": Code[30]; "PO Box": Text; Residence: Code[30]; "Postal Code": Text; Town: Code[30]; "Phone Number": Code[30]; Email: Text; "ID Number": Code[30]; "Branch Code": Code[30]; "Branch Name": Code[30]; "Account Number": Code[30]; Gender: Option; "Marital Status": Option; "Account Category": Option; "Application Category": Option; "Customer Group": Code[30]; "Employer Name": Code[30]; "Date of Birth": Date) num: Text
    begin
        begin

            objRegMember.Reset;
            objRegMember.SetRange("ID No.", "ID Number");
            if objRegMember.Find('-') then begin
                Message('already registered');
            end
            else begin
                objRegMember.Init;
                objRegMember.Name := "First Name" + ' ' + "Mid Name" + ' ' + "Last Name";
                objRegMember.Address := "PO Box";
                objRegMember."Address 2" := Residence;
                objRegMember."Postal Code" := "Postal Code";
                objRegMember.Town := Town;
                objRegMember."Mobile Phone No" := "Phone Number";
                objRegMember."E-Mail (Personal)" := Email;
                objRegMember."Date of Birth" := "Date of Birth";
                objRegMember."ID No." := "ID Number";
                objRegMember."Bank Code" := "Branch Code";
                objRegMember."Bank Name" := "Branch Name";
                objRegMember."Bank Account No" := "Account Number";
                objRegMember.Gender := Gender;
                objRegMember."Created By" := UserId;
                objRegMember."Global Dimension 1 Code" := 'BOSA';
                objRegMember."Date of Registration" := Today;
                objRegMember.Status := objRegMember.Status::Open;
                objRegMember."Application Category" := "Application Category";
                objRegMember."Account Category" := "Account Category";
                objRegMember."Marital Status" := "Marital Status";
                objRegMember."Employer Name" := "Employer Name";
                objRegMember."Customer Posting Group" := "Customer Group";
                objRegMember.Insert(true);
            end;


            //FnRegisterKin('','','','','');
        end;
    end;

    local procedure FnFreeShares("Member No": Text) Shares: Text
    begin
        begin
            begin
                GenSetup.Get();
                FreeShares := 0;
                glamount := 0;

                objMember.Reset;
                objMember.SetRange(objMember."No.", "Member No");
                if objMember.Find('-') then begin
                    objMember.CalcFields("Current Shares");
                    LoansGuaranteeDetails.Reset;
                    LoansGuaranteeDetails.SetRange(LoansGuaranteeDetails."Member No", objMember."No.");
                    LoansGuaranteeDetails.SetRange(LoansGuaranteeDetails.Substituted, false);
                    if LoansGuaranteeDetails.Find('-') then begin
                        repeat
                            glamount := glamount + LoansGuaranteeDetails."Amont Guaranteed";
                        //MESSAGE('Member No %1 Account no %2',Members."No.",glamount);
                        until LoansGuaranteeDetails.Next = 0;
                    end;
                    FreeShares := (objMember."Current Shares" * GenSetup."Contactual Shares (%)") - glamount;
                    Shares := Format(FreeShares, 0, '<Precision,2:2><Integer><Decimals>');
                end;
            end;
        end;
    end;


    procedure FnStandingOrders(BosaAcNo: Code[30]; SourceAcc: Code[50]; frequency: Text; Duration: Text; DestAccNo: Code[30]; StartDate: Date; Amount: Decimal; DestAccType: Option)
    begin
        objStandingOrders.Init();
        objStandingOrders."BOSA Account No." := BosaAcNo;
        objStandingOrders."Source Account No." := SourceAcc;
        objStandingOrders.Validate(objStandingOrders."Source Account No.");
        if Format(freq) = '' then
            Evaluate(freq, frequency);
        objStandingOrders.Frequency := freq;
        if Format(dur) = '' then
            Evaluate(dur, Duration);
        objStandingOrders.Duration := dur;
        objStandingOrders."Destination Account No." := DestAccNo;
        objStandingOrders.Validate(objStandingOrders."Destination Account No.");
        objStandingOrders."Destination Account Type" := DestAccType;
        objStandingOrders.Amount := Amount;
        objStandingOrders."Effective/Start Date" := StartDate;
        objStandingOrders.Validate(objStandingOrders.Duration);
        objStandingOrders.Status := objStandingOrders.Status::Open;
        //objStandingOrders.Source:='WEBPORTAL';
        objStandingOrders.Insert(true);
        objMember.Reset;
        objMember.SetRange(objMember."No.", BosaAcNo);
        if objMember.Find('-') then begin
            phoneNumber := objMember."Phone No.";
            sms := 'You have created a standing order of amount : ' + Format(Amount) + ' from Account ' + SourceAcc + ' start date: '
                  + Format(StartDate) + '. Thanks for using SURESTEP SACCO Portal.';
            FnSMSMessage(SourceAcc, phoneNumber, sms);
            //MESSAGE('All Cool');
        end
    end;


    procedure FnUpdateMonthlyContrib("Member No": Code[30]; "Updated Fig": Decimal)
    begin
        objMember.Reset;
        objMember.SetRange(objMember."No.", "Member No");

        if objMember.Find('-') then begin
            phoneNumber := objMember."Phone No.";
            FAccNo := objMember."FOSA Account No.";
            objMember."Monthly Contribution" := "Updated Fig";
            objMember.Modify;
            sms := 'You have adjusted your monthly contributions to: ' + Format("Updated Fig") + ' account number ' + FAccNo +
                  '. Thank you for using UNITED WOMEN Sacco Portal';
            FnSMSMessage(FAccNo, phoneNumber, sms);

            //MESSAGE('Updated');
        end
    end;


    procedure FnSMSMessage(accfrom: Text[30]; phone: Text[20]; message: Text[250])
    begin

        SMSMessages.Reset;
        if SMSMessages.Find('+') then begin
            iEntryNo := SMSMessages."Entry No";
            iEntryNo := iEntryNo + 1;
        end
        else begin
            iEntryNo := 1;
        end;
        SMSMessages.Init;
        SMSMessages."Entry No" := iEntryNo;
        //SMSMessages."Batch No":=documentNo;
        //SMSMessages."Document No":=documentNo;
        SMSMessages."Account No" := accfrom;
        SMSMessages."Date Entered" := Today;
        SMSMessages."Time Entered" := Time;
        SMSMessages.Source := 'WEBPORTAL';
        SMSMessages."Entered By" := UserId;
        SMSMessages."Sent To Server" := SMSMessages."sent to server"::No;
        SMSMessages."SMS Message" := message;
        SMSMessages."Telephone No" := phone;
        if SMSMessages."Telephone No" <> '' then
            SMSMessages.Insert;
    end;


    procedure FnLoanApplication(Member: Code[30]; LoanProductType: Code[10]; AmountApplied: Decimal; LoanPurpose: Code[30]; RepaymentFrequency: Integer; LoanConsolidation: Boolean; LoanBridging: Boolean; LoanRefinancing: Boolean) Result: Boolean
    begin
        //objMember.RESET;
        //objMember.SETRANGE(objMember."No.", Member);
        // IF objMember.FIND('-') THEN BEGIN
        //
        //   objLoanApplication.RESET;
        //   objLoanApplication.INIT;
        //    objLoanApplication.INSERT(TRUE);
        //  // objLoanApplication.Type:=objLoanApplication.Type::"Loan Form";
        //   objLoanApplication."Account No":=Member;
        //   objLoanApplication.VALIDATE(objLoanApplication."Account No");
        //
        //   objLoanApplication."Loan Type" :=LoanProductType;
        //
        //   objLoanApplication."Captured by":=USERID;
        //   objLoanApplication.Amount:=AmountApplied;
        //   objLoanApplication."Purpose of loan":=LoanPurpose;
        //   objLoanApplication."Repayment Period" :=RepaymentFrequency;
        //   objLoanApplication."Loan Bridging":=LoanBridging;
        //   objLoanApplication."Loan Consolidation":=LoanConsolidation;
        //   objLoanApplication."Loan Refinancing":=LoanRefinancing;
        //   objLoanApplication.Submited:=TRUE;
        //  objLoanApplication.MODIFY;
        //
        //
        // END;

        //***********insert******************//
        // objLoanApplication.RESET;
        // objLoanApplication.SETRANGE(objLoanApplication."Account No", Member);
        // objLoanApplication.SETRANGE(objLoanApplication.Type,objLoanApplication.Type::"Loan Form");
        //objLoanApplication.SETCURRENTKEY("Capture Date");
        //IF objLoanApplication.FINDLAST THEN
        //FormNo:=objLoanApplication.No;
        //objLoanApplication.SETRANGE(objLoanApplication.No,FormNo);
        //IF objLoanApplication.FIND('-') THEN
        //  BEGIN
        objLoanRegister.Init;
        objLoanRegister."Client Code" := Member;
        //   objLoanRegister.INSERT(TRUE);

        objLoanRegister.Validate("Client Code");
        objLoanRegister."Loan Product Type" := LoanProductType;
        objLoanRegister.Validate("Loan Product Type");
        objLoanRegister.Installments := RepaymentFrequency;
        objLoanRegister.Validate(Installments);
        objLoanRegister."Requested Amount" := AmountApplied;
        //  objLoanRegister.VALIDATE("Requested Amount");
        objLoanRegister."Product Code" := 'BOSA';
        objLoanRegister."Captured By" := UserId;
        objLoanRegister."Loan Purpose" := LoanPurpose;
        Message(objLoanRegister."Loan  No.");

        objLoanRegister.Source := objLoanRegister.Source::FOSA;
        //  objLoanRegister.VALIDATE("Requested Amount");
        objLoanRegister."Loan Status" := objLoanRegister."loan status"::Application;

        objLoanRegister.Insert(true);
        Message('here');
        Result := true;
        phoneNumber := objMember."Phone No.";
        ClientName := objMember."FOSA Account No.";
        sms := 'We have received your ' + LoanProductType + ' loan application of  amount : ' + Format(AmountApplied) +
        '. We are processing your loan, you will hear from us soon. Thanks for using UNITED WOMEN SACCO  Portal.';
        FnSMSMessage(ClientName, phoneNumber, sms);
        //PortaLuPS.INIT;
        // PortaLuPS.INSERT(TRUE);
        objLoanRegister.Reset;
        objLoanRegister.SetRange("Client Code", Member);
        objLoanRegister.SetCurrentkey("Application Date");
        objLoanRegister.Ascending(true);
        if objLoanRegister.FindLast
          then begin
        end;
    end;


    procedure FnDepositsStatement(MemberNo: Code[50]; var BigText: BigText)
    var
        Filename: Text[100];
        Convert: dotnet Convert;
        Path: dotnet Path;
        _File: dotnet File;
        //FileAccess: dotnet//FileAccess;
        FileMode: dotnet FileMode;
        MemoryStream: dotnet MemoryStream;
        FileStream: dotnet FileStream;
        Outputstream: OutStream;
    begin
        //Filename2:=FILEPATHMEM+path;

        objMember.Reset;
        objMember.SetRange(objMember."No.", MemberNo);

        Filename := Path.GetTempPath() + Path.GetRandomFileName();
        if objMember.Find('-') then begin
            Report.SaveAsPdf(51516224, Filename, objMember);
            FileMode := 4;
            //FileAccess:=1;

            // FileStream:=_File.Open(Filename,FileMode,FileAccess);

            MemoryStream := MemoryStream.MemoryStream();

            MemoryStream.SetLength(FileStream.Length);
            FileStream.Read(MemoryStream.GetBuffer(), 0, FileStream.Length);

            BigText.AddText((Convert.ToBase64String(MemoryStream.GetBuffer())));
            Message(Format(BigText));
            // exitString:=BigText;
            //MESSAGE(exitString);
            MemoryStream.Close();
            MemoryStream.Dispose();
            FileStream.Close();
            FileStream.Dispose();
            _File.Delete(Filename);

        end;
    end;


    procedure FnDepositsStatementArchived("Account No": Code[30]; path: Text[100])
    var
        Filename: Text[100];
    begin
        Filename := FILESPATH + path;
        Message(FILESPATH);
        if Exists(Filename) then
            Erase(Filename);
        objMember.Reset;
        objMember.SetRange(objMember."No.", "Account No");

        if objMember.Find('-') then begin
            Report.SaveAsPdf(51516354, Filename, objMember);
        end;
    end;


    procedure FnLoanStatement(MemberNo: Code[50]; "filter": Text; var BigText: BigText)
    var
        Filename: Text[100];
        Convert: dotnet Convert;
        Path: dotnet Path;
        _File: dotnet File;
        //FileAccess: dotnet//FileAccess;
        FileMode: dotnet FileMode;
        MemoryStream: dotnet MemoryStream;
        FileStream: dotnet FileStream;
        Outputstream: OutStream;
    begin
        objMember.Reset;
        objMember.SetRange(objMember."No.", MemberNo);

        objLoanRegister.Reset;
        objLoanRegister.SetRange(objLoanRegister."Client Code", MemberNo);


        if objLoanRegister.Find('-') then begin
            //  objMember.SETFILTER("Date Filter", filter);
            Filename := Path.GetTempPath() + Path.GetRandomFileName();
            Report.SaveAsPdf(50477, Filename, objLoanRegister);
            Message(Filename);

            FileMode := 4;
            //FileAccess:=1;

            //   FileStream:=_File.Open(Filename,FileMode,FileAccess);

            MemoryStream := MemoryStream.MemoryStream();

            MemoryStream.SetLength(FileStream.Length);
            FileStream.Read(MemoryStream.GetBuffer(), 0, FileStream.Length);

            BigText.AddText((Convert.ToBase64String(MemoryStream.GetBuffer())));
            Message(Format(BigText));
            // exitString:=BigText;
            //MESSAGE(exitString);
            MemoryStream.Close();
            MemoryStream.Dispose();
            FileStream.Close();
            FileStream.Dispose();
            _File.Delete(Filename);

        end;
    end;


    procedure Fnlogin(username: Code[20]; password: Text) status: Boolean
    begin
        objMember.Reset;
        objMember.SetRange(objMember."No.", username);
        objMember.SetRange(Password, password);
        if objMember.Find('-') then begin
            status := true;
        end
        else
            status := false;
    end;


    procedure FnmemberNo(IdNo: Code[20]) memberno: Code[10]
    begin
        objMember.Reset;
        objMember.SetRange(objMember."ID No.", IdNo);
        if objMember.Find('-') then begin
            memberno := objMember."No.";
        end
    end;


    procedure FnmemberInfo(MemberNo: Code[20]) info: Text
    begin
        objMember.Reset;
        objMember.SetRange(objMember."No.", MemberNo);
        if objMember.Find('-') then begin
            info := objMember."No." + '.' + ':' + objMember.Name + '.' + ':' + objMember."E-Mail" + '.' + ':' + Format(objMember.Status) + '.' + ':' + Format(objMember."Account Category") + '.' + ':' + objMember."Mobile Phone No"
            + '.' + ':' + objMember."ID No." + '.' + ':' + objMember."FOSA Account No.";
        end
        else
            objMember.Reset;
        objMember.SetRange(objMember."ID No.", MemberNo);
        if objMember.Find('-') then begin
            info := objMember."No." + '.' + ':' + objMember.Name + '.' + ':' + objMember."E-Mail" + '.' + ':' + objMember."Employer Name" + '.' + ':' + Format(objMember."Account Category") + '.' + ':' + objMember."Mobile Phone No"
            + '.' + ':' + objMember."Bank Code" + '.' + ':' + objMember."Bank Account No." + '.' + ':' + objMember."FOSA Account No.";

        end;
    end;


    procedure fnAccountInfo(Memberno: Code[20]) info: Text
    var
        FOSAbal: Text;
    begin
        objMember.Reset;
        objMember.SetRange(objMember."No.", Memberno);

        if objMember.Find('-') then begin

            FOSAbal := FNFosaBalance(objMember."FOSA Account No.");
            objMember.CalcFields("Total Committed Shares");
            objMember.CalcFields("Current Shares");
            //objMember.CALCFIELDS("Demand Savings");
            objMember.CalcFields("Shares Retained");
            info := Format(objMember."Shares Retained") + ':' + Format(objMember."Shares Retained") + ':' + Format(objMember."Current Shares") + ':'
            + Format(objMember."Total Committed Shares") + ':' + FNFosaBalance(objMember."FOSA Account No.");
        end;
        //FORMAT(amount,0,'<Precision,2:2><Integer><Decimals>');
    end;


    procedure fnloaninfo(Memberno: Code[20]) info: Text
    begin
        objMember.Reset;
        objMember.SetRange(objMember."No.", Memberno);
        if objMember.Find('-') then begin
            objMember.CalcFields("Outstanding Balance");
            objMember.CalcFields("Outstanding Interest");
            info := Format(objMember."Outstanding Balance") + ':' + Format(objMember."Outstanding Interest", 0, '<Precision,2:2><Integer><Decimals>');
        end;
    end;


    procedure fnLoans(MemberNo: Code[20]) loans: Text
    var
        loanlist: Text;
    begin
        objLoanRegister.Reset;
        objLoanRegister.SetRange("Client Code", MemberNo);
        //objLoanRegister.SETRANGE("Loan Status",objLoanRegister."Loan Status"::Appraisal);
        //objLoanRegister.SETRANGE("Loan Status",objLoanRegister."Loan Status"::Approval1);
        //objLoanRegister.SETRANGE("Loan Status",objLoanRegister."Loan Status"::Approved);
        //objLoanRegister.SETRANGE("Loan Status",objLoanRegister."Loan Status"::"Being Repaid");
        if objLoanRegister.Find('-') then begin
            //objLoanRegister.SETCURRENTKEY("Application Date");
            //objLoanRegister.ASCENDING(FALSE);

            repeat
                //Loanperiod:=Kentoursfactory.KnGetCurrentPeriodForLoan(objLoanRegister."Loan  No.");

                objLoanRegister.CalcFields("Outstanding Balance");
                loanlist := loanlist + '::::' + objLoanRegister."Loan Product Type Name" + ':' + Format(objLoanRegister."Outstanding Balance") + ':' + Format(objLoanRegister."Loan Status") + ':' + Format(objLoanRegister.Installments) + ':'
                  + Format(objLoanRegister.Installments - Loanperiod) + ':' + Format(objLoanRegister."Approved Amount") + ':' + Format(objLoanRegister."Requested Amount") + ':' + objLoanRegister."Loan  No." + '::::';

            until objLoanRegister.Next = 0;
            loans := loanlist;

        end;
    end;


    procedure FnloanCalc(LoanAmount: Decimal; RepayPeriod: Integer; LoanCode: Code[30]) text: Text
    begin
        Loansetup.Reset;
        Loansetup.SetRange(Code, LoanCode);

        if Loansetup.Find('-') then begin

            if Loansetup."Repayment Method" = Loansetup."repayment method"::Amortised then begin
                // LoansRec.TESTFIELD(LoansRec.Interest);
                // LoansRec.TESTFIELD(LoansRec.Installments);
                TotalMRepay := ROUND((Loansetup."Interest rate" / 12 / 100) / (1 - Power((1 + (Loansetup."Interest rate" / 12 / 100)), -(RepayPeriod))) * (LoanAmount), 0.0001, '>');
                LInterest := ROUND(LBalance / 100 / 12 * InterestRate, 0.0001, '>');
                LPrincipal := TotalMRepay - LInterest;
                //MESSAGE(FORMAT(TotalMRepay));
                text := text + Format(Date) + '!!' + Format(ROUND(LPrincipal)) + '!!' + Format(ROUND(LInterest)) + '!!' + Format(ROUND(TotalMRepay)) + '!!' + Format(ROUND(LoanAmount)) + '??';

            end;

            /*IF  Loansetup."Repayment Method"= Loansetup."Repayment Method"::"Straight Line" THEN BEGIN
            LoansRec.TESTFIELD(LoansRec.Interest);
            LoansRec.TESTFIELD(LoansRec.Installments);
            LPrincipal:=LoanAmount/RepayPeriod;
            LInterest:=(Loansetup."Interest rate"/12/100)*LoanAmount/RepayPeriod;

            END;*/
            /*
              IF  Loansetup."Repayment Method"= Loansetup."Repayment Method"::"Reducing Balance" THEN BEGIN
              //LoansRec.TESTFIELD(LoansRec.Interest);
              //LoansRec.TESTFIELD(LoansRec.Installments);
              MESSAGE('type is %1',LoanCode);
               Date:=TODAY;

            //    //MESSAGE('HERE');
            //  // TotalMRepay:=ROUND((Loansetup."Interest Rate2"/12/100) / (1 - POWER((1 +(Loansetup."Interest Rate2"/12/100)),- (RepayPeriod))) * (LoanAmount),0.0001,'>');
            //   REPEAT
            //  LInterest:=ROUND(LoanAmount * Loansetup."Interest Rate2"/12/100,0.0001,'>');
            //  LPrincipal:=TotalMRepay-LInterest;
            //    LoanAmount:=LoanAmount-LPrincipal;
            // RepayPeriod:= RepayPeriod-1;
            //
            //  text:=text+FORMAT(Date)+'!!'+FORMAT(ROUND( LPrincipal))+'!!'+FORMAT(ROUND( LInterest))+'!!'+FORMAT(ROUND(TotalMRepay))+'!!'+FORMAT(ROUND(LoanAmount))+'??';
            //  Date:=CALCDATE('+1M', Date);
            //
            //  UNTIL RepayPeriod=0;

              // ELSE BEGIN
              TotalMRepay:=ROUND((Loansetup."Interest rate"/12/100) / (1 - POWER((1 +(Loansetup."Interest rate"/12/100)),- (RepayPeriod))) * (LoanAmount),0.0001,'>');
               REPEAT
              LInterest:=ROUND(LoanAmount * Loansetup."Interest rate"/12/100,0.0001,'>');
              LPrincipal:=TotalMRepay-LInterest;
                LoanAmount:=LoanAmount-LPrincipal;
             RepayPeriod:= RepayPeriod-1;

              text:=text+FORMAT(Date)+'!!'+FORMAT(ROUND( LPrincipal))+'!!'+FORMAT(ROUND( LInterest))+'!!'+FORMAT(ROUND(TotalMRepay))+'!!'+FORMAT(ROUND(LoanAmount))+'??';
              Date:=CALCDATE('+1M', Date);

              UNTIL RepayPeriod=0;
              END;
              */
            /*IF  Loansetup."Repayment Method"= Loansetup."Repayment Method"::Constants THEN BEGIN
            LoansRec.TESTFIELD(LoansRec.Repayment);
            IF LBalance < LoansRec.Repayment THEN
            LPrincipal:=LBalance
            ELSE
            LPrincipal:=LoansRec.Repayment;
            LInterest:=LoansRec.Interest;
            END;
            */


            //END;

            //EXIT(Amount);
        end;

    end;


    procedure Fnloanssetup() loanType: Text
    begin
        Loansetup.Reset;
        //Loansetup.SETRANGE(Source, Loansetup.Source::FOSA);
        if Loansetup.Find('-') then begin
            loanType := '';
            repeat
                loanType := Format(Loansetup.Code) + ':' + Loansetup."Product Description" + ':::' + loanType;
            until Loansetup.Next = 0;
        end;
    end;


    procedure fnLoanDetails(Loancode: Code[20]) loandetail: Text
    begin
        Loansetup.Reset;
        //Loansetup.SETRANGE(Code, Loancode);
        if Loansetup.Find('-') then begin
            repeat
                loandetail := loandetail + Loansetup."Product Description" + '!!' + Format(Loansetup."Repayment Method") + '!!' + Format(Loansetup."Max. Loan Amount") + '!!' + Format(Loansetup."Instalment Period") + '!!' + Format(Loansetup."Interest rate") + '!!'
                + Format(Loansetup."Repayment Frequency") + '??';
            until Loansetup.Next = 0;
        end;
    end;


    procedure fnFeedback(No: Code[20]; Comment: Text[200])
    begin
        /*
        objMember.RESET;
        objMember.SETRANGE("No.", No);
        IF objMember.FIND('-') THEN BEGIN
         IF feedback.FIND('+') THEN
         feedback.Entry:=feedback.Entry+1
         ELSE
         feedback.Entry:=1;
         feedback.No:=No;
         feedback.Portalfeedback:=Comment;
         feedback.DatePosted:=TODAY;
         feedback.INSERT(TRUE)


        END
        ELSE
        EXIT;
        */

    end;


    procedure fnLoansPurposes() LoanType: Text
    begin
        LoansPurpose.Reset;
        begin
            LoanType := '';
            repeat
                LoanType := Format(LoansPurpose.Code) + ':' + LoansPurpose.Description + ':::' + LoanType;
            until LoansPurpose.Next = 0;
        end;
    end;


    procedure fnReplys(No: Code[20]) text: Text
    begin
        /*
        feedback.RESET;
        feedback.SETRANGE(No, No);
        feedback.SETCURRENTKEY(Entry);
        feedback.ASCENDING(FALSE);
        IF feedback.FIND('-') THEN BEGIN
          REPEAT
             IF(feedback.Reply ='') THEN BEGIN

         END ELSE
            text:=text+FORMAT(feedback.DatePosted)+'!!'+feedback.Portalfeedback+'!!'+ feedback.Reply+'??';
        UNTIL feedback.NEXT=0;
        END;
       */

    end;


    procedure FnNotifications("Member No": Code[10]; path: Text) text: Text
    var
        Filename: Text[100];
    begin
        Filename := FILESPATH + path;
        if Exists(Filename) then
            Erase(Filename);
        objLoanRegister.Reset;
        objLoanRegister.SetRange("Loan  No.", "Member No");

        if objLoanRegister.Find('-') then begin
            Report.SaveAsPdf(51516964, Filename, objLoanRegister);

        end;
    end;


    procedure fnGuarantorsPortal(Member: Code[40]; Number: Code[40]; LoanNo: Code[40]; Message: Text[100])
    begin
        /*
        objMember.RESET;
        objMember.SETRANGE("No.", Member);
        IF objMember.FIND('-') THEN BEGIN
         IF feedback.FIND('+') THEN
         feedback.Entry:=feedback.Entry+1
         ELSE
         feedback.Entry:=1;
         feedback.No:=Member;
         feedback.LoanNo:=LoanNo;
        // feedback.Portalfeedback:=Message;
         feedback.DatePosted:=TODAY;
        feedback.Guarantor:=Number;

        //feedback.LoanNo:=objLoanRegister."Loan  No.";
        feedback.Accepted:=0;
        feedback.Rejected:=0;
         feedback.INSERT(TRUE)


        END
        ELSE
        EXIT;
        */

    end;


    procedure FnApproveGurarantors(Approval: Integer; Number: Code[40]; LoanNo: Integer; reply: Text; Amount: Decimal)
    begin
        /*
         feedback.INIT;
         IF (Approval=0) THEN BEGIN
            feedback.SETRANGE(Entry,LoanNo);
        feedback.SETRANGE(Guarantor, Number);
        IF feedback.FIND ('-') THEN BEGIN
        
        
          feedback.Accepted:=0;
          feedback.Rejected:=1;
          feedback.MODIFY;
          END;
          END
        
         ELSE IF Approval=1 THEN BEGIN
        feedback.RESET;
        
        feedback.SETRANGE(Entry,LoanNo);
        feedback.SETRANGE(Guarantor, Number);
        IF feedback.FIND ('-') THEN BEGIN
        
        
          feedback.Accepted:=1;
          feedback.Rejected:=0;
          feedback.Amount:=Amount;
        objMember.SETRANGE("No.", Number);
        IF objMember.FIND('-') THEN
        
        
        reply:=objMember.Name+' '+'Has accepted to quarntee your loan';
        
        objLoanRegister.RESET;
        objLoanRegister.SETRANGE("Loan  No.",feedback.LoanNo);
        MESSAGE(feedback.LoanNo);
        IF objLoanRegister.FIND('-') THEN
        reply:=reply+ 'of amount '+ FORMAT(objLoanRegister."Requested Amount");
        LoansGuaranteeDetails.INIT;
        LoansGuaranteeDetails.CALCFIELDS("Loanees  No");
        
        LoansGuaranteeDetails."Member No":=Number;
        LoansGuaranteeDetails.VALIDATE("Member No");
        LoansGuaranteeDetails.VALIDATE("Substituted Guarantor");
        LoansGuaranteeDetails."Loan No":=feedback.LoanNo;
        LoansGuaranteeDetails.VALIDATE("Loan No");
        LoansGuaranteeDetails."Amont Guaranteed":=Amount;
        LoansGuaranteeDetails.VALIDATE("Amont Guaranteed");
        PortaLuPS.SETRANGE(LaonNo, feedback.LoanNo);
        IF PortaLuPS.FIND('-') THEN BEGIN
         // PortaLuPS.INIT;
        PortaLuPS.TotalGuaranteed:=PortaLuPS.TotalGuaranteed+Amount;
        PortaLuPS.MODIFY;
        
        //LoansGuaranteeDetails.VALIDATE("Amont Guaranteed");
        //LoansGuaranteeDetails."Loanees  No":=feedback.No;
        
        //LoansGuaranteeDetails.VALIDATE("Loanees  No");
        feedback.Reply:=reply;
        feedback.MODIFY;
        LoansGuaranteeDetails.INSERT;
        END;
        END;
        END;
        */

    end;


    procedure FNAppraisalLoans(Member: Code[10]) loans: Text
    begin
        objLoanRegister.Reset;
        objLoanRegister.SetRange("Client Code", Member);
        if objLoanRegister.Find('-') then begin
            objLoanRegister.SetCurrentkey("Application Date");

            // objLoanRegister.ASCENDING(FALSE);
            objLoanRegister.SetFilter("Loan Status", '=%1', objLoanRegister."loan status"::Application);
            objLoanRegister.SetFilter("Requested Amount", '>%1', 0);
            // objLoanRegister."Loan Status"::Appraisal;
            repeat
                objLoanRegister.CalcFields("Total Loans Outstanding");
                loans := loans + objLoanRegister."Loan  No." + ':' + objLoanRegister."Loan Product Type" + ':' + Format(objLoanRegister."Requested Amount") + '::';
            until
              objLoanRegister.Next = 0;
        end;
    end;


    procedure FnGetLoansForGuarantee(Member: Code[40]) Guarantee: Text
    begin
        /*
        feedback.RESET;
        feedback.SETRANGE(Guarantor, Member);
        feedback.SETRANGE(Accepted, 0);
        feedback.SETRANGE(Rejected,0);
        
         IF feedback.FIND('-') THEN BEGIN
        
           REPEAT
             objMember.SETRANGE("No.", feedback.No);
             IF objMember.FIND('-') THEN
               FAccNo:=objMember.Name;
             phoneNumber:=objMember."Phone No.";
             PortaLuPS.SETRANGE(LaonNo, feedback.LoanNo);
             IF PortaLuPS.FIND('-') THEN
               Amount:=(PortaLuPS.RequestedAmount-PortaLuPS.TotalGuaranteed);
             Guarantee:=Guarantee+FORMAT(feedback.Entry)+':'+FAccNo+':'+FORMAT(phoneNumber)+'>>'+':'+FORMAT(Amount)+'::';
        
        UNTIL feedback.NEXT=0;
        END;
        */

    end;


    procedure FnEditableLoans(MemberNo: Code[10]; Loan: Code[20]) Edit: Text
    var
        Loantpe: Text;
        Loanpurpose: Text;
    begin
        LoansGuaranteeDetails.Reset;
        LoansGuaranteeDetails.SetRange("Member No", MemberNo);
        LoansGuaranteeDetails.SetRange("Loan No", Loan);

        if LoansGuaranteeDetails.Find('-') then begin
            repeat
                Edit := Edit + LoansGuaranteeDetails."Loan No" + LoansGuaranteeDetails."Loanees  Name" + Format(LoansGuaranteeDetails."Amont Guaranteed");
            until LoansGuaranteeDetails.Next = 0;

        end;
    end;


    procedure fnedtitloan(Amount: Decimal; Loan: Code[20]; Repaymperiod: Integer; LoanPurpose: Code[20]; LoanType: Code[20])
    begin
        objLoanRegister.Reset;
        //objLoanRegister.SETRANGE("Client Code", Member);
        objLoanRegister.SetRange("Loan  No.", Loan);
        if objLoanRegister.Find('-') then begin
            objLoanRegister.Init;
            objLoanRegister."Requested Amount" := Amount;
            objLoanRegister.Validate("Requested Amount");
            objLoanRegister.Installments := Repaymperiod;
            // objLoanRegister.VALIDATE(Installments);
            objLoanRegister."Loan Product Type" := LoanType;
            objLoanRegister.Validate("Loan Product Type");
            objLoanRegister."Loan Purpose" := LoanPurpose;
            objLoanRegister.Validate("Loan Purpose");
            objLoanRegister.Modify;
        end;
    end;


    procedure FnApprovedGuarantors(Member: Code[40]; Loan: Code[40]) Guarantee: Text
    begin
        /*
        feedback.RESET;
        feedback.SETRANGE(No, Member);
        feedback.SETRANGE(Accepted, 1);
        feedback.SETRANGE(Rejected,0);
        feedback.SETRANGE(LoanNo,Loan);
        
         IF feedback.FIND('-') THEN BEGIN
        
           REPEAT
             objMember.SETRANGE("No.", feedback.Guarantor);
             IF objMember.FIND('-') THEN
               FAccNo:=objMember.Name;
             phoneNumber:=objMember."Phone No.";
             objLoanRegister.SETRANGE("Loan  No.", feedback.LoanNo);
             IF objLoanRegister.FIND('-') THEN
               Amount:=objLoanRegister."Requested Amount";
             Guarantee:=Guarantee+FORMAT(feedback.Entry)+':'+FAccNo+':'+FORMAT(phoneNumber)+'>>'+':'+FORMAT(feedback.Amount)+'::';
        
        UNTIL feedback.NEXT=0;
        END;
        */

    end;


    procedure FnPendingGuarantors(Member: Code[40]; Loan: Code[40]) Guarantee: Text
    begin
        /*
        feedback.RESET;
        feedback.SETRANGE(No, Member);
        feedback.SETRANGE(Accepted, 1);
        feedback.SETRANGE(Rejected,0);
        feedback.SETRANGE(LoanNo,Loan);

        IF feedback.FIND('-') THEN BEGIN

          REPEAT
            objMember.SETRANGE("No.", feedback.Guarantor);
            IF objMember.FIND('-') THEN
              FAccNo:=objMember.Name;
            phoneNumber:=objMember."Phone No.";
            objLoanRegister.SETRANGE("Loan  No.", feedback.LoanNo);
            IF objLoanRegister.FIND('-') THEN
              Amount:=objLoanRegister."Requested Amount";
            Guarantee:=Guarantee+FORMAT(feedback.Entry)+':'+FAccNo+':'+FORMAT(phoneNumber)+'>>'+':'+FORMAT(Amount)+'::';

        UNTIL feedback.NEXT=0;
        END;
       */

    end;


    procedure FnrejectedGuarantors(Member: Code[40]; Loan: Code[40]) Guarantee: Text
    begin
        /*
         feedback.RESET;
         feedback.SETRANGE(No, Member);
         feedback.SETRANGE(Accepted, 0);
         feedback.SETRANGE(Rejected,1);
         feedback.SETRANGE(LoanNo,Loan);
        
         IF feedback.FIND('-') THEN BEGIN
        
           REPEAT
             objMember.SETRANGE("No.", feedback.Guarantor);
             IF objMember.FIND('-') THEN
               FAccNo:=objMember.Name;
             phoneNumber:=objMember."Phone No.";
             objLoanRegister.SETRANGE("Loan  No.", feedback.LoanNo);
             IF objLoanRegister.FIND('-') THEN
               Amount:=objLoanRegister."Requested Amount";
             Guarantee:=Guarantee+FORMAT(feedback.Entry)+':'+FAccNo+':'+FORMAT(phoneNumber)+'>>'+'::';
        
         UNTIL feedback.NEXT=0;
         END;
         */

    end;


    procedure FnApplytoAppraise(LoanNo: Code[20])
    begin
        objLoanRegister.Reset;
        objLoanRegister.SetRange("Loan  No.", LoanNo);
        if objLoanRegister.Find('-') then begin
            // objLoanRegister.INIT;
            objLoanRegister."Loan Status" := objLoanRegister."loan status"::Appraisal;
            objLoanRegister.Modify;
        end;
    end;


    procedure fnTotalLoanAm(Loan: Code[10]) amount: Decimal
    begin
        /*
        PortaLuPS.RESET;
        PortaLuPS.SETRANGE(LaonNo, Loan);
        IF PortaLuPS.FIND('-') THEN
         BEGIN
           amount:=( PortaLuPS.RequestedAmount-PortaLuPS.TotalGuaranteed);

        END;
       */

    end;


    procedure Fnquestionaire(Member: Code[20]; reason: Text; time: Text; Leastimpressed: Text; Mostimpressed: Text; suggestion: Text; accounts: Option; customercare: Option; atmosphere: Option; serveby: Text)
    begin
        // Questinnaires.INIT;
        // IF Questinnaires.FIND('+') THEN
        //  Questinnaires.Entry:=Questinnaires.Entry+1
        //
        //  ELSE
        //  //Questinnaires.INSERT;
        //  Questinnaires.Entry:=1;
        // Questinnaires.Member:=Member;
        // Questinnaires.ReasonForVisit:=reason;
        // Questinnaires.LeastImpressedWIth:=Leastimpressed;
        // Questinnaires.MostImpressedwith:=Mostimpressed;
        // Questinnaires.Suggestions:=suggestion;
        // Questinnaires.Accounts:=accounts;
        // Questinnaires.Customercare:=customercare;
        // Questinnaires.OfficeAtmosphere:=atmosphere;
        // Questinnaires.ServedBy:=serveby;
        // Questinnaires.INSERT;
    end;


    procedure fnLoanApplicationform("Member No": Code[50]; start: Date; peroid: Code[10])
    begin

        // DivProg.RESET;
        // DivProg.SETRANGE(DivProg."Member No","Member No");
        // IF DivProg.FIND('-') THEN
        // DivProg.DELETEALL;
        // StartDate:=start;
        // RunningPeriod:=peroid;
        // IF StartDate = 0D THEN
        // ERROR('You must specify start Date.');
        //
        // IF RunningPeriod='' THEN ERROR('Running Period Must be inserted');
        //
        // DivTotal:=0;
        // DivCapTotal:=0;
        // GenSetup.GET(0);
        //
        //
        //
        //
        //
        // //1st Month(Opening bal.....)
        // EVALUATE(BDate,'01/01/05');
        // FromDate:=BDate;
        // ToDate:=CALCDATE('-1D',StartDate);
        // EVALUATE(FromDateS,FORMAT(FromDate));
        // EVALUATE(ToDateS,FORMAT(ToDate));
        //
        // IF Cust.FIND('-') THEN BEGIN
        // Cust.CALCFIELDS(Cust."Current Shares",Cust."Shares Retained");
        // //IF Cust."Current Shares" <> 0 THEN BEGIN
        // CDiv:=(GenSetup."Interest on Deposits (%)"/100)*(Cust."Current Shares"*-1)*(12/12);
        // CapDiv:=(GenSetup."Dividend (%)"/100*(Cust."Shares Retained"*-1))*(12/12);
        //
        // DivTotal:=CDiv;
        // DivCapTotal:=CapDiv;
        //
        //
        //
        // DivProg.INIT;
        // DivProg."Member No":="Member No" ;
        // DivProg.Date:=ToDate;
        // DivProg."Gross Dividends":=CDiv;
        // DivProg."Witholding Tax":=CDiv*(GenSetup."Withholding Tax (%)"/100);
        // DivProg."Net Dividends":=DivProg."Gross Dividends"-DivProg."Witholding Tax";
        // DivProg."Qualifying Shares":=(Cust."Current Shares"*-1)*(12/12);
        // DivProg.Shares:=Cust."Current Shares"*-1;
        // DivProg."Share Capital":=Cust."Shares Retained"*-1;
        // DivProg."Gross  Share cap Dividend":=CapDiv;
        // DivProg."Qualifying Share Capital":=(Cust."Shares Retained"*-1)*(12/12);
        // DivProg."Wtax Share Cap Dividend":=CapDiv*(GenSetup."Withholding Tax (%)"/100);
        // DivProg."Net Share Cap Dividend":=DivProg."Gross  Share cap Dividend"-DivProg."Wtax Share Cap Dividend";
        // DivProg.Period:=RunningPeriod;
        // DivProg.INSERT;
        // END;
        // //END;
        // //previous Year End(Opening Bal......)
        //
        //
        //
        //
        //
        // DateFilter:=FromDateS+'..'+ToDateS;
        // Cust.RESET;
        // Cust.SETCURRENTKEY("No.");
        // Cust.SETRANGE(Cust."No.","Member No");
        // Cust.SETFILTER(Cust."Date Filter",DateFilter);
        //
        // //1
        // EVALUATE(BDate,'01/01/16');
        // FromDate:=BDate;//StartDate;
        // ToDate:=CALCDATE('-1D',CALCDATE('1M',StartDate));
        // EVALUATE(FromDateS,FORMAT(FromDate));
        // EVALUATE(ToDateS,FORMAT(ToDate));
        //
        // DateFilter:=FromDateS+'..'+ToDateS;
        // Cust.RESET;
        // Cust.SETRANGE(Cust."No.","Member No");
        // Cust.SETFILTER(Cust."Date Filter",DateFilter);
        // IF Cust.FIND('-') THEN BEGIN
        // Cust.CALCFIELDS(Cust."Current Shares",Cust."Shares Retained");
        // //IF Cust."Current Shares" <> 0 THEN BEGIN
        // CDiv:=(GenSetup."Interest on Deposits (%)"/100)*(Cust."Current Shares"*-1)*(12/12);
        // CapDiv:=(GenSetup."Dividend (%)"/100*(Cust."Shares Retained"*-1))*(12/12);
        //
        // DivTotal:=CDiv;
        // DivCapTotal:=CapDiv;
        //
        //
        //
        // DivProg.INIT;
        // DivProg."Member No":="Member No";
        // DivProg.Date:=ToDate;
        // DivProg."Gross Dividends":=CDiv;
        // DivProg."Witholding Tax":=CDiv*(GenSetup."Withholding Tax (%)"/100);
        // DivProg."Net Dividends":=DivProg."Gross Dividends"-DivProg."Witholding Tax";
        // DivProg."Qualifying Shares":=(Cust."Current Shares"*-1)*(12/12);
        // DivProg.Shares:=Cust."Current Shares"*-1;
        // DivProg."Share Capital":=Cust."Shares Retained"*-1;
        // DivProg."Gross  Share cap Dividend":=CapDiv;
        // DivProg."Qualifying Share Capital":=(Cust."Shares Retained"*-1)*(12/12);
        // DivProg."Wtax Share Cap Dividend":=CapDiv*(GenSetup."Withholding Tax (%)"/100);
        // DivProg."Net Share Cap Dividend":=DivProg."Gross  Share cap Dividend"-DivProg."Wtax Share Cap Dividend";
        // DivProg.Period:=RunningPeriod;
        // DivProg.INSERT;
        // END;
        // //END ELSE
        // //DivTotal:=0;
        // //END;
        //
        //
        //
        //
        //
        //
        // //2
        // FromDate:=CALCDATE('1M',StartDate);
        // ToDate:=CALCDATE('-1D',CALCDATE('2M',StartDate));
        // EVALUATE(FromDateS,FORMAT(FromDate));
        // EVALUATE(ToDateS,FORMAT(ToDate));
        //
        // DateFilter:=FromDateS+'..'+ToDateS;
        // Cust.RESET;
        // Cust.SETRANGE(Cust."No.","Member No");
        // Cust.SETFILTER(Cust."Date Filter",DateFilter);
        // IF Cust.FIND('-') THEN BEGIN
        // Cust.CALCFIELDS(Cust."Current Shares",Cust."Shares Retained");
        // //IF Cust."Current Shares" <> 0 THEN BEGIN
        // CDiv:=(GenSetup."Interest on Deposits (%)"/100)*(Cust."Current Shares"*-1)*(11/12);
        // CapDiv:=(GenSetup."Dividend (%)"/100*(Cust."Shares Retained"*-1))*(11/12);
        //
        // DivTotal:=CDiv;
        // DivCapTotal:=CapDiv;
        //
        // DivProg.INIT;
        // DivProg."Member No":="Member No";
        // DivProg.Date:=ToDate;
        // DivProg."Gross Dividends":=CDiv;
        // DivProg."Witholding Tax":=CDiv*(GenSetup."Withholding Tax (%)"/100);
        // DivProg."Net Dividends":=DivProg."Gross Dividends"-DivProg."Witholding Tax";
        // DivProg."Qualifying Shares":=(Cust."Current Shares"*-1)*(11/12);
        // DivProg.Shares:=Cust."Current Shares"*-1;
        // DivProg."Share Capital":=Cust."Shares Retained"*-1;
        // DivProg."Gross  Share cap Dividend":=CapDiv;
        // DivProg."Qualifying Share Capital":=(Cust."Shares Retained"*-1)*(11/12);
        // DivProg."Wtax Share Cap Dividend":=CapDiv*(GenSetup."Withholding Tax (%)"/100);
        // DivProg."Net Share Cap Dividend":=DivProg."Gross  Share cap Dividend"-DivProg."Wtax Share Cap Dividend";
        // DivProg.Period:=RunningPeriod;
        // DivProg.INSERT
        //
        // END;
        // //END;
        //
        //
        //
        //
        //
        // //3
        // FromDate:=CALCDATE('2M',StartDate);
        // ToDate:=CALCDATE('-1D',CALCDATE('3M',StartDate));
        // EVALUATE(FromDateS,FORMAT(FromDate));
        // EVALUATE(ToDateS,FORMAT(ToDate));
        //
        // DateFilter:=FromDateS+'..'+ToDateS;
        // Cust.RESET;
        // Cust.SETRANGE(Cust."No.","Member No");
        // Cust.SETFILTER(Cust."Date Filter",DateFilter);
        // IF Cust.FIND('-') THEN BEGIN
        // Cust.CALCFIELDS(Cust."Current Shares",Cust."Shares Retained");
        // //IF Cust."Current Shares" <> 0 THEN BEGIN
        //
        // CDiv:=(GenSetup."Interest on Deposits (%)"/100)*(Cust."Current Shares"*-1)*(10/12);
        // CapDiv:=(GenSetup."Dividend (%)"/100*(Cust."Shares Retained"*-1))*(10/12);
        //
        // DivTotal:=CDiv;
        // DivCapTotal:=CapDiv;
        //
        // DivProg.INIT;
        // DivProg."Member No":="Member No";
        // DivProg.Date:=ToDate;
        // DivProg."Gross Dividends":=CDiv;
        // DivProg."Witholding Tax":=CDiv*(GenSetup."Withholding Tax (%)"/100);
        // DivProg."Net Dividends":=DivProg."Gross Dividends"-DivProg."Witholding Tax";
        // DivProg."Qualifying Shares":=(Cust."Current Shares"*-1)*(10/12);
        // DivProg.Shares:=Cust."Current Shares"*-1;
        // DivProg."Share Capital":=Cust."Shares Retained"*-1;
        // DivProg."Gross  Share cap Dividend":=CapDiv;
        // DivProg."Qualifying Share Capital":=(Cust."Shares Retained"*-1)*(10/12);
        // DivProg."Wtax Share Cap Dividend":=CapDiv*(GenSetup."Withholding Tax (%)"/100);
        // DivProg."Net Share Cap Dividend":=DivProg."Gross  Share cap Dividend"-DivProg."Wtax Share Cap Dividend";
        // DivProg.Period:=RunningPeriod;
        // DivProg.INSERT
        //
        // END;
        // //END;
        //
        //
        //
        //
        // //4
        // FromDate:=CALCDATE('3M',StartDate);
        // ToDate:=CALCDATE('-1D',CALCDATE('4M',StartDate));
        // EVALUATE(FromDateS,FORMAT(FromDate));
        // EVALUATE(ToDateS,FORMAT(ToDate));
        //
        // DateFilter:=FromDateS+'..'+ToDateS;
        // Cust.RESET;
        // Cust.SETRANGE(Cust."No.","Member No");
        // Cust.SETFILTER(Cust."Date Filter",DateFilter);
        // IF Cust.FIND('-') THEN BEGIN
        // Cust.CALCFIELDS(Cust."Current Shares",Cust."Shares Retained");
        // //IF Cust."Current Shares" <> 0 THEN BEGIN
        //
        // CDiv:=(GenSetup."Interest on Deposits (%)"/100)*(Cust."Current Shares"*-1)*(9/12);
        // CapDiv:=(GenSetup."Dividend (%)"/100*(Cust."Shares Retained"*-1))*(9/12);
        //
        // DivTotal:=CDiv;
        // DivCapTotal:=CapDiv;
        //
        // DivProg.INIT;
        // DivProg."Member No":="Member No";
        // DivProg.Date:=ToDate;
        // DivProg."Gross Dividends":=CDiv;
        // DivProg."Witholding Tax":=CDiv*(GenSetup."Withholding Tax (%)"/100);
        // DivProg."Net Dividends":=DivProg."Gross Dividends"-DivProg."Witholding Tax";
        // DivProg."Qualifying Shares":=(Cust."Current Shares"*-1)*(9/12);
        // DivProg.Shares:=Cust."Current Shares"*-1;
        // DivProg."Share Capital":=Cust."Shares Retained"*-1;
        // DivProg."Gross  Share cap Dividend":=CapDiv;
        // DivProg."Qualifying Share Capital":=(Cust."Shares Retained"*-1)*(9/12);
        // DivProg."Wtax Share Cap Dividend":=CapDiv*(GenSetup."Withholding Tax (%)"/100);
        // DivProg."Net Share Cap Dividend":=DivProg."Gross  Share cap Dividend"-DivProg."Wtax Share Cap Dividend";
        // DivProg.Period:=RunningPeriod;
        // DivProg.INSERT
        //
        // END;
        // //END;
        //
        //
        //
        //
        // //5
        // FromDate:=CALCDATE('4M',StartDate);
        // ToDate:=CALCDATE('-1D',CALCDATE('5M',StartDate));
        // EVALUATE(FromDateS,FORMAT(FromDate));
        // EVALUATE(ToDateS,FORMAT(ToDate));
        //
        // DateFilter:=FromDateS+'..'+ToDateS;
        // Cust.RESET;
        // Cust.SETRANGE(Cust."No.","Member No");
        // Cust.SETFILTER(Cust."Date Filter",DateFilter);
        // IF Cust.FIND('-') THEN BEGIN
        // Cust.CALCFIELDS(Cust."Current Shares",Cust."Shares Retained");
        // //IF Cust."Current Shares" <> 0 THEN BEGIN
        //
        // CDiv:=(GenSetup."Interest on Deposits (%)"/100)*(Cust."Current Shares"*-1)*(8/12);
        // CapDiv:=(GenSetup."Dividend (%)"/100*(Cust."Shares Retained"*-1))*(8/12);
        //
        // DivTotal:=CDiv;
        // DivCapTotal:=CapDiv;
        //
        // DivProg.INIT;
        // DivProg."Member No":="Member No";
        // DivProg.Date:=ToDate;
        // DivProg."Gross Dividends":=CDiv;
        // DivProg."Witholding Tax":=CDiv*(GenSetup."Withholding Tax (%)"/100);
        // DivProg."Net Dividends":=DivProg."Gross Dividends"-DivProg."Witholding Tax";
        // DivProg."Qualifying Shares":=(Cust."Current Shares"*-1)*(8/12);
        // DivProg.Shares:=Cust."Current Shares"*-1;
        // DivProg."Share Capital":=Cust."Shares Retained"*-1;
        // DivProg."Gross  Share cap Dividend":=CapDiv;
        // DivProg."Qualifying Share Capital":=(Cust."Shares Retained"*-1)*(8/12);
        // DivProg."Wtax Share Cap Dividend":=CapDiv*(GenSetup."Withholding Tax (%)"/100);
        // DivProg."Net Share Cap Dividend":=DivProg."Gross  Share cap Dividend"-DivProg."Wtax Share Cap Dividend";
        // DivProg.Period:=RunningPeriod;
        // DivProg.INSERT
        // END;
        // //END;
        //
        //
        //
        //
        // //6
        // FromDate:=CALCDATE('5M',StartDate);
        // ToDate:=CALCDATE('-1D',CALCDATE('6M',StartDate));
        // EVALUATE(FromDateS,FORMAT(FromDate));
        // EVALUATE(ToDateS,FORMAT(ToDate));
        //
        // DateFilter:=FromDateS+'..'+ToDateS;
        // Cust.RESET;
        // Cust.SETRANGE(Cust."No.","Member No");
        // Cust.SETFILTER(Cust."Date Filter",DateFilter);
        // IF Cust.FIND('-') THEN BEGIN
        // Cust.CALCFIELDS(Cust."Current Shares",Cust."Shares Retained");
        // //IF Cust."Current Shares" <> 0 THEN BEGIN
        //
        //
        // CDiv:=(GenSetup."Interest on Deposits (%)"/100)*(Cust."Current Shares"*-1)*(7/12);
        // CapDiv:=(GenSetup."Dividend (%)"/100*(Cust."Shares Retained"*-1))*(7/12);
        //
        // DivTotal:=CDiv;
        // DivCapTotal:=CapDiv;;
        //
        // DivProg.INIT;
        // DivProg."Member No":="Member No";
        // DivProg.Date:=ToDate;
        // DivProg."Gross Dividends":=CDiv;
        // DivProg."Witholding Tax":=CDiv*(GenSetup."Withholding Tax (%)"/100);
        // DivProg."Net Dividends":=DivProg."Gross Dividends"-DivProg."Witholding Tax";
        // DivProg."Qualifying Shares":=(Cust."Current Shares"*-1)*(7/12);
        // DivProg.Shares:=Cust."Current Shares"*-1;
        // DivProg."Share Capital":=Cust."Shares Retained"*-1;
        // DivProg."Gross  Share cap Dividend":=CapDiv;
        // DivProg."Qualifying Share Capital":=(Cust."Shares Retained"*-1)*(7/12);
        // DivProg."Wtax Share Cap Dividend":=CapDiv*(GenSetup."Withholding Tax (%)"/100);
        // DivProg."Net Share Cap Dividend":=DivProg."Gross  Share cap Dividend"-DivProg."Wtax Share Cap Dividend";
        // DivProg.Period:=RunningPeriod;
        // DivProg.INSERT
        //
        // END;
        // //END;
        //
        //
        //
        //
        //
        // //7
        // FromDate:=CALCDATE('6M',StartDate);
        // ToDate:=CALCDATE('-1D',CALCDATE('7M',StartDate));
        // EVALUATE(FromDateS,FORMAT(FromDate));
        // EVALUATE(ToDateS,FORMAT(ToDate));
        //
        // DateFilter:=FromDateS+'..'+ToDateS;
        // Cust.RESET;
        // Cust.SETRANGE(Cust."No.","Member No");
        // Cust.SETFILTER(Cust."Date Filter",DateFilter);
        // IF Cust.FIND('-') THEN BEGIN
        // Cust.CALCFIELDS(Cust."Current Shares",Cust."Shares Retained");
        // //IF Cust."Current Shares" <> 0 THEN BEGIN
        //
        //
        // CDiv:=(GenSetup."Interest on Deposits (%)"/100)*(Cust."Current Shares"*-1)*(6/12);
        // CapDiv:=(GenSetup."Dividend (%)"/100*(Cust."Shares Retained"*-1))*(6/12);
        //
        // DivTotal:=CDiv;
        // DivCapTotal:=CapDiv;
        //
        // DivProg.INIT;
        // DivProg."Member No":="Member No";
        // DivProg.Date:=ToDate;
        // DivProg."Gross Dividends":=CDiv;
        // DivProg."Witholding Tax":=CDiv*(GenSetup."Withholding Tax (%)"/100);
        // DivProg."Net Dividends":=DivProg."Gross Dividends"-DivProg."Witholding Tax";
        // DivProg."Qualifying Shares":=(Cust."Current Shares"*-1)*(6/12);
        // DivProg.Shares:=Cust."Current Shares"*-1;
        // DivProg."Share Capital":=Cust."Shares Retained"*-1;
        // DivProg."Gross  Share cap Dividend":=CapDiv;
        // DivProg."Qualifying Share Capital":=(Cust."Shares Retained"*-1)*(6/12);
        // DivProg."Wtax Share Cap Dividend":=CapDiv*(GenSetup."Withholding Tax (%)"/100);
        // DivProg."Net Share Cap Dividend":=DivProg."Gross  Share cap Dividend"-DivProg."Wtax Share Cap Dividend";
        // DivProg.Period:=RunningPeriod;
        // DivProg.INSERT
        //
        // END;
        // //END;
        //
        //
        //
        //
        //
        // //8
        // FromDate:=CALCDATE('7M',StartDate);
        // ToDate:=CALCDATE('-1D',CALCDATE('8M',StartDate));
        // EVALUATE(FromDateS,FORMAT(FromDate));
        // EVALUATE(ToDateS,FORMAT(ToDate));
        //
        // DateFilter:=FromDateS+'..'+ToDateS;
        // Cust.RESET;
        // Cust.SETRANGE(Cust."No.","Member No");
        // Cust.SETFILTER(Cust."Date Filter",DateFilter);
        // IF Cust.FIND('-') THEN BEGIN
        // Cust.CALCFIELDS(Cust."Current Shares",Cust."Shares Retained");
        // //IF Cust."Current Shares" <> 0 THEN BEGIN
        //
        //
        // CDiv:=(GenSetup."Interest on Deposits (%)"/100)*(Cust."Current Shares"*-1)*(5/12);
        // CapDiv:=(GenSetup."Dividend (%)"/100*(Cust."Shares Retained"*-1))*(5/12);
        //
        // DivTotal:=CDiv;
        // DivCapTotal:=CapDiv;
        //
        // DivProg.INIT;
        // DivProg."Member No":="Member No";
        // DivProg.Date:=ToDate;
        // DivProg."Gross Dividends":=CDiv;
        // DivProg."Witholding Tax":=CDiv*(GenSetup."Withholding Tax (%)"/100);
        // DivProg."Net Dividends":=DivProg."Gross Dividends"-DivProg."Witholding Tax";
        // DivProg."Qualifying Shares":=(Cust."Current Shares"*-1)*(5/12);
        // DivProg.Shares:=Cust."Current Shares"*-1;
        // DivProg."Share Capital":=Cust."Shares Retained"*-1;
        // DivProg."Gross  Share cap Dividend":=CapDiv;
        // DivProg."Qualifying Share Capital":=(Cust."Shares Retained"*-1)*(5/12);
        // DivProg."Wtax Share Cap Dividend":=CapDiv*(GenSetup."Withholding Tax (%)"/100);
        // DivProg."Net Share Cap Dividend":=DivProg."Gross  Share cap Dividend"-DivProg."Wtax Share Cap Dividend";
        // DivProg.Period:=RunningPeriod;
        // DivProg.INSERT
        //
        // END;
        // //END;
        //
        //
        //
        //
        //
        // //9
        // FromDate:=CALCDATE('8M',StartDate);
        // ToDate:=CALCDATE('-1D',CALCDATE('9M',StartDate));
        // EVALUATE(FromDateS,FORMAT(FromDate));
        // EVALUATE(ToDateS,FORMAT(ToDate));
        //
        // DateFilter:=FromDateS+'..'+ToDateS;
        // Cust.RESET;
        // Cust.SETRANGE(Cust."No.","Member No");
        // Cust.SETFILTER(Cust."Date Filter",DateFilter);
        // IF Cust.FIND('-') THEN BEGIN
        // Cust.CALCFIELDS(Cust."Current Shares",Cust."Shares Retained");
        // //IF Cust."Current Shares" <> 0 THEN BEGIN
        //
        //
        // CDiv:=(GenSetup."Interest on Deposits (%)"/100)*(Cust."Current Shares"*-1)*(4/12);
        // CapDiv:=(GenSetup."Dividend (%)"/100*(Cust."Shares Retained"*-1))*(4/12);
        //
        // DivTotal:=CDiv;
        // DivCapTotal:=CapDiv;
        //
        // DivProg.INIT;
        // DivProg."Member No":="Member No";
        // DivProg.Date:=ToDate;
        // DivProg."Gross Dividends":=CDiv;
        // DivProg."Witholding Tax":=CDiv*(GenSetup."Withholding Tax (%)"/100);
        // DivProg."Net Dividends":=DivProg."Gross Dividends"-DivProg."Witholding Tax";
        // DivProg."Qualifying Shares":=(Cust."Current Shares"*-1)*(4/12);
        // DivProg.Shares:=Cust."Current Shares"*-1;
        // DivProg."Share Capital":=Cust."Shares Retained"*-1;
        // DivProg."Gross  Share cap Dividend":=CapDiv;
        // DivProg."Qualifying Share Capital":=(Cust."Shares Retained"*-1)*(4/12);
        // DivProg."Wtax Share Cap Dividend":=CapDiv*(GenSetup."Withholding Tax (%)"/100);
        // DivProg."Net Share Cap Dividend":=DivProg."Gross  Share cap Dividend"-DivProg."Wtax Share Cap Dividend";
        // DivProg.Period:=RunningPeriod;
        // DivProg.INSERT
        // END;
        // //END;
        //
        //
        //
        //
        //
        // //10
        // FromDate:=CALCDATE('9M',StartDate);
        // ToDate:=CALCDATE('-1D',CALCDATE('10M',StartDate));
        // EVALUATE(FromDateS,FORMAT(FromDate));
        // EVALUATE(ToDateS,FORMAT(ToDate));
        //
        // DateFilter:=FromDateS+'..'+ToDateS;
        // Cust.RESET;
        // Cust.SETRANGE(Cust."No.","Member No");
        // Cust.SETFILTER(Cust."Date Filter",DateFilter);
        // IF Cust.FIND('-') THEN BEGIN
        // Cust.CALCFIELDS(Cust."Current Shares",Cust."Shares Retained");
        // //IF Cust."Current Shares" <> 0 THEN BEGIN
        //
        //
        // CDiv:=(GenSetup."Interest on Deposits (%)"/100)*(Cust."Current Shares"*-1)*(3/12);
        // CapDiv:=(GenSetup."Dividend (%)"/100*(Cust."Shares Retained"*-1))*(3/12);
        //
        // DivTotal:=CDiv;
        // DivCapTotal:=CapDiv;
        //
        // DivProg.INIT;
        // DivProg."Member No":="Member No";
        // DivProg.Date:=ToDate;
        // DivProg."Gross Dividends":=CDiv;
        // DivProg."Witholding Tax":=CDiv*(GenSetup."Withholding Tax (%)"/100);
        // DivProg."Net Dividends":=DivProg."Gross Dividends"-DivProg."Witholding Tax";
        // DivProg."Qualifying Shares":=(Cust."Current Shares"*-1)*(3/12);
        // DivProg.Shares:=Cust."Current Shares"*-1;
        // DivProg."Share Capital":=Cust."Shares Retained"*-1;
        // DivProg."Gross  Share cap Dividend":=CapDiv;
        // DivProg."Qualifying Share Capital":=(Cust."Shares Retained"*-1)*(3/12);
        // DivProg."Wtax Share Cap Dividend":=CapDiv*(GenSetup."Withholding Tax (%)"/100);
        // DivProg."Net Share Cap Dividend":=DivProg."Gross  Share cap Dividend"-DivProg."Wtax Share Cap Dividend";
        // DivProg.Period:=RunningPeriod;
        // DivProg.INSERT
        // END;
        // //END;
        //
        //
        //
        //
        //
        // //11
        // FromDate:=CALCDATE('10M',StartDate);
        // ToDate:=CALCDATE('-1D',CALCDATE('11M',StartDate));
        // EVALUATE(FromDateS,FORMAT(FromDate));
        // EVALUATE(ToDateS,FORMAT(ToDate));
        //
        // DateFilter:=FromDateS+'..'+ToDateS;
        // Cust.RESET;
        // Cust.SETRANGE(Cust."No.","Member No");
        // Cust.SETFILTER(Cust."Date Filter",DateFilter);
        // IF Cust.FIND('-') THEN BEGIN
        // Cust.CALCFIELDS(Cust."Current Shares",Cust."Shares Retained");
        // //IF Cust."Current Shares" <> 0 THEN BEGIN
        //
        //
        // CDiv:=(GenSetup."Interest on Deposits (%)"/100)*(Cust."Current Shares"*-1)*(2/12);
        // CapDiv:=(GenSetup."Dividend (%)"/100*(Cust."Shares Retained"*-1))*(2/12);
        //
        // DivTotal:=CDiv;
        // DivCapTotal:=CapDiv;
        //
        // DivProg.INIT;
        // DivProg."Member No":="Member No";
        // DivProg.Date:=ToDate;
        // DivProg."Gross Dividends":=CDiv;
        // DivProg."Witholding Tax":=CDiv*(GenSetup."Withholding Tax (%)"/100);
        // DivProg."Net Dividends":=DivProg."Gross Dividends"-DivProg."Witholding Tax";
        // DivProg."Qualifying Shares":=(Cust."Current Shares"*-1)*(2/12);
        // DivProg.Shares:=Cust."Current Shares"*-1;
        // DivProg."Share Capital":=Cust."Shares Retained"*-1;
        // DivProg."Gross  Share cap Dividend":=CapDiv;
        // DivProg."Qualifying Share Capital":=(Cust."Shares Retained"*-1)*(2/12);
        // DivProg."Wtax Share Cap Dividend":=CapDiv*(GenSetup."Withholding Tax (%)"/100);
        // DivProg."Net Share Cap Dividend":=DivProg."Gross  Share cap Dividend"-DivProg."Wtax Share Cap Dividend";
        // DivProg.Period:=RunningPeriod;
        // DivProg.INSERT
        // END;
        // //END;
        //
        //
        //
        //
        //
        // //12
        // FromDate:=CALCDATE('11M',StartDate);
        // ToDate:=CALCDATE('-1D',CALCDATE('12M',StartDate));
        // EVALUATE(FromDateS,FORMAT(FromDate));
        // EVALUATE(ToDateS,FORMAT(ToDate));
        //
        // DateFilter:=FromDateS+'..'+ToDateS;
        // Cust.RESET;
        // Cust.SETRANGE(Cust."No.","Member No");
        // Cust.SETFILTER(Cust."Date Filter",DateFilter);
        // IF Cust.FIND('-') THEN BEGIN
        // Cust.CALCFIELDS(Cust."Current Shares",Cust."Shares Retained");
        // //IF Cust."Current Shares" <> 0 THEN BEGIN
        //
        //
        // CDiv:=(GenSetup."Interest on Deposits (%)"/100)*(Cust."Current Shares"*-1)*(1/12);
        // CapDiv:=(GenSetup."Dividend (%)"/100*(Cust."Shares Retained"*-1))*(1/12);
        //
        // DivTotal:=CDiv;
        // DivCapTotal:=CapDiv;
        //
        // DivProg.INIT;
        // DivProg."Member No":="Member No";
        // DivProg.Date:=ToDate;
        // DivProg."Gross Dividends":=CDiv;
        // DivProg."Witholding Tax":=CDiv*(GenSetup."Withholding Tax (%)"/100);
        // DivProg."Net Dividends":=DivProg."Gross Dividends"-DivProg."Witholding Tax";
        // DivProg."Qualifying Shares":=(Cust."Current Shares"*-1)*(1/12);
        // DivProg.Shares:=Cust."Current Shares"*-1;
        // DivProg."Share Capital":=Cust."Shares Retained"*-1;
        // DivProg."Gross  Share cap Dividend":=CapDiv;
        // DivProg."Qualifying Share Capital":=(Cust."Shares Retained"*-1)*(1/12);
        // DivProg."Wtax Share Cap Dividend":=CapDiv*(GenSetup."Withholding Tax (%)"/100);
        // DivProg."Net Share Cap Dividend":=DivProg."Gross  Share cap Dividend"-DivProg."Wtax Share Cap Dividend";
        // DivProg.Period:=RunningPeriod;
        // DivProg.INSERT
        // END;
    end;


    procedure FnLoanfo(MemberNo: Code[20]) dividend: Text
    begin
        DivProg.Reset;
        DivProg.SetRange("Member No", MemberNo);
        if DivProg.Find('-') then begin
            repeat
                dividend := dividend + Format(DivProg.Date) + ':::' + Format(DivProg."Gross Dividends") + ':::' + Format(DivProg."Witholding Tax") + ':::' + Format(DivProg."Net Dividends") + ':::' + Format(DivProg."Qualifying Share Capital") + ':::'
                + Format(DivProg."Gross Interest On Deposit") + '::::';
            until DivProg.Next = 0;
        end;
    end;


    procedure fnFundsTransfer(Acountfrom: Code[20]; AccountTo: Code[20]; Amount: Decimal; DocNo: Code[20]) result: Text
    begin
        //result:=CloudPesaLive.FundsTransferFOSA(Acountfrom, AccountTo, DocNo, Amount);
    end;


    procedure fnGetFosaAccounts(BosaNo: Code[20]) fosas: Text
    begin
        /*objMember.RESET;
        objMember.SETRANGE("No.",BosaNo);
        IF objMember.FIND('-') THEN BEGIN
        
        Vendor.RESET;
        Vendor.SETRANGE("BOSA Account No", objMember."No.");
        Vendor.SETRANGE("Creditor Type",Vendor."Creditor Type"::Account);
        Vendor.SETFILTER("Account Type",'501|502|503|504|505|506|507|508|509');
        IF Vendor.FIND('-') THEN BEGIN
          REPEAT
          fosas:=fosas+ Vendor."No."+'>'+':::';
            UNTIL Vendor.NEXT=0;
          END;
          END;
          */

    end;


    procedure fnGetAtms(idnumber: Code[30]) return: Text
    begin
        objAtmapplication.Reset;
        objAtmapplication.SetRange("Customer ID", idnumber);
        if objAtmapplication.Find('-') then begin
            repeat
                return := objAtmapplication."Account No" + ':::' + Format(objAtmapplication."Card No") + ':::' + Format(objAtmapplication.Status) + ':::' + Format(objAtmapplication."Terms Read and Understood") + '::::' + return;
            until
              objAtmapplication.Next = 0;
        end;
    end;


    procedure fnGetNextofkin(MemberNumber: Code[20]) return: Text
    begin
        objNextKin.Reset;
        objNextKin.SetRange("Account No", MemberNumber);
        if objNextKin.Find('-') then begin
            repeat
                return := return + objNextKin.Name + ':::' + objNextKin.Relationship + ':::' + objNextKin.Address + ':::' + Format(objNextKin."%Allocation") + '::::';
            until objNextKin.Next = 0;
        end;
    end;


    procedure FNFosaBalance(Acc: Code[30]) Bal: Text[1024]
    var
        AccountTypes: Record "Account Types-Saving Products";
        miniBalance: Decimal;
        accBalance: Decimal;
    begin

        accBalance := 0;
        Vendor.Reset;
        Vendor.SetRange(Vendor."No.", Acc);
        if Vendor.Find('-') then begin
            repeat
                AccountTypes.Reset;
                AccountTypes.SetRange(AccountTypes.Code, Vendor."Account Type");
                if AccountTypes.Find('-') then begin
                    miniBalance := AccountTypes."Minimum Balance";
                end;
                Vendor.CalcFields(Vendor."Balance (LCY)");
                Vendor.CalcFields(Vendor."ATM Transactions");
                Vendor.CalcFields(Vendor."Uncleared Cheques");
                Vendor.CalcFields(Vendor."EFT Transactions");
                accBalance := accBalance + (Vendor."Balance (LCY)" - (Vendor."ATM Transactions" + Vendor."Uncleared Cheques" + Vendor."EFT Transactions" + miniBalance));
                Bal := Format(accBalance);
            until Vendor.Next = 0;
        end;
    end;


    procedure FnHolidayStatement(MemberNo: Code[50]; var BigText: BigText)
    var
        Filename: Text[100];
        Convert: dotnet Convert;
        Path: dotnet Path;
        _File: dotnet File;
        //FileAccess: dotnet//FileAccess;
        FileMode: dotnet FileMode;
        MemoryStream: dotnet MemoryStream;
        FileStream: dotnet FileStream;
        Outputstream: OutStream;
    begin

        objMember.Reset;
        objMember.SetRange(objMember."No.", MemberNo);
        Filename := Path.GetTempPath() + Path.GetRandomFileName();
        if objMember.Find('-') then begin
            Report.SaveAsPdf(51516230, Filename, objMember);
            FileMode := 4;
            //FileAccess:=1;

            //  FileStream:=_File.Open(Filename,FileMode,FileAccess);

            MemoryStream := MemoryStream.MemoryStream();

            MemoryStream.SetLength(FileStream.Length);
            //  FileStream.Read(MemoryStream.GetBuffer(), 0, FileStream.Length);

            BigText.AddText((Convert.ToBase64String(MemoryStream.GetBuffer())));
            Message(Format(BigText));
            // exitString:=BigText;
            //MESSAGE(exitString);
            MemoryStream.Close();
            MemoryStream.Dispose();
            FileStream.Close();
            FileStream.Dispose();
            _File.Delete(Filename);

        end;
    end;


    procedure fnGetLoanNumber(memberno: Code[50]) loanno: Code[1024]
    var
        faccount: Code[1024];
    begin
        objMember.Reset;
        objMember.SetRange(objMember."No.", memberno);
        if objMember.Find('-') then
            objLoanRegister.Reset;
        objLoanRegister.SetRange(objLoanRegister."Client Code", memberno);
        if objLoanRegister.Find('-') then begin
            repeat
                faccount := faccount + '::::' + objLoanRegister."Loan  No." + ' - ' + objLoanRegister."Loan Product Type Name" + '::::';

            until objLoanRegister.Next = 0;
            loanno := faccount;

        end;
    end;


    procedure fnGetJuniorAccount(memberno: Code[50]) junioraccountlist: Code[1024]
    var
        Jaccount: Code[1024];
    begin
        /*objMember.RESET;
        objMember.SETRANGE(objMember."Parent Membership No.",memberno);
        objMember.SETRANGE("Account Category",objMember."Account Category"::Junior);
        IF objMember.FIND('-') THEN BEGIN
            REPEAT
           Jaccount:=Jaccount+'::::'+objMember."No."+' ; '+objMember.Name+'::::';
        
           UNTIL objMember.NEXT=0;
           junioraccountlist:=Jaccount;
        
          END;*/

    end;


    procedure fnGetHolidaySavingsAccount(memberno: Code[50]) junioraccountlist: Code[1024]
    var
        Jaccount: Code[1024];
    begin
        /*objMember.RESET;
        objMember.SETRANGE(objMember."Parent Membership No.",memberno);
        objMember.SETRANGE("Account Category",objMember."Account Category"::Junior);
        IF objMember.FIND('-') THEN BEGIN
            REPEAT
           Jaccount:=Jaccount+'::::'+objMember."No."+' - '+objMember.Name+'::::';
        
           UNTIL objMember.NEXT=0;
           junioraccountlist:=Jaccount;
        
          END;*/

    end;


    procedure SMSMessage(documentNo: Text[30]; accfrom: Text[30]; phone: Text[20]; message: Text[1024])
    begin
        SMSMessages.Reset;
        if SMSMessages.Find('+') then begin
            iEntryNo := SMSMessages."Entry No";
            iEntryNo := iEntryNo + 1;
        end
        else begin
            iEntryNo := 1;
        end;
        SMSMessages.Init;
        SMSMessages."Entry No" := iEntryNo;
        SMSMessages."Batch No" := documentNo;
        SMSMessages."Document No" := documentNo;
        SMSMessages."Account No" := accfrom;
        SMSMessages."Date Entered" := Today;
        SMSMessages."Time Entered" := Time;
        SMSMessages.Source := 'PORTALTRAN';
        SMSMessages."Entered By" := UserId;
        SMSMessages."Sent To Server" := SMSMessages."sent to server"::No;
        SMSMessages."SMS Message" := message;
        SMSMessages."Telephone No" := phone;
        if SMSMessages."Telephone No" <> '' then
            SMSMessages.Insert;
    end;


    procedure FnCreatePassword(IDNumber: Code[20]; NewPassword: Text[250]) updated: Boolean
    begin
        sms := 'Your Portal Start Key is ' + NewPassword + '. Please use it to set a password for your account.';
        updated := false;
        objMember.Reset;
        //objMember.SETRANGE(objMember."No.",MemberNo);
        objMember.SetRange(objMember."ID No.", IDNumber);
        if objMember.Find('-') then
            phoneNumber := objMember."Mobile Phone No";
        objMember."Password Reset Date" := CurrentDatetime;
        objMember.Password := NewPassword;
        FAccNo := objMember."FOSA Account No.";
        updated := objMember.Modify;
        Message('Successful password change');
        //FnSMSMessage(FAccNo,phoneNumber,sms);
        SMSMessage('PORTALTRAN', FAccNo, phoneNumber, sms);
        exit(updated);
    end;
}

